-- OTS: kanal "Taski" - tylko komunikaty serwera o postepie taskow, pisac sie tu nie da.
function onSpeak(player, type, message)
	player:sendCancelMessage("Na kanale Taski nie da sie pisac.")
	return false
end
