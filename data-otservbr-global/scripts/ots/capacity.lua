-- OTS: udzwig (cap) liczony zawsze od zera z poziomu i profesji, wiec nic sie nie naklada:
--   jak w Tibii: 400 oz + 10 oz za poziomy 2-8 + przyrost profesji za kazdy poziom powyzej 8
--   plus BONUS_PER_LEVEL oz za kazdy poziom powyzej pierwszego.
-- Przeliczane przy logowaniu i po kazdej zmianie poziomu.

local BONUS_PER_LEVEL = 35 -- oz na poziom

local function sync(player)
	local level = player:getLevel()
	local gain = player:getVocation():getCapacityGain() / 100 -- silnik trzyma udzwig w setnych czesciach oz
	local base = 400 + (math.min(level, 8) - 1) * 10 + math.max(0, level - 8) * gain
	local total = base + math.max(0, level - 1) * BONUS_PER_LEVEL
	player:setCapacity(math.floor(total * 100))
end

local advance = CreatureEvent("OtsCapacityBonus")

function advance.onAdvance(player, skill, oldLevel, newLevel)
	if skill == SKILL_LEVEL then
		-- silnik dolicza zwykly udzwig po tym zdarzeniu, wiec liczymy po chwili od nowa
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
