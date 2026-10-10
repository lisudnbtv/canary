"""Generuje hale wierzchowcow (world/custom/ots-mounts.otbm): pietra z padami, zagrody z 5 stworzeniami i skrypt Lua."""
import json, re, struct, collections, os, glob
import xml.etree.ElementTree as ET
from xml.sax.saxutils import quoteattr

C = '/home/claude/canary'
X0, Y0, Z = 29500, 31000, 7
TELEPORT, SIGN_A, SIGN_B = 1949, 2016, 2014
PAD_AID = 64997
PITCH, ROOM, STEP, COLS = 3, 9, 24, 10
PER_PEN = 5
SPAWNTIME = 900            # przy rateSpawn 15 daje ok. 60 s
HUB_LOBBY = tuple(json.load(open('hub.json'))['lobby'])

src = open(C + '/data-otservbr-global/scripts/actions/mounts/mounts.lua').read()
names = {}
for it in ET.parse(C + '/data/items/items.xml').getroot():
    if it.get('id'): names[int(it.get('id'))] = it.get('name')
mon = {}
for f in glob.glob(C + '/data-otservbr-global/monster/**/*.lua', recursive=True):
    s = open(f, encoding='utf-8', errors='ignore').read()
    m = re.search(r'Game\.createMonsterType\("([^"]+)"\)', s)
    if not m: continue
    ob = re.search(r'monster\.outfit\s*=\s*\{(.*?)\}', s, re.S)
    of = {k: int(v) for k, v in re.findall(r'(look\w+)\s*=\s*(\d+)', ob.group(1))} if ob else {}
    mon[m.group(1).lower()] = (m.group(1), of)
mounts = []
for m in re.finditer(r'\[(\d+)\]\s*=\s*\{\s*NAME\s*=\s*"([^"]+)",\s*ID\s*=\s*(\d+),\s*BREAK\s*=\s*\w+,\s*TYPE\s*=\s*TYPE_MONSTER,\s*CHANCE\s*=\s*(\d+)', src):
    item, nm, mid, chance = int(m.group(1)), m.group(2), int(m.group(3)), int(m.group(4))
    if nm.lower() not in mon or not mon[nm.lower()][1].get('lookType'):
        print('pomijam (brak potwora):', nm); continue
    real, of = mon[nm.lower()]
    mounts.append(dict(name=real, item=item, itemName=names.get(item, '?'), mountId=mid, chance=chance, outfit={k: v for k, v in of.items() if k != 'lookTypeEx'}))
mounts.sort(key=lambda m: m['name'])
n = len(mounts)

tiles = {}; pads = {}; spawns = []
def floor(x, y, pz=True):
    tiles.setdefault((x, y, Z), dict(pz=pz, items=[]))
def item(x, y, iid, aid=0, text=None, pz=True):
    floor(x, y, pz)
    tiles[(x, y, Z)]['items'].append((iid, aid, text))
def key(x, y): return '%d:%d:%d' % (x, y, Z)

FLOOR_N, ROW_N, FLOOR_PITCH = 24, 12, 26
nfloors = (n + FLOOR_N - 1) // FLOOR_N
x_end = X0 + 2 + PITCH * (ROW_N // 2)
arrivals = [[X0 - 2, Y0 - FLOOR_PITCH * f + 5, Z] for f in range(nfloors)]
hall = arrivals[0]
navnpcs = []
tamer = [X0 - 2, Y0 + 11, Z]          # poludniowy koniec zachodniego korytarza pierwszego pietra
for f in range(nfloors):
    yc = Y0 - FLOOR_PITCH * f
    for x in list(range(X0 - 3, X0)) + list(range(x_end, x_end + 3)):
        for y in range(yc - 1, yc + 12):
            floor(x, y)
    for r in range(2):
        for x in range(X0, x_end):
            for y in range(yc + 10 * r - 1, yc + 10 * r + 2):
                floor(x, y)
    def nav(y, target, text, who):
        if target is None:
            item(X0 - 4, y, TELEPORT, PAD_AID); pads[key(X0 - 4, y)] = dict(kind='hub')
        else:
            t = target % nfloors
            item(X0 - 4, y, TELEPORT, PAD_AID); pads[key(X0 - 4, y)] = dict(kind='goto', pos=arrivals[t], label='Mounty %d/%d' % (t + 1, nfloors))
        floor(X0 - 5, y)
        navnpcs.append((who, X0 - 5, y))
        item(X0 - 6, y, SIGN_A, 0, text)
    if nfloors > 1:
        nav(yc + 3, f - 1, 'Poprzednie pietro\nMounty %d/%d' % ((f - 1) % nfloors + 1, nfloors), 'Poprzednie pomieszczenie')
        nav(yc + 7, f + 1, 'Nastepne pietro\nMounty %d/%d' % ((f + 1) % nfloors + 1, nfloors), 'Nastepne pomieszczenie')
    nav(yc + 5, None, 'Lobby hubu\nTu jestes: Mounty %d/%d' % (f + 1, nfloors), 'Lobby')
floor(tamer[0], tamer[1])
item(tamer[0], tamer[1] + 1, SIGN_B, 0, 'Tamer\nSprzedaje wszystkie przedmioty do oswajania po 1 gp')

rooms = []
for k, o in enumerate(mounts):
    f, j = divmod(k, FLOOR_N)
    r, jj = divmod(j, ROW_N)
    s, side = divmod(jj, 2)
    px = X0 + 3 + PITCH * s
    yr = Y0 - FLOOR_PITCH * f + 10 * r
    sgn = -1 if side == 0 else 1
    item(px, yr + 2 * sgn, TELEPORT, PAD_AID); pads[key(px, yr + 2 * sgn)] = dict(kind='room', index=k)
    item(px, yr + 3 * sgn, SIGN_A if sgn < 0 else SIGN_B, 0, '%s\nOswajanie: %s\nSzansa: %d%%' % (o['name'], o['itemName'], o['chance']))
    floor(px, yr + 4 * sgn)
    o['display'] = (px, yr + 4 * sgn, sgn)
    back = dict(kind='goto', pos=arrivals[f], label='Mounty %d/%d' % (f + 1, nfloors))
    # zagroda
    col, row = k % COLS, k // COLS
    rx = X0 + col * STEP
    ry = Y0 + 60 + row * STEP
    for x in range(rx, rx + ROOM):
        for y in range(ry, ry + ROOM):
            floor(x, y, pz=False)
    cx = rx + ROOM // 2
    for x in range(cx - 1, cx + 2):
        for y in range(ry + ROOM, ry + ROOM + 2):
            floor(x, y)
    item(cx + 1, ry + ROOM + 1, TELEPORT, PAD_AID); pads[key(cx + 1, ry + ROOM + 1)] = back
    item(cx - 1, ry + ROOM + 1, SIGN_B, 0, '%s\nUzyj na nim: %s (szansa %d%%)\nPrzedmiot kupisz u Tamera w hali.' % (o['name'], o['itemName'], o['chance']))
    for dx, dy in [(2, 2), (6, 2), (4, 4), (2, 6), (6, 6)][:PER_PEN]:
        spawns.append((o['name'], rx + dx, ry + dy))
    rooms.append(dict(entry=[cx, ry + ROOM, Z]))

MARBLE_A, MARBLE_B, WOOD, GRASS = 409, 410, 408, 4515
BUSHES = [3681, 3682, 3699]; FLOWERS = [3654, 3655, 3656, 3657, 3658, 3659]; TREES = [3614, 3615, 3617, 3618, 3620, 3621]
def _h(x, y, salt=0):
    v = (x * 73856093) ^ (y * 19349663) ^ (salt * 83492791)
    return (v ^ (v >> 13)) & 0xFFFF
for (x, y, z), t in tiles.items():
    if not t['pz']: t['ground'] = GRASS
    elif any(i[0] == TELEPORT for i in t['items']): t['ground'] = WOOD
    else: t['ground'] = MARBLE_A if (x + y) % 2 else MARBLE_B
RIM = 4
dist = {}
for (x, y, z) in list(tiles):
    for dx in range(-RIM, RIM + 1):
        for dy in range(-RIM, RIM + 1):
            kk = (x + dx, y + dy, z)
            if kk in tiles: continue
            d = max(abs(dx), abs(dy))
            if d < dist.get(kk, 99): dist[kk] = d
for (x, y, z), d in dist.items():
    its = []
    r = _h(x, y)
    if d == 1: its.append((BUSHES[r % len(BUSHES)], 0, None))
    elif r % 100 < 22: its.append((FLOWERS[_h(x, y, 1) % len(FLOWERS)], 0, None))
    elif d >= 3 and r % 100 < 34: its.append((TREES[_h(x, y, 2) % len(TREES)], 0, None))
    tiles[(x, y, z)] = dict(pz=False, items=its, ground=GRASS)

def esc(b):
    out = bytearray()
    for c in b:
        if c in (0xFD, 0xFE, 0xFF): out.append(0xFD)
        out.append(c)
    return bytes(out)
def s16(text):
    raw = text.encode('latin-1'); return struct.pack('<H', len(raw)) + raw
body = bytearray(b'\xfe\x02')
body += esc(b'\x01' + s16('OTS mounts, generated') + b'\x0b' + s16('ots-mounts-monster.xml') + b'\x0d' + s16('ots-mounts-house.xml') + b'\x17' + s16('ots-mounts-npc.xml') + b'\x18' + s16('ots-mounts-zones.xml'))
areas = collections.defaultdict(list)
for (x, y, z), t in tiles.items():
    areas[(x & 0xFF00, y & 0xFF00, z)].append((x & 0xFF, y & 0xFF, t))
for (bx, by, z), ts in sorted(areas.items()):
    body += b'\xfe\x04' + esc(struct.pack('<HHB', bx, by, z))
    for ox, oy, t in sorted(ts, key=lambda v: (v[0], v[1])):
        body += b'\xfe\x05' + esc(bytes([ox, oy]))
        if t['pz']: body += esc(b'\x03' + struct.pack('<I', 1))
        body += esc(b'\x09' + struct.pack('<H', t['ground']))
        for iid, aid, text in t['items']:
            data = struct.pack('<H', iid)
            if aid: data += b'\x04' + struct.pack('<H', aid)
            if text: data += b'\x06' + s16(text)
            body += b'\xfe\x06' + esc(data) + b'\xff'
        body += b'\xff'
    body += b'\xff'
body += b'\xfe\x0c\xff\xfe\x0f\xff\xff'
out = b'\x00\x00\x00\x00\xfe\x00' + esc(struct.pack('<IHHII', 2, 0x855f, 0x8414, 3, 0x3e)) + bytes(body) + b'\xff'
os.makedirs('mountq', exist_ok=True)
open('mountq/ots-mounts.otbm', 'wb').write(out)
with open('mountq/ots-mounts-monster.xml', 'w') as f:
    f.write('<?xml version="1.0"?>\n<monsters>\n')
    for name, x, y in spawns:
        f.write('\t<monster centerx="%d" centery="%d" centerz="%d" radius="2">\n\t\t<monster name=%s x="0" y="0" z="%d" spawntime="%d" />\n\t</monster>\n' % (x, y, Z, quoteattr(name), Z, SPAWNTIME))
    f.write('</monsters>\n')
for nm, tag in (('house', 'houses'), ('npc', 'npcs'), ('zones', 'zones')):
    open('mountq/ots-mounts-%s.xml' % nm, 'w').write('<?xml version="1.0"?>\n<%s />\n' % tag)

def q(s): return '"' + s.replace('\\', '\\\\').replace('"', '\\"') + '"'
L = ['''-- OTS: hala wierzchowcow. Plik generowany razem z mapa world/custom/ots-mounts.otbm.
-- Kazdy pad prowadzi do zagrody z 5 stworzeniami do oswojenia (odradzaja sie po ok. minucie).
-- Przedmioty do oswajania sprzedaje Tamer w hali, po 1 gp. Samo oswajanie robi skrypt silnika.

local PAD_ACTION_ID = %d
local hall = Position(%d, %d, %d)
local hubLobby = Position(%d, %d, %d)
local tamerPosition = Position(%d, %d, %d)

local mounts = {''' % (PAD_AID, *hall, *HUB_LOBBY, *tamer)]
for o, r in zip(mounts, rooms):
    L.append('\t{ name = %s, item = %d, itemName = %s, mountId = %d, entry = Position(%d, %d, %d), display = Position(%d, %d, %d), faceSouth = %s, outfit = { %s } },' % (q(o['name']), o['item'], q(o['itemName']), o['mountId'], *r['entry'], o['display'][0], o['display'][1], Z, 'true' if o['display'][2] < 0 else 'false', ', '.join('%s = %d' % kv for kv in o['outfit'].items())))
L.append('}\n\nlocal pads = {')
for k, a in sorted(pads.items()):
    if a['kind'] == 'room': v = '{ room = %d }' % (a['index'] + 1)
    elif a['kind'] == 'goto': v = '{ goto = Position(%d, %d, %d), label = %s }' % (*a['pos'], q(a['label']))
    else: v = '{ %s = true }' % a['kind']
    L.append('\t[%s] = %s,' % (q(k), v))
L.append('}\n\nlocal navNpcs = {')
for who, x, y in navnpcs:
    L.append('\t{ name = %s, position = Position(%d, %d, %d) },' % (q(who), x, y, Z))
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

-- Wejscie z hubu i z menu !tp.
function OtsMountHall(player)
	move(player, hall, "Wierzchowce, pietro 1")
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
		local mount = mounts[pad.room]
		local text
		if player:hasMount(mount.mountId) then
			text = mount.name .. ": tego wierzchowca juz masz."
		else
			text = string.format("%s: uzyj na nim przedmiotu %s.", mount.name, mount.itemName)
		end
		move(player, mount.entry, text)
	elseif pad.goto then
		move(player, pad.goto, pad.label)
	elseif pad.hub then
		move(player, hubLobby)
	end
	return true
end

padStep:type("stepin")
padStep:aid(PAD_ACTION_ID)
padStep:register()

-- Postacie pokazowe: wyglad stworzenia do oswojenia, po jednej za kazdym padem.
local function displayName(mount)
	return "Mount " .. mount.name
end

for _, mount in ipairs(mounts) do
	local name = displayName(mount)
	local npcType = Game.createNpcType(name)
	npcType:register({
		name = name,
		description = name,
		health = 100,
		maxHealth = 100,
		walkInterval = 0,
		walkRadius = 0,
		outfit = mount.outfit,
		flags = { floorchange = false },
	})
end

-- Tamer: sprzedaje wszystkie przedmioty do oswajania.
local tamerName = "Tamer"
local tamerType = Game.createNpcType(tamerName)
local tamerConfig = {
	name = tamerName,
	description = tamerName,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = { lookType = 144, lookHead = 114, lookBody = 120, lookLegs = 120, lookFeet = 114, lookAddons = 3 },
	flags = { floorchange = false },
	speechBubble = SPEECHBUBBLE_TRADE,
	shop = {},
}
for _, mount in ipairs(mounts) do
	tamerConfig.shop[#tamerConfig.shop + 1] = { itemName = mount.itemName, clientId = mount.item, buy = 1 }
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

tamerType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end
tamerType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end
tamerType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end
tamerType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end
tamerType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end
tamerType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|! Mam wszystko do oswajania wierzchowcow - powiedz {trade}.")
npcHandler:addModule(FocusModule:new(), tamerName, true, true, true)

tamerType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
tamerType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost) end
tamerType.onCheckItem = function(npc, player, clientId, subType) end

tamerType:register(tamerConfig)

local place = GlobalEvent("OtsMountHallNpcs")

function place.onStartup()
	local placed = 0
	for _, mount in ipairs(mounts) do
		local npc = Game.createNpc(displayName(mount), mount.display, false, true)
		if npc then
			npc:setMasterPos(mount.display)
			npc:setDirection(mount.faceSouth and DIRECTION_SOUTH or DIRECTION_NORTH)
			placed = placed + 1
		end
	end
	local guides = 0
	for _, guide in ipairs(navNpcs) do
		local npc = Game.createNpc(guide.name, guide.position, false, true)
		if npc then
			npc:setMasterPos(guide.position)
			npc:setDirection(DIRECTION_EAST)
			guides = guides + 1
		end
	end
	local tamer = Game.createNpc(tamerName, tamerPosition, false, true)
	if tamer then
		tamer:setMasterPos(tamerPosition)
		tamer:setDirection(DIRECTION_NORTH)
	end
	logger.info("[OTS mounty] Postacie pokazowe: {}/{}, przy padach: {}/{}, Tamer: {}", placed, #mounts, guides, #navNpcs, tamer and "tak" or "nie")
	return true
end

place:register()
''')
open('ots_mounts.lua', 'w').write('\n'.join(L))
json.dump(dict(hall=hall, count=n, floors=nfloors), open('mounts.json', 'w'))
xs = [k[0] for k in tiles]; ys = [k[1] for k in tiles]
print('mounts', n, 'floors', nfloors, 'tiles', len(tiles), 'spawns', len(spawns), 'bbox', min(xs), min(ys), max(xs), max(ys), 'bytes', len(out))
