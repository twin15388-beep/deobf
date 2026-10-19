# Игровая статическая деобфускация — 19.10.2026

**Результат:** 9 файлов / 7 заявленных игр (350 454 байта Lua), из них King Legacy — **только ограниченный фирменный core UI/ESP, не игра-специфичный фарм**. Остальные имеют конкретные объекты/события названного режима. [Читаемые выходы и функции с параметрами](../dobf%20scripts%201.0/README.md) · [коммиты источников и SHA-256 каждого входа/выхода](game-recovery-2026-10-19.json). Старые отклонённые игровые файлы и отчёты удалены. Ни один выход не испытан в Roblox.

| Игра | Входящий защищённый файл | Выход | Постпроход | Результат |
| --- | --- | --- | --- | --- |
| Jujutsu Shenanigans | `pantheon111/jjs:jujutsu_shenanigans_obfuscated.lua` | [Pantheon Hub](../dobf%20scripts%201.0/Jujutsu%20Shenanigans%20-%20Pantheon%20Hub.lua) | нет | 29 257 байт, Luau компилируется; неразрешённые глобалы, внешняя UI |
| Jujutsu Shenanigans | `Inquesthub/movesetJJS:obfuscated_script-1764581181505.lua` | [Inquest Moveset](../dobf%20scripts%201.0/Jujutsu%20Shenanigans%20-%20Inquest%20Moveset.lua) | нет | 58 299 байт, Luau компилируется; сложные ветвления не доказаны |
| King Legacy | `SAO412/kl-scripts:core.lua` | [Luxury Core](../dobf%20scripts%201.0/King%20Legacy%20-%20Luxury%20Core.lua) | AST-развёртывание | 32 783 байта, только UI/ESP уровня/PVP, не автобот |
| Violence District | `ayamnubchh/Violence-District-Roblox-Script:ANCH-Hax.lua` | [ANCH Hax](../dobf%20scripts%201.0/Violence%20District%20-%20ANCH%20Hax.lua) | узкий `goto`-патч | 38 095 байт, ремонт генераторов и ESP, Luau компилируется |
| Illegal Soccer | `Pitaya-real/Illegal-Soccer:main.lua` | [Smart GK](../dobf%20scripts%201.0/Illegal%20Soccer%20-%20Smart%20GK.lua) | AST-развёртывание | 25 876 байт, мяч и ворота команды, Luau компилируется |
| Murder Mystery 2 | `LYERHUB/MM2-azure:README.md` | [Azure Hub](../dobf%20scripts%201.0/Murder%20Mystery%202%20-%20Azure%20Hub.lua) | нет | 38 490 байт, роли/ESP/стрельба, Luau компилируется |
| Murder Mystery 2 | `digobott-cmd/MurderMystery2Script:README.md` | [KS Hub](../dobf%20scripts%201.0/Murder%20Mystery%202%20-%20KS%20Hub.lua) | нет | 33 132 байта, роли/ESP, Luau компилируется |
| Blue Lock Farm | `TaiTonKung/BlueLockFarm:README.md` | [RELWX](../dobf%20scripts%201.0/Blue%20Lock%20Farm%20-%20RELWX.lua) | нет | 54 727 байт, конвейер/юниты/мутации, Luau компилируется |
| Wild Horse Islands | `oihi173/Whifa:README.md` | [WHI Farm](../dobf%20scripts%201.0/Wild%20Horse%20Islands%20-%20WHI%20Farm.lua) | узкий `goto`-патч | 39 795 байт, дикие лошади/гонки/тренировки, Luau компилируется |

## Процесс и воспроизведение

1. Найдены именно **обфусцированные входы**, а не открытые игровые исходники; каждый вход привязан к GitHub-репозиторию, точному коммиту, пути и SHA-256 в JSON-отчёте. Файлы `README.md` у четырёх источников содержат обфусцированный Lua непосредственно. Источники **не взяты с pastefy.app** и никакие API-доступы к скриптам не использовались.
2. Статически применён локальный снимок [prostone4/Prometheus-Deobfuscator](https://github.com/prostone4/Prometheus-Deobfuscator) `6ee3291ec83fdc58c04e17bb1f1703386619711a` (`sources/prostone4--Prometheus-Deobfuscator.zip`); [`scripts/prepare_pdeobf.py`](../scripts/prepare_pdeobf.py) проверяет хэш архива и исправляет две опечатки в парсере/проходе CFG (`BLOCK_TERMINATORS` → `TERMINATORS`, определение границ `TAIL_STATEMENTS`/`TAIL_NODES`). Проводились только чтение и преобразование исходного текста; игровая программа **не исполнялась**. В выходах остаются понятные фрагменты с вызовами игровых `Remotes`, UI, обработчиков, а не сама защитная VM.
3. Для `King Legacy`/`Illegal Soccer`: [`scripts/unflatten_game_lua.cjs`](../scripts/unflatten_game_lua.cjs) по AST разворачивает только доказуемо завершающиеся числовые диспетчеры (`28` и `19` соответственно) и однократные циклы (`19` и `24`). Для настоящих/непонятных циклов преобразование не применяется (`remainingLoops=0` в этих двух файлах относится к рассматриваемым `while true`, а не к *любым* циклам в программе). Проверено независимыми синтетическими тестами порядка ветвей.
4. Для Violence District точечный [`repair_violence_district_goto.py`](../scripts/repair_violence_district_goto.py) заменяет **только один известный шаблон** из трёх переходов к общему `return`; для WHI [`repair_wild_horse_goto.py`](../scripts/repair_wild_horse_goto.py) дублирует `task.wait()` в ветке, из которой единственный переход в неё направлен. Оба патча отказываются обрабатывать иной шаблон. Это контроль синтаксиса и локальной структуры, **не** доказательство эквивалентности целого файла.
5. Все девять файлов прошли `luau-compile --null <файл>` в CLI из [Luau](https://github.com/luau-lang/luau) commit `9d7748a4f324213a18cb8283fa2a77c330225fa0`. Кроме того, [`verify_results.py`](../scripts/verify_results.py) сверяет inventory/размеры/SHA-256 с JSON; это также не запускает Lua.

Воспроизведение для отдельного входа, где `REPO`, `COMMIT`, `PATH` берутся **без изменений** из `game-recovery-2026-10-19.json`:

```bash
# Используйте свою временную директорию; показан пример для Pantheon JJS.
git clone --no-checkout https://github.com/pantheon111/jjs.git /tmp/jjs-recovery
# Если коммита ещё нет в локальном клоне: git -C /tmp/jjs-recovery fetch origin a5c3df2b86bc119e747a2e47374a6e7f17ad9371
git -C /tmp/jjs-recovery show a5c3df2b86bc119e747a2e47374a6e7f17ad9371:jujutsu_shenanigans_obfuscated.lua > /tmp/input.lua
PDEOBF_ROOT=$(python3 scripts/prepare_pdeobf.py)
node "$PDEOBF_ROOT/bin/pdeobf.js" /tmp/input.lua -o /tmp/result.lua
python3 scripts/verify_results.py
```

Для прочих файлов использован тот же `node "$PDEOBF_ROOT/bin/pdeobf.js" in.lua -o out.lua`, после чего для **двух** расплющенных файлов:

```bash
node scripts/unflatten_game_lua.cjs "$PDEOBF_ROOT" out.lua structured.lua
```

Для Violence District/WHI применяется соответствующий `python3 scripts/repair_*_goto.py out.lua structured.lua`; не запускайте неизвестный Roblox-скрипт, чтобы воспроизвести статический вывод. Для локальных тестов: `python3 -m unittest discover -s tests` и `PDEOBF_ROOT=$(python3 scripts/prepare_pdeobf.py) node --test tests/test_unflatten_game_lua.cjs`.

## Ограничения, отказы и отрицательные проверки

- **GPO не восстановлен.** У `0xRinFin/GPO` и `AdelOnTheTop/Adel-Hub` входы под Luraph v13.x: источники v14.x/v15.x в коллекции нельзя выдавать за декомпилятор v13. `CFA-HUB/CFAHub-Free:SeaHubCrackGPO.lua` статическим `memcpython/PSU-Deobfuscator` был поднят в Lua 5.1 bytecode (`unknownInstructions=0`), `unluac-js@1.4.4` вернул компилируемый фрагмент, однако действия — `Events.CIcklcon:FireServer(...)` и `Humanoid:ChangeState(11)` — **не подтверждают связь с Grand Piece Online**. Этот файл не опубликован. Другие открытые GPO-исходники уже читались без деобфускации и также не выдаются за результат.
- **Blox Fruits:** PSU-лифтер поднял байткод, но `unluac-js` вернул `diagnostic-pseudocode`/`unresolved HIR expression: open-pack`; Lua-кода для публикации нет. `pdeobf --force` на других PSU/Boronide-входах оставлял VM, поэтому его принудительный вывод не используется.
- **Case Paradise:** у MoonVeil v1.4.5 `--no-verify` вывел компилируемый текст, но проверка выявила присваивание `true` в ветке для `false` и обращение `.Panel` к `false`: это сломанная реконструкция. **Night** содержит только ключевой интерфейс и внешний загрузчик, не обработчики игры; **Ride a Pet** вход заканчивается посреди выражения; **Grow a Garden** дал только загрузчик удалённого кода с параметром webhook, без локальной игровой логики. Они не публикуются. Аналогично отброшен GUI-лоадер из `Obfuscado-big-bang` и общий скрипт сиденья/телепортации из `script-fuga`.
- `AnnonyA/WAD-deobf` на части игровых WAD сообщил `valid WAD alphabet not found` / `WAD VM dispatcher not found`; `yennylol/unprom` на большом входе — `RecursionError`. Эти ошибки не приравнены к полному восстановлению.
- King Legacy `core.lua` — **промежуточный** результат: брендированный UI, ESP и отображение PvP/уровня, но ESP и выбор игрока могут быть применимы к нескольким играм. Он намеренно не называется специфичным фармом King Legacy. В Illegal Soccer остаётся присваивание `v220` без объявления `local`. В Pantheon остаются неразрешённые глобалы; у других выходов остаются внешние UI-загрузки. Все эти файлы требуют независимого аудита перед использованием.
- Публичность GitHub-репозитория **не означает свободную лицензию**: в девяти исходных снимках не обнаружен `LICENSE`. Атрибуция, полный URL и коммиты приведены в JSON; права на повторную публикацию необходимо проверять отдельно.

**Проверено только:** наличие вывода, снятие соответствующей защитной оболочки, понятность конкретных фрагментов и компиляция. **Не проверено:** запуск в Roblox, актуальность ремоутов и объектов, эквивалентность исходному защищённому сценарию, безопасность внешних ссылок.
