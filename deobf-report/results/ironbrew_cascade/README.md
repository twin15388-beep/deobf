# IronBrew / AztupBrew: что получилось деобфусцировать

Корпус: 36 файлов с заголовком `IronBrew:tm: obfuscation` из `hexahigh/Scripts`.
**В этой папке — только те 12, что доведены до настоящего Lua.** Остальные 24 в результаты
не попали: их чанк не собирается в валидный байткод, причины и извлечённые имена объектов —
в `../_failed.md`.

Пайплайн:

```
CASCADE (devirtualize) → output.luac → luac_fix.py (maxstack/nups/vararg)
   → luac32to64.py → проверка загрузки в Lua 5.1.1 → unluac → lua_threeaddr.py
```

## Результаты

| каталог | игра/тема | строк | что внутри |
|---|---|---:|---|
| `_script_hub` | мультиигровой хаб (~100 игр) | 3 932 | `HttpGet`-загрузчик, XOR-декодер строк, `PreacherHub`-меню: папки `Games` → `Arsenal`, `Astray`, `Jailbreak`, `Tower of Hell`, … |
| `tower_of_hell_script` | Tower of Hell | 274 | авто-прохождение; в выводе есть `goto` (Lua 5.2+) |
| `tiny_tanks_gui` | Tiny Tanks | 212 | GUI: `ScreenGui`/`Frame`/`TextButton`, `Color3`/`UDim2`, подпись `Tank-` |
| `piggy_item_hub` | Piggy | 166 | хаб предметов: `ScrollingFrame`, `UIGridLayout`, цвета `0.15/0.15/0.15` |
| `prison_life_destroyer_hub` | Prison Life | 166 | тот же скрипт, что и Piggy (дубликат в корпусе) |
| `god_mode_any_game` | универсальный | 142 | `Players.LocalPlayer.Character.HumanoidRootPart.Position` → `Character:MoveTo(box.Position + offset)`, `UserInputService.InputBegan`, `Instance.new("Part")` |
| `avatar_swastika` | скин персонажа | 91 | `RunService`, `BodyForce`, `WaitForChild("HumanoidRootPart", 5)` |
| `ctrl_click_tp` | универсальный | 77 | телепорт по Ctrl+клик (есть 1 `goto`) |
| `fps_booster` | универсальный | 37 | `settings().Rendering`, `UserSettings():GetService("UserGameSettings")`, `Enum.VideoQualitySettings.LowResolution` |
| `anti_afk` | универсальный | 34 | `VirtualUser` + `Players.LocalPlayer.Idled` → `Button2Down/Button2Up` |
| `mega_fun_obby_auto_skip_stages` | Mega Fun Obby | 28 | `leaderstats.Stage.Value + 1` → `Workspace.stages:FindFirstChild(tostring(clvl))` |
| `clone_tycoon_2_1_billion_gems` | Clone Tycoon 2 | 7 | минимальный скрипт |

В каждом каталоге: `script.lua` (код) и `PARTS.md` (механики с уликами, вызовы API,
имена функций, парты/объекты, ссылки).

## Чем это отличается от прошлых итераций

| Шаг | Раньше | Сейчас |
|---|---|---|
| CASCADE на IB 2.7.x | падал `throw "ayo"` / 301-байтный пустой чанк | доходит до конца, чанк 200 B – 270 КБ |
| Формат чанка | `bad header in precompiled chunk` | `luac32to64.py` (32→64 бита) |
| Заголовок прототипа | `nups=0`, `is_vararg=2`, `maxstack=250` → `bad code` | честные значения (`luac_fix.py`) |
| unluac | `Index 250 out of bounds` | декомпилирует, максимум 3–12 локалов на функцию |

Подробности патчей — `../../tools/PATCHES.md` §9–10.
