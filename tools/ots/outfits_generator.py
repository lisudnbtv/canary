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
    lines.append('\t[%s] = { name = "%s", kind = "%s" },'%(lt,name,byname[name]))
c=collections.Counter(byname.values());print(c,len(names))
lua='''-- OTS: bonusy za stroje (outfity).
-- Kazdy stroj daje jeden bonus; kazdy zalozony dodatek (addon) go zwieksza:
-- bez dodatkow x1, jeden dodatek x2, oba dodatki x3.
-- Bonus dziala, dopoki stroj jest zalozony, i wraca po zalogowaniu.
-- Do tego kazdy stroj daje life leech i mana leech, tez rosnace z dodatkami.
-- Komenda !outfit pokazuje aktualny bonus.

local SUBID = 64990
local LEECH_SUBID = 64991

-- Leech na poziom, w setnych procenta (300 = 3%% zadanych obrazen).
local LIFE_LEECH_PER_LEVEL = 300
local MANA_LEECH_PER_LEVEL = 200

-- Wartosc bonusu na jeden poziom (poziom = 1 + liczba dodatkow).
local kinds = {
	health = { perLevel = 10, text = "+%%d HP co 2 sekundy" },
	mana = { perLevel = 10, text = "+%%d many co 2 sekundy" },
	melee = { perLevel = 3, text = "+%%d do walki wrecz (sword, axe, club)" },
	distance = { perLevel = 3, text = "+%%d distance" },
	shield = { perLevel = 3, text = "+%%d shielding" },
	magic = { perLevel = 1, text = "+%%d magic level" },
	speed = { perLevel = 20, text = "+%%d szybkosci" },
}

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
	local kind = kinds[outfit.kind]
	local level = levelOf(addons)
	return string.format("%%s: " .. kind.text .. ", life leech %%d%%%%, mana leech %%d%%%% (poziom %%d/3)", outfit.name, kind.perLevel * level, LIFE_LEECH_PER_LEVEL * level / 100, MANA_LEECH_PER_LEVEL * level / 100, level)
end

local function clear(player)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, SUBID)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, LEECH_SUBID)
end

local function apply(player, lookType, addons)
	clear(player)

	local outfit = outfits[lookType]
	if not outfit then
		return false
	end

	local level = levelOf(addons)
	local value = kinds[outfit.kind].perLevel * level
	local condition
	if outfit.kind == "health" then
		condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_HEALTHGAIN, value)
		condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)
	elseif outfit.kind == "mana" then
		condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_MANAGAIN, value)
		condition:setParameter(CONDITION_PARAM_MANATICKS, 2000)
	elseif outfit.kind == "speed" then
		condition = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_SPEED, value)
	else
		condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		if outfit.kind == "melee" then
			condition:setParameter(CONDITION_PARAM_SKILL_MELEE, value)
		elseif outfit.kind == "distance" then
			condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, value)
		elseif outfit.kind == "shield" then
			condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, value)
		elseif outfit.kind == "magic" then
			condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, value)
		end
	end

	condition:setParameter(CONDITION_PARAM_SUBID, SUBID)
	condition:setParameter(CONDITION_PARAM_TICKS, -1)
	player:addCondition(condition)

	-- Leech dla kazdego stroju, w osobnym warunku, zeby nie kolidowal z bonusem glownym.
	local leech = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	leech:setParameter(CONDITION_PARAM_SUBID, LEECH_SUBID)
	leech:setParameter(CONDITION_PARAM_TICKS, -1)
	leech:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
	leech:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, LIFE_LEECH_PER_LEVEL * level)
	leech:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
	leech:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, MANA_LEECH_PER_LEVEL * level)
	player:addCondition(leech)
	return true
end

-- Zmiana stroju: nowy bonus zamiast starego.
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

-- Logowanie: przywroc bonus aktualnego stroju.
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus stroju - " .. text .. ". Kazdy dodatek zwieksza bonus.")
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
