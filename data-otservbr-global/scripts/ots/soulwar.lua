-- OTS: wejscie do Soul War prosto z menu teleportow.
-- Zastepuje rozmowe z NPC (Flickering Soul): nadaje dostep do teleportow w hubie.
-- Reszta dziala jak w oryginale: piec terenow z bossami, potem Goshnar's Megalomania.

local hub = Position(33621, 31427, 10)

function OtsSoulWarStart(player)
	player:soulWarQuestKV():set("teleport-access", true)

	local from = player:getPosition()
	player:teleportTo(hub)
	from:sendMagicEffect(CONST_ME_POFF)
	hub:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Soul War: piec teleportow prowadzi na tereny z bossami Goshnara (wymagany poziom 250). Po pokonaniu calej piatki otwiera sie przejscie do Megalomanii, a po niej teleport do skrzyni z nagroda dla Twojej profesji.")
end
