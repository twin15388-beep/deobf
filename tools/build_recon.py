"""Bundle the reconstruction modules into one runnable file: ouroboros_recon.lua.

Layout of the produced file:
    1. среда        — F-алиасы артефакта (pcall/pairs/ipairs/task/coroutine/…)
    2. ядро         — ouroboros_core.lua целиком
    3. общие таблицы— bno / bpz / bny / bnB / bn8 / bmK
    4. модули       — move / farm / skills / combat / equip / parry / config / ui
    5. слоты cKb    — таблица «слот → реализация» + предупреждение на неизвестный
    6. псевдонимы   — bmO/bmX/bqd/bqn/… (имена артефакта на наши функции)
    7. Boot/Start   — сборка UI, привязка сеттеров, запуск шагов

Usage: python3 tools/build_recon.py
"""
MODULES = [
    ("Core", "ouroboros_core.lua"),
    ("Move", "ouroboros_move.lua"),
    ("Farm", "ouroboros_farm.lua"),
    ("Skills", "ouroboros_skills.lua"),
    ("Combat", "ouroboros_combat.lua"),
    ("Equip", "ouroboros_equip.lua"),
    ("Parry", "ouroboros_parry.lua"),
    ("Config", "ouroboros_config.lua"),
    ("UI", "ouroboros_ui.lua"),
]

HEADER = '''--[[ ============================================================================
  Ouroboros — ЕДИНАЯ СБОРКА (ouroboros_recon.lua)
  ----------------------------------------------------------------------------
  СГЕНЕРИРОВАНО tools/build_recon.py из модулей репозитория. Не править вручную:
  правьте модуль и пересоберите (`python3 tools/build_recon.py`).

  Порядок частей повторяет порядок инициализации в артефакте:
    ядро → общие таблицы → модули → слоты cKb → псевдонимы → UI → шаги.
  Всё, что в артефакте опирается на непрочитанные тела (bnq/bpQ/bp9/bnn,
  cKb[3], cKb[59]/[63], bps, bnN, bnZ, bn_, bnc, bpd), здесь оформлено явной
  заглушкой, которая один раз предупреждает и возвращает nil/false — так сборка
  остаётся запускаемой и не врёт о своей полноте.

  Внешние зависимости (как в артефакте): библиотека ObsidianUltra
  (Library.lua + addons/*), getgenv/HttpGet/loadstring/setclipboard, Roblox.
============================================================================ ]]
'''

GLUE_HEAD = '''
-- ---------------------------------------------------------------------------
-- 1. СРЕДА: алиасы артефакта (F-имена) для модулей
-- ---------------------------------------------------------------------------
local function F2175(fn, ...) return pcall(fn, ...) end          -- pcall-обёртка
local function F2602(t) return pairs(t) end                      -- pairs
local function F4813(t) return ipairs(t) end                     -- ipairs
local function F3916(s) return task.wait(s) end                  -- task.wait
local function F4004(s, fn) return task.delay(s, fn) end         -- task.delay
local function F5473() return coroutine.running() end            -- coroutine.running
local function F6548(msg, level) return warn(tostring(msg)) end   -- warn с уровнем
local function F853(v) return (type(cloneref) == "function") and cloneref(v) or v end
local F6128, F3109, F1269 = task, coroutine, Enum
local F319, F3022, F670, F2998, F32 = TweenInfo, Vector3, CFrame, Color3, UDim2

local function stub(name)
    local warned = false
    return function(...)
        if not warned then
            warned = true
            warn(("[Ouroboros] %s: тело не вычитано из артефакта"):format(name))
        end
        return nil
    end
end
local function stub_false(name)
    local fn = stub(name)
    return function(...) fn(...) return false end
end
'''

GLUE_TAIL = '''
-- ---------------------------------------------------------------------------
-- 4b. ДАННЫЕ: строки пула cKb[136] (из data/pool_index.json) и константы
-- ---------------------------------------------------------------------------
local POOL = {
__POOL__
}
local CONST = {
    ARRIVE_RADIUS = Move.bob["ARRIVE_RADIUS"],
    BLINK_HOLD    = Move.bob["BLINK_HOLD"],
    REFUSAL_GAP   = Skills.state and Skills.state["REFUSAL_GAP"],
    CAST_GRACE    = Skills["CAST_GRACE"],
    CAST_MIN_GAP  = Skills["CAST_MIN_GAP"],
}

-- Источник списка регионов: cKb[59] (канонически — пул 1319; во второй сборке тот
-- же слот указывает на пул 2112, который читает LocalPlayer.Humanoids.Regions).
local function Regions()
    local player = Core.Services.LocalPlayer
    local base = player and player:FindFirstChild("Humanoids")
    base = base and base:FindFirstChild("Regions")
    local out = {}
    if not base then return out end
    for _, scene in ipairs(base:GetChildren()) do
        local npcs = scene:FindFirstChild("ActiveNpcs")
        if npcs then
            for _, folder in ipairs(npcs:GetChildren()) do
                out[#out + 1] = { region = scene["Name"], folder = folder }
            end
        end
    end
    return out
end

-- ---------------------------------------------------------------------------
-- 5. СЛОТЫ cKb: слот → реализация (каноническая карта, см. ROADMAP)
-- ---------------------------------------------------------------------------
local slotWarned = {}
cKb = setmetatable({
    [3]   = stub("cKb[3] (источник слотов квестов)"),
    [8]   = Farm.QuestStep,
    [9]   = Move.GetCharacter,
    [13]  = function(condition, seconds)                  -- пул 4633/4512
        local deadline = os.clock() + (seconds or 0)
        while os.clock() < deadline do
            if condition() then return true end
            task.wait(0.05)
        end
        return false
    end,
    [37]  = Move.Detach,
    [38]  = function(key)          -- фича включена? (UI-тумблеры aVS)
        local toggle = Core.api and Core.api["toggles"] and Core.api["toggles"][key]
        if toggle ~= nil then return toggle["Value"] == true end
        return true                -- без UI считаем фичу включённой
    end,
    [48]  = stub("cKb[48] (уровень игрока)"),
    [51]  = nil,                                          -- ставится ниже из шагов
    [52]  = Farm.QuestSlotBusy,
    [54]  = Core.priority,
    [56]  = Core.priority,
    [59]  = Regions,
    [63]  = stub("cKb[63] (контейнер регионов)"),
    [69]  = Farm.TriggerPrompt,
    [76]  = stub("cKb[76] (код задачи квеста)"),
    [81]  = Move.CONFIG,
    [84]  = stub("cKb[84] (проверка промпта)"),
    [86]  = Move.WaitReady,
    [87]  = Move.CancelMove,
    [91]  = Farm.controllers,
    [94]  = Farm.QuestRemove,
    [97]  = Move.SetCollide,
    [98]  = Farm.Count,
    [100] = Core.Report,
    [110] = Farm.QuestData,
    [118] = function(v) return type(v) == "function" end,
    [119] = function(fn, ...) return pcall(fn, ...) end,
    [120] = Move.MoveTo,
    [124] = Move.GetHumanoid,
    [126] = Core.Services.LocalPlayer,
    [132] = F853(Core.Services.LocalPlayer),
    [136] = nil,    -- таблица строк пула, ставится ниже (POOL)
    [137] = Farm.QuestHolder,
    [138] = Farm.ClaimReadiness,
    [141] = CONST,
    [142] = Farm.QuestName,
    [145] = Move.GetRootPart,
}, {
    __index = function(_, key)
        if not slotWarned[key] then
            slotWarned[key] = true
            warn(("[Ouroboros] cKb[%s]: слот не вычитан"):format(tostring(key)))
        end
        return nil
    end,
})

-- ---------------------------------------------------------------------------
-- 6. ПСЕВДОНИМЫ артефакта (имена, которыми модули зовут друг друга)
-- ---------------------------------------------------------------------------
bno, bpz, bny, bnB, bn8, bmK = Core.bno, Core.bpz, Core.bny, Core.CanAct, Core.Signal, Core.Services
bmO, bp3 = Farm.BeginAttempt, Farm.BeginAttempt
bmX = Farm.StopController
bpu = Farm.StartController
bqd = Move.Reach
bqn = Farm.CarryPart
bpY = function(key) return Core.priority["uncommit"](key) end
SchematicStep = Farm.SchematicStep
MobList = Combat.MobList
AntiAfk = Combat.AntiAfk
boo, bon = Combat.MobList, Combat.AntiAfk
Alive = Move.Alive
WaitReady = Move.WaitReady
TriggerPrompt = Farm.TriggerPrompt
boa = function(table_, key) return table_ ~= nil and table_[key] == true end
bnq, bpQ, bp9, bnn = stub("bnq (пробежка по задачам квеста)"),
                      stub("bpQ (взятие квеста)"),
                      stub("bp9 (готовность квеста)"),
                      stub("bnn (ожидание статуса)")
bnN, bnZ, bn_, bnc, bpd, bps = stub("bnN"), stub("bnZ"), stub("bn_"),
                               stub("bnc"), stub("bpd"), stub("bps")
F2092 = stub("F2092")
firetouchinterest = (type(getgenv) == "function" and getgenv() or _G).firetouchinterest or stub("firetouchinterest")

-- ---------------------------------------------------------------------------
-- 7. СБОРКА И ЗАПУСК
-- ---------------------------------------------------------------------------
local M = { Core = Core, Move = Move, Farm = Farm, Skills = Skills, Combat = Combat,
            Equip = Equip, Parry = Parry, Config = Config, UI = UI, slots = cKb }

-- Сеттеры, которые уже реализованы в модулях (ключ конфига → функция).
function M.Setters()
    local setters = {
        SetLootRange      = Farm.SetLootRange,
        SetSoulRange      = Farm.SetSoulRange,
        SetAutoLoot       = Farm.SetAutoLoot,
        SetAutoChest      = Farm.SetAutoChest,
        SetAutoSoul       = Farm.SetAutoSoul,
        SetKillThreshold  = Combat.SetKillThreshold,
        SetChestKillThreshold = Combat.SetChestKillThreshold,
        SetChestInstantKill   = Combat.SetChestInstantKill,
        SetInstantKill        = Combat.SetInstantKill,
        SetOwnershipRange     = Combat.SetOwnershipRange,
        SetOwnershipViewer    = Combat.SetOwnershipViewer,
        SetNoStun             = Combat.SetNoStun,
        SetNoRagdoll          = Combat.SetNoRagdoll,
        SetNoAttackSlowdown   = Combat.SetNoAttackSlowdown,
        SetNoSunDamage        = Combat.SetNoSunDamage,
        SetAutoEquip          = Equip.SetAutoEquip,
        SetAutoParry          = Parry.SetAutoParry,
    }
    return setters
end

-- Запуск: UI (если доступна библиотека) + авто-шаги, которые уже вычитаны.
function M.Boot(options)
    options = options or {}
    local services = Core.Services
    local library = options.library
    if not library and options.loadLibrary and services.HttpService then
        library = UI.LoadFile(UI.FILES.library, {
            HttpGet = options.HttpGet, wait = task.wait, warn = warn,
        })
    end
    M.library = library
    local ui
    if library then
        local handlers = M.Setters()
        ui = UI.Build(library, handlers)
        M.ui = ui
    end
    return { ui = ui, library = library }
end

return M
'''

BOOT_TAIL = ''


def pool_lua():
    """Строки пула cKb[136] -> компактная Lua-таблица (числа и строки)."""
    import json
    idx = json.load(open("data/pool_index.json", encoding="utf-8"))
    items = []
    for key, value in idx.items():
        if isinstance(value, dict):
            value = value.get("expr") or value.get("function")
            if value is None:
                continue
            value = value if len(value) <= 40 else None
        if isinstance(value, str):
            value = '"%s"' % value.replace("\\", "\\\\").replace('"', '\\"')
        elif isinstance(value, (int, float)):
            value = repr(value)
        else:
            continue
        items.append("[%s] = %s" % (key, value))
    lines, row = [], []
    for item in items:
        row.append(item)
        if len(row) == 6:
            lines.append("    " + ", ".join(row) + ",")
            row = []
    if row:
        lines.append("    " + ", ".join(row) + ",")
    return "\n".join(lines)


def read(path):
    return open(path, encoding="utf-8").read().rstrip() + "\n"


def main():
    parts = [HEADER, GLUE_HEAD]
    for name, path in MODULES:
        parts.append("\n-- ---------------------------------------------------------------------------\n"
                     "-- %s: %s\n"
                     "-- ---------------------------------------------------------------------------\n"
                     "local %s = (function()\n" % (name, path, name))
        parts.append(read(path))
        parts.append("end)()\n")
    parts.append(GLUE_TAIL)
    text = "\n".join(parts)
    text = text.replace("__POOL__", pool_lua())
    open("ouroboros_recon.lua", "w", encoding="utf-8").write(text)
    print("wrote ouroboros_recon.lua (%d bytes)" % len("\n".join(parts)))


if __name__ == "__main__":
    main()
