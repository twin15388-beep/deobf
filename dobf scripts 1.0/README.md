# Игровые Luau: восстановленные и открытые исходники — 21 октября 2026

**61 игровой `.lua` в этой папке**: к прежним 57 добавлены **четыре результата из защищённых входов, ни одного нового `(src)`** — частичные Zero Academia, Item Factory (MoonSec V3), Anime Fighters Simulator (PSU) и статическое раскрытие Fight Your Zombie. Итого **26 раскрытий/частичных восстановлений**, **35 ранее добавленных `(src)`** (это открытые исходники, НЕ деобфускация). Новые файлы сопровождаются закреплёнными входами/лицензиями и [подробным отчётом с параметрами и пределами](../reports/game-sources-2026-10-21-protected.md) / [SHA-256](../reports/game-sources-2026-10-21-protected.json). Игровые скрипты **не запускались в Roblox**; тесты компиляции и макетов не доказывают работу игры или безопасность внешнего UI. Также доступны [предыдущий отчёт по Anime War RNG и Deepwoken](../reports/game-sources-2026-10-21-extra.md), [проход по 15 файлам](../reports/game-sources-2026-10-21-followup.md), [предыдущие 13](../reports/game-sources-2026-10-21-additions.md) и [первое дополнение](../reports/game-sources-2026-10-21.md).

**Следующий поиск:** Lone Survival, Trident Survival, Slayers 2, GPO и King Legacy пока не дали подтверждённого нового игрового восстановления. [Отчёт о кандидатах и офлайн-адаптере Luarmor/Jnkie](../reports/api-delivery-2026-10-21.md). Loader, SDK и сырой защищённый ответ не добавляются в эту папку вместо игрового результата; итог 61/26/35 не меняется.

## Новые результаты только из защищённых входов (не `(src)`)

| Игра | Восстановленный файл | Игровые обработчики и предел |
| --- | --- | --- |
| Zero Academia | [ZeroScripts (partial)](Zero%20Academia%20-%20ZeroScripts%20%28partial%29.lua) — **8 вручную переписанных прототипов исправленного PSU-bytecode** | `questSnapshot(player)`, `autoQuestLoop(state,deps)` (Cancel/Accept/Complete), `npcAlive(npc)`, `tweenToNpc(npc,settings,deps)` со скоростью 150, `pressKey(key,argument,deps)` и `swing(argument,deps)` с игровыми remotes, `autoFarm(state,deps)` по NPC/Keys и `autoSpinLoop(state,deps)` с `CommonSpin` при Cash > 5000. **Не хаб:** нет UI/bootstrap/getNPC/useKey, не хватает зависимостей, spin тратит игровую валюту. Имена/параметры/пояснения добавлены составителем; 28 макетных сценариев сверены только с выбранным исправленным bytecode. |
| Fight Your Zombie | [MoMoHub](Fight%20Your%20Zombie%20-%20MoMoHub.lua) — **всё 522-строчное тело вывода WAD-декодера** | Lucky Block prompt, ближайшие `WalkingZombies` и `Plots[*].TreeSpawn`, `EquipAxe`/`AxeSwing`, увеличение `Coin.HitBox`. Игровой код **inline**, не отдельный loader/UI; но для запуска подгружается **изменяемая внешняя X2ZU UI**. 17 проверок на макетах обнаружили также **залипание флагов при отключении AutoLuckyBlock/AutoFarmWalking**. Название плейса совпадает с официальной карточкой (PlaceId 92683694220101) [1](https://www.roblox.com/games/92683694220101/Fight-Your-Zombie), но соответствие кода и работа в Roblox не проверены. Это MPL-2.0, [полная лицензия](../reports/licenses/MomoHub-MPL-2.0.txt), а не MIT. |
| Item Factory | [MoonSec V3 (partial)](Item%20Factory%20-%20MoonSec%20V3%20%28partial%29.lua) — **десять выбранных прототипов переписаны вручную**, НЕ весь MoonSec-хаб | `findClosest` (неигровые игроки, 500 studs, HP > 1), `onSelectedMap` (PvE/PvP/KOTH, цилиндры и 150 studs), `equip`/`speed` (оружие), `dropTrash` (сумка ≥ 9, `GoPlaces("Home")`, внешний `moveTo`), `dropBelowRarity` (может выбросить предметы), `retreatAtHealth` (порог HP), `upgrade` (доступные улучшения, покупка), `farmTick` (0,01/1/0,1 с, клик и MoveTo), `fromSuffixString` (числа с суффиксами). **Полный поднятый chunk не проходит проверку Lua 5.1**; `moveTo`/UI нет. Добавленные имена/`state`/`deps` не авторские. 44 сравнения с выбранными прототипами на макетах + 1 smoke для `press`; не с защитой или Roblox. MIT в заголовке. Название совпадает с карточкой [1](https://www.roblox.com/games/7280506312/Item-Factory), PlaceId в коде не подтверждён. |
| Anime Fighters Simulator | [PSU (partial)](Anime%20Fighters%20Simulator%20-%20PSU%20%28partial%29.lua) — **десять выбранных игровых детей исправленного bytecode переписаны вручную**, не весь хаб | `setRarity(state,deps,rarity,enabled)` выбирает Common/Rare/Epic/Legendary/Mythical через `PetStats` (дубликаты возможны); `massSellTick`/`massSellLoop` **продают** выбранные UI-UID через `Remote.MassSell` раз в 1 с; `clickDamageOnce`/`autoClickDamageLoop` вызывают `ClickerDamage` и FakeDown/FakeUp (0,02/0,05 с); `refreshMobOptions` временно **перемещает персонажа** для поиска спавнеров и целей мира; `travelToWorld` ставит CFrame над SpawnLocation и вызывает `AttemptTravel`. Нужны `deps.game`/`require`/`wait`/`Vector3`, для списка целей — `targetDropdown`; UI и farm/auto-buy не включены. Имена/`state`/`deps` наши, 20 офлайн-сравнений **только с исправленными изолированными прототипами**, не с Roblox. MIT. Исходный корень отвергает PlaceId **4042427666** (это *другая*, Anime Fighting Simulator); предполагаемый AFS — [6299805723](https://www.roblox.com/games/6299805723/Anime-Fighters), но привязка к его текущей версии не доказана. |

**Отчёт:** [игровые параметры, точные входы/хеши, отрицательные результаты и ограничения](../reports/game-sources-2026-10-21-protected.md). В частности, полный PSU-хаб Zero Academia и Anime Fighters не были получены в виде надёжного Lua; не представляем диагностический bytecode как готовый файл.


**Откуда русские комментарии:** в трёх старых файлах `(partial)` для GPO, All Star Tower Defense и Ro-Ghoul их **написал составитель при ручной реконструкции фрагментов байткода**; это **не** комментарии оригинального автора и **не** готовые хабы. В Bloxstrike Memesense `(src)` комментарии побайтово присутствуют в исходнике upstream, а в раскрытом Gakuran кириллица — строки UI/сообщений, не комментарии. Заголовки с происхождением и ограничениями добавлены нами. [Аудит каждого случая с хешами и повторной распаковкой](../reports/russian-text-provenance-2026-10-21.md). Не принимайте пометки и дополнительные `deps`/оболочки `(partial)` за дословно восстановленный код.

## Предыдущий проход: один вскрытый строковый слой и один крупный `(src)`

| Игра | Новый файл | Функции и честный предел |
| --- | --- | --- |
| Anime War RNG | [WaveHub](Anime%20War%20RNG%20-%20WaveHub.lua) — **статическое раскрытие строк** | 607/607 значений и 1 070 вызовов; `fire(name, ...)`, `requestTraitRoll()`, `processInventorySync(payload)`, `tryAutoTreePurchase(force)` и `watch("RaidSync", callback)`. Тело 3 521 строка, включая общий shell и игровой UI, **но WindUI загружается извне и не входит в этот объём**. Roblox не проверялся. |
| Deepwoken | [Aztup main (src)](Deepwoken%20-%20Aztup%20main%20%28src%29.lua) — **открытый исходник с патчем телеметрии** | 7 692 строки игрового тела: `functions.autoParry(toggle)`, `functions.oresFarm(toggle)`, `functions.autoLoot(toggle)`, `functions.fishFarm(toggle)`. Удалены безусловные POST/пустой debug-webhook; **загрузка MP3, GET списка модераторов и пользовательские webhook остаются**. Требует оригинальный Aztup Hub. НЕ деобфускация и НЕ автономный файл. |

[Все параметры, исходные SHA-256, размеры UI и статусы защищённых вариантов](../reports/game-sources-2026-10-21-extra.md). Отсутствие полноценного 6-тысячестрочного UI в выходном файле **не** означает автоматически неполноту игрового кода: WindUI/UILibrary являются внешними зависимостями. И наоборот: 13 тыс. строк `(src)` или 76 тыс. строк зашифрованного входа не подтверждают восстановление. Защищённые кандидаты без разрешения и неудачные декомпиляции не выдаются за опубликованный код.

## Предыдущие 15 файлов: семь раскрытий защиты и восемь `(src)`

| Игра | Файлы | Что реально находится в коде и что не подтверждено |
| --- | --- | --- |
| Gakuran | [Dep Hub](Gakuran%20-%20Dep%20Hub.lua) — **деобфускация исторического WeAreDevs-входа** | `f34(p27)` обрабатывает `workspace.Hitboxes` и рассчитывает парирование, `f53(p42)` читает MIDI, `f48()` ищет BasketballShotMeter. Hydra UI скачивается и исполняется отдельно; PlaceId/Roblox не проверялись. Универсальный `DEPEMOTES.lua` из актуального HEAD в каталог не попадал. |
| SCP-3008 | [Sealient UI](SCP-3008%20-%20Sealient%20UI.lua), [Abyssal Luminx](SCP-3008%20-%20Abyssal%20Luminx.lua), [Abyssal Redux](SCP-3008%20-%20Abyssal%20Redux.lua) — **три разных раскрытия** | ESP сотрудников `GameObjects.Physical.Employees`, поиск/ESP предметов еды, телепорт с задержкой возврата; старый Redux требует Drawing API. Все три при запуске тянут разные внешние UI-библиотеки. |
| Piggy | [Sealient UI](Piggy%20-%20Sealient%20UI.lua) — **деобфускация** | `v8:CreatePiggyESP(p4)`, `v8:CreateItemESP(p3)`, расстояние до Piggy; Fluent UI загружается с изменяемых URL, кнопка обновления отдельно исполняет новую версию. |
| Demonology | [Luminx Ghost ESP](Demonology%20-%20Luminx%20Ghost%20ESP.lua) — **MoonVeil v1.4.5, не MoonSec V3** | Workspace.Ghost/Items, `R38(value)` для FlowerPot/SpiritBook, Highlights и цели камеры. 41 прототип, 2 991 слот, 305 совпавших proxy-событий — **не Roblox**; Luminx UI загружается извне. Нет подтверждённого поиска вида призрака. |
| Prison Life | [Vex Hub](Prison%20Life%20-%20Vex%20Hub.lua) — **деобфускация**, [Magma Hub module (src)](Prison%20Life%20-%20Magma%20Hub%20module%20%28src%29.lua) | Vex: команда Guards и `Remotes.ArrestPlayer`, UI WindUI; оригинал назван `Half-Broken`. Magma: ItemHandler/TeamEvent/meleeEvent, не автономен; Spawn Guns намеренно обнуляет здоровье. |
| Retail Tycoon 2 | [Magma Hub module (src)](Retail%20Tycoon%202%20-%20Magma%20Hub%20module%20%28src%29.lua) | `GetCar()`, `TeleportCar(pos)`, StockShelfFunction/LoadVehicle/UnloadVehicle; нужна оболочка Magma Hub, игровой API 2023 года. |
| Super Power Training Simulator | [Magma Hub module (src)](Super%20Power%20Training%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua) | `onHealthChanged(health)`, тренировка `RemoteEvent` (+FS1..+FS6); нужен Magma Hub, частота/сервер не проверены. |
| Vehicle Simulator / Magnet Simulator / Dashing Simulator | [Vehicle (src)](Vehicle%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua), [Magnet (src)](Magnet%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua), [Dashing (src)](Dashing%20Simulator%20-%20Magma%20Hub%20module%20%28src%29.lua) | Машина/ящики, `MagnetEvents.requestGrab`, скорость/гонки. Все три — зависимые модули Magma; в Vehicle «Give All Perks» пишет в read-only `UserId`, не считать функцией выдачи. |
| Anime Origins (tower defense) | [Ultimate (src)](Anime%20Origins%20-%20Ultimate%20%28src%29.lua) | `executeAction(action)` записывает/воспроизводит PlaceTower/UpgradeTower; `autoRiftTarget()`, SummonTower и магазин. MIT-исходник, не деобфускация. По кнопке исполняет внешний зашифрованный FakeVisual; опциональные webhook/обмен макросами. |
| SCP-096 | [MaddHub module (src)](SCP-096%20-%20MaddHub%20module%20%28src%29.lua) | `farmMats(resource)`, `equipTool(toolName)`, модель SCP-096. Без UI/глобальных переменных MaddHub не запустится, изменение атрибутов может быть только клиентским. |

**Детали и все параметры:** [новый отчёт по 15 файлам](../reports/game-sources-2026-10-21-followup.md). Внешние библиотеки не включены и не аудированы; все утверждения о механике основаны на статическом чтении кода.

## Предыдущие 13 файлов `(src)`: настоящие игровые обработчики, не загрузчики

| Игра | Новые файлы | Суть и предел |
| --- | --- | --- |
| Grand Piece Online | [Aztup main (src)](Grand%20Piece%20Online%20-%20Aztup%20main%20%28src%29.lua), [Aztup Perfect Block (src)](Grand%20Piece%20Online%20-%20Aztup%20Perfect%20Block%20%28src%29.lua) | NPC/квесты/боевые remotes и блок по GPO-анимации. Из main **удалена встроенная отправка accountData.uuid на вебхук**; `newTeleportAsync` в оригинале — заглушка. Оба модуля связаны, без Aztup не автономны. |
| All Star Tower Defense | [KarmaPanda (src)](All%20Star%20Tower%20Defense%20-%20KarmaPanda%20%28src%29.lua) | Полный опубликованный исходник, Summon/Upgrade/запись макросов; автор снял поддержку, разрешил использовать с указанием имени, без стандартной LICENSE. **При запуске тянет изменяемый Rayfield**, опциональный `auto_execute` — внешний URL; это **не** восстановление прежнего PSU-входа. |
| Ride a Pet | [0x5A46 Eggs (src)](Ride%20a%20Pet%20-%200x5A46%20Eggs%20%28src%29.lua) | `RenderedEggs`, `EggSpawns`, выбор редкости, ESP и попытка забрать яйцо/вернуться на базу; Apache-2.0, возможные побочные эффекты загрузки изображений и файловых API. |
| A Universal Time | [Hyper Zoro (src)](A%20Universal%20Time%20-%20Hyper%20Zoro%20%28src%29.lua) | **Небольшой** исходник только для Zoro: CheckDialogue/PickedUpSword/AscendAbility на каждом Heartbeat, потенциальный флуд remote; автор ScriptBlox назвал open source, формальной лицензии нет. Не полноценный AUT-хаб. |
| Ro-Ghoul | [Aztup module (src)](Ro-Ghoul%20-%20Aztup%20module%20%28src%29.lua) | Мобы, Kagune/Quinque, ReputationCashOut, тренеры. Нужны динамический remote key и Aztup; может вызвать Kick при ошибке ключа. |
| Project Mugetsu | [Aztup module (src)](Project%20Mugetsu%20-%20Aztup%20module%20%28src%29.lua) | Клавиши и кастомизация; **опасные изменения dataloss/профиля**; не рекомендуется запускать на основном аккаунте. |
| Deepwoken | [Aztup Race Changer (src)](Deepwoken%20-%20Aztup%20Race%20Changer%20%28src%29.lua) | Локальная косметика Lightborn/Contractor, **не настоящая смена расы**, требует Aztup. |
| RO-Wizard | [Magma Hub module (src)](RO-Wizard%20-%20Magma%20Hub%20module%20%28src%29.lua) | TogglePrompter, стойки заклинаний, книги, ингредиенты; нужна оболочка Magma Hub. |
| Pet Simulator X | [Magma Hub module (src)](Pet%20Simulator%20X%20-%20Magma%20Hub%20module%20%28src%29.lua) | `__THINGS.Coins`, `Select Coin`, Orbs/Lootbags; подарки обрабатываются общим поиском RemoteFunction и могут ошибаться. |
| Bloodlines | [Aztup module (src)](Bloodlines%20-%20Aztup%20module%20%28src%29.lua) | `DataEvent PickUp`, `ChakraPoints`, поиск грозы по серверам. **При запуске скачивает два mp3 с aztupscripts.xyz**; команда `Rollback Data` намеренно вызывает dataloss, нужен Aztup. |
| Doors | [Abysall Lobby (src)](Doors%20-%20Abysall%20Lobby%20%28src%29.lua), [Abysall Main (src)](Doors%20-%20Abysall%20Main%20%28src%29.lua) | Лифты/купоны и комнаты/Rush/Figure; отдельно не автономны. **Исходный Loader Abysall автоматически посылает имя игрока/исполнитель на сторонний сервис** (Loader не включён). Main сам **автоматически загружает исполняемый STX** с изменяемого GitHub main. Не запускать без аудита. |

**Оставшиеся пробелы после всех 59 файлов:** в King Legacy пока только прежний ограниченный UI/ESP core без подтверждённого фарма; для Demonfall, Trident Survival, VV Ultimatum, Anime Vanguards и отдельно подтверждённой игры «Illegal Sorcer» дополнительных игровых Lua с проверенными правами не найдено. **Gakuran теперь есть:** защищённый исторический Dep Hub действительно раскрыт и отличается от универсального DEPEMOTES. RScripts часто показывает только однострочные загрузчики; кандидаты без разрешения или игровые `.exe` не выдаются за Luau. GPO, ASTD, AUT и Ride a Pet представлены ранее открытыми исходниками **с указанными ограничениями**, а не новыми восстановленными файлами. [Результаты нового поиска и причины отказов](../reports/game-sources-2026-10-21-followup.md#пробелы-и-проверенные-тупики) · [обзор прежних карточек](../reports/game-sources-2026-10-21-additions.md#что-проверено-в-каталогах-и-почему-это-не-новые-файлы).

## Первое дополнение: 15 файлов (13 `(src)`, 2 статически восстановлены)

| Игра | Файлы с настоящими обработчиками | Коротко и ограничения |
| --- | --- | --- |
| Bloxstrike | [Hotline UI](Bloxstrike%20-%20Hotline%20UI.lua) — **деобфускация с удалённой телеметрией**; [Memesense (src)](Bloxstrike%20-%20Memesense%20%28src%29.lua) | Команды Terrorists / Counter-Terrorists, `_performRaycast`, spread и ESP; Memesense тянет внешнюю Obsidian UI |
| Blade Ball | [Nexus Hub](Blade%20Ball%20-%20Nexus%20Hub.lua) — **деобфускация**; [Nightmare Hub (src)](Blade%20Ball%20-%20Nightmare%20Hub%20%28src%29.lua) | `Balls`, `realBall`, `zoomies`, target-aware parry, `ParryButtonPress`; обе UI требуют внешнюю Rayfield |
| Forsaken | [Forsaken Plus (src)](Forsaken%20-%20Forsaken%20Plus%20%28src%29.lua); [Emotes GUI (src)](Forsaken%20-%20Emotes%20GUI%20%28src%29.lua) | Генераторы `PuzzleUI`, игровые QTE и `Assets.Emotes`; Plus поддерживает **запуск локальных плагинов** и запрос к стороннему API |
| Blue Lock Rivals | [Denzel Dribble (src)](Blue%20Lock%20Rivals%20-%20Denzel%20Dribble%20%28src%29.lua) | `BallService.RE.Dribble`, `Football`, предсказание траектории; не путать с Blue Lock Farm |
| Tower Defense X | [TDX Autofarm (src)](Tower%20Defense%20X%20-%20TDX%20Autofarm%20%28src%29.lua) | `PlaceTower`, `TowerUpgradeRequest`, `SkipWaveVoteCast`, карта APC; у исходника **ошибка в ветке `tryUntilSucceed=true`** |
| Vesteria | [Cheater Soul (src)](Vesteria%20-%20Cheater%20Soul%20%28src%29.lua) | `playerRequest_damageEntity`, способности, подбор лута; записывает `epicthing.config` |
| Blox Fruits | [Ardi Hub (src)](Blox%20Fruits%20-%20Ardi%20Hub%20%28src%29.lua) | Ближайший моб в `workspace.Enemies`, `Remotes.CommF_:InvokeServer("Combat", ...)`, попытка квеста; **серверные аргументы не подтверждены**, внешняя Kavo UI |
| Swordburst 2 | [Magma Hub module (src)](Swordburst%202%20-%20Magma%20Hub%20module%20%28src%29.lua); [Aztup module (src)](Swordburst%202%20-%20Aztup%20module%20%28src%29.lua) | Два разных игровых модуля: инвентарь/мобы и бой/автофарм; оба **не автономны** и требуют свои исходные хабы |
| Arcane Odyssey | [Aztup module (src)](Arcane%20Odyssey%20-%20Aztup%20module%20%28src%29.lua) | Рыбалка, квестовые цели, перемещение; требует оригинальную инфраструктуру Aztup |
| Voxl Blade | [Aztup module (src)](Voxl%20Blade%20-%20Aztup%20module%20%28src%29.lua) | Мобы, подземелья, продажа предметов; требует инфраструктуру Aztup |
| Adventure Tales | [Aztup module (src)](Adventure%20Tales%20-%20Aztup%20module%20%28src%29.lua) | Статы оружия, NPC, массовая продажа; требует инфраструктуру Aztup |

**Первое дополнение не устранило все пробелы.** После него отдельно добавлены игровые исходники GPO, ASTD и другие из таблицы выше; прежние частичные результаты не были «доделаны» и остаются отдельными файлами. По-прежнему не заменяем отсутствие игрового кода универсальным загрузчиком. Детали первого поиска — [в исходном отчёте](../reports/game-sources-2026-10-21.md#открытые-пробелы-вместо-универсальных-скриптов), новые находки/отказы — [в дополнительном отчёте](../reports/game-sources-2026-10-21-additions.md).

---

## Предыдущий проход: 12 восстановленных файлов (19–21 октября 2026)

В предыдущем проходе опубликованы **девять читаемых выходов из обфусцированных входов для семи заявленных игр** и **три отдельных частичных результата по Grand Piece Online, All Star Tower Defense и Ro-Ghoul**: всего двенадцать файлов / десять игр. Для этих трёх игр доступны только выбранные игровые участки из поднятого PSU-байткода, **не полные скрипты**; возвращаемые модулями таблицы и говорящие имена добавлены при оформлении. Это не подборка открытых соседних исходников или универсальных загрузчиков. **Оговорка для King Legacy:** удалось восстановить только фирменный `core.lua` с UI и ESP уровня/PVP; его основные действия довольно общие, игровых remote-вызовов для фарма там нет. Это не «полный скрипт King Legacy».

**Статус проверки:** все двенадцать файлов скомпилированы `luau-compile --null`, три частичных модуля также скомпилированы Lua 5.1 и проверены на подставных объектах **без Roblox и сети**. Ни защищённые входы, ни выходы не запускались в Roblox. Компиляция и подставные объекты **не доказывают** работоспособность, эквивалентность оригиналу или безопасность. Имена `f1`, `p1`, `v1` и новые имена в трёх частичных модулях — восстановленные/описательные обозначения, а не подлинные локальные имена автора. Сохранённые внешние `loadstring(game:HttpGet(...))` в полных выходах требуют отдельного аудита; **не запускайте эти файлы вслепую**. Хэши входов/выходов, точные коммиты и предупреждения — в [машинном отчёте](../reports/game-recovery-2026-10-19.json), способ воспроизведения — в [методике](../reports/game-recovery-2026-10-19.md). Права на сторонние исходники не проверены.

| Игра | Восстановленный файл | Что именно видно / предел |
| --- | --- | --- |
| Grand Piece Online | [Lunar Hub (partial).lua](Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua) | **Частично:** квесты, числовой `teleportNumeric`, `tweenAboveNpc`, `normalBarrelLoop(enabled,deps)` (Buy/Sell; числовой Tween при noclip=false, внешний `deps.banner`), боевой remote, лёд Hie-Hie. **Нет** полного `teleport()` для userdata/CFrame и noclip, GUI и самостоятельного автофарма |
| All Star Tower Defense | [Assasine03 Autofarm (partial).lua](All%20Star%20Tower%20Defense%20-%20Assasine03%20Autofarm%20%28partial%29.lua) | **Частично:** `Remotes.Input` — `Summon`, `Sell`, `Upgrade`, `VoteWaveConfirm`; циклы, GUI и подбор точки размещения отсутствуют |
| Ro-Ghoul | [Yoshimura Quest (partial).lua](Ro-Ghoul%20-%20Yoshimura%20Quest%20%28partial%29.lua) | **Частично:** квест `Aogiri Member` у Yoshimura, `ReputationCashOut`, параметры боссов; без движка перемещения и автофарма |
| Jujutsu Shenanigans | [Inquest Moveset.lua](Jujutsu%20Shenanigans%20-%20Inquest%20Moveset.lua) | `MainEnv()`, анимационные обработчики способностей и игровые `Service.RE.Activated` |
| Jujutsu Shenanigans | [Pantheon Hub.lua](Jujutsu%20Shenanigans%20-%20Pantheon%20Hub.lua) | Flash Step, обработчики анимаций, JJS UI; внешняя WindUI и неразрешённые глобалы |
| King Legacy | [Luxury Core.lua](King%20Legacy%20-%20Luxury%20Core.lua) | UI, ESP уровня/PVP, выбор игрока; **не** фарм квестов, механики ESP в основном общие |
| Violence District | [ANCH Hax.lua](Violence%20District%20-%20ANCH%20Hax.lua) | поиск генератора и ремонт, Killer/Survivor, ESP, перемещение; внешняя UI-библиотека |
| Illegal Soccer | [Smart GK.lua](Illegal%20Soccer%20-%20Smart%20GK.lua) | мяч `ClientBall_MainMatch`, ворота `Team1`/`Team2`, управление вратарём |
| Murder Mystery 2 | [Azure Hub.lua](Murder%20Mystery%202%20-%20Azure%20Hub.lua) | роли Knife/Gun, ESP, выпавшее оружие, стрельба и перемещение |
| Murder Mystery 2 | [KS Hub.lua](Murder%20Mystery%202%20-%20KS%20Hub.lua) | определение ролей по предметам, подсветка, UI |
| Blue Lock Farm | [RELWX.lua](Blue%20Lock%20Farm%20-%20RELWX.lua) | конвейер, тип/мутация коробок, полировщик, прокачка юнитов; **не Blue Lock Rivals** |
| Wild Horse Islands | [WHI Farm.lua](Wild%20Horse%20Islands%20-%20WHI%20Farm.lua) | поиск диких лошадей по UI, тренировки/гонки, авто-перемещение |

## Подлинные фрагменты восстановленных функций

Это **выдержки**, не пересказ вместо кода: результаты — по ссылкам в таблице. У GPO, ASTD и Ro-Ghoul доступны **только отмеченные частичные файлы**, а не полные исходные результаты; они составлены из выбранных участков поднятого байткода. `pN` означает параметр с неизвестным первоначальным именем.

### Grand Piece Online — Lunar Hub FREE (частично)

Защищённый `c0deblox/Scripts:GPO.lua` (PSU 4.0.A) **статически** поднят в Lua 5.1 bytecode. В нём присутствуют непосредственно игровые квесты (`Help Raphtalia`, `Take down Lucid`), NPC и `ReplicatedStorage.Events.Quest`/`Events.CombatRegister`, а также `WaterLogia["Hie-Hie"]`; связь с GPO подтверждается **содержимым**, а не названием репозитория. Выделены прототипы #9/#12 (движение), #17/#18, #19/#20, #22/#23 (подход над NPC), #31, #72 (бочки из исправленного лифта) и #90; это не результат копирования готового открытого скрипта. Файл [Grand Piece Online - Lunar Hub (partial).lua](Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua) содержит **сам код**, таблицы квестов и координат.

`calculateTime(x, y, z)` вычисляет секунды как расстояние от `HumanoidRootPart.Position` до числовых координат **либо до `.X/.Y/.Z` у userdata-CFrame**, делённое на `_G.speed` (в исходной инициализации 175; отдельно нужно задать при использовании модуля). Это добавление **не** означает, что `teleportNumeric` поддерживает CFrame как вход. `teleportNumeric(x, y, z)` воспроизводит **только числовой маршрут** функции #12 при выключенном `getgenv().noclip`: при расстоянии >1000 студов и высоте игрока >10 сначала делает Tween `Position` до Y=0, затем Tween `CFrame` в `(x, y, z)`, ждёт `Completed:Wait()`, сбрасывает `_G.teleporting` и возвращает `(tween, duration)`. Например, действительный восстановленный фрагмент:

```lua
local duration = calculateTime(x, y, z)
local tween = game:GetService("TweenService"):Create(root,
    TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
    { CFrame = CFrame.new(x, y, z) })
tween:Play()
tween.Completed:Wait()
_G.teleporting = false
return tween, duration
```

`takeQuest(npcName)` получает ключ NPC, берёт название и координаты из `Quest`/`QuestPos`, вызывает восстановленный числовой маршрут, **после его завершения** отправляет квест:

```lua
local function takeQuest(npcName)
    if npcName ~= "None" then
        local questName = Quest[npcName]
        local position = QuestPos[npcName]
        teleportNumeric(position.X, position.Y, position.Z)
        game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest", questName})
    end
end
```

`tweenAboveNpc(targetNpc)` принимает модель NPC с `Head.CFrame` и `HumanoidRootPart.CFrame`/`.lookVector`. Восстановленный прототип #22 вызывается внутри **не восстановленного** цикла AutoFarmNPC #84: он считает время до NPC и перемещает игрока на **3 студа выше головы и 5 позади взгляда цели**, дожидается окончания Tween и снимает `_G.teleporting`. Захваченный исходным прототипом `LocalPlayer` заменён обращением к `game.Players.LocalPlayer`. Сам обработчик опубликован в файле, существенная часть кода:

```lua
local duration = calculateTime(targetNpc.HumanoidRootPart.CFrame)
local root = game.Players.LocalPlayer.Character.HumanoidRootPart
local goal = targetNpc.Head.CFrame + Vector3.new(0, 3, 0)
    + targetNpc.HumanoidRootPart.CFrame.lookVector * -5
local tween = game:GetService("TweenService"):Create(root, TweenInfo.new(duration),
    { CFrame = goal })
tween:Play()
tween.Completed:Wait()
_G.teleporting = false
return tween
```

Функция сама **не выбирает NPC, не атакует и не делает автофарм**; в коде перед Tween также запускается цикл удержания скорости через `spawn`. Две подставные траектории этой функции и userdata-ветвь `calculateTime` сравнены с **неизменённым выбранным дочерним прототипом** байткода при явно поданном upvalue; детали [в отчёте](../reports/game-recovery-2026-10-21-followup.md).

`calculateFromTo(fromX, fromY, fromZ, toX, toY, toZ)` — восстановленный прототип #11: расстояние между точками / `_G.speed`; `fromX` либо `toX` могут быть userdata-CFrame, тогда используются их `.X/.Y/.Z`. Три случая сравнены с отдельным исходным прототипом; лишние компоненты ориентации, передаваемые вызывающим кодом, прототип игнорирует.

`normalBarrelLoop(enabled, deps)` — **восстановленный игровой обработчик #72** (не готовая автономная ферма). `enabled` — флаг переключателя «Autofarm Barrels». `deps.banner({Text=...})` заменяет захваченный UI-метод; `deps.teleport(x,y,z, nineOrientationComponents)` — **необязательная** подмена перемещения; без неё используется восстановленный `teleportNumeric` **только при `getgenv().noclip=false`**, возвращающий вторым значением время. В выделенной функции #12 всего три параметра: две траектории бочек подтвердили, что добавочные девять компонентов поворота игнорируются её поднятым байткодом. Полный путь `teleport()` для userdata/noclip не восстановлен. До вызова задайте `_G.speed` и `getgenv().good = false`, как это делал исходный UI; для числового маршрута выключите noclip. После оценки времени и баннера `while getgenv().ON` ждёт, перемещается к покупке, ждёт её завершения и ещё секунду, шлёт `{action="Buy",barrelType="Normal"}` в `Events.Barrel:FireServer`, идёт к точке продажи, ждёт аналогично и шлёт `Sell`. Обработчик **не ограничивает число повторений** и не проверен в Roblox. Подлинная часть опубликованного кода:

```lua
local move = deps.teleport or teleportNumeric
local _, travelTime = move(-561.834045, 11.9474373, -4466.64453,
    0.0234939456, -5.12754212e-8, -0.999723971, -3.6866743e-9, 1,
    -5.13762188e-8, 0.999723971, 4.8926867e-9, 0.0234939456)
wait(travelTime)
wait(1)
game:GetService("ReplicatedStorage").Events.Barrel:FireServer({
    action = "Buy", barrelType = "Normal",
})
-- Далее: teleport(-4497.41309, 5.98184872, -2668.52979, ...),
-- wait(returnTime), wait(1), FireServer({action="Sell",barrelType="Normal"}).
```

Для #72 **не использован** прежний дефектный поднятый байткод: независимый [постпроход](../scripts/lift_psu_multireturn.mjs) исправил распознавание PSU-вызовов с многозначным результатом (**22 CALL-классификации** на GPO). Только после этого выбранный дочерний прототип с исходным upvalue сверили под макетами на **трёх исходах**: включение/одна покупка-продажа, уже занятый цикл и отключение без действий. Весь исходный защищённый скрипт не выполнялся; `deps`/модульная оболочка добавлены нами. [Воспроизведение и ошибки первоначального лифта](../reports/game-recovery-2026-10-21-followup.md).

`damageNpc(targetNpc, selectedWeapon)` сопоставляет `Katana`/`Kiribachi` → `Sword`, `Black Leg` → `BlackLeg` и отправляет **пять** вызовов `CombatRegister` с `{ "damage", targetNpc.HumanoidRootPart, weapon, {strike, "Ground", weapon} }`. `nearestNpc(npcName)` выбирает ближайшего NPC из `workspace.NPCs`; `nearestNpcExcept(npcName, excludedName)` исключает точное имя. `hieWaterTouch(foot)` клонирует `WaterLogia["Hie-Hie"].floor`, помещает на поверхность воды на пять секунд и очищает `sm2`/`sm3`. Параметр `foot` — коснувшаяся воды деталь; подписка на `Water.Touched` была в остальном UI и **не входит** в опубликованный модуль.

**Важный предел:** `unluac-js` выдал для **целого** хаба диагностический псевдокод с 49 метками ошибки восстановления; после узкой поправки CALL осталось **24 ошибки**, а `luadec` не восстановил программу целиком. Мы **не** публикуем ошибочный псевдокод и **не** заявляем автономный полнофункциональный хаб/ферму: цикл бочек ограничен числовым маршрутом без noclip и требует UI-замены `deps.banner`. `teleportNumeric` намеренно отклоняет входы userdata/CFrame и включённый noclip: их ветви **не восстановлены**. `spawn`-цикл стабилизации персонажа сверён по инструкциям, но не проверен в Roblox. В таблице `QuestPos` отсутствуют `Bandit Boss`, `Axe Hand Logan`, `Gorilla King`, поэтому `takeQuest()` для них без добавочной логики не сработает. Не включены GUI, **полная** реализация `teleport`, другие циклы автофарма (NPC/сундуки) и загрузка MaterialLua. Синтаксис проверен в Lua 5.1 и Luau. Семь числовых маршрутов (в том числе две 12-аргументные траектории бочек) сравнили с **изолированно извлечённым поднятым байткодом** функций #9/#12; квест дополнительно сверили с прототипом #31 на трёх вариантах (`tests/test_gpo_teleport_numeric.lua`). Подход над NPC — два сценария и userdata-время — сверили с прототипами #22/#9 (`tests/test_gpo_npc_tween.lua`). Бочки — три сценария по **исправленному** поднятому прототипу #72, отдельно расстояние #11 и совместное исполнение #72 с выделенной функцией перемещения #12 (`tests/test_gpo_barrels.lua`). Квест/урон/лёд также проверены в отдельном тесте с подставными объектами. Ни один вызов не проверен на живом сервере. Имена функций/модульная оболочка при оформлении изменены, а степень сохранения поведения **всей** защиты неизвестна. [Метод сравнения и ограничения](../reports/game-recovery-2026-10-21-followup.md).

### All Star Tower Defense — Assasine03 Autofarm (частично)

Защищённый `c0deblox/Scripts:ASTD.lua` — PSU-вход со строкой `_G.UIName = "All Star Tower Defense Autofarm"`, полями `WaveValue`/`UnitPlaceAble` и `ReplicatedStorage.Remotes.Input`. Статическое поднятие дало Lua 5.1 bytecode, но **целый** диагностический вывод `unluac-js` содержит 46 меток ошибки: его нельзя запускать или выдавать за восстановленный скрипт. Выбранные действия #18, #19/#21, #22, #23 **дополнительно просмотрены в `luac -l -l`**. [Частичный Lua-модуль](All%20Star%20Tower%20Defense%20-%20Assasine03%20Autofarm%20%28partial%29.lua) даёт код четырёх функций, например:

```lua
local function summonAt(unitName, position)
    if position then
        inputRemote():FireServer("Summon", {
            Rotation = 0,
            cframe = CFrame.new(position.X, position.Y, position.Z),
            Unit = unitName,
        })
    end
end
```

`unitName` — выбранный юнит, `position` — готовая точка, которую в оригинале выбирает **не восстановленная здесь** функция #4. `sellAtWave(enabled, selectedWave)` при достижении волны отправляет `"Sell"` для **всех** моделей в `Workspace.Unit` (без фильтра владельца, как в выбранном участке). `upgradeOwnedUnit(enabled, unit, maxUpgrade)` проверяет `Owner == LocalPlayer`, текущую/максимальную ступень улучшения и отправляет `"Upgrade"` для **одного** юнита. `confirmNextWave(enabled)` проверяет `HUD.NextWaveVote.Visible`, отправляет `"VoteWaveConfirm"` и локально скрывает окно. `enabled` — прежний флаг UI, теперь аргумент однократного вызова, а не восстановленный цикл. **Не входят** UI, выбор уровня, очередь, бесконечные циклы, подбор позиции, контроль паузы автофарма и `pcall` оригинальной ветви Summon. Пройден изолированный тест с макетами и компиляция Lua 5.1/Luau; в Roblox не проверялся.

### Ro-Ghoul — Yoshimura Quest (частично)

Из защищённого `c0deblox/Scripts:Ro-Ghoul.lua` поднят Lua 5.1 bytecode; полный диагностический вывод содержит 28 меток ошибки, **не является рабочим автофармом**. Выбранная функция #24/#25 (и проверка из #35) сверена с дизассемблированным байткодом. [Частичный Lua-модуль](Ro-Ghoul%20-%20Yoshimura%20Quest%20%28partial%29.lua) содержит таблицы требований к `Eto Yoshimura`, `Koutarou Amon`, `Nishiki Nishio` и групп спавна, `needsAogiriQuest(player)` и `yoshimuraAction(shouldTakeQuest, deps)`. Внутри последней реально восстановлены два вызова квестового remote и подписка на прогресс:

```lua
if shouldTakeQuest then
    deps.remotes.Yoshimura.Task:InvokeServer()
    wait()
    deps.remotes.Yoshimura.Task:InvokeServer()
    local progress = deps.player.PlayerFolder.CurrentQuest.Complete:WaitForChild("Aogiri Member")
    deps.questUI.label.Text = deps.questUI.prefix .. progress.Value .. "/" .. progress.Max.Value
    progress.Changed:connect(function(value)
        deps.questUI.label.Text = deps.questUI.prefix .. value .. "/" .. progress.Max.Value
    end)
else
    deps.remotes.ReputationCashOut:InvokeServer()
    deps.lastCashOut = tick()
end
```

`player` — локальный игрок; `shouldTakeQuest=true` берёт квест, `false`/`nil` сдаёт репутацию. **Новый, не оригинальный** параметр `deps` явно предоставляет статус, `moveTo(cframe)`, remotes, игрока и UI; без `moveTo` и этих объектов функция не работает. Перед remote исходная функция также перемещается к `workspace.Anteiku.Yoshimura` и ждёт 1,5 секунды (см. файл). Не восстановлены бой, поиск целей, GUI, исполнение всего автофарма; работа на сервере не проверялась, только Lua 5.1/Luau-компиляция и изолированные макеты.

### Jujutsu Shenanigans — Inquest Moveset

`MainEnv()` создаёт эффекты персонажа и подписки на `Humanoid.AnimationPlayed`. `_G.Use(p6)` принимает название движения, для рывка отправляет `Chase`, для других способностей — активацию игрового сервиса:

```lua
function _G.Use(p6)
  if p6 == "Front Dash" then
    re.Chase:FireServer()
    return
  end

  services[p6 .. "Service"].RE.Activated:FireServer(unpack({ [1] = false }))
end
```

В обработчиках `AnimationPlayed` параметр `p12`/`p15` — трек анимации: сравнивается `p12.Animation.AnimationId` с конкретным ID, создаётся дополнительная анимация и в одном из вариантов вызывается `services.ChosoService.RE.RightActivated:FireServer(...)`. Части программы зависят от существующих игровых `lindwurm`, `re`, `services` и ресурсов. Статическое поднятие сложного CFG не проверено по поведению.

### Jujutsu Shenanigans — Pantheon Hub

`f6(p21, p22)` подписывает аниматор `p21` на проигрывание анимаций, `p23` — их трек; при совпадении ID из `v38` передаёт персонажа `p22` в `f5` (вычисление точки Flash Step относительно игрока):

```lua
local function f6(p21, p22)
  p21.AnimationPlayed:Connect(function(p23)
    if not v36 then
      return
    else
      local animationId = p23.Animation and p23.Animation.AnimationId

      if animationId then
        if v38[string.match(animationId, "%d+")] then
          f5(p22)
        end
      end

      return
    end
  end)
end
```

Также восстановлена проверка ключа `KeyValidator(p3)` и JJS-интерфейс. WindUI загружается извне. В выходе встречаются используемые, но не определённые здесь `PlaceId`, `JobId`, `HttpService`, `TeleportService` — их нельзя считать восстановленными.

### King Legacy — ограниченный игровой core

`f5(p6)` получает игрока `p6`, извлекает его уровень из `leaderstats` или `Data.Level` и статус PvP из атрибута/значения персонажа. Возвращает две строки для ESP:

```lua
  if v44 == "LV.?" and p6:FindFirstChild("Data") and p6.Data:FindFirstChild("Level") then
    v44 = "LV." .. tostring(p6.Data.Level.Value)
  end

  local character = p6.Character

  if character then
    if character:GetAttribute("PVP") == true
      or character:FindFirstChild("PVP") and character.PVP.Value == true then
      v45 = "⚔️ PVP: ✓"
    elseif p6:GetAttribute("PVP") == true then
      v45 = "⚔️ PVP: ✓"
    end
  end

  return v44, v45
```

`f4(p5)` создаёт ESP-объекты для игрока; `f6()` возвращает ближайшего живого противника. В файле есть названия `KING LEGACY`, но **нет подтверждённого специфичного автоквеста/фруктов/фарм-ремоута**. Опубликован как ограниченный результат по приоритетному режиму, а не как полноценный игровой бот.

### Violence District — ANCH Hax

`f5()` извлекает `ReplicatedStorage.Remotes.Generator.RepairEvent`, `f6()` перечисляет модели `Generator`, `f7(p8)` выбирает `GeneratorPoint1..4` у модели `p8`:

```lua
local function f7(p8)
  local v58 = p8

  for i = 1, 4 do
    local findFirstChild
    findFirstChild = p8:FindFirstChild("GeneratorPoint" .. i)

    local v59
    v59 = findFirstChild

    do
    end

    if findFirstChild and findFirstChild:IsA("BasePart") then
      return findFirstChild
    end
  end

  local primaryPart = p8.PrimaryPart
  local v60 = primaryPart

  do
  end

  return primaryPart or p8:FindFirstChildWhichIsA("BasePart")
end
```

Обработчик переключателя **Auto-Farm Generator** (`Callback = function(value12)`) проходит по генераторам с `RepairProgress < 100`, переносит персонажа к точке, выполняет `v128:FireServer(v131, true)` и затем `v128:FireServer(v131, false)`; при приближении игрока команды Killer цикл прерывается. В другом обработчике — ESP выживших/убийц. Внешняя WindUI не восстановлена. Для компиляции заменены три локальных `goto` в одном колбэке на эквивалентное падение к `return`; прочая эквивалентность не доказана.

### Illegal Soccer — Smart GK

`f5()` находит объект мяча в `workspace.Misc.Visuals`, отдавая предпочтение игровому `ClientBall_MainMatch`; `f9()` выбирает ближайшие ворота из `workspace.Map.Data.Team1/Team2` в пределах `GOAL_DETECTION_DIST`. Фрагмент `f5()`:

```lua
local function f5()
  local misc = workspace:FindFirstChild("Misc")

  if misc then
    do
      local visuals = misc:FindFirstChild("Visuals")

      if visuals then
        local clientBallMainMatch = visuals:FindFirstChild("ClientBall_MainMatch")

        if clientBallMainMatch then
          return clientBallMainMatch
        end

        return visuals:FindFirstChildWhichIsA("BasePart")
      end
    end
  end

  return nil
end
```

`f10(p17, p18, p19, p20, p21)`: `p17` — позиция цели, `p18`/`p19` задают смещение клавишей A/D, `p20` — прыжок, `p21` — альтернативный вариант удара. Игровые события генерируются через `VirtualInputManager`. Выход компилируется, но присваивание `v220` без объявления `local` оставлено как есть; NovaUI загружается извне.

### Murder Mystery 2 — Azure и KS

**Azure:** `f13(p24)` проверяет предметы игрока `p24` для определения роли, `f14(p25)` возвращает другого игрока с заданной ролью. Дословный фрагмент:

```lua
local function f13(p24)
  if f11(p24, "Knife") then
    return "Murderer"
  end

  if f11(p24, "Gun") then
    return "Sheriff"
  end

  return "Innocent"
end
```

**KS:** `f11(p15)` также определяет `Sheriff`/`Murderer` по именам предметов, `f13(p19)` создаёт `KS_MurderESP` и подпись, `f16(p20)` реагирует на появление игрока. `f10(p16, p17)` принимает имя предмета и перечень подстрок:

```lua
function f10(p16, p17)
  local v11 = string.lower(p16)

  for index4, value4 in ipairs(p17) do
    if string.find(v11, value4, 1, true) then
      return true
    end
  end

  return false
end
```

Оба файла получены из разных WeAreDevs-входов, а не один переименован в другой. Без Roblox-теста нельзя утверждать, что ESP/выстрелы сейчас работают.

### Blue Lock Farm — RELWX

`f22(p20)` оценивает юнита `p20` через его игровые атрибуты (уровень, grade, variant, число выпускаемых мячей), передавая данные в `f21(level, grade, variant)`:

```lua
local function f22(p20)
  local playerUnitLevel2 = p20:GetAttribute("PlayerUnitLevel") or 1
  local playerUnitGrade = p20:GetAttribute("PlayerUnitGrade") or "D"
  local playerUnitVariant = p20:GetAttribute("PlayerUnitVariant") or "Normal"
  local ballSpawnCount = p20:GetAttribute("BallSpawnCount")
  return f21(playerUnitLevel2, playerUnitGrade, playerUnitVariant) * (ballSpawnCount or 1)
end
```

`f20(p12, p13, p14)` работает со станцией конвейера (выбор коробки `p12`, покупка `p14`): делает `f7("PurchaseConveyorRoll", p14)`, `f7("RequestSetConveyorSelectedBox", p12)` и меняет настройки автопокупки. Это конкретный **Blue Lock Farm**, а не Blue Lock Rivals. Библиотека Fluent и два дополнения скачиваются отдельно в Roblox.

### Wild Horse Islands — WHI Farm

`f61(p43)` распознаёт UI захвата дикой лошади по `CaptureProgress` и надписям `wild`/`selvagem`/`salvaje`, `f63(p44)` поднимается к модели с Humanoid, `f70(p51)` перемещается к выбранной лошади:

```lua
local function f70(p51)
  local v91 = f8(p51)

  if not v91 then
    return
  end

  f69(p51, horseflyspeedwhi)

  if bodyPosition then
    bodyPosition.Position = Vector3.new(v91.Position.X, f1(p51) + 5, v91.Position.Z)
  end

  f67(p51)
end
```

`f69(p49, p50)` получает модель цели и скорость, делает `TweenService:Create(humanoidRootPart, TweenInfo.new(distance / p50, ...), {CFrame=...})` в восстановленной записи; `f75()` — главный цикл фермы. Узкий патч дублирует `task.wait()` вместо одного `goto`. Работоспособность внешней Rayfield и игровых UI-предположений не проверена.

## Что сознательно не опубликовано

- **Другие GPO-входы:** `0xRinFin/GPO`/`AdelOnTheTop/Adel-Hub` под Luraph v13.x не восстановлены. Отдельный `CFA-HUB/CFAHub-Free:SeaHubCrackGPO.lua` дал лишь цикл винтовочного вызова `CIcklcon` и общий noclip; читаемый GPO-референс в том же репозитории подтверждает игровой remote, но этот маленький фрагмент не выдаётся за отдельный полноценный скрипт. У `dilleron964/Grand-Piece-Online` сняты 922 XOR-строки, однако получилось только меню ввода ключа `PHANTOM`, без GPO-механики: файл отклонён. **Опубликован именно другой вход** `c0deblox/Scripts:GPO.lua` — выбранные проверяемые GPO-функции, частично.
- **Blox Fruits:** получен Lua 5.1 bytecode из PSU, но декомпилятор вернул лишь диагностический псевдокод (`unresolved HIR expression: open-pack`).
- **Case Paradise (MoonVeil):** полученная через `--no-verify` программа компилировалась, однако содержала явно ошибочные ветви и обращение к `.Panel` у `false`.
- **Night:** извлечён только ключевой интерфейс/внешний загрузчик; **Ride a Pet:** вход заканчивается посреди выражения; **Grow a Garden:** в защищённом входе оказался лишь внешний загрузчик с webhook, без игровой логики. Не публикуются.
- Ранее отклонённые God of Glory, Nerf FPS и Prior Extinction **удалены**; Steal an Egg не использовался. Открытые исходники других игр за результаты деобфускации не выдавались.
