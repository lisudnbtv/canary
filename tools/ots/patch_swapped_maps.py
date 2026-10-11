"""Dopisuje PZ z pz_targets.json do kawalkow mapy, ktore silnik wczytuje w trakcie gry
(Game.loadMap w questach). Bez tego podmiana kawalka kasuje PZ wpisane w glowna mape.
Uruchamiac z katalogu repo po kazdej zmianie pz_targets.json:
    python3 tools/ots/patch_swapped_maps.py
Wypisuje pliki, w ktorych cos zmienil - kazdy taki plik trzeba dodac do docker-compose.override.yml."""
import glob, os, subprocess, sys

here = os.path.dirname(os.path.abspath(__file__))
targets = os.path.join(here, 'pz_targets.json')
changed = []
for path in sorted(glob.glob('data-otservbr-global/world/**/*.otbm', recursive=True)):
    name = os.path.basename(path)
    if name == 'otservbr.otbm' or name.startswith('ots-') or os.path.getsize(path) < 1024:
        continue
    out = subprocess.run([sys.executable, os.path.join(here, 'patch_pz.py'), path, targets], capture_output=True, text=True).stdout
    backup = path + '.orig'
    if os.path.exists(backup):
        os.remove(backup)
    if 'zapisano' in out:
        changed.append(path)
print('zmienione pliki:', changed or 'brak')
