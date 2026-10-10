"""Lista wszystkich bossow: 59 z dzwignia (teleport pod dzwignie) + bossy z bestiariusza bossow bez dzwigni (arena)."""
import json,re,os
R='/home/claude/canary/data-otservbr-global/monster'
d=json.load(open('data2.json')); looks=json.load(open('boss_looks.json'))
assert [b['name'] for b in d['bosses']]==[b['name'] for b in looks]
out=[dict(name=b['name'],lvl=b['lvl'],pos=b['pos'],outfit=l['outfit']) for b,l in zip(d['bosses'],looks)]
have={b['name'].lower() for b in out}
extra=[]
for dp,_,fs in os.walk(R):
    if any(s in dp for s in ('dawnport','familiars','trainers','traps','event_creatures')): continue
    for f in fs:
        s=open(os.path.join(dp,f),encoding='utf-8',errors='ignore').read()
        if 'monster.bosstiary' not in s: continue
        nm=re.search(r'Game\.createMonsterType\("([^"]+)"\)',s)
        if not nm or nm.group(1).lower() in have: continue
        ob=re.search(r'monster\.outfit\s*=\s*\{(.*?)\}',s,re.S)
        of={k:int(v) for k,v in re.findall(r'(look\w+)\s*=\s*(\d+)',ob.group(1))} if ob else {}
        if not of.get('lookType') and not of.get('lookTypeEx'): continue
        if not of.get('lookType'): of={'lookTypeEx':of['lookTypeEx']}
        else: of.pop('lookTypeEx',None)
        _h=re.search(r'monster\.(?:maxHealth|health)\s*=\s*(\d+)',s); hp=int(_h.group(1)) if _h else 0
        have.add(nm.group(1).lower())
        extra.append(dict(name=nm.group(1),lvl=0,pos=None,hp=hp,outfit=of))
extra.sort(key=lambda b:(b['hp'],b['name']))
out+=extra
json.dump(out,open('bosses_all.json','w'))
print(len(out),len(extra),extra[0],extra[-1])
