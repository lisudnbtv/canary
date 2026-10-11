"""Wiecej potworow na expowiskach: kazdy punkt spawnu w promieniu 40 pol od miejsca ladowania
expowiska (to samo pietro) dostaje dwa dodatkowe potwory tego samego gatunku, czyli 3 zamiast 1.
Wynik to osobna 'mapa' world/custom/ots-spawns.otbm (jedno puste pole daleko od wszystkiego)
z plikiem ots-spawns-monster.xml - glowna lista spawnow zostaje nietknieta."""
import json, collections, struct, os
import xml.etree.ElementTree as ET
from xml.sax.saxutils import quoteattr

C = '/home/claude/canary/data-otservbr-global/world/'
R, EXTRA = 40, 2
d = json.load(open('data2.json'))
grid = collections.defaultdict(list)
for h in d['hunts']:
    x, y, z = h['pos']; grid[(x // R, y // R, z)].append((x, y))
def near(x, y, z):
    for gx in (-1, 0, 1):
        for gy in (-1, 0, 1):
            for hx, hy in grid.get((x // R + gx, y // R + gy, z), ()):
                if abs(hx - x) <= R and abs(hy - y) <= R: return True
    return False
bosses = {b['name'].lower() for b in json.load(open('bosses_all.json'))}
sel = []
for sp in ET.parse(C + 'otservbr-monster.xml').getroot():
    cx, cy, cz = int(sp.get('centerx')), int(sp.get('centery')), int(sp.get('centerz'))
    for m in sp:
        x, y, t = cx + int(m.get('x')), cy + int(m.get('y')), int(m.get('spawntime'))
        if m.get('name').lower() in bosses or t > 600: continue      # bez bossow i rzadkich spawnow
        if near(x, y, cz): sel.append((m.get('name'), x, y, cz, t))
os.makedirs('spawnsq', exist_ok=True)
with open('spawnsq/ots-spawns-monster.xml', 'w') as f:
    f.write('<?xml version="1.0"?>\n<monsters>\n')
    for name, x, y, z, t in sel:
        f.write('\t<monster centerx="%d" centery="%d" centerz="%d" radius="2">\n' % (x, y, z))
        for _ in range(EXTRA):
            f.write('\t\t<monster name=%s x="0" y="0" z="%d" spawntime="%d" />\n' % (quoteattr(name), z, t))
        f.write('\t</monster>\n')
    f.write('</monsters>\n')
for nm, tag in (('house', 'houses'), ('npc', 'npcs'), ('zones', 'zones')):
    open('spawnsq/ots-spawns-%s.xml' % nm, 'w').write('<?xml version="1.0"?>\n<%s />\n' % tag)
def esc(b):
    out = bytearray()
    for c in b:
        if c in (0xFD, 0xFE, 0xFF): out.append(0xFD)
        out.append(c)
    return bytes(out)
def s16(t):
    raw = t.encode('latin-1'); return struct.pack('<H', len(raw)) + raw
X, Y, Z = 29000, 29000, 7
body = bytearray(b'\xfe\x02')
body += esc(b'\x01' + s16('OTS extra spawns, generated') + b'\x0b' + s16('ots-spawns-monster.xml') + b'\x0d' + s16('ots-spawns-house.xml') + b'\x17' + s16('ots-spawns-npc.xml') + b'\x18' + s16('ots-spawns-zones.xml'))
body += b'\xfe\x04' + esc(struct.pack('<HHB', X & 0xFF00, Y & 0xFF00, Z))
body += b'\xfe\x05' + esc(bytes([X & 0xFF, Y & 0xFF])) + esc(b'\x09' + struct.pack('<H', 410)) + b'\xff\xff'
body += b'\xfe\x0c\xff\xfe\x0f\xff\xff'
open('spawnsq/ots-spawns.otbm', 'wb').write(b'\x00\x00\x00\x00\xfe\x00' + esc(struct.pack('<IHHII', 2, 0x855f, 0x8414, 3, 0x3e)) + bytes(body) + b'\xff')
print('punkty spawnu:', len(sel), 'dodatkowe potwory:', len(sel) * EXTRA)
