-- OTS: menu teleportow (expowiska, bossy, miasta).
-- Plik generowany z danych serwera (spawny potworow i dzwignie bossow).
-- Wejscie: teleport przy swiatyni w Thais albo komenda !tp.

local ENTRY_ACTION_ID = 64990
local ENTRY_ITEM_ID = 1949 -- magic forcefield
local ENTRY_TOWN = "thais"
local RETURN_ACTION_ID = 64991 -- teleport powrotny do swiatyni

local hunts = {
	{ label = "Exp do 100 (start)", list = {
		{ "Azure Frog (20 exp, 14x)", 32417, 32989, 7 },
		{ "Coral Frog (20 exp, 9x)", 32420, 32984, 7 },
		{ "Crimson Frog (20 exp, 15x)", 32434, 32972, 7 },
		{ "Hyaena (20 exp, 14x)", 32946, 32599, 11 },
		{ "Island Troll (20 exp, 33x)", 32099, 32574, 7 },
		{ "Orchid Frog (20 exp, 8x)", 32421, 32937, 7 },
		{ "Sandcrawler (20 exp, 37x)", 33091, 31448, 7 },
		{ "Spit Nettle (20 exp, 24x)", 32926, 32510, 7 },
		{ "Troll (20 exp, 61x)", 32280, 32133, 8 },
		{ "Water Buffalo (20 exp, 15x)", 32897, 32169, 7 },
		{ "Winter Wolf (20 exp, 33x)", 32025, 31252, 7 },
		{ "Cream Blob (21 exp, 9x)", 33430, 32169, 7 },
		{ "Poison Spider (22 exp, 26x)", 32886, 32865, 8 },
		{ "Bear (23 exp, 13x)", 32169, 32060, 10 },
		{ "Frost Troll (23 exp, 34x)", 32109, 31103, 9 },
		{ "Panda (23 exp, 21x)", 32544, 32856, 7 },
		{ "Wasp (24 exp, 31x)", 32414, 32316, 9 },
		{ "Goblin (25 exp, 42x)", 32532, 31855, 6 },
		{ "Orc (25 exp, 34x)", 32913, 31706, 7 },
		{ "Salamander (25 exp, 35x)", 32847, 32135, 10 },
		{ "Swamp Troll (25 exp, 44x)", 32946, 32171, 8 },
		{ "Polar Bear (28 exp, 18x)", 32242, 31029, 7 },
		{ "Cobra (30 exp, 21x)", 33004, 32587, 7 },
		{ "Crab (30 exp, 17x)", 32179, 32936, 8 },
		{ "Lion (30 exp, 12x)", 32694, 32140, 7 },
		{ "Centipede (34 exp, 35x)", 32180, 32798, 9 },
		{ "Crazed Beggar (35 exp, 11x)", 32890, 31338, 7 },
		{ "Dworc Venomsniper (35 exp, 83x)", 32751, 32934, 8 },
		{ "Emerald Damselfly (35 exp, 26x)", 32814, 32115, 10 },
		{ "Skeleton (35 exp, 67x)", 32452, 32037, 9 },
		{ "Goblin Scavenger (37 exp, 20x)", 33108, 31869, 10 },
		{ "Orc Spearman (38 exp, 46x)", 32899, 31769, 7 },
		{ "Chakoya Toolshaper (40 exp, 72x)", 32421, 31026, 10 },
		{ "Chakoya Tribewarden (40 exp, 44x)", 32507, 31090, 10 },
		{ "Crocodile (40 exp, 32x)", 32537, 32732, 8 },
		{ "Dworc Fleshhunter (40 exp, 61x)", 32647, 32894, 8 },
		{ "Insect Swarm (40 exp, 13x)", 33176, 31354, 7 },
		{ "Rotworm (40 exp, 81x)", 32181, 32720, 9 },
		{ "Tiger (40 exp, 10x)", 32780, 32736, 7 },
		{ "Troll Champion (40 exp, 17x)", 32666, 32007, 9 },
		{ "Elf (42 exp, 21x)", 33110, 32146, 8 },
		{ "Larva (44 exp, 130x)", 33276, 32719, 9 },
		{ "Dwarf (45 exp, 51x)", 32443, 31878, 9 },
		{ "Leaf Golem (45 exp, 49x)", 33163, 31996, 11 },
		{ "Scorpion (45 exp, 29x)", 32214, 31887, 11 },
		{ "Skeleton Warrior (45 exp, 13x)", 32965, 32439, 10 },
		{ "Swampling (45 exp, 9x)", 33330, 31979, 8 },
		{ "Chakoya Windcaller (48 exp, 33x)", 32413, 31073, 10 },
		{ "Smuggler (48 exp, 26x)", 32782, 31364, 6 },
		{ "Marsh Stalker (50 exp, 20x)", 32790, 32153, 10 },
		{ "Minotaur (50 exp, 37x)", 32413, 32190, 15 },
		{ "Minotaur Bruiser (50 exp, 30x)", 31999, 31853, 8 },
		{ "Orc Warrior (50 exp, 49x)", 32970, 31797, 7 },
		{ "Goblin Assassin (52 exp, 16x)", 33063, 31847, 10 },
		{ "Dworc Voodoomaster (55 exp, 23x)", 32682, 32872, 8 },
		{ "Minotaur Poacher (55 exp, 16x)", 31981, 31820, 10 },
		{ "War Wolf (55 exp, 18x)", 33420, 31560, 11 },
		{ "Amazon (60 exp, 30x)", 32811, 31904, 7 },
		{ "Boar (60 exp, 17x)", 32616, 32296, 7 },
		{ "Dwarf Miner (60 exp, 11x)", 32078, 31927, 11 },
		{ "Gnarlhound (60 exp, 26x)", 33119, 31440, 8 },
		{ "Nomad (60 exp, 31x)", 33182, 32533, 8 },
		{ "Toad (60 exp, 36x)", 32337, 32935, 7 },
		{ "Wild Warrior (60 exp, 19x)", 32641, 32385, 8 },
		{ "Bandit (65 exp, 36x)", 32655, 32330, 8 },
		{ "Ghost Wolf (65 exp, 11x)", 32810, 31927, 10 },
		{ "Minotaur Archer (65 exp, 12x)", 32274, 32388, 10 },
		{ "Carrion Worm (70 exp, 35x)", 32266, 32689, 10 },
		{ "Dwarf Soldier (70 exp, 67x)", 32443, 31880, 11 },
		{ "Gang Member (70 exp, 25x)", 32798, 31366, 7 },
		{ "Gloom Wolf (70 exp, 15x)", 32725, 31857, 10 },
		{ "Ladybug (70 exp, 35x)", 33591, 31264, 7 },
		{ "Slug (70 exp, 15x)", 32929, 32155, 9 },
		{ "Elf Scout (75 exp, 12x)", 32746, 31302, 7 },
		{ "Firestarter (80 exp, 17x)", 33062, 32203, 7 },
		{ "Barbarian Headsplitter (85 exp, 37x)", 31950, 31260, 7 },
		{ "Barbarian Skullhunter (85 exp, 29x)", 32049, 31304, 7 },
		{ "Ghoul (85 exp, 41x)", 33335, 31634, 11 },
		{ "Pirate Skeleton (85 exp, 25x)", 32034, 32562, 7 },
		{ "Valkyrie (85 exp, 18x)", 32911, 31881, 8 },
		{ "Barbarian Brutetamer (90 exp, 16x)", 32053, 31337, 7 },
		{ "Gazer (90 exp, 17x)", 32149, 32777, 8 },
		{ "Gladiator (90 exp, 19x)", 32700, 31229, 6 },
		{ "Stalker (90 exp, 70x)", 33080, 32895, 14 },
		{ "Tortoise (90 exp, 74x)", 32401, 32882, 9 },
		{ "Damaged Worker Golem (95 exp, 19x)", 32936, 31250, 8 },
		{ "Dark Apprentice (100 exp, 11x)", 32922, 31081, 5 },
		{ "Novice of the Cult (100 exp, 87x)", 32188, 31232, 9 },
		{ "Quara Mantassin Scout (100 exp, 20x)", 32036, 32699, 9 },
	} },
	{ label = "Exp 100-300", list = {
		{ "Assassin (105 exp, 26x)", 32615, 32474, 9 },
		{ "Rorc (105 exp, 47x)", 32771, 31728, 7 },
		{ "Sibang (105 exp, 63x)", 32832, 32486, 7 },
		{ "Lizard Sentinel (110 exp, 62x)", 32921, 32872, 7 },
		{ "Orc Rider (110 exp, 23x)", 33319, 31443, 7 },
		{ "Orc Shaman (110 exp, 20x)", 32897, 31723, 7 },
		{ "Kongra (115 exp, 52x)", 32853, 32508, 7 },
		{ "Ghost (120 exp, 53x)", 33146, 32998, 14 },
		{ "Scarab (120 exp, 94x)", 33236, 32637, 10 },
		{ "Tarantula (120 exp, 41x)", 32902, 32938, 9 },
		{ "Tarnished Spirit (120 exp, 25x)", 32986, 32424, 8 },
		{ "White Shade (120 exp, 25x)", 33048, 32399, 11 },
		{ "Witch (120 exp, 15x)", 32617, 32479, 9 },
		{ "Manta Ray (125 exp, 8x)", 33562, 31311, 13 },
		{ "Pirate Marauder (125 exp, 54x)", 31951, 32919, 6 },
		{ "Deepling Worker (130 exp, 30x)", 33496, 31296, 14 },
		{ "Troll Legionnaire (140 exp, 15x)", 32747, 31449, 12 },
		{ "Dark Monk (145 exp, 33x)", 32618, 32516, 9 },
		{ "Fire Devil (145 exp, 22x)", 32115, 32584, 8 },
		{ "Merlkin (145 exp, 26x)", 32763, 32499, 9 },
		{ "Carniphila (150 exp, 33x)", 32895, 32595, 7 },
		{ "Corym Charlatan (150 exp, 30x)", 32967, 32083, 11 },
		{ "Cyclops (150 exp, 45x)", 32400, 32068, 8 },
		{ "Frost Giant (150 exp, 27x)", 32363, 31312, 9 },
		{ "Frost Giantess (150 exp, 19x)", 32435, 31313, 9 },
		{ "Gargoyle (150 exp, 45x)", 32319, 32613, 8 },
		{ "Minotaur Mage (150 exp, 10x)", 32260, 32460, 10 },
		{ "Mummy (150 exp, 43x)", 32204, 32679, 9 },
		{ "Mutated Human (150 exp, 31x)", 32657, 31128, 6 },
		{ "Terror Bird (150 exp, 13x)", 32992, 32578, 7 },
		{ "Thornback Tortoise (150 exp, 71x)", 32476, 32894, 9 },
		{ "Lizard Templar (155 exp, 62x)", 32978, 32761, 7 },
		{ "Blood Crab (160 exp, 43x)", 31934, 31118, 8 },
		{ "Deepling Scout (160 exp, 30x)", 33495, 31272, 13 },
		{ "Elephant (160 exp, 17x)", 32949, 32754, 7 },
		{ "Mammoth (160 exp, 38x)", 32091, 31219, 6 },
		{ "Minotaur Guard (160 exp, 21x)", 32412, 32173, 15 },
		{ "Slime (160 exp, 35x)", 33384, 32684, 14 },
		{ "Stone Golem (160 exp, 24x)", 33050, 31519, 11 },
		{ "Terramite (160 exp, 54x)", 33201, 32471, 9 },
		{ "Dwarf Guard (165 exp, 78x)", 32556, 31991, 13 },
		{ "Vampire Pig (165 exp, 10x)", 32745, 31491, 6 },
		{ "Bonelord (170 exp, 43x)", 32080, 32825, 8 },
		{ "Elf Arcanist (175 exp, 14x)", 32683, 31308, 6 },
		{ "Pirate Cutthroat (175 exp, 26x)", 31948, 32910, 4 },
		{ "Gozzler (180 exp, 25x)", 32867, 31062, 7 },
		{ "Mercury Blob (180 exp, 8x)", 32739, 31130, 6 },
		{ "Dark Magician (185 exp, 11x)", 32846, 31132, 5 },
		{ "Dragon Hatchling (185 exp, 23x)", 33100, 31266, 7 },
		{ "Furious Troll (185 exp, 11x)", 32753, 31472, 13 },
		{ "Dryad (190 exp, 19x)", 33245, 31972, 10 },
		{ "Barbarian Bloodwalker (195 exp, 18x)", 32040, 31381, 7 },
		{ "Crypt Shambler (195 exp, 43x)", 33333, 32653, 14 },
		{ "Ghoulish Hyaena (195 exp, 11x)", 33014, 32782, 8 },
		{ "Orc Berserker (195 exp, 66x)", 32888, 31723, 7 },
		{ "Cyclops Drone (200 exp, 23x)", 32534, 31470, 6 },
		{ "Monk (200 exp, 13x)", 33373, 31343, 3 },
		{ "Quara Constrictor Scout (200 exp, 15x)", 32027, 32713, 8 },
		{ "Mad Scientist (205 exp, 12x)", 32848, 31128, 6 },
		{ "Orc Marauder (205 exp, 25x)", 33241, 31517, 7 },
		{ "Iron Servant (210 exp, 86x)", 32760, 32822, 13 },
		{ "Lizard Snakecharmer (210 exp, 17x)", 33258, 31546, 7 },
		{ "Green Djinn (215 exp, 19x)", 33000, 32687, 14 },
		{ "Tomb Servant (215 exp, 19x)", 32921, 32769, 10 },
		{ "Fire Elemental (220 exp, 38x)", 33204, 32824, 15 },
		{ "Wilting Leaf Golem (225 exp, 28x)", 33269, 31983, 11 },
		{ "Demon Skeleton (240 exp, 37x)", 32996, 32477, 11 },
		{ "Acid Blob (250 exp, 11x)", 32674, 31173, 6 },
		{ "Pirate Buccaneer (250 exp, 19x)", 32709, 31356, 6 },
		{ "Cyclops Smith (255 exp, 15x)", 33267, 31658, 11 },
		{ "Corym Skirmisher (260 exp, 27x)", 33036, 32121, 11 },
		{ "Dwarf Geomancer (265 exp, 20x)", 32567, 31382, 14 },
		{ "Orc Leader (270 exp, 13x)", 33070, 31265, 8 },
		{ "Lancer Beetle (275 exp, 30x)", 33278, 31341, 8 },
		{ "Elder Bonelord (280 exp, 15x)", 32129, 32806, 9 },
		{ "Zombie (280 exp, 70x)", 32080, 32968, 10 },
		{ "Ice Golem (295 exp, 37x)", 32236, 31043, 10 },
		{ "Acolyte of the Cult (300 exp, 45x)", 32000, 31119, 10 },
		{ "Death Blob (300 exp, 33x)", 33052, 31121, 9 },
	} },
	{ label = "Exp 300-700", list = {
		{ "Vampire (305 exp, 37x)", 33048, 32942, 14 },
		{ "Haunted Treeling (310 exp, 45x)", 32928, 31459, 7 },
		{ "Forest Fury (330 exp, 9x)", 33202, 32049, 10 },
		{ "Sacred Spider (330 exp, 16x)", 32943, 32726, 10 },
		{ "Swarmer (350 exp, 56x)", 33590, 31290, 7 },
		{ "Quara Constrictor (380 exp, 34x)", 32001, 32759, 12 },
		{ "Adept of the Cult (400 exp, 22x)", 32001, 31145, 10 },
		{ "Bane Bringer (400 exp, 12x)", 32718, 31955, 13 },
		{ "Clay Guardian (400 exp, 34x)", 32314, 32520, 11 },
		{ "Quara Predator Scout (400 exp, 24x)", 31932, 32642, 9 },
		{ "Shadow Pupil (410 exp, 13x)", 33029, 32477, 12 },
		{ "Priestess (420 exp, 20x)", 32962, 32438, 10 },
		{ "Mutated Rat (450 exp, 36x)", 32238, 32716, 12 },
		{ "Wailing Widow (450 exp, 46x)", 33653, 31727, 8 },
		{ "Clomp (475 exp, 34x)", 33635, 31712, 7 },
		{ "Grave Guard (485 exp, 13x)", 32990, 32760, 11 },
		{ "Corym Vanguard (490 exp, 18x)", 33068, 32154, 11 },
		{ "Crystalcrusher (500 exp, 23x)", 32234, 32711, 12 },
		{ "Enlightened of the Cult (500 exp, 27x)", 32124, 31225, 11 },
		{ "Nightstalker (500 exp, 22x)", 32814, 32400, 12 },
		{ "Pooka (500 exp, 10x)", 33485, 32291, 7 },
		{ "Stonerefiner (500 exp, 39x)", 33042, 31977, 13 },
		{ "Wyvern (515 exp, 18x)", 32902, 31798, 14 },
		{ "Earth Elemental (550 exp, 52x)", 32249, 32678, 12 },
		{ "Energy Elemental (550 exp, 38x)", 33524, 32428, 10 },
		{ "Enraged Crystal Golem (550 exp, 23x)", 32913, 31968, 10 },
		{ "Elder Mummy (560 exp, 14x)", 32978, 32755, 12 },
		{ "Bonebeast (580 exp, 29x)", 33421, 32260, 11 },
		{ "Ice Witch (580 exp, 18x)", 32307, 31005, 11 },
		{ "Necromancer (580 exp, 43x)", 32995, 32321, 10 },
		{ "Quara Mantassin (600 exp, 39x)", 32002, 32742, 12 },
		{ "Quara Pincher Scout (600 exp, 25x)", 31930, 32708, 10 },
		{ "Twisted Pooka (600 exp, 32x)", 33548, 32213, 8 },
		{ "Ogre Shaman (625 exp, 22x)", 33543, 31674, 7 },
		{ "Dragon Lord Hatchling (645 exp, 14x)", 32622, 31392, 15 },
		{ "Insectoid Worker (650 exp, 59x)", 33568, 31318, 7 },
		{ "Water Elemental (650 exp, 44x)", 32566, 32836, 9 },
		{ "Sandstone Scorpion (680 exp, 20x)", 32979, 32747, 12 },
		{ "Dragon (700 exp, 55x)", 33211, 31250, 7 },
		{ "Glooth Blob (700 exp, 61x)", 33520, 31905, 7 },
		{ "Pixie (700 exp, 39x)", 33515, 32167, 7 },
		{ "Shark (700 exp, 22x)", 33430, 31766, 15 },
		{ "Swan Maiden (700 exp, 11x)", 33594, 32185, 7 },
	} },
	{ label = "Exp 700-1500", list = {
		{ "Ancient Scarab (720 exp, 31x)", 33381, 32686, 12 },
		{ "Frost Dragon Hatchling (745 exp, 22x)", 32277, 31405, 7 },
		{ "Blood Hand (750 exp, 11x)", 33047, 32362, 11 },
		{ "Death Priest (750 exp, 14x)", 32979, 32742, 12 },
		{ "Mutated Bat (750 exp, 30x)", 32250, 32635, 12 },
		{ "Mutated Tiger (750 exp, 18x)", 33452, 31096, 8 },
		{ "Rot Elemental (750 exp, 36x)", 33598, 31883, 7 },
		{ "Stampor (780 exp, 18x)", 32120, 31026, 12 },
		{ "Bog Raider (800 exp, 26x)", 32710, 31088, 7 },
		{ "Faun (800 exp, 22x)", 33484, 32257, 7 },
		{ "Ogre Brute (800 exp, 36x)", 33640, 31610, 7 },
		{ "Quara Hydromancer Scout (800 exp, 18x)", 31929, 32671, 9 },
		{ "Roaring Lion (800 exp, 19x)", 33129, 32344, 9 },
		{ "Undead Gladiator (800 exp, 22x)", 33547, 31561, 8 },
		{ "Vampire Viscount (800 exp, 23x)", 33041, 31637, 11 },
		{ "Waspoid (830 exp, 54x)", 33596, 31269, 7 },
		{ "Nymph (850 exp, 10x)", 33508, 32287, 7 },
		{ "Askarak Demon (900 exp, 17x)", 33294, 31920, 12 },
		{ "Banshee (900 exp, 17x)", 32959, 32407, 14 },
		{ "Blood Priest (900 exp, 15x)", 33326, 31599, 9 },
		{ "Brimstone Bug (900 exp, 32x)", 33135, 31197, 7 },
		{ "Crystal Spider (900 exp, 28x)", 32389, 31076, 9 },
		{ "Dark Faun (900 exp, 35x)", 33623, 32171, 9 },
		{ "Giant Spider (900 exp, 41x)", 32952, 32922, 10 },
		{ "Killer Caiman (900 exp, 29x)", 33298, 31143, 7 },
		{ "Lich (900 exp, 17x)", 33104, 31783, 15 },
		{ "Mooh'Tah Warrior (900 exp, 37x)", 33674, 31995, 7 },
		{ "Putrid Mummy (900 exp, 23x)", 33329, 32258, 12 },
		{ "Shaburak Demon (900 exp, 25x)", 33249, 31921, 12 },
		{ "Vicious Squire (900 exp, 32x)", 33338, 31591, 9 },
		{ "Wiggler (900 exp, 39x)", 33033, 31856, 11 },
		{ "Boogy (950 exp, 17x)", 33522, 32275, 7 },
		{ "Gravedigger (950 exp, 13x)", 32998, 32475, 11 },
		{ "Massive Energy Elemental (950 exp, 8x)", 33065, 32692, 3 },
		{ "Minotaur Cult Follower (950 exp, 38x)", 31954, 32501, 8 },
		{ "Ogre Savage (950 exp, 13x)", 33706, 31656, 7 },
		{ "Quara Hydromancer (950 exp, 24x)", 32240, 32869, 10 },
		{ "Iks Pututu (980 exp, 30x)", 34076, 31775, 9 },
		{ "Braindeath (985 exp, 15x)", 32872, 32478, 12 },
		{ "Blood Beast (1000 exp, 32x)", 33525, 31962, 7 },
		{ "Crawler (1000 exp, 41x)", 33480, 31240, 7 },
		{ "Deepling Spellsinger (1000 exp, 33x)", 33426, 31230, 11 },
		{ "Weakened Frazzlemaw (1000 exp, 38x)", 33545, 32264, 9 },
		{ "Young Sea Serpent (1000 exp, 16x)", 31977, 31235, 9 },
		{ "Iks Chuka (1050 exp, 44x)", 34006, 31763, 8 },
		{ "Vampire Bride (1050 exp, 17x)", 33006, 32428, 14 },
		{ "Enfeebled Silencer (1100 exp, 29x)", 33546, 32267, 9 },
		{ "Instable Breach Brood (1100 exp, 33x)", 32483, 32410, 10 },
		{ "Lizard Legionnaire (1100 exp, 56x)", 33202, 31236, 7 },
		{ "Lost Husher (1100 exp, 27x)", 32239, 32570, 15 },
		{ "Massive Earth Elemental (1100 exp, 24x)", 32275, 32494, 13 },
		{ "Massive Water Elemental (1100 exp, 19x)", 31965, 32738, 12 },
		{ "Minotaur Cult Prophet (1100 exp, 27x)", 31957, 32484, 8 },
		{ "Orclops Ravager (1100 exp, 21x)", 32739, 32126, 10 },
		{ "Parder (1100 exp, 25x)", 33793, 32798, 7 },
		{ "Spitter (1100 exp, 41x)", 33598, 31247, 5 },
		{ "Vulcongra (1100 exp, 31x)", 32277, 32594, 15 },
		{ "Iks Aucar (1150 exp, 31x)", 34073, 31775, 9 },
		{ "Drillworm (1200 exp, 29x)", 32300, 32636, 13 },
		{ "Exotic Bat (1200 exp, 60x)", 33913, 31447, 8 },
		{ "Hero (1200 exp, 21x)", 33247, 31565, 9 },
		{ "Infected Weeper (1200 exp, 9x)", 33024, 31972, 11 },
		{ "Jungle Moa (1200 exp, 19x)", 33837, 32741, 7 },
		{ "Renegade Knight (1200 exp, 39x)", 33340, 31595, 9 },
		{ "Vicious Manbat (1200 exp, 13x)", 32939, 32413, 14 },
		{ "Golden Servant Replica (1250 exp, 17x)", 32859, 32833, 13 },
		{ "Worker Golem (1250 exp, 66x)", 31047, 32730, 8 },
		{ "Yielothax (1250 exp, 33x)", 32911, 31648, 9 },
		{ "Metal Gargoyle (1278 exp, 48x)", 33508, 32000, 10 },
		{ "Souleater (1300 exp, 129x)", 32879, 32479, 12 },
		{ "Lizard Dragon Priest (1320 exp, 18x)", 33044, 31127, 6 },
		{ "Instable Sparkion (1350 exp, 24x)", 32427, 32409, 10 },
		{ "Minotaur Cult Zealot (1350 exp, 26x)", 31925, 32504, 9 },
		{ "Nightmare Scion (1350 exp, 25x)", 33540, 31555, 9 },
		{ "Diamond Servant Replica (1400 exp, 16x)", 32764, 32820, 13 },
		{ "Exotic Cave Spider (1400 exp, 24x)", 33821, 31423, 8 },
		{ "Massive Fire Elemental (1400 exp, 18x)", 33267, 31810, 14 },
		{ "Lizard High Guard (1450 exp, 157x)", 33119, 31234, 7 },
		{ "Orclops Doomhauler (1450 exp, 10x)", 32732, 32125, 10 },
		{ "Lumbering Carnivor (1452 exp, 17x)", 32812, 32643, 8 },
		{ "Deepling Warrior (1500 exp, 22x)", 33424, 31239, 11 },
		{ "Lost Thrower (1500 exp, 45x)", 32201, 32487, 15 },
		{ "Quara Pincher (1500 exp, 32x)", 32034, 32734, 12 },
		{ "Vile Grandmaster (1500 exp, 39x)", 32374, 31704, 9 },
		{ "Worm Priestess (1500 exp, 26x)", 33623, 32011, 7 },
	} },
	{ label = "Exp 1500-3000", list = {
		{ "Sparkion (1520 exp, 63x)", 32145, 31321, 12 },
		{ "Wyrm (1550 exp, 42x)", 33093, 32418, 14 },
		{ "Minotaur Invader (1600 exp, 12x)", 33672, 31941, 13 },
		{ "Pirat Scoundrel (1600 exp, 26x)", 33841, 31228, 7 },
		{ "Werebadger (1600 exp, 27x)", 33309, 31676, 9 },
		{ "Werefox (1600 exp, 11x)", 33193, 31897, 8 },
		{ "Glooth Golem (1606 exp, 26x)", 33566, 31939, 9 },
		{ "Shaper Matriarch (1650 exp, 32x)", 32840, 32866, 14 },
		{ "Spiky Carnivor (1650 exp, 21x)", 32800, 32609, 10 },
		{ "Lizard Zaogun (1700 exp, 36x)", 33119, 31191, 6 },
		{ "Minotaur Hunter (1700 exp, 37x)", 33532, 32005, 7 },
		{ "Pirat Bombardier (1700 exp, 32x)", 33925, 31202, 6 },
		{ "Devourer (1755 exp, 28x)", 33584, 31887, 9 },
		{ "Glooth Anemone (1755 exp, 38x)", 33569, 31984, 10 },
		{ "Breach Brood (1760 exp, 54x)", 32168, 31388, 11 },
		{ "Broken Shaper (1800 exp, 108x)", 32879, 32692, 14 },
		{ "Eternal Guardian (1800 exp, 25x)", 32807, 32636, 12 },
		{ "Lost Exile (1800 exp, 25x)", 33770, 32251, 14 },
		{ "Nightmare (1800 exp, 24x)", 33678, 32708, 11 },
		{ "Pirat Cutthroat (1800 exp, 23x)", 33794, 31336, 8 },
		{ "Stone Rhino (1800 exp, 9x)", 32924, 32852, 15 },
		{ "Quara Predator (1850 exp, 23x)", 32237, 32927, 10 },
		{ "Cursed Ape (1860 exp, 9x)", 34081, 31842, 10 },
		{ "Glooth Brigand (1900 exp, 40x)", 33716, 32039, 12 },
		{ "Stabilizing Dread Intruder (1900 exp, 20x)", 32051, 31380, 11 },
		{ "Werewolf (1900 exp, 33x)", 33491, 31533, 11 },
		{ "Stabilizing Reality Reaver (1950 exp, 20x)", 32050, 31385, 11 },
		{ "Glooth Bandit (2000 exp, 54x)", 33619, 32024, 12 },
		{ "Lizard Noble (2000 exp, 12x)", 33044, 31138, 4 },
		{ "Wereboar (2000 exp, 25x)", 33305, 31675, 9 },
		{ "Twisted Shaper (2050 exp, 39x)", 32878, 32696, 14 },
		{ "Deepling Guard (2100 exp, 30x)", 33518, 31211, 11 },
		{ "Dragon Lord (2100 exp, 55x)", 33162, 31264, 5 },
		{ "Frost Dragon (2100 exp, 22x)", 32252, 31338, 8 },
		{ "Hydra (2100 exp, 33x)", 33465, 31975, 10 },
		{ "Rustheap Golem (2100 exp, 14x)", 33622, 32100, 15 },
		{ "Spectre (2100 exp, 29x)", 33063, 31759, 13 },
		{ "Werebear (2100 exp, 32x)", 33492, 31535, 11 },
		{ "Menacing Carnivor (2112 exp, 26x)", 32807, 32620, 10 },
		{ "Lizard Chosen (2200 exp, 51x)", 33277, 31125, 9 },
		{ "Minotaur Amazon (2200 exp, 101x)", 31240, 32709, 8 },
		{ "Walker (2200 exp, 13x)", 33716, 31962, 14 },
		{ "Werehyaena (2200 exp, 131x)", 33161, 32479, 10 },
		{ "Werehyaena Shaman (2200 exp, 52x)", 33149, 32368, 10 },
		{ "Werelion (2200 exp, 46x)", 33147, 32246, 11 },
		{ "Lost Basher (2300 exp, 39x)", 32200, 32483, 15 },
		{ "Sea Serpent (2300 exp, 30x)", 31920, 31114, 10 },
		{ "Shock Head (2300 exp, 17x)", 33660, 32541, 7 },
		{ "Werelioness (2300 exp, 41x)", 33082, 32240, 11 },
		{ "White Lion (2300 exp, 15x)", 33096, 32242, 11 },
		{ "War Golem (2310 exp, 72x)", 31111, 32640, 8 },
		{ "Draken Warmaster (2400 exp, 50x)", 33032, 31155, 3 },
		{ "Dread Intruder (2400 exp, 52x)", 32126, 31327, 12 },
		{ "Execowtioner (2400 exp, 67x)", 31318, 32606, 8 },
		{ "Kollos (2400 exp, 20x)", 33598, 31228, 2 },
		{ "Pirat Mate (2400 exp, 35x)", 33932, 31228, 6 },
		{ "Reality Reaver (2480 exp, 68x)", 32131, 31324, 12 },
		{ "Behemoth (2500 exp, 28x)", 33047, 32557, 9 },
		{ "Destroyer (2500 exp, 45x)", 33447, 31838, 8 },
		{ "Elder Wyrm (2500 exp, 49x)", 33059, 32350, 14 },
		{ "Deepworm (2520 exp, 56x)", 33218, 32269, 15 },
		{ "Hellspawn (2550 exp, 55x)", 33479, 31723, 8 },
		{ "Moohtant (2600 exp, 45x)", 31246, 32640, 8 },
		{ "Spidris (2600 exp, 26x)", 33594, 31242, 1 },
		{ "Enslaved Dwarf (2700 exp, 12x)", 33402, 31956, 15 },
		{ "Goggle Cake (2700 exp, 16x)", 33398, 32102, 8 },
		{ "Nibblemaw (2700 exp, 13x)", 33355, 32110, 8 },
		{ "Diremaw (2770 exp, 92x)", 33245, 32356, 15 },
		{ "Diabolic Imp (2900 exp, 20x)", 33157, 31766, 15 },
		{ "Humongous Fungus (2900 exp, 51x)", 33077, 31894, 10 },
		{ "Stone Devourer (2900 exp, 17x)", 33009, 31933, 10 },
		{ "Two-Headed Turtle (2930 exp, 66x)", 33766, 32778, 8 },
		{ "Candy Horror (3000 exp, 16x)", 33419, 32212, 9 },
	} },
	{ label = "Exp 3000-6000", list = {
		{ "Serpent Spawn (3050 exp, 30x)", 32834, 32614, 12 },
		{ "Draken Spellweaver (3100 exp, 38x)", 33118, 31198, 4 },
		{ "Foam Stalker (3120 exp, 22x)", 33765, 32777, 9 },
		{ "Armadile (3200 exp, 24x)", 33000, 31969, 10 },
		{ "Cave Devourer (3380 exp, 33x)", 33316, 32190, 15 },
		{ "Betrayed Wraith (3500 exp, 26x)", 33145, 31658, 11 },
		{ "Ripper Spectre (3500 exp, 27x)", 32754, 32234, 10 },
		{ "Chasm Spawn (3600 exp, 59x)", 33541, 32188, 15 },
		{ "Fury (3600 exp, 24x)", 33268, 31849, 15 },
		{ "Defiler (3700 exp, 28x)", 33233, 31771, 12 },
		{ "Hideous Fungus (3700 exp, 50x)", 33007, 31968, 10 },
		{ "Frazzlemaw (3740 exp, 45x)", 33679, 32517, 7 },
		{ "Hellfire Fighter (3800 exp, 36x)", 33610, 32628, 13 },
		{ "Plaguesmith (3800 exp, 37x)", 33239, 31477, 13 },
		{ "Candy Floss Elemental (3850 exp, 18x)", 33402, 32103, 8 },
		{ "Magma Crawler (3900 exp, 37x)", 33086, 31980, 11 },
		{ "Infernalist (4000 exp, 9x)", 33281, 31862, 15 },
		{ "Lava Lurker (4000 exp, 29x)", 33942, 32261, 14 },
		{ "Lost Soul (4000 exp, 27x)", 33142, 31665, 11 },
		{ "Ravenous Lava Lurker (4000 exp, 47x)", 33993, 32198, 14 },
		{ "Spidris Elite (4000 exp, 20x)", 33507, 31212, 8 },
		{ "Warlock (4000 exp, 19x)", 32402, 31655, 15 },
		{ "Medusa (4050 exp, 41x)", 32808, 32637, 15 },
		{ "Dawnfire Asura (4100 exp, 31x)", 32873, 32819, 9 },
		{ "Midnight Asura (4100 exp, 57x)", 32878, 32820, 9 },
		{ "Retching Horror (4100 exp, 53x)", 33702, 32320, 7 },
		{ "Frost Flower Asura (4200 exp, 16x)", 32846, 32740, 9 },
		{ "Gazer Spectre (4200 exp, 27x)", 32629, 32621, 8 },
		{ "Ogre Rowdy (4200 exp, 28x)", 33844, 31596, 8 },
		{ "Dark Carnisylvan (4400 exp, 22x)", 32595, 32418, 13 },
		{ "Phantasm (4400 exp, 30x)", 33097, 31826, 11 },
		{ "Poisonous Carnisylvan (4400 exp, 21x)", 32609, 32425, 13 },
		{ "Tunnel Tyrant (4420 exp, 34x)", 33315, 32117, 15 },
		{ "Draken Abomination (4500 exp, 23x)", 33108, 31099, 12 },
		{ "Flimsy Lost Soul (4500 exp, 65x)", 33643, 31440, 10 },
		{ "Juvenile Bashmu (4500 exp, 24x)", 34065, 31687, 8 },
		{ "Ghastly Dragon (4600 exp, 9x)", 33042, 31096, 14 },
		{ "Dark Torturer (4650 exp, 60x)", 33615, 32424, 10 },
		{ "Arachnophobica (4700 exp, 52x)", 32019, 32034, 13 },
		{ "Choking Fear (4700 exp, 51x)", 33671, 32327, 7 },
		{ "Crazed Summer Rearguard (4700 exp, 27x)", 32101, 31964, 13 },
		{ "Crazed Winter Rearguard (4700 exp, 36x)", 32082, 32034, 13 },
		{ "Hulking Carnisylvan (4700 exp, 11x)", 32558, 32442, 12 },
		{ "Draken Elite (4750 exp, 10x)", 33101, 31116, 9 },
		{ "Lost Berserker (4800 exp, 28x)", 33060, 31889, 12 },
		{ "Skeleton Elite Warrior (4800 exp, 37x)", 32922, 32262, 10 },
		{ "Bashmu (5000 exp, 33x)", 34066, 31690, 8 },
		{ "Crazed Summer Vanguard (5000 exp, 26x)", 32016, 31943, 13 },
		{ "Hand of Cursed Fate (5000 exp, 12x)", 33437, 32808, 9 },
		{ "Ogre Ruffian (5000 exp, 22x)", 33770, 31583, 7 },
		{ "Crape Man (5040 exp, 50x)", 33827, 32544, 7 },
		{ "Dragolisk (5050 exp, 69x)", 33301, 31084, 13 },
		{ "Feversleep (5060 exp, 27x)", 33718, 32382, 9 },
		{ "Undead Elite Gladiator (5090 exp, 23x)", 32932, 32305, 10 },
		{ "Manticore (5100 exp, 28x)", 33840, 31583, 7 },
		{ "Silencer (5100 exp, 43x)", 33560, 32541, 7 },
		{ "Naga Archer (5150 exp, 31x)", 33677, 32762, 8 },
		{ "Cursed Prospector (5250 exp, 104x)", 33807, 31821, 9 },
		{ "Blemished Spawn (5300 exp, 33x)", 32603, 31801, 10 },
		{ "Venerable Girtablilu (5300 exp, 29x)", 33822, 31779, 10 },
		{ "Crazed Winter Vanguard (5400 exp, 34x)", 32081, 32037, 13 },
		{ "Ironblight (5400 exp, 28x)", 33057, 31891, 12 },
		{ "Hellhound (5440 exp, 39x)", 33403, 31822, 8 },
		{ "Grim Reaper (5500 exp, 49x)", 33543, 31722, 8 },
		{ "Ogre Sage (5500 exp, 17x)", 33841, 31665, 7 },
		{ "Mean Lost Soul (5580 exp, 41x)", 33570, 31536, 10 },
		{ "Rhindeer (5600 exp, 51x)", 33680, 32596, 9 },
		{ "Afflicted Strider (5700 exp, 11x)", 32604, 31732, 10 },
		{ "Harpy (5720 exp, 39x)", 33810, 32621, 7 },
		{ "Makara (5720 exp, 44x)", 33606, 32774, 8 },
		{ "Girtablilu Warrior (5800 exp, 51x)", 33769, 31720, 10 },
		{ "Soul-Broken Harbinger (5800 exp, 35x)", 32082, 32035, 13 },
		{ "Weeper (5800 exp, 26x)", 33012, 31967, 11 },
		{ "Wardragon (5810 exp, 56x)", 33315, 31123, 13 },
		{ "Naga Warrior (5890 exp, 55x)", 33610, 32746, 8 },
		{ "Orewalker (5900 exp, 18x)", 33060, 31898, 12 },
		{ "Son of Verminor (5900 exp, 11x)", 33176, 31756, 12 },
		{ "Varnished Diremaw (5900 exp, 14x)", 32023, 31474, 14 },
		{ "Burster Spectre (6000 exp, 53x)", 33085, 32385, 8 },
		{ "Demon (6000 exp, 49x)", 33413, 31839, 8 },
		{ "Eyeless Devourer (6000 exp, 32x)", 32608, 31732, 10 },
		{ "Insane Siren (6000 exp, 26x)", 32016, 31942, 13 },
	} },
	{ label = "Exp 6000-12000", list = {
		{ "Crypt Warrior (6050 exp, 23x)", 32465, 32481, 9 },
		{ "Guzzlemaw (6050 exp, 53x)", 33610, 32534, 7 },
		{ "Tremendous Tyrant (6100 exp, 11x)", 32043, 31443, 11 },
		{ "Young Goanna (6100 exp, 31x)", 33954, 31560, 7 },
		{ "Demon Outcast (6200 exp, 121x)", 33520, 32334, 10 },
		{ "Lavafungus (6200 exp, 16x)", 32120, 31415, 15 },
		{ "Vexclaw (6248 exp, 44x)", 33417, 32672, 14 },
		{ "Deathling Scout (6300 exp, 30x)", 33530, 31472, 14 },
		{ "Falcon Knight (6300 exp, 25x)", 33330, 31274, 8 },
		{ "Streaked Devourer (6300 exp, 13x)", 32123, 31413, 15 },
		{ "Thanatursus (6300 exp, 53x)", 32019, 32033, 13 },
		{ "Blightwalker (6400 exp, 29x)", 33363, 32378, 13 },
		{ "Deathling Spellsinger (6400 exp, 31x)", 33543, 31473, 14 },
		{ "Priestess of the Wild Sun (6400 exp, 34x)", 33952, 31450, 8 },
		{ "Lavaworm (6500 exp, 17x)", 32119, 31454, 15 },
		{ "Adult Goanna (6650 exp, 37x)", 33853, 31675, 7 },
		{ "Sineater Inferniarch (6750 exp, 49x)", 33794, 32329, 7 },
		{ "Cave Chimera (6800 exp, 14x)", 32087, 31467, 13 },
		{ "Liodile (6860 exp, 41x)", 33763, 32592, 10 },
		{ "Falcon Paladin (6900 exp, 22x)", 33314, 31272, 9 },
		{ "Terrorsleep (6900 exp, 26x)", 33673, 32280, 8 },
		{ "Usurper Knight (6900 exp, 20x)", 32433, 32507, 7 },
		{ "Cobra Assassin (6980 exp, 37x)", 33365, 32823, 8 },
		{ "Usurper Warlock (7000 exp, 9x)", 32473, 32495, 6 },
		{ "Freakish Lost Soul (7020 exp, 29x)", 31915, 32345, 10 },
		{ "True Frost Flower Asura (7069 exp, 30x)", 32814, 32819, 10 },
		{ "Cliff Strider (7100 exp, 18x)", 33069, 31949, 12 },
		{ "Gorger Inferniarch (7180 exp, 40x)", 33791, 32334, 7 },
		{ "Black Sphinx Acolyte (7200 exp, 35x)", 33959, 31449, 8 },
		{ "Grimeleech (7216 exp, 43x)", 33625, 32679, 10 },
		{ "Carnivostrich (7290 exp, 35x)", 33754, 32531, 10 },
		{ "Cobra Scout (7310 exp, 17x)", 33364, 32828, 8 },
		{ "True Midnight Asura (7313 exp, 38x)", 32815, 32821, 10 },
		{ "Burning Gladiator (7350 exp, 40x)", 33862, 31526, 8 },
		{ "Broodrider Inferniarch (7400 exp, 40x)", 33851, 32400, 7 },
		{ "True Dawnfire Asura (7475 exp, 35x)", 32851, 32739, 10 },
		{ "Sphinx (7500 exp, 48x)", 33855, 31429, 9 },
		{ "Undead Dragon (7500 exp, 36x)", 33366, 32377, 13 },
		{ "Cobra Vizier (7650 exp, 19x)", 33373, 32737, 8 },
		{ "Boar Man (7720 exp, 46x)", 33769, 32593, 10 },
		{ "Mega Dragon (7810 exp, 38x)", 33308, 31066, 13 },
		{ "Lava Golem (7900 exp, 24x)", 33089, 31979, 11 },
		{ "Floating Savant (8000 exp, 23x)", 33318, 32085, 9 },
		{ "Hellhunter Inferniarch (8100 exp, 87x)", 33783, 32393, 8 },
		{ "Spellreaper Inferniarch (8350 exp, 108x)", 33783, 32390, 10 },
		{ "Crypt Warden (8400 exp, 45x)", 33871, 31422, 9 },
		{ "Feral Sphinx (8800 exp, 28x)", 33860, 31679, 7 },
		{ "Evil Prospector (9000 exp, 86x)", 33899, 31788, 9 },
		{ "Lamassu (9000 exp, 15x)", 33786, 31542, 7 },
		{ "Animated Feather (9860 exp, 19x)", 32484, 32565, 14 },
		{ "Guardian of Tales (10600 exp, 11x)", 32675, 32713, 12 },
		{ "Knowledge Elemental (10603 exp, 12x)", 32502, 32776, 12 },
		{ "Juggernaut (11200 exp, 35x)", 33512, 31720, 8 },
		{ "Sulphur Spouter (11517 exp, 56x)", 33719, 32829, 14 },
		{ "Mantosaurus (11569 exp, 51x)", 33761, 32844, 14 },
		{ "Stalking Stalk (11569 exp, 31x)", 33604, 32862, 14 },
		{ "Hellflayer (11720 exp, 27x)", 33389, 32431, 13 },
		{ "Sabretooth (11931 exp, 27x)", 33675, 32962, 14 },
	} },
	{ label = "Exp 12000+", list = {
		{ "Headpecker (12026 exp, 27x)", 33760, 32842, 14 },
		{ "Energetic Book (12034 exp, 24x)", 32475, 32683, 12 },
		{ "Mercurial Menace (12095 exp, 46x)", 33772, 32956, 14 },
		{ "Emerald Tortoise (12129 exp, 35x)", 33551, 32891, 14 },
		{ "Gore Horn (12595 exp, 52x)", 33563, 32881, 14 },
		{ "Nighthunter (12647 exp, 29x)", 33563, 32815, 14 },
		{ "Hulking Prehemoth (12690 exp, 50x)", 33564, 32882, 14 },
		{ "Icecold Book (12750 exp, 22x)", 32548, 32625, 13 },
		{ "Gorerilla (13172 exp, 40x)", 33674, 32962, 14 },
		{ "Noxious Ripptor (13190 exp, 50x)", 33766, 32847, 14 },
		{ "Burning Book (13200 exp, 39x)", 32612, 32604, 12 },
		{ "Sulphider (13328 exp, 31x)", 33563, 32839, 14 },
		{ "Cursed Book (13345 exp, 12x)", 32557, 32544, 12 },
		{ "Undertaker (13543 exp, 45x)", 33564, 32806, 14 },
		{ "Shrieking Cry-Stal (13560 exp, 27x)", 33773, 32956, 14 },
		{ "Squid Warden (15300 exp, 17x)", 32485, 32578, 14 },
		{ "Rage Squid (16300 exp, 47x)", 32586, 32611, 12 },
		{ "Sight of Surrender (17000 exp, 9x)", 33534, 32354, 7 },
		{ "Brain Squid (17672 exp, 11x)", 32533, 32764, 12 },
		{ "Brinebrute Inferniarch (20300 exp, 40x)", 33872, 32390, 11 },
		{ "Hazardous Phantom (66000 exp, 15x)", 33945, 31021, 8 },
	} },
}

local bosses = {
	{ "Ahau", 34037, 31714, 10 },
	{ "Anomaly", 32245, 31245, 14 },
	{ "Ascending Ferumbras", 33270, 31477, 14 },
	{ "Brokul", 33522, 31465, 15 },
	{ "Eradicator", 32334, 31284, 14 },
	{ "Foreshock", 32182, 31244, 14 },
	{ "Grand Master Oberon", 33364, 31344, 9 },
	{ "Mazoran", 33593, 32644, 14 },
	{ "Mitmah Vanguard", 34048, 31431, 11 },
	{ "Outburst", 32207, 31284, 14 },
	{ "Plagirath", 33229, 31500, 13 },
	{ "Ragiaz", 33456, 32356, 13 },
	{ "Razzagorn", 33386, 32455, 14 },
	{ "Rupture", 32309, 31248, 14 },
	{ "Scarlett Etzel", 33395, 32661, 6 },
	{ "Shulgrax", 33434, 32785, 13 },
	{ "Tarbaz", 33418, 32849, 11 },
	{ "The Lord of the Lice", 33201, 31475, 11 },
	{ "The Shatterer", 33403, 32465, 13 },
	{ "Zamulosh", 33680, 32741, 11 },
	{ "Spirit of Fertility", 33583, 30993, 14 },
	{ "Urmahlullu the Immaculate (lvl 100+)", 33918, 31626, 8 },
	{ "Arbaziloth (lvl 250+)", 34058, 32396, 14 },
	{ "Bakragore (lvl 250+)", 33078, 32398, 15 },
	{ "Chagorz (lvl 250+)", 33078, 32367, 15 },
	{ "Count Vlarkorth (lvl 250+)", 33455, 31413, 13 },
	{ "Duke Krule (lvl 250+)", 33455, 31493, 13 },
	{ "Earl Osam (lvl 250+)", 33516, 31444, 13 },
	{ "Faceless Bane (lvl 250+)", 33638, 32562, 13 },
	{ "Generator (lvl 250+)", 32208, 32021, 13 },
	{ "Ghulosh (lvl 250+)", 32747, 32773, 10 },
	{ "Gorzindel (lvl 250+)", 32747, 32749, 10 },
	{ "Ichgahal (lvl 250+)", 32978, 32333, 15 },
	{ "King Zelos (lvl 250+)", 33485, 31546, 13 },
	{ "Lady Tenebris (lvl 250+)", 32902, 31623, 14 },
	{ "Lloyd (lvl 250+)", 32759, 32868, 14 },
	{ "Lokathmor (lvl 250+)", 32721, 32749, 10 },
	{ "Lord Azaram (lvl 250+)", 33422, 31493, 13 },
	{ "Mazzinor (lvl 250+)", 32721, 32773, 10 },
	{ "Megasylvan Yselda (lvl 250+)", 32578, 32500, 12 },
	{ "Murcion (lvl 250+)", 32978, 32365, 15 },
	{ "Ratmiral Blackwhiskers (lvl 250+)", 33893, 31388, 15 },
	{ "Sir Nictros (lvl 250+)", 33424, 31413, 13 },
	{ "Tentugly's Head (lvl 250+)", 33792, 31391, 6 },
	{ "The Brainstealer (lvl 250+)", 32530, 31122, 15 },
	{ "The Dread Maiden (lvl 250+)", 33739, 31506, 14 },
	{ "The Enraged Thorn Knight (lvl 250+)", 32657, 32877, 14 },
	{ "The Fear Feaster (lvl 250+)", 33734, 31471, 14 },
	{ "The Last Lore Keeper (lvl 250+)", 32018, 32844, 14 },
	{ "The Nightmare Beast (lvl 250+)", 32212, 32070, 15 },
	{ "The Pale Worm (lvl 250+)", 33772, 31504, 14 },
	{ "The Scourge of Oblivion (lvl 250+)", 32676, 32743, 11 },
	{ "The Time Guardian (lvl 250+)", 33010, 31660, 14 },
	{ "The Unwelcome (lvl 250+)", 33736, 31537, 14 },
	{ "Timira the Many-Headed (lvl 250+)", 33809, 32702, 8 },
	{ "Vemiath (lvl 250+)", 33078, 32333, 15 },
	{ "Soul of Dragonking Zyrtarch (lvl 250+)", 33391, 31178, 10 },
	{ "Magma Bubble (lvl 500+)", 33669, 32926, 15 },
	{ "The Primal Menace (lvl 500+)", 33548, 32752, 14 },
}


local templePosition = nil -- swiatynia w Thais, ustawiana przy starcie serwera
local safeTiles = {} -- pola bezpiecznych stref 3x3
local preparedSpots = {} -- cele, ktore maja juz strefe i teleport powrotny

local function key(pos)
	return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local function isSafe(creature)
	return creature and safeTiles[key(creature:getPosition())] == true
end

local function prepareSpot(center)
	local id = key(center)
	if preparedSpots[id] then
		return
	end
	preparedSpots[id] = true

	local returnPlaced = false
	for dx = -1, 1 do
		for dy = -1, 1 do
			local pos = Position(center.x + dx, center.y + dy, center.z)
			safeTiles[key(pos)] = true
			if not returnPlaced and templePosition and not (dx == 0 and dy == 0) then
				local tile = Tile(pos)
				if tile and tile:isWalkable(false, false, true, true, false) and tile:getItemCount() == 0 then
					local item = Game.createItem(ENTRY_ITEM_ID, 1, pos)
					if item then
						item:setActionId(RETURN_ACTION_ID)
						returnPlaced = true
					end
				end
			end
		end
	end
end

local function travel(player, entry)
	local here = Tile(player:getPosition())
	local protected = isSafe(player) or (here and here:hasFlag(TILESTATE_PROTECTIONZONE))
	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) and not protected and not player:getGroup():getAccess() then
		player:sendCancelMessage("Nie mozesz sie teleportowac w trakcie walki.")
		return
	end

	local destination = Position(entry[2], entry[3], entry[4])
	local tile = Tile(destination)
	if not tile or not tile:isWalkable(false, true, true, true, false) then
		local free = player:getClosestFreePosition(destination, 4)
		if not free or free.x == 0 then
			player:sendCancelMessage("To miejsce jest teraz niedostepne: " .. entry[1])
			return
		end
		destination = free
	end

	local from = player:getPosition()
	if not entry.town then
		prepareSpot(destination)
	end
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	if entry.town then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1])
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1] .. ". Stoisz w bezpiecznej strefie 3x3, obok jest teleport powrotny do Thais.")
	end
end

local openMain

local function openList(player, title, list, back)
	local window = ModalWindow({ title = title, message = "Wybierz cel i kliknij Wybierz." })
	for i = 1, math.min(#list, 250) do
		local entry = list[i]
		window:addChoice(entry[1], function(target)
			travel(target, entry)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		back(target)
	end)
	window:setDefaultEnterButton(1)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
end

local function openHunts(player)
	local window = ModalWindow({ title = "Expowiska", message = "Wybierz przedzial doswiadczenia za potwora." })
	for i = 1, #hunts do
		local group = hunts[i]
		window:addChoice(group.label .. " [" .. #group.list .. "]", function(target)
			openList(target, group.label, group.list, openHunts)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		openMain(target)
	end)
	window:setDefaultEnterButton(1)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
end

local function openTowns(player)
	local list = {}
	for _, town in ipairs(Game.getTowns()) do
		local pos = town:getTemplePosition()
		if pos and pos.x > 0 then
			list[#list + 1] = { town:getName(), pos.x, pos.y, pos.z, town = true }
		end
	end
	table.sort(list, function(a, b)
		local aFirst, bFirst = a[1]:lower() == ENTRY_TOWN, b[1]:lower() == ENTRY_TOWN
		if aFirst ~= bFirst then
			return aFirst
		end
		return a[1] < b[1]
	end)
	openList(player, "Miasta", list, function(target)
		openMain(target)
	end)
end

openMain = function(player)
	local window = ModalWindow({ title = "Teleporty", message = "Dokad chcesz sie przeniesc?" })
	window:addChoice("Expowiska", function(target)
		openHunts(target)
	end)
	window:addChoice("Bossy [" .. #bosses .. "]", function(target)
		openList(target, "Bossy", bosses, function(again)
			openMain(again)
		end)
	end)
	window:addChoice("Miasta", function(target)
		openTowns(target)
	end)
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setDefaultEnterButton(1)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
end

-- Komenda !tp
local command = TalkAction("!tp")

function command.onSay(player, words, param)
	openMain(player)
	return true
end

command:groupType("normal")
command:register()

-- Teleport przy swiatyni w Thais
local entryStep = MoveEvent()

function entryStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	openMain(player)
	return true
end

entryStep:type("stepin")
entryStep:aid(ENTRY_ACTION_ID)
entryStep:register()

-- Teleport powrotny (tylko gracze, potwory zostaja na miejscu)
local returnStep = MoveEvent()

function returnStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or not templePosition then
		return true
	end
	player:teleportTo(templePosition)
	player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	position:sendMagicEffect(CONST_ME_POFF)
	templePosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

returnStep:type("stepin")
returnStep:aid(RETURN_ACTION_ID)
returnStep:register()

-- Bezpieczna strefa: blokada atakow w obie strony na polach 3x3
local safeTarget = EventCallback("OtsSafeZoneTargetCombat")

function safeTarget.creatureOnTargetCombat(attacker, target)
	-- Silnik odczytuje wynik jako true/false: false blokuje atak.
	if isSafe(target) and target:isPlayer() then
		return false
	end
	if attacker and attacker:isPlayer() and isSafe(attacker) then
		return false
	end
	return true
end

safeTarget:register()

local safeArea = EventCallback("OtsSafeZoneAreaCombat")

function safeArea.creatureOnAreaCombat(creature, tile, isAggressive)
	if isAggressive and tile and safeTiles[key(tile:getPosition())] then
		return false
	end
	return true
end

safeArea:register()

local offsets = {
	{ 0, -2 }, { 2, 0 }, { -2, 0 }, { 0, 2 }, { 2, -2 }, { -2, -2 }, { 2, 2 }, { -2, 2 },
	{ 0, -3 }, { 3, 0 }, { -3, 0 }, { 0, 3 }, { 1, -1 }, { -1, -1 }, { 1, 1 }, { -1, 1 },
	{ 0, -1 }, { 1, 0 }, { -1, 0 }, { 0, 1 },
}

local placeEntry = GlobalEvent("OtsTeleportEntry")

function placeEntry.onStartup()
	local temple
	for _, town in ipairs(Game.getTowns()) do
		if town:getName():lower() == ENTRY_TOWN then
			temple = town:getTemplePosition()
			break
		end
	end
	templePosition = temple
	if not temple then
		logger.warn("[OTS teleporty] Nie znaleziono miasta '{}'. Uzyj komendy !tp.", ENTRY_TOWN)
		return true
	end

	for _, offset in ipairs(offsets) do
		local pos = Position(temple.x + offset[1], temple.y + offset[2], temple.z)
		local tile = Tile(pos)
		if tile and tile:isWalkable(false, false, true, true, false) and tile:getItemCount() == 0 and not tile:getHouse() then
			local item = Game.createItem(ENTRY_ITEM_ID, 1, pos)
			if item then
				item:setActionId(ENTRY_ACTION_ID)
				logger.info("[OTS teleporty] Wejscie w Thais: {}, {}, {} (swiatynia: {}, {}, {})", pos.x, pos.y, pos.z, temple.x, temple.y, temple.z)
				return true
			end
		end
	end

	logger.warn("[OTS teleporty] Brak wolnego pola przy swiatyni w Thais. Uzyj komendy !tp.")
	return true
end

placeEntry:register()
