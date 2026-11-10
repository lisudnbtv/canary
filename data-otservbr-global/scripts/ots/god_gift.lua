-- OTS: jednorazowy zestaw dla postaci GOD "Lisu": Imbued Backpack (100 miejsc, najwiekszy plecak na serwerze)
-- z wszystkimi wlasnymi przedmiotami OTS, ktorych nie ma w sklepie (fast exp token, amulet czempiona,
-- loot legendarnych bossow, experience stone). Sklepowe (eternal sety, runa, potiony, loot pouch) pominiete.
local OWNER = "lisu"
local KV_KEY = "ots-god-gift"
local BACKPACK = 3253
local ITEMS = {
	60106, -- fast exp token
	60107, -- elemental champion amulet
	60108, 60109, 60110, 60111, -- apocalypse set
	60112, 60113, -- inferno wand, inferno rod
	60114, -- bazir's mask
	60115, -- death amulet
	60116, -- ferumbras' absolute hat
	60117, -- heart of morgaroth
	60118, -- frozen crown
	60119, 60120, 60121, -- ghazbaran's sword / axe / club
	60122, -- pair of plague boots
	60123, -- void lord's sigil
	60124, -- experience stone
}

local gift = CreatureEvent("OtsGodGift")

function gift.onLogin(player)
	if player:getName():lower() ~= OWNER or player:kv():get(KV_KEY) then
		return true
	end
	local backpack = Game.createItem(BACKPACK, 1)
	if not backpack then
		return true
	end
	for _, id in ipairs(ITEMS) do
		backpack:addItem(id, 1)
	end
	if player:addItemEx(backpack, false, CONST_SLOT_BACKPACK) ~= RETURNVALUE_NOERROR then
		player:addItemEx(backpack, true)
	end
	player:kv():set(KV_KEY, true)
	logger.info("[OTS] {}: prezent GOD - plecak z {} przedmiotami (w plecaku: {})", player:getName(), #ITEMS, backpack:getSize())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Otrzymujesz Imbued Backpack z %d wlasnymi przedmiotami OTS.", #ITEMS))
	return true
end

gift:register()
