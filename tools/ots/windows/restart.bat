@echo off
cd /d C:\OTS\canary\docker
set MAPA=C:\OTS\canary\data-otservbr-global\world\otservbr.otbm
if exist "%MAPA%\" rmdir "%MAPA%"
if not exist "%MAPA%" (
  echo Kopiuje mape z serwera na dysk - jednorazowo...
  docker compose cp server:/canary/data-otservbr-global/world/otservbr.otbm "%MAPA%"
)
if not exist "%MAPA%" (
  echo Mapa jeszcze sie pobiera w kontenerze. Odczekaj minute i uruchom restart.bat ponownie.
  pause
  exit /b
)
rem OTS: przed restartem serwer zapisuje gre (postacie, domy), a potem robimy kopie bazy.
rem Kopie: C:\OTS\backup\auto_RRRR-MM-DD_GG-MM.sql, trzymamy 15 najnowszych.
echo Zapisuje gre przed restartem...
docker compose exec -T server bash -c "kill -USR1 $(pidof canary 2>/dev/null || pgrep -x canary)" >nul 2>&1
timeout /t 8 /nobreak >nul
if not exist C:\OTS\backup mkdir C:\OTS\backup
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm"') do set TS=%%i
echo Kopia bazy: C:\OTS\backup\auto_%TS%.sql
docker compose exec -T db mariadb-dump -ucanary -pcanary --single-transaction canary > "C:\OTS\backup\auto_%TS%.sql"
powershell -NoProfile -Command "Get-ChildItem 'C:\OTS\backup\auto_*.sql' | Sort-Object LastWriteTime -Descending | Select-Object -Skip 15 | Remove-Item -Force"
echo Restartuje serwer gry...
docker compose up -d --force-recreate server
docker compose up -d myaac
echo Czekam 30 sekund na start...
timeout /t 30 /nobreak >nul
(
echo ==== %date% %time% ====
docker compose ps
echo ==== SERVER ====
docker compose logs --tail 400 server
echo ==== MYAAC ====
docker compose logs --tail 30 myaac
) > C:\OTS\status.txt 2>&1
echo Gotowe - zapisano C:\OTS\status.txt
echo.
findstr /i /c:"[error]" C:\OTS\status.txt >nul
if errorlevel 1 (
  echo Start bez bledow.
  timeout /t 3 >nul
) else (
  echo UWAGA - serwer zglosil bledy przy starcie:
  findstr /i /c:"[error]" C:\OTS\status.txt
  echo.
  echo Przekaz to Claude albo napisz "gotowe" - odczyta je sam.
  pause
)
