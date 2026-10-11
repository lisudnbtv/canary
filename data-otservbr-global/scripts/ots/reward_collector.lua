-- OTS: Boss Loot Collector - przedmiot ze sklepu. Po uzyciu na stale wlacza postaci zbieranie
-- lupu z bossow: wszystko, co trafia do skrzyni nagrod (reward chest), samo przenosi sie
-- do loot poucha. Dziala po zabiciu bossa, przy logowaniu i na komende !reward.
-- Odroczone wywolanie niesie tylko id gracza i od nowa go wyszukuje.
local COLLECTOR_ID = 9212 -- golden trophy of excellence
local KV_SCOPE = "ots-reward-collector"
local DELAY_MS = 3000

local function unlocked(player)
	return player:kv():scoped(KV_SCOPE):get("on") == true
end

local function moveToPouch(item, pouch)
	if item:moveTo(pouch) then
		return true
	end
	local copy = item:clone()
	if copy and pouch:addItemEx(copy, INDEX_WHEREEVER, FLAG_NOLIMIT) == RETURNVALUE_NOERROR then
		item:remove()
		return true
	end
	return false
end

local function collect(player, quiet)
	local pouch = player:getItemById(ITEM_GOLD_POUCH, true)
	if not pouch or not pouch:isContainer() then
		if not quiet then
			player:sendCancelMessage("Nie masz loot poucha.")
		end
		return
	end
	local moved, left = 0, 0
	for _, rewardId in ipairs(player:getRewardList()) do
		local reward = player:getReward(rewardId, false)
		if reward and reward:isContainer() then
			local items = reward:getItems(false)
			local remaining = 0
			for index = #items, 1, -1 do
				local count = items[index]:getCount()
				if moveToPouch(items[index], pouch) then
					moved = moved + count
				else
					remaining = remaining + 1
				end
			end
			if remaining == 0 then
				player:removeReward(rewardId)
			else
				left = left + remaining
			end
		end
	end
	if moved > 0 then
		local text = string.format("Lup z bossow przeniesiony do loot poucha: %d szt.", moved)
		if left > 0 then
			text = text .. string.format(" W skrzyni nagrod zostalo: %d.", left)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	elseif not quiet then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, left > 0 and "Tych przedmiotow nie da sie przeniesc do loot poucha." or "Skrzynia nagrod jest pusta.")
	end
end

local function collectLater(playerId)
	local player = Player(playerId)
	if player and unlocked(player) then
		collect(player, true)
	end
end

local collector = Action()

function collector.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if unlocked(player) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zbieranie lupu z bossow masz juz wlaczone.")
		return true
	end
	player:kv():scoped(KV_SCOPE):set("on", true)
	item:remove(1)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wlaczone na stale: lup z bossow bedzie sam trafial do loot poucha. Recznie: !reward.")
	collect(player, true)
	return true
end

collector:id(COLLECTOR_ID)
collector:register()

local bossKill = EventCallback("OtsRewardCollectorKill")

function bossKill.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local monsterType = monster:getType()
	if monsterType and monsterType:isRewardBoss() and unlocked(player) then
		addEvent(collectLater, DELAY_MS, player:getId())
	end
end

bossKill:register()

local login = CreatureEvent("OtsRewardCollectorLogin")

function login.onLogin(player)
	if unlocked(player) then
		addEvent(collectLater, DELAY_MS, player:getId())
	end
	return true
end

login:register()

local command = TalkAction("!reward")

function command.onSay(player, words, param)
	if not unlocked(player) then
		player:sendCancelMessage("Najpierw kup w sklepie i uzyj Boss Loot Collector.")
		return true
	end
	collect(player, false)
	return true
end

command:groupType("normal")
command:register()
