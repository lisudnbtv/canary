-- OTS: balans leecha. Life leech i mana leech dopelniaja tylko do 80% maksymalnego HP / many.
-- Powyzej tego progu leczy juz tylko to, co gracz robi sam: czary i potiony.
-- Leech rozpoznajemy po tym, ze silnik wysyla go bez sprawcy (attacker == nil) z ORIGIN_SPELL;
-- czary lecznicze maja sprawce, a potiony inne pochodzenie.
local LEECH_CAP = 0.80

-- Mana z potionow i skryptow idzie przez doTargetCombatMana bez sprawcy i domyslnie tez z ORIGIN_SPELL,
-- wiec wygladalaby jak leech. Nadajemy jej inne pochodzenie, zeby limit jej nie dotyczyl.
local rawTargetCombatMana = doTargetCombatMana
function doTargetCombatMana(cid, target, min, max, effect, origin)
	return rawTargetCombatMana(cid, target, min, max, effect, origin or ORIGIN_CONDITION)
end

local function capped(amount, current, maximum)
	local room = math.floor(maximum * LEECH_CAP) - current
	if room <= 0 then
		return 0
	end
	return math.min(amount, room)
end

local health = CreatureEvent("OtsLeechCapHealth")

function health.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not attacker and primaryType == COMBAT_HEALING and origin == ORIGIN_SPELL and creature:isPlayer() then
		local sign = primaryDamage < 0 and -1 or 1
		primaryDamage = sign * capped(math.abs(primaryDamage), creature:getHealth(), creature:getMaxHealth())
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

health:register()

local mana = CreatureEvent("OtsLeechCapMana")

function mana.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not attacker and origin == ORIGIN_SPELL and primaryDamage > 0 and creature:isPlayer() then
		primaryDamage = capped(primaryDamage, creature:getMana(), creature:getMaxMana())
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

mana:register()

local login = CreatureEvent("OtsLeechCapLogin")

function login.onLogin(player)
	player:registerEvent("OtsLeechCapHealth")
	player:registerEvent("OtsLeechCapMana")
	return true
end

login:register()
