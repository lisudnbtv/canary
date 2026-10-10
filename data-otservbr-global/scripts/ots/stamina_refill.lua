-- OTS: Full Stamina Refill - przedmiot ze sklepu (stamina extension). Uzycie przywraca
-- pelna stamine (42 godziny) i zuzywa przedmiot.
local ITEM_ID = 36725 -- stamina extension
local FULL_STAMINA_MINUTES = 42 * 60

local refill = Action()

function refill.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStamina() >= FULL_STAMINA_MINUTES then
		player:sendCancelMessage("Masz juz pelna stamine.")
		return true
	end
	player:setStamina(FULL_STAMINA_MINUTES)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Stamina uzupelniona do pelna (42 godziny).")
	item:remove(1)
	return true
end

refill:id(ITEM_ID)
refill:register()
