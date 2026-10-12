-- OTS: ostatnia walka In Service of Yalahar pod jednego gracza.
-- Zmiany wzgledem oryginalu:
--  * Azerus nie znika po 5 minutach - sala czysci sie dopiero, gdy nikogo w niej nie ma
--    (albo po 30 minutach), wiec da sie go spokojnie dobic w pojedynke;
--  * przemiana Azerusa po 3 minutach zachowuje jego obecne zycie zamiast leczyc do pelna;
--  * kazda walka ma swoj numer - zalegle fale i sprzatanie z poprzedniej walki nic nie robia.
OtsYalaharFight = OtsYalaharFight or { id = 0, active = false }

local CENTER = Position(32783, 31166, 10)
local RANGE = 10
local CHECK_START = 5 * 60 * 1000
local CHECK_EVERY = 60 * 1000
local MAX_CHECKS = 25

local waves = {
	Position(32779, 31166, 10),
	Position(32787, 31166, 10),
	Position(32782, 31162, 10),
	Position(32784, 31162, 10),
	Position(32782, 31170, 10),
	Position(32784, 31170, 10),
}

local creatureNames = { "rift worm", "rift scythe", "rift brood", "war golem" }

local effectPositions = {
	Position(32779, 31161, 10),
	Position(32787, 31171, 10),
}

local function current(fightId)
	return OtsYalaharFight.active and OtsYalaharFight.id == fightId
end

function OtsYalaharClearArena()
	local spectators = Game.getSpectators(CENTER, false, false, RANGE, RANGE, RANGE, RANGE)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isMonster() then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
	end
end

function OtsYalaharEndFight()
	OtsYalaharFight.active = false
	OtsYalaharFight.id = OtsYalaharFight.id + 1
	Game.setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.LastFight, 0)
end

local function playersInArena()
	return #Game.getSpectators(CENTER, false, true, RANGE, RANGE, RANGE, RANGE) > 0
end

local function checkArena(fightId, checksLeft)
	if not current(fightId) then
		return
	end
	if playersInArena() and checksLeft > 0 then
		addEvent(checkArena, CHECK_EVERY, fightId, checksLeft - 1)
		return
	end
	OtsYalaharClearArena()
	OtsYalaharEndFight()
end

local function changeAzerus(fightId)
	if not current(fightId) then
		return
	end
	local spectators = Game.getSpectators(CENTER, false, false, RANGE, RANGE, RANGE, RANGE)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isMonster() and spectator:getName():lower() == "azerus" then
			local health = spectator:getHealth()
			local position = spectator:getPosition()
			spectator:say("No! I am losing my energy!", TALKTYPE_MONSTER_SAY)
			spectator:remove()
			local azerus = Game.createMonster("Azerus", position, false, true)
			if azerus then
				azerus:setHealth(math.max(1, health))
			end
			return
		end
	end
end

local function summonMonster(fightId, name, position)
	if not current(fightId) then
		return
	end
	Game.createMonster(name, position, false, true)
	position:sendMagicEffect(CONST_ME_TELEPORT)
end

local inServiceYalaharLastFight = Action()
function inServiceYalaharLastFight.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if OtsYalaharFight.active or Game.getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.LastFight) == 1 then
		player:say("You have to wait some time before this globe charges.", TALKTYPE_MONSTER_SAY)
		return true
	end

	OtsYalaharFight.id = OtsYalaharFight.id + 1
	OtsYalaharFight.active = true
	local fightId = OtsYalaharFight.id
	Game.setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.LastFight, 1)

	addEvent(summonMonster, 18 * 1000, fightId, "Azerus2", Position(32783, 31167, 10))
	for i = 1, #creatureNames do
		for k = 1, #waves do
			addEvent(summonMonster, (i - 1) * 60 * 1000, fightId, creatureNames[i], Position(waves[k].x, waves[k].y, waves[k].z))
		end
	end

	for i = 1, #effectPositions do
		effectPositions[i]:sendMagicEffect(CONST_ME_HOLYAREA)
	end

	addEvent(changeAzerus, 3 * 60 * 1000, fightId)
	addEvent(checkArena, CHECK_START, fightId, MAX_CHECKS)
	return true
end

inServiceYalaharLastFight:uid(3086)
inServiceYalaharLastFight:register()
