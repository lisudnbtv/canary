# OTS: grupy hubu expowisk: Bestiariusz (wszystkie potwory z bestiariusza, wg klasy) i trzy
# wybrane listy Exp Low / Medium / High z kilkoma miejscami dla tych samych potworow.
import json, collections, re
exec(open('spots.py').read().split("if __name__=='__main__':")[0])
import xml.etree.ElementTree as ET
spawns=collections.defaultdict(list)
for sp in ET.parse(R+'/world/otservbr-monster.xml').getroot():
    cx,cy,cz=int(sp.get('centerx')),int(sp.get('centery')),int(sp.get('centerz'))
    for m in sp: spawns[m.get('name').lower()].append((cx+int(m.get('x')),cy+int(m.get('y')),cz))
H={h['name'].lower():h for h in json.load(open('data2.json'))['hunts']}
C=40
def clusters(name,k):
    pts=spawns[name.lower()]
    cells=collections.Counter((x//C,y//C,z) for x,y,z in pts)
    used=set();res=[]
    for _ in range(k):
        best=None
        for (ax,ay,az),_c in cells.items():
            if (ax,ay,az) in used: continue
            n=sum(cells.get((ax+dx,ay+dy,az),0) for dx in(-1,0,1) for dy in(-1,0,1) if (ax+dx,ay+dy,az) not in used)
            if not best or n>best[0]: best=(n,ax,ay,az)
        if not best or best[0]<8: break
        n,gx,gy,z=best
        cl=[p for p in pts if p[2]==z and abs(p[0]//C-gx)<=1 and abs(p[1]//C-gy)<=1 and (p[0]//C,p[1]//C,z) not in used]
        for dx in(-2,-1,0,1,2):
            for dy in(-2,-1,0,1,2): used.add((gx+dx,gy+dy,z))
        cand=set()
        for (x,y,_z) in cl:
            for dx in range(-3,4):
                for dy in range(-3,4): cand.add((x+dx,y+dy))
        bs=None
        for (x,y) in cand:
            s=score(x,y,z)
            if not s: continue
            dmin=min(max(abs(x-a),abs(y-b)) for a,b,_ in cl)
            val=s[0]+6*s[1]-(40 if dmin<2 else 0)
            if not bs or val>bs[0]: bs=(val,x,y)
        if bs: res.append(dict(n=n,pos=[bs[1],bs[2],z]))
    return res
def mon(name):
    m=re.search(r'monster\.experience\s*=\s*(\d+)', '')
    return H.get(name.lower())
PLAN={
 'Exp Low':[('Rotworm',3),('Cyclops',3),('Dragon',3),('Dragon Lord',2)],
 'Exp Medium':[('Wyrm',3),('Midnight Asura',2),('Dawnfire Asura',2),('Frost Flower Asura',2),('Dark Torturer',3),('Grim Reaper',3),('Frazzlemaw',2),('Guzzlemaw',2)],
 'Exp High':[('Demon',3),('Cobra Assassin',2),('Cobra Vizier',2),('Cobra Scout',2),('Falcon Knight',2),('Falcon Paladin',2),('Grimeleech',2),('Vexclaw',2),('Juggernaut',2),('Undead Dragon',2),('Crypt Warden',2),('Hellhunter Inferniarch',2),('Spellreaper Inferniarch',2),('Sphinx',2),
   ('Sulphur Spouter',2),('Mantosaurus',2),('Gore Horn',2),('Noxious Ripptor',2),('Hulking Prehemoth',2),
   ('Turbulent Elemental',2),('Capricious Phantom',2),('Bony Sea Devil',2),('Brachiodemon',2),('Infernal Demon',2),
   ('Mycobiontic Beetle',2),('Walking Pillar',2),('Meandering Mushroom',2),('Bloated Man-Maggot',2),('Darklight Striker',2)],
}
out=[]
B=json.load(open('bestiary.json'))
best=[]
for b in sorted(B,key=lambda b:(b['cls'],H[b['name'].lower()]['exp'] if b['name'].lower() in H else 0,b['name'])):
    h=H.get(b['name'].lower())
    if h: best.append(dict(name=h['name'],exp=h['exp'],n=h['n'],pos=h['pos'],cls=b['cls']))
out.append(dict(label='Bestiariusz',range='wg klas bestiariusza',entries=best))
for label,plan in PLAN.items():
    ents=[]
    for name,k in plan:
        h=H.get(name.lower())
        if not h: print('BRAK',name); continue
        cs=clusters(name,k)
        if not cs: cs=[dict(n=h['n'],pos=h['pos'])]
        for i,c in enumerate(cs):
            ents.append(dict(name=h['name'],exp=h['exp'],n=c['n'],pos=c['pos'],spot=i+1,spots=len(cs)))
    out.append(dict(label=label,range='%d expowisk'%len(ents),entries=ents))
json.dump(out,open("hubgroups_raw.json","w"))
for g in out:
    print(g['label'],len(g['entries']))
    if g['label']!='Bestiariusz':
        for e in g['entries']: print('  ',e['name'],e['spot'],'/',e['spots'],e['n'],e['pos'])
