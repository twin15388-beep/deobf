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
| `results/corpus/luraph_v15_rideapet/` | `script.lua` (5 170 строк), `PARTS.md`, `LOG.txt`. |
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
  binxgtl/luau-vmp-deobf (`luau-vmp-deobf-main.zip` в корне репозитория,
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

### Shindo Life (приоритет 4)
- DogeHub V2 (ScriptBlox 224947): тело скачано
  (`NoobieDoge/DogeHubV2@Separated:ShindoLife`, 44 639 B), ScriptBlox badge
  «Detected Key system». Полностью разобран контейнер; финальный слой НЕ
  восстановлен. Артефакты: `deobf-report/results/shindo_life/dogehub_v2_shindo/`
  (PARTS.md, dump.txt, disasm.txt) + `deobf-report/tools/{ironbrew_dump.py,
  ironbrew_disasm.py,luac51_dump.py}`. Кратко: внешний слой — плейнтекстовый
  Lua-VM; payload.bin 14 691 B — IronBrew («@Ironbrew/netcoreapp2.0/out.lua»)
  Lua 5.1-байткод с перетасовкой OpArg-таблицы (контейнер распарсен на 100 %);
  слои IronBrew-VM → K13 (570 символов, алфавит 0-9A-Z без 'F') → 365 B
  финальный блоб мини-VM. Фича ScriptBlox «Detected Key system» подтверждает,
  что финальный код, вероятно, подгружается по сети после проверки ключа;
  статическая девиртуализация финального слоя не достигнута.
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
