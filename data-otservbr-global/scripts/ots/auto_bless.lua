-- OTS: pelne blessy zawsze. Przy kazdym logowaniu (czyli takze po smierci) postac dostaje
-- wszystkie brakujace blogoslawienstwa, w tym Twist of Fate. Dodatkowo sprawdzane co 3 s.
local BLESSING_COUNT = 8

local function fill(player)
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
end

local login = CreatureEvent("OtsAutoBless")

function login.onLogin(player)
	fill(player)
	return true
end

login:register()

-- Dodatkowo co kilka sekund: gdyby logowanie po smierci ominelo uzupelnienie
-- (na przyklad przez automatyczne ponowne polaczenie), blessy wracaja i tak.
local tick = GlobalEvent("OtsAutoBlessTick")

function tick.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		fill(player)
	end
	return true
end

tick:interval(3000)
tick:register()
