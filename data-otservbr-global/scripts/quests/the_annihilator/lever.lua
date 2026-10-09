-- OTS: Annihilator przerobiony pod jednego gracza.
-- Dzwignia dziala, gdy na polach stoi co najmniej jeden gracz (zamiast czterech),
-- i mozna jej uzywac wielokrotnie: kazde pociagniecie czysci sale i stawia potwory od nowa.
local setting = {
	-- Od jakiego poziomu mozna zrobic quest?
	requiredLevel = 100,
	centerDemonRoomPosition = { x = 33221, y = 31659, z = 13 },
	demonsPositions = {
		{ x = 33219, y = 31657, z = 13 },
		{ x = 33221, y = 31657, z = 13 },
		{ x = 33223, y = 31659, z = 13 },
		{ x = 33224, y = 31659, z = 13 },
		{ x = 33220, y = 31661, z = 13 },
		{ x = 33222, y = 31661, z = 13 },
	},
	playersPositions = {
		{ fromPos = { x = 33225, y = 31671, z = 13 }, toPos = { x = 33222, y = 31659, z = 13 } },
		{ fromPos = { x = 33224, y = 31671, z = 13 }, toPos = { x = 33221, y = 31659, z = 13 } },
		{ fromPos = { x = 33223, y = 31671, z = 13 }, toPos = { x = 33220, y = 31659, z = 13 } },
		{ fromPos = { x = 33222, y = 31671, z = 13 }, toPos = { x = 33219, y = 31659, z = 13 } },
	},
}

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Zbierz graczy stojacych na polach startowych.
	local team = {}
	for i = 1, #setting.playersPositions do
		local tile = Tile(setting.playersPositions[i].fromPos)
		local creature = tile and tile:getTopCreature()
		if creature and creature:isPlayer() then
			if creature:getLevel() < setting.requiredLevel then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wymagany poziom: " .. setting.requiredLevel .. ".")
				return true
			end
			team[#team + 1] = { creature = creature, destination = setting.playersPositions[i].toPos }
		end
	end

	if #team == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Stan na jednym z czterech pol przy dzwigni i pociagnij ja.")
		return true
	end

	if roomIsOccupied(setting.centerDemonRoomPosition, true, 4, 4) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ktos jest juz w sali walki.")
		return true
	end

	-- Usun potwory z poprzedniego podejscia.
	local leftovers = Game.getSpectators(setting.centerDemonRoomPosition, false, false, 8, 8, 6, 6)
	for _, creature in ipairs(leftovers) do
		if creature:isMonster() then
			creature:remove()
		end
	end

	for i = 1, #setting.demonsPositions do
		Game.createMonster("Angry Demon", setting.demonsPositions[i])
	end

	for i = 1, #team do
		team[i].creature:teleportTo(team[i].destination)
		Position(team[i].destination):sendMagicEffect(CONST_ME_TELEPORT)
	end

	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

lever:uid(30025)
lever:register()
