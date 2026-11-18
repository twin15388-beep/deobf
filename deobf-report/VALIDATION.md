# Восстановление тулчейна и первая деобфускация (2026-11-16)

Запрос: «скачать все нужные инструменты и начать деобфускацию». Цель script/game
названа не была, поэтому общая часть сделана полностью: тулчейн развёрнут,
проверен на реальных обфусцированных сэмплах с эталонами, один результат
положен в `results/`. Дальше нужен конкретный артефакт от пользователя.

## 1. Что сделано (файлы)

| Файл | Что это |
|---|---|
| `tools/install_tools.sh` | Идемпотентный установщик: 10 клонов с зафиксированными ревизиями, JRE, npm, Luau 0.744, Lua 5.1.1, патчи, проверка входных точек. `--with-corpus` докачивает три корпуса сэмплов. |
| `tools/apply_patches.py` | Патчи из `PATCHES.md` §1, §2, §9 на скачанные инструменты; повторный запуск безопасен. |
| `tools/toolchain.json` | Единственный конфиг: версии, коммиты, сигнатуры обфускаторов с тегами `measured_on_artifact` / `from_report_unverified`, известные gaps. |
| `tools/build_luau.sh` | Убрана падающая линковка `luau-ast`; строит `bin/luau`, `rc=0`. |
| `tools/build_ast.sh` | Рабочая сборка `bin/luau-ast` (AstJsonEncoder + 2 стаба), `rc=0`. |
| `tools/PATCHES.md` | §11 с измеренными отличиями сборки и статусом axom. |
| `tools/rebuild_index.py` | Исправлен путь к `work/lua51/lua`. |
| `results/corpus/luraph_v15_rideapet/` | `script.combined.lua` (5 170 строк кода + PARTS-комментарии, sha256 исходника в combined), `LOG.txt`. |
| `results/INDEX.md`, `results/README.md` | Индекс пересобран: 62 сэмпла, 21 игра/режим. |

Всё скачанное и собранное лежит в `work/` (в `.gitignore`), репо не раздуто.

## 2. Измерено в этой сессии

**Сборка.** `bash deobf-report/tools/install_tools.sh` после удаления
`bin/luau`, `bin/luau-ast` и всех объектов Luau — `rc=0`, `INSTALL_OK`.
Проверено: `java -version` → OpenJDK 25.0.5 (jdk4py 25.0.5.0, только JRE);
`java -jar unluac.jar --help` → `unluac v1.2.3.569`;
`luau` исполняет `print("luau ok")`; `luau-ast` отдаёт JSON-дерево AST;
`lua -v` → Lua 5.1.1; `node --check` на всех пропатченных JS и
`py_compile` на `devirt_bridge.py` — без ошибок.

**Версии обфускаторов сняты с артефактов, не из отчёта:**
Luraph v15.0 (заголовок `RideAPet.lua`), PSU 4.0.A (`fastfarmjinsl2.lua`),
MoonSec V3 (`Lightux/v1.4/AllOfUsAreDead.lua`), MoonSec V2 (`BH v3.lua`),
IronBrew 2.7.2 (`Anti_AFK.lua`).

**Прогоны `pipeline.py --tools-root /home/user/deobf/work -v`:**

| Ветка | Сэмпл | rc | Результат | Lua 5.1 `loadfile` | Luau `luau-ast` |
|---|---|---:|---|---|---|
| luraph_v15 | `5ae248d6527b5c01.lua` | 0 | 15 B, `print("hello")`, diff с эталоном пустой | OK | OK |
| luraph_v15 | `RideAPet.lua` | 0 | 112 939 B / 5 170 строк, diff с эталоном пустой | FAIL (`+=`) | OK |
| psu | `fastfarmjinsl2.lua` | 0 | 1 332 B / 72 строки, чанк `LOAD_OK` | OK | OK |
| moonsec_v3 | `Lightux/v1.4/AllOfUsAreDead.lua` | 0 | 103 319 B / 4 753 строки | FAIL (`goto lbl_`) | FAIL |
| moonsec_v2 | `BritishHUB/BH v3.lua` | 0 | 39 546 B / 1 118 строк | FAIL (`continue`) | OK |
| ironbrew | `Anti_AFK.lua` через `pipeline.py` | 0 | `FAILED` (guard `No Matched Instruction`) | — | — |
| ironbrew | `Anti_AFK.lua` напрямую через CASCADE | 0 | чанк 490 B → `LOAD_OK` → 48 строк Lua | OK | OK |
| prometheus | `unprom/samples/hello.obfuscated.lua` | 0 | 123 B, diff с `hello.deobfuscated.lua` пустой | OK | OK |

MoonSec V3: чанк `extracted.luac.fixed` **не** грузится в Lua 5.1.1
(`bad code in precompiled chunk`), а исходник содержит 5 `goto lbl_*` —
этот результат рабочим не считается. Сэмпл `BloxFruit/lvllock.lua` отброшен:
начинается с `,nil,nil;`, это битый вход, а не поломка `moonsec-js-deobf`.

## 3. Предположения и непроверенное

- Атрибуции Luraph v14.x, MoonVeil v1.4.5, Synapse Xen 1.1.2, Luraph 6/11.x —
  из `REPORT.md` от 2026-10-28 и `_failed.md`, в этой сессии **не перепроверены**.
  В `toolchain.json` они помечены `from_report_unverified` с рецептом проверки.
- `0x251/Prometheus-Deobfuscator` установлен, но не запускается на Python 3.11:
  f-строки с `\` в выражении и битый литерал `vmify.py:122`. `python3.12`
  отсутствует, на 3.12 не проверено. Клон откатан к чистому состоянию.
- `luau-vmp-deobf` и `axomtools/ironbrew2-deobfuscator` распакованы/склонированы,
  но не запускались (нужны Lune и совместимый `luaparser` соответственно).
- Ни один скрипт в Roblox не запускался; рантайм-поведение не сравнивалось.
  «Работает» здесь означает только измеренные коды выхода, проверку синтаксиса
  и совпадение с эталонным выводом.

## 4. Чего не хватает и следующий шаг

Нужен конкретный артефакт: файл или ссылка на защищённый скрипт плюс игра/режим.
Без него версия обфускатора для целевого билда не измеряется.

Известные блокеры в самом тулчейне (не исправлялись, чтобы не менять поведение
`pipeline.py` без запроса):

1. `detect()` ищет текстовые маркеры только в первых 80 строках: 6 сэмплов
   `_corpus_prometheus` определяются как `unknown`. Для Prometheus/wearedevs
   нужен структурный признак (`return (function(...)` + диспетчер
   `while ... if pos < <большое число>`) или явный оверрайд.
2. `do_cascade()` отсекает валидный чанк по строке `No Matched Instruction`
   в логе CASCADE. Обходной путь измерен: CASCADE → `luac_fix.py` →
   `luac32to64.py` → `loadfile` → `unluac`.
3. MoonSec V3 после `unluac` даёт `goto lbl_*` и битый чанк; нужен либо
   `decompile_salvage.py`, либо другой декомпилятор.

Команда для продолжения:

```bash
bash deobf-report/tools/install_tools.sh --with-corpus
python3 deobf-report/tools/pipeline.py <файл.lua> \
  --out deobf-report/results/<игра>/<сэмпл> \
  --tools-root /home/user/deobf/work -v
```

## 5. Сессия 2026-11-17 — приоритетные игры (GPO, VV Ultimatum, YBA, Shindo, King Legacy, AoTR)

Статусы по измеренным фактам; «работает» = код выхода/вывод/синтаксис/эталон.
Ни один скрипт в Roblox не запускался.

### Attack on Titan Revolution (приоритет 6)
- `aotr_key.lua` (237946 B, заголовок «MoonVeil Obfuscator v1.4.5»):
  НЕ девиртуализирован. UnstableGrape/Moonveil-1.4.5-Deobfuscator 0.11.0 →
  RC=2, `error: P0.0:1576 has no FORGLOOP` (~135 с). edwindev-spec/MoonVeil
  0.13.0 (тот же движок, LUAU_PATH=bin/luau) → RC=2, то же самое сообщение.
  Nonition/MoonveilDeobfuscator 2.0.26 (target 2.0.26, другая версия) →
  RC=2, `Lua parse failed: [2:14275] '=' expected near 'elseif'`.
  binxgtl/luau-vmp-deobf (`deobf-report/tools/vendor/luau-vmp-deobf-main.zip`,
  pip -e + `work/pydeps/zstandard`): `luauvmp inspect` — восстановил спецификатор
  VM (byte_key=74, word_key=2013823922, varint_key=2489364247,
  str_prefix f9 e1 40 0c, 173/256 опкодов, 37 операций, 4 dispatch-цикла),
  но полный проход отказал: `incomplete VM spec: opcode for DECSTR,
  opcode for DECIMPORT, opcode for CALL, opcode for RETURN` → выписал
  заглушку 341 B (`recovered.deobf.lua`), НЕ деобфускация. Профиль
  moonveil-1.4.5.json из этого инструмента — для другого билда (константы
  рандомизированы per-build), не подходит без пиннинга. Артефакты:
  `work/validation/aotr_key/{run.log,fork.log,nonition.log,deobf.log,
  recovered.spec.json,recovered.deobf.lua}`.
- `aotr_tekkit.lua` (98629 B, «25ms» custom-вариант) — не разбирался дальше.
- Лоадеры (lixhub, titanic) — luarmor/key-flow, в работу не берём.

### VV Ultimatum (приоритет 2) — Centurion, 5 284 076 B
НЕ девиртуализирован. `Mova-Ult/centurion-deobfuscator fingerprint` →
`{"tag":"unknown","route":"unknown","sha8":"05f59c24cfab50a3"}`.
`gigihumana/Centurion-Deobfuscator fingerprint` (env CENT_LUAU_LUAU/_AST/_COMPILE
на `work/luraph15/.../bin/{luau,luau-ast,luau-compile}`, `bin/luau-compile`
собран из исходников Luau — официальная сборка недоступна, TLS EOF) →
тот же результат: `route:"unknown"`. klikedlua/centurion-6.3.3 — 3 файла по
1 байту (заглушка). Публичного деобфускатора этого билда нет; версия по
артефакту не названа (вероятно v6.2+ по репо-истерну al1n04ka_Loader-Code.lua,
но измеренного подтверждения нет).

### Shindo Life (приоритет 4) — обновлено 2026-11-17
- DogeHub V2 (ScriptBlox 224947): **финальный слой восстановлен и прочитан**.
  Цепочка: `NoobieDoge/DogeHubV2@Separated:ShindoLife` (44 639 B) — плейнтекстовый
  IronBrew-VM контейнер («@Ironbrew/netcoreapp2.0/out.lua», OpArg-перетасовка,
  контейнер распарсен на 100 %) → внешняя VM НЕ расшифровывает payload сама, а
  вызывает `game:HttpGet(«Kasep6720/Secret@DogeHubV2:Games/ShindoLife»)` +
  `loadstring()`. Черный ящик `work/sources/dogehub_sandbox.lua` (стоковый
  Lua 5.1.1 + болванки Roblox-глобалов, `bit` на чистой арифметике, перехват
  `loadstring`) подтвердил это по трассе (`work/sources/dogehub_trace.log`).
  Файл по URL скачан напрямую через `gh api`: **506 964 B, 14 298 строк, обычный
  читаемый Lua (sha256 64df4361…)** — это и есть «реальный» DogeHub V2 Shindo
  (UI + авто-Spin REL Bloodline, Bloodline/Element/RC-Shop changers, No CD
  Method, выбор устройства, логгер). Обфускации в финальном файле нет
  (маркеры `L<d>_<d>` = 0, `loadfile` OK для всех 13 файлов цепочки).
  Восстановлено в `results/shindo_life/dogehub_v2_shindo/recovered/`
  (+ `RECOVERY.md`, `SHA256SUMS`): основной payload, ChooseUrDevice,
  ShindoSpinRecords, AutoSpinRELL обёртка (проверка `GameId==1511883870`),
  Project Bullshit Rebooted (100 591 B, plain), страницы Bloodline/RCShop
  changer (plain), UserLogs.
  НЕ восстановлено (честно): IronBrew-VM тела Bloodline/RCShop changers и
  AutoSpin-RELL remote (`ShindoLifeAutoSpinRELLBloodline`, 18 166 B),
  AztupBrew V2.7.2 «No CD Method» (221 422 B, HDTerebi) — девиртуализатора под
  эти билды нет; тела не разбирались. Рантайм в Roblox не проверялся.
  Внимание: `mod_userlogs.lua` постит вебхук → пользователь предупреждён в
  RECOVERY.md; вебхук не вызывался.
- No Key Open Source (ScriptBlox 239695): inline plaintext (~2 КБ), прочитан:
  авто-Spin для Bloodline/Element (`startevent:FireServer("spin", ...)`),
  библиотека `wall v3` через HttpGet. Обфускации нет, «деобфусцировать» нечего.

### YBA (приоритет 3)
- MethionV2 («DUMPED», ScriptBlox 234461) → тот же raw GitHub
  (brawler-567/DecompiledRepo) — репозиторий 404 (удалён/переименован),
  оба файла 404, деобфусцировать нечего.
- MonHub (ScriptBlox 230405, keyless) → `api.jnkie.com/.../download` —
  HTTP 000 (хост недоступен из сети sandbox), не скачать.
- ScriptBlox API (`/api/script/search?q=yba&max=10`): все результаты —
  loadstring + key/keyless-хабы; inline-тел нет.

### King Legacy (приоритет 5)
- Lumin Hub (keyless, ScriptBlox 236263) → scriptblox raw =
  `loadstring(game:HttpGet("http://luminon.top/loader.lua"))()` — сервер мёртв
  (HTTP 500). Остальные результаты — ключ-хабы; inline-тел нет.
- hexahigh-корпус по имени игры: DQFuckerv1.2/dragon quest/Doge Simulator/
  RB World 3/Strucid — все Synapse Xen (PSU), detect → unknown;
  AoTR-совпадений — Synapse Xen/PSU, готовых к девиртуализации нет.

### Grand Piece Online (приоритет 1)
- AETHERIS HUB (ScriptBlox 231579) → `luarmor.net/files/v4/loaders/
  b10406e69f4ce98a9f6a9342cc42511d.lua` — luarmor-лоадер (не inline-тело),
  по правилам сеанса не девиртуализируем.
- Остальные результаты ScriptBlox — ключ-хабы; inline-тел нет.

### Собранный в сессии инструмент (персистентный)
`deobf-report/tools/build_compile.sh` — сборка `bin/luau-compile` из исходников
Luau (CodeGen → `work/luau-build/codegen-obj/`, линковка с `obj/*.o` минус
`luau_runner.o`). `bin/luau-compile` проверен (`--help` печатает modes).
`bin/luau` и `bin/luau-ast` уже были; `bin/luau-compile` в install_tools.sh
НЕ прописан (install_tools.sh не трогал) — только build_compile.sh.

## §6 Фаза 2 (2026-11-18): «другие режимы» — что реально найдено и где честные границы

### Новые сэмплы (публичные репозитории, содержимое взято как есть)
- **99_nights_in_the_forest / voidware_loader** — цепочка plain-загрузчиков VoidWare:
  `exploiters-scripts/99NightsInTheForest-Script` → файл `VoidWare` (точка входа,
  анти-debug, executor-blacklist, queue_on_teleport/isnetworkowner shims), затем
  `VapeVoidware/VW-Add@main`: `loader.lua` → `loader2.lua` (GameId-реестр:
  2619619496 Bedwars, 7008097940 Ink Game [no], 6331902150 Forsaken, 7326934954
  99 Nights), `nightsintheforest.lua` → `nightsintheforest2.lua` (автовыбор).
  Все 5 файлов сшиты в `script.combined.lua` дословно с URL-комментариями
  (Sha: `f41fda250055…`). **Финальная полезная нагрузка Luraph v14.7
  (`newnightsintheforest.lua`, 1 115 831 B) НЕ деобфусцирована и НЕ в репо.**
- **bedwars / voidware_6872274481** — `VapeVoidware/VWRewrite@main:games/6872274481.lua`,
  дословно (406 311 B; 12 262 строки читаемого кода): TP, ESP/chams,
  `FireServer`-вызовы, GUI; HIGHEST-confidence "читаемый код", но механика только
  инвентаризована, не запускалась. Sha: `d242c87daae9…`.
- Сопутствующие plain-файлы того же репо (`MainScript.lua` 98 140 B,
  `games/universal.lua` 262 056 B, `libraries/vm.lua` Fiu MIT, `guis/*`) в репозиторий
  НЕ скопированы: повторили бы уже покрытое; адресуемы по тому же репо (`gh api
  repos/VapeVoidware/VWRewrite/contents/...`).

### Попытка девиртуализации Luraph v14-файлов (honest outcome)
- Инструмент: vendored `tools/vendor/Deobfuscator-Luraph-V15-master.zip` →
  `work/luraph15/`, `bin/luau-ast` собран из luau 0.744 (`tools/build_ast.sh`).
- Входы: `vw_newforsaken.lua` (Luraph v14.4.1, 282 KB),
  `vw_newinkgame.lua` (v14.4.2, 535 KB), `vw_newnightsintheforest.lua`
  (v14.7, 1.1 MB) — все задетектированы как `luraph_v14` (0.50–1.00).
- Результат: **все три «успешно завершены», но результат — НАБЛЮДАТЕЛЬНЫЙ ТРЕЙС
  (behaviour trace), не восстановленный код** («attempt to index nil with
  'Options'» / «Main Failure with loading Library!»). Персистентные артефакты
  лежат в `work/results/` (вне репозитория), в таблицу в репо НЕ включены как
  «восстановленное». Никаких вымышленных feature-списков не приводится.
- `forsaken`/`inkgame` partial outputs (`work/results/vw_new*.deobf.lua`)
  содержат ~20 строк инициализации (флаги `shared.VoidwareForsaken`, запрос
  `VWUpdateLog`, выбор Obsidian-библиотеки) — не полезная нагрузка.

### Lua 5.1.1 vs Luau AST (переизмерено на всех 65 файлах)
- Lua 5.1.1 `loadfile`: **34 OK / 31 FAIL** (FAIL = Luau-диалект:
  `continue`/`+=`/backtick-строки, либо артефакты unluac: >200 locals / too complex).
- Luau AST (`bin/luau-ast`, Luau 0.744): **58 OK / 7 FAIL** (FAIL = лимиты парсинга
  «Reached error limit (100)» в bloxburg/autobuild, gacha_online/hub,
  ironbrew_cascade/_script_hub, corpus/psu_small, king_legacy/KL_psu40_*).
- Ни один файл не исполнялся в Roblox; «OK» = только синтаксис/парс.

### Границы
- Ни один файл из этой фазы не является «подтверждённо работающей в игре сборкой».
- Внешние серверы (`projectabyss.lol`, `luminon.top`, `api.jnkie.com`) мертвы
  или недоступны — загрузочные хабы, зависящие от них, нефункциональны (факт, не догадка).
- Инструменты: `rebuild_index.py` расширен разбором причин FAIL-статуса
  (backtick/continue/goto/артефакт); `build_luau.sh`/`build_ast.sh`/`luau_runner.cpp`
  — из фазы 1 (сборка `bin/luau`/`bin/luau-ast` из luau-src 0.744).

## §6.1 Фаза 3 (2026-11-18): Blade Ball / Steal-a-Brainrot / 99 Nights — новые находки и отрицательные результаты

### Каталог пополнили
- **lifting_guccis_farm / inquisitor_hub** — `gzyomi/Inquisitor-HUB` → файл
  `AllusiveBladeBallScript` (имя чужое): plain Gui-to-Lua v3.2, GUI «Gucci's Farm»
  (лифтинг-игра): кнопки EquipDW/LiftDW (авто-активация «Double Weight»), удаление
  HUD-кадров, Anti-Afk (VirtualUser). Нет обращений к сети/HttpGet. Lua 5.1 **OK**,
  Luau AST **OK**. В Roblox не запускался; имена объектов привязаны к клиенту.

### Отрицательные результаты (инструментально подтверждены)
- `Oussama-008/BladeBallScripts/AutoParry.lua` (4 280 B, plain Lua): парсится
  (lua51 OK, luau-ast OK), **но функционально сломан**: обработчики кликания
  вызывают `AutoParry()`/`AutoSpam()`, которые объявлены ниже как
  `local function` → в момент клика это вызов несуществующего глобального значения →
  «attempt to call a nil value»; фичи не запускаются. Дальше —
  `ReplicatedStorage.Events.Parry`, проверка имени части `Ball` — имена
  неподтверждённые. В каталог НЕ включён.
- `OfficialNebula/BladeBallScript` (moonsec_v3; `main.lua` 154 KB, `library.lua`
  350 KB, репо публичный, starred): разобран штатной связкой
  `moonsec-js-deobf` (namespace `work/moonsec-js-deobf`) → unluac. **Это вредоносный
  лут.** Деобфусцированный `main.lua` (644 B): задаёт в `_G` `Usernames`
  (whitelist из 3 ников), `min_rap = 100`, `pingEveryone = "Yes"`,
  **жёстко заданный Discord-webhook (значение НЕ приводится, токен)**, после чего
  тянет полезную нагрузку с `raw.githubusercontent.com/script-provider/BladeBallScript/.../library.lua`.
  Частичный дамп `library.lua` (unluac упал на `Implicit return must have zero values`,
  182 строки из ~сотен): гейт по PlaceId 13772394625 (Blade Ball), кик при ≥16 игроках,
  кик на VIP-серверах, проверка trade-PIN: `ReplicatedStorage...WaitForChild("Packages")` →
  `sleitnick_net@0.1.0` → `RF/ResetPINCode` с атакующим заданным PIN (жертве ставится
  известное значение), ветка `identifyexecutor() == "Delta"` → вторая ступень с
  `pastefy.app` (путь не приводится). **Сэмпл в каталог НЕ добавлен; webhook-токен
  нигде в репозитории не хранится.** Не запускать; в Roblox код не исполнялся.
  Это публичный случай «читерский скрипт = кража аккаунтов», репортить стоит
  владельцам площадок самим (ScriptBlox «verified» у этой записи — проверка не чинит).
- `xeno_hub.lua` (`ballj4359-pixel/Xeno-hub`, 63 B): загрузочный стаб
  (`loadstring(HttpGet(pastefy.app/…))`), не инлайн, пропущен.
- `collonroger/pigeonhub` (`99nights.lua` 407 KB, `Old99nights.lua` 339 KB,
  `autofarmdiamonds.lua` 78 KB, `steal a brainrot 1-10m finder` 36 KB),
  `kyruxv1/99nights-in-the-forest-script/99nitf` (138 KB),
  `koalesanajlepsze/Steal-a-Brainrot-Script/rehgbuehvwe.txt` (754 KB, 225★):
  обфускация wearedevs/25ms/«unknown». Проверено тулами: PSU — «no PSU payload»,
  Luraph-deobf — `generic 0.00 unknown obfuscator`, CASCADE — «Failed to detect
  obfuscator». Восстановить этой сборкой нельзя. Не включены.
- `iTugixerSecunub/Steal-a-Brainrot-Hellstorm`: кода в репо нет (файл `.cs`, 3 байта).
- `waliDiv/Blade-Ball-Script`, `bl-ball-tools/Blade-Ball-Scripts`, `BilixTap/fisch-script`,
  `streamj642-afk/FischROBLOX`: только README/маркетинг; inline-тел нет.

### Фон: публичные читерские репозитории содержат вредоносные тела
См. также `mod_userlogs.lua` в shindo (RECOVERY.md) — тот же паттерн (вебхук, данные
игроков). Ни один из этих URL/вебхук не вызывался из песочницы; ни один токен
в репозиторий не попал.
