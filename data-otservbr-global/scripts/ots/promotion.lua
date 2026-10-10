-- OTS: darmowa promocja z automatu.
-- Postac dostaje promocje (np. Royal Paladin) w chwili osiagniecia 20 poziomu,
-- a jesli ma go juz wczesniej, to przy logowaniu. Komenda !promotion robi to samo recznie.

local REQUIRED_LEVEL = 20

local function promote(player)
	if player:getLevel() < REQUIRED_LEVEL then
		return false, string.format("Promocja jest dostepna od %d poziomu.", REQUIRED_LEVEL)
	end

	local promotion = player:getVocation():getPromotion()
	if not promotion or player:isPromoted() then
		return false, "Masz juz promocje albo Twoja profesja jej nie ma."
	end

	player:setVocation(promotion)
	player:kv():set("promoted", true)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	return true, string.format("Gratulacje! Otrzymujesz promocje: %s.", player:getVocation():getName())
end

local advance = CreatureEvent("OtsAutoPromotion")

function advance.onAdvance(player, skill, oldLevel, newLevel)
	if skill == SKILL_LEVEL and newLevel >= REQUIRED_LEVEL then
		local ok, message = promote(player)
		if ok then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
		end
	end
	return true
end

advance:register()

local login = EventCallback("OtsAutoPromotionOnLogin")

function login.playerOnLoginComplete(player)
	player:registerEvent("OtsAutoPromotion")
	local ok, message = promote(player)
	if ok then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	end
end

login:register()

local command = TalkAction("!promotion")

function command.onSay(player, words, param)
	local _, message = promote(player)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	return true
end

command:groupType("normal")
command:register()
