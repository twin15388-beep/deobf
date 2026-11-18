--======================================================================
-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации
-- Игра/тема: blox_strike · Сэмпл: d0inks_router
-- Каталог:   deobf-report/results/blox_strike/d0inks_router/
-- Дата сборки: 2026-11-17 · Сгенерировано deobf-report/tools/build_combined.py
--
-- Состав (в этом порядке):
--   * PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии
--   * script.lua — ниже дословно (sha256=d05a87ac59bf892d4372a726bffffc8a8b151af3f58cace936ccb9c5ddd0d6a1)
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
-- # `d0inks_router` — функционал и механики
--
-- Игра/тема: **blox_strike** · восстановленный код: `script.lua` (11 строк)
--
-- ## Что делает (по восстановленному коду)
--
-- - **сеть / загрузка кода** — улики: `httpget`, `loadstring`
--
-- ## Вызовы API
--
-- - Методы: `HttpGet`×3, `loadstring`×3
--
-- ## Имена функций (0)
--
-- _имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), смысл восстанавливается по вызовам выше_
--
-- ## Строковые константы (UI, подписи)
--
-- - `Loaded Blox Strike`
-- - `Loaded Counter Blox`
-- - `Moon.lua Universal`
--
-- ## Ссылки / webhooks / ассеты (3)
--
-- - `https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/bloxstrike.lua`
-- - `https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/counterblox.lua`
-- - `https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/universal.lua`
--
-- ## Парты / объекты (9)
--
-- - идентификаторы в коде: `Blox`, `Counter`, `HttpGet`, `Loaded`, `Moon`, `PlaceId`, `Strike`, `Universal`, `d0inks`
--======================================================================
-- КОНЕЦ PARTS.md
--======================================================================
-- РАЗДЕЛ 2/2: восстановленный код (дословно)
--======================================================================
if game.PlaceId == 114234929420007 or game.PlaceId == 135434213652028 or game.PlaceId == 108194354348181 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/bloxstrike.lua"))() --bloxstrike
  print("Loaded Blox Strike")
elseif game.PlaceId == 301549746 or game.PlaceId == 1480424328 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/counterblox.lua"))() -- counterblox
  print("Loaded Counter Blox")
else
  loadstring(game:HttpGet("https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/universal.lua"))() --universal
  print("Moon.lua Universal")
  print("pls be aware some functions might not work depending on what game ur using.")
end
