# WeAreDevs v1.0.0 → «Main Game» (ESP + Silent Aim): полное раскрытие и дефект декодера (25 октября 2026)

**Ветка:** `arena/2cc60032-deobf`. **Вход:** файл, который пользователь дал в чате
(`Текстовый документ (2).txt`). **Итог:** тело раскрыто полностью — это клиент-чит
«Main Game» (WindUI, автор в заголовке окна — `big pickle`) с ESP, silent aim через хук
модуля снарядов, кругом FOV, fullbright и оверлеем производительности. **Игровых
обработчиков/remotes нет**, прав на перераспространение нет, поэтому в каталог ничего не
добавлено: счётчик остаётся **67 = 32 + 35 `(src)`**.

## Вход

| Поле | Значение |
| --- | --- |
| Файл | `Текстовый документ (2).txt` (пользовательский вход, происхождение/лицензия не подтверждены) |
| Размер / строк | 306 708 байт, одна строка |
| SHA-256 | `aba0ecbaf3e736216f8eaed05407227a022586c8245c4b64a2fa557acfb0d4f0` |
| Заголовок | `--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local N={...}` |
| Защита | WeAreDevs (WAD) v1.0.0 — семейство, для которого в репозитории уже есть закреплённый декодер |

## Результат

| Артефакт | Байты | Строки | SHA-256 |
| --- | --- | --- | --- |
| `standard.lua` — штатный вывод закреплённого декодера | 37 756 | 1 552 | `2ce3fd9e125e5cb24422c9e42dfe457b8fb706537ee99b0ce283276707ec46b2` |
| `complete.lua` — полное тело (релифт стадии + наш декодер строк) | 63 781 | 2 623 | `870c998ceb936c738fc851c52c5da3238a55e6e92eca9e4e53b5cf6021555b05` |

Оба файла лежат в игнорируемом `local-results/work_wad2/` (в Git не добавлялись — см. «Права»).

## Что делает скрипт

Один самодостаточный клиент (не хаб, не загрузчик), рассчитанный на шутер с
физическими снарядами: он читает дерево `workspace.Players.*` и `workspace.AI.*`,
находит `Humanoid`/`Head`/`HumanoidRootPart` и рисует ESP; «молчаливое» наведение
делает не через remotes, а **подменой `ReplicatedStorage.Modules.Client.Physics.Projectile.New`**
(через `require`, с восстановлением оригинала при выгрузке) и подтягиванием
`Modules.Shared.ModuleLoader:Load("CrosshairManager")` для прицела. Ни `FireServer`,
ни `InvokeServer`, ни сетевых запросов, кроме загрузки UI-библиотеки.

Составные части:

- **Конфиг** в `getgenv().__mainGame.cfg` (сохраняется между запусками):
  `ESP{Enabled, Players, NPCs, MaxDistance=1500, Box, BoxFill, Name, Health, Distance,
  Tracer, PlayerColor=255,70,70, NPCColor=255,170,40, UpdateRate=30, ScanInterval=0.15,
  MaxTargets=64}`, `Silent{Enabled, FOV=120, MaxDistance=10000, AimPart="Head",
  VisibleOnly, Prediction, TargetNPCs, PriorityPlayers, ShowFOV, FOVColor, FOVThickness,
  IgnorePlayers, AimAll, ExtendThrows, ForceTypes={Bullet,Rocket}, CrosshairTypes={Arrow},
  LobTypes={Grenade}}`, `Misc{PerfOverlay, Fullbright}`.
- **ESP** (`MainGameESP`, `DisplayOrder = 999999999`, родитель `gethui()`/`CoreGui`):
  пул переиспользуемых `Frame`/`TextLabel` (бокс, чёрный контур, заливка 0.15, имя,
  полоска HP с цветом по проценту 0.6/0.3, дистанция `[%d]`), обновление
  `RenderStepped` с ограничением `UpdateRate` (5–144 Гц) и пересканом цели
  `ScanInterval` (50–1000 мс), лимит отрисовки `MaxTargets` (8–200).
- **Silent aim**: хук `Projectile.New(origin, stats)` перехватывает локальные выстрелы
  (`stats.FromServer` игнорируются), классифицирует снаряд по `stats.Type`:
  `Force` (Bullet/Rocket, `ForceHitVector`), `Crosshair` (Arrow, поворот камеры +
  компенсация через `ScreenPointToRay`, до 3 итераций), `Lob` (Grenade, скорость = `Speed*0.5`,
  гравитация = `workspace.Gravity`), плюс «любой снаряд» при `AimAll`. Для
  `ExtendThrows` копия `stats` с `Drop = 0`. Подбор цели: угол до цели ≤ `FOV` (по
  умолчанию 120°), дистанция ≤ `MaxDistance` (урезается баллистическим пределом
  `min(max, (2v)²/drop·0.95)`), `IgnorePlayers`, `TargetNPCs`, приоритет игроков,
  опционально `VisibleOnly` (рейкаст). Баллистика — 3-итерационное решение
  квадратного уравнения с упреждением по `AssemblyLinearVelocity`; после выстрела
  камера и `CrosshairManager.AdjustSpring.Position` возвращаются как были.
- **Misc**: FOV-круг (проекция градусов в пиксели по `FieldOfView`/`ViewportSize`),
  fullbright через `Lighting` + `Atmosphere` с `BindToRenderStep("MG_Fullbright")` и
  восстановлением значений, оверлей `FPS/script ms/redraw/targets`, кнопки
  `Print debug` (счётчики `shots/redirected/types/lastAim`) и `Unload`
  (снимает хук, отключает соединения, удаляет объекты, чистит `getgenv()`).
- **UI**: WindUI, окно `Main Game` (`Author = "big pickle"`, `Folder = "main_game"`,
  `Icon = "crosshair"`), вкладки `ESP` / `Silent Aim` / `Misc`, глобальный тумблер по
  `Insert`, хоткеи `F1` (ESP) и `F2` (silent aim).

**Внешняя зависимость ровно одна:**
`https://github.com/Footagesus/WindUI/releases/latest/download/main.lua` (загружается
через `game:HttpGet` + `loadstring`). Телеметрии, вебхуков, paste-хостов и обращений к
`rscripts.net` в теле нет.

## Как раскрыто и где декодер теряет код

1. Закреплённый декодер ( `prostone4/Prometheus-Deobfuscator@6ee3291e` через
   [`scripts/prepare_pdeobf.py`](../scripts/prepare_pdeobf.py), `--force`) отработал
   без предупреждений и **детерминированно**: два прогона дали одинаковый
   `standard.lua`.
2. Аудит [`scripts/check_decoder_output.py`](../scripts/check_decoder_output.py):
   `loader_only`, `remotes = 0` — то есть формально это не «игровой код» по нашим
   критериям, а клиентский чит/UI.
3. **Найден новый дефект декодера.** В `standard.lua` остаются объявленные, но ни разу
   не заполненные локальные переменные (`local v27` без присваивания, `stats.redirected`,
   `stats.types`, `stats.lastAim` читаются, но никогда не пишутся) — исчезло **всё ядро
   silent aim**: подбор цели, баллистика, поворот камеры, `ForceHitVector`.
   Прогон с трассировкой по шагам показал точное место: шаг **`07-opt`** удаляет весь
   блок (после `03-str`, до `07-opt` в регионе есть `ScreenPointToRay` и `1e-7`, после —
   нет). Закреплённый инструмент **не правился**: это сломало бы воспроизводимость уже
   опубликованных WAD-разборов.
4. Обход без правки инструмента:
   - взят промежуточный кадр `05-if` (там блок цел, но строки ещё зашифрованы);
   - к нему применён только `03-str` (трижды) — это разрешает большую часть скрытых
     констант;
   - `07-opt` пропущен, дальше `08-vars → 09-fmt → 10-name → 11-scope` (получается
     `relift_noopt.lua`, 122 965 байт);
   - оставшиеся 1 452 зашифрованных литерала расшифрованы **нашим собственным
     декодером** [`scripts/wad_hidden_strings.py`](../scripts/wad_hidden_strings.py) —
     он воспроизводит схему WAD (`u42 = K % 255 + 2`, `u45 = K % 2**45`,
     `u45 = (u45*213 + 27552854471197) % 2**45`, `u42 = u42*201 % 257`, четыре байта из
     32-битного значения, `state = (byte + next + state) % 256` от 204) и проверен на
     парах, которые инструмент разрешил сам (`→ "Players"`, `"ESP"`, `"Frame"`, `"users"`).

Воспроизведение (нужен собранный декодер и `node`):

```bash
python3 scripts/prepare_pdeobf.py local-results/pdeobf-pinned/prostone4--Prometheus-Deobfuscator-6ee3291ec83f
node --max-old-space-size=6144 local-results/pdeobf-pinned/.../bin/pdeobf.js <вход> --force -o standard.lua
# промежуточный кадр и релифт — локальные скрипты local-results/work_wad2/{run_trace,lift_stage05}.js
python3 scripts/wad_hidden_strings.py rewrite relift_noopt.lua complete.lua
python3 scripts/wad_hidden_strings.py selftest
```

## Проверки

- Два прогона декодера: `standard.lua` побайтово одинаков (`2ce3fd9e…`).
- `complete.lua` воспроизводится нашим декодером из `relift_noopt.lua` **побайтово**
  (`870c998c…`, 1 452 замены).
- Синтаксис: `local-results/lua51/lua5.1` (`loadfile`) — **OK** для обоих файлов;
  `luau-compile --text` — **OK** для обоих.
- Полнота по маркерам: 36 из 36 ключевых строк (`ESP Enabled`, `ForceHitVector`,
  `ScreenPointToRay`, `AdjustSpring`, `CrosshairManager`, все вкладки/кнопки…) есть в
  `complete.lua`; в `standard.lua` отсутствуют ровно два — `ScreenPointToRay` и
  `ForceHitVector`, то есть потерян только aim-core.
- Новые тесты: [`tests/test_wad_hidden_strings.py`](../tests/test_wad_hidden_strings.py)
  (5 проверок: известные пары, независимость от ключа-«соли», разбор Lua-эскейпов,
  замена в тексте, идемпотентность). Всего в наборе теперь **108 тестов** (2 пропуска).
- `python3 scripts/verify_results.py` — 67 файлов; `python3 scripts/verify_sources.py` —
  46 архивов; `git diff --check` — чисто. Roblox не запускался.

## Ограничения и честные оговорки

- **Игра не подтверждена.** В теле нет ни названия игры, ни `PlaceId`; есть только
  пути модулей (`ReplicatedStorage.Modules.Client.Physics.Projectile`,
  `Modules.Shared.ModuleLoader`, `CrosshairManager`) и структура `workspace.Players`/`workspace.AI`.
  Поиск по этим путям в публичном GitHub кода не находит. Файл пришёл как продолжение
  разбора BloxStrike, но привязку к BloxStrike нельзя считать доказанной.
- **`complete.lua` не «чище» штатного вывода, а полнее.** Без `07-opt` в нём остаются
  несвёрнутые константы (`= 8093763 > 8912961` вместо `true`, `= 6675222 > 15380017`
  вместо `false`) — семантика та же (Lua-истинность), читаемость хуже; имена переменных
  машинные (`v31`, `u31`, `p48`).
- В `complete.lua` сохранён **водяной знак WAD** (первые ~40 строк с
  `math.random`/`gsub` и функция `f1()` с `error("Tamper Detected!")`, вызываемая в
  финальной «ловушке»). Штатный `standard.lua` этот страж снимает (`07-opt`: «resolved 1
  integrity guard(s)»). Для запуска полного тела страж нужно вырезать — мы этого не
  делали, файл приведён как есть.
- Поведение в Roblox не проверялось; эквивалентность оригиналу доказана статически
  (детерминированный декод + сверка литералов + компиляция), но не исполнением.
- Целиком опереться на `standard.lua` нельзя: в нём отсутствует ядро silent aim.

## Права

Лицензия и разрешение на перераспространение у входа **не подтверждены** (файл передан
пользователем, источника/репозитория нет). Поэтому ни `standard.lua`, ни `complete.lua`,
ни вход в Git и в каталог `dobf scripts 1.0/` не добавлены; в отчёте — только описание
поведения, имена функций и короткие строковые константы. Если владелец каталога
подтвердит права, файл можно оформить как `ui_library`/чит-клиент (не «игровое тело»):
remotes и игровых обработчиков в нём нет.

## Заметки для следующего прохода

- **Дефект `07-opt` в закреплённом WAD-декодере — новый и воспроизводимый.** Симптом:
  объявленные-но-не-заполненные локали и «пустые» ветки; лечится релифтом стадии
  `05-if` с пропуском `07-opt` (рецепт выше). Кандидат на отдельный отчёт/тест, как это
  было с дефектом `goto` в `src/vm/structure.js`, но править vendored-код ради
  опубликованных хешей не стоит.
- Наш декодер скрытых строк (`scripts/wad_hidden_strings.py`) пригодится и на других
  WAD-входах: он не исполняет payload и обходится без `math.random`.
