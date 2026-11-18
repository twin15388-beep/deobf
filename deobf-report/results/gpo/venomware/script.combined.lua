--======================================================================
-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации
-- Игра/тема: gpo · Сэмпл: venomware
-- Каталог:   deobf-report/results/gpo/venomware/
-- Дата сборки: 2026-11-17 · Сгенерировано deobf-report/tools/build_combined.py
--
-- Состав (в этом порядке):
--   * PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии
--   * script.lua — ниже дословно (sha256=8031387f5083b85feb41f892f8de1a40633ff2f0c6114ae272cd5d9d42a8437b)
--
-- Раздел 1/2 ниже — содержимое PARTS.md, построчно как Lua-комментарии.
-- Раздел 2/2 — восстановленный код (script.lua) ДОСЛОВНО, без изменений.
-- Комментарии в этом файле НЕ являются частью исходного кода игры.
-- ВНИМАНИЕ: это чужой код (игровой скрипт/хаб). Не запускайте его в Roblox,
-- не понимая, что он делает; результаты получены статической деобфускацией.
--======================================================================
--======================================================================
-- РАЗДЕЛ 1/2: PARTS.md (инвентарь: механики / Roblox API / имена функций / парты)
--======================================================================
-- # `venomware` — функционал и механики
--
-- Игра/тема: **gpo** · восстановленный код: `script.lua` (70 строк)
--
-- ## Что делает (по восстановленному коду)
--
-- - **ESP / подсветка** — улики: `chams`, `esp`
-- - **сеть / загрузка кода** — улики: `httpget`, `loadstring`
-- - **аимбот / наведение** — улики: `aimbot`
-- - **урон / убийство** — улики: `hitbox`
--
-- ## Вызовы API
--
-- - Сервисы: `Players`
-- - Методы: `HttpGet`×16, `loadstring`×16
--
-- ## Имена функций (0)
--
-- _имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), смысл восстанавливается по вызовам выше_
--
-- ## Строковые константы (UI, подписи)
--
-- - `Section` ×3
-- - `Left` ×3
-- - `ESP` ×3
-- - `Arrowesp` ×3
-- - `Chams` ×3
-- - `Healthbar` ×3
-- - `Skeleton` ×3
-- - `Radar` ×3
-- - `Exploits` ×3
-- - `Spinbot` ×3
-- - `WeaponGlow` ×3
-- - `HitBox` ×3
-- - `FlyHack` ×3
-- - `SpeedHack` ×3
-- - `AntiKick` ×3
--
-- ## Ссылки / webhooks / ассеты (18)
--
-- - `http://www.roblox.com/asset/?id=8395621517`
-- - `http://www.roblox.com/asset/?id=8395747586`
-- - `https://raw.githubusercontent.com/lenny2010/CHAMS3/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/espspp/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/hitbox/main/.lua`
-- - `https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua`
-- - `https://raw.githubusercontent.com/ZhenX201/fe-radar-script/main/source`
-- - `https://raw.githubusercontent.com/lenny2010/SkeletonV2/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/WeaponESP/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/aimbotpaid/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/antivote/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/arrow-esp/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/flyhack/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/healthybar/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/infjump/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/speedhack/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/spinbot/main/.lua`
-- - `https://raw.githubusercontent.com/lenny2010/tracerr/main/.lua`
--
-- ## Парты / объекты (46)
--
-- - идентификаторы в коде: `Aimbot`, `AntiKick`, `Arrowesp`, `Button`, `ButtonName`, `CHAMS3`, `Category`, `Category1`, `Chams`, `Combat`, `Description`, `ESP`, `Exploits`, `FlyHack`, `Grand`, `Healthbar`, `HitBox`, `HttpGet`, `HydraHubUi`, `InfJump`, `Left`, `LocalPlayer`, `Main`, `Online`, `Piece`, `Radar`, `Script`, `Section`, `Section1`, `Skeleton`, `SkeletonV2`, `SpeedHack`, `Spinbot`, `StepBroFurious`, `SubButton1`, `Title`, `Tracer`, `UILib`, `UserId`, `VenomWare`
--======================================================================
-- КОНЕЦ PARTS.md
--======================================================================
-- РАЗДЕЛ 2/2: восстановленный код (дословно)
--======================================================================
local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()
local Window = UILib.new("Grand Piece Online", game.Players.LocalPlayer.UserId, "VenomWare")
local Category1 = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")
local SubButton1 = Category1:Button("Combat", "http://www.roblox.com/asset/?id=8395747586")
local Section1 = SubButton1:Section("Section", "Left") Section1:Button({Title = "Aimbot", ButtonName = "Aimbot", Description = "locks on player",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/aimbotpaid/main/.lua'))()
end
)
local SubButton1 = Category1:Button("ESP", "http://www.roblox.com/asset/?id=8395747586")
local Section1 = SubButton1:Section("Section", "Left") Section1:Button({Title = "ESP", ButtonName = "ESP", Description = "Wallhack",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/espspp/main/.lua'))()
end
) Section1:Button({Title = "Tracer", ButtonName = "Tracer", Description = "Wallhack",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/tracerr/main/.lua'))()
end
) Section1:Button({Title = "Arrowesp", ButtonName = "Arrowesp", Description = "Arrowesp",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/arrow-esp/main/.lua'))()
end
) Section1:Button({Title = "Chams", ButtonName = "Chams", Description = "Chams",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/CHAMS3/main/.lua'))()
end
) Section1:Button({Title = "Healthbar", ButtonName = "Healthbar", Description = "Healthbar",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/healthybar/main/.lua"))()
end
) Section1:Button({Title = "Skeleton", ButtonName = "Skeleton", Description = "Skeleton",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/SkeletonV2/main/.lua'))()
end
) Section1:Button({Title = "Radar", ButtonName = "Radar", Description = "Radar",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhenX201/fe-radar-script/main/source"))()
end
)
local Category1 = Window:Category("Exploits", "http://www.roblox.com/asset/?id=8395621517")
local SubButton1 = Category1:Button("Exploits", "http://www.roblox.com/asset/?id=8395747586")
local Section1 = SubButton1:Section("Section", "Left") Section1:Button({Title = "Exploits", ButtonName = "InfJump", Description = "InfJump",}, function(value)
  print(value)
  loadstring(game:HttpGet('https://raw.githubusercontent.com/lenny2010/infjump/main/.lua'))()
end
) Section1:Button({Title = "Spinbot", ButtonName = "Spinbot", Description = "Spinbot",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/spinbot/main/.lua"))()
end
) Section1:Button({Title = "WeaponGlow", ButtonName = "WeaponGlow", Description = "WeaponGlow",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/WeaponESP/main/.lua"))()
end
) Section1:Button({Title = "HitBox", ButtonName = "HitBox", Description = "HitBox",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/hitbox/main/.lua"))()
end
) Section1:Button({Title = "FlyHack", ButtonName = "FlyHack", Description = "FlyHack",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/flyhack/main/.lua"))()
end
) Section1:Button({Title = "SpeedHack", ButtonName = "SpeedHack", Description = "SpeedHack",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/speedhack/main/.lua"))()
end
) Section1:Button({Title = "AntiKick", ButtonName = "AntiKick", Description = "AntiKick",}, function(value)
  print(value)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/lenny2010/antivote/main/.lua"))()
end
)
