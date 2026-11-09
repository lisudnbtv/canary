-- OTS: Nagrody dzienne (Reward Wall) - seria dni sie zlicza i daje konkretne bonusy.
--  * Dzien w nagrodach zmienia sie codziennie o globalServerSaveTime (06:00 czasu serwera), takze gdy serwer
--    byl wtedy wylaczony: przy starcie i co 5 minut nadrabiamy pominiety zapis (zwykle robi to tylko
--    global_server_save.lua, ktory na wylaczonym serwerze nigdy sie nie wykonuje i seria stala w miejscu).
--  * Bonus expa: +5% za kazdy dzien serii, najwyzej +50% (od 10 dni), dziala wszedzie.
--  * Za kazde odebranie: Tibia Coins (20 x dzien serii, najwyzej 300) i kamien ulepszen.
--  * Kamienie milowe: 7, 14, 21 i 30 dni (potem co 30) - worki, Tibia Coins i blessed upgrade stone.
local EXP_PER_DAY = 0.05
local EXP_MAX_DAYS = 10
local COINS_PER_DAY = 20
local COINS_MAX = 300
local UPGRADE_STONE = 20139
local BLESSED_STONE = 20138
local BAGS = { 34109, 39546, 43895 }
local MILESTONES = {
	[7] = { coins = 200, bags = 1, blessed = 1 },
	[14] = { coins = 400, bags = 2, blessed = 2 },
	[21] = { coins = 600, bags = 2, blessed = 3 },
	[30] = { coins = 1000, bags = 3, blessed = 5 },
}

local function streakOf(player)
	return math.max(0, tonumber(player:getStreakLevel()) or 0)
end

local function expBonus(streak)
	return math.min(streak, EXP_MAX_DAYS) * EXP_PER_DAY
end

-- ---------- codzienna zmiana dnia, takze po wylaczonym serwerze ----------
local function resetHour()
	local h, m = tostring(configManager.getString(configKeys.GLOBAL_SERVER_SAVE_TIME) or "06:00:00"):match("(%d+):(%d+)")
	return tonumber(h) or 6, tonumber(m) or 0
end

local function lastBoundary()
	local t = os.date("*t")
	t.hour, t.min = resetHour()
	t.sec = 0
	local boundary = os.time(t)
	if boundary > os.time() then
		boundary = boundary - 86400
	end
	return boundary
end

local function catchUp()
	local stored = tonumber(GetDailyRewardLastServerSave()) or 0
	local boundary = lastBoundary()
	if stored < boundary - 300 then
		UpdateDailyRewardGlobalStorage(DailyReward.storages.lastServerSave, boundary)
		for _, player in ipairs(Game.getPlayers()) do
			DailyReward.init(player:getId())
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nowy dzien! Nagroda dzienna jest gotowa do odebrania (Reward Wall).")
		end
		return true
	end
	return false
end

-- ---------- bonusy za odebranie nagrody ----------
local function giveClaimBonus(player)
	local streak = streakOf(player)
	local coins = math.min(COINS_MAX, COINS_PER_DAY * streak)
	player:addTibiaCoins(coins)
	player:addItem(UPGRADE_STONE, 1)
	local text = string.format("Seria nagrod dziennych: %d %s. Bonus: +%d Tibia Coins, kamien ulepszen. Bonus expa: +%d%%.", streak, streak == 1 and "dzien" or "dni", coins, math.floor(expBonus(streak) * 100 + 0.5))
	local milestone = MILESTONES[streak] or (streak > 30 and streak % 30 == 0 and MILESTONES[30])
	if milestone then
		player:addTibiaCoins(milestone.coins)
		for i = 1, milestone.bags do
			player:addItem(BAGS[(i - 1) % #BAGS + 1], 1)
		end
		player:addItem(BLESSED_STONE, milestone.blessed)
		text = text .. string.format(" KAMIEN MILOWY %d DNI: +%d Tibia Coins, %d %s, %d blessed upgrade stone!", streak, milestone.coins, milestone.bags, milestone.bags == 1 and "worek" or "worki", milestone.blessed)
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
end

local startup = GlobalEvent("OtsDailyStreakStartup")

function startup.onStartup()
	local caught = catchUp()
	-- odebranie nagrody: oryginalna funkcja modulu + nasze bonusy
	if DailyReward and DailyReward.pickedReward and not DailyReward.otsWrapped then
		local original = DailyReward.pickedReward
		DailyReward.pickedReward = function(playerId)
			local result = original(playerId)
			local player = Player(playerId)
			if result and player then
				giveClaimBonus(player)
			end
			return result
		end
		DailyReward.otsWrapped = true
	end
	logger.info("[OTS nagrody dzienne] Dzien nagrod: {} (nadrobiony: {})", os.date("%Y-%m-%d %H:%M", tonumber(GetDailyRewardLastServerSave()) or 0), caught and "tak" or "nie")
	return true
end

startup:register()

local think = GlobalEvent("OtsDailyStreakThink")

function think.onThink(interval)
	catchUp()
	return true
end

think:interval(5 * 60 * 1000)
think:register()

-- ---------- bonus expa ----------
-- (EventCallback playerOnGainExperience w tej wersji Canary nie zmienia expa - mnozniki ida przez
-- OtsExpModifiers w data/events/scripts/player.lua)
OtsExpModifiers = OtsExpModifiers or {}
OtsExpModifiers.dailyStreak = function(player, target, exp)
	local bonus = expBonus(streakOf(player))
	if bonus > 0 and exp > 0 and target then
		exp = exp * (1 + bonus)
	end
	return exp
end

local login = CreatureEvent("OtsDailyStreakLogin")

function login.onLogin(player)
	local streak = streakOf(player)
	if streak > 0 then
		player:sendTextMessage(MESSAGE_LOGIN, string.format("Seria nagrod dziennych: %d %s - bonus expa +%d%%.", streak, streak == 1 and "dzien" or "dni", math.floor(expBonus(streak) * 100 + 0.5)))
	end
	return true
end

login:register()
