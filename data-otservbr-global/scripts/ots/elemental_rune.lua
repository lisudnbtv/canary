-- OTS: Elemental Storm Rune (sklep). Dla kazdej profesji od 2500 poziomu, jedno uzycie na sztuke.
-- Wybucha wokol gracza w zasiegu jak UE (kolo 6x6) i uderza naraz ogniem, lodem, energia, ziemia,
-- smiercia, swietoscia i fizycznie, wiec trafia kazdego potwora niezaleznie od jego odpornosci.
-- Obrazenia licza sie z poziomu i magic levelu, tak samo dla wszystkich profesji.
-- Przedmiot: items.xml (id 60101), wyglad w appearances.dat (tools/ots/ots_runes.py).

local RUNE_ID = 60101
local LEVEL = 2500

local elements = {
	{ COMBAT_FIREDAMAGE, CONST_ME_FIREAREA },
	{ COMBAT_ICEDAMAGE, CONST_ME_ICEAREA },
	{ COMBAT_ENERGYDAMAGE, CONST_ME_BIGCLOUDS },
	{ COMBAT_EARTHDAMAGE, CONST_ME_SMALLPLANTS },
	{ COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA },
	{ COMBAT_HOLYDAMAGE, CONST_ME_HOLYAREA },
	{ COMBAT_PHYSICALDAMAGE, CONST_ME_EXPLOSIONAREA },
}

-- Na kazdy zywiol osobno; razem 7 uderzen.
function onGetElementalStormValues(player, level, maglevel)
	local min = (level * 0.25) + (maglevel * 2)
	local max = (level * 0.4) + (maglevel * 4)
	return -min, -max
end

local combats = {}
for _, element in ipairs(elements) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, element[1])
	combat:setParameter(COMBAT_PARAM_EFFECT, element[2])
	combat:setArea(createCombatArea(AREA_CIRCLE6X6))
	combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetElementalStormValues")
	combats[#combats + 1] = combat
end

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	local center = Variant(creature:getPosition())
	local hit = false
	for _, combat in ipairs(combats) do
		if combat:execute(creature, center) then
			hit = true
		end
	end
	return hit
end

rune:id(16)
rune:group("attack")
rune:name("elemental storm rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:runeId(RUNE_ID)
rune:allowFarUse(true)
rune:charges(1)
rune:level(LEVEL)
rune:magicLevel(0)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(false)
rune:register()
