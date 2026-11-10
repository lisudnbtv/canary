-- OTS: !i - okno do wpisania przedmiotu (id albo nazwa) i ilosci; przedmiot trafia do plecaka.
-- Tylko dla postaci z konta "lisu" (login @lisu) - bez zadnych uprawnien GOD na koncie czy postaci.
-- W oknie mozna wpisac kilka linijek naraz, kazda: "id, ilosc" albo "nazwa, ilosc" (ilosc mozna pominac = 1).
local INPUT_ITEM = 2814 -- pergamin, ktory klient pozwala zapisac
local MAX_COUNT = 10000

local awaiting = {}

local ACCOUNT_NAME = "lisu"
local accountId -- id konta "lisu" z bazy, pobierane raz

local function allowed(player)
	if not accountId then
		local result = db.storeQuery("SELECT `id` FROM `accounts` WHERE `name` = " .. db.escapeString(ACCOUNT_NAME))
		if result then
			accountId = Result.getNumber(result, "id")
			Result.free(result)
		end
	end
	return accountId ~= nil and player:getAccountId() == accountId
end

local function createOne(player, line)
	local what, amount = line:match("^%s*(.-)%s*,%s*(%d+)%s*$")
	if not what then
		what, amount = line:match("^%s*(.-)%s*$"), "1"
	end
	if what == "" then
		return nil
	end
	local itemType = ItemType(tonumber(what) or what)
	if not itemType or itemType:getId() < 100 then
		return string.format("%s - nie ma takiego przedmiotu", what)
	end
	local count = math.max(1, math.min(MAX_COUNT, tonumber(amount) or 1))
	local name = itemType:getName()
	local given = 0
	if itemType:isStackable() then
		local stack = math.max(1, itemType:getStackSize())
		while given < count do
			local part = math.min(stack, count - given)
			if not player:addItem(itemType:getId(), part) then
				break
			end
			given = given + part
		end
	else
		for _ = 1, math.min(count, 100) do
			if not player:addItem(itemType:getId(), 1) then
				break
			end
			given = given + 1
		end
	end
	logger.info("[OTS !i] {}: {} x{} (id {}) -> dodano {}", player:getName(), name, count, itemType:getId(), given)
	if given == 0 then
		return string.format("%s (id %d) - brak miejsca w plecaku", name, itemType:getId())
	end
	return string.format("%dx %s (id %d)%s", given, name, itemType:getId(), given < count and " - reszta sie nie zmiescila" or "")
end

local input = CreatureEvent("OtsGodItemInput")

function input.onTextEdit(player, item, text)
	if not awaiting[player:getId()] then
		return true
	end
	awaiting[player:getId()] = nil
	local results = {}
	for line in ((text or "") .. "\n"):gmatch("([^\n]*)\n") do
		local result = createOne(player, line)
		if result then
			results[#results + 1] = result
		end
	end
	if #results == 0 then
		player:sendCancelMessage("Nic nie wpisano.")
	else
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "!i: " .. table.concat(results, "; "))
	end
	return false
end

input:register()

local command = TalkAction("!i")

function command.onSay(player, words, param)
	if not allowed(player) then
		return false
	end
	-- "!i 60124, 5" dziala tez od razu, bez okna
	if param and param ~= "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "!i: " .. (createOne(player, param) or "nic nie wpisano"))
		return true
	end
	awaiting[player:getId()] = true
	player:registerEvent("OtsGodItemInput")
	player:showTextDialog(INPUT_ITEM, "", true, 400)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "!i: wpisz w okno id albo nazwe przedmiotu i ilosc, np. 60124, 5 (kilka przedmiotow - kazdy w nowej linijce) i kliknij OK.")
	return true
end

command:separator(" ")
command:groupType("normal")
command:register()
