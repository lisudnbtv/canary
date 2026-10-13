"""OTS: podmienia slabe gatunki w salach questow na stroje na mocniejsze.

Uruchomienie z katalogu canary: python3 tools/ots/outfit_strengthen.py
Gatunek slabszy niz MIN_EXP dostaje zastepce z puli gatunkow, ktore juz stoja w salach
(sprawdzone, ze sie pojawiaja), w przedziale MIN_EXP..MAX_POOL_EXP, rosnaco wraz z numerem sali.
Plik ots-outfits-monster.xml jest zmieniany w miejscu; ponowne uruchomienie nic nie zmienia.
"""
import os
import re
from collections import OrderedDict

ROOT = 'data-otservbr-global'
XML = os.path.join(ROOT, 'world/custom/ots-outfits-monster.xml')
LUA = os.path.join(ROOT, 'scripts/ots/outfit_quests.lua')
MIN_EXP = 2500
MAX_POOL_EXP = 7000
SKIP = {'goggle cake', 'candy horror', 'crazed summer rearguard', 'crazed summer vanguard', 'crazed winter vanguard'}

exp = {}
for root, _, files in os.walk(os.path.join(ROOT, 'monster')):
    for f in files:
        if f.endswith('.lua'):
            t = open(os.path.join(root, f), errors='ignore').read()
            m = re.search(r'createMonsterType\("([^"]+)"', t)
            e = re.search(r'monster\.experience = (\d+)', t)
            if m and e:
                exp[m.group(1).lower()] = int(e.group(1))

lua = open(LUA).read()
rooms = [(int(m.group(1)), int(m.group(2))) for m in re.finditer(r'name = "[^"]+", male = \d+, female = \d+, x = (\d+), y = (\d+)', lua)]
xml = open(XML).read()
spawn_re = re.compile(r'(centerx="(\d+)" centery="(\d+)" centerz="7" radius="3">\s*<monster name=")([^"]+)(")')
spawns = [(int(m.group(2)), int(m.group(3)), m.group(4)) for m in spawn_re.finditer(xml)]


def room_of(x, y):
    for i, (rx, ry) in enumerate(rooms):
        if rx <= x < rx + 13 and ry <= y < ry + 13:
            return i
    return None


species = [OrderedDict() for _ in rooms]
for x, y, name in spawns:
    i = room_of(x, y)
    if i is not None:
        species[i][name] = 1

pool = sorted({n for s in species for n in s if MIN_EXP <= exp.get(n.lower(), 0) <= MAX_POOL_EXP and n.lower() not in SKIP}, key=lambda n: (exp[n.lower()], n))
weak = [(i, n) for i, s in enumerate(species) for n in s if exp.get(n.lower(), 0) < MIN_EXP]
mapping = {}
for k, (i, n) in enumerate(weak):
    mapping[(i, n)] = pool[min(len(pool) - 1, k * len(pool) // max(1, len(weak)))]


def repl(m):
    i = room_of(int(m.group(2)), int(m.group(3)))
    new = mapping.get((i, m.group(4)))
    return m.group(1) + (new or m.group(4)) + m.group(5)


open(XML, 'w').write(spawn_re.sub(repl, xml))
print('pool', len(pool), 'replaced species', len(weak))
for (i, n), new in mapping.items():
    print(i, n, '->', new, exp[new.lower()])
