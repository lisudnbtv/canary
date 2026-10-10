-- OTS: christmas tokeny leca tylko ze swiatecznych potworow (wczesniej z kazdego).
-- Lista "dla wszystkich" jest pusta.
local allLootConfig = {}

-- Custom loot for specific monsters (this has the same usage options as normal monster loot)
local customLootConfig = {
	["Animated Snowman"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
	["Percht"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
	["Schiach"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
	["Baleful Bunny"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
	["The Percht Queen"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
	["Percht Minion"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
	["Grynch Clan Goblin"] = { items = { { id = 6526, chance = 100000, minCount = 1, maxCount = 3 } } },
}

local customMonsterLoot = GlobalEvent("CreateCustomMonsterLoot")

function customMonsterLoot.onStartup()
	for monsterName, lootTable in pairs(customLootConfig) do
		local mtype = Game.getMonsterTypeByName(monsterName)
		if mtype then
			if lootTable and lootTable.items and #lootTable.items > 0 then
				mtype:createLoot(lootTable.items)
				logger.debug("[customMonsterLoot.onStartup] - Custom loot registered for monster: {}", mtype:getName())
			end
		else
			logger.error("[customMonsterLoot.onStartup] - Monster type not found: {}", monsterName)
		end
	end

	if #allLootConfig > 0 then
		for monsterName, mtype in pairs(Game.getMonsterTypes()) do
			mtype:createLoot(allLootConfig)
			logger.debug("[customMonsterLoot.onStartup] - Global loot registered for monster: {}", mtype:getName())
		end
	end
end

customMonsterLoot:register()
