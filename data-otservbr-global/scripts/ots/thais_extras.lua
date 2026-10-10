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
	{ id = IMBUING_SHRINE, pos = Position(32358, 32239, 7) },
	{ id = ITEM_REWARD_CHEST, pos = Position(32378, 32239, 7) },
}

-- Przejscie na wprost miedzy depo a swiatynia przez drewniany dom: sciany znikaja, zostaje podloga.
local WOODEN_FLOOR = 408
local passage = {
	Position(32355, 32229, 7),
	Position(32356, 32229, 7),
	Position(32361, 32229, 7),
}

local function openPassage()
	local opened = 0
	for _, pos in ipairs(passage) do
		local tile = Tile(pos)
		if tile then
			local items = tile:getItems() or {}
			for index = #items, 1, -1 do
				items[index]:remove()
			end
			local ground = tile:getGround()
			if ground and ground:getId() ~= WOODEN_FLOOR then
				ground:transform(WOODEN_FLOOR)
			elseif not ground then
				Game.createItem(WOODEN_FLOOR, 1, pos)
			end
			opened = opened + 1
		end
	end
	return opened
end

-- Ruprecht (wymiana christmas tokenow) dodatkowo na pierwszym pietrze depo w Thais.
local RUPRECHT_POSITION = Position(32350, 32222, 6)

-- Teleporty wyjsciowe z questow, ktore maja prowadzic prosto do swiatyni w Thais.
local templeExits = {
	Position(32219, 31913, 15), -- Queen of the Banshees, miedzy skrzyniami z nagroda
}

local function redirectExits()
	local town = Town("Thais")
	local temple = town and town:getTemplePosition()
	local changed = 0
	if not temple then
		return changed
	end
	for _, pos in ipairs(templeExits) do
		local tile = Tile(pos)
		local item = tile and tile:getItemById(MAGIC_FORCEFIELD)
		-- przedmiot z mapy bedacy teleportem ma od razu metody teleportu
		if item and item.setDestination then
			item:setDestination(temple)
			changed = changed + 1
		end
	end
	return changed
end

local function hasItemlocal function hasItem(pos, id)
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
	logger.info("[OTS Thais] Przejscie depo-swiatynia, otwarte pola: {}/{}", openPassage(), #passage)
	local ruprecht = Game.createNpc("Ruprecht", RUPRECHT_POSITION, false, true)
	if ruprecht then
		ruprecht:setMasterPos(RUPRECHT_POSITION)
	end
	logger.info("[OTS Thais] Ruprecht w depo: {}, teleporty questow do swiatyni: {}/{}", ruprecht and "tak" or "nie", redirectExits(), #templeExits)
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
