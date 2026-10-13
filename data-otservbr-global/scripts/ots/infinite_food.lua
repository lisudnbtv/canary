-- OTS: Infinite Food - tort ze sklepu (party cake). Uzycie daje na 10 minut regeneracje
-- 250 HP i 250 many co sekunde i do pelna napelnia zwykly czas jedzenia postaci (20 minut).
-- Tort nie znika, mozna go uzyc ponownie w dowolnej chwili.
local ITEM_ID = 6279 -- party cake
local DURATION_MS = 10 * 60 * 1000
local GAIN = 250
local SUBID = 64990 -- wlasny slot, zeby nie mieszac sie ze zwyklym jedzeniem
local MAX_FOOD_SECONDS = 1200 -- limit zwyklego jedzenia (jak w foods.lua)

local regeneration = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
regeneration:setParameter(CONDITION_PARAM_SUBID, SUBID)
regeneration:setParameter(CONDITION_PARAM_TICKS, DURATION_MS)
regeneration:setParameter(CONDITION_PARAM_HEALTHGAIN, GAIN)
regeneration:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
regeneration:setParameter(CONDITION_PARAM_MANAGAIN, GAIN)
regeneration:setParameter(CONDITION_PARAM_MANATICKS, 1000)

local food = Action()

function food.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, SUBID)
	player:addCondition(regeneration)
	local current = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	local missing = MAX_FOOD_SECONDS - (current and math.floor(current:getTicks() / 1000) or 0)
	if missing > 0 then
		player:feed(missing)
	end
	player:say("Mmmm.", TALKTYPE_MONSTER_SAY)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Infinite Food: jestes najedzony (20 min), a przez 10 minut +250 HP i +250 many co sekunde.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end

food:id(ITEM_ID)
food:register()
