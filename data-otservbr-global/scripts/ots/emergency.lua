-- OTS: awaryjny powrot do swiatyni w Thais (!ratunek), dziala wszedzie, takze w trakcie walki.
-- Trzeba odczekac 5 s bez ruszania sie z miejsca; ruch przerywa odliczanie.
-- Odroczone wywolania niosa tylko id gracza, pozycje startowa i numer proby.
local WAIT_SECONDS = 5
local COOLDOWN_SECONDS = 30
local THAIS_TOWN_ID = 8

local attempts = {} -- id gracza -> numer aktualnej proby
local lastUse = {} -- id gracza -> czas ostatniego uzycia

local function samePosition(a, b)
	return a.x == b.x and a.y == b.y and a.z == b.z
end

local function countdown(playerId, start, attempt, left)
	if attempts[playerId] ~= attempt then
		return
	end
	local player = Player(playerId)
	if not player then
		attempts[playerId] = nil
		return
	end
	if not samePosition(player:getPosition(), start) then
		attempts[playerId] = nil
		player:sendCancelMessage("Ratunek przerwany - ruszyles sie.")
		return
	end
	if left > 0 then
		player:sendTextMessage(MESSAGE_STATUS, string.format("Ratunek za %d s - nie ruszaj sie.", left))
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		addEvent(countdown, 1000, playerId, start, attempt, left - 1)
		return
	end
	attempts[playerId] = nil
	local town = Town(THAIS_TOWN_ID)
	local temple = town and town:getTemplePosition() or player:getTown():getTemplePosition()
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(temple)
	temple:sendMagicEffect(CONST_ME_TELEPORT)
	lastUse[playerId] = os.time()
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ratunek: jestes w swiatyni w Thais.")
end

local command = TalkAction("!ratunek", "!temple")

function command.onSay(player, words, param)
	local id = player:getId()
	local wait = (lastUse[id] or 0) + COOLDOWN_SECONDS - os.time()
	if wait > 0 then
		player:sendCancelMessage(string.format("Ratunek mozna uzyc ponownie za %d s.", wait))
		return true
	end
	if attempts[id] then
		player:sendCancelMessage("Ratunek juz trwa - nie ruszaj sie.")
		return true
	end
	local attempt = os.time() * 1000 + math.random(999)
	attempts[id] = attempt
	countdown(id, player:getPosition(), attempt, WAIT_SECONDS)
	return true
end

command:groupType("normal")
command:register()
