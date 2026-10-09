-- OTS: nagroda In Service of Yalahar bez sprawdzania misji.
-- Do pokoju ze skrzyniami prowadzi tylko teleport po pokonaniu Azerusa,
-- wiec samo dojscie tutaj jest dowodem wygranej walki. Jedna nagroda na postac.
local rewards = {
	[3088] = { id = 8862, name = "a yalahari armor" },
	[3089] = { id = 8864, name = "a yalahari mask" },
	[3090] = { id = 8863, name = "a yalahari leg piece" },
	[30091] = { id = 50289, name = "a pair of yalahari footwraps" },
}

local REWARD_KEY = "ots-yalahar-reward"

local inServiceYalaharReward = Action()

function inServiceYalaharReward.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local reward = rewards[item.uid]
	if not reward then
		return true
	end

	local questline = Storage.Quest.U8_4.InServiceOfYalahar.Questline
	if player:kv():get(REWARD_KEY) or player:getStorageValue(questline) >= 54 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
		return true
	end

	player:addItem(reward.id, 1)
	player:kv():set(REWARD_KEY, true)
	player:setStorageValue(questline, 54)
	player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission10, 5)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. reward.name .. ".")
	return true
end

inServiceYalaharReward:uid(3088, 3089, 3090, 30091)
inServiceYalaharReward:register()
