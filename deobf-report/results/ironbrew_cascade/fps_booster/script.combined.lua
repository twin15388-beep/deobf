--======================================================================
-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации
-- Игра/тема: ironbrew_cascade · Сэмпл: fps_booster
-- Каталог:   deobf-report/results/ironbrew_cascade/fps_booster/
-- Дата сборки: 2026-11-17 · Сгенерировано deobf-report/tools/build_combined.py
--
-- Состав (в этом порядке):
--   * PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии
--   * script.lua — ниже дословно (sha256=8a0ff18457ec3e746d25640ee765bf437db557522e7cab47c95dcb9f008a9a7a)
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
-- # `fps_booster` — функционал и механики
--
-- Игра/тема: **ironbrew_cascade** · восстановленный код: `script.lua` (37 строк)
--
-- ## Что делает (по восстановленному коду)
--
-- - явных механик по ключевым словам не найдено
--
-- ## Вызовы API
--
-- - Методы: `GetService`×1
--
-- ## Имена функций (0)
--
-- _имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), смысл восстанавливается по вызовам выше_
--
-- ## Строковые константы (UI, подписи)
--
-- - `UserGameSettings` ×2
-- - `Game Options`
--
-- ## Ссылки / webhooks / ассеты (0)
--
-- _нет_
--
-- ## Парты / объекты (27)
--
-- - идентификаторы в коде: `Enum`, `FindService`, `Game`, `GetService`, `Level01`, `LowResolution`, `Network`, `Options`, `QualityLevel`, `QualityLevel1`, `Rendering`, `SavedQualitySetting`, `UserGameSettings`, `UserSettings`, `VideoQualitySettings`, `boostAttempt`, `eagerBulkExecution`, `gameSettings`, `hasEverUsedVR`, `incommingReplicationLag`, `lagConfiguration`, `networkSettings`, `qualityLevel`, `renderSettings`, `savedQualityLevel`, `userGameSettings`, `videoQualitySetting`
--======================================================================
-- КОНЕЦ PARTS.md
--======================================================================
-- РАЗДЕЛ 2/2: восстановленный код (дословно)
--======================================================================
local L1_1, L2_1, L3_1
arg = (settings()).Network
networkSettings = arg
arg = (settings()).Rendering
renderSettings = arg
arg = (settings())["Game Options"]
gameSettings = arg
arg = UserSettings()
L1_1 = arg
L2_1 = "UserGameSettings"
arg = arg.FindService(L1_1, L2_1)
if arg then
else
  arg = UserSettings()
  L1_1 = arg
  L2_1 = "UserGameSettings"
  arg = arg.GetService(L1_1, L2_1)
end
userGameSettings = arg
L1_1 = Enum.QualityLevel.Level01
L1_1 = Enum.SavedQualitySetting.QualityLevel1
L1_1 = Enum.VideoQualitySettings.LowResolution
arg = true
lagConfiguration = arg
function arg(...)
  local L1_2
  L1_2 = lagConfiguration.qualityLevel
  L1_2 = lagConfiguration.savedQualityLevel
  L1_2 = lagConfiguration.videoQualitySetting
  L1_2 = lagConfiguration.eagerBulkExecution
  L1_2 = lagConfiguration.incommingReplicationLag
  L1_2 = lagConfiguration.hasEverUsedVR
  arg = L1_2
end
boostAttempt = arg
arg = boostAttempt
arg()
