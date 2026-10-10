"""Generuje sale questow na stroje (world/custom/ots-outfits.otbm), spawny i skrypt Lua."""
import json, re, struct, collections, os
from xml.sax.saxutils import quoteattr

X0, Y0, Z = 30000, 31000, 7
GROUND, TELEPORT, SIGN_A, SIGN_B, CHEST = 410, 1949, 2016, 2014, 2472
PAD_AID, CHEST_AID = 64994, 64995
PITCH = 3
ROOM = 13            # bok areny
STEP = 32            # odstep miedzy salami
COLS = 12
KILLS = 20
HUB_LOBBY = tuple(json.load(open('hub.json'))['lobby'])

xml = open('/home/claude/canary/data/XML/outfits.xml').read()
rows = re.findall(r'<outfit type="(\d)" looktype="(\d+)" name="([^"]*)"', xml)
female = [(int(lt), n) for t, lt, n in rows if t == '0']
male = [(int(lt), n) for t, lt, n in rows if t == '1']
kinds = json.load(open('outfit_kinds.json'))
def norm(nm): return nm.replace('woman', 'man')
fem = {norm(nm): (lt, nm) for lt, nm in female}
mal = {norm(nm): (lt, nm) for lt, nm in male}
outfits = []
for nm in dict.fromkeys([norm(x[1]) for x in male] + [norm(x[1]) for x in female]):
    m, f = mal.get(nm), fem.get(nm)
    display = (m or f)[1]
    outfits.append(dict(name=display, male=m[0] if m else 0, female=f[0] if f else 0, kind=kinds[display]))
    if not (m and f): print('tylko jedna plec:', display)

hunts = sorted(json.load(open('data2.json'))['hunts'], key=lambda h: (h['exp'], h['name']))
lo = next(i for i, h in enumerate(hunts) if h['exp'] >= 150)
n = len(outfits)
for k, o in enumerate(outfits):
    a = lo + round(k * (len(hunts) - 1 - lo) / (n - 1))
    b = max(lo, a - 9)
    o['monsters'] = [hunts[a]['name'], hunts[b]['name']] if a != b else [hunts[a]['name']]
    o['exp'] = hunts[a]['exp']

tiles = {}; pads = {}; chests = {}; spawns = []
def floor(x, y, pz=True):
    tiles.setdefault((x, y, Z), dict(pz=pz, items=[]))
def item(x, y, iid, aid=0, text=None, pz=True):
    floor(x, y, pz)
    tiles[(x, y, Z)]['items'].append((iid, aid, text))
def key(x, y): return '%d:%d:%d' % (x, y, Z)

# Korytarz wyboru stroju
slots = (n + 1) // 2
x_end = X0 + 2 + PITCH * slots
for x in range(X0 + 1, x_end):
    for y in range(Y0 - 1, Y0 + 2):
        floor(x, y)
hall = [X0 + 1 + (x_end - X0) // 2, Y0, Z]
for xe, sx, sign in ((X0, X0 - 1, SIGN_A), (x_end, x_end + 1, SIGN_B)):
    item(xe, Y0, TELEPORT, PAD_AID); pads[key(xe, Y0)] = dict(kind='hub')
    item(sx, Y0, sign, 0, 'Hub\nPowrot do hubu expowisk')

rooms = []
for k, o in enumerate(outfits):
    s, side = divmod(k, 2)
    px = X0 + 3 + PITCH * s
    sgn = -1 if side == 0 else 1
    item(px, Y0 + 2 * sgn, TELEPORT, PAD_AID); pads[key(px, Y0 + 2 * sgn)] = dict(kind='room', index=k)
    item(px, Y0 + 3 * sgn, SIGN_A if sgn < 0 else SIGN_B, 0, '%s\nPotwory: %s\nDo pokonania: %d' % (o['name'], ', '.join(o['monsters']), KILLS))
    floor(px, Y0 + 4 * sgn)                 # wysepka z postacia pokazujaca stroj
    o['display'] = (px, Y0 + 4 * sgn, sgn)
    # sala
    col, row = k % COLS, k // COLS
    rx = X0 + col * STEP
    ry = Y0 + 60 + row * STEP
    for x in range(rx, rx + ROOM):
        for y in range(ry, ry + ROOM):
            floor(x, y, pz=False)
    cx = rx + ROOM // 2
    # wejscie (poludnie): platforma PZ 3x2 z padem powrotnym
    for x in range(cx - 1, cx + 2):
        for y in range(ry + ROOM, ry + ROOM + 2):
            floor(x, y)
    entry = [cx, ry + ROOM, Z]
    item(cx + 1, ry + ROOM + 1, TELEPORT, PAD_AID); pads[key(cx + 1, ry + ROOM + 1)] = dict(kind='hall')
    item(cx - 1, ry + ROOM + 1, SIGN_B, 0, '%s\nPokonaj %d potworow, potem otworz skrzynie po polnocnej stronie sali.' % (o['name'], KILLS))
    # skrzynia (polnoc): wneka PZ, skrzynia za nia
    for x in range(cx - 1, cx + 2):
        floor(x, ry - 1)
    item(cx, ry - 2, CHEST, CHEST_AID); chests[key(cx, ry - 2)] = k
    item(cx + 1, ry - 1, TELEPORT, PAD_AID); pads[key(cx + 1, ry - 1)] = dict(kind='hall')
    # spawny: wymagana liczba zabic + 10 zapasu (30 potworow), rowna siatka w arenie
    pts = [(dx, dy) for dy in (1, 3, 5, 7, 9) for dx in (1, 3, 5, 7, 9, 11)][:KILLS + 10]
    for i, (dx, dy) in enumerate(pts):
        spawns.append((o['monsters'][i % len(o['monsters'])], rx + dx, ry + dy))
    rooms.append(dict(x=rx, y=ry, entry=entry))

# ---- OTBM
def esc(b):
    out = bytearray()
    for c in b:
        if c in (0xFD, 0xFE, 0xFF): out.append(0xFD)
        out.append(c)
    return bytes(out)
def s16(text):
    raw = text.encode('latin-1'); return struct.pack('<H', len(raw)) + raw
body = bytearray(b'\xfe\x02')
body += esc(b'\x01' + s16('OTS outfit quests, generated') + b'\x0b' + s16('ots-outfits-monster.xml') + b'\x0d' + s16('ots-outfits-house.xml') + b'\x17' + s16('ots-outfits-npc.xml') + b'\x18' + s16('ots-outfits-zones.xml'))
areas = collections.defaultdict(list)
for (x, y, z), t in tiles.items():
    areas[(x & 0xFF00, y & 0xFF00, z)].append((x & 0xFF, y & 0xFF, t))
for (bx, by, z), ts in sorted(areas.items()):
    body += b'\xfe\x04' + esc(struct.pack('<HHB', bx, by, z))
    for ox, oy, t in sorted(ts, key=lambda v: (v[0], v[1])):
        body += b'\xfe\x05' + esc(bytes([ox, oy]))
        if t['pz']: body += esc(b'\x03' + struct.pack('<I', 1))
        body += esc(b'\x09' + struct.pack('<H', GROUND))
        for iid, aid, text in t['items']:
            data = struct.pack('<H', iid)
            if aid: data += b'\x04' + struct.pack('<H', aid)
            if text: data += b'\x06' + s16(text)
            body += b'\xfe\x06' + esc(data) + b'\xff'
        body += b'\xff'
    body += b'\xff'
body += b'\xfe\x0c\xff\xfe\x0f\xff\xff'
out = b'\x00\x00\x00\x00\xfe\x00' + esc(struct.pack('<IHHII', 2, 0x855f, 0x8414, 3, 0x3e)) + bytes(body) + b'\xff'
os.makedirs('outq', exist_ok=True)
open('outq/ots-outfits.otbm', 'wb').write(out)
with open('outq/ots-outfits-monster.xml', 'w') as f:
    f.write('<?xml version="1.0"?>\n<monsters>\n')
    for name, x, y in spawns:
        f.write('\t<monster centerx="%d" centery="%d" centerz="%d" radius="3">\n\t\t<monster name=%s x="0" y="0" z="%d" spawntime="300" />\n\t</monster>\n' % (x, y, Z, quoteattr(name), Z))
    f.write('</monsters>\n')
for nm, tag in (('house', 'houses'), ('npc', 'npcs'), ('zones', 'zones')):
    open('outq/ots-outfits-%s.xml' % nm, 'w').write('<?xml version="1.0"?>\n<%s />\n' % tag)

# ---- Lua
def q(s): return '"' + s.replace('\\', '\\\\').replace('"', '\\"') + '"'
L = []
L.append('''-- OTS: questy na stroje. Plik generowany razem z mapa world/custom/ots-outfits.otbm.
-- Kazdy stroj ma wlasna sale: pokonaj %d potworow, potem otworz skrzynie.
-- Nagroda: stroj z oboma dodatkami (wersja meska i zenska).

local PAD_ACTION_ID = %d
local CHEST_ACTION_ID = %d
local REQUIRED_KILLS = %d
local ROOM_SIZE = %d
local hall = Position(%d, %d, %d)
local hubLobby = Position(%d, %d, %d)

local quests = {''' % (KILLS, PAD_AID, CHEST_AID, KILLS, ROOM, *hall, *HUB_LOBBY))
for o, r in zip(outfits, rooms):
    L.append('\t{ name = %s, male = %d, female = %d, x = %d, y = %d, entry = Position(%d, %d, %d), display = Position(%d, %d, %d), faceSouth = %s },' % (q(o['name']), o['male'], o['female'], r['x'], r['y'], *r['entry'], o['display'][0], o['display'][1], Z, 'true' if o['display'][2] < 0 else 'false'))
L.append('}\n\nlocal pads = {')
for k, a in sorted(pads.items()):
    L.append('\t[%s] = %s,' % (q(k), '{ room = %d }' % (a['index'] + 1) if a['kind'] == 'room' else '{ %s = true }' % a['kind']))
L.append('}\n\nlocal chests = {')
for k, i in sorted(chests.items()):
    L.append('\t[%s] = %d,' % (q(k), i + 1))
L.append('}\n')
L.append(r'''
local function key(pos)
	return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local function move(player, destination, message)
	local from = player:getPosition()
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	if message then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	end
end

local function progress(player, index)
	return player:kv():scoped("ots-outfit-quests"):scoped(tostring(index))
end

local function killsOf(player, index)
	return tonumber(progress(player, index):get("kills")) or 0
end

local function isDone(player, index)
	return progress(player, index):get("done") == true
end

-- Ktora sala zawiera te pozycje (albo nil).
local function roomAt(pos)
	for index, quest in ipairs(quests) do
		if pos.x >= quest.x and pos.x < quest.x + ROOM_SIZE and pos.y >= quest.y and pos.y < quest.y + ROOM_SIZE and pos.z == quest.entry.z then
			return index
		end
	end
	return nil
end

-- Wejscie z menu !tp i z hubu.
function OtsOutfitHall(player)
	move(player, hall, "Questy na stroje: kazdy pad prowadzi do sali jednego stroju (tabliczka za padem mowi, co tam czeka). Trudnosc rosnie z zachodu na wschod.")
end

local padStep = MoveEvent()

function padStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local pad = pads[key(position)]
	if not pad then
		return true
	end

	if pad.room then
		local quest = quests[pad.room]
		local text
		if isDone(player, pad.room) then
			text = string.format("Stroj %s: quest juz wykonany.", quest.name)
		else
			text = string.format("Stroj %s: pokonane %d/%d. Skrzynia jest po polnocnej stronie sali.", quest.name, math.min(killsOf(player, pad.room), REQUIRED_KILLS), REQUIRED_KILLS)
		end
		move(player, quest.entry, text)
	elseif pad.hall then
		OtsOutfitHall(player)
	elseif pad.hub then
		move(player, hubLobby)
	end
	return true
end

padStep:type("stepin")
padStep:aid(PAD_ACTION_ID)
padStep:register()

local kills = EventCallback("OtsOutfitQuestOnKill")

function kills.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local index = roomAt(monster:getPosition())
	if not index or isDone(player, index) then
		return
	end

	local count = killsOf(player, index)
	if count >= REQUIRED_KILLS then
		return
	end
	count = count + 1
	progress(player, index):set("kills", count)
	if count >= REQUIRED_KILLS then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Stroj %s: wymagane potwory pokonane. Otworz skrzynie po polnocnej stronie sali.", quests[index].name))
	elseif count % 5 == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Stroj %s: %d/%d potworow.", quests[index].name, count, REQUIRED_KILLS))
	end
end

kills:register()

local chest = Action()

function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local index = chests[key(fromPosition)]
	if not index then
		return true
	end
	local quest = quests[index]

	if isDone(player, index) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skrzynia jest pusta. Ten quest jest juz wykonany.")
		return true
	end

	local count = killsOf(player, index)
	if count < REQUIRED_KILLS then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Skrzynia jest zamknieta. Pokonaj jeszcze %d potworow w tej sali.", REQUIRED_KILLS - count))
		return true
	end

	if quest.male > 0 then
		player:addOutfitAddon(quest.male, 3)
	end
	if quest.female > 0 then
		player:addOutfitAddon(quest.female, 3)
	end
	progress(player, index):set("done", true)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Quest wykonany! Nowy stroj dostepny: %s (z oboma dodatkami).", quest.name))
	return true
end

chest:aid(CHEST_ACTION_ID)
chest:register()

-- Postacie pokazujace stroje: po jednej za kazdym padem w hali wyboru.
-- Kazda ma wlasny typ NPC z nazwa stroju i jego wygladem z oboma dodatkami.
local function displayName(quest)
	return "Stroj " .. quest.name
end

for _, quest in ipairs(quests) do
	local name = displayName(quest)
	local npcType = Game.createNpcType(name)
	local npcConfig = {}
	npcConfig.name = name
	npcConfig.description = name
	npcConfig.health = 100
	npcConfig.maxHealth = 100
	npcConfig.walkInterval = 0
	npcConfig.walkRadius = 0
	npcConfig.outfit = {
		lookType = quest.male > 0 and quest.male or quest.female,
		lookHead = 78,
		lookBody = 69,
		lookLegs = 58,
		lookFeet = 76,
		lookAddons = 3,
	}
	npcConfig.flags = {
		floorchange = false,
	}
	npcType:register(npcConfig)
end

local displays = GlobalEvent("OtsOutfitDisplays")

function displays.onStartup()
	local placed = 0
	for _, quest in ipairs(quests) do
		local npc = Game.createNpc(displayName(quest), quest.display, false, true)
		if npc then
			npc:setMasterPos(quest.display)
			npc:setDirection(quest.faceSouth and DIRECTION_SOUTH or DIRECTION_NORTH)
			placed = placed + 1
		end
	end
	logger.info("[OTS stroje] Postacie pokazowe: {}/{}", placed, #quests)
	return true
end

displays:register()
''')
open('ots_outfit_quests.lua', 'w').write('\n'.join(L))
xs = [k[0] for k in tiles]; ys = [k[1] for k in tiles]
print('outfits', n, 'tiles', len(tiles), 'pads', len(pads), 'spawns', len(spawns), 'bbox', min(xs), min(ys), max(xs), max(ys), 'bytes', len(out), 'hall', hall)
for o in outfits[::16]: print(o['name'], o['monsters'], o['exp'])
print(outfits[-1]['name'], outfits[-1]['monsters'])
