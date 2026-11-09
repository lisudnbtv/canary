-- OTS: wlasne potiony ze sklepu, leczace naraz zycie i mane (jak ultimate spirit potion):
--  * Ultimate Arcane Potion (60102) - sorcerer i druid, wiecej many,
--  * Ultimate Warrior Potion (60103) - knight i monk, wiecej zycia,
--  * Ultimate Hunter Potion (60104) - paladyn, mocniejszy ultimate spirit potion.
-- Przedmioty: items.xml, wyglad w appearances.dat (tools/ots/ots_runes.py).
-- Potiony na serwerze sie nie zuzywaja (removeChargesFromPotions = false).
-- Leczenie: wieksza z wartosci - stala (health/mana) albo % maksymalnego zycia/many pijacego
-- (healthPercent/manaPercent), zeby potiony nie slably na wysokich poziomach.

local potions = {
	[60102] = {
		health = { 500, 700 },
		mana = { 900, 1100 },
		-- rosnie z postacia: co najmniej tyle % maksymalnego zycia / many pijacego
		healthPercent = { 5, 7 },
		manaPercent = { 10, 13 },
		level = 130,
		vocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID },
		description = "Only sorcerers and druids of level 130 or above may drink this fluid.",
	},
	[60103] = {
		health = { 1100, 1400 },
		mana = { 300, 400 },
		healthPercent = { 10, 13 },
		manaPercent = { 3, 5 },
		level = 130,
		vocations = { VOCATION.BASE_ID.KNIGHT, VOCATION.BASE_ID.MONK },
		description = "Only knights and monks of level 130 or above may drink this fluid.",
	},
	[60104] = {
		health = { 800, 1000 },
		mana = { 600, 800 },
		healthPercent = { 7, 9 },
		manaPercent = { 7, 9 },
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

	if OtsNoPotions and OtsNoPotions[player:getId()] then
		player:sendCancelMessage("W Wiezy Upadku potiony nie dzialaja.")
		return true
	end

	local config = potions[item:getId()]
	if not config then
		return false
	end

	if not player:getGroup():getAccess() and (player:getLevel() < config.level or not table.contains(config.vocations, player:getVocation():getBaseId())) then
		player:say(config.description, MESSAGE_POTION)
		return true
	end

	local hMin, hMax, mMin, mMax = config.health[1], config.health[2], config.mana[1], config.mana[2]
	if config.healthPercent then
		hMin = math.max(hMin, math.floor(target:getMaxHealth() * config.healthPercent[1] / 100))
		hMax = math.max(hMax, math.floor(target:getMaxHealth() * config.healthPercent[2] / 100))
	end
	if config.manaPercent then
		mMin = math.max(mMin, math.floor(target:getMaxMana() * config.manaPercent[1] / 100))
		mMax = math.max(mMax, math.floor(target:getMaxMana() * config.manaPercent[2] / 100))
	end
	doTargetCombatHealth(player, target, COMBAT_HEALING, hMin, hMax, CONST_ME_MAGIC_BLUE)
	doTargetCombatMana(0, target, mMin, mMax, CONST_ME_MAGIC_BLUE)
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
