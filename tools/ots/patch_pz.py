#!/usr/bin/env python3
"""Ustawia flage protection zone na polach 3x3 wokol podanych pozycji w pliku OTBM.

Uzycie: patch_pz.py MAPA.otbm cele.json
Przy pierwszym uruchomieniu tworzy kopie MAPA.otbm.orig. Mozna uruchamiac wielokrotnie.
"""
import json
import os
import re
import shutil
import sys
import time

START, END, ESC = 0xFE, 0xFF, 0xFD
PZ_FLAG = 1
ATTR_TILE_FLAGS = 3
TILE, HOUSETILE, TILE_AREA = 5, 14, 4

src, targets_path = sys.argv[1], sys.argv[2]
t0 = time.time()
targets = json.load(open(targets_path))
# Format: lista srodkow [x, y, z] (strefa 3x3) albo {"centers": [...], "tiles": [...]},
# gdzie "tiles" to pojedyncze pola oznaczane bez otoczenia.
if isinstance(targets, dict):
    centers, single = targets.get("centers", []), targets.get("tiles", [])
else:
    centers, single = targets, []
want = {}
for x, y, z in centers:
    for dx in (-1, 0, 1):
        for dy in (-1, 0, 1):
            X, Y = x + dx, y + dy
            want.setdefault((X & 0xFF00, Y & 0xFF00, z), set()).add((X & 0xFF, Y & 0xFF))
for X, Y, z in single:
    want.setdefault((X & 0xFF00, Y & 0xFF00, z), set()).add((X & 0xFF, Y & 0xFF))
total_wanted = sum(len(v) for v in want.values())

data = open(src, "rb").read()
print("wczytano %d bajtow, pol do oznaczenia: %d" % (len(data), total_wanted), flush=True)


def rd(i):
    if data[i] == ESC:
        return data[i + 1], i + 2
    return data[i], i + 1


special = re.compile(b"[\xfd\xfe\xff]")
edits = []
seen = set()
areas = unaligned = already = added = updated = house = 0

for m in re.finditer(b"\xfe\x04", data):
    i = m.start()
    k = i - 1
    while k >= 0 and data[k] == ESC:
        k -= 1
    if (i - 1 - k) % 2 == 1:
        continue  # zakodowany bajt danych, nie poczatek wezla
    p = i + 2
    b0, p = rd(p)
    b1, p = rd(p)
    b2, p = rd(p)
    b3, p = rd(p)
    z, p = rd(p)
    bx, by = b0 | (b1 << 8), b2 | (b3 << 8)
    areas += 1
    if (bx & 0xFF) or (by & 0xFF):
        unaligned += 1
    cells = want.get((bx, by, z))
    if not cells:
        continue
    while data[p] == START:
        t, q = rd(p + 1)
        ox, q = rd(q)
        oy, q = rd(q)
        if t == HOUSETILE:
            for _ in range(4):
                _, q = rd(q)
        if (ox, oy) in cells:
            pos = (bx + ox, by + oy, z)
            if pos not in seen:
                seen.add(pos)
                if t == HOUSETILE:
                    house += 1
                elif t == TILE:
                    if data[q] == ATTR_TILE_FLAGS:
                        if data[q + 1] & PZ_FLAG:
                            already += 1
                        else:
                            edits.append((q + 1, q + 2, bytes([data[q + 1] | PZ_FLAG])))
                            updated += 1
                    else:
                        edits.append((q, q, bytes([ATTR_TILE_FLAGS, PZ_FLAG, 0, 0, 0])))
                        added += 1
        depth = 1
        while depth:
            s = special.search(data, q)
            c = data[s.start()]
            if c == ESC:
                q = s.start() + 2
            else:
                depth += 1 if c == START else -1
                q = s.start() + 1
        p = q

print("obszary mapy: %d (niewyrownane: %d)" % (areas, unaligned))
print("pola znalezione: %d z %d" % (len(seen), total_wanted))
print("  nowa flaga: %d, dopisana do istniejacych flag: %d, juz PZ: %d, domki (pominiete): %d" % (added, updated, already, house))

if not edits:
    print("brak zmian do zapisania")
    sys.exit(0)

backup = src + ".orig"
if not os.path.exists(backup):
    shutil.copyfile(src, backup)
    print("kopia zapasowa: " + backup)

edits.sort()
out = []
last = 0
for a, b, rep in edits:
    out.append(data[last:a])
    out.append(rep)
    last = b
out.append(data[last:])
blob = b"".join(out)
with open(src, "r+b") as f:
    f.seek(0)
    f.write(blob)
    f.truncate()
print("zapisano %d bajtow w %.1f s" % (len(blob), time.time() - t0))
