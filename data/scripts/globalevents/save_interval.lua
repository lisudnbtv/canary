local isSaveScheduled = false

local function serverSave(interval)
	isSaveScheduled = false
	if configManager.getBoolean(configKeys.TOGGLE_SAVE_INTERVAL_CLEAN_MAP) then
		cleanMap()
	end

	saveServer()
	-- OTS: komunikaty po polsku
	local message = string.format("Zapis serwera gotowy, przedmioty z ziemi (poza domami) sprzatniete. Nastepny za %d min.", math.floor(interval / 60000))
	Game.broadcastMessage(message, MESSAGE_GAME_HIGHLIGHT)
	logger.info(message)
	Webhook.sendMessage("Server save", message, WEBHOOK_COLOR_WARNING)
end

local save = GlobalEvent("save")

function save.onTime(interval)
	if not configManager.getBoolean(configKeys.TOGGLE_SAVE_INTERVAL) then
		return true
	end

	if isSaveScheduled then
		return true
	end

	local warningDuration = 60 * 1000
	if interval <= warningDuration then
		serverSave(interval)
		return true
	end

	local warningSeconds = math.floor(warningDuration / 1000)
	local message = "Za " .. warningSeconds .. " s zapis serwera i sprzatanie przedmiotow lezacych na ziemi (poza domami)."
	Game.broadcastMessage(message, MESSAGE_GAME_HIGHLIGHT)
	logger.info(message)
	isSaveScheduled = true
	addEvent(serverSave, warningDuration, interval)

	return true
end

if SAVE_INTERVAL_TIME ~= 0 then
	save:interval(SAVE_INTERVAL_CONFIG_TIME * SAVE_INTERVAL_TIME)
else
	return logger.error(string.format("[save.onTime] - Save interval type '%s' is not valid, use 'second', 'minute' or 'hour'", SAVE_INTERVAL_TYPE))
end

save:register()
