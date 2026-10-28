# Дополнение: игровые скрипты, 21 октября 2026

## Что означает метка

- **`src`** — открытый MIT-исходник из указанного коммита, **не результат деобфускации**. К исходнику добавлен полный текст авторской лицензии, адрес/хэш исходного файла; иногда нормализованы переводы строк. `src` в имени обязательно.
- **Без `src`** — два статически раскрытых файла из обфусцированных входов; `Bloxstrike - Hotline UI.lua` дополнительно **очищен от удалённого загрузчика телеметрии RScripts**. Не утверждается точная эквивалентность обфусцированному вводу.
- Все файлы **только скомпилированы** инструментом `luau-compile --null` из Luau `9d7748a4f324213a18cb8283fa2a77c330225fa0`; **Roblox, посторонний Lua, сетевые запросы и игровые remotes не запускались**. Это не тест работоспособности/безопасности. Необходимые игровые объекты и executor API могут поменяться.

Подлинные файлы лежат в [`dobf scripts 1.0/`](../dobf%20scripts%201.0/); неизменяемые SHA-256, точные коммиты, исходные хэши и признаки модификаций — в [машинном отчёте](game-sources-2026-10-21.json). Не использованы Pastefy, доступы к API для получения скриптов или незаслуженно приписанные игры.

Два защищённых ввода клонированы через `git` с GitHub и раскрыты **локально** закреплённым [prostone4/Prometheus-Deobfuscator](../sources/prostone4--Prometheus-Deobfuscator.zip), подготовленным через `scripts/prepare_pdeobf.py` и вызванным как `node bin/pdeobf.js <вход> -o <выход>`. Промежуточные SHA-256 отражены в JSON. Для Bloxstrike из 37 203-байтного результата вырезан **один** выполняемый блок `task.spawn` с `loadstring(game:HttpGet(...rscripts.net/api/telemetry/client.lua...))`, после чего в опубликованное тело добавлены только исходная MIT-лицензия и заголовок происхождения; контрольное сравнение очищенного тела с промежуточным результатом прошло побайтно. У Blade Ball тело совпало с промежуточным результатом без изменений. Оба выхода компилируются Luau; восстановленные имена локальных переменных и поведение в игре не удостоверены. Ни телеметрия, ни чужой код локально не выполнялись.

## Функции и параметры (ссылки ведут на сам код)

### Bloxstrike — [Bloxstrike - Hotline UI.lua](../dobf%20scripts%201.0/Bloxstrike%20-%20Hotline%20UI.lua)

**Статус:** статически деобфусцирован; [исходный файл](https://github.com/orjinalwasexd/bloxstrike/blob/7f1babe48727e63bea57b78526c921b2dc1d4722/bloxstrike.lua) из `orjinalwasexd/bloxstrike@7f1babe48727` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `f1 / ParsaGetTeam(player)` | Определяет команду Terrorists / Counter-Terrorists по player.Team, атрибуту Character.Team либо родительской модели. |
| `f15(hitPart)` | Проверяет прямую видимость части цели лучом из камеры; флаг Wallbang обходится без проверки. |
| `f16()` | Выбирает ближайшую видимую часть игрока другой команды внутри FOV и задаёт getgenv().ParsaSilentTarget. |
| `hookfunction(_performRaycast)(original arguments...)` | Подменяет запись попадания в результате _performRaycast при включённом SilentEnabled. |

**Ограничения:** Нужны API executor Drawing/getgc/hookfunction и прежнее устройство команд/оружия Bloxstrike. Исполняемый блок загрузки телеметрии RScripts удалён; в теле файла больше нет HttpGet/loadstring. Локальные имена декомпилятора условные. В Roblox не проверено.

### Bloxstrike — [Bloxstrike - Memesense (src).lua](../dobf%20scripts%201.0/Bloxstrike%20-%20Memesense%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/xqmt/Bloxstrike-Memesense/blob/e4dea49aca0d409ca761e2bcffb7fc47bf18df9e/Meme.lua) из `xqmt/Bloxstrike-Memesense@e4dea49aca0d` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `GetPenetrationStats(origin, direction, maxPen, ignoreList, targetRoot)` | Считает прохождение выстрела через препятствия с учётом материала, толщины и предела maxPen. |
| `IsValidTarget(character, teamCheckEnabled)` | Проверяет персонажа противника и необязательный фильтр команды. |
| `getTrueSpread hook(weaponObject)` | При флаге NoSpread возвращает нулевой разброс, заменяя getTrueSpread. |
| `espfunctions.add_box(character)` | Рисует ESP-рамку вокруг отслеживаемого персонажа. |

**Ограничения:** Открытый исходник с добавленной лицензией. Во время работы загружает три файла UI Obsidian с raw.githubusercontent.com; зависимости не включены. Требует Drawing и перехваты executor. В Roblox не проверено.

### Blade Ball — [Blade Ball - Nexus Hub.lua](../dobf%20scripts%201.0/Blade%20Ball%20-%20Nexus%20Hub.lua)

**Статус:** статически деобфусцирован; [исходный файл](https://github.com/GreenicScripts/Nexus-Hub/blob/7b6c8172503bb418f9e45bd113d384bc4ee8bf2a/main.lua) из `GreenicScripts/Nexus-Hub@7b6c8172503b` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `f16()` | Подключает обработчик PreSimulation для частого парирования прилетающего мяча с компонентом zoomies. |
| `f32()` | Подключает автоматическое парирование настоящего мяча по атрибуту realBall и скорости zoomies.VectorVelocity. |
| `f13(p11, p12)` | Передаёт два параметра в обработчики парирования/имитации ввода; исходные имена и смысл параметров не восстановлены. |

**Ограничения:** Только статическое раскрытие: эквивалентность и работа в Roblox не доказаны. Проверяет PlaceId 13772394625 и перенаправляет игрока из другой игры. Загружает внешнюю Rayfield UI с sirius.menu.

### Blade Ball — [Blade Ball - Nightmare Hub (src).lua](../dobf%20scripts%201.0/Blade%20Ball%20-%20Nightmare%20Hub%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/GigaMechanicRear/blade_ball/blob/c9dc81c35fabeffaff1001334a8985efe4174643/blade_ball.lua) из `GigaMechanicRear/blade_ball@c9dc81c35fab` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `getBall()` | Находит активный Part в workspace.Balls, предпочитая realBall. |
| `ballTargetsMe(ball)` | Сверяет атрибут target мяча с LocalPlayer.Name. |
| `pressParry()` | Вызывает Remotes.ParryButtonPress либо имитирует клавишу F, если remote отсутствует. |

**Ограничения:** Открытый исходник, загрузка Rayfield UI при запуске. Резервный remote/клавиатурный путь — предположение автора и не проверялся на сервере Roblox.

### Forsaken — [Forsaken - Forsaken Plus (src).lua](../dobf%20scripts%201.0/Forsaken%20-%20Forsaken%20Plus%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/quins-max/ForsakenPlus/blob/e58979c290421f48f12b28f9440d12ef2df306eb/script.lua) из `quins-max/ForsakenPlus@e58979c29042` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `FeatureLoadout.Automation.AutoGeneratorPuzzle.OnLoop(self)` | Ищет поблизости генератор на карте, ждёт случайную задержку и шлёт прогресс RemoteEvent при открытой PuzzleUI. |
| `FeatureLoadout.Automation.AutoGeneratorPuzzle.IsPlayersNear(self, distance)` | Проверяет, есть ли другой игрок ближе distance студов, прежде чем ускорять цикл генератора. |
| `GetValue(featureName, instanceOnly)` | Читает активную настройку игровой панели по имени функции. |
| `Initializer.Start()` | Создаёт UI и настройки, при наличии файлов может дополнительно исполнить локальные плагины. |

**Ограничения:** Открытый исходник с сохранёнными кредитами автора. Проверяет GameId 6331902150/7464167604; зависит от иерархии Forsaken. Опциональные локальные плагины выполняются через loadstring, также запрашивается история обновлений у apis.rovalra.com; проверьте перед запуском. В Roblox не тестировалось.

### Forsaken — [Forsaken - Emotes GUI (src).lua](../dobf%20scripts%201.0/Forsaken%20-%20Emotes%20GUI%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/X3KT00/EmotesGUI/blob/81ce095ab406a044affdd78ad9a5ec60eb8fac29/Code.lua) из `X3KT00/EmotesGUI@81ce095ab406` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `findPlayerByNickname(nickname)` | Находит игрока для применения эмоции по логину или отображаемому имени. |
| `playAudio(sfxData, parent, targetKey)` | Воспроизводит SFX выбранной эмоции на указанном игровом объекте. |
| `playSpecialEffects(emoteName, data, targetChar, targetKey)` | Применяет к персонажу эффекты выбранной эмоции. |

**Ограничения:** Открытый исходник. Требует модулей ReplicatedStorage.Assets.Emotes с AssetID/SFX как в Forsaken. Нет проверки PlaceId и нет фарма; в Roblox не проверено.

### Blue Lock Rivals — [Blue Lock Rivals - Denzel Dribble (src).lua](../dobf%20scripts%201.0/Blue%20Lock%20Rivals%20-%20Denzel%20Dribble%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/AshTheScripter/Denzel-s-script-blr/blob/2c847fa2801a2a9803da438118cf91da396e7c54/Denzels%20script%20blr) из `AshTheScripter/Denzel-s-script-blr@2c847fa2801a` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `GetBallOffset()` | Вычисляет смещение футбольного мяча по горизонтальной скорости HumanoidRootPart. |
| `FireServer()` | При Values.HasBall шлёт Knit BallService.RE.Dribble; при высоком ping планирует повтор. |
| `simLand(position, velocity)` | Оценивает точку приземления Football для маркера траектории. |

**Ограничения:** Открытый исходник с жёсткой привязкой к Knit BallService и workspace.Football. Клиентское перемещение мяча может не приниматься сервером. В Roblox не проверено.

### Tower Defense X — [Tower Defense X - TDX Autofarm (src).lua](../dobf%20scripts%201.0/Tower%20Defense%20X%20-%20TDX%20Autofarm%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/jellyfishhhhhhh/TDXAutofarm/blob/ca430b23ce3f1395d8d972ddfcb34d61785104cb/main.lua) из `jellyfishhhhhhh/TDXAutofarm@ca430b23ce3f` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `tdxScript:Start(difficulty)` | Голосует за выбранную сложность и отправляет DifficultyVoteReady. |
| `tdxScript:placeTower(tower, strangeValue, location, tryUntilSucceed)` | Вызывает TDX PlaceTower с башней и координатами; сверяет UI-счётчик башен. |
| `tdxScript:upgradeTower(tower, option)` | Передаёт tower и option в TowerUpgradeRequest. |
| `tdxScript:JoinMap(mapName)` | Находит карту на экранах APC в лобби PlaceId 9503261072 и входит в очередь. |
| `tdxScript:StartLogging()` | Перехватывает игровые remotes и записывает строительство/улучшения в локальный текст. |

**Ограничения:** Открытый модуль, возвращает tdxScript; не готовый самостоятельный автофарм. StartLogging зависит от hookfunction/hookmetamethod и файловых API, также может содержать старые ошибки. В исходной ветке placeTower с tryUntilSucceed=true повторно читается устаревший текст счётчика — возможное вечное ожидание. В Roblox не проверено.

### Vesteria — [Vesteria - Cheater Soul (src).lua](../dobf%20scripts%201.0/Vesteria%20-%20Cheater%20Soul%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/Luciquad/robloxscripts/blob/21735be73af9db5d6c3f9df4c532f08e9ddf7980/vesteria-soul.lua) из `Luciquad/robloxscripts@21735be73af9` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `GetSetting(name)` | Читает настройку из epicthing.config по game.GameId. |
| `CastSpell(executionData)` | Для выбранных способностей шлёт playerRequest_damageEntity с тегом ability и ability-guid. |
| `Attack(enemy, attackingPlayers)` | Посылает запросы урона по сущностям Vesteria при включённом фарме. |

**Ограничения:** Исходник без изменений логики (добавлена лицензия, CRLF → LF). Читает/пишет epicthing.config; переход между серверами обращается к games.roblox.com. В Roblox не проверено.

### Blox Fruits — [Blox Fruits - Ardi Hub (src).lua](../dobf%20scripts%201.0/Blox%20Fruits%20-%20Ardi%20Hub%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/raizu25112005/ArdiHub/blob/e10421c58f87e89fbb3b8ef33cbc2b68cf28ae06/script.lua) из `raizu25112005/ArdiHub@e10421c58f87` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `getNearestMob()` | Выбирает ближайшего живого NPC в workspace.Enemies. |
| `AutoFarmLevel()` | В цикле перемещает персонажа к ближайшему NPC и вызывает attackMob. |
| `attackMob(mob)` | Отправляет в Remotes.CommF_ действие Combat с координатой моба. |
| `AutoSubmergeQuest()` | Пытается пройти квест SubmergeQuest через CommF_ и proximity prompt. |

**Ограничения:** Исходник с атрибуцией и нормализацией CRLF. Имена/аргументы AutoSubmergeQuest не сверены с сервером Roblox и могут быть вымышленными или устаревшими. Загружает Kavo UI извне, перехватывает Kick через executor; «anti-ban» не доказан. В Roblox не проверено.

### Swordburst 2 — [Swordburst 2 - Magma Hub module (src).lua](../dobf%20scripts%201.0/Swordburst%202%20-%20Magma%20Hub%20module%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/212154879.lua) из `Commandcracker/Magma-Hub@5d7e2f84de03` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `BigHitBox toggle callback()` | При включении меняет размер HumanoidRootPart у мобов из workspace.Mobs. |
| `Dismantle All input callback(itemName)` | По названию предмета посылает игровое Equipment/Dismantle для инвентаря. |
| `Max Upgrade input callback(itemName)` | По названию предмета делает до 100 Equipment/Upgrade; может расходовать ресурсы. |
| `InfiniteStamina toggle callback()` | В цикле меняет клиентское значение Entity.Stamina персонажа. |

**Ограничения:** Игровой MIT-модуль, требует глобалов MagmaHub и Threads исходного хаба; отдельно не работает. Клиентская стамина и локальные флаги игровых пропусков могут не дать эффекта на сервере. В Roblox не проверено.

### Swordburst 2 — [Swordburst 2 - Aztup module (src).lua](../dobf%20scripts%201.0/Swordburst%202%20-%20Aztup%20module%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/SwordBurst2.lua) из `ModerkaScripts/Aztup-Hub-V3@45bcead9541a` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `getClosestTarget(respectFlags)` | Выбирает ближайшего живого моба из workspace.Mobs либо игрока согласно флагам UI. |
| `toggleAutoAttack(toggle)` | Вызывает ReplicatedStorage.Event Combat Attack с ключом из захваченного игрового framework. |
| `toggleAutoFarm(toggle)` | Перемещается Tween над ближайшим мобом с BodyVelocity. |

**Ограничения:** Отдельный игровой модуль Aztup; нужен оригинальный loader/sharedRequire, UI и API executor getgc/getupvalue. При отсутствии игрового framework сам вызывает LocalPlayer:Kick (в том числе в лобби). Не автономен, не проверен в Roblox.

### Arcane Odyssey — [Arcane Odyssey - Aztup module (src).lua](../dobf%20scripts%201.0/Arcane%20Odyssey%20-%20Aztup%20module%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/ArcaneOdyssey.lua) из `ModerkaScripts/Aztup-Hub-V3@45bcead9541a` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `functions.autoFish(toggle)` | Управляет рыбалкой через fishClock/FishBiteGoal, выбирает тип водоёма и подматывает улов. |
| `functions.teleportToQuestObjective()` | Перемещается к отслеживаемой цели квеста Arcane Odyssey. |
| `functions.infiniteStamina()` | Через staminaCost remote пытается компенсировать расход выносливости (рискованно). |

**Ограничения:** Игровой модуль Aztup, не самостоятельный файл: нужны sharedRequire/UILibrary/Services/Utility и API executor. Сервер может заблокировать старые remotes. В Roblox не проверено.

### Voxl Blade — [Voxl Blade - Aztup module (src).lua](../dobf%20scripts%201.0/Voxl%20Blade%20-%20Aztup%20module%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/VoxlBlade.lua) из `ModerkaScripts/Aztup-Hub-V3@45bcead9541a` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `funcs.mobAutoFarm(toggle)` | Выбирает мобов Voxl Blade/подземелье по PlaceId и управляет noclip/автофармом. |
| `funcs.dungeonAutoFarm(toggle)` | Проходит подземелье по текущему dungeonName и состоянию игровых алтарей. |
| `funcs.autoSell()` | Собирает игровые предметы для автопродажи. |

**Ограничения:** Модуль Aztup, требует sharedRequire/UI/mobfarm utility и API executor. Есть экспериментальные действия с сохранением данных: не включать без понимания рисков. Подключает необязательный Webhook helper. В Roblox не проверено.

### Adventure Tales — [Adventure Tales - Aztup module (src).lua](../dobf%20scripts%201.0/Adventure%20Tales%20-%20Aztup%20module%20%28src%29.lua)

**Статус:** открытый `src`; [исходный файл](https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/AdventureTales.lua) из `ModerkaScripts/Aztup-Hub-V3@45bcead9541a` (MIT).

| Функция / обработчик (параметры) | Назначение |
| --- | --- |
| `getAttackSpeed()` | Вычисляет задержку удара по ItemData, редкости и экипировке. |
| `functions.killAura(toggle)` | Связывает атаки NPC Adventure Tales с meleeRemote и флагами UI. |
| `functions.autoSell(toggle)` | По выбранной редкости отправляет предметы в Remotes.UI.MassSell. |

**Ограничения:** Игровой модуль Aztup; без sharedRequire/UILibrary/Utility и API executor originalFunctions не работает самостоятельно. В Roblox не проверено.

## Фрагменты реального кода

### Bloxstrike: фильтрация команды и выбор цели

Из статически восстановленного Hotline UI (декомпилятор назвал функцию `f1`, публичное присваивание — `ParsaGetTeam`):

```lua
local team = character:GetAttribute("Team")
if team == "Terrorists" or team == "Counter-Terrorists" then
  return team
end
```

Точность попаданий **не проверена**; подмена `_performRaycast` зависит от API executor и игровой реализации.

### Blue Lock Rivals: игровой remote и параметры

В Denzel Dribble перед вызовом проверяется `C.Values.HasBall`; затем срабатывает игровой Knit remote, а положение футбольного мяча корректируется на клиенте:

```lua
local B = ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble
B:FireServer()
local ball = workspace:FindFirstChild("Football")
if ball then ball.AssemblyLinearVelocity=Vector3.zero; ball.CFrame=H.CFrame*CFrame.new(GetBallOffset()) end
```

Сервер может игнорировать вызов/клиентские координаты; это **не доказательство** успешного дриблинга.

### Tower Defense X: конкретный игровой обработчик

MIT-модуль `TDXAutofarm` (метод вызывается как `TDX:upgradeTower(tower, option)`):

```lua
function tdxScript:upgradeTower(tower, option)
    local args = {
        [1] = tower,
        [2] = option
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TowerUpgradeRequest"):FireServer(unpack(args))
end
```

Кроме апгрейда есть `placeTower(tower,strangeValue,location,tryUntilSucceed)`, `JoinMap(mapName)` и `Start(difficulty)`. В опубликованном оригинале ветка ожидания `tryUntilSucceed=true` использует устаревший текст счётчика башен и может зависнуть; этот флаг **не включайте**.

## Открытые пробелы: вместо универсальных скриптов

| Плейс / запрос | Почему новый файл не опубликован |
| --- | --- |
| King Legacy | Есть только прежний Luxury Core (в основном UI/ESP). Среди лицензированных находок нет второго проверенного Lua для King Legacy. |
| Grand Piece Online | Есть только прежний частичный Lunar Hub. Лицензированные кандидаты — внешние макросы рыбалки, не Roblox Lua. |
| Demonfall | В MIT-кандидате только тестовый hello-world, не Demonfall. Другие входы без лицензии и защищены MoonSec V3; статический Prometheus-деобфускатор к ним не применим, полного игрового Lua нет. |
| Trident Survival | В 6segs/kira есть Lua для Trident, но явного разрешения перепубликовать код не найдено; подходящего лицензированного файла нет. |
| VV Ultimatum | sensaix-d/vvultimatumhub без лицензии; vv.txt содержит домен-двойник roblox.com.et. Защищённый vvultimatum.lua.txt ещё и повреждён: Luau отвергает хвост после end)(...) на столбце 66861; pdeobf --force сообщает unexpected char \ на 66864. Не публикуем. |
| Gakuran | MIT-репозиторий theodorbrand/gakuran распакован статически: внутри универсальный Emotes GUI, не Gakuran. peptise/gakuran без лицензии. |
| Illegal Sorcer | Достоверный игровой Lua не найден. Уже опубликованный Illegal Soccer — другая игра. |
| A Universal Time | Найден неразрешённый MoonSec V3 без лицензии и Apache-репозиторий лишь с README; текущий статический инструмент не восстанавливает MoonSec V3, публиковать игровой Lua нечего. |
| Anime Vanguards | MIT Lua оказался универсальным шаблоном поиска remotes, а внешний макрос — заготовкой GUI. Не подменяем им игровые обработчики. |
| Ride a Pet | Скрипты поиска яиц в существующих репозиториях без явной лицензии; лицензированный кандидат — рекламный HTML. |
| Blue Lock Rivals (second independent script) | Другой MIT Lua выполняет общий поиск футбольных remote без специфики Knit-служб Blue Lock Rivals. Не считаем вторым результатом. |
| Tower Defense Simulator (additional Lua) | MIT-кандидат угадывает remote и меняет только клиентские деньги; вместо него опубликован конкретный модуль TDX и старый частичный ASTD. |

Другие Tower Defense: [старый частичный ASTD](../dobf%20scripts%201.0/All%20Star%20Tower%20Defense%20-%20Assasine03%20Autofarm%20%28partial%29.lua) и новый TDX — **разные игры**, ASTD-файл не называется полноценным. `Blue Lock Farm` ≠ `Blue Lock Rivals`, `Illegal Soccer` ≠ `Illegal Sorcer`. Количество независимых новых скриптов меньше запрошенного для большинства игр; не добавлены фиктивные варианты одного и того же загрузчика.

Лицензии сторонних исходников действуют **отдельно**, не как общая лицензия на коллекцию. Не исполняйте опубликованный код без проверки; среди исходников есть внешние загрузки UI, необязательные webhooks и локальные плагины.
