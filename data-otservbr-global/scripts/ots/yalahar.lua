-- OTS: wejscie do finalowej walki In Service of Yalahar prosto z menu teleportow.
-- Pomija dziesiec misji; walka z Azerusem i teleport do nagrod dzialaja jak w oryginale.

local entrance = Position(32783, 31174, 10)

function OtsYalaharStart(player)
	if Game.getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.LastFight) == 1 then
		player:sendCancelMessage("Walka z Azerusem jeszcze trwa albo sala sie resetuje. Sprobuj za kilka minut.")
		return
	end

	local from = player:getPosition()
	player:teleportTo(entrance)
	from:sendMagicEffect(CONST_ME_POFF)
	entrance:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "In Service of Yalahar: uzyj kuli na srodku sali, zeby zaczac walke. Przyjda cztery fale potworow i Azerus. Po jego smierci pojawi sie teleport do skrzyn (znika po 2 minutach).")
end
