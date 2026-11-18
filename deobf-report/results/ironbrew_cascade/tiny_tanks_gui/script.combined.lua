--======================================================================
-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации
-- Игра/тема: ironbrew_cascade · Сэмпл: tiny_tanks_gui
-- Каталог:   deobf-report/results/ironbrew_cascade/tiny_tanks_gui/
-- Дата сборки: 2026-11-17 · Сгенерировано deobf-report/tools/build_combined.py
--
-- Состав (в этом порядке):
--   * PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии
--   * script.lua — ниже дословно (sha256=8f14e296bc16161034fcd4641eae17a17ba48fef150364aaf7400032b7af8270)
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
-- # `tiny_tanks_gui` — функционал и механики
--
-- Игра/тема: **ironbrew_cascade** · восстановленный код: `script.lua` (212 строк)
--
-- ## Что делает (по восстановленному коду)
--
-- - **GUI / меню** — улики: `screengui`, `textbutton`
-- - **аимбот / наведение** — улики: `mousebutton`
--
-- ## Вызовы API
--
-- - Сервисы: `CoreGui`, `Players`
-- - Классы/объекты: `Frame`, `ScreenGui`, `TextButton`
-- - Методы: `GetChildren`×1
--
-- ## Имена функций (0)
--
-- _имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), смысл восстанавливается по вызовам выше_
--
-- ## Строковые константы (UI, подписи)
--
-- - `Tank-` ×5
--
-- ## Ссылки / webhooks / ассеты (0)
--
-- _нет_
--
-- ## Парты / объекты (14)
--
-- - идентификаторы в коде: `AvailableAmmo`, `Color3`, `Enum`, `Font`, `FontSize`, `GetChildren`, `Highway`, `LocalPlayer`, `MouseButton1Down`, `Name`, `Size14`, `Tank`, `Tanks`, `UDim2`
--======================================================================
-- КОНЕЦ PARTS.md
--======================================================================
-- РАЗДЕЛ 2/2: восстановленный код (дословно)
--======================================================================
local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1
L1_1 = "ScreenGui"
L2_1 = "Frame"
L3_1 = "TextButton"
L4_1 = "TextButton"
L5_1 = "TextButton"
L6_1 = "TextButton"
L7_1 = "TextButton"
L7_1 = game.CoreGui
arg = L7_1
L8_1 = 0
L9_1 = 0
L10_1 = 0
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 0.699999988
L9_1 = 0
L10_1 = 0.949999988
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.0500000007
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L1_1 = L7_1
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 0
L9_1 = 0
L10_1 = 0.100000001
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.800000012
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L7_1 = Enum.Font.Highway
L7_1 = Enum.FontSize.Size14
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.100000001
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.800000012
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L7_1 = Enum.Font.Highway
L7_1 = Enum.FontSize.Size14
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 0.400000006
L9_1 = 0
L10_1 = 0.100000001
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.800000012
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L7_1 = Enum.Font.Highway
L7_1 = Enum.FontSize.Size14
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 0.600000024
L9_1 = 0
L10_1 = 0.100000001
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.800000012
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L7_1 = Enum.Font.Highway
L7_1 = Enum.FontSize.Size14
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L8_1 = 0.800000012
L9_1 = 0
L10_1 = 0.100000001
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L8_1 = 0.200000003
L9_1 = 0
L10_1 = 0.800000012
L11_1 = 0
L7_1 = UDim2.new(L8_1, L9_1, L10_1, L11_1)
L7_1 = Enum.Font.Highway
L7_1 = Enum.FontSize.Size14
L8_1 = 1
L9_1 = 1
L10_1 = 1
L7_1 = Color3.new(L8_1, L9_1, L10_1)
L2_1 = true
L7_1 = L2_1.MouseButton1Down
L3_1 = true
L4_1 = true
L5_1 = true
L6_1 = true
L8_1 = L7_1
L7_1 = L7_1.connect
function L9_1(...)
  local L1_2, L2_2, L3_2
  L2_2 = game.Players.LocalPlayer.Name
  L3_2 = ""
  L1_2 = ("Tank-") .. L2_2 .. L3_2
  arg = workspace.Tanks[L1_2]
  mytank = arg
  L1_2 = math.huge
  arg = L1_2
end
L7_1(L8_1, L9_1)
L7_1 = L3_1.MouseButton1Down
L8_1 = L7_1
L7_1 = L7_1.connect
function L9_1(...)
  local L1_2, L2_2, L3_2
  L2_2 = game.Players.LocalPlayer.Name
  L3_2 = ""
  L1_2 = ("Tank-") .. L2_2 .. L3_2
  arg = workspace.Tanks[L1_2]
  mytank = arg
  arg = 0.1
end
L7_1(L8_1, L9_1)
L7_1 = L4_1.MouseButton1Down
L8_1 = L7_1
L7_1 = L7_1.connect
function L9_1(...)
  local L1_2, L2_2, L3_2
  L2_2 = game.Players.LocalPlayer.Name
  L3_2 = ""
  L1_2 = ("Tank-") .. L2_2 .. L3_2
  arg = workspace.Tanks[L1_2]
  mytank = arg
  arg = 2000000000
end
L7_1(L8_1, L9_1)
L7_1 = L5_1.MouseButton1Down
L8_1 = L7_1
L7_1 = L7_1.connect
function L9_1(...)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = game.Players.LocalPlayer.Name
  L3_2 = ""
  L1_2 = ("Tank-") .. L2_2 .. L3_2
  arg = workspace.Tanks[L1_2]
  mytank = arg
  arg = mytank.AvailableAmmo
  L1_2 = arg
  arg = arg.GetChildren(L1_2)
  L1_2 = 1
  L2_2 = #arg
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = wait
    L6_2 = 0.1
    L5_2(L6_2)
    L6_2 = math.huge
    L5_2 = L6_2
  end
end
L7_1(L8_1, L9_1)
L7_1 = L6_1.MouseButton1Down
L8_1 = L7_1
L7_1 = L7_1.connect
function L9_1(...)
  local L1_2, L2_2, L3_2
  L2_2 = game.Players.LocalPlayer.Name
  L3_2 = ""
  L1_2 = ("Tank-") .. L2_2 .. L3_2
  arg = workspace.Tanks[L1_2]
  mytank = arg
  arg = 0.1
end
L7_1(L8_1, L9_1)
