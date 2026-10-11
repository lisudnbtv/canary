-- OTS: uproszczony Demon Oak. Bez hallowed axe i bez rozmow z Oldrakiem:
--   * wejscie: klikniecie martwego drzewa, ktore zagradza sciezke (albo teleport z hali questow),
--   * walka: klikanie czesci debu (cztery czesci, po 10 uderzen), potwory wychodza jak w oryginale,
--   * po ostatnim uderzeniu i wybiciu potworow: teleport prosto do sali ze skrzyniami (jedna nagroda do wyboru).
-- Pozycje (DEMON_OAK_*) i storage sa oryginalne z silnika; skrzynie obsluguje oryginalny skrypt.
local ENTRANCE_TREE_POSITION = Position(32716, 32345, 7)
local ENTRANCE_TREE_ID = 3623
local ENTRANCE_ACTION_ID = 64998
local OAK_IDS = { 914, 915, 916, 917 }
local WAVES = 10
local BONEBEAST_CHANCE = 90
local BONEBEAST_COUNT = 4
local done = Storage.Quest.U8_2.TheDemonOak.Done
local progressStorage = Storage.Quest.U8_2.TheDemonOak.Progress

local summonPositions = {
	Position(32714, 32348, 7),
	Position(32712, 32349, 7),
	Position(32711, 32351, 7),
	Position(32713, 32354, 7),
	Position(32716, 32354, 7),
	Position(32719, 32354, 7),
	Position(32721, 32351, 7),
	Position(32719, 32348, 7),
}

local summons = {
	[914] = { [5] = { "Spectre", "Blightwalker", "Braindeath", "Demon" }, [10] = { "Betrayed Wraith", "Betrayed Wraith" } },
	[915] = { [5] = { "Plaguesmith", "Plaguesmith", "Blightwalker" }, [10] = { "Dark Torturer", "Blightwalker" } },
	[916] = { [5] = { "Banshee", "Plaguesmith", "Hellhound" }, [10] = { "Grim Reaper" } },
	[917] = { [5] = { "Plaguesmith", "Hellhound", "Hellhound" }, [10] = { "Undead Dragon", "Hand of Cursed Fate" } },
}

local blows = {
	[914] = Storage.Quest.U8_2.TheDemonOak.AxeBlowsBird,
	[915] = Storage.Quest.U8_2.TheDemonOak.AxeBlowsLeft,
	[916] = Storage.Quest.U8_2.TheDemonOak.AxeBlowsRight,
	[917] = Storage.Quest.U8_2.TheDemonOak.AxeBlowsFace,
}

local function randomSummonPosition()
	return summonPositions[math.random(#summonPositions)]
end

local function monstersInArea()
	local spectators = Game.getSpectators(DEMON_OAK_POSITION, false, false, 9, 9, 6, 6)
	for i = 1, #spectators do
		if spectators[i]:isMonster() and not spectators[i]:getMaster() then
			return true
		end
	end
	return false
end

local function enter(player)
	if player:getStorageValue(done) >= 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Demon Oak: nagroda juz odebrana.")
		return
	end
	if player:getStorageValue(done) == 2 then
		player:teleportTo(DEMON_OAK_REWARDROOM_POSITION)
		DEMON_OAK_REWARDROOM_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Demon Oak pokonany. Wybierz jedna skrzynie z nagroda.")
		return
	end
	if #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) > 0 then
		player:sendCancelMessage("Ktos juz walczy z Demon Oakiem.")
		return
	end
	player:teleportTo(DEMON_OAK_ENTER_POSITION)
	DEMON_OAK_ENTER_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
	player:setStorageValue(progressStorage, 1)
	player:say("I AWAITED YOU! COME HERE AND GET YOUR REWARD!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Demon Oak: klikaj cztery czesci debu. Kazda wymaga 10 uderzen, co kilka wychodza potwory.")
end

-- Wejscie z hali questow i z !tp: stawia gracza przed martwym drzewem.
function OtsDemonOakStart(player)
	player:teleportTo(DEMON_OAK_KICK_POSITION)
	DEMON_OAK_KICK_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Demon Oak: idz sciezka na poludnie i kliknij martwe drzewo, zeby wejsc.")
end

local entranceTree = Action()

function entranceTree.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	enter(player)
	return true
end

entranceTree:aid(ENTRANCE_ACTION_ID)
entranceTree:register()

local markTree = GlobalEvent("OtsDemonOakEntrance")

function markTree.onStartup()
	local tile = Tile(ENTRANCE_TREE_POSITION)
	local tree = tile and tile:getItemById(ENTRANCE_TREE_ID)
	if tree then
		tree:setActionId(ENTRANCE_ACTION_ID)
	end
	logger.info("[OTS demon oak] Drzewo przy wejsciu: {}", tree and "oznaczone" or "nie znaleziono")
	return true
end

markTree:register()

local oak = Action()

function oak.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local oakId = item:getId()
	local oakPosition = item:getPosition()

	local total = 0
	for _, storage in pairs(blows) do
		total = total + math.max(0, player:getStorageValue(storage))
	end
	local defeated = total == (#OAK_IDS * (WAVES + 1))

	if defeated then
		if monstersInArea() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Najpierw zabij wszystkie potwory.")
			return true
		end
		player:setStorageValue(done, 2)
		player:setStorageValue(progressStorage, 3)
		player:teleportTo(DEMON_OAK_REWARDROOM_POSITION)
		DEMON_OAK_REWARDROOM_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Demon Oak pokonany! Wybierz jedna skrzynie z nagroda.")
		return true
	end

	local storage = blows[oakId]
	local progress = math.max(player:getStorageValue(storage), 1)
	if progress >= WAVES + 1 then
		oakPosition:sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ta czesc jest juz zniszczona. Zostaly inne.")
		return true
	end

	local lastCut = total == (#OAK_IDS * (WAVES + 1) - 1)
	local wave = summons[oakId] and summons[oakId][progress]
	if wave then
		if lastCut then
			Game.createMonster("Demon", randomSummonPosition(), false, true)
		else
			for i = 1, #wave do
				Game.createMonster(wave[i], randomSummonPosition(), false, true)
			end
		end
	elseif math.random(100) >= BONEBEAST_CHANCE then
		for _ = 1, BONEBEAST_COUNT do
			Game.createMonster("Bonebeast", randomSummonPosition(), false, true)
		end
	end

	oakPosition:sendMagicEffect(CONST_ME_DRAWBLOOD)
	player:setStorageValue(storage, progress + 1)
	player:say("-krrrrak-", TALKTYPE_MONSTER_YELL, false, player, oakPosition)
	if lastCut then
		player:say("HOW IS THAT POSSIBLE?!? MY MASTER WILL CRUSH YOU!! AHRRGGG!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ostatnie uderzenie! Zabij potwory i kliknij dab jeszcze raz, zeby odebrac nagrode.")
	end
	doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -170, -210, CONST_ME_BIGPLANTS)
	return true
end

oak:id(914, 915, 916, 917)
oak:register()
