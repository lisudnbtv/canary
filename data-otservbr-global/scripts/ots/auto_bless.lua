-- OTS: pelne blessy zawsze. Przy kazdym logowaniu (czyli takze po smierci) postac dostaje
-- wszystkie brakujace blogoslawienstwa, w tym Twist of Fate.
local BLESSING_COUNT = 8

local login = CreatureEvent("OtsAutoBless")

function login.onLogin(player)
	local added = 0
	for id = 1, BLESSING_COUNT do
		if not player:hasBlessing(id) then
			player:addBlessing(id, 1)
			added = added + 1
		end
	end
	if added > 0 then
		player:sendTextMessage(MESSAGE_STATUS, "Blessy uzupelnione: masz komplet.")
	end
	return true
end

login:register()
