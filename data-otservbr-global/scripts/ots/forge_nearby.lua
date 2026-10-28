-- OTS: potwory kuzni pojawiaja sie tam, gdzie gracz expi. Serwer sam losuje je z calej mapy,
-- wiec przy jednym graczu rzadko trafiaja na jego expowisko. Ten skrypt co kilka sekund dba,
-- zeby w poblizu gracza (poza PZ) bylo do TARGET_NEARBY potworow kuzni; czasem zamiast nich fiendish.
-- Pyl z jednego potwora: forgeAmountMultiplier w docker/ots/config-overrides.lua.
local TICK_MS = 1500
local TARGET_NEARBY = 15
local PER_TICK = 4 -- ile brakujacych potworow kuzni moze dojsc w jednej turze
local RANGE_X, RANGE_Y = 11, 11 -- caly pokoj Bestiariusza / Fal
local CHANCE_PERCENT = 100 -- szansa na ture, ze brakujacy potwor kuzni sie pojawi
local FIENDISH_PERCENT = 15 -- z tego: szansa na czerwonego fiendish zamiast zwyklego

local function isElite(monster)
	return (OtsRandomElites and OtsRandomElites[monster:getId()]) or (OtsOutfitElite and OtsOutfitElite[monster:getId()])
end

-- Serwer trzyma limit potworow kuzni na mapie (forgeInfluencedLimit) i zwykle ma go pelny.
-- Zeby dodac potwora przy graczu, zdejmujemy status z jednego dalekiego (poza zasiegiem graczy).
local FAR = 20

local function farFromPlayers(position, players)
	for _, pos in ipairs(players) do
		if pos.z == position.z and math.abs(pos.x - position.x) <= FAR and math.abs(pos.y - position.y) <= FAR then
			return false
		end
	end
	return true
end

local function freeSlot(players)
	local ids = Game.getInfluencedMonsters() or {}
	for _ = 1, math.min(#ids, 30) do
		local id = ids[math.random(#ids)]
		local monster = Monster(id)
		if not monster then
			Game.removeInfluencedMonster(id)
			return true
		end
		if farFromPlayers(monster:getPosition(), players) then
			monster:clearFiendishStatus()
			Game.removeInfluencedMonster(id)
			return true
		end
	end
	return false
end

local function makeInfluenced(monster, players)
	if Game.addInfluencedMonster(monster) then
		return
	end
	if freeSlot(players) then
		Game.addInfluencedMonster(monster)
	end
end

local tick = GlobalEvent("OtsForgeNearbyTick")

function tick.onThink(interval)
	local players = {}
	for _, player in ipairs(Game.getPlayers()) do
		players[#players + 1] = player:getPosition()
	end
	for _, player in ipairs(Game.getPlayers()) do
		local position = player:getPosition()
		local tile = Tile(position)
		if tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
			local forge, candidates = 0, {}
			for _, creature in ipairs(Game.getSpectators(position, false, false, RANGE_X, RANGE_X, RANGE_Y, RANGE_Y)) do
				local monster = creature:getMonster()
				if monster and not monster:getMaster() then
					if monster:getForgeStack() > 0 then
						forge = forge + 1
					elseif monster:isForgeable() and not isElite(monster) then
						candidates[#candidates + 1] = monster
					end
				end
			end
			local add = math.min(PER_TICK, TARGET_NEARBY - forge)
			if math.random(100) > CHANCE_PERCENT then
				add = 0
			end
			for _ = 1, add do
				if #candidates == 0 then
					break
				end
				local monster = table.remove(candidates, math.random(#candidates))
				-- przez funkcje gry, zeby serwer mial je na swojej liscie (inaczej przy smierci
				-- pisze ostrzezenie "Failed to remove a Influenced Monster")
				local fiendish = math.random(100) <= FIENDISH_PERCENT and (tonumber(Game.makeFiendishMonster(monster:getId())) or 0) > 0
				if not fiendish then
					makeInfluenced(monster, players)
				end
			end
		end
	end
	return true
end

tick:interval(TICK_MS)
tick:register()

-- Slivery: silnik daje je tylko z fiendish (forgeMinSlivers-forgeMaxSlivers w config-overrides.lua).
-- Dodatkowo kazdy zwykly potwor kuzni (influenced) wrzuca do zwlok stack x (1-3) sliverow.
local SLIVER_ID = 37109
local SLIVER_PER_STACK_MAX = 3

local sliverDrop = EventCallback("OtsInfluencedSlivers")

function sliverDrop.monsterPostDropLoot(monster, corpse)
	if not monster or not corpse or not corpse:isContainer() then
		return
	end
	if monster:getMonsterForgeClassification() ~= FORGE_INFLUENCED_MONSTER then
		return
	end
	local stack = monster:getForgeStack()
	if stack <= 0 then
		return
	end
	corpse:addItem(SLIVER_ID, stack * math.random(1, SLIVER_PER_STACK_MAX))
end

sliverDrop:register()
