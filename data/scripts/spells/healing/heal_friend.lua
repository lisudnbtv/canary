local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- OTS: mocniejsze exura sio - rosnie z magic levelem (i troche z poziomem), ale zawsze co najmniej 5000
local MIN_HEAL = 5000

function onGetFormulaValues(player, level, magicLevel)
	local min = math.max(MIN_HEAL, level * 0.5 + magicLevel * 40)
	local max = math.max(math.floor(MIN_HEAL * 1.25), level * 0.5 + magicLevel * 55)
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return combat:execute(creature, variant)
end

spell:name("Heal Friend")
spell:words("exura sio")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HEAL_FRIEND)
spell:id(84)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(18)
spell:mana(120)
spell:needTarget(true)
spell:hasParams(true)
spell:hasPlayerNameParam(true)
spell:allowOnSelf(false)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
