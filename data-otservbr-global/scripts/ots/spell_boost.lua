-- OTS: mocniejsze czary bojowe graczy.
-- Obrazenia z czarow i run rzucanych przez gracza sa mnozone przez MULTIPLIER.
-- Nie dotyczy leczenia, zwyklych atakow bronia ani obrazen rozlozonych w czasie (ogien, trucizna).

local MULTIPLIER = 3

local boost = EventCallback("OtsSpellDamageBoost")

function boost.creatureOnCombat(caster, target, damage)
	if not caster or not damage or damage.origin ~= ORIGIN_SPELL then
		return
	end
	if type(caster.isPlayer) ~= "function" or not caster:isPlayer() then
		return
	end

	for _, entry in ipairs({ damage.primary, damage.secondary }) do
		-- wartosc ujemna = obrazenia, dodatnia = leczenie
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.value = entry.value * MULTIPLIER
		end
	end
end

boost:register()
