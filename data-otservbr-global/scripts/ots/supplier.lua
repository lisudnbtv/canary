-- OTS: "Supplier" - wszystko w jednym miejscu: runy, potiony, amunicja i narzedzia po 1 gp.
-- Stawiany przy starcie serwera w swiatyni w Thais.
local internalNpcName = "Supplier"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName
npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0
npcConfig.outfit = { lookType = 130, lookHead = 95, lookBody = 94, lookLegs = 114, lookFeet = 114, lookAddons = 3 }
npcConfig.flags = { floorchange = false }
npcConfig.speechBubble = SPEECHBUBBLE_TRADE

npcConfig.shop = {
	{ itemName = "sudden death rune", clientId = 3155, buy = 1 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 1 },
	{ itemName = "avalanche rune", clientId = 3161, buy = 1 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 1 },
	{ itemName = "stone shower rune", clientId = 3175, buy = 1 },
	{ itemName = "icicle rune", clientId = 3158, buy = 1 },
	{ itemName = "explosion rune", clientId = 3200, buy = 1 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 1 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 1 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 1 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 1 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 1 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 1 },
	{ itemName = "paralyse rune", clientId = 3165, buy = 1 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 1 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 1 },
	{ itemName = "disintegrate rune", clientId = 3197, buy = 1 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 1 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 1 },
	{ itemName = "great health potion", clientId = 239, buy = 1 },
	{ itemName = "strong health potion", clientId = 236, buy = 1 },
	{ itemName = "health potion", clientId = 266, buy = 1 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 1 },
	{ itemName = "great mana potion", clientId = 238, buy = 1 },
	{ itemName = "strong mana potion", clientId = 237, buy = 1 },
	{ itemName = "mana potion", clientId = 268, buy = 1 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 1 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 1 },
	{ itemName = "diamond arrow", clientId = 25757, buy = 1 },
	{ itemName = "crystal arrow", clientId = 3239, buy = 1 },
	{ itemName = "onyx arrow", clientId = 7365, buy = 1 },
	{ itemName = "envenomed arrow", clientId = 16143, buy = 1 },
	{ itemName = "burst arrow", clientId = 3449, buy = 1 },
	{ itemName = "arrow", clientId = 3447, buy = 1 },
	{ itemName = "spectral bolt", clientId = 25758, buy = 1 },
	{ itemName = "prismatic bolt", clientId = 16141, buy = 1 },
	{ itemName = "infernal bolt", clientId = 6528, buy = 1 },
	{ itemName = "power bolt", clientId = 3450, buy = 1 },
	{ itemName = "bolt", clientId = 3446, buy = 1 },
	{ itemName = "royal star", clientId = 25759, buy = 1 },
	{ itemName = "assassin star", clientId = 7368, buy = 1 },
	{ itemName = "royal spear", clientId = 7378, buy = 1 },
	{ itemName = "enchanted spear", clientId = 7367, buy = 1 },
	{ itemName = "quiver", clientId = 35562, buy = 1 },
	{ itemName = "backpack", clientId = 2854, buy = 1 },
	{ itemName = "rope", clientId = 3003, buy = 1 },
	{ itemName = "shovel", clientId = 3457, buy = 1 },
	{ itemName = "light shovel", clientId = 5710, buy = 1 },
	{ itemName = "pick", clientId = 3456, buy = 1 },
	{ itemName = "machete", clientId = 3308, buy = 1 },
	{ itemName = "scythe", clientId = 3453, buy = 1 },
	{ itemName = "fishing rod", clientId = 3483, buy = 1 },
	{ itemName = "brown mushroom", clientId = 3725, buy = 1 },
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end
npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end
npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end
npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end
npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|! Runy, potiony, amunicja i narzedzia - powiedz {trade}.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost) end
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)

local home = Position(32366, 32239, 7)
local place = GlobalEvent("OtsSupplier")

function place.onStartup()
	local spot = nil
	for radius = 0, 3 do
		for dx = -radius, radius do
			for dy = -radius, radius do
				if not spot then
					local pos = Position(home.x + dx, home.y + dy, home.z)
					local tile = Tile(pos)
					if tile and tile:isWalkable(false, true, true, true, false) and tile:getItemCount() == 0 and not tile:getTopCreature() then
						spot = pos
					end
				end
			end
		end
	end
	local npc = spot and Game.createNpc(internalNpcName, spot, false, true)
	if npc then
		npc:setMasterPos(spot)
		logger.info("[OTS npc] Supplier stoi: {}, {}, {}", spot.x, spot.y, spot.z)
	else
		logger.warn("[OTS npc] Nie udalo sie postawic: Supplier")
	end
	return true
end

place:register()
