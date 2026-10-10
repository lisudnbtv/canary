-- OTS: Thais Teleport Compass - przedmiot ze sklepu (charged compass). Uzycie przenosi
-- do swiatyni w Thais. Bez limitu uzyc, dziala wszedzie, takze poza PZ i w trakcie walki.
local ITEM_ID = 29292 -- charged compass (niebieski); nieuzywany przez inne skrypty

local compass = Action()

function compass.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local town = Town("Thais")
	local temple = town and town:getTemplePosition()
	if not temple then
		player:sendCancelMessage("Swiatynia w Thais jest niedostepna.")
		return true
	end
	local from = player:getPosition()
	player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	player:teleportTo(temple)
	from:sendMagicEffect(CONST_ME_POFF)
	temple:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

compass:id(ITEM_ID)
compass:register()
