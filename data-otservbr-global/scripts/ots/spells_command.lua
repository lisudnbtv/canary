-- OTS: !spells - lista czarow profesji gracza (slowa, nazwa, poziom, mana), posortowana po poziomie.
-- Czary z poziomem do osiagniecia sa oznaczone "(od X lvl)", juz dostepne bez dopisku.

local BOOK_ID = 3059 -- wyglad okna: spellbook

local function manaText(spell)
	if spell.manapercent > 0 then
		return spell.manapercent .. "%"
	end
	return tostring(spell.mana)
end

local talk = TalkAction("!spells")

function talk.onSay(player, words, param)
	local level = player:getLevel()
	local magicLevel = player:getMagicLevel()
	local spells = player:getInstantSpells()

	table.sort(spells, function(a, b)
		if a.level ~= b.level then
			return a.level < b.level
		end
		if a.mlevel ~= b.mlevel then
			return a.mlevel < b.mlevel
		end
		return a.name < b.name
	end)

	local lines = { string.format("Czary: %s (poziom %d, magic level %d)", player:getVocation():getName(), level, magicLevel), "" }
	local available = 0
	for _, spell in ipairs(spells) do
		local missing = {}
		if spell.level > level then
			missing[#missing + 1] = "od " .. spell.level .. " lvl"
		end
		if spell.mlevel > magicLevel then
			missing[#missing + 1] = "od " .. spell.mlevel .. " mlvl"
		end
		if #missing == 0 then
			available = available + 1
		end
		lines[#lines + 1] = string.format("%s - %s, mana %s%s", spell.words, spell.name, manaText(spell), #missing > 0 and (" (" .. table.concat(missing, ", ") .. ")") or "")
	end
	lines[2] = string.format("Dostepne teraz: %d z %d", available, #spells)

	player:showTextDialog(BOOK_ID, table.concat(lines, "\n"))
	return true
end

talk:groupType("normal")
talk:register()
