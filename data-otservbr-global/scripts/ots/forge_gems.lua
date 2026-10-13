-- OTS: gemy do Gem Atelier wypadaja z potworow "kuzni" (influenced, z wykrzyknikiem).
-- Im wiekszy stos (1-5), tym wieksza szansa i lepszy gem; z fiendish (czerwonych, maksymalnych)
-- zawsze wypada greater gem. Gem jest dla profesji gracza, ktory dostaje loot.
local GEMS = { -- lesser, zwykly, greater
	[VOCATION.BASE_ID.KNIGHT] = { 44602, 44603, 44604 },
	[VOCATION.BASE_ID.PALADIN] = { 44605, 44606, 44607 },
	[VOCATION.BASE_ID.SORCERER] = { 44608, 44609, 44610 },
	[VOCATION.BASE_ID.DRUID] = { 44611, 44612, 44613 },
	[VOCATION.BASE_ID.MONK] = { 49371, 49372, 49373 },
}
local FIENDISH_STACK = 15

-- [stos] = { szansa %, { waga lesser, waga zwykly, waga greater } }
local TABLE = {
	[1] = { 5, { 100, 0, 0 } },
	[2] = { 6, { 90, 10, 0 } },
	[3] = { 8, { 70, 30, 0 } },
	[4] = { 10, { 50, 45, 5 } },
	[5] = { 15, { 0, 60, 40 } },
}

local function pick(weights)
	local roll = math.random(1, weights[1] + weights[2] + weights[3])
	for quality = 1, 3 do
		roll = roll - weights[quality]
		if roll <= 0 then
			return quality
		end
	end
	return 1
end

local callback = EventCallback("OtsForgeGemsDropLoot")

function callback.monsterOnDropLoot(monster, corpse)
	local stack = monster:getForgeStack()
	if not stack or stack <= 0 then
		return
	end
	local player = Player(corpse:getCorpseOwner())
	if not player or not player:canReceiveLoot() then
		return
	end
	local gems = GEMS[player:getVocation():getBaseId()]
	if not gems then
		return
	end

	local quality
	if stack >= FIENDISH_STACK then
		quality = 3
	else
		local entry = TABLE[math.min(stack, 5)]
		if math.random(1, 100) > entry[1] then
			return
		end
		quality = pick(entry[2])
	end

	local gemId = gems[quality]
	if not corpse:addItem(gemId, 1) then
		player:addItem(gemId, 1)
	end
	local existing = corpse:getAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX) or ""
	local name = ItemType(gemId):getName()
	corpse:setAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX, existing .. (string.len(existing) > 0 and ", " or "") .. "gem: " .. name)
	if quality == 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Z potwora kuzni wypadl " .. name .. "!")
	end
end

callback:register()
