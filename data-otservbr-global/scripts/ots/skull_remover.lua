-- OTS: !skull - usuniecie czaszki (white / red / black) za Tibia Coins, z potwierdzeniem w okienku.
local PRICE = 500

local SKULL_NAMES = {
	[SKULL_YELLOW] = "zolty",
	[SKULL_GREEN] = "zielony",
	[SKULL_WHITE] = "bialy",
	[SKULL_RED] = "czerwony",
	[SKULL_BLACK] = "czarny",
	[SKULL_ORANGE] = "pomaranczowy",
}

local function removeSkull(player)
	local skull = player:getSkull()
	if skull == SKULL_NONE then
		player:sendCancelMessage("Nie masz zadnego skulla.")
		return
	end
	if player:getTibiaCoins() < PRICE then
		player:sendCancelMessage(string.format("Usuniecie skulla kosztuje %d Tibia Coins, a masz %d.", PRICE, player:getTibiaCoins()))
		return
	end
	player:removeTibiaCoins(PRICE)
	player:setSkull(SKULL_NONE)
	player:setSkullTime(0)
	player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Skull usuniety za %d Tibia Coins.", PRICE))
end

local command = TalkAction("!skull")

function command.onSay(player, words, param)
	local skull = player:getSkull()
	if skull == SKULL_NONE then
		player:sendCancelMessage("Nie masz zadnego skulla.")
		return true
	end
	local window = ModalWindow({
		title = "Skull Remover",
		message = string.format("Masz %s skull.\nCzy potwierdzasz checi usuniecia skulla za %d TC?\n(Twoje Tibia Coins: %d)", SKULL_NAMES[skull] or "", PRICE, player:getTibiaCoins()),
	})
	window:addButton("TAK", function(target)
		removeSkull(target)
	end)
	window:addButton("NIE", function() end)
	window:setDefaultEnterButton(1)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
	return true
end

command:groupType("normal")
command:register()
