-- OTS: ustawienia serwera nadpisujace domyslne z config.lua.
-- Kazda linia to zwykle przypisanie Lua; zmiana wymaga restartu serwera (restart.bat).

-- Nieskonczone runy, potiony i amunicja
removeChargesFromRunes = false
removeChargesFromPotions = false
removeWeaponAmmunition = false
removeWeaponCharges = false

-- Szybki atak: 4.0 = cztery razy szybciej niz standard (atak co 0,5 s zamiast co 2 s)
rateAttackSpeed = 4.0
classicAttackSpeed = true

-- Darmowe konto premium dla wszystkich
freePremium = true

-- Mnozniki. Exp idzie progami z pliku scripts/ots/stages.lua (tam tez skille x100 i magic x90);
-- rateSkill i rateMagic ponizej sa tylko wartoscia zapasowa.
rateUseStages = true
rateLoot = 10
rateSpawn = 15
rateSkill = 100
rateMagic = 90

-- Wheel of Destiny: punkty za kazdy poziom
wheelPointsPerLevel = 100

-- Czary bez nauki: wszystkie dostepne od swojego normalnego poziomu
toggleLearnSpells = false

-- Loot pouch (Gold Pouch ze sklepu): miesci 20000 przedmiotow i przyjmuje dowolne rzeczy
lootPouchMaxLimit = 20000
toggleGoldPouchAllowAnything = true
