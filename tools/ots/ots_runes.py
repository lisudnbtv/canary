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
TOOLS = [
    # id, wyglad z, nazwa, opis, waga - wlasne przedmioty, ktorych nie da sie zdobyc z potworow
    # (skrypt Clean Loot Pouch: data-otservbr-global/scripts/ots/commands.lua)
    (60105, 3454, 'clean loot pouch', 'Use it to remove everything from your loot pouch that the Loot Seller does not buy.', 1100),
    # klucz do sali FAST EXP w hubie (wystarczy miec go w plecaku); tylko 0,01% z Legendarnego Losowego Bossa
    (60106, 19082, 'fast exp token', 'Keep it in your backpack to use the FAST EXP teleport in the hub.', 10),
    # legendarne bossy (skrypt: data-otservbr-global/scripts/ots/legendary_items.lua)
    (60117, 9636, 'heart of morgaroth', 'Use it on a melee or distance weapon: +3 attack, up to +15.', 500),
    # kamien expa (skrypt: data-otservbr-global/scripts/ots/exp_stone.lua), nigdzie nie do zdobycia
    (60124, 3062, 'experience stone', 'Use it: 500% experience (x5) for 1 hour. Using it again adds another hour.', 10),
]

AMULETS = [
    # id, wyglad z, nazwa, opis, ochrona przed wszystkimi zywiolami (%) - nagroda z Hardcore Questow
    (60107, 22746, 'elemental champion amulet', 'Reward for the Champion of Elements: +30% protection against every kind of damage.', 30),
]


# Ekwipunek z legendarnych bossow (data-otservbr-global/scripts/ots/legendary_bosses.lua):
# kopia definicji przedmiotu bazowego z items.xml pod nowym id i nazwa, bez ograniczen profesji,
# z wymaganym poziomem LEGEND_LEVEL; 'set' nadpisuje/dodaje atrybuty, 'scale' mnozy obrazenia i atak.
LEGEND_LEVEL = 4000
ALL = 'absorbpercentall'
EQUIP = [
    # id, baza, nazwa, opis, set, scale
    (60108, 28715, 'apocalypse helmet', 'Apocalypse Set (1/4). Dropped by Apocalypse Reborn.', {ALL: 5, 'armor': 16, 'skillshield': 4, 'magiclevelpoints': 3, 'skillsword': 3, 'skillaxe': 3, 'skillclub': 3, 'skilldist': 3}, 1),
    (60109, 34094, 'apocalypse armor', 'Apocalypse Set (2/4). Dropped by Apocalypse Reborn.', {ALL: 6, 'armor': 26, 'magiclevelpoints': 4, 'skillsword': 4, 'skillaxe': 4, 'skillclub': 4, 'skilldist': 4}, 1),
    (60110, 34092, 'apocalypse legs', 'Apocalypse Set (3/4). Dropped by Apocalypse Reborn.', {ALL: 5, 'armor': 16, 'magiclevelpoints': 3, 'skillsword': 3, 'skillaxe': 3, 'skillclub': 3, 'skilldist': 3}, 1),
    (60111, 34097, 'pair of apocalypse boots', 'Apocalypse Set (4/4). Dropped by Apocalypse Reborn.', {ALL: 4, 'armor': 8, 'speed': 60}, 1),
    (60112, 34090, 'inferno wand', 'Burns with the flames of Infernatil.', {'shootType': 'fire', 'wandType': 'fire', 'magiclevelpoints': 6, 'absorbpercentfire': 15}, 4),
    (60113, 34091, 'inferno rod', 'Burns with the flames of Infernatil.', {'shootType': 'fire', 'wandType': 'fire', 'magiclevelpoints': 6, 'absorbpercentfire': 15}, 4),
    (60114, 8864, "bazir's mask", 'Nobody knows the real face of Bazir.', {ALL: 12, 'armor': 14, 'magiclevelpoints': 3}, 1),
    (60115, 30401, 'death amulet', 'Torn from Ashfalor of Death.', {'primarytype': 'amulets and necklaces', 'absorbpercentdeath': 40, ALL: 8, 'armor': 4}, 1),
    (60116, 5903, "ferumbras' absolute hat", 'Ferumbras has fallen. Forever?', {ALL: 6, 'armor': 12, 'magiclevelpoints': 8}, 1),
    (60118, 829, 'frozen crown', 'Cold as the heart of Zushuka.', {'absorbpercentice': 30, 'absorbpercentenergy': 30, ALL: 4, 'armor': 14}, 1),
    (60119, 34082, "ghazbaran's sword", 'The blade of Ghazbaran the Warrior.', {'skillsword': 10, 'attack': 30}, 2.5),
    (60120, 34084, "ghazbaran's axe", 'The axe of Ghazbaran the Warrior.', {'skillaxe': 10, 'attack': 30}, 2.5),
    (60121, 34086, "ghazbaran's club", 'The club of Ghazbaran the Warrior.', {'skillclub': 10, 'attack': 30}, 2.5),
    (60122, 34098, 'pair of plague boots', 'They spread regeneration instead of plague.', {'absorbpercentearth': 20, ALL: 4, 'armor': 8, 'speed': 50, 'healthgain': 3000, 'healthticks': 2000, 'managain': 2000, 'manaticks': 2000}, 1),
    (60123, 27565, "void lord's sigil", 'Reward from the Void Lord. The best amulet in the world.', {ALL: 35, 'armor': 8, 'magiclevelpoints': 6, 'skillsword': 6, 'skillaxe': 6, 'skillclub': 6, 'skilldist': 6, 'skillshield': 6, 'speed': 40}, 1),
]
SCALE_KEYS = re.compile(r'^(attack|defense|extradef|fromDamage|toDamage|element\w+)$')
DROP_KEYS = {'vocation', 'description', 'charges', 'duration', 'decayTo', 'transformEquipTo', 'transformDeEquipTo', 'showduration', 'showcharges', 'stopduration'}


def equip_xml(text, entry):
    nid, src, name, desc, sets, scale = entry
    m = re.search(r'\t<item id="%d"[^>]*>.*?\n\t</item>' % src, text, flags=re.S)
    lines = m.group(0).split('\n')
    out = ['\t<item id="%d" article="a" name="%s">' % (nid, name),
           '\t\t<attribute key="description" value="%s"/>' % desc]
    pending = dict(sets)
    level_done = False
    for line in lines[1:-1]:
        k = re.search(r'key="([^"]+)" value="([^"]*)"', line)
        key = k.group(1) if k else None
        if key in DROP_KEYS:
            continue
        top = line.startswith('\t\t<') and not line.startswith('\t\t\t')
        if key and (top or key == 'wandType') and key in pending:
            line = line[:k.start(2)] + str(pending.pop(key)) + line[k.end(2):]
        elif key and SCALE_KEYS.match(key) and scale != 1:
            try:
                line = line[:k.start(2)] + str(int(round(int(k.group(2)) * scale))) + line[k.end(2):]
            except ValueError:
                pass
        if key == 'level':
            continue
        if key == 'weight' and top:
            for pk, pv in list(pending.items()):
                if pk != 'wandType':
                    out.append('\t\t<attribute key="%s" value="%s"/>' % (pk, pv))
                    pending.pop(pk)
        if key == 'script' and not level_done:
            out.append(line)
            out.append('\t\t\t<attribute key="level" value="%d"/>' % LEGEND_LEVEL)
            level_done = True
            continue
        out.append(line)
    for pk, pv in pending.items():
        if pk == 'wandType':
            continue
        out.insert(2, '\t\t<attribute key="%s" value="%s"/>' % (pk, pv))
    out.append('\t\t<attribute key="showattributes" value="1"/>') if 'showattributes' not in m.group(0) else None
    out.append('\t</item>')
    return out


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
            if level:
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
    ids = {r[0] for r in RUNES + POTIONS + TOOLS + AMULETS + EQUIP}
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
            for entry in TOOLS:
                out += b'\x0a' + lenp(clone(objs[entry[1]], entry[0], entry[2], 0))
            for entry in AMULETS:
                out += b'\x0a' + lenp(clone(objs[entry[1]], entry[0], entry[2], 0))
            for entry in EQUIP:
                out += b'\x0a' + lenp(clone(objs[entry[1]], entry[0], entry[2], LEGEND_LEVEL, []))
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
    for tid, src, name, desc, weight in TOOLS:
        block += ['\t<item id="%d" article="a" name="%s">' % (tid, name),
                  '\t\t<attribute key="primarytype" value="tools"/>',
                  '\t\t<attribute key="description" value="%s"/>' % desc,
                  '\t\t<attribute key="weight" value="%d"/>' % weight,
                  '\t</item>']
    for aid, src, name, desc, absorb in AMULETS:
        block += ['\t<item id="%d" article="an" name="%s">' % (aid, name),
                  '\t\t<attribute key="primarytype" value="amulets and necklaces"/>',
                  '\t\t<attribute key="description" value="%s"/>' % desc,
                  '\t\t<attribute key="weight" value="420"/>',
                  '\t\t<attribute key="slotType" value="necklace"/>',
                  '\t\t<attribute key="showattributes" value="1"/>',
                  '\t\t<attribute key="absorbpercentall" value="%d"/>' % absorb,
                  '\t</item>']
    for entry in EQUIP:
        block += equip_xml(text, entry)
    block.append('\t<!-- /OTS runes -->')
    i = text.rindex('</items>')
    text = text[:i].rstrip('\n') + '\n' + '\n'.join(block) + '\n' + text[i:]
    open(x_out, 'w', encoding='utf-8').write(text)
    print('runes', len(RUNES), 'potions', len(POTIONS), 'tools', len(TOOLS), 'amulets', len(AMULETS), 'equip', len(EQUIP), 'appearances', len(out))


if __name__ == '__main__':
    main()
