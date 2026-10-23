-- OTS: familiar (summon od 200 poziomu) bije wedlug poziomu wlasciciela.
-- Bazowe obrazenia familiara (200-350) sa niewidoczne przy potworach na wysokim poziomie,
-- wiec mnozymy je przez poziom wlasciciela / LEVEL_STEP (najmniej x1).
-- Przy 2500 poziomie: x20, czyli ok. 4000-7000 na uderzenie.
-- Zycie (x5) i czas trwania (30 min) sa w data/libs/functions/player.lua i config-overrides.lua.
local LEVEL_STEP = 125

local boost = EventCallback("OtsFamiliarDamage")

function boost.creatureOnCombat(caster, target, combatDamage)
	if not caster or not combatDamage or type(caster.isMonster) ~= "function" or not caster:isMonster() then
		return
	end
	local master = caster:getMaster()
	if not master or not master:isPlayer() then
		return
	end
	if not caster:getName():lower():find("familiar", 1, true) then
		return
	end
	local multiplier = math.max(1, master:getLevel() / LEVEL_STEP)
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.value = math.floor(entry.value * multiplier)
		end
	end
end

boost:register()
