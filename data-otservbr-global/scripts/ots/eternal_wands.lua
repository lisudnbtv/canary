-- OTS: rozdzki Eternal ze sklepu strzelaja obszarowo, jak diamond arrow paladyna:
-- kazdy strzal trafia cel i wszystkie potwory w romb 5x5 wokol niego.
-- Zastepuje zwykla obsluge rozdzki z items.xml (ten sam poziom, mana, profesje i obrazenia 200-235).

local area = createCombatArea({
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 3, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
})

local MIN_DAMAGE, MAX_DAMAGE = 200, 235

local function wandValues(player, level, maglevel)
	return -MIN_DAMAGE, -MAX_DAMAGE
end

local wands = {
	{ id = 60020, name = "OtsEternalArcaneWand", combat = COMBAT_FIREDAMAGE, effect = CONST_ME_FIREAREA, shoot = CONST_ANI_FIRE, vocations = { "Sorcerer", "Master Sorcerer" } },
	{ id = 60026, name = "OtsEternalNatureRod", combat = COMBAT_EARTHDAMAGE, effect = CONST_ME_SMALLPLANTS, shoot = CONST_ANI_EARTH, vocations = { "Druid", "Elder Druid" } },
}

for _, config in ipairs(wands) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, config.combat)
	combat:setParameter(COMBAT_PARAM_EFFECT, config.effect)
	combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, config.shoot)
	combat:setArea(area)
	-- silnik zabiera globalna funkcje przy setCallback, wiec kazda rozdzka dostaje wlasna nazwe
	_G[config.name] = wandValues
	combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, config.name)

	local wand = Weapon(WEAPON_WAND)

	function wand.onUseWeapon(player, variant)
		return combat:execute(player, variant)
	end

	wand:id(config.id)
	wand:level(100)
	wand:mana(30)
	wand:damage(MIN_DAMAGE, MAX_DAMAGE)
	wand:shootType(config.shoot)
	wand:wieldUnproperly(true)
	for index, vocation in ipairs(config.vocations) do
		wand:vocation(vocation, index == 1, index == #config.vocations)
	end
	wand:register()
end
