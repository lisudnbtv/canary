-- OTS: komendy wygody.
--   !sell - sprzedaje caly loot z loot poucha, zloto trafia na konto w banku
--   !bp   - plecak z zapasami (runy, potiony, narzedzia); raz na minute

-- Ceny skupu: te same, ktore ma Loot Seller (LootShopConfigTable z data/scripts/lib/shops.lua).
local prices = nil
local function loadPrices()
	prices = {}
	for _, category in pairs(LootShopConfigTable or {}) do
		for _, entry in ipairs(category) do
			if entry.clientId and entry.sell and entry.sell > 0 then
				prices[entry.clientId] = entry.sell
			end
		end
	end
end

local sell = TalkAction("!sell")

function sell.onSay(player, words, param)
	if not prices then
		loadPrices()
	end
	local pouch = player:getItemById(ITEM_GOLD_POUCH, true)
	if not pouch or not pouch:isContainer() then
		player:sendCancelMessage("Nie masz loot poucha.")
		return true
	end
	local total, sold = 0, 0
	local items = pouch:getItems(true)
	for index = #items, 1, -1 do
		local item = items[index]
		local price = prices[item:getId()]
		if price and not item:isContainer() then
			local count = item:getCount()
			total = total + price * count
			sold = sold + count
			item:remove()
		end
	end
	if sold == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "W loot pouchu nie ma nic na sprzedaz.")
		return true
	end
	player:setBankBalance(player:getBankBalance() + total)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Sprzedano %d przedmiotow za %d gp. Zloto jest na koncie w banku.", sold, total))
	return true
end

sell:groupType("normal")
sell:register()

local BP_COOLDOWN_SECONDS = 60
local BACKPACK_ID = 2854
-- sudden death, great fireball, avalanche, thunderstorm, stone shower, ultimate healing, magic wall, paralyse,
-- supreme health, ultimate mana, ultimate spirit, rope, shovel, machete, pick
local bpItems = { 3155, 3191, 3161, 3202, 3175, 3160, 3180, 3165, 23375, 23373, 23374, 3003, 3457, 3308, 3456 }
local bpLast = {} -- guid -> czas ostatniego uzycia

local bp = TalkAction("!bp")

function bp.onSay(player, words, param)
	local guid, now = player:getGuid(), os.time()
	if bpLast[guid] and now - bpLast[guid] < BP_COOLDOWN_SECONDS then
		player:sendCancelMessage(string.format("Kolejny plecak za %d s.", BP_COOLDOWN_SECONDS - (now - bpLast[guid])))
		return true
	end
	local backpack = player:addItem(BACKPACK_ID, 1)
	if not backpack then
		player:sendCancelMessage("Brak miejsca albo udzwigu na plecak.")
		return true
	end
	for _, id in ipairs(bpItems) do
		backpack:addItem(id, 1)
	end
	bpLast[guid] = now
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Plecak z zapasami dodany (runy, potiony i narzedzia sa nieskonczone).")
	return true
end

bp:groupType("normal")
bp:register()
