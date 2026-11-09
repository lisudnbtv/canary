#!/usr/bin/env python3
"""Zwieksza pojemnosc zwlok potworow (containersize) x5 w items.xml - bot nie zbiera lootu z ziemi,
wiec wszystko musi sie zmiescic w ciele. Zwloki = monster.corpse z plikow potworow + lancuch decayTo
(kolejne stadia rozkladu, ktore tez sa pojemnikami). Uzycie: corpse_capacity.py items.xml katalog_potworow..."""
import re, sys, glob

MULT, CAP = 5, 150
path, dirs = sys.argv[1], sys.argv[2:]
text = open(path, encoding='utf-8').read()

ids = set()
for d in dirs:
    for f in glob.glob(d + '/**/*.lua', recursive=True):
        for m in re.finditer(r'monster\.corpse\s*=\s*(\d+)', open(f, encoding='utf-8', errors='ignore').read()):
            if int(m.group(1)) > 0:
                ids.add(int(m.group(1)))

block_re = re.compile(r'(\t<item id="(\d+)"[^>]*>)(.*?)(\n\t</item>)', re.S)
blocks = {int(m.group(2)): m for m in block_re.finditer(text)}
size_re = re.compile(r'key="containersize" value="(\d+)"', re.I)
decay_re = re.compile(r'key="decayTo" value="(\d+)"', re.I)

todo, seen = list(ids), set()
while todo:
    i = todo.pop()
    if i in seen or i not in blocks:
        continue
    seen.add(i)
    d = decay_re.search(blocks[i].group(3))
    if d and size_re.search(blocks[i].group(3)):
        todo.append(int(d.group(1)))

changed = 0
def fix(m):
    global changed
    i = int(m.group(2))
    body = m.group(3)
    if i not in seen:
        return m.group(0)
    s = size_re.search(body)
    if not s or int(s.group(1)) >= 100:
        return m.group(0)
    new = min(CAP, int(s.group(1)) * MULT)
    changed += 1
    body = body[:s.start(1)] + str(new) + body[s.end(1):]
    return m.group(1) + body + m.group(4)

text = block_re.sub(fix, text)
open(path, 'w', encoding='utf-8').write(text)
missing = sorted(ids - set(blocks))
print('zwlok (z lancuchem):', len(seen), 'zmienionych:', changed, 'bez wlasnego wpisu:', len(missing))
