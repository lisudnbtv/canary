-- OTS: sklep > Przedmioty > Rozne (wlasne przedmioty serwera)
return {
	icons = { "Category_Extras.png" },
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
	},
}
