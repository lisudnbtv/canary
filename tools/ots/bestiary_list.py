import re,os,json,collections
root='/home/claude/canary/data-otservbr-global/monster'
out=[]
for d,_,fs in os.walk(root):
    for f in fs:
        if not f.endswith('.lua'): continue
        s=open(os.path.join(d,f),encoding='latin-1').read()
        n=re.search(r'Game\.createMonsterType\("([^"]+)"\)',s)
        r=re.search(r'monster\.raceId\s*=\s*(\d+)',s)
        b=re.search(r'monster\.Bestiary\s*=\s*\{(.*?)\n\}',s,re.S)
        if not (n and r and b) or int(r.group(1))==0: continue
        c=re.search(r'class\s*=\s*"([^"]+)"',b.group(1)); k=re.search(r'toKill\s*=\s*(\d+)',b.group(1))
        if not c or not k: continue
        out.append(dict(name=n.group(1),race=int(r.group(1)),cls=c.group(1),kill=int(k.group(1))))
seen={}
for m in out: seen.setdefault(m['race'],m)
out=sorted(seen.values(),key=lambda m:(m['cls'],m['name']))
json.dump(out,open('bestiary.json','w'))
print(len(out),collections.Counter(m['cls'] for m in out).most_common())
