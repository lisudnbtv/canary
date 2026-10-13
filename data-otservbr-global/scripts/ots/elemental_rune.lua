-- OTS: Elemental Storm Rune (sklep). Dla kazdej profesji od 2500 poziomu. Uzywa sie jak avalanche:
-- na cel albo pole, a wybuch ma zasieg jak UE (kolo 6x6). Uderza naraz ogniem, lodem, energia, ziemia,
-- smiercia, swietoscia i fizycznie, wiec trafia kazdego potwora niezaleznie od jego odpornosci.
-- Obrazenia licza sie z poziomu i magic levelu, tak samo dla wszystkich profesji.
-- Runy na serwerze nie zuzywaja ladunkow (removeChargesFromRunes = false), wiec jedna sztuka wystarcza.
-- Przedmiot: items.xml (id 60101), wyglad w appearances.dat (tools/ots/ots_runes.py).

local RUNE_ID = 60101
local LEVEL = 2500

local elements = {
	{ COMBAT_ICEDAMAGE, CONST_ME_ICEAREA, CONST_ANI_ICE },
	{ COMBAT_FIREDAMAGE, CONST_ME_FIREAREA },
	{ COMBAT_ENERGYDAMAGE, CONST_ME_BIGCLOUDS },
	{ COMBAT_EARTHDAMAGE, CONST_ME_SMALLPLANTS },
	{ COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA },
	{ COMBAT_HOLYDAMAGE, CONST_ME_HOLYAREA },
	{ COMBAT_PHYSICALDAMAGE, CONST_ME_EXPLOSIONAREA },
}

-- Na kazdy zywiol osobno; razem 7 uderzen.
local function stormValues(player, level, maglevel)
	local min = (level * 0.25) + (maglevel * 2)
	local max = (level * 0.4) + (maglevel * 4)
	return -min, -max
end

local combats = {}
for _, element in ipairs(elements) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, element[1])
	combat:setParameter(COMBAT_PARAM_EFFECT, element[2])
	if element[3] then
		combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, element[3])
	end
	combat:setArea(createCombatArea(AREA_CIRCLE6X6))
	-- silnik zabiera funkcje o tej nazwie przy kazdym setCallback, wiec ustawiamy ja od nowa dla kazdej walki
	onGetElementalStormValues = stormValues
	combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetElementalStormValues")
	combats[#combats + 1] = combat
end

local rune = Spell("rune")

-- Zywioly uderzaja jeden po drugim co STEP_MS, zeby kazda liczba obrazen byla widoczna osobno
-- (naraz klient pokazuje tylko czesc z nich). Odroczone uderzenia trzymaja tylko id gracza
-- i pozycje celu, a gracza szukaja od nowa; gdy go nie ma, nic nie robia.
local STEP_MS = 150

local function strike(playerId, position, index)
	local player = Player(playerId)
	if not player then
		return
	end
	combats[index]:execute(player, Variant(position))
end

function rune.onCastSpell(creature, var, isHotkey)
	if not combats[1]:execute(creature, var) then
		return false
	end
	local position = var:getPosition()
	if not position or position.x == 0 then
		return true
	end
	local playerId = creature:getId()
	for index = 2, #combats do
		addEvent(strike, STEP_MS * (index - 1), playerId, Position(position.x, position.y, position.z), index)
	end
	return true
end

rune:id(16)
rune:group("attack")
rune:name("elemental storm rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:runeId(RUNE_ID)
rune:allowFarUse(true)
rune:charges(1)
rune:level(LEVEL)
rune:magicLevel(0)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(false)
rune:register()
