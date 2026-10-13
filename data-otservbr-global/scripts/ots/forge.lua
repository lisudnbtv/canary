-- OTS: komenda !kuznia (albo !forge) otwiera okno Kuzni Wzniesienia w strefie PZ,
-- bez chodzenia do kowadla w hubie (stoi na polnoc od depozytu).
local talk = TalkAction("!kuznia", "!forge")

function talk.onSay(player, words, param)
	local tile = Tile(player:getPosition())
	if not tile or not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage("Kuznie mozna otworzyc tylko w strefie PZ (np. w hubie albo w depo).")
		return false
	end
	player:openForge()
	return false
end

talk:groupType("normal")
talk:register()
