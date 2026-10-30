# Топ результатов: что реально читается как исходник

> В `results/` теперь попадает только деобфнутое. Файлы, где снят лишь внешний слой
> (wearedevs/Prometheus, doink, Luraph v14, IronBrew-неудачи), вынесены в `_failed.md`.

Критерий — не размер, а «можно открыть и понять, что скрипт делает, без дизасма».
Смотрел на: сохранённые имена (`Scroll`, `TextLabel`, `Signal`), строковые константы
Roblox API, отсутствие `L12_1 = L12_1` и `goto lbl_`.

## 1. `counter_blox/hub` — эталон (6 915 строк, 300 КБ)

Обфускатор не распознан, снят `unprom`. Имена переменных **сохранены** —
выглядит как исходник, а не как декомпиляция:

```lua
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua"))()
local TweenService = game:GetService("TweenService")
local cfglocation = "ovacfg/"
makefolder("ovacfg")
...
Button.Font = Enum.Font.SourceSans
TextLabel.TextColor3 = COL3RGB(200, 200, 200)
Button.MouseButton1Down:Connect(function()
    Drop.Visible = false
    Drop.CanvasPosition = Vec2(0, 0)
```

## 2. `blox_fruits/hub` — самый чистый Luraph v15 (6 764 строки, 188 КБ)

Табы, осмысленные `fn2/fn3/fn4`, честный загрузчик с `pcall`/`loadstring`/`HttpGet`:

```lua
repeat task.wait() until game:IsLoaded()
local function fn4(arg)
    local ok, result = pcall(function() return game:HttpGet(arg, true) end)
    if not ok then return nil, "Failed to load resource" end
    return result
end
```

## 3. `grow_a_garden/hub` (10 450 строк) и `gacha_online/hub` (10 451 строка, PSU)

Тот же класс качества: `until game:IsLoaded()`, `tbl._unpack/_pcall`, живые `game:GetService`.
Отдельно ценно, что PSU-сэмпл (Gacha) даёт такой же читаемый результат, как Luraph.

## 4. `king_legacy/KL_msv3_v15_ZombieAttack` (10 423) и `KL_msv2_v13` (4 207)

MoonSec V2/V3. Многословно (`L4_2 = L4_2.GetPlayers`), но **все имена Roblox на месте**,
и видно защиту от тампера, которую сняли:

```lua
local getconstants2 = debug.getconstants
v11 = getconstants2(p3)
```

## 5. IronBrew (новая, 6-я итерация) — `ironbrew_cascade/`

| файл | строк | почему хвалю |
|---|---:|---|
| `mega_fun_obby_auto_skip_stages` | 28 | один в один исходник: `leaderstats.Stage.Value + 1`, `Workspace.stages:FindFirstChild(tostring(clvl))` |
| `god_mode_any_game` | 142 | читается цепочка `LocalPlayer.Character.HumanoidRootPart.Position` → `Character:MoveTo(box.Position + offset)` |
| `avatar_swastika` | 91 | `RunService.RenderStepped`, `BodyForce`, `WaitForChild("HumanoidRootPart", 5)` |
| `_script_hub` | 3 932 | самый крупный артефакт: список ~100 игр, `HttpGet`-загрузчик, XOR-декодер строк |
| `tiny_tanks_gui` / `piggy_item_hub` / `prison_life_destroyer_hub` | 212 / 166 / 166 | полностью восстановлен GUI (Color3/UDim2/Enum.Font, обработчики кнопок) |

Пример из `mega_fun_obby_auto_skip_stages/script.lua` (после `lua_threeaddr.py`):

```lua
while true do
  arg = wait()
  if not arg then break end
  clvl = game.Players.LocalPlayer.leaderstats.Stage.Value + 1
  arg = game.Workspace.stages
  arg = arg.FindFirstChild(tostring(clvl))
  ...
```

## Что хвалить не за что (честно)

| файл | почему нет |
|---|---|
| `king_legacy/KL_psu45_ano` (56 150) | объём даёт `L0_1 = L0_1` / `do return L1_2 end` — мусорный пролог PSU-лифта |
| `ironbrew_cascade/_script_hub` | 123 `goto` — структура видна, но это Lua 5.2+, часть аргументов вызовов съехала |
| `corpus/psu_small` | много `goto lbl_*` — тот же артефакт unluac |

## Как быстро проверить самому

```bash
# «живые» идентификаторы: чем больше, тем лучше
grep -o '\b[A-Z][A-Za-z0-9_]\{4,\}\b' path/to/script.lua | sort -u | head -30
# «шум» лифта
grep -c '^\s*L[0-9]*_[0-9]* = L[0-9]*_[0-9]*$' path/to/script.lua
# артефакты unluac
grep -c 'goto lbl_' path/to/script.lua
```
