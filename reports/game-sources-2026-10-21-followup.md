# Ещё 15 игровых Luau: 7 статических восстановлений + 8 MIT-исходников — 21 октября 2026

Вместе с предыдущими 40 файлами в `dobf scripts 1.0/` теперь **55** игровых Lua. **`(src)` = открытый исходник, НЕ деобфускация**. Все остальные семь получены из защищённых оригиналов. Результат в Roblox **не запускался** и серверные эффекты не доказаны. Синтаксис всех новых файлов проверен через `luau-compile --null`; это не гарантирует работу игры или безопасность загружаемых сторонних библиотек.

## Что именно было восстановлено

- Шесть WeAreDevs/Prometheus-защищённых входов (Gakuran, 3 варианта SCP-3008, Piggy, Prison Life) раскрыты **статически** локально из закреплённых MIT-репозиториев инструментом [`prostone4/Prometheus-Deobfuscator@6ee3291`](../sources/prostone4--Prometheus-Deobfuscator.zip); воспроизводимый путь `python scripts/prepare_pdeobf.py /tmp/pdeobf-pinned` и `node /tmp/pdeobf-pinned/prostone4--Prometheus-Deobfuscator-6ee3291ec83f/bin/pdeobf.js INPUT.lua -o OUTPUT.lua`. Исполняемый Roblox/Lua gameplay при распаковке не запускался. Выход компилируется, но полного доказательства идентичности нет.
- Отдельный Demonology MoonVeil v1.4.5 раскрыт закреплённым [`edwindev-spec/MoonVeil@a948c48`](../sources/edwindev-spec--MoonVeil.zip) (`python -m moonveil decompile INPUT -o OUTPUT --artifacts DIR` с официальным Luau). Профиль **structured**, 41/41 прототип, 2 991 слот инструкций, компилятор принял выход, 305 из 305 событий в ограниченном proxy-сравнении совпали. Отчёт движка: `protected_target_executed: false`; это **не проверка в Roblox** и не гарантия всех обработчиков. Полные исходные имена/комментарии недоступны.
- Восемь остальных Lua — неизменённые MIT-исходники (6 модулей Magma, Anime Origins, SCP-096). Тела `src` побайтово совпадают с указанными Git-коммитами; в заголовках каждого файла помещён полный текст MIT. Один обфусцированный Gakuran извлечён из **исторического** коммита 17bfd85, не из текущего универсального DEPEMOTES.lua.

**Внимание:** статически восстановленные скрипты могут скачать и исполнить внешнюю UI-библиотеку, а UI с кнопками обновления — новую версию скрипта. Anime Origins содержит *опциональные* Discord webhook/обмен макросами и кнопку, исполняющую сторонний зашифрованный FakeVisual. Не запускайте эти компоненты без аудита. Запросов к `pastefy.app` или site API для получения исходников здесь не было.

## Файлы, функции/параметры и ограничения

### Gakuran — [Dep Hub](../dobf%20scripts%201.0/Gakuran%20-%20Dep%20Hub.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/DogFireBattle/gakuran/blob/17bfd85455075a0908dd64c28a09505f2a98db6f/gakuranscript.lua) — `DogFireBattle/gakuran@17bfd85455075a0908dd64c28a09505f2a98db6f` (`MIT`).
**SHA-256 input:** `fb9490f58ebec4081a379d0287d3d9985a09bd4ed0f01bf1fab9632d921533a0`; **SHA-256 опубликованного файла:** `73b17e12311aa8c65f89870ecae41aacdaf290a435129aa4a4b0a342b5155c1b`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `f34(p27)` | `p27: BasePart (incoming hitbox)` | Проверяет игровую зону удара и расстояние до игрока; планирует парирование с поправкой на пинг. |
| `f33()` | нет | Нажимает выбранную клавишу парирования несколько раз: ParryBurst/ParryHold/ParryBurstGap. |
| `f53(p42)` | `p42: string (local MIDI path)` | Читает MIDI через readfile и отдаёт данные парсеру f41 для автоматической игры на пианино. |
| `f48()` | нет | Ищет BasketballShotMeterAttach/Meter на персонаже для броска. |
| `f49(p40)` | `p40: Color3` | Распознаёт зелёную область баскетбольного индикатора; обработчик RenderStepped отпускает F при попадании стрелки. |

**Ограничения:**
- Взят именно исторический commit 17bfd85: текущий HEAD удалил gakuranscript.lua и содержит универсальный DEPEMOTES.lua; последний намеренно не публикуется как игровой.
- Требует workspace.Hitboxes, PlayerGui.RhythmServiceUI и баскетбольную шкалу; игровой PlaceId в файле не проверяется, соответствие определено по этим конкретным объектам.
- Hydra Lib загружается и исполняется при старте с изменяемого GitHub main; readfile нужен только для MIDI; gameplay и удалённая библиотека в Roblox не тестировались.
- Статическая распаковка WeAreDevs/Prometheus и компиляция не доказывают поведенческую эквивалентность.

### SCP-3008 — [Sealient UI](../dobf%20scripts%201.0/SCP-3008%20-%20Sealient%20UI.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/Sealient%27s%203008%20UI.lua) — `Sealient/Sealients-Roblox-Scripts@ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967` (`MIT`).
**SHA-256 input:** `2add113c086034788b03f4d67e494d91b60b5398977b0fb74818ef0a537fcb1f`; **SHA-256 опубликованного файла:** `9ad5ebed2d8f165311ea6ba3258d906de17a8c93fab0adcdc351f4b1c6b1ef5e`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `f8(p7)` | `p7: Model (employee NPC)` | Создаёт BillboardGui/дистанцию для сотрудников из GameObjects.Physical.Employees. |
| `f13(p9)` | `p9: BasePart\|Model (loot item)` | Рисует ItemESP для еды/предметов из секций Items этажа. |
| `f6()` | нет | Сканирует floor.Items, отбирает предметы по имени и максимальной дистанции для списка телепорта. |
| `f5(p5)` | `p5: BasePart\|Model (item)` | Переносит корневую часть персонажа к выбранному предмету, предварительно сохраняя позицию. |

**Ограничения:**
- При запуске исполняет три удалённые библиотеки Fluent/SaveManager/InterfaceManager с изменяемых URL; кнопка Check Version может отдельно скачать и исполнить новую версию. Эти зависимости не включены и не проверены.
- Нет проверки PlaceId; нужны GameObjects.Physical.Employees и floor.Items. Локальный ESP/телепорт не гарантия серверного эффекта; Roblox не тестировался.
- Это вариант с Fluent UI, не совпадающий с двумя вариантами Abyssal в той же коллекции.

### SCP-3008 — [Abyssal Luminx](../dobf%20scripts%201.0/SCP-3008%20-%20Abyssal%20Luminx.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/3008-%20UPDATED/3008%20%28new%29.lua) — `Sealient/Sealients-Roblox-Scripts@ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967` (`MIT`).
**SHA-256 input:** `f9d194286f131534198665e7718ed97ac1c91dbaff083f3870e643b1715f425c`; **SHA-256 опубликованного файла:** `03e9c9ddc83dab9d30a6470c3723423b7a91edb57dbc02fb06ae6fb33bcdbf70`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `f3(...)` | `...: string[] (path segments)` | Находит вложенный объект Workspace.GameObjects.Physical.* для сотрудников, игроков и предметов. |
| `f6(p9, p10, text)` | `p9: Instance (target)`, `p10: Color3`, `text: string` | Создаёт Highlight и настраиваемый BillboardGui для объекта 3008 в пределах MaxRange. |
| `f12()` | нет | Обновляет сортируемый по расстоянию список предметов из Map/Items для телепорта. |
| `Teleport to Selected callback()` | нет | Переносит персонажа к предмету из списка и по опции возвращает через Return Delay (s). |

**Ограничения:**
- В самом начале исполняет внешнюю Sealient/LuminxUI.lua с изменяемой ветки main; не проверялась. Кнопки «God Mode» и «Auto Rejoin on Kick» не подтверждены как серверные механики.
- Нет проверки PlaceId; используются конкретные GameObjects.Physical.Map/Items/Employees. Не тестировано в Roblox; только статическая компиляция.

### SCP-3008 — [Abyssal Redux](../dobf%20scripts%201.0/SCP-3008%20-%20Abyssal%20Redux.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/3008-%20UPDATED/3008.lua) — `Sealient/Sealients-Roblox-Scripts@ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967` (`MIT`).
**SHA-256 input:** `20bf0fca34b40ab629b93551187212217ab3e456982ee7cae1b1919af152f925`; **SHA-256 опубликованного файла:** `fdbbe652856fb93a436f1f0ec01868604caae31da06bd66209538aca3ac4c0e0`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `f4(p5)` | `p5: Model (employee NPC)` | Создаёт Drawing Box/Text для NPC сотрудника в GameObjects.Physical.Employees. |
| `f23(p16, p17)` | `p16: BasePart\|Model (loot)`, `p17: string (item name)` | Создаёт BillboardGui/Highlight выбранного по категории ресурса или еды. |
| `f31(p20, p21)` | `p20: BasePart\|Model (item)`, `p21: string (label)` | Телепортирует к объекту с сохранением позиции, cooldown и задержкой возврата. |
| `f34(p27)` | `p27: string (item name)` | Ищет ближайший разрешённый ресурс и вызывает f31 для перемещения. |

**Ограничения:**
- Это более старая и существенно более крупная версия Abyssal с Drawing API, Item ESP и UI-инструментами; не дубликат Luminx или Fluent UI.
- При запуске исполняет удалённую ReduxV2 UI с ветки main; без UI и Drawing не автономен. Серверный эффект телепорта не проверен.
- Нет проверки PlaceId и теста в Roblox. В старом интерфейсе присутствуют просьбы о поддержке автора; они не являются игровой механикой.

### Piggy — [Sealient UI](../dobf%20scripts%201.0/Piggy%20-%20Sealient%20UI.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/Piggy/Sealient%27s%20Piggy%20UI.lua) — `Sealient/Sealients-Roblox-Scripts@ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967` (`MIT`).
**SHA-256 input:** `dac295e7e7f0b5a389a00913a52c632c5b47d0770ef6a168a69a2d41274ba1d0`; **SHA-256 опубликованного файла:** `21a4c2c72ea45f05df95a4f68afc2b5c2d3baa8afd0116c4cf2fbaaceeed1a94`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `v8:CreateItemESP(p3)` | `p3: BasePart\|Model (map item)` | Создаёт ItemESP/Highlight для объекта; RenderStepped-подписка на расстояние задаётся отдельным UI-toggle. |
| `v8:CreatePiggyESP(p4)` | `p4: Model (Piggy NPC)` | Рисует метку и Highlight для преследующего NPC Piggy. |
| `v8:UpdatePiggyDistances()` | нет | Обновляет расстояния до отмеченных Piggy во время RenderStepped. |
| `f2()` | нет | Находит ItemFolder либо числовую папку с предметами текущей главы. |

**Ограничения:**
- При запуске загружает Fluent и два аддона с изменяемых внешних URL; кнопка Check for Updates при подтверждении скачивает и исполняет новый Piggy UI.
- Нет проверки PlaceId; ItemFolder/Piggy модель могут отличаться по главам. В Roblox не проверено; UI/Highlight локальные.

### Demonology — [Luminx Ghost ESP](../dobf%20scripts%201.0/Demonology%20-%20Luminx%20Ghost%20ESP.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/Demonology/Demonology.lua) — `Sealient/Sealients-Roblox-Scripts@ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967` (`MIT`).
**SHA-256 input:** `30756c399b77accb1c4762b65b6796506ae526bb301af40e59f0bf66097f3b56`; **SHA-256 опубликованного файла:** `c53975c9a0993e2743a666dd2c13fa651a3fd9bf88f870a6c762fe7ea3a723f7`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `R34(player, value2, value3, value4)` | `player: Player\|Model`, `value2: Color3`, `value3: Color3`, `value4: unknown` | Ставит Highlight на персонажей/сущности с переданными цветами; имя параметра value4 и его роль не подтверждены. |
| `R38(value)` | `value: Model (world item)` | Для FlowerPot/SpiritBook по OptimizedFlower/Pencil получает или создаёт WorldPivot для камеры. |
| `R39()` | нет | Перечисляет Player и игровые предметы из Workspace.Items как цели для переключения камеры. |
| `R40(value1, value2)` | `value1: Model (camera target)`, `value2: Vector3 (camera origin)` | Лучом проверяет препятствия и локально повышает прозрачность заслоняющих объектов. |
| `Ghost/Player/Item ESP callbacks(argument1)` | `argument1: boolean` | Включают Highlight для Ghost, игроков и предметов из Workspace.Ghost/jneedse/Items. |

**Ограничения:**
- Настоящий MoonVeil v1.4.5, не MoonSec V3: инструмент поднял все 41 прототип и 2 991 слот инструкции; proxy-трассы совпали в 305 событиях. Protected target не исполнялся в Roblox, совпадение прокси не равно полной эквивалентности в игре.
- Локальные имена и комментарии исходника утрачены; R/U и значение value4 — реконструкция. При старте исполняет Sealient/LuminxUI.lua с изменяемой ветки GitHub.
- Нет подтверждённого механизма определения типа призрака или автоматической охоты; обнаружены визуализация, цели камеры, fullbright/noclip. Не выдавать этот UI за полный Demonology-автофарм.

### Prison Life — [Vex Hub](../dobf%20scripts%201.0/Prison%20Life%20-%20Vex%20Hub.lua)

**Статус:** статически раскрытый защищённый Lua; не проверен в Roblox. [Исходный input](https://github.com/0x100C/Roblox-Scripts/blob/97fa45e403a00a3d7d1a06c4271e0a787269dd33/Obsfucate/Prison-Life%28Half-Broken%29.lua) — `0x100C/Roblox-Scripts@97fa45e403a00a3d7d1a06c4271e0a787269dd33` (`MIT`).
**SHA-256 input:** `dd8a5a7502a263969db9031bfb3a99389d722c9921dc5a678d9979e131962bea`; **SHA-256 опубликованного файла:** `f7a7f2f6bbdc1e889482153a38fd720ed73bcda548a9e06d50fc6d6c3d964b0a`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `v1.equip(cframe)` | `cframe: CFrame` | Твинит HumanoidRootPart к точке спавна оружия, не вызывает item pickup remote. |
| `Arrest All callback()` | нет | Находит игроков команды Criminals; для Guards пытается InvokeServer(Remotes.ArrestPlayer, target) после перемещения. |
| `Team/ESP callbacks(value)` | `value: string\|boolean` | Фильтрует игроков по Guards/Criminals и включает локальный ESP/трассеры. |
| `Remove All KeyCard Doors callback()` | нет | Клиентски удаляет объекты с door_v3 из Workspace; на серверные двери влияние не подтверждено. |

**Ограничения:**
- Имя upstream-файла содержит Half-Broken: никаких гарантий работоспособности. Для Arrest All нужна команда Guards; список remotes и координаты оружия/дверей могут устареть.
- При запуске исполняет изменяемую WindUI GitHub releases/latest, а ветки UI могут требовать API executor; Roblox не тестировался.
- MIT относится к репозиторию 0x100C, в окне исходника указаны два соавтора .interception. & s0ulz.lua; атрибуция сохранена.

### Retail Tycoon 2 — [Magma Hub module](../dobf%20scripts%201.0/Retail%20Tycoon%202%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/2092410051.lua) — `Commandcracker/Magma-Hub@5d7e2f84de039e65f909b50c3533b199fff9e9fd` (`MIT`).
**SHA-256 input:** `644c75028acd6ae338aaafb59f1651be2717ff4eb1c80bc6f345cc44b3a3e1a7`; **SHA-256 опубликованного файла:** `427ff54d9c2553b971da79bd82365a70898323b16ebbd8d5597e68e983668368`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `GetCar()` | нет | Находит Vehicle_<Player.Name> в Workspace.PlayerVehicles. |
| `TeleportCar(pos)` | `pos: CFrame` | Меняет CFrame деталей грузовика на переданную позицию. |
| `GetPlot()` | нет | Возвращает строительный участок игрока; используется для загрузочного дока. |
| `Auto Restock/Auto Delivery Threads:Add()` | нет | Пополняет полки через StockShelfFunction и перевозит склад с LoadVehicle/UnloadVehicle. |

**Ограничения:**
- Модуль не автономен: нужны глобальные MagmaHub, Threads и его UI; main.lua хаба сам подгружает game-файлы из сети, здесь не включён.
- GetLoadingDock/GetPlot зависят от старой геометрии и getrenv()._G.Data; серверные покупки/цвет не подтверждены на текущей игре. Roblox не тестировался.

### Super Power Training Simulator — [Magma Hub module](../dobf%20scripts%201.0/Super%20Power%20Training%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/767752328.lua) — `Commandcracker/Magma-Hub@5d7e2f84de039e65f909b50c3533b199fff9e9fd` (`MIT`).
**SHA-256 input:** `3838627aee214247117562f6db6ec85828c4f15d446e09345234e25d6445a647`; **SHA-256 опубликованного файла:** `497c8c882d920c8f889b69ec95979aa5ec8c4f891e48860cefc0cf272cb9b4b6`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `onHealthChanged(health)` | `health: number` | При активном Auto Respawn отправляет RemoteEvent {"Respawn"} после смерти. |
| `onCharacterAdded(character)` | `character: Model` | Подписывает Humanoid.HealthChanged для нового персонажа. |
| `Training Threads:Add()` | нет | Отправляет +FS1..+FS6 и другие команды тренировки через ReplicatedStorage.RemoteEvent по выбранным переключателям. |

**Ограничения:**
- Модуль требует MagmaHub/Threads, без загрузчика не автономен. RemoteEvent может ограничивать частоту, игровой API изменился с публикации Magma в 2023.
- UniverseId 767752328, RootPlace 2202352383 по games.json; настройки и выполнение в Roblox не проверены.

### Prison Life — [Magma Hub module](../dobf%20scripts%201.0/Prison%20Life%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/73885730.lua) — `Commandcracker/Magma-Hub@5d7e2f84de039e65f909b50c3533b199fff9e9fd` (`MIT`).
**SHA-256 input:** `2523d56b9cda3aa2dbd533b9b3544592a4f164e65cb93982d7489ce65481909f`; **SHA-256 опубликованного файла:** `b6c59fd22765065c94722938ca60bd0bcf5c01756d7c40492b099b4f99a572ab`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `Give M9/Remington/AK-47 callbacks()` | нет | Вызывает workspace.Remote.ItemHandler:InvokeServer для выбранного ITEMPICKUP. |
| `Kill Aura Threads:Add()` | нет | Отправляет meleeEvent для других игроков при включенном флаге; результат не проверен. |
| `Auto Reload Threads:Add()` | нет | Находит ModuleScript у инструмента и посылает ReplicatedStorage.ReloadEvent. |
| `Teams:addButton callback()` | нет | Запрашивает смену команды через workspace.Remote.TeamEvent с BrickColor-названием. |

**Ограничения:**
- Не автономен: MagmaHub/Threads; отличается от независимого WAD-защищённого Vex Hub.
- Spawn Guns включенным циклом зануляет Health и пытается loadchar:InvokeServer; это может убить персонажа/потерять текущую позицию.
- Старые remotes workspace.Remote/ReloadEvent и команды могут не работать сегодня. Roblox не тестировался.

### Vehicle Simulator — [Magma Hub module](../dobf%20scripts%201.0/Vehicle%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/81762198.lua) — `Commandcracker/Magma-Hub@5d7e2f84de039e65f909b50c3533b199fff9e9fd` (`MIT`).
**SHA-256 input:** `cf04e248e6b2252d35274731c4fbb94eb277221dd1b915129da86533cf5b6d36`; **SHA-256 опубликованного файла:** `1e228a2d3e1bbe5c9db6ab6404a2d719514869ec0c4e18bda3ce0a25c1e6093d`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `GetVehicle()` | нет | Перебирает workspace.Vehicles, сверяет owner.Value с LocalPlayer.Name. |
| `Auto Farm Threads:Add()` | нет | Переносит машину к трассе и меняет крутящий момент колес; зависит от старой физики. |
| `Crate ESP callback()` | нет | Создаёт BoxHandleAdornment у ящиков/дымящихся деталей. |
| `Max Speed input(Input)` | `Input: number\|string` | Меняет локальное значение Vehicle.Handling.MaxSpeed.Value. |

**Ограничения:**
- Требует оболочку MagmaHub/Threads; локальные настройки машины и UserId могут быть read-only и не влиять на сервер.
- Кнопка Give All Perks присваивает LocalPlayer.UserId = 1099580: вероятный runtime error; не считать рабочей выдачей перков. Roblox не тестировался.

### Magnet Simulator — [Magma Hub module](../dobf%20scripts%201.0/Magnet%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/1237829262.lua) — `Commandcracker/Magma-Hub@5d7e2f84de039e65f909b50c3533b199fff9e9fd` (`MIT`).
**SHA-256 input:** `00cc584e0dcea3922267685aa43e5fe443a48d7d30862f48bf80df815a2fc193`; **SHA-256 опубликованного файла:** `22773a8f984f4a17c640be009877dea24ffd6ceaa7f1b8d82ad4e774888e381f`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `Auto Sell Threads:Add()` | нет | Касается площадки Rings.Sellx2 или перемещает площадку к игроку при отсутствии firetouchinterest. |
| `Auto Collect Coins Threads:Add()` | нет | Вызывает MagnetEvents.requestGrab с жёстко заданным значением 6080000000 и ReplicatedStorage.Tools["Lucky Long Tri-Magnet"]. |
| `Auto Rebirth Threads:Add()` | нет | Вызывает RebirthEvents.requestRebirth для доступных настроек перерождения. |

**Ограничения:**
- Требует MagmaHub/Threads, firetouchinterest у executor либо локальное изменение CFrame кассы. Жёстко заданное значение и инструмент Lucky Long Tri-Magnet в requestGrab могут устареть.
- UniverseId 1237829262, RootPlace 3486025575. Не проверено в Roblox.

### Dashing Simulator — [Magma Hub module](../dobf%20scripts%201.0/Dashing%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/962480973.lua) — `Commandcracker/Magma-Hub@5d7e2f84de039e65f909b50c3533b199fff9e9fd` (`MIT`).
**SHA-256 input:** `c63f8514b1625f5fd6730ae283e0a36504cbcf153a8ec591c31118592db01424`; **SHA-256 опубликованного файла:** `4f22aec20b512a6b2fc6291b5c92630ab0042b0c969c30adebce6745ef3bf5b9`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `Add Speed Threads:Add()` | нет | В цикле отправляет Events.AddSpeed:InvokeServer по переключателю. |
| `Auto Accept Race Threads:Add()` | нет | Запрашивает участие через Events.RaceRequest:FireServer. |
| `Discover Lands callback()` | нет | Выполняет Events.Discover:InvokeServer(Land.Name) для доступных регионов. |
| `Collect Orbs Threads:Add()` | нет | Перебирает снимок Workspace.CollectableOrbs, ищет видимые орбы с Name == "35" и касается их через firetouchinterest (или телепорт). |

**Ограничения:**
- Не автономен: MagmaHub/Threads, данные старого игры и серверные ограничения неизвестны. Бесконечные циклы с wait() могут флудить remotes.
- UniverseId 962480973, RootPlace 2673595672. Roblox не тестировался.

### Anime Origins — [Ultimate tower-defense](../dobf%20scripts%201.0/Anime%20Origins%20-%20Ultimate%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/Truyem/Anime-Origins/blob/a8bb98346af9a6446c46de1b8d24fcb2896e3329/AnimeOriginsUltimate.lua) — `Truyem/Anime-Origins@a8bb98346af9a6446c46de1b8d24fcb2896e3329` (`MIT`).
**SHA-256 input:** `b9dd7bf5f19e4d3179540dd87913b0c968ca8300a6322ab87511a1bced97f809`; **SHA-256 опубликованного файла:** `9f2b73bf7910d2cf5af869ae04ce7713e9d12478b0a5577180d65249087b0002`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `executeAction(action)` | `action: table (Type/Position/Slot/Ref/...)` | Повторяет записанные игровые действия PlaceTower/UpgradeTower/SellTower, привязывает tower UUID к макросу. |
| `autoRiftTarget()` | нет | Оценивает таймер и CrashSite.RiftPart, подбирает режим ShibuyaRift/сложность/мир. |
| `standardSummon(requestedAmount, reserve, owner)` | `requestedAmount: number\|"Max"`, `reserve: number`, `owner: string` | Считает доступные валюту/слоты и зовёт SummonFunction("SummonTower","Standard",amount). |
| `runAutoShops()` | нет | Выбирает товары по ротации магазина и балансу, вызывает ShopRemote("BuyShopItem",...). |

**Ограничения:**
- Это открытый MIT Luau-исходник, НЕ деобфускация; 9 тыс. строк TD-макро и lobby/in-game. Требует реальные Assets/Misc, GameUI/MainUI и executor с файловыми/HTTP API.
- Опциональные WebhookUrl и Macro Share отправляют выбранные данные во внешние Discord/Netlify; по умолчанию URL пустой и Webhook*Enabled=false, но конфигурация может сохраняться. Кнопка FakeVisual явно скачивает и исполняет зашифрованный kocogi.lua с truyem789.site — не нажимать без аудита.
- При старте может загружаться изменяемый Fluent; использует thumbnails.roblox.com для иконки. Никакие внешние загрузки/POST не выполнялись здесь; Roblox не тестировался.

### SCP-096 — [MaddHub module](../dobf%20scripts%201.0/SCP-096%20-%20MaddHub%20module%20%28src%29.lua)

**Статус:** открытый MIT-исходник `src`, НЕ деобфускация. [Исходный input](https://github.com/MaddHub-Official/MaddHub/blob/2109e33d3d0f6cdd0a187eede1fc56af17630852/Games/096%20%5BSCP%5D/script.lua) — `MaddHub-Official/MaddHub@2109e33d3d0f6cdd0a187eede1fc56af17630852` (`MIT`).
**SHA-256 input:** `4801dfd84fd2c3d853629b9f41f82ce8eca97ee34dc998116b8299b86e12fb4b`; **SHA-256 опубликованного файла:** `9ab66fae1ebfbbe5fc6fe93913007d1d85e8a51aa18a9887e89cdceba716b9b4`.

| Функция / обработчик | Параметры | Назначение |
| --- | --- | --- |
| `returnObjs(loc, typ)` | `loc: Instance`, `typ: string` | Отбирает в игровом контейнере дочерние объекты по атрибуту Type. |
| `spawnPart(partName)` | `partName: string` | Локально перемещает выбранный тип предмета возле персонажа. |
| `farmMats(resource)` | `resource: "Stone"\|"Tree"` | Экипирует кирку/топор, обходит игровые Decoration nodes и вызывает Remotes.ToolAction. |
| `equipTool(toolName)` | `toolName: string` | Вызывает Remotes.Backpack("Equip", материал .. toolName, "Tool") для Wood/Stone/Iron. |
| `Teleport SCP To Player Callback(Value)` | `Value: string (player name)` | Перемещает модель SCP-096 к выбранному игроку и меняет CanAggro (локальный эффект может не реплицироваться). |

**Ограничения:**
- Это MIT-модуль MaddHub, не самостоятельный скрипт: нужны Svc, Lp, Chr, HumRP, GameTab, Window, TeleportSect и UI; сам key-loader MaddHub выполняет внешние запросы, сюда не включён.
- maxBackpack()/grantPerms() меняют локальные атрибуты/Perms; серверного разрешения/максимальных статов это не доказывает.
- Вызовы ToolAction/Backpack и getsenv зависят от старого состояния игры; Roblox не тестировался.

## Пробелы и проверенные тупики

RScripts и ScriptBlox показывают карточки и загрузчики, но не предоставляют разрешение на переиздание защищённого тела сами по себе. Настоящие найденные game-specific исходники вошли в список только после проверки Git-прав, игрового кода и сети. Ни `.exe`, ни архивы неизвестных лоадеров, ни однострочные `loadstring` не добавлялись.

| Игра | Почему новых Lua пока нет |
| --- | --- |
| King Legacy | Имеется только прежний UI/ESP Luxury Core; нового исходника с подтверждёнными правами и настоящими квестами/фруктами/фарм-remote не найдено. |
| Demonfall | NOOBHUBX и debunked69 хранят MoonSec без разрешения на распространение; в README LucaMichael06 прямо запрещено заимствование; у французских игровых сниппетов нет стандартной лицензии. |
| Trident Survival | PINGUIN/TridentZ прямо запрещает копирование; у realuwo WAD нет лицензии. Прочие результаты — .exe/ZIP-загрузчики либо универсальный аимбот. |
| Anime Vanguards | Многие страницы содержат лишь короткие загрузчики, приватный runtime или внешние Python-макросы; найденный MIT-кандидат GigaMechanicRear был универсальным, без специфичных AV remotes. |
| VV Ultimatum | Защищённый кандидат остановил pdeobf с ошибкой unexpected char backslash; нового игрового исходника с проверенными правами не найдено. |
| Illegal Sorcer | Не найден разрешённый Lua с подтверждённой механикой именно этого плейса; Illegal Soccer нельзя выдавать за Sorcer. |

Проверяемость: полный перечень байтов, SHA-256/лицензий, отметок игрового кода и статуса тестирования — [JSON-отчёт](game-sources-2026-10-21-followup.json); `python -m scripts.verify_results` сверяет файлы. Безопаснее изучать исходный текст, а не запускать сторонние `HttpGet`/`loadstring`.
