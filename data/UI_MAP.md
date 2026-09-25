# UI и конфиг Ouroboros — карта (шаг 3 плана)

Источники: `ouroboros_ps2 (1).luau` (код второй сборки — самая читаемая копия),
`ouroboros_main_pruned.txt` (рендер, строки ~5900…6900 и ~21500).
Все номера слотов — по **канонической карте** (заголовок второй сборки, см. ROADMAP).

## 1. Откуда берётся интерфейс

| Что | Значение | Где |
|---|---|---|
| База библиотеки | `https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/` | пул 957 |
| Основной файл | `Library.lua` (пул 2260) | хук `HttpGet` — пул 3372 |
| Аддон сохранений | `addons/SaveManager.lua` (пул 1406) | грузится загрузчиком библиотеки |
| Аддон тем | `addons/ThemeManager.lua` (пул 2200) | там же |
| Папка конфигов | `MyScriptHub` → `OuroborosHub/Ouwland` | строки 6763, 1120111 |
| Дефолтный конфиг | `Rosewater` (пул 6335) | `SaveManager:SaveDefault("Rosewater")` |
| Скрыть UI при старте | `HideUiOnStart` | влияет на стартовую вкладку |

Библиотека — внешняя (ObsidianUltra, WindUI-подобная: `AddLeftGroupbox`,
`AddRightTabbox`, `AddToggle`, `AddSlider`, `AddDropdown`, `AddInput`,
`AddKeyPicker`, `AddColorPicker`, `AddButton`, `AddLabel`, `Notify`, `Toggle`).
Её исходников в артефакте нет: воспроизвести 1:1 можно только вызовы её API,
а сам `Library.lua` остаётся внешней зависимостью.

## 2. Структура окна

* `aV7` — список закладок окна; `aV7[4]` — основная группа (все `AddLeftGroupbox`),
  `aV7[7]` — вкладка SaveManager (`SaveManager:ApplyToTab(aV7[7])`).
* Группы (по `AddLeftGroupbox`): Farm Settings, Mitigation (No Stun / No Ragdoll /
  No Attack Slowdown / No Dash Cooldown / No Sun Damage), Codes (Redeem All Codes),
  Instant Kill (InstantKill → KillThreshold, OwnershipViewer → OwnershipRange),
  Teleports (вкладки Zones / NPCs / Mobs), «Unavailable» (Missing: …),
  Matchmaking (QueueModes, QueueRanked, QueueFill, AutoQueue, Leave Queue),
  World (WorldTarget, PrivateOwner, AutoWorld, Join World) и т.д.
* Строки статусов: `bpe["status"](bpz[...])` — метки `CodeStatus`,
  `TeleportStatus`, `QueueStatus`, `WorldStatus`.
* Загрузчик библиотеки: `aVE("addons/SaveManager.lua")` — из того же корня, что
  `Library.lua`; если аддона нет, UI всё равно строится.

## 3. Переключатели: две таблицы виджетов

* `aVS[key]` — **тумблеры** (`AddToggle`), читаются грузчиком `cJb(key, setter)`:
  `if aVS[key] then setter(aVS[key]["Value"]) end`.
* `aVT[key]` — **остальные виджеты** (`AddSlider`, `AddDropdown`, `AddInput`,
  `AddKeyPicker`), грузчик `cJc(key, setter)`, читает `["Value"]`.
* Стартовая загрузка: `aVQ:LoadDefault()`, `cKb[51]["BeginPriorityLoad"]()`,
  `aVR:LoadAutoloadConfig()` — то есть дефолт → приоритеты → авто-конфиг.

## 4. Привязка «ключ конфига → сеттер» (156 прямых пар)

Выгружено из рендера (`cJb("Ключ", cKb[51]["Setter"])`, полный список воспроизводится
в `ouroboros_config.lua`). Смысл: `cJb` — виджет со `["Value"]` (слайдер/дропдаун/
инпут), `cJc` — тумблер.

Ключевые группы:

| Группа | Ключи |
|---|---|
| Приоритеты | `PriorityOrder`, `PriorityPreempt`, `PriorityMode` |
| Подход к цели | `PositionType`, `LookAtEnemy`, `OffsetDistance`, `HeightOffset`, `MovementMode`, `TweenSpeed` |
| Расходники | `WeaponChoice`, `PotionChoice`, `DrinkBelow`, `ShopItems`, `KeepAmount` |
| Скиллы | `SkillChoices`, `AutoSkills`, `SkillNodes`, `UnlockSkills`, `SkillHold:<key>` |
| Квесты/мобы | `MobTarget`, `BossTargets`, `ChestTiers`, `QuestTargets`, `AutoQuest` |
| Боссы/охота | `HuntTiers`, `HuntDropForeign`, `AutoBossHunt`, `BreathingChoice`, `WenMob` |
| Демон | `DemonMob`, `DemonDrink`, `DemonDropForeign`, `AutoDemon` |
| Подземелья/приведение | `DungeonRange`, `AutoDungeon`, `BringRange`, `AutoBringEnemies` |
| Карты | `CardTargets`, `BlockBareHands`, `HealBelow`, `ForceHealCards`, `CardPriority<имя>` |
| Бой | `AutoMob`, `AutoBoss`, `AutoSkipWaves`, `KillThreshold`, `ChestKillThreshold`, `ChestInstantKill` |
| Твики | `NoStun`, `NoRagdoll`, `NoAttackSlowdown`, `InstantKill`, `InfiniteStamina`, `InfiniteClimb`, `InfiniteHorseStamina`, `NoDrown`, `DisableShiftLock`, `NoDashCooldown` |
| Уведомления | `NotifyBosses`, `NotifyWarnBefore`, `Notify<BossSpawns\|Muzan\|Market\|Tailor\|Selection\|Hunts>` |
| Урожай/души | `LootRange`, `AutoLoot`, `SoulRange`, `AutoSoul` |
| Рыбалка/поезда | `FishBait`, `AutoBuyBait`, `AutoFish`, `Trainings`, `TrainingMode`, `AutoTraining` |
| Мир/очередь | `WorldTarget`, `PrivateOwner`, `AutoWorld`, `QueueModes`, `QueueRanked`, `QueueFill`, `AutoQueue` |
| ESP | `EspRange`, `Esp<Box\|BoxFill\|Box3D\|Name\|Distance\|HealthBar\|HealthText\|Tracer\|PlayerInfo>`, `Esp<...>Colour` (16), `Esp<Players\|Mobs\|Bosses\|Npcs\|Muzan\|SpiderLily\|Chest\|Horse\|Lever>` (9) |

Отдельные циклы (ключи строятся динамически):
* `SkillHold:<key>` из `cKb[51]["HoldSkills"]()` → `SetSkillHold(name, v)`;
* `CardPriority<имя без не-слов>` из `CardNames()` → `SetCardPriority(name, v)`;
* уведомления: `{NotifyBossSpawns="boss", NotifyMuzan="muzan", NotifyMarket="market",
  NotifyTailor="tailor", NotifySelection="selection", NotifyHunts="hunt"}` →
  `SetNotification(kind, v)`;
* ESP-опции: `{EspBox="box", EspBoxFill=…, EspBox3D="box3d", EspName="name",
  EspDistance="distance", EspHealthBar="healthBar", EspHealthText="healthText",
  EspTracer="tracer", EspPlayerInfo="playerInfo"}` → `SetEspOption(kind, v)`;
* ESP-цвета (16) → `SetEspColour(kind, colour)`;
* ESP-категории (9) → `SetEspCategory(kind, v)`.

**Внимание:** в одной из копий часть *значений* этих таблиц подменена чужими
строками (например `["EspBoxFill"] = "Warn Me Before"`, `["EspEnemyColour"] = "Players"`).
Ключи верны, значения — мусор от подстановки пула; брать значения из второй копии.

## 5. Экспорт конфига в буфер (кнопка «Export Config to Clipboard»)

1. Сбор записей: по `{aVS, aVT}` (индекс `#cIl + 1`, сортировка по `idx`, затем
   по `type`); запись пропускается, если `aVR["Ignore"][idx]` (SaveManager:SetIgnoreIndexes
   `{"MenuKeybind", "SaveManager_ImportSource"}`) или у виджета нет строкового `Type`.
   Формат записи по типу виджета:
   * `Toggle` — `{idx, type="Toggle", value = widget.Value == true}`;
   * `Slider` — `{idx, type="Slider", value = tostring(widget.Value)}`;
   * `Dropdown` — `{idx, type="Dropdown", multi = widget.Multi == true, value = widget.Value}`;
   * `Input` — `{idx, type="Input", text = tostring(value)}`;
   * `KeyPicker` — `{idx, type="KeyPicker", mode, key, modifiers, toggled}`;
   * `ColorPicker` — `{idx, type="ColorPicker", value = widget.Value:ToHex(), transparency}`.
   Итог — `{objects = <список>}`.
2. `pcall(HttpService.JSONEncode, HttpService, payload)` → при ошибке
   `Notify("Failed to encode the config")`.
3. Копирование: сначала `setclipboard`, затем `toclipboard`; если ни одной функции
   нет → `Notify("Your executor does not support copying to the clipboard")`;
   иначе `Notify("Config copied to clipboard", 6)`.

## 6. Импорт конфига (кнопка «Import Config from Clipboard Text»)

1. Берётся текст из инпута `SaveManager_ImportSource`.
2. `#текст > 262144` → `Notify("That config is too large")`.
3. `pcall(HttpService.JSONDecode, HttpService, text)` → ошибка →
   `Notify("That is not a valid exported config")`.
4. `type(decoded["objects"]) ~= "table"` → то же сообщение.
5. `#decoded["objects"] > 2048` → `Notify("That config has too many records")`.
6. `cKb[51]["BeginPriorityLoad"]()`; по каждой записи — применение (пропуск
   «Ignore» и отсутствующих виджетов), счётчик применённых.
7. `0` → `Notify("No settings in that config matched this script")`;
   иначе `Notify(("Imported %d setting%s"):format(n, n == 1 and "" or "s"), 6)`
   и инпут очищается (`:SetValue("")`).
8. По завершении — `cKb[51]["SettlePriority"]()` (приоритеты пересобираются).

Применение записи (`cJa`) по типу: `Input` → `SetValue(text)`; `Toggle` →
`SetValue(value)`, `Toggled = toggled`, `:Update()`; `Slider` → `SetValue(value)`;
`Dropdown` → `SetValue(value)`; `ColorPicker` → `SetValueRGB(Color3.fromHex(value), transparency)`;
`KeyPicker` → `SetValue({key, mode, modifiers})`, `Toggled = toggled`, `:Update()`
(при `mode == "Toggle"` значение приводится к паре).

## 7. Что осталось по UI

* Сам `Library.lua` (ObsidianUltra) в артефакте отсутствует — при 1:1-копии он
  остаётся внешним (либо нужен свой минимальный аналог тех API, что вызываются).
* Описания виджетов (тексты, тултипы, дефолты, min/max, суффиксы) лежат в коде
  UI (`a1c`, рендер ~6843 и далее) — выгружаются из артефакта по мере надобности;
  таблица «ключ → сеттер» уже выгружена (156 + динамические).
* ESP/уведомления/скиллы/карты как подсистемы — отдельные шаги (ROADMAP, п. 6).
