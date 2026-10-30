local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- OTS: mocniejsze leczenie, liczone glownie z poziomu (jak nasze leczenia knighta)
function onGetFormulaValues(player, level, magicLevel)
	local min = level * 2.5 + magicLevel * 40 + 500
	local max = level * 3.2 + magicLevel * 60 + 800
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Salvation")
spell:words("exura gran san")
spell:group("healing")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SALVATION)
spell:id(36)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(60)
spell:mana(210)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
