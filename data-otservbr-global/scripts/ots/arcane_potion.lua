-- OTS: wlasne potiony ze sklepu, leczace naraz zycie i mane (jak ultimate spirit potion):
--  * Ultimate Arcane Potion (60102) - sorcerer i druid, wiecej many,
--  * Ultimate Warrior Potion (60103) - knight i monk, wiecej zycia,
--  * Ultimate Hunter Potion (60104) - paladyn, mocniejszy ultimate spirit potion.
-- Przedmioty: items.xml, wyglad w appearances.dat (tools/ots/ots_runes.py).
-- Potiony na serwerze sie nie zuzywaja (removeChargesFromPotions = false).

local potions = {
	[60102] = {
		health = { 500, 700 },
		mana = { 900, 1100 },
		level = 130,
		vocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID },
		description = "Only sorcerers and druids of level 130 or above may drink this fluid.",
	},
	[60103] = {
		health = { 1100, 1400 },
		mana = { 300, 400 },
		level = 130,
		vocations = { VOCATION.BASE_ID.KNIGHT, VOCATION.BASE_ID.MONK },
		description = "Only knights and monks of level 130 or above may drink this fluid.",
	},
	[60104] = {
		health = { 800, 1000 },
		mana = { 600, 800 },
		level = 130,
		vocations = { VOCATION.BASE_ID.PALADIN },
		description = "Only paladins of level 130 or above may drink this fluid.",
	},
}

local potion = Action()

function potion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) == "userdata" and not target:isPlayer() then
		return false
	end

	local config = potions[item:getId()]
	if not config then
		return false
	end

	if not player:getGroup():getAccess() and (player:getLevel() < config.level or not table.contains(config.vocations, player:getVocation():getBaseId())) then
		player:say(config.description, MESSAGE_POTION)
		return true
	end

	doTargetCombatHealth(player, target, COMBAT_HEALING, config.health[1], config.health[2], CONST_ME_MAGIC_BLUE)
	doTargetCombatMana(0, target, config.mana[1], config.mana[2], CONST_ME_MAGIC_BLUE)
	target:say("Aaaah...", MESSAGE_POTION)
	player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ITEM_USE_POTION, player:isInGhostMode() and nil or player)

	if configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
		player:updateSupplyTracker(item)
		item:remove(1)
	end
	return true
end

for id in pairs(potions) do
	potion:id(id)
end
potion:register()
