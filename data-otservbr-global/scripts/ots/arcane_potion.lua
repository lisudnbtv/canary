-- OTS: Ultimate Arcane Potion (sklep) - odpowiednik ultimate spirit potion dla sorcererow i druidow:
-- leczy naraz zycie i mane, z wieksza iloscia many niz ultimate mana potion.
-- Przedmiot: items.xml (id 60102), wyglad w appearances.dat (tools/ots/ots_runes.py).
-- Potiony na serwerze sie nie zuzywaja (removeChargesFromPotions = false).

local POTION_ID = 60102
local LEVEL = 130
local HEALTH = { 500, 700 }
local MANA = { 900, 1100 }
local VOCATIONS = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID }
local DESCRIPTION = "Only sorcerers and druids of level 130 or above may drink this fluid."

local potion = Action()

function potion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) == "userdata" and not target:isPlayer() then
		return false
	end

	if not player:getGroup():getAccess() and (player:getLevel() < LEVEL or not table.contains(VOCATIONS, player:getVocation():getBaseId())) then
		player:say(DESCRIPTION, MESSAGE_POTION)
		return true
	end

	doTargetCombatHealth(player, target, COMBAT_HEALING, HEALTH[1], HEALTH[2], CONST_ME_MAGIC_BLUE)
	doTargetCombatMana(0, target, MANA[1], MANA[2], CONST_ME_MAGIC_BLUE)
	target:say("Aaaah...", MESSAGE_POTION)
	player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ITEM_USE_POTION, player:isInGhostMode() and nil or player)

	if configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
		player:updateSupplyTracker(item)
		item:remove(1)
	end
	return true
end

potion:id(POTION_ID)
potion:register()
