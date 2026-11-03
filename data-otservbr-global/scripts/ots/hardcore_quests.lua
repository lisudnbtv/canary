-- OTS: Hardcore Questy - piec trudnych wyzwan w salach w stylu sali Grand Mastera Obrona
-- (budowane przy starcie serwera obok huba). Menu: !tp > Hardcore Questy.
--  1. Wieza Upadku   - 50 pieter, co 10 boss, bez potionow, smierc = od nowa.
--  2. Czempion Zywiolow - 7 etapow, w kazdym potwory rani tylko jeden zywiol, na koniec amulet.
--  3. Wyscig z Czasem - 10 bossow jeden po drugim, limit 20 minut, nagroda wg czasu.
--  4. Survival 20 min - zamknieta sala bez teleportu, fale coraz mocniejsze, nagroda za kazda minute.
--  5. Klatwa Obrona   - lancuch 3 etapow (zakon sokola), na koncu Grand Master Oberon.
-- Potwory maja losowa sile jak w Hardcore Boss; jeden cios zabiera najwyzej HIT_CAP % zycia gracza.
-- Postep w Quest Logu: linia "Hardcore Questy" (053_ots_hardcore_quests.lua).

local HIT_CAP = 17 -- limit jednego ciosu (% max zycia gracza)
local EXTRA_POWER = 1.15 -- dodatkowe +15% zycia i obrazen ponad losowa sile
local STORAGE_START = 65100000
local STORAGE = { tower = 65100001, elements = 65100002, race = 65100003, survival = 65100004, oberon = 65100005 }
local BLESSED_STONE, UPGRADE_STONE = 20138, 20139
local BAGS = { 34109, 39546, 43895 } -- bag you desire, primal bag, bag you covet
local CHAMPION_AMULET = 60107

local ROOMS = {
	tower = Position(30260, 29909, 7),
	elements = Position(30290, 29909, 7),
	race = Position(30320, 29909, 7),
	survival = Position(30350, 29909, 7),
	oberon = Position(30380, 29909, 7),
}

OtsNoPotions = OtsNoPotions or {} -- id gracza -> potiony nie dzialaja (Wieza Upadku)
OtsElementOnly = OtsElementOnly or {} -- id potwora -> jedyny zywiol, ktory go rani (Czempion Zywiolow)

-- ---------- pule potworow i bossow (od najslabszego) ----------
local monsterPool, bossPool = nil, nil

local function buildPools()
	monsterPool, bossPool = {}, {}
	for _, mtype in pairs(Game.getMonsterTypes() or {}) do
		local hp = mtype:maxHealth()
		if hp > 0 then
			if mtype:bossRace() then
				bossPool[#bossPool + 1] = { name = mtype:getTypeName(), hp = hp }
			elseif not mtype:isRewardBoss() and (mtype:raceId() or 0) > 0 and (mtype:experience() or 0) > 0 then
				monsterPool[#monsterPool + 1] = { name = mtype:getTypeName(), exp = mtype:experience() }
			end
		end
	end
	table.sort(monsterPool, function(a, b)
		return a.exp < b.exp
	end)
	table.sort(bossPool, function(a, b)
		return a.hp < b.hp
	end)
	logger.info("[OTS hardcore questy] Potwory: {}, bossy: {}", #monsterPool, #bossPool)
end

-- losowa pozycja z przedzialu lo..hi (0..1) listy posortowanej od najslabszego
-- kind: "monster" albo "boss" (pule buduja sie przy pierwszym uzyciu)
local function pick(kind, lo, hi)
	if not monsterPool then
		buildPools()
	end
	local pool = kind == "boss" and bossPool or monsterPool
	local total = #pool
	if total == 0 then
		return nil
	end
	lo, hi = math.max(0, math.min(1, lo)), math.max(0, math.min(1, hi))
	-- hardcore: tylko gorna czesc listy (potwory: najmocniejsze 15%, bossy: mocniejsza polowa)
	local base = kind == "boss" and 0.5 or 0.85
	lo, hi = base + lo * (1 - base), base + hi * (1 - base)
	local first = math.max(1, math.floor(lo * total))
	local last = math.max(first, math.min(total, math.ceil(hi * total)))
	return pool[math.random(first, last)].name
end

-- ---------- wspolne ----------
local function inRoom(pos, landing)
	local b = OtsRoomBounds
	local dx, dy = pos.x - landing.x, pos.y - landing.y
	return pos.z == landing.z and dx >= b.minDx - 1 and dx <= b.maxDx + 1 and dy >= b.minDy - 4 and dy <= b.maxDy + 2
end

local function clearIds(ids)
	for _, id in ipairs(ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
		OtsHardcoreBossDamage[id] = nil
		OtsHardcoreBossVulnerable[id] = nil
		OtsHardcoreHitCap[id] = nil
		OtsElementOnly[id] = nil
	end
end

-- Zywe potwory z listy; te, ktore uciekly z sali (czar teleportu), wracaja.
local function alive(ids, landing)
	local list = {}
	for _, id in ipairs(ids) do
		local creature = Creature(id)
		if creature then
			list[#list + 1] = id
			if not inRoom(creature:getPosition(), landing) then
				local back = Position(landing.x + math.random(-5, 5), landing.y + math.random(-7, -2), landing.z)
				creature:teleportTo(back, true)
			end
		else
			OtsHardcoreBossDamage[id] = nil
			OtsHardcoreHitCap[id] = nil
			OtsElementOnly[id] = nil
		end
	end
	return list
end

-- Stawia count potworow name w sali (na wolnych polach), z losowa sila i limitem ciosu.
local function spawn(ids, landing, name, count, strongest)
	if not name then
		return 0
	end
	local b = OtsRoomBounds
	local spots = {}
	for dx = b.minDx, b.maxDx do
		for dy = b.minDy, b.maxDy do
			local pos = Position(landing.x + dx, landing.y + dy, landing.z)
			if OtsIsSpotFree(pos) and math.max(math.abs(dx), math.abs(dy)) >= 2 then
				spots[#spots + 1] = pos
			end
		end
	end
	local made = 0
	for _ = 1, count do
		if #spots == 0 then
			break
		end
		local monster = Game.createMonster(name, table.remove(spots, math.random(#spots)), true, true)
		if monster then
			if strongest then
				OtsEmpowerStrongest(monster)
			else
				OtsEmpowerRandom(monster)
			end
			local extraHealth = math.floor(monster:getMaxHealth() * EXTRA_POWER)
			monster:setMaxHealth(extraHealth)
			monster:addHealth(extraHealth)
			OtsHardcoreBossDamage[monster:getId()] = (OtsHardcoreBossDamage[monster:getId()] or 1) * EXTRA_POWER
			OtsHardcoreHitCap[monster:getId()] = HIT_CAP
			ids[#ids + 1] = monster:getId()
			made = made + 1
		end
	end
	return made
end

local function questStarted(player, key)
	if player:getStorageValue(STORAGE_START) < 1 then
		player:setStorageValue(STORAGE_START, 1)
	end
	if player:getStorageValue(STORAGE[key]) < 1 then
		player:setStorageValue(STORAGE[key], 1)
	end
end

local function questDone(player, key)
	local first = player:getStorageValue(STORAGE[key]) < 2
	player:setStorageValue(STORAGE[key], 2)
	return first
end

local function giveBags(player, count)
	for i = 1, count do
		player:addItem(BAGS[(i - 1) % #BAGS + 1], 1)
	end
end

local function fmtTime(seconds)
	return string.format("%d:%02d", math.floor(seconds / 60), seconds % 60)
end

local function tickPlayer(player, landing)
	if not player or not inRoom(player:getPosition(), landing) then
		return false
	end
	player:removeCondition(CONDITION_FEARED)
	return true
end

-- =====================================================================
-- 1. Wieza Upadku
-- =====================================================================
local tower = { token = 0, ids = {}, floor = 0, startedAt = 0 }

local function towerEnd(playerId, text)
	clearIds(tower.ids)
	tower.ids = {}
	OtsNoPotions[playerId] = nil
	local player = Player(playerId)
	if player and text then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	end
end

local towerTick

local function towerFloor(playerId, token)
	if token ~= tower.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.tower) then
		towerEnd(playerId, nil)
		return
	end
	tower.floor = tower.floor + 1
	tower.startedAt = os.time()
	local f = tower.floor
	local level = f / 50
	if f % 10 == 0 then
		spawn(tower.ids, ROOMS.tower, pick("boss", level * 0.8 - 0.1, level * 0.8 + 0.05), 1)
		spawn(tower.ids, ROOMS.tower, pick("monster", 0.35 + level * 0.6 - 0.05, 0.35 + level * 0.6 + 0.05), 4)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wieza Upadku - pietro %d/50: BOSS!", f))
	else
		local count = 12 + math.floor(f / 2)
		for _ = 1, count do
			spawn(tower.ids, ROOMS.tower, pick("monster", 0.35 + level * 0.6 - 0.05, 0.35 + level * 0.6 + 0.05), 1)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wieza Upadku - pietro %d/50 (%d potworow).", f, count))
	end
	addEvent(towerTick, 1000, playerId, token)
end

towerTick = function(playerId, token)
	if token ~= tower.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.tower) then
		local best = tonumber(player and player:kv():get("ots-hq-tower-best") or 0) or 0
		towerEnd(playerId, string.format("Wieza Upadku przerwana na pietrze %d. Nastepna proba od pietra 1. Rekord: %d.", tower.floor, best))
		return
	end
	tower.ids = alive(tower.ids, ROOMS.tower)
	if #tower.ids > 0 and os.time() - tower.startedAt < 8 * 60 then
		addEvent(towerTick, 1000, playerId, token)
		return
	end
	clearIds(tower.ids)
	tower.ids = {}
	local f = tower.floor
	if f > (tonumber(player:kv():get("ots-hq-tower-best")) or 0) then
		player:kv():set("ots-hq-tower-best", f)
	end
	if f % 10 == 0 then
		player:addItem(BLESSED_STONE, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Pietro %d zaliczone: +2 blessed upgrade stone.", f))
	end
	if f >= 50 then
		player:addTibiaCoins(1000)
		player:addItem(BLESSED_STONE, 5)
		giveBags(player, 3)
		questDone(player, "tower")
		towerEnd(playerId, "WIEZA UPADKU UKONCZONA! Nagroda: 1000 Tibia Coins, 5 blessed upgrade stone, bag you desire, primal bag i bag you covet.")
		return
	end
	addEvent(towerFloor, 2500, playerId, token)
end

local function towerEnter(player)
	if OtsInFight(player) then
		return
	end
	clearIds(tower.ids)
	tower.ids = {}
	tower.token = tower.token + 1
	tower.floor = 0
	OtsTravel(player, "Wieza Upadku", ROOMS.tower)
	if not inRoom(player:getPosition(), ROOMS.tower) then
		return
	end
	questStarted(player, "tower")
	OtsNoPotions[player:getId()] = true
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wieza Upadku: 50 pieter, co 10 boss. Potiony tu nie dzialaja - lecz sie czarami. Smierc albo wyjscie = proba od nowa.")
	addEvent(towerFloor, 3000, player:getId(), tower.token)
end

-- =====================================================================
-- 2. Czempion Zywiolow
-- =====================================================================
local ELEMENT_STAGES = {
	{ type = COMBAT_FIREDAMAGE, label = "OGIEN" },
	{ type = COMBAT_ICEDAMAGE, label = "LOD" },
	{ type = COMBAT_ENERGYDAMAGE, label = "ENERGIA" },
	{ type = COMBAT_EARTHDAMAGE, label = "ZIEMIA" },
	{ type = COMBAT_HOLYDAMAGE, label = "SWIETOSC" },
	{ type = COMBAT_DEATHDAMAGE, label = "SMIERC" },
	{ type = COMBAT_PHYSICALDAMAGE, label = "OBRAZENIA FIZYCZNE" },
}
local elements = { token = 0, ids = {}, stage = 0, startedAt = 0 }

local elementsTick

local function elementsStage(playerId, token)
	if token ~= elements.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.elements) then
		clearIds(elements.ids)
		elements.ids = {}
		return
	end
	elements.stage = elements.stage + 1
	elements.startedAt = os.time()
	local stage = ELEMENT_STAGES[elements.stage]
	local ids = {}
	for _ = 1, 15 do
		spawn(ids, ROOMS.elements, pick("monster", 0.5, 1), 1)
	end
	spawn(ids, ROOMS.elements, pick("boss", 0.3, 0.6), 1)
	for _, id in ipairs(ids) do
		OtsElementOnly[id] = stage.type
		OtsHardcoreBossVulnerable[id] = nil
		elements.ids[#elements.ids + 1] = id
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Czempion Zywiolow - etap %d/7: potwory i straznika rani tylko %s!", elements.stage, stage.label))
	addEvent(elementsTick, 1000, playerId, token)
end

elementsTick = function(playerId, token)
	if token ~= elements.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.elements) then
		clearIds(elements.ids)
		elements.ids = {}
		if player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Czempion Zywiolow przerwany. Nastepna proba od etapu 1.")
		end
		return
	end
	elements.ids = alive(elements.ids, ROOMS.elements)
	if #elements.ids > 0 and os.time() - elements.startedAt < 10 * 60 then
		addEvent(elementsTick, 1000, playerId, token)
		return
	end
	clearIds(elements.ids)
	elements.ids = {}
	if elements.stage >= #ELEMENT_STAGES then
		if questDone(player, "elements") then
			player:addItem(CHAMPION_AMULET, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "CZEMPION ZYWIOLOW! Nagroda: elemental champion amulet (+30% ochrony przed wszystkimi obrazeniami).")
		else
			player:addTibiaCoins(500)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Czempion Zywiolow ukonczony ponownie: +500 Tibia Coins.")
		end
		return
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Etap %d zaliczony.", elements.stage))
	addEvent(elementsStage, 3000, playerId, token)
end

local function elementsEnter(player)
	if OtsInFight(player) then
		return
	end
	clearIds(elements.ids)
	elements.ids = {}
	elements.token = elements.token + 1
	elements.stage = 0
	OtsTravel(player, "Czempion Zywiolow", ROOMS.elements)
	if not inRoom(player:getPosition(), ROOMS.elements) then
		return
	end
	questStarted(player, "elements")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Czempion Zywiolow: 7 etapow, w kazdym potwory rani tylko jeden zywiol - zmieniaj bron, czary i runy.")
	addEvent(elementsStage, 3000, player:getId(), elements.token)
end

-- Inne zywioly nie rania potworow Czempiona Zywiolow.
local elementGuard = EventCallback("OtsHardcoreElementOnly")

function elementGuard.creatureOnCombat(caster, target, combatDamage)
	if not target or not combatDamage or type(target.getId) ~= "function" then
		return
	end
	local only = OtsElementOnly[target:getId()]
	if not only then
		return
	end
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			if entry.type == only then
				-- wlasciwy zywiol zawsze rani (nawet potwora normalnie na niego odpornego)
				entry.type = COMBAT_NEUTRALDAMAGE
			else
				entry.value = 0
			end
		end
	end
end

elementGuard:register()

-- =====================================================================
-- 3. Wyscig z Czasem
-- =====================================================================
local RACE_BOSSES, RACE_LIMIT = 10, 20 * 60
local race = { token = 0, ids = {}, count = 0, startedAt = 0, used = {} }

local raceTick

local function raceNext(playerId, token)
	if token ~= race.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.race) then
		clearIds(race.ids)
		race.ids = {}
		return
	end
	race.count = race.count + 1
	local name
	for _ = 1, 10 do
		name = pick("boss", 0.2, 0.7)
		if not race.used[name] then
			break
		end
	end
	race.used[name or ""] = true
	spawn(race.ids, ROOMS.race, name, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wyscig z Czasem - boss %d/%d: %s. Czas: %s / 20:00.", race.count, RACE_BOSSES, name or "?", fmtTime(os.time() - race.startedAt)))
	addEvent(raceTick, 1000, playerId, token)
end

raceTick = function(playerId, token)
	if token ~= race.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.race) then
		clearIds(race.ids)
		race.ids = {}
		if player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wyscig z Czasem przerwany.")
		end
		return
	end
	local elapsed = os.time() - race.startedAt
	if elapsed > RACE_LIMIT then
		clearIds(race.ids)
		race.ids = {}
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wyscig z Czasem: czas minal (20:00). Pokonane bossy: %d/%d. Sprobuj jeszcze raz!", race.count - 1, RACE_BOSSES))
		return
	end
	race.ids = alive(race.ids, ROOMS.race)
	if #race.ids > 0 then
		addEvent(raceTick, 1000, playerId, token)
		return
	end
	if race.count < RACE_BOSSES then
		raceNext(playerId, token)
		return
	end
	-- komplet: nagroda wedlug czasu
	local text
	if elapsed < 10 * 60 then
		giveBags(player, 3)
		player:addTibiaCoins(500)
		text = "3 worki i 500 Tibia Coins"
	elseif elapsed < 15 * 60 then
		player:addItem(BAGS[math.random(#BAGS)], 1)
		player:addItem(BAGS[math.random(#BAGS)], 1)
		player:addTibiaCoins(300)
		text = "2 worki i 300 Tibia Coins"
	else
		player:addItem(BAGS[math.random(#BAGS)], 1)
		player:addTibiaCoins(150)
		text = "1 worek i 150 Tibia Coins"
	end
	local best = tonumber(player:kv():get("ots-hq-race-best")) or 0
	if best == 0 or elapsed < best then
		player:kv():set("ots-hq-race-best", elapsed)
		text = text .. ". Nowy rekord!"
	end
	questDone(player, "race")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("WYSCIG Z CZASEM UKONCZONY w %s! Nagroda: %s", fmtTime(elapsed), text))
end

local function raceEnter(player)
	if OtsInFight(player) then
		return
	end
	clearIds(race.ids)
	race.ids = {}
	race.token = race.token + 1
	race.count = 0
	race.used = {}
	OtsTravel(player, "Wyscig z Czasem", ROOMS.race)
	if not inRoom(player:getPosition(), ROOMS.race) then
		return
	end
	questStarted(player, "race")
	race.startedAt = os.time() + 3
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wyscig z Czasem: 10 bossow jeden po drugim, limit 20 minut. Ponizej 10 min - 3 worki, ponizej 15 min - 2 worki, ponizej 20 min - 1 worek.")
	addEvent(raceNext, 3000, player:getId(), race.token)
end

-- =====================================================================
-- 4. Survival 20 min (bez wyjscia)
-- =====================================================================
local SURVIVAL_TIME = 20 * 60
local survival = { token = 0, ids = {}, startedAt = 0, lastWave = 0 }

local function survivalFinish(player, seconds, completed)
	clearIds(survival.ids)
	survival.ids = {}
	if not player then
		return
	end
	local minutes = math.floor(seconds / 60)
	if minutes > 0 then
		player:addTibiaCoins(minutes * 25)
	end
	local stones = math.floor(minutes / 5)
	if stones > 0 then
		player:addItem(UPGRADE_STONE, stones)
	end
	local text = string.format("Survival: przetrwane %s. Nagroda: %d Tibia Coins, %d kamieni ulepszen", fmtTime(seconds), minutes * 25, stones)
	if completed then
		giveBags(player, 3)
		questDone(player, "survival")
		text = "SURVIVAL UKONCZONY (20:00)! " .. text .. " i 3 worki"
	end
	if minutes > (tonumber(player:kv():get("ots-hq-survival-best")) or 0) then
		player:kv():set("ots-hq-survival-best", minutes)
		text = text .. ". Nowy rekord!"
	else
		text = text .. "."
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
end

local function survivalTick(playerId, token)
	if token ~= survival.token then
		return
	end
	local player = Player(playerId)
	local elapsed = os.time() - survival.startedAt
	if not tickPlayer(player, ROOMS.survival) then
		survivalFinish(player, math.max(0, elapsed), false)
		return
	end
	if elapsed >= SURVIVAL_TIME then
		survivalFinish(player, SURVIVAL_TIME, true)
		player:teleportTo(OtsHubLobby)
		OtsHubLobby:sendMagicEffect(CONST_ME_TELEPORT)
		return
	end
	survival.ids = alive(survival.ids, ROOMS.survival)
	if os.time() - survival.lastWave >= 30 and #survival.ids < 60 then
		survival.lastWave = os.time()
		local minute = math.floor(elapsed / 60)
		local level = minute / 20
		local count = 8 + minute * 3
		for _ = 1, count do
			spawn(survival.ids, ROOMS.survival, pick("monster", 0.3 + level * 0.6 - 0.05, 0.3 + level * 0.6 + 0.05), 1)
		end
		player:sendTextMessage(MESSAGE_STATUS, string.format("Survival: %s / 20:00, nowa fala (%d).", fmtTime(elapsed), count))
	end
	addEvent(survivalTick, 1000, playerId, token)
end

local function survivalEnter(player)
	if OtsInFight(player) then
		return
	end
	clearIds(survival.ids)
	survival.ids = {}
	survival.token = survival.token + 1
	-- bez zwyklego teleportu (i bez teleportu powrotnego): z tej sali nie da sie wyjsc przed koncem
	local from = player:getPosition()
	player:teleportTo(ROOMS.survival)
	from:sendMagicEffect(CONST_ME_POFF)
	ROOMS.survival:sendMagicEffect(CONST_ME_TELEPORT)
	questStarted(player, "survival")
	survival.startedAt = os.time() + 3
	survival.lastWave = 0
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Survival: sala jest zamknieta na 20 minut, nie ma teleportu wyjscia. Fale co 30 s, coraz wieksze i mocniejsze. Nagroda za kazda przetrwana minute.")
	addEvent(survivalTick, 3000, player:getId(), survival.token)
end

-- =====================================================================
-- 5. Klatwa Obrona (lancuch 3 etapow)
-- =====================================================================
local FALCONS = { "Falcon Knight", "Falcon Paladin" }
local FALCON_ITEMS = { "falcon battleaxe", "falcon longsword", "falcon mace", "falcon bow", "falcon coif", "falcon rod", "falcon wand", "falcon sai", "falcon shield", "falcon greaves", "falcon plate" }
local oberon = { token = 0, ids = {}, stage = 0, wave = 0, startedAt = 0, lastAdds = 0 }

local oberonTick

local function oberonSpawnStage(player)
	local stage = oberon.stage
	oberon.startedAt = os.time()
	if stage == 1 then
		oberon.wave = oberon.wave + 1
		for _ = 1, 8 do
			spawn(oberon.ids, ROOMS.oberon, FALCONS[math.random(#FALCONS)], 1)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Klatwa Obrona - etap 1: Zakon Sokola, fala %d/3.", oberon.wave))
	elseif stage == 2 then
		spawn(oberon.ids, ROOMS.oberon, "Preceptor Lazare", 1)
		spawn(oberon.ids, ROOMS.oberon, "Grand Commander Soeren", 1)
		for _ = 1, 6 do
			spawn(oberon.ids, ROOMS.oberon, FALCONS[math.random(#FALCONS)], 1)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Klatwa Obrona - etap 2: Preceptor Lazare i Grand Commander Soeren.")
	else
		spawn(oberon.ids, ROOMS.oberon, "Grand Master Oberon", 1, true)
		oberon.lastAdds = os.time()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Klatwa Obrona - etap 3: GRAND MASTER OBERON (Koszmar)! Co 30 s dolaczaja rycerze sokola.")
	end
end

local function oberonStart(playerId, token)
	if token ~= oberon.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.oberon) then
		clearIds(oberon.ids)
		oberon.ids = {}
		return
	end
	oberon.wave = 0
	oberonSpawnStage(player)
	addEvent(oberonTick, 1000, playerId, token)
end

oberonTick = function(playerId, token)
	if token ~= oberon.token then
		return
	end
	local player = Player(playerId)
	if not tickPlayer(player, ROOMS.oberon) then
		clearIds(oberon.ids)
		oberon.ids = {}
		if player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Klatwa Obrona przerwana. Postep zapisany: etap %d.", oberon.stage))
		end
		return
	end
	oberon.ids = alive(oberon.ids, ROOMS.oberon)
	if oberon.stage == 3 and os.time() - oberon.lastAdds >= 30 and #oberon.ids > 0 then
		oberon.lastAdds = os.time()
		for _ = 1, 4 do
			spawn(oberon.ids, ROOMS.oberon, FALCONS[math.random(#FALCONS)], 1)
		end
	end
	if #oberon.ids > 0 and os.time() - oberon.startedAt < 15 * 60 then
		addEvent(oberonTick, 1000, playerId, token)
		return
	end
	clearIds(oberon.ids)
	oberon.ids = {}
	if oberon.stage == 1 and oberon.wave < 3 then
		oberonSpawnStage(player)
		addEvent(oberonTick, 1000, playerId, token)
		return
	end
	if oberon.stage == 1 then
		player:addTibiaCoins(300)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Etap 1 zaliczony: +300 Tibia Coins. Za chwile etap 2.")
	elseif oberon.stage == 2 then
		player:addItem(BLESSED_STONE, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Etap 2 zaliczony: +2 blessed upgrade stone. Za chwile etap 3.")
	else
		local itemName = FALCON_ITEMS[math.random(#FALCON_ITEMS)]
		player:addItem(ItemType(itemName):getId(), 1)
		player:addTibiaCoins(1000)
		player:addItem(BLESSED_STONE, 5)
		questDone(player, "oberon")
		player:kv():set("ots-hq-oberon-stage", 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("KLATWA OBRONA ZDJETA! Nagroda: %s, 1000 Tibia Coins, 5 blessed upgrade stone.", itemName))
		return
	end
	oberon.stage = oberon.stage + 1
	player:kv():set("ots-hq-oberon-stage", oberon.stage)
	addEvent(oberonStart, 4000, playerId, token)
end

local function oberonEnter(player)
	if OtsInFight(player) then
		return
	end
	clearIds(oberon.ids)
	oberon.ids = {}
	oberon.token = oberon.token + 1
	oberon.stage = math.max(1, math.min(3, tonumber(player:kv():get("ots-hq-oberon-stage")) or 1))
	OtsTravel(player, "Klatwa Obrona", ROOMS.oberon)
	if not inRoom(player:getPosition(), ROOMS.oberon) then
		return
	end
	questStarted(player, "oberon")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Klatwa Obrona: lancuch 3 etapow, postep sie zapisuje. Zaczynasz od etapu %d.", oberon.stage))
	addEvent(oberonStart, 3000, player:getId(), oberon.token)
end

-- =====================================================================
-- Menu (!tp > Hardcore Questy) i budowa sal
-- =====================================================================
OtsHardcoreMenu = function(player)
	local function status(key)
		return player:getStorageValue(STORAGE[key]) >= 2 and "[Complete] " or ""
	end
	local kv = player:kv()
	local window = ModalWindow({ title = "Hardcore Questy", message = "Piec trudnych wyzwan. Potwory maja losowa sile, jeden cios zabiera najwyzej 17% zycia.                                        " })
	window:addChoice(string.format("%sWieza Upadku (rekord: pietro %d/50)", status("tower"), tonumber(kv:get("ots-hq-tower-best")) or 0), towerEnter)
	window:addChoice(status("elements") .. "Czempion Zywiolow (7 etapow, amulet)", elementsEnter)
	local raceBest = tonumber(kv:get("ots-hq-race-best")) or 0
	window:addChoice(string.format("%sWyscig z Czasem (10 bossow w 20 min, rekord: %s)", status("race"), raceBest > 0 and fmtTime(raceBest) or "-"), raceEnter)
	window:addChoice(string.format("%sSurvival 20 min, bez wyjscia (rekord: %d min)", status("survival"), tonumber(kv:get("ots-hq-survival-best")) or 0), survivalEnter)
	window:addChoice(string.format("%sKlatwa Obrona (etap %d/3)", status("oberon"), tonumber(kv:get("ots-hq-oberon-stage")) or 1), oberonEnter)
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local build = GlobalEvent("OtsHardcoreRooms")

function build.onStartup()
	local made = 0
	for _, landing in pairs(ROOMS) do
		made = made + OtsBuildRoom(landing)
	end
	buildPools()
	logger.info("[OTS hardcore questy] Sale gotowe (pol: {})", made)
	return true
end

build:register()
