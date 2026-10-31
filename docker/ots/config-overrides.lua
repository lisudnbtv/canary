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

-- Exhaust czarow ustawia skrypt scripts/ots/spell_cooldown.lua (kazdy czar najwyzej 1 s); mnoznik zostaje 1.
rateSpellCooldown = 1.0

-- Komenda !emote on/off (czary jako emote zamiast tekstu)
emoteSpells = true

-- Domki: zakup komenda !buyhouse (stojac przed drzwiami), 1 gp za kratke, na stale bez czynszu
toggleCyclopediaHouseAuction = false
housePriceEachSQM = 1
houseRentPeriod = "never"
houseBuyLevel = 0
houseLoseAfterInactivity = 0

-- Zapis serwera co 30 min, przy okazji sprzatanie przedmiotow wyrzuconych na ziemie
-- (takze w PZ, np. w depo i swiatyni; domy sa pomijane, przedmioty z mapy zostaja)
toggleSaveInterval = true
saveIntervalType = "minute"
saveIntervalTime = 30
toggleSaveIntervalCleanMap = true
cleanProtectionZones = true

-- Trening na manekinie: ciosy cztery razy czesciej niz zwykly (szybki) atak
rateExerciseTrainingSpeed = rateAttackSpeed * 4

-- Ikony kategorii sklepu: klient pobiera je z tej strony (pliki w docker/ots/storeimages, serwuje je MyAAC)
coinImagesURL = "http://127.0.0.1:8080/ots-store/"

-- Kuznia: duzo wiecej potworow "kuzni" na mapie (z wykrzyknikiem i liczba 1-5, z nich pyl i gemy)
-- oraz czerwonych fiendish (zawsze greater gem). Domyslnie bylo 300 i 4 na cala mape.
forgeInfluencedLimit = 5000
forgeFiendishLimit = 50

-- Kuznia: maksymalny limit pylu (domyslnie 225); !dust podnosi limit az do tej wartosci
forgeMaxDust = 3000

-- Multi-client (MC): do 5 postaci z jednego konta naraz, wszystkie moga byc poza strefa ochronna
maxPlayersOnlinePerAccount = 5
maxPlayersOutsidePZPerAccount = 5

-- Bestiariusz: pelny loot potwora widoczny od razu (bez czekania na kolejne poziomy odblokowania)
showLootsInBestiary = true
-- familiar (utevo gran res ...): 30 min przywolania (silnik dzieli te wartosc na pol)
familiarTime = 60
-- kuznia: pyl z potwora kuzni = losowo od (stack) do (stack x ta wartosc); domyslnie 3
forgeAmountMultiplier = 10.0
-- kuznia: slivery z potworow fiendish (domyslnie 3-7)
forgeMinSlivers = 15
forgeMaxSlivers = 40
-- limit pakietow od klienta na sekunde (domyslnie 25): przy szybkim leczeniu/atakach klient byl rozlaczany
maxPacketsPerSecond = 200
