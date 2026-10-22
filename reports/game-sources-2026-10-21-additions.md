# Дополнительные игровые Lua (21 октября 2026)

**13 новых файлов — все `(src)`, НЕ деобфускация.** Предыдущие 27 остаются без изменений.
Проверены исходные Git-коммиты/SHA-256 (один текст из открытого View Raw ScriptBlox), игровой код, лицензии/атрибуция и `luau-compile --null`.
**Никакой Lua не выполнялся в Roblox**, отсутствие телеметрии во внешних загрузчиках не доказано.
Скрипты не получались через API ScriptBlox/RScripts или Pastefy; карточки использовались как указатели на GitHub/публичный View Raw.

| Игра | Файл и статус | Права / ограничения |
| --- | --- | --- |
| Grand Piece Online | [Grand Piece Online - Aztup main (src).lua](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Aztup%20main%20%28src%29.lua) — **src** | MIT; Модуль не автономен: sharedRequire, accountData, library, getgc, syn, hookmetamethod и другие части Aztup отсутствуют. |
| Grand Piece Online | [Grand Piece Online - Aztup Perfect Block (src).lua](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Aztup%20Perfect%20Block%20%28src%29.lua) — **src** | MIT; Нужны sharedRequire Aztup, getgenv, keypress/keyrelease и GPO-анимации из старого набора; модуль импортируется main.lua, но не является самостоятельным хабом. |
| Ro-Ghoul | [Ro-Ghoul - Aztup module (src).lua](../dobf%20scripts%201.0/Ro-Ghoul%20-%20Aztup%20module%20%28src%29.lua) — **src** | MIT; Полагается на getgc/getconstants для получения динамического RemoteKey и инфраструктуру Aztup; если ключ не получен, исходник вызывает LocalPlayer:Kick. |
| Project Mugetsu | [Project Mugetsu - Aztup module (src).lua](../dobf%20scripts%201.0/Project%20Mugetsu%20-%20Aztup%20module%20%28src%29.lua) — **src** | MIT; Опасный модуль с манипуляцией dataloss/UpdateKeys и профилем игрока, НЕ рекомендуется запускать на основном аккаунте; исходник содержит закомментированные UI-вызовы. |
| Deepwoken | [Deepwoken - Aztup Race Changer (src).lua](../dobf%20scripts%201.0/Deepwoken%20-%20Aztup%20Race%20Changer%20%28src%29.lua) — **src** | MIT; Только КОСМЕТИКА, не смена серверной расы. Нужны sharedRequire Aztup, UI misc, ассет rbxassetid://12562484379 и эффекты игры. |
| Ride a Pet | [Ride a Pet - 0x5A46 Eggs (src).lua](../dobf%20scripts%201.0/Ride%20a%20Pet%20-%200x5A46%20Eggs%20%28src%29.lua) — **src** | Apache-2.0; Apache-2.0; полный лицензионный текст добавлен в reports/licenses. Интерфейс/фон опционально получают произвольный URL изображения, читают/пишут файлы executor. |
| All Star Tower Defense | [All Star Tower Defense - KarmaPanda (src).lua](../dobf%20scripts%201.0/All%20Star%20Tower%20Defense%20-%20KarmaPanda%20%28src%29.lua) — **src** | author release / attribution requested (no SPDX); Автор README прямо разрешил использовать опубликованный исходник при указании KarmaPanda, но стандартной LICENSE нет; код не выдаётся за MIT. |
| A Universal Time | [A Universal Time - Hyper Zoro (src).lua](../dobf%20scripts%201.0/A%20Universal%20Time%20-%20Hyper%20Zoro%20%28src%29.lua) — **src** | self-described open source (no SPDX license); Выложено ScriptBlox автором neutral с названием «open source», но формального SPDX/лицензии нет; права на дальнейшее распространение не уточнялись. |
| RO-Wizard | [RO-Wizard - Magma Hub module (src).lua](../dobf%20scripts%201.0/RO-Wizard%20-%20Magma%20Hub%20module%20%28src%29.lua) — **src** | MIT; Это вкладка Magma Hub, нужны MagmaHub и Btable; телепортация напрямую меняет HumanoidRootPart.CFrame, могут возникнуть откаты/детект. |
| Pet Simulator X | [Pet Simulator X - Magma Hub module (src).lua](../dobf%20scripts%201.0/Pet%20Simulator%20X%20-%20Magma%20Hub%20module%20%28src%29.lua) — **src** | MIT; Требует MagmaHub/Threads и старую структуру Pet Simulator X; Auto Collect Gifts находит RemoteFunction по общему имени и может обращаться не к тому remote. |
| Bloodlines | [Bloodlines - Aztup module (src).lua](../dobf%20scripts%201.0/Bloodlines%20-%20Aztup%20module%20%28src%29.lua) — **src** | MIT; Этот модуль Bloodlines привязан к PlaceId 10266164381, не автономен: нужны sharedRequire, library, Utility и другие классы Aztup. |
| Doors | [Doors - Abysall Lobby (src).lua](../dobf%20scripts%201.0/Doors%20-%20Abysall%20Lobby%20%28src%29.lua) — **src** | MIT; Отдельный модуль Abysall без Loader/Interface; upstream Loader.luau автоматически загружает Components/Analytics.luau и отправляет username/executor/game в сторонний сервис. НЕ запускайте upstream Loader без отдельного аудита. |
| Doors | [Doors - Abysall Main (src).lua](../dobf%20scripts%201.0/Doors%20-%20Abysall%20Main%20%28src%29.lua) — **src** | MIT; Отдельный модуль Abysall, требует глобальные Abysall.Interface/Environment/ESPLibrary; STX.luau загружается И ИСПОЛНЯЕТСЯ автоматически с изменяемой ветки GitHub main, а DeathFarm только по кнопке. |

## Функции, параметры и происхождение

### Grand Piece Online — [Grand Piece Online - Aztup main (src).lua](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Aztup%20main%20%28src%29.lua)

**Источник:** [ModerkaScripts/Aztup-Hub-V3](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/GrandPieceOnline/main.lua)
`45bcead9541ad13c2adc631c1afaecf8bdfc8ed5`; исходный SHA-256 `03c1e5270797a413a551d99e74d2b552155da9439661b5cd513a0a2ad421a2d3`; тело в опубликованном файле `fa4b8411ea530206a45c58433849828fe5f4beeb234113f9c69ca81f556fc31e`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `functions.getNPC(searchNpcName)`<br>**searchNpcName: string** | Ищет живого NPC GPO с атрибутом NPCID; возвращает npc, Humanoid и квест из Modules.NPCInteractions. |
| `functions.autoQuest(toggle)`<br>**toggle: boolean** | Обрабатывает Defeat/Find квесты через Events.Quest:InvokeServer с takequest/quit/founditem/returnitem. |
| `functions.autoAttack(toggle)`<br>**toggle: boolean** | Меняет константы GunHandle/Hitbox и запускает боевой цикл с выбором ближайшего NPC; fireCombat имитирует ввод мыши/клавиши. |
| `functions.shipFarm(toggle)`<br>**toggle: boolean** | Автофарм кораблей, определяет судно в инвентаре и перемещает персонажа к целям. |

**Ограничения и безопасность:**
- Модуль не автономен: sharedRequire, accountData, library, getgc, syn, hookmetamethod и другие части Aztup отсутствуют.
- В upstream functions.newTeleportAsync(...) — ЗАГЛУШКА: только assert с некорректным логическим условием и return {await=function() end}; autoQuest/autoFarm не получают от неё перемещения.
- Удалены две отправки на BanWebhook и несколько FireWebhook-вызовов с accountData.uuid/trace; опциональный DF Notifier Webhook.new(webhookLink) оставлен и включается пользователем. Исходный Aztup loader отдельно передаёт аналитику; сюда он не включён.
- В Roblox не проверено; синтаксическая проверка не доказывает эффект и безопасность.
**Изменения копии:**
- scripts/sanitize_aztup_gpo.py удалил Ban/FireWebhook transport, бан-аналитику, вызовы Send и сбор usedFeatures; блокировка некоторых Skill вызовов сохранена. Сравнение diff: только эти удаления.

### Grand Piece Online — [Grand Piece Online - Aztup Perfect Block (src).lua](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Aztup%20Perfect%20Block%20%28src%29.lua)

**Источник:** [ModerkaScripts/Aztup-Hub-V3](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/GrandPieceOnline/PerfectBlock.lua)
`45bcead9541ad13c2adc631c1afaecf8bdfc8ed5`; исходный SHA-256 `b5804fa7724ce78c87121781f428bc512898e13078cf1cf5cd18492427ad227e`; тело в опубликованном файле `b5804fa7724ce78c87121781f428bc512898e13078cf1cf5cd18492427ad227e`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `PerfectBlock.new(character)`<br>**character: Model** | Подписывается на Humanoid.AnimationPlayed для NPC/другого игрока и отслеживает удаление персонажа. |
| `parryAttack(timings, rootPart, animationTrack, maxRange, useAnimSpeed)`<br>**timings: number[], rootPart, animationTrack, maxRange, useAnimSpeed** | Планирует нажатия клавиши F по ID анимации и длительности; rootPart/maxRange в parry сейчас не используются. |
| `init(t)`<br>**t: boolean** | Включает/выключает слушателей workspace.NPCs и workspace.PlayerCharacters; возвращён модулем для GPO main. |

**Ограничения и безопасность:**
- Нужны sharedRequire Aztup, getgenv, keypress/keyrelease и GPO-анимации из старого набора; модуль импортируется main.lua, но не является самостоятельным хабом.
- Пинг в calculatePingWait(n) фактически не учитывается, maxRange в parry не проверяется; в Roblox не проверено.

### Ro-Ghoul — [Ro-Ghoul - Aztup module (src).lua](../dobf%20scripts%201.0/Ro-Ghoul%20-%20Aztup%20module%20%28src%29.lua)

**Источник:** [ModerkaScripts/Aztup-Hub-V3](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/RoGhoul/main.lua)
`45bcead9541ad13c2adc631c1afaecf8bdfc8ed5`; исходный SHA-256 `27e3b957f00ba7056c12a6883541a712df487fa9ad26fc07448a1683985b19df`; тело в опубликованном файле `27e3b957f00ba7056c12a6883541a712df487fa9ad26fc07448a1683985b19df`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `getClosestMob()`<br>**нет** | Выбирает по дистанции/приоритетам моба в NPCSpawns или BossSpawns, учитывая выбранный квест и безопасность зоны. |
| `toggleAutoFarm(toggle)`<br>**toggle: boolean** | Ставит персонажа под мобом, посылает KeyEvent:FireServer(RemoteKey, Mouse1/E/R/F, ...) для Kagune/Katana/Quinque. |
| `toggleCashOutReputation(toggle)`<br>**toggle: boolean** | Делает InvokeServer ReputationCashOut в игровом цикле. |
| `toggleAutoTrainer(t)`<br>**t: boolean** | Вызывает Remotes.Trainers.RequestTraining для тренера своей команды. |

**Ограничения и безопасность:**
- Полагается на getgc/getconstants для получения динамического RemoteKey и инфраструктуру Aztup; если ключ не получен, исходник вызывает LocalPlayer:Kick.
- Включён старый UI и dataloss-опции; перед использованием анализируйте ограничения сохранений. В Roblox не проверено.

### Project Mugetsu — [Project Mugetsu - Aztup module (src).lua](../dobf%20scripts%201.0/Project%20Mugetsu%20-%20Aztup%20module%20%28src%29.lua)

**Источник:** [ModerkaScripts/Aztup-Hub-V3](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/ProjectMugetsu.lua)
`45bcead9541ad13c2adc631c1afaecf8bdfc8ed5`; исходный SHA-256 `cfb2dd642faf7d388f6bed1195fe5d37a69eeb77ed3b7cc06d956d9ed106fbb3`; тело в опубликованном файле `cfb2dd642faf7d388f6bed1195fe5d37a69eeb77ed3b7cc06d956d9ed106fbb3`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `isDatalossSet(myData)`<br>**myData: Instance** | Проверяет длину игровых Keys у Player_Data для определения состояния данных. |
| `funcs.setUpDataloss(t)`<br>**t: boolean** | Отправляет UpdateKeys с различными именами клавиш; функция определяется повторно в ветке лобби. |
| `funcs.rollBackData(t, bypass)`<br>**t: boolean, bypass: boolean** | Пытается откатить данные кастомизации; может повредить прогресс. |
| `funcs.doSpin(bypass)`<br>**bypass: boolean** | Планирует запросы Customization для вращения клана (вызов в UI частично закомментирован). |

**Ограничения и безопасность:**
- Опасный модуль с манипуляцией dataloss/UpdateKeys и профилем игрока, НЕ рекомендуется запускать на основном аккаунте; исходник содержит закомментированные UI-вызовы.
- Требует библиотеку Aztup и game.PlaceId из набора GAME_PLACE_IDS; в Roblox не проверено.

### Deepwoken — [Deepwoken - Aztup Race Changer (src).lua](../dobf%20scripts%201.0/Deepwoken%20-%20Aztup%20Race%20Changer%20%28src%29.lua)

**Источник:** [ModerkaScripts/Aztup-Hub-V3](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/DeepWokenRaceChanger.lua)
`45bcead9541ad13c2adc631c1afaecf8bdfc8ed5`; исходный SHA-256 `489a70d4e37e343e4875debdd43bd74b1f4c2cf1f2326f1d47935c6df6708081`; тело в опубликованном файле `489a70d4e37e343e4875debdd43bd74b1f4c2cf1f2326f1d47935c6df6708081`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `createCirclet(parent, weldPart, cframe, color)`<br>**parent, weldPart, cframe, color** | Клонирует ассет обруча и приваривает к нужной части аватара. |
| `functions.lightbornSkinColor(t)`<br>**t: boolean** | Меняет локально отображаемые части лица/кожи под Lightborn; для возврата нужен respawn. |
| `contractorToggle(t)`<br>**t: boolean** | Добавляет эффект ContractorString к рукам и торсу и чистит через Maid. |

**Ограничения и безопасность:**
- Только КОСМЕТИКА, не смена серверной расы. Нужны sharedRequire Aztup, UI misc, ассет rbxassetid://12562484379 и эффекты игры.
- Некоторые части аватара могут называться иначе; в Roblox не проверено.

### Ride a Pet — [Ride a Pet - 0x5A46 Eggs (src).lua](../dobf%20scripts%201.0/Ride%20a%20Pet%20-%200x5A46%20Eggs%20%28src%29.lua)

**Источник:** [0x5448OIOI/0x5A46-Ride-A-Pet](https://github.com/0x5448OIOI/0x5A46-Ride-A-Pet/blob/391c3853e944a64fda47744f5a17a79784d8f0b2/Code)
`391c3853e944a64fda47744f5a17a79784d8f0b2`; исходный SHA-256 `7d28ac24652e010113b1f295f2a5c081c8df00f90161c9eb19f5269ef72fb6bd`; тело в опубликованном файле `7d28ac24652e010113b1f295f2a5c081c8df00f90161c9eb19f5269ef72fb6bd`. Лицензия/разрешение: **Apache-2.0**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `acharRaridade(ovo, pos)`<br>**ovo: Model, pos: Vector3** | Связывает отрисованное яйцо с EggSpawns в радиусе 25 studs и читает A_OrigRarity. |
| `lerOvos()`<br>**нет** | Считывает RenderedEggs с типом, редкостью и расстоянием для ESP по фильтру. |
| `escolherAlvo()`<br>**нет** | Выбирает лучшее по luck или ближайшее яйцо выбранного типа. |
| `coletar(relatar)`<br>**relatar: function(status)** | Летит к яйцу, активирует ProximityPrompt, возвращается к плоту, ждёт подтверждения через счётчик яиц на базе. |

**Ограничения и безопасность:**
- Apache-2.0; полный лицензионный текст добавлен в reports/licenses. Интерфейс/фон опционально получают произвольный URL изображения, читают/пишут файлы executor.
- Работа зависит от RenderedEggs/EggSpawns и API fireproximityprompt/getcustomasset; авторская проверка сервера не подтверждена локально. Сеть в Roblox не проверялась.

### All Star Tower Defense — [All Star Tower Defense - KarmaPanda (src).lua](../dobf%20scripts%201.0/All%20Star%20Tower%20Defense%20-%20KarmaPanda%20%28src%29.lua)

**Источник:** [KarmaPanda/Roblox](https://github.com/KarmaPanda/Roblox/blob/1e2656974551c234c8296f3761c3a133177fcf8c/astd.lua)
`1e2656974551c234c8296f3761c3a133177fcf8c`; исходный SHA-256 `bf863c3c3538c8d91d2138c02eafb60f855c79be2ef4af8ad329cd4475bbdeb6`; тело в опубликованном файле `bf863c3c3538c8d91d2138c02eafb60f855c79be2ef4af8ad329cd4475bbdeb6`. Лицензия/разрешение: **author release / attribution requested (no SPDX)**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `SummonUnit(rotation, cframe, unit_name)`<br>**rotation, cframe, unit_name** | Шлёт Remotes.Input Summon и проверяет появление юнита Owner в workspace.Unit. |
| `UpgradeUnit(unit, upgrade_level)`<br>**unit: Model, upgrade_level: number** | Планирует игровые Upgrade до заданного уровня с учётом денег/очереди действий. |
| `StartMacroRecord() / StartMacroPlayback()`<br>**нет** | Записывает игровые Summon/Sell/Upgrade/SkipWave и воспроизводит профиль макроса. |
| `AutoJoinGame()`<br>**нет** | Выбирает ASTD-карту/режим через UI лобби и игровые события. |

**Ограничения и безопасность:**
- Автор README прямо разрешил использовать опубликованный исходник при указании KarmaPanda, но стандартной LICENSE нет; код не выдаётся за MIT.
- Хаб снят с поддержки автором; не гарантируется работа. При исполнении загружает Rayfield с GitHub main; при включении auto_execute обращается к api.irisapp.ca и повторно загружает себя. Опциональные GUI и user-configured webhook, хранилище макросов; в Roblox не проверено.

### A Universal Time — [A Universal Time - Hyper Zoro (src).lua](../dobf%20scripts%201.0/A%20Universal%20Time%20-%20Hyper%20Zoro%20%28src%29.lua)

**Источник:** [ScriptBlox View Raw](https://scriptblox.com/raw/JUJUTSU-KAISEN-A-Universal-Time-3.8-Universl-OP-uto-scend-20583)
`View Raw 2026-10-21`; исходный SHA-256 `3a64589ff6c8e472624b1f19db944d16e5ec9c9436c38f602901bbe830e7c96e`; тело в опубликованном файле `3a64589ff6c8e472624b1f19db944d16e5ec9c9436c38f602901bbe830e7c96e`. Лицензия/разрешение: **self-described open source (no SPDX license)**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `Heartbeat callback()`<br>**нет** | На каждом Heartbeat создаёт task.spawn с тремя запросами Knit для квеста Zoro. |
| `CheckDialogue:InvokeServer("Zoros_Swords_Adventure")`<br>**questName: string** | Проверяет диалог задания Zoro (в опубликованном коде вызывается как PickedUpSword.InvokeServer(CheckDialogue, ...)). |
| `PickedUpSword:InvokeServer() / AscendAbility:InvokeServer(ability)`<br>**ability: значение player.Data.Ability** | Пытается подобрать меч и повысить способность. |

**Ограничения и безопасность:**
- Выложено ScriptBlox автором neutral с названием «open source», но формального SPDX/лицензии нет; права на дальнейшее распространение не уточнялись.
- Историческая версия 2024 года и только режим тренировки; без ограничения частоты шлёт три InvokeServer на Heartbeat (потенциальный троттлинг/кик). Roblox не проверено.

### RO-Wizard — [RO-Wizard - Magma Hub module (src).lua](../dobf%20scripts%201.0/RO-Wizard%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Источник:** [Commandcracker/Magma-Hub](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/1111920082.lua)
`5d7e2f84de039e65f909b50c3533b199fff9e9fd`; исходный SHA-256 `ab4310d15d3c72a726f379ea2017a7136b4aa33884ffe920a6cb5078a946f012`; тело в опубликованном файле `ab4310d15d3c72a726f379ea2017a7136b4aa33884ffe920a6cb5078a946f012`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `UsePrompter(Prompter)`<br>**Prompter: Instance** | Посылает Modules.Network.RemoteEvent TogglePrompter Down/Up. |
| `Unlock All Spells callback()`<br>**нет** | Перемещает персонажа к BookStands и использует Prompter каждой стойки. |
| `Collect All Ingredients callback()`<br>**нет** | Пробегает разные Ingredients и вызывает их Prompter до пяти раз. |

**Ограничения и безопасность:**
- Это вкладка Magma Hub, нужны MagmaHub и Btable; телепортация напрямую меняет HumanoidRootPart.CFrame, могут возникнуть откаты/детект.
- Игра может изменить имена объектов или проверять позицию на сервере; в Roblox не проверено.

### Pet Simulator X — [Pet Simulator X - Magma Hub module (src).lua](../dobf%20scripts%201.0/Pet%20Simulator%20X%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Источник:** [Commandcracker/Magma-Hub](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/2316994223.lua)
`5d7e2f84de039e65f909b50c3533b199fff9e9fd`; исходный SHA-256 `1467665e670ab3c57b5721b15ab069beb961bdaf411093fd131808a477c0c609`; тело в опубликованном файле `1467665e670ab3c57b5721b15ab069beb961bdaf411093fd131808a477c0c609`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `FindNearestCoin()`<br>**нет** | Выбирает ближайшую монету __THINGS.Coins по расстоянию до персонажа. |
| `Auto Farm toggle callback()`<br>**нет** | Вызывает Framework.Signal.Fire("Select Coin", Coin) для числа экипированных питомцев. |
| `Auto Collect Orbs / Lootbags toggle callbacks()`<br>**нет** | Двигает __THINGS.Orbs и Lootbags к локальному персонажу. |

**Ограничения и безопасность:**
- Требует MagmaHub/Threads и старую структуру Pet Simulator X; Auto Collect Gifts находит RemoteFunction по общему имени и может обращаться не к тому remote.
- Если монет нет, обращение к Coin:GetChildren() в AutoFarm может упасть; в Roblox не проверено.

### Bloodlines — [Bloodlines - Aztup module (src).lua](../dobf%20scripts%201.0/Bloodlines%20-%20Aztup%20module%20%28src%29.lua)

**Источник:** [ModerkaScripts/Aztup-Hub-V3](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/Bloodlines.lua)
`45bcead9541ad13c2adc631c1afaecf8bdfc8ed5`; исходный SHA-256 `bf254aae3c687d771dcc69184f8c067add64e695dabd78e4eb859010411621a5`; тело в опубликованном файле `bf254aae3c687d771dcc69184f8c067add64e695dabd78e4eb859010411621a5`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `funcs.autoPickup(toggle)`<br>**toggle: boolean** | Отслеживает ID предметов с Pickupable в workspace и вызывает Events.DataEvent PickUp в радиусе 50. |
| `funcs.teleportToChakraPoint()`<br>**нет** | Перемещает HumanoidRootPart к выбранной ChakraPoints.PointName. |
| `funcs.findThunderstormServer(state)`<br>**state: boolean** | Проверяет Thunderstorm в workspace, запрашивает публичные серверы через syn.request и вызывает DataEvent ServerTeleport. |
| `funcs.rollbackData()`<br>**нет** | Отправляет UpdateSettings с огромной строкой и проверяет GetData.Footsteps; намеренная попытка dataloss/отката. |

**Ограничения и безопасность:**
- Этот модуль Bloodlines привязан к PlaceId 10266164381, не автономен: нужны sharedRequire, library, Utility и другие классы Aztup.
- Содержит опасный Rollback Data: намеренный dataloss через 10 млн NUL-байтов, и Purchase Item через Pay; НЕ запускайте эти команды без понимания последствий.
- При исполнении автоматически скачивает два mp3 с aztupscripts.xyz и записывает файлы через executor; функция поиска грозы посылает запросы к games.roblox.com, требует syn.request. Исходный Aztup runtime отдельно использует аналитику.
- В Roblox не проверено; серверная проверка DataEvent PickUp/ServerTeleport неизвестна.

### Doors — [Doors - Abysall Lobby (src).lua](../dobf%20scripts%201.0/Doors%20-%20Abysall%20Lobby%20%28src%29.lua)

**Источник:** [bocaj111004/Abysall](https://github.com/bocaj111004/Abysall/blob/66d4192d00d9b824a304b654bc2d2eb89c3b372b/Games/Doors/Lobby.luau)
`66d4192d00d9b824a304b654bc2d2eb89c3b372b`; исходный SHA-256 `cdeeb00e48765a600c6b037c44b7cdb8fd78c9d434ca04f62758e85571518739`; тело в опубликованном файле `cdeeb00e48765a600c6b037c44b7cdb8fd78c9d434ca04f62758e85571518739`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `Functions.CheckElevators()`<br>**нет** | Ищет лифт в Workspace.Lobby.LobbyElevators с InGameElevator выбранного игрока и вызывает ElevatorJoin/ElevatorExit. |
| `ShopCode input callback(Code)`<br>**Code: string** | Отправляет купон RemotesFolder.ShopCode:FireServer(Code). |
| `CreateElevator button callbacks()`<br>**нет** | Открывает лифты Doors с разными модификаторами через RemotesFolder.CreateElevator. |

**Ограничения и безопасность:**
- Отдельный модуль Abysall без Loader/Interface; upstream Loader.luau автоматически загружает Components/Analytics.luau и отправляет username/executor/game в сторонний сервис. НЕ запускайте upstream Loader без отдельного аудита.
- Не тестировалось в Roblox; команды лифтов и купонов могут измениться.

### Doors — [Doors - Abysall Main (src).lua](../dobf%20scripts%201.0/Doors%20-%20Abysall%20Main%20%28src%29.lua)

**Источник:** [bocaj111004/Abysall](https://github.com/bocaj111004/Abysall/blob/66d4192d00d9b824a304b654bc2d2eb89c3b372b/Games/Doors/Main.luau)
`66d4192d00d9b824a304b654bc2d2eb89c3b372b`; исходный SHA-256 `c54a3d40029b73ee592fb59d1dc7466e4760bbed8cad2faf103fb8d08f5f65ce`; тело в опубликованном файле `c54a3d40029b73ee592fb59d1dc7466e4760bbed8cad2faf103fb8d08f5f65ce`. Лицензия/разрешение: **MIT**. Это `src`, не восстановление из защиты.

| Функция / обработчик (параметры) | Что делает |
| --- | --- |
| `Functions.GetNearestEntity(CheckDisabled, List, UseRaycasting)`<br>**CheckDisabled, List, UseRaycasting** | Выбирает ближайшую сущность Doors (Rush/Ambush/Figure и др.) для уведомлений и укрытий. |
| `Functions.GetNearestHidingSpot()`<br>**нет** | Ищет шкафы/укрытия для защиты от монстров. |
| `Functions.HandleObject(Object)`<br>**Object: Instance** | Разбирает игровые комнаты, двери, предметы и события по типам; регистрирует ESP/подсказки. |
| `Functions.TriggerPrompt(Prompt)`<br>**Prompt: ProximityPrompt** | Активирует игровой ProximityPrompt через доступный API executor. |

**Ограничения и безопасность:**
- Отдельный модуль Abysall, требует глобальные Abysall.Interface/Environment/ESPLibrary; STX.luau загружается И ИСПОЛНЯЕТСЯ автоматически с изменяемой ветки GitHub main, а DeathFarm только по кнопке.
- Upstream Loader.luau автоматически отправляет username/executor/game через Components/Analytics.luau; Loader сюда не включён. В Roblox не проверено.

## Что проверено в каталогах и почему это не новые файлы

| Каталог / ссылка | Вывод |
| --- | --- |
| [RScripts Demonfall HUMILITYCC](https://rscripts.net/script/demonfall-or-humilitycc-v5mz) | Карточка — однострочный загрузчик `yolo5128/HumilityCC/Games/demonfall.lua`. Git-клон содержит 113 KB Luraph v14.1 без лицензии; это не читаемый Lua. |
| [RScripts King Legacy Fazium](https://rscripts.net/script/fazium-new-king-legacy-script-ndH6) | 97 байт загрузчика; `ZaRdoOx/Fazium-files/King-Legacy` — Luraph v14.3 без лицензии. |
| [RScripts Trident FL7](https://rscripts.net/script/fl7-or-trident-survival-4rCq) | 468 байт, ссылается на GitHub-загрузчик; [PINGUIN](https://github.com/PUSCRIPTS/PINGUIN) лицензионно запрещает копирование, его модуль не публикуем. |
| [RScripts GPO Kaizen](https://rscripts.net/script/one-click-farm-farm-any-npc-auto-fish-and-more-qDS6) | 111 байт GitHub-загрузчика; репозиторий не содержит разрешения на публикацию, вместо него добавлены реальные GPO-модули MIT. |
| [ScriptBlox Ride a Pet](https://scriptblox.com/script/Ride-A-Pet-esp-and-tp-eggs-(open-source)-229425) | View Raw — загрузчик `duyvietnam20121/my-script/ride-an-eggs.lua`; автор называет open source, но позже пишет, что script died. Вместо него включён Apache-2.0 `0x5A46`. |
| [ScriptBlox Anime Vanguards](https://scriptblox.com/script/RELEASE-Anime-Vanguards-AUTO-FARM-18163) | View Raw — GitHub loader на MoonSec V3 без разрешения; другой MIT-кандидат лишь перебирает общие имена remote, не подтверждая механику игры. |
| [ScriptBlox Gakuran OweHub](https://scriptblox.com/script/()-Gakuran-Gakuran-OweHub-source-code-by-me-242840) | View Raw даёт GitHub `/Int3rtia/Deobfuscated/tree/main/Gakuran/OweHub`, дерево отвечает 404; содержимое не получено. |
| [ScriptBlox AUT Hyper Zoro](https://scriptblox.com/script/JUJUTSU-KAISEN-A-Universal-Time-3.8-Universl-OP-uto-scend-20583) | Публичный View Raw содержит 3 специфичных Knit remote-вызова, поэтому добавлен с пометкой `(src)`, но это не полный AUT-хаб. |
| [Igor590/demonfall](https://github.com/Igor590/demonfall) | Конкретный 17 KB игровой Lua (`demonfallscript.lua`, `21a2b61`) есть, но нет найденной лицензии/разрешения на перепубликацию. |
| [FTBS2025/king-legacy](https://github.com/FTBS2025/king-legacy), [yourpalalabs/TRIDENT-SURVIVAL-V5-Script](https://github.com/yourpalalabs/TRIDENT-SURVIVAL-V5-Script) | Несмотря на рекламу и MIT-утверждения, в клонах (`cdb30c6`, `7bf6f2e`) нет игрового Lua: только README/лицензия или ZIP-загрузчик; бинарник не запускался. |
| [gtwjr/A-Universal-Time-4.3-Script-No-Key](https://github.com/gtwjr/A-Universal-Time-4.3-Script-No-Key), [desodlingham/AUTFarm](https://github.com/desodlingham/AUTFarm) | В клонах (`b498829`, `a5d8794`) нет Lua: README и/или лицензия. |

Оставшиеся ограничения перечислены в [манифесте JSON](game-sources-2026-10-21-additions.json#L1) (`unresolved`); подробности предыдущих проходов остаются в [первом отчёте](game-sources-2026-10-21.md).
