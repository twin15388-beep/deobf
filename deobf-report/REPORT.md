# Деобфускация скриптов Roblox: инструменты, проверка и результаты

Дата: 2026-10-28. Песочница Linux, 2 vCPU, 3 GB RAM, Node 22, Python 3.11, g++/make.
Все команды, логи и скрипты — в каталоге `deobf-report/` и в рабочем дереве `work/` (в git не попадает).

---

## 0. Обновление (вторая итерация): настоящий Lua вместо дизасма

Главное, что изменилось с первой версии отчёта:

1. **Найдена причина, по которой не работали декомпиляторы.** Все девиртуализаторы (PSU, MoonSec v3)
   после «лифта» отдают Lua 5.1 чанк с заниженным `maxstacksize` и с финальным `RETURN a, b` вместо
   `RETURN a, 1`. Из-за этого `unluac` падал с `ArrayIndexOutOfBoundsException` / `Implicit return must
   have zero values`, а `luadec` — с `cannot find blockend`/segfault. Написан `tools/lua51_repair.py`,
   который правит оба поля **прямо в файле чанка** (без пересборки): пересчитывает `maxstacksize` по
   всем опкодам и переписывает последний `RETURN` в `RETURN a, 1`.
2. **JVM всё-таки есть.** Вместо отсутствующего JDK взят wheel `jdk4py` (OpenJDK 25) — в нём только JRE,
   но `java -jar unluac.jar` этого достаточно. Итог: финальный декомпайл больше не блокер.
3. **Следствие:** PSU 4.0 **и** PSU 4.5 теперь дают настоящий Lua-исходник (раньше — только дизасм):
   `ano.lua` — 56 150 строк, `Kingpiece.lua` — 26 393, `BloxFruit` — 36 695.
4. **Инструментов стало заметно больше** (было 8, стало 14 рабочих/проверенных) — см. §3 и §3.1.
5. **Появилась папка с результатами** `deobf-report/results/` — там рабочий код (`script.lua`) и
   `PARTS.md` с названиями партов/фич по каждому сэмплу, плюс индекс `INDEX.md`.
6. Всё это собрано в один автоматический пайплайн: `deobf-report/tools/pipeline.py` (детект →
   деобфускатор → ремонт байткода → unluac → разбор частей → `LOG.txt`).


---

## 0б. Третья итерация: +15 сэмплов, +2 инструмента, salvage-режим

Что сделано после слияния первой партии:

1. **Собран Luau-рантайм** (`luau-lang/luau` 0.744 + собственные `luau` и `luau-ast`), поэтому
   заработал `Deobfuscator-Luraph-V15`. Результат: **Luraph v15 девиртуализируется в читаемый
   исходник** — Blox Fruits 6 764 строки, Grow a Garden 10 450 строк.
2. **Новый salvage-режим для unluac.** Нашлась ещё одна ошибка декомпилятора: одна плохая функция
   роняет весь файл (`IllegalStateException: IfThenEndBlock`, `Implicit return must have zero values`).
   Написан `lua51_split.py` (режет чанк на прототипы, умеет оборачивать функцию с upvalue в
   синтетический `main`) и `decompile_salvage.py`: файл декомпилируется **по функциям**, нечитаемые
   вставляются дизассемблером с пометкой `-- PSEUDO`. Так восстановлены The Wild West (Nocoal,
   newfarm) — было 791 строки обрезанного вывода, стало 2 411 и 2 355 строк с полным покрытием.
3. **`extract_parts.py` расширен**: теперь вытаскивает ещё и **названия партов/объектов**
   (`FindFirstChild`/`WaitForChild`/`Instance.new`/индексные обращения) с частотой — например у
   Blox Fruits 188 уникальных (`KitsuneIsland`, `EmberTemplate`, `Frozen Dimension`, `Mirage Island`,
   `SeaBeast1`, `HumanoidRootPart`, `VehicleSeat`).
4. **Найдены и деобфусцированы 15 новых скриптов** из 12 режимов (см. §4б) — YBA, Bloxburg, Gacha
   Online, Counter Blox, MM2, Piggy, Prison Life, Tower of Hell, Blox Fruits, Grow a Garden,
   The Wild West, Solara Hub, Jailbreak.
5. Проверен и **собран luadec51** (`sztupy/luadec51` + Lua 5.1.1): как альтернатива unluac он
   оказался хуже — на чанках после лифта падает с `bad code in precompiled chunk`, поэтому в
   пайплайне не используется, но лежит на случай ручного разбора.

---

## 0в. Четвёртая итерация: новый источник, +12 сэмплов, unprom и свой «разминификатор»

1. **Новый крупный источник.** Взяли `hexahigh/Scripts` — 6 132 Lua-файла (256 МБ); прогнали по всем
   файлам детектор обфускатора. Итог сканирования: IronBrew — 34, Synapse Xen — 47, Luraph — 6,
   остальные ~6 000 — обычный (в основном минифицированный в одну строку) Lua.
2. **Новый инструмент: `tools/lua_beautify.py`.** Токенайзер Lua 5.1/5.2, который расставляет
   переводы строк и отступы, **не меняя ни одного токена**, и в конце сверяет поток токенов
   (если поток изменился — файл не пишется). Это безопасный способ превратить
   `local a=1;local b=2` в читаемый код: семантика гарантированно та же, потому что в Lua
   перевод строки не является разделителем операторов. Первая версия «съедала» код после
   строчных комментариев — проверка токенов это поймала, баг исправлен.
3. **Проверен `unprom`** (деобфускатор Prometheus, ранее лежал без дела): 6 из 6 эталонных сэмплов
   (`disrobe/corpus/lua/obfuscators/*`, `prometheus/*`) разобраны, включая luaobfuscator.com,
   который в третьей итерации падал. Строки, ConstantArray и арифметика восстанавливаются;
   `Vmify` разворачивается в плоский CFG (лифтер `--devirt lift` в этой сборке не работает).
4. **12 новых сэмплов из 7 режимов** (Jailbreak, Prison Life, Murder Mystery 2, Pet Simulator,
   Close Quarters Combat, Tower Defense Simulator) — в `deobf-report/results/`, функциональный Lua
   + `PARTS.md` с названиями партов.
5. **Честный минус:** 12 обфусцированных файлов из того же репозитория (Synapse Xen 1.1.2,
   IronBrew 2.7.0/2.7.2, Luraph 6.0-beta1 / 11.1 / 11.5, неизвестный Luraph-подобный VM) разобрать
   не удалось — подробности в `results/_failed.md` и §5.

---

## 1. Короткий итог

| Что | Результат |
|---|---|
| **Итог второй итерации** | **6 из 6** игровых сэмплов разобраны в настоящий Lua (`results/`), плюс 3 бенчмарк-сэмпла. PSU 4.0/4.5 (раньше «только дизасм») теперь декомпилируются полностью. |
| **Итог третьей итерации** | **+15 сэмплов из 12 режимов** (Blox Fruits, Grow a Garden, **YBA**, Bloxburg, Gacha Online, Counter Blox, MM2, Piggy, Prison Life, The Wild West, Solara Hub, Tower of Hell, Jailbreak). Luraph v15 теперь девиртуализируется полностью. Всего в `results/` — **24 сэмпла**. |
| **Итог четвёртой итерации** | **+12 сэмплов из 7 режимов** (Jailbreak ×3, Prison Life ×3, Murder Mystery 2 ×2, Pet Simulator ×2, Close Quarters Combat, Tower Defense Simulator) — функциональный Lua через новый `lua_beautify.py`. Плюс проверен `unprom` (6/6 сэмплов Prometheus). Всего в `results/` — **36 сэмплов из 18 режимов**. 12 обфусцированных файлов (Xen, IronBrew 2.7, Luraph 6/11) разобрать не удалось — `results/_failed.md`. |
| Luraph v15 деобфускатор (из `Deobfuscator-Luraph-V15-master.zip`) | **Работает** после портирования на Linux. Валидирован: `RideAPet.lua` → вывод **байт-в-байт** совпал с эталоном из репозитория (5170 строк). Свежий Luraph v15.0 из сторонней коллекции → вытащен загрузчик за 5 с. |
| `luau-vmp-deobf-main.zip` (Python, Luraph v14.x) | **Не запускается**: требует Lune (рантайм Luau), а релизы Lune отдаются только через GitHub release-assets, которые в песочнице заблокированы. Пакет `lune` на PyPI — про фазы Луны, не то. |
| Сторонние деобфускаторы (найдены и проверены) | **14 проверено в работе**, из них 8 дают результат на реальных сэмплах; 1 частично; остальные — блокеры среды (нет .NET/Rust/Lune). Таблицы в §3 и §3.1. |
| King Legacy | 6 обфусцированных сэмплов → **все 6 разобраны в читаемый Lua**: PSU 4.0 (×2), PSU 4.5, MoonSec V3 (×2), MoonSec V2. |
| Blox Strike | 4 «обфусцированных» файла найдено (Keyforge, кастомный VM, «как Luraph»). Ни один не поддерживается доступными инструментами; для одного есть поведенческий трейс. |
| GPO (Grand Piece Online) | Обфусцированных публичных сэмплов **не найдено** — в паблике только исходники хабов. |
| YBA (Your Bizarre Adventure) | То же: только открытые GUI-скрипты, обфусцированных версий в публичном GitHub нет. |
| Illegal Soccer | Только SEO-мусорные репозитории (`.github`-заглушки), кода нет вообще. |
| Где смотреть результат | `deobf-report/results/` — `INDEX.md`, по каталогам `script.lua` + `PARTS.md` + `LOG.txt`. |

---

## 2. Что пришлось починить, чтобы инструменты вообще заработали

1. **Luau-рантайм.** Деобфускатор Luraph v15 — Node-обёртка, которая исполняет скрипт в песочнице через бинарники `luau` / `luau-ast` из `bin/` (в zip лежат только `.exe`).
   Скачать готовые Linux-сборки нельзя (release-assets заблокированы), поэтому Luau собран из исходников (`luau-lang/luau`, 0.744) вручную, без cmake:
   * `deobf-report/tools/build_luau.sh` — компилирует Ast/Compiler/Bytecode/VM + собственный минимальный раннер `luau_runner.cpp`;
   * `deobf-report/tools/build_ast.sh` — `luau-ast` (JSON-AST, нужен `vmmap`);
   * раннер реализует то, чего нет в стоковом Luau CLI, но нужно харнессу: `loadstring`, `warn`, `task.*`, `collectgarbage`, `debug.profilebegin/setmemorycategory`, **REPL-режим по stdin** (через него работает долгоживущий HarnessServer) и `require("./file")`.
   *(Первая версия раннера молча «проглатывала» ошибки: msgh-функция оказывалась поверх чанка, т.е. pcall вызывал traceback вместо скрипта. Исправлено — трейсбэки и коды возврата теперь честные.)*
2. **Баг в самом деобфускаторе.** `src/devirt_bridge.py`: `DummyArgs` не содержал `keep_harness`, из-за чего девиртуализация падала с `AttributeError` и скрипт уходил в «behaviour trace» (37 строк вместо 5170). Добавлен `__getattr__` с дефолтом.
3. **PSU-Deobfuscator** на финальном шаге зовёт `java -jar unluac.jar`. JVM в песочнице нет ⇒ патч `--bytecode`: при ошибке декомпайла всё равно сохранять восстановленный Lua 5.1 байткод.
4. **JVM появилась:** `pip download jdk4py` → распаковка whl → `jdk/jdk4py/java-runtime/bin/java` (OpenJDK 25, только JRE — `javac` нет, но `java -jar` работает). Теперь unluac запускается.
5. **Главный баг — битый байткод, а не декомпилятор.** После лифта PSU/MoonSec в чанке занижен `maxstacksize` и последний `RETURN` имеет лишние значения. Симптомы: `unluac` → `ArrayIndexOutOfBoundsException: Index 1 out of bounds`, `luadec` → `cannot find blockend` / segfault (`rc=134/139`), `luac -p` → `bad code in precompiled chunk`.
   Лечение — `deobf-report/tools/lua51_repair.py` (правит чанк **in place**): пересчитывает `maxstacksize` по всем опкодам функции и переписывает финальный `RETURN a, b` в `RETURN a, 1`.
   ```bash
   python3 tools/lua51_repair.py in.luac out.luac -v
   java -jar tools/PSU-Deobfuscator/tools/unluac.jar out.luac --output out.lua
   ```
   Проверено: у `KL_msv3_v14` было 15 битых прототипов из 95, у PSU-сэмпла Kingpiece — 39 из 265 (один `maxstack` был занижен с 257 до 2). После патча unluac отдаёт `rc=0`.
6. **Собственный дизассемблер остаётся как резерв:** `deobf-report/tools/lua51_disasm.py` (Lua 5.1 байткод → псевдо-Lua с RK-константами и метками) — используется, если unluac всё же падает.

---

## 3. Найденные деобфускаторы и результат их проверки

| Инструмент | Тип | Статус в песочнице | Проверка |
|---|---|---|---|
| `caomod2077/Deobfuscator-Luraph-V15` (он же zip в репо) | JS + Python | **Работает** | детект `sample/RideAPet.lua` → `luraph_v15 1.00`; `RideAPet.lua` (397 КБ) → 5170 строк, diff с эталоном **пустой**; 11 мин 08 с на 2 vCPU (в README заявлено 55 с на Windows). Сэмпл v15.0 (129 КБ) → 1 строка-загрузчик за 4.9 с. |
| `luau-vmp-deobf` (zip в репо) | Python | **Блокер: нет Lune** | До питонной части дело не доходит: `luraph-full` запускает `.luau`-раннеры через Lune. Без Lune пайплайн не стартует. |
| `luaprojects/moonsec-js-deobf` | JS (порт C#-версии) | **Работает** | MoonSec V3: 588 729 Б → 50 500 Б Lua 5.1 байткода (~1 с); 399 111 Б → 79 252 Б. |
| `neosnappp/moonsec-v2-deobfuscator` | Python | **Работает** | MoonSec V2: 625 484 Б → 53 013 Б читаемого Lua (anti-tamper-заглушки вроде `__secureeq` остаются, но логика видна). |
| `memcpython/PSU-Deobfuscator` | Node | **Работает** (после `lua51_repair.py`) | Статический лифт: PSU 4.0 — `handlers=255 unknown=0`; PSU 4.5 — `handlers=120/255 unknown=0`. С ремонтом чанка + `unluac` (JRE из `jdk4py`) — полный Lua: 26 393 / 36 695 / 56 150 строк. |
| `tupsutumppu/MoonsecDeobfuscator` | C# | **Блокер: нет .NET SDK** | — (использован JS-порт, см. выше). |
| `0x251/Prometheus-Deobfuscator` | Python | **Сломан на 3.11** | Три `SyntaxError` (f-строки с `\` внутри выражений — только 3.12+), после правки двух мест в `modules/vmify.py` — синтаксически невалидная f-строка (`'"...".encode("latin-1")...'`). Не починен. |
| `InternalWp1d/keyforge-deobfuscator` | Python | **Не инструмент** | По README это «гайд по разбору ForgeVM»: жёстко прописан путь к Lune и таблица опкодов под один конкретный сэмпл. Автоматически ничего не деобфусцирует. |
| `1-3-7/disrobe` | Rust | **Не собран** | Нет cargo/rustc, а это самый мощный из найденных (мультиобфускаторный набор). |
| `unluac` (`HansWessels/unluac`, jar v1.2.3.569) | Java | **Работает** | Основной декомпилятор Lua 5.1 в пайплайне; нужен только JRE (`jdk4py`). Выход — настоящий Lua `.lua`. |
| `unluac-rs`, `metaworm/luac-parser-rs` | Rust | **Не собраны** | Нет cargo; заменены на JVM-unluac. |

### 3.1. Что добавлено во вторую итерацию

| Инструмент | Тип | Статус | Проверка |
|---|---|---|---|
| `unprom` (`unprom/unprom.py`) | Python | **Работает** | Prometheus / LuaObfuscator / wYnFuscate: раскрывает `string.char(...)`-константы и VM-обёртку. `prom_small.lua` → 42 строки с `HttpGet` и URL загрузчика. |
| `prometheus-deobfuscator-by-axom` | Python | **Работает** | Альтернатива для Prometheus («unbox iife → unmask → wash»). На `prom_small` даёт 31 строку. Пайплайн берёт более крупный из двух результатов. |
| `disingeunity/CASCADE` | JS | **Частично** | IronBrew 2.7/MVSM: умеет собирать `output.luac`, но на сложных сэмплах падает с `No Matched Instruction ... SuperInstruction` → пайплайн честно считает это провалом (не отдаёт мусор). |
| `sztupy/luadec51`, `viruscamp/luadec` | C | **Плохо** | Собраны; на PSU/MoonSec-чанках `cannot find blockend` или segfault; генерируют `goto lbl_NN` (не парсится Lua 5.1). Оставлены как резерв, в пайплайне не используются. |
| `memcpython/Lua-Bytecode-Deobfuscator` | C# (.sln) | **Блокер: нет .NET** | — |
| `De4Lua` | TypeScript | **Блокер: нет сборки** | В репо только `src/`, `npm run build` требует глобальных `tsc`+`esbuild`. |
| `mehCake/luraph-deobfuscator-py` | — | **Только README** | Кода нет. |
| **`lua51_repair.py`** (мой) | Python | **Ключевой** | Ремонт `maxstacksize` + `RETURN` в Lua 5.1 чанке; без него ни unluac, ни luadec не работают. |
| **`extract_parts.py`** (мой) | Python | **Работает** | Из Lua вытаскивает фичи, UI-библиотеку, URL/webhook-и, сервисы, чат-команды и подписи UI → `PARTS.md`. |
| **`pipeline.py`** (мой) | Python | **Работает** | Детект обфускатора по 16 маркерам + цепочка фолбэков (psu → moonsec_v3 → ironbrew → unprom), ремонт, декомпайл, разбор частей, `LOG.txt`. |
| **`collect_results.py`** (мой) | Python | **Работает** | Собирает выходы пайплайна в `results/` и генерирует `INDEX.md`; отбрасывает «первые слои» короче 60 строк. |

### 3.2. Что добавлено в третьей итерации

| Инструмент | Тип | Статус | Проверка |
|---|---|---|---|
| **Luau-рантайм** (`build_luau.sh` + `luau_runner.cpp`) | C++ | **Работает** | Собран без cmake: `bin/luau` (VM + REPL + `loadstring`/`task.*`) и `bin/luau-ast`. Без них деобфускатор Luraph v15 не запускается. |
| **`lua51_split.py`** (мой) | Python | **Работает** | Режет Lua 5.1 чанк на отдельные чанки-прототипы; для функций с upvalue умеет собрать синтетический `main` (`CLOSURE; RETURN`). Именно из-за upvalue-функций unluac падал `NullPointerException: "func.parent" is null`. |
| **`decompile_salvage.py`** (мой) | Python | **Работает** | Полный декомпайл → при провале по-функциональный: 13/13 функций The Wild West восстановлены (7 в Lua, 6 с дизасмом), вместо 791 обрезанной строки — 2 411. |
| `Deobfuscator-Luraph-V15` | JS+Python | **Работает** | `--detect` даёт `luraph_v15 1.00`; Blox Fruits и Grow a Garden девиртуализированы полностью. |
| `sztupy/luadec51` + Lua 5.1.1 | C | **Не подходит** | Собран (`gcc … liblua.a`), но на чанках после лифта: `bad code in precompiled chunk`; выход хуже unluac (goto-метки). |
| `moonsec-js-deobf` (перенос зависимостей) | JS | **Работает** | Для MoonSec V3 требует `npm install` (`fengari`, `luaparse`) — без этого падал `Cannot find module 'fengari'`. |
| `TrixAde/scripts`, `FSOCIETY-WYLD/TWWLEAN`, `samuraa1/Solara-Hub`, `terrorlua/obfuscator-samples`, `retpirato/Roblox-Scripts` | источники | **Новые корпуса** | 15 скачанных скриптов по 12 популярным режимам. |

### 3.3. Что добавлено в четвёртой итерации

| Инструмент | Тип | Статус | Проверка |
|---|---|---|---|
| **`lua_beautify.py`** (мой) | Python | **Работает** | Токен-безопасная нормализация минифицированного Lua: склейка `local a=1;local b=2` в строки, отступы по `then/do/repeat/function`/`end/until`, корректная обработка длинных строк `[[ ]]`, `[=[ ]=]`, shebang, `\ddd`-escape. На 12 файлах (до 183 КБ) поток токенов совпал 12/12. |
| **`collect3.py`** (мой) | Python | **Работает** | Сборщик партии: detect → нормализация → `PARTS.md` → `LOG.txt` → сводная таблица. |
| `unprom` (`_work/tools/unprom`) | Python | **Работает** | 6/6 эталонных сэмплов Prometheus / wearedevs v1.0 / luaobfuscator.com. Снимает `WrapInFunction`, `NumbersToExpressions`, `EncryptStrings`, `ConstantArray`, `AntiTamper`; `Vmify` — только «де-флэттен» в плоский CFG. |
| `axomtools/ironbrew2-deobfuscator` | Python | **Не подходит** | Заявлен IB 2.7.0/2.7.1/AztupBrew 2.7.2, но написан под другую версию `luaparser` (`Index.obj`, `Index.index`); после патча под 3.3.0 детектор движка не срабатывает на реальных IB 2.7.2 (другая форма обёртки). |
| `CASCADE` (GNAA/Fission) | JS | **Не подходит** | Заявлен MS/IBW (`node index.js`, вход `input.lua`), но на IB 2.7.2 совпадает <10 инструкций, `output.luac` — 301 байт. |
| `hexahigh/Scripts` | источник | **+6 132 файла** | Скачан tarball'ом (41 МБ) через `codeload.github.com` — `git clone` на таких объёмах не нужен. |

Все свои скрипты — в `deobf-report/tools/`. Прежний `lua51_disasm.py` остался как резервный дизассемблер.

---

## 4. Результаты по играм

### King Legacy / Blox Fruits — **есть результат: 6 из 6**

Источники: `XxBoomer/script` (`unfazed/Kingpiece.lua`, `ano.lua`), `hankiwastaken/Cracks`
(`Lightux/v1.3`, `v1.4`, `v1.5`), плюс сэмпл Blox Fruits из той же коллекции.
Все выходы лежат в `deobf-report/results/king_legacy/<сэмпл>/{script.lua,PARTS.md,LOG.txt}`.

| Файл | Обфускатор | Вход | Результат | Что внутри (парты/фичи) |
|---|---|---|---|---|
| `unfazed/Kingpiece.lua` | PSU 4.0.A | 346 КБ | **26 393 строки Lua**, 849 КБ | автофарм NPC (`Auto Fram King Samurai`, `King of Sand`, `Sea King`, `Shadow Master`, `Boss Dragon`, `Anubis`), `Auto Haki`/`Auto Ken Haki`/`Auto Skill`/`Awakening NPC`, `Auto Raids`, `Auto Buy Devil Fruit`, ESP, телепорты, UI на Magma |
| Blox Fruits hub | PSU 4.0.A | 456 КБ | **36 695 строк Lua**, 1 295 КБ | автофарм/квесты (`AbandonQuest`, `Ability Teacher`), `Aimbot Gun`, инвентарь-ESP, 46 телепортов, UI Magma/Vision/Rain |
| `ano.lua` | PSU 4.5.A | 630 КБ | **56 150 строк Lua**, 3 421 КБ | King Legacy-фичи, key-система (`Hidden Key`, «1. Join discord / 2. Go to #key channel / 3. word.ink»), предметы `BlackSpikeyCape`/`BlueSpikeyCape` |
| `Lightux v1.4 ZombieAttack` | MoonSec V3 | 589 КБ | **6 765 строк Lua**, 149 КБ | `AutoFarm`, `Anti-AFK`, `Auto Equip`, `Click Teleport Tool`, проверка `IsInGroup(16527976)`, команды `:ban/:kick/:freeze/:fling` |
| `Lightux v1.5 ZombieAttack` | MoonSec V3 | 399 КБ | **10 423 строки Lua**, 279 КБ | то же, более новая версия |
| `Lightux v1.3` | MoonSec V2 | 625 КБ | **4 207 строк Lua**, 133 КБ | читаемый Lua сразу после деобфускатора: `game.HttpGet`, `loadstring`, UI, анти-tamper `__secureeq` |

Проверка «настоящий ли это Lua»: файлы синтаксически корректны; часть из них не компилируется
обратно стоковым `luac -p` из-за лимита Lua 5.1 «more than 200 local variables» — unluac объявляет
регистры VM локалями (см. §5, п. 3). Читаемость и корректность логики от этого не страдают.

### Бенчмарк на чужих обфускаторах (`vyxonq-dev/obfuscator-samples`)

Чтобы показать, что пайплайн не заточен под одну игру, прогнаны 12 минимальных сэмплов:

| Сэмпл | Детект | Итог |
|---|---|---|
| `psu_small` | psu | 1 479 строк Lua |
| `aztupbrew` | psu (AztupBrew — это форк PSU) | 6 874 строки Lua |
| `msv2_small` | moonsec_v2 | 14 строк (снят только ключ XOR — «первый слой») |
| `prom_small` | unknown → unprom | 42 строки, виден `HttpGet` и URL загрузчика (в `results` не попал, < 60 строк) |
| `luaobfuscator` | unknown → unprom | 15 строк (декодер строк, «первый слой») |
| `wynfuscate` | wynfuscate → unprom | 324 строки |
| `ib1_small` (IronBrew 1) | ironbrew1 → CASCADE → unprom | частично: CASCADE не матчит супер-инструкции; unprom снимает обёртку (1 606 строк), но внутри остаётся VM IronBrew1 — нужен отдельный девиртуализатор |
| `ib2_small` (IronBrew 2.7) | unknown → CASCADE | провал: `No Matched Instruction ... SuperInstruction` |
| `boronide` | boronide | частично: unprom снимает внешний слой (1 348 строк), внутри — VM Boronide с рантайм-ключом |
| `msv3_small` | unknown | провал: тестовый файл — пустая обёртка MoonSec |
| `luraph_unknown` | luraph_v15 | провал: это не обфусцированный скрипт, а сам загрузчик-заглушка |
| `moonveil` | moonveil | провал: статического деобфускатора для MoonVeil нет |

### Вторая партия: 15 скриптов из 12 режимов — **все разобраны**

Источники: `TrixAde/scripts` (хабы на 13 игр), `FSOCIETY-WYLD/TWWLEAN` (The Wild West),
`samuraa1/Solara-Hub` (Orion), `terrorlua/obfuscator-samples` (Luraph v15), `retpirato/Roblox-Scripts`
(IronBrew). Всё лежит в `deobf-report/results/<каталог>/`, таблица — `results/INDEX.md`.

| Режим | Сэмпл | Обфускатор | Результат | Парты / фичи |
|---|---|---|---|---|
| **Blox Fruits** | `sample/Blox Fruit.lua` | **Luraph v15** | 6 764 строки, читаемый исходник | `Auto Farm Sea`, `Auto Farm Mastery`, ESP, 188 партов: `KitsuneIsland`, `EmberTemplate`, `Frozen Dimension`, `Mirage Island`, `SeaBeast1`, `VehicleSeat` |
| **Grow a Garden** | `sample/Grow a Garden.lua` | **Luraph v15** | 10 450 строк | автофарм, авто-продажа, ESP ×48, телепорты ×19 |
| **Your Bizarre Adventure** | `KolgieYba.lua` | PSU 4.0 | 4 350 строк | авто-квесты ×43, автофарм ×38, авто-продажа, Aimbot |
| **Bloxburg** | `BloxBurgAutoBuild.lua` | MoonSec V3 | 13 315 строк | автопостройка домов, телепорты ×43, UI Krnl/Orion |
| **Gacha Online** | `GachaOnline.lua` | PSU 4.0 | 10 451 строка | авто-роллы, фарм валюты |
| **The Wild West** | `Nocoal.lua`, `newfarm.lua`, `coalfarm.lua` | MoonSec V3 | 2 411 / 2 355 / 2 417 строк (salvage) | фарм угля и без угля, ESP инвентаря, авто-телепорт к шахтам |
| **The Wild West** | `TheWildWest.lua` | PSU 4.5 | 6 612 строк | хаб с автофармом |
| **Solara Hub (Orion)** | `Orion.lua` | MoonSec V3 | 9 449 строк | мультиигровой хаб, UI Orion/Solara, конфиги ×15 |
| **Murder Mystery 2** | `mm2GhostHub.lua` | MoonSec V2 | 7 356 строк | Ghost Hub |
| **Counter Blox** | `counterBlox.lua` | unprom | 6 915 строк | чит-меню |
| **Prison Life** | `prsionlife.lua` | unprom | 3 477 строк | GUI с чат-командами |
| **Piggy** | `piggy.lua` | PSU 4.0 | 2 881 строка | хаб |
| **Tower of Hell** | `towerofhell.lua` | IronBrew | 295 строк | снят внешний слой, внутри VM |
| **Jailbreak** | `JailHack.lua` | самописный XOR | 7 строк | JailTabs 3.2, после снятия XOR остаётся компактный исходник |

Итог по этому блоку: **12 из 15 — полноценный читаемый Lua**, 3 (Tower of Hell, JailTabs,
Hatching Simulator) — снят только внешний слой, дальше VM без девиртуализатора.

### Третья партия: 12 сэмплов из 7 режимов (4-я итерация)

Источник — `hexahigh/Scripts`. В этой партии VM-обфускации не было, но код был **минифицирован в одну
строку**, поэтому применён `tools/lua_beautify.py` (токен-безопасная нормализация).

| Игра / режим | Сэмпл | Что это | Строк | Результат |
|---|---|---|---|---|
| Jailbreak | `jailbreak/unjailbreak` | авто-ограбления, ESP, aimbot, 71 телепорт, UI Rain | 4 510 | функциональный Lua |
| Jailbreak | `jailbreak/gui_2` | GUI-меню | 1 834 | функциональный Lua |
| Jailbreak | `jailbreak/jailbreaker_v42` | Jailbreaker V4.2 | 909 | функциональный Lua |
| Prison Life | `prison_life/main` | мультитул: килл-аура, ESP, телепорты, админ-команды | 3 659 | функциональный Lua |
| Prison Life | `prison_life/simple_gui` | простое GUI | 2 756 | функциональный Lua |
| Prison Life | `prison_life/gui` | GUI с командами | 1 228 | функциональный Lua |
| Murder Mystery 2 | `murder_mystery_2/full` | роли, ESP, авто-нож | 1 506 | функциональный Lua |
| Murder Mystery 2 | `murder_mystery_2/gui` | GUI | 1 149 | функциональный Lua |
| Close Quarters Combat | `close_quarters_combat/gui` | чит-меню | 1 613 | функциональный Lua |
| Pet Simulator | `pet_simulator/gui` | GUI-автофарм, UI Hydra/Rain | 1 354 | функциональный Lua |
| Pet Simulator | `pet_simulator/op_gui` | OP GUI | 999 | функциональный Lua |
| Tower Defense Simulator | `tower_defense_simulator/autofarm` | автофарм | 11 121 | **частично**: виден блок настроек `_G.*`, тело — VM Luraph v6-типа |

Пример `PARTS.md` (Jailbreak/UNJAILBREAK): фичи — Aimbot (34), ESP (32), Fly/Noclip (48),
Speed/Jump (35), Teleport (71), Config (77); UI — Rain; сервисы — `Players`, `Workspace`,
`Lighting`, `RunService`, `UserInputService`; парты — `HumanoidRootPart`, `HopperBin`,
`BillboardGui`, `ScreenGui`.

### Blox Strike — **только частично**
Источник: `haw1xs/ggs.hw` (`script.txt`, `Test.txt`, `script3.txt`), `brkapery/Sigmaware-Roblox-BloxStrike/main.lua` (чистый исходник).

* `script.txt` (1 МБ) — «protected by **Keyforge** (ForgeVM)»: свой набор опкодов у каждого файла, статический инструмент под него в паблике только в виде гайда (`keyforge-deobfuscator`). **Не деобфусцирован.**
* `Test.txt` (723 КБ) — кастомный VM (`return (function(...)`, переименованные глобалы `_ol0lOI_O__oO0I_0_`). Наш детектор: `unknown obfuscator`, **не поддержан**.
* `script3.txt` (449 КБ) — «Just like Luraph…» (самописный VM), **не поддержан**.
* Единственное, что удалось: для PSU-подобных скриптов работает поведенческий трейс (см. §5), но для Keyforge/кастомных VM даже он не запускается без их рантайма.

### GPO и Illegal Soccer — **сэмплов обфускации нет** (YBA найден, см. §4б)
Прошёл `search/code` + `search/repositories` по названиям, скачал и просканировал всё, что похоже на «обфусцированный» скрипт (скоринг: длиннющие строки, `\ddd`-эскейпы, сигнатуры PSU/MoonSec/Luraph/IronBrew/Keyforge, «магические» числа):

* **GPO**: `Spade324/SpadesHub`, `Ic0u/achieved-scripts`, `TrilhaX/scriptexec`, `StupidProAArsenal/AztubHub_OpenSource` и др. — везде открытый исходник, обфускации нет.
* **YBA**: в первой итерации находились только открытые GUI (`THUNER-Dev/YBA-Gui`, `RobyPumnDeFier/GUI`,
  `ScreamerUWU/YBA`). Во второй партии обфусцированный YBA-скрипт всё-таки найден — `KolgieYba.lua`
  из `TrixAde/scripts` (PSU 4.0), разобран в §4б.
* **Illegal Soccer**: ~десяток репозиториев вида `illegal-soccer-*.github` — SEO-спам без единого файла кода.

Вывод: деобфусцировать эти три игры **не из чего** — в публичном GitHub их обфусцированных сборок нет (они распространяются через приватные хабы/Key-системы, а не репозитории).

### Прочие популярные режимы (проверено на эталонных сэмплах Luraph v15)
`Blox Fruits`, `Grow a Garden (1/2)`, `Steal a Brainrot`, `Steal an Egg`, `Jump for Animals`, `Ride a Pet`, `+1 Speed Keyboard Escape` — все в `sample/`, деобфускатор их обрабатывает; для `RideAPet.lua` получено полное совпадение с эталоном.

---

## 5. Что не удалось и почему (ошибки)

**Закрыто во второй итерации:** JVM (JRE из `jdk4py`) и unluac; битый байткод после лифта (`lua51_repair.py`);
PSU 4.0/4.5 и MoonSec V3 теперь дают настоящий Lua, а не псевдо-Lua.

**Закрыто в третьей итерации:** Luau-рантайм (Luraph v15 больше не блокер); падения unluac на одной
плохой функции (появился salvage-режим `lua51_split.py` + `decompile_salvage.py`).

**Что по-прежнему не получилось:**

1. **Lune** — бинарник не скачать (release-assets заблокированы) ⇒ `luau-vmp-deobf` (Luraph v14.x) не проверен в работе.
2. **Свой unluac из исходников** — `jdk4py` содержит только JRE, `javac` нет. Используется готовый `unluac.jar` (v1.2.3.569).
3. **Ограничение генератора unluac, а не вывода:** в больших функциях unluac объявляет регистры VM локалями, и файл не проходит `luac -p` — «more than 200 local variables» / «function or expression too complex». Код читаемый, но для запуска нужен Luau-рантайм или ручное «схлопывание» локалей.
4. **luadec как альтернатива не годится:** `luadec51`/`viruscamp/luadec` на PSU-чанках дают `cannot find blockend`, segfault (rc=134/139) либо генерируют `goto lbl_NN`, который не парсится Lua 5.1.
5. **.NET SDK** — оригинальный `MoonsecDeobfuscator` (C#) и `Lua-Bytecode-Deobfuscator` (C#) не собраны.
6. **Rust (cargo)** — `disrobe`, `unluac-rs`, `luac-parser-rs` не собраны (нет rustc).
7. **Python 3.11** — `0x251/Prometheus-Deobfuscator` сломан (код требует 3.12 и содержит невалидный f-string). Работает альтернатива `prometheus-deobfuscator-by-axom` + `unprom`.
8. **IronBrew 1/2.7** — `CASCADE` падает на супер-инструкциях (`No Matched Instruction ... SuperInstruction`), `unprom` снимает только внешнюю обёртку. Полного девиртуализатора IB2 в песочнице нет.
9. **Boronide / MoonVeil** — VM с рантайм-ключом; статических деобфускаторов в паблике нет.
10. **Keyforge / кастомные VM (Blox Strike)** — публичных статических деобфускаторов нет; `keyforge-deobfuscator` — гайд, а не инструмент.
11. **Анти-tamper Luraph** при финальном прогоне иногда рапортует `LPH:23: Chilli Library bootstrap is invalid` — на корректность уже полученного вывода не влияет (вывод сверен побайтово), но финальная верификация в песочнице не проходит.
12. **Производительность:** 2 vCPU дают ~11 минут на 400-КБ Luraph v15 (Python-бэкенд девиртуализации упирается в CPU).
13. **Salvage-режим не идеален:** функции с upvalue (`GETUPVAL`) unluac не берёт даже в виде отдельного
    чанка — `NullPointerException: "func.parent" is null`. Синтетический родительский `main` проблему не
    решает (unluac выводит заглушку), поэтому такие функции идут дизассемблером под пометкой `-- PSEUDO`.
    На The Wild West это 6 функций из 13, на newfarm — 8.
14. **`luadec51` собран, но непригоден:** `bad code in precompiled chunk` на лифтованном чанке (Lua 5.1.1
    строже к `maxstacksize`/структуре, чем unluac), поэтому как запасной декомпилятор не используется.
15. **Luraph v14.x (DaHood-LegacyX, LumberTycoon2)** — оба файла определяются как `generic 0.00`:
    это Luraph-подобный VM, но не v15, а деобфускатора под v14 в песочнице нет (Lune недоступен).
16. **`samuraa1/Solara-Hub` LunaSrc/lunatest** — cамописный «Luna Interface»: `unprom` падает с
    `LuaSyntaxError: expected ')' but got OP:':'`; инструмента под этот формат нет.

17. **Synapse Xen 1.1.2** (One Piece Millennium, Vesteria, Bee Swarm, Doge Simulator, Dark Dex, Boku No
    Roblox): VM с шифрованным байткодом, `VM Hash` в шапке. Публичного деобфускатора нет — три
    поисковых запроса по GitHub (`synapse+xen+deobfuscator`, `xen+deobf+lua`, `xen deobfuscator`) дают
    только скрипт-хабы. Внутри — анти-констант-«троллинг» (строки вида `PSU|23F1w…`).
18. **IronBrew 2.7.x** (Clone Tycoon 2, Mega Fun Obby, Stackables, Blox Piece 232, Troll GUI,
    Prison Life Destroyer Hub): `CASCADE` выдаёт 301-байтный `output.luac`, `axomtools/ironbrew2-deobfuscator`
    падает на разборе AST (в актуальном `luaparser` у `Index` поля `value/idx`, а не `obj/index` —
    после патча детектор движка IB не срабатывает). Полного IB2-девиртуализатора в песочнице нет.
19. **Luraph 6.0-beta1 / 11.1 / 11.5** (Ro-Ghoul, Loomian Legacy, Da Hood): `deob.js` умеет только v15
    (`--detect` → `generic 0.00`), `unprom` на Luraph-десериализатор не реагирует. Отдельно проверены
    репозитории `larpcorrupt/luraph-v15-v14.x-deobfuscator` (только v14/v15) и
    `caomod2077/Deobfuscator-Luraph-V15` (то же).
20. **«Luraph-подобный» VM без шапки** (PEPSI AIMBOT, Arsenal GUI, Arsenal Aimbot): заголовок
    `local a=string.byte;local b=string.char;…` — тот же десериализатор с base-36 константами и
    `bit.bxor`-строками; ни один инструмент его не распознаёт (`detect → unknown`), `lua_beautify`
    даёт только форматирование.
21. **`unprom --devirt lift`** — флаг принимается молча и ничего не меняет (в README обещан полноценный
    лифтер); фактический результат по `Vmify` — плоский CFG с блоками `while pos do if pos < K then …`.
    Код читается, но это не исходный Lua.

---

## 6. Что ещё можно скачать (коллекции и инструменты)

Уже скачано и проверено (лежит в рабочем дереве `_work/tools/`, в git не попадает):
`PSU-Deobfuscator`, `moonsec-js-deobf`, `moonsec-v2-deobfuscator`, `CASCADE`, `unprom`,
`prometheus-deobfuscator-by-axom`, `luadec51`, `luadec`, `unluac` (исходники + jar), `jdk4py` (JRE 25),
`De4Lua`, `Lua-Bytecode-Deobfuscator`, `luraph-deobfuscator-py`, `luraph-v15-v14.x-deobfuscator`,
плюс 12 сэмплов корпуса `vyxonq-dev/obfuscator-samples` в `_work/corpus/`.

Инструменты (все проверяемы/скачиваемы из текущей песочницы):
* `1-3-7/disrobe` — **главная рекомендация**: мультиобфускаторный набор (Luraph/MoonSec/IronBrew/Prometheus/…), Rust. Нужен rustc.
* `0x251/Prometheus-DeobfuscatorV2` — обещанная переработка (в v1 код битый).
* `memcpython/PSU-Deobfuscator` — PSU 4.0/4.5 (работает; нужна Java для декомпайла).
* `luaprojects/moonsec-js-deobf` — MoonSec V3 (работает, JS, без зависимостей кроме npm).
* `neosnappp/moonsec-v2-deobfuscator` — MoonSec V2 (работает, Python).
* `disingeunity/CASCADE` — JS-девиртуализаторы IronBrew 2.7 и MSVM.
* `windaswitness/narsil`, `4fundsagent-source/luraph-deobfuscator`, `mrluraph/Luraph-Deobfuscator-v15`, `L0stHeart/Deobfuscator-Luraph-V15` — альтернативы по Luraph (не проверялись детально).
* `HansWessels/unluac` / `x3zvawq/unluac-rs` — декомпилятор Lua 5.1 (Java / Rust) — то, чего не хватает для финального шага.
* `metaworm/luac-parser-rs` — парсер байткода (Rust).
* `InternalWp1d/keyforge-deobfuscator` — гайд по ForgeVM (для Blox Strike).

Корпуса для тестов:
* `vyxonq-dev/obfuscator-samples` — **22 833 файла**, разложены по обфускаторам и версиям (`Luraph/v15.0`, `Boronide`, `AztupBrew`, `Base64Payload`, …). Идеальный бенчмарк.
* `NTTTTTTTT/deobf` — пары «вход → деобфусцированный Luraph» (66 файлов).
* `1-3-7/disrobe` `corpus/lua/luraph/` — подписные сэмплы Luraph разных версий.

---

## 7. Артефакты

```
deobf-report/
├── results/                                   # ← ГЛАВНОЕ: рабочий код + названия партов
│   ├── INDEX.md                               #   таблица всех результатов
│   ├── README.md                              #   что внутри и как получено
│   ├── king_legacy/<сэмпл>/
│   │   ├── script.lua                         #   восстановленный Lua (26k–56k строк)
│   │   ├── PARTS.md                           #   фичи, UI, URL, парты/подписи
│   │   └── LOG.txt                            #   лог пайплайна
│   ├── corpus/<сэмпл>/                        #   бенчмарк на чужих обфускаторах
│   ├── _failed.md                             #   что не удалось и что пробовали (4-я итерация)
│   ├── _batch3.md                             #   сводная таблица третьей партии
│   ├── _corpus_prometheus/                    #   проверка unprom: 6/6 сэмплов Prometheus
│   ├── <игра>/<сэмпл>/                        #   вторая партия: 12 режимов (blox_fruits, yba, …)
│   └── <игра>/<сэмпл>/                        #   третья партия: jailbreak, prison_life, pet_simulator, …
├── output/                                    # результаты первой итерации (псевдо-Lua, трейсы)
│   ├── luraph_v15_synaptix_loader.lua
│   ├── moonsec_v2_lightux13.lua
│   ├── moonsec_v3_lightux14.pseudo.lua.txt
│   ├── psu40_kingpiece.pseudo.lua.txt
│   └── psu40_kingpiece.behaviour_trace.lua
└── tools/
    ├── pipeline.py                            # детект → деобфускатор → ремонт → unluac → PARTS.md
    ├── lua51_repair.py                        # ремонт maxstacksize + RETURN в Lua 5.1 чанке
    ├── lua51_split.py                         # чанк → чанки по прототипам (salvage)
    ├── decompile_salvage.py                   # декомпайл по функциям, когда unluac падает
    ├── extract_parts.py                       # Lua → PARTS.md (фичи, парты, URL, remotes)
    ├── collect_results.py                     # сборка results/ + INDEX.md
    ├── collect3.py                            # сборка третьей партии (4-я итерация)
    ├── lua_beautify.py                        # токен-безопасная нормализация минифицированного Lua
    ├── lua51_disasm.py                        # резервный дизассемблер Lua 5.1
    ├── build_luau.sh / build_ast.sh           # сборка Luau-рантайма без cmake
    └── luau_runner.cpp                        # раннер+REPL+loadstring+require для харнесса
```

Как повторить:

```bash
# 0. один вызов на любой обфусцированный файл: детект + деобфускация + PARTS.md
python3 deobf-report/tools/pipeline.py obfuscated.lua --out results/<игра>/<сэмпл> -v

# 1. Luraph v15 (нужен собранный Luau-рантайм)
deobf-report/tools/build_luau.sh && deobf-report/tools/build_ast.sh
cd Deobfuscator-Luraph-V15-master && node deob.js sample.lua -o out.lua

# 2. MoonSec V3 -> байткод -> ремонт -> unluac -> Lua
node moonsec-js-deobf/bin/moonsec.js -dev -i in.lua -o out.luac
python3 deobf-report/tools/lua51_repair.py out.luac out.fixed
java -jar PSU-Deobfuscator/tools/unluac.jar out.fixed --output out.lua

# 3. PSU 4.0/4.5 -> байткод -> ремонт -> unluac -> Lua
node PSU-Deobfuscator/src/cli.js in.lua --bytecode out.luac
python3 deobf-report/tools/lua51_repair.py out.luac out.fixed
java -jar PSU-Deobfuscator/tools/unluac.jar out.fixed --output out.lua

# 4. разбор частей (фичи/парты/URL)
python3 deobf-report/tools/extract_parts.py out.lua -o PARTS.md --game "King Legacy"
```
