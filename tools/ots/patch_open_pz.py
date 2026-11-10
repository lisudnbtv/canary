#!/usr/bin/env python3
"""Dopisuje do mapy huba (ots-hub.otbm) PZ 3x3 przy wejsciu na Arena PvP - Open PvP
(30310, 30340, 30370, 30400 x 30018). Sale buduje arena_pvp.lua przy starcie.
Uzycie: patch_open_pz.py MAPA.otbm"""
import struct, sys

LANDINGS = [(30322 + dx, 30101 + dy, 7) for dx in (-1, 0, 1) for dy in (-1, 0, 1)]
GROUND = 11285  # podloga z sali Obrona (pole ladowania w bestiary_room_layout.lua)
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
for x, y, z in LANDINGS:
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
print('dopisano', added, 'bajtow')
