local callback = EventCallback("TaskboardPlayerOnKill")

-- OTS: tablica taskow pyta o bestiariusz tylko potwory, ktore w nim sa. Inne (np. warianty
-- questowe z wlasnym raceId) wywolywaly blad "Monster race id not exists" przy kazdym zabiciu.
local bestiaryRaces = nil
local function inBestiary(raceId)
	if not bestiaryRaces then
		bestiaryRaces = {}
		for _, id in ipairs(Game.getBestiaryList() or {}) do
			bestiaryRaces[tonumber(id)] = true
		end
	end
	return bestiaryRaces[tonumber(raceId) or 0] == true
end

function callback.playerOnKill(player, monster)
	local taskboard = rawget(_G, "Taskboard")
	if not taskboard or not taskboard.isEnabled() or not player or not monster then
		return
	end

	local monsterType = monster:getType()
	if not monsterType then
		return
	end

	local isRewardBoss = false
	if type(monsterType.isRewardBoss) == "function" then
		local ok, result = pcall(monsterType.isRewardBoss, monsterType)
		isRewardBoss = ok and result == true
	end
	if isRewardBoss then
		return
	end

	if not inBestiary(monsterType:raceId()) then
		return
	end

	taskboard.onMonsterKilled(player, monsterType:raceId(), monster)
end

callback:register()
