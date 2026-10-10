-- OTS: dodatkowy udzwig (cap) za kazdy poziom.
-- Kazdy poziom powyzej pierwszego daje BONUS_PER_LEVEL oz ponad to, co daje profesja.
-- Bonus jest wyliczany od poziomu postaci i zapamietywany, wiec dziala tez wstecz
-- (przy logowaniu) i zmniejsza sie przy utracie poziomu.

local BONUS_PER_LEVEL = 100 -- oz na poziom
local APPLIED_KEY = "ots-cap-bonus" -- ile oz bonusu postac juz dostala

local function sync(player)
	local target = math.max(0, player:getLevel() - 1) * BONUS_PER_LEVEL
	local applied = tonumber(player:kv():get(APPLIED_KEY)) or 0
	if target == applied then
		return
	end
	-- udzwig jest przechowywany w setnych czesciach oz
	local capacity = player:getCapacity() + (target - applied) * 100
	player:setCapacity(math.max(0, capacity))
	player:kv():set(APPLIED_KEY, target)
end

local advance = CreatureEvent("OtsCapacityBonus")

function advance.onAdvance(player, skill, oldLevel, newLevel)
	if skill == SKILL_LEVEL then
		-- silnik dolicza zwykly udzwig po tym zdarzeniu, wiec liczymy po chwili
		local id = player:getId()
		addEvent(function()
			local target = Player(id)
			if target then
				sync(target)
			end
		end, 100)
	end
	return true
end

advance:register()

local login = EventCallback("OtsCapacityBonusOnLogin")

function login.playerOnLoginComplete(player)
	player:registerEvent("OtsCapacityBonus")
	sync(player)
end

login:register()
