-- OTS: podobizny bossow w hali bossow (plik generowany razem z mapa hubu).
-- Kazda to NPC z wygladem bossa; stoi za padem prowadzacym pod jego dzwignie.

local displays = {
	{ name = "Low", outfit = { lookType = 128, lookHead = 78, lookBody = 69, lookLegs = 58, lookFeet = 76, lookAddons = 3 }, position = Position(30005, 29998, 7), faceSouth = true },
	{ name = "Medium", outfit = { lookType = 131, lookHead = 78, lookBody = 69, lookLegs = 58, lookFeet = 76, lookAddons = 3 }, position = Position(30011, 29998, 7), faceSouth = true },
	{ name = "Hard", outfit = { lookType = 335, lookHead = 78, lookBody = 69, lookLegs = 58, lookFeet = 76, lookAddons = 3 }, position = Position(30017, 29998, 7), faceSouth = true },
	{ name = "Very Hard", outfit = { lookType = 541, lookHead = 78, lookBody = 69, lookLegs = 58, lookFeet = 76, lookAddons = 3 }, position = Position(30023, 29998, 7), faceSouth = true },
	{ name = "Boss Ahau", outfit = { lookType = 1591, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30003, 29916, 7), faceSouth = true },
	{ name = "Boss Anomaly", outfit = { lookType = 876, lookHead = 38, lookBody = 79, lookLegs = 76, lookFeet = 79, lookAddons = 1, lookMount = 0 }, position = Position(30003, 29924, 7), faceSouth = false },
	{ name = "Boss Ascending Ferumbras", outfit = { lookType = 844, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30006, 29916, 7), faceSouth = true },
	{ name = "Boss Brokul", outfit = { lookType = 1076, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30006, 29924, 7), faceSouth = false },
	{ name = "Boss Eradicator", outfit = { lookType = 875, lookHead = 79, lookBody = 3, lookLegs = 114, lookFeet = 79, lookAddons = 1, lookMount = 0 }, position = Position(30009, 29916, 7), faceSouth = true },
	{ name = "Boss Foreshock", outfit = { lookType = 875, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30009, 29924, 7), faceSouth = false },
	{ name = "Boss Grand Master Oberon", outfit = { lookType = 1072, lookHead = 21, lookBody = 96, lookLegs = 21, lookFeet = 105, lookAddons = 1, lookMount = 0 }, position = Position(30012, 29916, 7), faceSouth = true },
	{ name = "Boss Mazoran", outfit = { lookType = 842, lookHead = 77, lookBody = 79, lookLegs = 78, lookFeet = 94, lookAddons = 3, lookMount = 0 }, position = Position(30012, 29924, 7), faceSouth = false },
	{ name = "Boss Mitmah Vanguard", outfit = { lookType = 1716, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30015, 29916, 7), faceSouth = true },
	{ name = "Boss Outburst", outfit = { lookType = 876, lookHead = 79, lookBody = 3, lookLegs = 94, lookFeet = 3, lookAddons = 3, lookMount = 0 }, position = Position(30015, 29924, 7), faceSouth = false },
	{ name = "Boss Plagirath", outfit = { lookType = 862, lookHead = 84, lookBody = 62, lookLegs = 60, lookFeet = 79, lookAddons = 1, lookMount = 0 }, position = Position(30018, 29916, 7), faceSouth = true },
	{ name = "Boss Ragiaz", outfit = { lookType = 862, lookHead = 76, lookBody = 57, lookLegs = 19, lookFeet = 0, lookAddons = 3, lookMount = 0 }, position = Position(30018, 29924, 7), faceSouth = false },
	{ name = "Boss Razzagorn", outfit = { lookType = 842, lookHead = 78, lookBody = 94, lookLegs = 13, lookFeet = 126, lookAddons = 0, lookMount = 0 }, position = Position(30021, 29916, 7), faceSouth = true },
	{ name = "Boss Rupture", outfit = { lookType = 875, lookHead = 77, lookBody = 79, lookLegs = 3, lookFeet = 85, lookAddons = 0, lookMount = 0 }, position = Position(30021, 29924, 7), faceSouth = false },
	{ name = "Boss Scarlett Etzel", outfit = { lookType = 1201, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30024, 29916, 7), faceSouth = true },
	{ name = "Boss Shulgrax", outfit = { lookType = 842, lookHead = 0, lookBody = 62, lookLegs = 2, lookFeet = 87, lookAddons = 1, lookMount = 0 }, position = Position(30024, 29924, 7), faceSouth = false },
	{ name = "Boss Tarbaz", outfit = { lookType = 842, lookHead = 0, lookBody = 21, lookLegs = 19, lookFeet = 3, lookAddons = 2, lookMount = 0 }, position = Position(30027, 29916, 7), faceSouth = true },
	{ name = "Boss The Lord Of The Lice", outfit = { lookType = 305, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30027, 29924, 7), faceSouth = false },
	{ name = "Boss The Shatterer", outfit = { lookType = 842, lookHead = 77, lookBody = 132, lookLegs = 21, lookFeet = 20, lookAddons = 0, lookMount = 0 }, position = Position(30030, 29916, 7), faceSouth = true },
	{ name = "Boss Zamulosh", outfit = { lookType = 862, lookHead = 16, lookBody = 12, lookLegs = 73, lookFeet = 55, lookAddons = 0, lookMount = 0 }, position = Position(30030, 29924, 7), faceSouth = false },
	{ name = "Boss Spirit Of Fertility", outfit = { lookType = 11, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30033, 29916, 7), faceSouth = true },
	{ name = "Boss Urmahlullu The Immaculate", outfit = { lookType = 1197, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30033, 29924, 7), faceSouth = false },
	{ name = "Boss Arbaziloth", outfit = { lookType = 1802, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30036, 29916, 7), faceSouth = true },
	{ name = "Boss Bakragore", outfit = { lookType = 1671, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30036, 29924, 7), faceSouth = false },
	{ name = "Boss Chagorz", outfit = { lookType = 1666, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30039, 29916, 7), faceSouth = true },
	{ name = "Boss Count Vlarkorth", outfit = { lookType = 1221, lookHead = 19, lookBody = 0, lookLegs = 83, lookFeet = 20, lookAddons = 1, lookMount = 0 }, position = Position(30039, 29924, 7), faceSouth = false },
	{ name = "Boss Duke Krule", outfit = { lookType = 1221, lookHead = 8, lookBody = 8, lookLegs = 19, lookFeet = 79, lookAddons = 3, lookMount = 0 }, position = Position(30042, 29916, 7), faceSouth = true },
	{ name = "Boss Earl Osam", outfit = { lookType = 1223, lookHead = 113, lookBody = 0, lookLegs = 79, lookFeet = 95, lookAddons = 0, lookMount = 0 }, position = Position(30042, 29924, 7), faceSouth = false },
	{ name = "Boss Faceless Bane", outfit = { lookType = 1119, lookHead = 0, lookBody = 2, lookLegs = 95, lookFeet = 97, lookAddons = 0, lookMount = 0 }, position = Position(30045, 29916, 7), faceSouth = true },
	{ name = "Boss Generator", outfit = { lookTypeEx = 20710 }, position = Position(30045, 29924, 7), faceSouth = false },
	{ name = "Boss Ghulosh", outfit = { lookType = 1062, lookHead = 78, lookBody = 113, lookLegs = 94, lookFeet = 18, lookAddons = 3, lookMount = 0 }, position = Position(30048, 29916, 7), faceSouth = true },
	{ name = "Boss Gorzindel", outfit = { lookType = 1062, lookHead = 94, lookBody = 81, lookLegs = 10, lookFeet = 0, lookAddons = 1, lookMount = 0 }, position = Position(30048, 29924, 7), faceSouth = false },
	{ name = "Boss Ichgahal", outfit = { lookType = 1665, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30051, 29916, 7), faceSouth = true },
	{ name = "Boss King Zelos", outfit = { lookType = 1224, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30051, 29924, 7), faceSouth = false },
	{ name = "Boss Lady Tenebris", outfit = { lookType = 433, lookHead = 76, lookBody = 95, lookLegs = 38, lookFeet = 94, lookAddons = 2, lookMount = 0 }, position = Position(30054, 29916, 7), faceSouth = true },
	{ name = "Boss Lloyd", outfit = { lookType = 940, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30054, 29924, 7), faceSouth = false },
	{ name = "Boss Lokathmor", outfit = { lookType = 1062, lookHead = 22, lookBody = 57, lookLegs = 79, lookFeet = 77, lookAddons = 0, lookMount = 0 }, position = Position(30057, 29916, 7), faceSouth = true },
	{ name = "Boss Lord Azaram", outfit = { lookType = 1223, lookHead = 19, lookBody = 2, lookLegs = 94, lookFeet = 81, lookAddons = 3, lookMount = 0 }, position = Position(30057, 29924, 7), faceSouth = false },
	{ name = "Boss Mazzinor", outfit = { lookType = 1062, lookHead = 85, lookBody = 7, lookLegs = 3, lookFeet = 15, lookAddons = 2, lookMount = 0 }, position = Position(30060, 29916, 7), faceSouth = true },
	{ name = "Boss Megasylvan Yselda", outfit = { lookTypeEx = 36928 }, position = Position(30060, 29924, 7), faceSouth = false },
	{ name = "Boss Murcion", outfit = { lookType = 1664, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30063, 29916, 7), faceSouth = true },
	{ name = "Boss Ratmiral Blackwhiskers", outfit = { lookType = 1377, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30063, 29924, 7), faceSouth = false },
	{ name = "Boss Sir Nictros", outfit = { lookType = 1222, lookHead = 101, lookBody = 79, lookLegs = 0, lookFeet = 0, lookAddons = 2, lookMount = 0 }, position = Position(30066, 29916, 7), faceSouth = true },
	{ name = "Boss Tentugly's Head", outfit = { lookTypeEx = 35105 }, position = Position(30066, 29924, 7), faceSouth = false },
	{ name = "Boss The Brainstealer", outfit = { lookType = 1412, lookHead = 94, lookBody = 88, lookLegs = 88, lookFeet = 114, lookAddons = 0, lookMount = 0 }, position = Position(30069, 29916, 7), faceSouth = true },
	{ name = "Boss The Dread Maiden", outfit = { lookType = 1278, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30069, 29924, 7), faceSouth = false },
	{ name = "Boss The Enraged Thorn Knight", outfit = { lookType = 512, lookHead = 81, lookBody = 121, lookLegs = 121, lookFeet = 121, lookAddons = 3, lookMount = 0 }, position = Position(30072, 29916, 7), faceSouth = true },
	{ name = "Boss The Fear Feaster", outfit = { lookType = 1276, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30072, 29924, 7), faceSouth = false },
	{ name = "Boss The Last Lore Keeper", outfit = { lookType = 939, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30075, 29916, 7), faceSouth = true },
	{ name = "Boss The Nightmare Beast", outfit = { lookType = 1144, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30075, 29924, 7), faceSouth = false },
	{ name = "Boss The Pale Worm", outfit = { lookType = 1272, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30078, 29916, 7), faceSouth = true },
	{ name = "Boss The Scourge Of Oblivion", outfit = { lookType = 875, lookHead = 79, lookBody = 3, lookLegs = 4, lookFeet = 2, lookAddons = 3, lookMount = 0 }, position = Position(30078, 29924, 7), faceSouth = false },
	{ name = "Boss The Time Guardian", outfit = { lookType = 945, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30081, 29916, 7), faceSouth = true },
	{ name = "Boss The Unwelcome", outfit = { lookType = 1277, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30081, 29924, 7), faceSouth = false },
	{ name = "Boss Timira The Many-Headed", outfit = { lookType = 1542, lookAddons = 3 }, position = Position(30084, 29916, 7), faceSouth = true },
	{ name = "Boss Vemiath", outfit = { lookType = 1668, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30084, 29924, 7), faceSouth = false },
	{ name = "Boss Soul Of Dragonking Zyrtarch", outfit = { lookType = 938, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30087, 29916, 7), faceSouth = true },
	{ name = "Boss Magma Bubble", outfit = { lookType = 1413, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30087, 29924, 7), faceSouth = false },
	{ name = "Boss The Primal Menace", outfit = { lookType = 1566, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }, position = Position(30090, 29916, 7), faceSouth = true },
}

for _, display in ipairs(displays) do
	local npcType = Game.createNpcType(display.name)
	local npcConfig = {}
	npcConfig.name = display.name
	npcConfig.description = display.name
	npcConfig.health = 100
	npcConfig.maxHealth = 100
	npcConfig.walkInterval = 0
	npcConfig.walkRadius = 0
	npcConfig.outfit = display.outfit
	npcConfig.flags = {
		floorchange = false,
	}
	npcType:register(npcConfig)
end

local place = GlobalEvent("OtsBossDisplays")

function place.onStartup()
	local placed = 0
	for _, display in ipairs(displays) do
		local npc = Game.createNpc(display.name, display.position, false, true)
		if npc then
			npc:setMasterPos(display.position)
			npc:setDirection(display.faceSouth and DIRECTION_SOUTH or DIRECTION_NORTH)
			placed = placed + 1
		end
	end
	logger.info("[OTS hub] Postacie w hubie (poziomy i bossy): {}/{}", placed, #displays)
	return true
end

place:register()
