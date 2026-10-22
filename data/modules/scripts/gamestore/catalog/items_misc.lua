-- OTS: sklep > Przedmioty > Rozne (wlasne przedmioty serwera)
return {
	icons = { "ots_cat_items_misc.png" },
	name = "Rozne",
	parent = "Przedmioty",
	rookgaard = true,
	state = GameStore.States.STATE_NONE,
	offers = {
		{
			-- OTS: plecak 100 slotow z bonusami jak z imbu (skrypt: data-otservbr-global/scripts/ots/imbued_backpack.lua)
			icons = { "Gold_Converter.png" },
			name = "Imbued Backpack",
			price = 3000,
			itemtype = 3253,
			count = 1,
			movable = true,
			description = "<i>A backpack with 100 slots.</i>\n\n{character}\n{storeinbox}\n{info} worn in the backpack slot: life leech 5%, mana leech 3%, critical 5% (+25%), +10% speed",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: lampa na slot amunicji z 3 slotami na imbu (items.xml: 16095)
			icons = { "Gold_Converter.png" },
			name = "Imbued Crystal Lamp",
			price = 2000,
			itemtype = 16095,
			count = 1,
			movable = true,
			description = "<i>A lamp for the arrow slot.</i>\n\n{character}\n{storeinbox}\n{info} worn: +10 shielding, +10% speed, +10% capacity",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: +25% odpornosci na wszystko i 3 sloty imbu (items.xml: 22746)
			icons = { "Gold_Converter.png" },
			name = "Amulet of Resistance",
			price = 3000,
			itemtype = 22746,
			count = 1,
			movable = true,
			description = "<i>An amulet with +25% protection against all damage.</i>\n\n{character}\n{storeinbox}\n{info} worn: life leech 5%, mana leech 3%, critical 5% (+25%)",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: +25% odpornosci na wszystko i 3 sloty imbu (items.xml: 34080)
			icons = { "Gold_Converter.png" },
			name = "Ring of Resistance",
			price = 3000,
			itemtype = 34080,
			count = 1,
			movable = true,
			description = "<i>A ring with +25% protection against all damage.</i>\n\n{character}\n{storeinbox}\n{info} worn: +3 to all skills and magic level",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: teleport do swiatyni w Thais (skrypt: data-otservbr-global/scripts/ots/temple_compass.lua)
			icons = { "Temple_Teleport.png" },
			name = "Thais Teleport Compass",
			price = 1500,
			itemtype = 29292,
			count = 1,
			movable = true,
			description = "<i>Teleports you instantly to the temple of Thais.</i>\n\n{character}\n{storeinbox}\n{once}\n{useicon} use it to teleport to the temple of Thais\n{info} unlimited uses, works anywhere, also outside protection zones and during a fight",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM_UNIQUE,
		},
		{
			-- OTS: pelna stamina (skrypt: data-otservbr-global/scripts/ots/stamina_refill.lua)
			icons = { "Stamina_Extension.png" },
			name = "Full Stamina Refill",
			price = 500,
			itemtype = 18992,
			count = 1,
			movable = true,
			description = "<i>Restores your stamina to the full 42 hours.</i>\n\n{character}\n{storeinbox}\n{useicon} use it to refill your stamina completely\n{info} single use",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: lup z bossow prosto do loot poucha (skrypt: data-otservbr-global/scripts/ots/reward_collector.lua)
			icons = { "Gold_Converter.png" },
			name = "Boss Loot Collector",
			price = 5000,
			itemtype = 9212,
			count = 1,
			movable = true,
			description = "<i>All boss loot from your reward chest goes straight into your loot pouch.</i>\n\n{character}\n{storeinbox}\n{useicon} use it once to unlock it permanently\n{info} works after every boss kill, on login and with !bossloot",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: czyszczenie loot poucha z rzeczy nie do sprzedania (skrypt: data-otservbr-global/scripts/ots/commands.lua)
			icons = { "Gold_Converter.png" },
			name = "Clean Loot Pouch",
			price = 500,
			itemtype = 60105,
			count = 1,
			movable = true,
			description = "<i>Deletes everything from your loot pouch that the Loot Seller does not buy.</i>\n\n{character}\n{storeinbox}\n{useicon} use it, confirm, done - reusable\n{info} keeps coins, containers, upgrade stones, reward bags and upgraded items",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: wieczne jedzenie (skrypt: data-otservbr-global/scripts/ots/infinite_food.lua)
			icons = { "Party_Cake.png" },
			name = "Infinite Food",
			price = 50,
			itemtype = 6279,
			count = 1,
			movable = true,
			description = "<i>A cake that never runs out.</i>\n\n{character}\n{storeinbox}\n{once}\n{useicon} use it to regenerate 250 hit points and 250 mana every second for 10 minutes\n{info} it is not consumed and can be used again at any time",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM_UNIQUE,
		},
		{
			icons = { "Gold_Pouch.png" },
			name = "Gold Pouch",
			price = 900,
			itemtype = 23721,
			count = 1,
			description = "<i>Carries as many gold, platinum or crystal coins as your capacity allows, however, no other items.</i>\n\n{character}\n{storeinbox}\n{once}\n{useicon} use it to open it\n{info} always placed on the first position of your Store inbox",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM_UNIQUE,
		},
	},
}
