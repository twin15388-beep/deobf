# Восстановленные игровые Lua / Luau — 19 октября 2026

Здесь **девять читаемых выходов из обфусцированных входов для семи заявленных игр** и **отдельный частичный результат по Grand Piece Online**: всего десять файлов / восемь игр. Для GPO это только выбранные игровые функции из поднятого PSU-байткода, **не полный скрипт Lunar Hub**; возвращаемая модулем таблица и говорящие имена добавлены при оформлении. Это не подборка открытых соседних исходников или универсальных загрузчиков. **Оговорка для King Legacy:** удалось восстановить только фирменный `core.lua` с UI и ESP уровня/PVP; его основные действия довольно общие, игровых remote-вызовов для фарма там нет. Это не «полный скрипт King Legacy».

**Статус проверки:** все десять файлов скомпилированы `luau-compile --null`, частичный GPO также скомпилирован Lua 5.1 и проверен на подставных объектах **без Roblox и сети**. Ни защищённые входы, ни выходы не запускались в Roblox. Компиляция и подставные объекты **не доказывают** работоспособность, эквивалентность оригиналу или безопасность. Имена `f1`, `p1`, `v1` и новые имена в GPO — восстановленные/описательные обозначения, а не подлинные локальные имена автора. Сохранённые внешние `loadstring(game:HttpGet(...))` в полных выходах требуют отдельного аудита; **не запускайте эти файлы вслепую**. Хэши входов/выходов, точные коммиты и предупреждения — в [машинном отчёте](../reports/game-recovery-2026-10-19.json), способ воспроизведения — в [методике](../reports/game-recovery-2026-10-19.md). Права на сторонние исходники не проверены.

| Игра | Восстановленный файл | Что именно видно / предел |
| --- | --- | --- |
| Grand Piece Online | [Lunar Hub (partial).lua](Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua) | **Частично:** GPO-квесты/координаты, `Events.Quest`, `Events.CombatRegister`, поиск NPC, лёд Hie-Hie. Полный хаб, GUI, `teleport()` и автофарм не восстановлены |
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

Это **выдержки**, не пересказ вместо кода: результаты — по ссылкам в таблице. У GPO доступен **только отмеченный частичный файл**, а не полный исходный результат; он составлен из выбранных участков поднятого байткода. `pN` означает параметр с неизвестным первоначальным именем.

### Grand Piece Online — Lunar Hub FREE (частично)

Защищённый `c0deblox/Scripts:GPO.lua` (PSU 4.0.A) **статически** поднят в Lua 5.1 bytecode. В нём присутствуют непосредственно игровые квесты (`Help Raphtalia`, `Take down Lucid`), NPC и `ReplicatedStorage.Events.Quest`/`Events.CombatRegister`, а также `WaterLogia["Hie-Hie"]`; связь с GPO подтверждается **содержимым**, а не названием репозитория. Выделены прототипы #17/#18, #19/#20, #31 и #90; это не результат копирования готового открытого скрипта. Файл [Grand Piece Online - Lunar Hub (partial).lua](Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua) содержит **сам код**, таблицы квестов и координат.

`takeQuest(npcName)` получает ключ NPC: выбирает название квеста/позицию, вызывает **не восстановленный здесь** `teleport(x, y, z)` и отправляет массив аргументов серверному квесту:

```lua
local function takeQuest(npcName)
    if npcName ~= "None" then
        local questName = Quest[npcName]
        local position = QuestPos[npcName]
        teleport(position.X, position.Y, position.Z)
        game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest", questName})
    end
end
```

`damageNpc(targetNpc, selectedWeapon)` сопоставляет `Katana`/`Kiribachi` → `Sword`, `Black Leg` → `BlackLeg` и отправляет **пять** вызовов `CombatRegister` с `{ "damage", targetNpc.HumanoidRootPart, weapon, {strike, "Ground", weapon} }`. `nearestNpc(npcName)` выбирает ближайшего NPC из `workspace.NPCs`; `nearestNpcExcept(npcName, excludedName)` исключает точное имя. `hieWaterTouch(foot)` клонирует `WaterLogia["Hie-Hie"].floor`, помещает на поверхность воды на пять секунд и очищает `sm2`/`sm3`. Параметр `foot` — коснувшаяся воды деталь; подписка на `Water.Touched` была в остальном UI и **не входит** в опубликованный модуль.

**Важный предел:** `unluac-js` выдал для **целого** хаба диагностический псевдокод с 49 метками ошибки восстановления, а `luadec` не восстановил программу целиком. Мы **не** публикуем этот ошибочный файл и **не** заявляем полный автоматический фарм. В таблице `QuestPos` отсутствуют `Bandit Boss`, `Axe Hand Logan`, `Gorilla King`, поэтому `takeQuest()` для них без добавочной логики не сработает. Не включены GUI, исходная реализация `teleport`, циклы автофарма и загрузка MaterialLua. Синтаксис проверен в Lua 5.1 и Luau, выбранные действия — в изолированном Lua-тесте с подставными объектами; ни один вызов не проверен на живом сервере. Имена функций/модульная оболочка при оформлении изменены, а степень сохранения поведения **всей** защиты неизвестна.

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
