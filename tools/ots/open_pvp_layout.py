"""Sala Open PvP: kopia prawdziwej pustyni z mapy Tibii (okolice oazy z rzeka i ruinami, 33062,32360)
+ druga kopia ruin na srodku i kepy palm (oslony). Wynik: data-otservbr-global/scripts/ots/open_pvp_layout.lua
Uzycie: python3 open_pvp_layout.py desert.pkl"""
import sys, pickle, re
sys.path.insert(0, '/home/claude/sprites')
import sprlib
from appearance_fields import fields
objs = sprlib.load_objects()
FL = {i: {f for f, _, _, _ in fields(o['flags'])} for i, o in objs.items()}
def unpass(i): return 13 in FL.get(i, set())

grid = pickle.load(open(sys.argv[1], 'rb'))
def tile(x, y):
    t = grid.get((x, y))
    if not t: return None
    g = t['ground']; its = [a[0] for a in t['items']]
    if g is None and its: g, its = its[0], its[1:]
    return [g, its]

W, H = 45, 35
SX, SY = 33062, 32360
lay = {}
for dx in range(W):
    for dy in range(H):
        t = tile(SX + dx, SY + dy)
        if t: lay[(dx, dy)] = t
# ruiny na srodku (kopia ruin z dolu)
RX0, RY0, RX1, RY1 = 33086, 32383, 33101, 32394
for x in range(RX0, RX1 + 1):
    for y in range(RY0, RY1 + 1):
        t = tile(x, y)
        if t: lay[(14 + x - RX0, 9 + y - RY0)] = t
# kepy palm
PALMS = [(5, 20, 3639), (6, 22, 3640), (4, 23, 3639), (8, 21, 3697),
         (37, 26, 3639), (39, 27, 3640), (36, 28, 3697),
         (12, 27, 3639), (30, 5, 3639), (32, 6, 3640), (31, 8, 3697), (2, 13, 3639), (3, 15, 3640)]
for dx, dy, iid in PALMS:
    t = lay.get((dx, dy))
    if t and not unpass(t[0]) and not any(unpass(i) for i in t[1]):
        t[1].append(iid)
def walk(dx, dy):
    t = lay.get((dx, dy))
    return t and t[0] and not unpass(t[0]) and not any(unpass(i) for i in t[1])
# landing i PZ 3x3: bez przeszkod
LX, LY = 22, 31
for dx in (-1, 0, 1):
    for dy in (-1, 0, 1):
        t = lay.get((LX + dx, LY + dy))
        assert t and not unpass(t[0]), ('landing', dx, dy)
        t[1] = [i for i in t[1] if not unpass(i)]
# punkty startu wrogow: najblizsze wolne pole do zadanych
def near(dx, dy):
    for r in range(0, 6):
        for ax in range(-r, r + 1):
            for ay in range(-r, r + 1):
                if walk(dx + ax, dy + ay): return (dx + ax, dy + ay)
    raise SystemExit('brak miejsca %d %d' % (dx, dy))
groups = [(0, [(4, 3), (6, 3), (5, 5), (3, 5)]), (8, [(40, 30), (38, 30), (39, 33)]), (16, [(24, 2), (22, 3), (26, 3)])]
out = ['-- OTS: sala Open PvP - wygenerowane przez tools/ots/open_pvp_layout.py (kopia pustyni z mapy Tibii).',
       '-- Kazdy wpis: przesuniecie od lewego gornego rogu sali (dx, dy), podloga, przedmioty.',
       'OtsOpenPvpLayout = {']
for (dx, dy), (g, its) in sorted(lay.items()):
    out.append('\t{ %d, %d, %d, { %s } },' % (dx, dy, g, ', '.join(map(str, its))))
out.append('}')
out.append('OtsOpenPvpLanding = { %d, %d }' % (LX, LY))
out.append('OtsOpenPvpGroups = {')
used = set()
for delay, pts in groups:
    ps = []
    for p in pts:
        q = near(*p)
        while q in used:
            q = near(q[0] + 1, q[1])
        used.add(q); ps.append('{ %d, %d }' % q)
    out.append('\t{ %d, { %s } },' % (delay, ', '.join(ps)))
out.append('}')
open('/home/claude/canary/data-otservbr-global/scripts/ots/open_pvp_layout.lua', 'w').write('\n'.join(out) + '\n')
pickle.dump(lay, open('/tmp/claude-0/open/lay.pkl', 'wb'))
print(len(lay), 'pol')
