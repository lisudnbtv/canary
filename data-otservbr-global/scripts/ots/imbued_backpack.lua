-- OTS: Imbued Backpack (sklep, 3000 TC): 100 slotow i stale bonusy jak z imbu, dopoki plecak
-- jest zalozony w slocie plecaka. Silnik nie liczy imbuementow z plecaka, wiec bonusy daje ten
-- skrypt (warunek z wlasnym SUBID, zakladany i zdejmowany co 2 s).
local BACKPACK_ID = 3253 -- backpack of holding (items.xml: imbued backpack, 100 slotow)
local SUBID = 64991
local LIFE_LEECH = 500 -- setne czesci procenta: 500 = 5%
local MANA_LEECH = 300 -- 3%
local CRIT_CHANCE = 500 -- 5%
local CRIT_DAMAGE = 2500 -- +25%
local SPEED_PERCENT = 10

local active = {} -- id gracza -> bonus nalozony

local function wearing(player)
	local item = player:getSlotItem(CONST_SLOT_BACKPACK)
	return item and item:getId() == BACKPACK_ID
end

local function apply(player)
	local skills = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	skills:setParameter(CONDITION_PARAM_SUBID, SUBID)
	skills:setParameter(CONDITION_PARAM_TICKS, -1)
	skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
	skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, LIFE_LEECH)
	skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
	skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, MANA_LEECH)
	skills:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, CRIT_CHANCE)
	skills:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, CRIT_DAMAGE)
	player:addCondition(skills)

	local haste = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
	haste:setParameter(CONDITION_PARAM_SUBID, SUBID)
	haste:setParameter(CONDITION_PARAM_TICKS, -1)
	haste:setParameter(CONDITION_PARAM_SPEED, math.floor(player:getBaseSpeed() * SPEED_PERCENT / 100))
	player:addCondition(haste)
end

local function clear(player)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, SUBID)
end

local tick = GlobalEvent("OtsImbuedBackpackTick")

function tick.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local id = player:getId()
		local on = wearing(player)
		if on and not active[id] then
			apply(player)
			active[id] = true
			player:sendTextMessage(MESSAGE_STATUS, "Imbued Backpack: bonusy wlaczone (leech, critical, szybkosc).")
		elseif not on and active[id] then
			clear(player)
			active[id] = nil
		end
	end
	for id in pairs(active) do
		if not Player(id) then
			active[id] = nil
		end
	end
	return true
end

tick:interval(2000)
tick:register()

local login = CreatureEvent("OtsImbuedBackpackLogin")

function login.onLogin(player)
	active[player:getId()] = nil
	clear(player)
	return true
end

login:register()
