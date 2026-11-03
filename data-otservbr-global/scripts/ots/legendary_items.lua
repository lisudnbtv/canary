-- OTS: przedmioty z Legendarnych Bossow (legendary_bosses.lua):
--  * Heart of Morgaroth (60117) - uzyte na broni do walki wrecz / dystansowej: +3 ataku, najwyzej 5 razy (+15),
--  * Void Lord's Sigil (60123) - aura wokol postaci, ktora go nosi.
local HEART_ID = 60117
local SIGIL_ID = 60123
local HEART_BONUS = 3
local HEART_MAX = 5

local heart = Action()

function heart.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target.isItem or not target:isItem() then
		player:sendCancelMessage("Uzyj serca na broni.")
		return true
	end
	local itemType = ItemType(target:getId())
	if not itemType or itemType:getAttack() <= 0 then
		player:sendCancelMessage("Serce Morgarotha dziala tylko na bronie do walki wrecz i dystansowe.")
		return true
	end
	local used = tonumber(target:getCustomAttribute("ots-heart")) or 0
	if used >= HEART_MAX then
		player:sendCancelMessage(string.format("Ta bron ma juz najwyzszy bonus (+%d ataku).", HEART_BONUS * HEART_MAX))
		return true
	end
	local attack = target:getAttribute(ITEM_ATTRIBUTE_ATTACK)
	if not attack or attack <= 0 then
		attack = itemType:getAttack()
	end
	target:setAttribute(ITEM_ATTRIBUTE_ATTACK, attack + HEART_BONUS)
	target:setCustomAttribute("ots-heart", used + 1)
	item:remove(1)
	player:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Serce Morgarotha wtopilo sie w bron: atak %d (ulepszenie %d/%d).", attack + HEART_BONUS, used + 1, HEART_MAX))
	return true
end

heart:id(HEART_ID)
heart:register()

local aura = GlobalEvent("OtsVoidSigilAura")

function aura.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local necklace = player:getSlotItem(CONST_SLOT_NECKLACE)
		if necklace and necklace:getId() == SIGIL_ID then
			player:getPosition():sendMagicEffect(CONST_ME_PURPLEENERGY)
		end
	end
	return true
end

aura:interval(2000)
aura:register()
