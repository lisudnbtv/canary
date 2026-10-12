-- OTS: po smierci Azerusa teleport do sali z nagrodami pojawia sie w stalym, widocznym
-- miejscu (nie pod zwlokami), stoi 10 minut, a postacie z sali dostaja wpis o wygranej -
-- dzieki niemu !tp > In Service of Yalahar zabiera prosto do skrzyn, gdyby teleport zniknal.
OtsYalaharFight = OtsYalaharFight or { id = 0, active = false }

local CENTER = Position(32783, 31166, 10)
local RANGE = 10
local PORTAL = Position(32783, 31171, 10)
local REWARD_ROOM = Position(32780, 31168, 14)
local PORTAL_TIME = 10 * 60 * 1000
OTS_YALAHAR_KILL_KEY = "ots-yalahar-azerus"
OtsYalaharPortal = OtsYalaharPortal or { generation = 0 }

local function removeTeleport(generation)
	if OtsYalaharPortal.generation ~= generation then
		return
	end
	local tile = Tile(PORTAL)
	local teleportItem = tile and tile:getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		PORTAL:sendMagicEffect(CONST_ME_POFF)
	end
end

local azerus = CreatureEvent("AzerusDeath")
function azerus.onDeath(creature)
	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

	local players = Game.getSpectators(CENTER, false, true, RANGE, RANGE, RANGE, RANGE)
	for i = 1, #players do
		players[i]:kv():set(OTS_YALAHAR_KILL_KEY, true)
		players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Azerus pokonany! Teleport do sali z nagrodami stoi na poludniu sali (10 minut).")
	end

	local tile = Tile(PORTAL)
	local teleportItem = tile and tile:getItemById(1949)
	if not teleportItem then
		teleportItem = Game.createItem(1949, 1, PORTAL)
	end
	if teleportItem and teleportItem:isTeleport() then
		teleportItem:setDestination(REWARD_ROOM)
	end
	PORTAL:sendMagicEffect(CONST_ME_TELEPORT)
	OtsYalaharPortal.generation = OtsYalaharPortal.generation + 1
	addEvent(removeTeleport, PORTAL_TIME, OtsYalaharPortal.generation)

	-- sprzatanie sali i reset kuli dopiero po wyjsciu Azerusa z listy potworow
	addEvent(function()
		if OtsYalaharClearArena then
			OtsYalaharClearArena()
		end
		if OtsYalaharEndFight then
			OtsYalaharEndFight()
		end
	end, 100)
	return true
end

azerus:register()
