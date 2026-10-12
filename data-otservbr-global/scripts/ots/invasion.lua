-- OTS: inwazje na Thais. Co jakis czas w losowym miejscu miasta (na zewnatrz) pojawia sie
-- grupa potworow i serwer to oglasza. Po wybiciu wszystkich kazdy, kto zabil choc jednego,
-- dostaje nagrode. Miejsca szuka sie komenda !inwazja - odpowiada jak exiva: kierunek i odleglosc.
-- (Sama exiva w silniku namierza tylko graczy, wiec inwazja ma wlasna komende.)
local STONE_ID = 20139
local FIRST_AFTER_SECONDS = 15 * 60
local EVERY_SECONDS = 90 * 60
local TIME_LIMIT_SECONDS = 20 * 60
local REWARD_GOLD = 1000000
local REWARD_COINS = 20
local REWARD_STONES = 3

-- otwarte miejsca na zewnatrz w Thais, poza strefami PZ (wybrane z mapy)
local spots = {
	Position(32314, 32293, 7),
	Position(32428, 32299, 7),
	Position(32437, 32260, 7),
	Position(32356, 32296, 7),
	Position(32395, 32191, 7),
	Position(32359, 32188, 7),
	Position(32338, 32251, 7),
	Position(32425, 32215, 7),
	Position(32338, 32215, 7),
	Position(32437, 32173, 7),
}

local themes = {
	{ name = "Demony", monsters = { { "Demon", 5 }, { "Destroyer", 5 }, { "Hellhound", 3 } } },
	{ name = "Smoki", monsters = { { "Dragon Lord", 7 }, { "Frost Dragon", 6 } } },
	{ name = "Nieumarli", monsters = { { "Lich", 6 }, { "Grim Reaper", 5 }, { "Undead Dragon", 2 } } },
	{ name = "Orkowie", monsters = { { "Orc Warlord", 8 }, { "Orc Berserker", 8 } } },
}

local state = { active = false, ids = {}, spot = nil, theme = nil, startedAt = 0, nextAt = os.time() + FIRST_AFTER_SECONDS, fighters = {} }

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

local function start()
	local theme = themes[math.random(#themes)]
	local spot = spots[math.random(#spots)]
	local ids = {}
	local free = reachableSpots(spot, 5)
	for _, group in ipairs(theme.monsters) do
		for _ = 1, group[2] do
			local pos = #free > 0 and table.remove(free, math.random(#free))
			local monster = pos and Game.createMonster(group[1], pos, false, true)
			if monster then
				ids[#ids + 1] = monster:getId()
			end
		end
	end
	if #ids == 0 then
		state.nextAt = os.time() + 60
		return
	end
	state.active = true
	state.ids = ids
	state.spot = spot
	state.theme = theme
	state.startedAt = os.time()
	state.fighters = {}
	Game.broadcastMessage("INWAZJA! " .. theme.name .. " atakuja Thais (" .. #ids .. " potworow). Wpisz !inwazja, zeby namierzyc miejsce.", MESSAGE_EVENT_ADVANCE)
end

local function finish(won)
	if won then
		local rewarded = 0
		for guid in pairs(state.fighters) do
			local player = Player(guid)
			if player then
				player:setBankBalance(player:getBankBalance() + REWARD_GOLD)
				player:addTibiaCoins(REWARD_COINS)
				player:addItem(STONE_ID, REWARD_STONES)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Inwazja odparta! Nagroda: %d gp na konto, %d Tibia Coins, %d kamienie ulepszen.", REWARD_GOLD, REWARD_COINS, REWARD_STONES))
				rewarded = rewarded + 1
			end
		end
		Game.broadcastMessage("Inwazja na Thais odparta (" .. state.theme.name .. ").", MESSAGE_EVENT_ADVANCE)
	else
		for _, id in ipairs(state.ids) do
			local creature = Creature(id)
			if creature then
				creature:remove()
			end
		end
		Game.broadcastMessage("Inwazja na Thais minela - najezdzcy odeszli sami.", MESSAGE_EVENT_ADVANCE)
	end
	state.active = false
	state.ids = {}
	state.fighters = {}
	state.nextAt = os.time() + EVERY_SECONDS
end

local tick = GlobalEvent("OtsInvasionTick")

function tick.onThink(interval)
	if not state.active then
		if os.time() >= state.nextAt and #Game.getPlayers() > 0 then
			start()
		end
		return true
	end
	local anyAlive = false
	for _, id in ipairs(state.ids) do
		if Creature(id) then
			anyAlive = true
			break
		end
	end
	if not anyAlive then
		finish(true)
	elseif os.time() - state.startedAt >= TIME_LIMIT_SECONDS then
		finish(false)
	end
	return true
end

tick:interval(5000)
tick:register()

local kills = EventCallback("OtsInvasionKill")

function kills.playerOnKill(player, monster)
	if not state.active or not player or not monster then
		return
	end
	local id = monster:getId()
	for _, invaderId in ipairs(state.ids) do
		if invaderId == id then
			state.fighters[player:getGuid()] = true
			return
		end
	end
end

kills:register()

local function direction(from, to)
	local dx, dy = to.x - from.x, to.y - from.y
	local ns = dy < 0 and "polnoc" or "poludnie"
	local ew = dx < 0 and "zachod" or "wschod"
	if math.abs(dx) * 2 < math.abs(dy) then
		return "na " .. ns
	elseif math.abs(dy) * 2 < math.abs(dx) then
		return "na " .. ew
	end
	return "na " .. (dy < 0 and "polnocny" or "poludniowy") .. " " .. ew
end

local find = TalkAction("!inwazja")

function find.onSay(player, words, param)
	if not state.active then
		local left = math.max(0, state.nextAt - os.time())
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Teraz nie ma inwazji. Nastepna za okolo %d min.", math.ceil(left / 60)))
		return true
	end
	local alive = 0
	for _, id in ipairs(state.ids) do
		if Creature(id) then
			alive = alive + 1
		end
	end
	local position = player:getPosition()
	local distance = math.max(math.abs(position.x - state.spot.x), math.abs(position.y - state.spot.y))
	local text
	if position.z ~= state.spot.z then
		text = "Inwazja jest na powierzchni w Thais - wyjdz na poziom ulicy."
	elseif distance <= 6 then
		text = "Inwazja jest tuz obok ciebie."
	else
		local how = distance <= 30 and "niedaleko" or (distance <= 90 and "daleko" or "bardzo daleko")
		text = "Inwazja jest " .. how .. " " .. direction(position, state.spot) .. "."
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s %s, zostalo potworow: %d.", text, state.theme.name, alive))
	return true
end

find:groupType("normal")
find:register()
