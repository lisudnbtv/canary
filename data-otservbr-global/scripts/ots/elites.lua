-- OTS: elitarne potwory. Gdy gracz expi poza PZ, co jakis czas jeden zwykly potwor w poblizu
-- zamienia sie w elite: 4x wiecej HP, 2x mocniejsze ataki, czarna czaszka i nazwa "Elite ...".
-- Za zabicie elity jest nagroda premium: kamienie ulepszen, losowy worek (bag you desire / primal bag /
-- bag you covet), Tibia Coins i zloto na konto. Naraz zyje najwyzej jedna elita na gracza.
local STONE_ID = 20139
local TICK_MS = 10000
local CHANCE_PERCENT = 4 -- szansa na ture (10 s) expienia
local HEALTH_MULTIPLIER = 4
local DAMAGE_MULTIPLIER = 2
local MIN_HEALTH = 400 -- bez elit z kurczakow
local REWARD_BAGS = { 34109, 39546, 43895 }
local REWARD_STONES = 2
local REWARD_COINS = 25
local REWARD_GOLD = 500000

local elites = {} -- id potwora -> guid gracza, przy ktorym powstal

local function makeElite(monster, player)
	local health = monster:getMaxHealth() * HEALTH_MULTIPLIER
	monster:setMaxHealth(health)
	monster:addHealth(health)
	monster:setName("Elite " .. monster:getName())
	monster:setSkull(SKULL_BLACK)
	monster:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
	monster:say("ELITE!", TALKTYPE_MONSTER_YELL)
	elites[monster:getId()] = player:getGuid()
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "W poblizu pojawil sie elitarny potwor: " .. monster:getName() .. ".")
end

local tick = GlobalEvent("OtsElitesTick")

function tick.onThink(interval)
	local alive = {}
	for id, guid in pairs(elites) do
		if Creature(id) then
			alive[guid] = true
		else
			elites[id] = nil
		end
	end

	for _, player in ipairs(Game.getPlayers()) do
		local position = player:getPosition()
		local tile = Tile(position)
		if tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and not alive[player:getGuid()] and math.random(100) <= CHANCE_PERCENT then
			local candidates = {}
			for _, creature in ipairs(Game.getSpectators(position, false, false, 7, 7, 5, 5)) do
				if creature:isMonster() and not creature:getMaster() and not elites[creature:getId()] and creature:getMaxHealth() >= MIN_HEALTH then
					local monsterType = creature:getType()
					if monsterType and not monsterType:isRewardBoss() then
						candidates[#candidates + 1] = creature
					end
				end
			end
			if #candidates > 0 then
				makeElite(candidates[math.random(#candidates)], player)
			end
		end
	end
	return true
end

tick:interval(TICK_MS)
tick:register()

-- Elity bija dwa razy mocniej.
local damage = EventCallback("OtsEliteDamage")

function damage.creatureOnCombat(caster, target, combatDamage)
	if not caster or not combatDamage or type(caster.getId) ~= "function" or not elites[caster:getId()] then
		return
	end
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.value = entry.value * DAMAGE_MULTIPLIER
		end
	end
end

damage:register()

local reward = EventCallback("OtsEliteReward")

function reward.playerOnKill(player, monster)
	if not player or not monster or not elites[monster:getId()] then
		return
	end
	elites[monster:getId()] = nil
	local bag = REWARD_BAGS[math.random(#REWARD_BAGS)]
	player:addItem(STONE_ID, REWARD_STONES)
	player:addItem(bag, 1)
	player:addTibiaCoins(REWARD_COINS)
	player:setBankBalance(player:getBankBalance() + REWARD_GOLD)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Elita pokonana! Nagroda: %d kamienie ulepszen, %s, %d Tibia Coins i %d gp na konto.", REWARD_STONES, ItemType(bag):getName(), REWARD_COINS, REWARD_GOLD))
end

reward:register()
