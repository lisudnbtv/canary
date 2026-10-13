-- OTS: komendy wygody.
--   !sell - sprzedaje caly loot z loot poucha, zloto trafia na konto w banku
--   !bp   - plecak z zapasami (runy, potiony, narzedzia); raz na minute

-- Ceny skupu: te same, ktore ma Loot Seller (LootShopConfigTable z data/scripts/lib/shops.lua).
local prices = nil
-- greater gemy (Gem Atelier) nigdy nie ida do !sell ani pod miotelke
local NEVER_SELL = { [44604] = true, [44607] = true, [44610] = true, [44613] = true, [49373] = true }
local function loadPrices()
	prices = {}
	for _, category in pairs(LootShopConfigTable or {}) do
		for _, entry in ipairs(category) do
			if entry.clientId and entry.sell and entry.sell > 0 and not NEVER_SELL[entry.clientId] then
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
	-- odswiez otwarte okno poucha: bez tego klient pokazuje stare, powielone pozycje
	if player.sendUpdateContainer then
		player:sendUpdateContainer(pouch)
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

-- Clean Loot Pouch (miotla ze sklepu, wielokrotnego uzytku): usuwa z loot poucha wszystko,
-- czego nie skupuje Loot Seller. Zostaja: zloto i monety, pojemniki, kamienie ulepszen,
-- worki z nagrodami, przedmioty ulepszone (+1 i wyzej) i sama miotla.
local CLEANER_ID = 3454 -- broom
local KEEP = {
	[ITEM_GOLD_COIN] = true,
	[ITEM_PLATINUM_COIN] = true,
	[ITEM_CRYSTAL_COIN] = true,
	[20139] = true, -- kamien ulepszen
	[20138] = true, -- blessed upgrade stone
	[9212] = true, -- Boss Loot Collector
	[34109] = true, -- bag you desire
	[39546] = true, -- primal bag
	[43895] = true, -- bag you covet
	[CLEANER_ID] = true,
	-- kuznia i Gem Atelier: wszystkie gemy (tez Monka, ktorych nie da sie sprzedac), fragmenty,
	-- exalted core, slivery i kruszarki - miotelka ich nie usuwa
	[44602] = true, [44603] = true, [44604] = true, [44605] = true, [44606] = true, [44607] = true,
	[44608] = true, [44609] = true, [44610] = true, [44611] = true, [44612] = true, [44613] = true,
	[49371] = true, [49372] = true, [49373] = true,
	[46625] = true, [46626] = true, [37109] = true, [37110] = true, [46627] = true, [46628] = true,
}

local function junkIn(pouch)
	if not prices then
		loadPrices()
	end
	local junk = {}
	for _, item in ipairs(pouch:getItems(true)) do
		local id = item:getId()
		if not item:isContainer() and not KEEP[id] and not prices[id] and not item:getCustomAttribute("ots-upgrade") then
			junk[#junk + 1] = item
		end
	end
	return junk
end

local cleaner = Action()

function cleaner.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local pouch = player:getItemById(ITEM_GOLD_POUCH, true)
	if not pouch or not pouch:isContainer() then
		player:sendCancelMessage("Nie masz loot poucha.")
		return true
	end
	local count = 0
	for _, entry in ipairs(junkIn(pouch)) do
		count = count + entry:getCount()
	end
	if count == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "W loot pouchu nie ma nic do wyrzucenia.")
		return true
	end
	local playerId = player:getId()
	local window = ModalWindow({ title = "Clean Loot Pouch", message = string.format("Usunac na zawsze %d szt. przedmiotow, ktorych nie da sie sprzedac?\nTo, co skupuje Loot Seller, zostaje (sprzedasz przez !sell).", count) })
	window:addButton("Usun", function()
		local target = Player(playerId)
		local bag = target and target:getItemById(ITEM_GOLD_POUCH, true)
		if not bag then
			return
		end
		local removed = 0
		local list = junkIn(bag)
		for index = #list, 1, -1 do
			removed = removed + list[index]:getCount()
			list[index]:remove()
		end
		if target.sendUpdateContainer then
			target:sendUpdateContainer(bag)
		end
		target:getPosition():sendMagicEffect(CONST_ME_POFF)
		target:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Usunieto z loot poucha %d szt. zbednych przedmiotow.", removed))
	end)
	window:addButton("Anuluj", function() end)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
	return true
end

cleaner:id(CLEANER_ID)
cleaner:register()
