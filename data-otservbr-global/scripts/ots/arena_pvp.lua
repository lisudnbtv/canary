-- OTS: Arena PvP - walki z NPC, ktore wygladaja i walcza jak gracze (!tp > Arena PvP albo !arena).
-- Cztery osobne sale:
--  * Pojedynek 1 na 1 - wybierasz profesje przeciwnika, kazda wygrana z rzedu = przeciwnik +5% mocniejszy.
--  * Fale przeciwnikow - coraz wiecej i coraz mocniejszych "graczy", az padniesz.
--  * Druzyna na druzyne - twoje party (np. postacie z bota) przeciw lustrzanej druzynie NPC.
--  * Turniej - drabinka 8 zawodnikow: cwiercfinal, polfinal, final z Mistrzem Areny.
-- Przeciwnicy to LUSTRO postaci: tyle samo zycia, bija sila jej najmocniejszego czaru (polowa jak w PvP,
-- gracz tez zadaje im polowe), lecza sie potionami i czarami co sekunde jak gracz.
-- Lecza sie (exura, potiony - z ograniczonym zapasem), MS i ED walcza pod utamo vita (mana jak u postaci),
-- uciekaja przy niskim zyciu. Przegrana nic nie kosztuje: przy smiertelnym ciosie postac wraca do wejscia
-- z pelnym zyciem. Za wygrane: punkty areny (sklep areny) i ranking.

local FIGHTER_TYPE = "Arena Fighter"
local STAGING_DY = 32 -- poczekalnia NPC (poza zasiegiem wzroku) - tu dostaja imie, zanim wejda do sali
local FLOOR = 11285 -- podloga z sali Obrona
local TICK = 200 -- co tyle ms NPC sprawdza sytuacje (szybka reakcja na leczenie, jak dobry gracz)
-- LUSTRO: NPC ma tyle zycia, co postac, i bije jej wlasna sila (sredni cios najmocniejszego czaru jak w !czary).
-- Jak w prawdziwym PvP obie strony zadaja sobie polowe obrazen (PVP).
local PVP = 0.5
-- POKRETLA TRUDNOSCI (lustro jest silniejsze niz "czysta kopia", bo gracz ma bota/autoleczenie i bonusy)
local NPC_POWER = 1.3 -- mnoznik ciosow NPC
local NPC_HEAL = 1.4 -- mnoznik leczenia NPC (czary, potiony, mana potiony)
local HEAL_BUDGET = 6 -- zapas leczenia NPC w paskach zycia (jak plecak potionow)
local MAX_HIT = 25 -- jeden cios NPC zabiera najwyzej tyle % zycia celu
local SPELL_EXHAUST = 1000 -- jak czary graczy na serwerze (spell_cooldown.lua: 1 s)

local ROOMS = {
	duel = { label = "Pojedynek 1 na 1", landing = Position(30310, 30018, 7), limit = 180, seconds = 40 },
	waves = { label = "Fale przeciwnikow", landing = Position(30340, 30018, 7), limit = 150, seconds = 18 },
	team = { label = "Druzyna na druzyne", landing = Position(30370, 30018, 7), limit = 240, seconds = 40 },
	tour = { label = "Turniej", landing = Position(30400, 30018, 7), limit = 180, seconds = 40 },
}
local MODE_ORDER = { "duel", "waves", "team", "tour" }

local KV_POINTS = "ots-arena-points"
local KV_DPS = "ots-arena-dps"
local KV_DUEL = "ots-arena-duel-streak"
local KV_TEAM = "ots-arena-team-streak"

local SHOP = {
	{ label = "50 Tibia Coins", price = 30, coins = 50 },
	{ label = "upgrade stone", price = 40, item = 20139, count = 1 },
	{ label = "exalted core", price = 60, item = 37110, count = 1 },
	{ label = "blessed upgrade stone", price = 200, item = 20138, count = 1 },
	{ label = "bag you desire", price = 300, item = 34109, count = 1 },
	{ label = "fast exp token", price = 1500, item = 60106, count = 1 },
}

-- ---------------------------------------------------------------------------------------------
-- Profesje NPC. Obrazenia w % maksymalnego zycia celu (przy sile 1.0).
-- area: promien wokol NPC (self) albo wokol celu; heal: % wlasnego zycia; budzet leczenia ograniczony.
local PHYS, HOLY, FIRE, ENERGY, ICE, DEATH, EARTH = COMBAT_PHYSICALDAMAGE, COMBAT_HOLYDAMAGE, COMBAT_FIREDAMAGE, COMBAT_ENERGYDAMAGE, COMBAT_ICEDAMAGE, COMBAT_DEATHDAMAGE, COMBAT_EARTHDAMAGE
-- Profesje NPC - zawsze najlepsze czary, runy i potiony (jak gracz na PvP).
-- Liczby obrazen: 12 = jeden sredni cios najmocniejszego czaru postaci-lustra.
-- support = runy/czary wsparcia (bomby, magic wall, paraliz, buffy) - osobne opoznienie od atakow.
-- heal: czar leczacy (co 1 s), emergency: najmocniejsze leczenie z dlugim czasem odnowienia,
-- potion: health potion (co 1 s, % zycia), manaPotion: mana potion magow (% many).
local VOC = {
	knight = {
		label = "Knight", short = "EK", looks = { 131, 139 }, range = 1, push = true,
		attack = { type = PHYS, min = 2, max = 3, effect = CONST_ME_DRAWBLOOD },
		spells = {
			{ words = "utito tempo", support = true, buff = 10000, cd = 30, effect = CONST_ME_MAGIC_RED },
			{ words = "exori gran", self = true, area = 1, type = PHYS, min = 11, max = 15, cd = 6, effect = CONST_ME_HITAREA },
			{ words = "exori hur", type = PHYS, min = 9, max = 12, cd = 6, shoot = CONST_ANI_WHIRLWINDSWORD, effect = CONST_ME_DRAWBLOOD },
			{ words = "exori min", wave = 2, type = PHYS, min = 9, max = 12, cd = 6, effect = CONST_ME_HITAREA },
			{ words = "exori ico", type = PHYS, min = 8, max = 11, cd = 4, effect = CONST_ME_DRAWBLOOD },
			{ words = "exori ultima", lowWords = "exori mas", self = true, area = 4, type = PHYS, min = 10, max = 14, cd = 1, effect = CONST_ME_EXPLOSIONAREA },
		},
		heal = { words = "exura med ico", pct = 15, below = 85 },
		emergency = { words = "exura gran ico", pct = 40, below = 40, cd = 30 },
		potion = { name = "supreme health potion", pct = 14, below = 92 },
	},
	paladin = {
		label = "Paladin", short = "RP", looks = { 129, 137 }, range = 4, push = true,
		attack = { type = PHYS, min = 2, max = 3, shoot = CONST_ANI_ETHEREALSPEAR, effect = CONST_ME_DRAWBLOOD },
		spells = {
			{ words = "utito tempo san", support = true, buff = 10000, cd = 30, effect = CONST_ME_MAGIC_RED },
			{ rune = "magic wall rune", support = true, mwall = true, cd = 15 },
			{ words = "exevo mas san", self = true, area = 3, type = HOLY, min = 10, max = 14, cd = 6, effect = CONST_ME_HOLYAREA },
			{ words = "exori gran con", type = PHYS, min = 10, max = 14, cd = 8, shoot = CONST_ANI_ETHEREALSPEAR, effect = CONST_ME_DRAWBLOOD },
			{ words = "exori san", type = HOLY, min = 8, max = 11, cd = 2, shoot = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYDAMAGE },
			{ words = "exevo ultima san", lowWords = "exevo mas san", self = true, area = 4, type = HOLY, min = 10, max = 14, cd = 1, effect = CONST_ME_HOLYAREA },
		},
		heal = { words = "exura gran san", pct = 20, below = 85 },
		potion = { name = "ultimate spirit potion", pct = 11, below = 92 },
	},
	sorcerer = {
		label = "Sorcerer", short = "MS", looks = { 130, 138 }, range = 4, utamo = true, push = true,
		attack = { type = ENERGY, min = 2, max = 3, shoot = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT },
		spells = {
			{ rune = "magic wall rune", support = true, mwall = true, cd = 15 },
			{ rune = "energy bomb rune", support = true, field = 2122, type = ENERGY, cd = 10, shoot = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT },
			{ words = "exevo gran mas vis", self = true, area = 5, type = ENERGY, min = 13, max = 18, cd = 20, effect = CONST_ME_BIGCLOUDS },
			{ words = "exori max vis", type = ENERGY, min = 12, max = 16, cd = 8, effect = CONST_ME_ENERGYAREA },
			{ words = "utori mort", dot = 5, type = DEATH, cd = 12, effect = CONST_ME_SMALLCLOUDS },
			{ words = "exevo vis hur", wave = 5, type = ENERGY, min = 10, max = 14, cd = 6, effect = CONST_ME_ENERGYAREA },
			{ rune = "sudden death rune", type = DEATH, min = 9, max = 13, cd = 2, shoot = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA },
			{ words = "exevo ultima flam", lowWords = "exevo gran mas flam", self = true, area = 4, type = FIRE, min = 10, max = 14, cd = 1, effect = CONST_ME_FIREAREA },
		},
		heal = { words = "exura max vita", pct = 25, below = 70 },
		potion = { name = "ultimate health potion", pct = 8, below = 50 },
		manaPotion = { name = "ultimate mana potion", pct = 13, below = 92 },
	},
	druid = {
		label = "Druid", short = "ED", looks = { 144, 148 }, range = 4, utamo = true, push = true,
		attack = { type = ICE, min = 2, max = 3, shoot = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK },
		spells = {
			{ words = "adana ani", support = true, paralyze = 4000, cd = 10, effect = CONST_ME_STUN },
			{ rune = "magic wall rune", support = true, mwall = true, cd = 15 },
			{ rune = "fire bomb rune", support = true, field = 2120, type = FIRE, cd = 10, shoot = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE },
			{ words = "exevo gran mas frigo", self = true, area = 5, type = ICE, min = 13, max = 18, cd = 20, effect = CONST_ME_ICETORNADO },
			{ words = "exori max frigo", type = ICE, min = 12, max = 16, cd = 8, effect = CONST_ME_ICEATTACK },
			{ words = "utori pox", dot = 5, type = EARTH, cd = 12, effect = CONST_ME_SMALLPLANTS },
			{ words = "exevo frigo hur", wave = 5, type = ICE, min = 10, max = 14, cd = 6, effect = CONST_ME_ICEATTACK },
			{ rune = "avalanche rune", area = 1, type = ICE, min = 9, max = 13, cd = 2, shoot = CONST_ANI_ICE, effect = CONST_ME_ICEAREA },
			{ words = "exevo ultima frigo", lowWords = "exevo gran mas frigo", self = true, area = 4, type = ICE, min = 10, max = 14, cd = 1, effect = CONST_ME_ICETORNADO },
		},
		heal = { words = "exura max vita", pct = 30, below = 70 },
		potion = { name = "ultimate health potion", pct = 8, below = 50 },
		manaPotion = { name = "ultimate mana potion", pct = 13, below = 92 },
		allyHeal = { words = "exura gran sio", pct = 30, below = 70 },
	},
	monk = {
		label = "Monk", short = "EM", looks = { 1824, 1825 }, range = 1, push = true,
		attack = { type = PHYS, min = 2, max = 3, effect = CONST_ME_DRAWBLOOD },
		spells = {
			{ words = "utito tempo", support = true, buff = 10000, cd = 30, effect = CONST_ME_MAGIC_RED },
			{ words = "exori mas nia", self = true, area = 1, type = PHYS, min = 11, max = 15, cd = 6, effect = CONST_ME_GROUNDSHAKER },
			{ words = "exori gran nia", wave = 3, type = PHYS, min = 9, max = 13, cd = 6, effect = CONST_ME_HITAREA },
			{ words = "exori nia", type = PHYS, min = 8, max = 12, cd = 2, effect = CONST_ME_HITAREA },
			{ words = "exori ultima nia", lowWords = "exori mas nia", self = true, area = 4, type = PHYS, min = 10, max = 14, cd = 1, effect = CONST_ME_GROUNDSHAKER },
		},
		heal = { words = "exura gran tio", pct = 18, below = 85 },
		emergency = { words = "exura med tio", pct = 35, below = 40, cd = 30 },
		potion = { name = "supreme health potion", pct = 14, below = 92 },
	},
}
local VOC_ORDER = { "knight", "paladin", "sorcerer", "druid", "monk" }

local NAMES = {
	{ "Bartek" }, { "Kuba" }, { "Zbyszek" }, { "Mirek" }, { "Wojtek" }, { "Rafal" }, { "Tomek" }, { "Piotrek" },
	{ "Grzesiek" }, { "Darek" }, { "Seba" }, { "Krystian" }, { "Janusz" }, { "Mariusz" }, { "Adrian" }, { "Patryk" },
	{ "Gosia", true }, { "Ola", true }, { "Marta", true }, { "Kasia", true }, { "Ania", true }, { "Ewa", true },
	{ "Magda", true }, { "Halina", true }, { "Zuzia", true }, { "Natalia", true },
}
local PREFIXES = { "", "", "", "Sir ", "Dark ", "Mroczny ", "Lord ", "Wielki " }

-- ---------------------------------------------------------------------------------------------
-- typy potworow: osobny typ na kazde imie (silnik szuka typu potwora po jego imieniu - np. przy
-- krytykach i charmach - wiec zmiana imienia w trakcie gry psula obrazenia i spamowala bledami)
local function registerFighter(name, lookType)
	local mType = Game.createMonsterType(name)
	local m = {}
	m.name = name
	m.description = name
	m.experience = 0
	m.outfit = { lookType = lookType, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 3, lookMount = 0 }
	m.health = 1000
	m.maxHealth = 1000
	m.race = "blood"
	m.corpse = 0
	m.speed = 220
	m.manaCost = 0
	m.changeTarget = { interval = 4000, chance = 0 }
	m.strategiesTarget = { nearest = 100 }
	m.flags = {
		summonable = false, attackable = true, hostile = true, convinceable = false, pushable = false,
		rewardBoss = false, illusionable = false, canPushItems = true, canPushCreatures = false,
		staticAttackChance = 90, targetDistance = 1, runHealth = 0, healthHidden = false, isBlockable = false,
		canWalkOnEnergy = true, canWalkOnFire = true, canWalkOnPoison = true, isForgeCreature = false,
	}
	m.light = { level = 0, color = 0 }
	m.voices = { interval = 5000, chance = 0 }
	m.loot = {}
	m.defenses = { defense = 0, armor = 0, mitigation = 0 }
	m.elements = {
		{ type = COMBAT_PHYSICALDAMAGE, percent = 0 }, { type = COMBAT_ENERGYDAMAGE, percent = 0 },
		{ type = COMBAT_EARTHDAMAGE, percent = 0 }, { type = COMBAT_FIREDAMAGE, percent = 0 },
		{ type = COMBAT_LIFEDRAIN, percent = 0 }, { type = COMBAT_MANADRAIN, percent = 0 },
		{ type = COMBAT_DROWNDAMAGE, percent = 0 }, { type = COMBAT_ICEDAMAGE, percent = 0 },
		{ type = COMBAT_HOLYDAMAGE, percent = 0 }, { type = COMBAT_DEATHDAMAGE, percent = 0 },
	}
	m.immunities = {
		{ type = "invisible", condition = true }, { type = "drunk", condition = true }, { type = "outfit", condition = true },
	}
	mType:register(m)
end

local fighterNames = {} -- pelne imie -> true
local function fighterName(base, voc)
	return string.format("%s [%s]", base, VOC[voc].short)
end

for _, voc in ipairs(VOC_ORDER) do
	for _, entry in ipairs(NAMES) do
		for _, prefix in ipairs(PREFIXES) do
			local name = fighterName(prefix .. entry[1], voc)
			if not fighterNames[name] then
				fighterNames[name] = true
				registerFighter(name, VOC[voc].looks[entry[2] and 2 or 1])
			end
		end
	end
	registerFighter(fighterName("Mistrz Areny", voc), VOC[voc].looks[1])
	fighterNames[fighterName("Mistrz Areny", voc)] = true
end

OtsNoElite = OtsNoElite or {}

-- ---------------------------------------------------------------------------------------------
local runs = {} -- tryb -> bieg
local playerMode = {} -- id gracza -> tryb (sala, w ktorej jest uczestnikiem)
local fighters = {} -- id NPC -> dane (wspolne dla wszystkich sal)

local function dist(a, b)
	return math.max(math.abs(a.x - b.x), math.abs(a.y - b.y))
end

local function roomBounds(mode)
	local l, b = ROOMS[mode].landing, OtsRoomBounds
	return { minX = l.x + b.minDx, maxX = l.x + b.maxDx, minY = l.y + b.minDy, maxY = l.y + b.maxDy, z = l.z }
end

local function inRoom(mode, pos)
	local r = roomBounds(mode)
	return pos.z == r.z and pos.x >= r.minX - 1 and pos.x <= r.maxX + 1 and pos.y >= r.minY - 3 and pos.y <= r.maxY + 2
end

local function vocKey(player)
	local name = player:getVocation():getName():lower()
	for _, key in ipairs(VOC_ORDER) do
		if name:find(key, 1, true) then
			return key
		end
	end
	return VOC_ORDER[math.random(#VOC_ORDER)]
end

local function getNum(player, key)
	return tonumber(player:kv():get(key)) or 0
end

local function setNum(player, key, value)
	player:kv():set(key, value)
end

-- ---------- ranking ----------
local function board()
	local ok, b = pcall(function()
		return kv.scoped("ots-arena"):get("board")
	end)
	return (ok and type(b) == "table") and b or {}
end

local function record(player, field, value, add)
	local b = board()
	local name = player:getName()
	local row = type(b[name]) == "table" and b[name] or {}
	local old = tonumber(row[field]) or 0
	row[field] = add and (old + value) or math.max(old, value)
	b[name] = row
	pcall(function()
		kv.scoped("ots-arena"):set("board", b)
	end)
	return add or value > old
end

local function addPoints(player, amount)
	if amount <= 0 then
		return
	end
	setNum(player, KV_POINTS, getNum(player, KV_POINTS) + amount)
	record(player, "points", amount, true)
end

-- ---------- sila postaci ----------
local function baseDps(player)
	local skill = player:getMagicLevel()
	for _, s in ipairs({ SKILL_SWORD, SKILL_AXE, SKILL_CLUB, SKILL_DISTANCE, SKILL_FIST }) do
		skill = math.max(skill, player:getSkillLevel(s) or 0)
	end
	local hit = (player:getLevel() * 0.325 + skill * 3) * 5 * 3
	return math.max(50, hit / 2)
end

-- sredni cios najmocniejszego czaru postaci (wzor ultima z !czary, x3 wzmocnienie czarow graczy);
-- przed 4500 poziomem (bez ultimy) 60% tego
local function mirrorHit(player)
	local level, magic = player:getLevel(), player:getMagicLevel()
	local avg = ((level * 0.25 + magic * 2) + (level * 0.4 + magic * 4)) / 2 * 5 * 3
	if level < 4500 then
		avg = avg * 0.6
	end
	return math.max(20, avg)
end

local function dpsOf(player)
	local v = getNum(player, KV_DPS)
	return v > 0 and v or baseDps(player)
end

-- po walce: srednia z tego, ile postac naprawde zadawala na sekunde (wolno zmienia sie w obie strony)
local function calibrate(run)
	local seconds = os.time() - (run.fightStart or os.time())
	if seconds < 6 then
		return
	end
	for pid, dealt in pairs(run.dealt) do
		local player = Player(pid)
		if player and dealt > 0 then
			local old = dpsOf(player)
			local measured = dealt / seconds
			local new = math.max(old * 0.5, math.min(old * 3, old * 0.3 + measured * 0.7))
			setNum(player, KV_DPS, math.floor(new))
		end
	end
end

-- ---------- uczestnicy ----------
local function tell(run, text, kind)
	for pid in pairs(run.players) do
		local player = Player(pid)
		if player then
			player:sendTextMessage(kind or MESSAGE_EVENT_ADVANCE, text)
		end
	end
end

local function aliveCount(run)
	local n = 0
	for pid in pairs(run.alive) do
		local player = Player(pid)
		if player and inRoom(run.mode, player:getPosition()) then
			n = n + 1
		else
			run.alive[pid] = nil
			if not player or not inRoom(run.mode, player:getPosition()) then
				run.left = true
			end
		end
	end
	return n
end

local function restore(player)
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	for _, c in ipairs({ CONDITION_PARALYZE, CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_BLEEDING, CONDITION_FREEZING, CONDITION_DAZZLED, CONDITION_CURSED, CONDITION_FEARED }) do
		player:removeCondition(c)
	end
end

-- ---------- NPC ----------
local function clearFighters(run)
	for id in pairs(run.fighters) do
		fighters[id] = nil
		OtsNoElite[id] = nil
		local creature = Creature(id)
		if creature then
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			creature:remove()
		end
	end
	run.fighters = {}
end

local function randomName(voc)
	local entry = NAMES[math.random(#NAMES)]
	local prefix = PREFIXES[math.random(#PREFIXES)]
	return fighterName(prefix .. entry[1], voc), entry[2] == true
end

local function stagingPos(mode)
	local l = ROOMS[mode].landing
	return Position(l.x, l.y + STAGING_DY, l.z)
end

local function spawnSpot(mode, index)
	local l = ROOMS[mode].landing
	local offsets = { 0, -3, 3, -6, 6, -1, 2, -4, 5, 1 }
	local dx = offsets[(index - 1) % #offsets + 1]
	local dy = -7 + math.floor((index - 1) / #offsets)
	local pos = Position(l.x + dx, l.y + dy, l.z)
	if OtsIsSpotFree(pos) then
		return pos
	end
	for _ = 1, 20 do
		local r = roomBounds(mode)
		local try = Position(math.random(r.minX, r.maxX), math.random(r.minY, r.minY + 4), r.z)
		if OtsIsSpotFree(try) then
			return try
		end
	end
	return pos
end

-- spec: voc, hp, dmg (mnoznik obrazen), prefer (id gracza), title (zamiast losowego imienia), skull
local function spawnFighter(run, spec, index)
	local voc = VOC[spec.voc]
	local name = randomName(spec.voc)
	if spec.fullName then
		name = spec.fullName
	elseif spec.title then
		name = fighterName(spec.title, spec.voc)
	end
	local monster = Game.createMonster(name, stagingPos(run.mode), true, true)
	if not monster then
		return nil
	end
	monster:setOutfit({ lookType = monster:getOutfit().lookType, lookHead = math.random(0, 132), lookBody = math.random(0, 132), lookLegs = math.random(0, 132), lookFeet = math.random(0, 132), lookAddons = 3 })
	local hp = math.max(100, math.floor(spec.hp))
	monster:setMaxHealth(hp)
	monster:setHealth(hp)
	if spec.skull then
		monster:setSkull(spec.skull)
	end
	monster:registerEvent("OtsArenaFighterHealth")
	logger.info("[OTS arena npc] {}: zycie {}/{} (cel {}), sila ciosu {}", name, monster:getHealth(), monster:getMaxHealth(), hp, math.floor(spec.base or 0))
	monster:changeTargetDistance(voc.range, 24 * 60 * 60 * 1000)
	local id = monster:getId()
	OtsNoElite[id] = true
	local data = {
		id = id, voc = spec.voc, mode = run.mode, token = run.token, dmg = spec.dmg or 1, prefer = spec.prefer,
		base = spec.base or 100, level = spec.level or 0, cds = {}, nextSpell = 0, nextAttack = 0, nextHeal = 0, healLeft = hp * HEAL_BUDGET, utamoUntil = 0, utamoReady = 0, mana = 0, maxMana = 0, shield = false,
		fleeUntil = 0, fleeReady = 0, name = name,
	}
	if voc.utamo then
		-- mana jak u postaci-lustra (w proporcji do zycia, np. slabsze NPC w falach maja mniej)
		local mirror = Player(spec.prefer or run.starter)
		local ratio = mirror and mirror:getMaxHealth() > 0 and hp / mirror:getMaxHealth() or 1
		data.maxMana = math.floor((mirror and mirror:getMaxMana() or hp) * ratio)
		data.mana = data.maxMana
		data.shield = true
	end
	fighters[id] = data
	run.fighters[id] = true
	monster:teleportTo(spawnSpot(run.mode, index or 1), true)
	monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	-- szybkosc jak postac, ktora ma zaatakowac
	local ref = spec.prefer and Player(spec.prefer)
	if ref then
		-- utani gran hur: szybkosc jak postac z haste (albo jej aktualna, jesli wieksza)
		local speed = math.max(ref:getSpeed(), math.floor(ref:getBaseSpeed() * 1.7))
		monster:changeSpeed(speed - monster:getSpeed())
	end
	return monster
end

local function attackable(player)
	local tile = Tile(player:getPosition())
	return tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE)
end

local function pickTarget(run, monster, data)
	-- druzyna: wszyscy bija jeden cel (najslabszego), jak gracze na filmikach
	local focus = run.focus and run.alive[run.focus] and Player(run.focus)
	if focus and attackable(focus) then
		return focus
	end
	local pref = data.prefer and run.alive[data.prefer] and Player(data.prefer)
	if pref and attackable(pref) then
		return pref
	end
	local best, bd
	for pid in pairs(run.alive) do
		local player = Player(pid)
		if player and attackable(player) then
			local d = dist(monster:getPosition(), player:getPosition())
			if not bd or d < bd then
				best, bd = player, d
			end
		end
	end
	return best
end

-- Ochrona postaci (absorb z ekwipunku) zmniejszalaby ciosy NPC, a jej ciosy w NPC nie sa niczym zmniejszane.
-- Zeby lustro bilo tak samo mocno jak postac, mierzymy, ile z ciosu NPC naprawde dochodzi, i NPC to nadrabia.
local pendingHit = {} -- id gracza -> obrazenia ciosu NPC przed ochrona (na czas jednego ciosu)
local protection = {} -- id gracza -> jaka czesc ciosu dochodzi (1 = brak ochrony)

-- PRAWDZIWA sila postaci: srednia z jej mocnych ciosow w NPC (z krytykami, ekwipunkiem, Wheel itd.),
-- zapamietywana na stale. Lustro bije co najmniej tak mocno, jak postac naprawde bije.
local KV_HIT = "ots-arena-hit"
local realHits = {}

local function realHit(player)
	local pid = player:getId()
	if realHits[pid] == nil then
		realHits[pid] = tonumber(player:kv():get(KV_HIT)) or 0
	end
	return realHits[pid]
end

local function learnHit(player, raw)
	local known = realHit(player)
	local floor = mirrorHit(player) * 0.2 -- drobne ciosy (zwykly atak, slabe czary) pomijamy
	if raw < floor or raw < known * 0.3 then
		return
	end
	realHits[player:getId()] = known > 0 and (known * 0.8 + raw * 0.2) or raw
end

local function saveHits(run)
	for pid in pairs(run.players) do
		local player = Player(pid)
		if player and realHits[pid] and realHits[pid] > 0 then
			player:kv():set(KV_HIT, math.floor(realHits[pid]))
		end
	end
end

local function hit(monster, target, data, spell)
	local max = target:getMaxHealth()
	local base = math.max(data.base, target:isPlayer() and realHit(target) or 0)
	-- wartosci w tabelach profesji: 12 = jeden sredni cios najmocniejszego czaru postaci-lustra
	local run0 = runs[data.mode]
	local buffed = data.buffUntil and run0 and (run0.clock or 0) < data.buffUntil
	local unit = base * PVP * data.dmg / 12 * (buffed and 1.2 or 1) * NPC_POWER
	local cap = max * MAX_HIT / 100
	local low = math.floor(math.min(cap, unit * spell.min))
	local high = math.floor(math.min(cap, unit * spell.max))
	if spell.shoot then
		monster:getPosition():sendDistanceEffect(target:getPosition(), spell.shoot)
	end
	local tid = target:getId()
	local value = math.random(math.max(1, low), math.max(1, high))
	value = math.floor(math.min(cap / math.max(0.05, protection[tid] or 1), value / math.max(0.05, protection[tid] or 1)))
	pendingHit[tid] = value
	local run = runs[data.mode]
	if run and run.stats then
		run.stats.nominal = run.stats.nominal + value
	end
	doTargetCombatHealth(monster:getId(), target, spell.type, -value, -value, spell.effect or CONST_ME_NONE, ORIGIN_SPELL)
	pendingHit[tid] = nil
end

local FIELD_SECONDS = 8 -- pola z bomb (ogien, energia) znikaja po tylu sekundach
local WALL_SECONDS = 12 -- magic wall
local MAGIC_WALL = 2128

local function walkable(pos)
	local tile = Tile(pos)
	return tile and tile:getGround() and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and tile:getCreatureCount() == 0
		and not tile:hasProperty(CONST_PROP_BLOCKSOLID) and not tile:getItemById(MAGIC_WALL)
end

local function removeItemAt(pos, itemId)
	local tile = Tile(pos)
	local item = tile and tile:getItemById(itemId)
	if item then
		item:remove()
	end
end

local function clearFields(run)
	for _, f in ipairs(run.fields or {}) do
		removeItemAt(f.pos, f.item)
	end
	run.fields = {}
end

-- kierunek fali: glowna os w strone celu
local function waveTiles(from, to, length)
	local dx, dy = to.x - from.x, to.y - from.y
	local ux, uy = 0, 0
	if math.abs(dx) >= math.abs(dy) then
		ux = dx >= 0 and 1 or -1
	else
		uy = dy >= 0 and 1 or -1
	end
	local tiles = {}
	for step = 1, length do
		local width = step == 1 and 0 or (step <= 3 and 1 or 2)
		for k = -width, width do
			tiles[#tiles + 1] = Position(from.x + ux * step + uy * k, from.y + uy * step + ux * k, from.z)
		end
	end
	return tiles
end

local function castSpell(run, monster, target, data, spell)
	local mpos = monster:getPosition()
	local tpos = target:getPosition()
	-- magic wall: miedzy celem a NPC (blokuje dojscie i strzaly), gdy cel jest blisko albo NPC jest ranny
	local wallPos
	if spell.mwall then
		local hpPct = monster:getHealth() * 100 / math.max(1, monster:getMaxHealth())
		if dist(mpos, tpos) > 3 and hpPct > 60 then
			return false
		end
		local sx = mpos.x > tpos.x and 1 or (mpos.x < tpos.x and -1 or 0)
		local sy = mpos.y > tpos.y and 1 or (mpos.y < tpos.y and -1 or 0)
		wallPos = Position(tpos.x + sx, tpos.y + sy, tpos.z)
		if (wallPos.x == mpos.x and wallPos.y == mpos.y) or not walkable(wallPos) then
			return false
		end
	end
	local words = (spell.lowWords and (data.level or 0) < 4500) and spell.lowWords or spell.words
	if words then
		monster:say(words, TALKTYPE_MONSTER_SAY)
	end
	if spell.buff then
		data.buffUntil = (run.clock or 0) + spell.buff
		mpos:sendMagicEffect(spell.effect)
		return true
	end
	if spell.dot then
		-- utori: obrazenia co sekunde przez kilka sekund
		run.dots = run.dots or {}
		run.dots[#run.dots + 1] = { target = target:getId(), owner = data.id, type = spell.type, left = spell.dot, next = (run.clock or 0) + 1000, effect = spell.effect }
		tpos:sendMagicEffect(spell.effect)
		return true
	end
	if wallPos then
		mpos:sendDistanceEffect(wallPos, CONST_ANI_ENERGY)
		local item = Game.createItem(MAGIC_WALL, 1, wallPos)
		if item then
			run.fields = run.fields or {}
			run.fields[#run.fields + 1] = { pos = wallPos, item = MAGIC_WALL, expire = (run.clock or 0) + WALL_SECONDS * 1000, wall = true }
		end
		return true
	end
	if spell.field then
		-- bomba: pola 3x3 pod celem; obrazenia co sekunde, gdy ktos na nich stoi (liczone w petli)
		mpos:sendDistanceEffect(tpos, spell.shoot or CONST_ANI_FIRE)
		run.fields = run.fields or {}
		for dx = -1, 1 do
			for dy = -1, 1 do
				local pos = Position(tpos.x + dx, tpos.y + dy, tpos.z)
				local tile = Tile(pos)
				if tile and tile:getGround() and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and not tile:hasProperty(CONST_PROP_BLOCKSOLID) and not tile:getItemById(spell.field) then
					local item = Game.createItem(spell.field, 1, pos)
					if item then
						run.fields[#run.fields + 1] = { pos = pos, item = spell.field, expire = (run.clock or 0) + FIELD_SECONDS * 1000, owner = data.id, type = spell.type, effect = spell.effect, next = {} }
					end
				end
			end
		end
		return true
	end
	if spell.wave then
		local plain = { type = spell.type, min = spell.min, max = spell.max, effect = CONST_ME_NONE }
		local hitIds = {}
		for _, pos in ipairs(waveTiles(mpos, tpos, spell.wave)) do
			pos:sendMagicEffect(spell.effect)
			local tile = Tile(pos)
			local creature = tile and tile:getTopCreature()
			if creature and creature:isPlayer() and run.alive[creature:getId()] and attackable(creature) and not hitIds[creature:getId()] then
				hitIds[creature:getId()] = true
				hit(monster, creature, data, plain)
			end
		end
		return true
	end
	if spell.paralyze then
		local condition = Condition(CONDITION_PARALYZE)
		condition:setParameter(CONDITION_PARAM_TICKS, spell.paralyze)
		condition:setFormula(-0.5, 0, -0.5, 0)
		target:addCondition(condition)
		target:getPosition():sendMagicEffect(spell.effect)
		return true
	end
	if spell.area then
		local center = spell.self and mpos or target:getPosition()
		if spell.self then
			for dx = -spell.area, spell.area do
				for dy = -spell.area, spell.area do
					if (dx * dx + dy * dy) <= spell.area * spell.area + 1 then
						Position(center.x + dx, center.y + dy, center.z):sendMagicEffect(spell.effect)
					end
				end
			end
		elseif spell.shoot then
			mpos:sendDistanceEffect(center, spell.shoot)
		end
		local plain = { type = spell.type, min = spell.min, max = spell.max, effect = spell.self and CONST_ME_NONE or spell.effect }
		for pid in pairs(run.alive) do
			local player = Player(pid)
			if player and attackable(player) and dist(center, player:getPosition()) <= spell.area then
				hit(monster, player, data, plain)
			end
		end
		return true
	end
	hit(monster, target, data, spell)
	return true
end

local function heal(monster, data, pct, words, effect)
	local amount = math.min(data.healLeft, math.floor(monster:getMaxHealth() * pct * NPC_HEAL / 100))
	if amount <= 0 then
		return false
	end
	data.healLeft = data.healLeft - amount
	local run = runs[data.mode]
	if run and run.stats then
		run.stats.healed = run.stats.healed + amount
	end
	if words then
		monster:say(words, TALKTYPE_MONSTER_SAY)
	end
	monster:addHealth(amount)
	monster:getPosition():sendMagicEffect(effect or CONST_ME_MAGIC_BLUE)
	return true
end

local function think(run, monster, data, now)
	local voc = VOC[data.voc]
	local hpPct = monster:getHealth() * 100 / math.max(1, monster:getMaxHealth())

	-- leczenie (jedna akcja na sekunde)
	if now >= data.nextHeal then
		local healed = false
		if voc.allyHeal then
			for otherId in pairs(run.fighters) do
				local other = Creature(otherId)
				if other and otherId ~= data.id and other:getHealth() * 100 / other:getMaxHealth() < voc.allyHeal.below and dist(other:getPosition(), monster:getPosition()) <= 6 then
					local amount = math.min(data.healLeft, math.floor(other:getMaxHealth() * voc.allyHeal.pct * NPC_HEAL / 100))
					if amount > 0 then
						data.healLeft = data.healLeft - amount
						monster:say(voc.allyHeal.words .. ' "' .. other:getName() .. '"', TALKTYPE_MONSTER_SAY)
						other:addHealth(amount)
						other:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
						healed = true
						break
					end
				end
			end
		end
		-- mag z utamo pije mana potiony (jego "zycie" to mana), a health potiony dopiero przy niskim zyciu
		local mp = voc.manaPotion
		if not healed and mp and data.maxMana > 0 and data.healLeft > 0 and data.mana < data.maxMana * mp.below / 100 and hpPct >= 50 then
			local amount = math.min(data.healLeft, math.floor(data.maxMana * mp.pct * NPC_HEAL / 100), data.maxMana - data.mana)
			if amount > 0 then
				data.healLeft = data.healLeft - amount
				data.mana = data.mana + amount
				monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				healed = true
			end
		end
		if not healed and voc.potion and hpPct < voc.potion.below then
			healed = heal(monster, data, voc.potion.pct, nil, CONST_ME_MAGIC_RED)
		end
		if healed then
			data.nextHeal = now + 1000
		end
	end

	-- czar leczacy: osobne opoznienie od czarow ataku (jak u gracza - moze leczyc i bic w tej samej sekundzie);
	-- najmocniejsze leczenie (exura gran ico itp.) przy niskim zyciu, z dlugim odnowieniem
	if voc.emergency and hpPct < voc.emergency.below and now >= (data.nextEmergency or 0) and heal(monster, data, voc.emergency.pct, voc.emergency.words) then
		data.nextEmergency = now + voc.emergency.cd * 1000
		data.nextHealSpell = now + SPELL_EXHAUST
	elseif now >= (data.nextHealSpell or 0) and voc.heal and hpPct < voc.heal.below and heal(monster, data, voc.heal.pct, voc.heal.words) then
		data.nextHealSpell = now + SPELL_EXHAUST
	end

	-- utamo vita (MS i ED): wlaczona od poczatku, a gdy mana spadnie do zera - wlaczana znowu po manie z potionow
	if voc.utamo and not data.shield and data.mana >= data.maxMana * 0.15 and now >= data.utamoReady then
		data.shield = true
		data.utamoReady = now + 2000
		monster:say("utamo vita", TALKTYPE_MONSTER_SAY)
		monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end

	-- ucieczka przy niskim zyciu
	if hpPct < 35 and now >= data.fleeReady then
		data.fleeReady = now + 12000
		data.fleeUntil = now + 3000
		monster:changeTargetDistance(8, 3000)
		monster:say("utani hur", TALKTYPE_MONSTER_SAY)
	elseif data.fleeUntil > 0 and now >= data.fleeUntil then
		data.fleeUntil = 0
		monster:changeTargetDistance(voc.range, 24 * 60 * 60 * 1000)
	end

	local target = pickTarget(run, monster, data)
	if not target then
		return
	end
	local current = monster:getTarget()
	if not current or current:getId() ~= target:getId() then
		monster:addTarget(target, true)
		monster:selectTarget(target)
	end
	local mpos, tpos = monster:getPosition(), target:getPosition()
	local d = dist(mpos, tpos)
	if mpos.z ~= tpos.z or not mpos:isSightClear(tpos) then
		return
	end
	local reach = voc.range == 1 and 1 or 6

	-- pchanie: stojac obok celu, NPC przesuwa go o kratke - najchetniej na pole z bomby
	if voc.push and d <= 1 and now >= (data.nextPush or 0) then
		data.nextPush = now + 6000
		local best
		for _, f in ipairs(run.fields or {}) do
			if not f.wall and dist(f.pos, tpos) == 1 and dist(f.pos, mpos) >= 1 and walkable(f.pos) then
				best = f.pos
				break
			end
		end
		if not best then
			local sx = tpos.x > mpos.x and 1 or (tpos.x < mpos.x and -1 or 0)
			local sy = tpos.y > mpos.y and 1 or (tpos.y < mpos.y and -1 or 0)
			local away = Position(tpos.x + sx, tpos.y + sy, tpos.z)
			if walkable(away) and inRoom(run.mode, away) then
				best = away
			end
		end
		if best then
			target:teleportTo(best, true)
		end
	end
	-- czar albo runa (wspolne opoznienie jak u graczy)
	if now >= data.nextSpell then
		for i, spell in ipairs(voc.spells) do
			if not spell.support then
				local ready = now >= (data.cds[i] or 0)
				local range = spell.wave and spell.wave or (spell.area and 6 or reach)
				local inRange = spell.self and d <= spell.area or (not spell.self and d <= range)
				if ready and inRange and castSpell(run, monster, target, data, spell) then
					data.cds[i] = now + spell.cd * 1000
					data.nextSpell = now + SPELL_EXHAUST
					break
				end
			end
		end
	end
	-- runy wsparcia (bomby, magic wall, paraliz) - osobne opoznienie 2 s
	if now >= (data.nextSupport or 0) then
		for i, spell in ipairs(voc.spells) do
			if spell.support and now >= (data.cds[i] or 0) and d <= 6 and castSpell(run, monster, target, data, spell) then
				data.cds[i] = now + spell.cd * 1000
				data.nextSupport = now + 2000
				break
			end
		end
	end

	-- zwykly atak (bron) co 2 s
	if now >= data.nextAttack and d <= reach then
		hit(monster, target, data, voc.attack)
		data.nextAttack = now + 2000
	end
end

-- ---------------------------------------------------------------------------------------------
-- przebieg walki
local loop
local openMenu, openDuel

local function newRun(mode, starter)
	local old = runs[mode]
	local run = {
		mode = mode, token = (old and old.token or 0) + 1, starter = starter:getId(), players = {}, alive = {},
		fighters = {}, dealt = {}, phase = "idle", wave = 0, round = 0, bracket = nil,
	}
	if old then
		clearFighters(old)
	end
	runs[mode] = run
	return run
end

local function addPlayer(run, player)
	run.players[player:getId()] = true
	playerMode[player:getId()] = run.mode
	player:registerEvent("OtsArenaGuard")
end

local function prepareSegment(run)
	run.alive = {}
	run.dealt = {}
	run.stats = { nominal = 0, got = 0, healed = 0 }
	run.left = false
	for pid in pairs(run.players) do
		local player = Player(pid)
		if player and inRoom(run.mode, player:getPosition()) then
			run.alive[pid] = true
		end
	end
end

-- odliczanie, potem spawn(run) i walka
local function countdown(run, seconds, spawn)
	run.phase = "countdown"
	local token = run.token
	for i = seconds, 1, -1 do
		addEvent(function()
			local r = runs[run.mode]
			if r and r.token == token and r.phase == "countdown" then
				for pid in pairs(r.players) do
					local player = Player(pid)
					if player then
						player:say(tostring(i), TALKTYPE_MONSTER_SAY)
					end
				end
			end
		end, (seconds - i) * 1000)
	end
	addEvent(function()
		local r = runs[run.mode]
		if not r or r.token ~= token or r.phase ~= "countdown" then
			return
		end
		prepareSegment(r)
		if next(r.alive) == nil then
			r.phase = "idle"
			return
		end
		spawn(r)
		r.phase = "fight"
		r.fightStart = os.time()
		r.deadline = os.time() + ROOMS[r.mode].limit
		for id in pairs(r.fighters) do
			local creature = Creature(id)
			if creature then
				creature:say("Do boju!", TALKTYPE_MONSTER_SAY)
				break
			end
		end
		for id in pairs(r.fighters) do
			local creature = Creature(id)
			if creature then
				creature:say("utani gran hur", TALKTYPE_MONSTER_SAY)
				creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			end
		end
		addEvent(loop, TICK, r.mode, r.token)
	end, seconds * 1000)
end

local function scheduleMenu(run, delay)
	local pid = run.starter
	local mode = run.mode
	addEvent(function()
		local player = Player(pid)
		if player and inRoom(mode, player:getPosition()) then
			if mode == "duel" then
				openDuel(player)
			else
				openMenu(player)
			end
		end
	end, delay)
end

-- ---------- tryby ----------
local MODES = {}

-- POJEDYNEK
MODES.duel = {
	spawn = function(run)
		local player = Player(run.starter)
		local streak = getNum(player, KV_DUEL)
		local s = math.min(2.5, 1 + 0.05 * streak)
		run.strength = s
		local voc = run.duelVoc or VOC_ORDER[math.random(#VOC_ORDER)]
		local f = spawnFighter(run, { voc = voc, base = mirrorHit(player), level = player:getLevel(), hp = player:getMaxHealth(), dmg = s, prefer = player:getId() }, 1)
		if f then
			tell(run, string.format("Pojedynek: %s (sila %d%%, seria wygranych: %d).", f:getName(), math.floor(s * 100 + 0.5), streak))
		end
	end,
	win = function(run)
		local player = Player(run.starter)
		if not player then
			return
		end
		local streak = getNum(player, KV_DUEL) + 1
		setNum(player, KV_DUEL, streak)
		local pts = math.min(50, 10 + 2 * (streak - 1))
		addPoints(player, pts)
		local best = record(player, "duel", streak)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("WYGRANA! Seria pojedynkow: %d%s. +%d pkt areny (masz %d). Nastepny przeciwnik bedzie o 5%% mocniejszy.", streak, best and " (nowy rekord)" or "", pts, getNum(player, KV_POINTS)))
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
		run.phase = "idle"
		scheduleMenu(run, 2500)
	end,
	lose = function(run, why)
		local player = Player(run.starter)
		if player then
			local streak = getNum(player, KV_DUEL)
			setNum(player, KV_DUEL, 0)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Pojedynek przegrany (%s). Seria %d wygranych zakonczona - przeciwnicy wracaja do sily 100%%. Bez zadnej straty.", why, streak))
		end
		run.phase = "idle"
		scheduleMenu(run, 2500)
	end,
}

-- FALE
local function waveSize(n)
	return math.min(6, 1 + math.floor(n / 2))
end

MODES.waves = {
	spawn = function(run)
		local player = Player(run.starter)
		run.wave = run.wave + 1
		local n = run.wave
		local count = waveSize(n)
		local hpMult = math.min(1, 0.3 + 0.05 * n)
		local dmg = 0.45 + 0.04 * n
		for i = 1, count do
			spawnFighter(run, { voc = VOC_ORDER[math.random(#VOC_ORDER)], base = mirrorHit(player), level = player:getLevel(), hp = player:getMaxHealth() * hpMult, dmg = dmg, prefer = (i == 1) and player:getId() or nil }, i)
		end
		tell(run, string.format("Fala %d: %d %s (zycie %d%%, obrazenia %d%%).", n, count, count == 1 and "przeciwnik" or "przeciwnikow", math.floor(hpMult * 100 + 0.5), math.floor(dmg * 100 + 0.5)))
	end,
	win = function(run)
		local player = Player(run.starter)
		if not player then
			return
		end
		local pts = run.wave * 3
		addPoints(player, pts)
		local best = record(player, "waves", run.wave)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Fala %d pokonana%s! +%d pkt areny. Kolejna fala za 5 sekund (zycie nie jest odnawiane).", run.wave, best and " (nowy rekord)" or "", pts))
		countdown(run, 5, MODES.waves.spawn)
	end,
	lose = function(run, why)
		local player = Player(run.starter)
		if player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Koniec fal (%s). Wynik: %d %s pokonanych. Bez zadnej straty.", why, math.max(0, run.wave - 1), (run.wave - 1) == 1 and "fala" or "fal"))
		end
		run.phase = "idle"
		run.wave = 0
		scheduleMenu(run, 2500)
	end,
}

-- DRUZYNA
MODES.team = {
	spawn = function(run)
		local leader = Player(run.starter)
		local streak = getNum(leader, KV_TEAM)
		local s = math.min(2.5, 0.8 + 0.1 * streak)
		local members = {}
		for pid in pairs(run.alive) do
			members[#members + 1] = Player(pid)
		end
		local index = 0
		for _, member in ipairs(members) do
			index = index + 1
			spawnFighter(run, { voc = vocKey(member), base = mirrorHit(member), level = member:getLevel(), hp = member:getMaxHealth(), dmg = s, prefer = member:getId() }, index)
		end
		if #members == 1 then
			-- sam: druzyna 2 slabszych przeciwnikow
			index = index + 1
			spawnFighter(run, { voc = VOC_ORDER[math.random(#VOC_ORDER)], base = mirrorHit(leader), level = leader:getLevel(), hp = leader:getMaxHealth() * 0.6, dmg = (0.6 + 0.4 * s) * 0.6 }, index)
		end
		tell(run, string.format("Druzyna na druzyne: %d na %d (sila %d%%, seria wygranych: %d).", #members, index, math.floor(s * 100 + 0.5), streak))
	end,
	win = function(run)
		local leader = Player(run.starter)
		local streak = (leader and getNum(leader, KV_TEAM) or 0) + 1
		if leader then
			setNum(leader, KV_TEAM, streak)
		end
		local pts = 25 + 5 * (streak - 1)
		for pid in pairs(run.players) do
			local player = Player(pid)
			if player then
				addPoints(player, pts)
				record(player, "team", streak)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("DRUZYNA WYGRYWA! Seria: %d. +%d pkt areny. Kolejna druzyna NPC bedzie o 10%% mocniejsza.", streak, pts))
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
			end
		end
		run.phase = "idle"
		scheduleMenu(run, 2500)
	end,
	lose = function(run, why)
		local leader = Player(run.starter)
		local streak = leader and getNum(leader, KV_TEAM) or 0
		if leader then
			setNum(leader, KV_TEAM, 0)
		end
		tell(run, string.format("Druzyna przegrywa (%s). Seria %d wygranych zakonczona. Bez zadnej straty.", why, streak))
		run.phase = "idle"
		scheduleMenu(run, 2500)
	end,
}

-- TURNIEJ
local TOUR_ROUNDS = {
	{ label = "Cwiercfinal", strength = 0.9, pts = 10 },
	{ label = "Polfinal", strength = 1.1, pts = 20 },
	{ label = "Final", strength = 1.35, pts = 40, title = "Mistrz Areny", skull = SKULL_RED },
}
local CHAMPION_PTS = 100

MODES.tour = {
	spawn = function(run)
		local player = Player(run.starter)
		run.round = run.round + 1
		local round = TOUR_ROUNDS[run.round]
		local opponent = run.bracket[run.round]
		local s = round.strength
		spawnFighter(run, { voc = opponent.voc, fullName = opponent.name, base = mirrorHit(player), level = player:getLevel(), hp = player:getMaxHealth(), dmg = s, prefer = player:getId(), skull = round.skull }, 1)
		tell(run, string.format("TURNIEJ - %s: %s vs %s.", round.label, player:getName(), opponent.name))
	end,
	win = function(run)
		local player = Player(run.starter)
		if not player then
			return
		end
		local round = TOUR_ROUNDS[run.round]
		addPoints(player, round.pts)
		if run.round >= #TOUR_ROUNDS then
			addPoints(player, CHAMPION_PTS)
			record(player, "tour", 1, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("ZWYCIESTWO W TURNIEJU! Pokonales Mistrza Areny. +%d pkt areny (masz %d).", round.pts + CHAMPION_PTS, getNum(player, KV_POINTS)))
			Game.broadcastMessage(string.format("%s wygral Turniej Areny PvP!", player:getName()), MESSAGE_EVENT_ADVANCE)
			for _ = 1, 3 do
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
			end
			run.phase = "idle"
			run.round = 0
			scheduleMenu(run, 3000)
			return
		end
		restore(player)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s wygrany! +%d pkt areny. Zycie i mana odnowione - %s za 8 sekund.", round.label, round.pts, TOUR_ROUNDS[run.round + 1].label))
		countdown(run, 8, MODES.tour.spawn)
	end,
	lose = function(run, why)
		local player = Player(run.starter)
		if player then
			local round = TOUR_ROUNDS[run.round]
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Odpadasz z turnieju w etapie: %s (%s). Bez zadnej straty.", round and round.label or "-", why))
		end
		run.phase = "idle"
		run.round = 0
		scheduleMenu(run, 2500)
	end,
}

-- ---------- petla ----------
local function logFight(run, result)
	saveHits(run)
	clearFields(run)
	run.dots = {}
	run.focus = nil
	local st = run.stats or { nominal = 0, got = 0, healed = 0 }
	local dealt = 0
	for _, v in pairs(run.dealt) do
		dealt = dealt + v
	end
	local starter = Player(run.starter)
	logger.info("[OTS arena] {} {} ({}): {} s, ciosy NPC {} -> doszlo {} ({}%), postac zadala NPC {}, NPC wyleczyl {}, sredni mocny cios postaci {}, najnizsze zycie postaci {}%", run.mode, starter and starter:getName() or "?", result, os.time() - (run.fightStart or os.time()), math.floor(st.nominal), math.floor(st.got), st.nominal > 0 and math.floor(st.got * 100 / st.nominal) or 0, math.floor(dealt), math.floor(st.healed), starter and math.floor(realHit(starter)) or 0, math.floor((st.minPct or 1) * 100))
end

loop = function(mode, token)
	local run = runs[mode]
	if not run or run.token ~= token or run.phase ~= "fight" then
		return
	end
	run.clock = (run.clock or 0) + TICK -- zegar w ms (serwer nie ma zegara z milisekundami dla Lua)
	local now = run.clock
	-- druzyna: co 4 s wybor wspolnego celu - postac z najnizszym % zycia
	if mode == "team" and now >= (run.nextFocus or 0) then
		run.nextFocus = now + 4000
		local best, bp
		for pid in pairs(run.alive) do
			local player = Player(pid)
			if player and attackable(player) then
				local pct = player:getHealth() / math.max(1, player:getMaxHealth())
				if not bp or pct < bp then
					best, bp = pid, pct
				end
			end
		end
		run.focus = best
	end
	-- pola z bomb i magic walle
	if run.fields and #run.fields > 0 then
		local keep = {}
		for _, f in ipairs(run.fields) do
			if now >= f.expire then
				removeItemAt(f.pos, f.item)
			else
				keep[#keep + 1] = f
				local owner = f.owner and Monster(f.owner)
				local data = owner and fighters[f.owner]
				if data then
					local tile = Tile(f.pos)
					local creature = tile and tile:getTopCreature()
					if creature and creature:isPlayer() and run.alive[creature:getId()] and now >= (f.next[creature:getId()] or 0) then
						f.next[creature:getId()] = now + 1000
						hit(owner, creature, data, { type = f.type, min = 1.5, max = 2.5, effect = f.effect })
					end
				end
			end
		end
		run.fields = keep
	end
	if run.dots and #run.dots > 0 then
		local keep = {}
		for _, dot in ipairs(run.dots) do
			local owner = Monster(dot.owner)
			local data = owner and fighters[dot.owner]
			local target = Player(dot.target)
			if data and target and run.alive[dot.target] and dot.left > 0 then
				if now >= dot.next then
					dot.next = now + 1000
					dot.left = dot.left - 1
					if attackable(target) then
						hit(owner, target, data, { type = dot.type, min = 1.2, max = 1.8, effect = dot.effect })
					end
				end
				if dot.left > 0 then
					keep[#keep + 1] = dot
				end
			end
		end
		run.dots = keep
	end
	-- NPC
	local remaining = 0
	for id in pairs(run.fighters) do
		local monster = Monster(id)
		if monster and monster:getHealth() > 0 then
			remaining = remaining + 1
			if not inRoom(mode, monster:getPosition()) then
				monster:teleportTo(spawnSpot(mode, 1), true)
			end
			think(run, monster, fighters[id], now)
		else
			run.fighters[id] = nil
			fighters[id] = nil
			OtsNoElite[id] = nil
		end
	end
	local alive = aliveCount(run)
	if alive == 0 then
		clearFighters(run)
		calibrate(run)
		logFight(run, "przegrana")
		MODES[mode].lose(run, run.left and next(run.knocked or {}) == nil and "opusciles sale" or "wszyscy powaleni")
		run.knocked = {}
		return
	end
	if remaining == 0 then
		calibrate(run)
		run.knocked = {}
		logFight(run, "wygrana")
		MODES[mode].win(run)
		return
	end
	if os.time() >= run.deadline then
		clearFighters(run)
		calibrate(run)
		run.knocked = {}
		logFight(run, "czas")
		MODES[mode].lose(run, "minal czas")
		return
	end
	addEvent(loop, TICK, mode, token)
end

-- smiertelny cios w sali: zamiast smierci powrot do wejscia z pelnym zyciem
local function knockOut(pid, mode, token)
	local run = runs[mode]
	local player = Player(pid)
	if not player or not run or run.token ~= token or not run.alive[pid] then
		return
	end
	if player:getHealth() > 1 then
		return -- np. utamo vita przyjelo cios
	end
	run.alive[pid] = nil
	run.knocked = run.knocked or {}
	run.knocked[pid] = true
	restore(player)
	local from = player:getPosition()
	player:teleportTo(ROOMS[mode].landing, true)
	from:sendMagicEffect(CONST_ME_POFF)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Powalony! Na arenie nie ma smierci - wracasz do wejscia z pelnym zyciem.")
end

local guard = CreatureEvent("OtsArenaGuard")

-- w pojedynku, falach i turnieju walczy tylko ta postac, ktora zaczela - druzyna (np. boty, ktore
-- teleportuja sie do lidera) nie moze jej leczyc ani bic przeciwnikow
local function outsider(run, attacker)
	return run and run.mode ~= "team" and attacker and attacker:isPlayer() and attacker:getId() ~= run.starter
end

function guard.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType == COMBAT_HEALING and creature:isPlayer() then
		local mode = playerMode[creature:getId()]
		local run = mode and runs[mode]
		if run and run.phase == "fight" and run.alive[creature:getId()] and attacker and attacker:getId() ~= creature:getId() and outsider(run, attacker) then
			return 0, primaryType, 0, secondaryType
		end
	end
	if primaryType == COMBAT_HEALING or not creature:isPlayer() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local pid = creature:getId()
	local mode = playerMode[pid]
	local run = mode and runs[mode]
	if not run or run.phase ~= "fight" or not run.alive[pid] then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local total = math.abs(primaryDamage) + math.abs(secondaryDamage)
	local nominal = pendingHit[pid]
	if nominal and nominal > 0 then
		local ratio = math.max(0.05, math.min(1, total / nominal))
		protection[pid] = protection[pid] and (protection[pid] * 0.7 + ratio * 0.3) or ratio
		if run.stats then
			run.stats.got = run.stats.got + total
		end
	end
	local health = creature:getHealth()
	if run.stats then
		local left = math.max(0, health - total) / math.max(1, creature:getMaxHealth())
		run.stats.minPct = math.min(run.stats.minPct or 1, left)
	end
	if total >= health then
		local keep = math.max(0, health - 1)
		primaryDamage = primaryDamage < 0 and -keep or keep
		secondaryDamage = 0
		addEvent(knockOut, 0, pid, mode, run.token)
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

guard:register()

local fighterHealth = CreatureEvent("OtsArenaFighterHealth")

function fighterHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	local data = fighters[creature:getId()]
	if not data or primaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local run = runs[data.mode]
	local now = run and run.clock or 0
	if outsider(run, attacker) then
		if not run.warned then
			run.warned = true
			attacker:sendCancelMessage("To walka 1 na 1 - druzyna nie moze pomagac.")
		end
		return 0, primaryType, 0, secondaryType
	end
	if attacker and attacker:isPlayer() then
		learnHit(attacker, math.abs(primaryDamage) + math.abs(secondaryDamage))
		local factor = PVP
		primaryDamage = math.floor(primaryDamage * factor)
		secondaryDamage = math.floor(secondaryDamage * factor)
	end
	-- lustrzany limit: jeden cios postaci zabiera NPC najwyzej MAX_HIT % zycia (tak samo jak cios NPC postaci);
	-- krytyki i bonusy postaci potrafily zdjac lustro jednym strzalem
	do
		local total = math.abs(primaryDamage) + math.abs(secondaryDamage)
		local cap = creature:getMaxHealth() * MAX_HIT / 100
		if attacker and attacker:isPlayer() and total > cap then
			local k = cap / total
			primaryDamage = math.floor(primaryDamage * k)
			secondaryDamage = math.floor(secondaryDamage * k)
		end
	end
	-- utamo vita: obrazenia najpierw schodza z many
	if data.shield and data.mana > 0 then
		local total = math.abs(primaryDamage) + math.abs(secondaryDamage)
		local absorbed = math.min(total, data.mana)
		data.mana = data.mana - absorbed
		creature:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
		if data.mana <= 0 then
			data.shield = false
			data.mana = 0
		end
		local k = total > 0 and (total - absorbed) / total or 0
		primaryDamage = math.floor(primaryDamage * k)
		secondaryDamage = math.floor(secondaryDamage * k)
	end
	-- diagnostyka: kazdy cios, ktory zabiera NPC co najmniej 25% zycia
	local after = math.abs(primaryDamage) + math.abs(secondaryDamage)
	if after >= creature:getMaxHealth() * 0.25 then
		logger.info("[OTS arena cios] {} -> {}: {} (typ {}/{}, zrodlo {}), zycie NPC {}/{}", attacker and attacker:getName() or "?", creature:getName(), after, primaryType, secondaryType, origin, creature:getHealth(), creature:getMaxHealth())
	end
	if run and run.token == data.token and attacker and attacker:isPlayer() then
		local pid = attacker:getId()
		run.dealt[pid] = (run.dealt[pid] or 0) + math.min(creature:getHealth(), math.abs(primaryDamage) + math.abs(secondaryDamage))
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

fighterHealth:register()

-- ---------------------------------------------------------------------------------------------
-- wejscie i menu
local function busy(mode, player)
	local run = runs[mode]
	if run and run.phase ~= "idle" then
		for pid in pairs(run.players) do
			local other = Player(pid)
			if other and inRoom(mode, other:getPosition()) and pid ~= player:getId() then
				player:sendCancelMessage(ROOMS[mode].label .. ": sala jest teraz zajeta.")
				return true
			end
		end
		if run.players[player:getId()] then
			player:sendCancelMessage("Walka juz trwa.")
			return true
		end
	end
	return false
end

-- przenosi gracza (i w trybie druzyny cale party) do sali; zwraca bieg albo nil
local function enter(player, mode)
	if busy(mode, player) then
		return nil
	end
	local room = ROOMS[mode]
	local here = inRoom(mode, player:getPosition())
	if not here then
		if OtsInFight(player) then
			return nil
		end
		OtsTravel(player, "Arena PvP - " .. room.label, room.landing)
		if not inRoom(mode, player:getPosition()) then
			return nil
		end
	end
	local run = runs[mode]
	if not run or run.phase == "idle" then
		run = newRun(mode, player)
	end
	run.starter = player:getId()
	run.players = {}
	addPlayer(run, player)
	if mode == "team" then
		local party = player:getParty()
		if party then
			if party:getLeader():getId() ~= player:getId() then
				player:sendCancelMessage("Walke druzyn rozpoczyna lider party.")
				return nil
			end
			local index = 1
			local members = party:getMembers() or {}
			for _, member in ipairs(members) do
				if member and member:getId() ~= player:getId() then
					if not inRoom(mode, member:getPosition()) then
						index = index + 1
						local from = member:getPosition()
						local spot = Position(room.landing.x + ((index % 3) - 1), room.landing.y + (math.floor(index / 3) % 2 == 0 and 0 or 1), room.landing.z)
						member:teleportTo(spot)
						from:sendMagicEffect(CONST_ME_TELEPORT)
						member:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					end
					restore(member)
					addPlayer(run, member)
				end
			end
		end
	end
	for pid in pairs(run.players) do
		local p = Player(pid)
		if p then
			restore(p)
		end
	end
	return run
end

local function start(player, mode, opts)
	local run = enter(player, mode)
	if not run then
		return
	end
	opts = opts or {}
	run.token = run.token + 1
	run.duelVoc = opts.voc
	run.wave = 0
	run.round = 0
	run.knocked = {}
	if mode == "tour" then
		-- drabinka: 7 losowych zawodnikow, w finale Mistrz Areny
		local others = {}
		for i = 1, 7 do
			local voc = VOC_ORDER[math.random(#VOC_ORDER)]
			local name = randomName(voc)
			others[i] = { voc = voc, name = name }
		end
		local champVoc = VOC_ORDER[math.random(#VOC_ORDER)]
		others[7] = { voc = champVoc, title = "Mistrz Areny", name = string.format("Mistrz Areny [%s]", VOC[champVoc].short) }
		run.bracket = { others[1], others[3], others[7] }
		local lines = {
			"TURNIEJ ARENY - drabinka",
			"",
			string.format("Cwiercfinaly:  %s vs %s   |   %s vs %s", player:getName(), others[1].name, others[2].name, others[3].name),
			string.format("               %s vs %s   |   %s vs %s", others[4].name, others[5].name, others[6].name, others[7].name),
			"",
			string.format("Twoja droga: %s -> %s -> final: %s", others[1].name, others[3].name, others[7].name),
			"",
			"Miedzy walkami zycie i mana sa odnawiane. Nagrody: 10 / 20 / 40 pkt za etapy, +100 pkt za zwyciestwo.",
		}
		player:showTextDialog(2814, table.concat(lines, "\n"))
	end
	local labels = { duel = "Pojedynek", waves = "Fale", team = "Walka druzyn", tour = "Turniej" }
	tell(run, string.format("%s: walka za 3 sekundy! Przegrana nic nie kosztuje. Wyjscie: teleport przy wejsciu.", labels[mode]))
	countdown(run, 3, MODES[mode].spawn)
end

openDuel = function(player)
	local streak = getNum(player, KV_DUEL)
	local window = ModalWindow({ title = "Pojedynek 1 na 1", message = string.format("Wybierz profesje przeciwnika.\nSeria wygranych: %d (przeciwnik ma sile %d%%).\nWygrana: %d pkt areny. Przegrana: seria od zera, bez innej straty.", streak, math.floor(math.min(2.5, 1 + 0.05 * streak) * 100 + 0.5), math.min(50, 10 + 2 * streak)) })
	window:addChoice("Losowa profesja", function(target)
		start(target, "duel", {})
	end)
	for _, key in ipairs(VOC_ORDER) do
		window:addChoice(VOC[key].label, function(target)
			start(target, "duel", { voc = key })
		end)
	end
	window:addButton("Walcz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local function openShop(player)
	local points = getNum(player, KV_POINTS)
	local window = ModalWindow({ title = "Sklep Areny", message = string.format("Masz %d pkt areny.", points) })
	for _, entry in ipairs(SHOP) do
		window:addChoice(string.format("%s - %d pkt", entry.label, entry.price), function(target)
			local have = getNum(target, KV_POINTS)
			if have < entry.price then
				target:sendCancelMessage(string.format("Za malo punktow areny (masz %d, potrzeba %d).", have, entry.price))
				return
			end
			if entry.coins then
				target:addTibiaCoins(entry.coins)
			elseif not target:addItem(entry.item, entry.count) then
				target:sendCancelMessage("Brak miejsca w plecaku.")
				return
			end
			setNum(target, KV_POINTS, have - entry.price)
			target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			target:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Sklep Areny: %s. Zostalo %d pkt.", entry.label, have - entry.price))
			openShop(target)
		end)
	end
	window:addButton("Kup")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local function showRanking(player)
	local b = board()
	local lines = { "RANKING ARENY PvP", "" }
	local cats = {
		{ "duel", "Najdluzsza seria pojedynkow" },
		{ "waves", "Najwiecej fal (rekord)" },
		{ "team", "Najdluzsza seria druzyny" },
		{ "tour", "Wygrane turnieje" },
		{ "points", "Zdobyte punkty areny (lacznie)" },
	}
	for _, cat in ipairs(cats) do
		local list = {}
		for name, row in pairs(b) do
			local v = type(row) == "table" and tonumber(row[cat[1]]) or 0
			if v and v > 0 then
				list[#list + 1] = { name, v }
			end
		end
		table.sort(list, function(a, c)
			return a[2] > c[2]
		end)
		lines[#lines + 1] = cat[2] .. ":"
		if #list == 0 then
			lines[#lines + 1] = "   (brak wynikow)"
		end
		for i = 1, math.min(10, #list) do
			lines[#lines + 1] = string.format("  %d. %s - %d", i, list[i][1], list[i][2])
		end
		lines[#lines + 1] = ""
	end
	player:showTextDialog(2814, table.concat(lines, "\n"))
end

openMenu = function(player)
	local b = board()[player:getName()] or {}
	local message = string.format("Walki z NPC, ktore walcza jak gracze, dopasowane do twojej postaci. Przegrana nic nie kosztuje.\nPunkty areny: %d. Twoje rekordy: pojedynki %d, fale %d, druzyna %d, turnieje %d.", getNum(player, KV_POINTS), tonumber(b.duel) or 0, tonumber(b.waves) or 0, tonumber(b.team) or 0, tonumber(b.tour) or 0)
	local window = ModalWindow({ title = "Arena PvP", message = message })
	window:addChoice(string.format("Pojedynek 1 na 1 (seria: %d)", getNum(player, KV_DUEL)), function(target)
		openDuel(target)
	end)
	window:addChoice("Fale przeciwnikow (az padniesz)", function(target)
		start(target, "waves")
	end)
	window:addChoice(string.format("Druzyna na druzyne (z party, seria: %d)", getNum(player, KV_TEAM)), function(target)
		start(target, "team")
	end)
	window:addChoice("Turniej (3 walki, final z Mistrzem Areny)", function(target)
		start(target, "tour")
	end)
	window:addChoice(string.format("Sklep Areny (%d pkt)", getNum(player, KV_POINTS)), function(target)
		openShop(target)
	end)
	window:addChoice("Ranking", function(target)
		showRanking(target)
	end)
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

OtsArenaPvpMenu = function(player)
	openMenu(player)
end

local command = TalkAction("!arena")

function command.onSay(player, words, param)
	openMenu(player)
	return true
end

command:groupType("normal")
command:register()

-- po wylogowaniu w trakcie walki NPC znikaja (bez kary)
local logout = CreatureEvent("OtsArenaLogout")

function logout.onLogout(player)
	local mode = playerMode[player:getId()]
	local run = mode and runs[mode]
	if run and run.alive[player:getId()] then
		run.alive[player:getId()] = nil
		run.left = true
	end
	playerMode[player:getId()] = nil
	return true
end

logout:register()

local login = CreatureEvent("OtsArenaLogin")

function login.onLogin(player)
	player:registerEvent("OtsArenaLogout")
	player:registerEvent("OtsArenaGuard")
	return true
end

login:register()

-- ---------- budowa sal ----------
-- przeszkody w kazdej sali (przesuniecie od wejscia, przedmiot): wejscie 3x3 i rzad startowy NPC zostaja wolne
local PILLAR, MARBLE, BASIN, STATUE = 2152, 2153, 171, 2026
local OBSTACLES = {
	{ -5, -4, PILLAR }, { 5, -4, PILLAR }, { -2, -3, MARBLE }, { 2, -3, MARBLE },
	{ -3, -5, PILLAR }, { 3, -5, PILLAR }, { 0, -4, STATUE },
	{ -7, -2, BASIN }, { 6, -2, BASIN }, { -6, 1, PILLAR }, { 5, 1, PILLAR },
}

local startup = GlobalEvent("OtsArenaPvpStartup")

function startup.onStartup()
	local made = 0
	for _, mode in ipairs(MODE_ORDER) do
		local landing = ROOMS[mode].landing
		made = made + OtsBuildRoom(landing)
		OtsReturnSpot(landing)
		-- przeszkody: filary (zaslaniaja strzaly i droge), kosze z ogniem i posagi
		for _, o in ipairs(OBSTACLES) do
			local pos = Position(landing.x + o[1], landing.y + o[2], landing.z)
			local tile = Tile(pos)
			if tile and tile:getGround() and not tile:getItemById(o[3]) and not tile:hasProperty(CONST_PROP_BLOCKSOLID) then
				Game.createItem(o[3], 1, pos)
			end
		end
		-- poczekalnia NPC
		local s = stagingPos(mode)
		for dx = -4, 4 do
			for dy = -1, 1 do
				local pos = Position(s.x + dx, s.y + dy, s.z)
				local tile = Tile(pos) or Game.createTile(pos.x, pos.y, pos.z)
				if tile and not tile:getGround() then
					Game.createItem(FLOOR, 1, pos)
				end
			end
		end
	end
	logger.info("[OTS arena pvp] 4 sale gotowe (pol: {})", made)
	return true
end

startup:register()
