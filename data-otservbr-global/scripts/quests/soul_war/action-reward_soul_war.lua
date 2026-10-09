-- OTS: nagroda Soul War dopasowana do profesji.
-- Zamiast jednego losowego przedmiotu gracz dostaje wszystkie przedmioty Soul War
-- swojej profesji (dla rycerza i paladyna to m.in. komplet broni).
-- Nadal trzeba pokonac Goshnar's Megalomania; nagroda jest jednorazowa.
local rewardsByVocation = {
	[VOCATION.BASE_ID.SORCERER] = {
		{ id = 34090, name = "soultainter" },
		{ id = 34092, name = "soulshanks" },
		{ id = 34095, name = "soulmantle" },
	},
	[VOCATION.BASE_ID.DRUID] = {
		{ id = 34091, name = "soulhexer" },
		{ id = 34093, name = "soulstrider" },
		{ id = 34096, name = "soulshroud" },
	},
	[VOCATION.BASE_ID.PALADIN] = {
		{ id = 34088, name = "soulbleeder" },
		{ id = 34089, name = "soulpiercer" },
		{ id = 34094, name = "soulshell" },
		{ id = 34098, name = "pair of soulstalkers" },
	},
	[VOCATION.BASE_ID.KNIGHT] = {
		{ id = 34082, name = "soulcutter" },
		{ id = 34083, name = "soulshredder" },
		{ id = 34084, name = "soulbiter" },
		{ id = 34085, name = "souleater" },
		{ id = 34086, name = "soulcrusher" },
		{ id = 34087, name = "soulmaimer" },
		{ id = 34097, name = "pair of soulwalkers" },
		{ id = 34099, name = "soulbastion" },
	},
}

local rewardSoulWar = Action()

function rewardSoulWar.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local soulWarQuest = player:soulWarQuestKV()
	if soulWarQuest:get("final-reward") then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already received your reward.")
		return true
	end

	if not soulWarQuest:get("goshnar's-megalomania-killed") then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to defeat Goshnar's Megalomania to receive your reward.")
		return true
	end

	local rewards = rewardsByVocation[player:getVocation():getBaseId()]
	if not rewards then
		-- Profesja bez wlasnych przedmiotow Soul War: jeden losowy, jak w oryginale.
		rewards = { SoulWarQuest.finalRewards[math.random(1, #SoulWarQuest.finalRewards)] }
	end

	local names = {}
	for _, reward in ipairs(rewards) do
		player:addItem(reward.id, 1)
		names[#names + 1] = reward.name
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found: " .. table.concat(names, ", ") .. ".")
	soulWarQuest:set("final-reward", true)
	return true
end

rewardSoulWar:position({ x = 33620, y = 31400, z = 10 })
rewardSoulWar:register()
