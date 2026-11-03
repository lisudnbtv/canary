-- OTS: wpis questa Pits of Inferno w Quest Logu (w Canary go brakowalo). Misje to trony siedmiu wladcow.
local quest = {
	name = "The Pits of Inferno",
	startStorageId = Storage.Quest.U7_9.ThePitsOfInferno.ShortcutHubDoor,
	startStorageValue = 1,
	missions = {
		[1] = {
			name = "Verminor's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThroneVerminor,
			missionId = 11101,
			startValue = 1,
			endValue = 1,
			description = "You have touched Verminor's throne and absorbed some of his spirit.",
		},
		[2] = {
			name = "Infernatil's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThroneInfernatil,
			missionId = 11102,
			startValue = 1,
			endValue = 1,
			description = "You have touched Infernatil's throne and absorbed some of his spirit.",
		},
		[3] = {
			name = "Tafariel's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThroneTafariel,
			missionId = 11103,
			startValue = 1,
			endValue = 1,
			description = "You have touched Tafariel's throne and absorbed some of his spirit.",
		},
		[4] = {
			name = "Apocalypse's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThroneApocalypse,
			missionId = 11104,
			startValue = 1,
			endValue = 1,
			description = "You have touched Apocalypse's throne and absorbed some of his spirit.",
		},
		[5] = {
			name = "Bazir's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThroneBazir,
			missionId = 11105,
			startValue = 1,
			endValue = 1,
			description = "You have touched Bazir's throne and absorbed some of his spirit.",
		},
		[6] = {
			name = "Ashfalor's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThroneAshfalor,
			missionId = 11106,
			startValue = 1,
			endValue = 1,
			description = "You have touched Ashfalor's throne and absorbed some of his spirit.",
		},
		[7] = {
			name = "Pumin's Throne",
			storageId = Storage.Quest.U7_9.ThePitsOfInferno.ThronePumin,
			missionId = 11107,
			startValue = 10,
			endValue = 10,
			description = "You have touched Pumin's throne and absorbed some of his spirit.",
		},
	},
}

return quest
