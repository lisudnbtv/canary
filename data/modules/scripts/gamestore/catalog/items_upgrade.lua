-- OTS: sklep > Przedmioty > Upgrade (kamienie ulepszen)
return {
	icons = { "Category_Extras.png" },
	name = "Upgrade",
	parent = "Przedmioty",
	rookgaard = true,
	state = GameStore.States.STATE_NONE,
	offers = {
		{
			-- OTS: kamien ulepszen (skrypt: data-otservbr-global/scripts/ots/upgrades.lua)
			icons = { "Gold_Converter.png" },
			name = "Upgrade Stone",
			price = 100,
			itemtype = 20139,
			count = 1,
			movable = true,
			description = "<i>Upgrades an item by one level (up to +10).</i>\n\n{character}\n{storeinbox}\n{useicon} use it on an item in your backpack or equipment\n{info} a failed attempt only uses up the stone",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: kamien ulepszen (skrypt: data-otservbr-global/scripts/ots/upgrades.lua)
			icons = { "Gold_Converter.png" },
			name = "5x Upgrade Stone",
			price = 500,
			itemtype = 20139,
			count = 5,
			movable = true,
			description = "<i>Upgrades an item by one level (up to +10).</i>\n\n{character}\n{storeinbox}\n{useicon} use it on an item in your backpack or equipment\n{info} a failed attempt only uses up the stone",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: kamien ulepszen (skrypt: data-otservbr-global/scripts/ots/upgrades.lua)
			icons = { "Gold_Converter.png" },
			name = "10x Upgrade Stone",
			price = 1000,
			itemtype = 20139,
			count = 10,
			movable = true,
			description = "<i>Upgrades an item by one level (up to +10).</i>\n\n{character}\n{storeinbox}\n{useicon} use it on an item in your backpack or equipment\n{info} a failed attempt only uses up the stone",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: kamien ulepszen (skrypt: data-otservbr-global/scripts/ots/upgrades.lua)
			icons = { "Gold_Converter.png" },
			name = "25x Upgrade Stone",
			price = 2500,
			itemtype = 20139,
			count = 25,
			movable = true,
			description = "<i>Upgrades an item by one level (up to +10).</i>\n\n{character}\n{storeinbox}\n{useicon} use it on an item in your backpack or equipment\n{info} a failed attempt only uses up the stone",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
		{
			-- OTS: blessed upgrade stone (zawsze udane +1)
			icons = { "Gold_Converter.png" },
			name = "Blessed Upgrade Stone",
			price = 1000,
			itemtype = 20138,
			count = 1,
			movable = true,
			description = "<i>Upgrades an item by one level - always succeeds (also weapons and +6 to +10).</i>\n\n{character}\n{storeinbox}\n{useicon} use it on an item in your backpack or equipment",
			type = GameStore.OfferTypes.OFFER_TYPE_ITEM,
		},
	},
}
