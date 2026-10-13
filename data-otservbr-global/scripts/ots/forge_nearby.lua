-- OTS: potwory kuzni pojawiaja sie tam, gdzie gracz expi. Serwer sam losuje je z calej mapy,
-- wiec przy jednym graczu rzadko trafiaja na jego expowisko. Ten skrypt co kilka sekund dba,
-- zeby w poblizu gracza (poza PZ) byly zwykle 2 potwory kuzni; czasem zamiast nich fiendish.
local TICK_MS = 5000
local TARGET_NEARBY = 2
local CHANCE_PERCENT = 40 -- szansa na ture, ze brakujacy potwor kuzni sie pojawi
local FIENDISH_PERCENT = 4 -- z tego: szansa na czerwonego fiendish zamiast zwyklego

local function isElite(monster)
	return monster:getName():find("^Elite ") ~= nil or (OtsOutfitElite and OtsOutfitElite[monster:getId()])
end

local tick = GlobalEvent("OtsForgeNearbyTick")

function tick.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		local position = player:getPosition()
		local tile = Tile(position)
		if tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
			local forge, candidates = 0, {}
			for _, creature in ipairs(Game.getSpectators(position, false, false, 8, 8, 6, 6)) do
				local monster = creature:getMonster()
				if monster and not monster:getMaster() then
					if monster:getForgeStack() > 0 then
						forge = forge + 1
					elseif monster:isForgeable() and not isElite(monster) then
						candidates[#candidates + 1] = monster
					end
				end
			end
			if forge < TARGET_NEARBY and #candidates > 0 and math.random(100) <= CHANCE_PERCENT then
				local monster = candidates[math.random(#candidates)]
				if math.random(100) <= FIENDISH_PERCENT then
					monster:setMonsterForgeClassification(FORGE_FIENDISH_MONSTER)
				else
					monster:setMonsterForgeClassification(FORGE_INFLUENCED_MONSTER)
				end
				monster:configureForgeSystem()
			end
		end
	end
	return true
end

tick:interval(TICK_MS)
tick:register()
