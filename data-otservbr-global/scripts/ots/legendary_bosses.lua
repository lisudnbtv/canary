-- OTS: Legendarne Bossy - 10 poteznych wersji klasycznych bossow, kazdy z wlasna mechanika i unikalnym lootem.
-- Trzy sposoby walki:
--  A. !tp > Legendarne Bossy: wlasna sala dla kazdego bossa (pole PZ przy teleporcie), odnowienie po zabiciu
--     (6 h, Wladca Pustki 24 h).
--  B. Co 3 godziny losowy legendarny boss pojawia sie na mapie swiata (przy jednym z trudnych expowisk),
--     zostaje godzine; dojscie: !tp > Legendarne Bossy > Idz do bossa na mapie.
--  C. Wiezienie: ukryty teleport w swiatyni w Thais (bez opisu). Wszystkie 10 bossow naraz, wyjscie jest
--     po drugiej stronie korytarza (3 pola) i dziala dopiero, gdy padna wszystkie bossy (kazdy 2 razy). Droge
--     blokuja dwie sciany Straznikow (150 mln HP, nie atakuja, bez lootu). !tp w wiezieniu nie dziala.
-- Przedmioty: tools/ots/ots_runes.py (EQUIP, 60108-60123), serce Morgarotha: legendary_items.lua.
-- Kazdy cios bossa zabiera najwyzej CAP % zycia gracza (mechanika w teleports.lua, jak w Hardcore Boss);
-- mechaniki specjalne (Armagedon, plagi, pierscien) licza sie osobno i sa celowo mocne.

local CAP_ROOM = 12
local CAP_PRISON = 8
local COOLDOWN_HOURS = 6
local WORLD_FIRST_MINUTES = 30
local WORLD_EVERY_HOURS = 3
local WORLD_LIFETIME_MINUTES = 60
local BAGS = { 34109, 39546, 43895 }
local BLESSED_STONE = 20138

local LEGEND_ROOM_Y = 29939 -- sale w rzedzie 30260 + 30 * (n - 1), 29939, 7 (pole PZ w ots-hub.otbm)
local PRISON = { x = 30260, y = 29975, z = 7, length = 60, half = 1, walls = { 20, 40 }, perLegend = 2 } -- korytarz 3 pola szerokosci: od x do x + length - 1, y +- half
local PRISON_EXIT_AID = 64981
local PRISON_ENTRY_AID = 64980
local ENTRY_ITEM_ID = 1949

OtsNoElite = OtsNoElite or {} -- id potwora -> nie zamieniac w elite (elites.lua)

-- ---------------------------------------------------------------------------------------------
-- Definicje potworow
-- ---------------------------------------------------------------------------------------------
local function attacks(combatType, min, max, effect, shoot)
	return {
		{ name = "melee", interval = 2000, chance = 100, minDamage = -min, maxDamage = -max },
		{ name = "combat", interval = 2000, chance = 25, type = combatType, minDamage = -min, maxDamage = -max, radius = 6, effect = effect, target = false },
		{ name = "combat", interval = 2000, chance = 20, type = combatType, minDamage = -math.floor(min * 1.2), maxDamage = -math.floor(max * 1.2), range = 7, radius = 3, shootEffect = shoot, effect = effect, target = true },
		{ name = "combat", interval = 3000, chance = 15, type = combatType, minDamage = -math.floor(min * 1.5), maxDamage = -math.floor(max * 1.5), length = 8, spread = 0, effect = effect, target = false },
	}
end

local function elements(strong, weak)
	local list = {}
	for _, t in ipairs({ COMBAT_PHYSICALDAMAGE, COMBAT_ENERGYDAMAGE, COMBAT_EARTHDAMAGE, COMBAT_FIREDAMAGE, COMBAT_ICEDAMAGE, COMBAT_HOLYDAMAGE, COMBAT_DEATHDAMAGE }) do
		local percent = 10
		if t == strong then
			percent = 60
		elseif t == weak then
			percent = -15
		end
		list[#list + 1] = { type = t, percent = percent }
	end
	list[#list + 1] = { type = COMBAT_LIFEDRAIN, percent = 100 }
	list[#list + 1] = { type = COMBAT_MANADRAIN, percent = 100 }
	list[#list + 1] = { type = COMBAT_DROWNDAMAGE, percent = 100 }
	return list
end

local function loot(special)
	local list = {
		{ name = "crystal coin", chance = 100000, maxCount = 100 },
		{ name = "crystal coin", chance = 60000, maxCount = 100 },
		{ id = BLESSED_STONE, chance = 30000, maxCount = 2 },
		{ id = 34109, chance = 15000 }, -- bag you desire
		{ id = 39546, chance = 15000 }, -- primal bag
		{ id = 43895, chance = 15000 }, -- bag you covet
		{ name = "giant ruby", chance = 40000, maxCount = 3 },
		{ name = "giant sapphire", chance = 40000, maxCount = 3 },
		{ name = "giant emerald", chance = 40000, maxCount = 3 },
	}
	for _, entry in ipairs(special) do
		list[#list + 1] = entry
	end
	return list
end

local function outfit(lookType, head, body, legs, feet)
	return { lookType = lookType, lookHead = head or 0, lookBody = body or 0, lookLegs = legs or 0, lookFeet = feet or 0, lookAddons = 0, lookMount = 0 }
end

local LEGENDS = {
	{
		key = "apocalypse", name = "Apocalypse Reborn", hp = 150000000, coins = 750,
		outfit = outfit(12, 38, 114, 0, 94), corpse = 6068, race = "fire",
		attacks = attacks(COMBAT_DEATHDAMAGE, 7000, 15000, CONST_ME_MORTAREA, CONST_ANI_DEATH),
		elements = elements(COMBAT_DEATHDAMAGE, COMBAT_HOLYDAMAGE),
		loot = loot({ { id = 60108, chance = 8000 }, { id = 60109, chance = 8000 }, { id = 60110, chance = 8000 }, { id = 60111, chance = 8000 } }),
		mechanics = { "armageddon", "juggernauts" }, voice = "ARMAGEDON NADCHODZI!",
	},
	{
		key = "infernatil", name = "Infernatil Pradawny", hp = 100000000, coins = 500,
		outfit = outfit(35), corpse = 4097, race = "fire",
		attacks = attacks(COMBAT_FIREDAMAGE, 6000, 14000, CONST_ME_FIREAREA, CONST_ANI_FIRE),
		elements = elements(COMBAT_FIREDAMAGE, COMBAT_ICEDAMAGE), fireImmune = true,
		loot = loot({ { id = 60112, chance = 15000 }, { id = 60113, chance = 15000 } }),
		mechanics = { "firefloor" }, voice = "SPLONIESZ!",
	},
	{
		key = "bazir", name = "Bazir Klamca", hp = 120000000, coins = 600,
		outfit = outfit(35, 0, 0, 0, 0), corpse = 4097, race = "fire",
		attacks = attacks(COMBAT_ENERGYDAMAGE, 6000, 14000, CONST_ME_PURPLEENERGY, CONST_ANI_ENERGY),
		elements = elements(COMBAT_ENERGYDAMAGE, COMBAT_HOLYDAMAGE),
		loot = loot({ { id = 60114, chance = 15000 } }),
		mechanics = { "illusions", "disguise" }, voice = "KTORY Z NAS JEST PRAWDZIWY?",
	},
	{
		key = "ashfalor", name = "Ashfalor Smierci", hp = 90000000, coins = 500,
		outfit = outfit(12, 114, 114, 114, 114), corpse = 6068, race = "undead",
		attacks = attacks(COMBAT_DEATHDAMAGE, 6000, 13000, CONST_ME_MORTAREA, CONST_ANI_DEATH),
		elements = elements(COMBAT_DEATHDAMAGE, COMBAT_HOLYDAMAGE),
		loot = loot({ { id = 60115, chance = 15000 } }),
		mechanics = { "lifesteal", "lastbreath" }, voice = "TWOJE ZYCIE JEST MOJE!",
	},
	{
		key = "ferumbras", name = "Lord Ferumbras Absolutny", hp = 200000000, coins = 1000,
		outfit = outfit(229), corpse = 6078, race = "venom",
		attacks = attacks(COMBAT_ENERGYDAMAGE, 7000, 15000, CONST_ME_ENERGYAREA, CONST_ANI_ENERGY),
		elements = elements(COMBAT_ENERGYDAMAGE, COMBAT_EARTHDAMAGE),
		loot = loot({ { id = 60116, chance = 15000 }, { id = 60108, chance = 1000 }, { id = 60109, chance = 1000 }, { id = 60110, chance = 1000 }, { id = 60111, chance = 1000 } }),
		mechanics = { "blink", "shadows", "antimagic" }, voice = "NIKT NIE POKONA FERUMBRASA!",
	},
	{
		key = "morgaroth", name = "Morgaroth Pozeracz", hp = 130000000, coins = 600,
		outfit = outfit(12, 2, 94, 78, 79), corpse = 6068, race = "fire",
		attacks = attacks(COMBAT_FIREDAMAGE, 7000, 15000, CONST_ME_FIREAREA, CONST_ANI_FIRE),
		elements = elements(COMBAT_FIREDAMAGE, COMBAT_ICEDAMAGE),
		loot = loot({ { id = 60117, chance = 40000, maxCount = 2 } }),
		mechanics = { "roar", "closeguard" }, voice = "POZRE WAS WSZYSTKICH!",
	},
	{
		key = "zushuka", name = "Zushuka Wieczna", hp = 80000000, coins = 450,
		outfit = outfit(149, 0, 10, 0, 4), corpse = 18265, race = "blood",
		attacks = attacks(COMBAT_ICEDAMAGE, 6000, 13000, CONST_ME_ICEAREA, CONST_ANI_ICE),
		elements = elements(COMBAT_ICEDAMAGE, COMBAT_FIREDAMAGE),
		loot = loot({ { id = 60118, chance = 15000 } }),
		mechanics = { "freeze", "icefloor", "rebirth" }, voice = "ZAMARZNIESZ NA WIEKI!",
	},
	{
		key = "ghazbaran", name = "Ghazbaran Wojownik", hp = 160000000, coins = 800,
		outfit = outfit(12, 0, 85, 78, 94), corpse = 6068, race = "fire",
		attacks = attacks(COMBAT_PHYSICALDAMAGE, 7000, 15000, CONST_ME_HITAREA, CONST_ANI_WHIRLWINDSWORD),
		elements = elements(COMBAT_PHYSICALDAMAGE, COMBAT_HOLYDAMAGE),
		loot = loot({ { id = 60119, chance = 8000 }, { id = 60120, chance = 8000 }, { id = 60121, chance = 8000 } }),
		mechanics = { "combo" }, voice = "KAZDY CIOS MOCNIEJSZY!",
	},
	{
		key = "orshabaal", name = "Orshabaal Zarazy", hp = 110000000, coins = 550,
		outfit = outfit(201), corpse = 5995, race = "venom",
		attacks = attacks(COMBAT_EARTHDAMAGE, 6000, 14000, CONST_ME_POISONAREA, CONST_ANI_POISON),
		elements = elements(COMBAT_EARTHDAMAGE, COMBAT_FIREDAMAGE),
		loot = loot({ { id = 60122, chance = 15000 } }),
		mechanics = { "plague", "burrow" }, voice = "ZARAZA WAS STRAWI!",
	},
	{
		key = "void", name = "Wladca Pustki", hp = 300000000, coins = 2000, cooldown = 24,
		outfit = outfit(12, 114, 0, 114, 0), corpse = 6068, race = "undead",
		attacks = attacks(COMBAT_DEATHDAMAGE, 8000, 17000, CONST_ME_BLACKSMOKE, CONST_ANI_DEATH),
		elements = elements(COMBAT_DEATHDAMAGE, -1),
		loot = loot({ { id = 60123, chance = 30000 }, { id = 60114, chance = 6000 }, { id = 60115, chance = 6000 }, { id = 60116, chance = 6000 }, { id = 60118, chance = 6000 }, { id = 60122, chance = 6000 } }),
		mechanics = { "armageddon", "blink", "roar", "rebirth", "burrow" }, voice = "PUSTKA POCHLANIA WSZYSTKO!",
	},
}
local LEGEND_BY_KEY, LEGEND_BY_NAME = {}, {}
for index, cfg in ipairs(LEGENDS) do
	cfg.index = index
	cfg.cooldown = cfg.cooldown or COOLDOWN_HOURS
	cfg.room = Position(30260 + 30 * (index - 1), LEGEND_ROOM_Y, 7)
	LEGEND_BY_KEY[cfg.key] = cfg
	LEGEND_BY_NAME[cfg.name:lower()] = cfg
end

local function register(name, cfg)
	local mType = Game.createMonsterType(name)
	local monster = {}
	monster.description = name
	monster.experience = cfg.exp or math.floor(cfg.hp / 4)
	monster.outfit = cfg.outfit
	monster.health = cfg.hp
	monster.maxHealth = cfg.hp
	monster.race = cfg.race or "blood"
	monster.corpse = cfg.corpse or 6068
	monster.speed = cfg.speed or 320
	monster.manaCost = 0
	monster.changeTarget = { interval = 4000, chance = 20 }
	monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }
	monster.flags = {
		summonable = false, attackable = true, hostile = true, convinceable = false, pushable = false,
		rewardBoss = false, illusionable = false, canPushItems = true, canPushCreatures = true,
		staticAttackChance = 90, targetDistance = 1, runHealth = 0, healthHidden = false, isBlockable = false,
		canWalkOnEnergy = true, canWalkOnFire = true, canWalkOnPoison = true,
	}
	monster.light = { level = 4, color = 180 }
	monster.voices = { interval = 5000, chance = 10, { text = cfg.voice or "...", yell = true } }
	monster.loot = cfg.loot or {}
	monster.attacks = cfg.attacks or {}
	monster.defenses = {
		defense = 150, armor = 150,
		{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 20000, maxDamage = 60000, effect = CONST_ME_MAGIC_BLUE, target = false },
	}
	monster.elements = cfg.elements or {}
	monster.immunities = {
		{ type = "paralyze", condition = true },
		{ type = "invisible", condition = true },
		{ type = "outfit", condition = true },
		{ type = "fire", combat = cfg.fireImmune or false, condition = cfg.fireImmune or false },
	}
	monster.events = cfg.events or { "OtsLegendDeath" }
	mType:register(monster)
end

for _, cfg in ipairs(LEGENDS) do
	register(cfg.name, cfg)
end
-- pomocnicy: iluzje Bazira (1 cios = wybuch) i cienie Ferumbrasa
register("Bazir Illusion", { hp = 1, exp = 0, outfit = LEGEND_BY_KEY.bazir.outfit, corpse = 0, attacks = attacks(COMBAT_ENERGYDAMAGE, 1500, 3000, CONST_ME_PURPLEENERGY, CONST_ANI_ENERGY), events = { "OtsLegendIllusionDeath" } })
-- Straznik wiezienia: nie atakuje, nie chodzi, nie ma lootu - tylko blokuje korytarz (2 sciany po 3).
register("Straznik", { hp = 150000000, exp = 0, outfit = outfit(244, 114, 114, 114, 114), corpse = 0, speed = 0, attacks = {}, loot = {}, elements = elements(-1, -1), events = {}, voice = "NIE PRZEJDZIESZ." })
register("Ferumbras Shadow", { hp = 3000000, exp = 0, outfit = outfit(229, 114, 114, 114, 114), corpse = 0, attacks = attacks(COMBAT_DEATHDAMAGE, 4000, 9000, CONST_ME_MORTAREA, CONST_ANI_DEATH), elements = elements(-1, -1), events = {} })

-- ---------------------------------------------------------------------------------------------
-- Stan walk
-- ---------------------------------------------------------------------------------------------
local active = {} -- id bossa -> { cfg, mode = "room"|"world"|"prison", owner, origin, timers, adds, ... }
local world = { id = nil, expires = 0, label = nil, pos = nil }
local prison = { ids = {}, entrance = nil, exit = nil }

local function now()
	return os.time()
end

local function playersNear(pos, range)
	local list = {}
	for _, creature in ipairs(Game.getSpectators(pos, false, true, range, range, range, range)) do
		if creature:isPlayer() and not creature:getGroup():getAccess() then
			list[#list + 1] = creature
		end
	end
	return list
end

local function freeSpotNear(center, radius)
	for _ = 1, 25 do
		local pos = Position(center.x + math.random(-radius, radius), center.y + math.random(-radius, radius), center.z)
		if OtsIsSpotFree and OtsIsSpotFree(pos) then
			return pos
		end
	end
	return nil
end

local function protect(monster, cap)
	local id = monster:getId()
	OtsHardcoreBossDamage[id] = 1
	OtsHardcoreHitCap[id] = cap
	OtsNoElite[id] = true
end

local function forget(id)
	OtsHardcoreBossDamage[id] = nil
	OtsHardcoreHitCap[id] = nil
	OtsNoElite[id] = nil
end

local function clearState(id)
	local st = active[id]
	if not st then
		return
	end
	for _, addId in ipairs(st.adds or {}) do
		local add = Creature(addId)
		if add then
			add:remove()
		end
		forget(addId)
	end
	active[id] = nil
	forget(id)
end

local function spawnLegend(cfg, pos, mode, owner, exact)
	local monster = Game.createMonster(cfg.name, pos, not exact, true)
	if not monster then
		return nil
	end
	protect(monster, mode == "prison" and CAP_PRISON or CAP_ROOM)
	monster:setSkull(SKULL_BLACK)
	monster:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
	active[monster:getId()] = { cfg = cfg, mode = mode, owner = owner, origin = monster:getPosition(), timers = {}, adds = {}, flags = {}, tiles = {}, combo = {}, plague = {} }
	return monster
end

local function addMinion(st, boss, name, count)
	for _ = 1, count do
		local pos = freeSpotNear(boss:getPosition(), 3) or boss:getPosition()
		local add = Game.createMonster(name, pos, true, true)
		if add then
			protect(add, OtsHardcoreHitCap[boss:getId()] or CAP_ROOM)
			st.adds[#st.adds + 1] = add:getId()
			pos:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
end

local function every(st, name, seconds)
	local t = st.timers[name] or 0
	if now() - t >= seconds then
		st.timers[name] = now()
		return t ~= 0 -- pierwsze wywolanie tylko ustawia licznik
	end
	return false
end

local function hit(player, percent, combatType, effect)
	local amount = math.floor(player:getMaxHealth() * percent / 100)
	if amount > 0 then
		doTargetCombatHealth(0, player, combatType, -amount, -amount, effect or CONST_ME_NONE)
	end
end

local function hpRatio(monster)
	return monster:getHealth() / math.max(1, monster:getMaxHealth())
end

local paralyze = Condition(CONDITION_PARALYZE)
paralyze:setParameter(CONDITION_PARAM_TICKS, 3000)
paralyze:setFormula(-0.9, 0, -0.9, 0)

local root = Condition(CONDITION_ROOTED or CONDITION_PARALYZE)
root:setParameter(CONDITION_PARAM_TICKS, 2000)
if not CONDITION_ROOTED then
	root:setFormula(-1, 0, -1, 0)
end

-- ---------------------------------------------------------------------------------------------
-- Mechaniki (wywolywane co sekunde dla kazdego bossa, przy ktorym sa gracze)
-- ---------------------------------------------------------------------------------------------
local M = {}

-- Apocalypse: co 30 s pod kazdym graczem pole 3x3 wybucha po 2 s (40% zycia), trzeba z niego zejsc.
M.armageddon = function(boss, st, players)
	if not every(st, "armageddon", 30) then
		return
	end
	boss:say("ARMAGEDON!", TALKTYPE_MONSTER_YELL)
	for _, player in ipairs(players) do
		local center = player:getPosition()
		for dx = -1, 1 do
			for dy = -1, 1 do
				Position(center.x + dx, center.y + dy, center.z):sendMagicEffect(CONST_ME_FIREATTACK)
			end
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ARMAGEDON! Zejdz z zaznaczonego pola!")
		local pid = player:getId()
		addEvent(function()
			local target = Player(pid)
			if not target then
				return
			end
			for dx = -1, 1 do
				for dy = -1, 1 do
					Position(center.x + dx, center.y + dy, center.z):sendMagicEffect(CONST_ME_EXPLOSIONAREA)
				end
			end
			local p = target:getPosition()
			if p.z == center.z and math.abs(p.x - center.x) <= 1 and math.abs(p.y - center.y) <= 1 then
				hit(target, 40, COMBAT_FIREDAMAGE, CONST_ME_EXPLOSIONHIT)
			end
		end, 2000)
	end
end

M.juggernauts = function(boss, st)
	if not st.flags.juggernauts and hpRatio(boss) <= 0.5 then
		st.flags.juggernauts = true
		boss:say("PRZYBADZCIE, JUGGERNAUTY!", TALKTYPE_MONSTER_YELL)
		addMinion(st, boss, "Juggernaut", 4)
	end
end

-- Infernatil / Zushuka: podloga zaczyna plonac (zamarzac), co 10 s wiecej pol; stanie na nich boli.
local function floorMechanic(boss, st, players, kind)
	local spec = kind == "fire" and { effect = CONST_ME_FIREATTACK, type = COMBAT_FIREDAMAGE, dmg = 5 } or { effect = CONST_ME_ICEATTACK, type = COMBAT_ICEDAMAGE, dmg = 4 }
	st.tileCount = st.tileCount or 0
	if every(st, "floorgrow", 10) and st.tileCount < 70 then
		local center = boss:getPosition()
		for _ = 1, 10 do
			local pos = freeSpotNear(center, 6)
			if pos and not st.tiles[pos.x .. ":" .. pos.y] then
				st.tiles[pos.x .. ":" .. pos.y] = pos
				st.tileCount = st.tileCount + 1
			end
		end
	end
	local show = every(st, "floorshow", 2)
	for _, pos in pairs(st.tiles) do
		if show then
			pos:sendMagicEffect(spec.effect)
		end
	end
	for _, player in ipairs(players) do
		local p = player:getPosition()
		if st.tiles[p.x .. ":" .. p.y] then
			hit(player, spec.dmg, spec.type, spec.effect)
		end
	end
	local b = boss:getPosition()
	if kind == "fire" and st.tiles[b.x .. ":" .. b.y] then
		boss:addHealth(math.floor(boss:getMaxHealth() * 0.005))
		b:sendMagicEffect(CONST_ME_MAGIC_RED)
	end
end

M.firefloor = function(boss, st, players)
	floorMechanic(boss, st, players, "fire")
end

M.icefloor = function(boss, st, players)
	floorMechanic(boss, st, players, "ice")
end

-- Bazir: co 20 s 5 iluzji (wybuchaja po uderzeniu), prawdziwy Bazir zamienia sie miejscem z jedna z nich.
M.illusions = function(boss, st)
	if not every(st, "illusions", 20) then
		return
	end
	-- stare iluzje znikaja, zanim przyjda nowe
	local keep = {}
	for _, addId in ipairs(st.adds) do
		local add = Creature(addId)
		if add and add:getName() == boss:getName() then
			add:remove()
			forget(addId)
		elseif add then
			keep[#keep + 1] = addId
		end
	end
	st.adds = keep
	local before = #st.adds
	addMinion(st, boss, "Bazir Illusion", 5)
	for i = before + 1, #st.adds do
		local add = Creature(st.adds[i])
		if add then
			add:setName(boss:getName(), boss:getName():lower())
		end
	end
	local last = Creature(st.adds[#st.adds])
	if last and #st.adds > before then
		local a, b = boss:getPosition(), last:getPosition()
		boss:teleportTo(b, true)
		last:teleportTo(a, true)
	end
	boss:say("KTORY Z NAS?", TALKTYPE_MONSTER_YELL)
end

local DISGUISES = { 35, 12, 229, 201, 244, 149 }
M.disguise = function(boss, st)
	if every(st, "disguise", 15) then
		boss:setOutfit(outfit(DISGUISES[math.random(#DISGUISES)]))
		st.disguisedUntil = now() + 5
	elseif st.disguisedUntil and now() >= st.disguisedUntil then
		st.disguisedUntil = nil
		boss:setOutfit(st.cfg.outfit)
	end
end

-- Ashfalor: leczenie z ciosow (callback nizej), przy 25% zycia zabiera wszystkim 50% many.
M.lifesteal = function() end
M.lastbreath = function(boss, st, players)
	if not st.flags.lastbreath and hpRatio(boss) <= 0.25 then
		st.flags.lastbreath = true
		boss:say("OSTATNIE TCHNIENIE!", TALKTYPE_MONSTER_YELL)
		for _, player in ipairs(players) do
			player:addMana(-math.floor(player:getMana() * 0.5))
			player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		end
	end
end

-- Ferumbras: faza 1 - przenosi graczy po sali, faza 2 (66%) - 3 cienie, faza 3 (33%) - szybszy i pole antymagii.
-- (w waskim korytarzu wiezienia nie przenosi; w salach co 20 s i tylko w 1. fazie)
M.blink = function(boss, st, players)
	if st.mode ~= "prison" and hpRatio(boss) > 0.66 then
		if every(st, "blink", 20) then
			for _, player in ipairs(players) do
				local pos = freeSpotNear(boss:getPosition(), 6)
				if pos then
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:teleportTo(pos, true)
					pos:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		end
	end
end

M.shadows = function(boss, st)
	if not st.flags.shadows and hpRatio(boss) <= 0.66 then
		st.flags.shadows = true
		boss:say("MOJE CIENIE, DO MNIE!", TALKTYPE_MONSTER_YELL)
		addMinion(st, boss, "Ferumbras Shadow", 3)
	end
end

M.antimagic = function(boss, st, players)
	if hpRatio(boss) > 0.33 then
		return
	end
	if not st.flags.antimagic then
		st.flags.antimagic = true
		boss:say("POLE ANTYMAGII!", TALKTYPE_MONSTER_YELL)
		boss:changeSpeed(boss:getBaseSpeed())
	end
	for _, player in ipairs(players) do
		player:addMana(-math.floor(player:getMaxMana() * 0.03))
	end
	if every(st, "antimagicfx", 2) then
		boss:getPosition():sendMagicEffect(CONST_ME_PURPLEENERGY)
	end
end

-- Morgaroth: co 15 s ryk (paraliz 3 s) i pierscien sie zaciska - kto stoi dalej niz promien, traci zycie.
M.roar = function(boss, st, players)
	st.ring = st.ring or 9
	if every(st, "roar", 15) then
		boss:say("RYK!", TALKTYPE_MONSTER_YELL)
		st.ring = math.max(3, st.ring - 1)
		for _, player in ipairs(players) do
			player:addCondition(paralyze)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Pierscien zaciska sie - trzymaj sie najwyzej %d pol od bossa!", st.ring))
		end
	end
	local b = boss:getPosition()
	for _, player in ipairs(players) do
		local p = player:getPosition()
		if math.max(math.abs(p.x - b.x), math.abs(p.y - b.y)) > st.ring then
			hit(player, 6, COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA)
		end
	end
end
M.closeguard = function() end -- callback nizej: fizyczne z przyleglego pola -50%

-- Zushuka: zamraza losowego gracza na 2 s, co 60 s "Odrodzenie" (pelne leczenie, jesli w 10 s nie straci 5%).
M.freeze = function(boss, st, players)
	if every(st, "freeze", 12) and #players > 0 then
		local player = players[math.random(#players)]
		player:addCondition(root)
		player:getPosition():sendMagicEffect(CONST_ME_ICETORNADO)
	end
end

M.rebirth = function(boss, st)
	if st.rebirthAt then
		if now() >= st.rebirthAt then
			st.rebirthAt = nil
			local lost = st.rebirthHealth - boss:getHealth()
			if lost < boss:getMaxHealth() * 0.05 then
				boss:addHealth(boss:getMaxHealth())
				boss:say("ODRODZENIE!", TALKTYPE_MONSTER_YELL)
				boss:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			else
				boss:say("Nie...", TALKTYPE_MONSTER_SAY)
			end
		end
	elseif every(st, "rebirth", 60) then
		st.rebirthAt = now() + 10
		st.rebirthHealth = boss:getHealth()
		boss:say("ODRODZENIE ZA 10 SEKUND! (zabierz 5% zycia, zeby przerwac)", TALKTYPE_MONSTER_YELL)
	end
end

-- Ghazbaran: seria - kazdy cios w ten sam cel +15% (do +150%), zeruje sie, gdy cel odejdzie na 3 pola.
M.combo = function(boss, st, players)
	local b = boss:getPosition()
	for _, player in ipairs(players) do
		local p = player:getPosition()
		if math.max(math.abs(p.x - b.x), math.abs(p.y - b.y)) >= 3 then
			st.combo[player:getId()] = nil
		end
	end
	local target = boss:getTarget()
	local count = target and st.combo[target:getId()] or 0
	OtsHardcoreBossDamage[boss:getId()] = 1 + 0.15 * count
end

-- Orshabaal: co 10 s zaraza (rosnace obrazenia przez 10 s), co 25 s chowa sie pod ziemie i wychodzi gdzie indziej.
M.plague = function(boss, st, players)
	if every(st, "plague", 10) then
		boss:say("ZARAZA!", TALKTYPE_MONSTER_YELL)
		for _, player in ipairs(players) do
			st.plague[player:getId()] = now()
		end
	end
	for _, player in ipairs(players) do
		local started = st.plague[player:getId()]
		if started then
			local elapsed = now() - started
			if elapsed >= 10 then
				st.plague[player:getId()] = nil
			else
				hit(player, 0.5 + elapsed * 0.5, COMBAT_EARTHDAMAGE, CONST_ME_HITBYPOISON)
			end
		end
	end
end

M.burrow = function(boss, st)
	if every(st, "burrow", 25) then
		local pos = freeSpotNear(boss:getPosition(), 6)
		if pos then
			boss:getPosition():sendMagicEffect(CONST_ME_GROUNDSHAKER)
			boss:teleportTo(pos, true)
			pos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
		end
	end
end

-- Leczenie Ashfalora, seria Ghazbarana i obrona Morgarotha przed walka wrecz z bliska.
local legendCombat = EventCallback("OtsLegendCombat")

function legendCombat.creatureOnCombat(caster, target, combatDamage)
	if not combatDamage or not target or type(target.getId) ~= "function" then
		return
	end
	if caster and type(caster.getId) == "function" then
		local st = active[caster:getId()]
		if st and target:isPlayer() then
			if st.cfg.key == "ashfalor" then
				caster:addHealth(math.floor(caster:getMaxHealth() * 0.01))
			elseif st.cfg.key == "ghazbaran" then
				st.combo[target:getId()] = math.min(10, (st.combo[target:getId()] or 0) + 1)
			end
		end
	end
	local tst = active[target:getId()]
	if tst and tst.cfg.key == "morgaroth" and caster and type(caster.getPosition) == "function" then
		local a, b = caster:getPosition(), target:getPosition()
		if math.max(math.abs(a.x - b.x), math.abs(a.y - b.y)) <= 1 then
			for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
				if entry and tonumber(entry.value) and entry.value < 0 and entry.type == COMBAT_PHYSICALDAMAGE then
					entry.value = math.floor(entry.value * 0.5)
				end
			end
		end
	end
end

legendCombat:register()

-- ---------------------------------------------------------------------------------------------
-- Petla: mechaniki, pilnowanie sal, wygasanie bossa z mapy
-- ---------------------------------------------------------------------------------------------
local function inBox(pos, center, rx, ry)
	return pos.z == center.z and math.abs(pos.x - center.x) <= rx and math.abs(pos.y - center.y) <= ry
end

local function tick()
	for id, st in pairs(active) do
		local boss = Creature(id)
		if not boss then
			clearState(id)
		else
			local keep = true
			if st.mode == "room" then
				local owner = st.owner and Player(st.owner)
				if not owner or not inBox(owner:getPosition(), st.cfg.room, 12, 12) then
					keep = false
					if owner then
						owner:sendTextMessage(MESSAGE_EVENT_ADVANCE, st.cfg.name .. " zniknal - opusciles sale. Odnowienie nie zostalo naliczone.")
					end
				end
			elseif st.mode == "world" and now() >= world.expires then
				keep = false
				Game.broadcastMessage(st.cfg.name .. " zniknal z mapy swiata. Nastepny legendarny boss za kilka godzin.", MESSAGE_EVENT_ADVANCE)
			end
			if not keep then
				boss:remove()
				clearState(id)
			else
				-- bossy uciekajace za daleko wracaja (sala / miejsce pojawienia sie)
				local home = st.mode == "room" and Position(st.cfg.room.x, st.cfg.room.y - 5, st.cfg.room.z) or st.origin
				if not inBox(boss:getPosition(), home, 14, 14) then
					boss:teleportTo(home, true)
				end
				local players = playersNear(boss:getPosition(), 9)
				if #players > 0 then
					for _, name in ipairs(st.cfg.mechanics) do
						local ok, err = pcall(M[name], boss, st, players)
						if not ok then
							logger.warn("[OTS legendarne] {} / {}: {}", st.cfg.name, name, tostring(err))
						end
					end
				end
			end
		end
	end
	addEvent(tick, 1000)
end

-- ---------------------------------------------------------------------------------------------
-- Smierc: Tibia Coins, odnowienie, wiezienie
-- ---------------------------------------------------------------------------------------------
local death = CreatureEvent("OtsLegendDeath")

function death.onDeath(creature, corpse, killer, mostDamageKiller)
	local st = active[creature:getId()]
	if not st then
		return true
	end
	local rewarded = {}
	for _, who in ipairs({ killer, mostDamageKiller }) do
		local player = who and who:isPlayer() and who or (who and who:getMaster() and who:getMaster():isPlayer() and who:getMaster())
		if player and not rewarded[player:getId()] then
			rewarded[player:getId()] = true
			player:addTibiaCoins(st.cfg.coins)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("LEGENDA POKONANA: %s! +%d Tibia Coins.", st.cfg.name, st.cfg.coins))
			local kills = (tonumber(player:kv():get("ots-legend-kills-" .. st.cfg.key)) or 0) + 1
			player:kv():set("ots-legend-kills-" .. st.cfg.key, kills)
		end
	end
	if st.mode == "room" and st.owner then
		local owner = Player(st.owner)
		if owner then
			owner:kv():set("ots-legend-cd-" .. st.cfg.key, now() + st.cfg.cooldown * 3600)
		end
	elseif st.mode == "world" then
		Game.broadcastMessage(st.cfg.name .. " zostal pokonany!", MESSAGE_EVENT_ADVANCE)
		world.id = nil
	end
	clearState(creature:getId())
	return true
end

death:register()

local illusionDeath = CreatureEvent("OtsLegendIllusionDeath")

function illusionDeath.onDeath(creature)
	local pos = creature:getPosition()
	pos:sendMagicEffect(CONST_ME_PURPLEENERGY)
	for _, player in ipairs(playersNear(pos, 2)) do
		hit(player, 15, COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYHIT)
	end
	forget(creature:getId())
	return true
end

illusionDeath:register()

-- ---------------------------------------------------------------------------------------------
-- A. Sale (!tp > Legendarne Bossy)
-- ---------------------------------------------------------------------------------------------
local function roomBusy(cfg)
	for _, st in pairs(active) do
		if st.mode == "room" and st.cfg == cfg then
			return true
		end
	end
	return false
end

local function roomEnter(player, cfg)
	local left = (tonumber(player:kv():get("ots-legend-cd-" .. cfg.key)) or 0) - now()
	if left > 0 then
		player:sendCancelMessage(string.format("%s odrodzi sie za %d h %02d min.", cfg.name, math.floor(left / 3600), math.floor(left % 3600 / 60)))
		return
	end
	if OtsInFight(player) then
		return
	end
	for id, st in pairs(active) do
		if st.mode == "room" and st.cfg == cfg then
			local boss = Creature(id)
			if boss then
				boss:remove()
			end
			clearState(id)
		end
	end
	OtsTravel(player, cfg.name, cfg.room)
	if not inBox(player:getPosition(), cfg.room, 12, 12) then
		return
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s pojawi sie za 3 sekundy. Kazdy jego cios zabiera najwyzej %d%% zycia, ale mechaniki specjalne bola bardziej!", cfg.name, CAP_ROOM))
	local pid = player:getId()
	addEvent(function()
		local target = Player(pid)
		if not target or not inBox(target:getPosition(), cfg.room, 12, 12) or roomBusy(cfg) then
			return
		end
		spawnLegend(cfg, Position(cfg.room.x, cfg.room.y - 5, cfg.room.z), "room", pid)
	end, 3000)
end

-- ---------------------------------------------------------------------------------------------
-- B. Boss na mapie swiata
-- ---------------------------------------------------------------------------------------------
local function worldSpawn()
	addEvent(worldSpawn, WORLD_EVERY_HOURS * 3600 * 1000)
	if world.id and Creature(world.id) then
		return
	end
	local spots = OtsLegendWorldSpots and OtsLegendWorldSpots() or {}
	if #spots == 0 then
		return
	end
	local pool = {}
	for _, cfg in ipairs(LEGENDS) do
		for _ = 1, cfg.key == "void" and 1 or 4 do
			pool[#pool + 1] = cfg
		end
	end
	local cfg = pool[math.random(#pool)]
	for _ = 1, 10 do
		local spot = spots[math.random(#spots)]
		local landing = Position(spot[2], spot[3], spot[4])
		local monster = spawnLegend(cfg, Position(landing.x + math.random(-5, 5), landing.y + math.random(-5, 5), landing.z), "world")
		if monster then
			world.id = monster:getId()
			world.expires = now() + WORLD_LIFETIME_MINUTES * 60
			world.label = spot[1]:gsub("%s*%b()", "")
			world.landing = landing
			Game.broadcastMessage(string.format("LEGENDARNY BOSS: %s pojawil sie przy expowisku %s! Masz %d minut. Dojscie: !tp > Legendarne Bossy.", cfg.name, world.label, WORLD_LIFETIME_MINUTES), MESSAGE_EVENT_ADVANCE)
			return
		end
	end
end

-- ---------------------------------------------------------------------------------------------
-- C. Wiezienie
-- ---------------------------------------------------------------------------------------------
local PRISON_FLOORS = { 11278, 11279, 11281, 11282, 11283, 11280 }

local function inPrison(pos)
	return pos.z == PRISON.z and pos.x >= PRISON.x - 1 and pos.x <= PRISON.x + PRISON.length and math.abs(pos.y - PRISON.y) <= PRISON.half + 1
end

OtsTpBlocked = function(player)
	if inPrison(player:getPosition()) then
		player:sendCancelMessage("Kraty wiezienia blokuja teleport. Jedyne wyjscie jest po drugiej stronie sali...")
		return true
	end
	return false
end

local function prisonAlive()
	local alive = {}
	for _, id in ipairs(prison.ids) do
		if Creature(id) then
			alive[#alive + 1] = id
		end
	end
	prison.ids = alive
	return #alive
end

local function prisonFill()
	if prisonAlive() > 0 then
		return
	end
	-- dwie sciany Straznikow (po 3 w pionie, przez cala szerokosc korytarza)
	for _, guardId in ipairs(prison.guards or {}) do
		local guard = Creature(guardId)
		if guard then
			guard:remove()
		end
		OtsNoElite[guardId] = nil
	end
	prison.guards = {}
	local wall = {}
	for _, dx in ipairs(PRISON.walls) do
		wall[dx] = true
		for dy = -PRISON.half, PRISON.half do
			local guard = Game.createMonster("Straznik", Position(PRISON.x + dx, PRISON.y + dy, PRISON.z), false, true)
			if guard then
				OtsNoElite[guard:getId()] = true
				guard:setSkull(SKULL_BLACK)
				prison.guards[#prison.guards + 1] = guard:getId()
			end
		end
	end
	-- bossy: kazda legenda PRISON.perLegend razy, rozlozone po calej dlugosci (poza scianami)
	local list = {}
	for _ = 1, PRISON.perLegend do
		for _, cfg in ipairs(LEGENDS) do
			list[#list + 1] = cfg
		end
	end
	local spots = {}
	for dx = 5, PRISON.length - 5 do
		if not wall[dx] and not wall[dx - 1] and not wall[dx + 1] then
			for dy = -PRISON.half, PRISON.half do
				spots[#spots + 1] = Position(PRISON.x + dx, PRISON.y + dy, PRISON.z)
			end
		end
	end
	local step = #spots / #list
	for index, cfg in ipairs(list) do
		local pos = spots[math.max(1, math.min(#spots, math.floor((index - 1) * step + math.random(0, math.max(0, math.floor(step) - 1))) + 1))]
		local monster = spawnLegend(cfg, pos, "prison", nil, true) or spawnLegend(cfg, pos, "prison")
		if monster then
			prison.ids[#prison.ids + 1] = monster:getId()
		end
	end
end

local prisonEntry = MoveEvent()

function prisonEntry.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	prisonFill()
	player:teleportTo(prison.entrance)
	prison.entrance:sendMagicEffect(CONST_ME_MORTAREA)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Kraty zatrzasnely sie za toba. To WIEZIENIE legendarnych bossow - wyjscie jest po drugiej stronie sali, ale otworzy sie dopiero, gdy padna wszystkie legendarne bossy. Droge blokuja dwie sciany Straznikow - trzeba sie przez nie przebic.")
	return true
end

prisonEntry:aid(PRISON_ENTRY_AID)
prisonEntry:register()

local prisonExit = MoveEvent()

function prisonExit.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local alive = prisonAlive()
	if alive > 0 then
		player:teleportTo(Position(position.x - 2, position.y, position.z), true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wyjscie jest zamkniete. Legendarne bossy przy zyciu: %d/%d.", alive, #LEGENDS * PRISON.perLegend))
		return true
	end
	local first = (tonumber(player:kv():get("ots-legend-prison")) or 0) == 0
	player:kv():set("ots-legend-prison", (tonumber(player:kv():get("ots-legend-prison")) or 0) + 1)
	if first then
		player:addItem(60123, 1)
		player:addTibiaCoins(3000)
		player:addItem(BLESSED_STONE, 5)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "UCIEKLES Z WIEZIENIA LEGEND! Nagroda za pierwszy raz: void lord's sigil, 3000 Tibia Coins, 5 blessed upgrade stone.")
	else
		player:addTibiaCoins(1500)
		for _, bag in ipairs(BAGS) do
			player:addItem(bag, 1)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Uciekles z Wiezienia Legend! Nagroda: 1500 Tibia Coins i 3 worki.")
	end
	player:teleportTo(OtsHubLobby)
	OtsHubLobby:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

prisonExit:aid(PRISON_EXIT_AID)
prisonExit:register()

local function buildPrison()
	local made = 0
	for dx = 0, PRISON.length - 1 do
		for dy = -PRISON.half, PRISON.half do
			local pos = Position(PRISON.x + dx, PRISON.y + dy, PRISON.z)
			if not Tile(pos) then
				Game.createTile(pos.x, pos.y, pos.z)
			end
			local tile = Tile(pos)
			if tile and not tile:getGround() then
				Game.createItem(PRISON_FLOORS[math.random(#PRISON_FLOORS)], 1, pos)
				made = made + 1
			end
		end
	end
	prison.entrance = Position(PRISON.x + 1, PRISON.y, PRISON.z)
	prison.exit = Position(PRISON.x + PRISON.length - 2, PRISON.y, PRISON.z)
	local tile = Tile(prison.exit)
	if tile and not tile:getItemById(ENTRY_ITEM_ID) then
		local tp = Game.createItem(ENTRY_ITEM_ID, 1, prison.exit)
		if tp then
			tp:setActionId(PRISON_EXIT_AID)
		end
	end
	return made
end

local function placeTempleTrap()
	local temple
	for _, town in ipairs(Game.getTowns()) do
		if town:getName():lower() == "thais" then
			temple = town:getTemplePosition()
			break
		end
	end
	if not temple then
		return nil
	end
	-- rzad nad swiatynia (y - 2) zajmuja NPC (Supplier, Token Trader), wiec szukamy nizej i po bokach
	for _, offset in ipairs({ { -3, 2 }, { 3, 2 }, { -2, 3 }, { 2, 3 }, { -4, 0 }, { 4, 0 }, { 0, 4 }, { -4, 3 }, { 4, 3 } }) do
		local pos = Position(temple.x + offset[1], temple.y + offset[2], temple.z)
		local tile = Tile(pos)
		if tile and tile:getGround() and tile:isWalkable(false, false, true, true, false) and tile:getItemCount() == 0 and not tile:getHouse() and not tile:getTopCreature() then
			local tp = Game.createItem(ENTRY_ITEM_ID, 1, pos)
			if tp then
				tp:setActionId(PRISON_ENTRY_AID)
				return pos
			end
		end
	end
	return nil
end

-- ---------------------------------------------------------------------------------------------
-- Menu
-- ---------------------------------------------------------------------------------------------
OtsLegendMenu = function(player)
	local window = ModalWindow({ title = "Legendarne Bossy", message = string.format("Sala dla kazdego bossa, odnowienie %d h po zabiciu (Wladca Pustki 24 h). Kazdy cios bossa: najwyzej %d%% zycia, mechaniki specjalne bola mocniej.                                        ", COOLDOWN_HOURS, CAP_ROOM) })
	if world.id and Creature(world.id) and world.landing then
		local st = active[world.id]
		local minutes = math.max(0, math.floor((world.expires - now()) / 60))
		window:addChoice(string.format(">> Idz do bossa na mapie: %s (%s, jeszcze %d min)", st and st.cfg.name or "?", world.label or "?", minutes), function(target)
			if OtsInFight(target) then
				return
			end
			OtsTravel(target, "Legendarny boss: " .. (world.label or ""), world.landing)
		end)
	end
	for _, cfg in ipairs(LEGENDS) do
		local left = (tonumber(player:kv():get("ots-legend-cd-" .. cfg.key)) or 0) - now()
		local kills = tonumber(player:kv():get("ots-legend-kills-" .. cfg.key)) or 0
		local status = left > 0 and string.format("odnowienie %d h %02d min", math.floor(left / 3600), math.floor(left % 3600 / 60)) or "gotowy"
		window:addChoice(string.format("%s (%d mln HP) - %s, zabity: %dx", cfg.name, math.floor(cfg.hp / 1000000), status, kills), function(target)
			roomEnter(target, cfg)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local startup = GlobalEvent("OtsLegendaryBosses")

function startup.onStartup()
	local made = 0
	for _, cfg in ipairs(LEGENDS) do
		made = made + OtsBuildRoom(cfg.room)
	end
	local prisonTiles = buildPrison()
	local trap = placeTempleTrap()
	addEvent(tick, 1000)
	addEvent(worldSpawn, WORLD_FIRST_MINUTES * 60 * 1000)
	logger.info("[OTS legendarne] Sale: {} pol, wiezienie: {} pol, pulapka w swiatyni: {}", made, prisonTiles, trap and string.format("%d, %d, %d", trap.x, trap.y, trap.z) or "brak miejsca")
	return true
end

startup:register()
