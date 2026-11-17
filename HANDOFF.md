# HANDOFF — 2026-11-16

## Точный запрос

«Ну давай качай все нужные инструменты и начинай деобфускацию». Конкретный
скрипт/игра названы не были. Сделана общая часть полностью: тулчейн развёрнут,
проверен end-to-end на реальных обфусцированных сэмплах, один результат положен
в `results/`. Открытый вопрос — какой артефакт деобфусцировать дальше.

## Измеренные факты против предположений

Полная таблица прогонов, синтаксис-проверок и непроверенных атрибуций —
`deobf-report/VALIDATION.md`. Версии и коммиты с тегами происхождения —
`deobf-report/tools/toolchain.json`.

Измерено: `install_tools.sh` с чистого состояния (`bin/luau`, `bin/luau-ast`
и объекты Luau удалены) → `rc=0`, `INSTALL_OK`; повторный запуск → `rc=0`.
Luraph v15 `RideAPet.lua` → 112 939 B / 5 170 строк, diff с эталоном пустой.
`5ae248d6527b5c01.lua` → `print("hello")`, diff пустой. `unprom` на своём
эталоне → diff пустой. PSU `fastfarmjinsl2.lua` → 72 строки, чанк `LOAD_OK`.
IronBrew `Anti_AFK.lua` напрямую → 48 строк, `LOAD_OK`. MoonSec V2 → 1 118 строк
(валидный Luau, не Lua 5.1). MoonSec V3 → 4 753 строки, но чанк не грузится,
в исходнике 5 `goto lbl_*`: рабочим результатом не считается.

Не проверено: атрибуции Luraph v14.x / MoonVeil v1.4.5 / Synapse Xen 1.1.2 /
Luraph 6/11.x (из `REPORT.md` 2026-10-28), `0x251/Prometheus-Deobfuscator`
на Python 3.12, `luau-vmp-deobf` (нет Lune), `axomtools/ironbrew2-deobfuscator`,
любое поведение в рантайме Roblox.

## Файлы и точки входа

- `deobf-report/tools/install_tools.sh` — установка, `--with-corpus` докачивает сэмплы.
- `deobf-report/tools/apply_patches.py` — патчи (идемпотентно).
- `deobf-report/tools/toolchain.json` — версии/коммиты/сигнатуры/gaps.
- `deobf-report/tools/build_luau.sh`, `build_ast.sh` — сборка `bin/luau*`.
- `deobf-report/tools/pipeline.py` — детект → деобфускатор → ремонт чанка →
  `unluac` → `PARTS.md`; запускать с `--tools-root /home/user/deobf/work`.
- `deobf-report/results/corpus/luraph_v15_rideapet/` — новый результат.
- `deobf-report/VALIDATION.md` — отчёт по сессии.
- Всё скачанное/собранное — в `work/` (gitignored).

## Собрано и протестировано (команды, коды выхода)

```bash
bash deobf-report/tools/install_tools.sh          # rc=0 (чистая пересборка)
bash deobf-report/tools/install_tools.sh          # rc=0 (повторно)
python3 -m py_compile deobf-report/tools/*.py     # rc=0
bash -n deobf-report/tools/install_tools.sh ...   # rc=0
python3 deobf-report/tools/rebuild_index.py --results deobf-report/results \
  -o deobf-report/results/INDEX.md                # rc=0, 62 сэмпла
python3 deobf-report/tools/pipeline.py <файл> --out <dir> \
  --tools-root /home/user/deobf/work -v           # см. таблицу в VALIDATION.md
```

Проверки синтаксиса: `work/lua51/lua -e "loadfile(...)"` (Lua 5.1.1) и
`work/luraph15/Deobfuscator-Luraph-V15-master/bin/luau-ast <файл>` (Luau 0.744).
Проверка чанка: `loadfile` на `.luac` после `lua51_repair.py` / `luac_fix.py`
/ `luac32to64.py`.

## Следующий проверяемый шаг

Получить файл или ссылку на целевой защищённый скрипт + игру/режим. Затем:

```bash
python3 deobf-report/tools/pipeline.py <файл.lua> \
  --out deobf-report/results/<игра>/<сэмпл> \
  --tools-root /home/user/deobf/work -v
```

После прогона: `loadfile` в Lua 5.1.1, `luau-ast`, `PARTS.md`, пересборка
`INDEX.md`. Если `detect()` вернёт `unknown` — сверить заголовок с `MARKERS`
в `pipeline.py` и `toolchain.json`, не угадывать версию. Для IronBrew при
отказе `do_cascade()` использовать прямой путь CASCADE → `luac_fix.py` →
`luac32to64.py` → `loadfile` → `unluac`.

Секретов, токенов и ключей в этом файле нет; найденные в скриптах URL лежат
в соответствующих `PARTS.md` и здесь не дублируются.
