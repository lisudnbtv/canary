-- OTS: "Token Trader" - sprzedaje przydatne rzeczy za christmas tokeny (leca z kazdego potwora).
-- Stawiany przy starcie serwera w swiatyni w Thais.
local internalNpcName = "Token Trader"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName
npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0
npcConfig.outfit = { lookType = 160, lookHead = 114, lookBody = 94, lookLegs = 95, lookFeet = 114, lookAddons = 3 }
npcConfig.flags = { floorchange = false }
npcConfig.speechBubble = SPEECHBUBBLE_TRADE
npcConfig.currency = 6526 -- christmas token

npcConfig.shop = {
	{ itemName = "lasting exercise sword", clientId = 35285, buy = 500 },
	{ itemName = "lasting exercise axe", clientId = 35286, buy = 500 },
	{ itemName = "lasting exercise club", clientId = 35287, buy = 500 },
	{ itemName = "lasting exercise bow", clientId = 35288, buy = 500 },
	{ itemName = "lasting exercise rod", clientId = 35289, buy = 500 },
	{ itemName = "lasting exercise wand", clientId = 35290, buy = 500 },
	{ itemName = "lasting exercise shield", clientId = 44067, buy = 500 },
	{ itemName = "stamina extension", clientId = 36725, buy = 100 },
	{ itemName = "exalted core", clientId = 37110, buy = 150 },
	{ itemName = "sliver", clientId = 37109, buy = 15 },
	{ itemName = "gold token", clientId = 22721, buy = 50 },
	{ itemName = "silver token", clientId = 22516, buy = 20 },
	{ itemName = "bar of gold", clientId = 14112, buy = 25 },
	{ itemName = "golden backpack", clientId = 2871, buy = 200 },
	{ itemName = "amulet of loss", clientId = 3057, buy = 30 },
	{ itemName = "crystal coin", clientId = 3043, buy = 2 },
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

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|! Wymieniam christmas tokeny na przydatne rzeczy - powiedz {trade}.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost) end
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)

local home = Position(32372, 32239, 7)
local place = GlobalEvent("OtsTokenTrader")

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
		logger.info("[OTS npc] Token Trader stoi: {}, {}, {}", spot.x, spot.y, spot.z)
	else
		logger.warn("[OTS npc] Nie udalo sie postawic: Token Trader")
	end
	return true
end

place:register()
