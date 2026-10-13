# dodatkowe miejsca tylko z min. 12 potworami; miejsca blizej niz 8 kratek od juz wybranego pomijane
import json
g=json.load(open('hubgroups_raw.json'))
for grp in g[1:]:
    keep=[]
    for e in grp['entries']:
        if e['spot']>1 and e['n']<12: continue
        if any(k['pos'][2]==e['pos'][2] and abs(k['pos'][0]-e['pos'][0])<=8 and abs(k['pos'][1]-e['pos'][1])<=8 for k in keep): continue
        keep.append(e)
    cnt={};seen={}
    for e in keep: cnt[e['name']]=cnt.get(e['name'],0)+1
    for e in keep:
        seen[e['name']]=seen.get(e['name'],0)+1; e['spot']=seen[e['name']]; e['spots']=cnt[e['name']]
    grp['entries']=keep; grp['range']='%d expowisk'%len(keep)
json.dump(g,open('hubgroups.json','w'))
print([ (x['label'],len(x['entries'])) for x in g])
