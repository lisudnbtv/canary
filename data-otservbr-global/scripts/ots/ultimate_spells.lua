-- OTS: czary "ultima" od 4500 poziomu - jeden na profesje, obszar jak UE (kolo 6x6 wokol postaci),
-- zywiol profesji. Sila jak Elemental Storm Rune (ta liczy osobno 7 zywiolow, tu jeden mocny cios):
-- (poziom * 0,25 + mlvl * 2) * 5 do (poziom * 0,4 + mlvl * 4) * 5.
-- Czary uzywaja numeru najwiekszego czaru obszarowego profesji (wspolny czas odnowienia z nim),
-- zeby klient pokazywal ikone i odliczanie bez nieznanych numerow.
local LEVEL = 4500
local MANA = 2000
local COOLDOWN = 1000 -- jak inne czary na serwerze (spell_cooldown.lua: najwyzej 1 s)

local spells = {
	{ words = "exevo ultima san", name = "Ultimate Holy Storm", id = 124, type = COMBAT_HOLYDAMAGE, effect = CONST_ME_HOLYAREA, vocations = { "paladin;true", "royal paladin;true" } },
	{ words = "exori ultima", name = "Ultimate Strike", id = 105, type = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_EXPLOSIONAREA, vocations = { "knight;true", "elite knight;true" } },
	{ words = "exevo ultima flam", name = "Ultimate Firestorm", id = 24, type = COMBAT_FIREDAMAGE, effect = CONST_ME_FIREAREA, vocations = { "sorcerer;true", "master sorcerer;true" } },
	{ words = "exevo ultima frigo", name = "Ultimate Blizzard", id = 118, type = COMBAT_ICEDAMAGE, effect = CONST_ME_ICETORNADO, vocations = { "druid;true", "elder druid;true" } },
	{ words = "exori ultima nia", name = "Ultimate Shockwave", id = 294, type = COMBAT_PHYSICALDAMAGE, effect = CONST_ME_GROUNDSHAKER, vocations = { "monk;true", "exalted monk;true" } },
}

local function ultimateValues(player, level, maglevel)
	local min = (level * 0.25 + maglevel * 2) * 5
	local max = (level * 0.4 + maglevel * 4) * 5
	return -min, -max
end

for index, config in ipairs(spells) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, config.type)
	combat:setParameter(COMBAT_PARAM_EFFECT, config.effect)
	combat:setArea(createCombatArea(AREA_CIRCLE6X6))
	-- silnik zabiera globalna funkcje przy setCallback, wiec kazdy czar ma wlasna nazwe
	local callbackName = "OtsUltimateValues" .. index
	_G[callbackName] = ultimateValues
	combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)

	local spell = Spell("instant")

	function spell.onCastSpell(creature, variant)
		return combat:execute(creature, variant)
	end

	spell:group("attack")
	spell:id(config.id)
	spell:name(config.name)
	spell:words(config.words)
	spell:level(LEVEL)
	spell:mana(MANA)
	spell:isPremium(true)
	spell:isSelfTarget(true)
	spell:cooldown(COOLDOWN)
	spell:groupCooldown(COOLDOWN)
	spell:needLearn(false)
	for _, vocation in ipairs(config.vocations) do
		spell:vocation(vocation)
	end
	spell:register()
end
