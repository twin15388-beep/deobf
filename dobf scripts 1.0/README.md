# Восстановленные игровые Lua-файлы — 19 октября 2026 г.

Это **четыре новых восстановления из четырёх VM-защищённых файлов трёх разных игр**, а не перечень имён функций или копии соседних открытых скриптов. Старые частичные/непроверенные файлы и устаревшие отчёты удалены по запросу. Исходный защищённый Lua и полученный Lua **не выполнялись**. Восстановлен **читаемый Lua 5.1**, но имена переменных и форматирование утрачены, идентичность исходному тексту и работа в Roblox не доказаны.

| Игра | Полученный код | Что действительно восстановлено |
| --- | --- | --- |
| God of Glory | [Destroy World.lua](God%20of%20Glory%20-%20Destroy%20World.lua) | Условие `StreamingEnabled == true`, callback `spawn(function() … end)`, обход папок и `BreakBuilding:FireServer`. |
| Nerf FPS 5.46 | [Infinite Money.lua](Nerf%20FPS%205.46%20-%20Infinite%20Money.lua) | Обход `leaderstats` и callback `__namecall` с защитой от `SubCash`. |
| Nerf FPS 5.46 | [TDM Kill All.lua](Nerf%20FPS%205.46%20-%20TDM%20Kill%20All.lua) | Оба цикла, фильтрация команды, `repeat`/`until`, вызов `sumiisbestgirl:FireServer`. В этом файле **нет пользовательского объявления функции**: не выдаём её за выдуманное имя. |
| Prior Extinction | [Anti Kick Ban.lua](Prior%20Extinction%20-%20Anti%20Kick%20Ban.lua) | Callback `__namecall`, ветви `KickPlayer`, `Ban`, `ServerBan`, `Teleport` и вызов старого обработчика. |

Ниже — **содержимое восстановленных обработчиков**, с удобными **аналитическими названиями**. Эти имена придуманы для описания роли, **не выдаются за утраченные оригинальные символы**. Точный вывод декомпилятора с операциями вокруг обработчиков и реальными формами вызовов находится в связанных `.lua`-файлах.

## God of Glory — `destroyWorldDestructibles()`

Параметров нет. Восстановленный обработчик передаётся в `spawn`; использует ранее установленные глобальные `worlds` и `remote`. Сначала основной chunk получает `NormalWorlds` и `BreakBuilding` и при `StreamingEnabled == true` присваивает `false`. Тело callback в человекочитаемой записи:

```lua
-- Аналитическое имя: в полученном файле это анонимный spawn(function() ... end).
local function destroyWorldDestructibles()
    for _, world in pairs(worlds:GetChildren()) do
        if world:IsA("Folder") then
            for _, folder in pairs(world:GetDescendants()) do
                if folder:IsA("Folder") and folder.Name == "Destructibles" then
                    for _, child in pairs(folder:GetChildren()) do
                        remote:FireServer({ TagFullName = tostring(child:GetFullName()) })
                    end
                    print("Destruction Loop Done")
                end
            end
        end
    end
end
```

## Nerf FPS — `blockSubCash(self, ...)`

Перед установкой перехватчика основной chunk находит дочерние `NumberValue` в `LocalPlayer.leaderstats` и при `v.name == "CashMoney"` присваивает `v.Value = 9000000000`. Затем снимает readonly с метатаблицы, сохраняет прежний `__namecall`, устанавливает `newcclosure` и возвращает readonly. **Реальное тело** callback после смыслового переименования регистров:

```lua
-- Аналитическое имя: в файле это анонимный newcclosure(function(p1_0, ...) ... end).
local function blockSubCash(self, ...)
    local args = { ... }  -- присутствует в VM, но далее не используется
    local method = getnamecallmethod()
    if method == "FireServer" and self.Name == "SubCash" then
        print("Trying to take cash from me NO!")
        return nil
    end
    return oldNamecall(self, ...)
end
```

`oldNamecall` обозначает сохранённый до замены `gmt.__namecall` — это захваченная внешняя переменная, а **не** новый глобальный API. Вызовы Roblox здесь не выполнялись.

## Nerf FPS TDM — основной chunk, не объявленная функция

Сохранённые операции основного тела: получить `game:GetService("Players"):GetPlayers()`, оставить игроков другой команды, кроме локального игрока; затем для каждого напечатать цель и повторять показанный ниже цикл до чтения `Humanoid.Died`. Не маскируем этот код под найденную именованную функцию:

```lua
for _, player in pairs(targets) do
    print(#targets)
    print("[Current Target]: " .. player.name)
    repeat
        wait(1)
        event:FireServer(149306230, player.Character, 100, "VULCAN", false)
        print("[Targets Heath] " .. player.Character.Humanoid.Health)
    until player.Character.Humanoid.Died
    print("Target " .. "[" .. player.name .. "]" .. " Elimated")
end
```

`event` и `targets` — только поясняющие имена: точный файл использует регистры `r0_…`. Не исправляли ни опечатку `Heath`/`Elimated`, ни необычное условие с `Died`: это именно наблюдаемые операции, а не обещание, что скрипт работает в нынешней игре.

## Prior Extinction — `guardNamecall(self, ...)`

Основной chunk берёт `getrawmetatable(game)`, сохраняет `gmt.__namecall`, снимает readonly, устанавливает callback через `newcclosure`, восстанавливает readonly и выводит сообщение. Внутри callback сохраняется `{...}` (затем не используется), проверяется метод и имя объекта, в ветви запрета печатается сообщение и возвращается `9000000000`, иначе — `oldNamecall(self, ...)`. Условие из **восстановленного** файла:

```lua
-- Аналитическое имя, не оригинальный символ:
local function guardNamecall(self, ...)
    local args = { ... }
    if getnamecallmethod() == "FireServer" and self.Name == "KickPlayer"
        or self.Name == "Ban" or self.Name == "ServerBan"
        or self.Name == "Teleport" then
        print("Someone tried to kick or ban us!")
        return 9000000000
    end
    return oldNamecall(self, ...)
end
```

**Важно:** `and` имеет приоритет над `or`. `"FireServer"` требуется только вместе с `"KickPlayer"`; для трёх других имён проверка метода **не** обязательна. Это оставлено без «исправления»; в машинно восстановленном файле условие представлено как ранний `return oldNamecall(...)` при отрицании того же предиката.

## Что подтверждено — и что нет

В каждом из четырёх входов прочитано **100% декодированного потока**, все VM-инструкции сопоставлены с обработчиками и собран Lua 5.1 bytecode. Его и итоговый текст принял `Lua 5.1 luac -p`; `unluac-js@1.4.4` в строгом режиме вернул `source` **без ошибок** для всех четырёх. Существенные ветви, параметры и эффекты **вручную сверены** с отдельно опубликованными открытыми контрольными парами того же pinned commit; сами открытые пары **не засчитаны** как результаты. Это более сильное основание, чем одни имена/константы, но **не** формальное доказательство поведенческой эквивалентности и **не** тест в Roblox. Сторонние права на исходные скрипты не установлены.

Формат и профили специфичны для этих конкретных SHA-256, их нельзя применять вслепую к GPO, Luraph, MoonSec, Luast или чужому VM. **GOGV3** (32 прототипа, 733 инструкции) прочитан только как контейнер — не публикуется как якобы готовый Lua. Для GPO надёжного полного игрового исходника всё ещё нет. [Методика, сравнение инструментов, пины и причины неудач](../reports/vm-recovery-2026-10-19.md) · [машинный отчёт с SHA-256](../reports/vm-recovery-2026-10-19.json) · [статический декодер](../scripts/recover_vm_samples.py).
