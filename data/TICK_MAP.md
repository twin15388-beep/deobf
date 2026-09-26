# Как в Ouroboros устроен «тик» (карта, 2026-09-26)

Источник: `ouroboros_ps2 (1).luau` → `ouroboros_main_pruned.txt` (состояния,
нумерация `S…`) и `tools/deflatten.py --pool N` (сырые тела пула).

## 1. Главное открытие: отдельного «общего тика» нет

В артефакте **нет** одного per-frame диспетчера фич. Верхний уровень — это одна
машина состояний с pc `cKb[73]` (entry 3720; диспетчер — `while true do` с
двоичным поиском по `cKb[73]`), и она выполняет **тело скрипта**: настройка,
меню, и запуск фоновых циклов. После запуска циклов машина заканчивается.

Работу фич ведут:

1. **воркеры контроллеров** — по одному на фичу, со своим интервалом;
2. **два глобальных цикла** (`task.delay(0, …)`): сводки (1 с) и «ownership» (0.2 с);
3. **Heartbeat-подключение парирования/блока** (одно на весь блок-воркер);
4. **подключение на каждый вход блока** (создаётся при постановке входа).

Плюс `task.spawn/task.delay` внутри шагов (в пуле это `F4004` = `task.delay`,
`F3916` = `task.wait`, `F6128` = `task`).

## 2. Воркеры контроллеров (это и есть основной цикл)

Канон — вторая копия артефакта (там `cKb[84]` задан **инлайн-функцией**
`function(AP, AQ)` в строке ~38268 принта; в первой копии на это место
поставлен `F3818` — тасование слотов).

```
cKb[84] = function(AP, AQ)                     -- AP = контроллер, AQ = шаг
    if AP.workerActive and not AP.stopped then return end      -- S10384/83/79
    AP.workerActive = true                                     -- S10385
    AP.generation   = (AP.generation or 0) + 1                 -- S10381/82
    AP.stopped      = false
    local myGen     = AP.generation
    AP.startedAt    = os.clock()
    AP.yield        = false
    task.delay(0, function()                                   -- F4004(0, тело)
        local runId  = coroutine.running()                     -- F3109["running"]()
        local record = { controller = AP, generation = myGen } -- bKB
        bny.runs[runId] = record                               -- S1966
        while true do
            if not (bnB() and not AP.stopped
                    and AP.generation == myGen) then break end -- S1956/59/58
            local ok, err = pcall(AQ)                          -- S1955
            if cKb[54].ownerRun == record then                 -- владелец заявки?
                bpY(AP.priorityKey)                            -- S1969 снять заявку
                if AP.generation == myGen then
                    cKb[54]["do ne"](AP.priorityKey)           -- S1967 закрыть
                end
            end
            if not ok then
                warn("[Ouroboros] loop error:" .. tostring(err))   -- S1963
            end
            if not bnB() then break end                        -- S1977
            if AP.stopped then break end                       -- S1954
            if AP.generation ~= myGen then break end           -- S1953/1972
            task.wait(AP.interval)                             -- S1975
        end
        bny.runs[runId] = nil                                  -- S1957
        if AP.generation == myGen then AP.workerActive = false end
    end)
end
```

Остановка — `bmX`:

```
bmX = F363 = function(Ba)                       -- S1083..S1087
    Ba.stopped = true; Ba.yield = false; Ba.startedAt = nil
    Ba.cancel = (Ba.cancel or 0) + 1
    Ba.generation = (Ba.generation or 0) + 1
    Ba.workerActive = false
    cKb[54]["do ne"](Ba.priorityKey, true)      -- закрыть заявку силой
    cKb[54].uncommit(Ba.priorityKey)
    if bny.session and bny.session.controller == Ba then bny.stop(bny.session) end
    if Ba.priorityKey and cKb[54].holder == Ba.priorityKey then
        cKb[37](); cKb[87](); bpY(Ba.priorityKey, true)       -- снять блок/движение
    end
end
```

Реестр контроллеров — `cKb[91]` (в нём же `controllers`, `features`, `opened`,
`retryAt`, `SchematicRunner`); вызовы вида
`cKb[84](cKb[91].TrainController, cKb[91].TrainController.step)`.

Поля контроллера (все встречаются в артефакте): `interval`, `step`, `generation`,
`stopped`, `startedAt`, `yield`, `workerActive`, `cancel`, `priorityKey`.

`bny` (ядро): `runs[id] = record`, `session = {controller=…}`, `stop(session)`,
`inputs[id] = owner`, `releaseInput(id, owner)`,
`controllerValid(controller)` (гейт: контроллер ещё жив — используется шагами
перед каждым действием), `cancelSkill`, `timing`.

## 3. Арбитр приоритетов `cKb[54]`

Поля: `holder` (кто держит приоритет), `ownerRun` (какая запись воркера владеет),
`done(key, force)`, `uncommit(key)`, `commit`, `turn`, `blocked`, `label`,
`active`, `settling`, `byKey`, `lastClaim`, `movementEpoch`,
`PriorityStatus`, `PriorityHolder`. Освобождение заявки — `bpY = F1585(key, force)`.

## 4. Глобальные циклы (запускаются из тела скрипта)

| Хендл | Старт | Тело | Что делает |
|---|---|---|---|
| `cKb[75]` | `S2052`: `task.delay(0, F5182)` | `F5182` | пока `bnB()`: под `pcall` пересчитывает `bpz.Summary = cKb[51].PlayerSummary()`, `bpz.Quest = cKb[51].QuestSummary()`, `bpz.CostText = cKb[51].BreathingCost()`, затем `task.wait(1)` |
| `bm8` | `S2056`: `task.delay(0, F3841)` | `F3841` | каждые 0.2 с «ownership»-подсветка: если `cKb[99].tweaks.ownership` выключен → `bpp.clear()` и выход; иначе собирает мобов (`boo()`), считает дистанцию до корня (`cKb[145]()`), и для мобов ближе `tweaks.ownershipRange` ставит метки (`bpp.marks[part]`, `cKb[78]`) с покраской `FillColor/OutlineColor`; лишние метки снимает (`cKb[112]`) |
| `bnx` | `S2928`: `Heartbeat:Connect(F4910)` | `F4910` | планировщик блоков/парирования (см. §5) |
| `entry.connection` | при постановке входа блока (S9202) | `boA(entry)` под `pcall` | опрос одного входа блока каждый кадр |

`F4910` — обёртка с защитой от повторного входа (`bn9`) и докладом об ошибке:

```
if bn9 then return end            -- S792
bn9 = true
local ok, err = pcall(cKb[65])    -- F2175(cKb[65]); cKb[65] = F3871
bn9 = false                       -- S787
if not ok and bnB() then          -- S789/S793
    cKb[100]("auto parry scheduler:" .. tostring(err))   -- S788
end
```

## 5. Блок/парирование: объект `bnl` (= `cKb[51].BlockWork`)

| Поле | Значение |
|---|---|
| `bnl.on`, `bnl.hold`, `bnl.mitigate`, `bnl.npc`, `bnl.pvp`, `bnl.lead`, `bnl.radius` | настройки из меню (`cKb[61]` — `reachPad`, `acknowledgement` и пр.) |
| `bnl.entries` (`bm0`) | таблица активных входов блоков (пары `инфо → состояние`) |
| `bnl.blockEntry` | вход, по которому идёт текущий блок |
| `bnl.stats` | `{fired, locked, late, missed, cancelled}` |
| `bnl["in validate"]` | `F4744`: `bnl.generation += 1`, `table.clear(bm0)` (хвост с `cKb[50]`/`cKb[14]` не вычитан) |
| `bnl.step` | `F288`: супервизор активного входа + статус `bpz.ParryStatus` |
| `bnl.reset` | `F6287`: обнулить `stats` |

`F288` (статусы, дословно): «Off» / «Combat presets unavailable» (гейт
`cKb[17]()` = `F3460`), «Block acknowledgement unresolved» (фаза `boxFill`),
«Waiting for previous block release» (вход ≠ `blockEntry`), «Waiting for block
release» (фаза `releasing`), иначе — `"%d attempts, %d blocks, %d missed,
%d cancelled"`.

`cKb[65] = F3871` — планировщик: перебор `pairs(bm0)`, `cKb[58] = F4381` (вход
годен), `cKb[128](model, reach, cKb[61].reachPad, true)` (дотягивается ли),
`cKb[41](model)` → `"block"`/`"none"`, `cKb[143](protectUntil)`, `bmN = F2590`
(проверка входа, 2 арг.), `bmL(entry, bool)` (взвести/снять), счётчики
`stats.missed` (просрочен `latest`) и `stats.fired`/`locked`.

## 6. Что ещё не восстановлено

* точное тело `F3871` (окна срабатывания, `protectUntil`, `mitigate`-ветка) —
  сейчас в сборке каркас: опрос входов + счётчик `missed`;
* `F4744` (хвост `in validate`) и `bom()` из `F288`;
* `F3841` (ownership-цикл) — нужны `bpp`, `cKb[78]`, `cKb[112]`;
* `F5182` зависит от `PlayerSummary` (F4476), `QuestSummary` (F3729),
  `BreathingCost` (F4597) — в сборке вызываются, если зарегистрированы в `cKb[51]`;
* воркеры, которых пока нет в сборке (см. `data/D_MAP.md`, ROADMAP п.6):
  рыбалка, данжи, очереди, ESP, вебхуки, тренировки, скиллы-контроллер.

## 7. Слоты, найденные попутно (канон = вторая копия)

`cKb[17] = F3460` (боевые пресеты доступны), `cKb[58] = F4381`,
`cKb[65] = F3871`, `cKb[73]` — pc верхней машины, `cKb[75] = task.delay(0, F5182)`,
`cKb[84]` — старт воркера (инлайн), `cKb[98] = F1968` (счётчик),
`cKb[14] = F5469`, `cKb[10] = F6447` / `cKb[91].SchematicRunner`, `cKb[50] = {}`,
`cKb[87] = F1319` (в первой копии; в каноне `cKb[87]` — отмена перемещения),
`bmX = F363`, `boa = F3818`, `bpu = F6310`, `bny`/`bpY = F1585`/`bn9`.
