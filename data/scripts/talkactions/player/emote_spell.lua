-- OTS: czary jako emote (pomaranczowy tekst) sa wlaczone na stale dla kazdej postaci.
-- Komenda !emote zostaje tylko po to, zeby o tym poinformowac - nie da sie tego wylaczyc.
local emoteSpell = TalkAction("!emote")

function emoteSpell.onSay(player, words, param)
	player:setStorageValue(STORAGEVALUE_EMOTE, 1)
	player:sendTextMessage(MESSAGE_LOOK, "Czary jako emote sa na tym serwerze wlaczone na stale.")
	return true
end

emoteSpell:separator(" ")
emoteSpell:groupType("normal")
emoteSpell:register()

local forceEmote = CreatureEvent("OtsForceEmoteSpells")

function forceEmote.onLogin(player)
	if player:getStorageValue(STORAGEVALUE_EMOTE) ~= 1 then
		player:setStorageValue(STORAGEVALUE_EMOTE, 1)
	end
	return true
end

forceEmote:register()
