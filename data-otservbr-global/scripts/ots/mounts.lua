-- OTS: hala wierzchowcow. Plik generowany razem z mapa world/custom/ots-mounts.otbm.
-- Kazdy pad prowadzi do zagrody z 5 stworzeniami do oswojenia (odradzaja sie po ok. minucie).
-- Przedmioty do oswajania sprzedaje Tamer w hali, po 1 gp. Samo oswajanie robi skrypt silnika.

local PAD_ACTION_ID = 64997
local hall = Position(29498, 31005, 7)
local hubLobby = Position(30013, 30000, 7)
local tamerPosition = Position(29498, 31011, 7)

local mounts = {
	{ name = "Bear", item = 5907, itemName = "slingshot", mountId = 3, entry = Position(29504, 31069, 7), display = Position(29503, 30996, 7), faceSouth = true, outfit = { lookType = 16, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Black Sheep", item = 12308, itemName = "reins", mountId = 4, entry = Position(29528, 31069, 7), display = Position(29503, 31004, 7), faceSouth = false, outfit = { lookType = 13, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Boar", item = 12260, itemName = "hunting horn", mountId = 10, entry = Position(29552, 31069, 7), display = Position(29506, 30996, 7), faceSouth = true, outfit = { lookType = 380, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Crustacea Gigantica", item = 12318, itemName = "giant shrimp", mountId = 7, entry = Position(29576, 31069, 7), display = Position(29506, 31004, 7), faceSouth = false, outfit = { lookType = 383, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Crystal Wolf", item = 12547, itemName = "diapason", mountId = 16, entry = Position(29600, 31069, 7), display = Position(29509, 30996, 7), faceSouth = true, outfit = { lookType = 391, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Donkey", item = 12548, itemName = "bag of apple slices", mountId = 13, entry = Position(29624, 31069, 7), display = Position(29509, 31004, 7), faceSouth = false, outfit = { lookType = 387, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Dragonling", item = 16155, itemName = "decorative ribbon", mountId = 31, entry = Position(29648, 31069, 7), display = Position(29512, 30996, 7), faceSouth = true, outfit = { lookType = 505, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Draptor", item = 12307, itemName = "harness", mountId = 6, entry = Position(29672, 31069, 7), display = Position(29512, 31004, 7), faceSouth = false, outfit = { lookType = 382, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Dromedary", item = 12546, itemName = "fist on a stick", mountId = 20, entry = Position(29696, 31069, 7), display = Position(29515, 30996, 7), faceSouth = true, outfit = { lookType = 404, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Enraged White Deer", item = 12550, itemName = "golden fir cone", mountId = 18, entry = Position(29720, 31069, 7), display = Position(29515, 31004, 7), faceSouth = false, outfit = { lookType = 400, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Flying Book", item = 28791, itemName = "library ticket", mountId = 126, entry = Position(29504, 31093, 7), display = Position(29518, 30996, 7), faceSouth = true, outfit = { lookType = 1060, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Gravedigger", item = 19136, itemName = "nail case", mountId = 39, entry = Position(29528, 31093, 7), display = Position(29518, 31004, 7), faceSouth = false, outfit = { lookType = 558, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Gryphon", item = 31576, itemName = "Regalia of Suon", mountId = 144, entry = Position(29552, 31093, 7), display = Position(29503, 31006, 7), faceSouth = true, outfit = { lookType = 1220, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Hibernal Moth", item = 30171, itemName = "purple tendril lantern", mountId = 131, entry = Position(29576, 31093, 7), display = Position(29503, 31014, 7), faceSouth = false, outfit = { lookType = 1149, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Ironblight", item = 16153, itemName = "iron loadstone", mountId = 29, entry = Position(29600, 31093, 7), display = Position(29506, 31006, 7), faceSouth = true, outfit = { lookType = 498, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Lacewing Moth", item = 30170, itemName = "turquoise tendril lantern", mountId = 130, entry = Position(29624, 31093, 7), display = Position(29506, 31014, 7), faceSouth = false, outfit = { lookType = 1148, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Ladybug", item = 14143, itemName = "four-leaf clover", mountId = 27, entry = Position(29648, 31093, 7), display = Position(29509, 31006, 7), faceSouth = true, outfit = { lookType = 448, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Magma Crawler", item = 16154, itemName = "glow wine", mountId = 30, entry = Position(29672, 31093, 7), display = Position(29509, 31014, 7), faceSouth = false, outfit = { lookType = 492, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Manta Ray", item = 14142, itemName = "foxtail", mountId = 28, entry = Position(29696, 31093, 7), display = Position(29512, 31006, 7), faceSouth = true, outfit = { lookType = 449, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Midnight Panther", item = 12306, itemName = "leather whip", mountId = 5, entry = Position(29720, 31093, 7), display = Position(29512, 31014, 7), faceSouth = false, outfit = { lookType = 385, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Modified Gnarlhound", item = 16251, itemName = "golem wrench", mountId = 32, entry = Position(29504, 31117, 7), display = Position(29515, 31006, 7), faceSouth = true, outfit = { lookType = 515, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Mole", item = 27605, itemName = "candle stump", mountId = 119, entry = Position(29528, 31117, 7), display = Position(29515, 31014, 7), faceSouth = false, outfit = { lookType = 1048, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Noble Lion", item = 21439, itemName = "Lion's Heart", mountId = 40, entry = Position(29552, 31117, 7), display = Position(29518, 31006, 7), faceSouth = true, outfit = { lookType = 570, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Panda", item = 12549, itemName = "bamboo leaves", mountId = 19, entry = Position(29576, 31117, 7), display = Position(29518, 31014, 7), faceSouth = false, outfit = { lookType = 123, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Sandstone Scorpion", item = 12509, itemName = "scorpion sceptre", mountId = 21, entry = Position(29600, 31117, 7), display = Position(29503, 30970, 7), faceSouth = true, outfit = { lookType = 398, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Shock Head", item = 20274, itemName = "nightmare horn", mountId = 42, entry = Position(29624, 31117, 7), display = Position(29503, 30978, 7), faceSouth = false, outfit = { lookType = 579, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Slug", item = 12519, itemName = "slug drug", mountId = 14, entry = Position(29648, 31117, 7), display = Position(29506, 30970, 7), faceSouth = true, outfit = { lookType = 407, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Stone Rhino", item = 24960, itemName = "astral shaper rune", mountId = 106, entry = Position(29672, 31117, 7), display = Position(29506, 30978, 7), faceSouth = false, outfit = { lookType = 936, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Terror Bird", item = 12311, itemName = "carrot on a stick", mountId = 2, entry = Position(29696, 31117, 7), display = Position(29509, 30970, 7), faceSouth = true, outfit = { lookType = 218, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Undead Cavebear", item = 12304, itemName = "maxilla maximus", mountId = 12, entry = Position(29720, 31117, 7), display = Position(29509, 30978, 7), faceSouth = false, outfit = { lookType = 384, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Wailing Widow", item = 12320, itemName = "sweet smelling bait", mountId = 1, entry = Position(29504, 31141, 7), display = Position(29512, 30970, 7), faceSouth = true, outfit = { lookType = 347, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Walker", item = 21186, itemName = "control unit", mountId = 43, entry = Position(29528, 31141, 7), display = Position(29512, 30978, 7), faceSouth = false, outfit = { lookType = 605, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Water Buffalo", item = 17858, itemName = "leech", mountId = 35, entry = Position(29552, 31141, 7), display = Position(29515, 30970, 7), faceSouth = true, outfit = { lookType = 523, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "White Lion", item = 34258, itemName = "red silk flower", mountId = 174, entry = Position(29576, 31141, 7), display = Position(29515, 30978, 7), faceSouth = false, outfit = { lookType = 1290, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
	{ name = "Wild Horse", item = 12802, itemName = "sugar oat", mountId = 17, entry = Position(29600, 31141, 7), display = Position(29518, 30970, 7), faceSouth = true, outfit = { lookType = 393, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 } },
}

local pads = {
	["29496:30977:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29496:30979:7"] = { hub = true },
	["29496:30981:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29496:31003:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29496:31005:7"] = { hub = true },
	["29496:31007:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29503:30972:7"] = { room = 25 },
	["29503:30976:7"] = { room = 26 },
	["29503:30998:7"] = { room = 1 },
	["29503:31002:7"] = { room = 2 },
	["29503:31008:7"] = { room = 13 },
	["29503:31012:7"] = { room = 14 },
	["29505:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29505:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29505:31118:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29505:31142:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29506:30972:7"] = { room = 27 },
	["29506:30976:7"] = { room = 28 },
	["29506:30998:7"] = { room = 3 },
	["29506:31002:7"] = { room = 4 },
	["29506:31008:7"] = { room = 15 },
	["29506:31012:7"] = { room = 16 },
	["29509:30972:7"] = { room = 29 },
	["29509:30976:7"] = { room = 30 },
	["29509:30998:7"] = { room = 5 },
	["29509:31002:7"] = { room = 6 },
	["29509:31008:7"] = { room = 17 },
	["29509:31012:7"] = { room = 18 },
	["29512:30972:7"] = { room = 31 },
	["29512:30976:7"] = { room = 32 },
	["29512:30998:7"] = { room = 7 },
	["29512:31002:7"] = { room = 8 },
	["29512:31008:7"] = { room = 19 },
	["29512:31012:7"] = { room = 20 },
	["29515:30972:7"] = { room = 33 },
	["29515:30976:7"] = { room = 34 },
	["29515:30998:7"] = { room = 9 },
	["29515:31002:7"] = { room = 10 },
	["29515:31008:7"] = { room = 21 },
	["29515:31012:7"] = { room = 22 },
	["29518:30972:7"] = { room = 35 },
	["29518:30998:7"] = { room = 11 },
	["29518:31002:7"] = { room = 12 },
	["29518:31008:7"] = { room = 23 },
	["29518:31012:7"] = { room = 24 },
	["29529:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29529:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29529:31118:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29529:31142:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29553:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29553:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29553:31118:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29553:31142:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29577:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29577:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29577:31118:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29577:31142:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29601:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29601:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29601:31118:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29601:31142:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29625:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29625:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29625:31118:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29649:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29649:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29649:31118:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29673:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29673:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29673:31118:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29697:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29697:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29697:31118:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
	["29721:31070:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29721:31094:7"] = { goto = Position(29498, 31005, 7), label = "Mounty 1/2" },
	["29721:31118:7"] = { goto = Position(29498, 30979, 7), label = "Mounty 2/2" },
}

local navNpcs = {
	{ name = "Poprzednie pomieszczenie", position = Position(29495, 31003, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29495, 31007, 7) },
	{ name = "Lobby", position = Position(29495, 31005, 7) },
	{ name = "Poprzednie pomieszczenie", position = Position(29495, 30977, 7) },
	{ name = "Nastepne pomieszczenie", position = Position(29495, 30981, 7) },
	{ name = "Lobby", position = Position(29495, 30979, 7) },
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

-- Wejscie z hubu i z menu !tp.
function OtsMountHall(player)
	move(player, hall, "Wierzchowce, pietro 1")
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
		local mount = mounts[pad.room]
		local text
		if player:hasMount(mount.mountId) then
			text = mount.name .. ": tego wierzchowca juz masz."
		else
			text = string.format("%s: uzyj na nim przedmiotu %s.", mount.name, mount.itemName)
		end
		move(player, mount.entry, text)
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

-- Postacie pokazowe: wyglad stworzenia do oswojenia, po jednej za kazdym padem.
local function displayName(mount)
	return "Mount " .. mount.name
end

for _, mount in ipairs(mounts) do
	local name = displayName(mount)
	local npcType = Game.createNpcType(name)
	npcType:register({
		name = name,
		description = name,
		health = 100,
		maxHealth = 100,
		walkInterval = 0,
		walkRadius = 0,
		outfit = mount.outfit,
		flags = { floorchange = false },
	})
end

-- Tamer: sprzedaje wszystkie przedmioty do oswajania.
local tamerName = "Tamer"
local tamerType = Game.createNpcType(tamerName)
local tamerConfig = {
	name = tamerName,
	description = tamerName,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = { lookType = 144, lookHead = 114, lookBody = 120, lookLegs = 120, lookFeet = 114, lookAddons = 3 },
	flags = { floorchange = false },
	speechBubble = SPEECHBUBBLE_TRADE,
	shop = {},
}
for _, mount in ipairs(mounts) do
	tamerConfig.shop[#tamerConfig.shop + 1] = { itemName = mount.itemName, clientId = mount.item, buy = 1 }
end
-- Dodatkowo: music box (oswaja od reki dragonlinga, draptora, white deer, ironblighta, magma crawlera,
-- midnight panther, wailing widow, wild horse i pande) oraz przedmioty, ktore daja wierzchowca po samym uzyciu.
local tamerExtras = {
	{ itemName = "music box", clientId = 16244, buy = 1 },
	{ itemName = "vibrant egg", clientId = 23538, buy = 1 },
	{ itemName = "crackling egg", clientId = 23684, buy = 1 },
	{ itemName = "menacing egg", clientId = 23685, buy = 1 },
	{ itemName = "spectral scrap of cloth", clientId = 32629, buy = 1 },
	{ itemName = "demon in a green box", clientId = 50064, buy = 1 },
}
for _, extra in ipairs(tamerExtras) do
	tamerConfig.shop[#tamerConfig.shop + 1] = extra
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

tamerType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end
tamerType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end
tamerType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end
tamerType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end
tamerType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end
tamerType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|! Mam wszystko do oswajania wierzchowcow - powiedz {trade}.")
npcHandler:addModule(FocusModule:new(), tamerName, true, true, true)

tamerType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
tamerType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost) end
tamerType.onCheckItem = function(npc, player, clientId, subType) end

tamerType:register(tamerConfig)

local place = GlobalEvent("OtsMountHallNpcs")

function place.onStartup()
	local placed = 0
	for _, mount in ipairs(mounts) do
		local npc = Game.createNpc(displayName(mount), mount.display, false, true)
		if npc then
			npc:setMasterPos(mount.display)
			npc:setDirection(mount.faceSouth and DIRECTION_SOUTH or DIRECTION_NORTH)
			placed = placed + 1
		end
	end
	local guides = 0
	for _, guide in ipairs(navNpcs) do
		local npc = Game.createNpc(guide.name, guide.position, false, true)
		if npc then
			npc:setMasterPos(guide.position)
			npc:setDirection(DIRECTION_EAST)
			guides = guides + 1
		end
	end
	local tamer = Game.createNpc(tamerName, tamerPosition, false, true)
	if tamer then
		tamer:setMasterPos(tamerPosition)
		tamer:setDirection(DIRECTION_NORTH)
	end
	logger.info("[OTS mounty] Postacie pokazowe: {}/{}, przy padach: {}/{}, Tamer: {}", placed, #mounts, guides, #navNpcs, tamer and "tak" or "nie")
	return true
end

place:register()
