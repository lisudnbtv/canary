-- OTS: zastepuje wbudowane !reward (wylaczone w configu, zajmowalo komende).
-- OTS: !reward - jednorazowa nagroda na start dla kazdej postaci: lasting exercise weapons
-- (po 14400 ladunkow) do trenowania na manekinie w depo. Bronie dla profesji + tarcza.
-- Trafiaja do skrzynki sklepu (Store inbox), zeby nie obciazac plecaka.
local KV_KEY = "ots-starter-reward"
local CHARGES = 14400
local SHIELD = 44067
local BY_VOCATION = {
	[1] = { 35290 }, -- sorcerer: wand
	[2] = { 35289 }, -- druid: rod
	[3] = { 35288 }, -- paladin: bow
	[4] = { 35285, 35286, 35287 }, -- knight: sword, axe, club
	[9] = { 50295 }, -- monk: wraps
}

local command = TalkAction("!reward")

function command.onSay(player, words, param)
	if player:kv():get(KV_KEY) then
		player:sendCancelMessage("Nagrode na start ta postac juz odebrala.")
		return true
	end
	local weapons = BY_VOCATION[player:getVocation():getBaseId()]
	if not weapons then
		player:sendCancelMessage("Najpierw wybierz profesje.")
		return true
	end
	local inbox = player:getStoreInbox()
	if not inbox then
		player:sendCancelMessage("Nie udalo sie otworzyc skrzynki sklepu.")
		return true
	end
	local ids = {}
	for _, id in ipairs(weapons) do
		ids[#ids + 1] = id
	end
	ids[#ids + 1] = SHIELD
	local given = 0
	for _, id in ipairs(ids) do
		local item = Game.createItem(id, 1)
		if item then
			item:setAttribute(ITEM_ATTRIBUTE_CHARGES, CHARGES)
			if inbox:addItemEx(item, INDEX_WHEREEVER, FLAG_NOLIMIT) == RETURNVALUE_NOERROR then
				given = given + 1
			end
		end
	end
	if given == 0 then
		player:sendCancelMessage("Nie udalo sie wydac nagrody - sprobuj ponownie.")
		return true
	end
	player:kv():set(KV_KEY, true)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Nagroda na start: %d x lasting exercise (po %d ladunkow) w skrzynce sklepu. Trenuj na manekinie w depo.", given, CHARGES))
	return true
end

command:groupType("normal")
command:register()
