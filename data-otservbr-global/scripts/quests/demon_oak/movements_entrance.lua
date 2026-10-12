-- OTS: uproszczony Demon Oak - wejscie sciezka nie wymaga taska na demony ani hallowed axe.
-- Cala logika wejscia jest w scripts/ots/demon_oak.lua (OtsDemonOakEnter).
local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if OtsDemonOakEnter then
		OtsDemonOakEnter(player)
	else
		player:teleportTo(DEMON_OAK_KICK_POSITION)
	end
	return true
end

entrance:type("stepin")
entrance:uid(9000)
entrance:register()
