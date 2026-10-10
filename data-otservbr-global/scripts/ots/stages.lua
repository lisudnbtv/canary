-- OTS: progi doswiadczenia (exp stages) oraz stale mnozniki skilli i magic level.
-- Nadpisuje tabele z data/stages.lua. Wymaga rateUseStages = true w ustawieniach serwera.

experienceStages = {
	{ minlevel = 1, maxlevel = 100, multiplier = 9999 },
	{ minlevel = 101, maxlevel = 500, multiplier = 6000 },
	{ minlevel = 501, maxlevel = 1000, multiplier = 4000 },
	{ minlevel = 1001, maxlevel = 1500, multiplier = 2000 },
	{ minlevel = 1501, maxlevel = 2000, multiplier = 800 },
	{ minlevel = 2001, maxlevel = 2500, multiplier = 500 },
	{ minlevel = 2501, multiplier = 250 },
}

-- Skille: x250 na kazdym poziomie umiejetnosci
skillsStages = {
	{ minlevel = 0, multiplier = 250 },
}

-- Magic level: x200 na kazdym poziomie
magicLevelStages = {
	{ minlevel = 0, multiplier = 200 },
}
