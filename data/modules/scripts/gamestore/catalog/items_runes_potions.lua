-- OTS: sklep > Przedmioty > Runy / Poty (wlasne runy i potiony serwera)
-- Runy i potiony sie nie zuzywaja, wiec kazda oferta to jedna sztuka.
return {
	icons = { "ots_cat_items_runes_potions.png" },
	name = "Runy / Poty",
	parent = "Przedmioty",
	rookgaard = true,
	state = GameStore.States.STATE_NONE,
	offers = {
		{
			-- OTS: wlasna runa (skrypt: data-otservbr-global/scripts/ots/elemental_rune.lua)
			icons = { "Elemental_Storm_Rune.png" },
			name = "Elemental Storm Rune",
			price = 5000,
			itemtype = 60101,
			count = 1,
			description = "{character}\n{storeinbox}\n{battlesign}\n{capacity}\n\n<i>Used like an avalanche rune, but explodes in a huge area (like an ultimate explosion) and hits every creature with fire, ice, energy, earth, death, holy and physical damage at once - no monster resists it all.</i>\n{info} for every vocation from level 2500\n{info} runes are unlimited on this server - one rune lasts forever",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: wlasny potion dla sorcererow i druidow (skrypt: data-otservbr-global/scripts/ots/arcane_potion.lua)
			icons = { "Ultimate_Mana_Potion.png" },
			name = "Ultimate Arcane Potion",
			price = 100,
			itemtype = 60102,
			count = 1,
			description = "<i>Restores 500-700 hit points and 900-1100 mana at once - the spirit potion for sorcerers and druids.</i>\n\n{character}\n{storeinbox}\n{battlesign}\n{capacity}\n{info} sorcerers and druids from level 130\n{info} potions are unlimited on this server - one potion lasts forever",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: wlasny potion dla knightow i monkow (skrypt: data-otservbr-global/scripts/ots/arcane_potion.lua)
			icons = { "Ultimate_Health_Potion.png" },
			name = "Ultimate Warrior Potion",
			price = 100,
			itemtype = 60103,
			count = 1,
			description = "<i>Restores 1100-1400 hit points and 300-400 mana at once - the spirit potion for knights and monks.</i>\n\n{character}\n{storeinbox}\n{battlesign}\n{capacity}\n{info} knights and monks from level 130\n{info} potions are unlimited on this server - one potion lasts forever",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: wlasny potion dla paladynow (skrypt: data-otservbr-global/scripts/ots/arcane_potion.lua)
			icons = { "Ultimate_Spirit_Potion.png" },
			name = "Ultimate Hunter Potion",
			price = 100,
			itemtype = 60104,
			count = 1,
			description = "<i>Restores 800-1000 hit points and 600-800 mana at once - a stronger spirit potion for paladins.</i>\n\n{character}\n{storeinbox}\n{battlesign}\n{capacity}\n{info} paladins from level 130\n{info} potions are unlimited on this server - one potion lasts forever",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
	},
}
