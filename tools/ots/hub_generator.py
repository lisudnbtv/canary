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
tiers = [(100,'Exp do 100'),(300,'Exp 100-300'),(700,'Exp 300-700'),(1500,'Exp 700-1500'),(3000,'Exp 1500-3000'),(6000,'Exp 3000-6000'),(12000,'Exp 6000-12000'),(10**9,'Exp 12000+')]
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
lobby_w = 2 + PITCH * len(tiers)
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
board(X0 + lobby_w // 2 - 4, Y0 + 3, 'Stroje\nQuesty na stroje z dodatkami', SIGN_B)

wings = []
for t, (g, (_, label)) in enumerate(zip(groups, tiers)):
    yc = Y0 + WING_GAP * (t + 1)
    slots = (len(g) + 1) // 2
    x_end = X0 + 2 + PITCH * slots
    for x in range(X0 + 1, x_end):
        for y in range(yc - 1, yc + 2):
            floor(x, y)
    # pady powrotne do lobby na obu koncach korytarza
    pad(X0, yc, dict(kind='lobby'))
    pad(x_end, yc, dict(kind='lobby'))
    board(X0 - 1, yc, 'Lobby\nPowrot do wyboru skrzydla', SIGN_A)
    board(x_end + 1, yc, 'Lobby\nPowrot do wyboru skrzydla', SIGN_B)
    arrival = [X0 + 1 + (x_end - X0) // 2, yc, Z]
    for i, h in enumerate(g):
        s, side = divmod(i, 2)
        x = X0 + 3 + PITCH * s
        sign = -1 if side == 0 else 1
        pad(x, yc + 2 * sign, dict(kind='hunt', tier=t, index=g.index(h)))
        board(x, yc + 3 * sign, '%s\n%d exp, %d potworow w okolicy' % (h['name'], h['exp'], h['n']), SIGN_A if sign < 0 else SIGN_B)
        floor(x, yc + 4 * sign, pz=False)       # wysepka potwora, poza PZ
        spawns.append((h['name'], x, yc + 4 * sign))
    wings.append(dict(label=label, arrival=arrival, count=len(g)))
    pad(X0 + 2 + PITCH * t, Y0 - 2, dict(kind='wing', wing=t))
    board(X0 + 2 + PITCH * t, Y0 - 3, '%s\n%d potworow' % (label, len(g)))

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

# Hala bossow: korytarz dalej na polnoc, pad na bossa, za padem tabliczka i postac z wygladem bossa
BL = json.load(open('boss_looks.json'))
yb = Y0 - 80
bslots = (len(BL) + 1) // 2
b_end = X0 + 2 + PITCH * bslots
for x in range(X0 + 1, b_end):
    for y in range(yb - 1, yb + 2):
        floor(x, y)
pad(X0, yb, dict(kind='lobby')); board(X0 - 1, yb, 'Lobby\nPowrot do hubu', SIGN_A)
pad(b_end, yb, dict(kind='lobby')); board(b_end + 1, yb, 'Lobby\nPowrot do hubu', SIGN_B)
bosshall = [X0 + 1 + (b_end - X0) // 2, yb, Z]
boss_displays = []
for i, b in enumerate(BL):
    s, side = divmod(i, 2)
    x = X0 + 3 + PITCH * s
    sign = -1 if side == 0 else 1
    nice = ' '.join(w[:1].upper() + w[1:] for w in b['name'].split(' '))
    pad(x, yb + 2 * sign, dict(kind='boss', index=i))
    board(x, yb + 3 * sign, nice + ('\nWymagany poziom: %d' % b['lvl'] if b['lvl'] else '\nBez wymaganego poziomu'), SIGN_A if sign < 0 else SIGN_B)
    floor(x, yb + 4 * sign)
    boss_displays.append(dict(name=nice, outfit=b['outfit'], pos=[x, yb + 4 * sign, Z], south=sign < 0))

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
        body += esc(b'\x09' + struct.pack('<H', GROUND))
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
json.dump(dict(pads=pads, wings=wings, lobby=lobby_arrival, questhall=questhall, bosshall=bosshall, bossDisplays=boss_displays), open('hub.json', 'w'))
xs = [k[0] for k in tiles]; ys = [k[1] for k in tiles]
print('tiles', len(tiles), 'pads', len(pads), 'spawns', len(spawns), 'bbox', min(xs), min(ys), max(xs), max(ys), 'bytes', len(out))
for w in wings: print(w)
