"""OTS: sety EQ profesji do sklepu (Eternal). Klonuje wyglad istniejacych przedmiotow pod nowymi id,
dopisuje definicje do items.xml i generuje kategorie sklepu dla kazdej profesji.
Uzycie: python3 eq.py <appearances.dat wejscie> <appearances.dat wyjscie> <items.xml wejscie> <items.xml wyjscie> <katalog sklepu>"""
import sys, re, copy, json
import xml.etree.ElementTree as ET
sys.path.insert(0, sys.path[0])
from appearance_fields import fields, ev

LEVEL = 100
SLOTS = 4
PRICE = 4500
FIRST_ID = 60001
SKILL_KEYS = {'melee': ['skillsword', 'skillaxe', 'skillclub'], 'sword': ['skillsword'], 'axe': ['skillaxe'], 'club': ['skillclub'],
              'dist': ['skilldist'], 'magic': ['magiclevelpoints'], 'fist': ['skillfist'], 'shield': ['skillshield']}
SKILL_LABEL = {'skillsword': 'sword', 'skillaxe': 'axe', 'skillclub': 'club', 'skilldist': 'distance', 'magiclevelpoints': 'magic level',
               'skillfist': 'fist', 'skillshield': 'shielding'}
PROT = ['elemental protection death', 'elemental protection earth', 'elemental protection fire', 'elemental protection ice',
        'elemental protection energy', 'elemental protection holy']
BOOST = {'sword': 'skillboost sword', 'axe': 'skillboost axe', 'club': 'skillboost club', 'dist': 'skillboost distance',
         'magic': 'skillboost magic level', 'fist': 'skillboost fist', 'shield': 'skillboost shielding'}

# piece: (leech zycia, leech many, szansa kryt., obrazenia kryt.) w setnych procenta, cena TC
PIECE = {
    'weapon': (500, 200, 1000, 1500, 250),
    'armor': (200, 100, 200, 400, 200),
    'helmet': (200, 100, 200, 400, 150),
    'legs': (150, 100, 200, 300, 150),
    'boots': (100, 100, 100, 300, 100),
    'offhand': (100, 100, 200, 300, 150),
}
SKILL_BONUS = {'weapon': 6, 'armor': 4, 'helmet': 3, 'legs': 3, 'boots': 2, 'offhand': 4}

# (nazwa, zrodlo wygladu, rodzaj, skill, dodatki)
SETS = {
    'Knight': ('items_elite_knight', [
        ('eternal warhelm', 39148, 'helmet', 'melee', dict(armor=13)),
        ('eternal warplate', 39147, 'armor', 'melee', dict(armor=22, absorbpercentphysical=10)),
        ('eternal warlegs', 43876, 'legs', 'melee', dict(armor=12, absorbpercentphysical=5)),
        ('eternal warboots', 34097, 'boots', 'melee', dict(armor=4, speed=20)),
        ('eternal blade', 43864, 'weapon', 'sword', dict(attack=48, elementfire=40, defense=34, extradef=4)),
        ('eternal axe', 43868, 'weapon', 'axe', dict(attack=48, elementenergy=40, defense=34, extradef=4)),
        ('eternal hammer', 43866, 'weapon', 'club', dict(attack=48, elementdeath=40, defense=34, extradef=4)),
        ('eternal bulwark', 34099, 'offhand', 'shield', dict(defense=45, absorbpercentphysical=6)),
    ]),
    'Paladin': ('items_royal_paladin', [
        ('eternal hunter helmet', 39149, 'helmet', 'dist', dict(armor=12)),
        ('eternal hunter armor', 34094, 'armor', 'dist', dict(armor=18, absorbpercentphysical=6)),
        ('eternal hunter legs', 43881, 'legs', 'dist', dict(armor=11, absorbpercentphysical=4)),
        ('eternal hunter boots', 34098, 'boots', 'dist', dict(armor=4, speed=20)),
        ('eternal bow', 43877, 'weapon', 'dist', dict(attack=15, hitchance=7, range=7)),
        ('eternal crossbow', 43879, 'weapon', 'dist', dict(attack=15, hitchance=8, range=7)),
        ('eternal quiver', 39150, 'offhand', 'dist', dict(absorbpercentphysical=8, magiclevelpoints=10, perfectshotdamage=40, perfectshotrange=5)),
    ]),
    'Sorcerer': ('items_master_sorcerer', [
        ('eternal arcane hat', 39151, 'helmet', 'magic', dict(armor=10)),
        ('eternal arcane robe', 34095, 'armor', 'magic', dict(armor=17, absorbpercentphysical=5)),
        ('eternal arcane legs', 34092, 'legs', 'magic', dict(armor=10, absorbpercentphysical=3)),
        ('eternal arcane boots', 43884, 'boots', 'magic', dict(armor=3, speed=20)),
        ('eternal arcane wand', 43882, 'weapon', 'magic', dict(_damage=(200, 235), _mana=30)),
        ('eternal arcane tome', 39152, 'offhand', 'magic', dict(defense=24, absorbpercentphysical=3, skillshield=40, magiclevelpoints=10)),
    ]),
    'Druid': ('items_elder_druid', [
        ('eternal nature crown', 39153, 'helmet', 'magic', dict(armor=10)),
        ('eternal nature robe', 34096, 'armor', 'magic', dict(armor=17, absorbpercentphysical=5)),
        ('eternal nature legs', 34093, 'legs', 'magic', dict(armor=10, absorbpercentphysical=3)),
        ('eternal nature boots', 43887, 'boots', 'magic', dict(armor=3, speed=20)),
        ('eternal nature rod', 43885, 'weapon', 'magic', dict(_damage=(200, 235), _mana=30)),
        ('eternal nature tome', 39154, 'offhand', 'magic', dict(defense=24, absorbpercentphysical=3, skillshield=40, magiclevelpoints=10)),
    ]),
    'Monk': ('items_exalted_monk', [
        ('eternal monk hood', 50188, 'helmet', 'fist', dict(armor=8, mantra=12)),
        ('eternal monk garb', 50254, 'armor', 'fist', dict(armor=14, absorbpercentphysical=6, mantra=20)),
        ('eternal monk trousers', 50146, 'legs', 'fist', dict(armor=10, absorbpercentphysical=4, mantra=10)),
        ('eternal monk sandals', 50240, 'boots', 'fist', dict(armor=3, speed=20)),
        ('eternal claws', 50157, 'weapon', 'fist', dict(attack=58, defense=25, skillfist=8)),
    ]),
}

DROP = re.compile(r'^(attack|defense|extradef|armor|skill\w+|\w*magiclevelpoints|\w*leech\w*|critical\w+|absorbpercent\w+|reflect\w+|augments|imbuementslot|element(fire|ice|energy|earth|death|holy)|speed|mantra|hitchance|perfectshot\w+|description)$', re.I)


def imbu_types(kind, skill):
    t = ['life leech', 'mana leech', 'critical hit']
    if kind == 'weapon':
        if skill != 'magic':
            t.append('elemental damage')
        t.append(BOOST[skill])
    else:
        t += PROT
        if kind == 'helmet':
            t += [BOOST[s] for s in (['sword', 'axe', 'club', 'shield'] if skill == 'melee' else [skill])]
        if kind == 'offhand' and skill in ('shield', 'magic'):
            t.append(BOOST['shield'])
        if kind == 'boots':
            t += ['increase speed', 'paralysis deflection']
    return t


def build():
    a_in, a_out, x_in, x_out, store_dir = sys.argv[1:6]
    tree = ET.parse(x_in)
    root = tree.getroot()
    src_xml = {int(it.get('id')): it for it in root if it.get('id')}
    names = {(it.get('name') or '').lower() for it in root if not (it.get('id') and int(it.get('id')) >= FIRST_ID)}
    items = []
    nid = FIRST_ID
    for voc, (module, pieces) in SETS.items():
        for name, src, kind, skill, extra in pieces:
            assert name not in names, name
            items.append(dict(id=nid, name=name, src=src, kind=kind, skill=skill, extra=extra, voc=voc, module=module))
            nid += 1

    # ---- items.xml
    new_nodes = []
    for o in items:
        base = src_xml[o['src']]
        node = ET.Element('item', {'id': str(o['id']), 'article': 'an', 'name': o['name']})
        ex = {k.lower() for k in o['extra']} | {k.lower() for k in o['extra'].get('_attrs', {})}
        keep = [copy.deepcopy(c) for c in base if c.get('key') and not DROP.match(c.get('key')) and c.get('key').lower() not in ex]
        script = [c for c in keep if c.get('key') == 'script']
        keep = [c for c in keep if c.get('key') != 'script']
        for c in keep:
            node.append(c)
        for k, v in o['extra'].get('_attrs', {}).items():
            ET.SubElement(node, 'attribute', {'key': k, 'value': str(v)})
        lifel, manal, cc, cd, price = PIECE[o['kind']]
        stats = []
        for k, v in o['extra'].items():
            if not k.startswith('_'):
                stats.append((k, v))
        for sk in SKILL_KEYS[o['skill']]:
            if sk not in o['extra']:
                stats.append((sk, SKILL_BONUS[o['kind']]))
        if o['kind'] == 'offhand' and o['skill'] == 'shield':
            pass
        stats += [('lifeleechamount', lifel), ('manaleechamount', manal), ('criticalhitchance', cc), ('criticalhitdamage', cd)]
        o['stats'] = stats
        o['price'] = PRICE
        for k, v in stats:
            ET.SubElement(node, 'attribute', {'key': k, 'value': str(v)})
        imb = ET.SubElement(node, 'attribute', {'key': 'imbuementslot', 'value': str(SLOTS)})
        for t in imbu_types(o['kind'], o['skill']):
            ET.SubElement(imb, 'attribute', {'key': t, 'value': '3'})
        o['imbu'] = imbu_types(o['kind'], o['skill'])
        for sc in script:
            for d in sc:
                k = d.get('key')
                if k == 'level':
                    d.set('value', str(LEVEL))
                elif k == 'fromDamage' and '_damage' in o['extra']:
                    d.set('value', str(o['extra']['_damage'][0]))
                elif k == 'toDamage' and '_damage' in o['extra']:
                    d.set('value', str(o['extra']['_damage'][1]))
                elif k == 'mana' and '_mana' in o['extra']:
                    d.set('value', str(o['extra']['_mana']))
            sc[:] = [d for d in sc if d.get('key') != 'augments']
            node.append(sc)
        new_nodes.append(node)

    text = open(x_in, encoding='utf-8').read()
    text = re.sub(r'\n\t<!-- OTS eternal sets -->.*?<!-- /OTS eternal sets -->', '', text, flags=re.S)
    block = ['\t<!-- OTS eternal sets -->']
    for node in new_nodes:
        ET.indent(node, space='\t', level=1)
        block.append('\t' + ET.tostring(node, encoding='unicode').rstrip())
    block.append('\t<!-- /OTS eternal sets -->')
    i = text.rindex('</items>')
    text = text[:i].rstrip('\n') + '\n' + '\n'.join(block) + '\n' + text[i:]
    open(x_out, 'w', encoding='utf-8').write(text)

    # ---- appearances.dat
    src = open(a_in, 'rb').read()
    top = fields(src)
    objs = {}
    last_obj = -1
    for n, (f, wt, raw, val) in enumerate(top):
        if f == 1:
            sub = fields(val)
            i = [v for (ff, w, r, v) in sub if ff == 1 and w == 0][0]
            objs[i] = sub
            if i < FIRST_ID:
                last_obj = n
    new_ids = {o['id'] for o in items}
    out = bytearray()
    for n, (f, wt, raw, val) in enumerate(top):
        if f == 1:
            i = [v for (ff, w, r, v) in fields(val) if ff == 1 and w == 0][0]
            if i in new_ids:
                continue          # stara kopia z poprzedniego uruchomienia
        out += raw
        if n == last_obj:
            for o in items:
                out += b'\x0a' + lenp(clone(objs[o['src']], o))
    open(a_out, 'wb').write(out)
    json.dump([{k: v for k, v in o.items() if k != 'extra'} for o in items], open('eq_items.json', 'w'), indent=1)

    # ---- sklep
    for voc, (module, pieces) in SETS.items():
        write_store(store_dir, voc, module, [o for o in items if o['voc'] == voc])
    print('items', len(items), 'ids', FIRST_ID, nid - 1, 'appearances', len(src), '->', len(out))


def lenp(b):
    return ev(len(b)) + bytes(b)


def clone(sub, o):
    out = bytearray()
    for ff, w, r, v in sub:
        if ff == 1 and w == 0:
            out += b'\x08' + ev(o['id'])
        elif ff == 3 and w == 2:
            fl = bytearray()
            for f2, w2, r2, v2 in fields(v):
                if f2 in (40, 44, 60, 63):
                    continue      # dane NPC i cyklopedii oryginalu, sloty imbu i poziom (dopisane nizej)
                if f2 == 36:
                    m = bytearray()
                    for f3, w3, r3, v3 in fields(v2):
                        if f3 in (2, 3):
                            m += bytes([f3 << 3]) + ev(o['id'])
                        elif f3 == 6:
                            m += b'\x30' + ev(LEVEL)
                        else:
                            m += r3
                    fl += ev(36 << 3 | 2) + lenp(m)
                else:
                    fl += r2
            fl += ev(60 << 3 | 2) + lenp(b'\x08' + ev(SLOTS))   # klient: liczba slotow imbuementu
            fl += ev(63 << 3) + ev(LEVEL)                         # klient: wymagany poziom
            out += b'\x1a' + lenp(fl)
        elif ff in (4, 5):
            continue
        else:
            out += r
    out += b'\x22' + lenp(o['name'].encode())
    return out


def write_store(store_dir, voc, module, items):
    path = '%s/%s.lua' % (store_dir, module)
    text = open(path, encoding='utf-8').read()
    m = re.search(r'\tname = "([^"]+)"', text)
    cat = m.group(1)
    L = ['-- OTS: sklep > Przedmioty > %s (wlasne przedmioty serwera, set Eternal)' % cat,
         '-- Plik generowany przez tools/ots/eternal_sets.py razem z items.xml i appearances.dat.',
         'return {',
         '\ticons = { "ots_cat_%s.png" },' % module,
         '\tname = "%s",' % cat,
         '\tparent = "Przedmioty",',
         '\trookgaard = true,',
         '\tstate = GameStore.States.STATE_NONE,',
         '\toffers = {']
    for o in items:
        desc = []
        for k, v in o['stats']:
            if k in SKILL_LABEL:
                desc.append('%s +%d' % (SKILL_LABEL[k], v))
            elif k == 'lifeleechamount':
                desc.append('life leech %s%%' % pct(v))
            elif k == 'manaleechamount':
                desc.append('mana leech %s%%' % pct(v))
            elif k == 'criticalhitchance':
                desc.append('critical hit chance %s%%' % pct(v))
            elif k == 'criticalhitdamage':
                desc.append('critical extra damage %s%%' % pct(v))
            elif k.startswith('element'):
                desc.append('%s damage %d' % (k[7:], v))
            elif k.startswith('absorbpercent'):
                desc.append('%s protection %d%%' % (k[13:], v))
            elif k == 'perfectshotdamage':
                desc.append('perfect shot +%d' % v)
            elif k == 'perfectshotrange':
                desc.append('perfect shot range %d' % v)
            elif k == 'range':
                desc.append('range %d' % v)
            else:
                desc.append('%s %d' % (k, v))
        if '_damage' in o['extra']:
            desc.insert(0, 'damage %d-%d' % o['extra']['_damage'])
        L += ['\t\t{',
              '\t\t\ticons = { "%s.png" },' % o['name'].title().replace(' ', '_'),
              '\t\t\tname = "%s",' % o['name'].title(),
              '\t\t\tprice = %d,' % o['price'],
              '\t\t\titemtype = %d,' % o['id'],
              '\t\t\tcount = 1,',
              '\t\t\tmovable = true,',
              '\t\t\tdescription = "<i>%s</i>\\n\\n{character}\\n{storeinbox}\\n{info} level %d, %s\\n{info} %d imbuement slots",' % (', '.join(desc), LEVEL, voc.lower(), SLOTS),
              '\t\t\ttype = GameStore.OfferTypes.OFFER_TYPE_ITEM,',
              '\t\t},']
    L += ['\t},', '}', '']
    open(path, 'w', encoding='utf-8').write('\n'.join(L))


def pct(v):
    s = '%.2f' % (v / 100)
    return s.rstrip('0').rstrip('.')


if __name__ == '__main__':
    build()
