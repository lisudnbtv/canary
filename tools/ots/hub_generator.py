"""Generuje hub expowisk jako osobna mape (world/custom/ots-hub.otbm) ze spawnami potworow."""
import json, bisect, struct, re, collections, os, sys
from xml.sax.saxutils import quoteattr

X0, Y0, Z = 30000, 30000, 7
GROUND = 410          # black marble floor
TELEPORT = 1949       # magic forcefield
PAD_AID = 64992
SIGN_A = 2016        # stojaca tabliczka (polnoc/zachod)
SIGN_B = 2014        # stojaca tabliczka (poludnie/wschod)
PITCH = 3
WING_GAP = 40
PZ = 1

d = json.load(open('data2.json'))
tiers = [(300, 'Low'), (1500, 'Medium'), (6000, 'Hard'), (10**9, 'Very Hard')]
RANGES = ['exp do 300', 'exp 300-1500', 'exp 1500-6000', 'exp 6000+']
TIER_LOOKS = [128, 131, 335, 541]   # Citizen, Knight, Warmaster, Demon
ROWCAP = 60          # potworow w jednym rzedzie skrzydla
ROW_GAP = 10
lim = [t[0] for t in tiers]
groups = [[] for _ in tiers]
for i, h in enumerate(d['hunts']):
    groups[bisect.bisect_left(lim, h['exp'])].append(h)

tiles = {}      # (x,y,z) -> dict(pz=bool, items=[(id, aid)])
pads = {}       # "x:y:z" -> action
spawns = []     # (name, x, y)

def floor(x, y, pz=True):
    tiles.setdefault((x, y, Z), dict(pz=pz, items=[]))
def pad(x, y, action):
    floor(x, y)
    tiles[(x, y, Z)]['items'].append((TELEPORT, PAD_AID, None))
    pads['%d:%d:%d' % (x, y, Z)] = action

def board(x, y, text, item=SIGN_A):
    floor(x, y)
    tiles[(x, y, Z)]['items'].append((item, 0, text))

# Lobby: platforma z rzedem padow do skrzydel (polnoc) i padem do Thais (poludnie)
lobby_w = 26
for x in range(X0, X0 + lobby_w + 1):
    for y in range(Y0 - 1, Y0 + 2):
        floor(x, y)
lobby_arrival = [X0 + lobby_w // 2, Y0, Z]
pad(X0 + lobby_w // 2, Y0 + 2, dict(kind='thais'))
board(X0 + lobby_w // 2, Y0 + 3, 'Thais\nPowrot do swiatyni', SIGN_B)
pad(X0 + lobby_w // 2 - 4, Y0 + 2, dict(kind='outfits'))
pad(X0 + lobby_w // 2 + 4, Y0 + 2, dict(kind='questhall'))
pad(X0 + lobby_w // 2 + 8, Y0 + 2, dict(kind='bosshall'))
board(X0 + lobby_w // 2 + 8, Y0 + 3, 'Bossy\nHala bossow', SIGN_B)
board(X0 + lobby_w // 2 + 4, Y0 + 3, 'Questy\nHala questow z nagrodami', SIGN_B)
board(X0 + lobby_w // 2 - 4, Y0 + 3, 'Outfity\nQuesty na stroje z dodatkami', SIGN_B)

wings = []
npcs = []
# postacie przy padach po poludniowej stronie lobby
_mid = X0 + lobby_w // 2
for dx, name, look in ((-4, 'Outfity', 273), (0, 'Thais', 128), (4, 'Questy', 367), (8, 'Bossy', 289)):
    floor(_mid + dx + 1, Y0 + 2)
    npcs.append(dict(name=name, outfit={'lookType': look, 'lookHead': 78, 'lookBody': 69, 'lookLegs': 58, 'lookFeet': 76, 'lookAddons': 3}, pos=[_mid + dx + 1, Y0 + 2, Z], south=False))
FLOOR_N = 24         # pozycji na jednym pietrze (2 rzedy po 12)
ROW_N = 12
COL_PITCH = 45       # odstep miedzy kolumnami pieter (osobna kolumna na kazdy poziom)
FLOOR_PITCH = 26

def build_floors(entries, x0, y_first, step, title, pad_action, sign_text, behind, range_text):
    """Pietra: kazde to pierscien z dwoch rzedow, polaczonych na obu koncach.
    Na zachodzie pady: poprzednie pietro, lobby, nastepne pietro (ostatnie wraca na pierwsze)."""
    chunks = [entries[i:i + FLOOR_N] for i in range(0, len(entries), FLOOR_N)]
    n = len(chunks)
    arrivals = [[x0 - 2, y_first + step * k + 5, Z] for k in range(n)]
    x_end = x0 + 2 + PITCH * (ROW_N // 2)
    for k, chunk in enumerate(chunks):
        yc = y_first + step * k
        name = '%s %d/%d' % (title, k + 1, n)
        for x in list(range(x0 - 3, x0)) + list(range(x_end, x_end + 3)):
            for y in range(yc - 1, yc + 12):
                floor(x, y)
        for r in range(2):
            yr = yc + 10 * r
            for x in range(x0, x_end):
                for y in range(yr - 1, yr + 2):
                    floor(x, y)
        for j, e in enumerate(chunk):
            r, jj = divmod(j, ROW_N)
            s_, side = divmod(jj, 2)
            x = x0 + 3 + PITCH * s_
            yr = yc + 10 * r
            sign = -1 if side == 0 else 1
            pad(x, yr + 2 * sign, pad_action(k * FLOOR_N + j, e))
            board(x, yr + 3 * sign, sign_text(e), SIGN_A if sign < 0 else SIGN_B)
            behind(e, x, yr + 4 * sign, sign < 0)
        def nav(y, target, text):
            if target is None:
                pad(x0 - 4, y, dict(kind='lobby'))
            else:
                tk = target % n
                pad(x0 - 4, y, dict(kind='goto', pos=arrivals[tk], label='%s %d/%d (%s)' % (title, tk + 1, n, range_text(chunks[tk]))))
            board(x0 - 5, y, text, SIGN_A)
        if n > 1:
            nav(yc + 3, k - 1, 'Poprzednie pietro\n%s %d/%d' % (title, (k - 1) % n + 1, n))
            nav(yc + 7, k + 1, 'Nastepne pietro\n%s %d/%d' % (title, (k + 1) % n + 1, n))
        nav(yc + 5, None, 'Lobby\nTu jestes: %s\n%s' % (name, range_text(chunk)))
    return arrivals

for t, (g, (_, label)) in enumerate(zip(groups, tiers)):
    def _behind(h, x, y, north):
        floor(x, y, pz=False)       # wysepka potwora, poza PZ
        spawns.append((h['name'], x, y))
    arr = build_floors(g, X0 + COL_PITCH * t, Y0 + WING_GAP, FLOOR_PITCH, label,
        lambda i, h, t=t: dict(kind='hunt', tier=t, index=i),
        lambda h: '%s\n%d exp, %d potworow w okolicy' % (h['name'], h['exp'], h['n']),
        _behind,
        lambda ch: 'exp %d-%d' % (ch[0]['exp'], ch[-1]['exp']))
    wings.append(dict(label='%s (%s)' % (label, RANGES[t]), arrival=arr[0], count=len(g), floors=len(arr)))
    # lobby: pad poziomu, za nim tabliczka, obok postac z nazwa poziomu
    lx = X0 + 4 + 6 * t
    pad(lx, Y0 - 2, dict(kind='wing', wing=t))
    board(lx, Y0 - 3, '%s\n%s\n%d potworow, %d pieter' % (label, RANGES[t], len(g), len(arr)))
    floor(lx + 1, Y0 - 2)
    npcs.append(dict(name=label, outfit={'lookType': TIER_LOOKS[t], 'lookHead': 78, 'lookBody': 69, 'lookLegs': 58, 'lookFeet': 76, 'lookAddons': 3}, pos=[lx + 1, Y0 - 2, Z], south=True))

# Hala questow: korytarz na polnoc od lobby, pad na quest, za padem tabliczka i nagrody
QM = json.load(open('quests_menu.json'))
QP = 5
yq = Y0 - 40
qslots = (len(QM) + 1) // 2
q_end = X0 + 3 + QP * qslots
for x in range(X0 + 1, q_end):
    for y in range(yq - 1, yq + 2):
        floor(x, y)
pad(X0, yq, dict(kind='lobby')); board(X0 - 1, yq, 'Lobby\nPowrot do hubu', SIGN_A)
pad(q_end, yq, dict(kind='lobby')); board(q_end + 1, yq, 'Lobby\nPowrot do hubu', SIGN_B)
questhall = [X0 + 1 + (q_end - X0) // 2, yq, Z]
for i, qm in enumerate(QM):
    s, side = divmod(i, 2)
    x = X0 + 4 + QP * s
    sign = -1 if side == 0 else 1
    pad(x, yq + 2 * sign, dict(kind='quest', index=i))
    board(x, yq + 3 * sign, qm['name'] + '\nNagrody leza za tabliczka', SIGN_A if sign < 0 else SIGN_B)
    for j, iid in enumerate(qm['items'][:6]):
        ix = x - 1 + j % 3
        iy = yq + (4 + j // 3) * sign
        floor(ix, iy)
        tiles[(ix, iy, Z)]['items'].append((iid, 0, None))

# Hala bossow: pietra po 24 bossy, kolejne pietra na polnoc
BL = json.load(open('bosses_all.json'))
boss_displays = []
def _nice(b): return ' '.join(w[:1].upper() + w[1:] for w in b['name'].split(' '))
def _bsign(b):
    if b['pos']:
        return _nice(b) + '\n' + ('Dzwignia bossa. Wymagany poziom: %d' % b['lvl'] if b['lvl'] else 'Dzwignia bossa. Bez wymaganego poziomu')
    return _nice(b) + '\nArena. HP bossa: %d' % b['hp']
def _bbehind(b, x, y, north):
    floor(x, y)
    boss_displays.append(dict(name=_nice(b), outfit=b['outfit'], pos=[x, y, Z], south=north))
def _brange(ch):
    return 'bossy z dzwignia' if ch[-1]['pos'] else ('dzwignie i arena' if ch[0]['pos'] else 'arena, HP %d-%d' % (ch[0]['hp'], ch[-1]['hp']))
_barr = build_floors(BL, X0, Y0 - 90, -FLOOR_PITCH, 'Bossy', lambda i, b: dict(kind='boss', index=i), _bsign, _bbehind, _brange)
bosshall = _barr[0]
boss_floors = len(_barr)

# Arena: wspolna sala walk dla bossow bez dzwigni i dla questow z walka. Poza PZ.
ARENA_R = 10
arena_center = [X0 + 60, Y0 - 100, Z]
for x in range(arena_center[0] - ARENA_R, arena_center[0] + ARENA_R + 1):
    for y in range(arena_center[1] - ARENA_R, arena_center[1] + ARENA_R + 1):
        floor(x, y, pz=False)
arena_landing = [arena_center[0], arena_center[1] + ARENA_R - 1, Z]

# ---- wystroj: szachownica z marmuru, drewno pod padami, trawa pod potworami i na arenie,
# zywoplot z krzakow dookola (blokuje przejscie) i pas trawy z kwiatami i drzewami dalej.
MARBLE_A, MARBLE_B, WOOD, GRASS = 409, 410, 408, 4515
BUSHES = [3681, 3682, 3699]
FLOWERS = [3654, 3655, 3656, 3657, 3658, 3659]
TREES = [3614, 3615, 3617, 3618, 3620, 3621]
def _h(x, y, salt=0):
    v = (x * 73856093) ^ (y * 19349663) ^ (salt * 83492791)
    return (v ^ (v >> 13)) & 0xFFFF
for (x, y, z), t in tiles.items():
    if not t['pz']:
        t['ground'] = GRASS
    elif any(i[0] == TELEPORT for i in t['items']):
        t['ground'] = WOOD
    else:
        t['ground'] = MARBLE_A if (x + y) % 2 else MARBLE_B
RIM = 4
dist = {}
for (x, y, z) in list(tiles):
    for dx in range(-RIM, RIM + 1):
        for dy in range(-RIM, RIM + 1):
            k = (x + dx, y + dy, z)
            if k in tiles:
                continue
            d = max(abs(dx), abs(dy))
            if d < dist.get(k, 99):
                dist[k] = d
for (x, y, z), d in dist.items():
    items = []
    r = _h(x, y)
    if d == 1:
        items.append((BUSHES[r % len(BUSHES)], 0, None))
    elif r % 100 < 22:
        items.append((FLOWERS[_h(x, y, 1) % len(FLOWERS)], 0, None))
    elif d >= 3 and r % 100 < 34:
        items.append((TREES[_h(x, y, 2) % len(TREES)], 0, None))
    tiles[(x, y, z)] = dict(pz=False, items=items, ground=GRASS)

# ---- zapis OTBM
def esc(b):
    out = bytearray()
    for c in b:
        if c in (0xFD, 0xFE, 0xFF):
            out.append(0xFD)
        out.append(c)
    return bytes(out)
def s16(text):
    raw = text.encode('latin-1')
    return struct.pack('<H', len(raw)) + raw

body = bytearray()
body += b'\xfe\x02'
attrs = b'\x01' + s16('OTS exp hub, generated') + b'\x0b' + s16('ots-hub-monster.xml') + b'\x0d' + s16('ots-hub-house.xml') + b'\x17' + s16('ots-hub-npc.xml') + b'\x18' + s16('ots-hub-zones.xml')
body += esc(attrs)
areas = collections.defaultdict(list)
for (x, y, z), t in tiles.items():
    areas[(x & 0xFF00, y & 0xFF00, z)].append((x & 0xFF, y & 0xFF, t))
for (bx, by, z), ts in sorted(areas.items()):
    body += b'\xfe\x04' + esc(struct.pack('<HHB', bx, by, z))
    for ox, oy, t in sorted(ts):
        body += b'\xfe\x05' + esc(bytes([ox, oy]))
        if t['pz']:
            body += esc(b'\x03' + struct.pack('<I', PZ))
        body += esc(b'\x09' + struct.pack('<H', t.get('ground', GROUND)))
        for iid, aid, text in t['items']:
            data = struct.pack('<H', iid)
            if aid:
                data += b'\x04' + struct.pack('<H', aid)
            if text:
                data += b'\x06' + s16(text)
            body += b'\xfe\x06' + esc(data) + b'\xff'
        body += b'\xff'
    body += b'\xff'
body += b'\xfe\x0c\xff'      # towns (puste)
body += b'\xfe\x0f\xff'      # waypoints (puste)
body += b'\xff'              # koniec MAP_DATA
header = b'\x00\x00\x00\x00' + b'\xfe\x00' + esc(struct.pack('<IHHII', 2, 0x855f, 0x8414, 3, 0x3e))
out = header + bytes(body) + b'\xff'
os.makedirs('hub', exist_ok=True)
open('hub/ots-hub.otbm', 'wb').write(out)
with open('hub/ots-hub-monster.xml', 'w') as f:
    f.write('<?xml version="1.0"?>\n<monsters>\n')
    for name, x, y in spawns:
        f.write('\t<monster centerx="%d" centery="%d" centerz="%d" radius="1">\n\t\t<monster name=%s x="0" y="0" z="%d" spawntime="60" />\n\t</monster>\n' % (x, y, Z, quoteattr(name), Z))
    f.write('</monsters>\n')
open('hub/ots-hub-house.xml', 'w').write('<?xml version="1.0"?>\n<houses />\n')
open('hub/ots-hub-npc.xml', 'w').write('<?xml version="1.0"?>\n<npcs />\n')
open('hub/ots-hub-zones.xml', 'w').write('<?xml version="1.0"?>\n<zones />\n')
json.dump(dict(pads=pads, wings=wings, lobby=lobby_arrival, questhall=questhall, bosshall=bosshall, bossDisplays=boss_displays, npcs=npcs, bossFloors=boss_floors, arena=dict(center=arena_center, landing=arena_landing, radius=ARENA_R)), open('hub.json', 'w'))
xs = [k[0] for k in tiles]; ys = [k[1] for k in tiles]
print('tiles', len(tiles), 'pads', len(pads), 'spawns', len(spawns), 'bbox', min(xs), min(ys), max(xs), max(ys), 'bytes', len(out))
for w in wings: print(w)
