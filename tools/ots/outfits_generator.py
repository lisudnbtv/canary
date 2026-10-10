import re,collections
xml=open('/home/claude/canary/data/XML/outfits.xml').read()
rows=re.findall(r'<outfit type="(\d)" looktype="(\d+)" name="([^"]*)"',xml)
KW=[('distance',['hunter','ranger','archer','arbalest','falconer','paladin','tracer','assassin','sinister']),
('shield',['defender','guardian','guidon','soil','insectoid','deepling','crystal warlord']),
('melee',['knight','warrior','barbarian','warmaster','champion','lion of war','blade','fencer','jouster','mercenary','siege','norseman','chieftain','slayer','demon hunter','avenger','raider','inquisition','revenant','pirate','brotherhood','nightmare']),
('magic',['mage','wizard','summoner','elementalist','conjurer','evoker','rune master','void','acolyte','herald','puppeteer','spirit caller','philosopher','yalaharian','pharaoh','poltergeist','demon']),
('mana',['druid','shaman','herbalist','priest','grove','seaweaver','forest','rootwalker','owl','warden','beekeeper','ceremonial','ancient','disciple']),
('health',['monk','martial','beastmaster','herder','afflicted','beggar','citizen','nobleman','noblewoman','fire-fighter','golden','royal']),
('speed',['wayfarer','trailblazer','discoverer','explorer','sea dog','jester','recruiter','engineer','entrepreneur','moth','breezy','rascoohan'])]
ORDER=['health','mana','melee','distance','magic','shield','speed']
byname={}
rot=0
names=[]
for t,lt,name in rows:
    if name not in byname:
        low=name.lower();kind=None
        for k,ws in KW:
            if any(w in low for w in ws): kind=k;break
        if not kind:
            kind=ORDER[rot%len(ORDER)];rot+=1
        byname[name]=kind;names.append(name)
lines=[]
for t,lt,name in rows:
    lines.append('\t[%s] = { name = "%s" },'%(lt,name))
c=collections.Counter(byname.values());print(c,len(names))
lua='''-- OTS: bonusy za stroje (outfity).
-- Kazdy stroj daje ten sam komplet bonusow; kazdy zalozony dodatek (addon) go zwieksza:
-- bez dodatkow x1, jeden dodatek x2, oba dodatki x3.
-- Bonusy dzialaja, dopoki stroj jest zalozony, i wracaja po zalogowaniu.
-- Komenda !outfit pokazuje aktualne wartosci.

local SUBID = 64990

-- Wartosci na jeden poziom (poziom = 1 + liczba dodatkow).
local PER_LEVEL = {
	health = 10, -- HP co 2 sekundy
	mana = 10, -- many co 2 sekundy
	melee = 3, -- sword, axe, club
	distance = 3,
	shield = 3,
	magic = 1,
	speed = 20,
	lifeLeech = 300, -- w setnych procenta: 300 = 3%% zadanych obrazen
	manaLeech = 200,
}

-- Stroje objete bonusem (wyglad -> nazwa).
local outfits = {
%s
}

local function levelOf(addons)
	local level = 1
	if addons == 1 or addons == 2 then
		level = 2
	elseif addons >= 3 then
		level = 3
	end
	return level
end

local function describe(lookType, addons)
	local outfit = outfits[lookType]
	if not outfit then
		return nil
	end
	local level = levelOf(addons)
	local p = PER_LEVEL
	return string.format(
		"%%s (poziom %%d/3): +%%d HP i +%%d many co 2 s, +%%d walka wrecz, +%%d distance, +%%d shielding, +%%d magic level, +%%d szybkosci, life leech %%d%%%%, mana leech %%d%%%%",
		outfit.name,
		level,
		p.health * level,
		p.mana * level,
		p.melee * level,
		p.distance * level,
		p.shield * level,
		p.magic * level,
		p.speed * level,
		p.lifeLeech * level / 100,
		p.manaLeech * level / 100
	)
end

local function clear(player)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, SUBID)
	-- osobny warunek na leech z poprzedniej wersji skryptu
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID + 1)
end

local function apply(player, lookType, addons)
	clear(player)

	if not outfits[lookType] then
		return false
	end

	local level = levelOf(addons)
	local p = PER_LEVEL

	local skills = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	skills:setParameter(CONDITION_PARAM_SUBID, SUBID)
	skills:setParameter(CONDITION_PARAM_TICKS, -1)
	skills:setParameter(CONDITION_PARAM_SKILL_MELEE, p.melee * level)
	skills:setParameter(CONDITION_PARAM_SKILL_DISTANCE, p.distance * level)
	skills:setParameter(CONDITION_PARAM_SKILL_SHIELD, p.shield * level)
	skills:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, p.magic * level)
	skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
	skills:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, p.lifeLeech * level)
	skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
	skills:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, p.manaLeech * level)
	player:addCondition(skills)

	local regeneration = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	regeneration:setParameter(CONDITION_PARAM_SUBID, SUBID)
	regeneration:setParameter(CONDITION_PARAM_TICKS, -1)
	regeneration:setParameter(CONDITION_PARAM_HEALTHGAIN, p.health * level)
	regeneration:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)
	regeneration:setParameter(CONDITION_PARAM_MANAGAIN, p.mana * level)
	regeneration:setParameter(CONDITION_PARAM_MANATICKS, 2000)
	player:addCondition(regeneration)

	local haste = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
	haste:setParameter(CONDITION_PARAM_SUBID, SUBID)
	haste:setParameter(CONDITION_PARAM_TICKS, -1)
	haste:setParameter(CONDITION_PARAM_SPEED, p.speed * level)
	player:addCondition(haste)
	return true
end

-- Zmiana stroju: bonusy przeliczone na nowo.
local change = EventCallback("OtsOutfitBonusOnChange")

function change.creatureOnChangeOutfit(creature, outfit)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if apply(player, outfit.lookType, outfit.lookAddons or 0) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus stroju - " .. describe(outfit.lookType, outfit.lookAddons or 0))
	end
	return true
end

change:register()

-- Logowanie: przywroc bonusy aktualnego stroju.
local login = EventCallback("OtsOutfitBonusOnLogin")

function login.playerOnLoginComplete(player)
	local outfit = player:getOutfit()
	apply(player, outfit.lookType, outfit.lookAddons or 0)
end

login:register()

local command = TalkAction("!outfit")

function command.onSay(player, words, param)
	local outfit = player:getOutfit()
	local text = describe(outfit.lookType, outfit.lookAddons or 0)
	if text then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus stroju - " .. text .. ". Kazdy dodatek zwieksza bonusy.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ten stroj nie ma bonusu.")
	end
	return true
end

command:groupType("normal")
command:register()
'''%'\n'.join(lines)
open('ots_outfits.lua','w').write(lua)
import json;json.dump(byname,open('outfit_kinds.json','w'))
for k in ORDER: print(k,':',', '.join(n for n in names if byname[n]==k))
