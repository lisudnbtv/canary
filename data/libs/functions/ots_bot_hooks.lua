-- OTS: przechwytywanie czarow, run i akcji przedmiotow na potrzeby bota (scripts/ots/bot.lua).
-- Lua w Canary nie ma funkcji "rzuc czar jak gracz" ani "uzyj przedmiotu jak gracz".
-- Ten plik laduje sie razem z bibliotekami (przed data/scripts), wiec widzi rejestracje
-- kazdego czaru, runy i akcji i zapamietuje ich funkcje. Bot wywoluje je potem sam,
-- a koszt many, cooldowny i wymagania sprawdza po swojej stronie.
-- Wczytywany z data/libs/functions/player.lua (ostatnia linia).

OtsBotHooks = OtsBotHooks or {}
local H = OtsBotHooks
H.areaById = H.areaById or {} -- id z createCombatArea -> macierz obszaru
H.combatArea = H.combatArea or setmetatable({}, { __mode = "k" }) -- Combat -> macierz
H.pendingSpell = H.pendingSpell or setmetatable({}, { __mode = "k" }) -- Spell -> funkcja czaru
H.pendingAction = H.pendingAction or setmetatable({}, { __mode = "k" }) -- Action -> { cb, ids }
H.spells = H.spells or {} -- slowa czaru (male litery) -> wpis
H.spellsByName = H.spellsByName or {} -- nazwa czaru (male litery) -> wpis
H.runes = H.runes or {} -- id runy -> wpis
H.actions = H.actions or {} -- id przedmiotu -> { cb, source }
H.pendingTalk = H.pendingTalk or setmetatable({}, { __mode = "k" }) -- TalkAction -> funkcja komendy
H.talkactions = H.talkactions or {} -- slowa komendy (male litery), np. "!polaczforge" -> { cb, words }

if H.installed then
	return
end
H.installed = true

-- Macierz obszaru -> lista przesuniec {dx, dy} wzgledem srodka (pole 2 albo 3).
local function areaOffsets(matrix)
	if type(matrix) ~= "table" or #matrix == 0 then
		return nil
	end
	local cy, cx
	for y, row in ipairs(matrix) do
		for x, value in ipairs(row) do
			if value == 2 or value == 3 then
				cy, cx = y, x
			end
		end
	end
	if not cy then
		cy = math.floor((#matrix + 1) / 2)
		cx = math.floor((#matrix[1] + 1) / 2)
	end
	local offsets = {}
	for y, row in ipairs(matrix) do
		for x, value in ipairs(row) do
			if value == 1 or value == 3 then
				offsets[#offsets + 1] = { x - cx, y - cy }
			end
		end
	end
	return #offsets > 0 and offsets or nil
end
H.areaOffsets = areaOffsets

local originalCreateCombatArea = createCombatArea
if originalCreateCombatArea then
	-- argumenty przekazywane dokladnie w tej liczbie, w jakiej przyszly: jawne nil jako
	-- drugi argument C++ traktuje jak zly "extArea" (Invalid extended area table)
	createCombatArea = function(area, ...)
		local id = originalCreateCombatArea(area, ...)
		if id then
			H.areaById[id] = area
		end
		return id
	end
end

local originalSetArea = Combat.setArea
function Combat.setArea(self, area, ...)
	local matrix = H.areaById[area]
	if matrix then
		H.combatArea[self] = matrix
	end
	return originalSetArea(self, area, ...)
end

-- Szuka w funkcji czaru (i funkcjach, ktore ona wola) obiektu Combat z obszarem.
local function findArea(fn, depth, seen)
	if type(fn) ~= "function" or not debug or not debug.getupvalue then
		return nil
	end
	seen = seen or {}
	if seen[fn] then
		return nil
	end
	seen[fn] = true
	local i = 1
	while true do
		local name, value = debug.getupvalue(fn, i)
		if not name then
			break
		end
		if value ~= nil then
			local matrix = H.combatArea[value]
			if matrix then
				return matrix
			end
			if type(value) == "table" then
				for _, inner in pairs(value) do
					if inner ~= nil and type(inner) ~= "table" then
						local m = H.combatArea[inner]
						if m then
							return m
						end
					end
				end
			elseif type(value) == "function" and depth > 0 then
				local m = findArea(value, depth - 1, seen)
				if m then
					return m
				end
			end
		end
		i = i + 1
	end
	return nil
end

local originalOnCastSpell = Spell.onCastSpell
function Spell.onCastSpell(self, callback, ...)
	H.pendingSpell[self] = callback
	return originalOnCastSpell(self, callback, ...)
end

local originalSpellRegister = Spell.register
function Spell.register(self, ...)
	local ok = originalSpellRegister(self, ...)
	local callback = H.pendingSpell[self]
	if ok and callback then
		local entry = { cb = callback, spell = self, offsets = areaOffsets(findArea(callback, 2)) }
		local rune = self:runeId()
		if rune and rune > 0 then
			entry.rune = rune
			H.runes[rune] = entry
		else
			local words = self:words()
			if words and words ~= "" then
				entry.words = words
				H.spells[words:lower()] = entry
			end
		end
		local name = self:name()
		if name and name ~= "" then
			entry.name = name
			H.spellsByName[name:lower()] = entry
		end
	end
	return ok
end

local function pendingAction(self)
	local pending = H.pendingAction[self]
	if not pending then
		pending = { ids = {} }
		H.pendingAction[self] = pending
	end
	return pending
end

local originalOnUse = Action.onUse
function Action.onUse(self, callback, ...)
	pendingAction(self).cb = callback
	return originalOnUse(self, callback, ...)
end

local originalActionId = Action.id
function Action.id(self, ...)
	local ids = pendingAction(self).ids
	for _, id in ipairs({ ... }) do
		if type(id) == "number" then
			ids[#ids + 1] = id
		end
	end
	return originalActionId(self, ...)
end

local originalActionRegister = Action.register
function Action.register(self, ...)
	local ok = originalActionRegister(self, ...)
	local pending = H.pendingAction[self]
	if ok and pending and pending.cb then
		local source = ""
		if debug and debug.getinfo then
			local info = debug.getinfo(pending.cb, "S")
			source = info and info.source or ""
		end
		for _, id in ipairs(pending.ids) do
			H.actions[id] = { cb = pending.cb, source = source }
		end
	end
	return ok
end

local originalTalkOnSay = TalkAction.onSay
function TalkAction.onSay(self, callback, ...)
	H.pendingTalk[self] = callback
	return originalTalkOnSay(self, callback, ...)
end

local originalTalkRegister = TalkAction.register
function TalkAction.register(self, ...)
	local ok = originalTalkRegister(self, ...)
	local callback = H.pendingTalk[self]
	if ok and callback then
		for word in tostring(self:getName() or ""):gmatch("[^,]+") do
			word = word:gsub("^%s+", ""):gsub("%s+$", "")
			if word ~= "" then
				H.talkactions[word:lower()] = { cb = callback, words = word }
			end
		end
	end
	return ok
end
