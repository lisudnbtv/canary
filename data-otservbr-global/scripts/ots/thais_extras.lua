-- OTS: wygody w Thais - szybkie przejscie swiatynia <-> depo, maszyna do imbu i skrzynia nagrod z bossow.
-- Przedmioty sa stawiane przy starcie serwera (mapa nie jest zmieniana).
local SHORTCUT_ACTION_ID = 64996
local IMBUING_SHRINE = 25061
local MAGIC_FORCEFIELD = 1949

local shortcuts = {
	{ from = Position(32379, 32243, 7), to = Position(32345, 32221, 7), label = "Depo" },
	{ from = Position(32347, 32218, 7), to = Position(32378, 32241, 7), label = "Swiatynia" },
}

local objects = {
	{ id = IMBUING_SHRINE, pos = Position(32380, 32239, 7) },
	{ id = ITEM_REWARD_CHEST, pos = Position(32380, 32240, 7) },
	{ id = IMBUING_SHRINE, pos = Position(32344, 32218, 7) },
	{ id = ITEM_REWARD_CHEST, pos = Position(32345, 32218, 7) },
}

local function hasItem(pos, id)
	local tile = Tile(pos)
	return tile and tile:getItemById(id) ~= nil
end

local place = GlobalEvent("OtsThaisExtras")

function place.onStartup()
	local placed = 0
	for _, object in ipairs(objects) do
		if hasItem(object.pos, object.id) or Game.createItem(object.id, 1, object.pos) then
			placed = placed + 1
		end
	end
	for _, shortcut in ipairs(shortcuts) do
		local item = Tile(shortcut.from) and (Tile(shortcut.from):getItemById(MAGIC_FORCEFIELD) or Game.createItem(MAGIC_FORCEFIELD, 1, shortcut.from))
		if item then
			item:setActionId(SHORTCUT_ACTION_ID)
			item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Szybkie przejscie: " .. shortcut.label .. ".")
			placed = placed + 1
		end
	end
	logger.info("[OTS Thais] Imbu, skrzynie nagrod i przejscia swiatynia-depo: {}/{}", placed, #objects + #shortcuts)
	return true
end

place:register()

local step = MoveEvent()

function step.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	for _, shortcut in ipairs(shortcuts) do
		if shortcut.from == position then
			player:teleportTo(shortcut.to)
			position:sendMagicEffect(CONST_ME_TELEPORT)
			shortcut.to:sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
	return true
end

step:aid(SHORTCUT_ACTION_ID)
step:register()
