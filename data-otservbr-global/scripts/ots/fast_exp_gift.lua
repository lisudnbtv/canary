-- OTS: jednorazowy prezent - postac Lisman dostaje fast exp token (wstep do sali FAST EXP w hubie).
local gift = CreatureEvent("OtsFastExpGift")

function gift.onLogin(player)
	if player:getName():lower() ~= "lisman" then
		return true
	end
	local store = player:kv():scoped("ots-fast-exp")
	if store:get("gift") then
		return true
	end
	store:set("gift", true)
	player:addItem(60106, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Otrzymales fast exp token - trzymaj go w plecaku, zeby wejsc do sali FAST EXP w hubie.")
	return true
end

gift:register()
