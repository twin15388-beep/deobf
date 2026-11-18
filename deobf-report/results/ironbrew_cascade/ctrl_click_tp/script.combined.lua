--======================================================================
-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации
-- Игра/тема: ironbrew_cascade · Сэмпл: ctrl_click_tp
-- Каталог:   deobf-report/results/ironbrew_cascade/ctrl_click_tp/
-- Дата сборки: 2026-11-17 · Сгенерировано deobf-report/tools/build_combined.py
--
-- Состав (в этом порядке):
--   * PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии
--   * script.lua — ниже дословно (sha256=aa5b316c64713af004f32aeecb0819f3f8a3bb2517e650b0756dd29f943b4016)
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
-- # `ctrl_click_tp` — функционал и механики
--
-- Игра/тема: **ironbrew_cascade** · восстановленный код: `script.lua` (77 строк)
--
-- ## Что делает (по восстановленному коду)
--
-- - **телепорт / движение** — улики: `moveto`
-- - **анти-АФК / ввод** — улики: `inputbegan`
--
-- ## Вызовы API
--
-- - Сервисы: `Players`, `UserInputService`
-- - Методы: `GetService`×1, `MoveTo`×1, `GetMouse`×1
--
-- ## Имена функций (0)
--
-- _имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), смысл восстанавливается по вызовам выше_
--
-- ## Ссылки / webhooks / ассеты (0)
--
-- _нет_
--
-- ## Парты / объекты (16)
--
-- - идентификаторы в коде: `Button1Down`, `Character`, `Enum`, `GetMouse`, `GetService`, `Hit`, `InputBegan`, `InputEnded`, `KeyCode`, `Keyboard`, `LeftControl`, `LocalPlayer`, `MoveTo`, `RightControl`, `UserInputType`, `lbl_26`
--======================================================================
-- КОНЕЦ PARTS.md
--======================================================================
-- РАЗДЕЛ 2/2: восстановленный код (дословно)
--======================================================================
local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
arg = game.Players.LocalPlayer
L2_1 = arg
L2_1 = game
L3_1 = L2_1
L4_1 = "UserInputService"
L1_1 = arg.GetMouse(L2_1)
L4_1 = L1_1.Button1Down
L2_1 = L2_1.GetService(L3_1, L4_1)
L3_1 = false
L5_1 = L4_1
L4_1 = L4_1.connect
function L6_1(...)
  local L1_2, L2_2, L3_2
  arg = L3_1
  if not arg then
  else
    arg = arg.Character
    L1_2 = arg
    arg = arg.MoveTo
    L2_2 = L1_1.Hit.p
    arg(L1_2, L2_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = L2_1.InputBegan
L5_1 = L4_1
L4_1 = L4_1.connect
function L6_1(A0_2, A1_2, ...)
  local L3_2
  arg = A0_2.UserInputType
  L3_2 = Enum.UserInputType.Keyboard
  if arg == L3_2 then
    arg = A0_2.KeyCode
    L3_2 = Enum.KeyCode.LeftControl
    if arg == L3_2 then
      arg = true
      L3_1 = arg
    else
      arg = A0_2.KeyCode
      L3_2 = Enum.KeyCode.RightControl
      if arg ~= L3_2 then
      else
        arg = true
        L3_1 = arg
      end
    end
  end
end
L4_1(L5_1, L6_1)
L4_1 = L2_1.InputEnded
L5_1 = L4_1
L4_1 = L4_1.connect
function L6_1(A0_2, A1_2, ...)
  local L3_2
  arg = A0_2.UserInputType
  L3_2 = Enum.UserInputType.Keyboard
  if arg ~= L3_2 then
  else
    arg = A0_2.KeyCode
    L3_2 = Enum.KeyCode.LeftControl
    if arg ~= L3_2 then
    else
      arg = false
      L3_1 = arg
      goto lbl_26
    end
    arg = A0_2.KeyCode
    L3_2 = Enum.KeyCode.RightControl
    if arg == L3_2 then
      arg = false
      L3_1 = arg
    end
  end
  :: lbl_26 ::
end
L4_1(L5_1, L6_1)
