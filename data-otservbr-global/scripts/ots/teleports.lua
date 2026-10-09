-- OTS: menu teleportow (expowiska, bossy, questy, miasta).
-- Plik generowany z danych serwera (spawny potworow i dzwignie bossow).
-- Wejscie: teleport przy swiatyni w Thais albo komenda !tp.

local ENTRY_ACTION_ID = 64990
local ENTRY_ITEM_ID = 1949 -- magic forcefield
local ENTRY_TOWN = "thais"
local RETURN_ACTION_ID = 64991 -- teleport powrotny do swiatyni

local hunts = {
	{ label = "Exp do 100 (start)", list = {
		{ "Azure Frog (20 exp, 14x)", 32372, 32910, 7 },
		{ "Coral Frog (20 exp, 9x)", 32375, 32968, 7 },
		{ "Crimson Frog (20 exp, 15x)", 32400, 32971, 7 },
		{ "Hyaena (20 exp, 14x)", 33006, 32657, 11 },
		{ "Island Troll (20 exp, 33x)", 32133, 32540, 7 },
		{ "Orchid Frog (20 exp, 8x)", 32507, 32914, 7 },
		{ "Sandcrawler (20 exp, 37x)", 33092, 31506, 7 },
		{ "Spit Nettle (20 exp, 24x)", 32997, 32577, 7 },
		{ "Troll (20 exp, 61x)", 32284, 32128, 8 },
		{ "Water Buffalo (20 exp, 15x)", 32920, 32185, 7 },
		{ "Winter Wolf (20 exp, 33x)", 31980, 31281, 7 },
		{ "Cream Blob (21 exp, 9x)", 33422, 32122, 7 },
		{ "Poison Spider (22 exp, 26x)", 32816, 32912, 8 },
		{ "Bear (23 exp, 13x)", 32149, 32047, 10 },
		{ "Frost Troll (23 exp, 34x)", 32093, 31053, 9 },
		{ "Panda (23 exp, 21x)", 32627, 32852, 7 },
		{ "Wasp (24 exp, 31x)", 32420, 32302, 9 },
		{ "Goblin (25 exp, 42x)", 32555, 31830, 6 },
		{ "Orc (25 exp, 34x)", 32898, 31777, 7 },
		{ "Salamander (25 exp, 35x)", 32868, 32169, 10 },
		{ "Swamp Troll (25 exp, 44x)", 32961, 32231, 8 },
		{ "Polar Bear (28 exp, 18x)", 32282, 31064, 7 },
		{ "Cobra (30 exp, 21x)", 32955, 32526, 7 },
		{ "Crab (30 exp, 17x)", 32180, 32938, 8 },
		{ "Lion (30 exp, 12x)", 32691, 32138, 7 },
		{ "Centipede (34 exp, 35x)", 32235, 32774, 9 },
		{ "Crazed Beggar (35 exp, 11x)", 32920, 31274, 7 },
		{ "Dworc Venomsniper (35 exp, 83x)", 32669, 32918, 8 },
		{ "Emerald Damselfly (35 exp, 26x)", 32846, 32098, 10 },
		{ "Skeleton (35 exp, 67x)", 32392, 31982, 9 },
		{ "Goblin Scavenger (37 exp, 20x)", 33107, 31866, 10 },
		{ "Orc Spearman (38 exp, 46x)", 32901, 31772, 7 },
		{ "Chakoya Toolshaper (40 exp, 72x)", 32452, 31066, 10 },
		{ "Chakoya Tribewarden (40 exp, 44x)", 32452, 31073, 10 },
		{ "Crocodile (40 exp, 32x)", 32611, 32677, 8 },
		{ "Dworc Fleshhunter (40 exp, 61x)", 32761, 32869, 8 },
		{ "Insect Swarm (40 exp, 13x)", 33208, 31386, 7 },
		{ "Rotworm (40 exp, 81x)", 32251, 32814, 9 },
		{ "Tiger (40 exp, 10x)", 32722, 32710, 7 },
		{ "Troll Champion (40 exp, 17x)", 32647, 31979, 9 },
		{ "Elf (42 exp, 21x)", 33054, 32199, 8 },
		{ "Larva (44 exp, 130x)", 33223, 32607, 9 },
		{ "Dwarf (45 exp, 51x)", 32551, 31878, 9 },
		{ "Leaf Golem (45 exp, 49x)", 33266, 31993, 11 },
		{ "Scorpion (45 exp, 29x)", 32242, 31923, 11 },
		{ "Skeleton Warrior (45 exp, 13x)", 32973, 32441, 10 },
		{ "Swampling (45 exp, 9x)", 33325, 31952, 8 },
		{ "Chakoya Windcaller (48 exp, 33x)", 32449, 31068, 10 },
		{ "Smuggler (48 exp, 26x)", 32860, 31321, 6 },
		{ "Marsh Stalker (50 exp, 20x)", 32847, 32101, 10 },
		{ "Minotaur (50 exp, 37x)", 32411, 32107, 15 },
		{ "Minotaur Bruiser (50 exp, 30x)", 32039, 31846, 8 },
		{ "Orc Warrior (50 exp, 49x)", 32936, 31705, 7 },
		{ "Goblin Assassin (52 exp, 16x)", 33107, 31867, 10 },
		{ "Dworc Voodoomaster (55 exp, 23x)", 32761, 32868, 8 },
		{ "Minotaur Poacher (55 exp, 16x)", 32001, 31840, 10 },
		{ "War Wolf (55 exp, 18x)", 33423, 31563, 11 },
		{ "Amazon (60 exp, 30x)", 32833, 31925, 7 },
		{ "Boar (60 exp, 17x)", 32601, 32262, 7 },
		{ "Dwarf Miner (60 exp, 11x)", 32069, 31940, 11 },
		{ "Gnarlhound (60 exp, 26x)", 33050, 31514, 8 },
		{ "Nomad (60 exp, 31x)", 33231, 32514, 8 },
		{ "Toad (60 exp, 36x)", 32368, 32963, 7 },
		{ "Wild Warrior (60 exp, 19x)", 32658, 32360, 8 },
		{ "Bandit (65 exp, 36x)", 32657, 32361, 8 },
		{ "Ghost Wolf (65 exp, 11x)", 32789, 31936, 10 },
		{ "Minotaur Archer (65 exp, 12x)", 32251, 32435, 10 },
		{ "Carrion Worm (70 exp, 35x)", 32235, 32711, 10 },
		{ "Dwarf Soldier (70 exp, 67x)", 32511, 31908, 11 },
		{ "Gang Member (70 exp, 25x)", 32828, 31303, 7 },
		{ "Gloom Wolf (70 exp, 15x)", 32788, 31936, 10 },
		{ "Ladybug (70 exp, 35x)", 33544, 31277, 7 },
		{ "Slug (70 exp, 15x)", 32928, 32126, 9 },
		{ "Elf Scout (75 exp, 12x)", 32759, 31280, 7 },
		{ "Firestarter (80 exp, 17x)", 33085, 32157, 7 },
		{ "Barbarian Headsplitter (85 exp, 37x)", 32006, 31272, 7 },
		{ "Barbarian Skullhunter (85 exp, 29x)", 31999, 31270, 7 },
		{ "Ghoul (85 exp, 41x)", 33383, 31667, 11 },
		{ "Pirate Skeleton (85 exp, 25x)", 32040, 32563, 7 },
		{ "Valkyrie (85 exp, 18x)", 32847, 31916, 8 },
		{ "Barbarian Brutetamer (90 exp, 16x)", 32051, 31338, 7 },
		{ "Gazer (90 exp, 17x)", 32087, 32791, 8 },
		{ "Gladiator (90 exp, 19x)", 32654, 31232, 6 },
		{ "Stalker (90 exp, 70x)", 33083, 32978, 14 },
		{ "Tortoise (90 exp, 74x)", 32465, 32939, 9 },
		{ "Damaged Worker Golem (95 exp, 19x)", 32888, 31254, 8 },
		{ "Dark Apprentice (100 exp, 11x)", 32921, 31084, 5 },
		{ "Novice of the Cult (100 exp, 87x)", 32144, 31120, 9 },
		{ "Quara Mantassin Scout (100 exp, 20x)", 31950, 32690, 9 },
	} },
	{ label = "Exp 100-300", list = {
		{ "Assassin (105 exp, 26x)", 32614, 32472, 9 },
		{ "Rorc (105 exp, 47x)", 32782, 31805, 7 },
		{ "Sibang (105 exp, 63x)", 32780, 32540, 7 },
		{ "Lizard Sentinel (110 exp, 62x)", 32919, 32871, 7 },
		{ "Orc Rider (110 exp, 23x)", 33312, 31472, 7 },
		{ "Orc Shaman (110 exp, 20x)", 32932, 31819, 7 },
		{ "Kongra (115 exp, 52x)", 32792, 32550, 7 },
		{ "Ghost (120 exp, 53x)", 33083, 32978, 14 },
		{ "Scarab (120 exp, 94x)", 33163, 32528, 10 },
		{ "Tarantula (120 exp, 41x)", 32877, 32907, 9 },
		{ "Tarnished Spirit (120 exp, 25x)", 33042, 32422, 8 },
		{ "White Shade (120 exp, 25x)", 32976, 32363, 11 },
		{ "Witch (120 exp, 15x)", 32614, 32476, 9 },
		{ "Manta Ray (125 exp, 8x)", 33552, 31293, 13 },
		{ "Pirate Marauder (125 exp, 54x)", 31960, 32805, 6 },
		{ "Deepling Worker (130 exp, 30x)", 33549, 31275, 14 },
		{ "Troll Legionnaire (140 exp, 15x)", 32760, 31454, 12 },
		{ "Dark Monk (145 exp, 33x)", 32614, 32474, 9 },
		{ "Fire Devil (145 exp, 22x)", 32016, 32599, 8 },
		{ "Merlkin (145 exp, 26x)", 32836, 32533, 9 },
		{ "Carniphila (150 exp, 33x)", 32950, 32524, 7 },
		{ "Corym Charlatan (150 exp, 30x)", 33008, 32198, 11 },
		{ "Cyclops (150 exp, 45x)", 32485, 32058, 8 },
		{ "Frost Giant (150 exp, 27x)", 32413, 31302, 9 },
		{ "Frost Giantess (150 exp, 19x)", 32413, 31301, 9 },
		{ "Gargoyle (150 exp, 45x)", 32232, 32579, 8 },
		{ "Minotaur Mage (150 exp, 10x)", 32251, 32433, 10 },
		{ "Mummy (150 exp, 43x)", 32205, 32672, 9 },
		{ "Mutated Human (150 exp, 31x)", 32696, 31162, 6 },
		{ "Terror Bird (150 exp, 13x)", 32994, 32578, 7 },
		{ "Thornback Tortoise (150 exp, 71x)", 32373, 32961, 9 },
		{ "Lizard Templar (155 exp, 62x)", 32920, 32871, 7 },
		{ "Blood Crab (160 exp, 43x)", 31939, 31046, 8 },
		{ "Deepling Scout (160 exp, 30x)", 33493, 31281, 13 },
		{ "Elephant (160 exp, 17x)", 32951, 32750, 7 },
		{ "Mammoth (160 exp, 38x)", 32140, 31289, 6 },
		{ "Minotaur Guard (160 exp, 21x)", 32402, 32102, 15 },
		{ "Slime (160 exp, 35x)", 33393, 32790, 14 },
		{ "Stone Golem (160 exp, 24x)", 33040, 31480, 11 },
		{ "Terramite (160 exp, 54x)", 33200, 32451, 9 },
		{ "Dwarf Guard (165 exp, 78x)", 32528, 31925, 13 },
		{ "Vampire Pig (165 exp, 10x)", 32751, 31483, 6 },
		{ "Bonelord (170 exp, 43x)", 32104, 32774, 8 },
		{ "Elf Arcanist (175 exp, 14x)", 32768, 31290, 6 },
		{ "Pirate Cutthroat (175 exp, 26x)", 31969, 32816, 4 },
		{ "Gozzler (180 exp, 25x)", 32849, 31055, 7 },
		{ "Mercury Blob (180 exp, 8x)", 32696, 31168, 6 },
		{ "Dark Magician (185 exp, 11x)", 32920, 31087, 5 },
		{ "Dragon Hatchling (185 exp, 23x)", 33048, 31172, 7 },
		{ "Furious Troll (185 exp, 11x)", 32752, 31470, 13 },
		{ "Dryad (190 exp, 19x)", 33236, 31974, 10 },
		{ "Barbarian Bloodwalker (195 exp, 18x)", 32001, 31416, 7 },
		{ "Crypt Shambler (195 exp, 43x)", 33375, 32762, 14 },
		{ "Ghoulish Hyaena (195 exp, 11x)", 33000, 32759, 8 },
		{ "Orc Berserker (195 exp, 66x)", 32877, 31790, 7 },
		{ "Cyclops Drone (200 exp, 23x)", 32602, 31417, 6 },
		{ "Monk (200 exp, 13x)", 33373, 31347, 3 },
		{ "Quara Constrictor Scout (200 exp, 15x)", 31949, 32672, 8 },
		{ "Mad Scientist (205 exp, 12x)", 32892, 31097, 6 },
		{ "Orc Marauder (205 exp, 25x)", 33242, 31515, 7 },
		{ "Iron Servant (210 exp, 86x)", 32769, 32871, 13 },
		{ "Lizard Snakecharmer (210 exp, 17x)", 33306, 31506, 7 },
		{ "Green Djinn (215 exp, 19x)", 33062, 32739, 14 },
		{ "Tomb Servant (215 exp, 19x)", 32949, 32761, 10 },
		{ "Fire Elemental (220 exp, 38x)", 33265, 32910, 15 },
		{ "Wilting Leaf Golem (225 exp, 28x)", 33199, 31997, 11 },
		{ "Demon Skeleton (240 exp, 37x)", 33002, 32412, 11 },
		{ "Acid Blob (250 exp, 11x)", 32698, 31162, 6 },
		{ "Pirate Buccaneer (250 exp, 19x)", 32639, 31296, 6 },
		{ "Cyclops Smith (255 exp, 15x)", 33313, 31667, 11 },
		{ "Corym Skirmisher (260 exp, 27x)", 33006, 32196, 11 },
		{ "Dwarf Geomancer (265 exp, 20x)", 32590, 31428, 14 },
		{ "Orc Leader (270 exp, 13x)", 33062, 31333, 8 },
		{ "Lancer Beetle (275 exp, 30x)", 33252, 31379, 8 },
		{ "Elder Bonelord (280 exp, 15x)", 32113, 32804, 9 },
		{ "Zombie (280 exp, 70x)", 32188, 32966, 10 },
		{ "Ice Golem (295 exp, 37x)", 32216, 31065, 10 },
		{ "Acolyte of the Cult (300 exp, 45x)", 32082, 31070, 10 },
		{ "Death Blob (300 exp, 33x)", 33083, 31104, 9 },
	} },
	{ label = "Exp 300-700", list = {
		{ "Vampire (305 exp, 37x)", 33094, 32916, 14 },
		{ "Haunted Treeling (310 exp, 45x)", 32926, 31507, 7 },
		{ "Forest Fury (330 exp, 9x)", 33217, 32041, 10 },
		{ "Sacred Spider (330 exp, 16x)", 32941, 32732, 10 },
		{ "Swarmer (350 exp, 56x)", 33552, 31265, 7 },
		{ "Quara Constrictor (380 exp, 34x)", 32070, 32767, 12 },
		{ "Adept of the Cult (400 exp, 22x)", 32026, 31196, 10 },
		{ "Bane Bringer (400 exp, 12x)", 32740, 31952, 13 },
		{ "Clay Guardian (400 exp, 34x)", 32308, 32587, 11 },
		{ "Quara Predator Scout (400 exp, 24x)", 31950, 32688, 9 },
		{ "Shadow Pupil (410 exp, 13x)", 33005, 32448, 12 },
		{ "Priestess (420 exp, 20x)", 33042, 32405, 10 },
		{ "Mutated Rat (450 exp, 36x)", 32213, 32707, 12 },
		{ "Wailing Widow (450 exp, 46x)", 33674, 31740, 8 },
		{ "Clomp (475 exp, 34x)", 33594, 31672, 7 },
		{ "Grave Guard (485 exp, 13x)", 32960, 32754, 11 },
		{ "Corym Vanguard (490 exp, 18x)", 33071, 32154, 11 },
		{ "Crystalcrusher (500 exp, 23x)", 32187, 32612, 12 },
		{ "Enlightened of the Cult (500 exp, 27x)", 32150, 31231, 11 },
		{ "Nightstalker (500 exp, 22x)", 32849, 32448, 12 },
		{ "Pooka (500 exp, 10x)", 33421, 32233, 7 },
		{ "Stonerefiner (500 exp, 39x)", 33059, 32005, 13 },
		{ "Wyvern (515 exp, 18x)", 32849, 31803, 14 },
		{ "Earth Elemental (550 exp, 52x)", 32337, 32588, 12 },
		{ "Energy Elemental (550 exp, 38x)", 33600, 32380, 10 },
		{ "Enraged Crystal Golem (550 exp, 23x)", 32948, 31951, 10 },
		{ "Elder Mummy (560 exp, 14x)", 32938, 32773, 12 },
		{ "Bonebeast (580 exp, 29x)", 33423, 32263, 11 },
		{ "Ice Witch (580 exp, 18x)", 32278, 31033, 11 },
		{ "Necromancer (580 exp, 43x)", 32996, 32391, 10 },
		{ "Quara Mantassin (600 exp, 39x)", 32080, 32772, 12 },
		{ "Quara Pincher Scout (600 exp, 25x)", 31928, 32692, 10 },
		{ "Twisted Pooka (600 exp, 32x)", 33551, 32210, 8 },
		{ "Ogre Shaman (625 exp, 22x)", 33592, 31674, 7 },
		{ "Dragon Lord Hatchling (645 exp, 14x)", 32561, 31373, 15 },
		{ "Insectoid Worker (650 exp, 59x)", 33551, 31232, 7 },
		{ "Water Elemental (650 exp, 44x)", 32542, 32829, 9 },
		{ "Sandstone Scorpion (680 exp, 20x)", 32944, 32773, 12 },
		{ "Dragon (700 exp, 55x)", 33214, 31252, 7 },
		{ "Glooth Blob (700 exp, 61x)", 33559, 31902, 7 },
		{ "Pixie (700 exp, 39x)", 33434, 32246, 7 },
		{ "Shark (700 exp, 22x)", 33446, 31796, 15 },
		{ "Swan Maiden (700 exp, 11x)", 33542, 32248, 7 },
	} },
	{ label = "Exp 700-1500", list = {
		{ "Ancient Scarab (720 exp, 31x)", 33335, 32640, 12 },
		{ "Frost Dragon Hatchling (745 exp, 22x)", 32197, 31450, 7 },
		{ "Blood Hand (750 exp, 11x)", 32976, 32422, 11 },
		{ "Death Priest (750 exp, 14x)", 32942, 32773, 12 },
		{ "Mutated Bat (750 exp, 30x)", 32323, 32612, 12 },
		{ "Mutated Tiger (750 exp, 18x)", 33535, 31129, 8 },
		{ "Rot Elemental (750 exp, 36x)", 33561, 31905, 7 },
		{ "Stampor (780 exp, 18x)", 32203, 30994, 12 },
		{ "Bog Raider (800 exp, 26x)", 32665, 31094, 7 },
		{ "Faun (800 exp, 22x)", 33565, 32236, 7 },
		{ "Ogre Brute (800 exp, 36x)", 33667, 31597, 7 },
		{ "Quara Hydromancer Scout (800 exp, 18x)", 31949, 32686, 9 },
		{ "Roaring Lion (800 exp, 19x)", 33145, 32335, 9 },
		{ "Undead Gladiator (800 exp, 22x)", 33599, 31603, 8 },
		{ "Vampire Viscount (800 exp, 23x)", 32977, 31612, 11 },
		{ "Waspoid (830 exp, 54x)", 33543, 31240, 7 },
		{ "Nymph (850 exp, 10x)", 33421, 32227, 7 },
		{ "Askarak Demon (900 exp, 17x)", 33292, 31934, 12 },
		{ "Banshee (900 exp, 17x)", 32999, 32427, 14 },
		{ "Blood Priest (900 exp, 15x)", 33297, 31581, 9 },
		{ "Brimstone Bug (900 exp, 32x)", 33146, 31098, 7 },
		{ "Crystal Spider (900 exp, 28x)", 32374, 31051, 9 },
		{ "Dark Faun (900 exp, 35x)", 33571, 32185, 9 },
		{ "Giant Spider (900 exp, 41x)", 32938, 32878, 10 },
		{ "Killer Caiman (900 exp, 29x)", 33277, 31161, 7 },
		{ "Lich (900 exp, 17x)", 33097, 31782, 15 },
		{ "Mooh'Tah Warrior (900 exp, 37x)", 33711, 31927, 7 },
		{ "Putrid Mummy (900 exp, 23x)", 33422, 32310, 12 },
		{ "Shaburak Demon (900 exp, 25x)", 33244, 31938, 12 },
		{ "Vicious Squire (900 exp, 32x)", 33297, 31581, 9 },
		{ "Wiggler (900 exp, 39x)", 32920, 31892, 11 },
		{ "Boogy (950 exp, 17x)", 33564, 32240, 7 },
		{ "Gravedigger (950 exp, 13x)", 33003, 32413, 11 },
		{ "Massive Energy Elemental (950 exp, 8x)", 33061, 32685, 3 },
		{ "Minotaur Cult Follower (950 exp, 38x)", 31942, 32466, 8 },
		{ "Ogre Savage (950 exp, 13x)", 33620, 31711, 7 },
		{ "Quara Hydromancer (950 exp, 24x)", 32272, 32920, 10 },
		{ "Iks Pututu (980 exp, 30x)", 34058, 31861, 9 },
		{ "Braindeath (985 exp, 15x)", 32817, 32428, 12 },
		{ "Blood Beast (1000 exp, 32x)", 33575, 32041, 7 },
		{ "Crawler (1000 exp, 41x)", 33546, 31235, 7 },
		{ "Deepling Spellsinger (1000 exp, 33x)", 33443, 31245, 11 },
		{ "Weakened Frazzlemaw (1000 exp, 38x)", 33571, 32270, 9 },
		{ "Young Sea Serpent (1000 exp, 16x)", 31907, 31254, 9 },
		{ "Iks Chuka (1050 exp, 44x)", 34030, 31855, 8 },
		{ "Vampire Bride (1050 exp, 17x)", 32939, 32420, 14 },
		{ "Enfeebled Silencer (1100 exp, 29x)", 33572, 32271, 9 },
		{ "Instable Breach Brood (1100 exp, 33x)", 32436, 32402, 10 },
		{ "Lizard Legionnaire (1100 exp, 56x)", 33250, 31242, 7 },
		{ "Lost Husher (1100 exp, 27x)", 32201, 32662, 15 },
		{ "Massive Earth Elemental (1100 exp, 24x)", 32241, 32522, 13 },
		{ "Massive Water Elemental (1100 exp, 19x)", 32069, 32773, 12 },
		{ "Minotaur Cult Prophet (1100 exp, 27x)", 31951, 32484, 8 },
		{ "Orclops Ravager (1100 exp, 21x)", 32738, 32124, 10 },
		{ "Parder (1100 exp, 25x)", 33687, 32742, 7 },
		{ "Spitter (1100 exp, 41x)", 33581, 31229, 5 },
		{ "Vulcongra (1100 exp, 31x)", 32214, 32529, 15 },
		{ "Iks Aucar (1150 exp, 31x)", 34061, 31855, 9 },
		{ "Drillworm (1200 exp, 29x)", 32257, 32574, 13 },
		{ "Exotic Bat (1200 exp, 60x)", 33868, 31392, 8 },
		{ "Hero (1200 exp, 21x)", 33297, 31581, 9 },
		{ "Infected Weeper (1200 exp, 9x)", 33022, 31971, 11 },
		{ "Jungle Moa (1200 exp, 19x)", 33807, 32712, 7 },
		{ "Renegade Knight (1200 exp, 39x)", 33298, 31582, 9 },
		{ "Vicious Manbat (1200 exp, 13x)", 32943, 32424, 14 },
		{ "Golden Servant Replica (1250 exp, 17x)", 32769, 32870, 13 },
		{ "Worker Golem (1250 exp, 66x)", 31134, 32655, 8 },
		{ "Yielothax (1250 exp, 33x)", 32944, 31586, 9 },
		{ "Metal Gargoyle (1278 exp, 48x)", 33419, 32088, 10 },
		{ "Souleater (1300 exp, 129x)", 32864, 32446, 12 },
		{ "Lizard Dragon Priest (1320 exp, 18x)", 33096, 31163, 6 },
		{ "Instable Sparkion (1350 exp, 24x)", 32470, 32407, 10 },
		{ "Minotaur Cult Zealot (1350 exp, 26x)", 31959, 32430, 9 },
		{ "Nightmare Scion (1350 exp, 25x)", 33561, 31586, 9 },
		{ "Diamond Servant Replica (1400 exp, 16x)", 32857, 32837, 13 },
		{ "Exotic Cave Spider (1400 exp, 24x)", 33829, 31381, 8 },
		{ "Massive Fire Elemental (1400 exp, 18x)", 33293, 31846, 14 },
		{ "Lizard High Guard (1450 exp, 157x)", 33048, 31171, 7 },
		{ "Orclops Doomhauler (1450 exp, 10x)", 32732, 32122, 10 },
		{ "Lumbering Carnivor (1452 exp, 17x)", 32747, 32629, 8 },
		{ "Deepling Warrior (1500 exp, 22x)", 33504, 31249, 11 },
		{ "Lost Thrower (1500 exp, 45x)", 32212, 32535, 15 },
		{ "Quara Pincher (1500 exp, 32x)", 31940, 32754, 12 },
		{ "Vile Grandmaster (1500 exp, 39x)", 32369, 31678, 9 },
		{ "Worm Priestess (1500 exp, 26x)", 33557, 32005, 7 },
	} },
	{ label = "Exp 1500-3000", list = {
		{ "Sparkion (1520 exp, 63x)", 32178, 31360, 12 },
		{ "Wyrm (1550 exp, 42x)", 33080, 32392, 14 },
		{ "Minotaur Invader (1600 exp, 12x)", 33583, 31948, 13 },
		{ "Pirat Scoundrel (1600 exp, 26x)", 33906, 31187, 7 },
		{ "Werebadger (1600 exp, 27x)", 33389, 31641, 9 },
		{ "Werefox (1600 exp, 11x)", 33130, 31983, 8 },
		{ "Glooth Golem (1606 exp, 26x)", 33652, 31953, 9 },
		{ "Shaper Matriarch (1650 exp, 32x)", 32839, 32868, 14 },
		{ "Spiky Carnivor (1650 exp, 21x)", 32753, 32627, 10 },
		{ "Lizard Zaogun (1700 exp, 36x)", 33116, 31153, 6 },
		{ "Minotaur Hunter (1700 exp, 37x)", 33604, 32016, 7 },
		{ "Pirat Bombardier (1700 exp, 32x)", 33902, 31251, 6 },
		{ "Devourer (1755 exp, 28x)", 33633, 31929, 9 },
		{ "Glooth Anemone (1755 exp, 38x)", 33646, 31954, 10 },
		{ "Breach Brood (1760 exp, 54x)", 32142, 31373, 11 },
		{ "Broken Shaper (1800 exp, 108x)", 32856, 32748, 14 },
		{ "Eternal Guardian (1800 exp, 25x)", 32726, 32575, 12 },
		{ "Lost Exile (1800 exp, 25x)", 33779, 32268, 14 },
		{ "Nightmare (1800 exp, 24x)", 33657, 32673, 11 },
		{ "Pirat Cutthroat (1800 exp, 23x)", 33869, 31351, 8 },
		{ "Stone Rhino (1800 exp, 9x)", 32896, 32858, 15 },
		{ "Quara Predator (1850 exp, 23x)", 32273, 32920, 10 },
		{ "Cursed Ape (1860 exp, 9x)", 34019, 31768, 10 },
		{ "Glooth Brigand (1900 exp, 40x)", 33694, 32002, 12 },
		{ "Stabilizing Dread Intruder (1900 exp, 20x)", 32028, 31351, 11 },
		{ "Werewolf (1900 exp, 33x)", 33424, 31564, 11 },
		{ "Stabilizing Reality Reaver (1950 exp, 20x)", 32034, 31347, 11 },
		{ "Glooth Bandit (2000 exp, 54x)", 33694, 32002, 12 },
		{ "Lizard Noble (2000 exp, 12x)", 33080, 31212, 4 },
		{ "Wereboar (2000 exp, 25x)", 33390, 31641, 9 },
		{ "Twisted Shaper (2050 exp, 39x)", 32856, 32750, 14 },
		{ "Deepling Guard (2100 exp, 30x)", 33504, 31249, 11 },
		{ "Dragon Lord (2100 exp, 55x)", 33223, 31277, 5 },
		{ "Frost Dragon (2100 exp, 22x)", 32229, 31411, 8 },
		{ "Hydra (2100 exp, 33x)", 33500, 31936, 10 },
		{ "Rustheap Golem (2100 exp, 14x)", 33629, 32056, 15 },
		{ "Spectre (2100 exp, 29x)", 33085, 31770, 13 },
		{ "Werebear (2100 exp, 32x)", 33427, 31564, 11 },
		{ "Menacing Carnivor (2112 exp, 26x)", 32752, 32628, 10 },
		{ "Lizard Chosen (2200 exp, 51x)", 33275, 31177, 9 },
		{ "Minotaur Amazon (2200 exp, 101x)", 31337, 32616, 8 },
		{ "Walker (2200 exp, 13x)", 33654, 31975, 14 },
		{ "Werehyaena (2200 exp, 131x)", 33197, 32396, 10 },
		{ "Werehyaena Shaman (2200 exp, 52x)", 33174, 32456, 10 },
		{ "Werelion (2200 exp, 46x)", 33130, 32321, 11 },
		{ "Lost Basher (2300 exp, 39x)", 32304, 32584, 15 },
		{ "Sea Serpent (2300 exp, 30x)", 31898, 31021, 10 },
		{ "Shock Head (2300 exp, 17x)", 33595, 32518, 7 },
		{ "Werelioness (2300 exp, 41x)", 33130, 32320, 11 },
		{ "White Lion (2300 exp, 15x)", 33130, 32321, 11 },
		{ "War Golem (2310 exp, 72x)", 31006, 32682, 8 },
		{ "Draken Warmaster (2400 exp, 50x)", 33082, 31108, 3 },
		{ "Dread Intruder (2400 exp, 52x)", 32147, 31361, 12 },
		{ "Execowtioner (2400 exp, 67x)", 31301, 32678, 8 },
		{ "Kollos (2400 exp, 20x)", 33592, 31224, 2 },
		{ "Pirat Mate (2400 exp, 35x)", 33879, 31228, 6 },
		{ "Reality Reaver (2480 exp, 68x)", 32181, 31365, 12 },
		{ "Behemoth (2500 exp, 28x)", 33011, 32508, 9 },
		{ "Destroyer (2500 exp, 45x)", 33508, 31791, 8 },
		{ "Elder Wyrm (2500 exp, 49x)", 33083, 32391, 14 },
		{ "Deepworm (2520 exp, 56x)", 33278, 32315, 15 },
		{ "Hellspawn (2550 exp, 55x)", 33394, 31726, 8 },
		{ "Moohtant (2600 exp, 45x)", 31302, 32680, 8 },
		{ "Spidris (2600 exp, 26x)", 33521, 31203, 1 },
		{ "Enslaved Dwarf (2700 exp, 12x)", 33400, 31953, 15 },
		{ "Goggle Cake (2700 exp, 16x)", 33438, 32188, 8 },
		{ "Nibblemaw (2700 exp, 13x)", 33370, 32168, 8 },
		{ "Diremaw (2770 exp, 92x)", 33278, 32316, 15 },
		{ "Diabolic Imp (2900 exp, 20x)", 33097, 31782, 15 },
		{ "Humongous Fungus (2900 exp, 51x)", 33044, 31958, 10 },
		{ "Stone Devourer (2900 exp, 17x)", 33060, 31972, 10 },
		{ "Two-Headed Turtle (2930 exp, 66x)", 33766, 32776, 8 },
		{ "Candy Horror (3000 exp, 16x)", 33411, 32156, 9 },
	} },
	{ label = "Exp 3000-6000", list = {
		{ "Serpent Spawn (3050 exp, 30x)", 32742, 32591, 12 },
		{ "Draken Spellweaver (3100 exp, 38x)", 33086, 31116, 4 },
		{ "Foam Stalker (3120 exp, 22x)", 33718, 32741, 9 },
		{ "Armadile (3200 exp, 24x)", 33044, 31959, 10 },
		{ "Cave Devourer (3380 exp, 33x)", 33289, 32174, 15 },
		{ "Betrayed Wraith (3500 exp, 26x)", 33109, 31590, 11 },
		{ "Ripper Spectre (3500 exp, 27x)", 32706, 32247, 10 },
		{ "Chasm Spawn (3600 exp, 59x)", 33461, 32252, 15 },
		{ "Fury (3600 exp, 24x)", 33311, 31835, 15 },
		{ "Defiler (3700 exp, 28x)", 33168, 31768, 12 },
		{ "Hideous Fungus (3700 exp, 50x)", 33044, 31958, 10 },
		{ "Frazzlemaw (3740 exp, 45x)", 33640, 32440, 7 },
		{ "Hellfire Fighter (3800 exp, 36x)", 33673, 32684, 13 },
		{ "Plaguesmith (3800 exp, 37x)", 33232, 31436, 13 },
		{ "Candy Floss Elemental (3850 exp, 18x)", 33429, 32168, 8 },
		{ "Magma Crawler (3900 exp, 37x)", 33079, 31958, 11 },
		{ "Infernalist (4000 exp, 9x)", 33303, 31827, 15 },
		{ "Lava Lurker (4000 exp, 29x)", 33988, 32265, 14 },
		{ "Lost Soul (4000 exp, 27x)", 33109, 31590, 11 },
		{ "Ravenous Lava Lurker (4000 exp, 47x)", 33933, 32203, 14 },
		{ "Spidris Elite (4000 exp, 20x)", 33437, 31273, 8 },
		{ "Warlock (4000 exp, 19x)", 32481, 31618, 15 },
		{ "Medusa (4050 exp, 41x)", 32800, 32630, 15 },
		{ "Dawnfire Asura (4100 exp, 31x)", 32814, 32754, 9 },
		{ "Midnight Asura (4100 exp, 57x)", 32814, 32755, 9 },
		{ "Retching Horror (4100 exp, 53x)", 33643, 32440, 7 },
		{ "Frost Flower Asura (4200 exp, 16x)", 32825, 32798, 9 },
		{ "Gazer Spectre (4200 exp, 27x)", 32678, 32655, 8 },
		{ "Ogre Rowdy (4200 exp, 28x)", 33824, 31647, 8 },
		{ "Dark Carnisylvan (4400 exp, 22x)", 32581, 32465, 13 },
		{ "Phantasm (4400 exp, 30x)", 33062, 31754, 11 },
		{ "Poisonous Carnisylvan (4400 exp, 21x)", 32584, 32463, 13 },
		{ "Tunnel Tyrant (4420 exp, 34x)", 33288, 32176, 15 },
		{ "Draken Abomination (4500 exp, 23x)", 33068, 31086, 12 },
		{ "Flimsy Lost Soul (4500 exp, 65x)", 33599, 31496, 10 },
		{ "Juvenile Bashmu (4500 exp, 24x)", 34043, 31685, 8 },
		{ "Ghastly Dragon (4600 exp, 9x)", 33049, 31108, 14 },
		{ "Dark Torturer (4650 exp, 60x)", 33600, 32381, 10 },
		{ "Arachnophobica (4700 exp, 52x)", 32068, 31950, 13 },
		{ "Choking Fear (4700 exp, 51x)", 33632, 32412, 7 },
		{ "Crazed Summer Rearguard (4700 exp, 27x)", 32085, 32004, 13 },
		{ "Crazed Winter Rearguard (4700 exp, 36x)", 32065, 31949, 13 },
		{ "Hulking Carnisylvan (4700 exp, 11x)", 32560, 32448, 12 },
		{ "Draken Elite (4750 exp, 10x)", 33103, 31116, 9 },
		{ "Lost Berserker (4800 exp, 28x)", 33008, 31924, 12 },
		{ "Skeleton Elite Warrior (4800 exp, 37x)", 32936, 32269, 10 },
		{ "Bashmu (5000 exp, 33x)", 33976, 31689, 8 },
		{ "Crazed Summer Vanguard (5000 exp, 26x)", 32014, 31949, 13 },
		{ "Hand of Cursed Fate (5000 exp, 12x)", 33477, 32808, 9 },
		{ "Ogre Ruffian (5000 exp, 22x)", 33793, 31603, 7 },
		{ "Crape Man (5040 exp, 50x)", 33762, 32545, 7 },
		{ "Dragolisk (5050 exp, 69x)", 33281, 31147, 13 },
		{ "Feversleep (5060 exp, 27x)", 33691, 32291, 9 },
		{ "Undead Elite Gladiator (5090 exp, 23x)", 32938, 32269, 10 },
		{ "Manticore (5100 exp, 28x)", 33920, 31625, 7 },
		{ "Silencer (5100 exp, 43x)", 33640, 32440, 7 },
		{ "Naga Archer (5150 exp, 31x)", 33656, 32753, 8 },
		{ "Cursed Prospector (5250 exp, 104x)", 33836, 31830, 9 },
		{ "Blemished Spawn (5300 exp, 33x)", 32626, 31796, 10 },
		{ "Venerable Girtablilu (5300 exp, 29x)", 33781, 31754, 10 },
		{ "Crazed Winter Vanguard (5400 exp, 34x)", 32066, 31953, 13 },
		{ "Ironblight (5400 exp, 28x)", 33010, 31923, 12 },
		{ "Hellhound (5440 exp, 39x)", 33507, 31790, 8 },
		{ "Grim Reaper (5500 exp, 49x)", 33543, 31725, 8 },
		{ "Ogre Sage (5500 exp, 17x)", 33796, 31603, 7 },
		{ "Mean Lost Soul (5580 exp, 41x)", 33593, 31450, 10 },
		{ "Rhindeer (5600 exp, 51x)", 33732, 32496, 9 },
		{ "Afflicted Strider (5700 exp, 11x)", 32632, 31791, 10 },
		{ "Harpy (5720 exp, 39x)", 33762, 32543, 7 },
		{ "Makara (5720 exp, 44x)", 33657, 32753, 8 },
		{ "Girtablilu Warrior (5800 exp, 51x)", 33781, 31754, 10 },
		{ "Soul-Broken Harbinger (5800 exp, 35x)", 32065, 31949, 13 },
		{ "Weeper (5800 exp, 26x)", 33073, 31960, 11 },
		{ "Wardragon (5810 exp, 56x)", 33237, 31187, 13 },
		{ "Naga Warrior (5890 exp, 55x)", 33657, 32753, 8 },
		{ "Orewalker (5900 exp, 18x)", 33005, 31953, 12 },
		{ "Son of Verminor (5900 exp, 11x)", 33196, 31670, 12 },
		{ "Varnished Diremaw (5900 exp, 14x)", 32048, 31456, 14 },
		{ "Burster Spectre (6000 exp, 53x)", 33085, 32310, 8 },
		{ "Demon (6000 exp, 49x)", 33510, 31790, 8 },
		{ "Eyeless Devourer (6000 exp, 32x)", 32642, 31780, 10 },
		{ "Insane Siren (6000 exp, 26x)", 32015, 31948, 13 },
	} },
	{ label = "Exp 6000-12000", list = {
		{ "Crypt Warrior (6050 exp, 23x)", 32438, 32521, 9 },
		{ "Guzzlemaw (6050 exp, 53x)", 33628, 32458, 7 },
		{ "Tremendous Tyrant (6100 exp, 11x)", 32064, 31464, 11 },
		{ "Young Goanna (6100 exp, 31x)", 33903, 31600, 7 },
		{ "Demon Outcast (6200 exp, 121x)", 33600, 32406, 10 },
		{ "Lavafungus (6200 exp, 16x)", 32126, 31448, 15 },
		{ "Vexclaw (6248 exp, 44x)", 33476, 32703, 14 },
		{ "Deathling Scout (6300 exp, 30x)", 33584, 31424, 14 },
		{ "Falcon Knight (6300 exp, 25x)", 33310, 31287, 8 },
		{ "Streaked Devourer (6300 exp, 13x)", 32128, 31445, 15 },
		{ "Thanatursus (6300 exp, 53x)", 32064, 31949, 13 },
		{ "Blightwalker (6400 exp, 29x)", 33404, 32374, 13 },
		{ "Deathling Spellsinger (6400 exp, 31x)", 33577, 31423, 14 },
		{ "Priestess of the Wild Sun (6400 exp, 34x)", 33868, 31524, 8 },
		{ "Lavaworm (6500 exp, 17x)", 32126, 31447, 15 },
		{ "Adult Goanna (6650 exp, 37x)", 33900, 31580, 7 },
		{ "Sineater Inferniarch (6750 exp, 49x)", 33834, 32335, 7 },
		{ "Cave Chimera (6800 exp, 14x)", 32059, 31443, 13 },
		{ "Liodile (6860 exp, 41x)", 33738, 32578, 10 },
		{ "Falcon Paladin (6900 exp, 22x)", 33296, 31318, 9 },
		{ "Terrorsleep (6900 exp, 26x)", 33684, 32357, 8 },
		{ "Usurper Knight (6900 exp, 20x)", 32460, 32499, 7 },
		{ "Cobra Assassin (6980 exp, 37x)", 33377, 32789, 8 },
		{ "Usurper Warlock (7000 exp, 9x)", 32386, 32464, 6 },
		{ "Freakish Lost Soul (7020 exp, 29x)", 31950, 32300, 10 },
		{ "True Frost Flower Asura (7069 exp, 30x)", 32843, 32805, 10 },
		{ "Cliff Strider (7100 exp, 18x)", 33013, 31925, 12 },
		{ "Gorger Inferniarch (7180 exp, 40x)", 33837, 32355, 7 },
		{ "Black Sphinx Acolyte (7200 exp, 35x)", 33868, 31524, 8 },
		{ "Grimeleech (7216 exp, 43x)", 33657, 32636, 10 },
		{ "Carnivostrich (7290 exp, 35x)", 33723, 32527, 10 },
		{ "Cobra Scout (7310 exp, 17x)", 33376, 32789, 8 },
		{ "True Midnight Asura (7313 exp, 38x)", 32843, 32804, 10 },
		{ "Burning Gladiator (7350 exp, 40x)", 33865, 31524, 8 },
		{ "Broodrider Inferniarch (7400 exp, 40x)", 33836, 32355, 7 },
		{ "True Dawnfire Asura (7475 exp, 35x)", 32841, 32805, 10 },
		{ "Sphinx (7500 exp, 48x)", 33872, 31441, 9 },
		{ "Undead Dragon (7500 exp, 36x)", 33416, 32363, 13 },
		{ "Cobra Vizier (7650 exp, 19x)", 33377, 32789, 8 },
		{ "Boar Man (7720 exp, 46x)", 33735, 32487, 10 },
		{ "Mega Dragon (7810 exp, 38x)", 33280, 31147, 13 },
		{ "Lava Golem (7900 exp, 24x)", 33074, 31959, 11 },
		{ "Floating Savant (8000 exp, 23x)", 33280, 32092, 9 },
		{ "Hellhunter Inferniarch (8100 exp, 87x)", 33844, 32361, 8 },
		{ "Spellreaper Inferniarch (8350 exp, 108x)", 33851, 32301, 10 },
		{ "Crypt Warden (8400 exp, 45x)", 33877, 31448, 9 },
		{ "Feral Sphinx (8800 exp, 28x)", 33900, 31580, 7 },
		{ "Evil Prospector (9000 exp, 86x)", 33835, 31830, 9 },
		{ "Lamassu (9000 exp, 15x)", 33789, 31541, 7 },
		{ "Animated Feather (9860 exp, 19x)", 32494, 32592, 14 },
		{ "Guardian of Tales (10600 exp, 11x)", 32675, 32710, 12 },
		{ "Knowledge Elemental (10603 exp, 12x)", 32438, 32727, 12 },
		{ "Juggernaut (11200 exp, 35x)", 33507, 31790, 8 },
		{ "Sulphur Spouter (11517 exp, 56x)", 33636, 32800, 14 },
		{ "Mantosaurus (11569 exp, 51x)", 33741, 32850, 14 },
		{ "Stalking Stalk (11569 exp, 31x)", 33669, 32841, 14 },
		{ "Hellflayer (11720 exp, 27x)", 33389, 32429, 13 },
		{ "Sabretooth (11931 exp, 27x)", 33608, 32976, 14 },
	} },
	{ label = "Exp 12000+", list = {
		{ "Headpecker (12026 exp, 27x)", 33741, 32850, 14 },
		{ "Energetic Book (12034 exp, 24x)", 32443, 32775, 12 },
		{ "Mercurial Menace (12095 exp, 46x)", 33741, 32850, 14 },
		{ "Emerald Tortoise (12129 exp, 35x)", 33604, 32975, 14 },
		{ "Gore Horn (12595 exp, 52x)", 33605, 32975, 14 },
		{ "Nighthunter (12647 exp, 29x)", 33561, 32827, 14 },
		{ "Hulking Prehemoth (12690 exp, 50x)", 33591, 32904, 14 },
		{ "Icecold Book (12750 exp, 22x)", 32475, 32560, 13 },
		{ "Gorerilla (13172 exp, 40x)", 33591, 32903, 14 },
		{ "Noxious Ripptor (13190 exp, 50x)", 33738, 32880, 14 },
		{ "Burning Book (13200 exp, 39x)", 32683, 32713, 12 },
		{ "Sulphider (13328 exp, 31x)", 33593, 32852, 14 },
		{ "Cursed Book (13345 exp, 12x)", 32608, 32541, 12 },
		{ "Undertaker (13543 exp, 45x)", 33561, 32827, 14 },
		{ "Shrieking Cry-Stal (13560 exp, 27x)", 33740, 32849, 14 },
		{ "Squid Warden (15300 exp, 17x)", 32492, 32594, 14 },
		{ "Rage Squid (16300 exp, 47x)", 32641, 32653, 12 },
		{ "Sight of Surrender (17000 exp, 9x)", 33550, 32348, 7 },
		{ "Brain Squid (17672 exp, 11x)", 32533, 32767, 12 },
		{ "Brinebrute Inferniarch (20300 exp, 40x)", 33822, 32305, 11 },
		{ "Hazardous Phantom (66000 exp, 15x)", 33909, 31084, 8 },
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

local quests = {
	{ "Pits of Inferno: soft boots, avenger, arcane staff, arbalest", func = "OtsPoiStart" },
	{ "Barbarian Arena: bron do wyboru (3 poziomy, 10 walk)", func = "OtsArenaStart" },
	{ "In Service of Yalahar: yalahari armor / mask / leg piece / footwraps", func = "OtsYalaharStart" },
	{ "Soul War: komplet przedmiotow Soul War dla Twojej profesji", func = "OtsSoulWarStart" },
	{ "Demon Helmet: steel boots, demon helmet, demon shield", 33324, 31575, 15, hint = "Pokonaj potwory w sali, pociagnij dzwignie po wschodniej stronie. Skrzynie sa na zachodzie, za kamieniem (pole PZ)." },
	{ "The Annihilator: demon armor, magic sword, stonecutter axe", 33224, 31671, 13, plain = true, hint = "Stan na jednym z czterech pol przy dzwigni i pociagnij ja. Wymagany poziom 100. Skrzynie sa na wschod od sali walki (pola PZ)." },
	{ "Behemoth Quest: guardian halberd, demon shield, golden armor", 33294, 31670, 13, hint = "Skrzynia z nagroda: ok. 11 krokow, kierunek polnoc. Przy skrzyni jest strefa PZ." },
	{ "Black Knight: crown armor, crown shield", 32870, 31943, 11, hint = "Skrzynia z nagroda: ok. 11 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ." },
	{ "Circle Room: war hammer", 32496, 31946, 14, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ." },
	{ "Crusader Helmet: crusader helmet", 32456, 31938, 14, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek zachod. Przy skrzyni jest strefa PZ." },
	{ "Deeper Fibula: tower shield, warrior helmet", 32279, 32469, 10, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek zachod. Przy skrzyni jest strefa PZ." },
	{ "Devil Helmet: devil helmet", 32450, 32150, 15, hint = "Skrzynia z nagroda: ok. 13 krokow, kierunek polnocny wschod. Przy skrzyni jest strefa PZ." },
	{ "Draconia: ice rapier", 32800, 31589, 2, hint = "Skrzynia z nagroda: ok. 6 krokow, kierunek polnoc. Przy skrzyni jest strefa PZ." },
	{ "Noble Armor: crown helmet", 32451, 32042, 8, hint = "Skrzynia z nagroda: ok. 5 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ." },
	{ "Orc Fortress: knight armor", 32974, 31769, 9, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek polnoc. Przy skrzyni jest strefa PZ." },
	{ "The Medusa Quest: medusa shield, blue robe", 33031, 32396, 10, hint = "Skrzynia z nagroda: ok. 17 krokow, kierunek wschod. Przy skrzyni jest strefa PZ." },
	{ "The Queen Of The Banshees: tower shield, boots of haste, giant sword", 32213, 31897, 15, hint = "Skrzynia z nagroda: ok. 12 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ." },
	{ "Vampire Shield: dragon lance, vampire shield", 33190, 31659, 14, hint = "Skrzynia z nagroda: ok. 22 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ." },
}

local HUB_ACTION_ID = 64992 -- pady w hubie expowisk
local hubLobby = Position(30013, 30000, 7)
local hubWings = {
	{ label = "Exp do 100 (89 potworow)", x = 30069, y = 30040, z = 7 },
	{ label = "Exp 100-300 (79 potworow)", x = 30062, y = 30080, z = 7 },
	{ label = "Exp 300-700 (43 potworow)", x = 30035, y = 30120, z = 7 },
	{ label = "Exp 700-1500 (85 potworow)", x = 30066, y = 30160, z = 7 },
	{ label = "Exp 1500-3000 (73 potworow)", x = 30057, y = 30200, z = 7 },
	{ label = "Exp 3000-6000 (82 potworow)", x = 30063, y = 30240, z = 7 },
	{ label = "Exp 6000-12000 (58 potworow)", x = 30045, y = 30280, z = 7 },
	{ label = "Exp 12000+ (21 potworow)", x = 30018, y = 30320, z = 7 },
}
local hubQuestHall = Position(30025, 29960, 7)
local hubPads = {
	["30000:29960:7"] = { lobby = true },
	["30000:30040:7"] = { lobby = true },
	["30000:30080:7"] = { lobby = true },
	["30000:30120:7"] = { lobby = true },
	["30000:30160:7"] = { lobby = true },
	["30000:30200:7"] = { lobby = true },
	["30000:30240:7"] = { lobby = true },
	["30000:30280:7"] = { lobby = true },
	["30000:30320:7"] = { lobby = true },
	["30002:29998:7"] = { wing = 1 },
	["30003:30038:7"] = { hunt = hunts[1].list[1] },
	["30003:30042:7"] = { hunt = hunts[1].list[2] },
	["30003:30078:7"] = { hunt = hunts[2].list[1] },
	["30003:30082:7"] = { hunt = hunts[2].list[2] },
	["30003:30118:7"] = { hunt = hunts[3].list[1] },
	["30003:30122:7"] = { hunt = hunts[3].list[2] },
	["30003:30158:7"] = { hunt = hunts[4].list[1] },
	["30003:30162:7"] = { hunt = hunts[4].list[2] },
	["30003:30198:7"] = { hunt = hunts[5].list[1] },
	["30003:30202:7"] = { hunt = hunts[5].list[2] },
	["30003:30238:7"] = { hunt = hunts[6].list[1] },
	["30003:30242:7"] = { hunt = hunts[6].list[2] },
	["30003:30278:7"] = { hunt = hunts[7].list[1] },
	["30003:30282:7"] = { hunt = hunts[7].list[2] },
	["30003:30318:7"] = { hunt = hunts[8].list[1] },
	["30003:30322:7"] = { hunt = hunts[8].list[2] },
	["30004:29958:7"] = { quest = quests[1] },
	["30004:29962:7"] = { quest = quests[2] },
	["30005:29998:7"] = { wing = 2 },
	["30006:30038:7"] = { hunt = hunts[1].list[3] },
	["30006:30042:7"] = { hunt = hunts[1].list[4] },
	["30006:30078:7"] = { hunt = hunts[2].list[3] },
	["30006:30082:7"] = { hunt = hunts[2].list[4] },
	["30006:30118:7"] = { hunt = hunts[3].list[3] },
	["30006:30122:7"] = { hunt = hunts[3].list[4] },
	["30006:30158:7"] = { hunt = hunts[4].list[3] },
	["30006:30162:7"] = { hunt = hunts[4].list[4] },
	["30006:30198:7"] = { hunt = hunts[5].list[3] },
	["30006:30202:7"] = { hunt = hunts[5].list[4] },
	["30006:30238:7"] = { hunt = hunts[6].list[3] },
	["30006:30242:7"] = { hunt = hunts[6].list[4] },
	["30006:30278:7"] = { hunt = hunts[7].list[3] },
	["30006:30282:7"] = { hunt = hunts[7].list[4] },
	["30006:30318:7"] = { hunt = hunts[8].list[3] },
	["30006:30322:7"] = { hunt = hunts[8].list[4] },
	["30008:29998:7"] = { wing = 3 },
	["30009:29958:7"] = { quest = quests[3] },
	["30009:29962:7"] = { quest = quests[4] },
	["30009:30002:7"] = { outfits = true },
	["30009:30038:7"] = { hunt = hunts[1].list[5] },
	["30009:30042:7"] = { hunt = hunts[1].list[6] },
	["30009:30078:7"] = { hunt = hunts[2].list[5] },
	["30009:30082:7"] = { hunt = hunts[2].list[6] },
	["30009:30118:7"] = { hunt = hunts[3].list[5] },
	["30009:30122:7"] = { hunt = hunts[3].list[6] },
	["30009:30158:7"] = { hunt = hunts[4].list[5] },
	["30009:30162:7"] = { hunt = hunts[4].list[6] },
	["30009:30198:7"] = { hunt = hunts[5].list[5] },
	["30009:30202:7"] = { hunt = hunts[5].list[6] },
	["30009:30238:7"] = { hunt = hunts[6].list[5] },
	["30009:30242:7"] = { hunt = hunts[6].list[6] },
	["30009:30278:7"] = { hunt = hunts[7].list[5] },
	["30009:30282:7"] = { hunt = hunts[7].list[6] },
	["30009:30318:7"] = { hunt = hunts[8].list[5] },
	["30009:30322:7"] = { hunt = hunts[8].list[6] },
	["30011:29998:7"] = { wing = 4 },
	["30012:30038:7"] = { hunt = hunts[1].list[7] },
	["30012:30042:7"] = { hunt = hunts[1].list[8] },
	["30012:30078:7"] = { hunt = hunts[2].list[7] },
	["30012:30082:7"] = { hunt = hunts[2].list[8] },
	["30012:30118:7"] = { hunt = hunts[3].list[7] },
	["30012:30122:7"] = { hunt = hunts[3].list[8] },
	["30012:30158:7"] = { hunt = hunts[4].list[7] },
	["30012:30162:7"] = { hunt = hunts[4].list[8] },
	["30012:30198:7"] = { hunt = hunts[5].list[7] },
	["30012:30202:7"] = { hunt = hunts[5].list[8] },
	["30012:30238:7"] = { hunt = hunts[6].list[7] },
	["30012:30242:7"] = { hunt = hunts[6].list[8] },
	["30012:30278:7"] = { hunt = hunts[7].list[7] },
	["30012:30282:7"] = { hunt = hunts[7].list[8] },
	["30012:30318:7"] = { hunt = hunts[8].list[7] },
	["30012:30322:7"] = { hunt = hunts[8].list[8] },
	["30013:30002:7"] = { thais = true },
	["30014:29958:7"] = { quest = quests[5] },
	["30014:29962:7"] = { quest = quests[6] },
	["30014:29998:7"] = { wing = 5 },
	["30015:30038:7"] = { hunt = hunts[1].list[9] },
	["30015:30042:7"] = { hunt = hunts[1].list[10] },
	["30015:30078:7"] = { hunt = hunts[2].list[9] },
	["30015:30082:7"] = { hunt = hunts[2].list[10] },
	["30015:30118:7"] = { hunt = hunts[3].list[9] },
	["30015:30122:7"] = { hunt = hunts[3].list[10] },
	["30015:30158:7"] = { hunt = hunts[4].list[9] },
	["30015:30162:7"] = { hunt = hunts[4].list[10] },
	["30015:30198:7"] = { hunt = hunts[5].list[9] },
	["30015:30202:7"] = { hunt = hunts[5].list[10] },
	["30015:30238:7"] = { hunt = hunts[6].list[9] },
	["30015:30242:7"] = { hunt = hunts[6].list[10] },
	["30015:30278:7"] = { hunt = hunts[7].list[9] },
	["30015:30282:7"] = { hunt = hunts[7].list[10] },
	["30015:30318:7"] = { hunt = hunts[8].list[9] },
	["30015:30322:7"] = { hunt = hunts[8].list[10] },
	["30017:29998:7"] = { wing = 6 },
	["30017:30002:7"] = { questhall = true },
	["30018:30038:7"] = { hunt = hunts[1].list[11] },
	["30018:30042:7"] = { hunt = hunts[1].list[12] },
	["30018:30078:7"] = { hunt = hunts[2].list[11] },
	["30018:30082:7"] = { hunt = hunts[2].list[12] },
	["30018:30118:7"] = { hunt = hunts[3].list[11] },
	["30018:30122:7"] = { hunt = hunts[3].list[12] },
	["30018:30158:7"] = { hunt = hunts[4].list[11] },
	["30018:30162:7"] = { hunt = hunts[4].list[12] },
	["30018:30198:7"] = { hunt = hunts[5].list[11] },
	["30018:30202:7"] = { hunt = hunts[5].list[12] },
	["30018:30238:7"] = { hunt = hunts[6].list[11] },
	["30018:30242:7"] = { hunt = hunts[6].list[12] },
	["30018:30278:7"] = { hunt = hunts[7].list[11] },
	["30018:30282:7"] = { hunt = hunts[7].list[12] },
	["30018:30318:7"] = { hunt = hunts[8].list[11] },
	["30018:30322:7"] = { hunt = hunts[8].list[12] },
	["30019:29958:7"] = { quest = quests[7] },
	["30019:29962:7"] = { quest = quests[8] },
	["30020:29998:7"] = { wing = 7 },
	["30021:30038:7"] = { hunt = hunts[1].list[13] },
	["30021:30042:7"] = { hunt = hunts[1].list[14] },
	["30021:30078:7"] = { hunt = hunts[2].list[13] },
	["30021:30082:7"] = { hunt = hunts[2].list[14] },
	["30021:30118:7"] = { hunt = hunts[3].list[13] },
	["30021:30122:7"] = { hunt = hunts[3].list[14] },
	["30021:30158:7"] = { hunt = hunts[4].list[13] },
	["30021:30162:7"] = { hunt = hunts[4].list[14] },
	["30021:30198:7"] = { hunt = hunts[5].list[13] },
	["30021:30202:7"] = { hunt = hunts[5].list[14] },
	["30021:30238:7"] = { hunt = hunts[6].list[13] },
	["30021:30242:7"] = { hunt = hunts[6].list[14] },
	["30021:30278:7"] = { hunt = hunts[7].list[13] },
	["30021:30282:7"] = { hunt = hunts[7].list[14] },
	["30021:30318:7"] = { hunt = hunts[8].list[13] },
	["30021:30322:7"] = { hunt = hunts[8].list[14] },
	["30023:29998:7"] = { wing = 8 },
	["30024:29958:7"] = { quest = quests[9] },
	["30024:29962:7"] = { quest = quests[10] },
	["30024:30038:7"] = { hunt = hunts[1].list[15] },
	["30024:30042:7"] = { hunt = hunts[1].list[16] },
	["30024:30078:7"] = { hunt = hunts[2].list[15] },
	["30024:30082:7"] = { hunt = hunts[2].list[16] },
	["30024:30118:7"] = { hunt = hunts[3].list[15] },
	["30024:30122:7"] = { hunt = hunts[3].list[16] },
	["30024:30158:7"] = { hunt = hunts[4].list[15] },
	["30024:30162:7"] = { hunt = hunts[4].list[16] },
	["30024:30198:7"] = { hunt = hunts[5].list[15] },
	["30024:30202:7"] = { hunt = hunts[5].list[16] },
	["30024:30238:7"] = { hunt = hunts[6].list[15] },
	["30024:30242:7"] = { hunt = hunts[6].list[16] },
	["30024:30278:7"] = { hunt = hunts[7].list[15] },
	["30024:30282:7"] = { hunt = hunts[7].list[16] },
	["30024:30318:7"] = { hunt = hunts[8].list[15] },
	["30024:30322:7"] = { hunt = hunts[8].list[16] },
	["30027:30038:7"] = { hunt = hunts[1].list[17] },
	["30027:30042:7"] = { hunt = hunts[1].list[18] },
	["30027:30078:7"] = { hunt = hunts[2].list[17] },
	["30027:30082:7"] = { hunt = hunts[2].list[18] },
	["30027:30118:7"] = { hunt = hunts[3].list[17] },
	["30027:30122:7"] = { hunt = hunts[3].list[18] },
	["30027:30158:7"] = { hunt = hunts[4].list[17] },
	["30027:30162:7"] = { hunt = hunts[4].list[18] },
	["30027:30198:7"] = { hunt = hunts[5].list[17] },
	["30027:30202:7"] = { hunt = hunts[5].list[18] },
	["30027:30238:7"] = { hunt = hunts[6].list[17] },
	["30027:30242:7"] = { hunt = hunts[6].list[18] },
	["30027:30278:7"] = { hunt = hunts[7].list[17] },
	["30027:30282:7"] = { hunt = hunts[7].list[18] },
	["30027:30318:7"] = { hunt = hunts[8].list[17] },
	["30027:30322:7"] = { hunt = hunts[8].list[18] },
	["30029:29958:7"] = { quest = quests[11] },
	["30029:29962:7"] = { quest = quests[12] },
	["30030:30038:7"] = { hunt = hunts[1].list[19] },
	["30030:30042:7"] = { hunt = hunts[1].list[20] },
	["30030:30078:7"] = { hunt = hunts[2].list[19] },
	["30030:30082:7"] = { hunt = hunts[2].list[20] },
	["30030:30118:7"] = { hunt = hunts[3].list[19] },
	["30030:30122:7"] = { hunt = hunts[3].list[20] },
	["30030:30158:7"] = { hunt = hunts[4].list[19] },
	["30030:30162:7"] = { hunt = hunts[4].list[20] },
	["30030:30198:7"] = { hunt = hunts[5].list[19] },
	["30030:30202:7"] = { hunt = hunts[5].list[20] },
	["30030:30238:7"] = { hunt = hunts[6].list[19] },
	["30030:30242:7"] = { hunt = hunts[6].list[20] },
	["30030:30278:7"] = { hunt = hunts[7].list[19] },
	["30030:30282:7"] = { hunt = hunts[7].list[20] },
	["30030:30318:7"] = { hunt = hunts[8].list[19] },
	["30030:30322:7"] = { hunt = hunts[8].list[20] },
	["30033:30038:7"] = { hunt = hunts[1].list[21] },
	["30033:30042:7"] = { hunt = hunts[1].list[22] },
	["30033:30078:7"] = { hunt = hunts[2].list[21] },
	["30033:30082:7"] = { hunt = hunts[2].list[22] },
	["30033:30118:7"] = { hunt = hunts[3].list[21] },
	["30033:30122:7"] = { hunt = hunts[3].list[22] },
	["30033:30158:7"] = { hunt = hunts[4].list[21] },
	["30033:30162:7"] = { hunt = hunts[4].list[22] },
	["30033:30198:7"] = { hunt = hunts[5].list[21] },
	["30033:30202:7"] = { hunt = hunts[5].list[22] },
	["30033:30238:7"] = { hunt = hunts[6].list[21] },
	["30033:30242:7"] = { hunt = hunts[6].list[22] },
	["30033:30278:7"] = { hunt = hunts[7].list[21] },
	["30033:30282:7"] = { hunt = hunts[7].list[22] },
	["30033:30318:7"] = { hunt = hunts[8].list[21] },
	["30034:29958:7"] = { quest = quests[13] },
	["30034:29962:7"] = { quest = quests[14] },
	["30035:30320:7"] = { lobby = true },
	["30036:30038:7"] = { hunt = hunts[1].list[23] },
	["30036:30042:7"] = { hunt = hunts[1].list[24] },
	["30036:30078:7"] = { hunt = hunts[2].list[23] },
	["30036:30082:7"] = { hunt = hunts[2].list[24] },
	["30036:30118:7"] = { hunt = hunts[3].list[23] },
	["30036:30122:7"] = { hunt = hunts[3].list[24] },
	["30036:30158:7"] = { hunt = hunts[4].list[23] },
	["30036:30162:7"] = { hunt = hunts[4].list[24] },
	["30036:30198:7"] = { hunt = hunts[5].list[23] },
	["30036:30202:7"] = { hunt = hunts[5].list[24] },
	["30036:30238:7"] = { hunt = hunts[6].list[23] },
	["30036:30242:7"] = { hunt = hunts[6].list[24] },
	["30036:30278:7"] = { hunt = hunts[7].list[23] },
	["30036:30282:7"] = { hunt = hunts[7].list[24] },
	["30039:29958:7"] = { quest = quests[15] },
	["30039:29962:7"] = { quest = quests[16] },
	["30039:30038:7"] = { hunt = hunts[1].list[25] },
	["30039:30042:7"] = { hunt = hunts[1].list[26] },
	["30039:30078:7"] = { hunt = hunts[2].list[25] },
	["30039:30082:7"] = { hunt = hunts[2].list[26] },
	["30039:30118:7"] = { hunt = hunts[3].list[25] },
	["30039:30122:7"] = { hunt = hunts[3].list[26] },
	["30039:30158:7"] = { hunt = hunts[4].list[25] },
	["30039:30162:7"] = { hunt = hunts[4].list[26] },
	["30039:30198:7"] = { hunt = hunts[5].list[25] },
	["30039:30202:7"] = { hunt = hunts[5].list[26] },
	["30039:30238:7"] = { hunt = hunts[6].list[25] },
	["30039:30242:7"] = { hunt = hunts[6].list[26] },
	["30039:30278:7"] = { hunt = hunts[7].list[25] },
	["30039:30282:7"] = { hunt = hunts[7].list[26] },
	["30042:30038:7"] = { hunt = hunts[1].list[27] },
	["30042:30042:7"] = { hunt = hunts[1].list[28] },
	["30042:30078:7"] = { hunt = hunts[2].list[27] },
	["30042:30082:7"] = { hunt = hunts[2].list[28] },
	["30042:30118:7"] = { hunt = hunts[3].list[27] },
	["30042:30122:7"] = { hunt = hunts[3].list[28] },
	["30042:30158:7"] = { hunt = hunts[4].list[27] },
	["30042:30162:7"] = { hunt = hunts[4].list[28] },
	["30042:30198:7"] = { hunt = hunts[5].list[27] },
	["30042:30202:7"] = { hunt = hunts[5].list[28] },
	["30042:30238:7"] = { hunt = hunts[6].list[27] },
	["30042:30242:7"] = { hunt = hunts[6].list[28] },
	["30042:30278:7"] = { hunt = hunts[7].list[27] },
	["30042:30282:7"] = { hunt = hunts[7].list[28] },
	["30044:29958:7"] = { quest = quests[17] },
	["30044:29962:7"] = { quest = quests[18] },
	["30045:30038:7"] = { hunt = hunts[1].list[29] },
	["30045:30042:7"] = { hunt = hunts[1].list[30] },
	["30045:30078:7"] = { hunt = hunts[2].list[29] },
	["30045:30082:7"] = { hunt = hunts[2].list[30] },
	["30045:30118:7"] = { hunt = hunts[3].list[29] },
	["30045:30122:7"] = { hunt = hunts[3].list[30] },
	["30045:30158:7"] = { hunt = hunts[4].list[29] },
	["30045:30162:7"] = { hunt = hunts[4].list[30] },
	["30045:30198:7"] = { hunt = hunts[5].list[29] },
	["30045:30202:7"] = { hunt = hunts[5].list[30] },
	["30045:30238:7"] = { hunt = hunts[6].list[29] },
	["30045:30242:7"] = { hunt = hunts[6].list[30] },
	["30045:30278:7"] = { hunt = hunts[7].list[29] },
	["30045:30282:7"] = { hunt = hunts[7].list[30] },
	["30048:29960:7"] = { lobby = true },
	["30048:30038:7"] = { hunt = hunts[1].list[31] },
	["30048:30042:7"] = { hunt = hunts[1].list[32] },
	["30048:30078:7"] = { hunt = hunts[2].list[31] },
	["30048:30082:7"] = { hunt = hunts[2].list[32] },
	["30048:30118:7"] = { hunt = hunts[3].list[31] },
	["30048:30122:7"] = { hunt = hunts[3].list[32] },
	["30048:30158:7"] = { hunt = hunts[4].list[31] },
	["30048:30162:7"] = { hunt = hunts[4].list[32] },
	["30048:30198:7"] = { hunt = hunts[5].list[31] },
	["30048:30202:7"] = { hunt = hunts[5].list[32] },
	["30048:30238:7"] = { hunt = hunts[6].list[31] },
	["30048:30242:7"] = { hunt = hunts[6].list[32] },
	["30048:30278:7"] = { hunt = hunts[7].list[31] },
	["30048:30282:7"] = { hunt = hunts[7].list[32] },
	["30051:30038:7"] = { hunt = hunts[1].list[33] },
	["30051:30042:7"] = { hunt = hunts[1].list[34] },
	["30051:30078:7"] = { hunt = hunts[2].list[33] },
	["30051:30082:7"] = { hunt = hunts[2].list[34] },
	["30051:30118:7"] = { hunt = hunts[3].list[33] },
	["30051:30122:7"] = { hunt = hunts[3].list[34] },
	["30051:30158:7"] = { hunt = hunts[4].list[33] },
	["30051:30162:7"] = { hunt = hunts[4].list[34] },
	["30051:30198:7"] = { hunt = hunts[5].list[33] },
	["30051:30202:7"] = { hunt = hunts[5].list[34] },
	["30051:30238:7"] = { hunt = hunts[6].list[33] },
	["30051:30242:7"] = { hunt = hunts[6].list[34] },
	["30051:30278:7"] = { hunt = hunts[7].list[33] },
	["30051:30282:7"] = { hunt = hunts[7].list[34] },
	["30054:30038:7"] = { hunt = hunts[1].list[35] },
	["30054:30042:7"] = { hunt = hunts[1].list[36] },
	["30054:30078:7"] = { hunt = hunts[2].list[35] },
	["30054:30082:7"] = { hunt = hunts[2].list[36] },
	["30054:30118:7"] = { hunt = hunts[3].list[35] },
	["30054:30122:7"] = { hunt = hunts[3].list[36] },
	["30054:30158:7"] = { hunt = hunts[4].list[35] },
	["30054:30162:7"] = { hunt = hunts[4].list[36] },
	["30054:30198:7"] = { hunt = hunts[5].list[35] },
	["30054:30202:7"] = { hunt = hunts[5].list[36] },
	["30054:30238:7"] = { hunt = hunts[6].list[35] },
	["30054:30242:7"] = { hunt = hunts[6].list[36] },
	["30054:30278:7"] = { hunt = hunts[7].list[35] },
	["30054:30282:7"] = { hunt = hunts[7].list[36] },
	["30057:30038:7"] = { hunt = hunts[1].list[37] },
	["30057:30042:7"] = { hunt = hunts[1].list[38] },
	["30057:30078:7"] = { hunt = hunts[2].list[37] },
	["30057:30082:7"] = { hunt = hunts[2].list[38] },
	["30057:30118:7"] = { hunt = hunts[3].list[37] },
	["30057:30122:7"] = { hunt = hunts[3].list[38] },
	["30057:30158:7"] = { hunt = hunts[4].list[37] },
	["30057:30162:7"] = { hunt = hunts[4].list[38] },
	["30057:30198:7"] = { hunt = hunts[5].list[37] },
	["30057:30202:7"] = { hunt = hunts[5].list[38] },
	["30057:30238:7"] = { hunt = hunts[6].list[37] },
	["30057:30242:7"] = { hunt = hunts[6].list[38] },
	["30057:30278:7"] = { hunt = hunts[7].list[37] },
	["30057:30282:7"] = { hunt = hunts[7].list[38] },
	["30060:30038:7"] = { hunt = hunts[1].list[39] },
	["30060:30042:7"] = { hunt = hunts[1].list[40] },
	["30060:30078:7"] = { hunt = hunts[2].list[39] },
	["30060:30082:7"] = { hunt = hunts[2].list[40] },
	["30060:30118:7"] = { hunt = hunts[3].list[39] },
	["30060:30122:7"] = { hunt = hunts[3].list[40] },
	["30060:30158:7"] = { hunt = hunts[4].list[39] },
	["30060:30162:7"] = { hunt = hunts[4].list[40] },
	["30060:30198:7"] = { hunt = hunts[5].list[39] },
	["30060:30202:7"] = { hunt = hunts[5].list[40] },
	["30060:30238:7"] = { hunt = hunts[6].list[39] },
	["30060:30242:7"] = { hunt = hunts[6].list[40] },
	["30060:30278:7"] = { hunt = hunts[7].list[39] },
	["30060:30282:7"] = { hunt = hunts[7].list[40] },
	["30063:30038:7"] = { hunt = hunts[1].list[41] },
	["30063:30042:7"] = { hunt = hunts[1].list[42] },
	["30063:30078:7"] = { hunt = hunts[2].list[41] },
	["30063:30082:7"] = { hunt = hunts[2].list[42] },
	["30063:30118:7"] = { hunt = hunts[3].list[41] },
	["30063:30122:7"] = { hunt = hunts[3].list[42] },
	["30063:30158:7"] = { hunt = hunts[4].list[41] },
	["30063:30162:7"] = { hunt = hunts[4].list[42] },
	["30063:30198:7"] = { hunt = hunts[5].list[41] },
	["30063:30202:7"] = { hunt = hunts[5].list[42] },
	["30063:30238:7"] = { hunt = hunts[6].list[41] },
	["30063:30242:7"] = { hunt = hunts[6].list[42] },
	["30063:30278:7"] = { hunt = hunts[7].list[41] },
	["30063:30282:7"] = { hunt = hunts[7].list[42] },
	["30066:30038:7"] = { hunt = hunts[1].list[43] },
	["30066:30042:7"] = { hunt = hunts[1].list[44] },
	["30066:30078:7"] = { hunt = hunts[2].list[43] },
	["30066:30082:7"] = { hunt = hunts[2].list[44] },
	["30066:30118:7"] = { hunt = hunts[3].list[43] },
	["30066:30158:7"] = { hunt = hunts[4].list[43] },
	["30066:30162:7"] = { hunt = hunts[4].list[44] },
	["30066:30198:7"] = { hunt = hunts[5].list[43] },
	["30066:30202:7"] = { hunt = hunts[5].list[44] },
	["30066:30238:7"] = { hunt = hunts[6].list[43] },
	["30066:30242:7"] = { hunt = hunts[6].list[44] },
	["30066:30278:7"] = { hunt = hunts[7].list[43] },
	["30066:30282:7"] = { hunt = hunts[7].list[44] },
	["30068:30120:7"] = { lobby = true },
	["30069:30038:7"] = { hunt = hunts[1].list[45] },
	["30069:30042:7"] = { hunt = hunts[1].list[46] },
	["30069:30078:7"] = { hunt = hunts[2].list[45] },
	["30069:30082:7"] = { hunt = hunts[2].list[46] },
	["30069:30158:7"] = { hunt = hunts[4].list[45] },
	["30069:30162:7"] = { hunt = hunts[4].list[46] },
	["30069:30198:7"] = { hunt = hunts[5].list[45] },
	["30069:30202:7"] = { hunt = hunts[5].list[46] },
	["30069:30238:7"] = { hunt = hunts[6].list[45] },
	["30069:30242:7"] = { hunt = hunts[6].list[46] },
	["30069:30278:7"] = { hunt = hunts[7].list[45] },
	["30069:30282:7"] = { hunt = hunts[7].list[46] },
	["30072:30038:7"] = { hunt = hunts[1].list[47] },
	["30072:30042:7"] = { hunt = hunts[1].list[48] },
	["30072:30078:7"] = { hunt = hunts[2].list[47] },
	["30072:30082:7"] = { hunt = hunts[2].list[48] },
	["30072:30158:7"] = { hunt = hunts[4].list[47] },
	["30072:30162:7"] = { hunt = hunts[4].list[48] },
	["30072:30198:7"] = { hunt = hunts[5].list[47] },
	["30072:30202:7"] = { hunt = hunts[5].list[48] },
	["30072:30238:7"] = { hunt = hunts[6].list[47] },
	["30072:30242:7"] = { hunt = hunts[6].list[48] },
	["30072:30278:7"] = { hunt = hunts[7].list[47] },
	["30072:30282:7"] = { hunt = hunts[7].list[48] },
	["30075:30038:7"] = { hunt = hunts[1].list[49] },
	["30075:30042:7"] = { hunt = hunts[1].list[50] },
	["30075:30078:7"] = { hunt = hunts[2].list[49] },
	["30075:30082:7"] = { hunt = hunts[2].list[50] },
	["30075:30158:7"] = { hunt = hunts[4].list[49] },
	["30075:30162:7"] = { hunt = hunts[4].list[50] },
	["30075:30198:7"] = { hunt = hunts[5].list[49] },
	["30075:30202:7"] = { hunt = hunts[5].list[50] },
	["30075:30238:7"] = { hunt = hunts[6].list[49] },
	["30075:30242:7"] = { hunt = hunts[6].list[50] },
	["30075:30278:7"] = { hunt = hunts[7].list[49] },
	["30075:30282:7"] = { hunt = hunts[7].list[50] },
	["30078:30038:7"] = { hunt = hunts[1].list[51] },
	["30078:30042:7"] = { hunt = hunts[1].list[52] },
	["30078:30078:7"] = { hunt = hunts[2].list[51] },
	["30078:30082:7"] = { hunt = hunts[2].list[52] },
	["30078:30158:7"] = { hunt = hunts[4].list[51] },
	["30078:30162:7"] = { hunt = hunts[4].list[52] },
	["30078:30198:7"] = { hunt = hunts[5].list[51] },
	["30078:30202:7"] = { hunt = hunts[5].list[52] },
	["30078:30238:7"] = { hunt = hunts[6].list[51] },
	["30078:30242:7"] = { hunt = hunts[6].list[52] },
	["30078:30278:7"] = { hunt = hunts[7].list[51] },
	["30078:30282:7"] = { hunt = hunts[7].list[52] },
	["30081:30038:7"] = { hunt = hunts[1].list[53] },
	["30081:30042:7"] = { hunt = hunts[1].list[54] },
	["30081:30078:7"] = { hunt = hunts[2].list[53] },
	["30081:30082:7"] = { hunt = hunts[2].list[54] },
	["30081:30158:7"] = { hunt = hunts[4].list[53] },
	["30081:30162:7"] = { hunt = hunts[4].list[54] },
	["30081:30198:7"] = { hunt = hunts[5].list[53] },
	["30081:30202:7"] = { hunt = hunts[5].list[54] },
	["30081:30238:7"] = { hunt = hunts[6].list[53] },
	["30081:30242:7"] = { hunt = hunts[6].list[54] },
	["30081:30278:7"] = { hunt = hunts[7].list[53] },
	["30081:30282:7"] = { hunt = hunts[7].list[54] },
	["30084:30038:7"] = { hunt = hunts[1].list[55] },
	["30084:30042:7"] = { hunt = hunts[1].list[56] },
	["30084:30078:7"] = { hunt = hunts[2].list[55] },
	["30084:30082:7"] = { hunt = hunts[2].list[56] },
	["30084:30158:7"] = { hunt = hunts[4].list[55] },
	["30084:30162:7"] = { hunt = hunts[4].list[56] },
	["30084:30198:7"] = { hunt = hunts[5].list[55] },
	["30084:30202:7"] = { hunt = hunts[5].list[56] },
	["30084:30238:7"] = { hunt = hunts[6].list[55] },
	["30084:30242:7"] = { hunt = hunts[6].list[56] },
	["30084:30278:7"] = { hunt = hunts[7].list[55] },
	["30084:30282:7"] = { hunt = hunts[7].list[56] },
	["30087:30038:7"] = { hunt = hunts[1].list[57] },
	["30087:30042:7"] = { hunt = hunts[1].list[58] },
	["30087:30078:7"] = { hunt = hunts[2].list[57] },
	["30087:30082:7"] = { hunt = hunts[2].list[58] },
	["30087:30158:7"] = { hunt = hunts[4].list[57] },
	["30087:30162:7"] = { hunt = hunts[4].list[58] },
	["30087:30198:7"] = { hunt = hunts[5].list[57] },
	["30087:30202:7"] = { hunt = hunts[5].list[58] },
	["30087:30238:7"] = { hunt = hunts[6].list[57] },
	["30087:30242:7"] = { hunt = hunts[6].list[58] },
	["30087:30278:7"] = { hunt = hunts[7].list[57] },
	["30087:30282:7"] = { hunt = hunts[7].list[58] },
	["30089:30280:7"] = { lobby = true },
	["30090:30038:7"] = { hunt = hunts[1].list[59] },
	["30090:30042:7"] = { hunt = hunts[1].list[60] },
	["30090:30078:7"] = { hunt = hunts[2].list[59] },
	["30090:30082:7"] = { hunt = hunts[2].list[60] },
	["30090:30158:7"] = { hunt = hunts[4].list[59] },
	["30090:30162:7"] = { hunt = hunts[4].list[60] },
	["30090:30198:7"] = { hunt = hunts[5].list[59] },
	["30090:30202:7"] = { hunt = hunts[5].list[60] },
	["30090:30238:7"] = { hunt = hunts[6].list[59] },
	["30090:30242:7"] = { hunt = hunts[6].list[60] },
	["30093:30038:7"] = { hunt = hunts[1].list[61] },
	["30093:30042:7"] = { hunt = hunts[1].list[62] },
	["30093:30078:7"] = { hunt = hunts[2].list[61] },
	["30093:30082:7"] = { hunt = hunts[2].list[62] },
	["30093:30158:7"] = { hunt = hunts[4].list[61] },
	["30093:30162:7"] = { hunt = hunts[4].list[62] },
	["30093:30198:7"] = { hunt = hunts[5].list[61] },
	["30093:30202:7"] = { hunt = hunts[5].list[62] },
	["30093:30238:7"] = { hunt = hunts[6].list[61] },
	["30093:30242:7"] = { hunt = hunts[6].list[62] },
	["30096:30038:7"] = { hunt = hunts[1].list[63] },
	["30096:30042:7"] = { hunt = hunts[1].list[64] },
	["30096:30078:7"] = { hunt = hunts[2].list[63] },
	["30096:30082:7"] = { hunt = hunts[2].list[64] },
	["30096:30158:7"] = { hunt = hunts[4].list[63] },
	["30096:30162:7"] = { hunt = hunts[4].list[64] },
	["30096:30198:7"] = { hunt = hunts[5].list[63] },
	["30096:30202:7"] = { hunt = hunts[5].list[64] },
	["30096:30238:7"] = { hunt = hunts[6].list[63] },
	["30096:30242:7"] = { hunt = hunts[6].list[64] },
	["30099:30038:7"] = { hunt = hunts[1].list[65] },
	["30099:30042:7"] = { hunt = hunts[1].list[66] },
	["30099:30078:7"] = { hunt = hunts[2].list[65] },
	["30099:30082:7"] = { hunt = hunts[2].list[66] },
	["30099:30158:7"] = { hunt = hunts[4].list[65] },
	["30099:30162:7"] = { hunt = hunts[4].list[66] },
	["30099:30198:7"] = { hunt = hunts[5].list[65] },
	["30099:30202:7"] = { hunt = hunts[5].list[66] },
	["30099:30238:7"] = { hunt = hunts[6].list[65] },
	["30099:30242:7"] = { hunt = hunts[6].list[66] },
	["30102:30038:7"] = { hunt = hunts[1].list[67] },
	["30102:30042:7"] = { hunt = hunts[1].list[68] },
	["30102:30078:7"] = { hunt = hunts[2].list[67] },
	["30102:30082:7"] = { hunt = hunts[2].list[68] },
	["30102:30158:7"] = { hunt = hunts[4].list[67] },
	["30102:30162:7"] = { hunt = hunts[4].list[68] },
	["30102:30198:7"] = { hunt = hunts[5].list[67] },
	["30102:30202:7"] = { hunt = hunts[5].list[68] },
	["30102:30238:7"] = { hunt = hunts[6].list[67] },
	["30102:30242:7"] = { hunt = hunts[6].list[68] },
	["30105:30038:7"] = { hunt = hunts[1].list[69] },
	["30105:30042:7"] = { hunt = hunts[1].list[70] },
	["30105:30078:7"] = { hunt = hunts[2].list[69] },
	["30105:30082:7"] = { hunt = hunts[2].list[70] },
	["30105:30158:7"] = { hunt = hunts[4].list[69] },
	["30105:30162:7"] = { hunt = hunts[4].list[70] },
	["30105:30198:7"] = { hunt = hunts[5].list[69] },
	["30105:30202:7"] = { hunt = hunts[5].list[70] },
	["30105:30238:7"] = { hunt = hunts[6].list[69] },
	["30105:30242:7"] = { hunt = hunts[6].list[70] },
	["30108:30038:7"] = { hunt = hunts[1].list[71] },
	["30108:30042:7"] = { hunt = hunts[1].list[72] },
	["30108:30078:7"] = { hunt = hunts[2].list[71] },
	["30108:30082:7"] = { hunt = hunts[2].list[72] },
	["30108:30158:7"] = { hunt = hunts[4].list[71] },
	["30108:30162:7"] = { hunt = hunts[4].list[72] },
	["30108:30198:7"] = { hunt = hunts[5].list[71] },
	["30108:30202:7"] = { hunt = hunts[5].list[72] },
	["30108:30238:7"] = { hunt = hunts[6].list[71] },
	["30108:30242:7"] = { hunt = hunts[6].list[72] },
	["30111:30038:7"] = { hunt = hunts[1].list[73] },
	["30111:30042:7"] = { hunt = hunts[1].list[74] },
	["30111:30078:7"] = { hunt = hunts[2].list[73] },
	["30111:30082:7"] = { hunt = hunts[2].list[74] },
	["30111:30158:7"] = { hunt = hunts[4].list[73] },
	["30111:30162:7"] = { hunt = hunts[4].list[74] },
	["30111:30198:7"] = { hunt = hunts[5].list[73] },
	["30111:30238:7"] = { hunt = hunts[6].list[73] },
	["30111:30242:7"] = { hunt = hunts[6].list[74] },
	["30113:30200:7"] = { lobby = true },
	["30114:30038:7"] = { hunt = hunts[1].list[75] },
	["30114:30042:7"] = { hunt = hunts[1].list[76] },
	["30114:30078:7"] = { hunt = hunts[2].list[75] },
	["30114:30082:7"] = { hunt = hunts[2].list[76] },
	["30114:30158:7"] = { hunt = hunts[4].list[75] },
	["30114:30162:7"] = { hunt = hunts[4].list[76] },
	["30114:30238:7"] = { hunt = hunts[6].list[75] },
	["30114:30242:7"] = { hunt = hunts[6].list[76] },
	["30117:30038:7"] = { hunt = hunts[1].list[77] },
	["30117:30042:7"] = { hunt = hunts[1].list[78] },
	["30117:30078:7"] = { hunt = hunts[2].list[77] },
	["30117:30082:7"] = { hunt = hunts[2].list[78] },
	["30117:30158:7"] = { hunt = hunts[4].list[77] },
	["30117:30162:7"] = { hunt = hunts[4].list[78] },
	["30117:30238:7"] = { hunt = hunts[6].list[77] },
	["30117:30242:7"] = { hunt = hunts[6].list[78] },
	["30120:30038:7"] = { hunt = hunts[1].list[79] },
	["30120:30042:7"] = { hunt = hunts[1].list[80] },
	["30120:30078:7"] = { hunt = hunts[2].list[79] },
	["30120:30158:7"] = { hunt = hunts[4].list[79] },
	["30120:30162:7"] = { hunt = hunts[4].list[80] },
	["30120:30238:7"] = { hunt = hunts[6].list[79] },
	["30120:30242:7"] = { hunt = hunts[6].list[80] },
	["30122:30080:7"] = { lobby = true },
	["30123:30038:7"] = { hunt = hunts[1].list[81] },
	["30123:30042:7"] = { hunt = hunts[1].list[82] },
	["30123:30158:7"] = { hunt = hunts[4].list[81] },
	["30123:30162:7"] = { hunt = hunts[4].list[82] },
	["30123:30238:7"] = { hunt = hunts[6].list[81] },
	["30123:30242:7"] = { hunt = hunts[6].list[82] },
	["30125:30240:7"] = { lobby = true },
	["30126:30038:7"] = { hunt = hunts[1].list[83] },
	["30126:30042:7"] = { hunt = hunts[1].list[84] },
	["30126:30158:7"] = { hunt = hunts[4].list[83] },
	["30126:30162:7"] = { hunt = hunts[4].list[84] },
	["30129:30038:7"] = { hunt = hunts[1].list[85] },
	["30129:30042:7"] = { hunt = hunts[1].list[86] },
	["30129:30158:7"] = { hunt = hunts[4].list[85] },
	["30131:30160:7"] = { lobby = true },
	["30132:30038:7"] = { hunt = hunts[1].list[87] },
	["30132:30042:7"] = { hunt = hunts[1].list[88] },
	["30135:30038:7"] = { hunt = hunts[1].list[89] },
	["30137:30040:7"] = { lobby = true },
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

local function inFight(player)
	local here = Tile(player:getPosition())
	local protected = isSafe(player) or (here and here:hasFlag(TILESTATE_PROTECTIONZONE))
	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) and not protected and not player:getGroup():getAccess() then
		player:sendCancelMessage("Nie mozesz sie teleportowac w trakcie walki.")
		return true
	end
	return false
end

local function travel(player, entry)
	if inFight(player) then
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
	local bare = entry.town or entry.plain
	if not bare then
		prepareSpot(destination)
	end
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	if bare then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1])
		if entry.hint then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, entry.hint)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1] .. ". Stoisz w bezpiecznej strefie 3x3, obok jest teleport powrotny do Thais.")
		if entry.hint then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, entry.hint)
		end
	end
end

local openMain

-- Uruchamia cel z listy: zwykly teleport albo quest z wlasnym skryptem.
local function startEntry(player, entry)
	if not entry.func then
		travel(player, entry)
		return
	end
	local start = _G[entry.func]
	if not start then
		player:sendCancelMessage("Ten quest nie jest jeszcze dostepny.")
	elseif not inFight(player) then
		start(player)
	end
end

local function openList(player, title, list, back)
	local window = ModalWindow({ title = title, message = "Wybierz cel i kliknij Wybierz." })
	for i = 1, math.min(#list, 250) do
		local entry = list[i]
		window:addChoice(entry[1], function(target)
			startEntry(target, entry)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		back(target)
	end)
	window:setPriority(true) -- okno przejmuje klawiature: strzalki, Enter, Esc
	-- Klient 15.x czyta te dwa pola w odwrotnej kolejnosci niz wysyla je serwer,
	-- dlatego wartosci sa zamienione: Enter = przycisk 1, Esc = przycisk 2.
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
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
	window:setPriority(true) -- okno przejmuje klawiature: strzalki, Enter, Esc
	-- Klient 15.x czyta te dwa pola w odwrotnej kolejnosci niz wysyla je serwer,
	-- dlatego wartosci sa zamienione: Enter = przycisk 1, Esc = przycisk 2.
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
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
	window:addChoice("Questy [" .. #quests .. "]", function(target)
		openList(target, "Questy", quests, function(again)
			openMain(again)
		end)
	end)
	window:addChoice("Stroje (questy)", function(target)
		if OtsOutfitHall and not inFight(target) then
			OtsOutfitHall(target)
		end
	end)
	window:addChoice("Miasta", function(target)
		openTowns(target)
	end)
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true) -- okno przejmuje klawiature: strzalki, Enter, Esc
	-- Klient 15.x czyta te dwa pola w odwrotnej kolejnosci niz wysyla je serwer,
	-- dlatego wartosci sa zamienione: Enter = przycisk 1, Esc = przycisk 2.
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
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

-- Funkcje hubu sa zdefiniowane nizej, ale uzywa ich juz teleport w swiatyni.
local hubMove, hubLobbyMessage

-- Teleport przy swiatyni w Thais
local entryStep = MoveEvent()

function entryStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	-- Teleport w swiatyni prowadzi do hubu expowisk; pelne menu jest pod komenda !tp.
	hubMove(player, hubLobby, hubLobbyMessage() .. " Bossy, questy i miasta: komenda !tp.")
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

-- Hub expowisk: osobna mapa z korytarzami; kazdy pad to jeden cel.
hubMove = function(player, destination, message)
	local from = player:getPosition()
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	if message then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	end
end

hubLobbyMessage = function()
	local names = {}
	for i = 1, #hubWings do
		names[i] = hubWings[i].label
	end
	return "Hub expowisk. Pady na polnocy, od zachodu: " .. table.concat(names, ", ") .. ". Pady na poludniu: questy na stroje, Thais i hala questow."
end

local hubStep = MoveEvent()

function hubStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local action = hubPads[key(position)]
	if not action then
		return true
	end

	if action.hunt then
		travel(player, action.hunt)
	elseif action.wing then
		local wing = hubWings[action.wing]
		hubMove(player, Position(wing.x, wing.y, wing.z), "Skrzydlo: " .. wing.label .. ". Potwory rosnaco od zachodu na wschod; pady na koncach korytarza wracaja do lobby.")
	elseif action.lobby then
		hubMove(player, hubLobby, hubLobbyMessage())
	elseif action.thais and templePosition then
		hubMove(player, templePosition)
	elseif action.outfits and OtsOutfitHall then
		OtsOutfitHall(player)
	elseif action.questhall then
		hubMove(player, hubQuestHall, "Hala questow: kazdy pad to jeden quest, za padem leza nagrody do zdobycia. Pady na koncach wracaja do lobby.")
	elseif action.quest then
		startEntry(player, action.quest)
	end
	return true
end

hubStep:type("stepin")
hubStep:aid(HUB_ACTION_ID)
hubStep:register()

-- Spojrzenie na pad w hubie pokazuje, dokad prowadzi.
local hubLook = EventCallback("OtsHubPlayerOnLook")

function hubLook.playerOnLook(player, inspectedThing, inspectedPosition, lookDistance)
	if not inspectedThing or not inspectedThing:isItem() or inspectedThing:getActionId() ~= HUB_ACTION_ID then
		return
	end
	local action = hubPads[key(inspectedPosition)]
	if not action then
		return
	end
	local text
	if action.hunt then
		text = "Teleport: " .. action.hunt[1]
	elseif action.wing then
		text = "Skrzydlo: " .. hubWings[action.wing].label
	elseif action.lobby then
		text = "Powrot do lobby hubu"
	elseif action.outfits then
		text = "Questy na stroje"
	elseif action.questhall then
		text = "Hala questow"
	elseif action.quest then
		text = "Quest: " .. action.quest[1]
	else
		text = "Powrot do swiatyni w Thais"
	end
	player:sendTextMessage(MESSAGE_LOOK, text)
end

hubLook:register()

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
