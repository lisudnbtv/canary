-- OTS (tymczasowo): diagnostyka liczenia bestiariusza dla Apparitions z Soul War.
-- Po zabiciu pokazuje graczowi numer rasy i stan licznika (od razu i chwile pozniej) oraz zapisuje to w logu.
local WATCH = {
	["monk's apparition"] = true,
	["knight's apparition"] = true,
}
local STORAGE_BASE = 61305000

local function report(playerId, name, race, before)
	local player = Player(playerId)
	if not player then
		return
	end
	local after = player:getStorageValue(STORAGE_BASE + race)
	local text = string.format("[diag] %s: rasa %d, licznik przed %d, po %d", name, race, before, after)
	player:sendTextMessage(MESSAGE_STATUS, text)
	logger.info("[OTS bestiariusz diag] {} {}", player:getName(), text)
end

local diag = EventCallback("OtsBestiaryDiag")

function diag.playerOnKill(player, monster)
	if not player or not monster then
		return
	end
	local name = monster:getName()
	if not WATCH[name:lower()] then
		return
	end
	local mtype = monster:getType()
	local race = mtype and mtype:raceId() or 0
	local before = player:getStorageValue(STORAGE_BASE + race)
	addEvent(report, 200, player:getId(), name, race, before)
end

diag:register()
