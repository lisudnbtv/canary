-- OTS: przedmioty ze sklepu ze stalymi bonusami "pelnego imbu", ktore dzialaja, dopoki przedmiot
-- jest zalozony we wlasciwym slocie. Silnik/klient nie pozwala tu na zwykle imbu (plecak,
-- amulet, pierscien, slot strzal), wiec bonusy daje ten skrypt: kazdy przedmiot ma wlasny
-- warunek (SUBID), zakladany i zdejmowany co 2 s.
local ITEMS = {
	{
		name = "Imbued Backpack",
		id = 3253,
		slot = CONST_SLOT_BACKPACK,
		subId = 64991,
		lifeLeech = 500, -- setne czesci procenta: 500 = 5%
		manaLeech = 300,
		critChance = 500,
		critDamage = 2500,
		speedPercent = 10,
	},
	{
		name = "Amulet of Resistance",
		id = 22746,
		slot = CONST_SLOT_NECKLACE,
		subId = 64992,
		lifeLeech = 500,
		manaLeech = 300,
		critChance = 500,
		critDamage = 2500,
	},
	{
		name = "Ring of Resistance",
		id = 34080,
		slot = CONST_SLOT_RING,
		subId = 64993,
		skills = 3, -- wszystkie skille walki i shielding
		magic = 3,
	},
	{
		name = "Imbued Crystal Lamp",
		id = 16095,
		slot = CONST_SLOT_AMMO,
		subId = 64994,
		shielding = 10,
		speedPercent = 10,
		capacityPercent = 110, -- 110 = +10% udzwigu
	},
}

local active = {} -- "idGracza:subId" -> bonus nalozony

local function wearing(player, config)
	local item = player:getSlotItem(config.slot)
	return item and item:getId() == config.id
end

local function apply(player, config)
	local skills = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	skills:setParameter(CONDITION_PARAM_SUBID, config.subId)
	skills:setParameter(CONDITION_PARAM_TICKS, -1)
	if config.lifeLeech then
		skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
		skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, config.lifeLeech)
	end
	if config.manaLeech then
		skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
		skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, config.manaLeech)
	end
	if config.critChance then
		skills:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, config.critChance)
		skills:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, config.critDamage)
	end
	if config.skills then
		skills:setParameter(CONDITION_PARAM_SKILL_MELEE, config.skills)
		skills:setParameter(CONDITION_PARAM_SKILL_FIST, config.skills)
		skills:setParameter(CONDITION_PARAM_SKILL_DISTANCE, config.skills)
		skills:setParameter(CONDITION_PARAM_SKILL_SHIELD, config.skills)
	end
	if config.shielding then
		skills:setParameter(CONDITION_PARAM_SKILL_SHIELD, config.shielding)
	end
	if config.magic then
		skills:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, config.magic)
	end
	if config.capacityPercent then
		skills:setParameter(CONDITION_PARAM_STAT_CAPACITYPERCENT, config.capacityPercent)
	end
	player:addCondition(skills)

	if config.speedPercent then
		local haste = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
		haste:setParameter(CONDITION_PARAM_SUBID, config.subId)
		haste:setParameter(CONDITION_PARAM_TICKS, -1)
		haste:setParameter(CONDITION_PARAM_SPEED, math.floor(player:getBaseSpeed() * config.speedPercent / 100))
		player:addCondition(haste)
	end
end

local function clear(player, config)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, config.subId)
	player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, config.subId)
end

local tick = GlobalEvent("OtsImbuedBackpackTick")

function tick.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local id = player:getId()
		for _, config in ipairs(ITEMS) do
			local key = id .. ":" .. config.subId
			local on = wearing(player, config)
			if on and not active[key] then
				apply(player, config)
				active[key] = true
				player:sendTextMessage(MESSAGE_STATUS, config.name .. ": bonusy wlaczone.")
			elseif not on and active[key] then
				clear(player, config)
				active[key] = nil
			end
		end
	end
	for key in pairs(active) do
		local id = tonumber(key:match("^(%d+):"))
		if not id or not Player(id) then
			active[key] = nil
		end
	end
	return true
end

tick:interval(2000)
tick:register()

local login = CreatureEvent("OtsImbuedBackpackLogin")

function login.onLogin(player)
	for _, config in ipairs(ITEMS) do
		active[player:getId() .. ":" .. config.subId] = nil
		clear(player, config)
	end
	return true
end

login:register()
