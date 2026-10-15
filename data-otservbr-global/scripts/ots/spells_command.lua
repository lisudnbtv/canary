-- OTS: !spells - lista czarow profesji gracza (slowa, nazwa, poziom, mana), posortowana po poziomie.
-- Czary pogrupowane wedlug wymaganego poziomu (naglowek "Level X").

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
	local currentLevel = nil
	for _, spell in ipairs(spells) do
		if spell.level ~= currentLevel then
			currentLevel = spell.level
			lines[#lines + 1] = ""
			lines[#lines + 1] = string.format("Level %d%s", currentLevel, currentLevel > level and " (jeszcze niedostepne)" or ":")
		end
		local note = ""
		if spell.mlevel > magicLevel then
			note = " (od " .. spell.mlevel .. " mlvl)"
		end
		if spell.level <= level and spell.mlevel <= magicLevel then
			available = available + 1
		end
		lines[#lines + 1] = string.format("  %s - %s, mana %s%s", spell.words, spell.name, manaText(spell), note)
	end
	lines[2] = string.format("Dostepne teraz: %d z %d", available, #spells)

	player:showTextDialog(BOOK_ID, table.concat(lines, "\n"))
	return true
end

talk:groupType("normal")
talk:register()
