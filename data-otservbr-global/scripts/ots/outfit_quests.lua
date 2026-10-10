-- OTS: questy na stroje. Plik generowany razem z mapa world/custom/ots-outfits.otbm.
-- Kazdy stroj ma wlasna sale: pokonaj 20 potworow, potem otworz skrzynie.
-- Nagroda: stroj z oboma dodatkami (wersja meska i zenska).

local PAD_ACTION_ID = 64994
local CHEST_ACTION_ID = 64995
local REQUIRED_KILLS = 20
local ROOM_SIZE = 13
local hall = Position(29998, 31005, 7)
local hubLobby = Position(30013, 30000, 7)

local quests = {
	{ name = "Citizen", male = 128, female = 136, x = 30000, y = 31060, entry = Position(30006, 31073, 7), display = Position(30003, 30996, 7), faceSouth = true },
	{ name = "Hunter", male = 129, female = 137, x = 30032, y = 31060, entry = Position(30038, 31073, 7), display = Position(30003, 31004, 7), faceSouth = false },
	{ name = "Mage", male = 130, female = 138, x = 30064, y = 31060, entry = Position(30070, 31073, 7), display = Position(30006, 30996, 7), faceSouth = true },
	{ name = "Knight", male = 131, female = 139, x = 30096, y = 31060, entry = Position(30102, 31073, 7), display = Position(30006, 31004, 7), faceSouth = false },
	{ name = "Nobleman", male = 132, female = 140, x = 30128, y = 31060, entry = Position(30134, 31073, 7), display = Position(30009, 30996, 7), faceSouth = true },
	{ name = "Summoner", male = 133, female = 141, x = 30160, y = 31060, entry = Position(30166, 31073, 7), display = Position(30009, 31004, 7), faceSouth = false },
	{ name = "Warrior", male = 134, female = 142, x = 30192, y = 31060, entry = Position(30198, 31073, 7), display = Position(30012, 30996, 7), faceSouth = true },
	{ name = "Barbarian", male = 143, female = 147, x = 30224, y = 31060, entry = Position(30230, 31073, 7), display = Position(30012, 31004, 7), faceSouth = false },
	{ name = "Druid", male = 144, female = 148, x = 30256, y = 31060, entry = Position(30262, 31073, 7), display = Position(30015, 30996, 7), faceSouth = true },
	{ name = "Wizard", male = 145, female = 149, x = 30288, y = 31060, entry = Position(30294, 31073, 7), display = Position(30015, 31004, 7), faceSouth = false },
	{ name = "Oriental", male = 146, female = 150, x = 30320, y = 31060, entry = Position(30326, 31073, 7), display = Position(30018, 30996, 7), faceSouth = true },
	{ name = "Pirate", male = 151, female = 155, x = 30352, y = 31060, entry = Position(30358, 31073, 7), display = Position(30018, 31004, 7), faceSouth = false },
	{ name = "Assassin", male = 152, female = 156, x = 30000, y = 31092, entry = Position(30006, 31105, 7), display = Position(30003, 31006, 7), faceSouth = true },
	{ name = "Beggar", male = 153, female = 157, x = 30032, y = 31092, entry = Position(30038, 31105, 7), display = Position(30003, 31014, 7), faceSouth = false },
	{ name = "Shaman", male = 154, female = 158, x = 30064, y = 31092, entry = Position(30070, 31105, 7), display = Position(30006, 31006, 7), faceSouth = true },
	{ name = "Norseman", male = 251, female = 252, x = 30096, y = 31092, entry = Position(30102, 31105, 7), display = Position(30006, 31014, 7), faceSouth = false },
	{ name = "Nightmare", male = 268, female = 269, x = 30128, y = 31092, entry = Position(30134, 31105, 7), display = Position(30009, 31006, 7), faceSouth = true },
	{ name = "Jester", male = 273, female = 270, x = 30160, y = 31092, entry = Position(30166, 31105, 7), display = Position(30009, 31014, 7), faceSouth = false },
	{ name = "Brotherhood", male = 278, female = 279, x = 30192, y = 31092, entry = Position(30198, 31105, 7), display = Position(30012, 31006, 7), faceSouth = true },
	{ name = "Demon Hunter", male = 289, female = 288, x = 30224, y = 31092, entry = Position(30230, 31105, 7), display = Position(30012, 31014, 7), faceSouth = false },
	{ name = "Yalaharian", male = 325, female = 324, x = 30256, y = 31092, entry = Position(30262, 31105, 7), display = Position(30015, 31006, 7), faceSouth = true },
	{ name = "Newly Wed", male = 328, female = 329, x = 30288, y = 31092, entry = Position(30294, 31105, 7), display = Position(30015, 31014, 7), faceSouth = false },
	{ name = "Warmaster", male = 335, female = 336, x = 30320, y = 31092, entry = Position(30326, 31105, 7), display = Position(30018, 31006, 7), faceSouth = true },
	{ name = "Wayfarer", male = 367, female = 366, x = 30352, y = 31092, entry = Position(30358, 31105, 7), display = Position(30018, 31014, 7), faceSouth = false },
	{ name = "Afflicted", male = 430, female = 431, x = 30000, y = 31124, entry = Position(30006, 31137, 7), display = Position(30003, 30970, 7), faceSouth = true },
	{ name = "Elementalist", male = 432, female = 433, x = 30032, y = 31124, entry = Position(30038, 31137, 7), display = Position(30003, 30978, 7), faceSouth = false },
	{ name = "Deepling", male = 463, female = 464, x = 30064, y = 31124, entry = Position(30070, 31137, 7), display = Position(30006, 30970, 7), faceSouth = true },
	{ name = "Insectoid", male = 465, female = 466, x = 30096, y = 31124, entry = Position(30102, 31137, 7), display = Position(30006, 30978, 7), faceSouth = false },
	{ name = "Entrepreneur", male = 472, female = 471, x = 30128, y = 31124, entry = Position(30134, 31137, 7), display = Position(30009, 30970, 7), faceSouth = true },
	{ name = "Crystal Warlord", male = 512, female = 513, x = 30160, y = 31124, entry = Position(30166, 31137, 7), display = Position(30009, 30978, 7), faceSouth = false },
	{ name = "Soil Guardian", male = 516, female = 514, x = 30192, y = 31124, entry = Position(30198, 31137, 7), display = Position(30012, 30970, 7), faceSouth = true },
	{ name = "Demon", male = 541, female = 542, x = 30224, y = 31124, entry = Position(30230, 31137, 7), display = Position(30012, 30978, 7), faceSouth = false },
	{ name = "Cave Explorer", male = 574, female = 575, x = 30256, y = 31124, entry = Position(30262, 31137, 7), display = Position(30015, 30970, 7), faceSouth = true },
	{ name = "Dream Warden", male = 577, female = 578, x = 30288, y = 31124, entry = Position(30294, 31137, 7), display = Position(30015, 30978, 7), faceSouth = false },
	{ name = "Glooth Engineer", male = 610, female = 618, x = 30320, y = 31124, entry = Position(30326, 31137, 7), display = Position(30018, 30970, 7), faceSouth = true },
	{ name = "Jersey", male = 619, female = 620, x = 30352, y = 31124, entry = Position(30358, 31137, 7), display = Position(30018, 30978, 7), faceSouth = false },
	{ name = "Champion", male = 633, female = 632, x = 30000, y = 31156, entry = Position(30006, 31169, 7), display = Position(30003, 30980, 7), faceSouth = true },
	{ name = "Conjurer", male = 634, female = 635, x = 30032, y = 31156, entry = Position(30038, 31169, 7), display = Position(30003, 30988, 7), faceSouth = false },
	{ name = "Beastmaster", male = 637, female = 636, x = 30064, y = 31156, entry = Position(30070, 31169, 7), display = Position(30006, 30980, 7), faceSouth = true },
	{ name = "Chaos Acolyte", male = 665, female = 664, x = 30096, y = 31156, entry = Position(30102, 31169, 7), display = Position(30006, 30988, 7), faceSouth = false },
	{ name = "Death Herald", male = 667, female = 666, x = 30128, y = 31156, entry = Position(30134, 31169, 7), display = Position(30009, 30980, 7), faceSouth = true },
	{ name = "Ranger", male = 684, female = 683, x = 30160, y = 31156, entry = Position(30166, 31169, 7), display = Position(30009, 30988, 7), faceSouth = false },
	{ name = "Ceremonial Garb", male = 695, female = 694, x = 30192, y = 31156, entry = Position(30198, 31169, 7), display = Position(30012, 30980, 7), faceSouth = true },
	{ name = "Puppeteer", male = 697, female = 696, x = 30224, y = 31156, entry = Position(30230, 31169, 7), display = Position(30012, 30988, 7), faceSouth = false },
	{ name = "Spirit Caller", male = 699, female = 698, x = 30256, y = 31156, entry = Position(30262, 31169, 7), display = Position(30015, 30980, 7), faceSouth = true },
	{ name = "Evoker", male = 725, female = 724, x = 30288, y = 31156, entry = Position(30294, 31169, 7), display = Position(30015, 30988, 7), faceSouth = false },
	{ name = "Seaweaver", male = 733, female = 732, x = 30320, y = 31156, entry = Position(30326, 31169, 7), display = Position(30018, 30980, 7), faceSouth = true },
	{ name = "Recruiter", male = 746, female = 745, x = 30352, y = 31156, entry = Position(30358, 31169, 7), display = Position(30018, 30988, 7), faceSouth = false },
	{ name = "Sea Dog", male = 750, female = 749, x = 30000, y = 31188, entry = Position(30006, 31201, 7), display = Position(30003, 30944, 7), faceSouth = true },
	{ name = "Royal Pumpkin", male = 760, female = 759, x = 30032, y = 31188, entry = Position(30038, 31201, 7), display = Position(30003, 30952, 7), faceSouth = false },
	{ name = "Rift Warrior", male = 846, female = 845, x = 30064, y = 31188, entry = Position(30070, 31201, 7), display = Position(30006, 30944, 7), faceSouth = true },
	{ name = "Winter Warden", male = 853, female = 852, x = 30096, y = 31188, entry = Position(30102, 31201, 7), display = Position(30006, 30952, 7), faceSouth = false },
	{ name = "Philosopher", male = 873, female = 874, x = 30128, y = 31188, entry = Position(30134, 31201, 7), display = Position(30009, 30944, 7), faceSouth = true },
	{ name = "Arena Champion", male = 884, female = 885, x = 30160, y = 31188, entry = Position(30166, 31201, 7), display = Position(30009, 30952, 7), faceSouth = false },
	{ name = "Lupine Warden", male = 899, female = 900, x = 30192, y = 31188, entry = Position(30198, 31201, 7), display = Position(30012, 30944, 7), faceSouth = true },
	{ name = "Grove Keeper", male = 908, female = 909, x = 30224, y = 31188, entry = Position(30230, 31201, 7), display = Position(30012, 30952, 7), faceSouth = false },
	{ name = "Festive", male = 931, female = 929, x = 30256, y = 31188, entry = Position(30262, 31201, 7), display = Position(30015, 30944, 7), faceSouth = true },
	{ name = "Pharaoh", male = 955, female = 956, x = 30288, y = 31188, entry = Position(30294, 31201, 7), display = Position(30015, 30952, 7), faceSouth = false },
	{ name = "Trophy Hunter", male = 957, female = 958, x = 30320, y = 31188, entry = Position(30326, 31201, 7), display = Position(30018, 30944, 7), faceSouth = true },
	{ name = "Retro Warrior", male = 962, female = 963, x = 30352, y = 31188, entry = Position(30358, 31201, 7), display = Position(30018, 30952, 7), faceSouth = false },
	{ name = "Retro Summoner", male = 964, female = 965, x = 30000, y = 31220, entry = Position(30006, 31233, 7), display = Position(30003, 30954, 7), faceSouth = true },
	{ name = "Retro Nobleman", male = 966, female = 967, x = 30032, y = 31220, entry = Position(30038, 31233, 7), display = Position(30003, 30962, 7), faceSouth = false },
	{ name = "Retro Mage", male = 968, female = 969, x = 30064, y = 31220, entry = Position(30070, 31233, 7), display = Position(30006, 30954, 7), faceSouth = true },
	{ name = "Retro Knight", male = 970, female = 971, x = 30096, y = 31220, entry = Position(30102, 31233, 7), display = Position(30006, 30962, 7), faceSouth = false },
	{ name = "Retro Hunter", male = 972, female = 973, x = 30128, y = 31220, entry = Position(30134, 31233, 7), display = Position(30009, 30954, 7), faceSouth = true },
	{ name = "Retro Citizen", male = 974, female = 975, x = 30160, y = 31220, entry = Position(30166, 31233, 7), display = Position(30009, 30962, 7), faceSouth = false },
	{ name = "Herbalist", male = 1021, female = 1020, x = 30192, y = 31220, entry = Position(30198, 31233, 7), display = Position(30012, 30954, 7), faceSouth = true },
	{ name = "Sun Priest", male = 1023, female = 1024, x = 30224, y = 31220, entry = Position(30230, 31233, 7), display = Position(30012, 30962, 7), faceSouth = false },
	{ name = "Makeshift Warrior", male = 1042, female = 1043, x = 30256, y = 31220, entry = Position(30262, 31233, 7), display = Position(30015, 30954, 7), faceSouth = true },
	{ name = "Siege Master", male = 1051, female = 1050, x = 30288, y = 31220, entry = Position(30294, 31233, 7), display = Position(30015, 30962, 7), faceSouth = false },
	{ name = "Mercenary", male = 1056, female = 1057, x = 30320, y = 31220, entry = Position(30326, 31233, 7), display = Position(30018, 30954, 7), faceSouth = true },
	{ name = "Battle Mage", male = 1069, female = 1070, x = 30352, y = 31220, entry = Position(30358, 31233, 7), display = Position(30018, 30962, 7), faceSouth = false },
	{ name = "Discoverer", male = 1094, female = 1095, x = 30000, y = 31252, entry = Position(30006, 31265, 7), display = Position(30003, 30918, 7), faceSouth = true },
	{ name = "Sinister Archer", male = 1102, female = 1103, x = 30032, y = 31252, entry = Position(30038, 31265, 7), display = Position(30003, 30926, 7), faceSouth = false },
	{ name = "Pumpkin Mummy", male = 1127, female = 1128, x = 30064, y = 31252, entry = Position(30070, 31265, 7), display = Position(30006, 30918, 7), faceSouth = true },
	{ name = "Dream Warrior", male = 1146, female = 1147, x = 30096, y = 31252, entry = Position(30102, 31265, 7), display = Position(30006, 30926, 7), faceSouth = false },
	{ name = "Percht Raider", male = 1161, female = 1162, x = 30128, y = 31252, entry = Position(30134, 31265, 7), display = Position(30009, 30918, 7), faceSouth = true },
	{ name = "Owl Keeper", male = 1173, female = 1174, x = 30160, y = 31252, entry = Position(30166, 31265, 7), display = Position(30009, 30926, 7), faceSouth = false },
	{ name = "Guidon Bearer", male = 1186, female = 1187, x = 30192, y = 31252, entry = Position(30198, 31265, 7), display = Position(30012, 30918, 7), faceSouth = true },
	{ name = "Void Master", male = 1202, female = 1203, x = 30224, y = 31252, entry = Position(30230, 31265, 7), display = Position(30012, 30926, 7), faceSouth = false },
	{ name = "Veteran Paladin", male = 1204, female = 1205, x = 30256, y = 31252, entry = Position(30262, 31265, 7), display = Position(30015, 30918, 7), faceSouth = true },
	{ name = "Lion of War", male = 1206, female = 1207, x = 30288, y = 31252, entry = Position(30294, 31265, 7), display = Position(30015, 30926, 7), faceSouth = false },
	{ name = "Golden", male = 1210, female = 1211, x = 30320, y = 31252, entry = Position(30326, 31265, 7), display = Position(30018, 30918, 7), faceSouth = true },
	{ name = "Hand of the Inquisition", male = 1243, female = 1244, x = 30352, y = 31252, entry = Position(30358, 31265, 7), display = Position(30018, 30926, 7), faceSouth = false },
	{ name = "Breezy Garb", male = 1245, female = 1246, x = 30000, y = 31284, entry = Position(30006, 31297, 7), display = Position(30003, 30928, 7), faceSouth = true },
	{ name = "Orcsoberfest Garb", male = 1251, female = 1252, x = 30032, y = 31284, entry = Position(30038, 31297, 7), display = Position(30003, 30936, 7), faceSouth = false },
	{ name = "Poltergeist", male = 1270, female = 1271, x = 30064, y = 31284, entry = Position(30070, 31297, 7), display = Position(30006, 30928, 7), faceSouth = true },
	{ name = "Herder", male = 1279, female = 1280, x = 30096, y = 31284, entry = Position(30102, 31297, 7), display = Position(30006, 30936, 7), faceSouth = false },
	{ name = "Falconer", male = 1282, female = 1283, x = 30128, y = 31284, entry = Position(30134, 31297, 7), display = Position(30009, 30928, 7), faceSouth = true },
	{ name = "Dragon Slayer", male = 1288, female = 1289, x = 30160, y = 31284, entry = Position(30166, 31297, 7), display = Position(30009, 30936, 7), faceSouth = false },
	{ name = "Trailblazer", male = 1292, female = 1293, x = 30192, y = 31284, entry = Position(30198, 31297, 7), display = Position(30012, 30928, 7), faceSouth = true },
	{ name = "Revenant", male = 1322, female = 1323, x = 30224, y = 31284, entry = Position(30230, 31297, 7), display = Position(30012, 30936, 7), faceSouth = false },
	{ name = "Jouster", male = 1331, female = 1332, x = 30256, y = 31284, entry = Position(30262, 31297, 7), display = Position(30015, 30928, 7), faceSouth = true },
	{ name = "Moth Cape", male = 1338, female = 1339, x = 30288, y = 31284, entry = Position(30294, 31297, 7), display = Position(30015, 30936, 7), faceSouth = false },
	{ name = "Rascoohan", male = 1371, female = 1372, x = 30320, y = 31284, entry = Position(30326, 31297, 7), display = Position(30018, 30928, 7), faceSouth = true },
	{ name = "Merry Garb", male = 1382, female = 1383, x = 30352, y = 31284, entry = Position(30358, 31297, 7), display = Position(30018, 30936, 7), faceSouth = false },
	{ name = "Rune Master", male = 1384, female = 1385, x = 30000, y = 31316, entry = Position(30006, 31329, 7), display = Position(30003, 30892, 7), faceSouth = true },
	{ name = "Citizen of Issavi", male = 1386, female = 1387, x = 30032, y = 31316, entry = Position(30038, 31329, 7), display = Position(30003, 30900, 7), faceSouth = false },
	{ name = "Forest Warden", male = 1415, female = 1416, x = 30064, y = 31316, entry = Position(30070, 31329, 7), display = Position(30006, 30892, 7), faceSouth = true },
	{ name = "Royal Bounacean Advisor", male = 1436, female = 1437, x = 30096, y = 31316, entry = Position(30102, 31329, 7), display = Position(30006, 30900, 7), faceSouth = false },
	{ name = "Dragon Knight", male = 1444, female = 1445, x = 30128, y = 31316, entry = Position(30134, 31329, 7), display = Position(30009, 30892, 7), faceSouth = true },
	{ name = "Arbalester", male = 1449, female = 1450, x = 30160, y = 31316, entry = Position(30166, 31329, 7), display = Position(30009, 30900, 7), faceSouth = false },
	{ name = "Royal Costume", male = 1457, female = 1456, x = 30192, y = 31316, entry = Position(30198, 31329, 7), display = Position(30012, 30892, 7), faceSouth = true },
	{ name = "Formal Dress", male = 1460, female = 1461, x = 30224, y = 31316, entry = Position(30230, 31329, 7), display = Position(30012, 30900, 7), faceSouth = false },
	{ name = "Ghost Blade", male = 1489, female = 1490, x = 30256, y = 31316, entry = Position(30262, 31329, 7), display = Position(30015, 30892, 7), faceSouth = true },
	{ name = "Nordic Chieftain", male = 1500, female = 1501, x = 30288, y = 31316, entry = Position(30294, 31329, 7), display = Position(30015, 30900, 7), faceSouth = false },
	{ name = "Fire-Fighter", male = 1568, female = 1569, x = 30320, y = 31316, entry = Position(30326, 31329, 7), display = Position(30018, 30892, 7), faceSouth = true },
	{ name = "Fencer", male = 1575, female = 1576, x = 30352, y = 31316, entry = Position(30358, 31329, 7), display = Position(30018, 30900, 7), faceSouth = false },
	{ name = "Shadowlotus Disciple", male = 1581, female = 1582, x = 30000, y = 31348, entry = Position(30006, 31361, 7), display = Position(30003, 30902, 7), faceSouth = true },
	{ name = "Ancient Aucar", male = 1597, female = 1598, x = 30032, y = 31348, entry = Position(30038, 31361, 7), display = Position(30003, 30910, 7), faceSouth = false },
	{ name = "Frost Tracer", male = 1612, female = 1613, x = 30064, y = 31348, entry = Position(30070, 31361, 7), display = Position(30006, 30902, 7), faceSouth = true },
	{ name = "Armoured Archer", male = 1618, female = 1619, x = 30096, y = 31348, entry = Position(30102, 31361, 7), display = Position(30006, 30910, 7), faceSouth = false },
	{ name = "Decaying Defender", male = 1662, female = 1663, x = 30128, y = 31348, entry = Position(30134, 31361, 7), display = Position(30009, 30902, 7), faceSouth = true },
	{ name = "Darklight Evoker", male = 1675, female = 1676, x = 30160, y = 31348, entry = Position(30166, 31361, 7), display = Position(30009, 30910, 7), faceSouth = false },
	{ name = "Flamefury Mage", male = 1680, female = 1681, x = 30192, y = 31348, entry = Position(30198, 31361, 7), display = Position(30012, 30902, 7), faceSouth = true },
	{ name = "Doom Knight", male = 1713, female = 1714, x = 30224, y = 31348, entry = Position(30230, 31361, 7), display = Position(30012, 30910, 7), faceSouth = false },
	{ name = "Draccoon Herald", male = 1722, female = 1723, x = 30256, y = 31348, entry = Position(30262, 31361, 7), display = Position(30015, 30902, 7), faceSouth = true },
	{ name = "Celestial Avenger", male = 1725, female = 1726, x = 30288, y = 31348, entry = Position(30294, 31361, 7), display = Position(30015, 30910, 7), faceSouth = false },
	{ name = "Blade Dancer", male = 1745, female = 1746, x = 30320, y = 31348, entry = Position(30326, 31361, 7), display = Position(30018, 30902, 7), faceSouth = true },
	{ name = "Rootwalker", male = 1774, female = 1775, x = 30352, y = 31348, entry = Position(30358, 31361, 7), display = Position(30018, 30910, 7), faceSouth = false },
	{ name = "Beekeeper", male = 1776, female = 1777, x = 30000, y = 31380, entry = Position(30006, 31393, 7), display = Position(30003, 30866, 7), faceSouth = true },
	{ name = "Fiend Slayer", male = 1809, female = 1808, x = 30032, y = 31380, entry = Position(30038, 31393, 7), display = Position(30003, 30874, 7), faceSouth = false },
	{ name = "Winged Druid", male = 1831, female = 1832, x = 30064, y = 31380, entry = Position(30070, 31393, 7), display = Position(30006, 30866, 7), faceSouth = true },
	{ name = "Monk", male = 1824, female = 1825, x = 30096, y = 31380, entry = Position(30102, 31393, 7), display = Position(30006, 30874, 7), faceSouth = false },
	{ name = "Martial Artist", male = 1837, female = 1838, x = 30128, y = 31380, entry = Position(30134, 31393, 7), display = Position(30009, 30866, 7), faceSouth = true },
	{ name = "Illuminator", male = 0, female = 1860, x = 30160, y = 31380, entry = Position(30166, 31393, 7), display = Position(30009, 30874, 7), faceSouth = false },
}

local pads = {
	["29996:30873:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["29996:30875:7"] = { hub = true },
	["29996:30877:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["29996:30899:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["29996:30901:7"] = { hub = true },
	["29996:30903:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["29996:30925:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["29996:30927:7"] = { hub = true },
	["29996:30929:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["29996:30951:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["29996:30953:7"] = { hub = true },
	["29996:30955:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["29996:30977:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["29996:30979:7"] = { hub = true },
	["29996:30981:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["29996:31003:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["29996:31005:7"] = { hub = true },
	["29996:31007:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30003:30868:7"] = { room = 121 },
	["30003:30872:7"] = { room = 122 },
	["30003:30894:7"] = { room = 97 },
	["30003:30898:7"] = { room = 98 },
	["30003:30904:7"] = { room = 109 },
	["30003:30908:7"] = { room = 110 },
	["30003:30920:7"] = { room = 73 },
	["30003:30924:7"] = { room = 74 },
	["30003:30930:7"] = { room = 85 },
	["30003:30934:7"] = { room = 86 },
	["30003:30946:7"] = { room = 49 },
	["30003:30950:7"] = { room = 50 },
	["30003:30956:7"] = { room = 61 },
	["30003:30960:7"] = { room = 62 },
	["30003:30972:7"] = { room = 25 },
	["30003:30976:7"] = { room = 26 },
	["30003:30982:7"] = { room = 37 },
	["30003:30986:7"] = { room = 38 },
	["30003:30998:7"] = { room = 1 },
	["30003:31002:7"] = { room = 2 },
	["30003:31008:7"] = { room = 13 },
	["30003:31012:7"] = { room = 14 },
	["30006:30868:7"] = { room = 123 },
	["30006:30872:7"] = { room = 124 },
	["30006:30894:7"] = { room = 99 },
	["30006:30898:7"] = { room = 100 },
	["30006:30904:7"] = { room = 111 },
	["30006:30908:7"] = { room = 112 },
	["30006:30920:7"] = { room = 75 },
	["30006:30924:7"] = { room = 76 },
	["30006:30930:7"] = { room = 87 },
	["30006:30934:7"] = { room = 88 },
	["30006:30946:7"] = { room = 51 },
	["30006:30950:7"] = { room = 52 },
	["30006:30956:7"] = { room = 63 },
	["30006:30960:7"] = { room = 64 },
	["30006:30972:7"] = { room = 27 },
	["30006:30976:7"] = { room = 28 },
	["30006:30982:7"] = { room = 39 },
	["30006:30986:7"] = { room = 40 },
	["30006:30998:7"] = { room = 3 },
	["30006:31002:7"] = { room = 4 },
	["30006:31008:7"] = { room = 15 },
	["30006:31012:7"] = { room = 16 },
	["30007:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30007:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30007:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30007:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30007:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30007:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30007:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30007:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30007:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30007:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30007:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30007:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30007:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30007:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30007:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30007:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30007:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30007:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30007:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30007:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30007:31379:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30007:31394:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30009:30868:7"] = { room = 125 },
	["30009:30872:7"] = { room = 126 },
	["30009:30894:7"] = { room = 101 },
	["30009:30898:7"] = { room = 102 },
	["30009:30904:7"] = { room = 113 },
	["30009:30908:7"] = { room = 114 },
	["30009:30920:7"] = { room = 77 },
	["30009:30924:7"] = { room = 78 },
	["30009:30930:7"] = { room = 89 },
	["30009:30934:7"] = { room = 90 },
	["30009:30946:7"] = { room = 53 },
	["30009:30950:7"] = { room = 54 },
	["30009:30956:7"] = { room = 65 },
	["30009:30960:7"] = { room = 66 },
	["30009:30972:7"] = { room = 29 },
	["30009:30976:7"] = { room = 30 },
	["30009:30982:7"] = { room = 41 },
	["30009:30986:7"] = { room = 42 },
	["30009:30998:7"] = { room = 5 },
	["30009:31002:7"] = { room = 6 },
	["30009:31008:7"] = { room = 17 },
	["30009:31012:7"] = { room = 18 },
	["30012:30894:7"] = { room = 103 },
	["30012:30898:7"] = { room = 104 },
	["30012:30904:7"] = { room = 115 },
	["30012:30908:7"] = { room = 116 },
	["30012:30920:7"] = { room = 79 },
	["30012:30924:7"] = { room = 80 },
	["30012:30930:7"] = { room = 91 },
	["30012:30934:7"] = { room = 92 },
	["30012:30946:7"] = { room = 55 },
	["30012:30950:7"] = { room = 56 },
	["30012:30956:7"] = { room = 67 },
	["30012:30960:7"] = { room = 68 },
	["30012:30972:7"] = { room = 31 },
	["30012:30976:7"] = { room = 32 },
	["30012:30982:7"] = { room = 43 },
	["30012:30986:7"] = { room = 44 },
	["30012:30998:7"] = { room = 7 },
	["30012:31002:7"] = { room = 8 },
	["30012:31008:7"] = { room = 19 },
	["30012:31012:7"] = { room = 20 },
	["30015:30894:7"] = { room = 105 },
	["30015:30898:7"] = { room = 106 },
	["30015:30904:7"] = { room = 117 },
	["30015:30908:7"] = { room = 118 },
	["30015:30920:7"] = { room = 81 },
	["30015:30924:7"] = { room = 82 },
	["30015:30930:7"] = { room = 93 },
	["30015:30934:7"] = { room = 94 },
	["30015:30946:7"] = { room = 57 },
	["30015:30950:7"] = { room = 58 },
	["30015:30956:7"] = { room = 69 },
	["30015:30960:7"] = { room = 70 },
	["30015:30972:7"] = { room = 33 },
	["30015:30976:7"] = { room = 34 },
	["30015:30982:7"] = { room = 45 },
	["30015:30986:7"] = { room = 46 },
	["30015:30998:7"] = { room = 9 },
	["30015:31002:7"] = { room = 10 },
	["30015:31008:7"] = { room = 21 },
	["30015:31012:7"] = { room = 22 },
	["30018:30894:7"] = { room = 107 },
	["30018:30898:7"] = { room = 108 },
	["30018:30904:7"] = { room = 119 },
	["30018:30908:7"] = { room = 120 },
	["30018:30920:7"] = { room = 83 },
	["30018:30924:7"] = { room = 84 },
	["30018:30930:7"] = { room = 95 },
	["30018:30934:7"] = { room = 96 },
	["30018:30946:7"] = { room = 59 },
	["30018:30950:7"] = { room = 60 },
	["30018:30956:7"] = { room = 71 },
	["30018:30960:7"] = { room = 72 },
	["30018:30972:7"] = { room = 35 },
	["30018:30976:7"] = { room = 36 },
	["30018:30982:7"] = { room = 47 },
	["30018:30986:7"] = { room = 48 },
	["30018:30998:7"] = { room = 11 },
	["30018:31002:7"] = { room = 12 },
	["30018:31008:7"] = { room = 23 },
	["30018:31012:7"] = { room = 24 },
	["30039:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30039:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30039:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30039:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30039:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30039:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30039:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30039:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30039:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30039:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30039:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30039:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30039:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30039:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30039:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30039:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30039:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30039:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30039:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30039:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30039:31379:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30039:31394:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30071:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30071:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30071:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30071:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30071:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30071:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30071:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30071:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30071:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30071:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30071:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30071:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30071:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30071:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30071:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30071:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30071:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30071:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30071:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30071:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30071:31379:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30071:31394:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30103:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30103:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30103:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30103:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30103:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30103:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30103:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30103:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30103:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30103:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30103:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30103:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30103:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30103:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30103:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30103:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30103:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30103:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30103:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30103:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30103:31379:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30103:31394:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30135:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30135:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30135:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30135:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30135:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30135:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30135:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30135:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30135:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30135:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30135:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30135:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30135:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30135:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30135:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30135:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30135:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30135:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30135:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30135:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30135:31379:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30135:31394:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30167:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30167:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30167:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30167:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30167:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30167:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30167:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30167:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30167:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30167:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30167:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30167:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30167:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30167:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30167:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30167:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30167:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30167:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30167:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30167:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30167:31379:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30167:31394:7"] = { goto = Position(29998, 30875, 7), label = "Stroje 6/6" },
	["30199:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30199:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30199:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30199:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30199:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30199:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30199:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30199:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30199:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30199:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30199:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30199:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30199:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30199:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30199:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30199:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30199:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30199:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30199:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30199:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30231:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30231:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30231:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30231:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30231:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30231:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30231:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30231:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30231:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30231:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30231:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30231:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30231:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30231:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30231:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30231:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30231:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30231:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30231:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30231:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30263:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30263:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30263:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30263:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30263:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30263:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30263:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30263:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30263:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30263:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30263:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30263:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30263:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30263:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30263:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30263:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30263:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30263:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30263:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30263:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30295:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30295:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30295:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30295:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30295:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30295:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30295:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30295:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30295:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30295:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30295:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30295:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30295:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30295:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30295:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30295:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30295:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30295:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30295:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30295:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30327:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30327:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30327:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30327:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30327:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30327:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30327:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30327:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30327:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30327:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30327:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30327:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30327:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30327:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30327:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30327:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30327:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30327:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30327:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30327:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30359:31059:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30359:31074:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30359:31091:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30359:31106:7"] = { goto = Position(29998, 31005, 7), label = "Stroje 1/6" },
	["30359:31123:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30359:31138:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30359:31155:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30359:31170:7"] = { goto = Position(29998, 30979, 7), label = "Stroje 2/6" },
	["30359:31187:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30359:31202:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30359:31219:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30359:31234:7"] = { goto = Position(29998, 30953, 7), label = "Stroje 3/6" },
	["30359:31251:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30359:31266:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30359:31283:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30359:31298:7"] = { goto = Position(29998, 30927, 7), label = "Stroje 4/6" },
	["30359:31315:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30359:31330:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30359:31347:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
	["30359:31362:7"] = { goto = Position(29998, 30901, 7), label = "Stroje 5/6" },
}

local navNpcs = {
	{ name = "Poprzednie pomieszczenie", position = Position(29995, 31003, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29995, 31007, 7) },
	{ name = "Lobby", position = Position(29995, 31005, 7) },
	{ name = "Poprzednie pomieszczenie", position = Position(29995, 30977, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29995, 30981, 7) },
	{ name = "Lobby", position = Position(29995, 30979, 7) },
	{ name = "Poprzednie pomieszczenie", position = Position(29995, 30951, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29995, 30955, 7) },
	{ name = "Lobby", position = Position(29995, 30953, 7) },
	{ name = "Poprzednie pomieszczenie", position = Position(29995, 30925, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29995, 30929, 7) },
	{ name = "Lobby", position = Position(29995, 30927, 7) },
	{ name = "Poprzednie pomieszczenie", position = Position(29995, 30899, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29995, 30903, 7) },
	{ name = "Lobby", position = Position(29995, 30901, 7) },
	{ name = "Poprzednie pomieszczenie", position = Position(29995, 30873, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29995, 30877, 7) },
	{ name = "Lobby", position = Position(29995, 30875, 7) },
}

local chests = {
	["30006:31058:7"] = 1,
	["30006:31090:7"] = 13,
	["30006:31122:7"] = 25,
	["30006:31154:7"] = 37,
	["30006:31186:7"] = 49,
	["30006:31218:7"] = 61,
	["30006:31250:7"] = 73,
	["30006:31282:7"] = 85,
	["30006:31314:7"] = 97,
	["30006:31346:7"] = 109,
	["30006:31378:7"] = 121,
	["30038:31058:7"] = 2,
	["30038:31090:7"] = 14,
	["30038:31122:7"] = 26,
	["30038:31154:7"] = 38,
	["30038:31186:7"] = 50,
	["30038:31218:7"] = 62,
	["30038:31250:7"] = 74,
	["30038:31282:7"] = 86,
	["30038:31314:7"] = 98,
	["30038:31346:7"] = 110,
	["30038:31378:7"] = 122,
	["30070:31058:7"] = 3,
	["30070:31090:7"] = 15,
	["30070:31122:7"] = 27,
	["30070:31154:7"] = 39,
	["30070:31186:7"] = 51,
	["30070:31218:7"] = 63,
	["30070:31250:7"] = 75,
	["30070:31282:7"] = 87,
	["30070:31314:7"] = 99,
	["30070:31346:7"] = 111,
	["30070:31378:7"] = 123,
	["30102:31058:7"] = 4,
	["30102:31090:7"] = 16,
	["30102:31122:7"] = 28,
	["30102:31154:7"] = 40,
	["30102:31186:7"] = 52,
	["30102:31218:7"] = 64,
	["30102:31250:7"] = 76,
	["30102:31282:7"] = 88,
	["30102:31314:7"] = 100,
	["30102:31346:7"] = 112,
	["30102:31378:7"] = 124,
	["30134:31058:7"] = 5,
	["30134:31090:7"] = 17,
	["30134:31122:7"] = 29,
	["30134:31154:7"] = 41,
	["30134:31186:7"] = 53,
	["30134:31218:7"] = 65,
	["30134:31250:7"] = 77,
	["30134:31282:7"] = 89,
	["30134:31314:7"] = 101,
	["30134:31346:7"] = 113,
	["30134:31378:7"] = 125,
	["30166:31058:7"] = 6,
	["30166:31090:7"] = 18,
	["30166:31122:7"] = 30,
	["30166:31154:7"] = 42,
	["30166:31186:7"] = 54,
	["30166:31218:7"] = 66,
	["30166:31250:7"] = 78,
	["30166:31282:7"] = 90,
	["30166:31314:7"] = 102,
	["30166:31346:7"] = 114,
	["30166:31378:7"] = 126,
	["30198:31058:7"] = 7,
	["30198:31090:7"] = 19,
	["30198:31122:7"] = 31,
	["30198:31154:7"] = 43,
	["30198:31186:7"] = 55,
	["30198:31218:7"] = 67,
	["30198:31250:7"] = 79,
	["30198:31282:7"] = 91,
	["30198:31314:7"] = 103,
	["30198:31346:7"] = 115,
	["30230:31058:7"] = 8,
	["30230:31090:7"] = 20,
	["30230:31122:7"] = 32,
	["30230:31154:7"] = 44,
	["30230:31186:7"] = 56,
	["30230:31218:7"] = 68,
	["30230:31250:7"] = 80,
	["30230:31282:7"] = 92,
	["30230:31314:7"] = 104,
	["30230:31346:7"] = 116,
	["30262:31058:7"] = 9,
	["30262:31090:7"] = 21,
	["30262:31122:7"] = 33,
	["30262:31154:7"] = 45,
	["30262:31186:7"] = 57,
	["30262:31218:7"] = 69,
	["30262:31250:7"] = 81,
	["30262:31282:7"] = 93,
	["30262:31314:7"] = 105,
	["30262:31346:7"] = 117,
	["30294:31058:7"] = 10,
	["30294:31090:7"] = 22,
	["30294:31122:7"] = 34,
	["30294:31154:7"] = 46,
	["30294:31186:7"] = 58,
	["30294:31218:7"] = 70,
	["30294:31250:7"] = 82,
	["30294:31282:7"] = 94,
	["30294:31314:7"] = 106,
	["30294:31346:7"] = 118,
	["30326:31058:7"] = 11,
	["30326:31090:7"] = 23,
	["30326:31122:7"] = 35,
	["30326:31154:7"] = 47,
	["30326:31186:7"] = 59,
	["30326:31218:7"] = 71,
	["30326:31250:7"] = 83,
	["30326:31282:7"] = 95,
	["30326:31314:7"] = 107,
	["30326:31346:7"] = 119,
	["30358:31058:7"] = 12,
	["30358:31090:7"] = 24,
	["30358:31122:7"] = 36,
	["30358:31154:7"] = 48,
	["30358:31186:7"] = 60,
	["30358:31218:7"] = 72,
	["30358:31250:7"] = 84,
	["30358:31282:7"] = 96,
	["30358:31314:7"] = 108,
	["30358:31346:7"] = 120,
}


local function key(pos)
	return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local function move(player, destination, message)
	local from = player:getPosition()
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	if message then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	end
end

local function progress(player, index)
	return player:kv():scoped("ots-outfit-quests"):scoped(tostring(index))
end

local function killsOf(player, index)
	return tonumber(progress(player, index):get("kills")) or 0
end

local function isDone(player, index)
	return progress(player, index):get("done") == true
end

-- Ktora sala zawiera te pozycje (albo nil).
local function roomAt(pos)
	for index, quest in ipairs(quests) do
		if pos.x >= quest.x and pos.x < quest.x + ROOM_SIZE and pos.y >= quest.y and pos.y < quest.y + ROOM_SIZE and pos.z == quest.entry.z then
			return index
		end
	end
	return nil
end

-- Wejscie z menu !tp i z hubu.
function OtsOutfitHall(player)
	move(player, hall, "Questy na stroje, pietro 1")
end

local padStep = MoveEvent()

function padStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local pad = pads[key(position)]
	if not pad then
		return true
	end

	if pad.room then
		local quest = quests[pad.room]
		local text
		if isDone(player, pad.room) then
			text = string.format("Stroj %s: quest juz wykonany.", quest.name)
		else
			text = string.format("Stroj %s: pokonane %d/%d. Skrzynia jest po polnocnej stronie sali.", quest.name, math.min(killsOf(player, pad.room), REQUIRED_KILLS), REQUIRED_KILLS)
		end
		move(player, quest.entry, text)
	elseif pad.goto then
		move(player, pad.goto, pad.label)
	elseif pad.hub then
		move(player, hubLobby)
	end
	return true
end

padStep:type("stepin")
padStep:aid(PAD_ACTION_ID)
padStep:register()

local kills = EventCallback("OtsOutfitQuestOnKill")

function kills.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local index = roomAt(monster:getPosition())
	if not index or isDone(player, index) then
		return
	end

	local count = killsOf(player, index)
	if count >= REQUIRED_KILLS then
		return
	end
	count = count + 1
	progress(player, index):set("kills", count)
	if count >= REQUIRED_KILLS then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Stroj %s: wymagane potwory pokonane. Otworz skrzynie po polnocnej stronie sali.", quests[index].name))
	elseif count % 5 == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Stroj %s: %d/%d potworow.", quests[index].name, count, REQUIRED_KILLS))
	end
end

kills:register()

local chest = Action()

function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local index = chests[key(fromPosition)]
	if not index then
		return true
	end
	local quest = quests[index]

	if isDone(player, index) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skrzynia jest pusta. Ten quest jest juz wykonany.")
		return true
	end

	local count = killsOf(player, index)
	if count < REQUIRED_KILLS then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Skrzynia jest zamknieta. Pokonaj jeszcze %d potworow w tej sali.", REQUIRED_KILLS - count))
		return true
	end

	if quest.male > 0 then
		player:addOutfitAddon(quest.male, 3)
	end
	if quest.female > 0 then
		player:addOutfitAddon(quest.female, 3)
	end
	progress(player, index):set("done", true)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Quest wykonany! Nowy stroj dostepny: %s (z oboma dodatkami).", quest.name))
	return true
end

chest:aid(CHEST_ACTION_ID)
chest:register()

-- Postacie pokazujace stroje: po jednej za kazdym padem w hali wyboru.
-- Kazda ma wlasny typ NPC z nazwa stroju i jego wygladem z oboma dodatkami.
local function displayName(quest)
	return "Stroj " .. quest.name
end

for _, quest in ipairs(quests) do
	local name = displayName(quest)
	local npcType = Game.createNpcType(name)
	local npcConfig = {}
	npcConfig.name = name
	npcConfig.description = name
	npcConfig.health = 100
	npcConfig.maxHealth = 100
	npcConfig.walkInterval = 0
	npcConfig.walkRadius = 0
	npcConfig.outfit = {
		lookType = quest.male > 0 and quest.male or quest.female,
		lookHead = 78,
		lookBody = 69,
		lookLegs = 58,
		lookFeet = 76,
		lookAddons = 3,
	}
	npcConfig.flags = {
		floorchange = false,
	}
	npcType:register(npcConfig)
end

local displays = GlobalEvent("OtsOutfitDisplays")

function displays.onStartup()
	local placed = 0
	for _, quest in ipairs(quests) do
		local npc = Game.createNpc(displayName(quest), quest.display, false, true)
		if npc then
			npc:setMasterPos(quest.display)
			npc:setDirection(quest.faceSouth and DIRECTION_SOUTH or DIRECTION_NORTH)
			placed = placed + 1
		end
	end
	-- Postacie przy padach nawigacji (typy NPC rejestruje boss_displays.lua).
	local guides = 0
	for _, guide in ipairs(navNpcs) do
		local npc = Game.createNpc(guide.name, guide.position, false, true)
		if npc then
			npc:setMasterPos(guide.position)
			npc:setDirection(DIRECTION_EAST)
			guides = guides + 1
		end
	end
	logger.info("[OTS stroje] Postacie pokazowe: {}/{}, przy padach: {}/{}", placed, #quests, guides, #navNpcs)
	return true
end

displays:register()
