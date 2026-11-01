#!/usr/bin/env python3
"""Dopisuje do mapy huba (ots-hub.otbm) pola 3x3 z PZ w miejscu ladowania sali FAST EXP.
Reszte sali (podloga, sciany) buduje skrypt przy starcie serwera (teleports.lua), ale flagi PZ
da sie nadac tylko w pliku mapy. Uzycie: patch_fast_exp_pz.py MAPA.otbm"""
import struct, sys

LANDING = (30230, 29909, 7)
GROUND = 410   # czarny marmur jak przy innych miejscach ladowania
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
lx, ly, lz = LANDING
bx, by = lx & 0xFF00, ly & 0xFF00
marker = b'\xfe\x04' + esc(struct.pack('<HHB', bx, by, lz))
node = bytearray(marker)
for dy in (-1, 0, 1):
    for dx in (-1, 0, 1):
        x, y = lx + dx, ly + dy
        node += b'\xfe\x05' + esc(bytes([x & 0xFF, y & 0xFF]))
        node += esc(b'\x03' + struct.pack('<I', PZ))
        node += esc(b'\x09' + struct.pack('<H', GROUND))
        node += b'\xff'
node += b'\xff'
if bytes(node) in data:
    print('juz jest')
    sys.exit(0)
first = data.index(b'\xfe\x04')   # pierwszy obszar pol w MAP_DATA
out = data[:first] + bytes(node) + data[first:]
open(path, 'wb').write(out)
print('dopisano', len(node), 'bajtow')
