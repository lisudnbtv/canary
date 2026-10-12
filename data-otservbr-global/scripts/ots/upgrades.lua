-- OTS: ulepszanie przedmiotow (+1 do +10) kamieniem ulepszen.
-- Kamien (essence of wishful thinking) uzywa sie na przedmiocie w plecaku albo na sobie.
-- Kazdy poziom dodaje 3% bazowego ataku / obrony / pancerza (co najmniej +1 na poziom).
-- Do +5 zawsze sie udaje; dalej szansa spada. Porazka tylko zuzywa kamien, poziom zostaje.
-- Ulepszyc da sie wszystko (poza pojemnikami i stosami). Bron ma osobna, duzo nizsza szanse.
-- Przedmioty bez ataku, obrony i pancerza dostaja premie, gdy sa zalozone:
-- bron (rozdzka, rod, luk...) +3% zadawanych obrazen na poziom,
-- pozostale (pierscien, amulet...) -0.5% otrzymywanych obrazen na poziom.
-- Kamienie sa w sklepie za TC i leca z bossow (reward boss), elit, fal i inwazji.
local STONE_ID = 20139
local BLESSED_STONE_ID = 20138 -- blessed upgrade stone: zawsze udane +1, powstaje z 10 zwyklych (!polacz)
local STONES_PER_BLESSED = 10
local MAX_LEVEL = 10
local SUCCESS_CHANCE = { 100, 100, 100, 100, 100, 80, 70, 60, 50, 40 }
local SUCCESS_CHANCE_WEAPON = { 60, 50, 40, 30, 25, 20, 15, 10, 7, 5 } -- kazda bron: czesciej pali kamien
local PLAIN_OTHER_REDUCTION = 0.005
local PLAIN_WEAPON_DAMAGE = 0.03
local LEVEL_KEY = "ots-upgrade"

local function upgraded(base, level)
	if base <= 0 then
		return nil
	end
	return base + math.max(level, math.ceil(base * 0.03 * level))
end

local function applyLevel(item, level)
	local itemType = ItemType(item:getId())
	local attack, defense, armor = itemType:getAttack(), itemType:getDefense(), itemType:getArmor()
	if attack > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_ATTACK, upgraded(attack, level))
	end
	if defense > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_DEFENSE, upgraded(defense, level))
	end
	if armor > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_ARMOR, upgraded(armor, level))
	end
	item:setAttribute(ITEM_ATTRIBUTE_NAME, level > 0 and (itemType:getName() .. " +" .. level) or itemType:getName())
	item:setCustomAttribute(LEVEL_KEY, level)
end

local stone = Action()

function stone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		player:sendCancelMessage("Uzyj kamienia na przedmiocie, ktory chcesz ulepszyc.")
		return true
	end
	if toPosition.x ~= CONTAINER_POSITION then
		player:sendCancelMessage("Przedmiot musi byc w plecaku albo zalozony.")
		return true
	end
	local itemType = ItemType(target:getId())
	local blessed = item:getId() == BLESSED_STONE_ID
	if target:getId() == STONE_ID or target:getId() == BLESSED_STONE_ID or itemType:isStackable() or itemType:isContainer() then
		player:sendCancelMessage("Tego przedmiotu nie da sie ulepszyc.")
		return true
	end
	local weaponType = itemType:getWeaponType()
	local isWeapon = weaponType ~= WEAPON_NONE and weaponType ~= WEAPON_SHIELD
	local chances = isWeapon and SUCCESS_CHANCE_WEAPON or SUCCESS_CHANCE
	local level = tonumber(target:getCustomAttribute(LEVEL_KEY)) or 0
	if level >= MAX_LEVEL then
		player:sendCancelMessage("Ten przedmiot ma juz maksymalny poziom +" .. MAX_LEVEL .. ".")
		return true
	end

	local nextLevel = level + 1
	item:remove(1)
	if blessed or math.random(100) <= chances[nextLevel] then
		applyLevel(target, nextLevel)
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Ulepszenie udane: %s +%d.", itemType:getName(), nextLevel))
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Ulepszenie nieudane: %s zostaje na +%d.", itemType:getName(), level))
	end
	return true
end

stone:id(STONE_ID, BLESSED_STONE_ID)
stone:register()

-- Przedmioty bez statystyk: premia liczona przy kazdym ciosie z zalozonych rzeczy.
local SLOTS = { CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING }

local function plainBonus(player)
	local dealt, taken = 0, 0
	for _, slot in ipairs(SLOTS) do
		local item = player:getSlotItem(slot)
		local level = item and tonumber(item:getCustomAttribute(LEVEL_KEY)) or 0
		if level > 0 then
			local itemType = ItemType(item:getId())
			if itemType:getAttack() <= 0 and itemType:getDefense() <= 0 and itemType:getArmor() <= 0 then
				if itemType:getWeaponType() ~= WEAPON_NONE then
					dealt = dealt + level * PLAIN_WEAPON_DAMAGE
				else
					taken = taken + level * PLAIN_OTHER_REDUCTION
				end
			end
		end
	end
	return dealt, taken
end

local plainCombat = EventCallback("OtsUpgradePlainCombat")

function plainCombat.creatureOnCombat(caster, target, combatDamage)
	if not combatDamage then
		return
	end
	local factor = 1
	if caster and type(caster.isPlayer) == "function" and caster:isPlayer() then
		factor = factor * (1 + plainBonus(caster))
	end
	if target and type(target.isPlayer) == "function" and target:isPlayer() and target ~= caster then
		local _, taken = plainBonus(target)
		factor = factor * (1 - taken)
	end
	if factor == 1 then
		return
	end
	for _, entry in ipairs({ combatDamage.primary, combatDamage.secondary }) do
		if entry and tonumber(entry.value) and entry.value < 0 then
			entry.value = math.floor(entry.value * factor)
		end
	end
end

plainCombat:register()

-- Kazdy zabity reward boss daje jeden kamien prosto do plecaka.
local bossStone = EventCallback("OtsUpgradeStoneFromBoss")

function bossStone.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local monsterType = monster:getType()
	if monsterType and monsterType:isRewardBoss() then
		player:addItem(STONE_ID, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss pokonany: +1 kamien ulepszen.")
	end
end

bossStone:register()

-- !polacz: kazde 10 zwyklych kamieni ulepszen zamienia w 1 blessed upgrade stone.
local combine = TalkAction("!polacz")

function combine.onSay(player, words, param)
	local have = player:getItemCount(STONE_ID)
	local make = math.floor(have / STONES_PER_BLESSED)
	if make == 0 then
		player:sendCancelMessage(string.format("Potrzebujesz %d kamieni ulepszen (masz %d).", STONES_PER_BLESSED, have))
		return true
	end
	if not player:removeItem(STONE_ID, make * STONES_PER_BLESSED) then
		player:sendCancelMessage("Nie udalo sie zabrac kamieni.")
		return true
	end
	player:addItem(BLESSED_STONE_ID, make)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Polaczono %d kamieni w %d blessed upgrade stone. Ulepszenie nim zawsze sie udaje.", make * STONES_PER_BLESSED, make))
	return true
end

combine:groupType("normal")
combine:register()

-- Wymiana: pierwsza wersja blessed stone miala wyglad midnight shard (9615), ktorego nie dalo sie uzyc na przedmiocie.
-- Przy logowaniu takie sztuki zamieniaja sie w nowy blessed upgrade stone.
local OLD_BLESSED_ID = 9615
local swap = CreatureEvent("OtsBlessedStoneSwap")

function swap.onLogin(player)
	local count = player:getItemCount(OLD_BLESSED_ID)
	if count > 0 and player:removeItem(OLD_BLESSED_ID, count) then
		player:addItem(BLESSED_STONE_ID, count)
		player:sendTextMessage(MESSAGE_STATUS, string.format("Wymieniono %d blessed upgrade stone na nowa wersje.", count))
	end
	return true
end

swap:register()
