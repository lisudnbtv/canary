local SPELL_BASE_POWER_CENTER = 48

-- OTS: obszar jak exevo mas san (kolo 3x3 wokol monka, bez kierunku) i mocniejsze obrazenia
local DAMAGE_MULTIPLIER = 1.5

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLOW_WHITE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local function calculateSweepingDamage(player, skill, attack, basePower)
	local levelBasedDmg = player:calculateFlatDamageHealing()

	local skillBonus = 0
	local delta = skill - 110
	local deltaSq = delta * delta

	if skill > 250 then
		skillBonus = deltaSq * 0.043
	elseif skill > 230 then
		skillBonus = deltaSq * 0.039
	elseif skill > 210 then
		skillBonus = deltaSq * 0.037
	elseif skill > 190 then
		skillBonus = deltaSq * 0.035
	elseif skill > 160 then
		skillBonus = deltaSq * 0.033
	elseif skill > 140 then
		skillBonus = deltaSq * 0.029
	elseif skill > 130 then
		skillBonus = deltaSq * 0.026
	elseif skill > 120 then
		skillBonus = deltaSq * 0.024
	elseif skill > 110 then
		skillBonus = deltaSq * 0.022
	end

	local baseDamage = skill * attack * basePower / 1000 + levelBasedDmg + skillBonus

	return player:getHarmonyDamage(baseDamage * 1.3, baseDamage * 1.7)
end

function onGetFormulaValuesSweeping(player, skill, attack, factor)
	local min, max = calculateSweepingDamage(player, skill, attack, SPELL_BASE_POWER_CENTER)
	return min * DAMAGE_MULTIPLIER, max * DAMAGE_MULTIPLIER
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesSweeping")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(294)
spell:name("Sweeping Takedown")
spell:words("exori mas nia")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_BRUTAL_STRIKE)
spell:level(60)
spell:mana(210)
spell:isPremium(true)
spell:needTarget(false)
spell:isSelfTarget(true)
spell:cooldown(4 * 1000) -- OTS: jak exevo mas san (bylo 8 s)
spell:groupCooldown(2 * 1000)

spell:monkSpellType(MonkSpell_Spender)
spell:vocation("monk;true", "exalted monk;true")
spell:register()
