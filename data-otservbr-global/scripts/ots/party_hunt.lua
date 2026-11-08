-- OTS: Expowisko Party (Mega Hardcore) - !tp > Expowisko Party.
-- Duza sala (31 x 21) obok huba dla calej druzyny (np. 5 postaci na multi-kliencie z botem).
--  * Lider party wchodzi z menu, a wszyscy czlonkowie party, ktorzy sa online, lecza razem z nim
--    (pozostali moga dolaczyc pozniej z tego samego menu). Przy wejsciu jest PZ 3x3 i teleport powrotny.
--  * Potwory: tylko najmocniejsze ~6% potworow w grze, sila Brutalny albo Koszmar (jak Hardcore Boss),
--    co 4 minuty boss. Jeden cios zabiera najwyzej HIT_CAP % zycia gracza.
--  * Ilosc potworow liczy sie od skladu: baza + dodatek za kazda postac wg profesji (VOCATIONS).
--  * Potwory sa dobierane pod profesje w druzynie: dla kazdej postaci te, ktore sa slabe (albo przynajmniej
--    nieodporne) na jej zywiol - knight/monk: fizyczne, paladin: swietosc, sorcerer: ogien/energia/smierc,
--    druid: lod/ziemia.
--  * Exp: bonus za kazda rozna profesje w sali, plus dodatek za pelny sklad 5 profesji.

local LANDING = Position(30280, 30018, 7) -- pole wejscia; PZ 3x3 wokol niego w ots-hub.otbm (patch_party_pz.py)
local ROOM = { minX = 30265, maxX = 30295, minY = 30000, maxY = 30020, z = 7 }
local SAFE_RADIUS = 2 -- potwory nie pojawiaja sie blizej niz tyle pol od wejscia (poza PZ)
local BASE_COUNT = 12
local MAX_COUNT = 60
local REFILL_AT = 0.6 -- dopelnianie, gdy zostanie mniej niz 60% potworow
local HIT_CAP = 15
local TIER_KOSZMAR_CHANCE = 50 -- reszta: Brutalny
local BOSS_EVERY = 4 * 60
local FULL_SET_BONUS = 0.25
local POOL_TOP = 0.06
local FLOORS = { 11278, 11279, 11281, 11282, 11283, 11280 }

local VOCATIONS = {
	knight = { label = "Knight", count = 10, exp = 0.15, elements = { COMBAT_PHYSICALDAMAGE } },
	paladin = { label = "Paladin", count = 8, exp = 0.15, elements = { COMBAT_HOLYDAMAGE, COMBAT_PHYSICALDAMAGE } },
	sorcerer = { label = "Sorcerer", count = 8, exp = 0.15, elements = { COMBAT_FIREDAMAGE, COMBAT_ENERGYDAMAGE, COMBAT_DEATHDAMAGE } },
	druid = { label = "Druid", count = 6, exp = 0.15, elements = { COMBAT_ICEDAMAGE, COMBAT_EARTHDAMAGE } },
	monk = { label = "Monk", count = 8, exp = 0.15, elements = { COMBAT_PHYSICALDAMAGE } },
}
local VOC_ORDER = { "knight", "paladin", "sorcerer", "druid", "monk" }

OtsNoElite = OtsNoElite or {}

local run = { token = 0, leader = nil, ids = {}, bossAt = 0, emptySince = nil, expBonus = 0, target = BASE_COUNT, lastInfo = 0 }

-- ---------------------------------------------------------------------------------------------
local function vocKey(player)
	local name = player:getVocation():getName():lower()
	for _, key in ipairs(VOC_ORDER) do
		if name:find(key, 1, true) then
			return key
		end
	end
	return nil
end

local function inRoom(pos)
	return pos.z == ROOM.z and pos.x >= ROOM.minX - 1 and pos.x <= ROOM.maxX + 1 and pos.y >= ROOM.minY - 1 and pos.y <= ROOM.maxY + 1
end

-- ---------- pule potworow ----------
local pool, poolByVoc, bossPool

local function buildPools()
	local all, bosses = {}, {}
	for _, mtype in pairs(Game.getMonsterTypes() or {}) do
		if mtype:maxHealth() > 0 then
			if mtype:bossRace() then
				bosses[#bosses + 1] = { name = mtype:getTypeName(), hp = mtype:maxHealth() }
			elseif not mtype:isRewardBoss() and (mtype:raceId() or 0) > 0 and (mtype:experience() or 0) > 0 then
				all[#all + 1] = { name = mtype:getTypeName(), exp = mtype:experience(), elements = mtype:getElementList() or {} }
			end
		end
	end
	table.sort(all, function(a, b)
		return a.exp > b.exp
	end)
	table.sort(bosses, function(a, b)
		return a.hp > b.hp
	end)
	pool = {}
	for i = 1, math.max(10, math.floor(#all * POOL_TOP)) do
		pool[#pool + 1] = all[i]
	end
	bossPool = {}
	for i = 1, math.floor(#bosses / 2) do
		bossPool[#bossPool + 1] = bosses[i].name
	end
	poolByVoc = {}
	for key, voc in pairs(VOCATIONS) do
		local weak, neutral = {}, {}
		for _, entry in ipairs(pool) do
			local best = 100
			for _, element in ipairs(voc.elements) do
				best = math.min(best, tonumber(entry.elements[element]) or 0)
			end
			if best < 0 then
				weak[#weak + 1] = entry.name
			elseif best <= 0 then
				neutral[#neutral + 1] = entry.name
			end
		end
		-- za malo potworow slabych na ten zywiol: dokladamy te bez odpornosci
		if #weak < 5 then
			for _, n in ipairs(neutral) do
				weak[#weak + 1] = n
			end
		end
		poolByVoc[key] = weak
	end
	logger.info("[OTS party] Pula: {} potworow, {} bossow; pod profesje: K {} / P {} / S {} / D {} / M {}", #pool, #bossPool, #poolByVoc.knight, #poolByVoc.paladin, #poolByVoc.sorcerer, #poolByVoc.druid, #poolByVoc.monk)
end

local function pickFor(key)
	local list = key and poolByVoc[key] or nil
	if not list or #list == 0 then
		return pool[math.random(#pool)].name
	end
	return list[math.random(#list)]
end

-- ---------- sklad druzyny ----------
local function partyMembers(player)
	local party = player:getParty()
	if not party then
		return { player }, nil
	end
	local list = { party:getLeader() }
	for _, member in ipairs(party:getMembers() or {}) do
		list[#list + 1] = member
	end
	return list, party
end

local function inRoomMembers()
	local leader = run.leader and Player(run.leader)
	if not leader then
		return {}
	end
	local list = {}
	for _, member in ipairs((partyMembers(leader))) do
		if member and inRoom(member:getPosition()) then
			list[#list + 1] = member
		end
	end
	return list
end

-- ilosc potworow i bonus expa wg profesji
local function composition(members)
	local count, unique, bonus = BASE_COUNT, 0, 0
	local seen = {}
	for _, member in ipairs(members) do
		local key = vocKey(member)
		if key then
			count = count + VOCATIONS[key].count
			if not seen[key] then
				seen[key] = true
				unique = unique + 1
				bonus = bonus + VOCATIONS[key].exp
			end
		end
	end
	if unique >= #VOC_ORDER then
		bonus = bonus + FULL_SET_BONUS
	end
	return math.min(MAX_COUNT, count), bonus, seen, unique
end

-- ---------- potwory ----------
local function clearMonsters()
	for _, id in ipairs(run.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
		OtsHardcoreBossDamage[id] = nil
		OtsHardcoreBossVulnerable[id] = nil
		OtsHardcoreHitCap[id] = nil
		OtsNoElite[id] = nil
	end
	run.ids = {}
end

local function aliveMonsters()
	local alive = {}
	for _, id in ipairs(run.ids) do
		local creature = Creature(id)
		if creature then
			alive[#alive + 1] = id
			if not inRoom(creature:getPosition()) then
				creature:teleportTo(Position(LANDING.x + math.random(-8, 8), LANDING.y - math.random(6, 12), LANDING.z), true)
			end
		else
			OtsHardcoreBossDamage[id] = nil
			OtsHardcoreHitCap[id] = nil
			OtsNoElite[id] = nil
		end
	end
	run.ids = alive
	return #alive
end

local function spotNear(center)
	for _ = 1, 20 do
		local pos = Position(center.x + math.random(-6, 6), center.y + math.random(-6, 6), ROOM.z)
		if pos.x >= ROOM.minX and pos.x <= ROOM.maxX and pos.y >= ROOM.minY and pos.y <= ROOM.maxY
			and math.max(math.abs(pos.x - LANDING.x), math.abs(pos.y - LANDING.y)) > SAFE_RADIUS + 1
			and math.max(math.abs(pos.x - center.x), math.abs(pos.y - center.y)) >= 2
			and OtsIsSpotFree(pos) then
			return pos
		end
	end
	return nil
end

local function spawnOne(name, near, tier)
	local pos = spotNear(near)
	if not pos or not name then
		return false
	end
	local monster = Game.createMonster(name, pos, false, true)
	if not monster then
		return false
	end
	OtsEmpowerTier(monster, tier or (math.random(100) <= TIER_KOSZMAR_CHANCE and 3 or 2))
	OtsHardcoreHitCap[monster:getId()] = HIT_CAP
	OtsNoElite[monster:getId()] = true
	run.ids[#run.ids + 1] = monster:getId()
	return true
end

-- ---------- petla ----------
local function tick(token)
	if token ~= run.token then
		return
	end
	local members = inRoomMembers()
	if #members == 0 then
		run.emptySince = run.emptySince or os.time()
		if os.time() - run.emptySince >= 10 then
			clearMonsters()
			run.leader = nil
			return
		end
		addEvent(tick, 1000, token)
		return
	end
	run.emptySince = nil
	local target, bonus, _, unique = composition(members)
	run.target, run.expBonus = target, bonus
	for _, member in ipairs(members) do
		member:removeCondition(CONDITION_FEARED)
	end
	local alive = aliveMonsters()
	if alive < math.ceil(target * REFILL_AT) then
		local index = 0
		for _ = alive + 1, target do
			index = index + 1
			local member = members[(index - 1) % #members + 1]
			spawnOne(pickFor(vocKey(member)), member:getPosition())
		end
	end
	if os.time() - run.bossAt >= BOSS_EVERY then
		run.bossAt = os.time()
		local member = members[math.random(#members)]
		local name = bossPool[math.random(#bossPool)]
		if spawnOne(name, member:getPosition(), 3) then
			for _, m in ipairs(members) do
				m:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Expowisko Party: pojawil sie boss " .. name .. " (Koszmar)!")
			end
		end
	end
	if os.time() - run.lastInfo >= 60 then
		run.lastInfo = os.time()
		for _, m in ipairs(members) do
			m:sendTextMessage(MESSAGE_STATUS, string.format("Expowisko Party: %d os. (%d profesji), do %d potworow, bonus expa +%d%%.", #members, unique, target, math.floor(bonus * 100 + 0.5)))
		end
	end
	addEvent(tick, 1000, token)
end

-- bonus expa w sali
local gain = EventCallback("OtsPartyHuntExp")

function gain.playerOnGainExperience(player, target, exp, rawExp)
	if run.leader and run.expBonus > 0 and exp > 0 and inRoom(player:getPosition()) then
		exp = math.floor(exp * (1 + run.expBonus) + 0.5)
	end
	return exp
end

gain:register()

-- ---------- wejscie ----------
local function enterSpot(index)
	local offsets = { { 0, 0 }, { -1, 0 }, { 1, 0 }, { 0, -1 }, { -1, -1 }, { 1, -1 }, { -1, 1 }, { 1, 1 }, { 0, 1 } }
	local o = offsets[(index - 1) % #offsets + 1]
	return Position(LANDING.x + o[1], LANDING.y + o[2], LANDING.z)
end

local function enter(player)
	local members, party = partyMembers(player)
	local leader = party and party:getLeader() or player
	-- trwa juz bieg tej druzyny: wchodzi tylko ta postac
	if run.leader and Player(run.leader) and #inRoomMembers() > 0 then
		local runLeader = Player(run.leader)
		local sameParty = runLeader:getId() == leader:getId()
		if not sameParty then
			player:sendCancelMessage("Na Expowisku Party jest teraz inna druzyna.")
			return
		end
		if OtsInFight(player) then
			return
		end
		player:teleportTo(enterSpot(math.random(9)))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return
	end
	if party and leader:getId() ~= player:getId() then
		player:sendCancelMessage("Wejscie z cala druzyna uruchamia lider party.")
		return
	end
	if OtsInFight(player) then
		return
	end
	clearMonsters()
	run.token = run.token + 1
	run.leader = leader:getId()
	run.bossAt = os.time()
	run.lastInfo = 0
	run.emptySince = nil
	OtsTravel(player, "Expowisko Party", LANDING)
	local index = 1
	for _, member in ipairs(members) do
		if member and member:getId() ~= player:getId() and not inRoom(member:getPosition()) then
			index = index + 1
			local from = member:getPosition()
			member:teleportTo(enterSpot(index))
			from:sendMagicEffect(CONST_ME_TELEPORT)
			member:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
	local target, bonus, _, unique = composition(inRoomMembers())
	for _, member in ipairs(inRoomMembers()) do
		member:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("EXPOWISKO PARTY (Mega Hardcore): %d os., %d profesji - do %d potworow naraz, bonus expa +%d%%. Co 4 minuty boss. Wyjscie: teleport przy wejsciu.", #inRoomMembers(), unique, target, math.floor(bonus * 100 + 0.5)))
	end
	addEvent(tick, 3000, run.token)
end

OtsPartyHuntMenu = function(player)
	local members, party = partyMembers(player)
	local count, bonus, seen, unique = composition(members)
	local vocs = {}
	for _, key in ipairs(VOC_ORDER) do
		vocs[#vocs + 1] = (seen[key] and "[x] " or "[ ] ") .. VOCATIONS[key].label
	end
	local message = string.format("Druzyna: %d os. (%s). Profesje: %s.\nPotwory naraz: %d (baza %d + K %d, P %d, S %d, D %d, M %d za postac). Bonus expa: +%d%% (15%% za kazda profesje, +25%% za pelne 5).%s", #members, party and "party" or "bez party", table.concat(vocs, ", "), count, BASE_COUNT, VOCATIONS.knight.count, VOCATIONS.paladin.count, VOCATIONS.sorcerer.count, VOCATIONS.druid.count, VOCATIONS.monk.count, math.floor(bonus * 100 + 0.5), "")
	local window = ModalWindow({ title = "Expowisko Party (Mega Hardcore)", message = message })
	window:addChoice(party and "Wejdz z cala druzyna" or "Wejdz (sam - lepiej z party!)", function(target)
		enter(target)
	end)
	window:addButton("Wejdz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
	return unique
end

-- ---------- budowa sali ----------
local startup = GlobalEvent("OtsPartyHuntStartup")

function startup.onStartup()
	local made = 0
	for x = ROOM.minX, ROOM.maxX do
		for y = ROOM.minY, ROOM.maxY do
			local pos = Position(x, y, ROOM.z)
			if not Tile(pos) then
				Game.createTile(x, y, ROOM.z)
			end
			local tile = Tile(pos)
			if tile and not tile:getGround() then
				Game.createItem(FLOORS[math.random(#FLOORS)], 1, pos)
				made = made + 1
			end
		end
	end
	buildPools()
	logger.info("[OTS party] Sala gotowa (pol: {})", made)
	return true
end

startup:register()
