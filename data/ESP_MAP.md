# Карта ESP (подсветка живых объектов) — рабочая сборка (вариант B)

Роли слотов (см. `data/BUILD_MAP.md`): `cKb[92]` — тумблеры (`bna["opt"]`),
`cKb[147]` — палитра (16 цветов), `cKb[57]` — восемь углов куба для `box3d`.

## Сборщик записей — `cKb[147]["collect"]` (состояния S6560…S6596)

В артефакте он встроен в главную машину; в варианте B тело лежит на смещениях
≈1 950 300…1 959 700. Собирает таблицу `cjJ` и возвращает её.

Внутри на каждом кадре:

```lua
local entries = {}                                  -- cjJ
local function mark(model, label, category, isPlayer)   -- cjK (S6569)
    if model and model:IsDescendantOf(game) then     -- cjH = model:IsDescendantOf(cKb[132])
        entries[model] = { label = label, category = category, player = isPlayer }
    end
end
```

То есть `mark` — это фильтр: модель обязана быть потомком `game` (`cKb[132]`),
иначе запись не создаётся. Поля записи строго `label`, `category`, `player`.

### Категории и подписи (проверено по телам состояний)

| Категория (`bna["on"][…]`) | Источник | Подпись |
|---|---|---|
| `"Chests"` | `bqo()` — список сундуков | `ChestId`, иначе `"Chest"`, плюс `" (locked)"`, если `ChestState == "Locked"` |
| `"Levers"` | дети контейнера `game:FindFirstChild("Map")` (в нём же `"Sickles Levers"`) | `"Lever " .. <Name>` |
| `"Spider Lily"` | дети контейнера (`Debree`) | `"Spider Lily"` |
| `"NPCs"` | контейнер с `"Puzzles"`/`"StationaryNpcs"` | `<child>.Name` |
| `"Muzan"` | `Debree:FindFirstChild("MuzanLairModel")` | `"Muzan"` |
| `"Bosses"` / `"Mobs"` | `boo()` — записи `{ model = …, name = … }` | `record.name`; категория `"Bosses"`, если имя есть в `cKb[147]["bossNames"]()`, иначе `"Mobs"` |
| `"Wild Horse"` | `bnK()` | `"Horse"` |
| `"Players"` | `Players:GetPlayers()` | имя игрока, `player = true` |

Порядок ветвлений соответствует порядку проверок `bna["on"][…]` в дизассемблере
состояний: `Chests` → `NPCs` → `Players` → `Bosses`/`Wild Horse`/`Spider Lily`/`Mobs`
→ `Muzan` → `Levers`.

## Хелперы отрисовки — `cKb[147]`

| Поле | Значение |
|---|---|
| `["camera"]` | `F5089` — текущая камера |
| `["container"]` | `F6613` — GuiObject-контейнер для 2D-элементов |
| `["newFrame"]` | `F4132` |
| `["newLabel"]` | `F2752` |
| `["line"]` | `F5265` — линия/трейсер |
| `["anchorPart"]` | `F5538` — привязка к части модели |
| `["add"]` | `F4872` — добавить запись на экран |
| `["bossNames"]` | `F4162` — таблица имён боссов |
| `["drop"]` | удаление записи: `entries[model]` → `holder:Destroy()` (через `F2175`) |
| `["collect"]` | сборщик выше |

`cKb[92]["clear"] = F3998`, и он же регистрируется в общем трекере:
`cKb[99]["Track"](cKb[92]["clear"])`.

## Состояние реконструкции

Тела `F5089` (camera), `F6613` (container, `OuroborosOuwlandEsp`, CoreGui, DisplayOrder
999999), `F4132` (newFrame), `F2752` (newLabel), `F5265` (line), `F5538` (anchorPart),
`F4872` (add: рамка + `UIStroke` + 12 линий + трейсер + подписи + полоса здоровья),
`F790` (bounds), `F675` (health), `F163` (hide), `F4525` (tint), `F4162` (bossNames),
`F3998` (clear) и `F5471` (render, вне пула — читается регионом) **вычитаны и вписаны
в `ouroboros_esp.lua`**; рёбра куба — экспорт `ESP.EDGES` → слот `cKb[39]` в
`tools/build_recon.py`.

Проверено дымовым прогоном (`tools/smoke.sh`, секция «ESP: рендер»): `Bounds`/`AnchorPart`/
`Tint`, `AddEntry` → `Render` (рамка, штрих, имя, «N studs», 12 рёбер box3d, трейсер),
полоса и подпись здоровья для модели с Humanoid (40/100), `HideEntry`, отсечение по
`range`, `ClearScreen`, `DropEntry`. Заглушки `tools/smoke_stub.lua` дополнены типами
`CFrame`/`Vector2`/`Color3` (`typeof`, `PointToWorldSpace`, `Lerp`, вычитание векторов).

## Что осталось

1. Сборщик записей (`collect`) подключить к реальному потоку: сейчас записи кладёт
   вызывающая сторона (`AddEntry`), категории — из `cKb[92]`.
2. Уточнить внутренние контейнеры для `Levers`/`Spider Lily`/`NPCs` (сырые тела
   состояний S6584/S6590/S6591) — в документе указаны по именам детей, найденным
   рядом: `"Map"`, `"Sickles Levers"`, `"Puzzles"`, `"StationaryNpcs"`, `"Debree"`.
