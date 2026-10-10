-- OTS: menu teleportow (expowiska, bossy, questy, miasta).
-- Plik generowany z danych serwera (spawny potworow i dzwignie bossow).
-- Wejscie: teleport przy swiatyni w Thais albo komenda !tp.

local ENTRY_ACTION_ID = 64990
local ENTRY_ITEM_ID = 1949 -- magic forcefield
local ENTRY_TOWN = "thais"
local RETURN_ACTION_ID = 64991 -- teleport powrotny do swiatyni

local hunts = {
	{ label = "Low (exp do 300)", list = {
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
	{ label = "Medium (exp 300-1500)", list = {
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
	{ label = "Hard (exp 1500-6000)", list = {
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
	{ label = "Very Hard (exp 6000+)", list = {
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
	{ "The Frog Prince (arena, HP 55)", 0, 0, 0, arena = { { "The Frog Prince", 1 } } },
	{ "Jailer (arena, HP 65)", 0, 0, 0, arena = { { "Jailer", 1 } } },
	{ "Rotworm Queen (arena, HP 105)", 0, 0, 0, arena = { { "Rotworm Queen", 1 } } },
	{ "Big Boss Trolliver (arena, HP 150)", 0, 0, 0, arena = { { "Big Boss Trolliver", 1 } } },
	{ "Robby the Reckless (arena, HP 155)", 0, 0, 0, arena = { { "Robby the Reckless", 1 } } },
	{ "Mornenion (arena, HP 190)", 0, 0, 0, arena = { { "Mornenion", 1 } } },
	{ "Xenia (arena, HP 200)", 0, 0, 0, arena = { { "Xenia", 1 } } },
	{ "Elvira Hammerthrust (arena, HP 245)", 0, 0, 0, arena = { { "Elvira Hammerthrust", 1 } } },
	{ "Willi Wasp (arena, HP 250)", 0, 0, 0, arena = { { "Willi Wasp", 1 } } },
	{ "Fleabringer (arena, HP 265)", 0, 0, 0, arena = { { "Fleabringer", 1 } } },
	{ "Jesse the Wicked (arena, HP 280)", 0, 0, 0, arena = { { "Jesse the Wicked", 1 } } },
	{ "Smuggler Baron Silvertoe (arena, HP 280)", 0, 0, 0, arena = { { "Smuggler Baron Silvertoe", 1 } } },
	{ "Zomba (arena, HP 300)", 0, 0, 0, arena = { { "Zomba", 1 } } },
	{ "Barbaria (arena, HP 345)", 0, 0, 0, arena = { { "Barbaria", 1 } } },
	{ "Dharalion (arena, HP 380)", 0, 0, 0, arena = { { "Dharalion", 1 } } },
	{ "Rukor Zad (arena, HP 380)", 0, 0, 0, arena = { { "Rukor Zad", 1 } } },
	{ "Groam (arena, HP 400)", 0, 0, 0, arena = { { "Groam", 1 } } },
	{ "The Blightfather (arena, HP 400)", 0, 0, 0, arena = { { "The Blightfather", 1 } } },
	{ "Mephiles (arena, HP 415)", 0, 0, 0, arena = { { "Mephiles", 1 } } },
	{ "Doctor Perhaps (arena, HP 475)", 0, 0, 0, arena = { { "Doctor Perhaps", 1 } } },
	{ "Man In the Cave (arena, HP 485)", 0, 0, 0, arena = { { "Man in the Cave", 1 } } },
	{ "Ekatrix (arena, HP 500)", 0, 0, 0, arena = { { "Ekatrix", 1 } } },
	{ "White Pale (arena, HP 500)", 0, 0, 0, arena = { { "White Pale", 1 } } },
	{ "General Murius (arena, HP 550)", 0, 0, 0, arena = { { "General Murius", 1 } } },
	{ "Captain Jones (arena, HP 555)", 0, 0, 0, arena = { { "Captain Jones", 1 } } },
	{ "Foreman Kneebiter (arena, HP 570)", 0, 0, 0, arena = { { "Foreman Kneebiter", 1 } } },
	{ "Hairman the Huge (arena, HP 600)", 0, 0, 0, arena = { { "Hairman the Huge", 1 } } },
	{ "Yaga the Crone (arena, HP 620)", 0, 0, 0, arena = { { "Yaga the Crone", 1 } } },
	{ "Dirtbeard (arena, HP 630)", 0, 0, 0, arena = { { "Dirtbeard", 1 } } },
	{ "Ocyakao (arena, HP 700)", 0, 0, 0, arena = { { "Ocyakao", 1 } } },
	{ "Diseased Dan (arena, HP 800)", 0, 0, 0, arena = { { "Diseased Dan", 1 } } },
	{ "Heoni (arena, HP 900)", 0, 0, 0, arena = { { "Heoni", 1 } } },
	{ "Boogey (arena, HP 930)", 0, 0, 0, arena = { { "Boogey", 1 } } },
	{ "Monstor (arena, HP 960)", 0, 0, 0, arena = { { "Monstor", 1 } } },
	{ "Diseased Bill (arena, HP 1000)", 0, 0, 0, arena = { { "Diseased Bill", 1 } } },
	{ "Glitterscale (arena, HP 1000)", 0, 0, 0, arena = { { "Glitterscale", 1 } } },
	{ "Diseased Fred (arena, HP 1100)", 0, 0, 0, arena = { { "Diseased Fred", 1 } } },
	{ "Raxias (arena, HP 1100)", 0, 0, 0, arena = { { "Raxias", 1 } } },
	{ "Bibby Bloodbath (arena, HP 1200)", 0, 0, 0, arena = { { "Bibby Bloodbath", 1 } } },
	{ "The Evil Eye (arena, HP 1200)", 0, 0, 0, arena = { { "The Evil Eye", 1 } } },
	{ "Evil Mastermind (arena, HP 1295)", 0, 0, 0, arena = { { "Evil Mastermind", 1 } } },
	{ "Zevelon Duskbringer (arena, HP 1400)", 0, 0, 0, arena = { { "Zevelon Duskbringer", 1 } } },
	{ "Diblis the Fair (arena, HP 1500)", 0, 0, 0, arena = { { "Diblis the Fair", 1 } } },
	{ "Hirintror (arena, HP 1500)", 0, 0, 0, arena = { { "Hirintror", 1 } } },
	{ "Warlord Ruzad (arena, HP 1500)", 0, 0, 0, arena = { { "Warlord Ruzad", 1 } } },
	{ "Arachir the Ancient One (arena, HP 1600)", 0, 0, 0, arena = { { "Arachir the Ancient One", 1 } } },
	{ "Sir Valorcrest (arena, HP 1600)", 0, 0, 0, arena = { { "Sir Valorcrest", 1 } } },
	{ "Black Knight (arena, HP 1800)", 0, 0, 0, arena = { { "Black Knight", 1 } } },
	{ "Grandfather Tridian (arena, HP 1800)", 0, 0, 0, arena = { { "Grandfather Tridian", 1 } } },
	{ "Grand Mother Foulscale (arena, HP 1850)", 0, 0, 0, arena = { { "Grand Mother Foulscale", 1 } } },
	{ "Dreadmaw (arena, HP 2000)", 0, 0, 0, arena = { { "Dreadmaw", 1 } } },
	{ "The Percht Queen (arena, HP 2300)", 0, 0, 0, arena = { { "The Percht Queen", 1 } } },
	{ "Mad Mage (arena, HP 2500)", 0, 0, 0, arena = { { "Mad Mage", 1 } } },
	{ "Grorlam (arena, HP 3000)", 0, 0, 0, arena = { { "Grorlam", 1 } } },
	{ "Kroazur (arena, HP 3000)", 0, 0, 0, arena = { { "Kroazur", 1 } } },
	{ "Gravelord Oshuran (arena, HP 3100)", 0, 0, 0, arena = { { "Gravelord Oshuran", 1 } } },
	{ "Black Vixen (arena, HP 3200)", 0, 0, 0, arena = { { "Black Vixen", 1 } } },
	{ "Sharpclaw (arena, HP 3300)", 0, 0, 0, arena = { { "Sharpclaw", 1 } } },
	{ "Raging Mage (arena, HP 3500)", 0, 0, 0, arena = { { "Raging mage", 1 } } },
	{ "Rahemos (arena, HP 3700)", 0, 0, 0, arena = { { "Rahemos", 1 } } },
	{ "Mahrdis (arena, HP 3900)", 0, 0, 0, arena = { { "Mahrdis", 1 } } },
	{ "Battlemaster Zunzu (arena, HP 4000)", 0, 0, 0, arena = { { "Battlemaster Zunzu", 1 } } },
	{ "Vashresamun (arena, HP 4000)", 0, 0, 0, arena = { { "Vashresamun", 1 } } },
	{ "Thalas (arena, HP 4100)", 0, 0, 0, arena = { { "Thalas", 1 } } },
	{ "Dipthrah (arena, HP 4200)", 0, 0, 0, arena = { { "Dipthrah", 1 } } },
	{ "Omruc (arena, HP 4300)", 0, 0, 0, arena = { { "Omruc", 1 } } },
	{ "Darkfang (arena, HP 4800)", 0, 0, 0, arena = { { "Darkfang", 1 } } },
	{ "Morguthis (arena, HP 4800)", 0, 0, 0, arena = { { "Morguthis", 1 } } },
	{ "Ashmunrah (arena, HP 5000)", 0, 0, 0, arena = { { "Ashmunrah", 1 } } },
	{ "Zarabustor (arena, HP 5100)", 0, 0, 0, arena = { { "Zarabustor", 1 } } },
	{ "Bloodback (arena, HP 5200)", 0, 0, 0, arena = { { "Bloodback", 1 } } },
	{ "The Voice of Ruin (arena, HP 5500)", 0, 0, 0, arena = { { "The Voice of Ruin", 1 } } },
	{ "Fleshslicer (arena, HP 5700)", 0, 0, 0, arena = { { "Fleshslicer", 1 } } },
	{ "Yakchal (arena, HP 5750)", 0, 0, 0, arena = { { "Yakchal", 1 } } },
	{ "Horestis (arena, HP 6000)", 0, 0, 0, arena = { { "Horestis", 1 } } },
	{ "Shadowpelt (arena, HP 6000)", 0, 0, 0, arena = { { "Shadowpelt", 1 } } },
	{ "Sugar Mommy (arena, HP 6000)", 0, 0, 0, arena = { { "Sugar Mommy", 1 } } },
	{ "Srezz Yellow Eyes (arena, HP 6200)", 0, 0, 0, arena = { { "Srezz Yellow Eyes", 1 } } },
	{ "Katex Blood Tongue (arena, HP 6300)", 0, 0, 0, arena = { { "Katex Blood Tongue", 1 } } },
	{ "Yirkas Blue Scales (arena, HP 6300)", 0, 0, 0, arena = { { "Yirkas Blue Scales", 1 } } },
	{ "Utua Stone Sting (arena, HP 6400)", 0, 0, 0, arena = { { "Utua Stone Sting", 1 } } },
	{ "Countess Sorrow (arena, HP 6500)", 0, 0, 0, arena = { { "Countess Sorrow", 1 } } },
	{ "The Plasmother (arena, HP 7500)", 0, 0, 0, arena = { { "The Plasmother", 1 } } },
	{ "Lord of the Elements (arena, HP 8000)", 0, 0, 0, arena = { { "Lord of the Elements", 1 } } },
	{ "Sugar Daddy (arena, HP 9500)", 0, 0, 0, arena = { { "Sugar Daddy", 1 } } },
	{ "Dazed Leaf Golem (arena, HP 10000)", 0, 0, 0, arena = { { "Dazed Leaf Golem", 1 } } },
	{ "Gelidrazah the Frozen (arena, HP 10000)", 0, 0, 0, arena = { { "Gelidrazah the Frozen", 1 } } },
	{ "Kalyassa (arena, HP 10000)", 0, 0, 0, arena = { { "Kalyassa", 1 } } },
	{ "Tazhadur (arena, HP 10000)", 0, 0, 0, arena = { { "Tazhadur", 1 } } },
	{ "The Blazing Rose (arena, HP 10000)", 0, 0, 0, arena = { { "The Blazing Rose", 1 } } },
	{ "Zorvorax (arena, HP 10000)", 0, 0, 0, arena = { { "Zorvorax", 1 } } },
	{ "Tyrn (arena, HP 12000)", 0, 0, 0, arena = { { "Tyrn", 1 } } },
	{ "Dreadful Disruptor (arena, HP 14000)", 0, 0, 0, arena = { { "Dreadful Disruptor", 1 } } },
	{ "Grand Canon Dominus (arena, HP 15000)", 0, 0, 0, arena = { { "Grand Canon Dominus", 1 } } },
	{ "The Imperor (arena, HP 15000)", 0, 0, 0, arena = { { "The Imperor", 1 } } },
	{ "Zushuka (arena, HP 15000)", 0, 0, 0, arena = { { "Zushuka", 1 } } },
	{ "Chizzoron the Distorter (arena, HP 16000)", 0, 0, 0, arena = { { "Chizzoron the Distorter", 1 } } },
	{ "Preceptor Lazare (arena, HP 16000)", 0, 0, 0, arena = { { "Preceptor Lazare", 1 } } },
	{ "Dracola (arena, HP 16200)", 0, 0, 0, arena = { { "Dracola", 1 } } },
	{ "Grand Commander Soeren (arena, HP 17000)", 0, 0, 0, arena = { { "Grand Commander Soeren", 1 } } },
	{ "Grand Chaplain Gaunder (arena, HP 18000)", 0, 0, 0, arena = { { "Grand Chaplain Gaunder", 1 } } },
	{ "The Lily of Night (arena, HP 19000)", 0, 0, 0, arena = { { "The Lily of Night", 1 } } },
	{ "The Handmaiden (arena, HP 19500)", 0, 0, 0, arena = { { "The Handmaiden", 1 } } },
	{ "Chikhaton (arena, HP 20000)", 0, 0, 0, arena = { { "Chikhaton", 1 } } },
	{ "The Diamond Blossom (arena, HP 20000)", 0, 0, 0, arena = { { "The Diamond Blossom", 1 } } },
	{ "Mr. Punish (arena, HP 22000)", 0, 0, 0, arena = { { "Mr. Punish", 1 } } },
	{ "Orshabaal (arena, HP 22500)", 0, 0, 0, arena = { { "Orshabaal", 1 } } },
	{ "Irgix The Flimsy (arena, HP 24000)", 0, 0, 0, arena = { { "Irgix The Flimsy", 1 } } },
	{ "Furyosa (arena, HP 25000)", 0, 0, 0, arena = { { "Furyosa", 1 } } },
	{ "Latrivan (arena, HP 25000)", 0, 0, 0, arena = { { "Latrivan", 1 } } },
	{ "Sister Hetai (arena, HP 25000)", 0, 0, 0, arena = { { "Sister Hetai", 1 } } },
	{ "Thawing Dragon Lord (arena, HP 25000)", 0, 0, 0, arena = { { "Thawing Dragon Lord", 1 } } },
	{ "The Welter (arena, HP 25000)", 0, 0, 0, arena = { { "The Welter", 1 } } },
	{ "World Devourer (arena, HP 25000)", 0, 0, 0, arena = { { "World Devourer", 1 } } },
	{ "Hellgorak (arena, HP 25850)", 0, 0, 0, arena = { { "Hellgorak", 1 } } },
	{ "Amenef the Burning (arena, HP 26000)", 0, 0, 0, arena = { { "Amenef the Burning", 1 } } },
	{ "Mozradek (arena, HP 28000)", 0, 0, 0, arena = { { "Mozradek", 1 } } },
	{ "Neferi the Spy (arena, HP 28000)", 0, 0, 0, arena = { { "Neferi the Spy", 1 } } },
	{ "Unaz the Mean (arena, HP 28000)", 0, 0, 0, arena = { { "Unaz the Mean", 1 } } },
	{ "Xogixath (arena, HP 28000)", 0, 0, 0, arena = { { "Xogixath", 1 } } },
	{ "Tanjis (arena, HP 30000)", 0, 0, 0, arena = { { "Tanjis", 1 } } },
	{ "Ushuriel (arena, HP 31500)", 0, 0, 0, arena = { { "Ushuriel", 1 } } },
	{ "Massacre (arena, HP 32000)", 0, 0, 0, arena = { { "Massacre", 1 } } },
	{ "Vok the Freakish (arena, HP 32000)", 0, 0, 0, arena = { { "Vok the Freakish", 1 } } },
	{ "Obujos (arena, HP 35000)", 0, 0, 0, arena = { { "Obujos", 1 } } },
	{ "Bragrumol (arena, HP 38000)", 0, 0, 0, arena = { { "Bragrumol", 1 } } },
	{ "Golgordan (arena, HP 40000)", 0, 0, 0, arena = { { "Golgordan", 1 } } },
	{ "Mawhawk (arena, HP 45000)", 0, 0, 0, arena = { { "Mawhawk", 1 } } },
	{ "Annihilon (arena, HP 46500)", 0, 0, 0, arena = { { "Annihilon", 1 } } },
	{ "Zulazza the Corruptor (arena, HP 46500)", 0, 0, 0, arena = { { "Zulazza the Corruptor", 1 } } },
	{ "Custodian (arena, HP 47000)", 0, 0, 0, arena = { { "Custodian", 1 } } },
	{ "Gaffir (arena, HP 48500)", 0, 0, 0, arena = { { "Gaffir", 1 } } },
	{ "The First Dragon (arena, HP 50000)", 0, 0, 0, arena = { { "The First Dragon", 1 } } },
	{ "The Pale Count (arena, HP 50000)", 0, 0, 0, arena = { { "The Pale Count", 1 } } },
	{ "The Sandking (arena, HP 50000)", 0, 0, 0, arena = { { "The Sandking", 1 } } },
	{ "The Ravager (arena, HP 53500)", 0, 0, 0, arena = { { "The Ravager", 1 } } },
	{ "Guard Captain Quaid (arena, HP 55000)", 0, 0, 0, arena = { { "Guard Captain Quaid", 1 } } },
	{ "Lisa (arena, HP 55000)", 0, 0, 0, arena = { { "Lisa", 1 } } },
	{ "Morgaroth (arena, HP 55000)", 0, 0, 0, arena = { { "Morgaroth", 1 } } },
	{ "Glooth Fairy (arena, HP 59000)", 0, 0, 0, arena = { { "Glooth Fairy", 1 } } },
	{ "The Armored Voidborn (arena, HP 60000)", 0, 0, 0, arena = { { "The Armored Voidborn", 1 } } },
	{ "Death Priest Shargon (arena, HP 65000)", 0, 0, 0, arena = { { "Death Priest Shargon", 1 } } },
	{ "Melting Frozen Horror (arena, HP 70000)", 0, 0, 0, arena = { { "Melting Frozen Horror", 1 } } },
	{ "Bullwark (arena, HP 72000)", 0, 0, 0, arena = { { "Bullwark", 1 } } },
	{ "Brain Head (arena, HP 75000)", 0, 0, 0, arena = { { "Brain Head", 1 } } },
	{ "Madareth (arena, HP 75000)", 0, 0, 0, arena = { { "Madareth", 1 } } },
	{ "Sir Baeloc (arena, HP 75000)", 0, 0, 0, arena = { { "Sir Baeloc", 1 } } },
	{ "Ghazbaran (arena, HP 77000)", 0, 0, 0, arena = { { "Ghazbaran", 1 } } },
	{ "Drume (arena, HP 80000)", 0, 0, 0, arena = { { "Drume", 1 } } },
	{ "Ferumbras (arena, HP 90000)", 0, 0, 0, arena = { { "Ferumbras", 1 } } },
	{ "Jaul (arena, HP 90000)", 0, 0, 0, arena = { { "Jaul", 1 } } },
	{ "Professor Maxxen (arena, HP 90000)", 0, 0, 0, arena = { { "Professor Maxxen", 1 } } },
	{ "Zugurosh (arena, HP 90500)", 0, 0, 0, arena = { { "Zugurosh", 1 } } },
	{ "Deep Terror (arena, HP 100000)", 0, 0, 0, arena = { { "Deep Terror", 1 } } },
	{ "Feroxa (arena, HP 100000)", 0, 0, 0, arena = { { "Feroxa", 1 } } },
	{ "Ravenous Hunger (arena, HP 100000)", 0, 0, 0, arena = { { "Ravenous Hunger", 1 } } },
	{ "Urmahlullu the Weakened (arena, HP 100000)", 0, 0, 0, arena = { { "Urmahlullu the Weakened", 1 } } },
	{ "Realityquake (arena, HP 110000)", 0, 0, 0, arena = { { "Realityquake", 1 } } },
	{ "Deathstrike (arena, HP 200000)", 0, 0, 0, arena = { { "Deathstrike", 1 } } },
	{ "Wisdom of Urmahlullu (arena, HP 200000)", 0, 0, 0, arena = { { "Wisdom of Urmahlullu", 1 } } },
	{ "Essence of Malice (arena, HP 250000)", 0, 0, 0, arena = { { "Essence of Malice", 1 } } },
	{ "Gnomevil (arena, HP 250000)", 0, 0, 0, arena = { { "Gnomevil", 1 } } },
	{ "The Unarmored Voidborn (arena, HP 250000)", 0, 0, 0, arena = { { "The Unarmored Voidborn", 1 } } },
	{ "Eradicator2 (arena, HP 290000)", 0, 0, 0, arena = { { "Eradicator2", 1 } } },
	{ "The Souldespoiler (arena, HP 290000)", 0, 0, 0, arena = { { "The Souldespoiler", 1 } } },
	{ "Goshnar's Cruelty (arena, HP 300000)", 0, 0, 0, arena = { { "Goshnar's Cruelty", 1 } } },
	{ "Goshnar's Greed (arena, HP 300000)", 0, 0, 0, arena = { { "Goshnar's Greed", 1 } } },
	{ "Goshnar's Hatred (arena, HP 300000)", 0, 0, 0, arena = { { "Goshnar's Hatred", 1 } } },
	{ "Goshnar's Malice (arena, HP 300000)", 0, 0, 0, arena = { { "Goshnar's Malice", 1 } } },
	{ "Goshnar's Spite (arena, HP 300000)", 0, 0, 0, arena = { { "Goshnar's Spite", 1 } } },
	{ "The False God (arena, HP 300000)", 0, 0, 0, arena = { { "The False God", 1 } } },
	{ "Urmahlullu the Tamed (arena, HP 300000)", 0, 0, 0, arena = { { "Urmahlullu the Tamed", 1 } } },
	{ "Alptramun (arena, HP 320000)", 0, 0, 0, arena = { { "Alptramun", 1 } } },
	{ "Izcandar the Banished (arena, HP 320000)", 0, 0, 0, arena = { { "Izcandar the Banished", 1 } } },
	{ "Malofur Mangrinder (arena, HP 320000)", 0, 0, 0, arena = { { "Malofur Mangrinder", 1 } } },
	{ "Maxxenius (arena, HP 320000)", 0, 0, 0, arena = { { "Maxxenius", 1 } } },
	{ "Plagueroot (arena, HP 320000)", 0, 0, 0, arena = { { "Plagueroot", 1 } } },
	{ "Omrafir (arena, HP 322000)", 0, 0, 0, arena = { { "Omrafir", 1 } } },
	{ "Abyssador (arena, HP 340000)", 0, 0, 0, arena = { { "Abyssador", 1 } } },
	{ "Gaz'Haragoth (arena, HP 350000)", 0, 0, 0, arena = { { "Gaz'Haragoth", 1 } } },
	{ "The Baron From Below (arena, HP 350000)", 0, 0, 0, arena = { { "The Baron from Below", 1 } } },
	{ "The Count of the Core (arena, HP 350000)", 0, 0, 0, arena = { { "The Count of the Core", 1 } } },
	{ "The Duke of the Depths (arena, HP 350000)", 0, 0, 0, arena = { { "The Duke of the Depths", 1 } } },
	{ "The Rootkraken (arena, HP 360000)", 0, 0, 0, arena = { { "The Rootkraken", 1 } } },
	{ "Wildness of Urmahlullu (arena, HP 400000)", 0, 0, 0, arena = { { "Wildness of Urmahlullu", 1 } } },
	{ "The Monster (arena, HP 450000)", 0, 0, 0, arena = { { "The Monster", 1 } } },
	{ "The Source of Corruption (arena, HP 500000)", 0, 0, 0, arena = { { "The Source of Corruption", 1 } } },
	{ "Goshnar's Megalomania Blue (arena, HP 620000)", 0, 0, 0, arena = { { "Goshnar's Megalomania Blue", 1 } } },
	{ "Goshnar's Megalomania Green (arena, HP 620000)", 0, 0, 0, arena = { { "Goshnar's Megalomania Green", 1 } } },
	{ "The Abomination (arena, HP 750000)", 0, 0, 0, arena = { { "The Abomination", 1 } } },
	{ "Ancient Spawn of Morgathla (arena, HP 900000)", 0, 0, 0, arena = { { "Ancient Spawn of Morgathla", 1 } } },
	{ "Dragon Hoard (arena, HP 999999)", 0, 0, 0, arena = { { "Dragon Hoard", 1 } } },
	{ "Morshabaal (arena, HP 1000000)", 0, 0, 0, arena = { { "Morshabaal", 1 } } },
}

local quests = {
	{ "Pits of Inferno: soft boots, avenger, arcane staff, arbalest", func = "OtsPoiStart" },
	{ "Barbarian Arena: bron do wyboru (3 poziomy, 10 walk)", func = "OtsArenaStart" },
	{ "In Service of Yalahar: yalahari armor / mask / leg piece / footwraps", func = "OtsYalaharStart" },
	{ "Soul War: komplet przedmiotow Soul War dla Twojej profesji", func = "OtsSoulWarStart" },
	{ "Demon Helmet: steel boots, demon helmet, demon shield", 33324, 31575, 15, hint = "Pokonaj potwory w sali, pociagnij dzwignie po wschodniej stronie. Skrzynie sa na zachodzie, za kamieniem (pole PZ)." },
	{ "The Annihilator: demon armor, magic sword, stonecutter axe", 33224, 31671, 13, plain = true, hint = "Stan na jednym z czterech pol przy dzwigni i pociagnij ja. Wymagany poziom 100. Skrzynie sa na wschod od sali walki (pola PZ)." },
	{ "Wrath of the Emperor: royal scale robe, royal draken mail, elite draken helmet", 0, 0, 0, arena = { { "Draken Elite", 4 }, { "Draken Abomination", 4 }, { "Draken Warmaster", 4 }, { "Draken Spellweaver", 4 }, { "Draken Elite", 2 } }, chest = { 33073, 31170, 8 }, hint = "Skrzynia z nagroda jest tuz obok. Skrzynie stoja obok siebie; zbroje sa w kolejnych skrzyniach." },
	{ "The Thieves Guild: modified crossbow, assassin dagger, spellbook of warding", 0, 0, 0, arena = { { "Assassin", 6 }, { "Stalker", 4 }, { "Bandit", 4 }, { "Smuggler", 4 }, { "Assassin", 4 } }, chest = { 32310, 32209, 8 }, hint = "Skrzynia z nagroda jest tuz obok. Trzy skrzynie, mozna wziac jedna nagrode." },
	{ "The Hidden City of Beregar: firewalker boots", 0, 0, 0, arena = { { "Dwarf Guard", 6 }, { "Dwarf Geomancer", 4 }, { "Worker Golem", 4 }, { "War Golem", 5 } }, chest = { 32580, 31404, 15 }, hint = "Skrzynia z nagroda jest tuz obok." },
	{ "Koshei the Deathless: blue legs", 0, 0, 0, arena = { { "Lich", 4 }, { "Bonebeast", 5 }, { "Vampire", 5 }, { "Mummy", 5 }, { "Koshei the Deathless", 1 } }, chest = { 33261, 32445, 12 }, hint = "Skrzynia z nagroda jest tuz obok." },
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
	{ label = "Low (exp do 300) (168 potworow)", x = 29998, y = 30045, z = 7 },
	{ label = "Medium (exp 300-1500) (128 potworow)", x = 30043, y = 30045, z = 7 },
	{ label = "Hard (exp 1500-6000) (155 potworow)", x = 30088, y = 30045, z = 7 },
	{ label = "Very Hard (exp 6000+) (79 potworow)", x = 30133, y = 30045, z = 7 },
}
local hubQuestHall = Position(30030, 29960, 7)
local hubBossHall = Position(29998, 29915, 7)
local arenaCenter = Position(30060, 29900, 7)
local arenaLanding = Position(30060, 29909, 7)
local ARENA_RADIUS = 10
local hubPads = {
	["29996:29653:7"] = { goto = { 29998, 29681, 7 }, label = "Bossy 10/11 (arena, HP 110000-350000)" },
	["29996:29655:7"] = { lobby = true },
	["29996:29657:7"] = { goto = { 29998, 29915, 7 }, label = "Bossy 1/11 (bossy z dzwignia)" },
	["29996:29679:7"] = { goto = { 29998, 29707, 7 }, label = "Bossy 9/11 (arena, HP 50000-100000)" },
	["29996:29681:7"] = { lobby = true },
	["29996:29683:7"] = { goto = { 29998, 29655, 7 }, label = "Bossy 11/11 (arena, HP 350000-1000000)" },
	["29996:29705:7"] = { goto = { 29998, 29733, 7 }, label = "Bossy 8/11 (arena, HP 25000-50000)" },
	["29996:29707:7"] = { lobby = true },
	["29996:29709:7"] = { goto = { 29998, 29681, 7 }, label = "Bossy 10/11 (arena, HP 110000-350000)" },
	["29996:29731:7"] = { goto = { 29998, 29759, 7 }, label = "Bossy 7/11 (arena, HP 10000-25000)" },
	["29996:29733:7"] = { lobby = true },
	["29996:29735:7"] = { goto = { 29998, 29707, 7 }, label = "Bossy 9/11 (arena, HP 50000-100000)" },
	["29996:29757:7"] = { goto = { 29998, 29785, 7 }, label = "Bossy 6/11 (arena, HP 4000-9500)" },
	["29996:29759:7"] = { lobby = true },
	["29996:29761:7"] = { goto = { 29998, 29733, 7 }, label = "Bossy 8/11 (arena, HP 25000-50000)" },
	["29996:29783:7"] = { goto = { 29998, 29811, 7 }, label = "Bossy 5/11 (arena, HP 1100-3900)" },
	["29996:29785:7"] = { lobby = true },
	["29996:29787:7"] = { goto = { 29998, 29759, 7 }, label = "Bossy 7/11 (arena, HP 10000-25000)" },
	["29996:29809:7"] = { goto = { 29998, 29837, 7 }, label = "Bossy 4/11 (arena, HP 345-1100)" },
	["29996:29811:7"] = { lobby = true },
	["29996:29813:7"] = { goto = { 29998, 29785, 7 }, label = "Bossy 6/11 (arena, HP 4000-9500)" },
	["29996:29835:7"] = { goto = { 29998, 29863, 7 }, label = "Bossy 3/11 (dzwignie i arena)" },
	["29996:29837:7"] = { lobby = true },
	["29996:29839:7"] = { goto = { 29998, 29811, 7 }, label = "Bossy 5/11 (arena, HP 1100-3900)" },
	["29996:29861:7"] = { goto = { 29998, 29889, 7 }, label = "Bossy 2/11 (bossy z dzwignia)" },
	["29996:29863:7"] = { lobby = true },
	["29996:29865:7"] = { goto = { 29998, 29837, 7 }, label = "Bossy 4/11 (arena, HP 345-1100)" },
	["29996:29887:7"] = { goto = { 29998, 29915, 7 }, label = "Bossy 1/11 (bossy z dzwignia)" },
	["29996:29889:7"] = { lobby = true },
	["29996:29891:7"] = { goto = { 29998, 29863, 7 }, label = "Bossy 3/11 (dzwignie i arena)" },
	["29996:29913:7"] = { goto = { 29998, 29655, 7 }, label = "Bossy 11/11 (arena, HP 350000-1000000)" },
	["29996:29915:7"] = { lobby = true },
	["29996:29917:7"] = { goto = { 29998, 29889, 7 }, label = "Bossy 2/11 (bossy z dzwignia)" },
	["29996:30043:7"] = { goto = { 29998, 30201, 7 }, label = "Low 7/7 (exp 200-300)" },
	["29996:30045:7"] = { lobby = true },
	["29996:30047:7"] = { goto = { 29998, 30071, 7 }, label = "Low 2/7 (exp 30-48)" },
	["29996:30069:7"] = { goto = { 29998, 30045, 7 }, label = "Low 1/7 (exp 20-30)" },
	["29996:30071:7"] = { lobby = true },
	["29996:30073:7"] = { goto = { 29998, 30097, 7 }, label = "Low 3/7 (exp 48-70)" },
	["29996:30095:7"] = { goto = { 29998, 30071, 7 }, label = "Low 2/7 (exp 30-48)" },
	["29996:30097:7"] = { lobby = true },
	["29996:30099:7"] = { goto = { 29998, 30123, 7 }, label = "Low 4/7 (exp 70-115)" },
	["29996:30121:7"] = { goto = { 29998, 30097, 7 }, label = "Low 3/7 (exp 48-70)" },
	["29996:30123:7"] = { lobby = true },
	["29996:30125:7"] = { goto = { 29998, 30149, 7 }, label = "Low 5/7 (exp 120-150)" },
	["29996:30147:7"] = { goto = { 29998, 30123, 7 }, label = "Low 4/7 (exp 70-115)" },
	["29996:30149:7"] = { lobby = true },
	["29996:30151:7"] = { goto = { 29998, 30175, 7 }, label = "Low 6/7 (exp 155-195)" },
	["29996:30173:7"] = { goto = { 29998, 30149, 7 }, label = "Low 5/7 (exp 120-150)" },
	["29996:30175:7"] = { lobby = true },
	["29996:30177:7"] = { goto = { 29998, 30201, 7 }, label = "Low 7/7 (exp 200-300)" },
	["29996:30199:7"] = { goto = { 29998, 30175, 7 }, label = "Low 6/7 (exp 155-195)" },
	["29996:30201:7"] = { lobby = true },
	["29996:30203:7"] = { goto = { 29998, 30045, 7 }, label = "Low 1/7 (exp 20-30)" },
	["30000:29960:7"] = { lobby = true },
	["30003:29648:7"] = { boss = bosses[241] },
	["30003:29652:7"] = { boss = bosses[242] },
	["30003:29674:7"] = { boss = bosses[217] },
	["30003:29678:7"] = { boss = bosses[218] },
	["30003:29684:7"] = { boss = bosses[229] },
	["30003:29688:7"] = { boss = bosses[230] },
	["30003:29700:7"] = { boss = bosses[193] },
	["30003:29704:7"] = { boss = bosses[194] },
	["30003:29710:7"] = { boss = bosses[205] },
	["30003:29714:7"] = { boss = bosses[206] },
	["30003:29726:7"] = { boss = bosses[169] },
	["30003:29730:7"] = { boss = bosses[170] },
	["30003:29736:7"] = { boss = bosses[181] },
	["30003:29740:7"] = { boss = bosses[182] },
	["30003:29752:7"] = { boss = bosses[145] },
	["30003:29756:7"] = { boss = bosses[146] },
	["30003:29762:7"] = { boss = bosses[157] },
	["30003:29766:7"] = { boss = bosses[158] },
	["30003:29778:7"] = { boss = bosses[121] },
	["30003:29782:7"] = { boss = bosses[122] },
	["30003:29788:7"] = { boss = bosses[133] },
	["30003:29792:7"] = { boss = bosses[134] },
	["30003:29804:7"] = { boss = bosses[97] },
	["30003:29808:7"] = { boss = bosses[98] },
	["30003:29814:7"] = { boss = bosses[109] },
	["30003:29818:7"] = { boss = bosses[110] },
	["30003:29830:7"] = { boss = bosses[73] },
	["30003:29834:7"] = { boss = bosses[74] },
	["30003:29840:7"] = { boss = bosses[85] },
	["30003:29844:7"] = { boss = bosses[86] },
	["30003:29856:7"] = { boss = bosses[49] },
	["30003:29860:7"] = { boss = bosses[50] },
	["30003:29866:7"] = { boss = bosses[61] },
	["30003:29870:7"] = { boss = bosses[62] },
	["30003:29882:7"] = { boss = bosses[25] },
	["30003:29886:7"] = { boss = bosses[26] },
	["30003:29892:7"] = { boss = bosses[37] },
	["30003:29896:7"] = { boss = bosses[38] },
	["30003:29908:7"] = { boss = bosses[1] },
	["30003:29912:7"] = { boss = bosses[2] },
	["30003:29918:7"] = { boss = bosses[13] },
	["30003:29922:7"] = { boss = bosses[14] },
	["30003:30038:7"] = { hunt = hunts[1].list[1] },
	["30003:30042:7"] = { hunt = hunts[1].list[2] },
	["30003:30048:7"] = { hunt = hunts[1].list[13] },
	["30003:30052:7"] = { hunt = hunts[1].list[14] },
	["30003:30064:7"] = { hunt = hunts[1].list[25] },
	["30003:30068:7"] = { hunt = hunts[1].list[26] },
	["30003:30074:7"] = { hunt = hunts[1].list[37] },
	["30003:30078:7"] = { hunt = hunts[1].list[38] },
	["30003:30090:7"] = { hunt = hunts[1].list[49] },
	["30003:30094:7"] = { hunt = hunts[1].list[50] },
	["30003:30100:7"] = { hunt = hunts[1].list[61] },
	["30003:30104:7"] = { hunt = hunts[1].list[62] },
	["30003:30116:7"] = { hunt = hunts[1].list[73] },
	["30003:30120:7"] = { hunt = hunts[1].list[74] },
	["30003:30126:7"] = { hunt = hunts[1].list[85] },
	["30003:30130:7"] = { hunt = hunts[1].list[86] },
	["30003:30142:7"] = { hunt = hunts[1].list[97] },
	["30003:30146:7"] = { hunt = hunts[1].list[98] },
	["30003:30152:7"] = { hunt = hunts[1].list[109] },
	["30003:30156:7"] = { hunt = hunts[1].list[110] },
	["30003:30168:7"] = { hunt = hunts[1].list[121] },
	["30003:30172:7"] = { hunt = hunts[1].list[122] },
	["30003:30178:7"] = { hunt = hunts[1].list[133] },
	["30003:30182:7"] = { hunt = hunts[1].list[134] },
	["30003:30194:7"] = { hunt = hunts[1].list[145] },
	["30003:30198:7"] = { hunt = hunts[1].list[146] },
	["30003:30204:7"] = { hunt = hunts[1].list[157] },
	["30003:30208:7"] = { hunt = hunts[1].list[158] },
	["30004:29958:7"] = { quest = quests[1] },
	["30004:29962:7"] = { quest = quests[2] },
	["30004:29998:7"] = { wing = 1 },
	["30006:29648:7"] = { boss = bosses[243] },
	["30006:29652:7"] = { boss = bosses[244] },
	["30006:29674:7"] = { boss = bosses[219] },
	["30006:29678:7"] = { boss = bosses[220] },
	["30006:29684:7"] = { boss = bosses[231] },
	["30006:29688:7"] = { boss = bosses[232] },
	["30006:29700:7"] = { boss = bosses[195] },
	["30006:29704:7"] = { boss = bosses[196] },
	["30006:29710:7"] = { boss = bosses[207] },
	["30006:29714:7"] = { boss = bosses[208] },
	["30006:29726:7"] = { boss = bosses[171] },
	["30006:29730:7"] = { boss = bosses[172] },
	["30006:29736:7"] = { boss = bosses[183] },
	["30006:29740:7"] = { boss = bosses[184] },
	["30006:29752:7"] = { boss = bosses[147] },
	["30006:29756:7"] = { boss = bosses[148] },
	["30006:29762:7"] = { boss = bosses[159] },
	["30006:29766:7"] = { boss = bosses[160] },
	["30006:29778:7"] = { boss = bosses[123] },
	["30006:29782:7"] = { boss = bosses[124] },
	["30006:29788:7"] = { boss = bosses[135] },
	["30006:29792:7"] = { boss = bosses[136] },
	["30006:29804:7"] = { boss = bosses[99] },
	["30006:29808:7"] = { boss = bosses[100] },
	["30006:29814:7"] = { boss = bosses[111] },
	["30006:29818:7"] = { boss = bosses[112] },
	["30006:29830:7"] = { boss = bosses[75] },
	["30006:29834:7"] = { boss = bosses[76] },
	["30006:29840:7"] = { boss = bosses[87] },
	["30006:29844:7"] = { boss = bosses[88] },
	["30006:29856:7"] = { boss = bosses[51] },
	["30006:29860:7"] = { boss = bosses[52] },
	["30006:29866:7"] = { boss = bosses[63] },
	["30006:29870:7"] = { boss = bosses[64] },
	["30006:29882:7"] = { boss = bosses[27] },
	["30006:29886:7"] = { boss = bosses[28] },
	["30006:29892:7"] = { boss = bosses[39] },
	["30006:29896:7"] = { boss = bosses[40] },
	["30006:29908:7"] = { boss = bosses[3] },
	["30006:29912:7"] = { boss = bosses[4] },
	["30006:29918:7"] = { boss = bosses[15] },
	["30006:29922:7"] = { boss = bosses[16] },
	["30006:30038:7"] = { hunt = hunts[1].list[3] },
	["30006:30042:7"] = { hunt = hunts[1].list[4] },
	["30006:30048:7"] = { hunt = hunts[1].list[15] },
	["30006:30052:7"] = { hunt = hunts[1].list[16] },
	["30006:30064:7"] = { hunt = hunts[1].list[27] },
	["30006:30068:7"] = { hunt = hunts[1].list[28] },
	["30006:30074:7"] = { hunt = hunts[1].list[39] },
	["30006:30078:7"] = { hunt = hunts[1].list[40] },
	["30006:30090:7"] = { hunt = hunts[1].list[51] },
	["30006:30094:7"] = { hunt = hunts[1].list[52] },
	["30006:30100:7"] = { hunt = hunts[1].list[63] },
	["30006:30104:7"] = { hunt = hunts[1].list[64] },
	["30006:30116:7"] = { hunt = hunts[1].list[75] },
	["30006:30120:7"] = { hunt = hunts[1].list[76] },
	["30006:30126:7"] = { hunt = hunts[1].list[87] },
	["30006:30130:7"] = { hunt = hunts[1].list[88] },
	["30006:30142:7"] = { hunt = hunts[1].list[99] },
	["30006:30146:7"] = { hunt = hunts[1].list[100] },
	["30006:30152:7"] = { hunt = hunts[1].list[111] },
	["30006:30156:7"] = { hunt = hunts[1].list[112] },
	["30006:30168:7"] = { hunt = hunts[1].list[123] },
	["30006:30172:7"] = { hunt = hunts[1].list[124] },
	["30006:30178:7"] = { hunt = hunts[1].list[135] },
	["30006:30182:7"] = { hunt = hunts[1].list[136] },
	["30006:30194:7"] = { hunt = hunts[1].list[147] },
	["30006:30198:7"] = { hunt = hunts[1].list[148] },
	["30006:30204:7"] = { hunt = hunts[1].list[159] },
	["30006:30208:7"] = { hunt = hunts[1].list[160] },
	["30009:29648:7"] = { boss = bosses[245] },
	["30009:29652:7"] = { boss = bosses[246] },
	["30009:29674:7"] = { boss = bosses[221] },
	["30009:29678:7"] = { boss = bosses[222] },
	["30009:29684:7"] = { boss = bosses[233] },
	["30009:29688:7"] = { boss = bosses[234] },
	["30009:29700:7"] = { boss = bosses[197] },
	["30009:29704:7"] = { boss = bosses[198] },
	["30009:29710:7"] = { boss = bosses[209] },
	["30009:29714:7"] = { boss = bosses[210] },
	["30009:29726:7"] = { boss = bosses[173] },
	["30009:29730:7"] = { boss = bosses[174] },
	["30009:29736:7"] = { boss = bosses[185] },
	["30009:29740:7"] = { boss = bosses[186] },
	["30009:29752:7"] = { boss = bosses[149] },
	["30009:29756:7"] = { boss = bosses[150] },
	["30009:29762:7"] = { boss = bosses[161] },
	["30009:29766:7"] = { boss = bosses[162] },
	["30009:29778:7"] = { boss = bosses[125] },
	["30009:29782:7"] = { boss = bosses[126] },
	["30009:29788:7"] = { boss = bosses[137] },
	["30009:29792:7"] = { boss = bosses[138] },
	["30009:29804:7"] = { boss = bosses[101] },
	["30009:29808:7"] = { boss = bosses[102] },
	["30009:29814:7"] = { boss = bosses[113] },
	["30009:29818:7"] = { boss = bosses[114] },
	["30009:29830:7"] = { boss = bosses[77] },
	["30009:29834:7"] = { boss = bosses[78] },
	["30009:29840:7"] = { boss = bosses[89] },
	["30009:29844:7"] = { boss = bosses[90] },
	["30009:29856:7"] = { boss = bosses[53] },
	["30009:29860:7"] = { boss = bosses[54] },
	["30009:29866:7"] = { boss = bosses[65] },
	["30009:29870:7"] = { boss = bosses[66] },
	["30009:29882:7"] = { boss = bosses[29] },
	["30009:29886:7"] = { boss = bosses[30] },
	["30009:29892:7"] = { boss = bosses[41] },
	["30009:29896:7"] = { boss = bosses[42] },
	["30009:29908:7"] = { boss = bosses[5] },
	["30009:29912:7"] = { boss = bosses[6] },
	["30009:29918:7"] = { boss = bosses[17] },
	["30009:29922:7"] = { boss = bosses[18] },
	["30009:29958:7"] = { quest = quests[3] },
	["30009:29962:7"] = { quest = quests[4] },
	["30009:30002:7"] = { outfits = true },
	["30009:30038:7"] = { hunt = hunts[1].list[5] },
	["30009:30042:7"] = { hunt = hunts[1].list[6] },
	["30009:30048:7"] = { hunt = hunts[1].list[17] },
	["30009:30052:7"] = { hunt = hunts[1].list[18] },
	["30009:30064:7"] = { hunt = hunts[1].list[29] },
	["30009:30068:7"] = { hunt = hunts[1].list[30] },
	["30009:30074:7"] = { hunt = hunts[1].list[41] },
	["30009:30078:7"] = { hunt = hunts[1].list[42] },
	["30009:30090:7"] = { hunt = hunts[1].list[53] },
	["30009:30094:7"] = { hunt = hunts[1].list[54] },
	["30009:30100:7"] = { hunt = hunts[1].list[65] },
	["30009:30104:7"] = { hunt = hunts[1].list[66] },
	["30009:30116:7"] = { hunt = hunts[1].list[77] },
	["30009:30120:7"] = { hunt = hunts[1].list[78] },
	["30009:30126:7"] = { hunt = hunts[1].list[89] },
	["30009:30130:7"] = { hunt = hunts[1].list[90] },
	["30009:30142:7"] = { hunt = hunts[1].list[101] },
	["30009:30146:7"] = { hunt = hunts[1].list[102] },
	["30009:30152:7"] = { hunt = hunts[1].list[113] },
	["30009:30156:7"] = { hunt = hunts[1].list[114] },
	["30009:30168:7"] = { hunt = hunts[1].list[125] },
	["30009:30172:7"] = { hunt = hunts[1].list[126] },
	["30009:30178:7"] = { hunt = hunts[1].list[137] },
	["30009:30182:7"] = { hunt = hunts[1].list[138] },
	["30009:30194:7"] = { hunt = hunts[1].list[149] },
	["30009:30198:7"] = { hunt = hunts[1].list[150] },
	["30009:30204:7"] = { hunt = hunts[1].list[161] },
	["30009:30208:7"] = { hunt = hunts[1].list[162] },
	["30010:29998:7"] = { wing = 2 },
	["30012:29648:7"] = { boss = bosses[247] },
	["30012:29652:7"] = { boss = bosses[248] },
	["30012:29674:7"] = { boss = bosses[223] },
	["30012:29678:7"] = { boss = bosses[224] },
	["30012:29684:7"] = { boss = bosses[235] },
	["30012:29688:7"] = { boss = bosses[236] },
	["30012:29700:7"] = { boss = bosses[199] },
	["30012:29704:7"] = { boss = bosses[200] },
	["30012:29710:7"] = { boss = bosses[211] },
	["30012:29714:7"] = { boss = bosses[212] },
	["30012:29726:7"] = { boss = bosses[175] },
	["30012:29730:7"] = { boss = bosses[176] },
	["30012:29736:7"] = { boss = bosses[187] },
	["30012:29740:7"] = { boss = bosses[188] },
	["30012:29752:7"] = { boss = bosses[151] },
	["30012:29756:7"] = { boss = bosses[152] },
	["30012:29762:7"] = { boss = bosses[163] },
	["30012:29766:7"] = { boss = bosses[164] },
	["30012:29778:7"] = { boss = bosses[127] },
	["30012:29782:7"] = { boss = bosses[128] },
	["30012:29788:7"] = { boss = bosses[139] },
	["30012:29792:7"] = { boss = bosses[140] },
	["30012:29804:7"] = { boss = bosses[103] },
	["30012:29808:7"] = { boss = bosses[104] },
	["30012:29814:7"] = { boss = bosses[115] },
	["30012:29818:7"] = { boss = bosses[116] },
	["30012:29830:7"] = { boss = bosses[79] },
	["30012:29834:7"] = { boss = bosses[80] },
	["30012:29840:7"] = { boss = bosses[91] },
	["30012:29844:7"] = { boss = bosses[92] },
	["30012:29856:7"] = { boss = bosses[55] },
	["30012:29860:7"] = { boss = bosses[56] },
	["30012:29866:7"] = { boss = bosses[67] },
	["30012:29870:7"] = { boss = bosses[68] },
	["30012:29882:7"] = { boss = bosses[31] },
	["30012:29886:7"] = { boss = bosses[32] },
	["30012:29892:7"] = { boss = bosses[43] },
	["30012:29896:7"] = { boss = bosses[44] },
	["30012:29908:7"] = { boss = bosses[7] },
	["30012:29912:7"] = { boss = bosses[8] },
	["30012:29918:7"] = { boss = bosses[19] },
	["30012:29922:7"] = { boss = bosses[20] },
	["30012:30038:7"] = { hunt = hunts[1].list[7] },
	["30012:30042:7"] = { hunt = hunts[1].list[8] },
	["30012:30048:7"] = { hunt = hunts[1].list[19] },
	["30012:30052:7"] = { hunt = hunts[1].list[20] },
	["30012:30064:7"] = { hunt = hunts[1].list[31] },
	["30012:30068:7"] = { hunt = hunts[1].list[32] },
	["30012:30074:7"] = { hunt = hunts[1].list[43] },
	["30012:30078:7"] = { hunt = hunts[1].list[44] },
	["30012:30090:7"] = { hunt = hunts[1].list[55] },
	["30012:30094:7"] = { hunt = hunts[1].list[56] },
	["30012:30100:7"] = { hunt = hunts[1].list[67] },
	["30012:30104:7"] = { hunt = hunts[1].list[68] },
	["30012:30116:7"] = { hunt = hunts[1].list[79] },
	["30012:30120:7"] = { hunt = hunts[1].list[80] },
	["30012:30126:7"] = { hunt = hunts[1].list[91] },
	["30012:30130:7"] = { hunt = hunts[1].list[92] },
	["30012:30142:7"] = { hunt = hunts[1].list[103] },
	["30012:30146:7"] = { hunt = hunts[1].list[104] },
	["30012:30152:7"] = { hunt = hunts[1].list[115] },
	["30012:30156:7"] = { hunt = hunts[1].list[116] },
	["30012:30168:7"] = { hunt = hunts[1].list[127] },
	["30012:30172:7"] = { hunt = hunts[1].list[128] },
	["30012:30178:7"] = { hunt = hunts[1].list[139] },
	["30012:30182:7"] = { hunt = hunts[1].list[140] },
	["30012:30194:7"] = { hunt = hunts[1].list[151] },
	["30012:30198:7"] = { hunt = hunts[1].list[152] },
	["30012:30204:7"] = { hunt = hunts[1].list[163] },
	["30012:30208:7"] = { hunt = hunts[1].list[164] },
	["30013:30002:7"] = { thais = true },
	["30014:29958:7"] = { quest = quests[5] },
	["30014:29962:7"] = { quest = quests[6] },
	["30015:29648:7"] = { boss = bosses[249] },
	["30015:29652:7"] = { boss = bosses[250] },
	["30015:29674:7"] = { boss = bosses[225] },
	["30015:29678:7"] = { boss = bosses[226] },
	["30015:29684:7"] = { boss = bosses[237] },
	["30015:29688:7"] = { boss = bosses[238] },
	["30015:29700:7"] = { boss = bosses[201] },
	["30015:29704:7"] = { boss = bosses[202] },
	["30015:29710:7"] = { boss = bosses[213] },
	["30015:29714:7"] = { boss = bosses[214] },
	["30015:29726:7"] = { boss = bosses[177] },
	["30015:29730:7"] = { boss = bosses[178] },
	["30015:29736:7"] = { boss = bosses[189] },
	["30015:29740:7"] = { boss = bosses[190] },
	["30015:29752:7"] = { boss = bosses[153] },
	["30015:29756:7"] = { boss = bosses[154] },
	["30015:29762:7"] = { boss = bosses[165] },
	["30015:29766:7"] = { boss = bosses[166] },
	["30015:29778:7"] = { boss = bosses[129] },
	["30015:29782:7"] = { boss = bosses[130] },
	["30015:29788:7"] = { boss = bosses[141] },
	["30015:29792:7"] = { boss = bosses[142] },
	["30015:29804:7"] = { boss = bosses[105] },
	["30015:29808:7"] = { boss = bosses[106] },
	["30015:29814:7"] = { boss = bosses[117] },
	["30015:29818:7"] = { boss = bosses[118] },
	["30015:29830:7"] = { boss = bosses[81] },
	["30015:29834:7"] = { boss = bosses[82] },
	["30015:29840:7"] = { boss = bosses[93] },
	["30015:29844:7"] = { boss = bosses[94] },
	["30015:29856:7"] = { boss = bosses[57] },
	["30015:29860:7"] = { boss = bosses[58] },
	["30015:29866:7"] = { boss = bosses[69] },
	["30015:29870:7"] = { boss = bosses[70] },
	["30015:29882:7"] = { boss = bosses[33] },
	["30015:29886:7"] = { boss = bosses[34] },
	["30015:29892:7"] = { boss = bosses[45] },
	["30015:29896:7"] = { boss = bosses[46] },
	["30015:29908:7"] = { boss = bosses[9] },
	["30015:29912:7"] = { boss = bosses[10] },
	["30015:29918:7"] = { boss = bosses[21] },
	["30015:29922:7"] = { boss = bosses[22] },
	["30015:30038:7"] = { hunt = hunts[1].list[9] },
	["30015:30042:7"] = { hunt = hunts[1].list[10] },
	["30015:30048:7"] = { hunt = hunts[1].list[21] },
	["30015:30052:7"] = { hunt = hunts[1].list[22] },
	["30015:30064:7"] = { hunt = hunts[1].list[33] },
	["30015:30068:7"] = { hunt = hunts[1].list[34] },
	["30015:30074:7"] = { hunt = hunts[1].list[45] },
	["30015:30078:7"] = { hunt = hunts[1].list[46] },
	["30015:30090:7"] = { hunt = hunts[1].list[57] },
	["30015:30094:7"] = { hunt = hunts[1].list[58] },
	["30015:30100:7"] = { hunt = hunts[1].list[69] },
	["30015:30104:7"] = { hunt = hunts[1].list[70] },
	["30015:30116:7"] = { hunt = hunts[1].list[81] },
	["30015:30120:7"] = { hunt = hunts[1].list[82] },
	["30015:30126:7"] = { hunt = hunts[1].list[93] },
	["30015:30130:7"] = { hunt = hunts[1].list[94] },
	["30015:30142:7"] = { hunt = hunts[1].list[105] },
	["30015:30146:7"] = { hunt = hunts[1].list[106] },
	["30015:30152:7"] = { hunt = hunts[1].list[117] },
	["30015:30156:7"] = { hunt = hunts[1].list[118] },
	["30015:30168:7"] = { hunt = hunts[1].list[129] },
	["30015:30172:7"] = { hunt = hunts[1].list[130] },
	["30015:30178:7"] = { hunt = hunts[1].list[141] },
	["30015:30182:7"] = { hunt = hunts[1].list[142] },
	["30015:30194:7"] = { hunt = hunts[1].list[153] },
	["30015:30198:7"] = { hunt = hunts[1].list[154] },
	["30015:30204:7"] = { hunt = hunts[1].list[165] },
	["30015:30208:7"] = { hunt = hunts[1].list[166] },
	["30016:29998:7"] = { wing = 3 },
	["30017:30002:7"] = { questhall = true },
	["30018:29648:7"] = { boss = bosses[251] },
	["30018:29652:7"] = { boss = bosses[252] },
	["30018:29674:7"] = { boss = bosses[227] },
	["30018:29678:7"] = { boss = bosses[228] },
	["30018:29684:7"] = { boss = bosses[239] },
	["30018:29688:7"] = { boss = bosses[240] },
	["30018:29700:7"] = { boss = bosses[203] },
	["30018:29704:7"] = { boss = bosses[204] },
	["30018:29710:7"] = { boss = bosses[215] },
	["30018:29714:7"] = { boss = bosses[216] },
	["30018:29726:7"] = { boss = bosses[179] },
	["30018:29730:7"] = { boss = bosses[180] },
	["30018:29736:7"] = { boss = bosses[191] },
	["30018:29740:7"] = { boss = bosses[192] },
	["30018:29752:7"] = { boss = bosses[155] },
	["30018:29756:7"] = { boss = bosses[156] },
	["30018:29762:7"] = { boss = bosses[167] },
	["30018:29766:7"] = { boss = bosses[168] },
	["30018:29778:7"] = { boss = bosses[131] },
	["30018:29782:7"] = { boss = bosses[132] },
	["30018:29788:7"] = { boss = bosses[143] },
	["30018:29792:7"] = { boss = bosses[144] },
	["30018:29804:7"] = { boss = bosses[107] },
	["30018:29808:7"] = { boss = bosses[108] },
	["30018:29814:7"] = { boss = bosses[119] },
	["30018:29818:7"] = { boss = bosses[120] },
	["30018:29830:7"] = { boss = bosses[83] },
	["30018:29834:7"] = { boss = bosses[84] },
	["30018:29840:7"] = { boss = bosses[95] },
	["30018:29844:7"] = { boss = bosses[96] },
	["30018:29856:7"] = { boss = bosses[59] },
	["30018:29860:7"] = { boss = bosses[60] },
	["30018:29866:7"] = { boss = bosses[71] },
	["30018:29870:7"] = { boss = bosses[72] },
	["30018:29882:7"] = { boss = bosses[35] },
	["30018:29886:7"] = { boss = bosses[36] },
	["30018:29892:7"] = { boss = bosses[47] },
	["30018:29896:7"] = { boss = bosses[48] },
	["30018:29908:7"] = { boss = bosses[11] },
	["30018:29912:7"] = { boss = bosses[12] },
	["30018:29918:7"] = { boss = bosses[23] },
	["30018:29922:7"] = { boss = bosses[24] },
	["30018:30038:7"] = { hunt = hunts[1].list[11] },
	["30018:30042:7"] = { hunt = hunts[1].list[12] },
	["30018:30048:7"] = { hunt = hunts[1].list[23] },
	["30018:30052:7"] = { hunt = hunts[1].list[24] },
	["30018:30064:7"] = { hunt = hunts[1].list[35] },
	["30018:30068:7"] = { hunt = hunts[1].list[36] },
	["30018:30074:7"] = { hunt = hunts[1].list[47] },
	["30018:30078:7"] = { hunt = hunts[1].list[48] },
	["30018:30090:7"] = { hunt = hunts[1].list[59] },
	["30018:30094:7"] = { hunt = hunts[1].list[60] },
	["30018:30100:7"] = { hunt = hunts[1].list[71] },
	["30018:30104:7"] = { hunt = hunts[1].list[72] },
	["30018:30116:7"] = { hunt = hunts[1].list[83] },
	["30018:30120:7"] = { hunt = hunts[1].list[84] },
	["30018:30126:7"] = { hunt = hunts[1].list[95] },
	["30018:30130:7"] = { hunt = hunts[1].list[96] },
	["30018:30142:7"] = { hunt = hunts[1].list[107] },
	["30018:30146:7"] = { hunt = hunts[1].list[108] },
	["30018:30152:7"] = { hunt = hunts[1].list[119] },
	["30018:30156:7"] = { hunt = hunts[1].list[120] },
	["30018:30168:7"] = { hunt = hunts[1].list[131] },
	["30018:30172:7"] = { hunt = hunts[1].list[132] },
	["30018:30178:7"] = { hunt = hunts[1].list[143] },
	["30018:30182:7"] = { hunt = hunts[1].list[144] },
	["30018:30194:7"] = { hunt = hunts[1].list[155] },
	["30018:30198:7"] = { hunt = hunts[1].list[156] },
	["30018:30204:7"] = { hunt = hunts[1].list[167] },
	["30018:30208:7"] = { hunt = hunts[1].list[168] },
	["30019:29958:7"] = { quest = quests[7] },
	["30019:29962:7"] = { quest = quests[8] },
	["30021:30002:7"] = { bosshall = true },
	["30022:29998:7"] = { wing = 4 },
	["30024:29958:7"] = { quest = quests[9] },
	["30024:29962:7"] = { quest = quests[10] },
	["30029:29958:7"] = { quest = quests[11] },
	["30029:29962:7"] = { quest = quests[12] },
	["30034:29958:7"] = { quest = quests[13] },
	["30034:29962:7"] = { quest = quests[14] },
	["30039:29958:7"] = { quest = quests[15] },
	["30039:29962:7"] = { quest = quests[16] },
	["30041:30043:7"] = { goto = { 30043, 30175, 7 }, label = "Medium 6/6 (exp 1450-1500)" },
	["30041:30045:7"] = { lobby = true },
	["30041:30047:7"] = { goto = { 30043, 30071, 7 }, label = "Medium 2/6 (exp 550-750)" },
	["30041:30069:7"] = { goto = { 30043, 30045, 7 }, label = "Medium 1/6 (exp 305-550)" },
	["30041:30071:7"] = { lobby = true },
	["30041:30073:7"] = { goto = { 30043, 30097, 7 }, label = "Medium 3/6 (exp 750-900)" },
	["30041:30095:7"] = { goto = { 30043, 30071, 7 }, label = "Medium 2/6 (exp 550-750)" },
	["30041:30097:7"] = { lobby = true },
	["30041:30099:7"] = { goto = { 30043, 30123, 7 }, label = "Medium 4/6 (exp 900-1100)" },
	["30041:30121:7"] = { goto = { 30043, 30097, 7 }, label = "Medium 3/6 (exp 750-900)" },
	["30041:30123:7"] = { lobby = true },
	["30041:30125:7"] = { goto = { 30043, 30149, 7 }, label = "Medium 5/6 (exp 1100-1400)" },
	["30041:30147:7"] = { goto = { 30043, 30123, 7 }, label = "Medium 4/6 (exp 900-1100)" },
	["30041:30149:7"] = { lobby = true },
	["30041:30151:7"] = { goto = { 30043, 30175, 7 }, label = "Medium 6/6 (exp 1450-1500)" },
	["30041:30173:7"] = { goto = { 30043, 30149, 7 }, label = "Medium 5/6 (exp 1100-1400)" },
	["30041:30175:7"] = { lobby = true },
	["30041:30177:7"] = { goto = { 30043, 30045, 7 }, label = "Medium 1/6 (exp 305-550)" },
	["30044:29958:7"] = { quest = quests[17] },
	["30044:29962:7"] = { quest = quests[18] },
	["30048:30038:7"] = { hunt = hunts[2].list[1] },
	["30048:30042:7"] = { hunt = hunts[2].list[2] },
	["30048:30048:7"] = { hunt = hunts[2].list[13] },
	["30048:30052:7"] = { hunt = hunts[2].list[14] },
	["30048:30064:7"] = { hunt = hunts[2].list[25] },
	["30048:30068:7"] = { hunt = hunts[2].list[26] },
	["30048:30074:7"] = { hunt = hunts[2].list[37] },
	["30048:30078:7"] = { hunt = hunts[2].list[38] },
	["30048:30090:7"] = { hunt = hunts[2].list[49] },
	["30048:30094:7"] = { hunt = hunts[2].list[50] },
	["30048:30100:7"] = { hunt = hunts[2].list[61] },
	["30048:30104:7"] = { hunt = hunts[2].list[62] },
	["30048:30116:7"] = { hunt = hunts[2].list[73] },
	["30048:30120:7"] = { hunt = hunts[2].list[74] },
	["30048:30126:7"] = { hunt = hunts[2].list[85] },
	["30048:30130:7"] = { hunt = hunts[2].list[86] },
	["30048:30142:7"] = { hunt = hunts[2].list[97] },
	["30048:30146:7"] = { hunt = hunts[2].list[98] },
	["30048:30152:7"] = { hunt = hunts[2].list[109] },
	["30048:30156:7"] = { hunt = hunts[2].list[110] },
	["30048:30168:7"] = { hunt = hunts[2].list[121] },
	["30048:30172:7"] = { hunt = hunts[2].list[122] },
	["30049:29958:7"] = { quest = quests[19] },
	["30049:29962:7"] = { quest = quests[20] },
	["30051:30038:7"] = { hunt = hunts[2].list[3] },
	["30051:30042:7"] = { hunt = hunts[2].list[4] },
	["30051:30048:7"] = { hunt = hunts[2].list[15] },
	["30051:30052:7"] = { hunt = hunts[2].list[16] },
	["30051:30064:7"] = { hunt = hunts[2].list[27] },
	["30051:30068:7"] = { hunt = hunts[2].list[28] },
	["30051:30074:7"] = { hunt = hunts[2].list[39] },
	["30051:30078:7"] = { hunt = hunts[2].list[40] },
	["30051:30090:7"] = { hunt = hunts[2].list[51] },
	["30051:30094:7"] = { hunt = hunts[2].list[52] },
	["30051:30100:7"] = { hunt = hunts[2].list[63] },
	["30051:30104:7"] = { hunt = hunts[2].list[64] },
	["30051:30116:7"] = { hunt = hunts[2].list[75] },
	["30051:30120:7"] = { hunt = hunts[2].list[76] },
	["30051:30126:7"] = { hunt = hunts[2].list[87] },
	["30051:30130:7"] = { hunt = hunts[2].list[88] },
	["30051:30142:7"] = { hunt = hunts[2].list[99] },
	["30051:30146:7"] = { hunt = hunts[2].list[100] },
	["30051:30152:7"] = { hunt = hunts[2].list[111] },
	["30051:30156:7"] = { hunt = hunts[2].list[112] },
	["30051:30168:7"] = { hunt = hunts[2].list[123] },
	["30051:30172:7"] = { hunt = hunts[2].list[124] },
	["30054:29958:7"] = { quest = quests[21] },
	["30054:29962:7"] = { quest = quests[22] },
	["30054:30038:7"] = { hunt = hunts[2].list[5] },
	["30054:30042:7"] = { hunt = hunts[2].list[6] },
	["30054:30048:7"] = { hunt = hunts[2].list[17] },
	["30054:30052:7"] = { hunt = hunts[2].list[18] },
	["30054:30064:7"] = { hunt = hunts[2].list[29] },
	["30054:30068:7"] = { hunt = hunts[2].list[30] },
	["30054:30074:7"] = { hunt = hunts[2].list[41] },
	["30054:30078:7"] = { hunt = hunts[2].list[42] },
	["30054:30090:7"] = { hunt = hunts[2].list[53] },
	["30054:30094:7"] = { hunt = hunts[2].list[54] },
	["30054:30100:7"] = { hunt = hunts[2].list[65] },
	["30054:30104:7"] = { hunt = hunts[2].list[66] },
	["30054:30116:7"] = { hunt = hunts[2].list[77] },
	["30054:30120:7"] = { hunt = hunts[2].list[78] },
	["30054:30126:7"] = { hunt = hunts[2].list[89] },
	["30054:30130:7"] = { hunt = hunts[2].list[90] },
	["30054:30142:7"] = { hunt = hunts[2].list[101] },
	["30054:30146:7"] = { hunt = hunts[2].list[102] },
	["30054:30152:7"] = { hunt = hunts[2].list[113] },
	["30054:30156:7"] = { hunt = hunts[2].list[114] },
	["30054:30168:7"] = { hunt = hunts[2].list[125] },
	["30054:30172:7"] = { hunt = hunts[2].list[126] },
	["30057:30038:7"] = { hunt = hunts[2].list[7] },
	["30057:30042:7"] = { hunt = hunts[2].list[8] },
	["30057:30048:7"] = { hunt = hunts[2].list[19] },
	["30057:30052:7"] = { hunt = hunts[2].list[20] },
	["30057:30064:7"] = { hunt = hunts[2].list[31] },
	["30057:30068:7"] = { hunt = hunts[2].list[32] },
	["30057:30074:7"] = { hunt = hunts[2].list[43] },
	["30057:30078:7"] = { hunt = hunts[2].list[44] },
	["30057:30090:7"] = { hunt = hunts[2].list[55] },
	["30057:30094:7"] = { hunt = hunts[2].list[56] },
	["30057:30100:7"] = { hunt = hunts[2].list[67] },
	["30057:30104:7"] = { hunt = hunts[2].list[68] },
	["30057:30116:7"] = { hunt = hunts[2].list[79] },
	["30057:30120:7"] = { hunt = hunts[2].list[80] },
	["30057:30126:7"] = { hunt = hunts[2].list[91] },
	["30057:30130:7"] = { hunt = hunts[2].list[92] },
	["30057:30142:7"] = { hunt = hunts[2].list[103] },
	["30057:30146:7"] = { hunt = hunts[2].list[104] },
	["30057:30152:7"] = { hunt = hunts[2].list[115] },
	["30057:30156:7"] = { hunt = hunts[2].list[116] },
	["30057:30168:7"] = { hunt = hunts[2].list[127] },
	["30057:30172:7"] = { hunt = hunts[2].list[128] },
	["30058:29960:7"] = { lobby = true },
	["30060:30038:7"] = { hunt = hunts[2].list[9] },
	["30060:30042:7"] = { hunt = hunts[2].list[10] },
	["30060:30048:7"] = { hunt = hunts[2].list[21] },
	["30060:30052:7"] = { hunt = hunts[2].list[22] },
	["30060:30064:7"] = { hunt = hunts[2].list[33] },
	["30060:30068:7"] = { hunt = hunts[2].list[34] },
	["30060:30074:7"] = { hunt = hunts[2].list[45] },
	["30060:30078:7"] = { hunt = hunts[2].list[46] },
	["30060:30090:7"] = { hunt = hunts[2].list[57] },
	["30060:30094:7"] = { hunt = hunts[2].list[58] },
	["30060:30100:7"] = { hunt = hunts[2].list[69] },
	["30060:30104:7"] = { hunt = hunts[2].list[70] },
	["30060:30116:7"] = { hunt = hunts[2].list[81] },
	["30060:30120:7"] = { hunt = hunts[2].list[82] },
	["30060:30126:7"] = { hunt = hunts[2].list[93] },
	["30060:30130:7"] = { hunt = hunts[2].list[94] },
	["30060:30142:7"] = { hunt = hunts[2].list[105] },
	["30060:30146:7"] = { hunt = hunts[2].list[106] },
	["30060:30152:7"] = { hunt = hunts[2].list[117] },
	["30060:30156:7"] = { hunt = hunts[2].list[118] },
	["30063:30038:7"] = { hunt = hunts[2].list[11] },
	["30063:30042:7"] = { hunt = hunts[2].list[12] },
	["30063:30048:7"] = { hunt = hunts[2].list[23] },
	["30063:30052:7"] = { hunt = hunts[2].list[24] },
	["30063:30064:7"] = { hunt = hunts[2].list[35] },
	["30063:30068:7"] = { hunt = hunts[2].list[36] },
	["30063:30074:7"] = { hunt = hunts[2].list[47] },
	["30063:30078:7"] = { hunt = hunts[2].list[48] },
	["30063:30090:7"] = { hunt = hunts[2].list[59] },
	["30063:30094:7"] = { hunt = hunts[2].list[60] },
	["30063:30100:7"] = { hunt = hunts[2].list[71] },
	["30063:30104:7"] = { hunt = hunts[2].list[72] },
	["30063:30116:7"] = { hunt = hunts[2].list[83] },
	["30063:30120:7"] = { hunt = hunts[2].list[84] },
	["30063:30126:7"] = { hunt = hunts[2].list[95] },
	["30063:30130:7"] = { hunt = hunts[2].list[96] },
	["30063:30142:7"] = { hunt = hunts[2].list[107] },
	["30063:30146:7"] = { hunt = hunts[2].list[108] },
	["30063:30152:7"] = { hunt = hunts[2].list[119] },
	["30063:30156:7"] = { hunt = hunts[2].list[120] },
	["30086:30043:7"] = { goto = { 30088, 30201, 7 }, label = "Hard 7/7 (exp 5800-6000)" },
	["30086:30045:7"] = { lobby = true },
	["30086:30047:7"] = { goto = { 30088, 30071, 7 }, label = "Hard 2/7 (exp 1900-2300)" },
	["30086:30069:7"] = { goto = { 30088, 30045, 7 }, label = "Hard 1/7 (exp 1520-1900)" },
	["30086:30071:7"] = { lobby = true },
	["30086:30073:7"] = { goto = { 30088, 30097, 7 }, label = "Hard 3/7 (exp 2300-2930)" },
	["30086:30095:7"] = { goto = { 30088, 30071, 7 }, label = "Hard 2/7 (exp 1900-2300)" },
	["30086:30097:7"] = { lobby = true },
	["30086:30099:7"] = { goto = { 30088, 30123, 7 }, label = "Hard 4/7 (exp 3000-4050)" },
	["30086:30121:7"] = { goto = { 30088, 30097, 7 }, label = "Hard 3/7 (exp 2300-2930)" },
	["30086:30123:7"] = { lobby = true },
	["30086:30125:7"] = { goto = { 30088, 30149, 7 }, label = "Hard 5/7 (exp 4100-5000)" },
	["30086:30147:7"] = { goto = { 30088, 30123, 7 }, label = "Hard 4/7 (exp 3000-4050)" },
	["30086:30149:7"] = { lobby = true },
	["30086:30151:7"] = { goto = { 30088, 30175, 7 }, label = "Hard 6/7 (exp 5000-5800)" },
	["30086:30173:7"] = { goto = { 30088, 30149, 7 }, label = "Hard 5/7 (exp 4100-5000)" },
	["30086:30175:7"] = { lobby = true },
	["30086:30177:7"] = { goto = { 30088, 30201, 7 }, label = "Hard 7/7 (exp 5800-6000)" },
	["30086:30199:7"] = { goto = { 30088, 30175, 7 }, label = "Hard 6/7 (exp 5000-5800)" },
	["30086:30201:7"] = { lobby = true },
	["30086:30203:7"] = { goto = { 30088, 30045, 7 }, label = "Hard 1/7 (exp 1520-1900)" },
	["30093:30038:7"] = { hunt = hunts[3].list[1] },
	["30093:30042:7"] = { hunt = hunts[3].list[2] },
	["30093:30048:7"] = { hunt = hunts[3].list[13] },
	["30093:30052:7"] = { hunt = hunts[3].list[14] },
	["30093:30064:7"] = { hunt = hunts[3].list[25] },
	["30093:30068:7"] = { hunt = hunts[3].list[26] },
	["30093:30074:7"] = { hunt = hunts[3].list[37] },
	["30093:30078:7"] = { hunt = hunts[3].list[38] },
	["30093:30090:7"] = { hunt = hunts[3].list[49] },
	["30093:30094:7"] = { hunt = hunts[3].list[50] },
	["30093:30100:7"] = { hunt = hunts[3].list[61] },
	["30093:30104:7"] = { hunt = hunts[3].list[62] },
	["30093:30116:7"] = { hunt = hunts[3].list[73] },
	["30093:30120:7"] = { hunt = hunts[3].list[74] },
	["30093:30126:7"] = { hunt = hunts[3].list[85] },
	["30093:30130:7"] = { hunt = hunts[3].list[86] },
	["30093:30142:7"] = { hunt = hunts[3].list[97] },
	["30093:30146:7"] = { hunt = hunts[3].list[98] },
	["30093:30152:7"] = { hunt = hunts[3].list[109] },
	["30093:30156:7"] = { hunt = hunts[3].list[110] },
	["30093:30168:7"] = { hunt = hunts[3].list[121] },
	["30093:30172:7"] = { hunt = hunts[3].list[122] },
	["30093:30178:7"] = { hunt = hunts[3].list[133] },
	["30093:30182:7"] = { hunt = hunts[3].list[134] },
	["30093:30194:7"] = { hunt = hunts[3].list[145] },
	["30093:30198:7"] = { hunt = hunts[3].list[146] },
	["30096:30038:7"] = { hunt = hunts[3].list[3] },
	["30096:30042:7"] = { hunt = hunts[3].list[4] },
	["30096:30048:7"] = { hunt = hunts[3].list[15] },
	["30096:30052:7"] = { hunt = hunts[3].list[16] },
	["30096:30064:7"] = { hunt = hunts[3].list[27] },
	["30096:30068:7"] = { hunt = hunts[3].list[28] },
	["30096:30074:7"] = { hunt = hunts[3].list[39] },
	["30096:30078:7"] = { hunt = hunts[3].list[40] },
	["30096:30090:7"] = { hunt = hunts[3].list[51] },
	["30096:30094:7"] = { hunt = hunts[3].list[52] },
	["30096:30100:7"] = { hunt = hunts[3].list[63] },
	["30096:30104:7"] = { hunt = hunts[3].list[64] },
	["30096:30116:7"] = { hunt = hunts[3].list[75] },
	["30096:30120:7"] = { hunt = hunts[3].list[76] },
	["30096:30126:7"] = { hunt = hunts[3].list[87] },
	["30096:30130:7"] = { hunt = hunts[3].list[88] },
	["30096:30142:7"] = { hunt = hunts[3].list[99] },
	["30096:30146:7"] = { hunt = hunts[3].list[100] },
	["30096:30152:7"] = { hunt = hunts[3].list[111] },
	["30096:30156:7"] = { hunt = hunts[3].list[112] },
	["30096:30168:7"] = { hunt = hunts[3].list[123] },
	["30096:30172:7"] = { hunt = hunts[3].list[124] },
	["30096:30178:7"] = { hunt = hunts[3].list[135] },
	["30096:30182:7"] = { hunt = hunts[3].list[136] },
	["30096:30194:7"] = { hunt = hunts[3].list[147] },
	["30096:30198:7"] = { hunt = hunts[3].list[148] },
	["30099:30038:7"] = { hunt = hunts[3].list[5] },
	["30099:30042:7"] = { hunt = hunts[3].list[6] },
	["30099:30048:7"] = { hunt = hunts[3].list[17] },
	["30099:30052:7"] = { hunt = hunts[3].list[18] },
	["30099:30064:7"] = { hunt = hunts[3].list[29] },
	["30099:30068:7"] = { hunt = hunts[3].list[30] },
	["30099:30074:7"] = { hunt = hunts[3].list[41] },
	["30099:30078:7"] = { hunt = hunts[3].list[42] },
	["30099:30090:7"] = { hunt = hunts[3].list[53] },
	["30099:30094:7"] = { hunt = hunts[3].list[54] },
	["30099:30100:7"] = { hunt = hunts[3].list[65] },
	["30099:30104:7"] = { hunt = hunts[3].list[66] },
	["30099:30116:7"] = { hunt = hunts[3].list[77] },
	["30099:30120:7"] = { hunt = hunts[3].list[78] },
	["30099:30126:7"] = { hunt = hunts[3].list[89] },
	["30099:30130:7"] = { hunt = hunts[3].list[90] },
	["30099:30142:7"] = { hunt = hunts[3].list[101] },
	["30099:30146:7"] = { hunt = hunts[3].list[102] },
	["30099:30152:7"] = { hunt = hunts[3].list[113] },
	["30099:30156:7"] = { hunt = hunts[3].list[114] },
	["30099:30168:7"] = { hunt = hunts[3].list[125] },
	["30099:30172:7"] = { hunt = hunts[3].list[126] },
	["30099:30178:7"] = { hunt = hunts[3].list[137] },
	["30099:30182:7"] = { hunt = hunts[3].list[138] },
	["30099:30194:7"] = { hunt = hunts[3].list[149] },
	["30099:30198:7"] = { hunt = hunts[3].list[150] },
	["30102:30038:7"] = { hunt = hunts[3].list[7] },
	["30102:30042:7"] = { hunt = hunts[3].list[8] },
	["30102:30048:7"] = { hunt = hunts[3].list[19] },
	["30102:30052:7"] = { hunt = hunts[3].list[20] },
	["30102:30064:7"] = { hunt = hunts[3].list[31] },
	["30102:30068:7"] = { hunt = hunts[3].list[32] },
	["30102:30074:7"] = { hunt = hunts[3].list[43] },
	["30102:30078:7"] = { hunt = hunts[3].list[44] },
	["30102:30090:7"] = { hunt = hunts[3].list[55] },
	["30102:30094:7"] = { hunt = hunts[3].list[56] },
	["30102:30100:7"] = { hunt = hunts[3].list[67] },
	["30102:30104:7"] = { hunt = hunts[3].list[68] },
	["30102:30116:7"] = { hunt = hunts[3].list[79] },
	["30102:30120:7"] = { hunt = hunts[3].list[80] },
	["30102:30126:7"] = { hunt = hunts[3].list[91] },
	["30102:30130:7"] = { hunt = hunts[3].list[92] },
	["30102:30142:7"] = { hunt = hunts[3].list[103] },
	["30102:30146:7"] = { hunt = hunts[3].list[104] },
	["30102:30152:7"] = { hunt = hunts[3].list[115] },
	["30102:30156:7"] = { hunt = hunts[3].list[116] },
	["30102:30168:7"] = { hunt = hunts[3].list[127] },
	["30102:30172:7"] = { hunt = hunts[3].list[128] },
	["30102:30178:7"] = { hunt = hunts[3].list[139] },
	["30102:30182:7"] = { hunt = hunts[3].list[140] },
	["30102:30194:7"] = { hunt = hunts[3].list[151] },
	["30102:30198:7"] = { hunt = hunts[3].list[152] },
	["30105:30038:7"] = { hunt = hunts[3].list[9] },
	["30105:30042:7"] = { hunt = hunts[3].list[10] },
	["30105:30048:7"] = { hunt = hunts[3].list[21] },
	["30105:30052:7"] = { hunt = hunts[3].list[22] },
	["30105:30064:7"] = { hunt = hunts[3].list[33] },
	["30105:30068:7"] = { hunt = hunts[3].list[34] },
	["30105:30074:7"] = { hunt = hunts[3].list[45] },
	["30105:30078:7"] = { hunt = hunts[3].list[46] },
	["30105:30090:7"] = { hunt = hunts[3].list[57] },
	["30105:30094:7"] = { hunt = hunts[3].list[58] },
	["30105:30100:7"] = { hunt = hunts[3].list[69] },
	["30105:30104:7"] = { hunt = hunts[3].list[70] },
	["30105:30116:7"] = { hunt = hunts[3].list[81] },
	["30105:30120:7"] = { hunt = hunts[3].list[82] },
	["30105:30126:7"] = { hunt = hunts[3].list[93] },
	["30105:30130:7"] = { hunt = hunts[3].list[94] },
	["30105:30142:7"] = { hunt = hunts[3].list[105] },
	["30105:30146:7"] = { hunt = hunts[3].list[106] },
	["30105:30152:7"] = { hunt = hunts[3].list[117] },
	["30105:30156:7"] = { hunt = hunts[3].list[118] },
	["30105:30168:7"] = { hunt = hunts[3].list[129] },
	["30105:30172:7"] = { hunt = hunts[3].list[130] },
	["30105:30178:7"] = { hunt = hunts[3].list[141] },
	["30105:30182:7"] = { hunt = hunts[3].list[142] },
	["30105:30194:7"] = { hunt = hunts[3].list[153] },
	["30105:30198:7"] = { hunt = hunts[3].list[154] },
	["30108:30038:7"] = { hunt = hunts[3].list[11] },
	["30108:30042:7"] = { hunt = hunts[3].list[12] },
	["30108:30048:7"] = { hunt = hunts[3].list[23] },
	["30108:30052:7"] = { hunt = hunts[3].list[24] },
	["30108:30064:7"] = { hunt = hunts[3].list[35] },
	["30108:30068:7"] = { hunt = hunts[3].list[36] },
	["30108:30074:7"] = { hunt = hunts[3].list[47] },
	["30108:30078:7"] = { hunt = hunts[3].list[48] },
	["30108:30090:7"] = { hunt = hunts[3].list[59] },
	["30108:30094:7"] = { hunt = hunts[3].list[60] },
	["30108:30100:7"] = { hunt = hunts[3].list[71] },
	["30108:30104:7"] = { hunt = hunts[3].list[72] },
	["30108:30116:7"] = { hunt = hunts[3].list[83] },
	["30108:30120:7"] = { hunt = hunts[3].list[84] },
	["30108:30126:7"] = { hunt = hunts[3].list[95] },
	["30108:30130:7"] = { hunt = hunts[3].list[96] },
	["30108:30142:7"] = { hunt = hunts[3].list[107] },
	["30108:30146:7"] = { hunt = hunts[3].list[108] },
	["30108:30152:7"] = { hunt = hunts[3].list[119] },
	["30108:30156:7"] = { hunt = hunts[3].list[120] },
	["30108:30168:7"] = { hunt = hunts[3].list[131] },
	["30108:30172:7"] = { hunt = hunts[3].list[132] },
	["30108:30178:7"] = { hunt = hunts[3].list[143] },
	["30108:30182:7"] = { hunt = hunts[3].list[144] },
	["30108:30194:7"] = { hunt = hunts[3].list[155] },
	["30131:30043:7"] = { goto = { 30133, 30123, 7 }, label = "Very Hard 4/4 (exp 13560-66000)" },
	["30131:30045:7"] = { lobby = true },
	["30131:30047:7"] = { goto = { 30133, 30071, 7 }, label = "Very Hard 2/4 (exp 7020-9000)" },
	["30131:30069:7"] = { goto = { 30133, 30045, 7 }, label = "Very Hard 1/4 (exp 6050-7000)" },
	["30131:30071:7"] = { lobby = true },
	["30131:30073:7"] = { goto = { 30133, 30097, 7 }, label = "Very Hard 3/4 (exp 9000-13543)" },
	["30131:30095:7"] = { goto = { 30133, 30071, 7 }, label = "Very Hard 2/4 (exp 7020-9000)" },
	["30131:30097:7"] = { lobby = true },
	["30131:30099:7"] = { goto = { 30133, 30123, 7 }, label = "Very Hard 4/4 (exp 13560-66000)" },
	["30131:30121:7"] = { goto = { 30133, 30097, 7 }, label = "Very Hard 3/4 (exp 9000-13543)" },
	["30131:30123:7"] = { lobby = true },
	["30131:30125:7"] = { goto = { 30133, 30045, 7 }, label = "Very Hard 1/4 (exp 6050-7000)" },
	["30138:30038:7"] = { hunt = hunts[4].list[1] },
	["30138:30042:7"] = { hunt = hunts[4].list[2] },
	["30138:30048:7"] = { hunt = hunts[4].list[13] },
	["30138:30052:7"] = { hunt = hunts[4].list[14] },
	["30138:30064:7"] = { hunt = hunts[4].list[25] },
	["30138:30068:7"] = { hunt = hunts[4].list[26] },
	["30138:30074:7"] = { hunt = hunts[4].list[37] },
	["30138:30078:7"] = { hunt = hunts[4].list[38] },
	["30138:30090:7"] = { hunt = hunts[4].list[49] },
	["30138:30094:7"] = { hunt = hunts[4].list[50] },
	["30138:30100:7"] = { hunt = hunts[4].list[61] },
	["30138:30104:7"] = { hunt = hunts[4].list[62] },
	["30138:30116:7"] = { hunt = hunts[4].list[73] },
	["30138:30120:7"] = { hunt = hunts[4].list[74] },
	["30141:30038:7"] = { hunt = hunts[4].list[3] },
	["30141:30042:7"] = { hunt = hunts[4].list[4] },
	["30141:30048:7"] = { hunt = hunts[4].list[15] },
	["30141:30052:7"] = { hunt = hunts[4].list[16] },
	["30141:30064:7"] = { hunt = hunts[4].list[27] },
	["30141:30068:7"] = { hunt = hunts[4].list[28] },
	["30141:30074:7"] = { hunt = hunts[4].list[39] },
	["30141:30078:7"] = { hunt = hunts[4].list[40] },
	["30141:30090:7"] = { hunt = hunts[4].list[51] },
	["30141:30094:7"] = { hunt = hunts[4].list[52] },
	["30141:30100:7"] = { hunt = hunts[4].list[63] },
	["30141:30104:7"] = { hunt = hunts[4].list[64] },
	["30141:30116:7"] = { hunt = hunts[4].list[75] },
	["30141:30120:7"] = { hunt = hunts[4].list[76] },
	["30144:30038:7"] = { hunt = hunts[4].list[5] },
	["30144:30042:7"] = { hunt = hunts[4].list[6] },
	["30144:30048:7"] = { hunt = hunts[4].list[17] },
	["30144:30052:7"] = { hunt = hunts[4].list[18] },
	["30144:30064:7"] = { hunt = hunts[4].list[29] },
	["30144:30068:7"] = { hunt = hunts[4].list[30] },
	["30144:30074:7"] = { hunt = hunts[4].list[41] },
	["30144:30078:7"] = { hunt = hunts[4].list[42] },
	["30144:30090:7"] = { hunt = hunts[4].list[53] },
	["30144:30094:7"] = { hunt = hunts[4].list[54] },
	["30144:30100:7"] = { hunt = hunts[4].list[65] },
	["30144:30104:7"] = { hunt = hunts[4].list[66] },
	["30144:30116:7"] = { hunt = hunts[4].list[77] },
	["30144:30120:7"] = { hunt = hunts[4].list[78] },
	["30147:30038:7"] = { hunt = hunts[4].list[7] },
	["30147:30042:7"] = { hunt = hunts[4].list[8] },
	["30147:30048:7"] = { hunt = hunts[4].list[19] },
	["30147:30052:7"] = { hunt = hunts[4].list[20] },
	["30147:30064:7"] = { hunt = hunts[4].list[31] },
	["30147:30068:7"] = { hunt = hunts[4].list[32] },
	["30147:30074:7"] = { hunt = hunts[4].list[43] },
	["30147:30078:7"] = { hunt = hunts[4].list[44] },
	["30147:30090:7"] = { hunt = hunts[4].list[55] },
	["30147:30094:7"] = { hunt = hunts[4].list[56] },
	["30147:30100:7"] = { hunt = hunts[4].list[67] },
	["30147:30104:7"] = { hunt = hunts[4].list[68] },
	["30147:30116:7"] = { hunt = hunts[4].list[79] },
	["30150:30038:7"] = { hunt = hunts[4].list[9] },
	["30150:30042:7"] = { hunt = hunts[4].list[10] },
	["30150:30048:7"] = { hunt = hunts[4].list[21] },
	["30150:30052:7"] = { hunt = hunts[4].list[22] },
	["30150:30064:7"] = { hunt = hunts[4].list[33] },
	["30150:30068:7"] = { hunt = hunts[4].list[34] },
	["30150:30074:7"] = { hunt = hunts[4].list[45] },
	["30150:30078:7"] = { hunt = hunts[4].list[46] },
	["30150:30090:7"] = { hunt = hunts[4].list[57] },
	["30150:30094:7"] = { hunt = hunts[4].list[58] },
	["30150:30100:7"] = { hunt = hunts[4].list[69] },
	["30150:30104:7"] = { hunt = hunts[4].list[70] },
	["30153:30038:7"] = { hunt = hunts[4].list[11] },
	["30153:30042:7"] = { hunt = hunts[4].list[12] },
	["30153:30048:7"] = { hunt = hunts[4].list[23] },
	["30153:30052:7"] = { hunt = hunts[4].list[24] },
	["30153:30064:7"] = { hunt = hunts[4].list[35] },
	["30153:30068:7"] = { hunt = hunts[4].list[36] },
	["30153:30074:7"] = { hunt = hunts[4].list[47] },
	["30153:30078:7"] = { hunt = hunts[4].list[48] },
	["30153:30090:7"] = { hunt = hunts[4].list[59] },
	["30153:30094:7"] = { hunt = hunts[4].list[60] },
	["30153:30100:7"] = { hunt = hunts[4].list[71] },
	["30153:30104:7"] = { hunt = hunts[4].list[72] },
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

local function placeReturn(pos)
	local item = Game.createItem(ENTRY_ITEM_ID, 1, pos)
	if item then
		item:setActionId(RETURN_ACTION_ID)
		return true
	end
	return false
end

-- Strefa 3x3 (raz) i teleport powrotny obok miejsca ladowania.
-- Teleport: najpierw puste pole, a gdy takiego nie ma (wszedzie leza ozdoby,
-- trawa itp.), dowolne pole, po ktorym da sie chodzic. Ponawiane przy kazdym
-- teleporcie, dopoki sie nie uda.
local function prepareSpot(center)
	local id = key(center)
	local spot = preparedSpots[id]
	if not spot then
		spot = { teleport = false }
		preparedSpots[id] = spot
		for dx = -1, 1 do
			for dy = -1, 1 do
				safeTiles[key(Position(center.x + dx, center.y + dy, center.z))] = true
			end
		end
	end

	if spot.teleport or not templePosition then
		return
	end

	local fallback = nil
	for dx = -1, 1 do
		for dy = -1, 1 do
			if not (dx == 0 and dy == 0) then
				local pos = Position(center.x + dx, center.y + dy, center.z)
				local tile = Tile(pos)
				if tile then
					local existing = tile:getItemById(ENTRY_ITEM_ID)
					if existing and existing:getActionId() == RETURN_ACTION_ID then
						spot.teleport = true
						return
					end
					if tile:isWalkable(false, false, true, true, false) then
						if tile:getItemCount() == 0 then
							if placeReturn(pos) then
								spot.teleport = true
								return
							end
						elseif not fallback then
							fallback = pos
						end
					end
				end
			end
		end
	end

	if fallback and placeReturn(fallback) then
		spot.teleport = true
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

-- Arena: wspolna sala walk. Bossy bez dzwigni pojawiaja sie tu na zadanie, a questy
-- bez wlasnej walki maja tu fale potworow; po wybiciu fali gracz trafia pod skrzynie.
-- Odroczone sprawdzenia trzymaja tylko identyfikatory i numer walki (token),
-- wiec po nowej walce albo zniknieciu gracza stare sprawdzenie nic nie robi.
local arenaState = { token = 0, ids = {} }

local function arenaClear()
	for _, id in ipairs(arenaState.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	arenaState.ids = {}
end

local function inArena(player)
	local pos = player:getPosition()
	return pos.z == arenaCenter.z and math.abs(pos.x - arenaCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - arenaCenter.y) <= ARENA_RADIUS + 1
end

local function arenaCheck(playerId, token, label, chest, hint)
	if token ~= arenaState.token then
		return
	end
	local player = Player(playerId)
	if not player or not inArena(player) then
		arenaClear()
		return
	end
	for _, id in ipairs(arenaState.ids) do
		if Creature(id) then
			addEvent(arenaCheck, 2000, playerId, token, label, chest, hint)
			return
		end
	end
	arenaState.ids = {}
	if chest then
		player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
		travel(player, { label .. " - nagroda", chest[1], chest[2], chest[3], hint = hint })
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Pokonano: " .. label .. ". Loot jest w zwlokach albo w skrzyni nagrod w swiatyni. Teleport powrotny stoi przy wejsciu na arene.")
	end
end

local function arenaStart(player, entry)
	if inFight(player) then
		return
	end
	arenaClear()
	arenaState.token = arenaState.token + 1
	local token = arenaState.token
	travel(player, { entry[1], arenaLanding.x, arenaLanding.y, arenaLanding.z })
	if not inArena(player) then
		return
	end
	local missing = 0
	for _, wave in ipairs(entry.arena) do
		for _ = 1, wave[2] do
			local pos = Position(arenaCenter.x + math.random(-ARENA_RADIUS + 1, ARENA_RADIUS - 1), arenaCenter.y + math.random(-ARENA_RADIUS + 1, 2), arenaCenter.z)
			local monster = Game.createMonster(wave[1], pos, true, true)
			if monster then
				arenaState.ids[#arenaState.ids + 1] = monster:getId()
			else
				missing = missing + 1
			end
		end
	end
	if #arenaState.ids == 0 then
		player:sendCancelMessage("Nie udalo sie przywolac przeciwnika: " .. entry[1])
		return
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Arena: przeciwnikow " .. #arenaState.ids .. (missing > 0 and (" (nie pojawilo sie: " .. missing .. ")") or "") .. ". " .. (entry.chest and "Po wybiciu wszystkich trafisz pod skrzynie z nagroda." or "Walka zaczyna sie, gdy wyjdziesz ze strefy."))
	addEvent(arenaCheck, 2000, player:getId(), token, entry[1], entry.chest, entry.hint)
end

local openMain

-- Uruchamia cel z listy: zwykly teleport albo quest z wlasnym skryptem.
local function startEntry(player, entry)
	if entry.arena then
		arenaStart(player, entry)
		return
	end
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
	for i = 1, math.min(#list, 255) do
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
	local window = ModalWindow({ title = "Expowiska", message = "Wybierz poziom trudnosci." })
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
	window:addChoice("Expowiska (Low / Medium / Hard / Very Hard)", function(target)
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
local HUB_MESSAGES = true
local hubMove, hubLobbyMessage

-- Teleport przy swiatyni w Thais
local entryStep = MoveEvent()

function entryStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	-- Teleport w swiatyni prowadzi do hubu expowisk; pelne menu jest pod komenda !tp.
	hubMove(player, hubLobby, "Hub: lobby")
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
	-- Krotkie opisy przy przejsciach w hubie. Klient sam dobiera czas wyswietlania do dlugosci
	-- tekstu, wiec zeby znikaly szybko, musza byc jednolinijkowe. HUB_MESSAGES = false je wylacza.
	if HUB_MESSAGES and message then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	end
end

hubLobbyMessage = function()
	local names = {}
	for i = 1, #hubWings do
		names[i] = hubWings[i].label
	end
	return "Hub. Expowiska na polnocy, od zachodu: " .. table.concat(names, ", ") .. ". Na poludniu: stroje, Thais, questy, bossy."
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
		hubMove(player, Position(wing.x, wing.y, wing.z), "EXP " .. wing.label .. ", pietro 1")
	elseif action.goto then
		hubMove(player, Position(action.goto[1], action.goto[2], action.goto[3]), action.label)
	elseif action.lobby then
		hubMove(player, hubLobby, "Hub: lobby")
	elseif action.thais and templePosition then
		hubMove(player, templePosition)
	elseif action.outfits and OtsOutfitHall then
		OtsOutfitHall(player)
	elseif action.questhall then
		hubMove(player, hubQuestHall, "Hala questow")
	elseif action.quest then
		startEntry(player, action.quest)
	elseif action.bosshall then
		hubMove(player, hubBossHall, "Hala bossow, pietro 1")
	elseif action.boss then
		startEntry(player, action.boss)
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
		text = "Expowiska: " .. hubWings[action.wing].label
	elseif action.goto then
		text = "Przejscie: " .. action.label
	elseif action.lobby then
		text = "Powrot do lobby hubu"
	elseif action.outfits then
		text = "Questy na stroje"
	elseif action.questhall then
		text = "Hala questow"
	elseif action.quest then
		text = "Quest: " .. action.quest[1]
	elseif action.bosshall then
		text = "Hala bossow"
	elseif action.boss then
		text = "Boss: " .. action.boss[1]
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

	-- Teleport do Event Room w swiatyni (z mapy dodatkowej) zamieniamy na wejscie do hubu.
	local eventRoomPosition = Position(32373, 32236, 7)
	local eventTile = Tile(eventRoomPosition)
	if eventTile then
		local old = eventTile:getItemById(ENTRY_ITEM_ID)
		if old then
			old:remove()
			local item = Game.createItem(ENTRY_ITEM_ID, 1, eventRoomPosition)
			if item then
				item:setActionId(ENTRY_ACTION_ID)
				logger.info("[OTS teleporty] Teleport Event Room w swiatyni prowadzi teraz do hubu: {}, {}, {}", eventRoomPosition.x, eventRoomPosition.y, eventRoomPosition.z)
				return true
			end
		end
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
