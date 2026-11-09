-- OTS: progi doswiadczenia (exp stages) oraz stale mnozniki skilli i magic level.
-- Nadpisuje tabele z data/stages.lua. Wymaga rateUseStages = true w ustawieniach serwera.

experienceStages = {
	{ minlevel = 1, maxlevel = 100, multiplier = 9999 },
	{ minlevel = 101, maxlevel = 500, multiplier = 6000 },
	{ minlevel = 501, maxlevel = 1000, multiplier = 4000 },
	{ minlevel = 1001, maxlevel = 1500, multiplier = 2000 },
	{ minlevel = 1501, maxlevel = 2000, multiplier = 800 },
	{ minlevel = 2001, maxlevel = 2500, multiplier = 500 },
	{ minlevel = 2501, maxlevel = 3500, multiplier = 250 },
	{ minlevel = 3501, maxlevel = 4500, multiplier = 200 },
	-- od 4500 (mocne czary "ultima") exp mocno zwalnia
	{ minlevel = 4501, maxlevel = 5000, multiplier = 120 },
	{ minlevel = 5001, maxlevel = 6000, multiplier = 80 },
	{ minlevel = 6001, maxlevel = 7000, multiplier = 50 },
	{ minlevel = 7001, maxlevel = 8000, multiplier = 30 },
	{ minlevel = 8001, maxlevel = 9000, multiplier = 20 },
	{ minlevel = 9001, maxlevel = 10000, multiplier = 12 },
	{ minlevel = 10001, multiplier = 8 },
}

-- Skille: x250 na kazdym poziomie umiejetnosci
skillsStages = {
	{ minlevel = 0, multiplier = 250 },
}

-- Magic level: x200 na kazdym poziomie
magicLevelStages = {
	{ minlevel = 0, multiplier = 200 },
}
