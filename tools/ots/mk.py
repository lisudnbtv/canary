import json,bisect
d=json.load(open('data2.json'))
tiers=[(300,'Low (exp do 300)'),(1500,'Medium (exp 300-1500)'),(6000,'Hard (exp 1500-6000)'),(10**9,'Very Hard (exp 6000+)')]
lim=[t[0] for t in tiers]
groups=[[] for _ in tiers]
for h in d['hunts']:
    groups[bisect.bisect_left(lim,h['exp'])].append(h)
def q(s): return '"'+s.replace('\\','\\\\').replace('"','\\"')+'"'
o=[]
o.append('''-- OTS: menu teleportow (expowiska, bossy, questy, miasta).
-- Plik generowany z danych serwera (spawny potworow i dzwignie bossow).
-- Wejscie: teleport przy swiatyni w Thais albo komenda !tp.

local ENTRY_ACTION_ID = 64990
local ENTRY_ITEM_ID = 1949 -- magic forcefield
local ENTRY_TOWN = "thais"
local RETURN_ACTION_ID = 64991 -- teleport powrotny do swiatyni

local hunts = {''')
for (l,label),g in zip(tiers,groups):
    o.append('\t{ label = %s, list = {'%q(label))
    for h in g:
        o.append('\t\t{ %s, %d, %d, %d, mon = %s },'%(q('%s (%d exp, %dx)'%(h['name'],h['exp'],h['n'])),*h['pos'],q(h['name'])))
    o.append('\t} },')
o.append('}\n\nlocal bosses = {')
for b in json.load(open('bosses_all.json')):
    nm=' '.join(w if w in('of','the','and') and i else w[:1].upper()+w[1:] for i,w in enumerate(b['name'].split(' ')))
    if b['pos']:
        lab=nm+(' (lvl %d+)'%b['lvl'] if b['lvl'] else '')
        o.append('\t{ %s, %d, %d, %d },'%(q(lab),*b['pos']))
    else:
        o.append('\t{ %s, 0, 0, 0, arena = { { %s, 1 } } },'%(q('%s (arena, HP %d)'%(nm,b['hp'])),q(b['name'])))
_CH=[c for c in json.load(open('chests.json')) if c['pos']]
def _done(p,r):
    n=[c for c in _CH if c['pos'][2]==p[2] and abs(c['pos'][0]-p[0])<=r and abs(c['pos'][1]-p[1])<=r]
    kv=sorted({c['kv'] for c in n if c['kv']})
    st=sorted({c['storage'] for c in n if c['storage'] and not c['kv']}) if not kv else []
    if not kv and not st: return ''
    parts=[]
    if kv: parts.append('kv = { %s }'%', '.join(q(k) for k in kv))
    if st: parts.append('st = { %s }'%', '.join('{ %s }'%q(s) for s in st))
    return 'done = { %s }, '%', '.join(parts)
SHORTCUT_QUESTS={'Deeper Fibula'}  # questy z teleportem prosto pod skrzynie
o.append('}\n\nlocal quests = {')
import gear
NICE={'Behemothquest':'Behemoth Quest','Noblearmor':'Noble Armor','Devilhemet':'Devil Helmet','Deeperfibula':'Deeper Fibula','Orcfortress':'Orc Fortress','Vampireshield':'Vampire Shield','Blackknight':'Black Knight','Circleroom':'Circle Room','Crusaderhelmet':'Crusader Helmet'}
Q=[]
for x in json.load(open('quests.json')):
    gs=[r for r in x['rewards'] if gear.good(r)]
    if x['kind']=='fight' and gs:
        x['name']=NICE.get(x['name'],x['name']);x['rewards']=gs;Q.append(x)
Q.sort(key=lambda x:x['name'].lower())
import xml.etree.ElementTree as _ET
ITEMID={}
for _it in _ET.parse('/home/claude/canary/data/items/items.xml').getroot():
    if _it.get('id'): ITEMID.setdefault(_it.get('name'),int(_it.get('id')))
QM=[dict(name='Pits of Inferno',items=[6529,6527,3341,5803]),
    dict(name='Barbarian Arena',items=[7434,7390,7429,7384,7389,7415]),
    dict(name='In Service of Yalahar',items=[8862,8864,8863,50289]),
    dict(name='Soul War',items=[34082,34088,34090,34091,34094,34099])]
o.append('\t{ "Pits of Inferno: soft boots, avenger, arcane staff, arbalest", func = "OtsPoiStart" },')
o.append('\t{ "Barbarian Arena: bron do wyboru (3 poziomy, 10 walk)", func = "OtsArenaStart" },')
o.append('\t{ "In Service of Yalahar: yalahari armor / mask / leg piece / footwraps", func = "OtsYalaharStart" },')
o.append('\t{ "Soul War: komplet przedmiotow Soul War dla Twojej profesji", func = "OtsSoulWarStart" },')
MAN=json.load(open('manual.json'))
for x in MAN:
    QM.append(dict(name=x['label'].split(':')[0],items=[ITEMID[n.strip()] for n in x['label'].split(':')[1].split(',') if n.strip() in ITEMID]))
    o.append('\t{ %s, %d, %d, %d, %s%shint = %s },'%(q(x['label']),*x['pos'],'plain = true, ' if x.get('plain') else '',_done(x['pos'],20),q(x['hint'])))
# Questy bez wlasnej walki: najpierw walka na arenie, potem teleport pod skrzynie.
import spots as _sp
def _near(c):
    best=None
    for dx in range(-2,3):
        for dy in range(-2,3):
            if (dx or dy) and _sp.walk(c[0]+dx,c[1]+dy,c[2]):
                k=(max(abs(dx),abs(dy)),abs(dx)+abs(dy))
                if best is None or k<best[0]: best=(k,[c[0]+dx,c[1]+dy,c[2]])
    assert best,c
    return best[1]
AQ=[('Wrath of the Emperor',['royal scale robe','royal draken mail','elite draken helmet'],[33073,31169,8],
     [('Draken Elite',4),('Draken Abomination',4),('Draken Warmaster',4),('Draken Spellweaver',4),('Draken Elite',2)],'Skrzynie stoja obok siebie; zbroje sa w kolejnych skrzyniach.'),
    ('The Thieves Guild',['modified crossbow','assassin dagger','spellbook of warding'],[32309,32209,8],
     [('Assassin',6),('Stalker',4),('Bandit',4),('Smuggler',4),('Assassin',4)],'Trzy skrzynie, mozna wziac jedna nagrode.'),
    ('The Hidden City of Beregar',['firewalker boots'],[32581,31404,15],
     [('Dwarf Guard',6),('Dwarf Geomancer',4),('Worker Golem',4),('War Golem',5)],''),
    ('Koshei the Deathless',['blue legs'],[33261,32444,12],
     [('Lich',4),('Bonebeast',5),('Vampire',5),('Mummy',5),('Koshei the Deathless',1)],'')]
_AQL=[]
for nm,rw,chest,mons,extra in AQ:
    land=_near(chest); _AQL.append(land)
    QM.append(dict(name=nm,items=[ITEMID[n] for n in rw if n in ITEMID]))
    hint=('Skrzynia z nagroda jest tuz obok. '+extra).strip()
    o.append('\t{ %s, 0, 0, 0, arena = { %s }, chest = { %d, %d, %d }, %shint = %s },'%(q('%s: %s'%(nm,', '.join(rw))),', '.join('{ %s, %d }'%(q(a),b) for a,b in mons),*land,_done(chest,3),q(hint)))
# Inkwizycja w wersji uproszczonej: szesc sal bossow pod rzad, potem sala z nagrodami
# (lancuch teleportow jest w podmienionym movements_teleport_main.lua)
INQ_WARDS=[[33158,31728,11],[33124,31692,11],[33197,31767,11],[33232,31733,11],[33197,31703,11],[33104,31734,11]]
QM.append(dict(name='The Inquisition',items=[8062,8090,8053,8060,8023,8096,8100,8102,8026]))
o.append('\t{ "The Inquisition: 6 bossow pod rzad, jedna z 9 nagrod do wyboru", %d, %d, %d, hint = "Zabij bossa i wejdz w teleport w jego sali - prowadzi do nastepnego. Kolejnosc: Ushuriel, Zugurosh, Madareth, Latrivan i Golgordan, Annihilon, Hellgorak. Po kazdym masz 10 minut na przejscie." },'%tuple(INQ_WARDS[0]))
# Demon Oak w wersji uproszczonej (skrypt scripts/ots/demon_oak.lua)
QM.append(dict(name='The Demon Oak',items=[3389,8077,14768,14769]))
o.append('\t{ "The Demon Oak: demon legs / rainbow shield / thorn spitter / spellbook of ancient arcana (jedna do wyboru)", func = "OtsDemonOakStart", done = { st = { { "Storage.Quest.U8_2.TheDemonOak.Done", 2 } } } },')
# Swiateczna arena: jedyne miejsce do farmienia christmas tokenow (leca z tych potworow), bez skrzyni, do powtarzania
QM.append(dict(name='Swiateczna arena',items=[6526]))
o.append('\t{ "Swiateczna arena: christmas tokeny z potworow", 0, 0, 0, arena = { { "Grynch Clan Goblin", 8 }, { "Animated Snowman", 6 }, { "Percht", 6 }, { "Schiach", 6 }, { "Baleful Bunny", 4 }, { "The Percht Queen", 1 } } },')
def direction(a,b):
    dx,dy=b[0]-a[0],b[1]-a[1]
    ns='polnoc' if dy<0 else 'poludnie'; ew='zachod' if dx<0 else 'wschod'
    if abs(dx)*2<abs(dy): return ns
    if abs(dy)*2<abs(dx): return ew
    return ns+'ny ' + ew if False else (('polnocny' if dy<0 else 'poludniowy')+' '+ew)
for x in Q:
    rw=', '.join(x['rewards'])
    if len(rw)>44: rw=rw[:41].rstrip(', ')+'...'
    lab='%s: %s'%(x['name'],rw)
    QM.append(dict(name=x['name'],items=[ITEMID[n] for n in x['rewards'] if n in ITEMID]))
    hint='Skrzynia z nagroda: ok. %d krokow, kierunek %s. Przy skrzyni jest strefa PZ.'%(x['dist'],direction(x['start'],x['chest']))
    if x['name'] in SHORTCUT_QUESTS:
        x['start']=x['chest']; hint='Skrot: teleport prosto pod skrzynie z nagroda (pole PZ).'
    _bx=(min(x['start'][0],x['chest'][0])-8,min(x['start'][1],x['chest'][1])-8,max(x['start'][0],x['chest'][0])+8,max(x['start'][1],x['chest'][1])+8,x['start'][2])
    o.append('\t{ %s, %d, %d, %d, %shint = %s, unlock = { %d, %d, %d, %d, %d } },'%(q(lab),*x['start'],_done(x['chest'],14),q(hint),*_bx))
o.append('}\n')
json.dump(QM,open('quests_menu.json','w'))
P=json.load(open('poi.json'))
_EXTRA=[b['pos'] for b in json.load(open('bosses_all.json')) if b['pos']]+_AQL+INQ_WARDS+[[33621,31427,10],[32783,31174,10]]  # dzwignie bossow, skrzynie questow z areny, wejscia Soul War i Yalahar
json.dump(dict(centers=_EXTRA+[h['pos'] for h in d['hunts']]+[x['start'] for x in Q]+P['centers']+[c for x in MAN for c in x['centers']],tiles=[t for x in Q for t in x['pz']]+P['tiles']+[t for x in MAN for t in x['tiles']]+json.load(open('yal_pz.json'))),open('/mnt/user-data/outputs/pz_targets.json','w'))
print('quests',len(Q))
HUB=json.load(open('hub.json'))
HL=['local HUB_ACTION_ID = 64992 -- pady w hubie expowisk','local hubLobby = Position(%d, %d, %d)'%tuple(HUB['lobby']),'local hubWings = {']
for w in HUB['wings']:
    HL.append('\t{ label = %s, x = %d, y = %d, z = %d },'%(q('%s (%d potworow)'%(w['label'],w['count'])),*w['arrival']))
HL.append('}')
HL.append('local hubQuestHall = Position(%d, %d, %d)'%tuple(HUB['questhall']))
HL.append('local hubBossHall = Position(%d, %d, %d)'%tuple(HUB['bosshall']))
HL.append('local arenaCenter = Position(%d, %d, %d)'%tuple(HUB['arena']['center']))
HL.append('local arenaLanding = Position(%d, %d, %d)'%tuple(HUB['arena']['landing']))
HL.append('local ARENA_RADIUS = %d'%HUB['arena']['radius'])
_R=HUB.get('raid',{}); _RB=[_b for _b in json.load(open('bosses_all.json')) if not _b['pos'] and _b['hp']>=15000 and not _b.get('events') and _b['outfit'].get('lookType') and _b.get('reward')]
_TIERS=[('Slabszy',15000,50000),('Mocny',50000,300000),('Legendarny',300000,10**12)]
HL.append('local raidNpcPosition = Position(%d, %d, %d)'%tuple(_R.get('npc',[0,0,0])))
HL.append('local raidRooms = {')
for (_lab,_lo,_hi),_room in zip(_TIERS,_R.get('rooms',[])):
    HL.append('\t{ label = %s, center = Position(%d, %d, %d), landing = Position(%d, %d, %d), bossId = nil, bossName = nil, nextAt = 0, bosses = {'%(q(_lab),*_room['center'],*_room['landing']))
    for _b in _RB:
        if _lo<=_b['hp']<_hi:
            HL.append('\t\t{ name = %s, outfit = { %s } },'%(q(_b['name']),', '.join('%s = %d'%kv for kv in _b['outfit'].items())))
    HL.append('\t} },')
HL.append('}')
_SV=HUB.get('survival',{})
HL.append('local survivalCenter = Position(%d, %d, %d)'%tuple(_SV.get('center',[0,0,0])))
HL.append('local survivalLanding = Position(%d, %d, %d)'%tuple(_SV.get('landing',[0,0,0])))
_RU=HUB.get('rush',{})
HL.append('local rushCenter = Position(%d, %d, %d)'%tuple(_RU.get('center',[0,0,0])))
HL.append('local rushLanding = Position(%d, %d, %d)'%tuple(_RU.get('landing',[0,0,0])))
HL.append('local rushBosses = { '+', '.join(q(_b['name']) for _b in sorted(_RB,key=lambda b:b['hp']))+' }')
_TW=HUB.get('tower',{})
HL.append('local towerCenter = Position(%d, %d, %d)'%tuple(_TW.get('center',[0,0,0])))
HL.append('local towerLanding = Position(%d, %d, %d)'%tuple(_TW.get('landing',[0,0,0])))
HL.append('local taskNpcPosition = Position(%d, %d, %d)'%tuple(HUB.get('taskNpc',[0,0,0])))
HL.append('local hubPads = {')
for k,a in sorted(HUB['pads'].items()):
    if a['kind']=='hunt': v='{ hunt = hunts[%d].list[%d] }'%(a['tier']+1,a['index']+1)
    elif a['kind']=='wing': v='{ wing = %d }'%(a['wing']+1)
    elif a['kind']=='quest': v='{ quest = quests[%d] }'%(a['index']+1)
    elif a['kind']=='goto': v='{ goto = { %d, %d, %d }, label = %s }'%(*a['pos'],q(a['label']))
    elif a['kind']=='boss': v='{ boss = bosses[%d] }'%(a['index']+1)
    else: v='{ %s = true }'%a['kind']
    HL.append('\t[%s] = %s,'%(q(k),v))
HL.append('}\n')
o.append('\n'.join(HL))
o.append(r'''
local templePosition = nil -- swiatynia w Thais, ustawiana przy starcie serwera
local safeTiles = {} -- pola bezpiecznych stref 3x3
local safeCenters = {} -- pole strefy -> jej srodek (do sprzatania potworow ze strefy)
local preparedSpots = {} -- cele, ktore maja juz strefe i teleport powrotny

local function key(pos)
	return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local function isSafe(creature)
	return creature and safeTiles[key(creature:getPosition())] == true
end

local function placeReturn(pos)
	local item = Game.createItem(ENTRY_ITEM_ID, 1, pos)
	if item then
		item:setActionId(RETURN_ACTION_ID)
		return true
	end
	return false
end

-- Strefa 3x3 (raz) i teleport powrotny obok miejsca ladowania.
-- Teleport: najpierw puste pole, a gdy takiego nie ma (wszedzie leza ozdoby,
-- trawa itp.), dowolne pole, po ktorym da sie chodzic. Ponawiane przy kazdym
-- teleporcie, dopoki sie nie uda.
local function prepareSpot(center)
	local id = key(center)
	local spot = preparedSpots[id]
	if not spot then
		spot = { teleport = false }
		preparedSpots[id] = spot
		for dx = -1, 1 do
			for dy = -1, 1 do
				safeTiles[key(Position(center.x + dx, center.y + dy, center.z))] = true
				safeCenters[key(Position(center.x + dx, center.y + dy, center.z))] = center
			end
		end
	end

	if spot.teleport or not templePosition then
		return
	end

	local fallback = nil
	for dx = -1, 1 do
		for dy = -1, 1 do
			if not (dx == 0 and dy == 0) then
				local pos = Position(center.x + dx, center.y + dy, center.z)
				local tile = Tile(pos)
				if tile then
					local existing = tile:getItemById(ENTRY_ITEM_ID)
					if existing and existing:getActionId() == RETURN_ACTION_ID then
						spot.teleport = true
						return
					end
					if tile:isWalkable(false, false, true, true, false) then
						if tile:getItemCount() == 0 then
							if placeReturn(pos) then
								spot.teleport = true
								return
							end
						elseif not fallback then
							fallback = pos
						end
					end
				end
			end
		end
	end

	if fallback and placeReturn(fallback) then
		spot.teleport = true
	end
end

-- Usuwa potwory stojace w strefie 3x3. Spawn z mapy potrafi postawic potwora na polu PZ
-- (strefa nie blokuje samego odrodzenia), a taki potwor stoi potem graczowi na glowie.
local function clearSpot(center)
	for dx = -1, 1 do
		for dy = -1, 1 do
			local tile = Tile(Position(center.x + dx, center.y + dy, center.z))
			local creatures = tile and tile:getCreatures() or {}
			for index = #creatures, 1, -1 do
				local creature = creatures[index]
				if creature:isMonster() and not creature:getMaster() then
					creature:remove()
				end
			end
		end
	end
end

-- Drzwi questowe ("sealed against unwanted intruders") otwieraja sie graczowi, ktory ma ustawiony
-- storage o numerze rownym action id drzwi. Przy teleporcie na quest ustawiamy go dla wszystkich
-- takich drzwi w okolicy trasy do skrzyni; drzwi bez action id dostaja wspolny numer.
local QUEST_DOOR_FALLBACK_AID = 64999
local questDoorIds = nil

local function unlockQuestDoors(player, box)
	if not questDoorIds then
		questDoorIds = {}
		for _, door in ipairs(QuestDoorTable or {}) do
			questDoorIds[door.closedDoor] = true
			questDoorIds[door.openDoor] = true
		end
	end
	local unlocked = 0
	for x = box[1], box[3] do
		for y = box[2], box[4] do
			local tile = Tile(Position(x, y, box[5]))
			local items = tile and tile:getItems() or {}
			for _, item in ipairs(items) do
				if questDoorIds[item:getId()] then
					local aid = item:getActionId()
					if aid <= 0 then
						aid = QUEST_DOOR_FALLBACK_AID
						item:setActionId(aid)
					end
					if player:getStorageValue(aid) == -1 then
						player:setStorageValue(aid, 1)
					end
					unlocked = unlocked + 1
				end
			end
		end
	end
	return unlocked
end

local function inFight(player)
	local here = Tile(player:getPosition())
	local protected = isSafe(player) or (here and here:hasFlag(TILESTATE_PROTECTIONZONE))
	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) and not protected and not player:getGroup():getAccess() then
		player:sendCancelMessage("Nie mozesz sie teleportowac w trakcie walki.")
		return true
	end
	return false
end

local function travel(player, entry)
	if inFight(player) then
		return
	end

	local destination = Position(entry[2], entry[3], entry[4])
	local tile = Tile(destination)
	if not tile or not tile:isWalkable(false, true, true, true, false) then
		local free = player:getClosestFreePosition(destination, 4)
		if not free or free.x == 0 then
			player:sendCancelMessage("To miejsce jest teraz niedostepne: " .. entry[1])
			return
		end
		destination = free
	end

	local from = player:getPosition()
	local bare = entry.town or entry.plain
	if not bare then
		prepareSpot(destination)
		clearSpot(destination)
	end
	if entry.unlock then
		unlockQuestDoors(player, entry.unlock)
	end
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	if bare then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1])
		if entry.hint then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, entry.hint)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport: " .. entry[1] .. ". Stoisz w bezpiecznej strefie 3x3, obok jest teleport powrotny do Thais.")
		if entry.hint then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, entry.hint)
		end
	end
end

-- Arena: wspolna sala walk. Bossy bez dzwigni pojawiaja sie tu na zadanie, a questy
-- bez wlasnej walki maja tu fale potworow; po wybiciu fali gracz trafia pod skrzynie.
-- Odroczone sprawdzenia trzymaja tylko identyfikatory i numer walki (token),
-- wiec po nowej walce albo zniknieciu gracza stare sprawdzenie nic nie robi.
local arenaState = { token = 0, ids = {} }

local function arenaClear()
	for _, id in ipairs(arenaState.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	arenaState.ids = {}
end

local function inArena(player)
	local pos = player:getPosition()
	return pos.z == arenaCenter.z and math.abs(pos.x - arenaCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - arenaCenter.y) <= ARENA_RADIUS + 1
end

local function arenaCheck(playerId, token, label, chest, hint)
	if token ~= arenaState.token then
		return
	end
	local player = Player(playerId)
	if not player or not inArena(player) then
		arenaClear()
		return
	end
	for _, id in ipairs(arenaState.ids) do
		if Creature(id) then
			addEvent(arenaCheck, 2000, playerId, token, label, chest, hint)
			return
		end
	end
	arenaState.ids = {}
	if chest then
		player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
		travel(player, { label .. " - nagroda", chest[1], chest[2], chest[3], hint = hint })
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Pokonano: " .. label .. ". Loot jest w zwlokach albo w skrzyni nagrod w swiatyni. Teleport powrotny stoi przy wejsciu na arene.")
	end
end

local function arenaStart(player, entry)
	if inFight(player) then
		return
	end
	arenaClear()
	arenaState.token = arenaState.token + 1
	local token = arenaState.token
	travel(player, { entry[1], arenaLanding.x, arenaLanding.y, arenaLanding.z })
	if not inArena(player) then
		return
	end
	local missing = 0
	for _, wave in ipairs(entry.arena) do
		for _ = 1, wave[2] do
			local pos = Position(arenaCenter.x + math.random(-ARENA_RADIUS + 1, ARENA_RADIUS - 1), arenaCenter.y + math.random(-ARENA_RADIUS + 1, 2), arenaCenter.z)
			local monster = Game.createMonster(wave[1], pos, true, true)
			if monster then
				arenaState.ids[#arenaState.ids + 1] = monster:getId()
			else
				missing = missing + 1
			end
		end
	end
	if #arenaState.ids == 0 then
		player:sendCancelMessage("Nie udalo sie przywolac przeciwnika: " .. entry[1])
		return
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Arena: przeciwnikow " .. #arenaState.ids .. (missing > 0 and (" (nie pojawilo sie: " .. missing .. ")") or "") .. ". " .. (entry.chest and "Po wybiciu wszystkich trafisz pod skrzynie z nagroda." or "Walka zaczyna sie, gdy wyjdziesz ze strefy."))
	addEvent(arenaCheck, 2000, player:getId(), token, entry[1], entry.chest, entry.hint)
end

-- Losowy Boss: trzy salki wedlug sily (slabszy / mocny / legendarny). W kazdej stoi jeden wylosowany
-- boss; po zabiciu nastepny pojawia sie po 10 minutach. Postac przy padzie w lobby zmienia wyglad
-- miedzy bossami ze wszystkich pul. Stan trzyma tylko identyfikatory, kazdy tik sprawdza je od nowa.
local RAID_RESPAWN_SECONDS = 10 * 60
local RAID_NPC_NAME = "Losowy Boss"
local raidNpc = { id = nil, looks = {}, look = 0 }
for _, room in ipairs(raidRooms) do
	for _, boss in ipairs(room.bosses) do
		raidNpc.looks[#raidNpc.looks + 1] = boss.outfit
	end
end

local function raidSpawn(room)
	if #room.bosses == 0 then
		return
	end
	local pick = room.bosses[math.random(#room.bosses)]
	local monster = Game.createMonster(pick.name, room.center, true, true)
	if monster then
		room.bossId = monster:getId()
		room.bossName = pick.name
		Game.broadcastMessage("Losowy Boss (" .. room.label .. "): " .. pick.name .. " czeka w salce.", MESSAGE_EVENT_ADVANCE)
	else
		room.nextAt = os.time() + 30
	end
end

local function raidStatus(room)
	if room.bossId and Creature(room.bossId) then
		return room.label .. ": czeka " .. room.bossName
	end
	local left = math.max(0, room.nextAt - os.time())
	return string.format("%s: nastepny za %d min %d s", room.label, math.floor(left / 60), left % 60)
end

local function raidEnter(player)
	if inFight(player) then
		return
	end
	local window = ModalWindow({ title = "Losowy Boss", message = "Wybierz salke. Po zabiciu bossa nastepny pojawia sie po 10 minutach." })
	for _, room in ipairs(raidRooms) do
		window:addChoice(raidStatus(room), function(target)
			travel(target, { RAID_NPC_NAME .. " - " .. room.label, room.landing.x, room.landing.y, room.landing.z })
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end) -- przycisk bez funkcji uruchomilby zaznaczona pozycje
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local raidNpcType = Game.createNpcType(RAID_NPC_NAME)
raidNpcType:register({
	name = RAID_NPC_NAME,
	description = RAID_NPC_NAME,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = raidNpc.looks[1] or { lookType = 35 },
	flags = { floorchange = false },
})

local raidTick = GlobalEvent("OtsRandomBossTick")

function raidTick.onThink(interval)
	-- bossy: wykrycie smierci i odliczanie do nastepnego, osobno w kazdej salce
	for _, room in ipairs(raidRooms) do
		if room.bossId then
			if not Creature(room.bossId) then
				Game.broadcastMessage("Losowy Boss pokonany: " .. (room.bossName or "?") .. " (" .. room.label .. "). Nastepny za 10 minut.", MESSAGE_EVENT_ADVANCE)
				room.bossId = nil
				room.nextAt = os.time() + RAID_RESPAWN_SECONDS
			end
		elseif os.time() >= room.nextAt then
			raidSpawn(room)
		end
	end

	-- strefy 3x3: jesli gracz stoi w ktorejs, sprzatamy z niej potwory, ktore odrodzily sie w srodku
	for _, online in ipairs(Game.getPlayers()) do
		local center = safeCenters[key(online:getPosition())]
		if center then
			clearSpot(center)
		end
	end

	-- postac w lobby: tworzona przy pierwszym tiku, potem zmienia wyglad
	local npc = raidNpc.id and Creature(raidNpc.id)
	if not npc then
		npc = Game.createNpc(RAID_NPC_NAME, raidNpcPosition, false, true)
		if npc then
			npc:setMasterPos(raidNpcPosition)
			npc:setDirection(DIRECTION_NORTH)
			raidNpc.id = npc:getId()
		end
	end
	if npc and #raidNpc.looks > 0 then
		raidNpc.look = raidNpc.look % #raidNpc.looks + 1
		npc:setOutfit(raidNpc.looks[raidNpc.look])
	end
	return true
end

raidTick:interval(2000)
raidTick:register()

-- !boss: co stoi w salkach losowego bossa albo ile zostalo do nastepnego
local raidInfo = TalkAction("!boss")

function raidInfo.onSay(player, words, param)
	local lines = {}
	for _, room in ipairs(raidRooms) do
		lines[#lines + 1] = raidStatus(room)
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Losowy Boss. " .. table.concat(lines, "; ") .. ".")
	return true
end

raidInfo:groupType("normal")
raidInfo:register()

-- Taski: jedno aktywne zadanie "zabij N sztuk potwora" z wybranego poziomu expowisk.
-- Nagroda wpada sama po ostatnim zabiciu: Tibia Coins i christmas tokeny (dla Token Tradera).
local TASK_TOKEN_ITEM = 6526
local taskTiers = {
	{ need = 200, coins = 10, tokens = 5, gold = 100000, rolls = 1 },
	{ need = 500, coins = 25, tokens = 10, gold = 300000, rolls = 1 },
	{ need = 1000, coins = 60, tokens = 20, gold = 1000000, rolls = 2 },
	{ need = 2000, coins = 150, tokens = 40, gold = 3000000, rolls = 3 },
}

-- Losowe nagrody dodatkowe (kazde losowanie wybiera jedna wedlug wagi).
local taskRandomRewards = {
	{ weight = 45, name = "kamien ulepszen", give = function(player, tier) player:addItem(20139, tier) return tier .. " x kamien ulepszen" end },
	{ weight = 20, name = "pelna stamina", give = function(player) player:addItem(18992, 1) return "fiolka pelnej staminy" end },
	{ weight = 25, name = "Tibia Coins", give = function(player, tier) player:addTibiaCoins(tier * 10) return (tier * 10) .. " dodatkowych Tibia Coins" end },
	{ weight = 10, name = "worek z nagroda", give = function(player)
		local bags = { { 34109, "bag you desire" }, { 39546, "primal bag" }, { 43895, "bag you covet" } }
		local bag = bags[math.random(#bags)]
		player:addItem(bag[1], 1)
		return bag[2]
	end },
}

local function taskRollReward(player, tier)
	local total = 0
	for _, reward in ipairs(taskRandomRewards) do
		total = total + reward.weight
	end
	local roll = math.random(total)
	for _, reward in ipairs(taskRandomRewards) do
		roll = roll - reward.weight
		if roll <= 0 then
			return reward.give(player, tier)
		end
	end
end

local function taskStore(player)
	return player:kv():scoped("ots-task")
end

local function taskGet(player)
	local store = taskStore(player)
	local tier = tonumber(store:get("tier")) or 0
	local index = tonumber(store:get("index")) or 0
	local entry = hunts[tier] and hunts[tier].list[index]
	if not entry or not taskTiers[tier] then
		return nil
	end
	return { tier = tier, entry = entry, count = tonumber(store:get("count")) or 0, need = taskTiers[tier].need }
end

local function taskClear(player)
	local store = taskStore(player)
	store:set("tier", 0)
	store:set("index", 0)
	store:set("count", 0)
end

local function taskReward(tier)
	local config = taskTiers[tier]
	return string.format("%d TC, %d gp, %d tokenow + %d losowa nagroda (kamienie / stamina / TC / worek)", config.coins, config.gold, config.tokens, config.rolls)
end

local function taskDoneCount(player, monster)
	return tonumber(player:kv():scoped("ots-task-done"):get(monster:lower())) or 0
end

local function taskStart(player, tier, index)
	if taskGet(player) then
		return
	end
	local store = taskStore(player)
	store:set("tier", tier)
	store:set("index", index)
	store:set("count", 0)
	local config = taskTiers[tier]
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Nowe zadanie: zabij %d x %s. Teleport znajdziesz pod !task.", config.need, hunts[tier].list[index].mon))
	player:sendChannelMessage("Taski", string.format("Nowe zadanie: %s 0/%d. Nagroda: %s.", hunts[tier].list[index].mon, config.need, taskReward(tier)), TALKTYPE_CHANNEL_O, 12)
end

local openTasks

-- Lista potworow z poziomu: [Complete xN] przy tych, ktorych task byl juz zrobiony.
local function openTaskTier(player, tier)
	local config = taskTiers[tier]
	local window = ModalWindow({ title = "Taski - " .. hunts[tier].label, message = string.format("%d potworow, nagroda: %s.\n[Complete] = task juz zrobiony (mozna powtorzyc).                    ", config.need, taskReward(tier)) })
	window:addChoice("Losowy potwor z tego poziomu", function(target)
		taskStart(target, tier, math.random(#hunts[tier].list))
	end)
	for index, entry in ipairs(hunts[tier].list) do
		if index > 250 then
			break
		end
		local times = taskDoneCount(player, entry.mon)
		local label = entry.mon
		if times > 0 then
			label = "[Complete] " .. entry.mon
		end
		window:addChoice(label, function(target)
			taskStart(target, tier, index)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		openTasks(target)
	end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

openTasks = function(player)
	local task = taskGet(player)
	local window
	if task then
		window = ModalWindow({
			title = "Taski",
			message = string.format("Zadanie: zabij %d x %s.\nPostep: %d/%d.\nNagroda: %s.", task.need, task.entry.mon, task.count, task.need, taskReward(task.tier)),
		})
		window:addChoice("Teleport na expowisko", function(target)
			local current = taskGet(target)
			if current then
				travel(target, current.entry)
			end
		end)
		window:addChoice("Porzuc zadanie", function(target)
			taskClear(target)
			target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zadanie porzucone. Mozesz wziac nowe.")
		end)
	else
		local done = tonumber(taskStore(player):get("done")) or 0
		window = ModalWindow({ title = "Taski", message = "Wybierz poziom, potem potwora (albo losowego). Kazdy task mozna robic wiele razy.\nUkonczone zadania: " .. done .. "                                        " })
		for tier, config in ipairs(taskTiers) do
			if hunts[tier] then
				local finished = 0
				for _, entry in ipairs(hunts[tier].list) do
					if taskDoneCount(player, entry.mon) > 0 then
						finished = finished + 1
					end
				end
				window:addChoice(string.format("%s: %d potworow (Complete: %d/%d)", hunts[tier].label, config.need, finished, #hunts[tier].list), function(target)
					openTaskTier(target, tier)
				end)
			end
		end
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end) -- przycisk bez funkcji uruchomilby zaznaczona pozycje
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Kanal czatu "Taski" (id 12, data/chatchannels/chatchannels.xml): postep kazdego zabicia.
local TASK_CHANNEL_ID = 12
local function taskChannel(player, text)
	player:sendChannelMessage("Taski", text, TALKTYPE_CHANNEL_O, TASK_CHANNEL_ID)
end

local taskKill = EventCallback("OtsTaskOnKill")

function taskKill.playerOnKill(player, monster)
	if not player or not monster or monster:getMaster() then
		return
	end
	local task = taskGet(player)
	if not task or monster:getName():lower() ~= task.entry.mon:lower() then
		return
	end
	local count = task.count + 1
	if count < task.need then
		taskStore(player):set("count", count)
		taskChannel(player, string.format("%s: %d/%d", task.entry.mon, count, task.need))
		return
	end
	local config = taskTiers[task.tier]
	local store = taskStore(player)
	store:set("done", (tonumber(store:get("done")) or 0) + 1)
	local doneStore = player:kv():scoped("ots-task-done")
	doneStore:set(task.entry.mon:lower(), (tonumber(doneStore:get(task.entry.mon:lower())) or 0) + 1)
	taskClear(player)
	player:addTibiaCoins(config.coins)
	player:addItem(TASK_TOKEN_ITEM, config.tokens)
	player:setBankBalance(player:getBankBalance() + config.gold)
	local extras = {}
	for _ = 1, config.rolls do
		extras[#extras + 1] = taskRollReward(player, task.tier)
	end
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Gratulacje! Wymagana liczba potworow zostala zabita: %d x %s.", task.need, task.entry.mon))
	taskChannel(player, string.format("Gratulacje! Task ukonczony: %d/%d %s. Nagroda: %d TC, %d gp na konto, %d tokenow, losowo: %s. Nowe zadanie: !task.", task.need, task.need, task.entry.mon, config.coins, config.gold, config.tokens, table.concat(extras, ", ")))
end

taskKill:register()

local taskCommand = TalkAction("!task")

function taskCommand.onSay(player, words, param)
	openTasks(player)
	return true
end

taskCommand:groupType("normal")
taskCommand:register()

-- Postac "Taski" w lobby hubu: wystarczy cokolwiek do niej powiedziec (np. hi), otwiera to samo okno.
local TASK_NPC_NAME = "Taski"
local taskNpcType = Game.createNpcType(TASK_NPC_NAME)
taskNpcType.onSay = function(npc, creature, type, message)
	local player = creature and creature:getPlayer()
	if player and player:getPosition():getDistance(npc:getPosition()) <= 4 then
		openTasks(player)
	end
end
taskNpcType:register({
	name = TASK_NPC_NAME,
	description = TASK_NPC_NAME,
	health = 100,
	maxHealth = 100,
	walkInterval = 0,
	walkRadius = 0,
	outfit = { lookType = 268, lookHead = 78, lookBody = 69, lookLegs = 58, lookFeet = 76, lookAddons = 3 },
	flags = { floorchange = false },
})

local taskNpcPlace = GlobalEvent("OtsTaskNpc")

function taskNpcPlace.onStartup()
	local npc = Game.createNpc(TASK_NPC_NAME, taskNpcPosition, false, true)
	if npc then
		npc:setMasterPos(taskNpcPosition)
		npc:setDirection(DIRECTION_SOUTH)
	end
	logger.info("[OTS taski] Postac w lobby: {}", npc and "tak" or "nie")
	return true
end

taskNpcPlace:register()

-- Fale: sala, w ktorej po wybiciu fali wchodzi nastepna, mocniejsza. Potwory ida po kolei
-- z listy expowisk (rosnaco wedlug exp). Za kazda fale jest zloto na konto, co piata takze Tibia Coins.
-- Odroczone wywolania niosa tylko id gracza i numer biegu (token).
local survival = { token = 0, ids = {}, wave = 0 }
local survivalMonsters = {}
for _, group in ipairs(hunts) do
	for _, entry in ipairs(group.list) do
		survivalMonsters[#survivalMonsters + 1] = entry.mon
	end
end

local function survivalClear()
	for _, id in ipairs(survival.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	survival.ids = {}
end

local function inSurvival(player)
	local pos = player:getPosition()
	return pos.z == survivalCenter.z and math.abs(pos.x - survivalCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - survivalCenter.y) <= ARENA_RADIUS + 1
end

local survivalCheck

local function survivalNext(playerId, token)
	if token ~= survival.token then
		return
	end
	local player = Player(playerId)
	if not player or not inSurvival(player) then
		survivalClear()
		return
	end
	survival.wave = survival.wave + 1
	local wave = survival.wave
	local name = survivalMonsters[math.min(#survivalMonsters, 6 + wave * 10)]
	local amount = math.min(10 + wave, 32)
	for _ = 1, amount do
		local pos = Position(survivalCenter.x + math.random(-ARENA_RADIUS + 1, ARENA_RADIUS - 1), survivalCenter.y + math.random(-ARENA_RADIUS + 1, 2), survivalCenter.z)
		local monster = name and Game.createMonster(name, pos, true, true)
		if monster then
			survival.ids[#survival.ids + 1] = monster:getId()
		end
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Fala %d: %d x %s.", wave, #survival.ids, name or "?"))
	addEvent(survivalCheck, 1000, playerId, token)
end

survivalCheck = function(playerId, token)
	if token ~= survival.token then
		return
	end
	local player = Player(playerId)
	if not player or not inSurvival(player) then
		survivalClear()
		return
	end
	for _, id in ipairs(survival.ids) do
		if Creature(id) then
			addEvent(survivalCheck, 1000, playerId, token)
			return
		end
	end
	survival.ids = {}
	local wave = survival.wave
	local gold = wave * 10000
	player:setBankBalance(player:getBankBalance() + gold)
	local text = string.format("Fala %d wybita: +%d gp na konto.", wave, gold)
	if wave % 3 == 0 then
		player:addItem(20139, 1)
		text = text .. " +1 kamien ulepszen."
	end
	if wave % 5 == 0 then
		player:addTibiaCoins(wave * 2)
		text = text .. string.format(" Bonus: +%d Tibia Coins.", wave * 2)
	end
	local store = player:kv():scoped("ots-survival")
	if wave > (tonumber(store:get("best")) or 0) then
		store:set("best", wave)
		text = text .. " Nowy rekord!"
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	addEvent(survivalNext, 2500, playerId, token)
end

local function survivalEnter(player)
	if inFight(player) then
		return
	end
	survivalClear()
	survival.token = survival.token + 1
	survival.wave = 0
	travel(player, { "Fale", survivalLanding.x, survivalLanding.y, survivalLanding.z })
	if not inSurvival(player) then
		return
	end
	local best = tonumber(player:kv():scoped("ots-survival"):get("best")) or 0
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Fale: pierwsza fala za chwile. Twoj rekord: fala %d. Wyjscie teleportem konczy bieg.", best))
	addEvent(survivalNext, 2500, player:getId(), survival.token)
end

-- Wieza: kolejne pietra coraz silniejszych potworow (z listy expowisk, rosnaco), co 10 pieter boss.
-- Rekord i punkt kontrolny (co 10 pieter) zapisuje sie na postaci - mozna zaczac od ostatniego punktu.
-- Odroczone wywolania niosa tylko id gracza i numer biegu (token).
local TOWER_BLESSED_STONE = 20138
local tower = { token = 0, ids = {}, floor = 0 }

local function towerClear()
	for _, id in ipairs(tower.ids) do
		local creature = Creature(id)
		if creature then
			creature:remove()
		end
	end
	tower.ids = {}
end

local function inTower(player)
	local pos = player:getPosition()
	return pos.z == towerCenter.z and math.abs(pos.x - towerCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - towerCenter.y) <= ARENA_RADIUS + 1
end

local towerCheck

local function towerNext(playerId, token)
	if token ~= tower.token then
		return
	end
	local player = Player(playerId)
	if not player or not inTower(player) then
		towerClear()
		return
	end
	tower.floor = tower.floor + 1
	local floor = tower.floor
	local name = survivalMonsters[math.min(#survivalMonsters, 10 + floor * 4)]
	local amount = math.min(8 + floor, 30)
	tower.ids = {}
	-- potwory w pierscieniu 2-3 pola wokol miejsca, w ktorym stoi postac (bez przenoszenia jej),
	-- tylko na wolnych polach sali poza PZ
	local here = player:getPosition()
	local ring = {}
	for dx = -3, 3 do
		for dy = -3, 3 do
			if math.max(math.abs(dx), math.abs(dy)) >= 2 then
				local pos = Position(here.x + dx, here.y + dy, here.z)
				local tile = Tile(pos)
				if math.abs(pos.x - towerCenter.x) <= ARENA_RADIUS and math.abs(pos.y - towerCenter.y) <= ARENA_RADIUS and tile and tile:isWalkable(true, true, true, true, false) then
					ring[#ring + 1] = pos
				end
			end
		end
	end
	for _ = 1, amount do
		local pos = #ring > 0 and table.remove(ring, math.random(#ring)) or towerCenter
		local monster = name and Game.createMonster(name, pos, true, true)
		if monster then
			tower.ids[#tower.ids + 1] = monster:getId()
		end
	end
	local bossText = ""
	if floor % 10 == 0 and #rushBosses > 0 then
		local bossName = rushBosses[math.min(#rushBosses, math.floor(floor / 10))]
		local bossPos = #ring > 0 and table.remove(ring, math.random(#ring)) or towerCenter
		local boss = Game.createMonster(bossName, bossPos, true, true)
		if boss then
			tower.ids[#tower.ids + 1] = boss:getId()
			bossText = " + boss " .. bossName
		end
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wieza, pietro %d: %d x %s%s.", floor, amount, name or "?", bossText))
	addEvent(towerCheck, 1000, playerId, token)
end

towerCheck = function(playerId, token)
	if token ~= tower.token then
		return
	end
	local player = Player(playerId)
	if not player or not inTower(player) then
		towerClear()
		return
	end
	for _, id in ipairs(tower.ids) do
		if Creature(id) then
			addEvent(towerCheck, 1000, playerId, token)
			return
		end
	end
	tower.ids = {}
	local floor = tower.floor
	local gold = floor * 20000
	player:setBankBalance(player:getBankBalance() + gold)
	local text = string.format("Pietro %d zaliczone: +%d gp na konto.", floor, gold)
	if floor % 5 == 0 then
		player:addTibiaCoins(floor)
		text = text .. string.format(" +%d Tibia Coins.", floor)
	end
	if floor % 10 == 0 then
		player:addItem(TOWER_BLESSED_STONE, 1)
		text = text .. " +1 blessed upgrade stone. Punkt kontrolny zapisany."
	end
	local store = player:kv():scoped("ots-tower")
	if floor > (tonumber(store:get("best")) or 0) then
		store:set("best", floor)
		text = text .. " Nowy rekord!"
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	addEvent(towerNext, 3000, playerId, token)
end

local function towerStart(player, fromFloor)
	if inFight(player) then
		return
	end
	towerClear()
	tower.token = tower.token + 1
	tower.floor = fromFloor
	travel(player, { "Wieza", towerLanding.x, towerLanding.y, towerLanding.z })
	if not inTower(player) then
		return
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wieza: pietro %d za chwile. Wyjscie teleportem konczy bieg.", fromFloor + 1))
	addEvent(towerNext, 3000, player:getId(), tower.token)
end

local function towerEnter(player)
	if inFight(player) then
		return
	end
	local best = tonumber(player:kv():scoped("ots-tower"):get("best")) or 0
	local checkpoint = best - best % 10
	local window = ModalWindow({ title = "Wieza", message = string.format("Rekord: pietro %d. Punkt kontrolny: pietro %d.\nNagrody: zloto za kazde pietro, TC co 5, blessed upgrade stone co 10 (boss).                    ", best, checkpoint) })
	window:addChoice("Start od pietra 1", function(target)
		towerStart(target, 0)
	end)
	if checkpoint > 0 then
		window:addChoice(string.format("Start od pietra %d (punkt kontrolny)", checkpoint + 1), function(target)
			towerStart(target, checkpoint)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true)
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Boss Rush: bossy z pul Losowego Bossa jeden po drugim, od najslabszego. Po kazdym zabitym
-- nagroda rosnie (zloto na konto i Tibia Coins), a po chwili wchodzi nastepny.
-- Odroczone wywolania niosa tylko id gracza i numer biegu (token).
local rush = { token = 0, bossId = nil, index = 0 }

local function rushClear()
	local creature = rush.bossId and Creature(rush.bossId)
	if creature then
		creature:remove()
	end
	rush.bossId = nil
end

local function inRush(player)
	local pos = player:getPosition()
	return pos.z == rushCenter.z and math.abs(pos.x - rushCenter.x) <= ARENA_RADIUS + 1 and math.abs(pos.y - rushCenter.y) <= ARENA_RADIUS + 1
end

local rushCheck

local function rushNext(playerId, token)
	if token ~= rush.token then
		return
	end
	local player = Player(playerId)
	if not player or not inRush(player) then
		rushClear()
		return
	end
	if rush.index >= #rushBosses then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss Rush ukonczony - wszystkie bossy pokonane!")
		return
	end
	rush.index = rush.index + 1
	local name = rushBosses[rush.index]
	local monster = Game.createMonster(name, Position(rushCenter.x, rushCenter.y - 4, rushCenter.z), true, true)
	if not monster then
		addEvent(rushNext, 500, playerId, token) -- tego bossa nie da sie postawic, bierzemy nastepnego
		return
	end
	rush.bossId = monster:getId()
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Boss Rush %d/%d: %s.", rush.index, #rushBosses, name))
	addEvent(rushCheck, 1000, playerId, token)
end

rushCheck = function(playerId, token)
	if token ~= rush.token then
		return
	end
	local player = Player(playerId)
	if not player or not inRush(player) then
		rushClear()
		return
	end
	if rush.bossId and Creature(rush.bossId) then
		addEvent(rushCheck, 1000, playerId, token)
		return
	end
	rush.bossId = nil
	local index = rush.index
	local gold = index * 50000
	player:setBankBalance(player:getBankBalance() + gold)
	player:addTibiaCoins(index * 2)
	local text = string.format("Boss %d pokonany: +%d gp na konto, +%d Tibia Coins.", index, gold, index * 2)
	local store = player:kv():scoped("ots-bossrush")
	if index > (tonumber(store:get("best")) or 0) then
		store:set("best", index)
		text = text .. " Nowy rekord!"
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	addEvent(rushNext, 3000, playerId, token)
end

local function rushEnter(player)
	if inFight(player) then
		return
	end
	rushClear()
	rush.token = rush.token + 1
	rush.index = 0
	travel(player, { "Boss Rush", rushLanding.x, rushLanding.y, rushLanding.z })
	if not inRush(player) then
		return
	end
	local best = tonumber(player:kv():scoped("ots-bossrush"):get("best")) or 0
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Boss Rush: pierwszy boss za chwile. Twoj rekord: %d. Wyjscie teleportem konczy bieg.", best))
	addEvent(rushNext, 3000, player:getId(), rush.token)
end

local openMain

-- Uruchamia cel z listy: zwykly teleport albo quest z wlasnym skryptem.
local function startEntry(player, entry)
	if entry.arena then
		arenaStart(player, entry)
		return
	end
	if not entry.func then
		travel(player, entry)
		return
	end
	local start = _G[entry.func]
	if not start then
		player:sendCancelMessage("Ten quest nie jest jeszcze dostepny.")
	elseif not inFight(player) then
		start(player)
	end
end

-- Czy quest jest juz zrobiony: skrzynie z nagroda zapisuja to w questKV (kv) albo w storage.
local function storageByPath(path)
	local value = _G
	for part in path:gmatch("[^%.]+") do
		if type(value) ~= "table" then
			return nil
		end
		value = value[part]
	end
	return tonumber(value)
end

local function questDone(player, entry)
	local done = entry.done
	if not done then
		return false
	end
	for _, name in ipairs(done.kv or {}) do
		if player:questKV(name):get("completed") then
			return true
		end
	end
	for _, item in ipairs(done.st or {}) do
		local key = storageByPath(item[1])
		if key and player:getStorageValue(key) >= (item[2] or 1) then
			return true
		end
	end
	return false
end

-- Dluga pierwsza linia poszerza okno w kliencie, zeby nazwy na liscie sie miescily.
local WIDE_MESSAGE = "Wybierz cel z listy i kliknij Wybierz. [Complete] = juz zrobione.                                        "

local function openList(player, title, list, back)
	local window = ModalWindow({ title = title, message = WIDE_MESSAGE })
	for i = 1, math.min(#list, 255) do
		local entry = list[i]
		local label = entry[1]
		if entry.done and questDone(player, entry) then
			label = "[Complete] " .. label
		end
		window:addChoice(label, function(target)
			startEntry(target, entry)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		back(target)
	end)
	window:setPriority(true) -- okno przejmuje klawiature: strzalki, Enter, Esc
	-- Klient 15.x czyta te dwa pola w odwrotnej kolejnosci niz wysyla je serwer,
	-- dlatego wartosci sa zamienione: Enter = przycisk 1, Esc = przycisk 2.
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local function openHunts(player)
	local window = ModalWindow({ title = "Expowiska", message = "Wybierz poziom trudnosci." })
	for i = 1, #hunts do
		local group = hunts[i]
		window:addChoice(group.label .. " [" .. #group.list .. "]", function(target)
			openList(target, group.label, group.list, openHunts)
		end)
	end
	window:addButton("Wybierz")
	window:addButton("Wstecz", function(target)
		openMain(target)
	end)
	window:setPriority(true) -- okno przejmuje klawiature: strzalki, Enter, Esc
	-- Klient 15.x czyta te dwa pola w odwrotnej kolejnosci niz wysyla je serwer,
	-- dlatego wartosci sa zamienione: Enter = przycisk 1, Esc = przycisk 2.
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local function openTowns(player)
	local list = {}
	for _, town in ipairs(Game.getTowns()) do
		local pos = town:getTemplePosition()
		if pos and pos.x > 0 then
			list[#list + 1] = { town:getName(), pos.x, pos.y, pos.z, town = true }
		end
	end
	table.sort(list, function(a, b)
		local aFirst, bFirst = a[1]:lower() == ENTRY_TOWN, b[1]:lower() == ENTRY_TOWN
		if aFirst ~= bFirst then
			return aFirst
		end
		return a[1] < b[1]
	end)
	openList(player, "Miasta", list, function(target)
		openMain(target)
	end)
end

openMain = function(player)
	local window = ModalWindow({ title = "Teleporty", message = "Dokad chcesz sie przeniesc?" })
	window:addChoice("Expowiska (Low / Medium / Hard / Very Hard)", function(target)
		openHunts(target)
	end)
	window:addChoice("Bossy [" .. #bosses .. "]", function(target)
		openList(target, "Bossy", bosses, function(again)
			openMain(again)
		end)
	end)
	window:addChoice("Wierzchowce do oswojenia", function(target)
		if OtsMountHall and not inFight(target) then
			OtsMountHall(target)
		end
	end)
	window:addChoice("Taski", function(target)
		openTasks(target)
	end)
	window:addChoice("Fale potworow", function(target)
		survivalEnter(target)
	end)
	window:addChoice("Wieza (pietra, boss co 10)", function(target)
		towerEnter(target)
	end)
	window:addChoice("Boss Rush (bossy jeden po drugim)", function(target)
		rushEnter(target)
	end)
	window:addChoice("Losowy Boss (nowy co 10 min po zabiciu)", function(target)
		raidEnter(target)
	end)
	window:addChoice("Questy [" .. #quests .. "]", function(target)
		openList(target, "Questy", quests, function(again)
			openMain(again)
		end)
	end)
	window:addChoice("Stroje (questy)", function(target)
		if inFight(target) then
			return
		end
		if OtsOutfitList then
			OtsOutfitList(target, function(again)
				openMain(again)
			end)
		elseif OtsOutfitHall then
			OtsOutfitHall(target)
		end
	end)
	window:addChoice("Miasta", function(target)
		openTowns(target)
	end)
	window:addButton("Wybierz")
	window:addButton("Zamknij", function() end)
	window:setPriority(true) -- okno przejmuje klawiature: strzalki, Enter, Esc
	-- Klient 15.x czyta te dwa pola w odwrotnej kolejnosci niz wysyla je serwer,
	-- dlatego wartosci sa zamienione: Enter = przycisk 1, Esc = przycisk 2.
	window:setDefaultEnterButton(2)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

-- Komenda !tp
local command = TalkAction("!tp")

function command.onSay(player, words, param)
	openMain(player)
	return true
end

command:groupType("normal")
command:register()

-- Funkcje hubu sa zdefiniowane nizej, ale uzywa ich juz teleport w swiatyni.
local HUB_MESSAGES = true
local hubMove, hubLobbyMessage

-- Teleport przy swiatyni w Thais
local entryStep = MoveEvent()

function entryStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	-- Teleport w swiatyni prowadzi do hubu expowisk; pelne menu jest pod komenda !tp.
	hubMove(player, hubLobby, "Hub: lobby")
	return true
end

entryStep:type("stepin")
entryStep:aid(ENTRY_ACTION_ID)
entryStep:register()

-- Teleport powrotny (tylko gracze, potwory zostaja na miejscu)
local returnStep = MoveEvent()

function returnStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or not templePosition then
		return true
	end
	player:teleportTo(templePosition)
	player:removeCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	position:sendMagicEffect(CONST_ME_POFF)
	templePosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

returnStep:type("stepin")
returnStep:aid(RETURN_ACTION_ID)
returnStep:register()

-- Hub expowisk: osobna mapa z korytarzami; kazdy pad to jeden cel.
hubMove = function(player, destination, message)
	local from = player:getPosition()
	player:teleportTo(destination)
	from:sendMagicEffect(CONST_ME_POFF)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	-- Krotkie opisy przy przejsciach w hubie. Klient sam dobiera czas wyswietlania do dlugosci
	-- tekstu, wiec zeby znikaly szybko, musza byc jednolinijkowe. HUB_MESSAGES = false je wylacza.
	if HUB_MESSAGES and message then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	end
end

hubLobbyMessage = function()
	local names = {}
	for i = 1, #hubWings do
		names[i] = hubWings[i].label
	end
	return "Hub. Expowiska na polnocy, od zachodu: " .. table.concat(names, ", ") .. ". Na poludniu: stroje, Thais, questy, bossy."
end

local hubStep = MoveEvent()

function hubStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local action = hubPads[key(position)]
	if not action then
		return true
	end

	if action.hunt then
		travel(player, action.hunt)
	elseif action.wing then
		local wing = hubWings[action.wing]
		hubMove(player, Position(wing.x, wing.y, wing.z), "EXP " .. wing.label .. ", pietro 1")
	elseif action.goto then
		hubMove(player, Position(action.goto[1], action.goto[2], action.goto[3]), action.label)
	elseif action.lobby then
		hubMove(player, hubLobby, "Hub: lobby")
	elseif action.thais and templePosition then
		hubMove(player, templePosition)
	elseif action.randomboss then
		raidEnter(player)
	elseif action.survival then
		survivalEnter(player)
	elseif action.bossrush then
		rushEnter(player)
	elseif action.tower then
		towerEnter(player)
	elseif action.mounts and OtsMountHall then
		OtsMountHall(player)
	elseif action.outfits and OtsOutfitHall then
		OtsOutfitHall(player)
	elseif action.questhall then
		hubMove(player, hubQuestHall, "Hala questow")
	elseif action.quest then
		startEntry(player, action.quest)
	elseif action.bosshall then
		hubMove(player, hubBossHall, "Hala bossow, pietro 1")
	elseif action.boss then
		startEntry(player, action.boss)
	end
	return true
end

hubStep:type("stepin")
hubStep:aid(HUB_ACTION_ID)
hubStep:register()

-- Spojrzenie na pad w hubie pokazuje, dokad prowadzi.
local hubLook = EventCallback("OtsHubPlayerOnLook")

function hubLook.playerOnLook(player, inspectedThing, inspectedPosition, lookDistance)
	if not inspectedThing or not inspectedThing:isItem() or inspectedThing:getActionId() ~= HUB_ACTION_ID then
		return
	end
	local action = hubPads[key(inspectedPosition)]
	if not action then
		return
	end
	local text
	if action.hunt then
		text = "Teleport: " .. action.hunt[1]
	elseif action.wing then
		text = "Expowiska: " .. hubWings[action.wing].label
	elseif action.goto then
		text = "Przejscie: " .. action.label
	elseif action.lobby then
		text = "Powrot do lobby hubu"
	elseif action.randomboss then
		text = "Losowy Boss"
	elseif action.survival then
		text = "Fale potworow"
	elseif action.bossrush then
		text = "Boss Rush"
	elseif action.tower then
		text = "Wieza"
	elseif action.mounts then
		text = "Wierzchowce do oswojenia"
	elseif action.outfits then
		text = "Questy na stroje"
	elseif action.questhall then
		text = "Hala questow"
	elseif action.quest then
		text = "Quest: " .. action.quest[1]
	elseif action.bosshall then
		text = "Hala bossow"
	elseif action.boss then
		text = "Boss: " .. action.boss[1]
	else
		text = "Powrot do swiatyni w Thais"
	end
	player:sendTextMessage(MESSAGE_LOOK, text)
end

hubLook:register()

-- Bezpieczna strefa: blokada atakow w obie strony na polach 3x3
local safeTarget = EventCallback("OtsSafeZoneTargetCombat")

function safeTarget.creatureOnTargetCombat(attacker, target)
	-- Silnik odczytuje wynik jako true/false: false blokuje atak.
	if isSafe(target) and target:isPlayer() then
		return false
	end
	if attacker and attacker:isPlayer() and isSafe(attacker) then
		return false
	end
	return true
end

safeTarget:register()

local safeArea = EventCallback("OtsSafeZoneAreaCombat")

function safeArea.creatureOnAreaCombat(creature, tile, isAggressive)
	if isAggressive and tile and safeTiles[key(tile:getPosition())] then
		return false
	end
	return true
end

safeArea:register()

local offsets = {
	{ 0, -2 }, { 2, 0 }, { -2, 0 }, { 0, 2 }, { 2, -2 }, { -2, -2 }, { 2, 2 }, { -2, 2 },
	{ 0, -3 }, { 3, 0 }, { -3, 0 }, { 0, 3 }, { 1, -1 }, { -1, -1 }, { 1, 1 }, { -1, 1 },
	{ 0, -1 }, { 1, 0 }, { -1, 0 }, { 0, 1 },
}

local placeEntry = GlobalEvent("OtsTeleportEntry")

function placeEntry.onStartup()
	local temple
	for _, town in ipairs(Game.getTowns()) do
		if town:getName():lower() == ENTRY_TOWN then
			temple = town:getTemplePosition()
			break
		end
	end
	templePosition = temple
	if not temple then
		logger.warn("[OTS teleporty] Nie znaleziono miasta '{}'. Uzyj komendy !tp.", ENTRY_TOWN)
		return true
	end

	-- Teleport do Event Room w swiatyni (z mapy dodatkowej) zamieniamy na wejscie do hubu.
	local eventRoomPosition = Position(32373, 32236, 7)
	local eventTile = Tile(eventRoomPosition)
	if eventTile then
		local old = eventTile:getItemById(ENTRY_ITEM_ID)
		if old then
			old:remove()
			local item = Game.createItem(ENTRY_ITEM_ID, 1, eventRoomPosition)
			if item then
				item:setActionId(ENTRY_ACTION_ID)
				logger.info("[OTS teleporty] Teleport Event Room w swiatyni prowadzi teraz do hubu: {}, {}, {}", eventRoomPosition.x, eventRoomPosition.y, eventRoomPosition.z)
				return true
			end
		end
	end

	for _, offset in ipairs(offsets) do
		local pos = Position(temple.x + offset[1], temple.y + offset[2], temple.z)
		local tile = Tile(pos)
		if tile and tile:isWalkable(false, false, true, true, false) and tile:getItemCount() == 0 and not tile:getHouse() then
			local item = Game.createItem(ENTRY_ITEM_ID, 1, pos)
			if item then
				item:setActionId(ENTRY_ACTION_ID)
				logger.info("[OTS teleporty] Wejscie w Thais: {}, {}, {} (swiatynia: {}, {}, {})", pos.x, pos.y, pos.z, temple.x, temple.y, temple.z)
				return true
			end
		end
	end

	logger.warn("[OTS teleporty] Brak wolnego pola przy swiatyni w Thais. Uzyj komendy !tp.")
	return true
end

placeEntry:register()
''')
open('ots_teleports.lua','w').write('\n'.join(o))

# ---- osobny plik: postacie z wygladem bossow w hali bossow
BD=['-- OTS: podobizny bossow w hali bossow (plik generowany razem z mapa hubu).','-- Kazda to NPC z wygladem bossa; stoi za padem prowadzacym pod jego dzwignie.','','local displays = {']
for b in [dict(x,raw=True) for x in HUB['npcs']]+HUB['bossDisplays']:
    of=', '.join('%s = %d'%(k,v) for k,v in b['outfit'].items())
    BD.append('\t{ name = %s, outfit = { %s }, position = Position(%d, %d, %d), faceSouth = %s%s },'%(q(b['name'] if b.get('raw') else 'Boss '+b['name']),of,*b['pos'],'true' if b['south'] else 'false',', direction = '+b['dir'] if b.get('dir') else ''))
BD.append('}')
BD.append(r"""
local registered = {} -- ta sama nazwa (np. Lobby) stoi w wielu miejscach: typ rejestrujemy raz
for _, display in ipairs(displays) do
	if not registered[display.name] then
		registered[display.name] = true
		local npcType = Game.createNpcType(display.name)
		local npcConfig = {}
		npcConfig.name = display.name
		npcConfig.description = display.name
		npcConfig.health = 100
		npcConfig.maxHealth = 100
		npcConfig.walkInterval = 0
		npcConfig.walkRadius = 0
		npcConfig.outfit = display.outfit
		npcConfig.flags = {
			floorchange = false,
		}
		npcType:register(npcConfig)
	end
end

local place = GlobalEvent("OtsBossDisplays")

function place.onStartup()
	local placed = 0
	for _, display in ipairs(displays) do
		local npc = Game.createNpc(display.name, display.position, false, true)
		if npc then
			npc:setMasterPos(display.position)
			npc:setDirection(display.direction or (display.faceSouth and DIRECTION_SOUTH or DIRECTION_NORTH))
			placed = placed + 1
		end
	end
	logger.info("[OTS hub] Postacie w hubie (poziomy i bossy): {}/{}", placed, #displays)
	return true
end

place:register()
""")
open('ots_boss_displays.lua','w').write('\n'.join(BD))
