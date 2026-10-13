-- OTS: automatyczne podnoszenie limitu pylu kuzni (Increase Dust Limit).
-- !dust on / off / (bez parametru: stan); dziala tez stare !autodust. Gdy wlaczone, co kilka sekund serwer wydaje pyl
-- na kolejne poziomy limitu, dopoki starcza pylu (koszt jak w kuzni: obecny limit - 75).
local KEY = "ots-auto-dust"
local TICK_MS = 5000

local function maxLevel()
	return configManager.getNumber(configKeys.FORGE_MAX_DUST) or 225
end

local function raise(player)
	local raised, spent = 0, 0
	while true do
		local level = player:getForgeDustLevel()
		local cost = math.max(1, level - 75)
		if level >= maxLevel() or player:getForgeDusts() < cost then
			break
		end
		player:removeForgeDusts(cost)
		player:addForgeDustLevel(1)
		raised = raised + 1
		spent = spent + cost
	end
	if raised > 0 then
		player:sendTextMessage(MESSAGE_STATUS, string.format("Auto dust: limit pylu %d (+%d, wydano %d pylu).", player:getForgeDustLevel(), raised, spent))
	end
end

local talk = TalkAction("!dust", "!autodust")

function talk.onSay(player, words, param)
	param = param:lower():gsub("%s", "")
	if param == "on" then
		player:kv():set(KEY, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto dust wlaczony: limit pylu bedzie sam rosl, gdy starczy pylu. Wylaczenie: !dust off")
		raise(player)
	elseif param == "off" then
		player:kv():remove(KEY)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto dust wylaczony.")
	else
		local level = player:getForgeDustLevel()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Auto dust: %s. Pyl %d, limit %d/%d, nastepny poziom kosztuje %d. Uzycie: !dust on / off", player:kv():get(KEY) and "wlaczony" or "wylaczony", player:getForgeDusts(), level, maxLevel(), math.max(1, level - 75)))
	end
	return false
end

talk:separator(" ")
talk:groupType("normal")
talk:register()

local tick = GlobalEvent("OtsAutoDustTick")

function tick.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		if player:kv():get(KEY) then
			raise(player)
		end
	end
	return true
end

tick:interval(TICK_MS)
tick:register()
