-- OTS: wbudowany bot (jak ZeroBot), dzialajacy po stronie serwera. Menu: !bot
-- Healing (czary i potiony na HP i mane), Hunting (auto atak Chase/Stand, wybor celu,
-- czary i runy z liczeniem trafionych potworow), Tools (auto haste, auto jedzenie, anty-AFK),
-- Timery (uzycie przedmiotu albo tekst/czar co X s/min/h).
-- Ustawienia zapisuja sie osobno dla kazdej postaci (KV) i wczytuja przy logowaniu.
-- Czary, runy i przedmioty bot uzywa przez funkcje przechwycone w data/libs/functions/ots_bot_hooks.lua.

local H = OtsBotHooks or { spells = {}, spellsByName = {}, runes = {}, actions = {} }

local TICK_MS = 200
local KV_SCOPE = "ots-bot"
local INPUT_ITEM = 2814 -- pergamin z miejscem do wpisania tekstu (jak w wyszukiwarce expowisk)
local PARTY_CAKE = 6279 -- Infinite Food
local IDLE_KICK_MINUTES = 15 -- bez anty-AFK: wylogowanie po tylu minutach bezczynnosci (jak domyslnie w Canary)
local PAD = "                                        " -- poszerza okno, zeby dlugie pozycje sie miescily

OtsBotState = OtsBotState or {}
OtsBotAwaiting = OtsBotAwaiting or {}
OtsBotLoop = (OtsBotLoop or 0) + 1 -- numer petli; po przeladowaniu skryptow stara petla sama sie konczy
local LOOP_ID = OtsBotLoop

---------------------------------------------------------------------------
-- Zapis ustawien
---------------------------------------------------------------------------

local function serialize(value)
	local t = type(value)
	if t == "table" then
		local parts = {}
		for k, v in pairs(value) do
			local key = type(k) == "number" and ("[" .. k .. "]") or ("[" .. string.format("%q", tostring(k)) .. "]")
			parts[#parts + 1] = key .. "=" .. serialize(v)
		end
		return "{" .. table.concat(parts, ",") .. "}"
	elseif t == "string" then
		return string.format("%q", value)
	elseif t == "number" or t == "boolean" then
		return tostring(value)
	end
	return "nil"
end

local function deserialize(text)
	if type(text) ~= "string" or text == "" then
		return nil
	end
	local loader = loadstring or load
	local fn = loader("return " .. text)
	if not fn then
		return nil
	end
	if setfenv then
		setfenv(fn, {})
	end
	local ok, result = pcall(fn)
	if ok and type(result) == "table" then
		return result
	end
	return nil
end

local function defaults()
	return {
		on = false,
		autostart = true,
		antiAfk = true,
		heal = {}, -- { on, kind = "spell"|"potion", value = slowa|id, below = % }
		mana = {},
		hunt = {
			on = false,
			mode = "chase", -- chase | stand
			target = "smart", -- smart | nearest | lowhp | highhp
			retarget = true,
			range = 7,
			mark = true,
			ignore = {},
			spellsOn = true,
			list = {}, -- { on, kind = "spell"|"rune", value, min, mana, hp }
		},
		haste = { on = false, words = "utani hur", noPz = true },
		food = { on = false, item = 0 },
		timers = {}, -- { on, kind = "item"|"say", value, every = sekundy }
	}
end

-- uzupelnia brakujace pola (np. po dodaniu nowych opcji w przyszlosci)
local function merge(target, base)
	for k, v in pairs(base) do
		if target[k] == nil then
			target[k] = v
		elseif type(v) == "table" and type(target[k]) == "table" and #v == 0 and next(v) ~= nil then
			merge(target[k], v)
		end
	end
	return target
end

local function state(player)
	local id = player:getId()
	local st = OtsBotState[id]
	if not st then
		local saved = deserialize(player:kv():scoped(KV_SCOPE):get("config"))
		st = { cfg = merge(saved or {}, defaults()), nextPotion = 0, nextFood = 0, nextRetarget = 0, timers = {} }
		OtsBotState[id] = st
	end
	return st
end

local function save(player)
	local st = state(player)
	player:kv():scoped(KV_SCOPE):set("config", serialize(st.cfg))
end

---------------------------------------------------------------------------
-- Pomocnicze
---------------------------------------------------------------------------

local function trim(text)
	return ((text or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function onOff(value)
	return value and "[ON] " or "[OFF] "
end

local function inPz(position)
	local tile = Tile(position)
	return tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) or false
end

local function percent(value, maxValue)
	if not maxValue or maxValue <= 0 then
		return 100
	end
	return value * 100 / maxValue
end

local function itemName(id)
	local it = ItemType(id)
	if it and it:getId() ~= 0 then
		return it:getName()
	end
	return "ID " .. tostring(id)
end

local function parseItem(text)
	text = trim(text)
	local id = tonumber(text)
	if id then
		return id
	end
	local it = ItemType(text)
	if it and it:getId() ~= 0 then
		return it:getId()
	end
	return nil
end

-- "30", "30s", "5m", "1h", "1h 30m" -> sekundy
local function parseDuration(text)
	text = trim(text):lower()
	if tonumber(text) then
		return math.floor(tonumber(text))
	end
	local total, found = 0, false
	for number, unit in text:gmatch("(%d+)%s*([smhgd]?)") do
		local n = tonumber(number)
		if unit == "m" then
			n = n * 60
		elseif unit == "h" or unit == "g" then
			n = n * 3600
		end
		total = total + n
		found = true
	end
	return found and total or nil
end

local function durationText(seconds)
	if seconds % 3600 == 0 then
		return (seconds / 3600) .. "h"
	elseif seconds % 60 == 0 then
		return (seconds / 60) .. "min"
	end
	return seconds .. "s"
end

local function spellEntry(words)
	return words and H.spells[trim(words):lower()] or nil
end

-- czary, ktore profesja postaci w ogole moze rzucac (slowa -> true)
OtsBotVocationCache = {}
local function vocationSpells(player)
	local vocId = player:getVocation():getId()
	local set = OtsBotVocationCache[vocId]
	if not set then
		set = {}
		for _, info in ipairs(player:getInstantSpells()) do
			set[info.words:lower()] = info
		end
		OtsBotVocationCache[vocId] = set
	end
	return set
end

local function runeAllowed(player, entry)
	if entry.vocations == nil then
		entry.vocations = {}
		local list = entry.spell:vocation()
		if type(list) == "table" then
			for _, name in pairs(list) do
				if type(name) == "string" then
					entry.vocations[name:lower()] = true
				end
			end
		end
	end
	if next(entry.vocations) == nil then
		return true
	end
	return entry.vocations[player:getVocation():getName():lower()] == true
end

---------------------------------------------------------------------------
-- Rzucanie czarow i run, uzywanie przedmiotow
---------------------------------------------------------------------------

local function manaCost(player, spell)
	local cost = spell:mana() or 0
	if cost == 0 then
		local pct = spell:manaPercent() or 0
		if pct > 0 then
			cost = math.floor(player:getMaxMana() * pct / 100)
		end
	end
	return cost
end

local function onCooldown(player, spell)
	local id = spell:id()
	if id and id > 0 and player:hasCondition(CONDITION_SPELLCOOLDOWN, id) then
		return true
	end
	local group, secondary = spell:group()
	if group and group > 0 and player:hasCondition(CONDITION_SPELLGROUPCOOLDOWN, group) then
		return true
	end
	if secondary and secondary > 0 and player:hasCondition(CONDITION_SPELLGROUPCOOLDOWN, secondary) then
		return true
	end
	return false
end

local function addCooldowns(player, spell)
	local cooldown = spell:cooldown() or 0
	local id = spell:id() or 0
	if cooldown > 0 and id > 0 then
		local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, id)
		condition:setTicks(cooldown)
		player:addCondition(condition)
	end
	local group, secondary = spell:group()
	local groupCooldown, secondaryCooldown = spell:groupCooldown()
	if group and group > 0 and (groupCooldown or 0) > 0 then
		local condition = Condition(CONDITION_SPELLGROUPCOOLDOWN, CONDITIONID_DEFAULT, group)
		condition:setTicks(groupCooldown)
		player:addCondition(condition)
	end
	if secondary and secondary > 0 and (secondaryCooldown or 0) > 0 then
		local condition = Condition(CONDITION_SPELLGROUPCOOLDOWN, CONDITIONID_DEFAULT, secondary)
		condition:setTicks(secondaryCooldown)
		player:addCondition(condition)
	end
end

-- czy postac moze teraz rzucic ten czar/rune (poziom, mlvl, mana, soul, cooldown, PZ)
local function canCast(player, entry, vocSet)
	local spell = entry.spell
	if entry.rune then
		if not runeAllowed(player, entry) or player:getItemCount(entry.rune) < 1 then
			return false
		end
	elseif vocSet and not vocSet[entry.words:lower()] then
		return false
	end
	if player:getLevel() < (spell:level() or 0) or player:getMagicLevel() < (spell:magicLevel() or 0) then
		return false
	end
	if manaCost(player, spell) > player:getMana() then
		return false
	end
	if (spell:soul() or 0) > player:getSoul() then
		return false
	end
	if spell:isAggressive() and (inPz(player:getPosition()) or player:hasCondition(CONDITION_PACIFIED)) then
		return false
	end
	if onCooldown(player, spell) then
		return false
	end
	return true
end

local function doCast(player, entry, variant)
	local spell = entry.spell
	if entry.rune then
		variant.runeName = entry.name or ""
	else
		variant.instantName = entry.name or ""
	end
	local ok, result = pcall(entry.cb, player, variant, true)
	if not ok then
		logger.error("[OTS bot] Blad czaru {}: {}", entry.name or "?", tostring(result))
		return false
	end
	if result == false then
		return false
	end
	local cost = manaCost(player, spell)
	if cost > 0 then
		player:addManaSpent(cost)
		player:addMana(-cost)
	end
	local soul = spell:soul() or 0
	if soul > 0 then
		player:addSoul(-soul)
	end
	addCooldowns(player, spell)
	if not entry.rune and entry.words then
		player:say(entry.words, TALKTYPE_MONSTER_SAY) -- jak czary jako emote (pomaranczowy tekst)
	end
	return true
end

-- wariant celu tak jak przy rzucaniu przez gracza (InstantSpell::playerCastInstant)
local function instantVariant(player, entry, target)
	local spell = entry.spell
	if spell:isSelfTarget() then
		return Variant(player:getId())
	end
	if spell:needTarget() or spell:needCasterTargetOrDirection() then
		if target then
			return Variant(target:getId())
		end
		if spell:needCasterTargetOrDirection() then
			return Variant(player:getPosition())
		end
		return nil
	end
	return Variant(player:getPosition())
end

-- rzuca czar natychmiastowy po slowach (healing, haste, timery); zwraca true po udanym rzucie
local function castWords(player, words, target, vocSet)
	local entry = spellEntry(words)
	if not entry or entry.rune then
		return false
	end
	if not canCast(player, entry, vocSet or vocationSpells(player)) then
		return false
	end
	local variant = instantVariant(player, entry, target)
	if not variant then
		return false
	end
	return doCast(player, entry, variant)
end

local CONTAINER_FROM = Position(CONTAINER_POSITION, 64, 0)

-- uzywa przedmiotu z plecaka na postaci (potiony, jedzenie, timery)
local function useItem(player, itemId)
	local action = H.actions[itemId]
	if not action then
		return false, "ten przedmiot nie ma akcji uzycia"
	end
	local item = player:getItemById(itemId, true)
	if not item then
		return false, "brak przedmiotu"
	end
	local ok, result = pcall(action.cb, player, item, CONTAINER_FROM, player, player:getPosition(), true)
	if not ok then
		logger.error("[OTS bot] Blad uzycia przedmiotu {}: {}", itemId, tostring(result))
		return false, "blad skryptu"
	end
	return result ~= false
end

local function potionDelay()
	local delay = configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) or 1000
	return math.max(delay, 200)
end

---------------------------------------------------------------------------
-- Healing
---------------------------------------------------------------------------

local function runHealing(player, st, now, vocSet)
	local cfg = st.cfg
	local hp = percent(player:getHealth(), player:getMaxHealth())
	local mp = percent(player:getMana(), player:getMaxMana())
	local castDone, potionDone = false, now < st.nextPotion

	for _, rule in ipairs(cfg.heal) do
		if rule.on and hp < rule.below then
			if rule.kind == "spell" and not castDone then
				castDone = castWords(player, rule.value, nil, vocSet)
			elseif rule.kind == "potion" and not potionDone then
				if useItem(player, rule.value) then
					potionDone = true
					st.nextPotion = now + potionDelay()
				end
			end
		end
	end
	for _, rule in ipairs(cfg.mana) do
		if rule.on and mp < rule.below then
			if rule.kind == "potion" and not potionDone then
				if useItem(player, rule.value) then
					potionDone = true
					st.nextPotion = now + potionDelay()
				end
			elseif rule.kind == "spell" and not castDone then
				castDone = castWords(player, rule.value, nil, vocSet)
			end
		end
	end
end

---------------------------------------------------------------------------
-- Hunting
---------------------------------------------------------------------------

local function posKey(x, y)
	return x * 65536 + y
end

local function monstersAround(player, cfg)
	local pos = player:getPosition()
	local range = math.max(1, math.min(cfg.hunt.range or 7, 10))
	local ignore = {}
	for _, name in ipairs(cfg.hunt.ignore or {}) do
		ignore[name:lower()] = true
	end
	local list, grid = {}, {}
	for _, creature in ipairs(Game.getSpectators(pos, false, false, range, range, range, range)) do
		if creature:isMonster() and not creature:getMaster() and creature:getHealth() > 0 then
			local cpos = creature:getPosition()
			local mtype = creature:getType()
			local attackable = not (mtype and mtype.isAttackable) or mtype:isAttackable()
			if attackable and cpos.z == pos.z and not ignore[creature:getName():lower()] and not inPz(cpos) and pos:isSightClear(cpos, true) then
				list[#list + 1] = creature
				local key = posKey(cpos.x, cpos.y)
				grid[key] = (grid[key] or 0) + 1
			end
		end
	end
	return list, grid
end

local function distance(a, b)
	return math.max(math.abs(a.x - b.x), math.abs(a.y - b.y))
end

local function neighbours(creature, grid)
	local p = creature:getPosition()
	local count = 0
	for dx = -1, 1 do
		for dy = -1, 1 do
			if dx ~= 0 or dy ~= 0 then
				count = count + (grid[posKey(p.x + dx, p.y + dy)] or 0)
			end
		end
	end
	return count
end

-- wynik celu: im wiekszy, tym lepszy
local function targetScore(player, creature, grid, mode)
	local ppos = player:getPosition()
	local dist = distance(ppos, creature:getPosition())
	if mode == "nearest" then
		return -dist
	elseif mode == "lowhp" then
		return -percent(creature:getHealth(), creature:getMaxHealth()) * 100 - dist
	elseif mode == "highhp" then
		return percent(creature:getHealth(), creature:getMaxHealth()) * 100 - dist
	end
	return neighbours(creature, grid) * 100 - dist -- smart: najwiecej potworow wokol celu
end

local function setMark(player, st, creature)
	if creature and st.markedId == creature:getId() and st.cfg.hunt.mark then
		return
	end
	local old = st.markedId and Creature(st.markedId)
	if old and (not creature or old:getId() ~= creature:getId()) then
		old:removeIcon("otsbot")
	end
	st.markedId = nil
	if creature and st.cfg.hunt.mark then
		creature:setIcon("otsbot", CreatureIconCategory_Quests, CreatureIconQuests_RedCross)
		st.markedId = creature:getId()
	end
end

local function runTargeting(player, st, now, list, grid)
	local hunt = st.cfg.hunt
	local current = player:getTarget()
	local currentValid = false
	if current and current:isMonster() and current:getHealth() > 0 then
		for _, m in ipairs(list) do
			if m:getId() == current:getId() then
				currentValid = true
				break
			end
		end
	end

	-- cel wybrany recznie przez gracza zostaje, dopoki jest w zasiegu
	if inPz(player:getPosition()) then
		setMark(player, st, nil)
		return currentValid and current or nil
	end
	local manual = current and currentValid and st.botTarget ~= current:getId()
	local target = currentValid and current or nil

	if not manual and #list > 0 and (not target or (hunt.retarget and now >= st.nextRetarget)) then
		local best, bestScore = nil, nil
		for _, m in ipairs(list) do
			local score = targetScore(player, m, grid, hunt.target)
			if not bestScore or score > bestScore then
				best, bestScore = m, score
			end
		end
		if target and best ~= target then
			-- zmiana tylko na wyraznie lepszy cel, zeby nie skakac co chwile
			local currentScore = targetScore(player, target, grid, hunt.target)
			if bestScore - currentScore < 150 then
				best = target
			end
		end
		st.nextRetarget = now + 1000
		if best and (not target or best:getId() ~= target:getId()) then
			if player:setTarget(best) then
				target = best
				st.botTarget = best:getId()
			end
		end
	end

	if target then
		if hunt.mode == "chase" then
			local follow = player:getFollowCreature()
			if not follow or follow:getId() ~= target:getId() then
				player:setFollowCreature(target)
			end
		elseif player:getFollowCreature() then
			player:setFollowCreature(nil)
		end
	end
	setMark(player, st, target)
	return target
end

local DIRECTIONS = { DIRECTION_NORTH, DIRECTION_EAST, DIRECTION_SOUTH, DIRECTION_WEST }

-- obrot przesuniecia z ukladu "na polnoc" w strone kierunku
local function rotate(dx, dy, dir)
	if dir == DIRECTION_EAST then
		return -dy, dx
	elseif dir == DIRECTION_SOUTH then
		return -dx, -dy
	elseif dir == DIRECTION_WEST then
		return dy, -dx
	end
	return dx, dy
end

local function countHits(offsets, cx, cy, grid, dir)
	local hits = 0
	for _, o in ipairs(offsets) do
		local dx, dy = o[1], o[2]
		if dir then
			dx, dy = rotate(dx, dy, dir)
		end
		hits = hits + (grid[posKey(cx + dx, cy + dy)] or 0)
	end
	return hits
end

local function inSpellRange(player, spell, pos)
	local range = spell:range() or 0
	if range <= 0 then
		range = 7
	end
	local ppos = player:getPosition()
	return distance(ppos, pos) <= range and ppos:isSightClear(pos, true)
end

-- planuje uzycie czaru/runy z listy: zwraca wariant (i kierunek) albo nil
local function planAttack(player, entry, item, target, list, grid)
	local spell = entry.spell
	local ppos = player:getPosition()
	local need = math.max(1, item.min or 1)

	if entry.rune then
		if spell:needTarget() then
			if target and inSpellRange(player, spell, target:getPosition()) then
				local tpos = target:getPosition()
				local hits = entry.offsets and countHits(entry.offsets, tpos.x, tpos.y, grid) or 1
				if hits >= need then
					return Variant(target:getId())
				end
			end
			return nil
		end
		if not entry.offsets then
			if target and need <= 1 and inSpellRange(player, spell, target:getPosition()) then
				return Variant(target:getPosition())
			end
			return nil
		end
		-- runa obszarowa: srodek tam, gdzie trafi najwiecej potworow
		local bestPos, bestHits = nil, 0
		local tried = {}
		for _, m in ipairs(list) do
			local mpos = m:getPosition()
			for dx = -1, 1 do
				for dy = -1, 1 do
					local key = posKey(mpos.x + dx, mpos.y + dy)
					if not tried[key] then
						tried[key] = true
						local hits = countHits(entry.offsets, mpos.x + dx, mpos.y + dy, grid)
						if hits > bestHits then
							local center = Position(mpos.x + dx, mpos.y + dy, mpos.z)
							if inSpellRange(player, spell, center) then
								bestPos, bestHits = center, hits
							end
						end
					end
				end
			end
		end
		if bestPos and bestHits >= need then
			return Variant(bestPos)
		end
		return nil
	end

	-- czar natychmiastowy
	if spell:isSelfTarget() then
		return #list >= need and Variant(player:getId()) or nil
	end
	if spell:needTarget() then
		if not target or not inSpellRange(player, spell, target:getPosition()) then
			return nil
		end
		local tpos = target:getPosition()
		local hits = entry.offsets and countHits(entry.offsets, tpos.x, tpos.y, grid) or 1
		return hits >= need and Variant(target:getId()) or nil
	end
	if spell:needDirection() then
		local offsets = entry.offsets
		if not offsets then
			offsets = {}
			for i = 1, 5 do
				offsets[i] = { 0, -i }
			end
		end
		local bestDir, bestHits = nil, 0
		local current = player:getDirection()
		for _, dir in ipairs(DIRECTIONS) do
			local hits = countHits(offsets, ppos.x, ppos.y, grid, dir)
			if hits > bestHits or (hits == bestHits and hits > 0 and dir == current) then
				bestDir, bestHits = dir, hits
			end
		end
		if bestDir and bestHits >= need then
			return Variant(ppos), bestDir
		end
		return nil
	end
	if entry.offsets then
		local hits = countHits(entry.offsets, ppos.x, ppos.y, grid)
		return hits >= need and Variant(ppos) or nil
	end
	if spell:needCasterTargetOrDirection() and target then
		return Variant(target:getId())
	end
	return #list >= need and Variant(ppos) or nil
end

local function attackEntry(item)
	if item.kind == "rune" then
		return H.runes[item.value]
	end
	return spellEntry(item.value)
end

local function runAttackSpells(player, st, target, list, grid, vocSet)
	if #list == 0 then
		return
	end
	local hp = percent(player:getHealth(), player:getMaxHealth())
	local mp = percent(player:getMana(), player:getMaxMana())
	for _, item in ipairs(st.cfg.hunt.list) do
		if item.on and mp >= (item.mana or 0) and hp >= (item.hp or 0) then
			local entry = attackEntry(item)
			if entry and canCast(player, entry, vocSet) then
				local variant, dir = planAttack(player, entry, item, target, list, grid)
				if variant then
					if dir then
						player:setDirection(dir)
					end
					if doCast(player, entry, variant) then
						return
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------
-- Tools i timery
---------------------------------------------------------------------------

local function foodIds()
	if not OtsBotFoodIds then
		OtsBotFoodIds = {}
		for id, action in pairs(H.actions) do
			local src = action.source or ""
			if src:find("items/foods.lua", 1, true) and id ~= PARTY_CAKE then
				OtsBotFoodIds[#OtsBotFoodIds + 1] = id
			end
		end
	end
	return OtsBotFoodIds
end

local function runTools(player, st, now, vocSet)
	local cfg = st.cfg
	if cfg.haste.on and not player:hasCondition(CONDITION_HASTE) then
		if not (cfg.haste.noPz and inPz(player:getPosition())) then
			castWords(player, cfg.haste.words, nil, vocSet)
		end
	end

	if cfg.food.on and now >= st.nextFood then
		st.nextFood = now + 5000
		local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
		local left = condition and condition:getTicks() / 1000 or 0
		if left < 300 then
			local chosen = nil
			if (cfg.food.item or 0) > 0 then
				chosen = player:getItemCount(cfg.food.item) > 0 and cfg.food.item or nil
			end
			if not chosen and H.actions[PARTY_CAKE] and player:getItemCount(PARTY_CAKE) > 0 then
				chosen = PARTY_CAKE
			end
			if not chosen then
				for _, id in ipairs(foodIds()) do
					if player:getItemCount(id) > 0 then
						chosen = id
						break
					end
				end
			end
			if chosen then
				useItem(player, chosen)
			end
		end
	end

	for index, timer in ipairs(cfg.timers) do
		if timer.on and (timer.every or 0) > 0 then
			local due = st.timers[index]
			if not due then
				st.timers[index] = now + timer.every * 1000
			elseif now >= due then
				local done
				if timer.kind == "item" then
					done = useItem(player, timer.value)
				else
					done = castWords(player, timer.value, player:getTarget(), vocSet)
					if not done and not spellEntry(timer.value) then
						player:say(timer.value, TALKTYPE_SAY)
						done = true
					end
				end
				-- nieudane (np. cooldown, brak many) probuje ponownie za sekunde
				st.timers[index] = done and (now + timer.every * 1000) or (now + 1000)
			end
		end
	end
end

local function runIdle(player, st)
	if st.cfg.antiAfk then
		st.idleWarned = nil
		return
	end
	local idle = player:getIdleTime()
	if idle >= (IDLE_KICK_MINUTES + 1) * 60000 then
		player:remove()
	elseif idle >= IDLE_KICK_MINUTES * 60000 and not st.idleWarned then
		st.idleWarned = true
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Brak aktywnosci od " .. IDLE_KICK_MINUTES .. " minut. Za minute zostaniesz wylogowany (wlacz Anty-AFK w !bot > Tools).")
	elseif idle < IDLE_KICK_MINUTES * 60000 then
		st.idleWarned = nil
	end
end

---------------------------------------------------------------------------
-- Petla bota
---------------------------------------------------------------------------

local function tickPlayer(player, now)
	local st = state(player)
	runIdle(player, st)
	local cfg = st.cfg
	if not cfg.on then
		if st.markedId then
			setMark(player, st, nil)
		end
		return
	end
	local vocSet = vocationSpells(player)
	runHealing(player, st, now, vocSet)
	runTools(player, st, now, vocSet)
	if cfg.hunt.on or cfg.hunt.spellsOn then
		local list, grid = monstersAround(player, cfg)
		local target = nil
		if cfg.hunt.on then
			target = runTargeting(player, st, now, list, grid)
		else
			target = player:getTarget()
			if target and not target:isMonster() then
				target = nil
			end
		end
		if cfg.hunt.spellsOn then
			runAttackSpells(player, st, target, list, grid, vocSet)
		end
	end
end

local function loop(loopId)
	if loopId ~= OtsBotLoop then
		return
	end
	local now = systemTime()
	for _, player in ipairs(Game.getPlayers()) do
		local ok, err = pcall(tickPlayer, player, now)
		if not ok then
			logger.error("[OTS bot] {}: {}", player:getName(), tostring(err))
		end
	end
	for id in pairs(OtsBotState) do
		if not Player(id) then
			OtsBotState[id] = nil
			OtsBotAwaiting[id] = nil
		end
	end
	addEvent(loop, TICK_MS, loopId)
end

local function ensureLoop()
	if OtsBotLoopRunning ~= LOOP_ID then
		OtsBotLoopRunning = LOOP_ID
		addEvent(loop, TICK_MS, LOOP_ID)
	end
end

local startup = GlobalEvent("OtsBotStartup")
function startup.onStartup()
	ensureLoop()
	return true
end
startup:register()

---------------------------------------------------------------------------
-- Okna (menu)
---------------------------------------------------------------------------

local openMain, openHealing, openHunting, openAttackList, openTools, openTimers

local function menu(player, title, message, choices, back)
	local window = ModalWindow({ title = title, message = message .. PAD })
	for i = 1, math.min(#choices, 255) do
		local c = choices[i]
		window:addChoice(c[1], c[2])
	end
	window:addButton("Wybierz")
	if back then
		window:addButton("Wstecz", function(target)
			back(target)
		end)
	else
		window:addButton("Zamknij", function() end)
	end
	window:setPriority(true)
	-- klient 15.x czyta te pola odwrotnie: Enter = przycisk 1, Esc = przycisk 2
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local function ask(player, prompt, current, onText)
	OtsBotAwaiting[player:getId()] = onText
	player:registerEvent("OtsBotInput")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bot: " .. prompt .. " Wpisz w okienku i zatwierdz OK.")
	player:showTextDialog(INPUT_ITEM, tostring(current or ""), true, 250)
end

local input = CreatureEvent("OtsBotInput")
function input.onTextEdit(player, item, text)
	local callback = OtsBotAwaiting[player:getId()]
	if not callback then
		return true
	end
	OtsBotAwaiting[player:getId()] = nil
	callback(player, trim(text))
	return false
end
input:register()

local function changed(player, reopen)
	save(player)
	reopen(player)
end

local function askNumber(player, prompt, current, minValue, maxValue, apply, reopen)
	ask(player, prompt .. " (" .. minValue .. "-" .. maxValue .. ")", current, function(p, text)
		local n = tonumber((text:gsub("%%", "")))
		if not n or n < minValue or n > maxValue then
			p:sendCancelMessage("Bot: podaj liczbe od " .. minValue .. " do " .. maxValue .. ".")
		else
			apply(math.floor(n))
			save(p)
		end
		reopen(p)
	end)
end

-- wybor czaru z listy czarow profesji
local function pickSpell(player, title, filter, onPick, back)
	local spells = {}
	for _, info in ipairs(player:getInstantSpells()) do
		local entry = spellEntry(info.words)
		if entry and (not filter or filter(entry, info)) then
			spells[#spells + 1] = info
		end
	end
	table.sort(spells, function(a, b)
		if a.level ~= b.level then
			return a.level < b.level
		end
		return a.name < b.name
	end)
	local choices = {
		{ ">> Wpisz slowa czaru recznie", function(p)
			ask(p, "slowa czaru, np. exura gran.", "", function(p2, text)
				if spellEntry(text) then
					onPick(p2, text:lower())
				else
					p2:sendCancelMessage("Bot: nie ma czaru \"" .. text .. "\".")
					back(p2)
				end
			end)
		end },
	}
	for _, info in ipairs(spells) do
		local mana = info.manapercent > 0 and (info.manapercent .. "%") or tostring(info.mana)
		choices[#choices + 1] = { string.format("%s - %s (lvl %d, mana %s)", info.words, info.name, info.level, mana), function(p)
			onPick(p, info.words:lower())
		end }
	end
	menu(player, title, "Wybierz czar z listy (czary Twojej profesji) albo wpisz slowa recznie.", choices, back)
end

local function pickItem(player, title, ids, onPick, back)
	table.sort(ids, function(a, b)
		local ha, hb = player:getItemCount(a) > 0, player:getItemCount(b) > 0
		if ha ~= hb then
			return ha
		end
		return itemName(a) < itemName(b)
	end)
	local choices = {
		{ ">> Wpisz ID albo nazwe przedmiotu", function(p)
			ask(p, "ID albo nazwa przedmiotu.", "", function(p2, text)
				local id = parseItem(text)
				if id then
					onPick(p2, id)
				else
					p2:sendCancelMessage("Bot: nie ma przedmiotu \"" .. text .. "\".")
					back(p2)
				end
			end)
		end },
	}
	for _, id in ipairs(ids) do
		local count = player:getItemCount(id)
		choices[#choices + 1] = { string.format("%s (ID %d)%s", itemName(id), id, count > 0 and (" - masz " .. count) or ""), function(p)
			onPick(p, id)
		end }
	end
	menu(player, title, "Wybierz z listy albo wpisz ID / nazwe.", choices, back)
end

local function potionIds()
	local ids = {}
	for id, action in pairs(H.actions) do
		if (action.source or ""):find("items/potions.lua", 1, true) then
			ids[#ids + 1] = id
		end
	end
	return ids
end

local function runeIds(player)
	local ids = {}
	for id, entry in pairs(H.runes) do
		if runeAllowed(player, entry) and entry.spell:isAggressive() then
			ids[#ids + 1] = id
		end
	end
	return ids
end

local function moveInList(list, index, delta)
	local other = index + delta
	if other >= 1 and other <= #list then
		list[index], list[other] = list[other], list[index]
		return other
	end
	return index
end

-- Healing -------------------------------------------------------------------

local function ruleLabel(rule, what)
	local value = rule.kind == "potion" and itemName(rule.value) or rule.value
	return string.format("%s%s < %d%%: %s (%s)", onOff(rule.on), what, rule.below, value, rule.kind == "potion" and "potion" or "czar")
end

local function openRule(player, listName, index)
	local cfg = state(player).cfg
	local list = cfg[listName]
	local rule = list[index]
	if not rule then
		return openHealing(player)
	end
	local what = listName == "heal" and "HP" or "Mana"
	local reopen = function(p)
		openRule(p, listName, index)
	end
	local choices = {
		{ onOff(rule.on) .. "Regula wlaczona", function(p)
			rule.on = not rule.on
			changed(p, reopen)
		end },
		{ string.format("Prog: ponizej %d%% %s (zmien)", rule.below, what), function(p)
			askNumber(p, "prog " .. what .. " w %", rule.below, 1, 100, function(n)
				rule.below = n
			end, reopen)
		end },
	}
	if rule.kind == "spell" then
		choices[#choices + 1] = { "Czar: " .. rule.value .. " (zmien)", function(p)
			pickSpell(p, "Czar - " .. what, nil, function(p2, words)
				rule.value = words
				changed(p2, reopen)
			end, reopen)
		end }
	else
		choices[#choices + 1] = { "Potion: " .. itemName(rule.value) .. " (zmien)", function(p)
			pickItem(p, "Potion - " .. what, potionIds(), function(p2, id)
				rule.value = id
				changed(p2, reopen)
			end, reopen)
		end }
	end
	choices[#choices + 1] = { "Przesun wyzej (wyzszy priorytet)", function(p)
		index = moveInList(list, index, -1)
		changed(p, reopen)
	end }
	choices[#choices + 1] = { "Przesun nizej", function(p)
		index = moveInList(list, index, 1)
		changed(p, reopen)
	end }
	choices[#choices + 1] = { "Usun regule", function(p)
		table.remove(list, index)
		changed(p, openHealing)
	end }
	menu(player, "Regula " .. what, ruleLabel(rule, what), choices, openHealing)
end

local function addRule(player, listName, kind)
	local what = listName == "heal" and "HP" or "Mana"
	local function finish(p, value)
		local list = state(p).cfg[listName]
		list[#list + 1] = { on = true, kind = kind, value = value, below = listName == "heal" and 70 or 50 }
		save(p)
		openRule(p, listName, #list)
	end
	if kind == "spell" then
		local filter = nil
		if listName == "heal" then
			filter = function(entry)
				return not entry.spell:isAggressive()
			end
		end
		pickSpell(player, "Nowa regula " .. what .. " - czar", filter, finish, openHealing)
	else
		pickItem(player, "Nowa regula " .. what .. " - potion", potionIds(), finish, openHealing)
	end
end

openHealing = function(player)
	local cfg = state(player).cfg
	local choices = {}
	for i, rule in ipairs(cfg.heal) do
		choices[#choices + 1] = { i .. ". " .. ruleLabel(rule, "HP"), function(p)
			openRule(p, "heal", i)
		end }
	end
	for i, rule in ipairs(cfg.mana) do
		choices[#choices + 1] = { i .. ". " .. ruleLabel(rule, "Mana"), function(p)
			openRule(p, "mana", i)
		end }
	end
	choices[#choices + 1] = { ">> Dodaj: HP - czar", function(p)
		addRule(p, "heal", "spell")
	end }
	choices[#choices + 1] = { ">> Dodaj: HP - potion", function(p)
		addRule(p, "heal", "potion")
	end }
	choices[#choices + 1] = { ">> Dodaj: Mana - potion", function(p)
		addRule(p, "mana", "potion")
	end }
	choices[#choices + 1] = { ">> Dodaj: Mana - czar", function(p)
		addRule(p, "mana", "spell")
	end }
	menu(player, "Bot - Healing", "Reguly sprawdzane od gory (co 0,2 s). Czar i potion moga zadzialac w tej samej chwili; HP ma pierwszenstwo przed mana.", choices, openMain)
end

-- Hunting -------------------------------------------------------------------

local TARGET_MODES = {
	{ "smart", "Smart - najwiecej potworow wokol celu" },
	{ "nearest", "Najblizszy" },
	{ "lowhp", "Najmniej HP (%)" },
	{ "highhp", "Najwiecej HP (%)" },
}

local function targetModeName(mode)
	for _, m in ipairs(TARGET_MODES) do
		if m[1] == mode then
			return m[2]
		end
	end
	return mode
end

local function attackLabel(item)
	local name = item.kind == "rune" and itemName(item.value) or item.value
	local extra = {}
	extra[#extra + 1] = "min " .. (item.min or 1) .. " potw."
	if (item.mana or 0) > 0 then
		extra[#extra + 1] = "mana >= " .. item.mana .. "%"
	end
	if (item.hp or 0) > 0 then
		extra[#extra + 1] = "HP >= " .. item.hp .. "%"
	end
	return string.format("%s%s (%s, %s)", onOff(item.on), name, item.kind == "rune" and "runa" or "czar", table.concat(extra, ", "))
end

local function areaText(item)
	local entry = attackEntry(item)
	if not entry then
		return "nie znaleziono czaru/runy na serwerze"
	end
	local spell = entry.spell
	local area = entry.offsets and (#entry.offsets .. " pol") or "brak"
	local kind
	if spell:needDirection() then
		kind = "kierunkowy (bot obraca postac w strone, gdzie trafi najwiecej)"
	elseif spell:needTarget() then
		kind = "na cel"
	elseif entry.rune then
		kind = "na pole (bot wybiera srodek z najwieksza liczba trafien)"
	else
		kind = "wokol postaci"
	end
	return "Typ: " .. kind .. ", obszar: " .. area .. "."
end

local function openAttackItem(player, index)
	local hunt = state(player).cfg.hunt
	local item = hunt.list[index]
	if not item then
		return openAttackList(player)
	end
	local reopen = function(p)
		openAttackItem(p, index)
	end
	local choices = {
		{ onOff(item.on) .. "Pozycja wlaczona", function(p)
			item.on = not item.on
			changed(p, reopen)
		end },
		{ "Minimum potworow w zasiegu: " .. (item.min or 1) .. " (zmien)", function(p)
			askNumber(p, "minimalna liczba trafionych potworow", item.min or 1, 1, 30, function(n)
				item.min = n
			end, reopen)
		end },
		{ "Minimum many: " .. (item.mana or 0) .. "% (zmien)", function(p)
			askNumber(p, "minimum many w % (0 = bez limitu)", item.mana or 0, 0, 100, function(n)
				item.mana = n
			end, reopen)
		end },
		{ "Minimum HP: " .. (item.hp or 0) .. "% (zmien)", function(p)
			askNumber(p, "minimum HP w % (0 = bez limitu)", item.hp or 0, 0, 100, function(n)
				item.hp = n
			end, reopen)
		end },
		{ "Przesun wyzej (wyzszy priorytet)", function(p)
			index = moveInList(hunt.list, index, -1)
			changed(p, reopen)
		end },
		{ "Przesun nizej", function(p)
			index = moveInList(hunt.list, index, 1)
			changed(p, reopen)
		end },
		{ "Usun z listy", function(p)
			table.remove(hunt.list, index)
			changed(p, openAttackList)
		end },
	}
	menu(player, "Czar / runa", attackLabel(item) .. "\n" .. areaText(item), choices, openAttackList)
end

openAttackList = function(player)
	local hunt = state(player).cfg.hunt
	local choices = {}
	for i, item in ipairs(hunt.list) do
		choices[#choices + 1] = { i .. ". " .. attackLabel(item), function(p)
			openAttackItem(p, i)
		end }
	end
	local function add(p, kind, value)
		local list = state(p).cfg.hunt.list
		list[#list + 1] = { on = true, kind = kind, value = value, min = 1, mana = 0, hp = 0 }
		save(p)
		openAttackItem(p, #list)
	end
	choices[#choices + 1] = { ">> Dodaj czar", function(p)
		pickSpell(p, "Nowy czar ataku", function(entry)
			return entry.spell:isAggressive()
		end, function(p2, words)
			add(p2, "spell", words)
		end, openAttackList)
	end }
	choices[#choices + 1] = { ">> Dodaj rune", function(p)
		pickItem(p, "Nowa runa", runeIds(p), function(p2, id)
			if not H.runes[id] then
				p2:sendCancelMessage("Bot: to nie jest runa.")
				return openAttackList(p2)
			end
			add(p2, "rune", id)
		end, openAttackList)
	end }
	menu(player, "Bot - Czary i runy", "Lista sprawdzana od gory: bot rzuca pierwsza pozycje, ktora ma cooldown gotowy, mane i wymagana liczbe potworow.", choices, openHunting)
end

openHunting = function(player)
	local hunt = state(player).cfg.hunt
	local reopen = openHunting
	local choices = {
		{ onOff(hunt.on) .. "Auto atak (bot wybiera cel)", function(p)
			hunt.on = not hunt.on
			if not hunt.on then
				setMark(p, state(p), nil)
			end
			changed(p, reopen)
		end },
		{ "Tryb: " .. (hunt.mode == "chase" and "Chase (podchodzi do celu)" or "Stand (stoi w miejscu)") .. " - zmien", function(p)
			hunt.mode = hunt.mode == "chase" and "stand" or "chase"
			changed(p, reopen)
		end },
		{ "Wybor celu: " .. targetModeName(hunt.target) .. " (zmien)", function(p)
			local modes = {}
			for _, m in ipairs(TARGET_MODES) do
				modes[#modes + 1] = { m[2], function(p2)
					hunt.target = m[1]
					changed(p2, reopen)
				end }
			end
			menu(p, "Wybor celu", "Jak bot ma wybierac potwora do ataku.", modes, reopen)
		end },
		{ onOff(hunt.retarget) .. "Zmieniaj cel na wyraznie lepszy", function(p)
			hunt.retarget = not hunt.retarget
			changed(p, reopen)
		end },
		{ "Zasieg szukania: " .. hunt.range .. " kratek (zmien)", function(p)
			askNumber(p, "zasieg szukania potworow w kratkach", hunt.range, 1, 10, function(n)
				hunt.range = n
			end, reopen)
		end },
		{ onOff(hunt.mark) .. "Oznaczaj cel bota ikonka", function(p)
			hunt.mark = not hunt.mark
			if not hunt.mark then
				setMark(p, state(p), nil)
			end
			changed(p, reopen)
		end },
		{ "Ignorowane potwory: " .. (#hunt.ignore > 0 and table.concat(hunt.ignore, ", ") or "brak") .. " (zmien)", function(p)
			ask(p, "nazwy potworow do pomijania, oddzielone przecinkami (puste = brak).", table.concat(hunt.ignore, ", "), function(p2, text)
				local list = {}
				for name in text:gmatch("[^,\n]+") do
					name = trim(name)
					if name ~= "" then
						list[#list + 1] = name
					end
				end
				hunt.ignore = list
				changed(p2, reopen)
			end)
		end },
		{ onOff(hunt.spellsOn) .. "Uzywaj czarow i run z listy", function(p)
			hunt.spellsOn = not hunt.spellsOn
			changed(p, reopen)
		end },
		{ "Lista czarow i run (" .. #hunt.list .. ") >", function(p)
			openAttackList(p)
		end },
	}
	menu(player, "Bot - Hunting", "Cel wybrany recznie (klikniecie w kliencie) bot zostawia, dopoki jest w zasiegu.", choices, openMain)
end

-- Tools ---------------------------------------------------------------------

openTools = function(player)
	local cfg = state(player).cfg
	local reopen = openTools
	local choices = {
		{ onOff(cfg.haste.on) .. "Auto haste: " .. cfg.haste.words, function(p)
			cfg.haste.on = not cfg.haste.on
			changed(p, reopen)
		end },
		{ "Czar haste: " .. cfg.haste.words .. " (zmien)", function(p)
			pickSpell(p, "Czar haste", function(entry)
				return (entry.words or ""):lower():find("utani", 1, true) ~= nil
			end, function(p2, words)
				cfg.haste.words = words
				changed(p2, reopen)
			end, reopen)
		end },
		{ onOff(cfg.haste.noPz) .. "Haste tylko poza strefa ochronna (PZ)", function(p)
			cfg.haste.noPz = not cfg.haste.noPz
			changed(p, reopen)
		end },
		{ onOff(cfg.food.on) .. "Auto jedzenie", function(p)
			cfg.food.on = not cfg.food.on
			changed(p, reopen)
		end },
		{ "Jedzenie: " .. ((cfg.food.item or 0) > 0 and itemName(cfg.food.item) or "dowolne z plecaka (najpierw Infinite Food)") .. " (zmien)", function(p)
			ask(p, "ID albo nazwa jedzenia (0 = dowolne z plecaka).", cfg.food.item or 0, function(p2, text)
				if text == "0" or text == "" then
					cfg.food.item = 0
				else
					local id = parseItem(text)
					if not id then
						p2:sendCancelMessage("Bot: nie ma przedmiotu \"" .. text .. "\".")
						return reopen(p2)
					end
					cfg.food.item = id
				end
				changed(p2, reopen)
			end)
		end },
		{ onOff(cfg.antiAfk) .. "Anty-AFK (bez wylogowania za bezczynnosc)", function(p)
			cfg.antiAfk = not cfg.antiAfk
			changed(p, reopen)
		end },
	}
	menu(player, "Bot - Tools", "Haste rzucany, gdy efekt przyspieszenia wygasnie. Jedzenie, gdy zostaje mniej niz 5 minut najedzenia.", choices, openMain)
end

-- Timery --------------------------------------------------------------------

local function timerLabel(timer)
	local what = timer.kind == "item" and ("uzyj " .. itemName(timer.value)) or ("powiedz \"" .. tostring(timer.value) .. "\"")
	return string.format("%sco %s: %s", onOff(timer.on), durationText(timer.every), what)
end

local function openTimer(player, index)
	local st = state(player)
	local timer = st.cfg.timers[index]
	if not timer then
		return openTimers(player)
	end
	local reopen = function(p)
		openTimer(p, index)
	end
	local choices = {
		{ onOff(timer.on) .. "Timer wlaczony", function(p)
			timer.on = not timer.on
			st.timers[index] = nil
			changed(p, reopen)
		end },
		{ "Co ile: " .. durationText(timer.every) .. " (zmien)", function(p)
			ask(p, "co ile, np. 30s, 5m, 1h, 1h 30m.", durationText(timer.every):gsub("min", "m"), function(p2, text)
				local seconds = parseDuration(text)
				if not seconds or seconds < 1 then
					p2:sendCancelMessage("Bot: nie rozumiem czasu \"" .. text .. "\".")
				else
					timer.every = seconds
					st.timers[index] = nil
					save(p2)
				end
				reopen(p2)
			end)
		end },
	}
	if timer.kind == "item" then
		choices[#choices + 1] = { "Przedmiot: " .. itemName(timer.value) .. " (zmien)", function(p)
			ask(p, "ID albo nazwa przedmiotu.", timer.value, function(p2, text)
				local id = parseItem(text)
				if id then
					timer.value = id
					save(p2)
				else
					p2:sendCancelMessage("Bot: nie ma przedmiotu \"" .. text .. "\".")
				end
				reopen(p2)
			end)
		end }
	else
		choices[#choices + 1] = { "Tekst: " .. tostring(timer.value) .. " (zmien)", function(p)
			ask(p, "tekst albo slowa czaru.", timer.value, function(p2, text)
				if text ~= "" then
					timer.value = text
					save(p2)
				end
				reopen(p2)
			end)
		end }
	end
	choices[#choices + 1] = { "Usun timer", function(p)
		table.remove(st.cfg.timers, index)
		st.timers = {}
		changed(p, openTimers)
	end }
	menu(player, "Timer", timerLabel(timer), choices, openTimers)
end

openTimers = function(player)
	local st = state(player)
	local choices = {}
	for i, timer in ipairs(st.cfg.timers) do
		choices[#choices + 1] = { i .. ". " .. timerLabel(timer), function(p)
			openTimer(p, i)
		end }
	end
	local function add(p, kind, value)
		local timers = state(p).cfg.timers
		timers[#timers + 1] = { on = true, kind = kind, value = value, every = 60 }
		save(p)
		openTimer(p, #timers)
	end
	choices[#choices + 1] = { ">> Dodaj: uzyj przedmiotu", function(p)
		ask(p, "ID albo nazwa przedmiotu do uzywania.", "", function(p2, text)
			local id = parseItem(text)
			if not id then
				p2:sendCancelMessage("Bot: nie ma przedmiotu \"" .. text .. "\".")
				return openTimers(p2)
			end
			add(p2, "item", id)
		end)
	end }
	choices[#choices + 1] = { ">> Dodaj: powiedz tekst / czar", function(p)
		ask(p, "tekst albo slowa czaru (czar zostanie rzucony).", "", function(p2, text)
			if text == "" then
				return openTimers(p2)
			end
			add(p2, "say", text)
		end)
	end }
	menu(player, "Bot - Timery", "Kazdy timer dziala co ustalony czas, liczac od wlaczenia bota. Nieudana proba (cooldown, brak many) jest powtarzana co sekunde.", choices, openMain)
end

-- Menu glowne -----------------------------------------------------------------

openMain = function(player)
	local cfg = state(player).cfg
	local reopen = openMain
	local choices = {
		{ onOff(cfg.on) .. "Bot " .. (cfg.on and "wlaczony" or "wylaczony"), function(p)
			cfg.on = not cfg.on
			if not cfg.on then
				setMark(p, state(p), nil)
			end
			changed(p, reopen)
		end },
		{ string.format("Healing (HP: %d, mana: %d regul) >", #cfg.heal, #cfg.mana), function(p)
			openHealing(p)
		end },
		{ string.format("Hunting (auto atak %s, %s) >", cfg.hunt.on and "ON" or "OFF", cfg.hunt.mode == "chase" and "Chase" or "Stand"), function(p)
			openHunting(p)
		end },
		{ "Tools (haste, jedzenie, anty-AFK) >", function(p)
			openTools(p)
		end },
		{ "Timery (" .. #cfg.timers .. ") >", function(p)
			openTimers(p)
		end },
		{ onOff(cfg.autostart) .. "Wlaczaj bota automatycznie po zalogowaniu", function(p)
			cfg.autostart = not cfg.autostart
			changed(p, reopen)
		end },
	}
	menu(player, "Bot - " .. player:getName(), "Ustawienia zapisuja sie dla tej postaci. Komendy: !bot, !bot on, !bot off.", choices, nil)
end

---------------------------------------------------------------------------
-- Komenda i logowanie
---------------------------------------------------------------------------

local talk = TalkAction("!bot")
function talk.onSay(player, words, param)
	ensureLoop()
	local cfg = state(player).cfg
	param = trim(param):lower()
	if param == "on" or param == "off" then
		cfg.on = param == "on"
		if not cfg.on then
			setMark(player, state(player), nil)
		end
		save(player)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bot " .. (cfg.on and "WLACZONY." or "WYLACZONY."))
		return true
	end
	openMain(player)
	return true
end
talk:separator(" ")
talk:groupType("normal")
talk:register()

local login = CreatureEvent("OtsBotLogin")
function login.onLogin(player)
	ensureLoop()
	OtsBotState[player:getId()] = nil
	local st = state(player)
	st.cfg.on = st.cfg.autostart == true
	if st.cfg.on then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bot: wczytano ustawienia postaci, bot WLACZONY (!bot - menu, !bot off - wylacz).")
	end
	return true
end
login:register()
