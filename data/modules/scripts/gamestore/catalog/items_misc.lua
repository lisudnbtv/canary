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
	},
}
