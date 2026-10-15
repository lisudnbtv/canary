"""OTS: wlasne runy i potiony (Elemental Storm Rune, Ultimate Arcane, Warrior i Hunter Potion). Klonuje wyglad istniejacej runy pod nowym id i dopisuje
definicje do items.xml. Skrypt czaru: data-otservbr-global/scripts/ots/elemental_rune.lua.
Uzycie: python3 runes.py <appearances.dat we> <appearances.dat wy> <items.xml we> <items.xml wy>"""
import sys, re
sys.path.insert(0, sys.path[0])
from appearance_fields import fields, ev

RUNES = [
    # id, wyglad z, nazwa, slowa czaru (runespellname), poziom
    (60101, 3195, 'elemental storm rune', 'adori mas omnia', 2500),
]
POTIONS = [
    # id, wyglad z, nazwa, opis, poziom, profesje w kliencie (1 knight, 2 paladin, 3 sorcerer, 4 druid, 5 monk) (skrypt: data-otservbr-global/scripts/ots/arcane_potion.lua)
    (60102, 23373, 'ultimate arcane potion', 'This potion can only be consumed by sorcerers and druids of level 130 or higher', 130, [4, 3]),
    (60103, 7643, 'ultimate warrior potion', 'This potion can only be consumed by knights and monks of level 130 or higher', 130, [1, 5]),
    (60104, 23374, 'ultimate hunter potion', 'This potion can only be consumed by paladins of level 130 or higher', 130, [2]),
]


def lenp(b):
    return ev(len(b)) + bytes(b)


def clone(sub, new_id, name, level, professions=None):
    out = bytearray()
    for ff, w, r, v in sub:
        if ff == 1 and w == 0:
            out += b'\x08' + ev(new_id)
        elif ff == 3 and w == 2:
            fl = bytearray()
            for f2, w2, r2, v2 in fields(v):
                if f2 in (40, 44, 63) or (professions is not None and f2 == 62):
                    continue      # dane NPC, cyklopedii, poziom (i profesje) oryginalu
                if f2 == 36:
                    m = bytearray()
                    for f3, w3, r3, v3 in fields(v2):
                        m += (bytes([f3 << 3]) + ev(new_id)) if f3 in (2, 3) else r3
                    fl += ev(36 << 3 | 2) + lenp(m)
                else:
                    fl += r2
            for prof in professions or []:
                fl += ev(62 << 3) + ev(prof)   # klient: profesje (3 sorcerer, 4 druid)
            fl += ev(63 << 3) + ev(level)   # klient: wymagany poziom
            out += b'\x1a' + lenp(fl)
        elif ff in (4, 5):
            continue
        else:
            out += r
    out += b'\x22' + lenp(name.encode())
    return out


def main():
    a_in, a_out, x_in, x_out = sys.argv[1:5]
    ids = {r[0] for r in RUNES + POTIONS}
    top = fields(open(a_in, 'rb').read())
    objs, last = {}, -1
    for n, (f, wt, raw, val) in enumerate(top):
        if f == 1:
            sub = fields(val)
            i = [v for (ff, w, r, v) in sub if ff == 1 and w == 0][0]
            objs[i] = sub
            if i not in ids:
                last = n
    out = bytearray()
    for n, (f, wt, raw, val) in enumerate(top):
        if f == 1:
            i = [v for (ff, w, r, v) in fields(val) if ff == 1 and w == 0][0]
            if i in ids:
                continue
        out += raw
        if n == last:
            for entry in RUNES:
                out += b'\x0a' + lenp(clone(objs[entry[1]], entry[0], entry[2], entry[4]))
            for entry in POTIONS:
                out += b'\x0a' + lenp(clone(objs[entry[1]], entry[0], entry[2], entry[4], entry[5]))
    open(a_out, 'wb').write(out)

    text = open(x_in, encoding='utf-8').read()
    text = re.sub(r'\n\t<!-- OTS runes -->.*?<!-- /OTS runes -->', '', text, flags=re.S)
    block = ['\t<!-- OTS runes -->']
    for rid, src, name, words, level in RUNES:
        block += ['\t<item id="%d" article="an" name="%s">' % (rid, name),
                  '\t\t<attribute key="primarytype" value="attack runes"/>',
                  '\t\t<attribute key="type" value="rune"/>',
                  '\t\t<attribute key="runespellname" value="%s"/>' % words,
                  '\t\t<attribute key="charges" value="1"/>',
                  '\t\t<attribute key="weight" value="70"/>',
                  '\t</item>']
    for pid, src, name, desc, level, professions in POTIONS:
        block += ['\t<item id="%d" article="an" name="%s">' % (pid, name),
                  '\t\t<attribute key="primarytype" value="liquids"/>',
                  '\t\t<attribute key="description" value="%s"/>' % desc,
                  '\t\t<attribute key="weight" value="310"/>',
                  '\t</item>']
    block.append('\t<!-- /OTS runes -->')
    i = text.rindex('</items>')
    text = text[:i].rstrip('\n') + '\n' + '\n'.join(block) + '\n' + text[i:]
    open(x_out, 'w', encoding='utf-8').write(text)
    print('runes', len(RUNES), 'potions', len(POTIONS), 'appearances', len(out))


if __name__ == '__main__':
    main()
