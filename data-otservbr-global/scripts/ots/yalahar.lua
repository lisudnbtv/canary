-- OTS: wejscie do finalowej walki In Service of Yalahar prosto z menu teleportow.
-- Pomija dziesiec misji. Po pokonaniu Azerusa (zanim odbierzesz nagrode) !tp zabiera prosto do skrzyn.

local entrance = Position(32783, 31174, 10)

local rewardRoom = Position(32780, 31168, 14)

function OtsYalaharStart(player)
	if player:kv():get("ots-yalahar-azerus") and not player:kv():get("ots-yalahar-reward") then
		local from = player:getPosition()
		player:teleportTo(rewardRoom)
		from:sendMagicEffect(CONST_ME_POFF)
		rewardRoom:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "In Service of Yalahar: Azerus juz pokonany - wybierz jedna skrzynie z nagroda.")
		return
	end

	if Game.getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.LastFight) == 1 then
		player:sendCancelMessage("Walka z Azerusem jeszcze trwa albo sala sie resetuje. Sprobuj za kilka minut.")
		return
	end

	local from = player:getPosition()
	player:teleportTo(entrance)
	from:sendMagicEffect(CONST_ME_POFF)
	entrance:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "In Service of Yalahar: uzyj kuli na srodku sali, zeby zaczac walke. Przyjda cztery fale potworow i Azerus. Po jego smierci na poludniu sali pojawi sie teleport do skrzyn (10 minut). Azerus nie ucieka - masz czas, zeby go dobic.")
end
