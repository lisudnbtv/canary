-- OTS: questy na stroje sa trudniejsze - kazdy potwor w sali stroju to elita
-- (czarna czaszka, nazwa "Elite ...", 4x wiecej HP, 2x mocniejsze ataki), a po wejsciu
-- do sali dochodzi dodatkowa fala 20 elit tych samych gatunkow. Elity z sal strojow nie
-- daja nagrody z losowych elit (to zwykla czesc questa).
-- Stan trzyma tylko identyfikatory potworow; kazdy tik sprawdza je od nowa, a dodatkowa
-- fala znika, gdy w sali nie ma juz gracza.

local HEALTH_MULTIPLIER = 4
local DAMAGE_MULTIPLIER = 2
local EXTRA_MONSTERS = 20
local TICK_MS = 2000

OtsOutfitElite = OtsOutfitElite or {} -- id potwora -> true
local extras = {} -- numer sali -> lista id dodatkowych potworow
local roomNames = {} -- numer sali -> nazwy gatunkow widzianych w sali

local function roomBounds(index)
	local quest = OtsOutfitRooms and OtsOutfitRooms[index]
	if not quest then
		return nil
	end
	local size = OtsOutfitRoomSize or 13
	return quest, size
end

local function inRoom(index, pos)
	local quest, size = roomBounds(index)
	return quest and pos.z == quest.entry.z and pos.x >= quest.x and pos.x < quest.x + size and pos.y >= quest.y and pos.y < quest.y + size
end

local function roomCreatures(index, playersOnly)
	local quest, size = roomBounds(index)
	if not quest then
		return {}
	end
	local half = math.floor(size / 2)
	local center = Position(quest.x + half, quest.y + half, quest.entry.z)
	local result = {}
	for _, creature in ipairs(Game.getSpectators(center, false, playersOnly, half + 1, half + 1, half + 1, half + 1)) do
		if inRoom(index, creature:getPosition()) then
			result[#result + 1] = creature
		end
	end
	return result
end

local function makeElite(monster)
	if OtsOutfitElite[monster:getId()] or monster:getMaster() or monster:getName():find("^Elite ") then
		return
	end
	local health = monster:getMaxHealth() * HEALTH_MULTIPLIER
	monster:setMaxHealth(health)
	monster:addHealth(health)
	monster:setName("Elite " .. monster:getName())
	monster:setSkull(SKULL_BLACK)
	OtsOutfitElite[monster:getId()] = true
end

-- Wywolywane z outfit_quests.lua przy wejsciu do sali (quest jeszcze niewykonany).
function OtsOutfitRoomEnter(player, index)
	local quest, size = roomBounds(index)
	if not quest then
		return
	end
	local names = roomNames[index] or {}
	if #names == 0 then
		local seen = {}
		for _, creature in ipairs(roomCreatures(index, false)) do
			if creature:isMonster() and not creature:getMaster() then
				local name = creature:getType() and creature:getType():getName() or creature:getName()
				if not seen[name] then
					seen[name] = true
					names[#names + 1] = name
				end
			end
		end
		roomNames[index] = names
	end
	if #names == 0 then
		return
	end

	local list = extras[index] or {}
	local alive = {}
	for _, id in ipairs(list) do
		if Creature(id) then
			alive[#alive + 1] = id
		end
	end
	for _ = #alive + 1, EXTRA_MONSTERS do
		local pos = Position(quest.x + math.random(1, size - 2), quest.y + math.random(1, size - 4), quest.entry.z)
		local monster = Game.createMonster(names[math.random(#names)], pos, true, false)
		if monster then
			if inRoom(index, monster:getPosition()) then
				makeElite(monster)
				alive[#alive + 1] = monster:getId()
			else
				monster:remove()
			end
		end
	end
	extras[index] = alive
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Sala stroju: wszystkie potwory to elity (czarna czaszka), doszla dodatkowa fala %d elit.", #alive))
end

local tick = GlobalEvent("OtsOutfitElitesTick")

function tick.onThink(interval)
	for id in pairs(OtsOutfitElite) do
		if not Creature(id) then
			OtsOutfitElite[id] = nil
		end
	end
	if not OtsOutfitRooms then
		return true
	end

	local occupied = {}
	for _, player in ipairs(Game.getPlayers()) do
		local pos = player:getPosition()
		local quest, size = nil, OtsOutfitRoomSize or 13
		for index, room in ipairs(OtsOutfitRooms) do
			if pos.z == room.entry.z and pos.x >= room.x and pos.x < room.x + size and pos.y >= room.y and pos.y < room.y + size then
				quest = index
				break
			end
		end
		if quest then
			occupied[quest] = true
		end
	end

	for index in pairs(occupied) do
		for _, creature in ipairs(roomCreatures(index, false)) do
			if creature:isMonster() then
				makeElite(creature)
			end
		end
	end

	for index, list in pairs(extras) do
		if not occupied[index] then
			for _, id in ipairs(list) do
				local creature = Creature(id)
				if creature then
					creature:remove()
				end
			end
			extras[index] = nil
		end
	end
	return true
end

tick:interval(TICK_MS)
tick:register()

local damage = EventCallback("OtsOutfitEliteDamage")

function damage.creatureOnCombat(caster, target, combatDamage)
	if not caster or not combatDamage or type(caster.getId) ~= "function" or not OtsOutfitElite[caster:getId()] then
		return
	end
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.value = entry.value * DAMAGE_MULTIPLIER
		end
	end
end

damage:register()
