-- OTS: sala z nagrodami In Service of Yalahar (32776-32779, 31203-31209, 7).
-- Na mapie stoja tylko trzy skrzynie (armor/mask/legs) - dostawiamy czwarta (footwraps)
-- i teleport powrotny do swiatyni w Thais, bo sala jest zamknieta.
OTS_YALAHAR_FOOTWRAPS_CHEST = Position(32776, 31207, 7)
local EXIT_POSITION = Position(32778, 31209, 7)
local CHEST_ID = 2472
local MAGIC_FORCEFIELD = 1949
local THAIS_TOWN_ID = 8

local place = GlobalEvent("OtsYalaharRewardRoom")

function place.onStartup()
	local chestTile = Tile(OTS_YALAHAR_FOOTWRAPS_CHEST)
	if chestTile then
		local chest = chestTile:getItemById(CHEST_ID) or Game.createItem(CHEST_ID, 1, OTS_YALAHAR_FOOTWRAPS_CHEST)
		if chest then
			chest:setActionId(IMMOVABLE_ACTION_ID)
		end
	end

	local exitTile = Tile(EXIT_POSITION)
	local town = Town(THAIS_TOWN_ID)
	if exitTile and town then
		local item = exitTile:getItemById(MAGIC_FORCEFIELD) or Game.createItem(MAGIC_FORCEFIELD, 1, EXIT_POSITION)
		if item and item.setDestination then
			item:setDestination(town:getTemplePosition())
		end
	end
	logger.info("[OTS yalahar] Sala nagrod: czwarta skrzynia i teleport powrotny gotowe")
	return true
end

place:register()
