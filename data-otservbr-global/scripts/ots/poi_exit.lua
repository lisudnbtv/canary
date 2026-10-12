-- OTS: teleport powrotny do swiatyni w Thais w pokoju nagrod Pits of Inferno
-- (wolne pole na srodku pokoju, ponizej skrzyn).
local EXIT_POSITION = Position(32815, 32235, 11)
local MAGIC_FORCEFIELD = 1949
local THAIS_TOWN_ID = 8

local place = GlobalEvent("OtsPoiExit")

function place.onStartup()
	local tile = Tile(EXIT_POSITION)
	local town = Town(THAIS_TOWN_ID)
	if not tile or not town then
		logger.warn("[OTS poi] Nie udalo sie postawic teleportu powrotnego.")
		return true
	end
	local item = tile:getItemById(MAGIC_FORCEFIELD) or Game.createItem(MAGIC_FORCEFIELD, 1, EXIT_POSITION)
	if item and item.setDestination then
		item:setDestination(town:getTemplePosition())
		logger.info("[OTS poi] Teleport powrotny do Thais w pokoju nagrod: tak")
	else
		logger.warn("[OTS poi] Teleport powrotny: nie")
	end
	return true
end

place:register()
