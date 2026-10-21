# Два полных WAD-восстановления: Your Bizarre Adventure и Jujutsu Shenanigans — 22 октября 2026

**Добавлены два игровых Lua, раскрытых из защищённых входов, и ни одного нового `(src)`.** В [`dobf scripts 1.0/`](../dobf%20scripts%201.0/README.md) теперь **63 файла: 28 восстановлений/частичных результатов и 35 прежних `(src)`**. Оба новых файла — **полное статическое раскрытие** WeAreDevs/WAD v1.0.0 (не частичная реконструкция): тело вывода декодера скопировано без изменений, добавлен только наш заголовок с происхождением и лицензией. Входы взяты из закреплённых MIT-коммитов через `git clone`; Pastefy и API для получения скриптов не использовались, ключи не подбирались, защищённый top-level не исполнялся, Roblox не запускался. [Манифест с SHA-256](game-sources-2026-10-22-wad.json).

> **Предел проверки.** Компиляция Lua 5.1 доказывает синтаксис, а макетные проверки — только то, что восстановленный код делает на подставных объектах. Ни один файл не проверялся в Roblox, приём сервером игровых remote не подтверждён, поведенческая эквивалентность незащищённому оригиналу не утверждается. Повторный прогон декодера дал **побайтово тот же** SHA-256 для обоих тел — это воспроизводимость инструмента, а не доказательство полноты.

## Входы, инструменты и хеши

| Игра | Защищённый вход (закреплённый коммит) | Размер / SHA-256 входа | Результат |
| --- | --- | --- | --- |
| Your Bizarre Adventure | [`volmaksDev/My-Scripts@231da028`](https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/YBA.lua), файл `YBA.lua`, MIT (LICENSE, SHA-256 `24ba1203a72495d8537a3b1eabfa866255cb91e0f83b2e65694f5fe76d098af7`) | 261 300 байт, `f86244ca7b694f450f42182039bce37f4d296c5639c1c9f85f35cf5d636f40ff` | [Your Bizarre Adventure - Revenge Hub.lua](../dobf%20scripts%201.0/Your%20Bizarre%20Adventure%20-%20Revenge%20Hub.lua), 39 566 байт (тело 36 413 / 1 353 строки), SHA-256 `c50a3769ab8933b39348c79627671c54d6f7524a1d667acb08f4ffbf46edab96` |
| Jujutsu Shenanigans | [`CelerityRBLX/Roblox@5fe709f2`](https://github.com/CelerityRBLX/Roblox/blob/5fe709f2a15f8b9e900529bc32d6badb78437607/Jujutsu%20Shenanigans/Sonic.lua), файл `Jujutsu Shenanigans/Sonic.lua`, MIT (LICENSE, SHA-256 `c5a94d034dc2fab5214ebf257c0a507ac7be47199f1371a4fe63d786b205bad7`) | 272 712 байт, `dd255706af4fddd62f16a0ce814c1b1da6c88f8e0ec8cf76ae5236b6e28d8b57` | [Jujutsu Shenanigans - Sonic Moveset.lua](../dobf%20scripts%201.0/Jujutsu%20Shenanigans%20-%20Sonic%20Moveset.lua), 43 025 байт (тело 39 719 / 1 472 строки), SHA-256 `798c0be68288f551790f38f4a862a2f4150c07c8b669ccdcfbb49d3702b022cf` |

Оба входа начинаются с `--[[ v1.0.0 https://wearedevs.net/obfuscator ]]`. Инструмент — уже закреплённый в репозитории [`prostone4/Prometheus-Deobfuscator@6ee3291e`](../sources/manifest.json) через [`scripts/prepare_pdeobf.py`](../scripts/prepare_pdeobf.py) (две локальные правки опечаток парсера/переходов). Его интерпретатор не обращается к сети и не вызывает Node-API: `os`/`io`/`debug` внутри Lua-окружения — JS-заглушки (`os.exit` бросает ошибку, `io.write` пишет в буфер), `child_process`/`http`/`fetch` в `src/` отсутствуют. SHA-256 тел после двух прогонов: `f8a9821d6257b7e402a3e64e533febd1ee71b158acc004207427f72b4a2c1ba0` (YBA) и `7cd429ed7fa480b1d009438b756fbcea71fff0d3792d956cb205e28bab9bf2f4` (JJS).

**Происхождение и права.** `volmaksDev/My-Scripts` — MIT («Copyright (c) 2025 UnnamedDeveloperFromUA»), README прямо говорит, что это собственные скрипты автора. `CelerityRBLX/Roblox` — MIT («Copyright (c) 2025 Celerity»), личная подборка по играм. Полные тексты лицензий вставлены в заголовки результатов между маркерами `MIT LICENSE BEGIN/END`; их SHA-256 сверяет [`scripts/verify_results.py`](../scripts/verify_results.py). Имена `f1..f25`, `v1..v55`, `p1..p26` **назначены декодером**, это не имена автора; заголовки и пояснения — работа составителя.

## Your Bizarre Adventure: что именно восстановлено

Игровая привязка видна в самом коде, а не только в названии: `workspace.FastTravel["Merchant's Keep"|"Parking Lot"|"Prison Bridge"|"Train Station"|"Via Toledo"|"Via dell'Oceano"].TeleportTo.Value.Position`, `players.LocalPlayer.PlayerStats.Money`, `PlayerStats.Stand/Race`, список из 16 предметов YBA (`Mysterious Arrow`, `Rokakaka`, `Gold Coin`, `Diamond`, `Pure Rokakaka`, `Quinton's Glove`, `Steel Ball`, `Rib Cage of The Saint's Corpse`, `Zepellin's Headband`, `Zeppeli's Hat`, `Caesar's Headband`, `Clackers`, `Stone Mask`, `Ancient Scroll`, `Dio's Diary`) и диалог продавца `NPC = "Merchant"`.

| Обработчик (имя декодера) | Параметры | Что делает и чем опасен |
| --- | --- | --- |
| `f9()` | — | Инициализация Money Farm: проверяет Character/HumanoidRootPart/CurrentCamera, ищет `workspace.Item_Spawns.Items`, подключает `ChildAdded`/`ChildRemoved`/`CharacterAdded`, возвращает функцию остановки (Disconnect, очистка очереди, `CameraType = Custom`). |
| `f19(item)` | `item: Instance` из `Item_Spawns.Items` | Подбор предмета: телепорт на `+3 studs`, Scriptable-камера на `+6 studs`, дистанция из `ProximityPrompt.MaxActivationDistance` (иначе 6), две попытки с опросом 0,2 с, возврат камеры, пауза 0,3 с. |
| `f18()` | — | Нажатие `E` через `VirtualInputManager:SendKeyEvent` с удержанием **0,22 с**. |
| `f13(position)` | `position: Vector3` | Фарм-телепорт по Lerp; скорость из `_G.TeleportSpeed` (по умолчанию 15), множитель 0,07, прерывается флагами `_G.MoneyFarm_Enabled/_G.MoneyFarm_Stop`. |
| `f22(character)` | `character: Model` | **Бесконечный** цикл продажи: перебирает `Tool` из Backpack, для 16 имён списка делает `Humanoid:EquipTool`, ждёт 1 с, продаёт с троттлингом 0,5 с на имя. |
| `f21(tool)` / `f20(character)` | `tool: Tool`, `character: Model` | Продажа через `character.RemoteEvent:FireServer("EndDialogue", {Option="Option2", Dialogue="Dialogue5", NPC="Merchant"})`; ищет remote с таймаутом 3 с. |
| `f11()` | — | `Character.RemoteEvent:FireServer("PurchaseShopItem", {ItemName="1x Lucky Arrow"})`; цикл покупки раз в **2 с** при `Money.Value >= 50000` — **тратит игровые деньги**. |
| `f6()` | — | «YBA god mode»: каждый Heartbeat ставит `HumanoidRootPart.CFrame` чужих моделей из `workspace.Living` на CFrame локального игрока, пропуская список игнорирования. Репликация не гарантирована. |
| `f10(kind, enabled)` / `f7(adornee, kind, text)` | `kind: playerEsp\|standEsp\|raceEsp` | ESP через RenderStepped: BillboardGui со `StudsOffset` 2/3,5/5,5 и текстом из `Name`, `PlayerStats.Stand.Value`, `PlayerStats.Race.Value`; выключение уничтожает GUI. |
| `f3(target, speed, step)` / `f8(target)` | `target: Vector3`, кнопки передают `10` и `0,1`; у `f8` фиксированные 18 studs/с и 0,05 | Телепорты по вкладке Fast Travel и к боссам: Jotaro Kujo, Dio, Diavolo, Ascended Dio (`8490.5439453125, -469.50018310547, 8151.3793945312`). |
| `TPReturner()` / `Teleport()` | — | Сбор публичных серверов `games.roblox.com/v1/games/<PlaceId>/servers/Public` (лимит 100, курсор), история в `NotSameServers.json` через `readfile`/`writefile`/`delfile`. |
| `f2(parent, name, timeout)` / `f5(substring)` | `timeout` по умолчанию 10; `substring: string` | Опрос `FindFirstChild` каждые 0,1 с; поиск игрока по подстроке имени для списка игнорирования. |

**Две найденные проблемы оригинала (не наши правки).**

1. **Недостижимые вкладки.** Вкладки Server Hop, Visual (ESP), Fast Travel, Credits и Tips создаются через **глобальную** переменную `Window`, хотя объект окна лежит в локальной `v11` (`windUI:CreateWindow`). В клонированном upstream WindUI (`Footagesus/WindUI`, `src/Init.lua`) `CreateWindow` сохраняет окно только внутри модуля (`WindUI.Window`, `Config.Window`) и **не** создаёт глобальный `Window`. Поэтому без такого глобала в окружении скрипт падает на `Window:Tab` сразу после вкладки «Yba God». Проверено статически и на макете (фаза A теста), **в Roblox не проверялось**; полностью исключить артефакт области видимости при деобфускации нельзя — но переименование локальных переменных декодером обычно последовательно, а здесь часть обращений осталась глобальной.
2. **Server Hop не меняет сервер.** `Teleport()` — это `while wait() do pcall(TPReturner) end`; `TeleportService` в теле отсутствует (проверяется и тестом, и верификатором). Кнопка лишь бесконечно перечисляет серверы.

Внешняя зависимость: **WindUI** загружается при старте через `loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua", true))()` — изменяемый release-ассет, в файл не включён и не аудирован; без него скрипт завершается досрочно.

## Jujutsu Shenanigans: что именно восстановлено

Это клиентская переработка мувесета **Naoya** в стиле Sonic. Игровая привязка — в коде: `replicatedStorage.Knit.Knit.Services.CursoryImpactService.RE.Activated`, `...NaoyaService.RE.RightActivated`, `...JoinService.RE.Talk`, `localPlayer:GetAttribute("Moveset") ~= "Naoya"` (все обработчики gated), `workspace.Characters`, `Info.InSkill/Info.Stun`, `PlayerGui.Main.Controls.Ultimate`, а также путь `Jujutsu Shenanigans/` в upstream-репозитории. **PlaceId в коде не проверяется**, соответствие текущей сборке JJS не доказано.

- **Скиллы и слоты:** `f7()`/`f8()` разрешают четыре слота из `character.Moveset` — (`Projection Breaker`|`Mach Breaker`|`Machshot`), (`Bleedout`|`Strike Of The Wind`|`Crushing Wind`), (`Decisive Strike`|`Sonic Wind`|`Supersonic`), (`Cursory Impact`|`Extender`); при загрузке персонажа слоты переименовываются, `Extender:SetAttribute("Key", 9)` и `("Tip", "PASSIVE")`.
- **`f15()`** — `CursoryImpactService.RE.Activated:FireServer(Extender или "Cursory Impact", nil)`; **`f17(a, b)`** — `NaoyaService.RE.RightActivated:FireServer(a, b)`.
- **Клавиши:** `Space` — воздушный рывок (`ChangeState(Jumping)` + knockback-анимация, 0,5 с на повтор); `T` — flash/boost с `LinearVelocity`, разгон со 150 до 200 studs/с в течение 0,6 с и звук Sonic Boost; `Q` — пустая ветка; `Y`/`C` — красный `Pin`/зелёный `GreenPin` (Highlight) на цели; `1`–`4` — состояние `v44`; `L` — ультимейт: Scriptable-камера 1,5 с, `talk:FireServer(13997948756)`, состояние `"Ultimate"`.
- **Целеуказание `f9()`** — точка прицела `(HRP.Position + normalize(LookVector + AssemblyLinearVelocity + camera.LookVector) * 5 + mouse.Hit.Position) * 0.5`, лимит 100 studs, `Humanoid.Health > 0`, вес `Pin` **0.75** и `GreenPin` **1.25**; `f11(t, origin)` предсказывает позицию с компенсацией гравитации (константа `-196.2` по Y при `v23.Y < -150`).
- **Движение (Heartbeat):** `WalkSpeed` 0 в ультимейте, иначе 120/144 через `f16` (raycast на 20 studs с фильтром по `workspace.Characters`), 33 при `Info.Stun`, иначе 66; `JumpPower` 0/80/60; `mahitoSprint` при `MoveDirection ~= 0` и не в скилле.
- **Побочные эффекты:** `workspace.Gravity = 170`, `Humanoid.AutomaticScalingEnabled = false`, `HipHeight = 0.05`, переименование GUI-текста `Head of the Hei` → `The Blue Blur`, перекраска `replicatedStorage.Utils.Hakari.IdleDeath.Aura`, 8 `rbxassetid://` звуков/анимаций и **скачивание mp3 с изменяемого raw-URL** через `writefile` + `getcustomasset`.

## Проверка и воспроизведение

В этой среде нет ни `luac`, ни `luau`, ни Java/Cargo/.NET, поэтому добавлен [`scripts/prepare_lua51.py`](../scripts/prepare_lua51.py): он собирает Lua 5.1 из официального зеркала `lua/lua`, тег **v5.1.1** (коммит `98194db4295726069137d13b8d24fca8cbf892b6`), и проверяет файлы **только компиляцией** (`loadfile`, тот же фронтенд `lparser.c`/`llex.c`, что и `luac -p`). В теге нет `luac.c`/`print.c`, поэтому отдельного `luac` не собирается; `luau-compile` недоступен (нет CMake), и проверка Luau-синтаксиса в этом проходе **не выполнялась**.

```bash
# Интерпретатор Lua 5.1 (исходники качаются с github.com, ничего не исполняется):
python3 scripts/prepare_lua51.py local-results/lua51 \
  --check 'dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua' \
  --check 'dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua'

# Повторное раскрытие своего законно полученного входа (защищённый Lua не запускать):
PDEOBF_ROOT=$(python3 scripts/prepare_pdeobf.py)
node "$PDEOBF_ROOT/bin/pdeobf.js" /путь/к/YBA.lua --force -o /tmp/yba.lua

# Макетные и статистические проверки восстановленных тел:
LUA51=local-results/lua51/lua5.1 \
  local-results/lua51/lua5.1 tests/test_yba_revenge_hub.lua \
  'dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua'          # 36 проверок
local-results/lua51/lua5.1 tests/test_jjs_sonic_static.lua \
  'dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua'           # 35 проверок
```

- [`tests/test_yba_revenge_hub.lua`](../tests/test_yba_revenge_hub.lua) — **36 офлайн-проверок** на подставных объектах: сеть, файловые API и WindUI заглушены, бесконечные циклы обрезаны бюджетом шагов. Проверяются фазы «без глобального `Window`» (падение именно на нём, созданные до этого тумблеры) и «с глобалом» (7 вкладок, телепорты по `workspace.FastTravel` и к Ascended Dio, подбор предметов с нажатием `E`, продажа через диалог продавца, три вида ESP, god mode со списком игнорирования, порог покупки стрелы 50000, бесконечный Server Hop без `TeleportService`).
- [`tests/test_jjs_sonic_static.lua`](../tests/test_jjs_sonic_static.lua) — **35 статических проверок** тела плюс компиляция Lua 5.1. **Поведенческого макета для JJS нет, и это сознательно:** восстановленный top-level создаёт десятки типов Roblox (`ColorSequence`, `NumberRange`, `RaycastParams`, `TweenService`, `Debris`, `Stats`), запускает неограниченные циклы и требует `writefile`/`getcustomasset`, так что макет проверял бы в основном сам макет. В манифесте у этого файла `mock_game_assertions: 0`, и [`verify_results.py`](../scripts/verify_results.py) не принимает такой файл без `static_body_assertions`.
- [`tests/test_wad_game_results.py`](../tests/test_wad_game_results.py) — 6 Python-тестов: закреплённые MIT-входы и побайтовость тел, неизменность лицензии, честные поля `verification`, отказ верификатора при подмене числа проверок/хеша лицензии/подмене входа на выход, отказ при незарегистрированном WAD-файле, и (при наличии интерпретатора) запуск обоих Lua-тестов со сверкой напечатанного числа с манифестом. Без интерпретатора этот тест **пропускается**, а не засчитывается.

## Отрицательные результаты этого прохода

- **Пять приоритетных игр без нового результата.** По Lone Survival, Trident Survival, Slayers 2, Grand Piece Online и King Legacy не найдено ни одного защищённого входа с подтверждённым правом на перепубликацию: найденные репозитории либо не имеют LICENSE (`Lennox2010/LONE-SURVIVAL-LEGACY`, `KumaoRoblox/TridentSurvival`, `Panda22MyGod/TridentSurvival`, `realuwo/Trident-Survival`, `Nw2r/trident-survival-`, `dilleron964/Grand-Piece-Online`, `jeagerist/Grand-Piece-Online`, `Phyoue/GrandPieceOnline`, `Kchan420/KingLegacyScript`, `ALPHAneegy/kingLegacy`, `trustedscript/tiki-script`), либо содержат loader/открытый исходник вместо защищённого тела. Счётчик по этим играм **не менялся**.
- **MomoHub007:** 16 репозиториев с WeAreDevs-входами (`Sailor-Piece`, `Anime-Tactical`, `All-Star-`, `Scirpt-Standard`, `AZ`, `SpearTrain`, `Be-a-Youtuber`, `Garden-Horizon` и др.) **не содержат LICENSE**; лицензия MPL-2.0 есть только у уже использованного `Fight-Your-Zombie`. Ничего из них не опубликовано.
- **`Luciquad/robloxscripts` (MIT):** `bloxfruits` (437 344 байт) — **Perth**-обфускация (строки-заполнители «Xenvant Likes cock - Perth», «concat was here», «Bunu yazan tosun... - federal»), инструмента нет; `bigpaintballv1` (285 950) — **Synapse Xen v1.1.2**, инструмента нет; `stfu` (485 759) и `dgqst` (68 937) — **MoonSec V2**, лицензированного девиртуализатора не найдено; `sl2 autofarm` — открытый исходник Shindo Life 2, то есть `(src)`, который сейчас не добавляем.
- **`Xowie89/Roblox-Scripts` (MIT):** `Anime Training Simulator.lua`, `Factory Simulator [OVERHAUL].lua`, `Hospital Tycoon.lua` — MoonSec V2; без рабочего девиртуализатора публиковать нечего. `Item Factory.lua` (MoonSec V3) уже опубликован ранее как `(partial)`.
- Поиск кода GitHub по сочетаниям «название игры + заголовок защиты» для пяти приоритетных игр дал 0–1 совпадений (индекс не включает крупные минифицированные файлы); тела входов через API не запрашивались.

**Контроль:** 74 Python-теста (было 68; +6 новых), проверка **63** опубликованных игровых файлов, **40** архивов исходников, один Node-тест и `git diff --check` проходят; оба Lua-теста проходят на собранном Lua 5.1.1. Защищённые входы, промежуточные выводы декодера, клоны сторонних репозиториев и собранный интерпретатор лежат в игнорируемом `local-results/` и в Git не добавлены.
