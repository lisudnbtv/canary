-- OTS: Arena PvP - walki z NPC, ktore wygladaja i walcza jak gracze (!tp > Arena PvP albo !arena).
-- Cztery osobne sale:
--  * Pojedynek 1 na 1 - wybierasz profesje przeciwnika, kazda wygrana z rzedu = przeciwnik +5% mocniejszy.
--  * Fale przeciwnikow - coraz wiecej i coraz mocniejszych "graczy", az padniesz.
--  * Druzyna na druzyne - twoje party (np. postacie z bota) przeciw lustrzanej druzynie NPC.
--  * Turniej - drabinka 8 zawodnikow: cwiercfinal, polfinal, final z Mistrzem Areny.
-- Przeciwnicy to LUSTRO postaci: tyle samo zycia, bija sila jej najmocniejszego czaru (polowa jak w PvP,
-- gracz tez zadaje im polowe), lecza sie potionami i czarami co sekunde jak gracz.
-- Lecza sie (exura, potiony - z ograniczonym zapasem), uzywaja utamo vita, czarow i run swojej profesji,
-- uciekaja przy niskim zyciu. Przegrana nic nie kosztuje: przy smiertelnym ciosie postac wraca do wejscia
-- z pelnym zyciem. Za wygrane: punkty areny (sklep areny) i ranking.

local FIGHTER_TYPE = "Arena Fighter"
local STAGING_DY = 32 -- poczekalnia NPC (poza zasiegiem wzroku) - tu dostaja imie, zanim wejda do sali
local FLOOR = 11285 -- podloga z sali Obrona
local TICK = 500
-- LUSTRO: NPC ma tyle zycia, co postac, i bije jej wlasna sila (sredni cios najmocniejszego czaru jak w !czary).
-- Jak w prawdziwym PvP obie strony zadaja sobie polowe obrazen (PVP).
local PVP = 0.5
local MAX_HIT = 45 -- jeden cios NPC zabiera najwyzej tyle % zycia celu
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
local VOC = {
	knight = {
		label = "Knight", short = "EK", looks = { 131, 139 }, range = 1,
		attack = { type = PHYS, min = 2, max = 3, effect = CONST_ME_DRAWBLOOD },
		spells = {
			{ words = "exori gran", self = true, area = 1, type = PHYS, min = 10, max = 15, cd = 8, effect = CONST_ME_HITAREA },
			{ words = "exori", self = true, area = 1, type = PHYS, min = 8, max = 12, cd = 4, effect = CONST_ME_HITAREA },
			{ words = "exori ico", type = PHYS, min = 7, max = 10, cd = 6, effect = CONST_ME_DRAWBLOOD },
			-- glowny czar (jak ultima postaci, co 1 s); przed 4500 poziomem slabszy odpowiednik
			{ words = "exori ultima", lowWords = "exori gran", self = true, area = 4, type = PHYS, min = 10, max = 14, cd = 1, effect = CONST_ME_EXPLOSIONAREA },
		},
		heal = { words = "exura med ico", pct = 15, below = 60 },
		potion = { pct = 11, below = 80 },
	},
	paladin = {
		label = "Paladin", short = "RP", looks = { 129, 137 }, range = 4,
		attack = { type = PHYS, min = 2, max = 3, shoot = CONST_ANI_ROYALSPEAR, effect = CONST_ME_DRAWBLOOD },
		spells = {
			{ words = "exevo mas san", self = true, area = 3, type = HOLY, min = 9, max = 13, cd = 8, effect = CONST_ME_HOLYAREA },
			{ words = "exori con", type = PHYS, min = 8, max = 12, cd = 6, shoot = CONST_ANI_ROYALSPEAR, effect = CONST_ME_DRAWBLOOD },
			{ words = "exori san", type = HOLY, min = 7, max = 11, cd = 2, shoot = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYDAMAGE },
			-- glowny czar (jak ultima postaci, co 1 s); przed 4500 poziomem slabszy odpowiednik
			{ words = "exevo ultima san", lowWords = "exevo mas san", self = true, area = 4, type = HOLY, min = 10, max = 14, cd = 1, effect = CONST_ME_HOLYAREA },
		},
		heal = { words = "exura gran san", pct = 18, below = 60 },
		potion = { pct = 8, below = 80 },
	},
	sorcerer = {
		label = "Sorcerer", short = "MS", looks = { 130, 138 }, range = 4, utamo = true,
		attack = { type = ENERGY, min = 2, max = 3, shoot = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT },
		spells = {
			{ words = "exevo gran mas flam", self = true, area = 5, type = FIRE, min = 12, max = 18, cd = 20, effect = CONST_ME_FIREAREA },
			{ rune = "sudden death rune", type = DEATH, min = 9, max = 13, cd = 2, shoot = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA },
			{ words = "exori vis", type = ENERGY, min = 7, max = 11, cd = 2, effect = CONST_ME_ENERGYAREA },
			-- glowny czar (jak ultima postaci, co 1 s); przed 4500 poziomem slabszy odpowiednik
			{ words = "exevo ultima flam", lowWords = "exevo gran mas flam", self = true, area = 4, type = FIRE, min = 10, max = 14, cd = 1, effect = CONST_ME_FIREAREA },
		},
		heal = { words = "exura vita", pct = 18, below = 60 },
		potion = { pct = 6, below = 80 },
	},
	druid = {
		label = "Druid", short = "ED", looks = { 144, 148 }, range = 4, utamo = true,
		attack = { type = ICE, min = 2, max = 3, shoot = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK },
		spells = {
			{ words = "exevo gran mas frigo", self = true, area = 5, type = ICE, min = 12, max = 18, cd = 20, effect = CONST_ME_ICETORNADO },
			{ words = "adana ani", paralyze = 3000, cd = 25, effect = CONST_ME_STUN },
			{ rune = "avalanche rune", area = 1, type = ICE, min = 8, max = 12, cd = 2, shoot = CONST_ANI_ICE, effect = CONST_ME_ICEAREA },
			{ words = "exori tera", type = EARTH, min = 7, max = 11, cd = 2, effect = CONST_ME_SMALLPLANTS },
			-- glowny czar (jak ultima postaci, co 1 s); przed 4500 poziomem slabszy odpowiednik
			{ words = "exevo ultima frigo", lowWords = "exevo gran mas frigo", self = true, area = 4, type = ICE, min = 10, max = 14, cd = 1, effect = CONST_ME_ICETORNADO },
		},
		heal = { words = "exura vita", pct = 25, below = 60 },
		potion = { pct = 6, below = 80 },
		allyHeal = { words = "exura sio", pct = 20, below = 50 },
	},
	monk = {
		label = "Monk", short = "EM", looks = { 1824, 1825 }, range = 1,
		attack = { type = PHYS, min = 2, max = 3, effect = CONST_ME_DRAWBLOOD },
		spells = {
			{ words = "exori mas nia", self = true, area = 1, type = PHYS, min = 10, max = 14, cd = 8, effect = CONST_ME_GROUNDSHAKER },
			{ words = "exori nia", type = PHYS, min = 8, max = 12, cd = 2, effect = CONST_ME_HITAREA },
			-- glowny czar (jak ultima postaci, co 1 s); przed 4500 poziomem slabszy odpowiednik
			{ words = "exori ultima nia", lowWords = "exori mas nia", self = true, area = 4, type = PHYS, min = 10, max = 14, cd = 1, effect = CONST_ME_GROUNDSHAKER },
		},
		heal = { words = "exura nia", pct = 15, below = 60 },
		potion = { pct = 11, below = 80 },
	},
}
local VOC_ORDER = { "knight", "paladin", "sorcerer", "druid", "monk" }

local NAMES = {
	{ "Bartek" }, { "Kuba" }, { "Zbyszek" }, { "Mirek" }, { "Wojtek" }, { "Rafal" }, { "Tomek" }, { "Piotrek" },
	{ "Grzesiek" }, { "Darek" }, { "Seba" }, { "Krystian" }, { "Janusz" }, { "Mariusz" }, { "Adrian" }, { "Patryk" },
	{ "Gosia", true }, { "Ola", true }, { "Marta", true }, { "Kasia", true }, { "Ania", true }, { "Ewa", true },
	{ "Magda", true }, { "Halina", true }, { "Zuzia", true }, { "Natalia", true },
}
local PREFIXES = { "", "", "", "Sir ", "Dark ", "Mroczny ", "Lord ", "Xx", "Wielki ", "Cichy " }

-- ---------------------------------------------------------------------------------------------
-- typ potwora (jeden dla wszystkich; imie, stroj i zycie ustawiane przy tworzeniu)
do
	local mType = Game.createMonsterType(FIGHTER_TYPE)
	local m = {}
	m.description = "an arena fighter"
	m.experience = 0
	m.outfit = { lookType = 131, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 3, lookMount = 0 }
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
	local name = prefix .. entry[1]
	if prefix == "Xx" then
		name = name .. "xX"
	end
	return string.format("%s [%s]", name, VOC[voc].short), entry[2] == true
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
	local monster = Game.createMonster(FIGHTER_TYPE, stagingPos(run.mode), true, true)
	if not monster then
		return nil
	end
	local name, female = randomName(spec.voc)
	if spec.fullName then
		name = spec.fullName
	elseif spec.title then
		name = string.format("%s [%s]", spec.title, voc.short)
	end
	monster:setName(name, name)
	local look = voc.looks[female and 2 or 1]
	monster:setOutfit({ lookType = look, lookHead = math.random(0, 132), lookBody = math.random(0, 132), lookLegs = math.random(0, 132), lookFeet = math.random(0, 132), lookAddons = 3 })
	local hp = math.max(100, math.floor(spec.hp))
	monster:setMaxHealth(hp)
	monster:setHealth(hp)
	if spec.skull then
		monster:setSkull(spec.skull)
	end
	monster:registerEvent("OtsArenaFighterHealth")
	monster:changeTargetDistance(voc.range, 24 * 60 * 60 * 1000)
	local id = monster:getId()
	OtsNoElite[id] = true
	local data = {
		id = id, voc = spec.voc, mode = run.mode, token = run.token, dmg = spec.dmg or 1, prefer = spec.prefer,
		base = spec.base or 100, level = spec.level or 0, cds = {}, nextSpell = 0, nextAttack = 0, nextHeal = 0, healLeft = hp * 1.5, utamoUntil = 0, utamoReady = 0,
		fleeUntil = 0, fleeReady = 0, name = name,
	}
	fighters[id] = data
	run.fighters[id] = true
	monster:teleportTo(spawnSpot(run.mode, index or 1), true)
	monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	-- szybkosc jak postac, ktora ma zaatakowac
	local ref = spec.prefer and Player(spec.prefer)
	if ref then
		monster:changeSpeed(ref:getSpeed() - monster:getSpeed())
	end
	return monster
end

local function attackable(player)
	local tile = Tile(player:getPosition())
	return tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE)
end

local function pickTarget(run, monster, data)
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

local function hit(monster, target, data, spell)
	local max = target:getMaxHealth()
	-- wartosci w tabelach profesji: 12 = jeden sredni cios najmocniejszego czaru postaci-lustra
	local unit = data.base * PVP * data.dmg / 12
	local cap = max * MAX_HIT / 100
	local low = math.floor(math.min(cap, unit * spell.min))
	local high = math.floor(math.min(cap, unit * spell.max))
	if spell.shoot then
		monster:getPosition():sendDistanceEffect(target:getPosition(), spell.shoot)
	end
	doTargetCombatHealth(monster:getId(), target, spell.type, -low, -high, spell.effect or CONST_ME_NONE, ORIGIN_SPELL)
end

local function castSpell(run, monster, target, data, spell)
	local mpos = monster:getPosition()
	local words = (spell.lowWords and (data.level or 0) < 4500) and spell.lowWords or spell.words
	if words then
		monster:say(words, TALKTYPE_MONSTER_SAY)
	end
	if spell.paralyze then
		local condition = Condition(CONDITION_PARALYZE)
		condition:setParameter(CONDITION_PARAM_TICKS, spell.paralyze)
		condition:setFormula(-0.5, 0, -0.5, 0)
		target:addCondition(condition)
		target:getPosition():sendMagicEffect(spell.effect)
		return
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
		return
	end
	hit(monster, target, data, spell)
end

local function heal(monster, data, pct, words, effect)
	local amount = math.min(data.healLeft, math.floor(monster:getMaxHealth() * pct / 100))
	if amount <= 0 then
		return false
	end
	data.healLeft = data.healLeft - amount
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
					local amount = math.min(data.healLeft, math.floor(other:getMaxHealth() * voc.allyHeal.pct / 100))
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
		if not healed and voc.potion and hpPct < voc.potion.below then
			healed = heal(monster, data, voc.potion.pct, nil, CONST_ME_MAGIC_RED)
		end
		if healed then
			data.nextHeal = now + 1000
		end
	end

	-- utamo vita
	if voc.utamo and hpPct < 45 and now >= data.utamoReady then
		data.utamoUntil = now + 12000
		data.utamoReady = now + 30000
		monster:say("utamo vita", TALKTYPE_MONSTER_SAY)
		monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end

	-- ucieczka przy niskim zyciu
	if hpPct < 20 and now >= data.fleeReady then
		data.fleeReady = now + 15000
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

	-- czar leczacy: osobne opoznienie od czarow ataku (jak u gracza - moze leczyc i bic w tej samej sekundzie)
	if now >= (data.nextHealSpell or 0) and voc.heal and hpPct < voc.heal.below and heal(monster, data, voc.heal.pct, voc.heal.words) then
		data.nextHealSpell = now + SPELL_EXHAUST
	end
	-- czar albo runa (wspolne opoznienie jak u graczy)
	if now >= data.nextSpell then
		for i, spell in ipairs(voc.spells) do
			local ready = now >= (data.cds[i] or 0)
			local inRange = spell.self and d <= spell.area or (not spell.self and d <= (spell.area and 6 or reach))
			if ready and inRange then
				castSpell(run, monster, target, data, spell)
				data.cds[i] = now + spell.cd * 1000
				data.nextSpell = now + SPELL_EXHAUST
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
		local f = spawnFighter(run, { voc = voc, base = mirrorHit(player), level = player:getLevel(), hp = player:getMaxHealth(), dmg = 0.6 + 0.4 * s, prefer = player:getId() }, 1)
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
			spawnFighter(run, { voc = vocKey(member), base = mirrorHit(member), level = member:getLevel(), hp = member:getMaxHealth(), dmg = 0.6 + 0.4 * s, prefer = member:getId() }, index)
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
		spawnFighter(run, { voc = opponent.voc, fullName = opponent.name, base = mirrorHit(player), level = player:getLevel(), hp = player:getMaxHealth(), dmg = 0.6 + 0.4 * s, prefer = player:getId(), skull = round.skull }, 1)
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
loop = function(mode, token)
	local run = runs[mode]
	if not run or run.token ~= token or run.phase ~= "fight" then
		return
	end
	run.clock = (run.clock or 0) + TICK -- zegar w ms (serwer nie ma zegara z milisekundami dla Lua)
	local now = run.clock
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
		MODES[mode].lose(run, run.left and next(run.knocked or {}) == nil and "opusciles sale" or "wszyscy powaleni")
		run.knocked = {}
		return
	end
	if remaining == 0 then
		calibrate(run)
		run.knocked = {}
		MODES[mode].win(run)
		return
	end
	if os.time() >= run.deadline then
		clearFighters(run)
		calibrate(run)
		run.knocked = {}
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

function guard.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
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
	local health = creature:getHealth()
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
	if attacker and attacker:isPlayer() then
		primaryDamage = math.floor(primaryDamage * PVP)
		secondaryDamage = math.floor(secondaryDamage * PVP)
	end
	if data.utamoUntil > now then
		primaryDamage = math.floor(primaryDamage * 0.65)
		secondaryDamage = math.floor(secondaryDamage * 0.65)
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
	for _, key in ipairs(VOC_ORDER) do
		window:addChoice(VOC[key].label, function(target)
			start(target, "duel", { voc = key })
		end)
	end
	window:addChoice("Losowa profesja", function(target)
		start(target, "duel", {})
	end)
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
local startup = GlobalEvent("OtsArenaPvpStartup")

function startup.onStartup()
	local made = 0
	for _, mode in ipairs(MODE_ORDER) do
		local landing = ROOMS[mode].landing
		made = made + OtsBuildRoom(landing)
		OtsReturnSpot(landing)
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
