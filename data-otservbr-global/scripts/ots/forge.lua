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

-- OTS: !polaczforge - zamienia wszystkie slivery z plecaka (takze z loot poucha) na exalted core,
-- tak jak kuznia: forgeCoreCost sliverow (domyslnie 50) = 1 core. Reszta sliverow zostaje.
local mergeForge = TalkAction("!polaczforge")

function mergeForge.onSay(player, words, param)
	local cost = configManager.getNumber(configKeys.FORGE_CORE_COST) or 50
	if not cost or cost <= 0 then
		cost = 50
	end
	local have = player:getItemCount(ITEM_FORGE_SLIVER)
	local make = math.floor(have / cost)
	if make == 0 then
		player:sendCancelMessage(string.format("Potrzebujesz %d sliverow na 1 exalted core (masz %d).", cost, have))
		return false
	end
	if not player:removeItem(ITEM_FORGE_SLIVER, make * cost) then
		player:sendCancelMessage("Nie udalo sie zabrac sliverow.")
		return false
	end
	player:addItem(ITEM_FORGE_CORE, make)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Polaczono %d sliverow w %d exalted core. Zostalo %d sliverow.", make * cost, make, have - make * cost))
	return false
end

mergeForge:groupType("normal")
mergeForge:register()
