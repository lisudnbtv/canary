-- OTS: Experience Stone (60124) - po uzyciu 1 godzina expa x500. Kolejne uzycie dodaje godzine.
-- Nie wypada z potworow i nie ma go w sklepie; postac Monk dostaje jeden raz przy logowaniu.
-- Mnoznik idzie przez OtsExpModifiers (data/events/scripts/player.lua), wiec dziala tez na exp z party bota.
local STONE_ID = 60124
local MULTIPLIER = 500
local DURATION = 60 * 60
local KV_KEY = "ots-exp-stone-until"
local GIFTS = { ["monk"] = 1 } -- postac -> ile kamieni dostaje (jeden raz na GIFT_KEY)
local GIFT_KEY = "ots-exp-stone-gift-2" -- zmiana klucza = nowy prezent

local function untilTime(player)
	return tonumber(player:kv():get(KV_KEY)) or 0
end

local function left(player)
	return math.max(0, untilTime(player) - os.time())
end

local function fmt(seconds)
	return string.format("%d h %02d min", math.floor(seconds / 3600), math.floor(seconds % 3600 / 60))
end

OtsExpModifiers = OtsExpModifiers or {}
OtsExpModifiers.expStone = function(player, target, exp)
	if exp > 0 and left(player) > 0 then
		exp = exp * MULTIPLIER
	end
	return exp
end

local stone = Action()

function stone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local start = math.max(os.time(), untilTime(player))
	player:kv():set(KV_KEY, start + DURATION)
	item:remove(1)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Experience Stone: exp x%d jeszcze przez %s.", MULTIPLIER, fmt(left(player))))
	return true
end

stone:id(STONE_ID)
stone:register()

local login = CreatureEvent("OtsExpStoneLogin")

function login.onLogin(player)
	local gift = GIFTS[player:getName():lower()]
	if gift and not player:kv():get(GIFT_KEY) then
		player:kv():set(GIFT_KEY, true)
		player:addItem(STONE_ID, gift)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Otrzymujesz Experience Stone - uzyj go, a przez godzine dostajesz exp x500.")
	end
	if left(player) > 0 then
		player:sendTextMessage(MESSAGE_LOGIN, string.format("Experience Stone aktywny: exp x%d jeszcze przez %s.", MULTIPLIER, fmt(left(player))))
	end
	return true
end

login:register()

-- komunikat, gdy dzialanie sie konczy (sprawdzane co minute)
local think = GlobalEvent("OtsExpStoneThink")
local warned = {}

function think.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local id = player:getId()
		local remaining = left(player)
		if remaining > 0 then
			warned[id] = true
		elseif warned[id] then
			warned[id] = nil
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Experience Stone przestal dzialac.")
		end
	end
	return true
end

think:interval(60 * 1000)
think:register()
