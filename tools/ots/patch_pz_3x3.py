#!/usr/bin/env python3
"""Dopisuje do mapy huba (ots-hub.otbm) PZ na 8 polach wokol ladowania sal, ktore mialy PZ tylko na jednym
polu (srodek jest juz w mapie z patch_hardcore_pz.py / patch_legend_pz.py) - wszedzie PZ 3x3 jak w FAST EXP
i Expowisku Party. Sale: 4 Hardcore Questy (bez Survival) i 10 Legendarnych Bossow.
Uzycie: patch_pz_3x3.py MAPA.otbm"""
import struct, sys

CENTERS = [(30260, 29909, 7), (30290, 29909, 7), (30320, 29909, 7), (30380, 29909, 7)]
CENTERS += [(30260 + 30 * n, 29939, 7) for n in range(10)]
TILES = [(x + dx, y + dy, z) for x, y, z in CENTERS for dx in (-1, 0, 1) for dy in (-1, 0, 1) if (dx, dy) != (0, 0)]
GROUND = 11285
PZ = 1


def esc(b):
    out = bytearray()
    for c in b:
        if c in (0xFD, 0xFE, 0xFF):
            out.append(0xFD)
        out.append(c)
    return bytes(out)


path = sys.argv[1]
data = open(path, 'rb').read()
areas = {}
for x, y, z in TILES:
    areas.setdefault((x & 0xFF00, y & 0xFF00, z), []).append((x, y))
added = 0
for (bx, by, bz), tiles in sorted(areas.items()):
    node = bytearray(b'\xfe\x04' + esc(struct.pack('<HHB', bx, by, bz)))
    for x, y in tiles:
        node += b'\xfe\x05' + esc(bytes([x & 0xFF, y & 0xFF]))
        node += esc(b'\x03' + struct.pack('<I', PZ))
        node += esc(b'\x09' + struct.pack('<H', GROUND))
        node += b'\xff'
    node += b'\xff'
    if bytes(node) in data:
        continue
    first = data.index(b'\xfe\x04')
    data = data[:first] + bytes(node) + data[first:]
    added += len(node)
open(path, 'wb').write(data)
print('dopisano', added, 'bajtow,', len(TILES), 'pol')
