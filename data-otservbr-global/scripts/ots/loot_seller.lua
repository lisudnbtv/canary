-- OTS: "Loot Seller" w depo w Thais. Skupuje caly loot: pojedynczo przez {trade}
-- albo wszystko naraz z loot poucha (pozycja "all loot in pouch" w oknie handlu).
-- Kopia NPC The Lootmonger pod wlasna nazwa, stawiana przy starcie serwera.
local internalNpcName = "Loot Seller"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1575,
	lookHead = 96,
	lookBody = 101,
	lookLegs = 120,
	lookFeet = 120,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
	profession = "trader",
}
npcConfig.speechBubble = SPEECHBUBBLE_TRADE

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

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = LootShopConfig

local function creatureSayCallback(npc, player, type, message)
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	local categoryTable = LootShopConfigTable[message:lower()]
	if MsgContains(message, "shop options") then
		npcHandler:say("I sell a selection of " .. GetFormattedShopCategoryNames(LootShopConfigTable), npc, player)
	elseif categoryTable then
		local remainingCategories = npc:getRemainingShopCategories(message:lower(), LootShopConfigTable)
		npcHandler:say("Of course, just browse through my wares. You can also look at " .. remainingCategories .. ".", npc, player)
		npc:openShopWindowTable(player, categoryTable)
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Ah, a customer! Be greeted, |PLAYERNAME|! I buy all kinds of loot, would you like a {trade}? I can also show you my {shop options}.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Ah, a customer! Be greeted, |PLAYERNAME|! I buy all kinds of loot, would you look at " .. GetFormattedShopCategoryNames(LootShopConfigTable) .. ".")

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)

-- Miejsce w depo w Thais (hala na zachod od szafek); gdy pole jest zajete, szukamy obok.
local home = Position(32350, 32227, 7)

local place = GlobalEvent("OtsLootSeller")

function place.onStartup()
	local spot = nil
	for radius = 0, 3 do
		for dx = -radius, radius do
			for dy = -radius, radius do
				if not spot then
					local pos = Position(home.x + dx, home.y + dy, home.z)
					local tile = Tile(pos)
					if tile and tile:isWalkable(false, true, true, true, false) and tile:getItemCount() == 0 then
						spot = pos
					end
				end
			end
		end
	end

	local npc = spot and Game.createNpc(internalNpcName, spot, false, true)
	if npc then
		npc:setMasterPos(spot)
		logger.info("[OTS loot] Loot Seller stoi w depo w Thais: {}, {}, {}", spot.x, spot.y, spot.z)
	else
		logger.warn("[OTS loot] Nie udalo sie postawic Loot Sellera w depo w Thais.")
	end
	return true
end

place:register()
