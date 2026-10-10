-- OTS: autoloot wlaczony domyslnie (takze bossy) dla postaci, ktore same go nie ustawily.
-- Gracz zmienia komenda !autoloot all/on/off; jego wybor jest zapamietywany.
local login = CreatureEvent("OtsAutoLootDefault")

function login.onLogin(player)
	if player:kv():scoped("features"):get(Features.AutoLoot) == nil then
		player:setFeature(Features.AutoLoot, 2)
	end
	return true
end

login:register()
