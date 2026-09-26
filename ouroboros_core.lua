--[[ ============================================================================
  Ouroboros — ЯДРО (общий каркас реконструкции)
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; номера строк — по ouroboros_main_pruned.txt.

  Зачем этот файл: модули (equip / parry / farm / skills / combat) написаны как
  читаемые порты, но каждый ссылался на общие таблицы (bno, bpz, cKb, bny,
  bn8, bnB…). Здесь эти таблицы собраны в одном месте и в правильном порядке,
  чтобы набор стал запускаемым каркасом, а не пятью отдельными файлами.

  ВАЖНО ПРО СЛОТЫ: в артефакте ДВЕ параллельные копии кода (сдвиг ~5.5 тыс.
  строк), и в них РАЗНЫЕ значения одних и тех же cKb[N]. Проверено:
      cKb[100]  -> в одной копии {...} с полями missing/asGameScript/playerValues,
                   в другой — F2979 (хелпер WaitForChild)
      cKb[118]  -> F1959 (= не выгружен) в одной, F5470 (= type(x)=="function") в другой
  Поэтому ниже слоты даны как КАРТА для сверки, а сам код использует именованные
  функции-обёртки. Это единственный способ не разъехаться с оригиналом.
============================================================================ ]]

local Core = {}

-- ---------------------------------------------------------------------------
-- 0. Служебные обёртки вызова (в артефакте — cKb[118]/F2175)
-- ---------------------------------------------------------------------------
-- F1959: return not cKb[51]["Unloaded"]        -- «скрипт загружен»
-- F5470: return type(R) == "function"          -- «это вызываемо»
-- F2175: pcall-обёртка вызова (защищённый вызов функции со аргументами)
local function Unloaded() return Core.api and Core.api["Unloaded"] end
local function CanAct() return not Core.api["Unloaded"] end
local function IsCallable(value) return type(value) == "function" end
local function Call(fn, ...) return pcall(fn, ...) end

-- Журнал отсутствующих зависимостей (в артефакте — cKb[100]["missing"])
local missing = {}
local function Report(name)                       -- cKb[100](name)
    missing[name] = (missing[name] or 0) + 1
    warn("[Ouroboros] missing/unavailable: " .. tostring(name))
    return false
end

-- ---------------------------------------------------------------------------
-- 1. СЕРВИСЫ (cKb[126], строка 3274) — точный список из артефакта
-- ---------------------------------------------------------------------------
local Services = {}
do
    local get = game.GetService
    for _, name in ipairs({
        "Players", "ReplicatedStorage", "RunService", "UserInputService", "VirtualUser",
        "HttpService", "GuiService", "CoreGui", "CollectionService", "TweenService",
        "TeleportService", "Lighting", "Workspace",
    }) do
        Services[name] = get(game, name)
    end
    Services.LocalPlayer = Services.Players.LocalPlayer      -- bmK
end

-- ---------------------------------------------------------------------------
-- 2. КЭШ ИГРОВЫХ МОДУЛЕЙ (bno) + загрузчик (cKb[42]/bpA)
--    Строка 26131: bno = cKb[42](bpA["Global"], {"Combat_presets"}, "Combat_presets module")
-- ---------------------------------------------------------------------------
local bno = {}
setmetatable(bno, { __index = function(t, key)
    if key == "Utility" then          -- bno["Utility"]["Tick"] — используется парированием
        return rawget(t, "__utility")
    end
    return nil
end })

local namespace = (type(getgenv) == "function" and getgenv()) or _G
bno["Global"] = namespace               -- корень, из которого растут модули

-- загрузчик: достаёт модуль по пути из namespace, кэширует и запоминает имя
local function LoadModule(root, path, label, optional)
    local node = root
    for _, part in ipairs(path) do
        node = node and node[part]
    end
    if type(node) ~= "userdata" and type(node) ~= "table" then
        if not optional then Report(label or table.concat(path, ".")) end
        return nil
    end
    local ok, module = pcall(require, node)
    if not ok then
        if not optional then Report(label or table.concat(path, ".")) end
        return nil
    end
    return module
end

-- ---------------------------------------------------------------------------
-- 3. СТАТУСЫ (bpz) — все ключи, которые пишет реконструкция
-- ---------------------------------------------------------------------------
local bpz = {
    -- подсистемы
    LootStatus = "Idle", ChestStatus = "Idle", SoulStatus = "Idle",
    QuestStatus = "Idle", AutoSkillStatus = "Idle", ParryStatus = "Idle",
    EquipStatus = "Idle", BossStatus = "Idle", MobStatus = "Idle",
    LevelStatus = "Idle", TrainStatus = "Idle", DungeonStatus = "Idle",
    CardStatus = "Idle", WaveStatus = "Idle", BringStatus = "Idle",
    SchematicStatus = "Idle", PriorityStatus = "Idle", PriorityHolder = "",
    -- счётчики
    Chests = 0, Looted = 0, Souls = 0, Quests = 0, Kills = 0,
    -- кэши/выборы
    SkillChoices = {},
}

-- ---------------------------------------------------------------------------
-- 4. КОНСТАНТЫ (cKb[141], строки 19690+ и 3320+)
-- ---------------------------------------------------------------------------
local CONST = {
    SLOT_NAMES = { "One", "Two", "Three", "Four", "Five" },
    CHEST_TIERS = { "T1", "T2", "T3" },
    CHEST_GUARD_RANGE = 220,
    HUNT_TIERS = { "Common", "UnCommon", "Rare", "Epic", "Legendary", "Mythic" },
    CAST_MIN_GAP = 0.2,
    CAST_GRACE = 6,
    TRAINING_TIMEOUT = 180,
    TRAINING_NAMES = { "Boulder Push", "Boulder Split", "Cup Game", "Meditation",
                       "Pushups", "Squat", "Target Shooting" },
    BREATHINGS = { "Flame", "Insect", "Sound", "Stone", "Thunder", "Water", "Wind" },
    LOCKOUT_TAGS = { "Stun", "CombatStun", "Strict_Stun", "KnockedOut",
                     "Swapping", "combatdisabled" },
    CARD_NAMES = { "AscendClan", "Clan", "Event", "ExtraLife", "Forge", "Fortune",
                   "Heal", "Points", "Potion", "Reroll", "Revive", "Skill" },
    HEAL_CARDS = { Heal = true },
    MUZAN_LAIR = Vector3.new(2466.3, 1079.33, 2334.51),
    PASSIVE_MOBS = {},            -- заполняется из игровых данных
}

-- ---------------------------------------------------------------------------
-- 5. АРБИТР ПРИОРИТЕТОВ (cKb[54], строка 57)
--    Поля из артефакта: active, preempt, settling, settle = 0.05, "or der",
--    rank, wants, commitments, holder, byKey, byLabel
-- ---------------------------------------------------------------------------
local priority = {
    active = false, preempt = true, settling = false, settle = 0.05,
    ["or der"] = {}, rank = {}, wants = {}, commitments = {},
    holder = nil, byKey = {}, byLabel = {},
    ownerRun = nil, lastClaim = {}, movementEpoch = 0,
}

local function labelOf(key)
    local entry = priority.byKey[key]
    return (entry and entry.label) or priority.byLabel[key] or tostring(key)
end

function priority.label(key) return labelOf(key) end

function priority.commit(key)                      -- cKb[54]["commit"]
    priority.wants[key] = true
    priority.byKey[key] = priority.byKey[key] or { key = key, label = labelOf(key) }
    return true
end

priority["do ne"] = function(key)                  -- cKb[54]["do ne"]
    priority.wants[key] = nil
    priority.commitments[key] = nil
    return true
end

function priority.uncommit(key)                    -- cKb[54]["uncommit"]
    priority.wants[key] = nil
    priority.commitments[key] = nil
    if priority.holder == key then priority.holder = nil end
    return true
end

function priority.blocked(key)                    -- cKb[54]["blocked"]
    for other in pairs(priority.commitments) do
        if other ~= key and priority.rank[other] and priority.rank[key]
        and priority.rank[other] < priority.rank[key] then
            return other
        end
    end
    return nil
end

function priority.turn(key)                        -- cKb[54]["turn"]
    priority.holder = key
    priority.active = true
    bpz["PriorityHolder"] = labelOf(key)
    bpz["PriorityStatus"] = "Running " .. labelOf(key)
    return true
end

function priority.claim(record)                    -- используется в шагах
    priority.ownerRun = record
    return true
end

-- ---------------------------------------------------------------------------
-- 6. РЕЕСТР ЗАПУСКОВ (bny, строки 1497/3176/3882)
-- ---------------------------------------------------------------------------
local bny = {
    runs = {},                                     -- bny["runs"][coroutine] = record
    cancelSkill = nil,                             -- bny["cancelSkill"] = F1204
    timing = nil,                                  -- bny["timing"](player) — из игры
    controllerValid = function(controller)
        return controller ~= nil and controller.running == true
           and controller.stopped ~= true
    end,
}

-- ---------------------------------------------------------------------------
-- 7. SIGNAL (bn8 = F651, строка 10990) — дословно
-- ---------------------------------------------------------------------------
local function Signal(name, ...)                   -- bn8
    if type(bno["SignalEvent"]) ~= "table" then
        Report("SignalEvent")
        return false
    end
    if not IsCallable(bno["SignalEvent"]["ToServer"]) then
        Report("SignalEvent.ToServer")
        return false
    end
    return Call(bno["SignalEvent"]["ToServer"], name, ...)
end

-- ---------------------------------------------------------------------------
-- 8. СЛОТ-КАРТА cKb — только для сверки с артефактом
-- ---------------------------------------------------------------------------
local SLOT_MAP = {
    api = "[51]  публичный API (201 запись, см. API_MAP.md)",
    priority = "[54]  арбитр приоритетов (init в строке 57)",
    constants = "[141] константы (CHEST_TIERS, SLOT_NAMES, CAST_*)",
    character = "[9]   локальный персонаж (F4555)",
    services = "[126] сервисы + LocalPlayer (F4885)",
    skills = "[77]  состояние скиллов (remaining/backoff/held/owns/retire/release)",
    module = "[81]  модуль (autoSkills)",
    controllers = "[91] реестр 24 контроллеров (LootController и др.)",
    tweaks = "[99]  боевые твики (killThreshold, instantKill, …)",
    schematics = "[91][\"SchematicRunner\"]  перенос деталей",
    looted = "[132] контейнер игровых объектов (drop/chest root)",
    bots = "[118]  см. предупреждение выше: в копиях разные функции",
}

-- ---------------------------------------------------------------------------
-- 9. ИНИЦИАЛИЗАЦИЯ: порядок из артефакта
--    (константы -> статусы -> сервисы -> кэш модулей -> арбитр -> контроллеры)
-- ---------------------------------------------------------------------------
function Core.init()
    Core.services = Services
    Core.bno = bno
    Core.bpz = bpz
    Core.constants = CONST
    Core.priority = priority
    Core.bny = bny
    Core.missing = missing
    Core.CanAct = CanAct
    Core.IsCallable = IsCallable
    Core.Report = Report
    Core.Signal = Signal
    Core.SLOT_MAP = SLOT_MAP
    Core.Unloaded = Unloaded

    -- игровые модули, к которым обращаются подсистемы
    bno["SignalEvent"] = LoadModule(namespace, { "Communication", "ServerAndClient",
                                                "Signals", "SignalEvent" }, "SignalEvent")
        or LoadModule(Services.ReplicatedStorage,
                      { "Communication", "ServerAndClient", "Signals", "SignalEvent" },
                      "SignalEvent")
    bno["Quests"] = LoadModule(namespace, { "Quests" }, "Quests", true)
    bno["CombatPresets"] = LoadModule(namespace, { "Combat_presets" }, "CombatPresets", true)
    bno["SkillRunner"] = LoadModule(namespace, { "SkillRunner" }, "SkillRunner", true)
    bno["Utility"] = LoadModule(namespace, { "Utility" }, "Utility", true)

    bpz["PriorityStatus"] = "Idle"
    return Core
end

-- ---------------------------------------------------------------------------
-- 10. ПОДКЛЮЧЕНИЕ МОДУЛЕЙ (после init)
--      Каждый модуль получает общие таблицы через этот же namespace:
--        local M = loadstring(...)()  -- или require(path)
--        M.bind(Core)
--      Ниже — примерная последовательность (в артефакте порядок иной, но
--      зависимости те же).
-- ---------------------------------------------------------------------------
function Core.bind(moduleTable)
    moduleTable.bno = bno
    moduleTable.bpz = bpz
    moduleTable.cKb = Core.cKb
    moduleTable.bny = bny
    moduleTable.priority = priority
    moduleTable.constants = CONST
    moduleTable.Signal = Signal
    moduleTable.CanAct = CanAct
    moduleTable.Report = Report
    return moduleTable
end

-- Публичный API (cKb[51]): флаг выгрузки + таблица тумблеров UI (aVS).
-- Раньше Core.api упоминался в Unloaded()/CanAct(), но нигде не создавался —
-- теперь он есть, и сборка может зарегистрировать в нём тумблеры из UI.
Core.api = { Unloaded = false, toggles = {} }

function Core.Bind(api)
    if type(api) ~= "table" then return Core.api end
    if api.toggles then Core.api.toggles = api.toggles end
    if api.Unloaded ~= nil then Core.api.Unloaded = api.Unloaded end
    return Core.api
end

Core.CanAct = CanAct        -- bnB: «скрипт загружен и может действовать»
Core.Unloaded = Unloaded

Core.Services = Services
Core.constants = CONST
Core.priority = priority
Core.bny = bny
Core.bpz = bpz
Core.bno = bno
Core.Signal = Signal
Core.missing = missing

return Core

--[[ ============================================================================
  НЕ ДОЧИТАНО (ядро):
  1. cKb[42] (bpA) — настоящий загрузчик модулей: как он ищет путь внутри
     namespace, что делает при отсутствии, и что такое bpA["Global"].
  2. Тела операций арбитра: commit/do ne/turn/blocked/uncommit реализованы по
     наблюдаемым полям (order/rank/wants/commitments/holder), но точная логика
     голосования и preempt не вычитана. Также не вычитан OnFarmClaim (cKb[51]).
  3. bny["timing"](player) — игровой модуль таймингов (используется шагом скиллов).
  4. Полный список модулей в bno: сейчас 5 подтверждённых (SignalEvent, Quests,
     CombatPresets, SkillRunner, Utility) + SignalFunction (по cKb[100]).
============================================================================ ]]
