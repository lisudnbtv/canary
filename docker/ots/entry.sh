#!/bin/bash
# OTS: dopisuje wlasne ustawienia na koniec config.lua, a potem uruchamia zwykly start serwera.
# config.lua to kod Lua, wiec pozniejsze przypisanie nadpisuje wczesniejsze;
# oryginalny start.sh zmienia tylko swoje linie i reszte pliku zostawia.
set -e
cd /canary

# usun blok z poprzedniego startu tego samego kontenera, zeby sie nie dublowal
sed -i '/^-- OTS-BEGIN$/,/^-- OTS-END$/d' config.lua
{
	echo "-- OTS-BEGIN"
	tr -d '\r' </canary/ots/config-overrides.lua
	echo "-- OTS-END"
} >>config.lua

exec /canary/start.sh "$@"
