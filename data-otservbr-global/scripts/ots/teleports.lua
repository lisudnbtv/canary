-- OTS: menu teleportow (expowiska, bossy, questy, miasta).
-- Plik generowany z danych serwera (spawny potworow i dzwignie bossow).
-- Wejscie: teleport przy swiatyni w Thais albo komenda !tp.

local ENTRY_ACTION_ID = 64990
local ENTRY_ITEM_ID = 1949 -- magic forcefield
local ENTRY_TOWN = "thais"
local RETURN_ACTION_ID = 64991 -- teleport powrotny do hubu expowisk

local hunts = {
	{ label = "Low (exp do 300)", list = {
		{ "Azure Frog (20 exp, 14x)", 32372, 32910, 7, mon = "Azure Frog" },
		{ "Coral Frog (20 exp, 9x)", 32375, 32968, 7, mon = "Coral Frog" },
		{ "Crimson Frog (20 exp, 15x)", 32400, 32971, 7, mon = "Crimson Frog" },
		{ "Hyaena (20 exp, 14x)", 33006, 32657, 11, mon = "Hyaena" },
		{ "Island Troll (20 exp, 33x)", 32133, 32540, 7, mon = "Island Troll" },
		{ "Orchid Frog (20 exp, 8x)", 32507, 32914, 7, mon = "Orchid Frog" },
		{ "Sandcrawler (20 exp, 37x)", 33092, 31506, 7, mon = "Sandcrawler" },
		{ "Spit Nettle (20 exp, 24x)", 32997, 32577, 7, mon = "Spit Nettle" },
		{ "Troll (20 exp, 61x)", 32284, 32128, 8, mon = "Troll" },
		{ "Water Buffalo (20 exp, 15x)", 32920, 32185, 7, mon = "Water Buffalo" },
		{ "Winter Wolf (20 exp, 33x)", 31980, 31281, 7, mon = "Winter Wolf" },
		{ "Cream Blob (21 exp, 9x)", 33422, 32122, 7, mon = "Cream Blob" },
		{ "Poison Spider (22 exp, 26x)", 32816, 32912, 8, mon = "Poison Spider" },
		{ "Bear (23 exp, 13x)", 32149, 32047, 10, mon = "Bear" },
		{ "Frost Troll (23 exp, 34x)", 32093, 31053, 9, mon = "Frost Troll" },
		{ "Panda (23 exp, 21x)", 32627, 32852, 7, mon = "Panda" },
		{ "Wasp (24 exp, 31x)", 32420, 32302, 9, mon = "Wasp" },
		{ "Demon Goblin (25 exp, 13x)", 32817, 32321, 14, mon = "Demon Goblin" },
		{ "Goblin (25 exp, 42x)", 32555, 31830, 6, mon = "Goblin" },
		{ "Orc (25 exp, 34x)", 32898, 31777, 7, mon = "Orc" },
		{ "Salamander (25 exp, 35x)", 32868, 32169, 10, mon = "Salamander" },
		{ "Swamp Troll (25 exp, 44x)", 32961, 32231, 8, mon = "Swamp Troll" },
		{ "Polar Bear (28 exp, 18x)", 32282, 31064, 7, mon = "Polar Bear" },
		{ "Cobra (30 exp, 21x)", 32955, 32526, 7, mon = "Cobra" },
		{ "Crab (30 exp, 17x)", 32180, 32938, 8, mon = "Crab" },
		{ "Lion (30 exp, 12x)", 32691, 32138, 7, mon = "Lion" },
		{ "Centipede (34 exp, 35x)", 32235, 32774, 9, mon = "Centipede" },
		{ "Crazed Beggar (35 exp, 11x)", 32920, 31274, 7, mon = "Crazed Beggar" },
		{ "Dworc Venomsniper (35 exp, 83x)", 32669, 32918, 8, mon = "Dworc Venomsniper" },
		{ "Emerald Damselfly (35 exp, 26x)", 32846, 32098, 10, mon = "Emerald Damselfly" },
		{ "Skeleton (35 exp, 67x)", 32392, 31982, 9, mon = "Skeleton" },
		{ "Goblin Scavenger (37 exp, 20x)", 33107, 31866, 10, mon = "Goblin Scavenger" },
		{ "Orc Spearman (38 exp, 46x)", 32901, 31772, 7, mon = "Orc Spearman" },
		{ "Chakoya Toolshaper (40 exp, 72x)", 32452, 31066, 10, mon = "Chakoya Toolshaper" },
		{ "Chakoya Tribewarden (40 exp, 44x)", 32452, 31073, 10, mon = "Chakoya Tribewarden" },
		{ "Crocodile (40 exp, 32x)", 32611, 32677, 8, mon = "Crocodile" },
		{ "Dworc Fleshhunter (40 exp, 61x)", 32761, 32869, 8, mon = "Dworc Fleshhunter" },
		{ "Insect Swarm (40 exp, 13x)", 33208, 31386, 7, mon = "Insect Swarm" },
		{ "Rotworm (40 exp, 81x)", 32251, 32814, 9, mon = "Rotworm" },
		{ "Tiger (40 exp, 10x)", 32722, 32710, 7, mon = "Tiger" },
		{ "Troll Champion (40 exp, 17x)", 32647, 31979, 9, mon = "Troll Champion" },
		{ "Elf (42 exp, 21x)", 33054, 32199, 8, mon = "Elf" },
		{ "Larva (44 exp, 130x)", 33223, 32607, 9, mon = "Larva" },
		{ "Dwarf (45 exp, 51x)", 32551, 31878, 9, mon = "Dwarf" },
		{ "Leaf Golem (45 exp, 49x)", 33266, 31993, 11, mon = "Leaf Golem" },
		{ "Scorpion (45 exp, 29x)", 32242, 31923, 11, mon = "Scorpion" },
		{ "Skeleton Warrior (45 exp, 13x)", 32973, 32441, 10, mon = "Skeleton Warrior" },
		{ "Swampling (45 exp, 9x)", 33325, 31952, 8, mon = "Swampling" },
		{ "Chakoya Windcaller (48 exp, 33x)", 32449, 31068, 10, mon = "Chakoya Windcaller" },
		{ "Smuggler (48 exp, 26x)", 32860, 31321, 6, mon = "Smuggler" },
		{ "Marsh Stalker (50 exp, 20x)", 32847, 32101, 10, mon = "Marsh Stalker" },
		{ "Minotaur (50 exp, 37x)", 32411, 32107, 15, mon = "Minotaur" },
		{ "Minotaur Bruiser (50 exp, 30x)", 32039, 31846, 8, mon = "Minotaur Bruiser" },
		{ "Orc Warrior (50 exp, 49x)", 32936, 31705, 7, mon = "Orc Warrior" },
		{ "Goblin Assassin (52 exp, 16x)", 33107, 31867, 10, mon = "Goblin Assassin" },
		{ "Dworc Voodoomaster (55 exp, 23x)", 32761, 32868, 8, mon = "Dworc Voodoomaster" },
		{ "Minotaur Poacher (55 exp, 16x)", 32001, 31840, 10, mon = "Minotaur Poacher" },
		{ "War Wolf (55 exp, 18x)", 33423, 31563, 11, mon = "War Wolf" },
		{ "Amazon (60 exp, 30x)", 32833, 31925, 7, mon = "Amazon" },
		{ "Boar (60 exp, 17x)", 32601, 32262, 7, mon = "Boar" },
		{ "Dwarf Miner (60 exp, 11x)", 32069, 31940, 11, mon = "Dwarf Miner" },
		{ "Gnarlhound (60 exp, 26x)", 33050, 31514, 8, mon = "Gnarlhound" },
		{ "Nomad (60 exp, 31x)", 33231, 32514, 8, mon = "Nomad" },
		{ "Toad (60 exp, 36x)", 32368, 32963, 7, mon = "Toad" },
		{ "Wild Warrior (60 exp, 19x)", 32658, 32360, 8, mon = "Wild Warrior" },
		{ "Bandit (65 exp, 36x)", 32657, 32361, 8, mon = "Bandit" },
		{ "Ghost Wolf (65 exp, 11x)", 32789, 31936, 10, mon = "Ghost Wolf" },
		{ "Minotaur Archer (65 exp, 12x)", 32251, 32435, 10, mon = "Minotaur Archer" },
		{ "Carrion Worm (70 exp, 35x)", 32235, 32711, 10, mon = "Carrion Worm" },
		{ "Dwarf Soldier (70 exp, 67x)", 32511, 31908, 11, mon = "Dwarf Soldier" },
		{ "Gang Member (70 exp, 25x)", 32828, 31303, 7, mon = "Gang Member" },
		{ "Gloom Wolf (70 exp, 15x)", 32788, 31936, 10, mon = "Gloom Wolf" },
		{ "Ladybug (70 exp, 35x)", 33544, 31277, 7, mon = "Ladybug" },
		{ "Slug (70 exp, 15x)", 32928, 32126, 9, mon = "Slug" },
		{ "Elf Scout (75 exp, 12x)", 32759, 31280, 7, mon = "Elf Scout" },
		{ "Firestarter (80 exp, 17x)", 33085, 32157, 7, mon = "Firestarter" },
		{ "Barbarian Headsplitter (85 exp, 37x)", 32006, 31272, 7, mon = "Barbarian Headsplitter" },
		{ "Barbarian Skullhunter (85 exp, 29x)", 31999, 31270, 7, mon = "Barbarian Skullhunter" },
		{ "Ghoul (85 exp, 41x)", 33383, 31667, 11, mon = "Ghoul" },
		{ "Pirate Skeleton (85 exp, 25x)", 32040, 32563, 7, mon = "Pirate Skeleton" },
		{ "Valkyrie (85 exp, 18x)", 32847, 31916, 8, mon = "Valkyrie" },
		{ "Barbarian Brutetamer (90 exp, 16x)", 32051, 31338, 7, mon = "Barbarian Brutetamer" },
		{ "Gazer (90 exp, 17x)", 32087, 32791, 8, mon = "Gazer" },
		{ "Gladiator (90 exp, 19x)", 32654, 31232, 6, mon = "Gladiator" },
		{ "Stalker (90 exp, 70x)", 33083, 32978, 14, mon = "Stalker" },
		{ "Tortoise (90 exp, 74x)", 32465, 32939, 9, mon = "Tortoise" },
		{ "Damaged Worker Golem (95 exp, 19x)", 32888, 31254, 8, mon = "Damaged Worker Golem" },
		{ "Dark Apprentice (100 exp, 11x)", 32921, 31084, 5, mon = "Dark Apprentice" },
		{ "Novice of the Cult (100 exp, 87x)", 32144, 31120, 9, mon = "Novice of the Cult" },
		{ "Quara Mantassin Scout (100 exp, 20x)", 31950, 32690, 9, mon = "Quara Mantassin Scout" },
		{ "Assassin (105 exp, 26x)", 32614, 32472, 9, mon = "Assassin" },
		{ "Rorc (105 exp, 47x)", 32782, 31805, 7, mon = "Rorc" },
		{ "Sibang (105 exp, 63x)", 32780, 32540, 7, mon = "Sibang" },
		{ "Lizard Sentinel (110 exp, 62x)", 32919, 32871, 7, mon = "Lizard Sentinel" },
		{ "Orc Rider (110 exp, 23x)", 33312, 31472, 7, mon = "Orc Rider" },
		{ "Orc Shaman (110 exp, 20x)", 32932, 31819, 7, mon = "Orc Shaman" },
		{ "Kongra (115 exp, 52x)", 32792, 32550, 7, mon = "Kongra" },
		{ "Ghost (120 exp, 53x)", 33083, 32978, 14, mon = "Ghost" },
		{ "Scarab (120 exp, 94x)", 33163, 32528, 10, mon = "Scarab" },
		{ "Tarantula (120 exp, 41x)", 32877, 32907, 9, mon = "Tarantula" },
		{ "Tarnished Spirit (120 exp, 25x)", 33042, 32422, 8, mon = "Tarnished Spirit" },
		{ "White Shade (120 exp, 25x)", 32976, 32363, 11, mon = "White Shade" },
		{ "Witch (120 exp, 15x)", 32614, 32476, 9, mon = "Witch" },
		{ "Manta Ray (125 exp, 8x)", 33552, 31293, 13, mon = "Manta Ray" },
		{ "Pirate Marauder (125 exp, 54x)", 31960, 32805, 6, mon = "Pirate Marauder" },
		{ "Deepling Worker (130 exp, 30x)", 33549, 31275, 14, mon = "Deepling Worker" },
		{ "Troll Legionnaire (140 exp, 15x)", 32760, 31454, 12, mon = "Troll Legionnaire" },
		{ "Dark Monk (145 exp, 33x)", 32614, 32474, 9, mon = "Dark Monk" },
		{ "Fire Devil (145 exp, 22x)", 32016, 32599, 8, mon = "Fire Devil" },
		{ "Merlkin (145 exp, 26x)", 32836, 32533, 9, mon = "Merlkin" },
		{ "Carniphila (150 exp, 33x)", 32950, 32524, 7, mon = "Carniphila" },
		{ "Corym Charlatan (150 exp, 30x)", 33008, 32198, 11, mon = "Corym Charlatan" },
		{ "Cyclops (150 exp, 45x)", 32485, 32058, 8, mon = "Cyclops" },
		{ "Frost Giant (150 exp, 27x)", 32413, 31302, 9, mon = "Frost Giant" },
		{ "Frost Giantess (150 exp, 19x)", 32413, 31301, 9, mon = "Frost Giantess" },
		{ "Gargoyle (150 exp, 45x)", 32232, 32579, 8, mon = "Gargoyle" },
		{ "Minotaur Mage (150 exp, 10x)", 32251, 32433, 10, mon = "Minotaur Mage" },
		{ "Mummy (150 exp, 43x)", 32205, 32672, 9, mon = "Mummy" },
		{ "Mutated Human (150 exp, 31x)", 32696, 31162, 6, mon = "Mutated Human" },
		{ "Terror Bird (150 exp, 13x)", 32994, 32578, 7, mon = "Terror Bird" },
		{ "Thornback Tortoise (150 exp, 71x)", 32373, 32961, 9, mon = "Thornback Tortoise" },
		{ "Lizard Templar (155 exp, 62x)", 32920, 32871, 7, mon = "Lizard Templar" },
		{ "Blood Crab (160 exp, 43x)", 31939, 31046, 8, mon = "Blood Crab" },
		{ "Deepling Scout (160 exp, 30x)", 33493, 31281, 13, mon = "Deepling Scout" },
		{ "Elephant (160 exp, 17x)", 32951, 32750, 7, mon = "Elephant" },
		{ "Mammoth (160 exp, 38x)", 32140, 31289, 6, mon = "Mammoth" },
		{ "Minotaur Guard (160 exp, 21x)", 32402, 32102, 15, mon = "Minotaur Guard" },
		{ "Slime (160 exp, 35x)", 33393, 32790, 14, mon = "Slime" },
		{ "Stone Golem (160 exp, 24x)", 33040, 31480, 11, mon = "Stone Golem" },
		{ "Terramite (160 exp, 54x)", 33200, 32451, 9, mon = "Terramite" },
		{ "Dwarf Guard (165 exp, 78x)", 32528, 31925, 13, mon = "Dwarf Guard" },
		{ "Vampire Pig (165 exp, 10x)", 32751, 31483, 6, mon = "Vampire Pig" },
		{ "Bonelord (170 exp, 43x)", 32104, 32774, 8, mon = "Bonelord" },
		{ "Elf Arcanist (175 exp, 14x)", 32768, 31290, 6, mon = "Elf Arcanist" },
		{ "Pirate Cutthroat (175 exp, 26x)", 31969, 32816, 4, mon = "Pirate Cutthroat" },
		{ "Gozzler (180 exp, 25x)", 32849, 31055, 7, mon = "Gozzler" },
		{ "Mercury Blob (180 exp, 8x)", 32696, 31168, 6, mon = "Mercury Blob" },
		{ "Dark Magician (185 exp, 11x)", 32920, 31087, 5, mon = "Dark Magician" },
		{ "Dragon Hatchling (185 exp, 23x)", 33048, 31172, 7, mon = "Dragon Hatchling" },
		{ "Furious Troll (185 exp, 11x)", 32752, 31470, 13, mon = "Furious Troll" },
		{ "Dryad (190 exp, 19x)", 33236, 31974, 10, mon = "Dryad" },
		{ "Barbarian Bloodwalker (195 exp, 18x)", 32001, 31416, 7, mon = "Barbarian Bloodwalker" },
		{ "Crypt Shambler (195 exp, 43x)", 33375, 32762, 14, mon = "Crypt Shambler" },
		{ "Ghoulish Hyaena (195 exp, 11x)", 33000, 32759, 8, mon = "Ghoulish Hyaena" },
		{ "Orc Berserker (195 exp, 66x)", 32877, 31790, 7, mon = "Orc Berserker" },
		{ "Cyclops Drone (200 exp, 23x)", 32602, 31417, 6, mon = "Cyclops Drone" },
		{ "Monk (200 exp, 13x)", 33373, 31347, 3, mon = "Monk" },
		{ "Quara Constrictor Scout (200 exp, 15x)", 31949, 32672, 8, mon = "Quara Constrictor Scout" },
		{ "Mad Scientist (205 exp, 12x)", 32892, 31097, 6, mon = "Mad Scientist" },
		{ "Orc Marauder (205 exp, 25x)", 33242, 31515, 7, mon = "Orc Marauder" },
		{ "Iron Servant (210 exp, 86x)", 32769, 32871, 13, mon = "Iron Servant" },
		{ "Lizard Snakecharmer (210 exp, 17x)", 33306, 31506, 7, mon = "Lizard Snakecharmer" },
		{ "Green Djinn (215 exp, 19x)", 33062, 32739, 14, mon = "Green Djinn" },
		{ "Tomb Servant (215 exp, 19x)", 32949, 32761, 10, mon = "Tomb Servant" },
		{ "Fire Elemental (220 exp, 38x)", 33265, 32910, 15, mon = "Fire Elemental" },
		{ "Wilting Leaf Golem (225 exp, 28x)", 33199, 31997, 11, mon = "Wilting Leaf Golem" },
		{ "Demon Skeleton (240 exp, 37x)", 33002, 32412, 11, mon = "Demon Skeleton" },
		{ "Acid Blob (250 exp, 11x)", 32698, 31162, 6, mon = "Acid Blob" },
		{ "Pirate Buccaneer (250 exp, 19x)", 32639, 31296, 6, mon = "Pirate Buccaneer" },
		{ "Cyclops Smith (255 exp, 15x)", 33313, 31667, 11, mon = "Cyclops Smith" },
		{ "Corym Skirmisher (260 exp, 27x)", 33006, 32196, 11, mon = "Corym Skirmisher" },
		{ "Dwarf Geomancer (265 exp, 20x)", 32590, 31428, 14, mon = "Dwarf Geomancer" },
		{ "Orc Leader (270 exp, 13x)", 33062, 31333, 8, mon = "Orc Leader" },
		{ "Lancer Beetle (275 exp, 30x)", 33252, 31379, 8, mon = "Lancer Beetle" },
		{ "Elder Bonelord (280 exp, 15x)", 32113, 32804, 9, mon = "Elder Bonelord" },
		{ "Zombie (280 exp, 70x)", 32188, 32966, 10, mon = "Zombie" },
		{ "Ice Golem (295 exp, 37x)", 32216, 31065, 10, mon = "Ice Golem" },
		{ "Acolyte of the Cult (300 exp, 45x)", 32082, 31070, 10, mon = "Acolyte of the Cult" },
		{ "Death Blob (300 exp, 33x)", 33083, 31104, 9, mon = "Death Blob" },
	} },
	{ label = "Medium (exp 300-1500)", list = {
		{ "Vampire (305 exp, 37x)", 33094, 32916, 14, mon = "Vampire" },
		{ "Haunted Treeling (310 exp, 45x)", 32926, 31507, 7, mon = "Haunted Treeling" },
		{ "Electric Sparks (320 exp, 8x)", 33402, 31476, 14, mon = "Electric Sparks" },
		{ "Guilt (320 exp, 31x)", 33491, 32866, 12, mon = "Guilt" },
		{ "Forest Fury (330 exp, 9x)", 33217, 32041, 10, mon = "Forest Fury" },
		{ "Sacred Spider (330 exp, 16x)", 32941, 32732, 10, mon = "Sacred Spider" },
		{ "Swarmer (350 exp, 56x)", 33552, 31265, 7, mon = "Swarmer" },
		{ "Quara Constrictor (380 exp, 34x)", 32070, 32767, 12, mon = "Quara Constrictor" },
		{ "Adept of the Cult (400 exp, 22x)", 32026, 31196, 10, mon = "Adept of the Cult" },
		{ "Bane Bringer (400 exp, 12x)", 32740, 31952, 13, mon = "Bane Bringer" },
		{ "Clay Guardian (400 exp, 34x)", 32308, 32587, 11, mon = "Clay Guardian" },
		{ "Quara Predator Scout (400 exp, 24x)", 31950, 32688, 9, mon = "Quara Predator Scout" },
		{ "Shadow Pupil (410 exp, 13x)", 33005, 32448, 12, mon = "Shadow Pupil" },
		{ "Priestess (420 exp, 20x)", 33042, 32405, 10, mon = "Priestess" },
		{ "Baleful Bunny (450 exp, 12x)", 33789, 31024, 7, mon = "Baleful Bunny" },
		{ "Blazing Fire Elemental (450 exp, 14x)", 33200, 32191, 13, mon = "Blazing Fire Elemental" },
		{ "Charged Energy Elemental (450 exp, 28x)", 33099, 32123, 13, mon = "Charged Energy Elemental" },
		{ "Muddy Earth Elemental (450 exp, 50x)", 33362, 32106, 13, mon = "Muddy Earth Elemental" },
		{ "Mutated Rat (450 exp, 36x)", 32213, 32707, 12, mon = "Mutated Rat" },
		{ "Slick Water Elemental (450 exp, 20x)", 33299, 32177, 13, mon = "Slick Water Elemental" },
		{ "Wailing Widow (450 exp, 46x)", 33674, 31740, 8, mon = "Wailing Widow" },
		{ "Clomp (475 exp, 34x)", 33594, 31672, 7, mon = "Clomp" },
		{ "Grave Guard (485 exp, 13x)", 32960, 32754, 11, mon = "Grave Guard" },
		{ "Corym Vanguard (490 exp, 18x)", 33071, 32154, 11, mon = "Corym Vanguard" },
		{ "Crystalcrusher (500 exp, 23x)", 32187, 32612, 12, mon = "Crystalcrusher" },
		{ "Enlightened of the Cult (500 exp, 27x)", 32150, 31231, 11, mon = "Enlightened of the Cult" },
		{ "Nightstalker (500 exp, 22x)", 32849, 32448, 12, mon = "Nightstalker" },
		{ "Pooka (500 exp, 10x)", 33421, 32233, 7, mon = "Pooka" },
		{ "Stonerefiner (500 exp, 39x)", 33059, 32005, 13, mon = "Stonerefiner" },
		{ "Wyvern (515 exp, 18x)", 32849, 31803, 14, mon = "Wyvern" },
		{ "Earth Elemental (550 exp, 52x)", 32337, 32588, 12, mon = "Earth Elemental" },
		{ "Energy Elemental (550 exp, 38x)", 33600, 32380, 10, mon = "Energy Elemental" },
		{ "Enraged Crystal Golem (550 exp, 23x)", 32948, 31951, 10, mon = "Enraged Crystal Golem" },
		{ "Elder Mummy (560 exp, 14x)", 32938, 32773, 12, mon = "Elder Mummy" },
		{ "Bonebeast (580 exp, 29x)", 33423, 32263, 11, mon = "Bonebeast" },
		{ "Ice Witch (580 exp, 18x)", 32278, 31033, 11, mon = "Ice Witch" },
		{ "Necromancer (580 exp, 43x)", 32996, 32391, 10, mon = "Necromancer" },
		{ "Schiach (580 exp, 30x)", 33862, 31077, 7, mon = "Schiach" },
		{ "Percht (600 exp, 20x)", 33809, 31105, 7, mon = "Percht" },
		{ "Quara Mantassin (600 exp, 39x)", 32080, 32772, 12, mon = "Quara Mantassin" },
		{ "Quara Pincher Scout (600 exp, 25x)", 31928, 32692, 10, mon = "Quara Pincher Scout" },
		{ "Twisted Pooka (600 exp, 32x)", 33551, 32210, 8, mon = "Twisted Pooka" },
		{ "Ogre Shaman (625 exp, 22x)", 33592, 31674, 7, mon = "Ogre Shaman" },
		{ "Dragon Lord Hatchling (645 exp, 14x)", 32561, 31373, 15, mon = "Dragon Lord Hatchling" },
		{ "Insectoid Worker (650 exp, 59x)", 33551, 31232, 7, mon = "Insectoid Worker" },
		{ "Water Elemental (650 exp, 44x)", 32542, 32829, 9, mon = "Water Elemental" },
		{ "Sandstone Scorpion (680 exp, 20x)", 32944, 32773, 12, mon = "Sandstone Scorpion" },
		{ "Dragon (700 exp, 55x)", 33214, 31252, 7, mon = "Dragon" },
		{ "Glooth Blob (700 exp, 61x)", 33559, 31902, 7, mon = "Glooth Blob" },
		{ "Pixie (700 exp, 39x)", 33434, 32246, 7, mon = "Pixie" },
		{ "Shark (700 exp, 22x)", 33446, 31796, 15, mon = "Shark" },
		{ "Swan Maiden (700 exp, 11x)", 33542, 32248, 7, mon = "Swan Maiden" },
		{ "Ancient Scarab (720 exp, 31x)", 33335, 32640, 12, mon = "Ancient Scarab" },
		{ "Frost Dragon Hatchling (745 exp, 22x)", 32197, 31450, 7, mon = "Frost Dragon Hatchling" },
		{ "Blood Hand (750 exp, 11x)", 32976, 32422, 11, mon = "Blood Hand" },
		{ "Death Priest (750 exp, 14x)", 32942, 32773, 12, mon = "Death Priest" },
		{ "Mutated Bat (750 exp, 30x)", 32323, 32612, 12, mon = "Mutated Bat" },
		{ "Mutated Tiger (750 exp, 18x)", 33535, 31129, 8, mon = "Mutated Tiger" },
		{ "Rot Elemental (750 exp, 36x)", 33561, 31905, 7, mon = "Rot Elemental" },
		{ "Stampor (780 exp, 18x)", 32203, 30994, 12, mon = "Stampor" },
		{ "Bog Raider (800 exp, 26x)", 32665, 31094, 7, mon = "Bog Raider" },
		{ "Faun (800 exp, 22x)", 33565, 32236, 7, mon = "Faun" },
		{ "Ogre Brute (800 exp, 36x)", 33667, 31597, 7, mon = "Ogre Brute" },
		{ "Quara Hydromancer Scout (800 exp, 18x)", 31949, 32686, 9, mon = "Quara Hydromancer Scout" },
		{ "Roaring Lion (800 exp, 19x)", 33145, 32335, 9, mon = "Roaring Lion" },
		{ "Undead Gladiator (800 exp, 22x)", 33599, 31603, 8, mon = "Undead Gladiator" },
		{ "Vampire Viscount (800 exp, 23x)", 32977, 31612, 11, mon = "Vampire Viscount" },
		{ "Waspoid (830 exp, 54x)", 33543, 31240, 7, mon = "Waspoid" },
		{ "Cult Believer (850 exp, 25x)", 32351, 31680, 8, mon = "Cult Believer" },
		{ "Nymph (850 exp, 10x)", 33421, 32227, 7, mon = "Nymph" },
		{ "Orc Cult Minion (850 exp, 13x)", 33152, 31876, 10, mon = "Orc Cult Minion" },
		{ "Askarak Demon (900 exp, 17x)", 33292, 31934, 12, mon = "Askarak Demon" },
		{ "Banshee (900 exp, 17x)", 32999, 32427, 14, mon = "Banshee" },
		{ "Blood Priest (900 exp, 15x)", 33297, 31581, 9, mon = "Blood Priest" },
		{ "Brimstone Bug (900 exp, 32x)", 33146, 31098, 7, mon = "Brimstone Bug" },
		{ "Crystal Spider (900 exp, 28x)", 32374, 31051, 9, mon = "Crystal Spider" },
		{ "Dark Faun (900 exp, 35x)", 33571, 32185, 9, mon = "Dark Faun" },
		{ "Giant Spider (900 exp, 41x)", 32938, 32878, 10, mon = "Giant Spider" },
		{ "Killer Caiman (900 exp, 29x)", 33277, 31161, 7, mon = "Killer Caiman" },
		{ "Lich (900 exp, 17x)", 33097, 31782, 15, mon = "Lich" },
		{ "Mooh'Tah Warrior (900 exp, 37x)", 33711, 31927, 7, mon = "Mooh'Tah Warrior" },
		{ "Putrid Mummy (900 exp, 23x)", 33422, 32310, 12, mon = "Putrid Mummy" },
		{ "Shaburak Demon (900 exp, 25x)", 33244, 31938, 12, mon = "Shaburak Demon" },
		{ "Vicious Squire (900 exp, 32x)", 33297, 31581, 9, mon = "Vicious Squire" },
		{ "Wiggler (900 exp, 39x)", 32920, 31892, 11, mon = "Wiggler" },
		{ "Boogy (950 exp, 17x)", 33564, 32240, 7, mon = "Boogy" },
		{ "Gravedigger (950 exp, 13x)", 33003, 32413, 11, mon = "Gravedigger" },
		{ "Massive Energy Elemental (950 exp, 8x)", 33061, 32685, 3, mon = "Massive Energy Elemental" },
		{ "Minotaur Cult Follower (950 exp, 38x)", 31942, 32466, 8, mon = "Minotaur Cult Follower" },
		{ "Ogre Savage (950 exp, 13x)", 33620, 31711, 7, mon = "Ogre Savage" },
		{ "Orc Cultist (950 exp, 8x)", 33129, 31881, 10, mon = "Orc Cultist" },
		{ "Quara Hydromancer (950 exp, 24x)", 32272, 32920, 10, mon = "Quara Hydromancer" },
		{ "Iks Pututu (980 exp, 30x)", 34058, 31861, 9, mon = "Iks Pututu" },
		{ "Braindeath (985 exp, 15x)", 32817, 32428, 12, mon = "Braindeath" },
		{ "Blood Beast (1000 exp, 32x)", 33575, 32041, 7, mon = "Blood Beast" },
		{ "Crawler (1000 exp, 41x)", 33546, 31235, 7, mon = "Crawler" },
		{ "Cult Enforcer (1000 exp, 25x)", 32369, 31680, 9, mon = "Cult Enforcer" },
		{ "Deepling Spellsinger (1000 exp, 33x)", 33443, 31245, 11, mon = "Deepling Spellsinger" },
		{ "Orc Cult Priest (1000 exp, 13x)", 33178, 31897, 12, mon = "Orc Cult Priest" },
		{ "Weakened Frazzlemaw (1000 exp, 38x)", 33571, 32270, 9, mon = "Weakened Frazzlemaw" },
		{ "Young Sea Serpent (1000 exp, 16x)", 31907, 31254, 9, mon = "Young Sea Serpent" },
		{ "Iks Chuka (1050 exp, 44x)", 34030, 31855, 8, mon = "Iks Chuka" },
		{ "Vampire Bride (1050 exp, 17x)", 32939, 32420, 14, mon = "Vampire Bride" },
		{ "Cult Scholar (1100 exp, 12x)", 32346, 31673, 10, mon = "Cult Scholar" },
		{ "Enfeebled Silencer (1100 exp, 29x)", 33572, 32271, 9, mon = "Enfeebled Silencer" },
		{ "Instable Breach Brood (1100 exp, 33x)", 32436, 32402, 10, mon = "Instable Breach Brood" },
		{ "Lizard Legionnaire (1100 exp, 56x)", 33250, 31242, 7, mon = "Lizard Legionnaire" },
		{ "Lost Husher (1100 exp, 27x)", 32201, 32662, 15, mon = "Lost Husher" },
		{ "Massive Earth Elemental (1100 exp, 24x)", 32241, 32522, 13, mon = "Massive Earth Elemental" },
		{ "Massive Water Elemental (1100 exp, 19x)", 32069, 32773, 12, mon = "Massive Water Elemental" },
		{ "Minotaur Cult Prophet (1100 exp, 27x)", 31951, 32484, 8, mon = "Minotaur Cult Prophet" },
		{ "Orc Cult Fanatic (1100 exp, 11x)", 33177, 31896, 12, mon = "Orc Cult Fanatic" },
		{ "Orclops Ravager (1100 exp, 21x)", 32738, 32124, 10, mon = "Orclops Ravager" },
		{ "Parder (1100 exp, 25x)", 33687, 32742, 7, mon = "Parder" },
		{ "Spitter (1100 exp, 41x)", 33581, 31229, 5, mon = "Spitter" },
		{ "Vulcongra (1100 exp, 31x)", 32214, 32529, 15, mon = "Vulcongra" },
		{ "Iks Aucar (1150 exp, 31x)", 34061, 31855, 9, mon = "Iks Aucar" },
		{ "Orc Cult Inquisitor (1150 exp, 16x)", 33146, 31863, 10, mon = "Orc Cult Inquisitor" },
		{ "Rift Worm (1195 exp, 22x)", 32781, 31161, 15, mon = "Rift Worm" },
		{ "Drillworm (1200 exp, 29x)", 32257, 32574, 13, mon = "Drillworm" },
		{ "Exotic Bat (1200 exp, 60x)", 33868, 31392, 8, mon = "Exotic Bat" },
		{ "Hero (1200 exp, 21x)", 33297, 31581, 9, mon = "Hero" },
		{ "Infected Weeper (1200 exp, 9x)", 33022, 31971, 11, mon = "Infected Weeper" },
		{ "Jungle Moa (1200 exp, 19x)", 33807, 32712, 7, mon = "Jungle Moa" },
		{ "Misguided Bully (1200 exp, 38x)", 32526, 32400, 9, mon = "Misguided Bully" },
		{ "Misguided Thief (1200 exp, 25x)", 32502, 32420, 9, mon = "Misguided Thief" },
		{ "Renegade Knight (1200 exp, 39x)", 33298, 31582, 9, mon = "Renegade Knight" },
		{ "Vicious Manbat (1200 exp, 13x)", 32943, 32424, 14, mon = "Vicious Manbat" },
		{ "Golden Servant Replica (1250 exp, 17x)", 32769, 32870, 13, mon = "Golden Servant Replica" },
		{ "Worker Golem (1250 exp, 66x)", 31134, 32655, 8, mon = "Worker Golem" },
		{ "Yielothax (1250 exp, 33x)", 32944, 31586, 9, mon = "Yielothax" },
		{ "Metal Gargoyle (1278 exp, 48x)", 33419, 32088, 10, mon = "Metal Gargoyle" },
		{ "Blistering Fire Elemental (1300 exp, 31x)", 33201, 32130, 13, mon = "Blistering Fire Elemental" },
		{ "Jagged Earth Elemental (1300 exp, 15x)", 33337, 32160, 13, mon = "Jagged Earth Elemental" },
		{ "Overcharged Energy Elemental (1300 exp, 12x)", 33104, 32123, 13, mon = "Overcharged Energy Elemental" },
		{ "Roaring Water Elemental (1300 exp, 16x)", 33277, 32137, 13, mon = "Roaring Water Elemental" },
		{ "Souleater (1300 exp, 129x)", 32864, 32446, 12, mon = "Souleater" },
		{ "Lizard Dragon Priest (1320 exp, 18x)", 33096, 31163, 6, mon = "Lizard Dragon Priest" },
		{ "Instable Sparkion (1350 exp, 24x)", 32470, 32407, 10, mon = "Instable Sparkion" },
		{ "Minotaur Cult Zealot (1350 exp, 26x)", 31959, 32430, 9, mon = "Minotaur Cult Zealot" },
		{ "Nightmare Scion (1350 exp, 25x)", 33561, 31586, 9, mon = "Nightmare Scion" },
		{ "Diamond Servant Replica (1400 exp, 16x)", 32857, 32837, 13, mon = "Diamond Servant Replica" },
		{ "Exotic Cave Spider (1400 exp, 24x)", 33829, 31381, 8, mon = "Exotic Cave Spider" },
		{ "Massive Fire Elemental (1400 exp, 18x)", 33293, 31846, 14, mon = "Massive Fire Elemental" },
		{ "Lizard High Guard (1450 exp, 157x)", 33048, 31171, 7, mon = "Lizard High Guard" },
		{ "Orclops Doomhauler (1450 exp, 10x)", 32732, 32122, 10, mon = "Orclops Doomhauler" },
		{ "Lumbering Carnivor (1452 exp, 17x)", 32747, 32629, 8, mon = "Lumbering Carnivor" },
		{ "Deepling Warrior (1500 exp, 22x)", 33504, 31249, 11, mon = "Deepling Warrior" },
		{ "Lost Thrower (1500 exp, 45x)", 32212, 32535, 15, mon = "Lost Thrower" },
		{ "Quara Pincher (1500 exp, 32x)", 31940, 32754, 12, mon = "Quara Pincher" },
		{ "Vile Grandmaster (1500 exp, 39x)", 32369, 31678, 9, mon = "Vile Grandmaster" },
		{ "Worm Priestess (1500 exp, 26x)", 33557, 32005, 7, mon = "Worm Priestess" },
	} },
	{ label = "Hard (exp 1500-6000)", list = {
		{ "Sparkion (1520 exp, 63x)", 32178, 31360, 12, mon = "Sparkion" },
		{ "Wyrm (1550 exp, 42x)", 33080, 32392, 14, mon = "Wyrm" },
		{ "Minotaur Invader (1600 exp, 12x)", 33583, 31948, 13, mon = "Minotaur Invader" },
		{ "Pirat Scoundrel (1600 exp, 26x)", 33906, 31187, 7, mon = "Pirat Scoundrel" },
		{ "Rift Brood (1600 exp, 27x)", 32724, 31162, 15, mon = "Rift Brood" },
		{ "Werebadger (1600 exp, 27x)", 33389, 31641, 9, mon = "Werebadger" },
		{ "Werefox (1600 exp, 11x)", 33130, 31983, 8, mon = "Werefox" },
		{ "Glooth Golem (1606 exp, 26x)", 33652, 31953, 9, mon = "Glooth Golem" },
		{ "Shaper Matriarch (1650 exp, 32x)", 32839, 32868, 14, mon = "Shaper Matriarch" },
		{ "Spiky Carnivor (1650 exp, 21x)", 32753, 32627, 10, mon = "Spiky Carnivor" },
		{ "Lizard Zaogun (1700 exp, 36x)", 33116, 31153, 6, mon = "Lizard Zaogun" },
		{ "Minotaur Hunter (1700 exp, 37x)", 33604, 32016, 7, mon = "Minotaur Hunter" },
		{ "Pirat Bombardier (1700 exp, 32x)", 33902, 31251, 6, mon = "Pirat Bombardier" },
		{ "Devourer (1755 exp, 28x)", 33633, 31929, 9, mon = "Devourer" },
		{ "Glooth Anemone (1755 exp, 38x)", 33646, 31954, 10, mon = "Glooth Anemone" },
		{ "Breach Brood (1760 exp, 54x)", 32142, 31373, 11, mon = "Breach Brood" },
		{ "Broken Shaper (1800 exp, 108x)", 32856, 32748, 14, mon = "Broken Shaper" },
		{ "Eternal Guardian (1800 exp, 25x)", 32726, 32575, 12, mon = "Eternal Guardian" },
		{ "Lost Exile (1800 exp, 25x)", 33779, 32268, 14, mon = "Lost Exile" },
		{ "Nightmare (1800 exp, 24x)", 33657, 32673, 11, mon = "Nightmare" },
		{ "Pirat Cutthroat (1800 exp, 23x)", 33869, 31351, 8, mon = "Pirat Cutthroat" },
		{ "Stone Rhino (1800 exp, 9x)", 32896, 32858, 15, mon = "Stone Rhino" },
		{ "Quara Predator (1850 exp, 23x)", 32273, 32920, 10, mon = "Quara Predator" },
		{ "Cursed Ape (1860 exp, 9x)", 34019, 31768, 10, mon = "Cursed Ape" },
		{ "Glooth Brigand (1900 exp, 40x)", 33694, 32002, 12, mon = "Glooth Brigand" },
		{ "Stabilizing Dread Intruder (1900 exp, 20x)", 32028, 31351, 11, mon = "Stabilizing Dread Intruder" },
		{ "Werewolf (1900 exp, 33x)", 33424, 31564, 11, mon = "Werewolf" },
		{ "Stabilizing Reality Reaver (1950 exp, 20x)", 32034, 31347, 11, mon = "Stabilizing Reality Reaver" },
		{ "Earworm (2000 exp, 44x)", 33928, 31634, 9, mon = "Earworm" },
		{ "Glooth Bandit (2000 exp, 54x)", 33694, 32002, 12, mon = "Glooth Bandit" },
		{ "Goldhanded Cultist (2000 exp, 25x)", 33228, 32141, 10, mon = "Goldhanded Cultist" },
		{ "Lizard Noble (2000 exp, 12x)", 33080, 31212, 4, mon = "Lizard Noble" },
		{ "Rift Scythe (2000 exp, 31x)", 32724, 31162, 15, mon = "Rift Scythe" },
		{ "Wereboar (2000 exp, 25x)", 33390, 31641, 9, mon = "Wereboar" },
		{ "Twisted Shaper (2050 exp, 39x)", 32856, 32750, 14, mon = "Twisted Shaper" },
		{ "Deepling Guard (2100 exp, 30x)", 33504, 31249, 11, mon = "Deepling Guard" },
		{ "Dragon Lord (2100 exp, 55x)", 33223, 31277, 5, mon = "Dragon Lord" },
		{ "Frost Dragon (2100 exp, 22x)", 32229, 31411, 8, mon = "Frost Dragon" },
		{ "Hydra (2100 exp, 33x)", 33500, 31936, 10, mon = "Hydra" },
		{ "Rustheap Golem (2100 exp, 14x)", 33629, 32056, 15, mon = "Rustheap Golem" },
		{ "Spectre (2100 exp, 29x)", 33085, 31770, 13, mon = "Spectre" },
		{ "Werebear (2100 exp, 32x)", 33427, 31564, 11, mon = "Werebear" },
		{ "Menacing Carnivor (2112 exp, 26x)", 32752, 32628, 10, mon = "Menacing Carnivor" },
		{ "Barkless Devotee (2200 exp, 25x)", 32712, 31433, 8, mon = "Barkless Devotee" },
		{ "Lizard Chosen (2200 exp, 51x)", 33275, 31177, 9, mon = "Lizard Chosen" },
		{ "Minotaur Amazon (2200 exp, 101x)", 31337, 32616, 8, mon = "Minotaur Amazon" },
		{ "Walker (2200 exp, 13x)", 33654, 31975, 14, mon = "Walker" },
		{ "Werehyaena (2200 exp, 131x)", 33197, 32396, 10, mon = "Werehyaena" },
		{ "Werehyaena Shaman (2200 exp, 52x)", 33174, 32456, 10, mon = "Werehyaena Shaman" },
		{ "Werelion (2200 exp, 46x)", 33130, 32321, 11, mon = "Werelion" },
		{ "Ice Dragon (2300 exp, 12x)", 32055, 32483, 11, mon = "Ice Dragon" },
		{ "Lost Basher (2300 exp, 39x)", 32304, 32584, 15, mon = "Lost Basher" },
		{ "Sea Serpent (2300 exp, 30x)", 31898, 31021, 10, mon = "Sea Serpent" },
		{ "Shock Head (2300 exp, 17x)", 33595, 32518, 7, mon = "Shock Head" },
		{ "Werelioness (2300 exp, 41x)", 33130, 32320, 11, mon = "Werelioness" },
		{ "White Lion (2300 exp, 15x)", 33130, 32321, 11, mon = "White Lion" },
		{ "War Golem (2310 exp, 72x)", 31006, 32682, 8, mon = "War Golem" },
		{ "Draken Warmaster (2400 exp, 50x)", 33082, 31108, 3, mon = "Draken Warmaster" },
		{ "Dread Intruder (2400 exp, 52x)", 32147, 31361, 12, mon = "Dread Intruder" },
		{ "Execowtioner (2400 exp, 67x)", 31301, 32678, 8, mon = "Execowtioner" },
		{ "Kollos (2400 exp, 20x)", 33592, 31224, 2, mon = "Kollos" },
		{ "Pirat Mate (2400 exp, 35x)", 33879, 31228, 6, mon = "Pirat Mate" },
		{ "Reality Reaver (2480 exp, 68x)", 32181, 31365, 12, mon = "Reality Reaver" },
		{ "Barkless Fanatic (2500 exp, 39x)", 32712, 31434, 8, mon = "Barkless Fanatic" },
		{ "Behemoth (2500 exp, 28x)", 33011, 32508, 9, mon = "Behemoth" },
		{ "Destroyer (2500 exp, 45x)", 33508, 31791, 8, mon = "Destroyer" },
		{ "Elder Wyrm (2500 exp, 49x)", 33083, 32391, 14, mon = "Elder Wyrm" },
		{ "Deepworm (2520 exp, 56x)", 33278, 32315, 15, mon = "Deepworm" },
		{ "Hellspawn (2550 exp, 55x)", 33394, 31726, 8, mon = "Hellspawn" },
		{ "Moohtant (2600 exp, 45x)", 31302, 32680, 8, mon = "Moohtant" },
		{ "Spidris (2600 exp, 26x)", 33521, 31203, 1, mon = "Spidris" },
		{ "Enslaved Dwarf (2700 exp, 12x)", 33400, 31953, 15, mon = "Enslaved Dwarf" },
		{ "Goggle Cake (2700 exp, 16x)", 33438, 32188, 8, mon = "Goggle Cake" },
		{ "Nibblemaw (2700 exp, 13x)", 33370, 32168, 8, mon = "Nibblemaw" },
		{ "Diremaw (2770 exp, 92x)", 33278, 32316, 15, mon = "Diremaw" },
		{ "Diabolic Imp (2900 exp, 20x)", 33097, 31782, 15, mon = "Diabolic Imp" },
		{ "Humongous Fungus (2900 exp, 51x)", 33044, 31958, 10, mon = "Humongous Fungus" },
		{ "Stone Devourer (2900 exp, 17x)", 33060, 31972, 10, mon = "Stone Devourer" },
		{ "Two-Headed Turtle (2930 exp, 66x)", 33766, 32776, 8, mon = "Two-Headed Turtle" },
		{ "Candy Horror (3000 exp, 16x)", 33411, 32156, 9, mon = "Candy Horror" },
		{ "Serpent Spawn (3050 exp, 30x)", 32742, 32591, 12, mon = "Serpent Spawn" },
		{ "Draken Spellweaver (3100 exp, 38x)", 33086, 31116, 4, mon = "Draken Spellweaver" },
		{ "Foam Stalker (3120 exp, 22x)", 33718, 32741, 9, mon = "Foam Stalker" },
		{ "Armadile (3200 exp, 24x)", 33044, 31959, 10, mon = "Armadile" },
		{ "Cave Devourer (3380 exp, 33x)", 33289, 32174, 15, mon = "Cave Devourer" },
		{ "Betrayed Wraith (3500 exp, 26x)", 33109, 31590, 11, mon = "Betrayed Wraith" },
		{ "Ripper Spectre (3500 exp, 27x)", 32706, 32247, 10, mon = "Ripper Spectre" },
		{ "Chasm Spawn (3600 exp, 59x)", 33461, 32252, 15, mon = "Chasm Spawn" },
		{ "Fury (3600 exp, 24x)", 33311, 31835, 15, mon = "Fury" },
		{ "Defiler (3700 exp, 28x)", 33168, 31768, 12, mon = "Defiler" },
		{ "Hideous Fungus (3700 exp, 50x)", 33044, 31958, 10, mon = "Hideous Fungus" },
		{ "Frazzlemaw (3740 exp, 45x)", 33640, 32440, 7, mon = "Frazzlemaw" },
		{ "Hellfire Fighter (3800 exp, 36x)", 33673, 32684, 13, mon = "Hellfire Fighter" },
		{ "Plaguesmith (3800 exp, 37x)", 33232, 31436, 13, mon = "Plaguesmith" },
		{ "Candy Floss Elemental (3850 exp, 18x)", 33429, 32168, 8, mon = "Candy Floss Elemental" },
		{ "Magma Crawler (3900 exp, 37x)", 33079, 31958, 11, mon = "Magma Crawler" },
		{ "Infernalist (4000 exp, 9x)", 33303, 31827, 15, mon = "Infernalist" },
		{ "Lava Lurker (4000 exp, 29x)", 33988, 32265, 14, mon = "Lava Lurker" },
		{ "Lost Soul (4000 exp, 27x)", 33109, 31590, 11, mon = "Lost Soul" },
		{ "Ravenous Lava Lurker (4000 exp, 47x)", 33933, 32203, 14, mon = "Ravenous Lava Lurker" },
		{ "Spidris Elite (4000 exp, 20x)", 33437, 31273, 8, mon = "Spidris Elite" },
		{ "Warlock (4000 exp, 19x)", 32481, 31618, 15, mon = "Warlock" },
		{ "Medusa (4050 exp, 41x)", 32800, 32630, 15, mon = "Medusa" },
		{ "Dawnfire Asura (4100 exp, 31x)", 32814, 32754, 9, mon = "Dawnfire Asura" },
		{ "Midnight Asura (4100 exp, 57x)", 32814, 32755, 9, mon = "Midnight Asura" },
		{ "Retching Horror (4100 exp, 53x)", 33643, 32440, 7, mon = "Retching Horror" },
		{ "Frost Flower Asura (4200 exp, 16x)", 32825, 32798, 9, mon = "Frost Flower Asura" },
		{ "Gazer Spectre (4200 exp, 27x)", 32678, 32655, 8, mon = "Gazer Spectre" },
		{ "Ogre Rowdy (4200 exp, 28x)", 33824, 31647, 8, mon = "Ogre Rowdy" },
		{ "Dark Carnisylvan (4400 exp, 22x)", 32581, 32465, 13, mon = "Dark Carnisylvan" },
		{ "Phantasm (4400 exp, 30x)", 33062, 31754, 11, mon = "Phantasm" },
		{ "Poisonous Carnisylvan (4400 exp, 21x)", 32584, 32463, 13, mon = "Poisonous Carnisylvan" },
		{ "Tunnel Tyrant (4420 exp, 34x)", 33288, 32176, 15, mon = "Tunnel Tyrant" },
		{ "Draken Abomination (4500 exp, 23x)", 33068, 31086, 12, mon = "Draken Abomination" },
		{ "Flimsy Lost Soul (4500 exp, 65x)", 33599, 31496, 10, mon = "Flimsy Lost Soul" },
		{ "Juvenile Bashmu (4500 exp, 24x)", 34043, 31685, 8, mon = "Juvenile Bashmu" },
		{ "Ghastly Dragon (4600 exp, 9x)", 33049, 31108, 14, mon = "Ghastly Dragon" },
		{ "Dark Torturer (4650 exp, 60x)", 33600, 32381, 10, mon = "Dark Torturer" },
		{ "Arachnophobica (4700 exp, 52x)", 32068, 31950, 13, mon = "Arachnophobica" },
		{ "Choking Fear (4700 exp, 51x)", 33632, 32412, 7, mon = "Choking Fear" },
		{ "Crazed Summer Rearguard (4700 exp, 27x)", 32085, 32004, 13, mon = "Crazed Summer Rearguard" },
		{ "Crazed Winter Rearguard (4700 exp, 36x)", 32065, 31949, 13, mon = "Crazed Winter Rearguard" },
		{ "Hulking Carnisylvan (4700 exp, 11x)", 32560, 32448, 12, mon = "Hulking Carnisylvan" },
		{ "Draken Elite (4750 exp, 10x)", 33103, 31116, 9, mon = "Draken Elite" },
		{ "Lost Berserker (4800 exp, 28x)", 33008, 31924, 12, mon = "Lost Berserker" },
		{ "Skeleton Elite Warrior (4800 exp, 37x)", 32936, 32269, 10, mon = "Skeleton Elite Warrior" },
		{ "Bashmu (5000 exp, 33x)", 33976, 31689, 8, mon = "Bashmu" },
		{ "Crazed Summer Vanguard (5000 exp, 26x)", 32014, 31949, 13, mon = "Crazed Summer Vanguard" },
		{ "Hand of Cursed Fate (5000 exp, 12x)", 33477, 32808, 9, mon = "Hand of Cursed Fate" },
		{ "Ogre Ruffian (5000 exp, 22x)", 33793, 31603, 7, mon = "Ogre Ruffian" },
		{ "Crape Man (5040 exp, 50x)", 33762, 32545, 7, mon = "Crape Man" },
		{ "Dragolisk (5050 exp, 69x)", 33281, 31147, 13, mon = "Dragolisk" },
		{ "Feversleep (5060 exp, 27x)", 33691, 32291, 9, mon = "Feversleep" },
		{ "Undead Elite Gladiator (5090 exp, 23x)", 32938, 32269, 10, mon = "Undead Elite Gladiator" },
		{ "Manticore (5100 exp, 28x)", 33920, 31625, 7, mon = "Manticore" },
		{ "Silencer (5100 exp, 43x)", 33640, 32440, 7, mon = "Silencer" },
		{ "Naga Archer (5150 exp, 31x)", 33656, 32753, 8, mon = "Naga Archer" },
		{ "Cursed Prospector (5250 exp, 104x)", 33836, 31830, 9, mon = "Cursed Prospector" },
		{ "Blemished Spawn (5300 exp, 33x)", 32626, 31796, 10, mon = "Blemished Spawn" },
		{ "Venerable Girtablilu (5300 exp, 29x)", 33781, 31754, 10, mon = "Venerable Girtablilu" },
		{ "Crazed Winter Vanguard (5400 exp, 34x)", 32066, 31953, 13, mon = "Crazed Winter Vanguard" },
		{ "Ironblight (5400 exp, 28x)", 33010, 31923, 12, mon = "Ironblight" },
		{ "Hellhound (5440 exp, 39x)", 33507, 31790, 8, mon = "Hellhound" },
		{ "Grim Reaper (5500 exp, 49x)", 33543, 31725, 8, mon = "Grim Reaper" },
		{ "Ogre Sage (5500 exp, 17x)", 33796, 31603, 7, mon = "Ogre Sage" },
		{ "Mean Lost Soul (5580 exp, 41x)", 33593, 31450, 10, mon = "Mean Lost Soul" },
		{ "Rhindeer (5600 exp, 51x)", 33732, 32496, 9, mon = "Rhindeer" },
		{ "Afflicted Strider (5700 exp, 11x)", 32632, 31791, 10, mon = "Afflicted Strider" },
		{ "Harpy (5720 exp, 39x)", 33762, 32543, 7, mon = "Harpy" },
		{ "Makara (5720 exp, 44x)", 33657, 32753, 8, mon = "Makara" },
		{ "Girtablilu Warrior (5800 exp, 51x)", 33781, 31754, 10, mon = "Girtablilu Warrior" },
		{ "Soul-Broken Harbinger (5800 exp, 35x)", 32065, 31949, 13, mon = "Soul-Broken Harbinger" },
		{ "Weeper (5800 exp, 26x)", 33073, 31960, 11, mon = "Weeper" },
		{ "Wardragon (5810 exp, 56x)", 33237, 31187, 13, mon = "Wardragon" },
		{ "Naga Warrior (5890 exp, 55x)", 33657, 32753, 8, mon = "Naga Warrior" },
		{ "Orewalker (5900 exp, 18x)", 33005, 31953, 12, mon = "Orewalker" },
		{ "Son of Verminor (5900 exp, 11x)", 33196, 31670, 12, mon = "Son of Verminor" },
		{ "Varnished Diremaw (5900 exp, 14x)", 32048, 31456, 14, mon = "Varnished Diremaw" },
		{ "Burster Spectre (6000 exp, 53x)", 33085, 32310, 8, mon = "Burster Spectre" },
		{ "Demon (6000 exp, 49x)", 33510, 31790, 8, mon = "Demon" },
		{ "Eyeless Devourer (6000 exp, 32x)", 32642, 31780, 10, mon = "Eyeless Devourer" },
		{ "Insane Siren (6000 exp, 26x)", 32015, 31948, 13, mon = "Insane Siren" },
	} },
	{ label = "Very Hard (exp 6000+)", list = {
		{ "Crypt Warrior (6050 exp, 23x)", 32438, 32521, 9, mon = "Crypt Warrior" },
		{ "Guzzlemaw (6050 exp, 53x)", 33628, 32458, 7, mon = "Guzzlemaw" },
		{ "Tremendous Tyrant (6100 exp, 11x)", 32064, 31464, 11, mon = "Tremendous Tyrant" },
		{ "Young Goanna (6100 exp, 31x)", 33903, 31600, 7, mon = "Young Goanna" },
		{ "Demon Outcast (6200 exp, 121x)", 33600, 32406, 10, mon = "Demon Outcast" },
		{ "Lavafungus (6200 exp, 16x)", 32126, 31448, 15, mon = "Lavafungus" },
		{ "Vexclaw (6248 exp, 44x)", 33476, 32703, 14, mon = "Vexclaw" },
		{ "Deathling Scout (6300 exp, 30x)", 33584, 31424, 14, mon = "Deathling Scout" },
		{ "Falcon Knight (6300 exp, 25x)", 33310, 31287, 8, mon = "Falcon Knight" },
		{ "Streaked Devourer (6300 exp, 13x)", 32128, 31445, 15, mon = "Streaked Devourer" },
		{ "Thanatursus (6300 exp, 53x)", 32064, 31949, 13, mon = "Thanatursus" },
		{ "Blightwalker (6400 exp, 29x)", 33404, 32374, 13, mon = "Blightwalker" },
		{ "Deathling Spellsinger (6400 exp, 31x)", 33577, 31423, 14, mon = "Deathling Spellsinger" },
		{ "Priestess of the Wild Sun (6400 exp, 34x)", 33868, 31524, 8, mon = "Priestess of the Wild Sun" },
		{ "Haunted Dragon (6500 exp, 15x)", 32122, 32512, 12, mon = "Haunted Dragon" },
		{ "Lavaworm (6500 exp, 17x)", 32126, 31447, 15, mon = "Lavaworm" },
		{ "Adult Goanna (6650 exp, 37x)", 33900, 31580, 7, mon = "Adult Goanna" },
		{ "Sineater Inferniarch (6750 exp, 49x)", 33834, 32335, 7, mon = "Sineater Inferniarch" },
		{ "Cave Chimera (6800 exp, 14x)", 32059, 31443, 13, mon = "Cave Chimera" },
		{ "Liodile (6860 exp, 41x)", 33738, 32578, 10, mon = "Liodile" },
		{ "Falcon Paladin (6900 exp, 22x)", 33296, 31318, 9, mon = "Falcon Paladin" },
		{ "Terrorsleep (6900 exp, 26x)", 33684, 32357, 8, mon = "Terrorsleep" },
		{ "Usurper Knight (6900 exp, 20x)", 32460, 32499, 7, mon = "Usurper Knight" },
		{ "Cobra Assassin (6980 exp, 37x)", 33377, 32789, 8, mon = "Cobra Assassin" },
		{ "Usurper Warlock (7000 exp, 9x)", 32386, 32464, 6, mon = "Usurper Warlock" },
		{ "Freakish Lost Soul (7020 exp, 29x)", 31950, 32300, 10, mon = "Freakish Lost Soul" },
		{ "True Frost Flower Asura (7069 exp, 30x)", 32843, 32805, 10, mon = "True Frost Flower Asura" },
		{ "Cliff Strider (7100 exp, 18x)", 33013, 31925, 12, mon = "Cliff Strider" },
		{ "Gorger Inferniarch (7180 exp, 40x)", 33837, 32355, 7, mon = "Gorger Inferniarch" },
		{ "Black Sphinx Acolyte (7200 exp, 35x)", 33868, 31524, 8, mon = "Black Sphinx Acolyte" },
		{ "Grimeleech (7216 exp, 43x)", 33657, 32636, 10, mon = "Grimeleech" },
		{ "Carnivostrich (7290 exp, 35x)", 33723, 32527, 10, mon = "Carnivostrich" },
		{ "Cobra Scout (7310 exp, 17x)", 33376, 32789, 8, mon = "Cobra Scout" },
		{ "True Midnight Asura (7313 exp, 38x)", 32843, 32804, 10, mon = "True Midnight Asura" },
		{ "Burning Gladiator (7350 exp, 40x)", 33865, 31524, 8, mon = "Burning Gladiator" },
		{ "Broodrider Inferniarch (7400 exp, 40x)", 33836, 32355, 7, mon = "Broodrider Inferniarch" },
		{ "True Dawnfire Asura (7475 exp, 35x)", 32841, 32805, 10, mon = "True Dawnfire Asura" },
		{ "Sphinx (7500 exp, 48x)", 33872, 31441, 9, mon = "Sphinx" },
		{ "Undead Dragon (7500 exp, 36x)", 33416, 32363, 13, mon = "Undead Dragon" },
		{ "Cobra Vizier (7650 exp, 19x)", 33377, 32789, 8, mon = "Cobra Vizier" },
		{ "Boar Man (7720 exp, 46x)", 33735, 32487, 10, mon = "Boar Man" },
		{ "Mega Dragon (7810 exp, 38x)", 33280, 31147, 13, mon = "Mega Dragon" },
		{ "Lava Golem (7900 exp, 24x)", 33074, 31959, 11, mon = "Lava Golem" },
		{ "Floating Savant (8000 exp, 23x)", 33280, 32092, 9, mon = "Floating Savant" },
		{ "Hellhunter Inferniarch (8100 exp, 87x)", 33844, 32361, 8, mon = "Hellhunter Inferniarch" },
		{ "Spellreaper Inferniarch (8350 exp, 108x)", 33851, 32301, 10, mon = "Spellreaper Inferniarch" },
		{ "Crypt Warden (8400 exp, 45x)", 33877, 31448, 9, mon = "Crypt Warden" },
		{ "Feral Sphinx (8800 exp, 28x)", 33900, 31580, 7, mon = "Feral Sphinx" },
		{ "Evil Prospector (9000 exp, 86x)", 33835, 31830, 9, mon = "Evil Prospector" },
		{ "Lamassu (9000 exp, 15x)", 33789, 31541, 7, mon = "Lamassu" },
		{ "Animated Feather (9860 exp, 19x)", 32494, 32592, 14, mon = "Animated Feather" },
		{ "Guardian of Tales (10600 exp, 11x)", 32675, 32710, 12, mon = "Guardian of Tales" },
		{ "Knowledge Elemental (10603 exp, 12x)", 32438, 32727, 12, mon = "Knowledge Elemental" },
		{ "Juggernaut (11200 exp, 35x)", 33507, 31790, 8, mon = "Juggernaut" },
		{ "Sulphur Spouter (11517 exp, 56x)", 33636, 32800, 14, mon = "Sulphur Spouter" },
		{ "Mantosaurus (11569 exp, 51x)", 33741, 32850, 14, mon = "Mantosaurus" },
		{ "Stalking Stalk (11569 exp, 31x)", 33669, 32841, 14, mon = "Stalking Stalk" },
		{ "Hellflayer (11720 exp, 27x)", 33389, 32429, 13, mon = "Hellflayer" },
		{ "Sabretooth (11931 exp, 27x)", 33608, 32976, 14, mon = "Sabretooth" },
		{ "Headpecker (12026 exp, 27x)", 33741, 32850, 14, mon = "Headpecker" },
		{ "Energetic Book (12034 exp, 24x)", 32443, 32775, 12, mon = "Energetic Book" },
		{ "Mercurial Menace (12095 exp, 46x)", 33741, 32850, 14, mon = "Mercurial Menace" },
		{ "Emerald Tortoise (12129 exp, 35x)", 33604, 32975, 14, mon = "Emerald Tortoise" },
		{ "Gore Horn (12595 exp, 52x)", 33605, 32975, 14, mon = "Gore Horn" },
		{ "Nighthunter (12647 exp, 29x)", 33561, 32827, 14, mon = "Nighthunter" },
		{ "Hulking Prehemoth (12690 exp, 50x)", 33591, 32904, 14, mon = "Hulking Prehemoth" },
		{ "Icecold Book (12750 exp, 22x)", 32475, 32560, 13, mon = "Icecold Book" },
		{ "Gorerilla (13172 exp, 40x)", 33591, 32903, 14, mon = "Gorerilla" },
		{ "Noxious Ripptor (13190 exp, 50x)", 33738, 32880, 14, mon = "Noxious Ripptor" },
		{ "Burning Book (13200 exp, 39x)", 32683, 32713, 12, mon = "Burning Book" },
		{ "Sulphider (13328 exp, 31x)", 33593, 32852, 14, mon = "Sulphider" },
		{ "Cursed Book (13345 exp, 12x)", 32608, 32541, 12, mon = "Cursed Book" },
		{ "Undertaker (13543 exp, 45x)", 33561, 32827, 14, mon = "Undertaker" },
		{ "Shrieking Cry-Stal (13560 exp, 27x)", 33740, 32849, 14, mon = "Shrieking Cry-Stal" },
		{ "Squid Warden (15300 exp, 17x)", 32492, 32594, 14, mon = "Squid Warden" },
		{ "Brachiodemon (15770 exp, 50x)", 34014, 31062, 9, mon = "Brachiodemon" },
		{ "Infernal Phantom (15770 exp, 31x)", 34006, 31069, 9, mon = "Infernal Phantom" },
		{ "Rage Squid (16300 exp, 47x)", 32641, 32653, 12, mon = "Rage Squid" },
		{ "Sight of Surrender (17000 exp, 9x)", 33550, 32348, 7, mon = "Sight of Surrender" },
		{ "Infernal Demon (17430 exp, 46x)", 34017, 31062, 9, mon = "Infernal Demon" },
		{ "Brain Squid (17672 exp, 11x)", 32533, 32767, 12, mon = "Brain Squid" },
		{ "Branchy Crawler (17860 exp, 31x)", 33969, 31036, 12, mon = "Branchy Crawler" },
		{ "Rotten Golem (17860 exp, 39x)", 33965, 31086, 11, mon = "Rotten Golem" },
		{ "Mould Phantom (18330 exp, 59x)", 33935, 31039, 13, mon = "Mould Phantom" },
		{ "Distorted Phantom (18870 exp, 22x)", 33937, 31189, 13, mon = "Distorted Phantom" },
		{ "Many Faces (18870 exp, 18x)", 33962, 31180, 12, mon = "Many Faces" },
		{ "Courage Leech (18900 exp, 29x)", 33842, 31835, 3, mon = "Courage Leech" },
		{ "Capricious Phantom (19360 exp, 53x)", 33941, 31021, 9, mon = "Capricious Phantom" },
		{ "Turbulent Elemental (19360 exp, 64x)", 33940, 31021, 9, mon = "Turbulent Elemental" },
		{ "Bony Sea Devil (19470 exp, 55x)", 33939, 31076, 9, mon = "Bony Sea Devil" },
		{ "Cloak of Terror (19700 exp, 26x)", 33835, 31885, 4, mon = "Cloak of Terror" },
		{ "Vibrant Phantom (19700 exp, 25x)", 33832, 31845, 3, mon = "Vibrant Phantom" },
		{ "Brinebrute Inferniarch (20300 exp, 40x)", 33822, 32305, 11, mon = "Brinebrute Inferniarch" },
		{ "Darklight Emitter (20600 exp, 46x)", 33842, 31879, 14, mon = "Darklight Emitter" },
		{ "Oozing Corpus (20600 exp, 35x)", 33820, 31743, 14, mon = "Oozing Corpus" },
		{ "Oozing Carcass (20980 exp, 45x)", 34083, 31712, 14, mon = "Oozing Carcass" },
		{ "Mycobiontic Beetle (21175 exp, 62x)", 33820, 31743, 14, mon = "Mycobiontic Beetle" },
		{ "Converter (21425 exp, 14x)", 33868, 31882, 14, mon = "Converter" },
		{ "Bloated Man-Maggot (21570 exp, 39x)", 33820, 31744, 14, mon = "Bloated Man-Maggot" },
		{ "Meandering Mushroom (21980 exp, 43x)", 34084, 31712, 14, mon = "Meandering Mushroom" },
		{ "Darklight Construct (22050 exp, 44x)", 33813, 31843, 14, mon = "Darklight Construct" },
		{ "Darklight Striker (22200 exp, 36x)", 34005, 31848, 14, mon = "Darklight Striker" },
		{ "Darklight Matter (22250 exp, 31x)", 34017, 31915, 14, mon = "Darklight Matter" },
		{ "Darklight Source (22465 exp, 17x)", 34005, 31848, 14, mon = "Darklight Source" },
		{ "Sopping Corpus (22465 exp, 12x)", 33901, 31694, 15, mon = "Sopping Corpus" },
		{ "Rotten Man-Maggot (22625 exp, 14x)", 34060, 31722, 15, mon = "Rotten Man-Maggot" },
		{ "Wandering Pillar (23200 exp, 24x)", 33868, 31881, 14, mon = "Wandering Pillar" },
		{ "Sopping Carcass (23425 exp, 57x)", 34020, 31740, 14, mon = "Sopping Carcass" },
		{ "Walking Pillar (24300 exp, 47x)", 34005, 31848, 14, mon = "Walking Pillar" },
		{ "Dreadful Harvester (25500 exp, 9x)", 33710, 31634, 14, mon = "Dreadful Harvester" },
		{ "Hazardous Phantom (66000 exp, 15x)", 33909, 31084, 8, mon = "Hazardous Phantom" },
	} },
}

-- hub i menu expowisk: Bestiariusz (wg klas bestiariusza) i wybrane Exp Low / Medium / High
local hubHunts = {
	{ label = "Bestiariusz", list = {
		{ "Azure Frog (20 exp, 14x)", 32372, 32910, 7, mon = "Azure Frog", cls = "Amphibic" },
		{ "Coral Frog (20 exp, 9x)", 32375, 32968, 7, mon = "Coral Frog", cls = "Amphibic" },
		{ "Crimson Frog (20 exp, 15x)", 32400, 32971, 7, mon = "Crimson Frog", cls = "Amphibic" },
		{ "Orchid Frog (20 exp, 8x)", 32507, 32914, 7, mon = "Orchid Frog", cls = "Amphibic" },
		{ "Salamander (25 exp, 35x)", 32868, 32169, 10, mon = "Salamander", cls = "Amphibic" },
		{ "Toad (60 exp, 36x)", 32368, 32963, 7, mon = "Toad", cls = "Amphibic" },
		{ "Makara (5720 exp, 44x)", 33657, 32753, 8, mon = "Makara", cls = "Amphibic" },
		{ "Crab (30 exp, 17x)", 32180, 32938, 8, mon = "Crab", cls = "Aquatic" },
		{ "Quara Mantassin Scout (100 exp, 20x)", 31950, 32690, 9, mon = "Quara Mantassin Scout", cls = "Aquatic" },
		{ "Manta Ray (125 exp, 8x)", 33552, 31293, 13, mon = "Manta Ray", cls = "Aquatic" },
		{ "Deepling Worker (130 exp, 30x)", 33549, 31275, 14, mon = "Deepling Worker", cls = "Aquatic" },
		{ "Blood Crab (160 exp, 43x)", 31939, 31046, 8, mon = "Blood Crab", cls = "Aquatic" },
		{ "Deepling Scout (160 exp, 30x)", 33493, 31281, 13, mon = "Deepling Scout", cls = "Aquatic" },
		{ "Quara Constrictor Scout (200 exp, 15x)", 31949, 32672, 8, mon = "Quara Constrictor Scout", cls = "Aquatic" },
		{ "Quara Constrictor (380 exp, 34x)", 32070, 32767, 12, mon = "Quara Constrictor", cls = "Aquatic" },
		{ "Quara Predator Scout (400 exp, 24x)", 31950, 32688, 9, mon = "Quara Predator Scout", cls = "Aquatic" },
		{ "Quara Mantassin (600 exp, 39x)", 32080, 32772, 12, mon = "Quara Mantassin", cls = "Aquatic" },
		{ "Quara Pincher Scout (600 exp, 25x)", 31928, 32692, 10, mon = "Quara Pincher Scout", cls = "Aquatic" },
		{ "Shark (700 exp, 22x)", 33446, 31796, 15, mon = "Shark", cls = "Aquatic" },
		{ "Quara Hydromancer Scout (800 exp, 18x)", 31949, 32686, 9, mon = "Quara Hydromancer Scout", cls = "Aquatic" },
		{ "Quara Hydromancer (950 exp, 24x)", 32272, 32920, 10, mon = "Quara Hydromancer", cls = "Aquatic" },
		{ "Deepling Spellsinger (1000 exp, 33x)", 33443, 31245, 11, mon = "Deepling Spellsinger", cls = "Aquatic" },
		{ "Deepling Warrior (1500 exp, 22x)", 33504, 31249, 11, mon = "Deepling Warrior", cls = "Aquatic" },
		{ "Quara Pincher (1500 exp, 32x)", 31940, 32754, 12, mon = "Quara Pincher", cls = "Aquatic" },
		{ "Quara Predator (1850 exp, 23x)", 32273, 32920, 10, mon = "Quara Predator", cls = "Aquatic" },
		{ "Deepling Guard (2100 exp, 30x)", 33504, 31249, 11, mon = "Deepling Guard", cls = "Aquatic" },
		{ "Deathling Scout (6300 exp, 30x)", 33584, 31424, 14, mon = "Deathling Scout", cls = "Aquatic" },
		{ "Deathling Spellsinger (6400 exp, 31x)", 33577, 31423, 14, mon = "Deathling Spellsinger", cls = "Aquatic" },
		{ "Marsh Stalker (50 exp, 20x)", 32847, 32101, 10, mon = "Marsh Stalker", cls = "Bird" },
		{ "Terror Bird (150 exp, 13x)", 32994, 32578, 7, mon = "Terror Bird", cls = "Bird" },
		{ "Jungle Moa (1200 exp, 19x)", 33807, 32712, 7, mon = "Jungle Moa", cls = "Bird" },
		{ "Harpy (5720 exp, 39x)", 33762, 32543, 7, mon = "Harpy", cls = "Bird" },
		{ "Carnivostrich (7290 exp, 35x)", 33723, 32527, 10, mon = "Carnivostrich", cls = "Bird" },
		{ "Headpecker (12026 exp, 27x)", 33741, 32850, 14, mon = "Headpecker", cls = "Bird" },
		{ "Damaged Worker Golem (95 exp, 19x)", 32888, 31254, 8, mon = "Damaged Worker Golem", cls = "Construct" },
		{ "Stone Golem (160 exp, 24x)", 33040, 31480, 11, mon = "Stone Golem", cls = "Construct" },
		{ "Iron Servant (210 exp, 86x)", 32769, 32871, 13, mon = "Iron Servant", cls = "Construct" },
		{ "Ice Golem (295 exp, 37x)", 32216, 31065, 10, mon = "Ice Golem", cls = "Construct" },
		{ "Clay Guardian (400 exp, 34x)", 32308, 32587, 11, mon = "Clay Guardian", cls = "Construct" },
		{ "Enraged Crystal Golem (550 exp, 23x)", 32948, 31951, 10, mon = "Enraged Crystal Golem", cls = "Construct" },
		{ "Sandstone Scorpion (680 exp, 20x)", 32944, 32773, 12, mon = "Sandstone Scorpion", cls = "Construct" },
		{ "Infected Weeper (1200 exp, 9x)", 33022, 31971, 11, mon = "Infected Weeper", cls = "Construct" },
		{ "Golden Servant Replica (1250 exp, 17x)", 32769, 32870, 13, mon = "Golden Servant Replica", cls = "Construct" },
		{ "Worker Golem (1250 exp, 66x)", 31134, 32655, 8, mon = "Worker Golem", cls = "Construct" },
		{ "Metal Gargoyle (1278 exp, 48x)", 33419, 32088, 10, mon = "Metal Gargoyle", cls = "Construct" },
		{ "Diamond Servant Replica (1400 exp, 16x)", 32857, 32837, 13, mon = "Diamond Servant Replica", cls = "Construct" },
		{ "Glooth Golem (1606 exp, 26x)", 33652, 31953, 9, mon = "Glooth Golem", cls = "Construct" },
		{ "Eternal Guardian (1800 exp, 25x)", 32726, 32575, 12, mon = "Eternal Guardian", cls = "Construct" },
		{ "Rustheap Golem (2100 exp, 14x)", 33629, 32056, 15, mon = "Rustheap Golem", cls = "Construct" },
		{ "Walker (2200 exp, 13x)", 33654, 31975, 14, mon = "Walker", cls = "Construct" },
		{ "War Golem (2310 exp, 72x)", 31006, 32682, 8, mon = "War Golem", cls = "Construct" },
		{ "Goggle Cake (2700 exp, 16x)", 33438, 32188, 8, mon = "Goggle Cake", cls = "Construct" },
		{ "Stone Devourer (2900 exp, 17x)", 33060, 31972, 10, mon = "Stone Devourer", cls = "Construct" },
		{ "Magma Crawler (3900 exp, 37x)", 33079, 31958, 11, mon = "Magma Crawler", cls = "Construct" },
		{ "Weeper (5800 exp, 26x)", 33073, 31960, 11, mon = "Weeper", cls = "Construct" },
		{ "Orewalker (5900 exp, 18x)", 33005, 31953, 12, mon = "Orewalker", cls = "Construct" },
		{ "Lava Golem (7900 exp, 24x)", 33074, 31959, 11, mon = "Lava Golem", cls = "Construct" },
		{ "Shrieking Cry-Stal (13560 exp, 27x)", 33740, 32849, 14, mon = "Shrieking Cry-Stal", cls = "Construct" },
		{ "Rotten Golem (17860 exp, 39x)", 33965, 31086, 11, mon = "Rotten Golem", cls = "Construct" },
		{ "Wandering Pillar (23200 exp, 24x)", 33868, 31881, 14, mon = "Wandering Pillar", cls = "Construct" },
		{ "Walking Pillar (24300 exp, 47x)", 34005, 31848, 14, mon = "Walking Pillar", cls = "Construct" },
		{ "Fire Devil (145 exp, 22x)", 32016, 32599, 8, mon = "Fire Devil", cls = "Demon" },
		{ "Gozzler (180 exp, 25x)", 32849, 31055, 7, mon = "Gozzler", cls = "Demon" },
		{ "Askarak Demon (900 exp, 17x)", 33292, 31934, 12, mon = "Askarak Demon", cls = "Demon" },
		{ "Shaburak Demon (900 exp, 25x)", 33244, 31938, 12, mon = "Shaburak Demon", cls = "Demon" },
		{ "Destroyer (2500 exp, 45x)", 33508, 31791, 8, mon = "Destroyer", cls = "Demon" },
		{ "Hellspawn (2550 exp, 55x)", 33394, 31726, 8, mon = "Hellspawn", cls = "Demon" },
		{ "Diabolic Imp (2900 exp, 20x)", 33097, 31782, 15, mon = "Diabolic Imp", cls = "Demon" },
		{ "Fury (3600 exp, 24x)", 33311, 31835, 15, mon = "Fury", cls = "Demon" },
		{ "Hellfire Fighter (3800 exp, 36x)", 33673, 32684, 13, mon = "Hellfire Fighter", cls = "Demon" },
		{ "Plaguesmith (3800 exp, 37x)", 33232, 31436, 13, mon = "Plaguesmith", cls = "Demon" },
		{ "Dawnfire Asura (4100 exp, 31x)", 32814, 32754, 9, mon = "Dawnfire Asura", cls = "Demon" },
		{ "Midnight Asura (4100 exp, 57x)", 32814, 32755, 9, mon = "Midnight Asura", cls = "Demon" },
		{ "Frost Flower Asura (4200 exp, 16x)", 32825, 32798, 9, mon = "Frost Flower Asura", cls = "Demon" },
		{ "Dark Torturer (4650 exp, 60x)", 33600, 32381, 10, mon = "Dark Torturer", cls = "Demon" },
		{ "Hellhound (5440 exp, 39x)", 33507, 31790, 8, mon = "Hellhound", cls = "Demon" },
		{ "Demon (6000 exp, 49x)", 33510, 31790, 8, mon = "Demon", cls = "Demon" },
		{ "Demon Outcast (6200 exp, 121x)", 33600, 32406, 10, mon = "Demon Outcast", cls = "Demon" },
		{ "Vexclaw (6248 exp, 44x)", 33476, 32703, 14, mon = "Vexclaw", cls = "Demon" },
		{ "Sineater Inferniarch (6750 exp, 49x)", 33834, 32335, 7, mon = "Sineater Inferniarch", cls = "Demon" },
		{ "True Frost Flower Asura (7069 exp, 30x)", 32843, 32805, 10, mon = "True Frost Flower Asura", cls = "Demon" },
		{ "Gorger Inferniarch (7180 exp, 40x)", 33837, 32355, 7, mon = "Gorger Inferniarch", cls = "Demon" },
		{ "Grimeleech (7216 exp, 43x)", 33657, 32636, 10, mon = "Grimeleech", cls = "Demon" },
		{ "True Midnight Asura (7313 exp, 38x)", 32843, 32804, 10, mon = "True Midnight Asura", cls = "Demon" },
		{ "Broodrider Inferniarch (7400 exp, 40x)", 33836, 32355, 7, mon = "Broodrider Inferniarch", cls = "Demon" },
		{ "True Dawnfire Asura (7475 exp, 35x)", 32841, 32805, 10, mon = "True Dawnfire Asura", cls = "Demon" },
		{ "Floating Savant (8000 exp, 23x)", 33280, 32092, 9, mon = "Floating Savant", cls = "Demon" },
		{ "Hellhunter Inferniarch (8100 exp, 87x)", 33844, 32361, 8, mon = "Hellhunter Inferniarch", cls = "Demon" },
		{ "Spellreaper Inferniarch (8350 exp, 108x)", 33851, 32301, 10, mon = "Spellreaper Inferniarch", cls = "Demon" },
		{ "Juggernaut (11200 exp, 35x)", 33507, 31790, 8, mon = "Juggernaut", cls = "Demon" },
		{ "Hellflayer (11720 exp, 27x)", 33389, 32429, 13, mon = "Hellflayer", cls = "Demon" },
		{ "Brachiodemon (15770 exp, 50x)", 34014, 31062, 9, mon = "Brachiodemon", cls = "Demon" },
		{ "Infernal Demon (17430 exp, 46x)", 34017, 31062, 9, mon = "Infernal Demon", cls = "Demon" },
		{ "Many Faces (18870 exp, 18x)", 33962, 31180, 12, mon = "Many Faces", cls = "Demon" },
		{ "Brinebrute Inferniarch (20300 exp, 40x)", 33822, 32305, 11, mon = "Brinebrute Inferniarch", cls = "Demon" },
		{ "Dragon Hatchling (185 exp, 23x)", 33048, 31172, 7, mon = "Dragon Hatchling", cls = "Dragon" },
		{ "Dragon Lord Hatchling (645 exp, 14x)", 32561, 31373, 15, mon = "Dragon Lord Hatchling", cls = "Dragon" },
		{ "Dragon (700 exp, 55x)", 33214, 31252, 7, mon = "Dragon", cls = "Dragon" },
		{ "Frost Dragon Hatchling (745 exp, 22x)", 32197, 31450, 7, mon = "Frost Dragon Hatchling", cls = "Dragon" },
		{ "Wyrm (1550 exp, 42x)", 33080, 32392, 14, mon = "Wyrm", cls = "Dragon" },
		{ "Dragon Lord (2100 exp, 55x)", 33223, 31277, 5, mon = "Dragon Lord", cls = "Dragon" },
		{ "Frost Dragon (2100 exp, 22x)", 32229, 31411, 8, mon = "Frost Dragon", cls = "Dragon" },
		{ "Hydra (2100 exp, 33x)", 33500, 31936, 10, mon = "Hydra", cls = "Dragon" },
		{ "Ice Dragon (2300 exp, 12x)", 32055, 32483, 11, mon = "Ice Dragon", cls = "Dragon" },
		{ "Draken Warmaster (2400 exp, 50x)", 33082, 31108, 3, mon = "Draken Warmaster", cls = "Dragon" },
		{ "Elder Wyrm (2500 exp, 49x)", 33083, 32391, 14, mon = "Elder Wyrm", cls = "Dragon" },
		{ "Draken Spellweaver (3100 exp, 38x)", 33086, 31116, 4, mon = "Draken Spellweaver", cls = "Dragon" },
		{ "Draken Abomination (4500 exp, 23x)", 33068, 31086, 12, mon = "Draken Abomination", cls = "Dragon" },
		{ "Ghastly Dragon (4600 exp, 9x)", 33049, 31108, 14, mon = "Ghastly Dragon", cls = "Dragon" },
		{ "Draken Elite (4750 exp, 10x)", 33103, 31116, 9, mon = "Draken Elite", cls = "Dragon" },
		{ "Dragolisk (5050 exp, 69x)", 33281, 31147, 13, mon = "Dragolisk", cls = "Dragon" },
		{ "Wardragon (5810 exp, 56x)", 33237, 31187, 13, mon = "Wardragon", cls = "Dragon" },
		{ "Haunted Dragon (6500 exp, 15x)", 32122, 32512, 12, mon = "Haunted Dragon", cls = "Dragon" },
		{ "Mega Dragon (7810 exp, 38x)", 33280, 31147, 13, mon = "Mega Dragon", cls = "Dragon" },
		{ "Fire Elemental (220 exp, 38x)", 33265, 32910, 15, mon = "Fire Elemental", cls = "Elemental" },
		{ "Earth Elemental (550 exp, 52x)", 32337, 32588, 12, mon = "Earth Elemental", cls = "Elemental" },
		{ "Energy Elemental (550 exp, 38x)", 33600, 32380, 10, mon = "Energy Elemental", cls = "Elemental" },
		{ "Water Elemental (650 exp, 44x)", 32542, 32829, 9, mon = "Water Elemental", cls = "Elemental" },
		{ "Massive Energy Elemental (950 exp, 8x)", 33061, 32685, 3, mon = "Massive Energy Elemental", cls = "Elemental" },
		{ "Massive Earth Elemental (1100 exp, 24x)", 32241, 32522, 13, mon = "Massive Earth Elemental", cls = "Elemental" },
		{ "Massive Water Elemental (1100 exp, 19x)", 32069, 32773, 12, mon = "Massive Water Elemental", cls = "Elemental" },
		{ "Massive Fire Elemental (1400 exp, 18x)", 33293, 31846, 14, mon = "Massive Fire Elemental", cls = "Elemental" },
		{ "Foam Stalker (3120 exp, 22x)", 33718, 32741, 9, mon = "Foam Stalker", cls = "Elemental" },
		{ "Candy Floss Elemental (3850 exp, 18x)", 33429, 32168, 8, mon = "Candy Floss Elemental", cls = "Elemental" },
		{ "Lava Lurker (4000 exp, 29x)", 33988, 32265, 14, mon = "Lava Lurker", cls = "Elemental" },
		{ "Ravenous Lava Lurker (4000 exp, 47x)", 33933, 32203, 14, mon = "Ravenous Lava Lurker", cls = "Elemental" },
		{ "Ironblight (5400 exp, 28x)", 33010, 31923, 12, mon = "Ironblight", cls = "Elemental" },
		{ "Cliff Strider (7100 exp, 18x)", 33013, 31925, 12, mon = "Cliff Strider", cls = "Elemental" },
		{ "Knowledge Elemental (10603 exp, 12x)", 32438, 32727, 12, mon = "Knowledge Elemental", cls = "Elemental" },
		{ "Sulphur Spouter (11517 exp, 56x)", 33636, 32800, 14, mon = "Sulphur Spouter", cls = "Elemental" },
		{ "Turbulent Elemental (19360 exp, 64x)", 33940, 31021, 9, mon = "Turbulent Elemental", cls = "Elemental" },
		{ "Converter (21425 exp, 14x)", 33868, 31882, 14, mon = "Converter", cls = "Elemental" },
		{ "Instable Breach Brood (1100 exp, 33x)", 32436, 32402, 10, mon = "Instable Breach Brood", cls = "Extra Dimensional" },
		{ "Yielothax (1250 exp, 33x)", 32944, 31586, 9, mon = "Yielothax", cls = "Extra Dimensional" },
		{ "Instable Sparkion (1350 exp, 24x)", 32470, 32407, 10, mon = "Instable Sparkion", cls = "Extra Dimensional" },
		{ "Sparkion (1520 exp, 63x)", 32178, 31360, 12, mon = "Sparkion", cls = "Extra Dimensional" },
		{ "Breach Brood (1760 exp, 54x)", 32142, 31373, 11, mon = "Breach Brood", cls = "Extra Dimensional" },
		{ "Stabilizing Dread Intruder (1900 exp, 20x)", 32028, 31351, 11, mon = "Stabilizing Dread Intruder", cls = "Extra Dimensional" },
		{ "Stabilizing Reality Reaver (1950 exp, 20x)", 32034, 31347, 11, mon = "Stabilizing Reality Reaver", cls = "Extra Dimensional" },
		{ "Dread Intruder (2400 exp, 52x)", 32147, 31361, 12, mon = "Dread Intruder", cls = "Extra Dimensional" },
		{ "Reality Reaver (2480 exp, 68x)", 32181, 31365, 12, mon = "Reality Reaver", cls = "Extra Dimensional" },
		{ "Courage Leech (18900 exp, 29x)", 33842, 31835, 3, mon = "Courage Leech", cls = "Extra Dimensional" },
		{ "Cream Blob (21 exp, 9x)", 33422, 32122, 7, mon = "Cream Blob", cls = "Fey" },
		{ "Dryad (190 exp, 19x)", 33236, 31974, 10, mon = "Dryad", cls = "Fey" },
		{ "Pooka (500 exp, 10x)", 33421, 32233, 7, mon = "Pooka", cls = "Fey" },
		{ "Schiach (580 exp, 30x)", 33862, 31077, 7, mon = "Schiach", cls = "Fey" },
		{ "Percht (600 exp, 20x)", 33809, 31105, 7, mon = "Percht", cls = "Fey" },
		{ "Twisted Pooka (600 exp, 32x)", 33551, 32210, 8, mon = "Twisted Pooka", cls = "Fey" },
		{ "Pixie (700 exp, 39x)", 33434, 32246, 7, mon = "Pixie", cls = "Fey" },
		{ "Swan Maiden (700 exp, 11x)", 33542, 32248, 7, mon = "Swan Maiden", cls = "Fey" },
		{ "Faun (800 exp, 22x)", 33565, 32236, 7, mon = "Faun", cls = "Fey" },
		{ "Nymph (850 exp, 10x)", 33421, 32227, 7, mon = "Nymph", cls = "Fey" },
		{ "Dark Faun (900 exp, 35x)", 33571, 32185, 9, mon = "Dark Faun", cls = "Fey" },
		{ "Boogy (950 exp, 17x)", 33564, 32240, 7, mon = "Boogy", cls = "Fey" },
		{ "Cyclops (150 exp, 45x)", 32485, 32058, 8, mon = "Cyclops", cls = "Giant" },
		{ "Frost Giant (150 exp, 27x)", 32413, 31302, 9, mon = "Frost Giant", cls = "Giant" },
		{ "Frost Giantess (150 exp, 19x)", 32413, 31301, 9, mon = "Frost Giantess", cls = "Giant" },
		{ "Cyclops Drone (200 exp, 23x)", 32602, 31417, 6, mon = "Cyclops Drone", cls = "Giant" },
		{ "Cyclops Smith (255 exp, 15x)", 33313, 31667, 11, mon = "Cyclops Smith", cls = "Giant" },
		{ "Ogre Shaman (625 exp, 22x)", 33592, 31674, 7, mon = "Ogre Shaman", cls = "Giant" },
		{ "Ogre Brute (800 exp, 36x)", 33667, 31597, 7, mon = "Ogre Brute", cls = "Giant" },
		{ "Ogre Savage (950 exp, 13x)", 33620, 31711, 7, mon = "Ogre Savage", cls = "Giant" },
		{ "Orclops Ravager (1100 exp, 21x)", 32738, 32124, 10, mon = "Orclops Ravager", cls = "Giant" },
		{ "Orclops Doomhauler (1450 exp, 10x)", 32732, 32122, 10, mon = "Orclops Doomhauler", cls = "Giant" },
		{ "Behemoth (2500 exp, 28x)", 33011, 32508, 9, mon = "Behemoth", cls = "Giant" },
		{ "Ogre Rowdy (4200 exp, 28x)", 33824, 31647, 8, mon = "Ogre Rowdy", cls = "Giant" },
		{ "Ogre Ruffian (5000 exp, 22x)", 33793, 31603, 7, mon = "Ogre Ruffian", cls = "Giant" },
		{ "Ogre Sage (5500 exp, 17x)", 33796, 31603, 7, mon = "Ogre Sage", cls = "Giant" },
		{ "Hulking Prehemoth (12690 exp, 50x)", 33591, 32904, 14, mon = "Hulking Prehemoth", cls = "Giant" },
		{ "Crazed Beggar (35 exp, 11x)", 32920, 31274, 7, mon = "Crazed Beggar", cls = "Human" },
		{ "Smuggler (48 exp, 26x)", 32860, 31321, 6, mon = "Smuggler", cls = "Human" },
		{ "Amazon (60 exp, 30x)", 32833, 31925, 7, mon = "Amazon", cls = "Human" },
		{ "Nomad (60 exp, 31x)", 33231, 32514, 8, mon = "Nomad", cls = "Human" },
		{ "Wild Warrior (60 exp, 19x)", 32658, 32360, 8, mon = "Wild Warrior", cls = "Human" },
		{ "Bandit (65 exp, 36x)", 32657, 32361, 8, mon = "Bandit", cls = "Human" },
		{ "Gang Member (70 exp, 25x)", 32828, 31303, 7, mon = "Gang Member", cls = "Human" },
		{ "Barbarian Headsplitter (85 exp, 37x)", 32006, 31272, 7, mon = "Barbarian Headsplitter", cls = "Human" },
		{ "Barbarian Skullhunter (85 exp, 29x)", 31999, 31270, 7, mon = "Barbarian Skullhunter", cls = "Human" },
		{ "Valkyrie (85 exp, 18x)", 32847, 31916, 8, mon = "Valkyrie", cls = "Human" },
		{ "Barbarian Brutetamer (90 exp, 16x)", 32051, 31338, 7, mon = "Barbarian Brutetamer", cls = "Human" },
		{ "Gladiator (90 exp, 19x)", 32654, 31232, 6, mon = "Gladiator", cls = "Human" },
		{ "Stalker (90 exp, 70x)", 33083, 32978, 14, mon = "Stalker", cls = "Human" },
		{ "Dark Apprentice (100 exp, 11x)", 32921, 31084, 5, mon = "Dark Apprentice", cls = "Human" },
		{ "Novice of the Cult (100 exp, 87x)", 32144, 31120, 9, mon = "Novice of the Cult", cls = "Human" },
		{ "Assassin (105 exp, 26x)", 32614, 32472, 9, mon = "Assassin", cls = "Human" },
		{ "Witch (120 exp, 15x)", 32614, 32476, 9, mon = "Witch", cls = "Human" },
		{ "Pirate Marauder (125 exp, 54x)", 31960, 32805, 6, mon = "Pirate Marauder", cls = "Human" },
		{ "Dark Monk (145 exp, 33x)", 32614, 32474, 9, mon = "Dark Monk", cls = "Human" },
		{ "Mutated Human (150 exp, 31x)", 32696, 31162, 6, mon = "Mutated Human", cls = "Human" },
		{ "Pirate Cutthroat (175 exp, 26x)", 31969, 32816, 4, mon = "Pirate Cutthroat", cls = "Human" },
		{ "Dark Magician (185 exp, 11x)", 32920, 31087, 5, mon = "Dark Magician", cls = "Human" },
		{ "Barbarian Bloodwalker (195 exp, 18x)", 32001, 31416, 7, mon = "Barbarian Bloodwalker", cls = "Human" },
		{ "Monk (200 exp, 13x)", 33373, 31347, 3, mon = "Monk", cls = "Human" },
		{ "Mad Scientist (205 exp, 12x)", 32892, 31097, 6, mon = "Mad Scientist", cls = "Human" },
		{ "Pirate Buccaneer (250 exp, 19x)", 32639, 31296, 6, mon = "Pirate Buccaneer", cls = "Human" },
		{ "Acolyte of the Cult (300 exp, 45x)", 32082, 31070, 10, mon = "Acolyte of the Cult", cls = "Human" },
		{ "Adept of the Cult (400 exp, 22x)", 32026, 31196, 10, mon = "Adept of the Cult", cls = "Human" },
		{ "Shadow Pupil (410 exp, 13x)", 33005, 32448, 12, mon = "Shadow Pupil", cls = "Human" },
		{ "Priestess (420 exp, 20x)", 33042, 32405, 10, mon = "Priestess", cls = "Human" },
		{ "Enlightened of the Cult (500 exp, 27x)", 32150, 31231, 11, mon = "Enlightened of the Cult", cls = "Human" },
		{ "Ice Witch (580 exp, 18x)", 32278, 31033, 11, mon = "Ice Witch", cls = "Human" },
		{ "Necromancer (580 exp, 43x)", 32996, 32391, 10, mon = "Necromancer", cls = "Human" },
		{ "Blood Hand (750 exp, 11x)", 32976, 32422, 11, mon = "Blood Hand", cls = "Human" },
		{ "Cult Believer (850 exp, 25x)", 32351, 31680, 8, mon = "Cult Believer", cls = "Human" },
		{ "Blood Priest (900 exp, 15x)", 33297, 31581, 9, mon = "Blood Priest", cls = "Human" },
		{ "Vicious Squire (900 exp, 32x)", 33297, 31581, 9, mon = "Vicious Squire", cls = "Human" },
		{ "Cult Enforcer (1000 exp, 25x)", 32369, 31680, 9, mon = "Cult Enforcer", cls = "Human" },
		{ "Cult Scholar (1100 exp, 12x)", 32346, 31673, 10, mon = "Cult Scholar", cls = "Human" },
		{ "Hero (1200 exp, 21x)", 33297, 31581, 9, mon = "Hero", cls = "Human" },
		{ "Misguided Thief (1200 exp, 25x)", 32502, 32420, 9, mon = "Misguided Thief", cls = "Human" },
		{ "Renegade Knight (1200 exp, 39x)", 33298, 31582, 9, mon = "Renegade Knight", cls = "Human" },
		{ "Vile Grandmaster (1500 exp, 39x)", 32369, 31678, 9, mon = "Vile Grandmaster", cls = "Human" },
		{ "Glooth Brigand (1900 exp, 40x)", 33694, 32002, 12, mon = "Glooth Brigand", cls = "Human" },
		{ "Glooth Bandit (2000 exp, 54x)", 33694, 32002, 12, mon = "Glooth Bandit", cls = "Human" },
		{ "Goldhanded Cultist (2000 exp, 25x)", 33228, 32141, 10, mon = "Goldhanded Cultist", cls = "Human" },
		{ "Infernalist (4000 exp, 9x)", 33303, 31827, 15, mon = "Infernalist", cls = "Human" },
		{ "Warlock (4000 exp, 19x)", 32481, 31618, 15, mon = "Warlock", cls = "Human" },
		{ "Dark Carnisylvan (4400 exp, 22x)", 32581, 32465, 13, mon = "Dark Carnisylvan", cls = "Human" },
		{ "Poisonous Carnisylvan (4400 exp, 21x)", 32584, 32463, 13, mon = "Poisonous Carnisylvan", cls = "Human" },
		{ "Hulking Carnisylvan (4700 exp, 11x)", 32560, 32448, 12, mon = "Hulking Carnisylvan", cls = "Human" },
		{ "Priestess of the Wild Sun (6400 exp, 34x)", 33868, 31524, 8, mon = "Priestess of the Wild Sun", cls = "Human" },
		{ "Usurper Knight (6900 exp, 20x)", 32460, 32499, 7, mon = "Usurper Knight", cls = "Human" },
		{ "Cobra Assassin (6980 exp, 37x)", 33377, 32789, 8, mon = "Cobra Assassin", cls = "Human" },
		{ "Usurper Warlock (7000 exp, 9x)", 32386, 32464, 6, mon = "Usurper Warlock", cls = "Human" },
		{ "Black Sphinx Acolyte (7200 exp, 35x)", 33868, 31524, 8, mon = "Black Sphinx Acolyte", cls = "Human" },
		{ "Cobra Scout (7310 exp, 17x)", 33376, 32789, 8, mon = "Cobra Scout", cls = "Human" },
		{ "Burning Gladiator (7350 exp, 40x)", 33865, 31524, 8, mon = "Burning Gladiator", cls = "Human" },
		{ "Cobra Vizier (7650 exp, 19x)", 33377, 32789, 8, mon = "Cobra Vizier", cls = "Human" },
		{ "Island Troll (20 exp, 33x)", 32133, 32540, 7, mon = "Island Troll", cls = "Humanoid" },
		{ "Troll (20 exp, 61x)", 32284, 32128, 8, mon = "Troll", cls = "Humanoid" },
		{ "Frost Troll (23 exp, 34x)", 32093, 31053, 9, mon = "Frost Troll", cls = "Humanoid" },
		{ "Goblin (25 exp, 42x)", 32555, 31830, 6, mon = "Goblin", cls = "Humanoid" },
		{ "Orc (25 exp, 34x)", 32898, 31777, 7, mon = "Orc", cls = "Humanoid" },
		{ "Swamp Troll (25 exp, 44x)", 32961, 32231, 8, mon = "Swamp Troll", cls = "Humanoid" },
		{ "Dworc Venomsniper (35 exp, 83x)", 32669, 32918, 8, mon = "Dworc Venomsniper", cls = "Humanoid" },
		{ "Goblin Scavenger (37 exp, 20x)", 33107, 31866, 10, mon = "Goblin Scavenger", cls = "Humanoid" },
		{ "Orc Spearman (38 exp, 46x)", 32901, 31772, 7, mon = "Orc Spearman", cls = "Humanoid" },
		{ "Chakoya Toolshaper (40 exp, 72x)", 32452, 31066, 10, mon = "Chakoya Toolshaper", cls = "Humanoid" },
		{ "Chakoya Tribewarden (40 exp, 44x)", 32452, 31073, 10, mon = "Chakoya Tribewarden", cls = "Humanoid" },
		{ "Dworc Fleshhunter (40 exp, 61x)", 32761, 32869, 8, mon = "Dworc Fleshhunter", cls = "Humanoid" },
		{ "Troll Champion (40 exp, 17x)", 32647, 31979, 9, mon = "Troll Champion", cls = "Humanoid" },
		{ "Elf (42 exp, 21x)", 33054, 32199, 8, mon = "Elf", cls = "Humanoid" },
		{ "Dwarf (45 exp, 51x)", 32551, 31878, 9, mon = "Dwarf", cls = "Humanoid" },
		{ "Chakoya Windcaller (48 exp, 33x)", 32449, 31068, 10, mon = "Chakoya Windcaller", cls = "Humanoid" },
		{ "Minotaur (50 exp, 37x)", 32411, 32107, 15, mon = "Minotaur", cls = "Humanoid" },
		{ "Orc Warrior (50 exp, 49x)", 32936, 31705, 7, mon = "Orc Warrior", cls = "Humanoid" },
		{ "Goblin Assassin (52 exp, 16x)", 33107, 31867, 10, mon = "Goblin Assassin", cls = "Humanoid" },
		{ "Dworc Voodoomaster (55 exp, 23x)", 32761, 32868, 8, mon = "Dworc Voodoomaster", cls = "Humanoid" },
		{ "Minotaur Archer (65 exp, 12x)", 32251, 32435, 10, mon = "Minotaur Archer", cls = "Humanoid" },
		{ "Dwarf Soldier (70 exp, 67x)", 32511, 31908, 11, mon = "Dwarf Soldier", cls = "Humanoid" },
		{ "Elf Scout (75 exp, 12x)", 32759, 31280, 7, mon = "Elf Scout", cls = "Humanoid" },
		{ "Firestarter (80 exp, 17x)", 33085, 32157, 7, mon = "Firestarter", cls = "Humanoid" },
		{ "Orc Rider (110 exp, 23x)", 33312, 31472, 7, mon = "Orc Rider", cls = "Humanoid" },
		{ "Orc Shaman (110 exp, 20x)", 32932, 31819, 7, mon = "Orc Shaman", cls = "Humanoid" },
		{ "Troll Legionnaire (140 exp, 15x)", 32760, 31454, 12, mon = "Troll Legionnaire", cls = "Humanoid" },
		{ "Corym Charlatan (150 exp, 30x)", 33008, 32198, 11, mon = "Corym Charlatan", cls = "Humanoid" },
		{ "Minotaur Mage (150 exp, 10x)", 32251, 32433, 10, mon = "Minotaur Mage", cls = "Humanoid" },
		{ "Minotaur Guard (160 exp, 21x)", 32402, 32102, 15, mon = "Minotaur Guard", cls = "Humanoid" },
		{ "Dwarf Guard (165 exp, 78x)", 32528, 31925, 13, mon = "Dwarf Guard", cls = "Humanoid" },
		{ "Elf Arcanist (175 exp, 14x)", 32768, 31290, 6, mon = "Elf Arcanist", cls = "Humanoid" },
		{ "Furious Troll (185 exp, 11x)", 32752, 31470, 13, mon = "Furious Troll", cls = "Humanoid" },
		{ "Orc Berserker (195 exp, 66x)", 32877, 31790, 7, mon = "Orc Berserker", cls = "Humanoid" },
		{ "Orc Marauder (205 exp, 25x)", 33242, 31515, 7, mon = "Orc Marauder", cls = "Humanoid" },
		{ "Corym Skirmisher (260 exp, 27x)", 33006, 32196, 11, mon = "Corym Skirmisher", cls = "Humanoid" },
		{ "Dwarf Geomancer (265 exp, 20x)", 32590, 31428, 14, mon = "Dwarf Geomancer", cls = "Humanoid" },
		{ "Orc Leader (270 exp, 13x)", 33062, 31333, 8, mon = "Orc Leader", cls = "Humanoid" },
		{ "Corym Vanguard (490 exp, 18x)", 33071, 32154, 11, mon = "Corym Vanguard", cls = "Humanoid" },
		{ "Orc Cult Minion (850 exp, 13x)", 33152, 31876, 10, mon = "Orc Cult Minion", cls = "Humanoid" },
		{ "Mooh'Tah Warrior (900 exp, 37x)", 33711, 31927, 7, mon = "Mooh'Tah Warrior", cls = "Humanoid" },
		{ "Minotaur Cult Follower (950 exp, 38x)", 31942, 32466, 8, mon = "Minotaur Cult Follower", cls = "Humanoid" },
		{ "Orc Cultist (950 exp, 8x)", 33129, 31881, 10, mon = "Orc Cultist", cls = "Humanoid" },
		{ "Orc Cult Priest (1000 exp, 13x)", 33178, 31897, 12, mon = "Orc Cult Priest", cls = "Humanoid" },
		{ "Lost Husher (1100 exp, 27x)", 32201, 32662, 15, mon = "Lost Husher", cls = "Humanoid" },
		{ "Minotaur Cult Prophet (1100 exp, 27x)", 31951, 32484, 8, mon = "Minotaur Cult Prophet", cls = "Humanoid" },
		{ "Orc Cult Fanatic (1100 exp, 11x)", 33177, 31896, 12, mon = "Orc Cult Fanatic", cls = "Humanoid" },
		{ "Orc Cult Inquisitor (1150 exp, 16x)", 33146, 31863, 10, mon = "Orc Cult Inquisitor", cls = "Humanoid" },
		{ "Misguided Bully (1200 exp, 38x)", 32526, 32400, 9, mon = "Misguided Bully", cls = "Humanoid" },
		{ "Minotaur Cult Zealot (1350 exp, 26x)", 31959, 32430, 9, mon = "Minotaur Cult Zealot", cls = "Humanoid" },
		{ "Lost Thrower (1500 exp, 45x)", 32212, 32535, 15, mon = "Lost Thrower", cls = "Humanoid" },
		{ "Worm Priestess (1500 exp, 26x)", 33557, 32005, 7, mon = "Worm Priestess", cls = "Humanoid" },
		{ "Minotaur Invader (1600 exp, 12x)", 33583, 31948, 13, mon = "Minotaur Invader", cls = "Humanoid" },
		{ "Pirat Scoundrel (1600 exp, 26x)", 33906, 31187, 7, mon = "Pirat Scoundrel", cls = "Humanoid" },
		{ "Shaper Matriarch (1650 exp, 32x)", 32839, 32868, 14, mon = "Shaper Matriarch", cls = "Humanoid" },
		{ "Minotaur Hunter (1700 exp, 37x)", 33604, 32016, 7, mon = "Minotaur Hunter", cls = "Humanoid" },
		{ "Pirat Bombardier (1700 exp, 32x)", 33902, 31251, 6, mon = "Pirat Bombardier", cls = "Humanoid" },
		{ "Broken Shaper (1800 exp, 108x)", 32856, 32748, 14, mon = "Broken Shaper", cls = "Humanoid" },
		{ "Lost Exile (1800 exp, 25x)", 33779, 32268, 14, mon = "Lost Exile", cls = "Humanoid" },
		{ "Pirat Cutthroat (1800 exp, 23x)", 33869, 31351, 8, mon = "Pirat Cutthroat", cls = "Humanoid" },
		{ "Twisted Shaper (2050 exp, 39x)", 32856, 32750, 14, mon = "Twisted Shaper", cls = "Humanoid" },
		{ "Barkless Devotee (2200 exp, 25x)", 32712, 31433, 8, mon = "Barkless Devotee", cls = "Humanoid" },
		{ "Minotaur Amazon (2200 exp, 101x)", 31337, 32616, 8, mon = "Minotaur Amazon", cls = "Humanoid" },
		{ "Lost Basher (2300 exp, 39x)", 32304, 32584, 15, mon = "Lost Basher", cls = "Humanoid" },
		{ "Execowtioner (2400 exp, 67x)", 31301, 32678, 8, mon = "Execowtioner", cls = "Humanoid" },
		{ "Pirat Mate (2400 exp, 35x)", 33879, 31228, 6, mon = "Pirat Mate", cls = "Humanoid" },
		{ "Barkless Fanatic (2500 exp, 39x)", 32712, 31434, 8, mon = "Barkless Fanatic", cls = "Humanoid" },
		{ "Moohtant (2600 exp, 45x)", 31302, 32680, 8, mon = "Moohtant", cls = "Humanoid" },
		{ "Enslaved Dwarf (2700 exp, 12x)", 33400, 31953, 15, mon = "Enslaved Dwarf", cls = "Humanoid" },
		{ "Crazed Summer Rearguard (4700 exp, 27x)", 32085, 32004, 13, mon = "Crazed Summer Rearguard", cls = "Humanoid" },
		{ "Crazed Winter Rearguard (4700 exp, 36x)", 32065, 31949, 13, mon = "Crazed Winter Rearguard", cls = "Humanoid" },
		{ "Lost Berserker (4800 exp, 28x)", 33008, 31924, 12, mon = "Lost Berserker", cls = "Humanoid" },
		{ "Crazed Summer Vanguard (5000 exp, 26x)", 32014, 31949, 13, mon = "Crazed Summer Vanguard", cls = "Humanoid" },
		{ "Crape Man (5040 exp, 50x)", 33762, 32545, 7, mon = "Crape Man", cls = "Humanoid" },
		{ "Crazed Winter Vanguard (5400 exp, 34x)", 32066, 31953, 13, mon = "Crazed Winter Vanguard", cls = "Humanoid" },
		{ "Rhindeer (5600 exp, 51x)", 33732, 32496, 9, mon = "Rhindeer", cls = "Humanoid" },
		{ "Soul-Broken Harbinger (5800 exp, 35x)", 32065, 31949, 13, mon = "Soul-Broken Harbinger", cls = "Humanoid" },
		{ "Insane Siren (6000 exp, 26x)", 32015, 31948, 13, mon = "Insane Siren", cls = "Humanoid" },
		{ "Liodile (6860 exp, 41x)", 33738, 32578, 10, mon = "Liodile", cls = "Humanoid" },
		{ "Boar Man (7720 exp, 46x)", 33735, 32487, 10, mon = "Boar Man", cls = "Humanoid" },
		{ "Werebadger (1600 exp, 27x)", 33389, 31641, 9, mon = "Werebadger", cls = "Lycanthrope" },
		{ "Werefox (1600 exp, 11x)", 33130, 31983, 8, mon = "Werefox", cls = "Lycanthrope" },
		{ "Werewolf (1900 exp, 33x)", 33424, 31564, 11, mon = "Werewolf", cls = "Lycanthrope" },
		{ "Wereboar (2000 exp, 25x)", 33390, 31641, 9, mon = "Wereboar", cls = "Lycanthrope" },
		{ "Werebear (2100 exp, 32x)", 33427, 31564, 11, mon = "Werebear", cls = "Lycanthrope" },
		{ "Werehyaena (2200 exp, 131x)", 33197, 32396, 10, mon = "Werehyaena", cls = "Lycanthrope" },
		{ "Werehyaena Shaman (2200 exp, 52x)", 33174, 32456, 10, mon = "Werehyaena Shaman", cls = "Lycanthrope" },
		{ "Werelion (2200 exp, 46x)", 33130, 32321, 11, mon = "Werelion", cls = "Lycanthrope" },
		{ "Werelioness (2300 exp, 41x)", 33130, 32320, 11, mon = "Werelioness", cls = "Lycanthrope" },
		{ "Gazer (90 exp, 17x)", 32087, 32791, 8, mon = "Gazer", cls = "Magical" },
		{ "Rorc (105 exp, 47x)", 32782, 31805, 7, mon = "Rorc", cls = "Magical" },
		{ "Gargoyle (150 exp, 45x)", 32232, 32579, 8, mon = "Gargoyle", cls = "Magical" },
		{ "Bonelord (170 exp, 43x)", 32104, 32774, 8, mon = "Bonelord", cls = "Magical" },
		{ "Green Djinn (215 exp, 19x)", 33062, 32739, 14, mon = "Green Djinn", cls = "Magical" },
		{ "Elder Bonelord (280 exp, 15x)", 32113, 32804, 9, mon = "Elder Bonelord", cls = "Magical" },
		{ "Forest Fury (330 exp, 9x)", 33217, 32041, 10, mon = "Forest Fury", cls = "Magical" },
		{ "Crystalcrusher (500 exp, 23x)", 32187, 32612, 12, mon = "Crystalcrusher", cls = "Magical" },
		{ "Nightstalker (500 exp, 22x)", 32849, 32448, 12, mon = "Nightstalker", cls = "Magical" },
		{ "Bog Raider (800 exp, 26x)", 32665, 31094, 7, mon = "Bog Raider", cls = "Magical" },
		{ "Crystal Spider (900 exp, 28x)", 32374, 31051, 9, mon = "Crystal Spider", cls = "Magical" },
		{ "Weakened Frazzlemaw (1000 exp, 38x)", 33571, 32270, 9, mon = "Weakened Frazzlemaw", cls = "Magical" },
		{ "Enfeebled Silencer (1100 exp, 29x)", 33572, 32271, 9, mon = "Enfeebled Silencer", cls = "Magical" },
		{ "Nightmare Scion (1350 exp, 25x)", 33561, 31586, 9, mon = "Nightmare Scion", cls = "Magical" },
		{ "Lumbering Carnivor (1452 exp, 17x)", 32747, 32629, 8, mon = "Lumbering Carnivor", cls = "Magical" },
		{ "Spiky Carnivor (1650 exp, 21x)", 32753, 32627, 10, mon = "Spiky Carnivor", cls = "Magical" },
		{ "Nightmare (1800 exp, 24x)", 33657, 32673, 11, mon = "Nightmare", cls = "Magical" },
		{ "Menacing Carnivor (2112 exp, 26x)", 32752, 32628, 10, mon = "Menacing Carnivor", cls = "Magical" },
		{ "Shock Head (2300 exp, 17x)", 33595, 32518, 7, mon = "Shock Head", cls = "Magical" },
		{ "Nibblemaw (2700 exp, 13x)", 33370, 32168, 8, mon = "Nibblemaw", cls = "Magical" },
		{ "Candy Horror (3000 exp, 16x)", 33411, 32156, 9, mon = "Candy Horror", cls = "Magical" },
		{ "Armadile (3200 exp, 24x)", 33044, 31959, 10, mon = "Armadile", cls = "Magical" },
		{ "Frazzlemaw (3740 exp, 45x)", 33640, 32440, 7, mon = "Frazzlemaw", cls = "Magical" },
		{ "Medusa (4050 exp, 41x)", 32800, 32630, 15, mon = "Medusa", cls = "Magical" },
		{ "Retching Horror (4100 exp, 53x)", 33643, 32440, 7, mon = "Retching Horror", cls = "Magical" },
		{ "Phantasm (4400 exp, 30x)", 33062, 31754, 11, mon = "Phantasm", cls = "Magical" },
		{ "Juvenile Bashmu (4500 exp, 24x)", 34043, 31685, 8, mon = "Juvenile Bashmu", cls = "Magical" },
		{ "Arachnophobica (4700 exp, 52x)", 32068, 31950, 13, mon = "Arachnophobica", cls = "Magical" },
		{ "Choking Fear (4700 exp, 51x)", 33632, 32412, 7, mon = "Choking Fear", cls = "Magical" },
		{ "Bashmu (5000 exp, 33x)", 33976, 31689, 8, mon = "Bashmu", cls = "Magical" },
		{ "Feversleep (5060 exp, 27x)", 33691, 32291, 9, mon = "Feversleep", cls = "Magical" },
		{ "Manticore (5100 exp, 28x)", 33920, 31625, 7, mon = "Manticore", cls = "Magical" },
		{ "Silencer (5100 exp, 43x)", 33640, 32440, 7, mon = "Silencer", cls = "Magical" },
		{ "Venerable Girtablilu (5300 exp, 29x)", 33781, 31754, 10, mon = "Venerable Girtablilu", cls = "Magical" },
		{ "Girtablilu Warrior (5800 exp, 51x)", 33781, 31754, 10, mon = "Girtablilu Warrior", cls = "Magical" },
		{ "Guzzlemaw (6050 exp, 53x)", 33628, 32458, 7, mon = "Guzzlemaw", cls = "Magical" },
		{ "Thanatursus (6300 exp, 53x)", 32064, 31949, 13, mon = "Thanatursus", cls = "Magical" },
		{ "Terrorsleep (6900 exp, 26x)", 33684, 32357, 8, mon = "Terrorsleep", cls = "Magical" },
		{ "Sphinx (7500 exp, 48x)", 33872, 31441, 9, mon = "Sphinx", cls = "Magical" },
		{ "Crypt Warden (8400 exp, 45x)", 33877, 31448, 9, mon = "Crypt Warden", cls = "Magical" },
		{ "Feral Sphinx (8800 exp, 28x)", 33900, 31580, 7, mon = "Feral Sphinx", cls = "Magical" },
		{ "Lamassu (9000 exp, 15x)", 33789, 31541, 7, mon = "Lamassu", cls = "Magical" },
		{ "Animated Feather (9860 exp, 19x)", 32494, 32592, 14, mon = "Animated Feather", cls = "Magical" },
		{ "Guardian of Tales (10600 exp, 11x)", 32675, 32710, 12, mon = "Guardian of Tales", cls = "Magical" },
		{ "Energetic Book (12034 exp, 24x)", 32443, 32775, 12, mon = "Energetic Book", cls = "Magical" },
		{ "Icecold Book (12750 exp, 22x)", 32475, 32560, 13, mon = "Icecold Book", cls = "Magical" },
		{ "Burning Book (13200 exp, 39x)", 32683, 32713, 12, mon = "Burning Book", cls = "Magical" },
		{ "Cursed Book (13345 exp, 12x)", 32608, 32541, 12, mon = "Cursed Book", cls = "Magical" },
		{ "Squid Warden (15300 exp, 17x)", 32492, 32594, 14, mon = "Squid Warden", cls = "Magical" },
		{ "Rage Squid (16300 exp, 47x)", 32641, 32653, 12, mon = "Rage Squid", cls = "Magical" },
		{ "Sight of Surrender (17000 exp, 9x)", 33550, 32348, 7, mon = "Sight of Surrender", cls = "Magical" },
		{ "Brain Squid (17672 exp, 11x)", 32533, 32767, 12, mon = "Brain Squid", cls = "Magical" },
		{ "Darklight Emitter (20600 exp, 46x)", 33842, 31879, 14, mon = "Darklight Emitter", cls = "Magical" },
		{ "Darklight Construct (22050 exp, 44x)", 33813, 31843, 14, mon = "Darklight Construct", cls = "Magical" },
		{ "Darklight Striker (22200 exp, 36x)", 34005, 31848, 14, mon = "Darklight Striker", cls = "Magical" },
		{ "Darklight Source (22465 exp, 17x)", 34005, 31848, 14, mon = "Darklight Source", cls = "Magical" },
		{ "Hyaena (20 exp, 14x)", 33006, 32657, 11, mon = "Hyaena", cls = "Mammal" },
		{ "Water Buffalo (20 exp, 15x)", 32920, 32185, 7, mon = "Water Buffalo", cls = "Mammal" },
		{ "Winter Wolf (20 exp, 33x)", 31980, 31281, 7, mon = "Winter Wolf", cls = "Mammal" },
		{ "Bear (23 exp, 13x)", 32149, 32047, 10, mon = "Bear", cls = "Mammal" },
		{ "Panda (23 exp, 21x)", 32627, 32852, 7, mon = "Panda", cls = "Mammal" },
		{ "Polar Bear (28 exp, 18x)", 32282, 31064, 7, mon = "Polar Bear", cls = "Mammal" },
		{ "Lion (30 exp, 12x)", 32691, 32138, 7, mon = "Lion", cls = "Mammal" },
		{ "Tiger (40 exp, 10x)", 32722, 32710, 7, mon = "Tiger", cls = "Mammal" },
		{ "War Wolf (55 exp, 18x)", 33423, 31563, 11, mon = "War Wolf", cls = "Mammal" },
		{ "Boar (60 exp, 17x)", 32601, 32262, 7, mon = "Boar", cls = "Mammal" },
		{ "Gnarlhound (60 exp, 26x)", 33050, 31514, 8, mon = "Gnarlhound", cls = "Mammal" },
		{ "Gloom Wolf (70 exp, 15x)", 32788, 31936, 10, mon = "Gloom Wolf", cls = "Mammal" },
		{ "Sibang (105 exp, 63x)", 32780, 32540, 7, mon = "Sibang", cls = "Mammal" },
		{ "Kongra (115 exp, 52x)", 32792, 32550, 7, mon = "Kongra", cls = "Mammal" },
		{ "Merlkin (145 exp, 26x)", 32836, 32533, 9, mon = "Merlkin", cls = "Mammal" },
		{ "Elephant (160 exp, 17x)", 32951, 32750, 7, mon = "Elephant", cls = "Mammal" },
		{ "Mammoth (160 exp, 38x)", 32140, 31289, 6, mon = "Mammoth", cls = "Mammal" },
		{ "Baleful Bunny (450 exp, 12x)", 33789, 31024, 7, mon = "Baleful Bunny", cls = "Mammal" },
		{ "Mutated Rat (450 exp, 36x)", 32213, 32707, 12, mon = "Mutated Rat", cls = "Mammal" },
		{ "Clomp (475 exp, 34x)", 33594, 31672, 7, mon = "Clomp", cls = "Mammal" },
		{ "Mutated Bat (750 exp, 30x)", 32323, 32612, 12, mon = "Mutated Bat", cls = "Mammal" },
		{ "Mutated Tiger (750 exp, 18x)", 33535, 31129, 8, mon = "Mutated Tiger", cls = "Mammal" },
		{ "Roaring Lion (800 exp, 19x)", 33145, 32335, 9, mon = "Roaring Lion", cls = "Mammal" },
		{ "Parder (1100 exp, 25x)", 33687, 32742, 7, mon = "Parder", cls = "Mammal" },
		{ "Vulcongra (1100 exp, 31x)", 32214, 32529, 15, mon = "Vulcongra", cls = "Mammal" },
		{ "Exotic Bat (1200 exp, 60x)", 33868, 31392, 8, mon = "Exotic Bat", cls = "Mammal" },
		{ "Stone Rhino (1800 exp, 9x)", 32896, 32858, 15, mon = "Stone Rhino", cls = "Mammal" },
		{ "White Lion (2300 exp, 15x)", 33130, 32321, 11, mon = "White Lion", cls = "Mammal" },
		{ "Sabretooth (11931 exp, 27x)", 33608, 32976, 14, mon = "Sabretooth", cls = "Mammal" },
		{ "Gore Horn (12595 exp, 52x)", 33605, 32975, 14, mon = "Gore Horn", cls = "Mammal" },
		{ "Nighthunter (12647 exp, 29x)", 33561, 32827, 14, mon = "Nighthunter", cls = "Mammal" },
		{ "Gorerilla (13172 exp, 40x)", 33591, 32903, 14, mon = "Gorerilla", cls = "Mammal" },
		{ "Spit Nettle (20 exp, 24x)", 32997, 32577, 7, mon = "Spit Nettle", cls = "Plant" },
		{ "Leaf Golem (45 exp, 49x)", 33266, 31993, 11, mon = "Leaf Golem", cls = "Plant" },
		{ "Swampling (45 exp, 9x)", 33325, 31952, 8, mon = "Swampling", cls = "Plant" },
		{ "Carniphila (150 exp, 33x)", 32950, 32524, 7, mon = "Carniphila", cls = "Plant" },
		{ "Wilting Leaf Golem (225 exp, 28x)", 33199, 31997, 11, mon = "Wilting Leaf Golem", cls = "Plant" },
		{ "Haunted Treeling (310 exp, 45x)", 32926, 31507, 7, mon = "Haunted Treeling", cls = "Plant" },
		{ "Bane Bringer (400 exp, 12x)", 32740, 31952, 13, mon = "Bane Bringer", cls = "Plant" },
		{ "Glooth Anemone (1755 exp, 38x)", 33646, 31954, 10, mon = "Glooth Anemone", cls = "Plant" },
		{ "Humongous Fungus (2900 exp, 51x)", 33044, 31958, 10, mon = "Humongous Fungus", cls = "Plant" },
		{ "Hideous Fungus (3700 exp, 50x)", 33044, 31958, 10, mon = "Hideous Fungus", cls = "Plant" },
		{ "Lavafungus (6200 exp, 16x)", 32126, 31448, 15, mon = "Lavafungus", cls = "Plant" },
		{ "Stalking Stalk (11569 exp, 31x)", 33669, 32841, 14, mon = "Stalking Stalk", cls = "Plant" },
		{ "Branchy Crawler (17860 exp, 31x)", 33969, 31036, 12, mon = "Branchy Crawler", cls = "Plant" },
		{ "Cloak of Terror (19700 exp, 26x)", 33835, 31885, 4, mon = "Cloak of Terror", cls = "Plant" },
		{ "Cobra (30 exp, 21x)", 32955, 32526, 7, mon = "Cobra", cls = "Reptile" },
		{ "Crocodile (40 exp, 32x)", 32611, 32677, 8, mon = "Crocodile", cls = "Reptile" },
		{ "Tortoise (90 exp, 74x)", 32465, 32939, 9, mon = "Tortoise", cls = "Reptile" },
		{ "Lizard Sentinel (110 exp, 62x)", 32919, 32871, 7, mon = "Lizard Sentinel", cls = "Reptile" },
		{ "Thornback Tortoise (150 exp, 71x)", 32373, 32961, 9, mon = "Thornback Tortoise", cls = "Reptile" },
		{ "Lizard Templar (155 exp, 62x)", 32920, 32871, 7, mon = "Lizard Templar", cls = "Reptile" },
		{ "Lizard Snakecharmer (210 exp, 17x)", 33306, 31506, 7, mon = "Lizard Snakecharmer", cls = "Reptile" },
		{ "Stonerefiner (500 exp, 39x)", 33059, 32005, 13, mon = "Stonerefiner", cls = "Reptile" },
		{ "Wyvern (515 exp, 18x)", 32849, 31803, 14, mon = "Wyvern", cls = "Reptile" },
		{ "Stampor (780 exp, 18x)", 32203, 30994, 12, mon = "Stampor", cls = "Reptile" },
		{ "Killer Caiman (900 exp, 29x)", 33277, 31161, 7, mon = "Killer Caiman", cls = "Reptile" },
		{ "Young Sea Serpent (1000 exp, 16x)", 31907, 31254, 9, mon = "Young Sea Serpent", cls = "Reptile" },
		{ "Lizard Legionnaire (1100 exp, 56x)", 33250, 31242, 7, mon = "Lizard Legionnaire", cls = "Reptile" },
		{ "Lizard Dragon Priest (1320 exp, 18x)", 33096, 31163, 6, mon = "Lizard Dragon Priest", cls = "Reptile" },
		{ "Lizard High Guard (1450 exp, 157x)", 33048, 31171, 7, mon = "Lizard High Guard", cls = "Reptile" },
		{ "Lizard Zaogun (1700 exp, 36x)", 33116, 31153, 6, mon = "Lizard Zaogun", cls = "Reptile" },
		{ "Lizard Noble (2000 exp, 12x)", 33080, 31212, 4, mon = "Lizard Noble", cls = "Reptile" },
		{ "Lizard Chosen (2200 exp, 51x)", 33275, 31177, 9, mon = "Lizard Chosen", cls = "Reptile" },
		{ "Sea Serpent (2300 exp, 30x)", 31898, 31021, 10, mon = "Sea Serpent", cls = "Reptile" },
		{ "Two-Headed Turtle (2930 exp, 66x)", 33766, 32776, 8, mon = "Two-Headed Turtle", cls = "Reptile" },
		{ "Serpent Spawn (3050 exp, 30x)", 32742, 32591, 12, mon = "Serpent Spawn", cls = "Reptile" },
		{ "Naga Archer (5150 exp, 31x)", 33656, 32753, 8, mon = "Naga Archer", cls = "Reptile" },
		{ "Naga Warrior (5890 exp, 55x)", 33657, 32753, 8, mon = "Naga Warrior", cls = "Reptile" },
		{ "Young Goanna (6100 exp, 31x)", 33903, 31600, 7, mon = "Young Goanna", cls = "Reptile" },
		{ "Adult Goanna (6650 exp, 37x)", 33900, 31580, 7, mon = "Adult Goanna", cls = "Reptile" },
		{ "Mantosaurus (11569 exp, 51x)", 33741, 32850, 14, mon = "Mantosaurus", cls = "Reptile" },
		{ "Mercurial Menace (12095 exp, 46x)", 33741, 32850, 14, mon = "Mercurial Menace", cls = "Reptile" },
		{ "Emerald Tortoise (12129 exp, 35x)", 33604, 32975, 14, mon = "Emerald Tortoise", cls = "Reptile" },
		{ "Noxious Ripptor (13190 exp, 50x)", 33738, 32880, 14, mon = "Noxious Ripptor", cls = "Reptile" },
		{ "Slime (160 exp, 35x)", 33393, 32790, 14, mon = "Slime", cls = "Slime" },
		{ "Mercury Blob (180 exp, 8x)", 32696, 31168, 6, mon = "Mercury Blob", cls = "Slime" },
		{ "Acid Blob (250 exp, 11x)", 32698, 31162, 6, mon = "Acid Blob", cls = "Slime" },
		{ "Death Blob (300 exp, 33x)", 33083, 31104, 9, mon = "Death Blob", cls = "Slime" },
		{ "Glooth Blob (700 exp, 61x)", 33559, 31902, 7, mon = "Glooth Blob", cls = "Slime" },
		{ "Devourer (1755 exp, 28x)", 33633, 31929, 9, mon = "Devourer", cls = "Slime" },
		{ "Defiler (3700 exp, 28x)", 33168, 31768, 12, mon = "Defiler", cls = "Slime" },
		{ "Son of Verminor (5900 exp, 11x)", 33196, 31670, 12, mon = "Son of Verminor", cls = "Slime" },
		{ "Meandering Mushroom (21980 exp, 43x)", 34084, 31712, 14, mon = "Meandering Mushroom", cls = "Slime" },
		{ "Darklight Matter (22250 exp, 31x)", 34017, 31915, 14, mon = "Darklight Matter", cls = "Slime" },
		{ "Skeleton (35 exp, 67x)", 32392, 31982, 9, mon = "Skeleton", cls = "Undead" },
		{ "Skeleton Warrior (45 exp, 13x)", 32973, 32441, 10, mon = "Skeleton Warrior", cls = "Undead" },
		{ "Ghost Wolf (65 exp, 11x)", 32789, 31936, 10, mon = "Ghost Wolf", cls = "Undead" },
		{ "Ghoul (85 exp, 41x)", 33383, 31667, 11, mon = "Ghoul", cls = "Undead" },
		{ "Pirate Skeleton (85 exp, 25x)", 32040, 32563, 7, mon = "Pirate Skeleton", cls = "Undead" },
		{ "Ghost (120 exp, 53x)", 33083, 32978, 14, mon = "Ghost", cls = "Undead" },
		{ "Tarnished Spirit (120 exp, 25x)", 33042, 32422, 8, mon = "Tarnished Spirit", cls = "Undead" },
		{ "White Shade (120 exp, 25x)", 32976, 32363, 11, mon = "White Shade", cls = "Undead" },
		{ "Mummy (150 exp, 43x)", 32205, 32672, 9, mon = "Mummy", cls = "Undead" },
		{ "Vampire Pig (165 exp, 10x)", 32751, 31483, 6, mon = "Vampire Pig", cls = "Undead" },
		{ "Crypt Shambler (195 exp, 43x)", 33375, 32762, 14, mon = "Crypt Shambler", cls = "Undead" },
		{ "Ghoulish Hyaena (195 exp, 11x)", 33000, 32759, 8, mon = "Ghoulish Hyaena", cls = "Undead" },
		{ "Tomb Servant (215 exp, 19x)", 32949, 32761, 10, mon = "Tomb Servant", cls = "Undead" },
		{ "Demon Skeleton (240 exp, 37x)", 33002, 32412, 11, mon = "Demon Skeleton", cls = "Undead" },
		{ "Zombie (280 exp, 70x)", 32188, 32966, 10, mon = "Zombie", cls = "Undead" },
		{ "Vampire (305 exp, 37x)", 33094, 32916, 14, mon = "Vampire", cls = "Undead" },
		{ "Grave Guard (485 exp, 13x)", 32960, 32754, 11, mon = "Grave Guard", cls = "Undead" },
		{ "Elder Mummy (560 exp, 14x)", 32938, 32773, 12, mon = "Elder Mummy", cls = "Undead" },
		{ "Bonebeast (580 exp, 29x)", 33423, 32263, 11, mon = "Bonebeast", cls = "Undead" },
		{ "Death Priest (750 exp, 14x)", 32942, 32773, 12, mon = "Death Priest", cls = "Undead" },
		{ "Rot Elemental (750 exp, 36x)", 33561, 31905, 7, mon = "Rot Elemental", cls = "Undead" },
		{ "Undead Gladiator (800 exp, 22x)", 33599, 31603, 8, mon = "Undead Gladiator", cls = "Undead" },
		{ "Vampire Viscount (800 exp, 23x)", 32977, 31612, 11, mon = "Vampire Viscount", cls = "Undead" },
		{ "Banshee (900 exp, 17x)", 32999, 32427, 14, mon = "Banshee", cls = "Undead" },
		{ "Lich (900 exp, 17x)", 33097, 31782, 15, mon = "Lich", cls = "Undead" },
		{ "Putrid Mummy (900 exp, 23x)", 33422, 32310, 12, mon = "Putrid Mummy", cls = "Undead" },
		{ "Gravedigger (950 exp, 13x)", 33003, 32413, 11, mon = "Gravedigger", cls = "Undead" },
		{ "Iks Pututu (980 exp, 30x)", 34058, 31861, 9, mon = "Iks Pututu", cls = "Undead" },
		{ "Braindeath (985 exp, 15x)", 32817, 32428, 12, mon = "Braindeath", cls = "Undead" },
		{ "Blood Beast (1000 exp, 32x)", 33575, 32041, 7, mon = "Blood Beast", cls = "Undead" },
		{ "Iks Chuka (1050 exp, 44x)", 34030, 31855, 8, mon = "Iks Chuka", cls = "Undead" },
		{ "Vampire Bride (1050 exp, 17x)", 32939, 32420, 14, mon = "Vampire Bride", cls = "Undead" },
		{ "Iks Aucar (1150 exp, 31x)", 34061, 31855, 9, mon = "Iks Aucar", cls = "Undead" },
		{ "Vicious Manbat (1200 exp, 13x)", 32943, 32424, 14, mon = "Vicious Manbat", cls = "Undead" },
		{ "Souleater (1300 exp, 129x)", 32864, 32446, 12, mon = "Souleater", cls = "Undead" },
		{ "Cursed Ape (1860 exp, 9x)", 34019, 31768, 10, mon = "Cursed Ape", cls = "Undead" },
		{ "Spectre (2100 exp, 29x)", 33085, 31770, 13, mon = "Spectre", cls = "Undead" },
		{ "Betrayed Wraith (3500 exp, 26x)", 33109, 31590, 11, mon = "Betrayed Wraith", cls = "Undead" },
		{ "Ripper Spectre (3500 exp, 27x)", 32706, 32247, 10, mon = "Ripper Spectre", cls = "Undead" },
		{ "Lost Soul (4000 exp, 27x)", 33109, 31590, 11, mon = "Lost Soul", cls = "Undead" },
		{ "Gazer Spectre (4200 exp, 27x)", 32678, 32655, 8, mon = "Gazer Spectre", cls = "Undead" },
		{ "Flimsy Lost Soul (4500 exp, 65x)", 33599, 31496, 10, mon = "Flimsy Lost Soul", cls = "Undead" },
		{ "Skeleton Elite Warrior (4800 exp, 37x)", 32936, 32269, 10, mon = "Skeleton Elite Warrior", cls = "Undead" },
		{ "Hand of Cursed Fate (5000 exp, 12x)", 33477, 32808, 9, mon = "Hand of Cursed Fate", cls = "Undead" },
		{ "Undead Elite Gladiator (5090 exp, 23x)", 32938, 32269, 10, mon = "Undead Elite Gladiator", cls = "Undead" },
		{ "Cursed Prospector (5250 exp, 104x)", 33836, 31830, 9, mon = "Cursed Prospector", cls = "Undead" },
		{ "Grim Reaper (5500 exp, 49x)", 33543, 31725, 8, mon = "Grim Reaper", cls = "Undead" },
		{ "Mean Lost Soul (5580 exp, 41x)", 33593, 31450, 10, mon = "Mean Lost Soul", cls = "Undead" },
		{ "Burster Spectre (6000 exp, 53x)", 33085, 32310, 8, mon = "Burster Spectre", cls = "Undead" },
		{ "Falcon Knight (6300 exp, 25x)", 33310, 31287, 8, mon = "Falcon Knight", cls = "Undead" },
		{ "Blightwalker (6400 exp, 29x)", 33404, 32374, 13, mon = "Blightwalker", cls = "Undead" },
		{ "Falcon Paladin (6900 exp, 22x)", 33296, 31318, 9, mon = "Falcon Paladin", cls = "Undead" },
		{ "Freakish Lost Soul (7020 exp, 29x)", 31950, 32300, 10, mon = "Freakish Lost Soul", cls = "Undead" },
		{ "Undead Dragon (7500 exp, 36x)", 33416, 32363, 13, mon = "Undead Dragon", cls = "Undead" },
		{ "Evil Prospector (9000 exp, 86x)", 33835, 31830, 9, mon = "Evil Prospector", cls = "Undead" },
		{ "Infernal Phantom (15770 exp, 31x)", 34006, 31069, 9, mon = "Infernal Phantom", cls = "Undead" },
		{ "Mould Phantom (18330 exp, 59x)", 33935, 31039, 13, mon = "Mould Phantom", cls = "Undead" },
		{ "Distorted Phantom (18870 exp, 22x)", 33937, 31189, 13, mon = "Distorted Phantom", cls = "Undead" },
		{ "Capricious Phantom (19360 exp, 53x)", 33941, 31021, 9, mon = "Capricious Phantom", cls = "Undead" },
		{ "Bony Sea Devil (19470 exp, 55x)", 33939, 31076, 9, mon = "Bony Sea Devil", cls = "Undead" },
		{ "Vibrant Phantom (19700 exp, 25x)", 33832, 31845, 3, mon = "Vibrant Phantom", cls = "Undead" },
		{ "Oozing Corpus (20600 exp, 35x)", 33820, 31743, 14, mon = "Oozing Corpus", cls = "Undead" },
		{ "Oozing Carcass (20980 exp, 45x)", 34083, 31712, 14, mon = "Oozing Carcass", cls = "Undead" },
		{ "Sopping Corpus (22465 exp, 12x)", 33901, 31694, 15, mon = "Sopping Corpus", cls = "Undead" },
		{ "Sopping Carcass (23425 exp, 57x)", 34020, 31740, 14, mon = "Sopping Carcass", cls = "Undead" },
		{ "Sandcrawler (20 exp, 37x)", 33092, 31506, 7, mon = "Sandcrawler", cls = "Vermin" },
		{ "Poison Spider (22 exp, 26x)", 32816, 32912, 8, mon = "Poison Spider", cls = "Vermin" },
		{ "Wasp (24 exp, 31x)", 32420, 32302, 9, mon = "Wasp", cls = "Vermin" },
		{ "Centipede (34 exp, 35x)", 32235, 32774, 9, mon = "Centipede", cls = "Vermin" },
		{ "Emerald Damselfly (35 exp, 26x)", 32846, 32098, 10, mon = "Emerald Damselfly", cls = "Vermin" },
		{ "Insect Swarm (40 exp, 13x)", 33208, 31386, 7, mon = "Insect Swarm", cls = "Vermin" },
		{ "Rotworm (40 exp, 81x)", 32251, 32814, 9, mon = "Rotworm", cls = "Vermin" },
		{ "Larva (44 exp, 130x)", 33223, 32607, 9, mon = "Larva", cls = "Vermin" },
		{ "Scorpion (45 exp, 29x)", 32242, 31923, 11, mon = "Scorpion", cls = "Vermin" },
		{ "Carrion Worm (70 exp, 35x)", 32235, 32711, 10, mon = "Carrion Worm", cls = "Vermin" },
		{ "Ladybug (70 exp, 35x)", 33544, 31277, 7, mon = "Ladybug", cls = "Vermin" },
		{ "Slug (70 exp, 15x)", 32928, 32126, 9, mon = "Slug", cls = "Vermin" },
		{ "Scarab (120 exp, 94x)", 33163, 32528, 10, mon = "Scarab", cls = "Vermin" },
		{ "Tarantula (120 exp, 41x)", 32877, 32907, 9, mon = "Tarantula", cls = "Vermin" },
		{ "Terramite (160 exp, 54x)", 33200, 32451, 9, mon = "Terramite", cls = "Vermin" },
		{ "Lancer Beetle (275 exp, 30x)", 33252, 31379, 8, mon = "Lancer Beetle", cls = "Vermin" },
		{ "Sacred Spider (330 exp, 16x)", 32941, 32732, 10, mon = "Sacred Spider", cls = "Vermin" },
		{ "Swarmer (350 exp, 56x)", 33552, 31265, 7, mon = "Swarmer", cls = "Vermin" },
		{ "Wailing Widow (450 exp, 46x)", 33674, 31740, 8, mon = "Wailing Widow", cls = "Vermin" },
		{ "Insectoid Worker (650 exp, 59x)", 33551, 31232, 7, mon = "Insectoid Worker", cls = "Vermin" },
		{ "Ancient Scarab (720 exp, 31x)", 33335, 32640, 12, mon = "Ancient Scarab", cls = "Vermin" },
		{ "Waspoid (830 exp, 54x)", 33543, 31240, 7, mon = "Waspoid", cls = "Vermin" },
		{ "Brimstone Bug (900 exp, 32x)", 33146, 31098, 7, mon = "Brimstone Bug", cls = "Vermin" },
		{ "Giant Spider (900 exp, 41x)", 32938, 32878, 10, mon = "Giant Spider", cls = "Vermin" },
		{ "Wiggler (900 exp, 39x)", 32920, 31892, 11, mon = "Wiggler", cls = "Vermin" },
		{ "Crawler (1000 exp, 41x)", 33546, 31235, 7, mon = "Crawler", cls = "Vermin" },
		{ "Spitter (1100 exp, 41x)", 33581, 31229, 5, mon = "Spitter", cls = "Vermin" },
		{ "Drillworm (1200 exp, 29x)", 32257, 32574, 13, mon = "Drillworm", cls = "Vermin" },
		{ "Exotic Cave Spider (1400 exp, 24x)", 33829, 31381, 8, mon = "Exotic Cave Spider", cls = "Vermin" },
		{ "Kollos (2400 exp, 20x)", 33592, 31224, 2, mon = "Kollos", cls = "Vermin" },
		{ "Deepworm (2520 exp, 56x)", 33278, 32315, 15, mon = "Deepworm", cls = "Vermin" },
		{ "Spidris (2600 exp, 26x)", 33521, 31203, 1, mon = "Spidris", cls = "Vermin" },
		{ "Diremaw (2770 exp, 92x)", 33278, 32316, 15, mon = "Diremaw", cls = "Vermin" },
		{ "Cave Devourer (3380 exp, 33x)", 33289, 32174, 15, mon = "Cave Devourer", cls = "Vermin" },
		{ "Chasm Spawn (3600 exp, 59x)", 33461, 32252, 15, mon = "Chasm Spawn", cls = "Vermin" },
		{ "Spidris Elite (4000 exp, 20x)", 33437, 31273, 8, mon = "Spidris Elite", cls = "Vermin" },
		{ "Tunnel Tyrant (4420 exp, 34x)", 33288, 32176, 15, mon = "Tunnel Tyrant", cls = "Vermin" },
		{ "Blemished Spawn (5300 exp, 33x)", 32626, 31796, 10, mon = "Blemished Spawn", cls = "Vermin" },
		{ "Afflicted Strider (5700 exp, 11x)", 32632, 31791, 10, mon = "Afflicted Strider", cls = "Vermin" },
		{ "Varnished Diremaw (5900 exp, 14x)", 32048, 31456, 14, mon = "Varnished Diremaw", cls = "Vermin" },
		{ "Eyeless Devourer (6000 exp, 32x)", 32642, 31780, 10, mon = "Eyeless Devourer", cls = "Vermin" },
		{ "Tremendous Tyrant (6100 exp, 11x)", 32064, 31464, 11, mon = "Tremendous Tyrant", cls = "Vermin" },
		{ "Streaked Devourer (6300 exp, 13x)", 32128, 31445, 15, mon = "Streaked Devourer", cls = "Vermin" },
		{ "Lavaworm (6500 exp, 17x)", 32126, 31447, 15, mon = "Lavaworm", cls = "Vermin" },
		{ "Cave Chimera (6800 exp, 14x)", 32059, 31443, 13, mon = "Cave Chimera", cls = "Vermin" },
		{ "Sulphider (13328 exp, 31x)", 33593, 32852, 14, mon = "Sulphider", cls = "Vermin" },
		{ "Undertaker (13543 exp, 45x)", 33561, 32827, 14, mon = "Undertaker", cls = "Vermin" },
		{ "Mycobiontic Beetle (21175 exp, 62x)", 33820, 31743, 14, mon = "Mycobiontic Beetle", cls = "Vermin" },
		{ "Bloated Man-Maggot (21570 exp, 39x)", 33820, 31744, 14, mon = "Bloated Man-Maggot", cls = "Vermin" },
		{ "Rotten Man-Maggot (22625 exp, 14x)", 34060, 31722, 15, mon = "Rotten Man-Maggot", cls = "Vermin" },
	} },
	{ label = "Exp Low", list = {
		{ "Rotworm 1 (40 exp, 81x)", 32251, 32814, 9, mon = "Rotworm" },
		{ "Rotworm 2 (40 exp, 74x)", 32271, 32789, 8, mon = "Rotworm" },
		{ "Rotworm 3 (40 exp, 72x)", 32115, 32345, 9, mon = "Rotworm" },
		{ "Cyclops 1 (150 exp, 45x)", 32485, 32058, 8, mon = "Cyclops" },
		{ "Cyclops 2 (150 exp, 33x)", 33278, 31683, 8, mon = "Cyclops" },
		{ "Cyclops 3 (150 exp, 30x)", 32568, 31450, 4, mon = "Cyclops" },
		{ "Dragon 1 (700 exp, 55x)", 33214, 31252, 7, mon = "Dragon" },
		{ "Dragon 2 (700 exp, 34x)", 33072, 32647, 7, mon = "Dragon" },
		{ "Dragon 3 (700 exp, 33x)", 32699, 31266, 11, mon = "Dragon" },
		{ "Dragon Lord 1 (2100 exp, 55x)", 33223, 31277, 5, mon = "Dragon Lord" },
		{ "Dragon Lord 2 (2100 exp, 30x)", 32788, 32336, 12, mon = "Dragon Lord" },
	} },
	{ label = "Exp Medium", list = {
		{ "Wyrm 1 (1550 exp, 42x)", 33080, 32392, 14, mon = "Wyrm" },
		{ "Wyrm 2 (1550 exp, 29x)", 32177, 32598, 15, mon = "Wyrm" },
		{ "Wyrm 3 (1550 exp, 23x)", 32390, 32834, 9, mon = "Wyrm" },
		{ "Midnight Asura 1 (4100 exp, 57x)", 32814, 32755, 9, mon = "Midnight Asura" },
		{ "Midnight Asura 2 (4100 exp, 18x)", 32815, 32734, 10, mon = "Midnight Asura" },
		{ "Frost Flower Asura (4200 exp, 16x)", 32825, 32798, 9, mon = "Frost Flower Asura" },
		{ "Dark Torturer 1 (4650 exp, 60x)", 33600, 32381, 10, mon = "Dark Torturer" },
		{ "Dark Torturer 2 (4650 exp, 58x)", 33477, 32702, 14, mon = "Dark Torturer" },
		{ "Dark Torturer 3 (4650 exp, 36x)", 33507, 31790, 8, mon = "Dark Torturer" },
		{ "Grim Reaper 1 (5500 exp, 49x)", 33543, 31725, 8, mon = "Grim Reaper" },
		{ "Grim Reaper 2 (5500 exp, 46x)", 31109, 32681, 8, mon = "Grim Reaper" },
		{ "Grim Reaper 3 (5500 exp, 45x)", 31302, 32680, 8, mon = "Grim Reaper" },
		{ "Frazzlemaw 1 (3740 exp, 45x)", 33640, 32440, 7, mon = "Frazzlemaw" },
		{ "Frazzlemaw 2 (3740 exp, 22x)", 33523, 32529, 6, mon = "Frazzlemaw" },
		{ "Guzzlemaw (6050 exp, 53x)", 33628, 32458, 7, mon = "Guzzlemaw" },
	} },
	{ label = "Exp High", list = {
		{ "Demon 1 (6000 exp, 49x)", 33510, 31790, 8, mon = "Demon" },
		{ "Demon 2 (6000 exp, 39x)", 33512, 32081, 10, mon = "Demon" },
		{ "Demon 3 (6000 exp, 18x)", 33156, 31782, 15, mon = "Demon" },
		{ "Cobra Assassin 1 (6980 exp, 37x)", 33377, 32789, 8, mon = "Cobra Assassin" },
		{ "Cobra Assassin 2 (6980 exp, 15x)", 33393, 32683, 7, mon = "Cobra Assassin" },
		{ "Cobra Scout (7310 exp, 16x)", 33403, 32647, 5, mon = "Cobra Scout" },
		{ "Falcon Knight 1 (6300 exp, 25x)", 33310, 31287, 8, mon = "Falcon Knight" },
		{ "Falcon Knight 2 (6300 exp, 25x)", 33293, 31290, 9, mon = "Falcon Knight" },
		{ "Falcon Paladin 1 (6900 exp, 22x)", 33296, 31318, 9, mon = "Falcon Paladin" },
		{ "Falcon Paladin 2 (6900 exp, 20x)", 33323, 31296, 8, mon = "Falcon Paladin" },
		{ "Grimeleech 1 (7216 exp, 43x)", 33657, 32636, 10, mon = "Grimeleech" },
		{ "Grimeleech 2 (7216 exp, 39x)", 33196, 31450, 13, mon = "Grimeleech" },
		{ "Vexclaw 1 (6248 exp, 44x)", 33476, 32703, 14, mon = "Vexclaw" },
		{ "Vexclaw 2 (6248 exp, 35x)", 33484, 32703, 13, mon = "Vexclaw" },
		{ "Juggernaut (11200 exp, 23x)", 33430, 32428, 15, mon = "Juggernaut" },
		{ "Undead Dragon 1 (7500 exp, 36x)", 33416, 32363, 13, mon = "Undead Dragon" },
		{ "Undead Dragon 2 (7500 exp, 27x)", 33425, 32338, 11, mon = "Undead Dragon" },
		{ "Crypt Warden (8400 exp, 45x)", 33877, 31448, 9, mon = "Crypt Warden" },
		{ "Hellhunter Inferniarch 1 (8100 exp, 87x)", 33844, 32361, 8, mon = "Hellhunter Inferniarch" },
		{ "Hellhunter Inferniarch 2 (8100 exp, 75x)", 33832, 32309, 9, mon = "Hellhunter Inferniarch" },
		{ "Spellreaper Inferniarch 1 (8350 exp, 108x)", 33851, 32301, 10, mon = "Spellreaper Inferniarch" },
		{ "Spellreaper Inferniarch 2 (8350 exp, 86x)", 33786, 32327, 9, mon = "Spellreaper Inferniarch" },
		{ "Sphinx (7500 exp, 13x)", 33823, 31476, 7, mon = "Sphinx" },
		{ "Sulphur Spouter (11517 exp, 56x)", 33636, 32800, 14, mon = "Sulphur Spouter" },
		{ "Mantosaurus (11569 exp, 51x)", 33741, 32850, 14, mon = "Mantosaurus" },
		{ "Gore Horn (12595 exp, 52x)", 33605, 32975, 14, mon = "Gore Horn" },
		{ "Noxious Ripptor (13190 exp, 50x)", 33738, 32880, 14, mon = "Noxious Ripptor" },
		{ "Hulking Prehemoth (12690 exp, 50x)", 33591, 32904, 14, mon = "Hulking Prehemoth" },
		{ "Turbulent Elemental 1 (19360 exp, 64x)", 33940, 31021, 9, mon = "Turbulent Elemental" },
		{ "Turbulent Elemental 2 (19360 exp, 29x)", 33903, 31083, 8, mon = "Turbulent Elemental" },
		{ "Capricious Phantom (19360 exp, 13x)", 33906, 31116, 8, mon = "Capricious Phantom" },
		{ "Bony Sea Devil (19470 exp, 55x)", 33939, 31076, 9, mon = "Bony Sea Devil" },
		{ "Brachiodemon 1 (15770 exp, 50x)", 34014, 31062, 9, mon = "Brachiodemon" },
		{ "Brachiodemon 2 (15770 exp, 44x)", 34006, 31056, 11, mon = "Brachiodemon" },
		{ "Infernal Demon (17430 exp, 41x)", 34015, 31056, 10, mon = "Infernal Demon" },
		{ "Mycobiontic Beetle 1 (21175 exp, 62x)", 33820, 31743, 14, mon = "Mycobiontic Beetle" },
		{ "Mycobiontic Beetle 2 (21175 exp, 13x)", 33858, 31690, 15, mon = "Mycobiontic Beetle" },
		{ "Walking Pillar (24300 exp, 47x)", 34005, 31848, 14, mon = "Walking Pillar" },
		{ "Meandering Mushroom 1 (21980 exp, 43x)", 34084, 31712, 14, mon = "Meandering Mushroom" },
		{ "Meandering Mushroom 2 (21980 exp, 12x)", 34055, 31695, 15, mon = "Meandering Mushroom" },
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
	{ "Sister Hetai (arena, HP 25000)", 0, 0, 0, arena = { { "Sister Hetai", 1 } } },
	{ "Thawing Dragon Lord (arena, HP 25000)", 0, 0, 0, arena = { { "Thawing Dragon Lord", 1 } } },
	{ "The Welter (arena, HP 25000)", 0, 0, 0, arena = { { "The Welter", 1 } } },
	{ "World Devourer (arena, HP 25000)", 0, 0, 0, arena = { { "World Devourer", 1 } } },
	{ "Amenef the Burning (arena, HP 26000)", 0, 0, 0, arena = { { "Amenef the Burning", 1 } } },
	{ "Mozradek (arena, HP 28000)", 0, 0, 0, arena = { { "Mozradek", 1 } } },
	{ "Neferi the Spy (arena, HP 28000)", 0, 0, 0, arena = { { "Neferi the Spy", 1 } } },
	{ "Unaz the Mean (arena, HP 28000)", 0, 0, 0, arena = { { "Unaz the Mean", 1 } } },
	{ "Xogixath (arena, HP 28000)", 0, 0, 0, arena = { { "Xogixath", 1 } } },
	{ "Tanjis (arena, HP 30000)", 0, 0, 0, arena = { { "Tanjis", 1 } } },
	{ "Massacre (arena, HP 32000)", 0, 0, 0, arena = { { "Massacre", 1 } } },
	{ "Vok the Freakish (arena, HP 32000)", 0, 0, 0, arena = { { "Vok the Freakish", 1 } } },
	{ "Obujos (arena, HP 35000)", 0, 0, 0, arena = { { "Obujos", 1 } } },
	{ "Bragrumol (arena, HP 38000)", 0, 0, 0, arena = { { "Bragrumol", 1 } } },
	{ "Mawhawk (arena, HP 45000)", 0, 0, 0, arena = { { "Mawhawk", 1 } } },
	{ "Zulazza the Corruptor (arena, HP 46500)", 0, 0, 0, arena = { { "Zulazza the Corruptor", 1 } } },
	{ "Custodian (arena, HP 47000)", 0, 0, 0, arena = { { "Custodian", 1 } } },
	{ "The Pale Count (arena, HP 50000)", 0, 0, 0, arena = { { "The Pale Count", 1 } } },
	{ "Lisa (arena, HP 55000)", 0, 0, 0, arena = { { "Lisa", 1 } } },
	{ "Morgaroth (arena, HP 55000)", 0, 0, 0, arena = { { "Morgaroth", 1 } } },
	{ "Glooth Fairy (arena, HP 59000)", 0, 0, 0, arena = { { "Glooth Fairy", 1 } } },
	{ "The Armored Voidborn (arena, HP 60000)", 0, 0, 0, arena = { { "The Armored Voidborn", 1 } } },
	{ "Bullwark (arena, HP 72000)", 0, 0, 0, arena = { { "Bullwark", 1 } } },
	{ "Brain Head (arena, HP 75000)", 0, 0, 0, arena = { { "Brain Head", 1 } } },
	{ "Ghazbaran (arena, HP 77000)", 0, 0, 0, arena = { { "Ghazbaran", 1 } } },
	{ "Drume (arena, HP 80000)", 0, 0, 0, arena = { { "Drume", 1 } } },
	{ "Ferumbras (arena, HP 90000)", 0, 0, 0, arena = { { "Ferumbras", 1 } } },
	{ "Jaul (arena, HP 90000)", 0, 0, 0, arena = { { "Jaul", 1 } } },
	{ "Urmahlullu the Weakened (arena, HP 100000)", 0, 0, 0, arena = { { "Urmahlullu the Weakened", 1 } } },
	{ "Realityquake (arena, HP 110000)", 0, 0, 0, arena = { { "Realityquake", 1 } } },
	{ "Deathstrike (arena, HP 200000)", 0, 0, 0, arena = { { "Deathstrike", 1 } } },
	{ "Gnomevil (arena, HP 250000)", 0, 0, 0, arena = { { "Gnomevil", 1 } } },
	{ "Omrafir (arena, HP 322000)", 0, 0, 0, arena = { { "Omrafir", 1 } } },
	{ "Abyssador (arena, HP 340000)", 0, 0, 0, arena = { { "Abyssador", 1 } } },
	{ "The Rootkraken (arena, HP 360000)", 0, 0, 0, arena = { { "The Rootkraken", 1 } } },
	{ "The Monster (arena, HP 450000)", 0, 0, 0, arena = { { "The Monster", 1 } } },
	{ "The Abomination (arena, HP 750000)", 0, 0, 0, arena = { { "The Abomination", 1 } } },
	{ "Ancient Spawn of Morgathla (arena, HP 900000)", 0, 0, 0, arena = { { "Ancient Spawn of Morgathla", 1 } } },
	{ "Morshabaal (arena, HP 1000000)", 0, 0, 0, arena = { { "Morshabaal", 1 } } },
}

local quests = {
	{ "Pits of Inferno: soft boots, avenger, arcane staff, arbalest", func = "OtsPoiStart", done = { st = { { "Storage.Quest.U7_9.ThePitsOfInferno.ThroneAshfalor" }, { "9248" }, { "9249" }, { "9250" } } } },
	{ "Barbarian Arena: bron do wyboru (3 poziomy, 10 walk)", func = "OtsArenaStart", done = { st = { { "Storage.Quest.U8_0.BarbarianArena.Arena", 4 } } } },
	{ "In Service of Yalahar: yalahari armor / mask / leg piece / footwraps", func = "OtsYalaharStart", done = { st = { { "Storage.Quest.U8_4.InServiceOfYalahar.Questline", 54 } } } },
	{ "Soul War: 6 bossow po kolei, nagroda: komplet Soul War dla Twojej profesji", func = "OtsSoulWarStart", done = { fn = { "OtsSoulWarDone" } } },
	{ "Demon Helmet: steel boots, demon helmet, demon shield", 33324, 31575, 15, done = { st = { { "Storage.Quest.U6_4.DemonHelmet.Rewards.DemonHelmet" }, { "Storage.Quest.U6_4.DemonHelmet.Rewards.DemonShield" }, { "Storage.Quest.U6_4.DemonHelmet.Rewards.SteelBoots" } } }, hint = "Pokonaj potwory w sali, pociagnij dzwignie po wschodniej stronie. Skrzynie sa na zachodzie, za kamieniem (pole PZ)." },
	{ "The Annihilator: demon armor, magic sword, stonecutter axe", 33224, 31671, 13, plain = true, done = { st = { { "Storage.Quest.U7_24.TheAnnihilator.Reward" } } }, hint = "Stan na jednym z czterech pol przy dzwigni i pociagnij ja. Wymagany poziom 100. Skrzynie sa na wschod od sali walki (pola PZ)." },
	{ "Wrath of the Emperor: royal scale robe, royal draken mail, elite draken helmet", 0, 0, 0, arena = { { "Draken Elite", 4 }, { "Draken Abomination", 4 }, { "Draken Warmaster", 4 }, { "Draken Spellweaver", 4 }, { "Draken Elite", 2 } }, chest = { 33073, 31170, 8 }, done = { st = { { "Storage.Quest.U8_6.WrathOfTheEmperor.Chest100PlatinumCoins" }, { "Storage.Quest.U8_6.WrathOfTheEmperor.ChestBag" }, { "Storage.Quest.U8_6.WrathOfTheEmperor.ChestItems" } } }, hint = "Skrzynia z nagroda jest tuz obok. Skrzynie stoja obok siebie; zbroje sa w kolejnych skrzyniach." },
	{ "The Thieves Guild: modified crossbow, assassin dagger, spellbook of warding", 0, 0, 0, arena = { { "Assassin", 6 }, { "Stalker", 4 }, { "Bandit", 4 }, { "Smuggler", 4 }, { "Assassin", 4 } }, chest = { 32310, 32209, 8 }, done = { st = { { "Storage.Quest.U8_2.TheThievesGuildQuest.RewardEnd" } } }, hint = "Skrzynia z nagroda jest tuz obok. Trzy skrzynie, mozna wziac jedna nagrode." },
	{ "The Hidden City of Beregar: firewalker boots", 0, 0, 0, arena = { { "Dwarf Guard", 6 }, { "Dwarf Geomancer", 4 }, { "Worker Golem", 4 }, { "War Golem", 5 } }, chest = { 32580, 31404, 15 }, done = { st = { { "Storage.Quest.U8_4.TheHiddenCityOfBeregar.FirewalkerBoots" } } }, hint = "Skrzynia z nagroda jest tuz obok." },
	{ "Koshei the Deathless: blue legs", 0, 0, 0, arena = { { "Lich", 4 }, { "Bonebeast", 5 }, { "Vampire", 5 }, { "Mummy", 5 }, { "Koshei the Deathless", 1 } }, chest = { 33261, 32445, 12 }, done = { st = { { "Storage.Quest.U8_1.KosheiTheDeathless.KosheiTheDeathlessLegs" } } }, hint = "Skrzynia z nagroda jest tuz obok." },
	{ "The Inquisition: 6 bossow pod rzad, jedna z 9 nagrod do wyboru", 33158, 31728, 11, hint = "Zabij bossa i wejdz w teleport w jego sali - prowadzi do nastepnego. Kolejnosc: Ushuriel, Zugurosh, Madareth, Latrivan i Golgordan, Annihilon, Hellgorak. Po kazdym masz 10 minut na przejscie.", done = { st = { { "Storage.Quest.U8_2.TheInquisitionQuest.Reward" } } } },
	{ "The Demon Oak: demon legs / rainbow shield / thorn spitter / spellbook of ancient arcana (jedna do wyboru)", func = "OtsDemonOakStart", done = { st = { { "Storage.Quest.U8_2.TheDemonOak.Done", 2 } } } },
	{ "Swiateczna arena: christmas tokeny z potworow", 0, 0, 0, arena = { { "Grynch Clan Goblin", 8 }, { "Animated Snowman", 6 }, { "Percht", 6 }, { "Schiach", 6 }, { "Baleful Bunny", 4 }, { "The Percht Queen", 1 } } },
	{ "Behemoth Quest: guardian halberd, demon shield, golden armor", 33294, 31670, 13, done = { kv = { "behemothquest1", "behemothquest2", "behemothquest3", "behemothquest4" } }, hint = "Skrzynia z nagroda: ok. 11 krokow, kierunek polnoc. Przy skrzyni jest strefa PZ.", unlock = { 33286, 31650, 33303, 31678, 13 } },
	{ "Black Knight: crown armor, crown shield", 32870, 31943, 11, done = { kv = { "Blackknight1", "Blackknight2" } }, hint = "Skrzynia z nagroda: ok. 11 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ.", unlock = { 32860, 31935, 32878, 31962, 11 } },
	{ "Circle Room: war hammer", 32496, 31946, 14, done = { kv = { "circleroom1", "circleroom2" } }, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ.", unlock = { 32487, 31938, 32504, 32000, 14 } },
	{ "Crusader Helmet: crusader helmet", 32456, 31938, 14, done = { kv = { "crusaderhelmet" } }, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek zachod. Przy skrzyni jest strefa PZ.", unlock = { 32419, 31930, 32464, 31951, 14 } },
	{ "Deeper Fibula: tower shield, warrior helmet", 32239, 32471, 10, done = { kv = { "deeperfibula1", "deeperfibula2" } }, hint = "Skrot: teleport prosto pod skrzynie z nagroda (pole PZ).", unlock = { 32231, 32463, 32247, 32479, 10 } },
	{ "Devil Helmet: devil helmet", 32450, 32150, 15, done = { kv = { "devilhemet1", "devilhemet2", "devilhemet3" } }, hint = "Skrzynia z nagroda: ok. 13 krokow, kierunek polnocny wschod. Przy skrzyni jest strefa PZ.", unlock = { 32442, 32136, 32467, 32158, 15 } },
	{ "Draconia: ice rapier", 32800, 31589, 2, done = { kv = { "draconia1", "draconia2" } }, hint = "Skrzynia z nagroda: ok. 6 krokow, kierunek polnoc. Przy skrzyni jest strefa PZ.", unlock = { 32792, 31574, 32811, 31597, 2 } },
	{ "Noble Armor: crown helmet", 32451, 32042, 8, done = { kv = { "noblearmor1", "noblearmor2" } }, hint = "Skrzynia z nagroda: ok. 5 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ.", unlock = { 32443, 32034, 32459, 32056, 8 } },
	{ "Orc Fortress: knight armor", 32974, 31769, 9, done = { kv = { "orcfortress1", "orcfortress2", "orcfortress3" } }, hint = "Skrzynia z nagroda: ok. 45 krokow, kierunek polnoc. Przy skrzyni jest strefa PZ.", unlock = { 32966, 31719, 32988, 31777, 9 } },
	{ "The Medusa Quest: medusa shield, blue robe", 33031, 32396, 10, done = { st = { { "Storage.Quest.U7_3.TheMedusaQuest" } } }, hint = "Skrzynia z nagroda: ok. 17 krokow, kierunek wschod. Przy skrzyni jest strefa PZ.", unlock = { 33023, 32388, 33056, 32406, 10 } },
	{ "The Queen Of The Banshees: tower shield, boots of haste, giant sword", 32213, 31897, 15, done = { st = { { "Storage.Quest.U7_2.TheQueenOfTheBanshees.Reward.BootsOfHaste" }, { "Storage.Quest.U7_2.TheQueenOfTheBanshees.Reward.GiantSword" }, { "Storage.Quest.U7_2.TheQueenOfTheBanshees.Reward.PlatinumCoin" }, { "Storage.Quest.U7_2.TheQueenOfTheBanshees.Reward.StealthRing" }, { "Storage.Quest.U7_2.TheQueenOfTheBanshees.Reward.StoneSkinAmulet" }, { "Storage.Quest.U7_2.TheQueenOfTheBanshees.Reward.TowerShield" } } }, hint = "Skrzynia z nagroda: ok. 12 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ.", unlock = { 32204, 31889, 32221, 31918, 15 } },
	{ "Vampire Shield: dragon lance, vampire shield", 33190, 31659, 14, done = { kv = { "vampireshield1", "vampireshield2", "vampireshield3" } }, hint = "Skrzynia z nagroda: ok. 22 krokow, kierunek poludnie. Przy skrzyni jest strefa PZ.", unlock = { 33181, 31651, 33198, 31696, 14 } },
}

local HUB_ACTION_ID = 64992 -- pady w hubie expowisk
local hubLobby = Position(30013, 30000, 7)
local hubWings = {
	{ label = "Bestiariusz (573 teleportow)", x = 30000, y = 30040, z = 7 },
	{ label = "Exp Low (11 teleportow)", x = 30045, y = 30040, z = 7 },
	{ label = "Exp Medium (15 teleportow)", x = 30090, y = 30040, z = 7 },
	{ label = "Exp High (40 teleportow)", x = 30135, y = 30040, z = 7 },
}
local hubQuestHall = Position(30000, 29960, 7)
local hubBossHall = Position(30000, 29940, 7)
local arenaCenter = Position(30060, 29900, 7)
local arenaLanding = Position(30060, 29909, 7)
local ARENA_RADIUS = 10
local raidNpcPosition = Position(30006, 30002, 7)
local raidRooms = {
	{ label = "Slabszy", center = Position(30060, 29860, 7), landing = Position(30060, 29869, 7), bossId = nil, bossName = nil, nextAt = 0, bosses = {
		{ name = "The Imperor", outfit = { lookType = 237, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Zushuka", outfit = { lookType = 149, lookHead = 0, lookBody = 10, lookLegs = 0, lookFeet = 4, lookAddons = 0, lookMount = 0 } },
		{ name = "Chizzoron the Distorter", outfit = { lookType = 340, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Dracola", outfit = { lookType = 231, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "The Handmaiden", outfit = { lookType = 230, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Chikhaton", outfit = { lookType = 361, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Mr. Punish", outfit = { lookType = 234, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Orshabaal", outfit = { lookType = 201, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Irgix The Flimsy", outfit = { lookType = 1268, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 94, lookAddons = 0, lookMount = 0 } },
		{ name = "Furyosa", outfit = { lookType = 149, lookHead = 94, lookBody = 79, lookLegs = 77, lookFeet = 3, lookAddons = 3, lookMount = 0 } },
		{ name = "Thawing Dragon Lord", outfit = { lookType = 1077, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "The Welter", outfit = { lookType = 563, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Amenef the Burning", outfit = { lookType = 541, lookHead = 113, lookBody = 114, lookLegs = 113, lookFeet = 113, lookAddons = 1, lookMount = 0 } },
		{ name = "Unaz the Mean", outfit = { lookType = 1268, lookHead = 0, lookBody = 95, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Massacre", outfit = { lookType = 244, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Vok the Freakish", outfit = { lookType = 1268, lookHead = 0, lookBody = 98, lookLegs = 0, lookFeet = 94, lookAddons = 0, lookMount = 0 } },
		{ name = "Mawhawk", outfit = { lookType = 595, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Zulazza the Corruptor", outfit = { lookType = 334, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	} },
	{ label = "Mocny", center = Position(30090, 29860, 7), landing = Position(30090, 29869, 7), bossId = nil, bossName = nil, nextAt = 0, bosses = {
		{ name = "The Pale Count", outfit = { lookType = 557, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Lisa", outfit = { lookType = 604, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Morgaroth", outfit = { lookType = 12, lookHead = 2, lookBody = 94, lookLegs = 78, lookFeet = 79, lookAddons = 0, lookMount = 0 } },
		{ name = "Glooth Fairy", outfit = { lookType = 600, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "The Armored Voidborn", outfit = { lookType = 987, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Bullwark", outfit = { lookType = 607, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Ghazbaran", outfit = { lookType = 12, lookHead = 0, lookBody = 85, lookLegs = 78, lookFeet = 94, lookAddons = 0, lookMount = 0 } },
		{ name = "Drume", outfit = { lookType = 1317, lookHead = 38, lookBody = 76, lookLegs = 57, lookFeet = 114, lookAddons = 2, lookMount = 0 } },
		{ name = "Ferumbras", outfit = { lookType = 229, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Urmahlullu the Weakened", outfit = { lookType = 1197, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	} },
	{ label = "Legendarny", center = Position(30120, 29860, 7), landing = Position(30120, 29869, 7), bossId = nil, bossName = nil, nextAt = 0, bosses = {
		{ name = "Omrafir", outfit = { lookType = 12, lookHead = 78, lookBody = 3, lookLegs = 79, lookFeet = 79, lookAddons = 0, lookMount = 0 } },
		{ name = "The Rootkraken", outfit = { lookType = 1765 } },
		{ name = "The Monster", outfit = { lookType = 1600 } },
		{ name = "The Abomination", outfit = { lookType = 1393, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Ancient Spawn of Morgathla", outfit = { lookType = 1055, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
		{ name = "Morshabaal", outfit = { lookType = 1468, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	} },
}
local survivalCenter = Position(30090, 29900, 7)
local survivalLanding = Position(30090, 29909, 7)
local rushCenter = Position(30120, 29900, 7)
local rushLanding = Position(30120, 29909, 7)
local rushBosses = { "The Imperor", "Zushuka", "Chizzoron the Distorter", "Dracola", "The Handmaiden", "Chikhaton", "Mr. Punish", "Orshabaal", "Irgix The Flimsy", "Furyosa", "Thawing Dragon Lord", "The Welter", "Amenef the Burning", "Unaz the Mean", "Massacre", "Vok the Freakish", "Mawhawk", "Zulazza the Corruptor", "The Pale Count", "Lisa", "Morgaroth", "Glooth Fairy", "The Armored Voidborn", "Bullwark", "Ghazbaran", "Drume", "Ferumbras", "Urmahlullu the Weakened", "Omrafir", "The Rootkraken", "The Monster", "The Abomination", "Ancient Spawn of Morgathla", "Morshabaal" }
local towerCenter = Position(30150, 29900, 7)
local towerLanding = Position(30150, 29909, 7)
local bestiaryCenter = Position(30180, 29900, 7)
-- Sala Bestiariusza/Bosstiariusza zmniejszona przy starcie serwera do kwadratu 11x11 (promien 5)
-- wokol tego srodka; dookola zywoplot i ogrod jak przy innych salach huba. Miejsce ladowania (y+9) jest na jej poludniowym brzegu.
local BESTIARY_ROOM_CENTER = Position(30180, 29904, 7)
local BESTIARY_ROOM_RADIUS = 5
local bestiaryLanding = Position(30180, 29909, 7)
local bestiaryClasses = {
	{ name = "Amphibic", list = {
		{ "Azure Frog", 268, 500 },
		{ "Bog Frog", 738, 250 },
		{ "Coral Frog", 269, 500 },
		{ "Crimson Frog", 270, 500 },
		{ "Filth Toad", 735, 500 },
		{ "Green Frog", 267, 250 },
		{ "Infernal Frog", 563, 1000 },
		{ "Makara", 2262, 2500 },
		{ "Orchid Frog", 271, 500 },
		{ "Salamander", 913, 500 },
		{ "Toad", 262, 500 },
	} },
	{ name = "Aquatic", list = {
		{ "Abyssal Calamary", 1105, 500 },
		{ "Blood Crab", 261, 500 },
		{ "Calamary", 780, 500 },
		{ "Crab", 112, 500 },
		{ "Crustacea Gigantica", 697, 5 },
		{ "Deathling Scout", 1667, 2500 },
		{ "Deathling Spellsinger", 1677, 2500 },
		{ "Deepling Brawler", 859, 1000 },
		{ "Deepling Elite", 862, 1000 },
		{ "Deepling Guard", 770, 1000 },
		{ "Deepling Master Librarian", 860, 1000 },
		{ "Deepling Scout", 734, 1000 },
		{ "Deepling Spellsinger", 772, 1000 },
		{ "Deepling Tyrant", 861, 2500 },
		{ "Deepling Warrior", 769, 1000 },
		{ "Deepling Worker", 795, 500 },
		{ "Deepsea Blood Crab", 437, 500 },
		{ "Fish", 784, 250 },
		{ "Jellyfish", 781, 500 },
		{ "Manta Ray", 779, 1000 },
		{ "Northern Pike", 783, 25 },
		{ "Quara Constrictor", 239, 1000 },
		{ "Quara Constrictor Scout", 240, 1000 },
		{ "Quara Hydromancer", 243, 1000 },
		{ "Quara Hydromancer Scout", 244, 1000 },
		{ "Quara Looter", 2543, 2500 },
		{ "Quara Mantassin", 241, 1000 },
		{ "Quara Mantassin Scout", 242, 500 },
		{ "Quara Pincher", 245, 1000 },
		{ "Quara Pincher Scout", 246, 1000 },
		{ "Quara Plunderer", 2542, 2500 },
		{ "Quara Predator", 237, 1000 },
		{ "Quara Predator Scout", 238, 1000 },
		{ "Quara Raider", 2541, 2500 },
		{ "Renegade Quara Constrictor", 1097, 1000 },
		{ "Renegade Quara Hydromancer", 1098, 1000 },
		{ "Renegade Quara Mantassin", 1099, 1000 },
		{ "Renegade Quara Pincher", 1100, 1000 },
		{ "Renegade Quara Predator", 1101, 1000 },
		{ "Shark", 782, 1000 },
	} },
	{ name = "Bird", list = {
		{ "Agrestic Chicken", 1979, 250 },
		{ "Berserker Chicken", 561, 1000 },
		{ "Carnivostrich", 2341, 2500 },
		{ "Cave Parrot", 1307, 250 },
		{ "Chicken", 111, 250 },
		{ "Demon Parrot", 562, 1000 },
		{ "Dire Penguin", 335, 5 },
		{ "Flamingo", 212, 250 },
		{ "Harpy", 2340, 2500 },
		{ "Headpecker", 2275, 5000 },
		{ "Jungle Moa", 2257, 1000 },
		{ "Marsh Stalker", 914, 500 },
		{ "Parrot", 217, 250 },
		{ "Penguin", 318, 250 },
		{ "Pigeon", 915, 25 },
		{ "Seagull", 264, 250 },
		{ "Terror Bird", 218, 500 },
	} },
	{ name = "Construct", list = {
		{ "Animated Snowman", 1751, 1000 },
		{ "Biting Book", 1656, 2500 },
		{ "Clay Guardian", 706, 1000 },
		{ "Damaged Crystal Golem", 874, 500 },
		{ "Damaged Worker Golem", 524, 500 },
		{ "Diamond Servant", 702, 5 },
		{ "Diamond Servant Replica", 1326, 1000 },
		{ "Enraged Crystal Golem", 873, 1000 },
		{ "Eternal Guardian", 615, 1000 },
		{ "Gingerbread Man", 2549, 25 },
		{ "Glooth Golem", 1038, 1000 },
		{ "Goggle Cake", 2534, 2500 },
		{ "Golden Servant", 701, 5 },
		{ "Golden Servant Replica", 1327, 1000 },
		{ "Ice Golem", 326, 1000 },
		{ "Infected Weeper", 897, 2500 },
		{ "Iron Servant", 700, 5 },
		{ "Iron Servant Replica", 1325, 1000 },
		{ "Lava Golem", 884, 2500 },
		{ "Magma Crawler", 885, 2500 },
		{ "Metal Gargoyle", 1039, 1000 },
		{ "Orewalker", 883, 2500 },
		{ "Rotten Golem", 1939, 5000 },
		{ "Rustheap Golem", 1041, 1000 },
		{ "Sandstone Scorpion", 705, 1000 },
		{ "Shrieking Cry-Stal", 2278, 5000 },
		{ "Stone Devourer", 879, 2500 },
		{ "Stone Golem", 67, 500 },
		{ "Walker", 1043, 1000 },
		{ "Walking Pillar", 2394, 5000 },
		{ "Wandering Pillar", 2395, 5000 },
		{ "War Golem", 533, 1000 },
		{ "Weeper", 882, 2500 },
		{ "Worker Golem", 503, 1000 },
	} },
	{ name = "Demon", list = {
		{ "Askarak Demon", 727, 1000 },
		{ "Askarak Lord", 728, 1000 },
		{ "Askarak Prince", 729, 1000 },
		{ "Brachiodemon", 1930, 5000 },
		{ "Brinebrute Inferniarch", 2601, 2500 },
		{ "Broodrider Inferniarch", 2603, 2500 },
		{ "Dark Torturer", 285, 2500 },
		{ "Dawnfire Asura", 1134, 2500 },
		{ "Demon", 35, 2500 },
		{ "Demon Outcast", 1019, 2500 },
		{ "Destroyer", 287, 1000 },
		{ "Diabolic Imp", 288, 1000 },
		{ "Duskbringer", 581, 5 },
		{ "Fire Devil", 40, 500 },
		{ "Floating Savant", 1637, 2500 },
		{ "Frost Flower Asura", 1619, 1000 },
		{ "Fury", 291, 2500 },
		{ "Gorger Inferniarch", 2604, 2500 },
		{ "Gozzler", 523, 500 },
		{ "Grimeleech", 1196, 2500 },
		{ "Hellfire Fighter", 295, 2500 },
		{ "Hellflayer", 1198, 2500 },
		{ "Hellhound", 294, 2500 },
		{ "Hellhunter Inferniarch", 2600, 2500 },
		{ "Hellspawn", 519, 1000 },
		{ "Herald of Gloom", 586, 5 },
		{ "Infernal Demon", 1938, 5000 },
		{ "Juggernaut", 296, 2500 },
		{ "Many Faces", 1927, 5000 },
		{ "Midnight Asura", 1135, 1000 },
		{ "Nightfiend", 973, 5 },
		{ "Plaguesmith", 314, 1000 },
		{ "Shaburak Demon", 724, 1000 },
		{ "Shaburak Lord", 725, 1000 },
		{ "Shaburak Prince", 726, 1000 },
		{ "Shadow Hound", 582, 5 },
		{ "Sineater Inferniarch", 2602, 2500 },
		{ "Spellreaper Inferniarch", 2599, 2500 },
		{ "True Dawnfire Asura", 1620, 2500 },
		{ "True Frost Flower Asura", 1622, 2500 },
		{ "True Midnight Asura", 1621, 2500 },
		{ "Vexclaw", 1197, 2500 },
	} },
	{ name = "Dragon", list = {
		{ "Dragolisk", 2456, 2500 },
		{ "Dragon", 34, 1000 },
		{ "Dragon Hatchling", 385, 1000 },
		{ "Dragon Lord", 39, 1000 },
		{ "Dragon Lord Hatchling", 386, 1000 },
		{ "Draken Abomination", 673, 2500 },
		{ "Draken Elite", 672, 2500 },
		{ "Draken Spellweaver", 618, 2500 },
		{ "Draken Warmaster", 617, 1000 },
		{ "Elder Wyrm", 963, 2500 },
		{ "Frost Dragon", 317, 1000 },
		{ "Frost Dragon Hatchling", 402, 1000 },
		{ "Ghastly Dragon", 643, 2500 },
		{ "Haunted Dragon", 1376, 2500 },
		{ "Hydra", 121, 1000 },
		{ "Ice Dragon", 1380, 1000 },
		{ "Mega Dragon", 2459, 2500 },
		{ "Wardragon", 2458, 2500 },
		{ "Wyrm", 461, 1000 },
	} },
	{ name = "Elemental", list = {
		{ "Candy Floss Elemental", 2533, 2500 },
		{ "Cliff Strider", 889, 2500 },
		{ "Converter", 2379, 5000 },
		{ "Earth Elemental", 458, 1000 },
		{ "Energy Elemental", 457, 1000 },
		{ "Fire Elemental", 49, 1000 },
		{ "Foam Stalker", 2259, 2500 },
		{ "High Voltage Elemental", 1116, 1000 },
		{ "Honey Elemental", 2551, 1000 },
		{ "Ironblight", 890, 2500 },
		{ "Knowledge Elemental", 1670, 2500 },
		{ "Lava Lurker", 1563, 2500 },
		{ "Massive Earth Elemental", 455, 1000 },
		{ "Massive Energy Elemental", 456, 1000 },
		{ "Massive Fire Elemental", 313, 1000 },
		{ "Massive Water Elemental", 279, 1000 },
		{ "Raging Fire", 1121, 5 },
		{ "Ravenous Lava Lurker", 1569, 1000 },
		{ "Sulphur Spouter", 2265, 5000 },
		{ "Turbulent Elemental", 1940, 5000 },
		{ "Water Elemental", 236, 1000 },
	} },
	{ name = "Extra Dimensional", list = {
		{ "Breach Brood", 1235, 2500 },
		{ "Courage Leech", 1941, 5000 },
		{ "Dread Intruder", 1260, 2500 },
		{ "Instable Breach Brood", 1265, 1000 },
		{ "Instable Sparkion", 1264, 1000 },
		{ "Mitmah Scout", 2460, 2500 },
		{ "Mitmah Seer", 2461, 2500 },
		{ "Reality Reaver", 1224, 2500 },
		{ "Sparkion", 1234, 2500 },
		{ "Stabilizing Dread Intruder", 1267, 1000 },
		{ "Stabilizing Reality Reaver", 1266, 1000 },
		{ "Yielothax", 717, 1000 },
	} },
	{ name = "Fey", list = {
		{ "Angry Sugar Fairy", 2552, 2500 },
		{ "Arctic Faun", 1626, 1000 },
		{ "Boogy", 1439, 1000 },
		{ "Cream Blob", 2568, 25 },
		{ "Dark Faun", 1496, 1000 },
		{ "Dryad", 383, 5 },
		{ "Faun", 1434, 1000 },
		{ "Fruit Drop", 2565, 25 },
		{ "Nymph", 1485, 1000 },
		{ "Percht", 1740, 1000 },
		{ "Pixie", 1438, 1000 },
		{ "Pooka", 1435, 1000 },
		{ "Schiach", 1741, 1000 },
		{ "Sugar Cube", 2548, 25 },
		{ "Sugar Cube Worker", 2567, 25 },
		{ "Swan Maiden", 1437, 1000 },
		{ "Truffle", 2547, 25 },
		{ "Truffle Cook", 2563, 25 },
		{ "Twisted Pooka", 1436, 1000 },
		{ "Wisp", 462, 250 },
	} },
	{ name = "Giant", list = {
		{ "Behemoth", 55, 1000 },
		{ "Cyclops", 22, 500 },
		{ "Cyclops Drone", 391, 1000 },
		{ "Cyclops Smith", 389, 1000 },
		{ "Frost Giant", 324, 500 },
		{ "Frost Giantess", 334, 500 },
		{ "Hulking Prehemoth", 2271, 5000 },
		{ "Ogre Brute", 1161, 1000 },
		{ "Ogre Rowdy", 1821, 2500 },
		{ "Ogre Ruffian", 1820, 2500 },
		{ "Ogre Sage", 1822, 2500 },
		{ "Ogre Savage", 1162, 1000 },
		{ "Ogre Shaman", 1163, 1000 },
		{ "Orclops Doomhauler", 1314, 1000 },
		{ "Orclops Ravager", 1320, 1000 },
	} },
	{ name = "Human", list = {
		{ "Acolyte of Darkness", 578, 5 },
		{ "Acolyte of the Cult", 253, 1000 },
		{ "Adept of the Cult", 254, 1000 },
		{ "Adventurer", 922, 500 },
		{ "Amazon", 77, 500 },
		{ "Assassin", 224, 500 },
		{ "Bandit", 223, 500 },
		{ "Barbarian Bloodwalker", 323, 1000 },
		{ "Barbarian Brutetamer", 332, 500 },
		{ "Barbarian Headsplitter", 333, 500 },
		{ "Barbarian Skullhunter", 322, 500 },
		{ "Black Sphinx Acolyte", 1800, 2500 },
		{ "Blood Hand", 974, 1000 },
		{ "Blood Priest", 961, 1000 },
		{ "Burning Gladiator", 1798, 2500 },
		{ "Cobra Assassin", 1775, 2500 },
		{ "Cobra Scout", 1776, 2500 },
		{ "Cobra Vizier", 1824, 2500 },
		{ "Crazed Beggar", 525, 500 },
		{ "Crypt Defiler", 868, 500 },
		{ "Cult Believer", 1512, 1000 },
		{ "Cult Enforcer", 1513, 1000 },
		{ "Cult Scholar", 1514, 1000 },
		{ "Dark Apprentice", 372, 500 },
		{ "Dark Carnisylvan", 2109, 2500 },
		{ "Dark Magician", 371, 500 },
		{ "Dark Monk", 225, 500 },
		{ "Enlightened of the Cult", 252, 1000 },
		{ "Feverish Citizen", 719, 500 },
		{ "Gang Member", 526, 500 },
		{ "Gladiator", 527, 500 },
		{ "Glooth Bandit", 1119, 1000 },
		{ "Glooth Brigand", 1120, 1000 },
		{ "Goldhanded Cultist", 1481, 1000 },
		{ "Grave Robber", 867, 500 },
		{ "Hero", 73, 1000 },
		{ "Hulking Carnisylvan", 2107, 2500 },
		{ "Hunter", 11, 500 },
		{ "Ice Witch", 331, 1000 },
		{ "Infernalist", 529, 2500 },
		{ "Mad Scientist", 528, 500 },
		{ "Misguided Thief", 1413, 1000 },
		{ "Monk", 57, 500 },
		{ "Mutated Human", 521, 1000 },
		{ "Necromancer", 9, 1000 },
		{ "Nomad", 310, 500 },
		{ "Nomad Blue", 776, 500 },
		{ "Nomad Female", 777, 500 },
		{ "Novice of the Cult", 255, 500 },
		{ "Pirate Buccaneer", 249, 1000 },
		{ "Pirate Corsair", 250, 1000 },
		{ "Pirate Cutthroat", 248, 1000 },
		{ "Pirate Marauder", 247, 500 },
		{ "Poacher", 376, 500 },
		{ "Poisonous Carnisylvan", 2108, 2500 },
		{ "Priestess", 58, 1000 },
		{ "Priestess of the Wild Sun", 1799, 2500 },
		{ "Renegade Knight", 1146, 1000 },
		{ "Shadow Pupil", 960, 1000 },
		{ "Smuggler", 222, 500 },
		{ "Stalker", 72, 500 },
		{ "Usurper Archer", 1973, 2500 },
		{ "Usurper Knight", 1972, 2500 },
		{ "Usurper Warlock", 1974, 2500 },
		{ "Valkyrie", 12, 500 },
		{ "Vicious Squire", 1145, 1000 },
		{ "Vile Grandmaster", 1147, 1000 },
		{ "Warlock", 10, 1000 },
		{ "Wild Warrior", 47, 500 },
		{ "Witch", 54, 500 },
	} },
	{ name = "Humanoid", list = {
		{ "Barkless Devotee", 1486, 1000 },
		{ "Barkless Fanatic", 1488, 1000 },
		{ "Boar Man", 2339, 2500 },
		{ "Broken Shaper", 1321, 1000 },
		{ "Bulltaur Alchemist", 2448, 2500 },
		{ "Bulltaur Brute", 2447, 2500 },
		{ "Bulltaur Forgepriest", 2449, 2500 },
		{ "Chakoya Toolshaper", 328, 500 },
		{ "Chakoya Tribewarden", 319, 500 },
		{ "Chakoya Windcaller", 329, 500 },
		{ "Corym Charlatan", 916, 500 },
		{ "Corym Skirmisher", 917, 1000 },
		{ "Corym Vanguard", 918, 1000 },
		{ "Crape Man", 2337, 2500 },
		{ "Crazed Summer Rearguard", 1733, 2500 },
		{ "Crazed Summer Vanguard", 1732, 2500 },
		{ "Crazed Winter Rearguard", 1731, 2500 },
		{ "Crazed Winter Vanguard", 1730, 2500 },
		{ "Dwarf", 69, 500 },
		{ "Dwarf Geomancer", 66, 1000 },
		{ "Dwarf Guard", 70, 500 },
		{ "Dwarf Henchman", 379, 1000 },
		{ "Dwarf Soldier", 71, 500 },
		{ "Dworc Fleshhunter", 215, 500 },
		{ "Dworc Venomsniper", 216, 500 },
		{ "Dworc Voodoomaster", 214, 500 },
		{ "Elf", 62, 500 },
		{ "Elf Arcanist", 63, 500 },
		{ "Elf Overseer", 741, 5 },
		{ "Elf Scout", 64, 500 },
		{ "Enslaved Dwarf", 886, 1000 },
		{ "Execowtioner", 1046, 1000 },
		{ "Firestarter", 737, 500 },
		{ "Frost Troll", 53, 250 },
		{ "Furious Troll", 540, 500 },
		{ "Goblin", 61, 250 },
		{ "Goblin Assassin", 463, 500 },
		{ "Goblin Leader", 377, 5 },
		{ "Goblin Scavenger", 464, 500 },
		{ "Grynch Clan Goblin", 393, 5 },
		{ "Insane Siren", 1735, 2500 },
		{ "Island Troll", 277, 250 },
		{ "Liodile", 2338, 2500 },
		{ "Little Corym Charlatan", 920, 500 },
		{ "Lost Basher", 925, 1000 },
		{ "Lost Berserker", 888, 2500 },
		{ "Lost Exile", 1529, 1000 },
		{ "Lost Husher", 924, 1000 },
		{ "Lost Thrower", 926, 1000 },
		{ "Minotaur", 25, 500 },
		{ "Minotaur Amazon", 1045, 2500 },
		{ "Minotaur Archer", 24, 500 },
		{ "Minotaur Cult Follower", 1508, 1000 },
		{ "Minotaur Cult Prophet", 1509, 1000 },
		{ "Minotaur Cult Zealot", 1510, 1000 },
		{ "Minotaur Guard", 29, 500 },
		{ "Minotaur Hunter", 1052, 1000 },
		{ "Minotaur Invader", 1109, 1000 },
		{ "Minotaur Mage", 23, 500 },
		{ "Misguided Bully", 1412, 1000 },
		{ "Mooh'Tah Warrior", 1051, 1000 },
		{ "Moohtant", 1044, 1000 },
		{ "Orc", 5, 500 },
		{ "Orc Berserker", 8, 1000 },
		{ "Orc Cult Fanatic", 1506, 1000 },
		{ "Orc Cult Inquisitor", 1505, 1000 },
		{ "Orc Cult Minion", 1507, 1000 },
		{ "Orc Cult Priest", 1504, 1000 },
		{ "Orc Cultist", 1503, 1000 },
		{ "Orc Leader", 59, 1000 },
		{ "Orc Marauder", 614, 1000 },
		{ "Orc Rider", 4, 500 },
		{ "Orc Shaman", 6, 500 },
		{ "Orc Spearman", 50, 500 },
		{ "Orc Warlord", 2, 1000 },
		{ "Orc Warrior", 7, 500 },
		{ "Pirat Bombardier", 2038, 1000 },
		{ "Pirat Cutthroat", 2036, 1000 },
		{ "Pirat Mate", 2039, 1000 },
		{ "Pirat Scoundrel", 2037, 1000 },
		{ "Rhindeer", 2342, 2500 },
		{ "Shaper Matriarch", 1394, 1000 },
		{ "Soul-Broken Harbinger", 1734, 2500 },
		{ "Swamp Troll", 76, 500 },
		{ "Troll", 15, 250 },
		{ "Troll Champion", 392, 500 },
		{ "Troll Guard", 745, 5 },
		{ "Troll Legionnaire", 541, 1000 },
		{ "Twisted Shaper", 1322, 1000 },
		{ "Worm Priestess", 1053, 1000 },
	} },
	{ name = "Lycanthrope", list = {
		{ "Cunning Werepanther", 2403, 2500 },
		{ "Feral Werecrocodile", 2389, 2500 },
		{ "Werebadger", 1144, 1000 },
		{ "Werebear", 1142, 1000 },
		{ "Wereboar", 1143, 1000 },
		{ "Werecrocodile", 2388, 2500 },
		{ "Werefox", 1549, 1000 },
		{ "Werehyaena", 1963, 1000 },
		{ "Werehyaena Shaman", 1964, 1000 },
		{ "Werelion", 1965, 2500 },
		{ "Werelioness", 1966, 2500 },
		{ "Werepanther", 2390, 2500 },
		{ "Weretiger", 2386, 2500 },
		{ "Werewolf", 510, 1000 },
		{ "White Weretiger", 2387, 2500 },
	} },
	{ name = "Magical", list = {
		{ "Animated Feather", 1671, 2500 },
		{ "Arachnophobica", 1729, 2500 },
		{ "Armadile", 880, 2500 },
		{ "Bashmu", 2100, 2500 },
		{ "Blue Djinn", 80, 1000 },
		{ "Bog Raider", 460, 1000 },
		{ "Bonelord", 17, 500 },
		{ "Brain Squid", 1653, 2500 },
		{ "Burning Book", 1663, 2500 },
		{ "Candy Horror", 2535, 2500 },
		{ "Choking Fear", 1015, 2500 },
		{ "Crypt Warden", 1805, 2500 },
		{ "Crystal Spider", 330, 1000 },
		{ "Crystal Wolf", 740, 5 },
		{ "Crystalcrusher", 869, 1000 },
		{ "Cursed Book", 1655, 2500 },
		{ "Darklight Construct", 2378, 5000 },
		{ "Darklight Emitter", 2382, 5000 },
		{ "Darklight Source", 2398, 5000 },
		{ "Darklight Striker", 2399, 5000 },
		{ "Dragonling", 894, 1000 },
		{ "Efreet", 103, 1000 },
		{ "Elder Bonelord", 108, 1000 },
		{ "Energetic Book", 1665, 2500 },
		{ "Energuardian of Tales", 1666, 2500 },
		{ "Enfeebled Silencer", 1443, 1000 },
		{ "Feral Sphinx", 1807, 2500 },
		{ "Feversleep", 1021, 1000 },
		{ "Flying Book", 1654, 1000 },
		{ "Forest Fury", 980, 1000 },
		{ "Frazzlemaw", 1022, 2500 },
		{ "Gargoyle", 95, 500 },
		{ "Gazer", 109, 500 },
		{ "Girtablilu Warrior", 2099, 2500 },
		{ "Green Djinn", 51, 1000 },
		{ "Gryphon", 1819, 1000 },
		{ "Guardian of Tales", 1659, 2500 },
		{ "Guzzlemaw", 1013, 2500 },
		{ "Icecold Book", 1664, 2500 },
		{ "Juvenile Bashmu", 2101, 2500 },
		{ "Lamassu", 1806, 2500 },
		{ "Lumbering Carnivor", 1721, 1000 },
		{ "Manticore", 1816, 2500 },
		{ "Marid", 104, 1000 },
		{ "Medusa", 570, 2500 },
		{ "Menacing Carnivor", 1723, 2500 },
		{ "Midnight Panther", 698, 5 },
		{ "Nibblemaw", 2531, 2500 },
		{ "Nightmare", 299, 1000 },
		{ "Nightmare Scion", 518, 1000 },
		{ "Nightstalker", 520, 1000 },
		{ "Phantasm", 292, 2500 },
		{ "Rage Squid", 1668, 2500 },
		{ "Redeemed Soul", 1138, 500 },
		{ "Retching Horror", 1018, 2500 },
		{ "Rorc", 978, 1000 },
		{ "Shock Head", 1004, 2500 },
		{ "Sight of Surrender", 1012, 2500 },
		{ "Silencer", 1014, 1000 },
		{ "Sphinx", 1808, 2500 },
		{ "Spiky Carnivor", 1722, 2500 },
		{ "Squid Warden", 1669, 2500 },
		{ "Tainted Soul", 1137, 500 },
		{ "Terrorsleep", 1016, 2500 },
		{ "Thanatursus", 1728, 2500 },
		{ "Thornfire Wolf", 739, 5 },
		{ "Venerable Girtablilu", 2098, 2500 },
		{ "Weakened Frazzlemaw", 1442, 1000 },
	} },
	{ name = "Mammal", list = {
		{ "Badger", 105, 250 },
		{ "Baleful Bunny", 1742, 1000 },
		{ "Bat", 122, 250 },
		{ "Bear", 16, 500 },
		{ "Black Sheep", 13, 250 },
		{ "Boar", 693, 500 },
		{ "Brown Horse", 752, 250 },
		{ "Cat", 387, 25 },
		{ "Cave Rat", 56, 250 },
		{ "Clomp", 1174, 1000 },
		{ "Deer", 31, 250 },
		{ "Dog", 32, 25 },
		{ "Doom Deer", 559, 1000 },
		{ "Dromedary", 733, 250 },
		{ "Elephant", 211, 500 },
		{ "Evil Sheep", 555, 1000 },
		{ "Evil Sheep Lord", 556, 1000 },
		{ "Exotic Bat", 2051, 1000 },
		{ "Fox", 1548, 250 },
		{ "Gloom Wolf", 1139, 500 },
		{ "Gnarlhound", 630, 500 },
		{ "Gore Horn", 2266, 5000 },
		{ "Gorerilla", 2277, 5000 },
		{ "Grey Horse", 751, 250 },
		{ "Horse", 750, 250 },
		{ "Hot Dog", 557, 1000 },
		{ "Husky", 325, 25 },
		{ "Hyaena", 94, 500 },
		{ "Killer Rabbit", 560, 500 },
		{ "Kongra", 116, 500 },
		{ "Lion", 41, 500 },
		{ "Mammoth", 260, 500 },
		{ "Merlkin", 117, 500 },
		{ "Modified Gnarlhound", 877, 25 },
		{ "Mole", 1570, 500 },
		{ "Mushroom Sniffer", 870, 25 },
		{ "Mutated Bat", 509, 1000 },
		{ "Mutated Rat", 502, 1000 },
		{ "Mutated Tiger", 516, 1000 },
		{ "Nighthunter", 2270, 5000 },
		{ "Noble Lion", 1118, 1000 },
		{ "Panda", 123, 500 },
		{ "Parder", 2256, 1000 },
		{ "Pig", 60, 250 },
		{ "Polar Bear", 42, 500 },
		{ "Rabbit", 74, 250 },
		{ "Rat", 21, 250 },
		{ "Roaring Lion", 981, 1000 },
		{ "Sabretooth", 2267, 5000 },
		{ "Sheep", 14, 250 },
		{ "Sibang", 118, 500 },
		{ "Silver Rabbit", 327, 250 },
		{ "Skunk", 106, 250 },
		{ "Squirrel", 384, 250 },
		{ "Starving Wolf", 723, 500 },
		{ "Stone Rhino", 1395, 1000 },
		{ "Terrified Elephant", 771, 500 },
		{ "Tiger", 125, 500 },
		{ "Vulcongra", 898, 2500 },
		{ "War Wolf", 3, 500 },
		{ "Water Buffalo", 872, 5 },
		{ "White Deer", 720, 250 },
		{ "White Lion", 1967, 2500 },
		{ "White Tiger", 2391, 500 },
		{ "Wild Horse", 730, 5 },
		{ "Winter Wolf", 52, 250 },
		{ "Wolf", 27, 250 },
		{ "Yeti", 110, 5 },
	} },
	{ name = "Plant", list = {
		{ "Bane Bringer", 679, 5 },
		{ "Branchy Crawler", 1931, 5000 },
		{ "Carniphila", 120, 1000 },
		{ "Cloak of Terror", 1928, 5000 },
		{ "Glooth Anemone", 1042, 1000 },
		{ "Haunted Treeling", 511, 1000 },
		{ "Hideous Fungus", 891, 2500 },
		{ "Humongous Fungus", 881, 2500 },
		{ "Lavafungus", 2095, 2500 },
		{ "Leaf Golem", 979, 500 },
		{ "Omnivora", 1141, 1000 },
		{ "Rootthing Amber Shaper", 2539, 2500 },
		{ "Rootthing Bug Tracker", 2538, 2500 },
		{ "Rootthing Nutshell", 2540, 2500 },
		{ "Spit Nettle", 221, 500 },
		{ "Stalking Stalk", 2272, 5000 },
		{ "Swampling", 919, 500 },
		{ "Wilting Leaf Golem", 982, 1000 },
	} },
	{ name = "Reptile", list = {
		{ "Adult Goanna", 1818, 2500 },
		{ "Cobra", 81, 500 },
		{ "Crocodile", 119, 500 },
		{ "Draptor", 695, 5 },
		{ "Emerald Tortoise", 2268, 5000 },
		{ "Killer Caiman", 627, 1000 },
		{ "Lizard Chosen", 620, 1000 },
		{ "Lizard Dragon Priest", 623, 1000 },
		{ "Lizard High Guard", 625, 1000 },
		{ "Lizard Legionnaire", 624, 1000 },
		{ "Lizard Magistratus", 655, 1000 },
		{ "Lizard Noble", 656, 2500 },
		{ "Lizard Sentinel", 114, 500 },
		{ "Lizard Snakecharmer", 115, 1000 },
		{ "Lizard Templar", 113, 500 },
		{ "Lizard Zaogun", 616, 1000 },
		{ "Mantosaurus", 2274, 5000 },
		{ "Mercurial Menace", 2279, 5000 },
		{ "Naga Archer", 2260, 2500 },
		{ "Naga Warrior", 2261, 2500 },
		{ "Noxious Ripptor", 2276, 5000 },
		{ "Sea Serpent", 438, 1000 },
		{ "Seacrest Serpent", 1096, 2500 },
		{ "Serpent Spawn", 220, 1000 },
		{ "Snake", 28, 250 },
		{ "Stampor", 694, 1000 },
		{ "Stonerefiner", 1525, 1000 },
		{ "Thornback Tortoise", 259, 500 },
		{ "Tortoise", 258, 500 },
		{ "Two-Headed Turtle", 2258, 2500 },
		{ "Wyvern", 290, 1000 },
		{ "Young Goanna", 1817, 2500 },
		{ "Young Sea Serpent", 439, 1000 },
	} },
	{ name = "Slime", list = {
		{ "Acid Blob", 513, 1000 },
		{ "Chocolate Blob", 2550, 25 },
		{ "Darklight Matter", 2380, 5000 },
		{ "Death Blob", 514, 1000 },
		{ "Defiler", 289, 2500 },
		{ "Devourer", 1056, 1000 },
		{ "Glooth Blob", 1054, 1000 },
		{ "Ink Blob", 1658, 2500 },
		{ "Meandering Mushroom", 2376, 5000 },
		{ "Mercury Blob", 515, 500 },
		{ "Midnight Spawn", 584, 5 },
		{ "Slime", 19, 500 },
		{ "Son of Verminor", 265, 2500 },
		{ "Squidgy Slime", 20, 500 },
	} },
	{ name = "Undead", list = {
		{ "Bane of Light", 580, 5 },
		{ "Banshee", 78, 1000 },
		{ "Betrayed Wraith", 284, 1000 },
		{ "Blightwalker", 298, 2500 },
		{ "Blood Beast", 1040, 1000 },
		{ "Bonebeast", 101, 1000 },
		{ "Bony Sea Devil", 1926, 5000 },
		{ "Braindeath", 321, 1000 },
		{ "Burster Spectre", 1726, 2500 },
		{ "Capricious Phantom", 1932, 5000 },
		{ "Crypt Shambler", 100, 500 },
		{ "Cursed Ape", 2347, 1000 },
		{ "Cursed Prospector", 1880, 2500 },
		{ "Death Priest", 710, 1000 },
		{ "Demon Skeleton", 37, 1000 },
		{ "Distorted Phantom", 1962, 5000 },
		{ "Druid's Apparition", 1946, 5000 },
		{ "Elder Mummy", 711, 1000 },
		{ "Evil Prospector", 1885, 2500 },
		{ "Falcon Knight", 1646, 2500 },
		{ "Falcon Paladin", 1647, 2500 },
		{ "Flimsy Lost Soul", 1864, 2500 },
		{ "Freakish Lost Soul", 1866, 2500 },
		{ "Gazer Spectre", 1725, 2500 },
		{ "Ghost", 48, 500 },
		{ "Ghost Wolf", 1148, 500 },
		{ "Ghoul", 18, 500 },
		{ "Ghoulish Hyaena", 704, 1000 },
		{ "Grave Guard", 707, 1000 },
		{ "Gravedigger", 975, 1000 },
		{ "Grim Reaper", 465, 2500 },
		{ "Hand of Cursed Fate", 281, 2500 },
		{ "Honour Guard", 712, 500 },
		{ "Iks Ahpututu", 2349, 5 },
		{ "Iks Aucar", 2344, 1000 },
		{ "Iks Chuka", 2345, 1000 },
		{ "Iks Churrascan", 2350, 1000 },
		{ "Iks Pututu", 2343, 1000 },
		{ "Iks Yapunac", 2437, 2500 },
		{ "Infernal Phantom", 1933, 5000 },
		{ "Knight's Apparition", 1947, 5000 },
		{ "Lich", 99, 1000 },
		{ "Lost Soul", 283, 1000 },
		{ "Mean Lost Soul", 1865, 2500 },
		{ "Monk's Apparition", 2636, 5000 },
		{ "Mould Phantom", 1945, 5000 },
		{ "Mummy", 65, 500 },
		{ "Oozing Carcass", 2377, 5000 },
		{ "Oozing Corpus", 2381, 5000 },
		{ "Paladin's Apparition", 1948, 5000 },
		{ "Pirate Ghost", 257, 500 },
		{ "Pirate Skeleton", 256, 500 },
		{ "Putrid Mummy", 1415, 1000 },
		{ "Ripper Spectre", 1724, 2500 },
		{ "Rot Elemental", 1055, 1000 },
		{ "Skeleton", 33, 500 },
		{ "Skeleton Elite Warrior", 1674, 2500 },
		{ "Skeleton Warrior", 446, 500 },
		{ "Sopping Carcass", 2396, 5000 },
		{ "Sopping Corpus", 2397, 5000 },
		{ "Sorcerer's Apparition", 1949, 5000 },
		{ "Souleater", 675, 1000 },
		{ "Spectre", 286, 1000 },
		{ "Tarnished Spirit", 976, 500 },
		{ "Tomb Servant", 708, 1000 },
		{ "Undead Cavebear", 696, 5 },
		{ "Undead Dragon", 282, 2500 },
		{ "Undead Elite Gladiator", 1675, 2500 },
		{ "Undead Gladiator", 508, 1000 },
		{ "Undead Mine Worker", 594, 500 },
		{ "Undead Prospector", 595, 500 },
		{ "Vampire", 68, 1000 },
		{ "Vampire Bride", 483, 1000 },
		{ "Vampire Pig", 558, 1000 },
		{ "Vampire Viscount", 958, 1000 },
		{ "Vibrant Phantom", 1929, 5000 },
		{ "Vicious Manbat", 959, 5 },
		{ "White Shade", 962, 500 },
		{ "Zombie", 512, 1000 },
	} },
	{ name = "Vermin", list = {
		{ "Afflicted Strider", 2094, 2500 },
		{ "Ancient Scarab", 79, 1000 },
		{ "Blemished Spawn", 2093, 2500 },
		{ "Bloated Man-Maggot", 2392, 5000 },
		{ "Brimstone Bug", 674, 1000 },
		{ "Bug", 45, 250 },
		{ "Butterfly", 227, 25 },
		{ "Carrion Worm", 251, 500 },
		{ "Cave Chimera", 2096, 2500 },
		{ "Cave Devourer", 1544, 2500 },
		{ "Centipede", 124, 500 },
		{ "Chasm Spawn", 1546, 2500 },
		{ "Crawler", 786, 1000 },
		{ "Deepworm", 1531, 2500 },
		{ "Diremaw", 1532, 2500 },
		{ "Drillworm", 878, 1000 },
		{ "Emerald Damselfly", 912, 500 },
		{ "Exotic Cave Spider", 2024, 1000 },
		{ "Eyeless Devourer", 2092, 2500 },
		{ "Giant Spider", 38, 1000 },
		{ "Hibernal Moth", 1737, 1000 },
		{ "Hive Overseer", 801, 2500 },
		{ "Insect Swarm", 621, 500 },
		{ "Insectoid Scout", 732, 500 },
		{ "Insectoid Worker", 796, 1000 },
		{ "Kollos", 788, 1000 },
		{ "Lacewing Moth", 1736, 1000 },
		{ "Ladybug", 778, 500 },
		{ "Lancer Beetle", 633, 1000 },
		{ "Larva", 82, 500 },
		{ "Lavaworm", 2088, 2500 },
		{ "Mycobiontic Beetle", 2375, 5000 },
		{ "Pink Butterfly", 213, 25 },
		{ "Poison Spider", 36, 250 },
		{ "Red Butterfly", 228, 25 },
		{ "Rotten Man-Maggot", 2393, 5000 },
		{ "Rotworm", 26, 500 },
		{ "Sacred Spider", 709, 1000 },
		{ "Sandcrawler", 641, 250 },
		{ "Scarab", 83, 500 },
		{ "Scorpion", 43, 500 },
		{ "Slug", 731, 500 },
		{ "Spider", 30, 250 },
		{ "Spidris", 787, 1000 },
		{ "Spidris Elite", 797, 1000 },
		{ "Spitter", 791, 1000 },
		{ "Streaked Devourer", 2091, 2500 },
		{ "Sulphider", 2264, 5000 },
		{ "Swarmer", 790, 1000 },
		{ "Tarantula", 219, 500 },
		{ "Terramite", 631, 500 },
		{ "Tremendous Tyrant", 2089, 2500 },
		{ "Tunnel Tyrant", 1545, 2500 },
		{ "Undertaker", 2269, 5000 },
		{ "Varnished Diremaw", 2090, 2500 },
		{ "Wailing Widow", 632, 1000 },
		{ "Wasp", 44, 250 },
		{ "Waspoid", 792, 1000 },
		{ "Wiggler", 899, 1000 },
		{ "Yellow Butterfly", 235, 25 },
	} },
}
local taskNpcPosition = Position(30011, 29998, 7)
local hubPads = {
	["29998:29889:7"] = { goto = { 30000, 29900, 7 }, label = "Bossy: arena 3/4" },
	["29998:29890:7"] = { lobby = true },
	["29998:29891:7"] = { goto = { 30000, 29940, 7 }, label = "Bossy: dzwignie 1/2" },
	["29998:29899:7"] = { goto = { 30000, 29910, 7 }, label = "Bossy: arena 2/4" },
	["29998:29900:7"] = { lobby = true },
	["29998:29901:7"] = { goto = { 30000, 29890, 7 }, label = "Bossy: arena 4/4" },
	["29998:29909:7"] = { goto = { 30000, 29920, 7 }, label = "Bossy: arena 1/4" },
	["29998:29910:7"] = { lobby = true },
	["29998:29911:7"] = { goto = { 30000, 29900, 7 }, label = "Bossy: arena 3/4" },
	["29998:29919:7"] = { goto = { 30000, 29930, 7 }, label = "Bossy: dzwignie 2/2" },
	["29998:29920:7"] = { lobby = true },
	["29998:29921:7"] = { goto = { 30000, 29910, 7 }, label = "Bossy: arena 2/4" },
	["29998:29929:7"] = { goto = { 30000, 29940, 7 }, label = "Bossy: dzwignie 1/2" },
	["29998:29930:7"] = { lobby = true },
	["29998:29931:7"] = { goto = { 30000, 29920, 7 }, label = "Bossy: arena 1/4" },
	["29998:29939:7"] = { goto = { 30000, 29890, 7 }, label = "Bossy: arena 4/4" },
	["29998:29940:7"] = { lobby = true },
	["29998:29941:7"] = { goto = { 30000, 29930, 7 }, label = "Bossy: dzwignie 2/2" },
	["29998:29960:7"] = { lobby = true },
	["29998:30039:7"] = { goto = { 30000, 30280, 7 }, label = "Bestiariusz: Vermin 2/2" },
	["29998:30040:7"] = { lobby = true },
	["29998:30041:7"] = { goto = { 30000, 30050, 7 }, label = "Bestiariusz: Aquatic" },
	["29998:30049:7"] = { goto = { 30000, 30040, 7 }, label = "Bestiariusz: Amphibic" },
	["29998:30050:7"] = { lobby = true },
	["29998:30051:7"] = { goto = { 30000, 30060, 7 }, label = "Bestiariusz: Bird" },
	["29998:30059:7"] = { goto = { 30000, 30050, 7 }, label = "Bestiariusz: Aquatic" },
	["29998:30060:7"] = { lobby = true },
	["29998:30061:7"] = { goto = { 30000, 30070, 7 }, label = "Bestiariusz: Construct" },
	["29998:30069:7"] = { goto = { 30000, 30060, 7 }, label = "Bestiariusz: Bird" },
	["29998:30070:7"] = { lobby = true },
	["29998:30071:7"] = { goto = { 30000, 30080, 7 }, label = "Bestiariusz: Demon" },
	["29998:30079:7"] = { goto = { 30000, 30070, 7 }, label = "Bestiariusz: Construct" },
	["29998:30080:7"] = { lobby = true },
	["29998:30081:7"] = { goto = { 30000, 30090, 7 }, label = "Bestiariusz: Dragon" },
	["29998:30089:7"] = { goto = { 30000, 30080, 7 }, label = "Bestiariusz: Demon" },
	["29998:30090:7"] = { lobby = true },
	["29998:30091:7"] = { goto = { 30000, 30100, 7 }, label = "Bestiariusz: Elemental" },
	["29998:30099:7"] = { goto = { 30000, 30090, 7 }, label = "Bestiariusz: Dragon" },
	["29998:30100:7"] = { lobby = true },
	["29998:30101:7"] = { goto = { 30000, 30110, 7 }, label = "Bestiariusz: Extra Dimensional" },
	["29998:30109:7"] = { goto = { 30000, 30100, 7 }, label = "Bestiariusz: Elemental" },
	["29998:30110:7"] = { lobby = true },
	["29998:30111:7"] = { goto = { 30000, 30120, 7 }, label = "Bestiariusz: Fey" },
	["29998:30119:7"] = { goto = { 30000, 30110, 7 }, label = "Bestiariusz: Extra Dimensional" },
	["29998:30120:7"] = { lobby = true },
	["29998:30121:7"] = { goto = { 30000, 30130, 7 }, label = "Bestiariusz: Giant" },
	["29998:30129:7"] = { goto = { 30000, 30120, 7 }, label = "Bestiariusz: Fey" },
	["29998:30130:7"] = { lobby = true },
	["29998:30131:7"] = { goto = { 30000, 30140, 7 }, label = "Bestiariusz: Human 1/2" },
	["29998:30139:7"] = { goto = { 30000, 30130, 7 }, label = "Bestiariusz: Giant" },
	["29998:30140:7"] = { lobby = true },
	["29998:30141:7"] = { goto = { 30000, 30150, 7 }, label = "Bestiariusz: Human 2/2" },
	["29998:30149:7"] = { goto = { 30000, 30140, 7 }, label = "Bestiariusz: Human 1/2" },
	["29998:30150:7"] = { lobby = true },
	["29998:30151:7"] = { goto = { 30000, 30160, 7 }, label = "Bestiariusz: Humanoid 1/2" },
	["29998:30159:7"] = { goto = { 30000, 30150, 7 }, label = "Bestiariusz: Human 2/2" },
	["29998:30160:7"] = { lobby = true },
	["29998:30161:7"] = { goto = { 30000, 30170, 7 }, label = "Bestiariusz: Humanoid 2/2" },
	["29998:30169:7"] = { goto = { 30000, 30160, 7 }, label = "Bestiariusz: Humanoid 1/2" },
	["29998:30170:7"] = { lobby = true },
	["29998:30171:7"] = { goto = { 30000, 30180, 7 }, label = "Bestiariusz: Lycanthrope" },
	["29998:30179:7"] = { goto = { 30000, 30170, 7 }, label = "Bestiariusz: Humanoid 2/2" },
	["29998:30180:7"] = { lobby = true },
	["29998:30181:7"] = { goto = { 30000, 30190, 7 }, label = "Bestiariusz: Magical 1/2" },
	["29998:30189:7"] = { goto = { 30000, 30180, 7 }, label = "Bestiariusz: Lycanthrope" },
	["29998:30190:7"] = { lobby = true },
	["29998:30191:7"] = { goto = { 30000, 30200, 7 }, label = "Bestiariusz: Magical 2/2" },
	["29998:30199:7"] = { goto = { 30000, 30190, 7 }, label = "Bestiariusz: Magical 1/2" },
	["29998:30200:7"] = { lobby = true },
	["29998:30201:7"] = { goto = { 30000, 30210, 7 }, label = "Bestiariusz: Mammal" },
	["29998:30209:7"] = { goto = { 30000, 30200, 7 }, label = "Bestiariusz: Magical 2/2" },
	["29998:30210:7"] = { lobby = true },
	["29998:30211:7"] = { goto = { 30000, 30220, 7 }, label = "Bestiariusz: Plant" },
	["29998:30219:7"] = { goto = { 30000, 30210, 7 }, label = "Bestiariusz: Mammal" },
	["29998:30220:7"] = { lobby = true },
	["29998:30221:7"] = { goto = { 30000, 30230, 7 }, label = "Bestiariusz: Reptile" },
	["29998:30229:7"] = { goto = { 30000, 30220, 7 }, label = "Bestiariusz: Plant" },
	["29998:30230:7"] = { lobby = true },
	["29998:30231:7"] = { goto = { 30000, 30240, 7 }, label = "Bestiariusz: Slime" },
	["29998:30239:7"] = { goto = { 30000, 30230, 7 }, label = "Bestiariusz: Reptile" },
	["29998:30240:7"] = { lobby = true },
	["29998:30241:7"] = { goto = { 30000, 30250, 7 }, label = "Bestiariusz: Undead 1/2" },
	["29998:30249:7"] = { goto = { 30000, 30240, 7 }, label = "Bestiariusz: Slime" },
	["29998:30250:7"] = { lobby = true },
	["29998:30251:7"] = { goto = { 30000, 30260, 7 }, label = "Bestiariusz: Undead 2/2" },
	["29998:30259:7"] = { goto = { 30000, 30250, 7 }, label = "Bestiariusz: Undead 1/2" },
	["29998:30260:7"] = { lobby = true },
	["29998:30261:7"] = { goto = { 30000, 30270, 7 }, label = "Bestiariusz: Vermin 1/2" },
	["29998:30269:7"] = { goto = { 30000, 30260, 7 }, label = "Bestiariusz: Undead 2/2" },
	["29998:30270:7"] = { lobby = true },
	["29998:30271:7"] = { goto = { 30000, 30280, 7 }, label = "Bestiariusz: Vermin 2/2" },
	["29998:30279:7"] = { goto = { 30000, 30270, 7 }, label = "Bestiariusz: Vermin 1/2" },
	["29998:30280:7"] = { lobby = true },
	["29998:30281:7"] = { goto = { 30000, 30040, 7 }, label = "Bestiariusz: Amphibic" },
	["30000:29998:7"] = { bossrush = true },
	["30001:30002:7"] = { survival = true },
	["30002:29888:7"] = { boss = bosses[171] },
	["30002:29892:7"] = { boss = bosses[189] },
	["30002:29898:7"] = { boss = bosses[134] },
	["30002:29902:7"] = { boss = bosses[153] },
	["30002:29908:7"] = { boss = bosses[97] },
	["30002:29912:7"] = { boss = bosses[116] },
	["30002:29918:7"] = { boss = bosses[60] },
	["30002:29922:7"] = { boss = bosses[79] },
	["30002:29928:7"] = { boss = bosses[31] },
	["30002:29932:7"] = { boss = bosses[46] },
	["30002:29938:7"] = { boss = bosses[1] },
	["30002:29942:7"] = { boss = bosses[16] },
	["30002:29958:7"] = { quest = quests[1] },
	["30002:29962:7"] = { quest = quests[14] },
	["30002:30038:7"] = { hunt = hubHunts[1].list[1] },
	["30002:30042:7"] = { hunt = hubHunts[1].list[5] },
	["30002:30048:7"] = { hunt = hubHunts[1].list[8] },
	["30002:30052:7"] = { hunt = hubHunts[1].list[19] },
	["30002:30058:7"] = { hunt = hubHunts[1].list[29] },
	["30002:30062:7"] = { hunt = hubHunts[1].list[32] },
	["30002:30068:7"] = { hunt = hubHunts[1].list[35] },
	["30002:30072:7"] = { hunt = hubHunts[1].list[49] },
	["30002:30078:7"] = { hunt = hubHunts[1].list[62] },
	["30002:30082:7"] = { hunt = hubHunts[1].list[79] },
	["30002:30088:7"] = { hunt = hubHunts[1].list[96] },
	["30002:30092:7"] = { hunt = hubHunts[1].list[106] },
	["30002:30098:7"] = { hunt = hubHunts[1].list[115] },
	["30002:30102:7"] = { hunt = hubHunts[1].list[124] },
	["30002:30108:7"] = { hunt = hubHunts[1].list[133] },
	["30002:30112:7"] = { hunt = hubHunts[1].list[138] },
	["30002:30118:7"] = { hunt = hubHunts[1].list[143] },
	["30002:30122:7"] = { hunt = hubHunts[1].list[149] },
	["30002:30128:7"] = { hunt = hubHunts[1].list[155] },
	["30002:30132:7"] = { hunt = hubHunts[1].list[163] },
	["30002:30138:7"] = { hunt = hubHunts[1].list[170] },
	["30002:30142:7"] = { hunt = hubHunts[1].list[185] },
	["30002:30148:7"] = { hunt = hubHunts[1].list[200] },
	["30002:30152:7"] = { hunt = hubHunts[1].list[215] },
	["30002:30158:7"] = { hunt = hubHunts[1].list[229] },
	["30002:30162:7"] = { hunt = hubHunts[1].list[249] },
	["30002:30168:7"] = { hunt = hubHunts[1].list[269] },
	["30002:30172:7"] = { hunt = hubHunts[1].list[289] },
	["30002:30178:7"] = { hunt = hubHunts[1].list[309] },
	["30002:30182:7"] = { hunt = hubHunts[1].list[314] },
	["30002:30188:7"] = { hunt = hubHunts[1].list[318] },
	["30002:30192:7"] = { hunt = hubHunts[1].list[332] },
	["30002:30198:7"] = { hunt = hubHunts[1].list[346] },
	["30002:30202:7"] = { hunt = hubHunts[1].list[360] },
	["30002:30208:7"] = { hunt = hubHunts[1].list[374] },
	["30002:30212:7"] = { hunt = hubHunts[1].list[390] },
	["30002:30218:7"] = { hunt = hubHunts[1].list[406] },
	["30002:30222:7"] = { hunt = hubHunts[1].list[413] },
	["30002:30228:7"] = { hunt = hubHunts[1].list[420] },
	["30002:30232:7"] = { hunt = hubHunts[1].list[435] },
	["30002:30238:7"] = { hunt = hubHunts[1].list[449] },
	["30002:30242:7"] = { hunt = hubHunts[1].list[454] },
	["30002:30248:7"] = { hunt = hubHunts[1].list[459] },
	["30002:30252:7"] = { hunt = hubHunts[1].list[476] },
	["30002:30258:7"] = { hunt = hubHunts[1].list[492] },
	["30002:30262:7"] = { hunt = hubHunts[1].list[508] },
	["30002:30268:7"] = { hunt = hubHunts[1].list[524] },
	["30002:30272:7"] = { hunt = hubHunts[1].list[537] },
	["30002:30278:7"] = { hunt = hubHunts[1].list[549] },
	["30002:30282:7"] = { hunt = hubHunts[1].list[562] },
	["30003:29888:7"] = { boss = bosses[172] },
	["30003:29892:7"] = { boss = bosses[190] },
	["30003:29898:7"] = { boss = bosses[135] },
	["30003:29902:7"] = { boss = bosses[154] },
	["30003:29908:7"] = { boss = bosses[98] },
	["30003:29912:7"] = { boss = bosses[117] },
	["30003:29918:7"] = { boss = bosses[61] },
	["30003:29922:7"] = { boss = bosses[80] },
	["30003:29928:7"] = { boss = bosses[32] },
	["30003:29932:7"] = { boss = bosses[47] },
	["30003:29938:7"] = { boss = bosses[2] },
	["30003:29942:7"] = { boss = bosses[17] },
	["30003:29958:7"] = { quest = quests[2] },
	["30003:29962:7"] = { quest = quests[15] },
	["30003:30038:7"] = { hunt = hubHunts[1].list[2] },
	["30003:30042:7"] = { hunt = hubHunts[1].list[6] },
	["30003:30048:7"] = { hunt = hubHunts[1].list[9] },
	["30003:30052:7"] = { hunt = hubHunts[1].list[20] },
	["30003:30058:7"] = { hunt = hubHunts[1].list[30] },
	["30003:30062:7"] = { hunt = hubHunts[1].list[33] },
	["30003:30068:7"] = { hunt = hubHunts[1].list[36] },
	["30003:30072:7"] = { hunt = hubHunts[1].list[50] },
	["30003:30078:7"] = { hunt = hubHunts[1].list[63] },
	["30003:30082:7"] = { hunt = hubHunts[1].list[80] },
	["30003:30088:7"] = { hunt = hubHunts[1].list[97] },
	["30003:30092:7"] = { hunt = hubHunts[1].list[107] },
	["30003:30098:7"] = { hunt = hubHunts[1].list[116] },
	["30003:30102:7"] = { hunt = hubHunts[1].list[125] },
	["30003:30108:7"] = { hunt = hubHunts[1].list[134] },
	["30003:30112:7"] = { hunt = hubHunts[1].list[139] },
	["30003:30118:7"] = { hunt = hubHunts[1].list[144] },
	["30003:30122:7"] = { hunt = hubHunts[1].list[150] },
	["30003:30128:7"] = { hunt = hubHunts[1].list[156] },
	["30003:30132:7"] = { hunt = hubHunts[1].list[164] },
	["30003:30138:7"] = { hunt = hubHunts[1].list[171] },
	["30003:30142:7"] = { hunt = hubHunts[1].list[186] },
	["30003:30148:7"] = { hunt = hubHunts[1].list[201] },
	["30003:30152:7"] = { hunt = hubHunts[1].list[216] },
	["30003:30158:7"] = { hunt = hubHunts[1].list[230] },
	["30003:30162:7"] = { hunt = hubHunts[1].list[250] },
	["30003:30168:7"] = { hunt = hubHunts[1].list[270] },
	["30003:30172:7"] = { hunt = hubHunts[1].list[290] },
	["30003:30178:7"] = { hunt = hubHunts[1].list[310] },
	["30003:30182:7"] = { hunt = hubHunts[1].list[315] },
	["30003:30188:7"] = { hunt = hubHunts[1].list[319] },
	["30003:30192:7"] = { hunt = hubHunts[1].list[333] },
	["30003:30198:7"] = { hunt = hubHunts[1].list[347] },
	["30003:30202:7"] = { hunt = hubHunts[1].list[361] },
	["30003:30208:7"] = { hunt = hubHunts[1].list[375] },
	["30003:30212:7"] = { hunt = hubHunts[1].list[391] },
	["30003:30218:7"] = { hunt = hubHunts[1].list[407] },
	["30003:30222:7"] = { hunt = hubHunts[1].list[414] },
	["30003:30228:7"] = { hunt = hubHunts[1].list[421] },
	["30003:30232:7"] = { hunt = hubHunts[1].list[436] },
	["30003:30238:7"] = { hunt = hubHunts[1].list[450] },
	["30003:30242:7"] = { hunt = hubHunts[1].list[455] },
	["30003:30248:7"] = { hunt = hubHunts[1].list[460] },
	["30003:30252:7"] = { hunt = hubHunts[1].list[477] },
	["30003:30258:7"] = { hunt = hubHunts[1].list[493] },
	["30003:30262:7"] = { hunt = hubHunts[1].list[509] },
	["30003:30268:7"] = { hunt = hubHunts[1].list[525] },
	["30003:30272:7"] = { hunt = hubHunts[1].list[538] },
	["30003:30278:7"] = { hunt = hubHunts[1].list[550] },
	["30003:30282:7"] = { hunt = hubHunts[1].list[563] },
	["30004:29888:7"] = { boss = bosses[173] },
	["30004:29892:7"] = { boss = bosses[191] },
	["30004:29898:7"] = { boss = bosses[136] },
	["30004:29902:7"] = { boss = bosses[155] },
	["30004:29908:7"] = { boss = bosses[99] },
	["30004:29912:7"] = { boss = bosses[118] },
	["30004:29918:7"] = { boss = bosses[62] },
	["30004:29922:7"] = { boss = bosses[81] },
	["30004:29928:7"] = { boss = bosses[33] },
	["30004:29932:7"] = { boss = bosses[48] },
	["30004:29938:7"] = { boss = bosses[3] },
	["30004:29942:7"] = { boss = bosses[18] },
	["30004:29958:7"] = { quest = quests[3] },
	["30004:29962:7"] = { quest = quests[16] },
	["30004:29998:7"] = { wing = 1 },
	["30004:30038:7"] = { hunt = hubHunts[1].list[3] },
	["30004:30042:7"] = { hunt = hubHunts[1].list[7] },
	["30004:30048:7"] = { hunt = hubHunts[1].list[10] },
	["30004:30052:7"] = { hunt = hubHunts[1].list[21] },
	["30004:30058:7"] = { hunt = hubHunts[1].list[31] },
	["30004:30062:7"] = { hunt = hubHunts[1].list[34] },
	["30004:30068:7"] = { hunt = hubHunts[1].list[37] },
	["30004:30072:7"] = { hunt = hubHunts[1].list[51] },
	["30004:30078:7"] = { hunt = hubHunts[1].list[64] },
	["30004:30082:7"] = { hunt = hubHunts[1].list[81] },
	["30004:30088:7"] = { hunt = hubHunts[1].list[98] },
	["30004:30092:7"] = { hunt = hubHunts[1].list[108] },
	["30004:30098:7"] = { hunt = hubHunts[1].list[117] },
	["30004:30102:7"] = { hunt = hubHunts[1].list[126] },
	["30004:30108:7"] = { hunt = hubHunts[1].list[135] },
	["30004:30112:7"] = { hunt = hubHunts[1].list[140] },
	["30004:30118:7"] = { hunt = hubHunts[1].list[145] },
	["30004:30122:7"] = { hunt = hubHunts[1].list[151] },
	["30004:30128:7"] = { hunt = hubHunts[1].list[157] },
	["30004:30132:7"] = { hunt = hubHunts[1].list[165] },
	["30004:30138:7"] = { hunt = hubHunts[1].list[172] },
	["30004:30142:7"] = { hunt = hubHunts[1].list[187] },
	["30004:30148:7"] = { hunt = hubHunts[1].list[202] },
	["30004:30152:7"] = { hunt = hubHunts[1].list[217] },
	["30004:30158:7"] = { hunt = hubHunts[1].list[231] },
	["30004:30162:7"] = { hunt = hubHunts[1].list[251] },
	["30004:30168:7"] = { hunt = hubHunts[1].list[271] },
	["30004:30172:7"] = { hunt = hubHunts[1].list[291] },
	["30004:30178:7"] = { hunt = hubHunts[1].list[311] },
	["30004:30182:7"] = { hunt = hubHunts[1].list[316] },
	["30004:30188:7"] = { hunt = hubHunts[1].list[320] },
	["30004:30192:7"] = { hunt = hubHunts[1].list[334] },
	["30004:30198:7"] = { hunt = hubHunts[1].list[348] },
	["30004:30202:7"] = { hunt = hubHunts[1].list[362] },
	["30004:30208:7"] = { hunt = hubHunts[1].list[376] },
	["30004:30212:7"] = { hunt = hubHunts[1].list[392] },
	["30004:30218:7"] = { hunt = hubHunts[1].list[408] },
	["30004:30222:7"] = { hunt = hubHunts[1].list[415] },
	["30004:30228:7"] = { hunt = hubHunts[1].list[422] },
	["30004:30232:7"] = { hunt = hubHunts[1].list[437] },
	["30004:30238:7"] = { hunt = hubHunts[1].list[451] },
	["30004:30242:7"] = { hunt = hubHunts[1].list[456] },
	["30004:30248:7"] = { hunt = hubHunts[1].list[461] },
	["30004:30252:7"] = { hunt = hubHunts[1].list[478] },
	["30004:30258:7"] = { hunt = hubHunts[1].list[494] },
	["30004:30262:7"] = { hunt = hubHunts[1].list[510] },
	["30004:30268:7"] = { hunt = hubHunts[1].list[526] },
	["30004:30272:7"] = { hunt = hubHunts[1].list[539] },
	["30004:30278:7"] = { hunt = hubHunts[1].list[551] },
	["30004:30282:7"] = { hunt = hubHunts[1].list[564] },
	["30005:29888:7"] = { boss = bosses[174] },
	["30005:29892:7"] = { boss = bosses[192] },
	["30005:29898:7"] = { boss = bosses[137] },
	["30005:29902:7"] = { boss = bosses[156] },
	["30005:29908:7"] = { boss = bosses[100] },
	["30005:29912:7"] = { boss = bosses[119] },
	["30005:29918:7"] = { boss = bosses[63] },
	["30005:29922:7"] = { boss = bosses[82] },
	["30005:29928:7"] = { boss = bosses[34] },
	["30005:29932:7"] = { boss = bosses[49] },
	["30005:29938:7"] = { boss = bosses[4] },
	["30005:29942:7"] = { boss = bosses[19] },
	["30005:29958:7"] = { quest = quests[4] },
	["30005:29962:7"] = { quest = quests[17] },
	["30005:30002:7"] = { randomboss = true },
	["30005:30038:7"] = { hunt = hubHunts[1].list[4] },
	["30005:30048:7"] = { hunt = hubHunts[1].list[11] },
	["30005:30052:7"] = { hunt = hubHunts[1].list[22] },
	["30005:30068:7"] = { hunt = hubHunts[1].list[38] },
	["30005:30072:7"] = { hunt = hubHunts[1].list[52] },
	["30005:30078:7"] = { hunt = hubHunts[1].list[65] },
	["30005:30082:7"] = { hunt = hubHunts[1].list[82] },
	["30005:30088:7"] = { hunt = hubHunts[1].list[99] },
	["30005:30092:7"] = { hunt = hubHunts[1].list[109] },
	["30005:30098:7"] = { hunt = hubHunts[1].list[118] },
	["30005:30102:7"] = { hunt = hubHunts[1].list[127] },
	["30005:30108:7"] = { hunt = hubHunts[1].list[136] },
	["30005:30112:7"] = { hunt = hubHunts[1].list[141] },
	["30005:30118:7"] = { hunt = hubHunts[1].list[146] },
	["30005:30122:7"] = { hunt = hubHunts[1].list[152] },
	["30005:30128:7"] = { hunt = hubHunts[1].list[158] },
	["30005:30132:7"] = { hunt = hubHunts[1].list[166] },
	["30005:30138:7"] = { hunt = hubHunts[1].list[173] },
	["30005:30142:7"] = { hunt = hubHunts[1].list[188] },
	["30005:30148:7"] = { hunt = hubHunts[1].list[203] },
	["30005:30152:7"] = { hunt = hubHunts[1].list[218] },
	["30005:30158:7"] = { hunt = hubHunts[1].list[232] },
	["30005:30162:7"] = { hunt = hubHunts[1].list[252] },
	["30005:30168:7"] = { hunt = hubHunts[1].list[272] },
	["30005:30172:7"] = { hunt = hubHunts[1].list[292] },
	["30005:30178:7"] = { hunt = hubHunts[1].list[312] },
	["30005:30182:7"] = { hunt = hubHunts[1].list[317] },
	["30005:30188:7"] = { hunt = hubHunts[1].list[321] },
	["30005:30192:7"] = { hunt = hubHunts[1].list[335] },
	["30005:30198:7"] = { hunt = hubHunts[1].list[349] },
	["30005:30202:7"] = { hunt = hubHunts[1].list[363] },
	["30005:30208:7"] = { hunt = hubHunts[1].list[377] },
	["30005:30212:7"] = { hunt = hubHunts[1].list[393] },
	["30005:30218:7"] = { hunt = hubHunts[1].list[409] },
	["30005:30222:7"] = { hunt = hubHunts[1].list[416] },
	["30005:30228:7"] = { hunt = hubHunts[1].list[423] },
	["30005:30232:7"] = { hunt = hubHunts[1].list[438] },
	["30005:30238:7"] = { hunt = hubHunts[1].list[452] },
	["30005:30242:7"] = { hunt = hubHunts[1].list[457] },
	["30005:30248:7"] = { hunt = hubHunts[1].list[462] },
	["30005:30252:7"] = { hunt = hubHunts[1].list[479] },
	["30005:30258:7"] = { hunt = hubHunts[1].list[495] },
	["30005:30262:7"] = { hunt = hubHunts[1].list[511] },
	["30005:30268:7"] = { hunt = hubHunts[1].list[527] },
	["30005:30272:7"] = { hunt = hubHunts[1].list[540] },
	["30005:30278:7"] = { hunt = hubHunts[1].list[552] },
	["30005:30282:7"] = { hunt = hubHunts[1].list[565] },
	["30006:29888:7"] = { boss = bosses[175] },
	["30006:29892:7"] = { boss = bosses[193] },
	["30006:29898:7"] = { boss = bosses[138] },
	["30006:29902:7"] = { boss = bosses[157] },
	["30006:29908:7"] = { boss = bosses[101] },
	["30006:29912:7"] = { boss = bosses[120] },
	["30006:29918:7"] = { boss = bosses[64] },
	["30006:29922:7"] = { boss = bosses[83] },
	["30006:29928:7"] = { boss = bosses[35] },
	["30006:29932:7"] = { boss = bosses[50] },
	["30006:29938:7"] = { boss = bosses[5] },
	["30006:29942:7"] = { boss = bosses[20] },
	["30006:29958:7"] = { quest = quests[5] },
	["30006:29962:7"] = { quest = quests[18] },
	["30006:30048:7"] = { hunt = hubHunts[1].list[12] },
	["30006:30052:7"] = { hunt = hubHunts[1].list[23] },
	["30006:30068:7"] = { hunt = hubHunts[1].list[39] },
	["30006:30072:7"] = { hunt = hubHunts[1].list[53] },
	["30006:30078:7"] = { hunt = hubHunts[1].list[66] },
	["30006:30082:7"] = { hunt = hubHunts[1].list[83] },
	["30006:30088:7"] = { hunt = hubHunts[1].list[100] },
	["30006:30092:7"] = { hunt = hubHunts[1].list[110] },
	["30006:30098:7"] = { hunt = hubHunts[1].list[119] },
	["30006:30102:7"] = { hunt = hubHunts[1].list[128] },
	["30006:30108:7"] = { hunt = hubHunts[1].list[137] },
	["30006:30112:7"] = { hunt = hubHunts[1].list[142] },
	["30006:30118:7"] = { hunt = hubHunts[1].list[147] },
	["30006:30122:7"] = { hunt = hubHunts[1].list[153] },
	["30006:30128:7"] = { hunt = hubHunts[1].list[159] },
	["30006:30132:7"] = { hunt = hubHunts[1].list[167] },
	["30006:30138:7"] = { hunt = hubHunts[1].list[174] },
	["30006:30142:7"] = { hunt = hubHunts[1].list[189] },
	["30006:30148:7"] = { hunt = hubHunts[1].list[204] },
	["30006:30152:7"] = { hunt = hubHunts[1].list[219] },
	["30006:30158:7"] = { hunt = hubHunts[1].list[233] },
	["30006:30162:7"] = { hunt = hubHunts[1].list[253] },
	["30006:30168:7"] = { hunt = hubHunts[1].list[273] },
	["30006:30172:7"] = { hunt = hubHunts[1].list[293] },
	["30006:30178:7"] = { hunt = hubHunts[1].list[313] },
	["30006:30188:7"] = { hunt = hubHunts[1].list[322] },
	["30006:30192:7"] = { hunt = hubHunts[1].list[336] },
	["30006:30198:7"] = { hunt = hubHunts[1].list[350] },
	["30006:30202:7"] = { hunt = hubHunts[1].list[364] },
	["30006:30208:7"] = { hunt = hubHunts[1].list[378] },
	["30006:30212:7"] = { hunt = hubHunts[1].list[394] },
	["30006:30218:7"] = { hunt = hubHunts[1].list[410] },
	["30006:30222:7"] = { hunt = hubHunts[1].list[417] },
	["30006:30228:7"] = { hunt = hubHunts[1].list[424] },
	["30006:30232:7"] = { hunt = hubHunts[1].list[439] },
	["30006:30238:7"] = { hunt = hubHunts[1].list[453] },
	["30006:30242:7"] = { hunt = hubHunts[1].list[458] },
	["30006:30248:7"] = { hunt = hubHunts[1].list[463] },
	["30006:30252:7"] = { hunt = hubHunts[1].list[480] },
	["30006:30258:7"] = { hunt = hubHunts[1].list[496] },
	["30006:30262:7"] = { hunt = hubHunts[1].list[512] },
	["30006:30268:7"] = { hunt = hubHunts[1].list[528] },
	["30006:30272:7"] = { hunt = hubHunts[1].list[541] },
	["30006:30278:7"] = { hunt = hubHunts[1].list[553] },
	["30006:30282:7"] = { hunt = hubHunts[1].list[566] },
	["30007:29888:7"] = { boss = bosses[176] },
	["30007:29892:7"] = { boss = bosses[194] },
	["30007:29898:7"] = { boss = bosses[139] },
	["30007:29902:7"] = { boss = bosses[158] },
	["30007:29908:7"] = { boss = bosses[102] },
	["30007:29912:7"] = { boss = bosses[121] },
	["30007:29918:7"] = { boss = bosses[65] },
	["30007:29922:7"] = { boss = bosses[84] },
	["30007:29928:7"] = { boss = bosses[36] },
	["30007:29932:7"] = { boss = bosses[51] },
	["30007:29938:7"] = { boss = bosses[6] },
	["30007:29942:7"] = { boss = bosses[21] },
	["30007:29958:7"] = { quest = quests[6] },
	["30007:29962:7"] = { quest = quests[19] },
	["30007:29998:7"] = { bestiary = true },
	["30007:30048:7"] = { hunt = hubHunts[1].list[13] },
	["30007:30052:7"] = { hunt = hubHunts[1].list[24] },
	["30007:30068:7"] = { hunt = hubHunts[1].list[40] },
	["30007:30072:7"] = { hunt = hubHunts[1].list[54] },
	["30007:30078:7"] = { hunt = hubHunts[1].list[67] },
	["30007:30082:7"] = { hunt = hubHunts[1].list[84] },
	["30007:30088:7"] = { hunt = hubHunts[1].list[101] },
	["30007:30092:7"] = { hunt = hubHunts[1].list[111] },
	["30007:30098:7"] = { hunt = hubHunts[1].list[120] },
	["30007:30102:7"] = { hunt = hubHunts[1].list[129] },
	["30007:30118:7"] = { hunt = hubHunts[1].list[148] },
	["30007:30122:7"] = { hunt = hubHunts[1].list[154] },
	["30007:30128:7"] = { hunt = hubHunts[1].list[160] },
	["30007:30132:7"] = { hunt = hubHunts[1].list[168] },
	["30007:30138:7"] = { hunt = hubHunts[1].list[175] },
	["30007:30142:7"] = { hunt = hubHunts[1].list[190] },
	["30007:30148:7"] = { hunt = hubHunts[1].list[205] },
	["30007:30152:7"] = { hunt = hubHunts[1].list[220] },
	["30007:30158:7"] = { hunt = hubHunts[1].list[234] },
	["30007:30162:7"] = { hunt = hubHunts[1].list[254] },
	["30007:30168:7"] = { hunt = hubHunts[1].list[274] },
	["30007:30172:7"] = { hunt = hubHunts[1].list[294] },
	["30007:30188:7"] = { hunt = hubHunts[1].list[323] },
	["30007:30192:7"] = { hunt = hubHunts[1].list[337] },
	["30007:30198:7"] = { hunt = hubHunts[1].list[351] },
	["30007:30202:7"] = { hunt = hubHunts[1].list[365] },
	["30007:30208:7"] = { hunt = hubHunts[1].list[379] },
	["30007:30212:7"] = { hunt = hubHunts[1].list[395] },
	["30007:30218:7"] = { hunt = hubHunts[1].list[411] },
	["30007:30222:7"] = { hunt = hubHunts[1].list[418] },
	["30007:30228:7"] = { hunt = hubHunts[1].list[425] },
	["30007:30232:7"] = { hunt = hubHunts[1].list[440] },
	["30007:30248:7"] = { hunt = hubHunts[1].list[464] },
	["30007:30252:7"] = { hunt = hubHunts[1].list[481] },
	["30007:30258:7"] = { hunt = hubHunts[1].list[497] },
	["30007:30262:7"] = { hunt = hubHunts[1].list[513] },
	["30007:30268:7"] = { hunt = hubHunts[1].list[529] },
	["30007:30272:7"] = { hunt = hubHunts[1].list[542] },
	["30007:30278:7"] = { hunt = hubHunts[1].list[554] },
	["30007:30282:7"] = { hunt = hubHunts[1].list[567] },
	["30008:29888:7"] = { boss = bosses[177] },
	["30008:29892:7"] = { boss = bosses[195] },
	["30008:29898:7"] = { boss = bosses[140] },
	["30008:29902:7"] = { boss = bosses[159] },
	["30008:29908:7"] = { boss = bosses[103] },
	["30008:29912:7"] = { boss = bosses[122] },
	["30008:29918:7"] = { boss = bosses[66] },
	["30008:29922:7"] = { boss = bosses[85] },
	["30008:29928:7"] = { boss = bosses[37] },
	["30008:29932:7"] = { boss = bosses[52] },
	["30008:29938:7"] = { boss = bosses[7] },
	["30008:29942:7"] = { boss = bosses[22] },
	["30008:29958:7"] = { quest = quests[7] },
	["30008:29962:7"] = { quest = quests[20] },
	["30008:30048:7"] = { hunt = hubHunts[1].list[14] },
	["30008:30052:7"] = { hunt = hubHunts[1].list[25] },
	["30008:30068:7"] = { hunt = hubHunts[1].list[41] },
	["30008:30072:7"] = { hunt = hubHunts[1].list[55] },
	["30008:30078:7"] = { hunt = hubHunts[1].list[68] },
	["30008:30082:7"] = { hunt = hubHunts[1].list[85] },
	["30008:30088:7"] = { hunt = hubHunts[1].list[102] },
	["30008:30092:7"] = { hunt = hubHunts[1].list[112] },
	["30008:30098:7"] = { hunt = hubHunts[1].list[121] },
	["30008:30102:7"] = { hunt = hubHunts[1].list[130] },
	["30008:30128:7"] = { hunt = hubHunts[1].list[161] },
	["30008:30132:7"] = { hunt = hubHunts[1].list[169] },
	["30008:30138:7"] = { hunt = hubHunts[1].list[176] },
	["30008:30142:7"] = { hunt = hubHunts[1].list[191] },
	["30008:30148:7"] = { hunt = hubHunts[1].list[206] },
	["30008:30152:7"] = { hunt = hubHunts[1].list[221] },
	["30008:30158:7"] = { hunt = hubHunts[1].list[235] },
	["30008:30162:7"] = { hunt = hubHunts[1].list[255] },
	["30008:30168:7"] = { hunt = hubHunts[1].list[275] },
	["30008:30172:7"] = { hunt = hubHunts[1].list[295] },
	["30008:30188:7"] = { hunt = hubHunts[1].list[324] },
	["30008:30192:7"] = { hunt = hubHunts[1].list[338] },
	["30008:30198:7"] = { hunt = hubHunts[1].list[352] },
	["30008:30202:7"] = { hunt = hubHunts[1].list[366] },
	["30008:30208:7"] = { hunt = hubHunts[1].list[380] },
	["30008:30212:7"] = { hunt = hubHunts[1].list[396] },
	["30008:30218:7"] = { hunt = hubHunts[1].list[412] },
	["30008:30222:7"] = { hunt = hubHunts[1].list[419] },
	["30008:30228:7"] = { hunt = hubHunts[1].list[426] },
	["30008:30232:7"] = { hunt = hubHunts[1].list[441] },
	["30008:30248:7"] = { hunt = hubHunts[1].list[465] },
	["30008:30252:7"] = { hunt = hubHunts[1].list[482] },
	["30008:30258:7"] = { hunt = hubHunts[1].list[498] },
	["30008:30262:7"] = { hunt = hubHunts[1].list[514] },
	["30008:30268:7"] = { hunt = hubHunts[1].list[530] },
	["30008:30272:7"] = { hunt = hubHunts[1].list[543] },
	["30008:30278:7"] = { hunt = hubHunts[1].list[555] },
	["30008:30282:7"] = { hunt = hubHunts[1].list[568] },
	["30009:29888:7"] = { boss = bosses[178] },
	["30009:29892:7"] = { boss = bosses[196] },
	["30009:29898:7"] = { boss = bosses[141] },
	["30009:29902:7"] = { boss = bosses[160] },
	["30009:29908:7"] = { boss = bosses[104] },
	["30009:29912:7"] = { boss = bosses[123] },
	["30009:29918:7"] = { boss = bosses[67] },
	["30009:29922:7"] = { boss = bosses[86] },
	["30009:29928:7"] = { boss = bosses[38] },
	["30009:29932:7"] = { boss = bosses[53] },
	["30009:29938:7"] = { boss = bosses[8] },
	["30009:29942:7"] = { boss = bosses[23] },
	["30009:29958:7"] = { quest = quests[8] },
	["30009:29962:7"] = { quest = quests[21] },
	["30009:30002:7"] = { outfits = true },
	["30009:30048:7"] = { hunt = hubHunts[1].list[15] },
	["30009:30052:7"] = { hunt = hubHunts[1].list[26] },
	["30009:30068:7"] = { hunt = hubHunts[1].list[42] },
	["30009:30072:7"] = { hunt = hubHunts[1].list[56] },
	["30009:30078:7"] = { hunt = hubHunts[1].list[69] },
	["30009:30082:7"] = { hunt = hubHunts[1].list[86] },
	["30009:30088:7"] = { hunt = hubHunts[1].list[103] },
	["30009:30092:7"] = { hunt = hubHunts[1].list[113] },
	["30009:30098:7"] = { hunt = hubHunts[1].list[122] },
	["30009:30102:7"] = { hunt = hubHunts[1].list[131] },
	["30009:30128:7"] = { hunt = hubHunts[1].list[162] },
	["30009:30138:7"] = { hunt = hubHunts[1].list[177] },
	["30009:30142:7"] = { hunt = hubHunts[1].list[192] },
	["30009:30148:7"] = { hunt = hubHunts[1].list[207] },
	["30009:30152:7"] = { hunt = hubHunts[1].list[222] },
	["30009:30158:7"] = { hunt = hubHunts[1].list[236] },
	["30009:30162:7"] = { hunt = hubHunts[1].list[256] },
	["30009:30168:7"] = { hunt = hubHunts[1].list[276] },
	["30009:30172:7"] = { hunt = hubHunts[1].list[296] },
	["30009:30188:7"] = { hunt = hubHunts[1].list[325] },
	["30009:30192:7"] = { hunt = hubHunts[1].list[339] },
	["30009:30198:7"] = { hunt = hubHunts[1].list[353] },
	["30009:30202:7"] = { hunt = hubHunts[1].list[367] },
	["30009:30208:7"] = { hunt = hubHunts[1].list[381] },
	["30009:30212:7"] = { hunt = hubHunts[1].list[397] },
	["30009:30228:7"] = { hunt = hubHunts[1].list[427] },
	["30009:30232:7"] = { hunt = hubHunts[1].list[442] },
	["30009:30248:7"] = { hunt = hubHunts[1].list[466] },
	["30009:30252:7"] = { hunt = hubHunts[1].list[483] },
	["30009:30258:7"] = { hunt = hubHunts[1].list[499] },
	["30009:30262:7"] = { hunt = hubHunts[1].list[515] },
	["30009:30268:7"] = { hunt = hubHunts[1].list[531] },
	["30009:30272:7"] = { hunt = hubHunts[1].list[544] },
	["30009:30278:7"] = { hunt = hubHunts[1].list[556] },
	["30009:30282:7"] = { hunt = hubHunts[1].list[569] },
	["30010:29888:7"] = { boss = bosses[179] },
	["30010:29892:7"] = { boss = bosses[197] },
	["30010:29898:7"] = { boss = bosses[142] },
	["30010:29902:7"] = { boss = bosses[161] },
	["30010:29908:7"] = { boss = bosses[105] },
	["30010:29912:7"] = { boss = bosses[124] },
	["30010:29918:7"] = { boss = bosses[68] },
	["30010:29922:7"] = { boss = bosses[87] },
	["30010:29928:7"] = { boss = bosses[39] },
	["30010:29932:7"] = { boss = bosses[54] },
	["30010:29938:7"] = { boss = bosses[9] },
	["30010:29942:7"] = { boss = bosses[24] },
	["30010:29958:7"] = { quest = quests[9] },
	["30010:29962:7"] = { quest = quests[22] },
	["30010:30048:7"] = { hunt = hubHunts[1].list[16] },
	["30010:30052:7"] = { hunt = hubHunts[1].list[27] },
	["30010:30068:7"] = { hunt = hubHunts[1].list[43] },
	["30010:30072:7"] = { hunt = hubHunts[1].list[57] },
	["30010:30078:7"] = { hunt = hubHunts[1].list[70] },
	["30010:30082:7"] = { hunt = hubHunts[1].list[87] },
	["30010:30088:7"] = { hunt = hubHunts[1].list[104] },
	["30010:30092:7"] = { hunt = hubHunts[1].list[114] },
	["30010:30098:7"] = { hunt = hubHunts[1].list[123] },
	["30010:30102:7"] = { hunt = hubHunts[1].list[132] },
	["30010:30138:7"] = { hunt = hubHunts[1].list[178] },
	["30010:30142:7"] = { hunt = hubHunts[1].list[193] },
	["30010:30148:7"] = { hunt = hubHunts[1].list[208] },
	["30010:30152:7"] = { hunt = hubHunts[1].list[223] },
	["30010:30158:7"] = { hunt = hubHunts[1].list[237] },
	["30010:30162:7"] = { hunt = hubHunts[1].list[257] },
	["30010:30168:7"] = { hunt = hubHunts[1].list[277] },
	["30010:30172:7"] = { hunt = hubHunts[1].list[297] },
	["30010:30188:7"] = { hunt = hubHunts[1].list[326] },
	["30010:30192:7"] = { hunt = hubHunts[1].list[340] },
	["30010:30198:7"] = { hunt = hubHunts[1].list[354] },
	["30010:30202:7"] = { hunt = hubHunts[1].list[368] },
	["30010:30208:7"] = { hunt = hubHunts[1].list[382] },
	["30010:30212:7"] = { hunt = hubHunts[1].list[398] },
	["30010:30228:7"] = { hunt = hubHunts[1].list[428] },
	["30010:30232:7"] = { hunt = hubHunts[1].list[443] },
	["30010:30248:7"] = { hunt = hubHunts[1].list[467] },
	["30010:30252:7"] = { hunt = hubHunts[1].list[484] },
	["30010:30258:7"] = { hunt = hubHunts[1].list[500] },
	["30010:30262:7"] = { hunt = hubHunts[1].list[516] },
	["30010:30268:7"] = { hunt = hubHunts[1].list[532] },
	["30010:30272:7"] = { hunt = hubHunts[1].list[545] },
	["30010:30278:7"] = { hunt = hubHunts[1].list[557] },
	["30010:30282:7"] = { hunt = hubHunts[1].list[570] },
	["30011:29888:7"] = { boss = bosses[180] },
	["30011:29892:7"] = { boss = bosses[198] },
	["30011:29898:7"] = { boss = bosses[143] },
	["30011:29902:7"] = { boss = bosses[162] },
	["30011:29908:7"] = { boss = bosses[106] },
	["30011:29912:7"] = { boss = bosses[125] },
	["30011:29918:7"] = { boss = bosses[69] },
	["30011:29922:7"] = { boss = bosses[88] },
	["30011:29928:7"] = { boss = bosses[40] },
	["30011:29932:7"] = { boss = bosses[55] },
	["30011:29938:7"] = { boss = bosses[10] },
	["30011:29942:7"] = { boss = bosses[25] },
	["30011:29958:7"] = { quest = quests[10] },
	["30011:29962:7"] = { quest = quests[23] },
	["30011:30048:7"] = { hunt = hubHunts[1].list[17] },
	["30011:30052:7"] = { hunt = hubHunts[1].list[28] },
	["30011:30068:7"] = { hunt = hubHunts[1].list[44] },
	["30011:30072:7"] = { hunt = hubHunts[1].list[58] },
	["30011:30078:7"] = { hunt = hubHunts[1].list[71] },
	["30011:30082:7"] = { hunt = hubHunts[1].list[88] },
	["30011:30088:7"] = { hunt = hubHunts[1].list[105] },
	["30011:30138:7"] = { hunt = hubHunts[1].list[179] },
	["30011:30142:7"] = { hunt = hubHunts[1].list[194] },
	["30011:30148:7"] = { hunt = hubHunts[1].list[209] },
	["30011:30152:7"] = { hunt = hubHunts[1].list[224] },
	["30011:30158:7"] = { hunt = hubHunts[1].list[238] },
	["30011:30162:7"] = { hunt = hubHunts[1].list[258] },
	["30011:30168:7"] = { hunt = hubHunts[1].list[278] },
	["30011:30172:7"] = { hunt = hubHunts[1].list[298] },
	["30011:30188:7"] = { hunt = hubHunts[1].list[327] },
	["30011:30192:7"] = { hunt = hubHunts[1].list[341] },
	["30011:30198:7"] = { hunt = hubHunts[1].list[355] },
	["30011:30202:7"] = { hunt = hubHunts[1].list[369] },
	["30011:30208:7"] = { hunt = hubHunts[1].list[383] },
	["30011:30212:7"] = { hunt = hubHunts[1].list[399] },
	["30011:30228:7"] = { hunt = hubHunts[1].list[429] },
	["30011:30232:7"] = { hunt = hubHunts[1].list[444] },
	["30011:30248:7"] = { hunt = hubHunts[1].list[468] },
	["30011:30252:7"] = { hunt = hubHunts[1].list[485] },
	["30011:30258:7"] = { hunt = hubHunts[1].list[501] },
	["30011:30262:7"] = { hunt = hubHunts[1].list[517] },
	["30011:30268:7"] = { hunt = hubHunts[1].list[533] },
	["30011:30272:7"] = { hunt = hubHunts[1].list[546] },
	["30011:30278:7"] = { hunt = hubHunts[1].list[558] },
	["30011:30282:7"] = { hunt = hubHunts[1].list[571] },
	["30012:29888:7"] = { boss = bosses[181] },
	["30012:29892:7"] = { boss = bosses[199] },
	["30012:29898:7"] = { boss = bosses[144] },
	["30012:29902:7"] = { boss = bosses[163] },
	["30012:29908:7"] = { boss = bosses[107] },
	["30012:29912:7"] = { boss = bosses[126] },
	["30012:29918:7"] = { boss = bosses[70] },
	["30012:29922:7"] = { boss = bosses[89] },
	["30012:29928:7"] = { boss = bosses[41] },
	["30012:29932:7"] = { boss = bosses[56] },
	["30012:29938:7"] = { boss = bosses[11] },
	["30012:29942:7"] = { boss = bosses[26] },
	["30012:29958:7"] = { quest = quests[11] },
	["30012:29962:7"] = { quest = quests[24] },
	["30012:30048:7"] = { hunt = hubHunts[1].list[18] },
	["30012:30068:7"] = { hunt = hubHunts[1].list[45] },
	["30012:30072:7"] = { hunt = hubHunts[1].list[59] },
	["30012:30078:7"] = { hunt = hubHunts[1].list[72] },
	["30012:30082:7"] = { hunt = hubHunts[1].list[89] },
	["30012:30138:7"] = { hunt = hubHunts[1].list[180] },
	["30012:30142:7"] = { hunt = hubHunts[1].list[195] },
	["30012:30148:7"] = { hunt = hubHunts[1].list[210] },
	["30012:30152:7"] = { hunt = hubHunts[1].list[225] },
	["30012:30158:7"] = { hunt = hubHunts[1].list[239] },
	["30012:30162:7"] = { hunt = hubHunts[1].list[259] },
	["30012:30168:7"] = { hunt = hubHunts[1].list[279] },
	["30012:30172:7"] = { hunt = hubHunts[1].list[299] },
	["30012:30188:7"] = { hunt = hubHunts[1].list[328] },
	["30012:30192:7"] = { hunt = hubHunts[1].list[342] },
	["30012:30198:7"] = { hunt = hubHunts[1].list[356] },
	["30012:30202:7"] = { hunt = hubHunts[1].list[370] },
	["30012:30208:7"] = { hunt = hubHunts[1].list[384] },
	["30012:30212:7"] = { hunt = hubHunts[1].list[400] },
	["30012:30228:7"] = { hunt = hubHunts[1].list[430] },
	["30012:30232:7"] = { hunt = hubHunts[1].list[445] },
	["30012:30248:7"] = { hunt = hubHunts[1].list[469] },
	["30012:30252:7"] = { hunt = hubHunts[1].list[486] },
	["30012:30258:7"] = { hunt = hubHunts[1].list[502] },
	["30012:30262:7"] = { hunt = hubHunts[1].list[518] },
	["30012:30268:7"] = { hunt = hubHunts[1].list[534] },
	["30012:30272:7"] = { hunt = hubHunts[1].list[547] },
	["30012:30278:7"] = { hunt = hubHunts[1].list[559] },
	["30012:30282:7"] = { hunt = hubHunts[1].list[572] },
	["30013:29888:7"] = { boss = bosses[182] },
	["30013:29892:7"] = { boss = bosses[200] },
	["30013:29898:7"] = { boss = bosses[145] },
	["30013:29902:7"] = { boss = bosses[164] },
	["30013:29908:7"] = { boss = bosses[108] },
	["30013:29912:7"] = { boss = bosses[127] },
	["30013:29918:7"] = { boss = bosses[71] },
	["30013:29922:7"] = { boss = bosses[90] },
	["30013:29928:7"] = { boss = bosses[42] },
	["30013:29932:7"] = { boss = bosses[57] },
	["30013:29938:7"] = { boss = bosses[12] },
	["30013:29942:7"] = { boss = bosses[27] },
	["30013:29958:7"] = { quest = quests[12] },
	["30013:29962:7"] = { quest = quests[25] },
	["30013:30002:7"] = { thais = true },
	["30013:30068:7"] = { hunt = hubHunts[1].list[46] },
	["30013:30072:7"] = { hunt = hubHunts[1].list[60] },
	["30013:30078:7"] = { hunt = hubHunts[1].list[73] },
	["30013:30082:7"] = { hunt = hubHunts[1].list[90] },
	["30013:30138:7"] = { hunt = hubHunts[1].list[181] },
	["30013:30142:7"] = { hunt = hubHunts[1].list[196] },
	["30013:30148:7"] = { hunt = hubHunts[1].list[211] },
	["30013:30152:7"] = { hunt = hubHunts[1].list[226] },
	["30013:30158:7"] = { hunt = hubHunts[1].list[240] },
	["30013:30162:7"] = { hunt = hubHunts[1].list[260] },
	["30013:30168:7"] = { hunt = hubHunts[1].list[280] },
	["30013:30172:7"] = { hunt = hubHunts[1].list[300] },
	["30013:30188:7"] = { hunt = hubHunts[1].list[329] },
	["30013:30192:7"] = { hunt = hubHunts[1].list[343] },
	["30013:30198:7"] = { hunt = hubHunts[1].list[357] },
	["30013:30202:7"] = { hunt = hubHunts[1].list[371] },
	["30013:30208:7"] = { hunt = hubHunts[1].list[385] },
	["30013:30212:7"] = { hunt = hubHunts[1].list[401] },
	["30013:30228:7"] = { hunt = hubHunts[1].list[431] },
	["30013:30232:7"] = { hunt = hubHunts[1].list[446] },
	["30013:30248:7"] = { hunt = hubHunts[1].list[470] },
	["30013:30252:7"] = { hunt = hubHunts[1].list[487] },
	["30013:30258:7"] = { hunt = hubHunts[1].list[503] },
	["30013:30262:7"] = { hunt = hubHunts[1].list[519] },
	["30013:30268:7"] = { hunt = hubHunts[1].list[535] },
	["30013:30272:7"] = { hunt = hubHunts[1].list[548] },
	["30013:30278:7"] = { hunt = hubHunts[1].list[560] },
	["30013:30282:7"] = { hunt = hubHunts[1].list[573] },
	["30014:29888:7"] = { boss = bosses[183] },
	["30014:29892:7"] = { boss = bosses[201] },
	["30014:29898:7"] = { boss = bosses[146] },
	["30014:29902:7"] = { boss = bosses[165] },
	["30014:29908:7"] = { boss = bosses[109] },
	["30014:29912:7"] = { boss = bosses[128] },
	["30014:29918:7"] = { boss = bosses[72] },
	["30014:29922:7"] = { boss = bosses[91] },
	["30014:29928:7"] = { boss = bosses[43] },
	["30014:29932:7"] = { boss = bosses[58] },
	["30014:29938:7"] = { boss = bosses[13] },
	["30014:29942:7"] = { boss = bosses[28] },
	["30014:29958:7"] = { quest = quests[13] },
	["30014:29998:7"] = { wing = 2 },
	["30014:30068:7"] = { hunt = hubHunts[1].list[47] },
	["30014:30072:7"] = { hunt = hubHunts[1].list[61] },
	["30014:30078:7"] = { hunt = hubHunts[1].list[74] },
	["30014:30082:7"] = { hunt = hubHunts[1].list[91] },
	["30014:30138:7"] = { hunt = hubHunts[1].list[182] },
	["30014:30142:7"] = { hunt = hubHunts[1].list[197] },
	["30014:30148:7"] = { hunt = hubHunts[1].list[212] },
	["30014:30152:7"] = { hunt = hubHunts[1].list[227] },
	["30014:30158:7"] = { hunt = hubHunts[1].list[241] },
	["30014:30162:7"] = { hunt = hubHunts[1].list[261] },
	["30014:30168:7"] = { hunt = hubHunts[1].list[281] },
	["30014:30172:7"] = { hunt = hubHunts[1].list[301] },
	["30014:30188:7"] = { hunt = hubHunts[1].list[330] },
	["30014:30192:7"] = { hunt = hubHunts[1].list[344] },
	["30014:30198:7"] = { hunt = hubHunts[1].list[358] },
	["30014:30202:7"] = { hunt = hubHunts[1].list[372] },
	["30014:30208:7"] = { hunt = hubHunts[1].list[386] },
	["30014:30212:7"] = { hunt = hubHunts[1].list[402] },
	["30014:30228:7"] = { hunt = hubHunts[1].list[432] },
	["30014:30232:7"] = { hunt = hubHunts[1].list[447] },
	["30014:30248:7"] = { hunt = hubHunts[1].list[471] },
	["30014:30252:7"] = { hunt = hubHunts[1].list[488] },
	["30014:30258:7"] = { hunt = hubHunts[1].list[504] },
	["30014:30262:7"] = { hunt = hubHunts[1].list[520] },
	["30014:30268:7"] = { hunt = hubHunts[1].list[536] },
	["30014:30278:7"] = { hunt = hubHunts[1].list[561] },
	["30015:29888:7"] = { boss = bosses[184] },
	["30015:29892:7"] = { boss = bosses[202] },
	["30015:29898:7"] = { boss = bosses[147] },
	["30015:29902:7"] = { boss = bosses[166] },
	["30015:29908:7"] = { boss = bosses[110] },
	["30015:29912:7"] = { boss = bosses[129] },
	["30015:29918:7"] = { boss = bosses[73] },
	["30015:29922:7"] = { boss = bosses[92] },
	["30015:29928:7"] = { boss = bosses[44] },
	["30015:29932:7"] = { boss = bosses[59] },
	["30015:29938:7"] = { boss = bosses[14] },
	["30015:29942:7"] = { boss = bosses[29] },
	["30015:30068:7"] = { hunt = hubHunts[1].list[48] },
	["30015:30078:7"] = { hunt = hubHunts[1].list[75] },
	["30015:30082:7"] = { hunt = hubHunts[1].list[92] },
	["30015:30138:7"] = { hunt = hubHunts[1].list[183] },
	["30015:30142:7"] = { hunt = hubHunts[1].list[198] },
	["30015:30148:7"] = { hunt = hubHunts[1].list[213] },
	["30015:30152:7"] = { hunt = hubHunts[1].list[228] },
	["30015:30158:7"] = { hunt = hubHunts[1].list[242] },
	["30015:30162:7"] = { hunt = hubHunts[1].list[262] },
	["30015:30168:7"] = { hunt = hubHunts[1].list[282] },
	["30015:30172:7"] = { hunt = hubHunts[1].list[302] },
	["30015:30188:7"] = { hunt = hubHunts[1].list[331] },
	["30015:30192:7"] = { hunt = hubHunts[1].list[345] },
	["30015:30198:7"] = { hunt = hubHunts[1].list[359] },
	["30015:30202:7"] = { hunt = hubHunts[1].list[373] },
	["30015:30208:7"] = { hunt = hubHunts[1].list[387] },
	["30015:30212:7"] = { hunt = hubHunts[1].list[403] },
	["30015:30228:7"] = { hunt = hubHunts[1].list[433] },
	["30015:30232:7"] = { hunt = hubHunts[1].list[448] },
	["30015:30248:7"] = { hunt = hubHunts[1].list[472] },
	["30015:30252:7"] = { hunt = hubHunts[1].list[489] },
	["30015:30258:7"] = { hunt = hubHunts[1].list[505] },
	["30015:30262:7"] = { hunt = hubHunts[1].list[521] },
	["30016:29888:7"] = { boss = bosses[185] },
	["30016:29892:7"] = { boss = bosses[203] },
	["30016:29898:7"] = { boss = bosses[148] },
	["30016:29902:7"] = { boss = bosses[167] },
	["30016:29908:7"] = { boss = bosses[111] },
	["30016:29912:7"] = { boss = bosses[130] },
	["30016:29918:7"] = { boss = bosses[74] },
	["30016:29922:7"] = { boss = bosses[93] },
	["30016:29928:7"] = { boss = bosses[45] },
	["30016:29938:7"] = { boss = bosses[15] },
	["30016:29942:7"] = { boss = bosses[30] },
	["30016:29998:7"] = { wing = 3 },
	["30016:30078:7"] = { hunt = hubHunts[1].list[76] },
	["30016:30082:7"] = { hunt = hubHunts[1].list[93] },
	["30016:30138:7"] = { hunt = hubHunts[1].list[184] },
	["30016:30142:7"] = { hunt = hubHunts[1].list[199] },
	["30016:30148:7"] = { hunt = hubHunts[1].list[214] },
	["30016:30158:7"] = { hunt = hubHunts[1].list[243] },
	["30016:30162:7"] = { hunt = hubHunts[1].list[263] },
	["30016:30168:7"] = { hunt = hubHunts[1].list[283] },
	["30016:30172:7"] = { hunt = hubHunts[1].list[303] },
	["30016:30208:7"] = { hunt = hubHunts[1].list[388] },
	["30016:30212:7"] = { hunt = hubHunts[1].list[404] },
	["30016:30228:7"] = { hunt = hubHunts[1].list[434] },
	["30016:30248:7"] = { hunt = hubHunts[1].list[473] },
	["30016:30252:7"] = { hunt = hubHunts[1].list[490] },
	["30016:30258:7"] = { hunt = hubHunts[1].list[506] },
	["30016:30262:7"] = { hunt = hubHunts[1].list[522] },
	["30017:29888:7"] = { boss = bosses[186] },
	["30017:29892:7"] = { boss = bosses[204] },
	["30017:29898:7"] = { boss = bosses[149] },
	["30017:29902:7"] = { boss = bosses[168] },
	["30017:29908:7"] = { boss = bosses[112] },
	["30017:29912:7"] = { boss = bosses[131] },
	["30017:29918:7"] = { boss = bosses[75] },
	["30017:29922:7"] = { boss = bosses[94] },
	["30017:30002:7"] = { questhall = true },
	["30017:30078:7"] = { hunt = hubHunts[1].list[77] },
	["30017:30082:7"] = { hunt = hubHunts[1].list[94] },
	["30017:30158:7"] = { hunt = hubHunts[1].list[244] },
	["30017:30162:7"] = { hunt = hubHunts[1].list[264] },
	["30017:30168:7"] = { hunt = hubHunts[1].list[284] },
	["30017:30172:7"] = { hunt = hubHunts[1].list[304] },
	["30017:30208:7"] = { hunt = hubHunts[1].list[389] },
	["30017:30212:7"] = { hunt = hubHunts[1].list[405] },
	["30017:30248:7"] = { hunt = hubHunts[1].list[474] },
	["30017:30252:7"] = { hunt = hubHunts[1].list[491] },
	["30017:30258:7"] = { hunt = hubHunts[1].list[507] },
	["30017:30262:7"] = { hunt = hubHunts[1].list[523] },
	["30018:29888:7"] = { boss = bosses[187] },
	["30018:29892:7"] = { boss = bosses[205] },
	["30018:29898:7"] = { boss = bosses[150] },
	["30018:29902:7"] = { boss = bosses[169] },
	["30018:29908:7"] = { boss = bosses[113] },
	["30018:29912:7"] = { boss = bosses[132] },
	["30018:29918:7"] = { boss = bosses[76] },
	["30018:29922:7"] = { boss = bosses[95] },
	["30018:29998:7"] = { wing = 4 },
	["30018:30078:7"] = { hunt = hubHunts[1].list[78] },
	["30018:30082:7"] = { hunt = hubHunts[1].list[95] },
	["30018:30158:7"] = { hunt = hubHunts[1].list[245] },
	["30018:30162:7"] = { hunt = hubHunts[1].list[265] },
	["30018:30168:7"] = { hunt = hubHunts[1].list[285] },
	["30018:30172:7"] = { hunt = hubHunts[1].list[305] },
	["30018:30248:7"] = { hunt = hubHunts[1].list[475] },
	["30019:29888:7"] = { boss = bosses[188] },
	["30019:29898:7"] = { boss = bosses[151] },
	["30019:29902:7"] = { boss = bosses[170] },
	["30019:29908:7"] = { boss = bosses[114] },
	["30019:29912:7"] = { boss = bosses[133] },
	["30019:29918:7"] = { boss = bosses[77] },
	["30019:29922:7"] = { boss = bosses[96] },
	["30019:30158:7"] = { hunt = hubHunts[1].list[246] },
	["30019:30162:7"] = { hunt = hubHunts[1].list[266] },
	["30019:30168:7"] = { hunt = hubHunts[1].list[286] },
	["30019:30172:7"] = { hunt = hubHunts[1].list[306] },
	["30020:29898:7"] = { boss = bosses[152] },
	["30020:29908:7"] = { boss = bosses[115] },
	["30020:29918:7"] = { boss = bosses[78] },
	["30020:30158:7"] = { hunt = hubHunts[1].list[247] },
	["30020:30162:7"] = { hunt = hubHunts[1].list[267] },
	["30020:30168:7"] = { hunt = hubHunts[1].list[287] },
	["30020:30172:7"] = { hunt = hubHunts[1].list[307] },
	["30021:30002:7"] = { bosshall = true },
	["30021:30158:7"] = { hunt = hubHunts[1].list[248] },
	["30021:30162:7"] = { hunt = hubHunts[1].list[268] },
	["30021:30168:7"] = { hunt = hubHunts[1].list[288] },
	["30021:30172:7"] = { hunt = hubHunts[1].list[308] },
	["30025:30002:7"] = { mounts = true },
	["30026:29998:7"] = { tower = true },
	["30043:30040:7"] = { lobby = true },
	["30047:30038:7"] = { hunt = hubHunts[2].list[1] },
	["30047:30042:7"] = { hunt = hubHunts[2].list[7] },
	["30048:30038:7"] = { hunt = hubHunts[2].list[2] },
	["30048:30042:7"] = { hunt = hubHunts[2].list[8] },
	["30049:30038:7"] = { hunt = hubHunts[2].list[3] },
	["30049:30042:7"] = { hunt = hubHunts[2].list[9] },
	["30050:30038:7"] = { hunt = hubHunts[2].list[4] },
	["30050:30042:7"] = { hunt = hubHunts[2].list[10] },
	["30051:30038:7"] = { hunt = hubHunts[2].list[5] },
	["30051:30042:7"] = { hunt = hubHunts[2].list[11] },
	["30052:30038:7"] = { hunt = hubHunts[2].list[6] },
	["30088:30040:7"] = { lobby = true },
	["30092:30038:7"] = { hunt = hubHunts[3].list[1] },
	["30092:30042:7"] = { hunt = hubHunts[3].list[9] },
	["30093:30038:7"] = { hunt = hubHunts[3].list[2] },
	["30093:30042:7"] = { hunt = hubHunts[3].list[10] },
	["30094:30038:7"] = { hunt = hubHunts[3].list[3] },
	["30094:30042:7"] = { hunt = hubHunts[3].list[11] },
	["30095:30038:7"] = { hunt = hubHunts[3].list[4] },
	["30095:30042:7"] = { hunt = hubHunts[3].list[12] },
	["30096:30038:7"] = { hunt = hubHunts[3].list[5] },
	["30096:30042:7"] = { hunt = hubHunts[3].list[13] },
	["30097:30038:7"] = { hunt = hubHunts[3].list[6] },
	["30097:30042:7"] = { hunt = hubHunts[3].list[14] },
	["30098:30038:7"] = { hunt = hubHunts[3].list[7] },
	["30098:30042:7"] = { hunt = hubHunts[3].list[15] },
	["30099:30038:7"] = { hunt = hubHunts[3].list[8] },
	["30133:30040:7"] = { lobby = true },
	["30137:30038:7"] = { hunt = hubHunts[4].list[1] },
	["30137:30042:7"] = { hunt = hubHunts[4].list[21] },
	["30138:30038:7"] = { hunt = hubHunts[4].list[2] },
	["30138:30042:7"] = { hunt = hubHunts[4].list[22] },
	["30139:30038:7"] = { hunt = hubHunts[4].list[3] },
	["30139:30042:7"] = { hunt = hubHunts[4].list[23] },
	["30140:30038:7"] = { hunt = hubHunts[4].list[4] },
	["30140:30042:7"] = { hunt = hubHunts[4].list[24] },
	["30141:30038:7"] = { hunt = hubHunts[4].list[5] },
	["30141:30042:7"] = { hunt = hubHunts[4].list[25] },
	["30142:30038:7"] = { hunt = hubHunts[4].list[6] },
	["30142:30042:7"] = { hunt = hubHunts[4].list[26] },
	["30143:30038:7"] = { hunt = hubHunts[4].list[7] },
	["30143:30042:7"] = { hunt = hubHunts[4].list[27] },
	["30144:30038:7"] = { hunt = hubHunts[4].list[8] },
	["30144:30042:7"] = { hunt = hubHunts[4].list[28] },
	["30145:30038:7"] = { hunt = hubHunts[4].list[9] },
	["30145:30042:7"] = { hunt = hubHunts[4].list[29] },
	["30146:30038:7"] = { hunt = hubHunts[4].list[10] },
	["30146:30042:7"] = { hunt = hubHunts[4].list[30] },
	["30147:30038:7"] = { hunt = hubHunts[4].list[11] },
	["30147:30042:7"] = { hunt = hubHunts[4].list[31] },
	["30148:30038:7"] = { hunt = hubHunts[4].list[12] },
	["30148:30042:7"] = { hunt = hubHunts[4].list[32] },
	["30149:30038:7"] = { hunt = hubHunts[4].list[13] },
	["30149:30042:7"] = { hunt = hubHunts[4].list[33] },
	["30150:30038:7"] = { hunt = hubHunts[4].list[14] },
	["30150:30042:7"] = { hunt = hubHunts[4].list[34] },
	["30151:30038:7"] = { hunt = hubHunts[4].list[15] },
	["30151:30042:7"] = { hunt = hubHunts[4].list[35] },
	["30152:30038:7"] = { hunt = hubHunts[4].list[16] },
	["30152:30042:7"] = { hunt = hubHunts[4].list[36] },
	["30153:30038:7"] = { hunt = hubHunts[4].list[17] },
	["30153:30042:7"] = { hunt = hubHunts[4].list[37] },
	["30154:30038:7"] = { hunt = hubHunts[4].list[18] },
	["30154:30042:7"] = { hunt = hubHunts[4].list[38] },
	["30155:30038:7"] = { hunt = hubHunts[4].list[19] },
	["30155:30042:7"] = { hunt = hubHunts[4].list[39] },
	["30156:30038:7"] = { hunt = hubHunts[4].list[20] },
	["30156:30042:7"] = { hunt = hubHunts[4].list[40] },
}


local templePosition = nil -- swiatynia w Thais, ustawiana przy starcie serwera
local safeTiles = {} -- pola bezpiecznych stref 3x3
local safeCenters = {} -- pole strefy -> jej srodek (do sprzatania potworow ze strefy)
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
-- Przy kazdym teleporcie sprawdzamy, czy teleport powrotny nadal stoi na swoim polu;
-- jesli go nie ma, stawiamy go od nowa. Szukamy najpierw wokol miejsca ladowania (pola 3x3),
-- a gdy tam sie nie da, dwa pola dalej. Najpierw puste pole, potem dowolne, po ktorym da sie chodzic.
local function returnAt(pos)
	local tile = Tile(pos)
	local item = tile and tile:getItemById(ENTRY_ITEM_ID)
	return item and item:getActionId() == RETURN_ACTION_ID
end

local function prepareSpot(center)
	local id = key(center)
	local spot = preparedSpots[id]
	if not spot then
		spot = { center = Position(center.x, center.y, center.z) }
		preparedSpots[id] = spot
		for dx = -1, 1 do
			for dy = -1, 1 do
				safeTiles[key(Position(center.x + dx, center.y + dy, center.z))] = true
				safeCenters[key(Position(center.x + dx, center.y + dy, center.z))] = center
			end
		end
	end

	if spot.pos and returnAt(spot.pos) then
		return
	end
	if spot.pos then
		logger.info("[OTS teleporty] Teleport powrotny zniknal przy {}, {}, {} - stawiam go od nowa", center.x, center.y, center.z)
	end
	spot.pos = nil

	for radius = 1, 2 do
		local empty, fallback = nil, nil
		for dx = -radius, radius do
			for dy = -radius, radius do
				if math.max(math.abs(dx), math.abs(dy)) == radius then
					local pos = Position(center.x + dx, center.y + dy, center.z)
					if returnAt(pos) then
						spot.pos = pos
						return
					end
					local tile = Tile(pos)
					if tile and tile:isWalkable(false, false, true, true, false) and not tile:getHouse() then
						if tile:getItemCount() == 0 then
							empty = empty or pos
						else
							fallback = fallback or pos
						end
					end
				end
			end
		end
		for _, pos in ipairs({ empty, fallback }) do
			if pos and placeReturn(pos) then
				spot.pos = pos
				return
			end
		end
	end

	logger.warn("[OTS teleporty] Brak miejsca na teleport powrotny przy {}, {}, {}", center.x, center.y, center.z)
end

-- Usuwa potwory stojace w strefie 3x3. Spawn z mapy potrafi postawic potwora na polu PZ
-- (strefa nie blokuje samego odrodzenia), a taki potwor stoi potem graczowi na glowie.
local function clearSpot(center)
	for dx = -1, 1 do
		for dy = -1, 1 do
			local tile = Tile(Position(center.x + dx, center.y + dy, center.z))
			local creatures = tile and tile:getCreatures() or {}
			for index = #creatures, 1, -1 do
				local creature = creatures[index]
				if creature:isMonster() and not creature:getMaster() then
					creature:remove()
				end
			end
		end
	end
end

-- Drzwi questowe ("sealed against unwanted intruders") otwieraja sie graczowi, ktory ma ustawiony
-- storage o numerze rownym action id drzwi. Przy teleporcie na quest ustawiamy go dla wszystkich
-- takich drzwi w okolicy trasy do skrzyni; drzwi bez action id dostaja wspolny numer.
local QUEST_DOOR_FALLBACK_AID = 64999
local questDoorIds = nil

local function unlockQuestDoors(player, box)
	if not questDoorIds then
		questDoorIds = {}
		for _, door in ipairs(QuestDoorTable or {}) do
			questDoorIds[door.closedDoor] = true
			questDoorIds[door.openDoor] = true
		end
	end
	local unlocked = 0
	for x = box[1], box[3] do
		for y = box[2], box[4] do
			local tile = Tile(Position(x, y, box[5]))
			local items = tile and tile:getItems() or {}
			for _, item in ipairs(items) do
				if questDoorIds[item:getId()] then
					local aid = item:getActionId()
					if aid <= 0 then
						aid = QUEST_DOOR_FALLBACK_AID
						item:setActionId(aid)
					end
					if player:getStorageValue(aid) == -1 then
						player:setStorageValue(aid, 1)
					end
					unlocked = unlocked + 1
				end
			end
		end
	end
	return unlocked
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
		clearSpot(destination)
	end
	if entry.unlock then
		unlockQuestDoors(player, entry.unlock)
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1] .. ". Stoisz w bezpiecznej strefie 3x3, obok jest teleport powrotny do hubu.")
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

-- Losowy Boss: trzy salki wedlug sily (slabszy / mocny / legendarny). W kazdej stoi jeden wylosowany
-- boss; po zabiciu nastepny pojawia sie po 10 minutach. Postac przy padzie w lobby zmienia wyglad
-- miedzy bossami ze wszystkich pul. Stan trzyma tylko identyfikatory, kazdy tik sprawdza je od nowa.
local RAID_RESPAWN_SECONDS = 10 * 60
local RAID_NPC_NAME = "Losowy Boss"
local raidNpc = { id = nil, looks = {}, look = 0 }
for _, room in ipairs(raidRooms) do
	for _, boss in ipairs(room.bosses) do
		raidNpc.looks[#raidNpc.looks + 1] = boss.outfit
	end
end

local function raidSpawn(room)
	if #room.bosses == 0 then
		return
	end
	local pick = room.bosses[math.random(#room.bosses)]
	local monster = Game.createMonster(pick.name, room.center, true, true)
	if monster then
		room.bossId = monster:getId()
		room.bossName = pick.name
		Game.broadcastMessage("Losowy Boss (" .. room.label .. "): " .. pick.name .. " czeka w salce.", MESSAGE_EVENT_ADVANCE)
	else
		room.nextAt = os.time() + 30
	end
end

local function raidStatus(room)
	if room.bossId and Creature(room.bossId) then
		return room.label .. ": czeka " .. room.bossName
	end
	local left = math.max(0, room.nextAt - os.time())
	return string.format("%s: nastepny za %d min %d s", room.label, math.floor(left / 60), left % 60)
end

local function raidEnter(player)
	if inFight(player) then
		return
	end
	local window = ModalWindow({ title = "Losowy Boss", message = "Wybierz salke. Po zabiciu bossa nastepny pojawia sie po 10 minutach." })
	for _, room in ipairs(raidRooms) do
		window:addChoice(raidStatus(room), function(target)
			travel(target, { RAID_NPC_NAME .. " - " .. room.label, room.landing.x, room.landing.y, room.landing.z })
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end) -- przycisk bez funkcji uruchomilby zaznaczona pozycje
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local raidNpcType = Game.createNpcType(RAID_NPC_NAME)
raidNpcType:register({
	name = RAID_NPC_NAME,
	description = RAID_NPC_NAME,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = raidNpc.looks[1] or { lookType = 35 },
	flags = { floorchange = false },
})

local raidTick = GlobalEvent("OtsRandomBossTick")

function raidTick.onThink(interval)
	-- bossy: wykrycie smierci i odliczanie do nastepnego, osobno w kazdej salce
	for _, room in ipairs(raidRooms) do
		if room.bossId then
			if not Creature(room.bossId) then
				Game.broadcastMessage("Losowy Boss pokonany: " .. (room.bossName or "?") .. " (" .. room.label .. "). Nastepny za 10 minut.", MESSAGE_EVENT_ADVANCE)
				room.bossId = nil
				room.nextAt = os.time() + RAID_RESPAWN_SECONDS
			end
		elseif os.time() >= room.nextAt then
			raidSpawn(room)
		end
	end

	-- strefy 3x3: jesli gracz stoi w ktorejs, sprzatamy z niej potwory, ktore odrodzily sie w srodku
	for _, online in ipairs(Game.getPlayers()) do
		local center = safeCenters[key(online:getPosition())]
		if center then
			clearSpot(center)
		end
	end

	-- postac w lobby: tworzona przy pierwszym tiku, potem zmienia wyglad
	local npc = raidNpc.id and Creature(raidNpc.id)
	if not npc then
		npc = Game.createNpc(RAID_NPC_NAME, raidNpcPosition, false, true)
		if npc then
			npc:setMasterPos(raidNpcPosition)
			npc:setDirection(DIRECTION_NORTH)
			raidNpc.id = npc:getId()
		end
	end
	if npc and #raidNpc.looks > 0 then
		raidNpc.look = raidNpc.look % #raidNpc.looks + 1
		npc:setOutfit(raidNpc.looks[raidNpc.look])
	end
	return true
end

raidTick:interval(2000)
raidTick:register()

-- !boss: co stoi w salkach losowego bossa albo ile zostalo do nastepnego
local raidInfo = TalkAction("!boss")

function raidInfo.onSay(player, words, param)
	local lines = {}
	for _, room in ipairs(raidRooms) do
		lines[#lines + 1] = raidStatus(room)
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Losowy Boss. " .. table.concat(lines, "; ") .. ".")
	return true
end

raidInfo:groupType("normal")
raidInfo:register()

-- Taski: jedno aktywne zadanie "zabij N sztuk potwora" z wybranego poziomu expowisk.
-- Nagroda wpada sama po ostatnim zabiciu: Tibia Coins i christmas tokeny (dla Token Tradera).
local TASK_TOKEN_ITEM = 6526
local taskTiers = {
	{ need = 200, coins = 10, tokens = 5, gold = 100000, rolls = 1 },
	{ need = 500, coins = 25, tokens = 10, gold = 300000, rolls = 1 },
	{ need = 1000, coins = 60, tokens = 20, gold = 1000000, rolls = 2 },
	{ need = 2000, coins = 150, tokens = 40, gold = 3000000, rolls = 3 },
}

-- Losowe nagrody dodatkowe (kazde losowanie wybiera jedna wedlug wagi).
local taskRandomRewards = {
	{ weight = 45, name = "kamien ulepszen", give = function(player, tier) player:addItem(20139, tier) return tier .. " x kamien ulepszen" end },
	{ weight = 20, name = "pelna stamina", give = function(player) player:addItem(18992, 1) return "fiolka pelnej staminy" end },
	{ weight = 25, name = "Tibia Coins", give = function(player, tier) player:addTibiaCoins(tier * 10) return (tier * 10) .. " dodatkowych Tibia Coins" end },
	{ weight = 10, name = "worek z nagroda", give = function(player)
		local bags = { { 34109, "bag you desire" }, { 39546, "primal bag" }, { 43895, "bag you covet" } }
		local bag = bags[math.random(#bags)]
		player:addItem(bag[1], 1)
		return bag[2]
	end },
}

local function taskRollReward(player, tier)
	local total = 0
	for _, reward in ipairs(taskRandomRewards) do
		total = total + reward.weight
	end
	local roll = math.random(total)
	for _, reward in ipairs(taskRandomRewards) do
		roll = roll - reward.weight
		if roll <= 0 then
			return reward.give(player, tier)
		end
	end
end

local function taskStore(player)
	return player:kv():scoped("ots-task")
end

local function taskGet(player)
	local store = taskStore(player)
	local tier = tonumber(store:get("tier")) or 0
	local index = tonumber(store:get("index")) or 0
	local entry = hunts[tier] and hunts[tier].list[index]
	if not entry or not taskTiers[tier] then
		return nil
	end
	return { tier = tier, entry = entry, count = tonumber(store:get("count")) or 0, need = taskTiers[tier].need }
end

local function taskClear(player)
	local store = taskStore(player)
	store:set("tier", 0)
	store:set("index", 0)
	store:set("count", 0)
end

local function taskReward(tier)
	local config = taskTiers[tier]
	return string.format("%d TC, %d gp, %d tokenow + %d losowa nagroda (kamienie / stamina / TC / worek)", config.coins, config.gold, config.tokens, config.rolls)
end

local function taskDoneCount(player, monster)
	return tonumber(player:kv():scoped("ots-task-done"):get(monster:lower())) or 0
end

local function taskStart(player, tier, index)
	if taskGet(player) then
		return
	end
	local store = taskStore(player)
	store:set("tier", tier)
	store:set("index", index)
	store:set("count", 0)
	local config = taskTiers[tier]
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Nowe zadanie: zabij %d x %s. Teleport znajdziesz pod !task.", config.need, hunts[tier].list[index].mon))
	player:sendChannelMessage("Taski", string.format("Nowe zadanie: %s 0/%d. Nagroda: %s.", hunts[tier].list[index].mon, config.need, taskReward(tier)), TALKTYPE_CHANNEL_O, 12)
end

local openTasks

-- Lista potworow z poziomu: [Complete xN] przy tych, ktorych task byl juz zrobiony.
local function openTaskTier(player, tier)
	local config = taskTiers[tier]
	local window = ModalWindow({ title = "Taski - " .. hunts[tier].label, message = string.format("%d potworow, nagroda: %s.\n[Complete] = task juz zrobiony (mozna powtorzyc).                    ", config.need, taskReward(tier)) })
	window:addChoice("Losowy potwor z tego poziomu", function(target)
		taskStart(target, tier, math.random(#hunts[tier].list))
	end)
	for index, entry in ipairs(hunts[tier].list) do
		if index > 250 then
			break
		end
		local times = taskDoneCount(player, entry.mon)
		local label = entry.mon
		if times > 0 then
			label = "[Complete] " .. entry.mon
		end
		window:addChoice(label, function(target)
			taskStart(target, tier, index)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		openTasks(target)
	end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

openTasks = function(player)
	local task = taskGet(player)
	local window
	if task then
		window = ModalWindow({
			title = "Taski",
			message = string.format("Zadanie: zabij %d x %s.\nPostep: %d/%d.\nNagroda: %s.", task.need, task.entry.mon, task.count, task.need, taskReward(task.tier)),
		})
		window:addChoice("Teleport na expowisko", function(target)
			local current = taskGet(target)
			if current then
				travel(target, current.entry)
			end
		end)
		window:addChoice("Porzuc zadanie", function(target)
			taskClear(target)
			target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zadanie porzucone. Mozesz wziac nowe.")
		end)
	else
		local done = tonumber(taskStore(player):get("done")) or 0
		window = ModalWindow({ title = "Taski", message = "Wybierz poziom, potem potwora (albo losowego). Kazdy task mozna robic wiele razy.\nUkonczone zadania: " .. done .. "                                        " })
		for tier, config in ipairs(taskTiers) do
			if hunts[tier] then
				local finished = 0
				for _, entry in ipairs(hunts[tier].list) do
					if taskDoneCount(player, entry.mon) > 0 then
						finished = finished + 1
					end
				end
				window:addChoice(string.format("%s: %d potworow (Complete: %d/%d)", hunts[tier].label, config.need, finished, #hunts[tier].list), function(target)
					openTaskTier(target, tier)
				end)
			end
		end
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end) -- przycisk bez funkcji uruchomilby zaznaczona pozycje
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Kanal czatu "Taski" (id 12, data/chatchannels/chatchannels.xml): postep kazdego zabicia.
local TASK_CHANNEL_ID = 12
local function taskChannel(player, text)
	player:sendChannelMessage("Taski", text, TALKTYPE_CHANNEL_O, TASK_CHANNEL_ID)
end

local taskKill = EventCallback("OtsTaskOnKill")

function taskKill.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local task = taskGet(player)
	if not task or monster:getName():lower() ~= task.entry.mon:lower() then
		return
	end
	local count = task.count + 1
	if count < task.need then
		taskStore(player):set("count", count)
		taskChannel(player, string.format("%s: %d/%d", task.entry.mon, count, task.need))
		return
	end
	local config = taskTiers[task.tier]
	local store = taskStore(player)
	store:set("done", (tonumber(store:get("done")) or 0) + 1)
	local doneStore = player:kv():scoped("ots-task-done")
	doneStore:set(task.entry.mon:lower(), (tonumber(doneStore:get(task.entry.mon:lower())) or 0) + 1)
	taskClear(player)
	player:addTibiaCoins(config.coins)
	player:addItem(TASK_TOKEN_ITEM, config.tokens)
	player:setBankBalance(player:getBankBalance() + config.gold)
	local extras = {}
	for _ = 1, config.rolls do
		extras[#extras + 1] = taskRollReward(player, task.tier)
	end
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Gratulacje! Wymagana liczba potworow zostala zabita: %d x %s.", task.need, task.entry.mon))
	taskChannel(player, string.format("Gratulacje! Task ukonczony: %d/%d %s. Nagroda: %d TC, %d gp na konto, %d tokenow, losowo: %s. Nowe zadanie: !task.", task.need, task.need, task.entry.mon, config.coins, config.gold, config.tokens, table.concat(extras, ", ")))
end

taskKill:register()

local taskCommand = TalkAction("!task")

function taskCommand.onSay(player, words, param)
	openTasks(player)
	return true
end

taskCommand:groupType("normal")
taskCommand:register()

-- Postac "Taski" w lobby hubu: wystarczy cokolwiek do niej powiedziec (np. hi), otwiera to samo okno.
local TASK_NPC_NAME = "Taski"
local taskNpcType = Game.createNpcType(TASK_NPC_NAME)
taskNpcType.onSay = function(npc, creature, type, message)
	local player = creature and creature:getPlayer()
	if player and player:getPosition():getDistance(npc:getPosition()) <= 4 then
		openTasks(player)
	end
end
taskNpcType:register({
	name = TASK_NPC_NAME,
	description = TASK_NPC_NAME,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = { lookType = 268, lookHead = 78, lookBody = 69, lookLegs = 58, lookFeet = 76, lookAddons = 3 },
	flags = { floorchange = false },
})

local taskNpcPlace = GlobalEvent("OtsTaskNpc")

function taskNpcPlace.onStartup()
	local npc = Game.createNpc(TASK_NPC_NAME, taskNpcPosition, false, true)
	if npc then
		npc:setMasterPos(taskNpcPosition)
		npc:setDirection(DIRECTION_SOUTH)
	end
	logger.info("[OTS taski] Postac w lobby: {}", npc and "tak" or "nie")
	return true
end

taskNpcPlace:register()

-- Fale: sala, w ktorej po wybiciu fali wchodzi nastepna, mocniejsza. Potwory ida po kolei
-- z listy expowisk (rosnaco wedlug exp). Za kazda fale jest zloto na konto, co piata takze Tibia Coins.
-- Odroczone wywolania niosa tylko id gracza i numer biegu (token).
local survival = { token = 0, ids = {}, wave = 0 }
local survivalMonsters = {}
for _, group in ipairs(hunts) do
	for _, entry in ipairs(group.list) do
		survivalMonsters[#survivalMonsters + 1] = entry.mon
	end
end

local function survivalClear()
	for _, id in ipairs(survival.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	survival.ids = {}
end

local function inSurvival(player)
	local pos = player:getPosition()
	return pos.z == survivalCenter.z and math.abs(pos.x - survivalCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - survivalCenter.y) <= ARENA_RADIUS + 1
end

local survivalCheck

local function survivalNext(playerId, token)
	if token ~= survival.token then
		return
	end
	local player = Player(playerId)
	if not player or not inSurvival(player) then
		survivalClear()
		return
	end
	survival.wave = survival.wave + 1
	local wave = survival.wave
	local name = survivalMonsters[math.min(#survivalMonsters, 6 + wave * 10)]
	local amount = math.min(10 + wave, 32)
	for _ = 1, amount do
		local pos = Position(survivalCenter.x + math.random(-ARENA_RADIUS + 1, ARENA_RADIUS - 1), survivalCenter.y + math.random(-ARENA_RADIUS + 1, 2), survivalCenter.z)
		local monster = name and Game.createMonster(name, pos, true, true)
		if monster then
			survival.ids[#survival.ids + 1] = monster:getId()
		end
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Fala %d: %d x %s.", wave, #survival.ids, name or "?"))
	addEvent(survivalCheck, 1000, playerId, token)
end

survivalCheck = function(playerId, token)
	if token ~= survival.token then
		return
	end
	local player = Player(playerId)
	if not player or not inSurvival(player) then
		survivalClear()
		return
	end
	for _, id in ipairs(survival.ids) do
		if Creature(id) then
			addEvent(survivalCheck, 1000, playerId, token)
			return
		end
	end
	survival.ids = {}
	local wave = survival.wave
	local gold = wave * 10000
	player:setBankBalance(player:getBankBalance() + gold)
	local text = string.format("Fala %d wybita: +%d gp na konto.", wave, gold)
	if wave % 3 == 0 then
		player:addItem(20139, 1)
		text = text .. " +1 kamien ulepszen."
	end
	if wave % 5 == 0 then
		player:addTibiaCoins(wave * 2)
		text = text .. string.format(" Bonus: +%d Tibia Coins.", wave * 2)
	end
	local store = player:kv():scoped("ots-survival")
	if wave > (tonumber(store:get("best")) or 0) then
		store:set("best", wave)
		text = text .. " Nowy rekord!"
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	addEvent(survivalNext, 2500, playerId, token)
end

local function survivalEnter(player)
	if inFight(player) then
		return
	end
	survivalClear()
	survival.token = survival.token + 1
	survival.wave = 0
	travel(player, { "Fale", survivalLanding.x, survivalLanding.y, survivalLanding.z })
	if not inSurvival(player) then
		return
	end
	local best = tonumber(player:kv():scoped("ots-survival"):get("best")) or 0
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Fale: pierwsza fala za chwile. Twoj rekord: fala %d. Wyjscie teleportem konczy bieg.", best))
	addEvent(survivalNext, 2500, player:getId(), survival.token)
end

-- Bestiariusz: sala, w ktorej wokol postaci pojawiaja sie fale wybranego potwora, az bestiariusz
-- tego potwora sie zapelni albo gracz wyjdzie. Zabojstwa licza sie normalnie (silnik dolicza je sam).
-- Postep czytany ze storage silnika (STORAGEVALUE_BESTIARYKILLCOUNT + raceId).
local BESTIARY_KILL_STORAGE = 61305000
local BESTIARY_WAVE = 60 -- tyle potworow naraz w sali
local BESTIARY_REFILL = 30 -- gdy zostanie mniej, sala od razu sie dopelnia do BESTIARY_WAVE
local BESTIARY_RANGE = 4 -- jak daleko od postaci moga sie pojawiac potwory (bylo 7)
local BOSS_RANGE = 3 -- to samo dla bossow w Bosstiariuszu
local bestiaryRun = { token = 0, ids = {}, monster = nil, lastKills = 0, lastProgressAt = 0 }

-- Bosstiariusz (ta sama sala): bossy z bosstiary do poziomu Mastery, z losowa sila jak w Hardcore Boss.
-- Wpis bossa: { nazwa, 0, wymagane zabojstwa, boss = true, batch = ile naraz }.
local BOSS_BATCH = { Bane = 10, Archfoe = 3, Nemesis = 3 }
local BOSS_MASTERY = { Bane = 300, Archfoe = 60, Nemesis = 5 }
local BOSS_STUCK_SECONDS = 5 * 60 -- boss bez postepu tyle czasu (np. nie da sie go zabic) jest pomijany
local hardcoreEmpower -- ustawiane nizej, w sekcji Hardcore Boss

-- Czy bossa da sie w ogole zranic: false, gdy ma 100% odpornosci (albo immunitet) na kazdy rodzaj
-- obrazen, np. Ascending Ferumbras. Takie bossy w Hardcore Boss i Bosstiariuszu dostaja obrazenia
-- neutralne (patrz OtsHardcoreBossVulnerable nizej), wiec da sie je normalnie zabic.
local DAMAGE_TYPES = { COMBAT_PHYSICALDAMAGE, COMBAT_ENERGYDAMAGE, COMBAT_EARTHDAMAGE, COMBAT_FIREDAMAGE, COMBAT_ICEDAMAGE, COMBAT_HOLYDAMAGE, COMBAT_DEATHDAMAGE }

local function bossKillable(mtype)
	local elements = mtype:getElementList() or {}
	local immune = mtype:combatImmunities()
	for _, combatType in ipairs(DAMAGE_TYPES) do
		local blocked = (tonumber(elements[combatType]) or 0) >= 100 or (type(immune) == "table" and tonumber(immune[combatType]) == 1)
		if not blocked then
			return true
		end
	end
	return false
end

local function bestiaryKills(player, race)
	return math.max(0, player:getStorageValue(BESTIARY_KILL_STORAGE + race))
end

-- Postep wpisu: bestiariusz potwora albo bosstiary bossa.
local function entryKills(player, entry)
	if entry.boss then
		return tonumber(player:getBosstiaryKills(entry.spawn or entry[1])) or 0
	end
	return bestiaryKills(player, entry[2])
end

local function runLabel(entry)
	return entry and entry.boss and "Bosstiariusz" or "Bestiariusz"
end

local function inBestiaryRoom(player)
	local pos = player:getPosition()
	return pos.z == bestiaryCenter.z and math.abs(pos.x - bestiaryCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - bestiaryCenter.y) <= ARENA_RADIUS + 1
end

local function bestiaryClear()
	for _, id in ipairs(bestiaryRun.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
		OtsHardcoreBossDamage[id] = nil
		OtsHardcoreBossVulnerable[id] = nil
	end
	bestiaryRun.ids = {}
end

local function bestiaryAlive()
	local alive = {}
	for _, id in ipairs(bestiaryRun.ids) do
		if Creature(id) then
			alive[#alive + 1] = id
		end
	end
	bestiaryRun.ids = alive
	return #alive
end

-- Dostawia potwory wokol postaci, az w sali bedzie ich BESTIARY_WAVE (albo tyle, ile brakuje do konca).
local function bestiarySpawn(player, entry, kills)
	local alive = bestiaryAlive()
	local amount = math.min((entry.batch or BESTIARY_WAVE) - alive, entry[3] - kills - alive)
	if amount <= 0 then
		return 0
	end
	local here = player:getPosition()
	local ring = {}
	local range = entry.boss and BOSS_RANGE or BESTIARY_RANGE
	for dx = -range, range do
		for dy = -range, range do
			if math.max(math.abs(dx), math.abs(dy)) >= 2 then
				local pos = Position(here.x + dx, here.y + dy, here.z)
				if math.abs(pos.x - BESTIARY_ROOM_CENTER.x) <= BESTIARY_ROOM_RADIUS and math.abs(pos.y - BESTIARY_ROOM_CENTER.y) <= BESTIARY_ROOM_RADIUS then
					local tile = Tile(pos)
					if tile and tile:isWalkable(true, true, true, false, false) and not returnAt(pos) then
						ring[#ring + 1] = pos
					end
				end
			end
		end
	end
	local spawned = 0
	for _ = 1, amount do
		if #ring == 0 then
			break
		end
		local pos = table.remove(ring, math.random(#ring))
		local monster = Game.createMonster(entry.spawn or entry[1], pos, true, true)
		if monster then
			if entry.boss and hardcoreEmpower then
				hardcoreEmpower(monster)
			end
			bestiaryRun.ids[#bestiaryRun.ids + 1] = monster:getId()
			spawned = spawned + 1
		end
	end
	return spawned
end

local bestiaryStart

-- Nastepny nieukonczony potwor z tej samej klasy (po obecnym, potem od poczatku listy).
local function bestiaryNextInClass(player, class, current)
	if not class then
		return nil
	end
	local list = class.list
	local startIndex = 0
	for index, entry in ipairs(list) do
		if entry == current then
			startIndex = index
			break
		end
	end
	for step = 1, #list do
		local entry = list[(startIndex + step - 1) % #list + 1]
		if entry ~= current and entryKills(player, entry) < entry[3] then
			return entry
		end
	end
	return nil
end

-- Co sekunde: sprawdza postep i dopelnia sale, gdy potworow zrobi sie malo.
local function bestiaryTick(playerId, token)
	if token ~= bestiaryRun.token then
		return
	end
	local player = Player(playerId)
	if not player or not inBestiaryRoom(player) then
		bestiaryClear()
		return
	end
	local entry = bestiaryRun.monster
	local label = runLabel(entry)
	local kills = entryKills(player, entry)
	if kills ~= bestiaryRun.lastKills then
		bestiaryRun.lastKills = kills
		bestiaryRun.lastProgressAt = os.time()
	end
	-- Postep to tez zadawane obrazenia: suma zycia zywych bossow spadla od poprzedniej sekundy
	-- (silne bossy potrafia zyc dluzej niz BOSS_STUCK_SECONDS, a to nie znaczy, ze sa nie do zabicia).
	local hp, count = 0, 0
	for _, id in ipairs(bestiaryRun.ids) do
		local creature = Creature(id)
		if creature then
			hp = hp + creature:getHealth()
			count = count + 1
			-- Klony bossa (np. Zamulosh przywoluje kopie z ta sama nazwa i zyciem, ktore nie licza sie
			-- do bosstiary) od razu znikaja, zeby gracz bil prawdziwego bossa.
			if entry.boss then
				for _, summon in ipairs(creature:getSummons() or {}) do
					if summon:getName() == creature:getName() then
						summon:remove()
					end
				end
			end
		end
	end
	if bestiaryRun.lastHp and (hp < bestiaryRun.lastHp or count < (bestiaryRun.lastCount or 0)) then
		bestiaryRun.lastProgressAt = os.time()
	end
	local stuck = entry.boss and os.time() - bestiaryRun.lastProgressAt >= BOSS_STUCK_SECONDS
	if kills >= entry[3] or stuck then
		bestiaryClear()
		local nextEntry = bestiaryNextInClass(player, bestiaryRun.class, entry)
		local head = stuck and string.format("%s: %s pominiety (przez %d min zadnych obrazen ani zabojstw).", label, entry[1], BOSS_STUCK_SECONDS / 60) or string.format("%s: %s ukonczony (%d/%d)!", label, entry[1], kills, entry[3])
		if nextEntry then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, head .. " Dalej: " .. nextEntry[1] .. ".")
			bestiaryStart(player, nextEntry, bestiaryRun.class)
		elseif bestiaryRun.class then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, head .. " Cala kategoria " .. bestiaryRun.class.name .. " jest ukonczona.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, head .. " Wybierz kolejnego.")
		end
		return
	end
	local alive = bestiaryAlive()
	if alive < (entry.boss and entry.batch or BESTIARY_REFILL) then
		local spawned = bestiarySpawn(player, entry, kills)
		if spawned == 0 and alive == 0 then
			local nextEntry = bestiaryNextInClass(player, bestiaryRun.class, entry)
			if nextEntry then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s: %s nie da sie przywolac w sali. Dalej: %s.", label, entry[1], nextEntry[1]))
				bestiaryStart(player, nextEntry, bestiaryRun.class)
			else
				player:sendCancelMessage(entry[1] .. " nie da sie przywolac w sali.")
			end
			return
		end
		player:sendTextMessage(MESSAGE_STATUS, string.format("%s: %s %d/%d.", label, entry[1], kills, entry[3]))
	end
	-- stan po dopelnieniu: punkt odniesienia dla nastepnej sekundy
	local hpAfter, countAfter = 0, 0
	for _, id in ipairs(bestiaryRun.ids) do
		local creature = Creature(id)
		if creature then
			hpAfter = hpAfter + creature:getHealth()
			countAfter = countAfter + 1
		end
	end
	bestiaryRun.lastHp, bestiaryRun.lastCount = hpAfter, countAfter
	addEvent(bestiaryTick, 1000, playerId, token)
end

-- class: klasa bestiariusza, z ktorej po ukonczeniu potwora automatycznie startuje nastepny.
bestiaryStart = function(player, entry, class)
	-- W sali Bestiariusza mozna od razu zmienic potwora mimo walki (bez teleportu, bez PZ).
	if not inBestiaryRoom(player) and inFight(player) then
		return
	end
	bestiaryClear()
	bestiaryRun.token = bestiaryRun.token + 1
	bestiaryRun.monster = entry
	bestiaryRun.class = class
	bestiaryRun.lastKills = entryKills(player, entry)
	bestiaryRun.lastProgressAt = os.time()
	bestiaryRun.lastHp, bestiaryRun.lastCount = nil, nil
	if not inBestiaryRoom(player) then
		travel(player, { "Bestiariusz", bestiaryLanding.x, bestiaryLanding.y, bestiaryLanding.z })
	end
	if not inBestiaryRoom(player) then
		return
	end
	if entry.boss then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Bosstiariusz: %s, %d/%d (Mastery). %d naraz, losowa sila jak w Hardcore Boss. Wyjscie teleportem konczy.", entry[1], entryKills(player, entry), entry[3], entry.batch))
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Bestiariusz: %s, %d/%d. Do 60 potworow naraz wokol ciebie, sala sama sie dopelnia. Wyjscie teleportem konczy.", entry[1], bestiaryKills(player, entry[2]), entry[3]))
	end
	addEvent(bestiaryTick, 1000, player:getId(), bestiaryRun.token)
end

local openBestiary

local function openBestiaryClass(player, class, back)
	local window = ModalWindow({ title = (class.title or "Bestiariusz") .. " - " .. class.name, message = "Wybierz potwora - po jego ukonczeniu sala sama przechodzi do nastepnego nieukonczonego z tej klasy.                                        " })
	local firstOpen = bestiaryNextInClass(player, class, nil)
	if firstOpen then
		window:addChoice(">> Cala klasa po kolei (od: " .. firstOpen[1] .. ")", function(target)
			bestiaryStart(target, firstOpen, class)
		end)
	end
	for index, entry in ipairs(class.list) do
		if index > 250 then
			break
		end
		local kills = entryKills(player, entry)
		local label = kills >= entry[3] and ("[Complete] " .. entry[1]) or string.format("%s  %d/%d", entry[1], kills, entry[3])
		window:addChoice(label, function(target)
			bestiaryStart(target, entry, class)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		(back or openBestiary)(target)
	end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Kategorie bosstiary (Bane, Archfoe, Nemesis), budowane raz z typow potworow na serwerze, od najslabszego.
local bossClasses = nil

local function buildBossClasses()
	bossClasses = {}
	local byName = {}
	for _, name in ipairs({ "Bane", "Archfoe", "Nemesis" }) do
		byName[name] = { name = name, title = "Bosstiariusz", list = {} }
		bossClasses[#bossClasses + 1] = byName[name]
	end
	local seen = {}
	for _, mtype in pairs(Game.getMonsterTypes() or {}) do
		local rarity = mtype:bossRace()
		local class = rarity and byName[rarity]
		local name = mtype:name()
		if class and name and not seen[name:lower()] and mtype:maxHealth() > 0 then
			seen[name:lower()] = true
			-- spawn: nazwa typu (np. "Goshnar's Megalomania Green"), bo wyswietlana nazwa nie zawsze jest typem
			class.list[#class.list + 1] = { name, 0, BOSS_MASTERY[rarity], boss = true, batch = BOSS_BATCH[rarity], health = mtype:maxHealth(), spawn = mtype:getTypeName() }
		end
	end
	for _, class in ipairs(bossClasses) do
		table.sort(class.list, function(x, y)
			return x.health < y.health
		end)
	end
end

local openBosstiary

openBosstiary = function(player)
	if not bossClasses then
		buildBossClasses()
	end
	local window = ModalWindow({ title = "Bosstiariusz", message = "Bossy do poziomu Mastery, z losowa sila jak w Hardcore Boss. Bane: 10 naraz, Archfoe i Nemesis: 3 naraz. W nawiasie: ukonczone / wszystkie.                                        " })
	for _, class in ipairs(bossClasses) do
		local finished = 0
		for _, entry in ipairs(class.list) do
			if entryKills(player, entry) >= entry[3] then
				finished = finished + 1
			end
		end
		window:addChoice(string.format("%s (%d/%d)", class.name, finished, #class.list), function(target)
			openBestiaryClass(target, class, openBosstiary)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end
OtsOpenBosstiary = openBosstiary

openBestiary = function(player)
	local window = ModalWindow({ title = "Bestiariusz", message = "Wybierz klase potworow. W nawiasie: ukonczone / wszystkie.                                        " })
	for _, class in ipairs(bestiaryClasses) do
		local finished = 0
		for _, entry in ipairs(class.list) do
			if bestiaryKills(player, entry[2]) >= entry[3] then
				finished = finished + 1
			end
		end
		window:addChoice(string.format("%s (%d/%d)", class.name, finished, #class.list), function(target)
			openBestiaryClass(target, class)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Wieza: kolejne pietra coraz silniejszych potworow (z listy expowisk, rosnaco), co 10 pieter boss.
-- Rekord i punkt kontrolny (co 10 pieter) zapisuje sie na postaci - mozna zaczac od ostatniego punktu.
-- Odroczone wywolania niosa tylko id gracza i numer biegu (token).
local TOWER_BLESSED_STONE = 20138
local tower = { token = 0, ids = {}, floor = 0 }

local function towerClear()
	for _, id in ipairs(tower.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	tower.ids = {}
end

local function inTower(player)
	local pos = player:getPosition()
	return pos.z == towerCenter.z and math.abs(pos.x - towerCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - towerCenter.y) <= ARENA_RADIUS + 1
end

local towerCheck

local function towerNext(playerId, token)
	if token ~= tower.token then
		return
	end
	local player = Player(playerId)
	if not player or not inTower(player) then
		towerClear()
		return
	end
	tower.floor = tower.floor + 1
	local floor = tower.floor
	local name = survivalMonsters[math.min(#survivalMonsters, 10 + floor * 4)]
	local amount = math.min(8 + floor, 30)
	tower.ids = {}
	-- potwory w pierscieniu 2-3 pola wokol miejsca, w ktorym stoi postac (bez przenoszenia jej),
	-- tylko na wolnych polach sali poza PZ
	local here = player:getPosition()
	local ring = {}
	for dx = -3, 3 do
		for dy = -3, 3 do
			if math.max(math.abs(dx), math.abs(dy)) >= 2 then
				local pos = Position(here.x + dx, here.y + dy, here.z)
				local tile = Tile(pos)
				if math.abs(pos.x - towerCenter.x) <= ARENA_RADIUS and math.abs(pos.y - towerCenter.y) <= ARENA_RADIUS and tile and tile:isWalkable(true, true, true, false, false) then
					ring[#ring + 1] = pos
				end
			end
		end
	end
	for _ = 1, amount do
		local pos = #ring > 0 and table.remove(ring, math.random(#ring)) or towerCenter
		local monster = name and Game.createMonster(name, pos, true, true)
		if monster then
			tower.ids[#tower.ids + 1] = monster:getId()
		end
	end
	local bossText = ""
	if floor % 10 == 0 and #rushBosses > 0 then
		local bossName = rushBosses[math.min(#rushBosses, math.floor(floor / 10))]
		local bossPos = #ring > 0 and table.remove(ring, math.random(#ring)) or towerCenter
		local boss = Game.createMonster(bossName, bossPos, true, true)
		if boss then
			tower.ids[#tower.ids + 1] = boss:getId()
			bossText = " + boss " .. bossName
		end
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wieza, pietro %d: %d x %s%s.", floor, amount, name or "?", bossText))
	addEvent(towerCheck, 1000, playerId, token)
end

towerCheck = function(playerId, token)
	if token ~= tower.token then
		return
	end
	local player = Player(playerId)
	if not player or not inTower(player) then
		towerClear()
		return
	end
	for _, id in ipairs(tower.ids) do
		if Creature(id) then
			addEvent(towerCheck, 1000, playerId, token)
			return
		end
	end
	tower.ids = {}
	local floor = tower.floor
	local gold = floor * 20000
	player:setBankBalance(player:getBankBalance() + gold)
	local text = string.format("Pietro %d zaliczone: +%d gp na konto.", floor, gold)
	if floor % 5 == 0 then
		player:addTibiaCoins(floor)
		text = text .. string.format(" +%d Tibia Coins.", floor)
	end
	if floor % 10 == 0 then
		player:addItem(TOWER_BLESSED_STONE, 1)
		text = text .. " +1 blessed upgrade stone. Punkt kontrolny zapisany."
	end
	local store = player:kv():scoped("ots-tower")
	if floor > (tonumber(store:get("best")) or 0) then
		store:set("best", floor)
		text = text .. " Nowy rekord!"
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	addEvent(towerNext, 3000, playerId, token)
end

local function towerStart(player, fromFloor)
	if inFight(player) then
		return
	end
	towerClear()
	tower.token = tower.token + 1
	tower.floor = fromFloor
	travel(player, { "Wieza", towerLanding.x, towerLanding.y, towerLanding.z })
	if not inTower(player) then
		return
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wieza: pietro %d za chwile. Wyjscie teleportem konczy bieg.", fromFloor + 1))
	addEvent(towerNext, 3000, player:getId(), tower.token)
end

local function towerEnter(player)
	if inFight(player) then
		return
	end
	local best = tonumber(player:kv():scoped("ots-tower"):get("best")) or 0
	local checkpoint = best - best % 10
	local window = ModalWindow({ title = "Wieza", message = string.format("Rekord: pietro %d. Punkt kontrolny: pietro %d.\nNagrody: zloto za kazde pietro, TC co 5, blessed upgrade stone co 10 (boss).                    ", best, checkpoint) })
	window:addChoice("Start od pietra 1", function(target)
		towerStart(target, 0)
	end)
	if checkpoint > 0 then
		window:addChoice(string.format("Start od pietra %d (punkt kontrolny)", checkpoint + 1), function(target)
			towerStart(target, checkpoint)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Hardcore Boss (dawniej Boss Rush): fale losowych bossow, 3-5 naraz w jednym pokoju.
-- Pula to wszystkie bossy z bosstiary na serwerze, ulozone od najslabszego (wg zycia).
-- Bossy fali nr i sa losowane z i-tego przedzialu tej listy, wiec kazdy bieg jest inny,
-- a trudnosc i tak rosnie. Bossy nie powtarzaja sie w biegu.
-- Fala, ktorej nie da sie wybic w RUSH_WAVE_TIME (np. boss wymaga mechaniki), jest konczona:
-- pozostale bossy znikaja bez nagrody. Za kazdego zabitego bossa nagroda rosnie z numerem fali
-- (zloto na konto i Tibia Coins). Odroczone wywolania niosa tylko id gracza i numer biegu (token).
local RUSH_NAME = "Hardcore Boss"
local RUSH_WAVES = 15
local RUSH_MIN_BOSSES = 3
local RUSH_MAX_BOSSES = 5
local RUSH_WAVE_TIME = 5 * 60 -- sekundy na jedna fale
local RUSH_MAX_HIT_PERCENT = 25 -- jeden cios bossa (Hardcore Boss i Bosstiariusz) zabiera najwyzej tyle % max zycia
local RUSH_SPOTS = { { 0, -4 }, { -3, -3 }, { 3, -3 }, { -5, -1 }, { 5, -1 } }
local rush = { token = 0, ids = {}, wave = 0, used = {}, spawnedAt = 0, size = 0, kills = 0, tiers = {} }
local rushPool = nil

-- Losowa sila kazdego bossa: mnoznik zycia i obrazen; nagroda za niego rosnie razem z sila.
local RUSH_TIERS = {
	{ label = "Silny", health = 3, damage = 1.5, reward = 1, weight = 40, skull = SKULL_YELLOW },
	{ label = "Brutalny", health = 6, damage = 2.5, reward = 2, weight = 35, skull = SKULL_RED },
	{ label = "Koszmar", health = 12, damage = 4, reward = 4, weight = 25, skull = SKULL_BLACK },
}
OtsHardcoreBossDamage = OtsHardcoreBossDamage or {} -- id bossa -> mnoznik obrazen
OtsHardcoreBossVulnerable = OtsHardcoreBossVulnerable or {} -- id bossa odpornego na wszystko -> obrazenia graczy jako neutralne

local function rushTier()
	local total = 0
	for _, tier in ipairs(RUSH_TIERS) do
		total = total + tier.weight
	end
	local roll = math.random(total)
	for _, tier in ipairs(RUSH_TIERS) do
		roll = roll - tier.weight
		if roll <= 0 then
			return tier
		end
	end
	return RUSH_TIERS[1]
end

local function rushEmpower(monster, tier)
	-- Mechaniki questowe (np. The Lily of Night przyjmuje obrazenia tylko po zapachu z questu,
	-- Faceless Bane przy 20% zycia leczy sie do pelna i staje sie niesmiertelny) siedza w zdarzeniach
	-- zmiany zycia/many i "think". W tym trybie ich nie ma: kazdego bossa da sie bic.
	-- Zdarzenia smierci tez znikaja: questy ustawiaja w nich czasowki na ponowna walke (np. Zamulosh,
	-- Zalesh: 44 h) i przenosza do kolejnych faz. Zabojstwo do bosstiary i loot licza sie bez nich.
	for _, eventType in ipairs({ CREATURE_EVENT_HEALTHCHANGE, CREATURE_EVENT_MANACHANGE, CREATURE_EVENT_THINK, CREATURE_EVENT_DEATH }) do
		for _, eventName in ipairs(monster:getEvents(eventType) or {}) do
			monster:unregisterEvent(eventName)
		end
	end
	local health = math.floor(monster:getMaxHealth() * tier.health)
	monster:setMaxHealth(health)
	monster:addHealth(health)
	monster:setSkull(tier.skull)
	monster:setName(monster:getName(), string.format("%s (%s, %dx zycia, %.1fx obrazen)", monster:getName(), tier.label, tier.health, tier.damage))
	OtsHardcoreBossDamage[monster:getId()] = tier.damage
	local mtype = monster:getType()
	if mtype and not bossKillable(mtype) then
		OtsHardcoreBossVulnerable[monster:getId()] = true
	end
end

local function buildRushPool()
	rushPool = {}
	local seen = {}
	for _, mtype in pairs(Game.getMonsterTypes() or {}) do
		local name = mtype:name()
		local isBoss = (tonumber(mtype:bossRaceId()) or 0) > 0 or mtype:isRewardBoss()
		if isBoss and name and name ~= "" and not seen[name:lower()] and mtype:maxHealth() > 0 then
			seen[name:lower()] = true
			rushPool[#rushPool + 1] = { name = name, health = mtype:maxHealth(), spawn = mtype:getTypeName() }
		end
	end
	if #rushPool < RUSH_WAVES * RUSH_MAX_BOSSES then
		for _, name in ipairs(rushBosses) do
			if not seen[name:lower()] then
				seen[name:lower()] = true
				rushPool[#rushPool + 1] = { name = name, health = 0 }
			end
		end
	end
	table.sort(rushPool, function(x, y)
		return x.health < y.health
	end)
	logger.info("[OTS hardcore boss] Pula losowych bossow: {}", #rushPool)
end

-- Losuje bossa dla fali wave (1..RUSH_WAVES) z odpowiedniego przedzialu puli.
local function rushPick(wave)
	if not rushPool then
		buildRushPool()
	end
	local total = #rushPool
	if total == 0 then
		return nil
	end
	local first = math.floor((wave - 1) * total / RUSH_WAVES) + 1
	local last = math.max(first, math.floor(wave * total / RUSH_WAVES))
	local choices = {}
	for i = first, math.min(last, total) do
		if not rush.used[rushPool[i].spawn or rushPool[i].name] then
			choices[#choices + 1] = rushPool[i].spawn or rushPool[i].name
		end
	end
	if #choices == 0 then
		for i = 1, total do
			if not rush.used[rushPool[i].spawn or rushPool[i].name] then
				choices[#choices + 1] = rushPool[i].spawn or rushPool[i].name
			end
		end
	end
	if #choices == 0 then
		return nil
	end
	return choices[math.random(#choices)]
end

local function rushAlive()
	local alive = {}
	for _, id in ipairs(rush.ids) do
		local creature = Creature(id)
		if creature then
			alive[#alive + 1] = id
			-- klony bossa z ta sama nazwa (np. Zamulosh) znikaja - liczy sie tylko prawdziwy boss
			for _, summon in ipairs(creature:getSummons() or {}) do
				if summon:getName() == creature:getName() then
					summon:remove()
				end
			end
		end
	end
	return alive
end

local function rushClear()
	for _, id in ipairs(rush.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
		OtsHardcoreBossDamage[id] = nil
		OtsHardcoreBossVulnerable[id] = nil
	end
	rush.ids = {}
	rush.tiers = {}
end

local function inRush(player)
	local pos = player:getPosition()
	return pos.z == rushCenter.z and math.abs(pos.x - rushCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - rushCenter.y) <= ARENA_RADIUS + 1
end

local rushCheck

local function rushNext(playerId, token)
	if token ~= rush.token then
		return
	end
	local player = Player(playerId)
	if not player or not inRush(player) then
		rushClear()
		return
	end
	if rush.wave >= RUSH_WAVES then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s ukonczony - wszystkie fale pokonane! Zabite bossy: %d.", RUSH_NAME, rush.kills))
		return
	end
	local wave = rush.wave + 1
	local want = math.random(RUSH_MIN_BOSSES, RUSH_MAX_BOSSES)
	local names = {}
	rush.ids = {}
	local attempts = 0
	while #rush.ids < want and attempts < 30 do
		attempts = attempts + 1
		local name = rushPick(wave)
		if not name then
			break
		end
		rush.used[name] = true
		local spot = RUSH_SPOTS[#rush.ids + 1]
		local monster = Game.createMonster(name, Position(rushCenter.x + spot[1], rushCenter.y + spot[2], rushCenter.z), true, true)
		if monster then
			local tier = rushTier()
			rushEmpower(monster, tier)
			rush.ids[#rush.ids + 1] = monster:getId()
			rush.tiers[monster:getId()] = tier
			names[#names + 1] = name .. " [" .. tier.label .. "]"
		end
	end
	if #rush.ids == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s ukonczony - brak kolejnych bossow. Zabite bossy: %d.", RUSH_NAME, rush.kills))
		return
	end
	rush.wave = wave
	rush.size = #rush.ids
	rush.spawnedAt = os.time()
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s - fala %d/%d (%dx): %s.", RUSH_NAME, wave, RUSH_WAVES, #names, table.concat(names, ", ")))
	addEvent(rushCheck, 1000, playerId, token)
end

rushCheck = function(playerId, token)
	if token ~= rush.token then
		return
	end
	local player = Player(playerId)
	if not player or not inRush(player) then
		rushClear()
		return
	end
	local alive = rushAlive()
	local timedOut = #alive > 0 and os.time() - rush.spawnedAt >= RUSH_WAVE_TIME
	if #alive > 0 and not timedOut then
		addEvent(rushCheck, 1000, playerId, token)
		return
	end
	local killed = rush.size - #alive
	local aliveSet = {}
	for _, id in ipairs(alive) do
		aliveSet[id] = true
	end
	local rewardPoints = 0
	for _, id in ipairs(rush.ids) do
		if not aliveSet[id] then
			rewardPoints = rewardPoints + (rush.tiers[id] and rush.tiers[id].reward or 1)
		end
	end
	rushClear()
	rush.kills = rush.kills + killed
	local wave = rush.wave
	local gold = rewardPoints * wave * 50000
	local coins = rewardPoints * wave * 2
	if killed > 0 then
		player:setBankBalance(player:getBankBalance() + gold)
		player:addTibiaCoins(coins)
	end
	local text
	if timedOut then
		text = string.format("Fala %d: czas minal (%d min), pozostale bossy zniknely. Zabite: %d/%d, +%d gp na konto, +%d Tibia Coins.", wave, RUSH_WAVE_TIME / 60, killed, rush.size, gold, coins)
	else
		text = string.format("Fala %d pokonana (%d bossow): +%d gp na konto, +%d Tibia Coins.", wave, killed, gold, coins)
	end
	local store = player:kv():scoped("ots-bossrush")
	if rush.kills > (tonumber(store:get("best")) or 0) then
		store:set("best", rush.kills)
		text = text .. " Nowy rekord!"
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	addEvent(rushNext, 3000, playerId, token)
end

hardcoreEmpower = function(monster)
	rushEmpower(monster, rushTier())
end

-- Bossy Hardcore Boss bija mocniej wedlug wylosowanej sily.
local rushDamage = EventCallback("OtsHardcoreBossDamage")

function rushDamage.creatureOnCombat(caster, target, combatDamage)
	if not caster or not combatDamage or type(caster.getId) ~= "function" then
		return
	end
	local multiplier = OtsHardcoreBossDamage[caster:getId()]
	if not multiplier then
		return
	end
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.value = math.floor(entry.value * multiplier)
		end
	end
	-- Limit jednego ciosu w gracza: najwyzej RUSH_MAX_HIT_PERCENT jego maksymalnego zycia
	-- (zeby kilka mocnych bossow naraz nie zabijalo na jednego hita).
	if target and type(target.isPlayer) == "function" and target:isPlayer() then
		local total = 0
		for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
			if entry and tonumber(entry.value) and entry.value < 0 then
				total = total - entry.value
			end
		end
		local cap = math.floor(target:getMaxHealth() * RUSH_MAX_HIT_PERCENT / 100)
		if total > cap and cap > 0 then
			local scale = cap / total
			for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
				if entry and tonumber(entry.value) and entry.value < 0 then
					entry.value = math.floor(entry.value * scale)
				end
			end
		end
	end
end

rushDamage:register()

-- Bossy odporne na kazdy zywiol (np. Ascending Ferumbras) przyjmuja w tych trybach obrazenia jako neutralne.
local rushVulnerable = EventCallback("OtsHardcoreBossVulnerable")

function rushVulnerable.creatureOnCombat(caster, target, combatDamage)
	if not target or not combatDamage or type(target.getId) ~= "function" or not OtsHardcoreBossVulnerable[target:getId()] then
		return
	end
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.type = COMBAT_NEUTRALDAMAGE
		end
	end
end

rushVulnerable:register()

local function rushEnter(player)
	if inFight(player) then
		return
	end
	rushClear()
	rush.token = rush.token + 1
	rush.wave = 0
	rush.kills = 0
	rush.used = {}
	travel(player, { RUSH_NAME, rushLanding.x, rushLanding.y, rushLanding.z })
	if not inRush(player) then
		return
	end
	local best = tonumber(player:kv():scoped("ots-bossrush"):get("best")) or 0
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s: pierwsza fala za chwile (%d-%d bossow naraz). Twoj rekord: %d zabitych. Wyjscie teleportem konczy bieg.", RUSH_NAME, RUSH_MIN_BOSSES, RUSH_MAX_BOSSES, best))
	addEvent(rushNext, 3000, player:getId(), rush.token)
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

-- Czy quest jest juz zrobiony: skrzynie z nagroda zapisuja to w questKV (kv) albo w storage.
local function storageByPath(path)
	if tonumber(path) then
		return tonumber(path)
	end
	local value = _G
	for part in path:gmatch("[^%.]+") do
		if type(value) ~= "table" then
			return nil
		end
		value = value[part]
	end
	return tonumber(value)
end

local function questDone(player, entry)
	local done = entry.done
	if not done then
		return false
	end
	for _, fname in ipairs(done.fn or {}) do
		local check = _G[fname]
		if check and check(player) then
			return true
		end
	end
	for _, name in ipairs(done.kv or {}) do
		if player:questKV(name):get("completed") then
			return true
		end
	end
	for _, item in ipairs(done.st or {}) do
		local key = storageByPath(item[1])
		if key and player:getStorageValue(key) >= (item[2] or 1) then
			return true
		end
	end
	return false
end

-- Dluga pierwsza linia poszerza okno w kliencie, zeby nazwy na liscie sie miescily.
local WIDE_MESSAGE = "Wybierz cel z listy i kliknij Wybierz. [Complete] = juz zrobione.                                        "

local function openList(player, title, list, back)
	local window = ModalWindow({ title = title, message = WIDE_MESSAGE })
	for i = 1, math.min(#list, 255) do
		local entry = list[i]
		local label = entry[1]
		if entry.done and questDone(player, entry) then
			label = "[Complete] " .. label
		end
		window:addChoice(label, function(target)
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

local openHunts

-- Bestiariusz w menu: najpierw klasa potworow, potem lista (cala lista ma ponad 255 pozycji).
local function openHuntClasses(player, group)
	local classes, byClass = {}, {}
	for _, entry in ipairs(group.list) do
		local cls = entry.cls or "Inne"
		if not byClass[cls] then
			byClass[cls] = {}
			classes[#classes + 1] = cls
		end
		table.insert(byClass[cls], entry)
	end
	local window = ModalWindow({ title = group.label, message = "Wybierz klase potworow." })
	for _, cls in ipairs(classes) do
		window:addChoice(cls .. " [" .. #byClass[cls] .. "]", function(target)
			openList(target, group.label .. " - " .. cls, byClass[cls], function(back)
				openHuntClasses(back, group)
			end)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		openHunts(target)
	end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

openHunts = function(player)
	local window = ModalWindow({ title = "Expowiska", message = "Bestiariusz: wszystkie potwory wg klas. Exp Low / Medium / High: wybrane expowiska." })
	for i = 1, #hubHunts do
		local group = hubHunts[i]
		window:addChoice(group.label .. " [" .. #group.list .. "]", function(target)
			if group.list[1] and group.list[1].cls then
				openHuntClasses(target, group)
			else
				openList(target, group.label, group.list, openHunts)
			end
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
	window:addChoice("Wierzchowce do oswojenia", function(target)
		if OtsMountHall and not inFight(target) then
			OtsMountHall(target)
		end
	end)
	window:addChoice("Taski", function(target)
		openTasks(target)
	end)
	window:addChoice("Fale potworow", function(target)
		survivalEnter(target)
	end)
	window:addChoice("Bestiariusz (fale wybranego potwora)", function(target)
		openBestiary(target)
	end)
	window:addChoice("Bosstiariusz (bossy do Mastery, Hardcore)", function(target)
		OtsOpenBosstiary(target)
	end)
	window:addChoice("Wieza (pietra, boss co 10)", function(target)
		towerEnter(target)
	end)
	window:addChoice("Hardcore Boss (3-5 losowych bossow naraz)", function(target)
		rushEnter(target)
	end)
	window:addChoice("Losowy Boss (nowy co 10 min po zabiciu)", function(target)
		raidEnter(target)
	end)
	window:addChoice("Questy [" .. #quests .. "]", function(target)
		openList(target, "Questy", quests, function(again)
			openMain(again)
		end)
	end)
	window:addChoice("Stroje (questy)", function(target)
		if inFight(target) then
			return
		end
		if OtsOutfitList then
			OtsOutfitList(target, function(again)
				openMain(again)
			end)
		elseif OtsOutfitHall then
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
	if not player then
		return true
	end
	-- OTS: powrot do hubu expowisk (lobby), nie do swiatyni
	player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	hubMove(player, hubLobby, "Hub: lobby")
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
		hubMove(player, Position(wing.x, wing.y, wing.z), wing.label .. ", pietro 1")
	elseif action.goto then
		hubMove(player, Position(action.goto[1], action.goto[2], action.goto[3]), action.label)
	elseif action.lobby then
		hubMove(player, hubLobby, "Hub: lobby")
	elseif action.thais and templePosition then
		hubMove(player, templePosition)
	elseif action.randomboss then
		raidEnter(player)
	elseif action.survival then
		survivalEnter(player)
	elseif action.bossrush then
		rushEnter(player)
	elseif action.tower then
		towerEnter(player)
	elseif action.bestiary then
		openBestiary(player)
	elseif action.mounts and OtsMountHall then
		OtsMountHall(player)
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
	elseif action.randomboss then
		text = "Losowy Boss"
	elseif action.survival then
		text = "Fale potworow"
	elseif action.bossrush then
		text = "Hardcore Boss"
	elseif action.tower then
		text = "Wieza"
	elseif action.bestiary then
		text = "Bestiariusz"
	elseif action.mounts then
		text = "Wierzchowce do oswojenia"
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

-- Straznik teleportow powrotnych: co kilka sekund sprawdza miejsca ladowania w poblizu graczy
-- (expowiska, Bestiariusz, sale) i stawia teleport od nowa, jesli zniknal.
local returnGuard = GlobalEvent("OtsReturnTeleportGuard")

function returnGuard.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local here = player:getPosition()
		for _, spot in pairs(preparedSpots) do
			local c = spot.center
			if c and c.z == here.z and math.abs(c.x - here.x) <= 15 and math.abs(c.y - here.y) <= 15 then
				prepareSpot(c)
			end
		end
	end
	return true
end

returnGuard:interval(5000)
returnGuard:register()

-- Po starcie serwera teleporty powrotne nie istnieja, dopoki ktos tam nie przyjdzie przez !tp.
-- Dlatego: sale (Bestiariusz, Fale, Hardcore Boss, Wieza, Arena, Losowy Boss) dostaja je od razu przy starcie,
-- a gracz, ktory loguje sie na expowisku, dostaje teleport przy najblizszym miejscu ladowania.
local roomGuard = GlobalEvent("OtsReturnTeleportRooms")

function roomGuard.onStartup()
	-- Zmniejszenie sali Bestiariusza do kwadratu BESTIARY_ROOM_RADIUS: dookola zywoplot z krzakow (blokuje
	-- przejscie), a dalej trawa z kwiatami i drzewami - tak jak brzegi pozostalych sal huba.
	local bushes = { 3681, 3682, 3699 }
	local flowers = { 3654, 3655, 3656, 3657, 3658, 3659 }
	local trees = { 3614, 3615, 3617, 3618, 3620, 3621 }
	local function hash(x, y, salt)
		local v = bit.bxor(bit.bxor(x * 73856093, y * 19349663), salt * 83492791)
		return bit.band(bit.bxor(v, bit.rshift(v, 13)), 0xFFFF)
	end
	local changed = 0
	for x = bestiaryCenter.x - ARENA_RADIUS, bestiaryCenter.x + ARENA_RADIUS do
		for y = bestiaryCenter.y - ARENA_RADIUS, bestiaryCenter.y + ARENA_RADIUS do
			local d = math.max(math.abs(x - BESTIARY_ROOM_CENTER.x) - BESTIARY_ROOM_RADIUS, math.abs(y - BESTIARY_ROOM_CENTER.y) - BESTIARY_ROOM_RADIUS)
			if d >= 1 then
				local pos = Position(x, y, bestiaryCenter.z)
				local tile = Tile(pos)
				if tile and tile:getGround() and not tile:getTopCreature() then
					local items = tile:getItems() or {}
					for index = #items, 1, -1 do
						items[index]:remove()
					end
					local r = hash(x, y, 0)
					if d == 1 then
						Game.createItem(bushes[r % #bushes + 1], 1, pos)
					elseif r % 100 < 22 then
						Game.createItem(flowers[hash(x, y, 1) % #flowers + 1], 1, pos)
					elseif d >= 3 and r % 100 < 34 then
						Game.createItem(trees[hash(x, y, 2) % #trees + 1], 1, pos)
					end
					changed = changed + 1
				end
			end
		end
	end
	logger.info("[OTS teleporty] Sala Bestiariusza: {}x{} z zywoplotem (zmienione pola: {})", BESTIARY_ROOM_RADIUS * 2 + 1, BESTIARY_ROOM_RADIUS * 2 + 1, changed)

	local landings = { arenaLanding, survivalLanding, rushLanding, towerLanding, bestiaryLanding }
	for _, room in ipairs(raidRooms) do
		landings[#landings + 1] = room.landing
	end
	for _, landing in ipairs(landings) do
		prepareSpot(landing)
	end
	return true
end

roomGuard:register()

local loginGuard = CreatureEvent("OtsReturnTeleportLogin")

function loginGuard.onLogin(player)
	local here = player:getPosition()
	local best, bestDistance = nil, 16
	for _, group in ipairs(hubHunts) do
		for _, entry in ipairs(group.list) do
			if entry[4] == here.z and not entry.town and not entry.plain then
				local distance = math.max(math.abs(entry[2] - here.x), math.abs(entry[3] - here.y))
				if distance < bestDistance then
					best, bestDistance = entry, distance
				end
			end
		end
	end
	if best then
		prepareSpot(Position(best[2], best[3], best[4]))
	end
	return true
end

loginGuard:register()

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

	-- Tabliczka nad padem w hubie (tekst z mapy) dostaje nowa nazwe trybu.
	local boardTile = Tile(Position(30000, 29997, 7))
	for _, item in ipairs(boardTile and boardTile:getItems() or {}) do
		local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
		if type(text) == "string" and text:find("Boss Rush", 1, true) then
			item:setAttribute(ITEM_ATTRIBUTE_TEXT, "Hardcore Boss\n3-5 losowych bossow naraz, fale coraz mocniejsze, nagroda za kazdego zabitego")
		end
	end
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
