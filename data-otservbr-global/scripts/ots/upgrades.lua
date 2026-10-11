-- OTS: ulepszanie przedmiotow (+1 do +10) kamieniem ulepszen.
-- Kamien (essence of wishful thinking) uzywa sie na przedmiocie w plecaku albo na sobie.
-- Kazdy poziom dodaje 3% bazowego ataku / obrony / pancerza (co najmniej +1 na poziom).
-- Do +5 zawsze sie udaje; dalej szansa spada. Porazka zuzywa kamien, a od proby na +8
-- dodatkowo cofa przedmiot o jeden poziom.
-- Kamienie leca z bossow (reward boss), elit, fal, boss rusha i inwazji.
local STONE_ID = 20139
local MAX_LEVEL = 10
local SUCCESS_CHANCE = { 100, 100, 100, 100, 100, 80, 70, 60, 50, 40 }
local DROP_BACK_FROM = 8
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
	if itemType:getAttack() <= 0 and itemType:getDefense() <= 0 and itemType:getArmor() <= 0 then
		player:sendCancelMessage("Tego przedmiotu nie da sie ulepszyc (nie ma ataku, obrony ani pancerza).")
		return true
	end
	local level = tonumber(target:getCustomAttribute(LEVEL_KEY)) or 0
	if level >= MAX_LEVEL then
		player:sendCancelMessage("Ten przedmiot ma juz maksymalny poziom +" .. MAX_LEVEL .. ".")
		return true
	end

	local nextLevel = level + 1
	item:remove(1)
	if math.random(100) <= SUCCESS_CHANCE[nextLevel] then
		applyLevel(target, nextLevel)
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Ulepszenie udane: %s +%d.", itemType:getName(), nextLevel))
	elseif nextLevel >= DROP_BACK_FROM then
		applyLevel(target, level - 1)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Ulepszenie nieudane: %s spada na +%d.", itemType:getName(), level - 1))
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Ulepszenie nieudane: %s zostaje na +%d.", itemType:getName(), level))
	end
	return true
end

stone:id(STONE_ID)
stone:register()

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
