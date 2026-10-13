import sys,json,os
sys.path.insert(0,'.')
from dec import sheet
from PIL import Image
spr=json.load(open('sprites.json'))
need=json.load(open('need.json'))
MAP={'items':3366,'items_royal_paladin':5803,'items_elite_knight':3288,'items_master_sorcerer':3071,'items_elder_druid':3065,'items_exalted_monk':5919,'items_misc':3253,'items_upgrade':20139,'items_forge':37110,'premium_time':3043,'consumables':7643,'consumables_blessings':3077,'consumables_casks':25881,'consumables_exercise_weapons':35280,'consumables_kegs':25905,'consumables_potions':239,'consumables_runes':3155,'cosmetics':3385,'cosmetics_mounts':3595,'cosmetics_outfits':3567,'house':27664,'house_decorations':27679,'house_furniture':27664,'beds':39788,'house_upgrades':25721,'house_hirelings':29432,'house_hireling_dresses':3566,'boost':3030,'extras':23722,'extras_extras_services':3505,'extras_usefull_things':23722,'tournament':5805,'tournament_tickets':347,'tournament_exclusive_offers':32909}
sheets={}
os.makedirs('out',exist_ok=True)
for mod,iid in MAP.items():
    sid=spr[str(iid)]
    for fn,lst in need.items():
        for s,t,first in lst:
            if s==sid: f=(fn,t,first)
    fn,t,first=f
    if fn not in sheets: sheets[fn]=sheet(fn)
    im=sheets[fn]
    size=32 if t==0 else 64
    cols=384//size
    k=sid-first
    box=((k%cols)*size,(k//cols)*size)
    tile=im.crop((box[0],box[1],box[0]+size,box[1]+size))
    px=tile.load()
    for y in range(size):
        for x in range(size):
            r,g,b,a=px[x,y]
            if (r,g,b)==(255,0,255): px[x,y]=(0,0,0,0)
    if size!=32: tile=tile.resize((32,32),Image.LANCZOS)
    tile.save('out/ots_cat_%s.png'%mod)
print(len(os.listdir('out')))
