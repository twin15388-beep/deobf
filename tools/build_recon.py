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
    ("ESP", "ouroboros_esp.lua"),
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
__CONST__
}
-- Значения, которые модули считают своими (источник — артефакт, строки 21156/21157/28566)
CONST["ARRIVE_RADIUS"] = CONST["ARRIVE_RADIUS"] or Move.bob["ARRIVE_RADIUS"]
CONST["BLINK_HOLD"]    = CONST["BLINK_HOLD"]    or Move.bob["BLINK_HOLD"]
CONST["REFUSAL_GAP"]   = CONST["REFUSAL_GAP"]   or (Skills.state and Skills.state["REFUSAL_GAP"])
CONST["CAST_GRACE"]    = CONST["CAST_GRACE"]    or Skills["CAST_GRACE"]
CONST["CAST_MIN_GAP"]  = CONST["CAST_MIN_GAP"]  or Skills["CAST_MIN_GAP"]
for _, key in ipairs({ "SLOT_NAMES", "CHEST_TIERS", "CHEST_GUARD_RANGE", "LOCKOUT_TAGS",
                       "PASSIVE_MOBS", "STAT_WEIGHTS", "POTION_NAMES", "HUNT_TIERS",
                       "BREATHINGS", "TRAINING_NAMES", "TRAINING_TIMEOUT" }) do
    if CONST[key] == nil and Core.constants[key] ~= nil then CONST[key] = Core.constants[key] end
end
CONST["PASSIVE_MOBS"] = CONST["PASSIVE_MOBS"] or {}

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
local REGISTRY = {}                              -- cKb[50]
local slotWarned = {}
-- Непрочитанный слот: вместо nil отдаём «цепную» заглушку, чтобы код не падал
-- сразу, а один раз предупредил и пошёл дальше (её можно вызвать и индексировать).
local slotWarned = {}
local function chain_stub(name)
    local obj = {}
    return setmetatable(obj, {
        __index = function(self, key)
            local child = chain_stub(name .. "." .. tostring(key))
            rawset(self, key, child)
            return child
        end,
        __call = function() return chain_stub(name .. "()") end,
        __tostring = function() return name end,
        __add = function() return 0 end, __sub = function() return 0 end,
        __lt = function() return false end, __le = function() return false end,
    })
end
local function missing_slot(key)
    if not slotWarned[key] then
        slotWarned[key] = true
        warn(("[Ouroboros] cKb[%s]: слот не вычитан из артефакта"):format(tostring(key)))
    end
    return chain_stub("cKb[" .. tostring(key) .. "]")
end

-- Публичный API (cKb[51]): сеттеры + трекер отмены перемещения.
local API = {}
API["Track"] = function(fn) return fn end

cKb = setmetatable({
    [3]   = chain_stub("cKb[3]"),                -- источник слотов квестов (не вычитан)
    [8]   = Farm.QuestStep,
    [9]   = function()                           -- персонаж: cKb[126]["Character"]
        local player = Core.Services.LocalPlayer
        return player and player["Character"]
    end,
    [13]  = function(condition, seconds)         -- ожидание условия (пул 4633/4512)
        local deadline = os.clock() + (seconds or 0)
        while os.clock() < deadline do
            if condition() then return true end
            task.wait(0.05)
        end
        return false
    end,
    [14]  = Parry.TrackModel,                    -- подписка на модель (cKb[14])
    [17]  = function()                       -- F3460: боевые пресеты доступны?
        return type(bno["CombatPresets"]) == "table"
    end,
    [34]  = Parry.state.presets,                 -- таблица пресетов боя (заполняет F3460)
    [108] = Parry.PresetFor,                     -- F3490: пресет по анимации
    [22]  = Farm.ChestStep,
    [23]  = 1110,                                -- интервал воркера экипировки
    [24]  = missing_slot(24),                    -- игровой объект скилла по имени
    [27]  = Equip.EquipSlot,
    [31]  = Equip.EquipWeapon,
    [36]  = Equip.Inventory,
    [37]  = Move.Detach,
    [38]  = function(key)                        -- фича включена? (UI-тумблеры)
        local toggle = Core.api and Core.api.toggles and Core.api.toggles[key]
        if toggle ~= nil then return toggle["Value"] == true end
        return true
    end,
    [42]  = missing_slot(42),                    -- ввод боя (cKb[51]["CombatInputs"])
    [41]  = function(values)                     -- F5356: «block» / «none» по playerValues
        if values == nil then return "none" end
        if type(values) ~= "table" then return "none" end
        local block = values["Blocking"] or values["block"]
        if block == nil then return "none" end
        return "block"
    end,
    [48]  = missing_slot(48),                    -- уровень игрока
    [50]  = REGISTRY,                            -- cKb[50]: записи подписок по моделям
    [51]  = API,
    [52]  = Farm.QuestSlotBusy,
    [54]  = Core.priority,
    [55]  = Equip.EquippedValue,
    [56]  = Core.priority,
    [58]  = Parry.EntryValid,                    -- F4381: вход блока годен
    [59]  = Regions,
    [60]  = Equip.EquippedByName,
    [61]  = Parry.CONFIG,
    [63]  = missing_slot(63),                    -- контейнер регионов
    [65]  = Parry.Scheduler,                     -- F3871: планировщик блоков (bm0)
    [64]  = function(value)                      -- CFrame-конструктор
        if typeof(value) == "CFrame" then return value end
        return CFrame.new(value)
    end,
    [69]  = Farm.TriggerPrompt,
    [75]  = nil,                                 -- хендл цикла сводок (F5182, ставится в Boot)
    [71]  = false,                               -- флаг анти-АФК
    [72]  = Combat.tweaks,
    [76]  = missing_slot(76),                    -- код задачи квеста
    [78]  = ESP.MarkModel,                       -- F4034: метка-подсветка модели
    [112] = ESP.DropMark,                        -- cKb[112]: снять метку модели
    [77]  = {                                    -- хелперы скиллов (cKb[77])
        owns = Skills.owns, claim = Skills.claim, held = Skills.held,
    },
    [81]  = Move.CONFIG,
    [83]  = Equip.EquipBest,
    [84]  = Farm.StartController,
    [86]  = Move.WaitReady,
    [87]  = Move.CancelMove,
    [91]  = Farm.controllers,
    [94]  = Farm.QuestRemove,
    [97]  = Move.SetCollide,
    [98]  = Farm.Count,
    [99]  = ESP.container,                       -- cKb[99]: settings (tweaks + viewer)
    [100] = function(...) return Core.Report(...) end,  -- доклад (Core.Report ставится при Boot)
    [102] = { EquipWeapon = Equip.EquipWeapon },
    [104] = Equip.ItemScore,
    [106] = missing_slot(106),                   -- обновление списка скиллов
    [107] = function() return Equip.EquippedValue() end,
    [110] = Farm.QuestData,
    [111] = Farm.SoulStep,
    [118] = function(v) return type(v) == "function" end,
    [119] = function(fn, ...) return pcall(fn, ...) end,
    [120] = Move.MoveTo,
    [122] = Parry.ValidNumber,                   -- проверка «валидное число»
    [128] = Parry.InReach,                       -- F853: дотягивается ли цель
    [143] = Parry.BeginBlock,                    -- боевой вход (S1839..S1857)
    [123] = missing_slot(123),                   -- module-таблица (playerValues и пр.)
    [124] = Move.GetHumanoid,
    [126] = Core.Services.LocalPlayer,
    [130] = function(key)                        -- перезапуск контроллера по ключу
        local controller = Farm.controllers[key .. "Controller"]
        if controller then Farm.StopController(controller); Farm.StartController(controller) end
    end,
    [131] = function() return Core.Services.LocalPlayer end,   -- Utility.GetData
    [132] = F853(Core.Services.LocalPlayer),
    [136] = POOL,                                -- строки пула
    [137] = Farm.QuestHolder,
    [138] = Farm.ClaimReadiness,
    [141] = CONST,
    [142] = Farm.QuestName,
    [145] = Move.GetRootPart,
    [4004] = function(seconds, fn) return task.delay(seconds, fn) end,
}, { __index = function(_, key) return missing_slot(key) end })

cKb[51]["BlockWork"] = Parry.state   -- bnl == cKb[51]["BlockWork"] (S2928)
cKb[50] = Parry.state.watched        -- cKb[50]: записи подписок по моделям
ESP.viewer["clear"] = ESP.ClearMarks -- bpp["clear"] = F1060
ESP.container["tweaks"] = Combat.tweaks         -- S752: cKb[99]["tweaks"] = cKb[72]

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
            Equip = Equip, Parry = Parry, Config = Config, UI = UI, ESP = ESP,
            slots = cKb }

-- Сеттеры, которые уже реализованы в модулях (ключ конфига → функция).
-- Они же попадают в публичный API cKb[51] — так же, как в артефакте.
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
    for name, fn in pairs(setters) do
        if cKb[51][name] == nil then cKb[51][name] = fn end
    end
    return setters
end

-- Тик: упрощённый драйвер над уже вычитанными шагами.
-- В артефакте это один общий цикл-машина (pc cKb[73], entry 3720), который ещё
-- не восстановлен; здесь шаги вызываются по Heartbeat и сами решают, положено ли
-- им работать (bnB + приоритет + флаги фич).
function M.StartSteps()
    if M._tick then return M._tick end
    M._tick = Core.Services.RunService.Heartbeat:Connect(function()
        if not Core.CanAct() then return end
        pcall(Combat.CombatTick)
        pcall(Skills.SkillStep)
        pcall(Parry.BlockTick)
        pcall(Equip.EquipStep)
    end)
    return M._tick
end

function M.StopSteps()
    if M._tick then M._tick:Disconnect() M._tick = nil end
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

    M.StartLoops()                     -- S2928 + S2052/S2056: фоновые циклы артефакта
    return { ui = ui, library = library }
end

-- ---------------------------------------------------------------------------
-- Фоновые циклы верхнего уровня (они и есть «тик» артефакта: у каждой фичи
-- свой воркер, запускаемый cKb[84](controller, step))
-- ---------------------------------------------------------------------------
function M.StartSummaryLoop()                        -- cKb[75] = task.delay(0, F5182)
    if M._summaryLoop then return M._summaryLoop end
    M._summaryLoop = task.delay(0, function()
        while bnB() do
            pcall(function()                         -- тело F5182
                if cKb[51]["PlayerSummary"] then
                    bpz["Summary"] = cKb[51]["PlayerSummary"]()
                end
                if cKb[51]["QuestSummary"] then
                    bpz["Quest"] = cKb[51]["QuestSummary"]()
                end
                if cKb[51]["BreathingCost"] then
                    bpz["CostText"] = cKb[51]["BreathingCost"]()
                end
            end)
            task.wait(1)                             -- F3916(1)
        end
    end)
    return M._summaryLoop
end

function M.StartLoops()
    M.StartSummaryLoop()
    Parry.StartScheduler()                           -- bnx = Heartbeat:Connect(F4910)
    ESP.StartOwnershipLoop(ESP.container)            -- bm8 = task.delay(0, F3841)
    return true
end

-- Автозапуск при загрузке исполнителем (как в артефакте).
-- Отключается флагом getgenv().OUROBOROS_NO_AUTORUN = true.
if type(game) == "table" and type(task) == "table" then
    local env = (type(getgenv) == "function" and getgenv()) or _G
    if not env["OUROBOROS_NO_AUTORUN"] then
        local http = (type(HttpGet) == "function") and HttpGet
            or function(url) return game:HttpGet(url) end
        local ok, err = pcall(function()
            M.Boot({ loadLibrary = true, HttpGet = http })
            M.StartSteps()   -- временный драйвер: пока не все воркеры восстановлены
        end)
        if ok then
            print("[Ouroboros] recon: UI собран; циклы сводок и парирования запущены, "
                .. "шаги — временным драйвером (воркеры cKb[84]/cKb[91] в работе)")
        else
            warn("[Ouroboros] recon: запуск не удался: " .. tostring(err))
        end
    end
end

return M
'''

BOOT_TAIL = ''


def lua_escape(text):
    """Строка -> тело Lua-литерала: экранируем кавычки, слэши и управляющие.

    В пуле артефакта есть значения с реальными управляющими символами
    (например [3189] = "\\n" — настоящий перевод строки), поэтому мало
    удвоить слэши: любой символ < 0x20 или 0x7F пишем как \\ddd.
    """
    out = []
    for ch in text:
        code = ord(ch)
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif code < 32 or code == 127:
            out.append("\\%03d" % code)       # \010, \013, \009 …
        else:
            out.append(ch)
    return "".join(out)


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
            value = '"%s"' % lua_escape(value)
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


def const_lua():
    """Литеральные константы cKb[141] из data/const_141.json -> поля Lua-таблицы."""
    import json
    data = json.load(open("data/const_141.json", encoding="utf-8"))
    lines = []
    for key in sorted(data):
        lines.append("    [%s] = %s," % ('"%s"' % key, data[key]))
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
    text = text.replace("__CONST__", const_lua())
    open("ouroboros_recon.lua", "w", encoding="utf-8").write(text)
    print("wrote ouroboros_recon.lua (%d bytes)" % len("\n".join(parts)))


if __name__ == "__main__":
    main()
