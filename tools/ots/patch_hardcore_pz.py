#!/usr/bin/env python3
"""Dopisuje do mapy huba (ots-hub.otbm) po jednym polu z PZ w miejscu ladowania sal Hardcore Questow
(Wieza, Czempion Zywiolow, Wyscig z Czasem, Klatwa Obrona; Survival celowo bez PZ).
Reszte sal buduje hardcore_quests.lua przy starcie. Uzycie: patch_hardcore_pz.py MAPA.otbm"""
import struct, sys

LANDINGS = [(30260, 29909, 7), (30290, 29909, 7), (30320, 29909, 7), (30380, 29909, 7)]
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
lx, ly, lz = LANDINGS[0]
bx, by = lx & 0xFF00, ly & 0xFF00
node = bytearray(b'\xfe\x04' + esc(struct.pack('<HHB', bx, by, lz)))
for x, y, z in LANDINGS:
    assert (x & 0xFF00, y & 0xFF00, z) == (bx, by, lz)
    node += b'\xfe\x05' + esc(bytes([x & 0xFF, y & 0xFF]))
    node += esc(b'\x03' + struct.pack('<I', PZ))
    node += esc(b'\x09' + struct.pack('<H', GROUND))
    node += b'\xff'
node += b'\xff'
if bytes(node) in data:
    print('juz jest')
    sys.exit(0)
first = data.index(b'\xfe\x04')
open(path, 'wb').write(data[:first] + bytes(node) + data[first:])
print('dopisano', len(node), 'bajtow')
