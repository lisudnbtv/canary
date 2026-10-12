-- OTS: "Skrzynia najazdu" przy depo w Thais.
-- Co 30 min (liczone od odebrania nagrody) pojawia sie skrzynia i czeka, az ktos jej uzyje - nie znika sama.
-- Uzycie rusza 4 fale wokol skrzyni: 1) 30 potworow z piekla, 2) 60 takich samych, 3) 45 potworow z Soul War,
-- 4) mocny boss (od Ghazbarana w gore). Po wybiciu wszystkiego uzycie skrzyni daje nagrode: crystal coiny, losowy mocny przedmiot
-- i kamienie ulepszen. Potem skrzynia znika i zaczyna sie odliczanie do nastepnej.
-- Miejsce skrzyni: zapisane raz (dawna komenda "!skrzynia tutaj"), inaczej domyslne przy depo. "!skrzynia" pokazuje stan.
-- Odroczone wywolania niosa tylko numer biegu (token) i identyfikatory potworow.
local CHEST_ID = 2483 -- large trunk
-- IMMOVABLE_ACTION_ID: silnik nie pozwala ruszyc takiego przedmiotu - ani graczom, ani potworom.
-- Uzycie skrzyni lapie akcja przypisana do pola, na ktorym stoi.
local CHEST_ACTION_ID = IMMOVABLE_ACTION_ID
local RESPAWN_SECONDS = 30 * 60
local FIRST_AFTER_SECONDS = 2 * 60
local ABANDON_SECONDS = 10 * 60 -- nikogo w poblizu przez tyle czasu: fale przepadaja, skrzynia czeka od nowa
local DEFAULT_POSITION = Position(32349, 32215, 7)
local REWARD_CRYSTAL_COINS = 200
local REWARD_STONES = 3

local HELL = { "Demon", "Juggernaut", "Hellhound", "Plaguesmith" }
local SOUL_WAR = { "Hazardous Phantom", "Infernal Phantom", "Infernal Demon", "Rotten Golem", "Branchy Crawler", "Mould Phantom", "Courage Leech", "Bony Sea Devil", "Many Faces", "Cloak of Terror", "Vibrant Phantom", "Turbulent Elemental", "Capricious Phantom" }
local BOSSES = { "Ghazbaran", "Drume", "Ferumbras", "Urmahlullu the Weakened", "Omrafir", "The Rootkraken", "The Monster", "The Abomination", "Ancient Spawn of Morgathla", "Morshabaal" }
local WAVES = {
	{ label = "Fala 1/4: piekielne potwory", pool = HELL, count = 30 },
	{ label = "Fala 2/4: wiecej piekielnych potworow", pool = HELL, count = 60 },
	{ label = "Fala 3/4: potwory z Soul War", pool = SOUL_WAR, count = 45 },
	{ label = "Fala 4/4: boss", pool = BOSSES, count = 1 },
}
local REWARD_ITEMS = {
	34082, 34088, 34090, 34091, 34092, 34093, 34094, 34095, 34096, 34097, 34098, 34099, -- Soul War
	28714, 28715, 28716, 28717, 28718, 28719, 28720, 28721, 28722, 28723, 28724, 28725, -- Falcon
}

-- stan: "waiting" (nie ma skrzyni), "ready" (skrzynia czeka na start), "fighting", "reward" (czeka na odbior)
local state = { phase = "waiting", nextAt = os.time() + FIRST_AFTER_SECONDS, wave = 0, ids = {}, token = 0, lastSeen = 0 }

local function chestPosition()
	local ok, saved = pcall(function()
		return kv.scoped("ots-depot-raid"):get("pos")
	end)
	saved = ok and saved or nil
	if type(saved) == "table" and saved.x then
		return Position(saved.x, saved.y, saved.z)
	end
	return DEFAULT_POSITION
end


local function findChest()
	local tile = Tile(chestPosition())
	return tile and tile:getItemById(CHEST_ID)
end

local function placeChest()
	local chest = findChest() or Game.createItem(CHEST_ID, 1, chestPosition())
	if chest then
		chest:setActionId(CHEST_ACTION_ID)
		chest:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Skrzynia najazdu. Uzyj, zeby wywolac 4 fale potworow - nagroda czeka w srodku.")
	end
	return chest
end

local function removeChest()
	local chest = findChest()
	if chest then
		chest:remove()
	end
end

local function clearMonsters()
	for _, id in ipairs(state.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	state.ids = {}
end

-- Wolne pola wokol srodka, do ktorych da sie dojsc pieszo od srodka (bez domkow, PZ, schodow, scian).
-- Dzieki temu potwory nie pojawiaja sie w domkach ani w zamknietych pomieszczeniach.
local function reachableSpots(center, radius)
	local list, seen, queue = {}, {}, { center }
	seen[center.x .. ":" .. center.y] = true
	local head = 1
	while queue[head] do
		local pos = queue[head]
		head = head + 1
		for dx = -1, 1 do
			for dy = -1, 1 do
				local nx, ny = pos.x + dx, pos.y + dy
				local id = nx .. ":" .. ny
				if not seen[id] and math.abs(nx - center.x) <= radius and math.abs(ny - center.y) <= radius then
					seen[id] = true
					local nextPos = Position(nx, ny, center.z)
					local tile = Tile(nextPos)
					if tile and tile:isWalkable(true, false, true, true, false) then
						queue[#queue + 1] = nextPos
						if not tile:getTopCreature() then
							list[#list + 1] = nextPos
						end
					end
				end
			end
		end
	end
	return list
end

local function spawnWave(index)
	local wave = WAVES[index]
	local center = chestPosition()
	state.ids = {}
	local free = reachableSpots(center, 9)
	for _ = 1, wave.count do
		if #free == 0 then
			break
		end
		local name = wave.pool[math.random(#wave.pool)]
		local pos = table.remove(free, math.random(#free))
		local monster = Game.createMonster(name, pos, false, true)
		if monster then
			state.ids[#state.ids + 1] = monster:getId()
		end
	end
	center:sendMagicEffect(CONST_ME_MORTAREA)
	Game.broadcastMessage(string.format("Skrzynia najazdu: %s (%d).", wave.label, #state.ids), MESSAGE_EVENT_ADVANCE)
end

local function anyoneNear()
	local center = chestPosition()
	for _, creature in ipairs(Game.getSpectators(center, false, true, 15, 15, 15, 15)) do
		if creature:isPlayer() then
			return true
		end
	end
	return false
end

local tick = GlobalEvent("OtsDepotRaidTick")

function tick.onThink(interval)
	if state.phase == "waiting" then
		if os.time() >= state.nextAt and placeChest() then
			state.phase = "ready"
			Game.broadcastMessage("Przy depo w Thais pojawila sie Skrzynia najazdu! Uzyj jej, zeby zaczac 4 fale.", MESSAGE_EVENT_ADVANCE)
		end
		return true
	end
	if state.phase == "ready" or state.phase == "reward" then
		placeChest() -- gdyby ktos ja przesunal albo sprzatanie mapy ja zabralo
		return true
	end
	-- walka
	if anyoneNear() then
		state.lastSeen = os.time()
	elseif os.time() - state.lastSeen >= ABANDON_SECONDS then
		clearMonsters()
		state.phase = "ready"
		state.wave = 0
		placeChest()
		Game.broadcastMessage("Skrzynia najazdu: nikt nie walczyl - fale przepadly. Skrzynia czeka na ponowne uzycie.", MESSAGE_EVENT_ADVANCE)
		return true
	end
	for _, id in ipairs(state.ids) do
		if Creature(id) then
			return true
		end
	end
	if state.wave < #WAVES then
		state.wave = state.wave + 1
		spawnWave(state.wave)
		if #state.ids == 0 and state.wave < #WAVES then
			return true -- pusta fala (nie dalo sie postawic potworow): nastepna przy kolejnym tiku
		end
		return true
	end
	state.phase = "reward"
	state.ids = {}
	placeChest()
	Game.broadcastMessage("Skrzynia najazdu: wszystkie fale pokonane! Uzyj skrzyni, zeby odebrac nagrode.", MESSAGE_EVENT_ADVANCE)
	return true
end

tick:interval(3000)
tick:register()

local chest = Action()

function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= CHEST_ID then
		return false
	end
	if state.phase == "ready" then
		state.phase = "fighting"
		state.wave = 0
		state.ids = {}
		state.lastSeen = os.time()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skrzynia najazdu otwarta - nadchodza fale! Odsun sie i walcz.")
		return true
	end
	if state.phase == "fighting" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Skrzynia jest zamknieta - trwa fala %d/%d.", math.max(state.wave, 1), #WAVES))
		return true
	end
	if state.phase ~= "reward" then
		return true
	end
	local itemId = REWARD_ITEMS[math.random(#REWARD_ITEMS)]
	player:addItem(ITEM_CRYSTAL_COIN, REWARD_CRYSTAL_COINS)
	player:addItem(itemId, 1)
	player:addItem(20139, REWARD_STONES)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Nagroda ze Skrzyni najazdu: %d crystal coin, %s i %d kamienie ulepszen.", REWARD_CRYSTAL_COINS, ItemType(itemId):getName(), REWARD_STONES))
	removeChest()
	state.phase = "waiting"
	state.wave = 0
	state.nextAt = os.time() + RESPAWN_SECONDS
	return true
end

chest:position(chestPosition())
chest:register()

local command = TalkAction("!skrzynia")

function command.onSay(player, words, param)
	local text
	if state.phase == "waiting" then
		text = string.format("Nastepna Skrzynia najazdu za okolo %d min.", math.ceil(math.max(0, state.nextAt - os.time()) / 60))
	elseif state.phase == "ready" then
		text = "Skrzynia najazdu czeka przy depo - uzyj jej, zeby zaczac."
	elseif state.phase == "fighting" then
		local alive = 0
		for _, id in ipairs(state.ids) do
			if Creature(id) then
				alive = alive + 1
			end
		end
		text = string.format("Trwa fala %d/%d, zostalo potworow: %d.", math.max(state.wave, 1), #WAVES, alive)
	else
		text = "Fale pokonane - nagroda czeka w skrzyni."
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	return true
end

command:separator(" ")
command:groupType("normal")
command:register()
