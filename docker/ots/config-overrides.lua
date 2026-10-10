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

-- Mnozniki. Exp idzie progami z pliku scripts/ots/stages.lua (tam tez skille x250 i magic x200);
-- rateSkill i rateMagic ponizej sa tylko wartoscia zapasowa.
rateUseStages = true
rateLoot = 10
rateSpawn = 15
rateSkill = 250
rateMagic = 200

-- Wheel of Destiny: punkty za kazdy poziom
wheelPointsPerLevel = 100

-- Czary bez nauki: wszystkie dostepne od swojego normalnego poziomu
toggleLearnSpells = false

-- Loot pouch (Gold Pouch ze sklepu): miesci 20000 przedmiotow i przyjmuje dowolne rzeczy
lootPouchMaxLimit = 20000
toggleGoldPouchAllowAnything = true

-- Autoloot (!autoloot all/on/off) i zloto z potworow od razu na konto w banku
autoLoot = true
autoBank = true

-- Maszyna do imbu dziala bez questa Forgotten Knowledge
toggleImbuementShrineStorage = false

-- Exhaust czarow: wszystkie cooldowny dzielone przez 2 (2 s -> 1 s). Wyzsza wartosc nie ma sensu:
-- ten sam mnoznik przyspiesza tiki buffow regeneracji i przy bardzo duzej wartosci spadlyby do zera.
rateSpellCooldown = 2.0

-- Komenda !emote on/off (czary jako emote zamiast tekstu)
emoteSpells = true
