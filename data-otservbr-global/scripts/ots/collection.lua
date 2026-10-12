-- OTS: kolekcja serwera. Kronikarz w swiatyni w Thais (powiedz hi) albo komenda !kolekcja pokazuje
-- postep: zabici bossowie, zdobyte stroje, wierzchowce i rekord fal. Kazdy osiagniety prog
-- (25%, 50%, 100%; dla fal 10 / 20 / 40) daje na stale +2% maksymalnego HP i many.
local BOSS_TOTAL = 205
local OUTFIT_TOTAL = 126
local MOUNT_TOTAL = 35
local MOUNT_MAX_ID = 250
local WAVE_STEPS = { 10, 20, 40 }
local PERCENT_STEPS = { 25, 50, 100 }
local BONUS_PER_STEP = 2
local SUBID = 64993
local NPC_NAME = "Kronikarz"
local NPC_HOME = Position(32369, 32239, 7)
local pendingGreeting = {} -- id gracza -> czeka na pierwsze pokazanie w tym logowaniu
local kronikarzId = nil

local function store(player)
	return player:kv():scoped("ots-collection")
end

local function progress(player)
	local bosses = math.min(tonumber(store(player):get("bosses")) or 0, BOSS_TOTAL)
	local outfits = 0
	local quests = player:kv():scoped("ots-outfit-quests")
	for index = 1, OUTFIT_TOTAL do
		if quests:scoped(tostring(index)):get("done") == true then
			outfits = outfits + 1
		end
	end
	local mounts = 0
	for id = 1, MOUNT_MAX_ID do
		if player:hasMount(id) then
			mounts = mounts + 1
		end
	end
	mounts = math.min(mounts, MOUNT_TOTAL)
	local waves = tonumber(player:kv():scoped("ots-survival"):get("best")) or 0
	return bosses, outfits, mounts, waves
end

local function stepsFor(value, total)
	local steps = 0
	for _, percent in ipairs(PERCENT_STEPS) do
		if value * 100 >= total * percent then
			steps = steps + 1
		end
	end
	return steps
end

local function totalSteps(bosses, outfits, mounts, waves)
	local steps = stepsFor(bosses, BOSS_TOTAL) + stepsFor(outfits, OUTFIT_TOTAL) + stepsFor(mounts, MOUNT_TOTAL)
	for _, wave in ipairs(WAVE_STEPS) do
		if waves >= wave then
			steps = steps + 1
		end
	end
	return steps
end

local function applyBonus(player, steps)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID)
	if steps <= 0 then
		return
	end
	local bonus = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	bonus:setParameter(CONDITION_PARAM_SUBID, SUBID)
	bonus:setParameter(CONDITION_PARAM_TICKS, -1)
	bonus:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 100 + steps * BONUS_PER_STEP)
	bonus:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, 100 + steps * BONUS_PER_STEP)
	player:addCondition(bonus)
end

local function show(player)
	local bosses, outfits, mounts, waves = progress(player)
	local steps = totalSteps(bosses, outfits, mounts, waves)
	applyBonus(player, steps)
	local text = string.format(
		"Kolekcja:\nBossowie: %d/%d\nStroje z questow: %d/%d\nWierzchowce: %d/%d\nRekord fal: %d (progi %d / %d / %d)\n\nOsiagniete progi: %d z 12.\nStaly bonus: +%d%% maksymalnego HP i many.",
		bosses,
		BOSS_TOTAL,
		outfits,
		OUTFIT_TOTAL,
		mounts,
		MOUNT_TOTAL,
		waves,
		WAVE_STEPS[1],
		WAVE_STEPS[2],
		WAVE_STEPS[3],
		steps,
		steps * BONUS_PER_STEP
	)
	local window = ModalWindow({ title = "Kolekcja", message = text })
	-- Uklad jak w oknach !tp, gdzie Enter dziala: dwa przyciski, wartosci zamienione,
	-- bo klient 15.x czyta je odwrotnie (Enter = przycisk 1 "OK", Esc = przycisk 2).
	window:addChoice("OK", function() end)
	window:addButton("OK", function() end)
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Kazdy rodzaj bossa liczy sie raz.
local bossKill = EventCallback("OtsCollectionBossKill")

function bossKill.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local monsterType = monster:getType()
	if not monsterType or not monsterType:isRewardBoss() then
		return
	end
	local seen = store(player):scoped("boss")
	local name = monster:getName():lower()
	if seen:get(name) then
		return
	end
	seen:set(name, true)
	local count = (tonumber(store(player):get("bosses")) or 0) + 1
	store(player):set("bosses", count)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Kolekcja: nowy boss (%d/%d).", math.min(count, BOSS_TOTAL), BOSS_TOTAL))
end

bossKill:register()

local login = CreatureEvent("OtsCollectionLogin")

function login.onLogin(player)
	applyBonus(player, totalSteps(progress(player)))
	pendingGreeting[player:getId()] = true
	return true
end

login:register()

local command = TalkAction("!kolekcja")

function command.onSay(player, words, param)
	show(player)
	return true
end

command:groupType("normal")
command:register()

local npcType = Game.createNpcType(NPC_NAME)
-- Okno pokazuje sie samo raz na logowanie, gdy podejdziesz do Kronikarza; potem tylko na "hi" albo !kolekcja.
npcType.onSay = function(npc, creature, type, message)
	local player = creature and creature:getPlayer()
	local text = message and message:lower() or ""
	if player and (text == "hi" or text == "hello" or text == "kolekcja") and player:getPosition():getDistance(npc:getPosition()) <= 4 then
		show(player)
	end
end
npcType:register({
	name = NPC_NAME,
	description = NPC_NAME,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = { lookType = 130, lookHead = 0, lookBody = 114, lookLegs = 114, lookFeet = 95, lookAddons = 3 },
	flags = { floorchange = false },
})

local place = GlobalEvent("OtsCollectionNpc")

function place.onStartup()
	local spot = nil
	for radius = 0, 3 do
		for dx = -radius, radius do
			for dy = -radius, radius do
				if not spot then
					local pos = Position(NPC_HOME.x + dx, NPC_HOME.y + dy, NPC_HOME.z)
					local tile = Tile(pos)
					if tile and tile:isWalkable(false, true, true, true, false) and tile:getItemCount() == 0 and not tile:getTopCreature() then
						spot = pos
					end
				end
			end
		end
	end
	local npc = spot and Game.createNpc(NPC_NAME, spot, false, true)
	if npc then
		npc:setMasterPos(spot)
		kronikarzId = npc:getId()
	end
	logger.info("[OTS kolekcja] Kronikarz w swiatyni: {}", npc and "tak" or "nie")
	return true
end

place:register()

local greet = GlobalEvent("OtsCollectionGreeting")

function greet.onThink(interval)
	local npc = kronikarzId and Creature(kronikarzId)
	if not npc then
		return true
	end
	local npcPosition = npc:getPosition()
	for id in pairs(pendingGreeting) do
		local player = Player(id)
		if not player then
			pendingGreeting[id] = nil
		else
			local pos = player:getPosition()
			if pos.z == npcPosition.z and pos:getDistance(npcPosition) <= 4 then
				pendingGreeting[id] = nil
				show(player)
			end
		end
	end
	return true
end

greet:interval(1000)
greet:register()
