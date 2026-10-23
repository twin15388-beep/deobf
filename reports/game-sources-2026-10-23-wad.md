# Три новых WAD-восстановления: Slap Battles, Prison Life и Work at a Pizza Place — 23 октября 2026

**Добавлены три игровых Lua, раскрытых из защищённых входов, и ни одного нового `(src)`.** В [`dobf scripts 1.0/`](../dobf%20scripts%201.0/README.md) теперь **66 файлов: 31 восстановление/частичный результат и 35 прежних `(src)`**. Все три — полное статическое раскрытие WeAreDevs/WAD: тело вывода декодера перенесено целиком (в одном случае — минус одна строка, см. ниже), добавлены только наши заголовки с происхождением и полные тексты MIT-лицензий. Входы взяты из уже закреплённых MIT-коммитов через `git clone`; Pastefy и API для получения скриптов не использовались, ключи не подбирались, защищённый top-level не исполнялся, Roblox не запускался. [Манифест с SHA-256](game-sources-2026-10-23-wad.json).

> **Предел проверки.** Для всех трёх файлов есть только **статические** проверки тела и компиляция Lua 5.1 (14/15/14 утверждений). Поведенческих макетов нет сознательно: top-level каждого скрипта строит GUI или Drawing-объекты, регистрирует действия ContextActionService, а два из трёх ещё и исполняют внешние UI-библиотеки через `loadstring(game:HttpGet(...))`, так что макет проверял бы в основном сам макет. В манифесте у всех трёх `mock_game_assertions: 0`, и [`verify_results.py`](../scripts/verify_results.py) не принимает такой файл без `static_body_assertions`.

## Входы, инструменты и хеши

| Игра | Защищённый вход (закреплённый коммит, MIT) | Вход | Результат |
| --- | --- | --- | --- |
| Slap Battles | [`CelerityRBLX/Roblox@5fe709f2`](https://github.com/CelerityRBLX/Roblox/blob/5fe709f2a15f8b9e900529bc32d6badb78437607/Slap%20Battles/Tryhard%20AI%20Demo.lua), `Slap Battles/Tryhard AI Demo.lua`, WAD v1.0.0 (баннер есть) | 250 479 байт, `71dd77491da4f847ff87ecc3303b01a8973c6d36e007cbcaba8d5ee2490d5a67` | [Slap Battles - Tryhard AI Demo.lua](../dobf%20scripts%201.0/Slap%20Battles%20-%20Tryhard%20AI%20Demo.lua), 39 746 байт (тело 36 249 / 1 149 строк), `50b539dd90e82201b454e9ab051a625d939dd6c39fbaec69b194225a3db5ca55` |
| Prison Life | [`volmaksDev/My-Scripts@231da028`](https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/Prison%20Life), файл `Prison Life`, **без** баннера v1.0.0 (`--force`) | 250 071 байт, `ba3ecd9f3315cf751c7bef4d5825661704e7546285182f4bf1ba798d504ae547` | [Prison Life - volmaks ESP Freecam.lua](../dobf%20scripts%201.0/Prison%20Life%20-%20volmaks%20ESP%20Freecam.lua), 29 945 байт (тело 25 760 / 1 090 строк), `ce8afdaf2f324ba29b9297bba7e02fc8947555d62ad14b695eb38370515580ca` |
| Work at a Pizza Place | [`volmaksDev/My-Scripts@231da028`](https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/Additional/Orders/Order4.lua), `Additional/Orders/Order4.lua`, WAD v1.0.0 (баннер есть) | 276 344 байт, `796bb79caa7a4f6007ad692376ed9f93eff233204943fb77ed62976d1bd0d3c3` | [Work at a Pizza Place - Order4.lua](../dobf%20scripts%201.0/Work%20at%20a%20Pizza%20Place%20-%20Order4.lua), 36 002 байт (тело 32 083 / 1 244 строки), `32b4c26b698205df649d5c8cc520530bc26e9a16bb5a0cf328a6c639cc963706` |

SHA-256 тел после раскрытия: `d361a868982123ee11967e68838621d991cadb99bf0618089c1a22343c79459d` (Slap Battles), `386b65e3930a8c119b6f578050d7377e41687784621a1385fce35b8bf5f2c3f7` (Prison Life), `8c44e114dbb72d3f89447a3d35deed150b59fc3fe67844f587c4ef6780f38113` (Pizza Place). Инструмент — закреплённый [`prostone4/Prometheus-Deobfuscator@6ee3291e`](../sources/manifest.json) через [`prepare_pdeobf.py`](../scripts/prepare_pdeobf.py); повторный прогон побайтово тот же. Лицензии обоих репозиториев (MIT, SHA-256 `24ba1203…` и `c5a94d03…`) вставлены в заголовки между `MIT LICENSE BEGIN/END`. Имена `f1..f21`, `v1..v90`, `p1..p30` **назначены декодером**; заголовки и пояснения — работа составителя.

## Что именно восстановлено

### Slap Battles — Tryhard AI Demo (авто-бой, без внешних загрузок)

Игровая привязка в самом коде: `workspace.Arena`, `workspace.Lobby.Teleport`, `replicatedStorage.Slap` и `replicatedStorage:FindFirstChild(name .. "Slap")`, `replicatedStorage.GeneralHit`/`SnowHit`, поле `LastSlappedBy` у персонажей.

- `f5(p5)` — выбор перчатки (для `Default` — `replicatedStorage.b`, для остальных — `GeneralHit`/`SnowHit`); `f13(p6)` — привязка `MouseButton1Click`/`TouchTap` к `f5`.
- `f6(p8)` — привязка к персонажу: `Humanoid` с таймаутом 10 с, `LoadAnimation(slap)` на `Animator`, цикл `repeat wait()`.
- `f8(p10, p11)` — слежение за `LastSlappedBy`: при совпадении с именем локального игрока выбирается случайная цель; `f9(p12)` — класс приоритета (2/3/4 по спискам `v20`/`v22`); `f3(p13)` — ближайший игрок в 50 studs и не ближе 1.25; `f10(p14)` — `workspace:Raycast(p14, Vector3.yAxis * -10, v2)` перед `Humanoid:MoveTo`.
- `f1()`/`f11()` — два цикла авто-боя с атакой `b:FireServer(humanoidRootPart)`; `f2()` — баннер статуса с `Debris:AddItem(instance8, 10)`.
- `f15()` — панель `"Control Panel"` (DisplayOrder 123), `f16()..f21()` — шесть тумблеров: вкл/выкл ИИ, перебор целей `v85/v86`, режим `"Rigged"`, значение 100↔400.

**Дефект оригинала, из-за которого скрипт сейчас мёртв:** весь код внутри `if v1 then`, где `v1 = tick() < 1763809636.9279 and tick() > 1763204836.9279` — окно **с 2025-11-15T11:07:16Z по 2025-11-22T11:07:16Z**. Оно истекло, поэтому тело лишь печатает остаток секунд; дополнительно `getgenv().BSF` блокирует повторный запуск. Это свойство входа, а не деобфускации: в выводе декодера условие присутствует дословно. Внешних загрузок нет вообще (ни `HttpGet`, ни `loadstring`), но есть отправка чата `textChatService.TextChannels.RBXGeneral:SendAsync`.

### Prison Life — ESP и свободная камера (без единого remote)

Игровая привязка: `workspace.CellDoors`, `workspace.Doors`, `workspace.Prison_Fences`, `workspace.Prison_ITEMS`, команды `Guards`/`Inmates`/`Criminals`.

- ESP на executor-библиотеке `Drawing`: `v7:createComponents()` собирает `Box` (`"Square"`, Thickness 1), `Tracer` (`"Line"`), `HP` (`"Line"`) и `Name` (`"Text"`), кэш в `espCache`; `f16(p30)`/`f17()` рисуют скелет по R6/R15-именам частей (`Torso`/`UpperTorso`, `Left Arm`/`LeftUpperArm`, `Left Leg`/`LeftUpperLeg` …); `f8(p24)` — имя команды, `f15(p29)` — цвет (Guards = `Color3.fromRGB(0, 0, 255)`); `f9(p25)` — world-to-screen; `f10()` — проверка видимости рейкастом из камеры.
- Свободная камера: `StartFreecam`/`StopFreecam`, `v22.Start`/`Stop` с `BindAction "FC_KEYS"/"FC_MOUSE"/"FC_WHEEL"`, скорость `clamp(v25 + p8 * (Up - Down) * 0.75, 0.05, 4)`, ускорение `LeftShift`, панорама `* 0.05`, зум колесом; `v26.Push`/`Pop` сохраняют CFrame/FOV/CameraType/MouseBehavior.
- Сглаживание `v14.new(f, p2)`/`v14:Update(p3, p4)`/`v14:Reset(p6)` (демпфер `exp(-v15 * p3)`), полный свет `f4(p7)` (Brightness 3, ClockTime 12, FogEnd 1000000000), `f6(p19)` — `setfpscap(0)`/`setfpscap(60)`.
- **Тело не вызывает ни одного remote** (`FireServer`/`InvokeServer` отсутствуют) — только клиентская визуализация.

**Единственное изменение относительно вывода декодера (задокументировано в заголовке, манифесте и проверках):** удалена одна строка `      goto L9209319` (строка 37 сырого вывода, 20 байт). Декодер выдал этот continue-переход **без метки**, поэтому файл не компилировался; `goto` был последним оператором тела цикла проверки подписки перед `until not nextPageCursor`, так что удаление равносильно проваливанию в проверку цикла. Проверка: `tests/test_wad_batch2_static.lua` утверждает, что `goto ` в теле больше нет, а [`verify_results.py`](../scripts/verify_results.py) требует ненулевого `modifications`, если в теле встречается `goto `.

**Риск приватности:** стартовый гейт `f1(p1)` постранично читает `https://friends.roproxy.com/v1/users/<userId>/followings?limit=100` через `game:HttpGet` и продолжает только если найден id `583171793` — то есть список ваших подписок уходит стороннему прокси. Внешние зависимости: `AdvancedUtils.lua` (mutable raw-URL того же репозитория, вызывается `init()`) и WindUI (mutable release-URL).

### Work at a Pizza Place — Order4 (авто-менеджер и награды)

Игровая привязка: `workspace.Customers`, `workspace.Ovens`, `ManagerChair`, `Capsule Machines`, `CheesePizza`/`PepperoniPizza`/`SausagePizza`, `"Pizza Boxer"`, станции `Cashier Area`/`Delivery Area`/`Boxing Area`, сиденья `Driver`/`HoodSeat`.

- Игровые remote: `replicatedStorage.ManagerChannel:FireServer("GiveBonus", v56)` и `FireServer("EmployeeOfTheDay", v56)` после чтения счётчиков через `v15:SendData("GetCounters", "ManagerChannel", 2, game.Players.LocalPlayer)`; `FireServer("OrderComplete", v67, "I'll take your order and then I'll eat your food")` в цикле кражи заказов.
- Хелперы: `GetVehicle()` (пустое сиденье `Driver` + `HoodSeat`), `GetCurrentVehicle()` (`Humanoid.SeatPart`), `GetManager()` (`Teams.Manager:GetPlayers()[1]`), `FindFirstCustomer()` (`workspace.Customers` c `Head`), `f6(p10)` — смена команды, `TP(p4, cframe)`, `startFly`/`stopFly`, `f2()` — WalkSpeed/JumpPower, `f3(p3)` — CharacterAdded.
- Тумблеры дословно: `"Auto bonus"`, `"Auto employee of the day"`, `"Auto claim manager role"`, `"Auto claim fire extinguisher"`, `"Auto steal items"` (`StealAllBoxes` → `Script.AutoStealItems`), `"Enable Fling"`, `"Enable Gravity"`, `"Enable JumpPower"`, `"Enable Noclip"`, `"Enable WalkSpeed"`, слайдер скорости полёта; клавиши — W/A/S/D/Space/LeftShift.
- **Тратит/заявляет игровые награды от вашего имени** и двигает персонажа (Fling/Gravity/Noclip). Внешние зависимости: `Linoria.lua`, `ThemeManager.lua`, `SaveManager.lua` — три `loadstring(game:HttpGet(...))` с изменяемых raw-URL того же репозитория.

## Проверки и воспроизведение

```bash
python3 scripts/prepare_pdeobf.py local-results/pdeobf-pinned
node --max-old-space-size=6144 \
  local-results/pdeobf-pinned/prostone4--Prometheus-Deobfuscator-6ee3291ec83f/bin/pdeobf.js \
  local-results/inputs/SB-Tryhard.lua --force -o local-results/wad-out/sb-tryhard.lua

python3 scripts/prepare_lua51.py local-results/lua51          # интерпретатор Lua 5.1.1
for c in slapbattles prisonlife pizzaplace; do
  local-results/lua51/lua5.1 tests/test_wad_batch2_static.lua '<опубликованный файл>' "$c"
done
```

- [`tests/test_wad_batch2_static.lua`](../tests/test_wad_batch2_static.lua) — **14 / 15 / 14** статических утверждений: компиляция Lua 5.1 через `loadstring` (без исполнения), игровые remote и пути workspace, тумблеры, видимые дефекты (окно времени у Slap Battles, гейт подписки у Prison Life, mutable UI-зависимости у Pizza Place) и отсутствие `goto `, `pastefy.app`, а у Prison Life — отсутствие любых `FireServer(`/`InvokeServer(`.
- [`tests/test_wad_game_results.py`](../tests/test_wad_game_results.py) — 6 Python-тестов на оба WAD-манифеста (5 артефактов): закреплённые MIT-входы и побайтовость тел, неизменность лицензий, честные поля `verification`, **все хосты из тела обязаны быть объявлены** в `external_dependencies`/`limitations` (эта проверка и выявила недокументированную ссылку `discord.gg` в Credits-вкладке YBA — она добавлена в манифест 22 октября), отказ верификатора при подмене числа проверок/хеша лицензии/подмене входа на выход и при незарегистрированном файле. Без интерпретатора Lua тест сравнения чисел **пропускается**, а не засчитывается.
- Полный прогон: 74 Python-теста + 6 (итого 80), [`verify_results.py`](../scripts/verify_results.py) — **66 опубликованных игровых файлов** и 7 манифестов, [`verify_sources.py`](../scripts/verify_sources.py) — 40 архивов, `node --test tests/test_psu_fixed_calls.mjs` — 1 тест, `git diff --check` чисто.

## Отрицательные результаты и сознательно неопубликованное

- **`Fling Things And People.lua`** (volmaksDev/My-Scripts, MIT) раскрыт полностью — 32 332 байта, 1 253 строки, игровые маркеры `replicatedStorage.GameCorrectionEvents`, `MenuToys`, `FirePlayerPart`, `GrabParts` — но **не опубликован**: тело загружает внешний код с `https://paste.ee/r/7X7NLEPB`. Непроверяемые paste-хосты в публикуемом артефакте противоречат правилам каталога.
- **`Additional/test2.0.lua`** (тот же репозиторий) раскрыт — 35 176 байт, 1 421 строка — но **не опубликован**: игру по маркерам (`"Auto Battle"`, `"Manual Fuse"`, `" stars"`, адрес кошелька `0xFDe67e2fD7EEfC02545A510B0087a29F24ceb3FA`) однозначно установить не удалось, а публиковать игровой результат без установленной игры нельзя.
- **`Jujutsu Shenanigans/Sun Rage.lua`** (CelerityRBLX, MIT) — после распаковки получается копия loader'а, игрового кода нет.
- **Slap Battles, остальное:** `Slap Farm/{Regular,Killstreak,No One Shot,New Players}.lua` и `Tycoon Farm.lua` — MoonSec V3 (инструмент на C#, в среде нет .NET); `Legit Slap Farm.lua` и `Car Keys Mastery.lua` — Fairifyer Obfuscator (инструмента нет); `Chara.lua` — открытый исходник, то есть `(src)`, который сейчас не добавляем.
- **volmaksDev/My-Scripts, остальное:** `Additional/testR.lua` — Luraph v14.7, `Additional/tst.lua` — Luraph v14.8 (рабочего инструмента нет), `Additional/d.lua` — дамп числовых констант VM, `luraph.lua`/`meshes2.0.luau`/`mm2_meshes`/`UI.lua`/`Linoria.lua`/`WindUI.lua` — не игровой код.
- **Пять приоритетных игр** (Lone Survival, Trident Survival, Slayers 2, GPO, King Legacy) нового допустимого входа по-прежнему не дали: см. [отчёт 22 октября](game-sources-2026-10-22-wad.md#отрицательные-результаты-этого-прохода). Счётчик по ним не менялся.

**Контроль:** сырые входы, выводы декодера, клоны сторонних репозиториев и собранный интерпретатор лежат в игнорируемом `local-results/` и в Git не добавлены; HAR, ключи и чужие защищённые образцы не коммитились.
