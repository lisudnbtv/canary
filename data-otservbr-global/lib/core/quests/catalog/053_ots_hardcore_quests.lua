-- OTS: Hardcore Questy (!tp > Hardcore Questy) w Quest Logu. Logika: data-otservbr-global/scripts/ots/hardcore_quests.lua.
local function mission(index, name, desc)
	return {
		name = name,
		storageId = 65100000 + index,
		missionId = 11200 + index,
		startValue = 1,
		endValue = 2,
		states = {
			[1] = "In progress: " .. desc,
			[2] = "Complete: " .. desc,
		},
	}
end

local quest = {
	name = "Hardcore Questy",
	startStorageId = 65100000,
	startStorageValue = 1,
	missions = {
		[1] = mission(1, "Wieza Upadku", "50 floors without potions, a boss every 10 floors."),
		[2] = mission(2, "Czempion Zywiolow", "7 stages, each monster is hurt by only one element."),
		[3] = mission(3, "Wyscig z Czasem", "10 bosses in a row within 20 minutes."),
		[4] = mission(4, "Survival 20 min", "Survive 20 minutes of growing waves with no exit."),
		[5] = mission(5, "Klatwa Obrona", "Break the curse of Grand Master Oberon in 3 stages."),
	},
}

return quest
