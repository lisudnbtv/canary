local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- OTS: mocniejsze exura sio - rosnie z magic levelem (i troche z poziomem), ale zawsze co najmniej 5000
local MIN_HEAL = 5000

local function onGetFormulaValues(player, level, magicLevel)
	local min = math.max(MIN_HEAL, level * 0.5 + magicLevel * 40)
	local max = math.max(math.floor(MIN_HEAL * 1.25), level * 0.5 + magicLevel * 55)
	return min, max
end

_G.OtsHealFriendValues = onGetFormulaValues
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "OtsHealFriendValues")

local spell = Spell("instant")

-- OTS: przy wysokich poziomach liczy sie tez % zycia leczonego: co najmniej 25-35% jego maksymalnego zycia
local PERCENT_MIN, PERCENT_MAX = 0.25, 0.35

function spell.onCastSpell(creature, variant)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	local target = Creature(variant:getNumber())
	if target and target:isPlayer() and creature:isPlayer() then
		local level, magic = creature:getLevel(), creature:getMagicLevel()
		local min, max = onGetFormulaValues(creature, level, magic)
		min = math.max(min, math.floor(target:getMaxHealth() * PERCENT_MIN))
		max = math.max(max, math.floor(target:getMaxHealth() * PERCENT_MAX))
		doTargetCombatHealth(creature, target, COMBAT_HEALING, min, max, CONST_ME_MAGIC_GREEN, ORIGIN_SPELL, "Heal Friend")
		target:removeCondition(CONDITION_PARALYZE)
		return true
	end
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
