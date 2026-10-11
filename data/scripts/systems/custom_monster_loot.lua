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

-- OTS: bag you desire z kazdego potwora Soul War. Szansa 1000 na 100000 to 1%, a serwerowy
-- mnoznik lootu x10 robi z tego ok. 10% na zabicie.
local BAG_YOU_DESIRE_CHANCE = 1000
local soulWarMonsters = {
	"Dreadful Disruptor",
	"Dreadful Harvester",
	"Goshnar's Megalomania Blue",
	"Goshnar's Megalomania Green",
	"Goshnar's Megalomania Purple",
	"Goshnar's Cruelty",
	"Goshnar's Greed",
	"Goshnar's Hatred",
	"Goshnar's Malice",
	"Goshnar's Spite",
	"Malicious Soul",
	"Mean Maw",
	"Mirror Image",
	"Bony Sea Devil",
	"Brachiodemon",
	"Branchy Crawler",
	"Capricious Phantom",
	"Distorted Phantom",
	"Druid's Apparition",
	"Cloak of Terror",
	"Courage Leech",
	"Vibrant Phantom",
	"Hateful Soul",
	"Infernal Demon",
	"Infernal Phantom",
	"Knight's Apparition",
	"Many Faces",
	"Monk's Apparition",
	"Mould Phantom",
	"Paladin's Apparition",
	"Rotten Golem",
	"Sorcerer's Apparition",
	"Turbulent Elemental",
	"Soul Cage",
	"Spiteful Spitter",
	"Hazardous Phantom",
}
for _, monsterName in ipairs(soulWarMonsters) do
	local entry = customLootConfig[monsterName] or { items = {} }
	entry.items[#entry.items + 1] = { name = "bag you desire", chance = BAG_YOU_DESIRE_CHANCE }
	customLootConfig[monsterName] = entry
end

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
