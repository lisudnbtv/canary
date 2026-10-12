-- OTS: Soul War jako fale bossow na arenie w hubie (zamiast pieciu terenow z mechanikami).
-- Kolejno: Cruelty, Hatred, Spite, Malice, Greed, a na koniec Goshnar's Megalomania.
-- Nastepny boss pojawia sie kilka sekund po smierci poprzedniego. Po Megalomanii
-- gracz trafia do oryginalnego pokoju nagrod Soul War (skrzynia z przedmiotami profesji).
-- Wyjscie z areny przerywa walke; odroczone sprawdzenia trzymaja tylko identyfikatory
-- i numer walki, wiec po przerwaniu albo nowej walce stare wywolania nic nie robia.

local ARENA_CENTER = Position(30060, 29900, 7)
local ARENA_LANDING = Position(30060, 29909, 7)
local ARENA_RADIUS = 10
local REWARD_ROOM = Position(33621, 31402, 10)
local NEXT_WAVE_DELAY = 5000
local CHECK_INTERVAL = 2000

local waves = {
	{ monster = "Goshnar's Cruelty", label = "Goshnar's Cruelty" },
	{ monster = "Goshnar's Hatred", label = "Goshnar's Hatred" },
	{ monster = "Goshnar's Spite", label = "Goshnar's Spite" },
	{ monster = "Goshnar's Malice", label = "Goshnar's Malice", unregister = { "Goshnar's-Malice" } },
	{ monster = "Goshnar's Greed", label = "Goshnar's Greed" },
	{ monster = "Goshnar's Megalomania Green", label = "Goshnar's Megalomania" },
}

local state = { token = 0, bossId = nil }

local function inArena(player)
	local pos = player:getPosition()
	return pos.z == ARENA_CENTER.z and math.abs(pos.x - ARENA_CENTER.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - ARENA_CENTER.y) <= ARENA_RADIUS + 1
end

local function clearArena()
	local spectators = Game.getSpectators(ARENA_CENTER, false, false, ARENA_RADIUS + 1, ARENA_RADIUS + 1, ARENA_RADIUS + 1, ARENA_RADIUS + 1)
	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			creature:remove()
		end
	end
	state.bossId = nil
end

local function abort(token)
	if token ~= state.token then
		return
	end
	state.token = state.token + 1
	clearArena()
end

local spawnWave

local function check(playerId, token, index)
	if token ~= state.token then
		return
	end
	local player = Player(playerId)
	if not player or not inArena(player) then
		abort(token)
		return
	end
	if state.bossId and Creature(state.bossId) then
		addEvent(check, CHECK_INTERVAL, playerId, token, index)
		return
	end
	state.bossId = nil

	if index < #waves then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Soul War: pokonano %s (%d/%d). Nastepny boss za %d s.", waves[index].label, index, #waves, NEXT_WAVE_DELAY / 1000))
		addEvent(spawnWave, NEXT_WAVE_DELAY, playerId, token, index + 1)
		return
	end

	state.token = state.token + 1
	clearArena()
	-- Megalomania sama zapisuje wygrana zabojcom; tu dopisujemy na wypadek, gdyby ostatni cios zadalo cos innego.
	player:soulWarQuestKV():set("goshnar's-megalomania-killed", true)
	player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	player:teleportTo(REWARD_ROOM)
	REWARD_ROOM:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Soul War ukonczone! Skrzynia z przedmiotami Twojej profesji stoi w tym pokoju (strefa PZ). Powrot: !tp.")
end

spawnWave = function(playerId, token, index)
	if token ~= state.token then
		return
	end
	local player = Player(playerId)
	if not player or not inArena(player) then
		abort(token)
		return
	end
	local wave = waves[index]
	local pos = Position(ARENA_CENTER.x + math.random(-3, 3), ARENA_CENTER.y + math.random(-6, -2), ARENA_CENTER.z)
	local boss = Game.createMonster(wave.monster, pos, true, true)
	if not boss then
		player:sendCancelMessage("Nie udalo sie przywolac bossa: " .. wave.label)
		abort(token)
		return
	end
	for _, eventName in ipairs(wave.unregister or {}) do
		boss:unregisterEvent(eventName)
	end
	state.bossId = boss:getId()
	boss:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Soul War, fala %d/%d: %s!", index, #waves, wave.label))
	addEvent(check, CHECK_INTERVAL, playerId, token, index)
end

function OtsSoulWarStart(player)
	local soulWarQuest = player:soulWarQuestKV()
	if soulWarQuest:get("goshnar's-megalomania-killed") and not soulWarQuest:get("final-reward") then
		local from = player:getPosition()
		player:teleportTo(REWARD_ROOM)
		from:sendMagicEffect(CONST_ME_POFF)
		REWARD_ROOM:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Soul War: Megalomania juz pokonana - odbierz nagrode ze skrzyni w tym pokoju.")
		return
	end

	state.token = state.token + 1
	local token = state.token
	clearArena()

	local from = player:getPosition()
	player:teleportTo(ARENA_LANDING)
	from:sendMagicEffect(CONST_ME_POFF)
	ARENA_LANDING:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Soul War: %d bossow po kolei, ostatni to Goshnar's Megalomania. Pierwszy za %d s. Wyjscie z areny przerywa walke.", #waves, NEXT_WAVE_DELAY / 1000))
	addEvent(spawnWave, NEXT_WAVE_DELAY, player:getId(), token, 1)
end

function OtsSoulWarDone(player)
	return player:soulWarQuestKV():get("final-reward") and true or false
end
