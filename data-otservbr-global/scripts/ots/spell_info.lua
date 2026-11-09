-- OTS: !czary - obrazenia czarow "ultima" (od 4500 poziomu, ultimate_spells.lua) dla tej postaci,
-- z mnoznikiem czarow graczy x3 (spell_boost.lua). Przy logowaniu dane postaci trafiaja tez do logu
-- serwera ("[OTS postac]"), zeby dalo sie policzyc tabelke dla wszystkich postaci.
local SPELL_BOOST = 3
local ULTIMA = {
	[VOCATION.BASE_ID.SORCERER] = { "exevo ultima flam", "ogien" },
	[VOCATION.BASE_ID.DRUID] = { "exevo ultima frigo", "lod" },
	[VOCATION.BASE_ID.PALADIN] = { "exevo ultima san", "swietosc" },
	[VOCATION.BASE_ID.KNIGHT] = { "exori ultima", "fizyczne" },
	[VOCATION.BASE_ID.MONK] = { "exori ultima nia", "fizyczne" },
}

local function ultimaDamage(level, magic)
	local min = (level * 0.25 + magic * 2) * 5 * SPELL_BOOST
	local max = (level * 0.4 + magic * 4) * 5 * SPELL_BOOST
	return math.floor(min), math.floor(max)
end

local function describe(player)
	local level, magic = player:getLevel(), player:getMagicLevel()
	local spell = ULTIMA[player:getVocation():getBaseId()]
	local min, max = ultimaDamage(level, magic)
	return spell, level, magic, min, max
end

local login = CreatureEvent("OtsSpellInfoLogin")

function login.onLogin(player)
	local spell, level, magic, min, max = describe(player)
	logger.info("[OTS postac] {}: {} lvl {}, mlvl {}, zycie {}, mana {}, {} {}-{} (sr. {})", player:getName(), player:getVocation():getName(), level, magic, player:getMaxHealth(), player:getMaxMana(), spell and spell[1] or "-", min, max, math.floor((min + max) / 2))
	return true
end

login:register()

local command = TalkAction("!czary")

function command.onSay(player, words, param)
	local spell, level, magic, min, max = describe(player)
	local lines = {
		string.format("%s - %s, poziom %d, magic level %d", player:getName(), player:getVocation():getName(), level, magic),
		"",
	}
	if not spell then
		lines[#lines + 1] = "Ta profesja nie ma czaru ultima."
	else
		lines[#lines + 1] = string.format("Czar: %s (%s), obszar 6x6 wokol postaci, od 4500 poziomu.", spell[1], spell[2])
		if level < 4500 then
			lines[#lines + 1] = "Jeszcze niedostepny - wymaga 4500 poziomu."
		end
		lines[#lines + 1] = string.format("Obrazenia na kazdego potwora w obszarze: %d - %d (srednio %d).", min, max, math.floor((min + max) / 2))
		lines[#lines + 1] = "(wzor: (poziom x 0,25 + mlvl x 2) x 5 do (poziom x 0,4 + mlvl x 4) x 5, razy 3 za wzmocnienie czarow;"
		lines[#lines + 1] = "przed odpornosciami potwora, bez trafien krytycznych i bonusow z Wheel of Destiny)"
	end
	player:showTextDialog(2814, table.concat(lines, "\n"))
	return true
end

command:groupType("normal")
command:register()
