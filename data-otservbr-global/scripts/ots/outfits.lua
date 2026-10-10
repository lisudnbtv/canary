-- OTS: bonusy za stroje (outfity).
-- Kazdy stroj daje ten sam komplet bonusow; kazdy zalozony dodatek (addon) go zwieksza:
-- bez dodatkow x1, jeden dodatek x2, oba dodatki x3.
-- Bonusy dzialaja, dopoki stroj jest zalozony, i wracaja po zalogowaniu.
-- Komenda !outfit pokazuje aktualne wartosci.

local SUBID = 64990

-- Wartosci na jeden poziom (poziom = 1 + liczba dodatkow).
local PER_LEVEL = {
	health = 10, -- HP co 2 sekundy
	mana = 10, -- many co 2 sekundy
	melee = 3, -- sword, axe, club
	distance = 3,
	shield = 3,
	magic = 1,
	speed = 20,
	lifeLeech = 300, -- w setnych procenta: 300 = 3% zadanych obrazen
	manaLeech = 200,
}

-- Stroje objete bonusem (wyglad -> nazwa).
local outfits = {
	[136] = { name = "Citizen" },
	[137] = { name = "Hunter" },
	[138] = { name = "Mage" },
	[139] = { name = "Knight" },
	[140] = { name = "Noblewoman" },
	[141] = { name = "Summoner" },
	[142] = { name = "Warrior" },
	[147] = { name = "Barbarian" },
	[148] = { name = "Druid" },
	[149] = { name = "Wizard" },
	[150] = { name = "Oriental" },
	[155] = { name = "Pirate" },
	[156] = { name = "Assassin" },
	[157] = { name = "Beggar" },
	[158] = { name = "Shaman" },
	[252] = { name = "Norsewoman" },
	[269] = { name = "Nightmare" },
	[270] = { name = "Jester" },
	[279] = { name = "Brotherhood" },
	[288] = { name = "Demon Hunter" },
	[324] = { name = "Yalaharian" },
	[329] = { name = "Newly Wed" },
	[336] = { name = "Warmaster" },
	[366] = { name = "Wayfarer" },
	[431] = { name = "Afflicted" },
	[433] = { name = "Elementalist" },
	[464] = { name = "Deepling" },
	[466] = { name = "Insectoid" },
	[471] = { name = "Entrepreneur" },
	[513] = { name = "Crystal Warlord" },
	[514] = { name = "Soil Guardian" },
	[542] = { name = "Demon" },
	[575] = { name = "Cave Explorer" },
	[578] = { name = "Dream Warden" },
	[618] = { name = "Glooth Engineer" },
	[620] = { name = "Jersey" },
	[632] = { name = "Champion" },
	[635] = { name = "Conjurer" },
	[636] = { name = "Beastmaster" },
	[664] = { name = "Chaos Acolyte" },
	[666] = { name = "Death Herald" },
	[683] = { name = "Ranger" },
	[694] = { name = "Ceremonial Garb" },
	[696] = { name = "Puppeteer" },
	[698] = { name = "Spirit Caller" },
	[724] = { name = "Evoker" },
	[732] = { name = "Seaweaver" },
	[745] = { name = "Recruiter" },
	[749] = { name = "Sea Dog" },
	[759] = { name = "Royal Pumpkin" },
	[845] = { name = "Rift Warrior" },
	[852] = { name = "Winter Warden" },
	[874] = { name = "Philosopher" },
	[885] = { name = "Arena Champion" },
	[900] = { name = "Lupine Warden" },
	[909] = { name = "Grove Keeper" },
	[929] = { name = "Festive" },
	[956] = { name = "Pharaoh" },
	[958] = { name = "Trophy Hunter" },
	[963] = { name = "Retro Warrior" },
	[965] = { name = "Retro Summoner" },
	[967] = { name = "Retro Noblewoman" },
	[969] = { name = "Retro Mage" },
	[971] = { name = "Retro Knight" },
	[973] = { name = "Retro Hunter" },
	[975] = { name = "Retro Citizen" },
	[1020] = { name = "Herbalist" },
	[1024] = { name = "Sun Priest" },
	[1043] = { name = "Makeshift Warrior" },
	[1050] = { name = "Siege Master" },
	[1057] = { name = "Mercenary" },
	[1070] = { name = "Battle Mage" },
	[1095] = { name = "Discoverer" },
	[1103] = { name = "Sinister Archer" },
	[1128] = { name = "Pumpkin Mummy" },
	[1147] = { name = "Dream Warrior" },
	[1162] = { name = "Percht Raider" },
	[1174] = { name = "Owl Keeper" },
	[1187] = { name = "Guidon Bearer" },
	[1203] = { name = "Void Master" },
	[1205] = { name = "Veteran Paladin" },
	[1207] = { name = "Lion of War" },
	[1211] = { name = "Golden" },
	[1244] = { name = "Hand of the Inquisition" },
	[1246] = { name = "Breezy Garb" },
	[1252] = { name = "Orcsoberfest Garb" },
	[1271] = { name = "Poltergeist" },
	[1280] = { name = "Herder" },
	[1283] = { name = "Falconer" },
	[1289] = { name = "Dragon Slayer" },
	[1293] = { name = "Trailblazer" },
	[1323] = { name = "Revenant" },
	[1332] = { name = "Jouster" },
	[1339] = { name = "Moth Cape" },
	[1372] = { name = "Rascoohan" },
	[1383] = { name = "Merry Garb" },
	[1385] = { name = "Rune Master" },
	[1387] = { name = "Citizen of Issavi" },
	[1416] = { name = "Forest Warden" },
	[1437] = { name = "Royal Bounacean Advisor" },
	[1445] = { name = "Dragon Knight" },
	[1450] = { name = "Arbalester" },
	[1456] = { name = "Royal Costume" },
	[1461] = { name = "Formal Dress" },
	[1490] = { name = "Ghost Blade" },
	[1501] = { name = "Nordic Chieftain" },
	[1569] = { name = "Fire-Fighter" },
	[1576] = { name = "Fencer" },
	[1582] = { name = "Shadowlotus Disciple" },
	[1598] = { name = "Ancient Aucar" },
	[1613] = { name = "Frost Tracer" },
	[1619] = { name = "Armoured Archer" },
	[1663] = { name = "Decaying Defender" },
	[1676] = { name = "Darklight Evoker" },
	[1681] = { name = "Flamefury Mage" },
	[1714] = { name = "Doom Knight" },
	[1723] = { name = "Draccoon Herald" },
	[1726] = { name = "Celestial Avenger" },
	[1746] = { name = "Blade Dancer" },
	[1775] = { name = "Rootwalker" },
	[1777] = { name = "Beekeeper" },
	[1808] = { name = "Fiend Slayer" },
	[1832] = { name = "Winged Druid" },
	[1825] = { name = "Monk" },
	[1838] = { name = "Martial Artist" },
	[1861] = { name = "Illuminator" },
	[128] = { name = "Citizen" },
	[129] = { name = "Hunter" },
	[130] = { name = "Mage" },
	[131] = { name = "Knight" },
	[132] = { name = "Nobleman" },
	[133] = { name = "Summoner" },
	[134] = { name = "Warrior" },
	[143] = { name = "Barbarian" },
	[144] = { name = "Druid" },
	[145] = { name = "Wizard" },
	[146] = { name = "Oriental" },
	[151] = { name = "Pirate" },
	[152] = { name = "Assassin" },
	[153] = { name = "Beggar" },
	[154] = { name = "Shaman" },
	[251] = { name = "Norseman" },
	[268] = { name = "Nightmare" },
	[273] = { name = "Jester" },
	[278] = { name = "Brotherhood" },
	[289] = { name = "Demon Hunter" },
	[325] = { name = "Yalaharian" },
	[328] = { name = "Newly Wed" },
	[335] = { name = "Warmaster" },
	[367] = { name = "Wayfarer" },
	[430] = { name = "Afflicted" },
	[432] = { name = "Elementalist" },
	[463] = { name = "Deepling" },
	[465] = { name = "Insectoid" },
	[472] = { name = "Entrepreneur" },
	[512] = { name = "Crystal Warlord" },
	[516] = { name = "Soil Guardian" },
	[541] = { name = "Demon" },
	[574] = { name = "Cave Explorer" },
	[577] = { name = "Dream Warden" },
	[610] = { name = "Glooth Engineer" },
	[619] = { name = "Jersey" },
	[633] = { name = "Champion" },
	[634] = { name = "Conjurer" },
	[637] = { name = "Beastmaster" },
	[665] = { name = "Chaos Acolyte" },
	[667] = { name = "Death Herald" },
	[684] = { name = "Ranger" },
	[695] = { name = "Ceremonial Garb" },
	[697] = { name = "Puppeteer" },
	[699] = { name = "Spirit Caller" },
	[725] = { name = "Evoker" },
	[733] = { name = "Seaweaver" },
	[746] = { name = "Recruiter" },
	[750] = { name = "Sea Dog" },
	[760] = { name = "Royal Pumpkin" },
	[846] = { name = "Rift Warrior" },
	[853] = { name = "Winter Warden" },
	[873] = { name = "Philosopher" },
	[884] = { name = "Arena Champion" },
	[899] = { name = "Lupine Warden" },
	[908] = { name = "Grove Keeper" },
	[931] = { name = "Festive" },
	[955] = { name = "Pharaoh" },
	[957] = { name = "Trophy Hunter" },
	[962] = { name = "Retro Warrior" },
	[964] = { name = "Retro Summoner" },
	[966] = { name = "Retro Nobleman" },
	[968] = { name = "Retro Mage" },
	[970] = { name = "Retro Knight" },
	[972] = { name = "Retro Hunter" },
	[974] = { name = "Retro Citizen" },
	[1021] = { name = "Herbalist" },
	[1023] = { name = "Sun Priest" },
	[1042] = { name = "Makeshift Warrior" },
	[1051] = { name = "Siege Master" },
	[1056] = { name = "Mercenary" },
	[1069] = { name = "Battle Mage" },
	[1094] = { name = "Discoverer" },
	[1102] = { name = "Sinister Archer" },
	[1127] = { name = "Pumpkin Mummy" },
	[1146] = { name = "Dream Warrior" },
	[1161] = { name = "Percht Raider" },
	[1173] = { name = "Owl Keeper" },
	[1186] = { name = "Guidon Bearer" },
	[1202] = { name = "Void Master" },
	[1204] = { name = "Veteran Paladin" },
	[1206] = { name = "Lion of War" },
	[1210] = { name = "Golden" },
	[1243] = { name = "Hand of the Inquisition" },
	[1245] = { name = "Breezy Garb" },
	[1251] = { name = "Orcsoberfest Garb" },
	[1270] = { name = "Poltergeist" },
	[1279] = { name = "Herder" },
	[1282] = { name = "Falconer" },
	[1288] = { name = "Dragon Slayer" },
	[1292] = { name = "Trailblazer" },
	[1322] = { name = "Revenant" },
	[1331] = { name = "Jouster" },
	[1338] = { name = "Moth Cape" },
	[1371] = { name = "Rascoohan" },
	[1382] = { name = "Merry Garb" },
	[1384] = { name = "Rune Master" },
	[1386] = { name = "Citizen of Issavi" },
	[1415] = { name = "Forest Warden" },
	[1436] = { name = "Royal Bounacean Advisor" },
	[1444] = { name = "Dragon Knight" },
	[1449] = { name = "Arbalester" },
	[1457] = { name = "Royal Costume" },
	[1460] = { name = "Formal Dress" },
	[1489] = { name = "Ghost Blade" },
	[1500] = { name = "Nordic Chieftain" },
	[1568] = { name = "Fire-Fighter" },
	[1575] = { name = "Fencer" },
	[1581] = { name = "Shadowlotus Disciple" },
	[1597] = { name = "Ancient Aucar" },
	[1612] = { name = "Frost Tracer" },
	[1618] = { name = "Armoured Archer" },
	[1662] = { name = "Decaying Defender" },
	[1675] = { name = "Darklight Evoker" },
	[1680] = { name = "Flamefury Mage" },
	[1713] = { name = "Doom Knight" },
	[1722] = { name = "Draccoon Herald" },
	[1725] = { name = "Celestial Avenger" },
	[1745] = { name = "Blade Dancer" },
	[1774] = { name = "Rootwalker" },
	[1776] = { name = "Beekeeper" },
	[1809] = { name = "Fiend Slayer" },
	[1831] = { name = "Winged Druid" },
	[1824] = { name = "Monk" },
	[1837] = { name = "Martial Artist" },
	[1860] = { name = "Illuminator" },
}

local function levelOf(addons)
	local level = 1
	if addons == 1 or addons == 2 then
		level = 2
	elseif addons >= 3 then
		level = 3
	end
	return level
end

local function describe(lookType, addons)
	local outfit = outfits[lookType]
	if not outfit then
		return nil
	end
	local level = levelOf(addons)
	local p = PER_LEVEL
	return string.format(
		"%s (poziom %d/3): +%d HP i +%d many co 2 s, +%d walka wrecz, +%d distance, +%d shielding, +%d magic level, +%d szybkosci, life leech %d%%, mana leech %d%%",
		outfit.name,
		level,
		p.health * level,
		p.mana * level,
		p.melee * level,
		p.distance * level,
		p.shield * level,
		p.magic * level,
		p.speed * level,
		p.lifeLeech * level / 100,
		p.manaLeech * level / 100
	)
end

local function clear(player)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, SUBID)
	-- osobny warunek na leech z poprzedniej wersji skryptu
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID + 1)
end

local function apply(player, lookType, addons)
	clear(player)

	if not outfits[lookType] then
		return false
	end

	local level = levelOf(addons)
	local p = PER_LEVEL

	local skills = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	skills:setParameter(CONDITION_PARAM_SUBID, SUBID)
	skills:setParameter(CONDITION_PARAM_TICKS, -1)
	skills:setParameter(CONDITION_PARAM_SKILL_MELEE, p.melee * level)
	skills:setParameter(CONDITION_PARAM_SKILL_DISTANCE, p.distance * level)
	skills:setParameter(CONDITION_PARAM_SKILL_SHIELD, p.shield * level)
	skills:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, p.magic * level)
	skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
	skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, p.lifeLeech * level)
	skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
	skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, p.manaLeech * level)
	player:addCondition(skills)

	local regeneration = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	regeneration:setParameter(CONDITION_PARAM_SUBID, SUBID)
	regeneration:setParameter(CONDITION_PARAM_TICKS, -1)
	regeneration:setParameter(CONDITION_PARAM_HEALTHGAIN, p.health * level)
	regeneration:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)
	regeneration:setParameter(CONDITION_PARAM_MANAGAIN, p.mana * level)
	regeneration:setParameter(CONDITION_PARAM_MANATICKS, 2000)
	player:addCondition(regeneration)

	local haste = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
	haste:setParameter(CONDITION_PARAM_SUBID, SUBID)
	haste:setParameter(CONDITION_PARAM_TICKS, -1)
	haste:setParameter(CONDITION_PARAM_SPEED, p.speed * level)
	player:addCondition(haste)
	return true
end

-- Zmiana stroju: bonusy przeliczone na nowo.
local change = EventCallback("OtsOutfitBonusOnChange")

function change.creatureOnChangeOutfit(creature, outfit)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if apply(player, outfit.lookType, outfit.lookAddons or 0) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus stroju - " .. describe(outfit.lookType, outfit.lookAddons or 0))
	end
	return true
end

change:register()

-- Logowanie: przywroc bonusy aktualnego stroju.
local login = EventCallback("OtsOutfitBonusOnLogin")

function login.playerOnLoginComplete(player)
	local outfit = player:getOutfit()
	apply(player, outfit.lookType, outfit.lookAddons or 0)
end

login:register()

local command = TalkAction("!outfit")

function command.onSay(player, words, param)
	local outfit = player:getOutfit()
	local text = describe(outfit.lookType, outfit.lookAddons or 0)
	if text then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus stroju - " .. text .. ". Kazdy dodatek zwieksza bonusy.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ten stroj nie ma bonusu.")
	end
	return true
end

command:groupType("normal")
command:register()
