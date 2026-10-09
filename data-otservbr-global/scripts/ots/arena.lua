-- OTS: wejscie na Barbarian Arena prosto z menu teleportow.
-- Zastepuje rozmowe z Halvarem i oplate: ustawia te same dane co on
-- i wpuszcza gracza do pierwszej z dziesieciu walk. Dalej dziala oryginalny skrypt areny.

function OtsArenaStart(player)
	local storages = Storage.Quest.U8_0.BarbarianArena

	local arenaId = player:getStorageValue(storages.Arena)
	if arenaId < 1 then
		arenaId = 1
		player:setStorageValue(storages.Arena, arenaId)
	end

	local arena = ARENA[arenaId]
	if not arena then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Barbarian Arena: wszystkie trzy poziomy sa juz ukonczone.")
		return
	end

	local pitId = 1
	if SvargrondArena.getPitOccupant(pitId, player) then
		player:sendCancelMessage("Ktos jest juz w pierwszej walce areny.")
		return
	end

	player:setStorageValue(storages.PitDoor, pitId)
	if player:getStorageValue(arena.questLog) ~= 1 then
		player:setStorageValue(arena.questLog, 1)
	end

	SvargrondArena.resetPit(pitId)
	SvargrondArena.scheduleKickPlayer(player.uid, pitId)
	Game.createMonster(arena.creatures[pitId], PITS[pitId].summon, false, true)

	player:teleportTo(PITS[pitId].center)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:say("FIGHT!", TALKTYPE_MONSTER_SAY)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Barbarian Arena, poziom %d/3 (%s): 10 walk pod rzad. Po kazdej wygranej wejdz w teleport do nastepnej. Po dziesiatej trafisz do pokoju nagrod.", arenaId, arena.name))
end
