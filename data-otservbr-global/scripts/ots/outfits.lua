-- OTS: bonusy za stroje (outfity).
-- Kazdy stroj daje jeden bonus; kazdy zalozony dodatek (addon) go zwieksza:
-- bez dodatkow x1, jeden dodatek x2, oba dodatki x3.
-- Bonus dziala, dopoki stroj jest zalozony, i wraca po zalogowaniu.
-- Do tego kazdy stroj daje life leech i mana leech, tez rosnace z dodatkami.
-- Komenda !outfit pokazuje aktualny bonus.

local SUBID = 64990
local LEECH_SUBID = 64991

-- Leech na poziom, w setnych procenta (300 = 3% zadanych obrazen).
local LIFE_LEECH_PER_LEVEL = 300
local MANA_LEECH_PER_LEVEL = 200

-- Wartosc bonusu na jeden poziom (poziom = 1 + liczba dodatkow).
local kinds = {
	health = { perLevel = 10, text = "+%d HP co 2 sekundy" },
	mana = { perLevel = 10, text = "+%d many co 2 sekundy" },
	melee = { perLevel = 3, text = "+%d do walki wrecz (sword, axe, club)" },
	distance = { perLevel = 3, text = "+%d distance" },
	shield = { perLevel = 3, text = "+%d shielding" },
	magic = { perLevel = 1, text = "+%d magic level" },
	speed = { perLevel = 20, text = "+%d szybkosci" },
}

local outfits = {
	[136] = { name = "Citizen", kind = "health" },
	[137] = { name = "Hunter", kind = "distance" },
	[138] = { name = "Mage", kind = "magic" },
	[139] = { name = "Knight", kind = "melee" },
	[140] = { name = "Noblewoman", kind = "health" },
	[141] = { name = "Summoner", kind = "magic" },
	[142] = { name = "Warrior", kind = "melee" },
	[147] = { name = "Barbarian", kind = "melee" },
	[148] = { name = "Druid", kind = "mana" },
	[149] = { name = "Wizard", kind = "magic" },
	[150] = { name = "Oriental", kind = "health" },
	[155] = { name = "Pirate", kind = "melee" },
	[156] = { name = "Assassin", kind = "distance" },
	[157] = { name = "Beggar", kind = "health" },
	[158] = { name = "Shaman", kind = "mana" },
	[252] = { name = "Norsewoman", kind = "mana" },
	[269] = { name = "Nightmare", kind = "melee" },
	[270] = { name = "Jester", kind = "speed" },
	[279] = { name = "Brotherhood", kind = "melee" },
	[288] = { name = "Demon Hunter", kind = "distance" },
	[324] = { name = "Yalaharian", kind = "magic" },
	[329] = { name = "Newly Wed", kind = "melee" },
	[336] = { name = "Warmaster", kind = "melee" },
	[366] = { name = "Wayfarer", kind = "speed" },
	[431] = { name = "Afflicted", kind = "health" },
	[433] = { name = "Elementalist", kind = "magic" },
	[464] = { name = "Deepling", kind = "shield" },
	[466] = { name = "Insectoid", kind = "shield" },
	[471] = { name = "Entrepreneur", kind = "speed" },
	[513] = { name = "Crystal Warlord", kind = "shield" },
	[514] = { name = "Soil Guardian", kind = "shield" },
	[542] = { name = "Demon", kind = "magic" },
	[575] = { name = "Cave Explorer", kind = "speed" },
	[578] = { name = "Dream Warden", kind = "mana" },
	[618] = { name = "Glooth Engineer", kind = "speed" },
	[620] = { name = "Jersey", kind = "distance" },
	[632] = { name = "Champion", kind = "melee" },
	[635] = { name = "Conjurer", kind = "magic" },
	[636] = { name = "Beastmaster", kind = "health" },
	[664] = { name = "Chaos Acolyte", kind = "magic" },
	[666] = { name = "Death Herald", kind = "magic" },
	[683] = { name = "Ranger", kind = "distance" },
	[694] = { name = "Ceremonial Garb", kind = "mana" },
	[696] = { name = "Puppeteer", kind = "magic" },
	[698] = { name = "Spirit Caller", kind = "magic" },
	[724] = { name = "Evoker", kind = "magic" },
	[732] = { name = "Seaweaver", kind = "mana" },
	[745] = { name = "Recruiter", kind = "speed" },
	[749] = { name = "Sea Dog", kind = "speed" },
	[759] = { name = "Royal Pumpkin", kind = "health" },
	[845] = { name = "Rift Warrior", kind = "melee" },
	[852] = { name = "Winter Warden", kind = "mana" },
	[874] = { name = "Philosopher", kind = "magic" },
	[885] = { name = "Arena Champion", kind = "melee" },
	[900] = { name = "Lupine Warden", kind = "mana" },
	[909] = { name = "Grove Keeper", kind = "mana" },
	[929] = { name = "Festive", kind = "magic" },
	[956] = { name = "Pharaoh", kind = "magic" },
	[958] = { name = "Trophy Hunter", kind = "distance" },
	[963] = { name = "Retro Warrior", kind = "melee" },
	[965] = { name = "Retro Summoner", kind = "magic" },
	[967] = { name = "Retro Noblewoman", kind = "health" },
	[969] = { name = "Retro Mage", kind = "magic" },
	[971] = { name = "Retro Knight", kind = "melee" },
	[973] = { name = "Retro Hunter", kind = "distance" },
	[975] = { name = "Retro Citizen", kind = "health" },
	[1020] = { name = "Herbalist", kind = "mana" },
	[1024] = { name = "Sun Priest", kind = "mana" },
	[1043] = { name = "Makeshift Warrior", kind = "melee" },
	[1050] = { name = "Siege Master", kind = "melee" },
	[1057] = { name = "Mercenary", kind = "melee" },
	[1070] = { name = "Battle Mage", kind = "magic" },
	[1095] = { name = "Discoverer", kind = "speed" },
	[1103] = { name = "Sinister Archer", kind = "distance" },
	[1128] = { name = "Pumpkin Mummy", kind = "shield" },
	[1147] = { name = "Dream Warrior", kind = "melee" },
	[1162] = { name = "Percht Raider", kind = "melee" },
	[1174] = { name = "Owl Keeper", kind = "mana" },
	[1187] = { name = "Guidon Bearer", kind = "shield" },
	[1203] = { name = "Void Master", kind = "magic" },
	[1205] = { name = "Veteran Paladin", kind = "distance" },
	[1207] = { name = "Lion of War", kind = "melee" },
	[1211] = { name = "Golden", kind = "health" },
	[1244] = { name = "Hand of the Inquisition", kind = "melee" },
	[1246] = { name = "Breezy Garb", kind = "speed" },
	[1252] = { name = "Orcsoberfest Garb", kind = "speed" },
	[1271] = { name = "Poltergeist", kind = "magic" },
	[1280] = { name = "Herder", kind = "health" },
	[1283] = { name = "Falconer", kind = "distance" },
	[1289] = { name = "Dragon Slayer", kind = "melee" },
	[1293] = { name = "Trailblazer", kind = "speed" },
	[1323] = { name = "Revenant", kind = "melee" },
	[1332] = { name = "Jouster", kind = "melee" },
	[1339] = { name = "Moth Cape", kind = "speed" },
	[1372] = { name = "Rascoohan", kind = "speed" },
	[1383] = { name = "Merry Garb", kind = "health" },
	[1385] = { name = "Rune Master", kind = "magic" },
	[1387] = { name = "Citizen of Issavi", kind = "health" },
	[1416] = { name = "Forest Warden", kind = "mana" },
	[1437] = { name = "Royal Bounacean Advisor", kind = "health" },
	[1445] = { name = "Dragon Knight", kind = "melee" },
	[1450] = { name = "Arbalester", kind = "distance" },
	[1456] = { name = "Royal Costume", kind = "health" },
	[1461] = { name = "Formal Dress", kind = "mana" },
	[1490] = { name = "Ghost Blade", kind = "melee" },
	[1501] = { name = "Nordic Chieftain", kind = "melee" },
	[1569] = { name = "Fire-Fighter", kind = "health" },
	[1576] = { name = "Fencer", kind = "melee" },
	[1582] = { name = "Shadowlotus Disciple", kind = "mana" },
	[1598] = { name = "Ancient Aucar", kind = "mana" },
	[1613] = { name = "Frost Tracer", kind = "distance" },
	[1619] = { name = "Armoured Archer", kind = "distance" },
	[1663] = { name = "Decaying Defender", kind = "shield" },
	[1676] = { name = "Darklight Evoker", kind = "magic" },
	[1681] = { name = "Flamefury Mage", kind = "magic" },
	[1714] = { name = "Doom Knight", kind = "melee" },
	[1723] = { name = "Draccoon Herald", kind = "magic" },
	[1726] = { name = "Celestial Avenger", kind = "melee" },
	[1746] = { name = "Blade Dancer", kind = "melee" },
	[1775] = { name = "Rootwalker", kind = "mana" },
	[1777] = { name = "Beekeeper", kind = "mana" },
	[1808] = { name = "Fiend Slayer", kind = "melee" },
	[1832] = { name = "Winged Druid", kind = "mana" },
	[1825] = { name = "Monk", kind = "health" },
	[1838] = { name = "Martial Artist", kind = "health" },
	[1861] = { name = "Illuminator", kind = "melee" },
	[128] = { name = "Citizen", kind = "health" },
	[129] = { name = "Hunter", kind = "distance" },
	[130] = { name = "Mage", kind = "magic" },
	[131] = { name = "Knight", kind = "melee" },
	[132] = { name = "Nobleman", kind = "health" },
	[133] = { name = "Summoner", kind = "magic" },
	[134] = { name = "Warrior", kind = "melee" },
	[143] = { name = "Barbarian", kind = "melee" },
	[144] = { name = "Druid", kind = "mana" },
	[145] = { name = "Wizard", kind = "magic" },
	[146] = { name = "Oriental", kind = "health" },
	[151] = { name = "Pirate", kind = "melee" },
	[152] = { name = "Assassin", kind = "distance" },
	[153] = { name = "Beggar", kind = "health" },
	[154] = { name = "Shaman", kind = "mana" },
	[251] = { name = "Norseman", kind = "melee" },
	[268] = { name = "Nightmare", kind = "melee" },
	[273] = { name = "Jester", kind = "speed" },
	[278] = { name = "Brotherhood", kind = "melee" },
	[289] = { name = "Demon Hunter", kind = "distance" },
	[325] = { name = "Yalaharian", kind = "magic" },
	[328] = { name = "Newly Wed", kind = "melee" },
	[335] = { name = "Warmaster", kind = "melee" },
	[367] = { name = "Wayfarer", kind = "speed" },
	[430] = { name = "Afflicted", kind = "health" },
	[432] = { name = "Elementalist", kind = "magic" },
	[463] = { name = "Deepling", kind = "shield" },
	[465] = { name = "Insectoid", kind = "shield" },
	[472] = { name = "Entrepreneur", kind = "speed" },
	[512] = { name = "Crystal Warlord", kind = "shield" },
	[516] = { name = "Soil Guardian", kind = "shield" },
	[541] = { name = "Demon", kind = "magic" },
	[574] = { name = "Cave Explorer", kind = "speed" },
	[577] = { name = "Dream Warden", kind = "mana" },
	[610] = { name = "Glooth Engineer", kind = "speed" },
	[619] = { name = "Jersey", kind = "distance" },
	[633] = { name = "Champion", kind = "melee" },
	[634] = { name = "Conjurer", kind = "magic" },
	[637] = { name = "Beastmaster", kind = "health" },
	[665] = { name = "Chaos Acolyte", kind = "magic" },
	[667] = { name = "Death Herald", kind = "magic" },
	[684] = { name = "Ranger", kind = "distance" },
	[695] = { name = "Ceremonial Garb", kind = "mana" },
	[697] = { name = "Puppeteer", kind = "magic" },
	[699] = { name = "Spirit Caller", kind = "magic" },
	[725] = { name = "Evoker", kind = "magic" },
	[733] = { name = "Seaweaver", kind = "mana" },
	[746] = { name = "Recruiter", kind = "speed" },
	[750] = { name = "Sea Dog", kind = "speed" },
	[760] = { name = "Royal Pumpkin", kind = "health" },
	[846] = { name = "Rift Warrior", kind = "melee" },
	[853] = { name = "Winter Warden", kind = "mana" },
	[873] = { name = "Philosopher", kind = "magic" },
	[884] = { name = "Arena Champion", kind = "melee" },
	[899] = { name = "Lupine Warden", kind = "mana" },
	[908] = { name = "Grove Keeper", kind = "mana" },
	[931] = { name = "Festive", kind = "magic" },
	[955] = { name = "Pharaoh", kind = "magic" },
	[957] = { name = "Trophy Hunter", kind = "distance" },
	[962] = { name = "Retro Warrior", kind = "melee" },
	[964] = { name = "Retro Summoner", kind = "magic" },
	[966] = { name = "Retro Nobleman", kind = "health" },
	[968] = { name = "Retro Mage", kind = "magic" },
	[970] = { name = "Retro Knight", kind = "melee" },
	[972] = { name = "Retro Hunter", kind = "distance" },
	[974] = { name = "Retro Citizen", kind = "health" },
	[1021] = { name = "Herbalist", kind = "mana" },
	[1023] = { name = "Sun Priest", kind = "mana" },
	[1042] = { name = "Makeshift Warrior", kind = "melee" },
	[1051] = { name = "Siege Master", kind = "melee" },
	[1056] = { name = "Mercenary", kind = "melee" },
	[1069] = { name = "Battle Mage", kind = "magic" },
	[1094] = { name = "Discoverer", kind = "speed" },
	[1102] = { name = "Sinister Archer", kind = "distance" },
	[1127] = { name = "Pumpkin Mummy", kind = "shield" },
	[1146] = { name = "Dream Warrior", kind = "melee" },
	[1161] = { name = "Percht Raider", kind = "melee" },
	[1173] = { name = "Owl Keeper", kind = "mana" },
	[1186] = { name = "Guidon Bearer", kind = "shield" },
	[1202] = { name = "Void Master", kind = "magic" },
	[1204] = { name = "Veteran Paladin", kind = "distance" },
	[1206] = { name = "Lion of War", kind = "melee" },
	[1210] = { name = "Golden", kind = "health" },
	[1243] = { name = "Hand of the Inquisition", kind = "melee" },
	[1245] = { name = "Breezy Garb", kind = "speed" },
	[1251] = { name = "Orcsoberfest Garb", kind = "speed" },
	[1270] = { name = "Poltergeist", kind = "magic" },
	[1279] = { name = "Herder", kind = "health" },
	[1282] = { name = "Falconer", kind = "distance" },
	[1288] = { name = "Dragon Slayer", kind = "melee" },
	[1292] = { name = "Trailblazer", kind = "speed" },
	[1322] = { name = "Revenant", kind = "melee" },
	[1331] = { name = "Jouster", kind = "melee" },
	[1338] = { name = "Moth Cape", kind = "speed" },
	[1371] = { name = "Rascoohan", kind = "speed" },
	[1382] = { name = "Merry Garb", kind = "health" },
	[1384] = { name = "Rune Master", kind = "magic" },
	[1386] = { name = "Citizen of Issavi", kind = "health" },
	[1415] = { name = "Forest Warden", kind = "mana" },
	[1436] = { name = "Royal Bounacean Advisor", kind = "health" },
	[1444] = { name = "Dragon Knight", kind = "melee" },
	[1449] = { name = "Arbalester", kind = "distance" },
	[1457] = { name = "Royal Costume", kind = "health" },
	[1460] = { name = "Formal Dress", kind = "mana" },
	[1489] = { name = "Ghost Blade", kind = "melee" },
	[1500] = { name = "Nordic Chieftain", kind = "melee" },
	[1568] = { name = "Fire-Fighter", kind = "health" },
	[1575] = { name = "Fencer", kind = "melee" },
	[1581] = { name = "Shadowlotus Disciple", kind = "mana" },
	[1597] = { name = "Ancient Aucar", kind = "mana" },
	[1612] = { name = "Frost Tracer", kind = "distance" },
	[1618] = { name = "Armoured Archer", kind = "distance" },
	[1662] = { name = "Decaying Defender", kind = "shield" },
	[1675] = { name = "Darklight Evoker", kind = "magic" },
	[1680] = { name = "Flamefury Mage", kind = "magic" },
	[1713] = { name = "Doom Knight", kind = "melee" },
	[1722] = { name = "Draccoon Herald", kind = "magic" },
	[1725] = { name = "Celestial Avenger", kind = "melee" },
	[1745] = { name = "Blade Dancer", kind = "melee" },
	[1774] = { name = "Rootwalker", kind = "mana" },
	[1776] = { name = "Beekeeper", kind = "mana" },
	[1809] = { name = "Fiend Slayer", kind = "melee" },
	[1831] = { name = "Winged Druid", kind = "mana" },
	[1824] = { name = "Monk", kind = "health" },
	[1837] = { name = "Martial Artist", kind = "health" },
	[1860] = { name = "Illuminator", kind = "melee" },
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
	local kind = kinds[outfit.kind]
	local level = levelOf(addons)
	return string.format("%s: " .. kind.text .. ", life leech %d%%, mana leech %d%% (poziom %d/3)", outfit.name, kind.perLevel * level, LIFE_LEECH_PER_LEVEL * level / 100, MANA_LEECH_PER_LEVEL * level / 100, level)
end

local function clear(player)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, LEECH_SUBID)
end

local function apply(player, lookType, addons)
	clear(player)

	local outfit = outfits[lookType]
	if not outfit then
		return false
	end

	local level = levelOf(addons)
	local value = kinds[outfit.kind].perLevel * level
	local condition
	if outfit.kind == "health" then
		condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_HEALTHGAIN, value)
		condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)
	elseif outfit.kind == "mana" then
		condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_MANAGAIN, value)
		condition:setParameter(CONDITION_PARAM_MANATICKS, 2000)
	elseif outfit.kind == "speed" then
		condition = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_SPEED, value)
	else
		condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		if outfit.kind == "melee" then
			condition:setParameter(CONDITION_PARAM_SKILL_MELEE, value)
		elseif outfit.kind == "distance" then
			condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, value)
		elseif outfit.kind == "shield" then
			condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, value)
		elseif outfit.kind == "magic" then
			condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, value)
		end
	end

	condition:setParameter(CONDITION_PARAM_SUBID, SUBID)
	condition:setParameter(CONDITION_PARAM_TICKS, -1)
	player:addCondition(condition)

	-- Leech dla kazdego stroju, w osobnym warunku, zeby nie kolidowal z bonusem glownym.
	local leech = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	leech:setParameter(CONDITION_PARAM_SUBID, LEECH_SUBID)
	leech:setParameter(CONDITION_PARAM_TICKS, -1)
	leech:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
	leech:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, LIFE_LEECH_PER_LEVEL * level)
	leech:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
	leech:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, MANA_LEECH_PER_LEVEL * level)
	player:addCondition(leech)
	return true
end

-- Zmiana stroju: nowy bonus zamiast starego.
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

-- Logowanie: przywroc bonus aktualnego stroju.
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus stroju - " .. text .. ". Kazdy dodatek zwieksza bonus.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ten stroj nie ma bonusu.")
	end
	return true
end

command:groupType("normal")
command:register()
