local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
-- OTS: obszar jak exevo mas san (kolo 3x3 wokol rycerza) i mocniejsze obrazenia
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()

	local min = (level / 3) + (skill + 2 * attack) * 2
	local max = (level / 3) + (skill + 2 * attack) * 4.5

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(105)
spell:name("Fierce Berserk")
spell:words("exori gran")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(90)
spell:mana(340)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(4 * 1000) -- OTS: jak exevo mas san (bylo 6 s)
spell:groupCooldown(2 * 1000)

spell:vocation("knight;true", "elite knight;true")
spell:register()
