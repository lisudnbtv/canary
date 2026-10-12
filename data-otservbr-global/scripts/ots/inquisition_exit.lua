-- OTS: teleport powrotny do swiatyni w Thais w sali z nagrodami Inkwizycji
-- (na koncu korytarza, na poludnie od miejsca, w ktore przenosi ostatni teleport questu).
local EXIT_POSITION = Position(32319, 32257, 9)
local MAGIC_FORCEFIELD = 1949
local THAIS_TOWN_ID = 8

local place = GlobalEvent("OtsInquisitionExit")

function place.onStartup()
	local tile = Tile(EXIT_POSITION)
	local town = Town(THAIS_TOWN_ID)
	if not tile or not town then
		logger.warn("[OTS inkwizycja] Nie udalo sie postawic teleportu powrotnego.")
		return true
	end
	local item = tile:getItemById(MAGIC_FORCEFIELD) or Game.createItem(MAGIC_FORCEFIELD, 1, EXIT_POSITION)
	if item and item.setDestination then
		item:setDestination(town:getTemplePosition())
		logger.info("[OTS inkwizycja] Teleport powrotny do Thais w sali nagrod: tak")
	else
		logger.warn("[OTS inkwizycja] Teleport powrotny: nie")
	end
	return true
end

place:register()
