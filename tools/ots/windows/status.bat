@echo off
cd /d C:\OTS\canary\docker
(
echo ==== %date% %time% ====
docker compose ps
echo ==== SERVER ====
docker compose logs --tail 1500 server
echo ==== LOGIN-SERVER ====
docker compose logs --tail 30 login-server
echo ==== MYAAC ====
docker compose logs --tail 40 myaac
) > C:\OTS\status.txt 2>&1
rem OTS: pelny log serwera od startu (do szukania przyczyn rozlaczen w nocy)
docker compose logs --timestamps server > C:\OTS\status_full.txt 2>&1
echo Gotowe - zapisano C:\OTS\status.txt i C:\OTS\status_full.txt
timeout /t 3 >nul
