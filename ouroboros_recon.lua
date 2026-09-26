--[[ ============================================================================
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


-- ---------------------------------------------------------------------------
-- Core: ouroboros_core.lua
-- ---------------------------------------------------------------------------
local Core = (function()

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
    inputs = {},                                   -- bny["inputs"][id] = owner (захваты ввода)
    releaseInput = nil,                            -- bny["releaseInput"](id, owner) — из арбитра
    session = nil,                                 -- bny["session"] = {controller=…} (активная сессия)
    stop = nil,                                    -- bny["stop"](session) — завершение сессии
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
Core.Report = Report        -- cKb[100]: доклад о недостающих зависимостях
Core.IsCallable = IsCallable

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

end)()


-- ---------------------------------------------------------------------------
-- Move: ouroboros_move.lua
-- ---------------------------------------------------------------------------
local Move = (function()

--[[ ============================================================================
  Ouroboros — ДВИЖОК ПЕРЕМЕЩЕНИЯ: арбитр `bob`, `Reach` (bqd), `MoveTo` (cKb[120])
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; номера строк — по ouroboros_main_pruned.txt.
  Всё вычитано из состояний, а не угадано; спорные места помечены в конце файла.

  Роли слотов (каноническая карта — заголовок второй сборки, см. ROADMAP):
    cKb[9]()    = персонаж (Character)
    cKb[124]()  = Humanoid        (пул 2170: cKb[9]():FindFirstChildOfClass("Humanoid"))
    cKb[145]()  = корневая часть  (пул 5863: HumanoidRootPart; если сам персонаж —
                                   BasePart, возвращается он)
    cKb[97](b)  = переключатель столкновений (inline, копия B @1 941 283):
                                   true  → вернуть сохранённые CanCollide
                                   false → выключить CanCollide у персонажа,
                                           запомнив прежние значения
    cKb[87]()   = отмена текущего перемещения (ниже CancelMove)
    cKb[37]()   = detach переносимой детали (bqn; bny["detach"])
    cKb[86](s)  = ожидание готовности (WaitReady; см. состояния 5671…5679)
    bqd         = Reach(цель, доп. пауза, отмена)
    cKb[120]    = MoveTo(цель, доп. пауза, отмена)
    bpm         = Alive() — пул 796
    bob         = {tween = nil, token = 0} + ARRIVE_RADIUS = 8, BLINK_HOLD = 0.35
    cKb[81]     = настройки: movementMode = "Tween", tweenSpeed = 400,
                  positionType = "Above", lookAtEnemy = true, offset = 3,
                  height = 0, weapon = "", autoSkills = false,
                  skills = {}, holdTimes = {}
    cKb[141]    = константы: ARRIVE_RADIUS = 8, BLINK_HOLD = 0.35 (стр. 21156)
============================================================================ ]]

local CONFIG = {
    positionType = "Above",
    lookAtEnemy = true,
    offset = 3,
    height = 0,
    movementMode = "Tween",       -- "Tween" | "Teleport"
    tweenSpeed = 400,
    weapon = "",
    autoSkills = false,
    skills = {},
    holdTimes = {},
}

-- Арбитр движения: у каждого «поколения» ходьбы свой token; тот, кто видит
-- чужой token, обязан немедленно сдаться (проверки в bqd/MoveTo повсюду).
local bob = {
    tween = nil,
    token = 0,
    ARRIVE_RADIUS = 8,            -- cKb[141]["ARRIVE_RADIUS"] = 8 (стр. 21156)
    BLINK_HOLD = 0.35,            -- cKb[141]["BLINK_HOLD"] = 0.35 (стр. 21157)
}

-- Персонаж: cKb[9] = пул 4555 (`cKb[126]["Character"]`)
local function GetCharacter()                        -- cKb[9]
    return cKb[9]()
end

-- Humanoid: cKb[124] = пул 2170
local function GetHumanoid()                         -- cKb[124]
    local character = cKb[9]()
    if not character then return nil end
    return character:FindFirstChildOfClass("Humanoid")
end

-- Корневая часть (или сам персонаж, если он BasePart): cKb[145] = пул 5863
local function GetRootPart()                         -- cKb[145]
    local character = cKb[9]()
    if not character then return nil end
    if character:IsA("BasePart") then return character end
    return character:FindFirstChild("HumanoidRootPart")
end

-- Жив ли персонаж: bpm = пул 796.
-- Опакованный предикат разрешён точно: для «Humanoid есть» сравнение
-- (1637*2317 + 1474*2351 + 1637*1474) % 16777213 == 9671241 истинно, поэтому
-- реальный код — `if humanoid then return GetRootPart() ~= nil end; return false`
-- (проверка Health > 0 вычисляется, но её результат отбрасывается).
local function Alive()                               -- bpm
    local humanoid = GetHumanoid()
    if humanoid then
        return GetRootPart() ~= nil
    end
    return false
end

-- Переключатель столкновений: cKb[97] (копия B @1 941 283; в копии A тот же
-- код лежит в слоте 145). Семантика выведена из состояний: bmV — карта
-- «часть → прежнее CanCollide».
local savedCollide = {}                              -- bmV (setmetatable({}, {__mode = "k"}))
local function SetCollide(enabled)                   -- cKb[97]
    if enabled then
        -- Возврат прежних значений: bmV = {часть → CanCollide}
        for part, was in pairs(savedCollide) do
            if part["Parent"] then
                pcall(function() part["CanCollide"] = was end)
                savedCollide[part] = nil
            end
        end
        return
    end
    -- Выключение: у всех BasePart персонажа запоминаем CanCollide и гасим его
    local character = cKb[9]()
    if not character then return end
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") and savedCollide[descendant] == nil then
            savedCollide[descendant] = descendant["CanCollide"]
            descendant["CanCollide"] = false
        end
    end
end

-- Отмена текущего перемещения: cKb[87] (стр. 3886).
--   token += 1 → все активные ходьбы считают себя устаревшими;
--   активный твин отменяется через pcall; у персонажа снимается Anchored
--   и возвращаются столкновения (cKb[97](false)); затем — «сброс управления».
local function CancelMove()                          -- cKb[87]
    bob["token"] = bob["token"] + 1
    if bob["tween"] then
        pcall(function() bob["tween"]:Cancel() end)
        bob["tween"] = nil
    end
    local part = GetRootPart()
    if part then
        pcall(function() part["Anchored"] = false end)
    end
    SetCollide(false)
end

-- Перенос детали: cKb[37] = bqn = bny["detach"] (стр. 20989). Перед началом
-- любой ходьбы переносимая деталь сбрасывается.
local function Detach()                              -- cKb[37]
    if bny["detach"] then bny["detach"]() end
end

-- Ожидание готовности: cKb[86](f8) — состояния 5671…5679, зеркало bvI,
--   deadline = os.clock() + (f8 or 20)   -- 5671/5678/5666
--   ready()  = bnB() and (нет записи запуска или controllerValid(controller))
--   loop:  если не ready() → false
--          если время вышло → вернуть bpm()
--          если bpm() → true; иначе task.wait(0.2) и снова
-- Замечание: в первой реконструкции здесь был простой дедлайн-цикл — это
-- исправлено по состояниям 5674/5677/5665: без bpm() ожидание не прекращается.
local function WaitReady(seconds)                     -- cKb[86]
    local record = bny["runs"][coroutine.running()]   -- F5473() = coroutine.running
    local function ready()
        if not bnB() then return false end
        if record and not bny["controllerValid"](record["controller"]) then
            return false
        end
        return true
    end
    local deadline = os.clock() + (seconds or 20)
    while true do
        if not ready() then return false end
        if os.clock() >= deadline then return Alive() end
        if Alive() then return true end
        task.wait(0.2)
    end
end

-- ---------------------------------------------------------------------------
-- MoveTo(hb, hc, hd) — cKb[120] (стр. 4370), зеркало bwg = 14945 - bwg.
--   hb = цель (Vector3), hc = доп. пауза после прибытия, hd = предикат отмены.
--   В отличие от Reach, здесь всегда «блинк»: корень ставится Anchored и
--   CFrame переставляется шагами не дольше BLINK_HOLD.
-- ---------------------------------------------------------------------------
local function MoveTo(target, waitSeconds, cancel)    -- cKb[120]
    if typeof(target) ~= "Vector3" then return false end          -- 14863
    local record = bny["runs"][coroutine.running()]                -- 14867
    local userCancel = cancel
    local aborted = function()
        if not bnB() then return true end
        if record and not bny["controllerValid"](record["controller"]) then
            return true
        end
        if userCancel then return userCancel() end
        return false
    end
    if aborted() then return false end                             -- 14841

    Detach()                                                       -- 14875
    CancelMove()
    local token = bob["token"]
    if not WaitReady(15) then return false end                     -- 14875/14859/14862
    if bob["token"] ~= token then return false end                 -- 14837

    local part = GetRootPart()                                     -- 14880
    if not part then return false end
    local distance = (target - part["Position"])["Magnitude"]      -- 14839
    if distance <= bob["ARRIVE_RADIUS"] then                       -- 14879
        if waitSeconds then task.wait(waitSeconds) end             -- 14871
        if aborted() then return false end                         -- 14850
        return bob["token"] == token                               -- 14852/14868
    end

    bob["token"] = bob["token"] + 1                                -- 14878
    token = bob["token"]
    local goal = Vector3.new(target)
    SetCollide(true)
    local humanoid = GetHumanoid()
    if humanoid then
        pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end)
    end

    local blinkUntil = os.clock() + bob["BLINK_HOLD"]              -- 14870
    part = nil
    while true do                                                  -- 14858
        if bob["token"] ~= token then return false end              -- 14876
        part = GetRootPart()                                       -- 14874
        if not part then break end                                 -- 14845
        if part["Anchored"] then                                   -- 14856
            pcall(function() part["Anchored"] = false end)         -- 14872
        end
        part["CFrame"] = goal                                      -- 14842
        part["AssemblyLinearVelocity"] = Vector3.zero
        part["AssemblyAngularVelocity"] = Vector3.zero
        task.wait()
        if os.clock() >= blinkUntil then break end                 -- 14873/14838
        if aborted() then break end                                -- 14843/14873/14848
    end

    if bob["token"] ~= token then return false end                 -- 14851/14849
    SetCollide(false)                                              -- 14840
    if waitSeconds then task.wait(waitSeconds) end                 -- 14869
    part = GetRootPart()                                           -- 14866
    local ok = not aborted()                                       -- 14850 → 14852
    if ok then ok = bob["token"] == token end
    if ok then ok = part ~= nil end                                -- 14853
    if ok then ok = (part["Position"] - target)["Magnitude"] < 25 end  -- 14860
    return ok
end

-- ---------------------------------------------------------------------------
-- Reach(go, gp, gq) — bqd (стр. 4013), зеркало bvZ = 11941 - bvZ.
--   go = цель (Vector3), gp = доп. пауза, gq = предикат отмены.
--   Два режима по cKb[81]["movementMode"]:
--     "Teleport" — Anchored + CFrame шагами по BLINK_HOLD (проход сквозь стены,
--                  столкновения выключены на время);
--     иначе      — TweenService:Create(... Linear/InOut, {CFrame = цель}) со
--                  скоростью clamp(tweenSpeed, 50, 1000) и длительностью
--                  clamp(путь / скорость, 0.05, 25).
-- ---------------------------------------------------------------------------
local function Reach(target, waitSeconds, cancel)     -- bqd
    if typeof(target) ~= "Vector3" then return false end           -- 11941
    local record = bny["runs"][coroutine.running()]                -- 11866
    local userCancel = cancel
    local aborted = function()
        if not bnB() then return true end
        if record and not bny["controllerValid"](record["controller"]) then
            return true
        end
        if userCancel then return userCancel() end
        return false
    end
    if aborted() then return false end                             -- 11939

    Detach()                                                       -- 11884
    CancelMove()
    local token = bob["token"]
    if not WaitReady(15) then return false end                     -- 11884/11871/11904
    if aborted() then return false end                             -- 11900
    if bob["token"] ~= token then return false end                 -- 11933

    local part = GetRootPart()                                     -- 11890
    if not part then return false end
    local distance = (target - part["Position"])["Magnitude"]      -- 11887
    if distance <= bob["ARRIVE_RADIUS"] then                       -- 11924
        if waitSeconds then task.wait(waitSeconds) end             -- 11908
        local ok = not aborted()                                   -- 11919
        if ok then ok = bob["token"] == token end                  -- 11921/11903
        return ok
    end

    bob["token"] = bob["token"] + 1                                -- 11909
    token = bob["token"]
    local goal = Vector3.new(target)
    SetCollide(true)                                               -- «сквозь стены»
    part["AssemblyLinearVelocity"] = Vector3.zero
    part["AssemblyAngularVelocity"] = Vector3.zero
    local humanoid = GetHumanoid()
    if humanoid then
        pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end)
    end

    local cancelledInTween = false                                 -- bvW
    if CONFIG["movementMode"] == "Teleport" then                   -- 11880/11893
        local blinkUntil = os.clock() + bob["BLINK_HOLD"]
        local moving = nil
        while true do
            if bob["token"] ~= token then return false end         -- 11905/11934
            moving = GetRootPart()                                 -- 11888
            if not moving then break end                           -- 11917
            if moving["Anchored"] then                             -- 11913
                pcall(function() moving["Anchored"] = false end)   -- 11940
            end
            moving["CFrame"] = goal                                -- 11910
            moving["AssemblyLinearVelocity"] = Vector3.zero
            moving["AssemblyAngularVelocity"] = Vector3.zero
            task.wait()
            if os.clock() >= blinkUntil then break end             -- 11878/11927/11926
            if aborted() then break end                            -- 11869
        end
    else
        -- Твин: корень Anchored, скорость clamp(50…1000), время clamp(0.05…25)
        part["Anchored"] = true                                    -- 11898
        local speed = math.clamp(CONFIG["tweenSpeed"], 50, 1000)
        local duration = math.clamp(distance / speed, 0.05, 25)
        local tween = bmK["TweenService"]:Create(                  -- F319["new"]
            part,
            TweenInfo.new(duration,
                Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            { CFrame = goal })
        bob["tween"] = tween
        tween:Play()
        local deadline = os.clock() + duration + 3
        while true do                                              -- 11930
            if not bnB() then break end                            -- 11915/11892/11874
            if os.clock() >= deadline then break end
            if bob["token"] ~= token then return false end          -- 11868
            if aborted() then cancelledInTween = true end           -- 11931/11923/11886/11882
            if tween["PlaybackState"] ~= Enum.PlaybackState.Playing then break end  -- 11876
            if GetRootPart() ~= part then break end                 -- 11914/11885
            task.wait(0.05)                                         -- 11889
        end
        if bob["token"] ~= token then return false end              -- 11870/11879
        if tween["PlaybackState"] == Enum.PlaybackState.Playing then
            pcall(function() tween:Cancel() end)                    -- 11935
        end
        bob["tween"] = nil                                          -- 11925
    end

    -- Общий хвост (11867): снять Anchored/скорость, вернуть столкновения,
    -- выждать gp, проверить отмену и расстояние (25 studs).
    if bob["token"] ~= token then return false end                  -- 11867/11920
    local finalPart = GetRootPart()                                 -- 11891
    if finalPart ~= nil then                                        -- 11911/11936
        pcall(function() finalPart["Anchored"] = false end)
        finalPart["AssemblyLinearVelocity"] = Vector3.zero
    end
    SetCollide(false)                                               -- 11881
    if cancelledInTween then return false end                       -- 11873
    if waitSeconds then task.wait(waitSeconds) end                   -- 11899/11938
    local ok = not aborted()                                        -- 11932
    if ok then ok = bob["token"] == token end                       -- 11895/11928
    if ok then ok = finalPart ~= nil end                            -- 11897
    if ok then ok = (finalPart["Position"] - target)["Magnitude"] < 25 end  -- 11902
    return ok                                                       -- 11918
end

-- Регистрация отмены в трекере ходьбы: `cKb[51]["Track"](cKb[87])` (стр. 3919).
-- cKb[51] — реестр задач движения; CancelMove попадает в него, чтобы общий
-- сброс (например, при выходе из меню) останавливал шаг.
local function TrackCancel(tracker, fn)               -- cKb[51]["Track"]
    tracker["Track"](fn or CancelMove)
end

return {
    bob = bob,
    CONFIG = CONFIG,
    GetCharacter = GetCharacter,
    GetHumanoid = GetHumanoid,
    GetRootPart = GetRootPart,
    Alive = Alive,
    SetCollide = SetCollide,
    CancelMove = CancelMove,
    Detach = Detach,
    WaitReady = WaitReady,
    MoveTo = MoveTo,
    Reach = Reach,
    TrackCancel = TrackCancel,
}

--[[ ============================================================================
  НЕ ДОЧИТАНО ЗДЕСЬ:
    * cKb[51] — сам реестр задач движения (в разных сборках слот 51 указывает на
      разные тела: пул 4619, таблицу {}, функцию(G,H) и т.д.). Здесь используется
      только контракт `["Track"](fn)`; полный разбор реестра — в UI/каркасе.
    * cKb[81] — таблица настроек: читается movementMode/tweenSpeed; остальные
      поля (positionType, lookAtEnemy, offset, height, weapon, skills, holdTimes)
      разбираются в подсистеме «подход к цели» (выше по стеку).
    * порядок проверок в теле SetCollide (внешний разбор веток true/false)
      восстановлен по опакованному предикату: du = true → ветка возврата,
      du = false → ветка выключения; микродетали внутренних машин опущены.
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- Farm: ouroboros_farm.lua
-- ---------------------------------------------------------------------------
local Farm = (function()

--[[ ============================================================================
  Ouroboros — подсистема ФАРМА (D): лут, сундуки, души, схематики, квесты
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau (пул cKb[136]); номера строк — по
  ouroboros_main_pruned.txt. Полная карта: data/D_MAP.md

  Стиль: поведенческая реконструкция 1:1. Порядок проверок восстановлен по
  состояниям S4165…S4214 (лут), S13715…S13740 (душа), S7535…S7566 (сундук),
  S14057…S14065 (квест). Всё, что не дочитано, помечено в конце файла.

  ВАЖНО (проверено трейсами): подбор идёт через ProximityPrompt, а не через
  SignalEvent — поэтому в трейсах v2/v3 при включённом AutoLoot не было ни
  одного события. Триггер промпта — cKb[69] ("fireproximityprompt").
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Общий каркас: реестр контроллеров (cKb[91], строки 34295..34317)
-- Рабочая таблица — cKb[91]; cKb[56] — легаси-двойник, сразу после
-- инициализации гасится: cKb[56] = false.
-- ---------------------------------------------------------------------------
local controllers = {
    LevelController    = { interval = 0.05, cancel = 0, priorityKey = "AutoLevel" },
    QuestController    = { interval = 0.05, quests = {}, cancel = 0, priorityKey = "AutoQuest" },
    HuntController     = { interval = 0.5,  tiers = {}, dropForeign = false, cancel = 0, priorityKey = "AutoBossHunt" },
    DeliveryController = { interval = 0.5,  cancel = 0, priorityKey = "AutoDelivery" },
    DemonController    = { interval = 0.5,  repMob = "Mizunoto", drink = true, dropForeign = false, cursor = 0, cancel = 0, priorityKey = "AutoDemon" },
    DungeonController  = { interval = 0.05, range = 250, cancel = 0, priorityKey = "AutoDungeon" },
    BringController    = { interval = 0.1,  range = 2000, cancel = 0 },
    CardController     = { interval = 0.5,  cards = {}, priority = {}, blockBareHands = true, forceHeal = false, healBelow = 40, cancel = 0 },
    WaveController     = { interval = 0.25, voted = false, cancel = 0 },
    MobController      = { interval = 0.05, target = "", cancel = 0, priorityKey = "AutoMob" },
    BossController     = { interval = 2,    bosses = {}, current = nil, waitName = nil, dwell = 0, skip = {}, cancel = 0, priorityKey = "AutoBoss" },
    ChestController    = { interval = 2,    tiers = {}, pending = false, cancel = 0, priorityKey = "AutoChest" },
    BreathController   = { interval = 2,    breathing = "", cancel = 0, priorityKey = "AutoBreathing" },
    TrainController    = { interval = 1,    codes = {}, mode = "Instantly", cursor = 0, TextColor3 = {}, cancel = 0, priorityKey = "AutoTraining" },
    SkillController    = { interval = 5,    nodes = {}, unlockSkills = false, cancel = 0 },
    EquipController    = { interval = 20,   cancel = 0 },
    PotionController   = { interval = 1,    potion = "", threshold = 40, cancel = 0, priorityKey = "AutoPotion" },
    ShopController     = { interval = 15,   items = {}, keep = 1, cancel = 0, priorityKey = "AutoBuy" },
    FishController     = { interval = 0.15, bait = "None", buyBait = false, cancel = 0, priorityKey = "AutoFish" },
    LootController     = { interval = 0.5,  range = 150, pending = false, awaitUntil = 0, cancel = 0, priorityKey = "AutoLoot" },
    SoulController     = { interval = 0.5,  range = 250, cancel = 0, priorityKey = "AutoSoul" },
    QueueController    = { interval = 2,    modes = {}, ranked = false, fill = false, cursor = 0, current = nil, cancel = 0 },
    WorldController    = { interval = 4,    world = "", privateOwner = "", cancel = 0 },
    CrystalController  = { interval = 20,   bundles = 99, reserve = 0, cancel = 0, priorityKey = "AutoBuyExp" },
}
controllers.controllers = controllers          -- cKb[91]["controllers"] = {все по списку}
controllers.opened  = setmetatable({}, { __mode = "k" })   -- что уже открыто
controllers.retryAt = setmetatable({}, { __mode = "k" })   -- кулдаун повторов
controllers.isOpened = function(part) return bn_ and bn_(part) end
controllers.SchematicRunner = { running = false }

-- ---------------------------------------------------------------------------
-- Лента приоритетов (cKb[91]["features"], строка 16125)
-- key / label / controller. Конфликтующие фичи гасятся арбитром.
-- ---------------------------------------------------------------------------
local FEATURES = {
    { key = "AutoBuy",      label = "Auto Buy",           controller = controllers.ShopController },
    { key = "AutoLevel",    label = "Auto Level",         controller = controllers.LevelController },
    { key = "AutoPotion",   label = "Auto Potion",        controller = controllers.PotionController, moves = false },
    { key = "AutoSoul",     label = "Auto Soul",          controller = controllers.SoulController },
    { key = "AutoDelivery", label = "Auto Delivery Quest",controller = controllers.DeliveryController },
    { key = "AutoBoss",     label = "Auto Boss",          controller = controllers.BossController },
    { key = "AutoLoot",     label = "Auto Loot",          controller = controllers.LootController },
    { key = "AutoChest",    label = "Sealed Cache",       controller = controllers.ChestController },
    { key = "AutoTraining", label = "Auto Training",      controller = controllers.TrainController },
    { key = "AutoBreathing",label = "Auto Breathing",     controller = controllers.BreathController },
    { key = "AutoBuyExp",   label = F2092,                controller = controllers.CrystalController },
    { key = "AutoFish",     label = "Auto Fishing",       controller = controllers.FishController },
}

-- ---------------------------------------------------------------------------
-- Арбитр приоритетов (cKb[54]): доступные операции, встречаются в шагах
-- ---------------------------------------------------------------------------
local priority = {
    commit  = function(key) return cKb[54]["commit"](key) end,          -- заявить фичу
    done    = function(key) return cKb[54]["do ne"](key) end,           -- закончить
    turn    = function(key) return cKb[54]["turn"](key) end,
    blocked = function(key) return cKb[54]["blocked"](key) end,
    label   = function(key) return cKb[54]["label"](key) end,
    uncommit= function(key) return cKb[54]["uncommit"](key) end,
}
-- cKb[54]["active"], ["settling"], ["byKey"], ["ownerRun"], ["holder"],
-- ["lastClaim"], ["movementEpoch"], ["PriorityStatus"], ["PriorityHolder"]

local function enabled(key) return cKb[38](key) end       -- фича включена?

-- ---------------------------------------------------------------------------
-- РАННЕР КОНТРОЛЛЕРОВ (bpu, строка 3127) — общий для всех фич фарма
--   bpu(controller, step): заводит «поколение», крутит step по интервалу,
--   держит запись в bny["runs"] и сам снимает приоритет по выходу.
-- ---------------------------------------------------------------------------
local function StartController(controller, step)          -- cKb[84] (F3818, copy 2)
    -- S10384/S10383/S10379: уже идёт и не остановлен — второй воркер не заводим
    if controller["workerActive"] and not controller["stopped"] then return end

    controller["workerActive"] = true                     -- S10385
    controller["generation"] = (controller["generation"] or 0) + 1   -- S10381/S10382
    controller["stopped"] = false
    local generation = controller["generation"]
    controller["startedAt"] = os.clock()
    controller["yield"] = false

    task.delay(0, function()                              -- F4004(0, тело)
        local runId = coroutine.running()                 -- F3109["running"]() = coroutine.running
        local record = { controller = controller, generation = generation }
        bny["runs"][runId] = record                       -- S1966

        while true do
            -- S1956/S1959/S1958: три условия продолжения
            if not (bnB() and not controller["stopped"]
                    and controller["generation"] == generation) then
                break
            end

            local ok, err = pcall(step)                   -- S1955

            if cKb[54]["ownerRun"] == record then          -- S1955 (хвост)
                bpY(controller["priorityKey"])             -- S1969: снять заявку
                if controller["generation"] == generation then      -- S1970
                    cKb[54]["do ne"](controller["priorityKey"])     -- S1967
                end
            end
            if not ok then                                 -- S1968 -> S1963
                warn("[Ouroboros] loop error:" .. tostring(err))
            end
            if not bnB() then break end                    -- S1977
            if controller["stopped"] then break end         -- S1954
            if controller["generation"] ~= generation then break end    -- S1953/S1972
            task.wait(controller["interval"])              -- S1975: F3916(AP["interval"])
        end

        bny["runs"][runId] = nil                           -- S1957
        if controller["generation"] == generation then      -- S1957
            controller["workerActive"] = false             -- S1960
        end
    end)
end

local function StopController(controller)                  -- bmX (F363, copy 2)
    controller["stopped"] = true                           -- S1083
    controller["yield"] = false
    controller["startedAt"] = nil
    controller["cancel"] = (controller["cancel"] or 0) + 1 -- S1074/S1075/S1076
    controller["generation"] = (controller["generation"] or 0) + 1      -- S1078/S1077
    controller["workerActive"] = false
    cKb[54]["do ne"](controller["priorityKey"], true)      -- арбитр: закрыть заявку силой
    cKb[54]["uncommit"](controller["priorityKey"])
    local session = bny["session"]                         -- S1080/S1082
    if session and session["controller"] == controller then
        bny["stop"](session)
    end
    if controller["priorityKey"] and cKb[54]["holder"] == controller["priorityKey"] then
        cKb[37]()                                          -- снять удержание блока/скилла
        cKb[87]()                                          -- CancelMove
        bpY(controller["priorityKey"], true)               -- S1085
    end
end


-- ---------------------------------------------------------------------------
-- Триггер промпта (cKb[69], строка 19540) — им берётся и лут, и сундуки, и души
-- ---------------------------------------------------------------------------
local function TriggerPrompt(prompt)                 -- cKb[69]
    -- cKb[118]: в этой копии артефакта — проверка type(x)=="function" (F5470);
    -- в другой копии тот же слот = F1959 «скрипт не выгружен». См. ouroboros_core.lua.
    if not cKb[118](fireproximityprompt) then
        cKb[100]("fireproximityprompt")
        return false
    end
    if not bnB() then return false end               -- действия разрешены?
    if not prompt:IsA("ProximityPrompt") then
        prompt = prompt:FindFirstChildWhichIsA("ProximityPrompt", true)
        if not prompt then return false end
    end
    if not prompt.Enabled then return false end
    return pcall(fireproximityprompt, prompt)
end

-- ---------------------------------------------------------------------------
-- ПОДГОТОВКА ПОПЫТКИ — bmO/bp3 (слот F5074; эти два имени в артефакте
-- указывают на один слот, поэтому совмещены)
-- ---------------------------------------------------------------------------
local function BeginAttempt(controller)          -- bmO(controller) / bp3(controller)
    controller["claim"] = nil
    controller["attempt"] = (controller["attempt"] or 0) + 1
    local attempt = controller["attempt"]
    return function()
        return not controller["cancelled"]
           and controller["attempt"] == attempt
           and controller["running"] == true
    end
end

-- ---------------------------------------------------------------------------
-- ОЖИДАНИЕ ГОТОВНОСТИ — cKb[86](seconds)  (строка 3928)
--   Ждёт, пока скрипт загружен (bnB) и запуск контроллера валиден, но не
--   дольше seconds. Возвращает true, если дождались.
-- ---------------------------------------------------------------------------
--   Точная логика (состояния 5671…5679): deadline = os.clock() + (секунды или 20);
--   цикл: не ready() → false; время вышло → вернуть bpm() (Alive: есть Humanoid и
--   корневая часть); bpm() → true; иначе task.wait(0.2) и снова.
local function WaitReady(seconds)                 -- cKb[86]
    local record = bny["runs"][coroutine.running()]
    local function ready()
        if not bnB() then return false end
        if record and not bny["controllerValid"](record["controller"]) then
            return false
        end
        return true
    end
    local function alive()                       -- bpm = пул 796
        local humanoid = cKb[124]()
        if humanoid then return cKb[145]() ~= nil end
        return false
    end
    local deadline = os.clock() + (seconds or 20)
    while true do
        if not ready() then return false end
        if os.clock() >= deadline then return alive() end
        if alive() then return true end
        task.wait(0.2)
    end
end

-- ---------------------------------------------------------------------------
-- ГОТОВНОСТЬ ДРОПА К ЗАХВАТУ — cKb[138] = F2668 (строка 14011)
--   Атрибуты: "DropReservedFor" (строка) и "DropOwnerUserId" (число).
-- ---------------------------------------------------------------------------
local function ClaimReadiness(drop)               -- cKb[138]
    local reserved = drop:GetAttribute("DropReservedFor")
    if type(reserved) ~= "string" then return true end
    local owner = drop:GetAttribute("DropOwnerUserId")
    if type(owner) == "number" and owner ~= cKb[126]["UserId"] then
        return false
    end
    return true
end

-- ---------------------------------------------------------------------------
-- ПРЕДИКАТ «МОЖНО ЗАБИРАТЬ» — состояния S4168…S4184
--   cKb[132] = cloneref(LocalPlayer) => IsDescendantOf(cKb[132]) = «уже у нас».
-- ---------------------------------------------------------------------------
local function Claimable(drop)
    if drop:IsDescendantOf(cKb[132]) then return false end
    local claimedBy = drop:GetAttribute("DropClaimedBy")
    if claimedBy ~= nil and claimedBy ~= cKb[126]["UserId"] then return false end
    return ClaimReadiness(drop)
end

-- ---------------------------------------------------------------------------
-- ПОДОЙТИ К ТОЧКЕ — bqd(position, eps, cancel)  (строка 4018)
--   Композиция отмены вычитана дословно: прерываемся, если not bnB(), или
--   невалиден запуск контроллера, или сработал внешний cancel.
--   Перемещение выполняет арбитр движения bob (token/поколение).
-- ---------------------------------------------------------------------------
local function MoveToTarget(character, position)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid:MoveTo(position) end
end

local function Reach(position, eps, cancel)       -- bqd
    local record = bny["runs"][coroutine.running()]
    local function aborted()
        if not bnB() then return true end
        if record and not bny["controllerValid"](record["controller"]) then return true end
        return cancel and cancel() or false
    end
    local character = cKb[9]()
    if not character then return false end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return false end

    local deadline = os.clock() + 10
    while os.clock() < deadline do
        if aborted() then return false end
        if (root["Position"] - position)["Magnitude"] <= (eps or 0.2) + 0.5 then
            return true
        end
        MoveToTarget(character, position)
        task.wait(0.05)
    end
    return false
end

-- ---------------------------------------------------------------------------
-- ЛУТ — шаг LootController: bnb(aBP, aBQ)  (строка 14014, состояния S4162…S4214)
--   aBP = объект дропа, aBQ = функция отмены/признак "ждать"
-- ---------------------------------------------------------------------------
local function LootStep(drop, cancel)
    local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt")      -- S4165
    if not prompt then return false end                                -- S4200

    local itemId = drop:GetAttribute("DropItemId")                     -- S4196
    local label = itemId or "loot"                                     -- S4166
    bpz["LootStatus"] = "Collecting " .. tostring(label)               -- S4167
    if not prompt.Enabled then                                         -- S4167 → S4199
        bpz["LootStatus"] = "Waiting for pickup readiness"
        return false
    end

    -- S4169/S4184: проверка «можно ли забирать»
    if not Claimable(drop) then
        -- S4213: подойти к дропу (смещение вверх на 3)
        local base = drop:IsA("BasePart") and drop
                  or drop:FindFirstChildWhichIsA("BasePart", true)
        if not base then return false end
        if not Reach(base["Position"] + Vector3.new(0, 3, 0), 0.2, cancel) then
            return false                                               -- S4198
        end
    end

    -- S4193/S4214: уважать retryAt записи попытки
    local record = controllers.LootController.attempts[drop]
    if record and record.retryAt and os.clock() < record.retryAt then
        return false
    end

    -- S4176/S4177: провал попытки → счётчик растёт, кулдаун по бэкоффу
    if not cKb[138](drop) then                                         -- cKb[138] = F2668
        record = record or { count = 0 }
        controllers.LootController.attempts[drop] = record
        record.count = record.count + 1
        record.retryAt = os.clock() + 2 + math.min(2 ^ math.min(record.count, 5), 30)
        return false
    end

    -- S4181..S4183: создать запись первой попытки
    record = controllers.LootController.attempts[drop] or { count = 0 }
    controllers.LootController.attempts[drop] = record

    -- S4184: дождаться, пока дроп либо отмечен забранным, либо исчез
    local waited = cKb[13](function()                                   -- wait-until, таймаут 2
        return drop:GetAttribute("DropClaimedBy") ~= nil
            or not drop:IsDescendantOf(cKb[132])
    end, 2, cancel)

    if drop:GetAttribute("DropClaimedBy") == cKb[126]["UserId"] then   -- S4171
        bpz["Looted"] = bpz["Looted"] + 1                              -- S4211
        bpz["LootStatus"] = "Collected " .. tostring(label)            -- S4209
        return true
    end

    if waited then                                                     -- S4173
        return false
    end

    if TriggerPrompt(prompt) then                                      -- S4186/S4189
        bpz["LootStatus"] = "Collected " .. tostring(label)
        return true
    end

    bpz["LootStatus"] = "Cannot take " .. tostring(label)              -- S4185
    return false
end

-- ---------------------------------------------------------------------------
-- ДУША — шаг SoulController: boc(aDC)  (строка 15938, состояния S13715…S13740)
--   aDC = { label = "...", point = Vector3, part = <Instance> }
-- ---------------------------------------------------------------------------
local function SoulStep(soul)
    local target = soul.part
    local part = target:IsA("BasePart") and target                        -- S13715
              or target:FindFirstChildWhichIsA("BasePart", true)          -- S13736
    if not part then return false end                                     -- S13719
    if part:IsDescendantOf(cKb[132]) then return false end                -- S13718/S13730

    local prompt = bnZ(target)                                            -- S13720 (bnZ = F892)
    if prompt then
        TriggerPrompt(prompt)                                             -- S13734 → S13729
    elseif cKb[118](firetouchinterest) then                               -- S13726/S13735
        F2175(firetouchinterest, part, target, 0)
        task.wait(0.1)                                                    -- F3916(0.1)
        F2175(firetouchinterest, part, target, 1)
    end

    -- S13729: подождать, пока цель не окажется «своей»
    local ok = cKb[13](function() return not target:IsDescendantOf(cKb[132]) end, 2, part)
    if ok then                                                            -- S13721
        return false
    end

    bpz["SoulStatus"] = "Collecting " .. soul["label"]                    -- S13731/S13733
    if not bqd(soul["point"] + Vector3.new(0, 3, 0), 0.2, part) then      -- S13724
        return false
    end

    bpz["Souls"] = bpz["Souls"] + 1                                       -- S13723
    bpz["SoulStatus"] = "Collected " .. soul["label"]
    return true
    -- иначе (S13722): bpz["SoulStatus"] = "Cannot take " .. soul["label"]; return false
end

-- ---------------------------------------------------------------------------
-- СУНДУК — controllers["open"](chest, statusKey, cancel)
--   (состояния S7535…S7566, строка 23125-ветка)
-- ---------------------------------------------------------------------------
function controllers.open(chest, statusKey, cancel)
    if chest:GetAttribute("ChestState") == "Locked" then                  -- S7536
        return false
    end
    if not chest:IsDescendantOf(cKb[132]) then return false end           -- S7535

    if not controllers.isOpened(chest) then                               -- S7539
        bpz[statusKey] = "Waiting for chest to unlock"
        cKb[13](function()                                                -- таймаут 4
            return not chest:IsDescendantOf(cKb[132])
                and chest:GetAttribute("ChestState") ~= "Locked"
        end, 4, cancel)
        if cancel() then return false end
    end

    bpz[statusKey] = "Opening chest"                                      -- S7561
    if not bqd(chest:GetPivot().Position + Vector3.new(0, 3, 0), 0.3, cancel) then
        -- S7547/S7563: не смогли подойти
        return false
    end

    cKb[13](function()                                                    -- таймаут 3
        return chest:GetAttribute("IsOpen") == true
            or not chest:IsDescendantOf(cKb[132])
    end, 3, cancel)

    if chest:GetAttribute("IsOpen") == true or not chest:IsDescendantOf(cKb[132]) then
        controllers.opened[chest] = true                                  -- S7542
        bpz["Chests"] = bpz["Chests"] + 1
        bpz[statusKey] = "Chest opened"
        return true
    end
    return false
end


-- ---------------------------------------------------------------------------
-- СУНДУК — шаг контроллера: bpL (строка 13460)
--   Константы: cKb[141]["CHEST_TIERS"] = {"T1","T2","T3"}, CHEST_GUARD_RANGE = 220,
--   cKb[141]["PASSIVE_MOBS"][name] — мобы, которых охрана не считает охраной.
-- ---------------------------------------------------------------------------
local function ChestStep()                                -- bpL
    if not bnB() then
        controllers.ChestController.pending = false
        return
    end
    bmO(controllers.ChestController)                      -- снять прошлый claim
    local list = bps()                                    -- заспавненные sealed caches
    controllers.ChestController.pending = #list > 0
    if #list == 0 then
        bpz["ChestStatus"] = "No sealed cache spawned"
        return
    end
    if not enabled("AutoChest") then return end
    warn("[Ouroboros] chest step:" .. tostring(list))

    -- ждём готовности контроллера (не больше 20 с)
    if not cKb[86](20) then
        bpz["ChestStatus"] = "Waiting for character"
        return
    end

    local cancel = function() return controllers.ChestController.cancel ~= nil end
    while true do
        if not bny["controllerValid"](controllers.ChestController) then return end
        list = bps()
        if #list == 0 then
            bpz["ChestStatus"] = "No sealed cache spawned"
            return
        end

        -- охрана: ни один живой непassive-моб не должен быть ближе CHEST_GUARD_RANGE
        -- (bWZ — сохранённая позиция последнего выбранного сундука, как в артефакте)
        local guardOrigin = bWZ or (cKb[9]() and cKb[9]():GetPivot().Position) or Vector3.zero
        local clear = bnN(function(mob)
            return not cKb[141]["PASSIVE_MOBS"][mob["name"]]
                and (mob["model"]:GetPivot().Position - guardOrigin).Magnitude
                    <= cKb[141]["CHEST_GUARD_RANGE"]
        end)
        if not clear then
            bpz["ChestStatus"] = "Waiting for guards"
            task.wait(1)
        else
            -- берём ближайший сундук
            local origin = bWY or Vector3.zero
            table.sort(list, function(a, b)
                return (a["model"]:GetPivot().Position - origin).Magnitude
                     < (b["model"]:GetPivot().Position - origin).Magnitude
            end)
            local chest = list[1]
            local model = chest["model"]
            bWZ = model:GetPivot().Position

            if model:GetAttribute("ChestState") == "Locked" then
                bpz["ChestStatus"] = "Clearing " .. chest["tier"] .. " guards"
                bqd(bWZ + Vector3.new(0, 5, 0), 0.4, cancel)      -- подойти
                local deadline = os.clock() + 180                 -- 3 минуты на зачистку
                while os.clock() < deadline do
                    if not bny["controllerValid"](controllers.ChestController) then return end
                    if model:GetAttribute("ChestState") ~= "Locked" then break end
                    task.wait(0.05)
                end
            else
                bp3(model, "ChestStatus", 120, controllers.ChestController,
                    function()
                        return not model:IsDescendantOf(cKb[132])
                            or model:GetAttribute("ChestState") ~= "Locked"
                    end)
                task.wait(0.05)
            end

            controllers["open"](model, "ChestStatus", cancel)     -- S7535…S7566
        end
        bpY("AutoChest")
        task.wait(0.05)
    end
end

-- ---------------------------------------------------------------------------
-- СХЕМАТИКИ — bqn(fz, fA) (строка 20991)
-- ---------------------------------------------------------------------------
-- Раннер схем атик: cKb[91]["SchematicRunner"] = {running, cancel, ret, targets}
-- (строка 27643). Обёртки из API (F3068/F2545):
--   CollectSchematics() -> return select(2, SchematicRunner.start())
--   StopSchematics()    -> SchematicRunner.stop(); return bpz["SchematicStatus"]
controllers.SchematicRunner = controllers.SchematicRunner
    or { running = false, cancel = 0, ret = true, targets = {} }

function controllers.SchematicRunner.start()
    if controllers.SchematicRunner.running then
        bpz["SchematicStatus"] = "Already collecting schematics"
        return false
    end
    bpz["SchematicStatus"] = "Collecting schematics"
    controllers.SchematicRunner.running = true
    local collected = 0
    -- targets = выбранные имена схем атик (SetSchematicTargets = F1267),
    -- возврат домой — SetSchematicReturn (F2078)
    while controllers.SchematicRunner.running do
        -- схем атика — физическая деталь: bqn(part, owner) подтаскивает её к игроку
        local part, owner = nil, nil
        if part then bqn(part, owner) end
        collected = collected + 1
        task.wait(0.1)
    end
    bpz["SchematicStatus"] = string.format("Stopped after %d collected", collected)
    return true
end

function controllers.SchematicRunner.stop()
    controllers.SchematicRunner.running = false
    controllers.SchematicRunner.cancel = controllers.SchematicRunner.cancel + 1
    return true
end

-- bqn(part, owner): перенос детали — анкорит, тянет к игроку, гасит скорость
local function CarryPart(part, owner)                     -- bqn (строка 20991)
    if not part:IsA("BasePart") then return false end
    local carry = bmZ                                       -- состояние переноса
    if carry["owner"] == owner then return carry["connection"] end
    carry["part"], carry["owner"] = part, owner
    if part["Anchored"] then
        -- отпускаем: снимаем анкор и даём упасть
        F2175(function() part["Anchored"] = false end)
    end
    local target = cKb[64](part)                            -- целевой CFrame
    carry["connection"] = bmK["RunService"]["Heartbeat"]:Connect(function()
        if not bnB() then return end
        if owner and not owner.valid() then return end
        part["CFrame"] = cKb[64](target)
        part["AssemblyLinearVelocity"] = Vector3.new(0, -8, 0)
        part["AssemblyAngularVelocity"] = Vector3.zero
    end)
    return carry["connection"]
end

-- ---------------------------------------------------------------------------
-- КВЕСТЫ — шаг QuestController: bpn
--   В копии B — inline (смещение 1 660 803), в копии A слот bpn = пул-функция
--   6279. Рендер: ouroboros_main_pruned.txt, строка 23850.
-- ---------------------------------------------------------------------------
-- Управляющая машина (вход pc=14066, зеркало bMR = 14066 - bMR), 1:1:
--   14066  bMP = not bnB()                     -- модуль выгружен?
--   14060  if bMP -> return
--   14061  bMP = cKb[98](quests) == 0          -- квестов нет -> return
--   14062  cKb[54]["commit"]("AutoQuest"); if not cKb[38]("AutoQuest") -> return
--   14065  bMP, bMQ = pcall(<тело>); bpY("AutoQuest")
--          if not bMP -> warn("[Ouroboros] quest step: " .. tostring(bMQ))
-- Тело pcall (вход pc=3512, зеркало bMx = 3518 - bMx):
--   3512  if not cKb[86](20) -> bpz["QuestStatus"] = "Waiting for character"; return
--   3511  bMq = {}; for D4 in pairs(quests) do bMq[#bMq+1] = D4 end
--         table.sort(bMq); bMr = <аксессор имени>; bMs = cKb[137]()
--         for Ed, Ee in ipairs(bMq) do <машина bMFA, вход 7>; if bMG then break end end
--         bMs = cKb[52]();  bMs -> 3514, иначе 3518
--   3514  bMt = cKb[110](bMs); bpz["QuestStatus"] = "Clearing quest slot"
--         cKb[94](bMr(bMt, bMs)); return
--   3518  bMr = boW();  bMr > 0 -> 3516, иначе 3517
--   3516  cKb[54]["uncommit"]("AutoQuest")
--         bpz["QuestStatus"] = string.format("Quest cooldown %ds", math.ceil(bMr)); return
--   3517  <машина bMFB, вход 4>; cKb[54]["uncommit"]("AutoQuest")
--         bpz["QuestStatus"] = "Cannot take a selected quest"
--
-- Машина bMFA — первая петля по квестам (вход 7), состояния 1:1:
--   7  QuestController.stopped -> 3 (return)
--   18 bMt = cKb[110](bMK); bMp = bMr(bMt, bMK); bMu = bMs
--   10 bMu = bMs:FindFirstChild(bMp)
--   11 bMu -> 20, иначе 13 (пустой квест — дальше)
--   20 bMu, bMw, bMv = bnq(bMK, "QuestStatus", QuestController)
--      bMv (квест снят) -> 2;  bMw (пора сдавать) -> 14;  иначе 17
--   2  bpz["QuestStatus"] = "Dropping stuck " .. cKb[142](bMK); cKb[94](bMp); return
--   14 bpz["QuestStatus"] = "Handing in " .. cKb[142](bMK)
--      bMu = cKb[13](<ждём, пока Holder:FindFirstChild(имя) == nil>, 6)
--      bMu -> 12, иначе 0
--   12 bMt = bMu;  bMt -> 4, иначе 19
--   4  bpz["Quests"] = bpz["Quests"] + 1; bpz["QuestStatus"] = "Finished " .. cKb[142](bMK)
--   5  -> 17 (return)
--   0  bMu = bnn(bMt, bMp, "QuestStatus", QuestController) -> 12
--   19 bMt = not QuestController["yield"];  bMt -> 8, иначе 15
--   8  bMt = not QuestController["stopped"]; -> 15
--   15 bMt -> 16, иначе 21
--   16 cKb[54]["uncommit"]("AutoQuest") -> 21
--   21 bpz["QuestStatus"] = "Cannot hand in " .. cKb[142](bMK); -> 5 (return)
--   13 (пусто -> 9) и 9 — конец итерации;  1 bMG = true (break внешней петли)
--
-- Машина bMFB — петля «взять квест» (вход 4):
--   4  QuestController.stopped -> 6 (return), иначе 8
--   8  bMq = cKb[110](bMO); bMr = bMq;  bMr -> 7, иначе 3
--   7  bMr = bp9(bMq) -> 3
--   3  bMr -> 1, иначе 9 (дальше)
--   1  bpz["QuestStatus"] = "Accepting " .. cKb[142](bMO)
--      bpQ(bMO, QuestController, "QuestStatus") -> 10 (return), иначе 0 -> 9
--   9  -> 2 (конец петли);  5 bMG = true;  2 break;  6/10 return
-- После петли: cKb[54]["uncommit"]("AutoQuest"); "Cannot take a selected quest".
--
-- Константы (проверены по пулу): 4656="QuestStatus", 868="QuestController",
-- 4265="quests", 3464="stopped", 4610="yield", 3287="Quests", 3546="AutoQuest",
-- 5499="Dropping stuck ", 6229="Finished ", 6062="Handing in ",
-- 2414="Cannot hand in ", 4554="Accepting ", 150="Cannot take a selected quest",
-- 3142="Waiting for character", 3184="Clearing quest slot",
-- 5289="Quest cooldown %ds", 6259="[Ouroboros] quest step: ".
-- ---------------------------------------------------------------------------

-- ВАЖНО про слот-карты (проверено 26.09): в артефакте несколько карт слотов.
-- Одна и та же строка кода встречается дважды с ОДИНАКОВЫМИ номерами слотов
-- (сверено: копия @1 192 023 `cKb[8] = function()` и копия @1 660 803 `bpn`),
-- но заголовки сборок привязывают слоты к РАЗНЫМ пул-функциям. Канонической
-- (самосогласованной для этого кода) является карта из заголовка второй сборки:
--   98 → пул 1968 (счётчик), 110 → пул 615 (запись квеста),
--   137 → пул 931 (Quests.Holder), 142 → пул 774 (имя/tostring),
--   94 → пул 2280 (RemoveQuest + 0.5 c), 52 → пул 429 (questString),
--   13 → пул 4633/4512, 86 → ожидание готовности.
-- В первой сборке те же слоты местами указывают на другое (98 → пул 363 —
-- это НЕ счётчик, а отмена контроллера: Ba["cancel"], Ba["generation"],
-- cKb[54]["do ne"]/["uncommit"]). Поэтому реализации ниже выписаны по
-- канонической карте; см. также out/pool_perm.json (перестановка пула) и
-- ROADMAP «Известные ловушки».

-- Счётчик элементов таблицы: cKb[98] = пул 1968 (каноническая карта):
--   local n = 0; for _ in pairs(t) do n = n + 1 end; return n
local function count(container)
    local n = 0
    for _ in pairs(container) do n = n + 1 end
    return n
end

-- Запись квеста: cKb[110] = пул 615 (коп. B) / 5-арг. inline (смещение 2 114 855)
--   bno["Quests"]["Holder"][id]; при отсутствии bno["Quests"] или .Holder
--   вызывается cKb[100]("Quests.Holder") и возвращается nil.
local function QuestData(questId)                     -- cKb[110]
    if type(bno["Quests"]) ~= "table" then
        cKb[100]("Quests.Holder")
        return nil
    end
    if type(bno["Quests"]["Holder"]) ~= "table" then
        cKb[100]("Quests.Holder")
        return nil
    end
    return bno["Quests"]["Holder"][questId]
end

-- Имя квеста или tostring: cKb[142] = пул 774 (коп. B) / 5-арг. inline (2 119 745).
-- Вычитано дословно: bFg = cKb[110](ut); если type(bFg)=="table" и
-- typeof(bFg["QuestInstance"])=="Instance" -> bFg["QuestInstance"]["Name"],
-- иначе tostring(ut).
local function QuestName(questId)                     -- cKb[142]
    local data = QuestData(questId)
    if type(data) == "table" and typeof(data["QuestInstance"]) == "Instance" then
        return data["QuestInstance"]["Name"]
    end
    return tostring(questId)
end

-- Аксессор имени с запасным значением — bMr (состояния 15077…15084):
--   D6 — запись квеста, D7 — запасное имя. D6["QuestInstance"]["Name"] если
--   typeof(...)=="Instance", иначе D7.
local function QuestNameOr(data, fallback)            -- bMr
    if type(data) == "table" and typeof(data["QuestInstance"]) == "Instance" then
        return data["QuestInstance"]["Name"]
    end
    return fallback
end

-- Держатель квестов: cKb[137] = пул 931 (коп. A; в коп. A позже перепривязан
-- к пулу 4555 = LocalPlayer.Character — см. заметку ниже).
-- Пул 931: btr = cKb[131]() -> :FindFirstChild("Quests") -> :FindFirstChild("Holder"),
-- с проверками на nil на каждом шаге.
local function QuestHolder()                          -- cKb[137]
    local node = cKb[131]()                           -- Utility.GetData(LocalPlayer)
    if not node then return nil end
    local quests = node:FindFirstChild("Quests")
    if not quests then return nil end
    return quests:FindFirstChild("Holder")
end

-- Снять квест: cKb[94] = пул 2280 (коп. B; в коп. A — inline, смещение 1 124 747).
-- Вычитано дословно: bn8(пул[1299], name); task.wait(0.5).
--   пул[1299] — строка "RemoveQuest" ПОСЛЕ перестановки пула (до неё — 527),
--   bn8 = отправка сигнала на сервер (см. ouroboros_core.lua).
local function QuestRemove(playerQuestName)           -- cKb[94]
    bn8("RemoveQuest", playerQuestName)
    task.wait(0.5)
end

-- Кулдаун квестов — boW = пул 1412 (состояния 14757…14778). Вычитано дословно:
--   если type(bno["Quests"]) ~= "table" -> 0
--   bLz = cKb[131]() (Utility.GetData(LocalPlayer)); нет -> 0
--   bLz = bLz:FindFirstChild("Quests"); нет -> 0
--   bLz = bLz:FindFirstChild("LastTime"); нет -> 0
--   если type(bno["Utility"]) ~= "table" -> 0
--   если cKb[118](bno["Utility"]["Tick"]) == false -> 0
--   ok, tick = cKb[119](bno["Utility"]["Tick"]); если not ok -> 0
--   если not tonumber(tick) -> 0
--   cd = tonumber(bno["Quests"]["QuestCD"]) или 30
--   return math.max(0, cd - (tick - LastTime.Value))
local function QuestCooldown()                        -- boW
    if type(bno["Quests"]) ~= "table" then return 0 end
    local node = cKb[131]()
    if not node then return 0 end
    node = node:FindFirstChild("Quests")
    if not node then return 0 end
    local stamp = node:FindFirstChild("LastTime")
    if not stamp then return 0 end
    if type(bno["Utility"]) ~= "table" then return 0 end
    if not cKb[118](bno["Utility"]["Tick"]) then return 0 end
    local ok, tick = cKb[119](bno["Utility"]["Tick"])
    if not ok or not tonumber(tick) then return 0 end
    local cooldown = tonumber(bno["Quests"]["QuestCD"]) or 30
    return math.max(0, cooldown - (tick - stamp["Value"]))
end

-- Квест, лежащий в слоте — cKb[52] = пул 429 (коп. B; в коп. A — inline, 1 278 022).
-- Вычитано дословно: bFM = cKb[3](); bFN = bFM[1]; если nil -> nil;
-- иначе bFN[1]["questString"].
local function QuestSlotBusy()                        -- cKb[52]
    local list = cKb[3]()
    local first = list and list[1]
    if not first then return nil end
    return first[1]["questString"]
end

-- Ожидание условия с таймаутом — cKb[13] = пул 4633 (коп. A) / пул 4512 (коп. B).
-- Контракт вычитан из вызова: cKb[13](function() ... end, 6) -> истина, если
-- условие выполнилось до истечения таймаута (тело пула не читано).
local function WaitFor(condition, seconds)            -- cKb[13]
    return cKb[13](condition, seconds)
end

-- Проверка «квест можно взять» — bp9. В артефакте два разных тела на один слот:
--   коп. A: bp9 = F6275 (строка 11469 рендера) — перебирает vs:GetChildren(),
--           берёт код задачи через cKb[76], требует наличие "Code"."Value"
--           у каждой задачи; nil, если хоть одна не готова.
--   коп. B: bp9 = F5388 (строка 37281) — требования по уровню/расе:
--           bFQ = cKb[48]() (уровень), tonumber(bFP["Level"]), bFP["MaxLevel"],
--           type(bFP["Race"]) == "table".
-- Какое тело действует в момент вызова, решает порядок перепривязки слотов в
-- машине артефакта; поэтому вызов оставлен слоту (не дочитано до конца).
local function QuestAcceptable(data)                  -- bp9
    return bp9(data)
end

-- Пробежка по задачам квеста — bnq (коп. A, смещение 1 445 494) / bpV (коп. B,
-- смещение 1 678 198) — возвращает три значения: (ok, wantHandIn, dropped).
-- Тело — отдельная подсистема «выполнение задания», здесь не читано.
local function QuestRunTask(questId, statusKey, controller)   -- bnq / bpV
    return bnq(questId, statusKey, controller)
end

-- Взять квест — bpQ (смещение 2 239 797 в коп. B). Возвращает истину, если квест
-- принят (тело не читано).
local function QuestTake(questId, controller, statusKey)      -- bpQ
    return bpQ(questId, controller, statusKey)
end

-- Ожидание статуса квеста — bnn(a, b, "QuestStatus", controller) (см. заметку
-- про уровень-ветку: bpz["LevelStatus"] = "Waiting for %d points").
local function QuestStatusWait(alive, name, statusKey, controller)   -- bnn
    return bnn(alive, name, statusKey, controller)
end

-- Шаг квеста: bpn()
local function QuestStep()
    -- 14066 / 14060 / 14061
    if not bnB() then return end                                   -- выгружен?
    if count(controllers.QuestController["quests"]) == 0 then return end
    -- 14062
    priority.commit("AutoQuest")
    if not enabled("AutoQuest") then return end
    -- 14065
    local ok, err = pcall(function()
        -- 3512
        if not WaitReady(20) then                                  -- cKb[86](20)
            bpz["QuestStatus"] = "Waiting for character"
            return
        end
        -- 3511
        local list = {}
        for _, quest in pairs(controllers.QuestController["quests"]) do
            list[#list + 1] = quest
        end
        table.sort(list)
        local holder = QuestHolder()                               -- cKb[137]()

        local stop = false
        for _, quest in ipairs(list) do
            -- машина bMFA (вход 7)
            if not controllers.QuestController["stopped"] then     -- 7
                local data = QuestData(quest)                      -- 18
                local name = QuestNameOr(data, quest)
                local present = holder and holder:FindFirstChild(name) or nil  -- 10/11
                if present then                                    -- 20
                    if not controllers.QuestController["yield"] then -- 19
                        local _, wantHandIn, dropped = QuestRunTask(quest, "QuestStatus",
                                                                    controllers.QuestController)
                        if dropped then                            -- 2
                            bpz["QuestStatus"] = "Dropping stuck " .. QuestName(quest)
                            QuestRemove(name)
                            return
                        end
                        if wantHandIn then                         -- 14
                            bpz["QuestStatus"] = "Handing in " .. QuestName(quest)
                            local gone = WaitFor(function()        -- 4278-замыкание
                                local holderNow = QuestHolder()
                                return holderNow == nil
                                    or holderNow:FindFirstChild(name) == nil
                            end, 6)
                            if gone then                           -- 12 -> 4
                                bpz["Quests"] = bpz["Quests"] + 1
                                bpz["QuestStatus"] = "Finished " .. QuestName(quest)
                                return                             -- 5 -> 17
                            end
                            -- 0 -> 12: ждём статус, если не сдался
                            QuestStatusWait(false, name, "QuestStatus",
                                            controllers.QuestController)
                            -- 19/8/15/16/21
                            if not controllers.QuestController["stopped"] then
                                priority.uncommit("AutoQuest")     -- 16
                            end
                            bpz["QuestStatus"] = "Cannot hand in " .. QuestName(quest)
                            return
                        end
                        return                                     -- 17 (нечего делать)
                    end
                end
                -- 13 -> 9: пустой слот, идём к следующему квесту
            end
            if stop then break end
        end

        -- 3511 (хвост): слот занят?
        local busy = QuestSlotBusy()                               -- cKb[52]()
        if busy then                                               -- 3514
            local data = QuestData(busy)
            bpz["QuestStatus"] = "Clearing quest slot"
            QuestRemove(QuestNameOr(data, busy))
            return
        end
        -- 3518
        local cooldown = QuestCooldown()                           -- boW()
        if cooldown > 0 then                                       -- 3516
            priority.uncommit("AutoQuest")
            bpz["QuestStatus"] = string.format("Quest cooldown %ds", math.ceil(cooldown))
            return
        end
        -- 3517: пробуем взять квест
        for _, quest in ipairs(list) do
            local data = QuestData(quest)                          -- 8
            if data and QuestAcceptable(data) then                 -- 7/3
                bpz["QuestStatus"] = "Accepting " .. QuestName(quest)  -- 1
                if QuestTake(quest, controllers.QuestController, "QuestStatus") then
                    return                                         -- 10
                end
            end
        end
        priority.uncommit("AutoQuest")
        bpz["QuestStatus"] = "Cannot take a selected quest"
    end)
    bpY("AutoQuest")                                               -- снять заявку
    if not ok then
        warn("[Ouroboros] quest step: " .. tostring(err))
    end
end

-- ---------------------------------------------------------------------------
-- Настройки из меню (F-слоты) — 1:1
-- ---------------------------------------------------------------------------
local function SetAutoLoot(value)                    -- F5861
    if value then
        bpz["LootStatus"] = "Waiting for loot"
        controllers.LootController.running = true
        cKb[84](controllers.LootController, bpd)
    else
        controllers.LootController.running = false
        controllers.LootController.pending = false
        controllers.LootController.awaitUntil = 0
        controllers.HuntController.lootUntil = nil
        bmX(controllers.LootController)
        bpz["LootStatus"] = "Idle"
    end
end

local function SetAutoChest(value)                   -- F3785
    if value then
        cKb[130]("AutoChest")
        bpz["ChestStatus"] = "Starting"
        controllers.ChestController.running = true
        cKb[84](controllers.ChestController, cKb[22])
    else
        controllers.ChestController.running = false
        controllers.ChestController.pending = false
        bmX(controllers.ChestController)
        bpz["ChestStatus"] = "Idle"
    end
end

local function SetAutoSoul(value)                    -- F2208
    if value then
        bpz["SoulStatus"] = "Waiting for souls"
        controllers.SoulController.running = true
        cKb[84](controllers.SoulController, cKb[111])
    else
        controllers.SoulController.running = false
        bmX(controllers.SoulController)
        bpz["SoulStatus"] = "Idle"
    end
end

local function SetLootRange(value)                   -- F2617
    controllers.LootController.range = math.clamp(tonumber(value) or 150, 0, 2000)
    bnc(controllers.LootController)                  -- пересобрать список целей
end

local function SetSoulRange(value)                   -- F4068
    controllers.SoulController.range = math.clamp(tonumber(value) or 250, 0, 2000)
end

return {
    controllers = controllers,
    FEATURES = FEATURES,
    priority = priority,
    StartController = StartController,
    StopController = StopController,
    TriggerPrompt = TriggerPrompt,
    ChestStep = ChestStep,
    CarryPart = CarryPart,
    LootStep = LootStep,
    SoulStep = SoulStep,
    SchematicStep = SchematicStep,
    QuestStep = QuestStep,
    -- квест-хелперы (используются единой сборкой и тестами)
    Count = count,
    BeginAttempt = BeginAttempt,
    ClaimReadiness = ClaimReadiness,
    Claimable = Claimable,
    Reach = Reach,
    MoveToTarget = MoveToTarget,
    QuestData = QuestData,
    QuestName = QuestName,
    QuestNameOr = QuestNameOr,
    QuestHolder = QuestHolder,
    QuestRemove = QuestRemove,
    QuestCooldown = QuestCooldown,
    QuestSlotBusy = QuestSlotBusy,
    QuestReady = QuestReady,
    QuestRunTask = QuestRunTask,
    QuestTake = QuestTake,
    QuestStatusSync = QuestStatusSync,
    WaitReady = WaitReady,
    SetAutoLoot = SetAutoLoot,
    SetAutoChest = SetAutoChest,
    SetAutoSoul = SetAutoSoul,
    SetLootRange = SetLootRange,
    SetSoulRange = SetSoulRange,
}

--[[ ============================================================================
  СТАТУС: лут-шаг больше не содержит заглушек.

  ЗАКРЫТО (вычитано из артефакта):
    ClaimReadiness — F2668: атрибуты "DropReservedFor" (строка) и
      "DropOwnerUserId" (число); чужой владелец → нельзя.
    Claimable — S4168…S4184: не «уже у нас» + DropClaimedBy пустой или наш.
    WaitReady — cKb[86](секунды), строка 3928.
    BeginAttempt — bmO/bp3 = слот F5074 (снять прошлый claim + предикат).
    Reach — bqd(position, eps, cancel), строка 4018 (композиция отмены дословно).
    cKb[145](arg) — переключатель CanCollide (проход сквозь препятствия) с
      восстановлением прежних значений.

  ЗАКРЫТО ПО КВЕСТАМ (шаг bpn, рендер строка 23850; коп. B — inline 1 660 803,
  коп. A — пул-функция 6279):
    Управляющая машина 14066→14060→14061→14062→14065 (выгружен / пустой список /
    commit+enabled / pcall+bpY+warn) — расписана в шапке квест-секции.
    Тело pcall 3512→3511→3514/3518→3516/3517: ожидание персонажа cKb[86](20),
    сбор квестов (pairs → bMq, table.sort), cKb[137]() = Quests.Holder, две
    вложенные машины bMF (вход 7 — сопровождение квеста; вход 4 — взятие).
    Хелперы вычитаны дословно: count (пул 363/1968), QuestData (пул 615),
    QuestName/QuestNameOr (пул 774 / состояния 15077…15084),
    QuestHolder (пул 931), QuestRemove (пул 2280: bn8("RemoveQuest", имя) +
    task.wait(0.5); пул[1299] — после перестановки пула), QuestCooldown
    (пул 1412: math.max(0, QuestCD∨30 − (Tick − LastTime.Value))),
    QuestSlotBusy (пул 429: cKb[3]()[1][1]["questString"]).

  ОСТАЛОСЬ (движок перемещения, не фарм):
    * bob — арбитр движения (token/поколение), целиком не вычитан;
    * трасса ходьбы/твина (MovementMode, TweenSpeed) — отдельная подсистема;
    * cKb[59]() — источник списка регионов (для MobList в ouroboros_combat.lua).
    * квест-хелперы bnq/bpV (тело «выполнения задания»), bpQ (взятие квеста) и
      cKb[13] (пул 4633/4512, ожидание условия с таймаутом) — оставлены вызовами
      слота: их тела целиком не читаны;
    * bp9 — на один слот два разных тела (F6275 задачи-готовность / F5388
      требования по уровню-расе); какой действует в момент вызова, зависит от
      порядка перепривязки слотов в машине артефакта.

  ПРО КОПИИ: bmO/bp3 в двух копиях артефакта указывают на РАЗНЫЕ функции;
  везде используется первая копия, как и в остальных модулях.
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- Skills: ouroboros_skills.lua
-- ---------------------------------------------------------------------------
local Skills = (function()

--[[ ============================================================================
  Ouroboros — подсистема СКИЛЛОВ (A): Auto Skills
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; номера строк — по ouroboros_main_pruned.txt.

  Наблюдения из трейсов (важно для сверки):
    * в трейсах виден ТОЛЬКО путь игрока: SkillController.Attempt_Hold("Dash","S")
      + StopHold("Dash") + сигналы Hold/UnHold/Cancel с мировыми координатами;
    * путь автокаста артефакта другой: asGameScript(SkillRunner.Attempt_Hold, имя, "")
      — второй аргумент пустая строка, а не клавиша. В трейсах он не встречался,
      потому что скиллы не были выбраны/на хотбаре.

  Константы (cKb[141]): CAST_MIN_GAP = 0.2, CAST_GRACE = 6
  Состояние: cKb[77] (таймеры/учёт), cKb[81] (модуль), bno["SkillRunner"] (игра).
============================================================================ ]]

local CAST_MIN_GAP = 0.2      -- cKb[141]["CAST_MIN_GAP"]
local CAST_GRACE   = 6        -- cKb[141]["CAST_GRACE"]

-- ---------------------------------------------------------------------------
-- Состояние подсистемы
-- ---------------------------------------------------------------------------
local skills = {                -- cKb[77] — наблюдаемые поля
    count = 0,                  -- сколько кастов сделано
    skills = nil,               -- список доступных скиллов
    skillsAt = 0,               -- когда список обновлялся
    stall = nil,                -- текст паузы (когда всё на кулдауне)
    stallUntil = 0,
    active = nil,               -- текущая запись каста (bDn)
    -- методы (объявлены ниже): backoff, remaining, held, owns, valid, retire,
    -- release, refused, claim, reset, busy, step
}
local module = { autoSkills = false }   -- cKb[81]

-- ---------------------------------------------------------------------------
-- НАСТРОЙКИ из меню (F-слоты)
-- ---------------------------------------------------------------------------
local function SetAutoSkills(value)                        -- F6333
    module["autoSkills"] = value == true
    skills["reset"]()                                      -- сбросить счётчики/паузы
    bpz["AutoSkillStatus"] = module["autoSkills"] and "Starting" or "Idle"
end

local function SetSkillSelection(selection)                -- F3620
    -- оригинал: cKb[81][<4782>] = boa(selection)
    module["selection"] = boa(selection)
end

local function SetSkillHold(name, value)                   -- F6286
    module["holds"] = module["holds"] or {}
    module["holds"][name] = value == true
end

local function HoldSkills()                                 -- F1669 (getter для UI)
    return module["holds"] or {}
end

local function SkillChoices()                              -- F544
    return bpz["SkillChoices"]
end

local function SetUnlockSkills(value)                      -- F5505
    module["unlockSkills"] = value == true
end

local function SetAutoSkillTree(value)                     -- F2053
    module["autoSkillTree"] = value == true
end


-- ---------------------------------------------------------------------------
-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ СОСТОЯНИЯ (вычитаны из артефакта, слоты cKb[77])
-- ---------------------------------------------------------------------------
local REFUSAL_GAP = 0.35      -- cKb[141]["REFUSAL_GAP"]: пауза после отказа

-- owns(record) — F5285: запись всё ещё «наша»
function skills.owns(record)
    local character = cKb[9]()
    local shc = character and character:FindFirstChild("SHC")
    if cKb[51]["SkillWork"]["entry"] ~= record then return false end
    if character ~= record["character"] then return false end
    if record["stamp"] == nil then return false end
    if shc ~= record["shc"] then return false end
    if shc == nil then return false end
    if shc["Value"] ~= record["name"] then return false end
    return shc:GetAttribute("last_performed") == record["stamp"]
end

-- retire(record) — F3455: снять запись отовсюду
function skills.retire(record)
    if skills["active"] == record then skills["active"] = nil end
    if cKb[51]["SkillWork"]["entry"] == record then
        cKb[51]["SkillWork"]["entry"] = nil
    end
end

-- valid(record) — F3170: можно ли продолжать возиться с этой записью
function skills.valid(record)                     -- bpm() = F796: игрок жив и персонаж есть
    local alive = playerValues() ~= nil and playerValues()["Health"] > 0
                  and cKb[145]() ~= nil
    return bnB()
       and module["autoSkills"]
       and not record["cancelled"]
       and cKb[9]() == record["character"]
       and alive
       and record["session"]["valid"]()
       and cKb[51]["SkillWork"]["entry"] == record
end

-- claim(record) — F4419: занять скилл под каст
function skills.claim(record)
    if not skills["owns"](record) then return false end
    if not bnB() then return false end
    local runner = bno["SkillRunner"]
    runner["HeldSkill"] = record["name"]
    runner["CurrentMax"] = (tonumber(record["hold"]) or 0) > 0 and record["hold"] or nil
    return true
end

-- remaining(name) — F5168: сколько секунд кулдауна осталось
function skills.remaining(name)
    local skill = cKb[24](name)                    -- игровой объект скилла по имени
    if not skill then return 0 end
    local cooldown = tonumber(skill["Cooldown"])
    if not cooldown then cooldown = 0 end
    if cooldown <= 0 then return 0 end
    local lastUsed = tonumber(skill["lastUsed"])
    if not lastUsed then return 0 end
    return math.max(cooldown - (os.clock() - lastUsed), 0)
end

-- backoff(name, seconds, stallText) — F5871: поставить кулдаун и, если нужно, паузу
function skills.backoff(name, seconds, stallText)
    local wait = math.max(tonumber(seconds) or 0, 0)
    cKb[77]["cooldowns"] = cKb[77]["cooldowns"] or {}
    cKb[77]["cooldowns"][name] = os.clock() + wait
    if stallText then
        skills["stall"], skills["stallUntil"] = stallText, os.clock() + wait
    end
end

-- held(name) — F1166: этот скилл сейчас удерживается персонажем
function skills.held(name)
    local character = cKb[9]()
    local shc = character and character:FindFirstChild("SHC")
    if not shc then return false end
    return shc["Value"] == name
end

-- busy(record) — F2775: каст ещё в процессе (по нему и решается «ждать»)
function skills.busy(record)
    if not record then return false end
    if cKb[9]() ~= record["character"] then
        if record["releaseFailed"] then
            skills["retire"](record)
            return false
        end
        if not skills["owns"](record) then
            if record["releaseFailed"] then
                skills["retire"](record)
                return false
            end
            if record["cancelled"] then return false end
            return true
        end
    end
    if record["cancelled"] then return false end
    return true
end

-- refused(name) — F6399: причина отказа в касте + пауза
function skills.refused(name)
    local values = cKb[123]["playerValues"]()        -- bCH = cKb[77]["remaining"](pO)
    if not values then return "No player values", REFUSAL_GAP end
    if values:FindFirstChild("Blocking") then return "Not enough stamina", REFUSAL_GAP end
    local remaining = skills["remaining"](name)
    if remaining > 0 then
        return "Waiting for " .. tostring(name) .. " cooldown", REFUSAL_GAP
    end
    local stamina = tonumber(values["Stamina"])
    if stamina and stamina < (tonumber(values["Value"]) or 0) then
        return "Not enough stamina", REFUSAL_GAP
    end
    return nil, REFUSAL_GAP
end

-- playerValues() — cKb[123]["playerValues"], с кэшем на кадр
local cachedValues, cachedAt
function playerValues()
    local now = os.clock()
    if cachedValues and cachedAt == now then return cachedValues end
    cachedValues = cKb[123]["playerValues"]()
    cachedAt = now
    return cachedValues
end

-- ---------------------------------------------------------------------------
-- ЗАПИСЬ КАСТА (строка 16263) и вход в каст
-- ---------------------------------------------------------------------------
local function CastSkill(name, hold, session)              -- начало шага, S16246…
    -- гарды
    if type(bno["SkillRunner"]) ~= "table" then
        bpz["AutoSkillStatus"] = "Skill controller unavailable"
        return false
    end
    -- cKb[118] — проверка вызываемости (F5470); см. предупреждение в ouroboros_core.lua
    if not cKb[118](bno["SkillRunner"]["Attempt_Hold"]) then
        bpz["AutoSkillStatus"] = "Skill controller unavailable"
        return false
    end

    local character = cKb[9]()                              -- bDp
    if not character then return false end
    local lastPerformed = character:GetAttribute("last_performed") or 0   -- bDo

    local record = {                                       -- bDn
        name = name,                                       -- p8
        hold = hold,                                       -- p9
        session = session,                                 -- qa
        character = character,
        expires = os.clock()
                + math.max(hold, lastPerformed)
                + CAST_GRACE,                              -- cKb[141]["CAST_GRACE"]
    }

    skills["active"] = record
    cKb[51]["SkillWork"]["entry"] = record
    bpz["AutoSkillStatus"] = "Casting " .. name

    -- наблюдатель SHC: запоминает контейнер и отпечаток последнего каста
    local function watch()                                 -- bDm
        local shc = record["character"]:FindFirstChild("SHC") or record["character"]
        if not shc then return end
        record["shc"] = shc
        record["stamp"] = shc:GetAttribute("last_performed")
    end
    watch()

    -- РАБОЧИЙ КАСТА (F3374 spawn)
    task.spawn(function()
        local message, code, flag = skills["refused"](name)       -- bDb, bDc, bC9
        local deadline = nil                                       -- bC7
        while true do
            if skills["valid"](record) then
                task.wait(0.05)
            else
                if not skills["owns"](record) then
                    skills["retire"](record)
                    return
                end
                if not skills["claim"](record) then
                    skills["release"](record)
                    return
                end

                skills["count"] = skills["count"] + 1
                skills["backoff"](name, math.max(skills["remaining"](name), CAST_MIN_GAP))

                bpz["AutoSkillStatus"] = "Holding " .. name
                deadline = os.clock() + hold                   -- bC7 = os.clock() + p9

                -- ВОТ ОН, автокаст: второй аргумент — пустая строка
                local ok, err = cKb[123]["asGameScript"](
                    bno["SkillRunner"]["Attempt_Hold"], name, "")
                record["return ed"] = true
                watch()

                if not skills["valid"](record) then
                    skills["release"](record)
                    return
                end
                if not ok then
                    bpz["AutoSkillStatus"] = "Cast error:" .. tostring(err)
                    skills["release"](record)
                    return
                end
            end
        end
    end)

    -- СТОРОЖ ТАЙМАУТА (второй F3374 spawn)
    task.spawn(function()
        while true do
            if cKb[51]["SkillWork"]["entry"] ~= record then
                if not skills["valid"](record) then
                    record["cancelled"] = true
                    skills["release"](record)
                end
                return
            end
            if os.clock() < record["expires"] then
                task.wait(0.05)
            else
                record["cancelled"] = true
                skills["release"](record)
                if bnB() then
                    bpz["AutoSkillStatus"] = "Waiting for unresolved skill " .. name
                end
                return
            end
        end
    end)

    return true
end

-- ---------------------------------------------------------------------------
-- ОСВОБОЖДЕНИЕ СКИЛЛА (cKb[77]["release"], строка 969) — до 3 попыток
-- ---------------------------------------------------------------------------
function skills.release(record)                          -- cKb[77].release
    if not record then return end
    if record["releasing"] then return end
    if not record["return ed"] then return end
    record["releasing"] = true

    task.spawn(function()
        for attempt = 1, 3 do
            if skills["owns"](record) then
                record["releaseFailed"] = true
                if bnB() then
                    bpz["AutoSkillStatus"] = "Skill release unresolved"
                    return
                end
            end

            local entry = cKb[51]["SkillWork"]["entry"]
            if not skills["owns"](record) then
                if entry == record and cKb[9]() == record["character"] then
                    if bno["SkillRunner"]["HeldSkill"] == record["name"] then
                        bno["SkillRunner"]["HeldSkill"] = nil
                        bno["SkillRunner"]["CurrentMax"] = nil
                    end
                    skills["retire"](record)
                    -- подтверждение: изменился ли last_performed
                    if record["shc"]
                    and record["shc"]:GetAttribute("last_performed") == record["stamp"] then
                        skills["retire"](record)
                    end
                    return
                end
                if cKb[118](bno["SkillRunner"]["StopHold"]) then
                    cKb[123]["asGameScript"](bno["SkillRunner"]["StopHold"], record["name"])
                end
                if not skills["owns"](record) then
                    if cKb[118](bno["SkillRunner"]["ForceCancel"]) then
                        cKb[123]["asGameScript"](bno["SkillRunner"]["ForceCancel"], record["name"])
                    end
                end
            else
                if cKb[118](bno["SkillRunner"]["ForceCancel"]) then
                    cKb[123]["asGameScript"](bno["SkillRunner"]["ForceCancel"], record["name"])
                end
                if not skills["owns"](record) then
                    task.wait(0.1)
                else
                    skills["retire"](record)
                    return
                end
            end
        end
    end)
end

-- ---------------------------------------------------------------------------
-- ШАГ КОНТРОЛЛЕРА СКИЛЛОВ (F434) — что делает Auto Skills каждый интервал (5 с)
-- ---------------------------------------------------------------------------
local function SkillStep(caster)                            -- cKb[77]["step"]
    if skills["busy"]() then
        bnO(caster)
        return true
    end

    if skills["stall"] then
        if os.clock() < skills["stallUntil"] then
            bpz["AutoSkillStatus"] = skills["stall"]
        else
            skills["stall"] = nil
            bpz["AutoSkillStatus"] = string.format(
                "%d cast, all on cooldown", skills["count"])
        end
    end

    if not module["autoSkills"] then return false end

    -- не мешать авто-парированию (пересечение с подсистемой C!)
    local values = cKb[123]["playerValues"]()
    if values and values:FindFirstChild("Blocking") then
        bpz["AutoSkillStatus"] = "Holding off for auto parry"
        return false
    end

    if not skills["skills"] or os.clock() >= skills["skillsAt"] then
        skills["skills"] = cKb[106]()                       -- обновить список скиллов
        skills["skillsAt"] = os.clock() + 0.5
    end

    if #skills["skills"] == 0 then
        bpz["AutoSkillStatus"] = "Waiting for the current skill"
        return true
    end

    -- выбор скилла и запуск CastSkill(...) — см. «не дочитано»
    bnO(caster)
    return true
end

-- ---------------------------------------------------------------------------
-- СБРОС (cKb[77]["reset"], F215) — вспомогательная заглушка под реконструкцию
-- ---------------------------------------------------------------------------
function skills.reset()
    skills["count"] = 0
    skills["stall"] = nil
    skills["stallUntil"] = 0
    skills["skills"] = nil
    skills["active"] = nil
end

return {
    state = skills,             -- cKb[77]
    module = module,            -- cKb[81]
    CAST_MIN_GAP = CAST_MIN_GAP,
    CAST_GRACE = CAST_GRACE,
    CastSkill = CastSkill,
    SkillStep = SkillStep,
    SetAutoSkills = SetAutoSkills,
    -- вспомогательные (вычитаны)
    owns = skills.owns, retire = skills.retire, valid = skills.valid,
    claim = skills.claim, remaining = skills.remaining, backoff = skills.backoff,
    held = skills.held, busy = skills.busy, refused = skills.refused,
    SetSkillSelection = SetSkillSelection,
    SetSkillHold = SetSkillHold,
    SetUnlockSkills = SetUnlockSkills,
    SetAutoSkillTree = SetAutoSkillTree,
    HoldSkills = HoldSkills,
    SkillChoices = SkillChoices,
}

--[[ ============================================================================
  ЗАКРЫТО в этом заходе (вычитано из артефакта):
    owns (F5285), retire (F3455), valid (F3170), claim (F4419),
    remaining (F5168), backoff (F5871), held (F1166), busy (F2775),
    refused (F6399, строки "No player values" / "Not enough stamina",
    REFUSAL_GAP = 0.35), игрок жив = bpm (F796: playerValues ~= nil и
    Health > 0 и cKb[145]() ~= nil).

  НЕ ДОЧИТАНО (A):
  2. Выбор конкретного скилла внутри SkillStep: cKb[106]() даёт список,
     дальше фильтр по hold-настройкам (SetSkillHold F6286), приоритет и
     bnO(q9)/bny["timing"](q9) — временная логика перед кастом.
  3. Ветка «всё на кулдауне»: cKb[77]["stall"] + stallUntil, взаимодействие
     с bno["CombatPresets"]["slow_walk_duration"].
  4. SkillTree: SetAutoSkillTree F2053, SetSkillNodes F6271, SkillNodes F4215,
     UnlockSkills F5505, RefreshSkillNodes F708 — отдельная ветка (не каст).
  5. Связка с C: скиллы уступают парированию («Holding off for auto parry»),
     а парирование считает окна по свингам Combat_Service (A3/A5 из трейсов).

  Сверка с трейсами: путь автокаста (Attempt_Hold с "" и записью release) в трейсах
  НЕ наблюдался ни разу — только действия игрока (Dash + клавиша). Чтобы поймать
  автокаст, нужен прогон с выбранными скиллами на хотбаре.
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- Combat: ouroboros_combat.lua
-- ---------------------------------------------------------------------------
local Combat = (function()

--[[ ============================================================================
  Ouroboros — БОЕВЫЕ ТВИКИ и ПОРОГИ УБИЙСТВА (пересечение B/C/D)
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; строки — по ouroboros_main_pruned.txt.

  ГЛАВНЫЙ ОТВЕТ ПРО СВИНГИ:
    Сигнала "Combat_Service" в артефакте НЕТ НИ ОДНОГО (проверено: 0 вхождений
    в оригинале и 0 в пуле). Значит строки Combat_Service/Combat с A3=1..5 и
    A5=0.13/0.04 из трейсов — это САМА ИГРА (её собственный ремоут), а не
    Ouroboros. Рекордер видел их, потому что хукал SignalEvent.ToServer целиком.
    Ouroboros же в бой влезает иначе: пишет в игровые таблицы
    CombatInputs / SkillWork / BlockWork и читает bno["CombatPresets"],
    bno["CombatSkills"].
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Таблица твиков (cKb[99]["tweaks"], строка 37249) с точными дефолтами
-- ---------------------------------------------------------------------------
local tweaks = {
    noStun = true,
    noRagdoll = false,
    instantKill = false,
    killThreshold = 10,
    chestKill = false,
    chestKillThreshold = 10,
    infStamina = false,
    infClimb = false,
    infHorse = false,
    noDrown = false,
    noDashCd = false,
    noSun = false,
    alwaysRun = false,
    ownership = false,
    ownershipRange = 250,
    [8562344] = false,          -- ещё один безымянный флаг (в артефакте — число)
}
-- В коде ниже таблица встречается как cKb[72] (строка 32666: cKb[72] = cKb[99]["tweaks"])
-- и как bop (строка 23692).

-- ---------------------------------------------------------------------------
-- Настройки из меню (F-слоты) — все пишут в ту же таблицу
-- ---------------------------------------------------------------------------
local function SetKillThreshold(value)          -- F51
    tweaks["killThreshold"] = math.clamp(tonumber(value) or 10, 0, 100)
end

local function SetChestKillThreshold(value)     -- F6033
    tweaks["chestKillThreshold"] = math.clamp(tonumber(value) or 10, 0, 100)
end

local function SetInstantKill(value)            -- F4760
    tweaks["instantKill"] = value == true
end

local function SetChestInstantKill(value)       -- F2680
    tweaks["chestKill"] = value == true
end

local function SetNoStun(value)       tweaks["noStun"] = value == true end        -- F5991
local function SetNoRagdoll(value)    tweaks["noRagdoll"] = value == true end     -- F6168
local function SetNoAttackSlowdown(value) tweaks["noAttackSlowdown"] = value == true end -- F5934
local function SetNoDashCooldown(value)   tweaks["noDashCd"] = value == true end  -- F734
local function SetNoDrown(value)      tweaks["noDrown"] = value == true end       -- F5927
local function SetInfiniteStamina(value)  tweaks["infStamina"] = value == true end-- F4483
local function SetInfiniteClimb(value)    tweaks["infClimb"] = value == true end  -- F2327
local function SetInfiniteHorseStamina(value) tweaks["infHorse"] = value == true end -- F787
local function SetAlwaysRun(value)    tweaks["alwaysRun"] = value == true end     -- F2206
local function SetDisableShiftLock(value) tweaks["shiftLock"] = value == true end -- F4303
local function SetNoSunDamage(value)  tweaks["noSun"] = value == true end         -- F127
local function SetPrivateOwner(value) tweaks["privateOwner"] = value end          -- F944

local function SetOwnershipRange(value)         -- F841
    tweaks["ownershipRange"] = math.clamp(tonumber(value) or 250, 50, 2000)
end

local function SetOwnershipViewer(value)        -- F3137
    tweaks["viewer"] = value
end

-- ---------------------------------------------------------------------------
-- META-ПОРОГ: 1 - порог/100. 10% -> 0.9, 0% -> 1.0, 100% -> 0
-- Убиваем, когда Health <= MaxHealth * meta.
-- То есть слайдер = «сколько процентов здоровья должно быть снято до казни»:
--   0   -> убивает сразу (Health <= MaxHealth),
--   10  -> когда снято 10% (по умолчанию),
--   100 -> уже мёртвых (по факту никогда).
-- ---------------------------------------------------------------------------
local function MetaFor(threshold)
    return 1 - math.clamp(threshold or 0, 0, 100) / 100
end

-- ---------------------------------------------------------------------------
-- INSTANT KILL — bpX (строка 733), вызывается из анти-АФК тика
-- ---------------------------------------------------------------------------
local function InstantKillStep(mobs)                  -- bpX
    if not tweaks["instantKill"] then return end      -- S5529
    local meta = MetaFor(tweaks["killThreshold"])     -- cbM
    for _, entry in ipairs(mobs()) do                 -- boo() — список мобов
        local model = entry["model"]
        local humanoid = entry["humanoid"]
        if humanoid and humanoid["Serpent"] > 0                  -- MaxHealth в атрибуте Serpent
        and humanoid["Health"] <= humanoid["Serpent"] * meta
        and (model:FindFirstChild("HumanoidRootPart") or model["PrimaryPart"])
        and model[1] and model["ReceiveAge"] == 0 then           -- только что появившийся
            task.defer(function() humanoid["Health"] = 0 end)    -- F2175(...)
            break
        end
    end
end

-- ---------------------------------------------------------------------------
-- CHEST KILL — boZ (строка 813), тоже из анти-АФК тика
--   Работает только когда идёт авто-открытие сундуков и есть ЗАПЕРТЫЕ сундуки;
--   валит охрану рядом с ними (CHEST_GUARD_RANGE = 220) по своему порогу.
-- ---------------------------------------------------------------------------
local function ChestKillStep(mobs, chestList)         -- boZ
    if not tweaks["chestKill"] then return end                  -- S7381
    if not cKb[91]["ChestController"]["running"] then return end-- S7387
    if cKb[91]["ChestController"]["stopped"] then return end    -- S7388

    local locked = {}                                            -- cbX
    for _, chest in ipairs(chestList()) do                       -- bps() — sealed caches
        if chest["model"]:GetAttribute("ChestState") == "Locked" then
            locked[#locked + 1] = chest["model"]:GetPivot().Position
        end
    end
    if #locked == 0 then return end

    local meta = MetaFor(tweaks["chestKillThreshold"])           -- cbY
    for _, entry in ipairs(mobs()) do
        local model, humanoid = entry["model"], entry["humanoid"]
        local root = model and (model:FindFirstChild("HumanoidRootPart") or model["PrimaryPart"])
        if root
        and humanoid and humanoid["Serpent"] > 0
        and humanoid["Health"] <= humanoid["Serpent"] * meta
        and model["ReceiveAge"] == 0
        and not cKb[141]["PASSIVE_MOBS"][entry["model"]["Name"]] then -- охрана, а не пассивка
            for _, position in ipairs(locked) do
                if (root["Position"] - position).Magnitude
                   <= cKb[141]["CHEST_GUARD_RANGE"] then         -- 220
                    task.defer(function() humanoid["Health"] = 0 end)
                    break
                end
            end
        end
    end
end

-- ---------------------------------------------------------------------------
-- КОНТЕЙНЕР: cKb[132] = cloneref(LocalPlayer)  (строка 8144 оригинала:
--   cKb[132] = bpZ(bmK[<"LocalPlayer">]), где bpZ = F5378 = cloneref)
-- Поэтому проверки вида obj:IsDescendantOf(cKb[132]) означают
-- «объект уже у нас / принадлежит локальному игроку».
-- ---------------------------------------------------------------------------
local LocalPlayerRef = cloneref and cloneref(game:GetService("Players").LocalPlayer)
                          or game:GetService("Players").LocalPlayer

-- ---------------------------------------------------------------------------
-- СПИСОК МОБОВ — boo() = F3280 (вторая копия; в первой F76 — та же идея,
-- но запутаннее и без полей name/region)
--   bxc[i] = { name = <имя папки>, region = <регион>, model = <Model>, humanoid = <Humanoid> }
-- ---------------------------------------------------------------------------
local function MobList()                                  -- boo (F3280)
    local found = {}
    for _, region in ipairs(cKb[59]()) do                 -- список регионов/папок
        for _, model in ipairs(region["folder"]:GetChildren()) do
            if model:IsA("Model") and model:GetAttribute("IsMob") then
                local humanoid = model:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid["Health"] > 0 then
                    found[#found + 1] = {
                        name = region["folder"]["Name"],      -- имя папки региона
                        region = region["region"],
                        model = model,
                        humanoid = humanoid,
                    }
                end
            end
        end
    end
    return found
end

-- ---------------------------------------------------------------------------
-- АНТИ-АФК — bon() = F2440: переключает RunHandler.Toggled, чтобы персонаж
-- не «засыпал». Флаг cKb[71] хранит состояние переключателя.
-- ---------------------------------------------------------------------------
local antiAfkFlag = false                                 -- cKb[71]
local function AntiAfk()                                  -- bon (F2440)
    if type(bno["RunHandler"]) ~= "table" then return end
    if antiAfkFlag then
        antiAfkFlag = false
        task.defer(function() bno["RunHandler"]["Toggled"] = false end)
    else
        if bno["RunHandler"]["Toggled"] ~= true then
            bno["RunHandler"]["Toggled"] = true
        end
        antiAfkFlag = true
    end
end

-- ---------------------------------------------------------------------------
-- ТИКЕР (в оригинале — цикл под флагом cKb[72]["AntiAfk"], строка ~9300)
--   bon(); bpX(); boZ()   -- каждый проход
-- ---------------------------------------------------------------------------
local function CombatTick()                               -- обёртка анти-АФК прохода
    if not tweaks["AntiAfk"] then return end
    AntiAfk()                                             -- анти-АФК действие
    InstantKillStep(MobList)                              -- bpX
    ChestKillStep(MobList, bps)                           -- boZ
end

-- ---------------------------------------------------------------------------
-- ГДЕ ЗДЕСЬ ИНТЕГРАЦИЯ С ИГРОЙ (для справки, не переписывать наугад)
-- ---------------------------------------------------------------------------
-- cKb[51]["CombatInputs"], cKb[51]["SkillWork"], cKb[51]["BlockWork"] — это
-- игровые таблицы, которые Ouroboros экспортирует/патчит:
--   * парирование пишет cKb[51]["BlockWork"]["entry"] = cfX   (см. ouroboros_parry.lua)
--   * скиллы пишут   cKb[51]["SkillWork"]["entry"] = bDn     (см. ouroboros_skills.lua)
--   * cKb[42] = cKb[51]["CombatInputs"] (строка 34340) — доступ к вводу боя
-- bno["CombatPresets"]["slow_walk_duration"] используется в шаге скиллов (F434).
-- bno["CombatSkills"] = отдельный модуль игры.
-- Прочие теги: cKb[141]["LOCKOUT_TAGS"] = {"Stun","CombatStun","Strict_Stun",
--   "KnockedOut","Swapping","combatdisabled"}; boL = {Stun=true, CombatStun=true}.

return {
    tweaks = tweaks,
    MetaFor = MetaFor,
    InstantKillStep = InstantKillStep,
    ChestKillStep = ChestKillStep,
    CombatTick = CombatTick,
    MobList = MobList,
    AntiAfk = AntiAfk,
    LocalPlayerRef = LocalPlayerRef,
    SetKillThreshold = SetKillThreshold,
    SetChestKillThreshold = SetChestKillThreshold,
    SetInstantKill = SetInstantKill,
    SetChestInstantKill = SetChestInstantKill,
    SetNoStun = SetNoStun,
    SetNoRagdoll = SetNoRagdoll,
    SetNoAttackSlowdown = SetNoAttackSlowdown,
    SetNoDashCooldown = SetNoDashCooldown,
    SetNoDrown = SetNoDrown,
    SetInfiniteStamina = SetInfiniteStamina,
    SetInfiniteClimb = SetInfiniteClimb,
    SetInfiniteHorseStamina = SetInfiniteHorseStamina,
    SetAlwaysRun = SetAlwaysRun,
    SetDisableShiftLock = SetDisableShiftLock,
    SetNoSunDamage = SetNoSunDamage,
    SetPrivateOwner = SetPrivateOwner,
    SetOwnershipRange = SetOwnershipRange,
    SetOwnershipViewer = SetOwnershipViewer,
}

--[[ ============================================================================
  ЗАКРЫТО в этом заходе:
    MobList (boo = F3280: обход cKb[59](), фильтр Model + атрибут "IsMob" +
    живой Humanoid, запись {name=имя папки, region, model, humanoid});
    AntiAfk (bon = F2440: переключатель RunHandler.Toggled);
    cKb[132] = cloneref(LocalPlayer) — значит IsDescendantOf(cKb[132]) читается
    как «уже у нас».

  cKb[59]() = пул-функция 1319 (привязка в заголовке второй сборки @1 963 167;
  там же слот 87 @2 262 903) — прочитана целиком:
    local out = {}
    local base = cKb[63]()               -- контейнер со «сценами»/регионами
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
  (записи — {region = имя ребёнка контейнера, folder = папка из его ActiveNpcs}).

  ЧТО ЗДЕСЬ ЕЩЁ НЕ ДОЧИТАНО:
  1. cKb[63]() — сам контейнер регионов: в сборках слот 63 привязан к РАЗНЫМ
     телам (пул 5333 @1 462 355 и пул 2112 @1 527 155 в первой сборке; inline
     @1 714 392 во второй — но там это уже не контейнер, а хелпер промпта с
     параметром). Какое тело действует в момент вызова cKb[59](), зависит от
     выбранной карты слотов (см. ROADMAP, «Известные ловушки»).
  3. Точный тик: цикл запускается через F2175(function() … end) и гейтится
     cKb[72]["AntiAfk"]; внутри — пошаговая машина состояний (per-frame).
  4. Патч "instant kill is patched": в UI есть подпись, что мгновенное убийство
     заблокировано игрой, но всё ещё работает — потому что мы ставим Health = 0
     через task.defer, а не бьём свингом. Свинги (Combat_Service) — игра сама.
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- Equip: ouroboros_equip.lua
-- ---------------------------------------------------------------------------
local Equip = (function()

--[[ ============================================================================
  Ouroboros — подсистема ЭКИПИРОВКИ, реконструкция 1:1 из артефакта
  ----------------------------------------------------------------------------
  Источник:      ouroboros_ps2 (1).luau  (luast v1.0.1, пул cKb[136])
  Инструменты:   tools/deflatten.py --pool N / --slot N, tools/prune_junk.py
  Трейс-эталон:  data/traces/2026-09-25-autolevel-loot-parry.txt

  Каждая функция помечена ссылкой на оригинал: F<n> = запись пула cKb[136][n],
  S<k> = состояние (state) в де-flattened машине.  Номера строк — в
  ouroboros_main_pruned.txt.

  Схема (подтверждена трейсом):
     SetAutoEquip(true)  -> воркер EquipController (интервал 20 c)
                              шаг: pcall(cKb[83])
     cKb[83]             -> скор всех предметов, сортировка, AccessoryEquip
     cKb[27](slot, true) -> Item_Equip  (смена слоя хотбара)
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- 1. Отправка сигналов на сервер игры                             [F651]
--    Оригинал: bn8 = F651.  Трейс: A1="Item_Equip" A2=2 и т.д.
-- ---------------------------------------------------------------------------
local function Signal(name, ...)
    if type(bno["SignalEvent"]) ~= "table" or not cKb[118](bno["SignalEvent"]["ToServer"]) then
        cKb[100]("SignalEvent.ToServer")        -- warn: сигналы недоступны
        return false
    end
    return pcall(bno["SignalEvent"]["ToServer"], name, ...)
end

-- ---------------------------------------------------------------------------
-- 2. Инвентарь и «Equipped»-контейнер                             [F4012]
--    Items_Config.Equipped — объект, чей .Value = индекс текущего слота.
-- ---------------------------------------------------------------------------
local function Inventory()                                  -- cKb[36]
    local cfg = cKb[126]:FindFirstChild("Items_Config")
    if not cfg then return nil end
    return cfg:FindFirstChild("Equipped")
end

local function EquippedValue()                               -- cKb[55]
    return Inventory()           -- тот же аксессор: Items_Config.Equipped
end

local function EquippedByName(name)                          -- cKb[60] = F3695
    local inv = Inventory()
    if not inv then return nil end
    return inv:FindFirstChild(name)
end

-- ---------------------------------------------------------------------------
-- 3. Оценка предмета по статам                                    [F900]
--    score = Σ value * STAT_WEIGHTS[stat]; неизвестный стат вес 10.
--    cKb[141]["STAT_WEIGHTS"] (строка 28566):
--      Max Health 1 | Max Stamina 0.6 | Additional Damage 25
--      Additional Damage Factor 900 | Movement Speed Factor 300
--      Stamina Regen Speed 120 | Health Regen Speed 120
--      Block Points 30 | Block Regen 80
-- ---------------------------------------------------------------------------
local function ItemScore(item)                               -- cKb[104]
    local stats = item and item["Stats"]
    if type(stats) ~= "table" then return nil end
    local score = 0
    for stat, value in pairs(stats) do
        local weight = cKb[141]["STAT_WEIGHTS"][stat] or 10
        if type(value) == "number" then
            score += value * weight
        end
    end
    return score
end

-- ---------------------------------------------------------------------------
-- 4. Смена слота хотбара                                          [S4899..S4912]
--    Оригинал: cKb[27] = function(slot, force)   (строка 20759)
--    force=true — реально отправить Item_Equip (трейс: A2 = 0/2/3).
-- ---------------------------------------------------------------------------
local SLOT_NAMES = { "One", "Two", "Three", "Four", "Five" }  -- cKb[141]["SLOT_NAMES"]

local function EquipSlot(slot, force)                        -- cKb[27]
    local holder = EquippedValue()
    slot = tonumber(slot)
    if not holder or not slot then return false end           -- S4909/S4908
    if slot < 0 then return false end                         -- S4910
    if slot > #SLOT_NAMES then return false end               -- S4902
    if holder["Value"] == slot then                           -- S4900
        if force then                                         -- S4911
            Signal("Item_Equip", slot)                        -- S4904
        end
        return true                                           -- S4905
    end
    -- S4901: значение ставится локально; сигнал отправит следующий вызов с force
    return pcall(function() holder["Value"] = slot end)
end

-- ---------------------------------------------------------------------------
-- 5. «Auto Equip Best»: подбор лучшего снаряжения в каждый слот   [F4194]
--    Оригинал: cKb[83], строка 28569.
-- ---------------------------------------------------------------------------
local function EquipBest()                                   -- cKb[83]
    local inv = Inventory()                                  -- cKb[36]()
    local ready = EquippedValue()                            -- bnY()
    if not inv or not ready then                             -- S12032/S12033
        bpz["EquipStatus"] = "Waiting for inventory"         -- S12026
        return false
    end

    -- 5.1 собрать и оценить всё, что лежит в инвентаре
    local scored = {}
    local isNil = false
    for _, item in ipairs(inv:GetChildren()) do              -- S12027
        local score = ItemScore(item)                        -- cKb[104](item["Name"])
        local id = EquippedByName(item["Name"])              -- cKb[60](item["Name"])
        if score then
            scored[#scored + 1] = { name = item["Name"], score = score, id = id }
        else
            isNil = true
        end
    end
    if #scored == 0 then                                     -- S12034
        bpz["EquipStatus"] = "No stat gear owned"
        return false
    end
    table.sort(scored, function(a, b) return a["score"] > b["score"] end)  -- S12028

    -- 5.2 пройти слоты и надеть лучшее, если оно ещё не надето
    local equipped = 0
    local done = false
    for index, slotName in ipairs(SLOT_NAMES) do             -- S6010 / S12028
        local best = scored[index]
        if best then
            local current = inv:FindFirstChild(slotName)     -- b2u = имя слота
            local currentId = current and tonumber(current["Value"])
            if currentId ~= best["id"] then
                Signal("AccessoryEquip", best["id"], index, "Stats")   -- S4
                equipped += 1
                task.wait(0.35)                              -- пауза между слотами
            end
        end
        -- в артефакте здесь проверяется флаг выхода (S4): прерываем обход слотов
        if done then break end
    end

    -- 5.3 статус
    if equipped > 0 then
        bpz["EquipStatus"] = "Equipped " .. equipped .. " items"  -- S12037
        return true
    end
    bpz["EquipStatus"] = "Nothing to upgrade"                -- S12036
    return true
end

-- ---------------------------------------------------------------------------
-- 6. Включение/выключение автоподбора                             [F5830]
--    Оригинал: cKb[51]["SetAutoEquip"], строка 256.
--    EquipController = { interval = 20, cancel = 0 }  (cKb[91], строка 34309)
--    cKb[84]  — старт воркера, bmX — остановка, cKb[23] — интервал 1110 мс
-- ---------------------------------------------------------------------------
local function SetAutoEquip(enabled)                         -- F5830
    local controller = cKb[91]["EquipController"]
    if enabled then
        bpz["EquipStatus"] = "Starting"
        controller["running"] = true
        cKb[84](controller, 1110)                            -- cKb[23] = 1110
    else
        controller["running"] = false
        bmX(controller)
        bpz["EquipStatus"] = "Idle"
    end
end

-- Шаг воркера, который вызывает cKb[84]                      [F2994]
local function EquipStep()                                   -- cKb[23] в копии 2
    if not bnB() then return end                             -- гейт «можно действовать»
    pcall(cKb[83])                                           -- = EquipBest()
end

-- ---------------------------------------------------------------------------
-- 7. Кнопка «Equip Weapon» в меню                                 [F1125]
--    Оригинал: cKb[102]["EquipWeapon"] = F1125.
--    cKb[31]() — экипировать следующее боевое оружие, cKb[107]() — его имя.
-- ---------------------------------------------------------------------------
local function EquipWeapon()                                 -- F1125
    local delay = task["delay"]                              -- F6128["delay"]
    cKb[4004](0, function()                                  -- F4004 = отложенный запуск
        if cKb[31]() then                                    -- есть что надеть
            bpz["LevelStatus"] = "Equipped " .. tostring(cKb[107]())
        else
            bpz["LevelStatus"] = "No combat item in toolbar"
        end
    end)
end

return {
    Signal = Signal,
    Inventory = Inventory,
    EquippedValue = EquippedValue,
    EquippedByName = EquippedByName,
    ItemScore = ItemScore,
    EquipSlot = EquipSlot,
    EquipBest = EquipBest,
    SetAutoEquip = SetAutoEquip,
    EquipStep = EquipStep,
    EquipWeapon = EquipWeapon,
    SLOT_NAMES = SLOT_NAMES,
}

--[[ ============================================================================
  ДОКАЗАТЕЛЬСТВА ИЗ ТРЕЙСА (data/traces/2026-09-25-autolevel-loot-parry.txt)

  Item_Equip — аргумент это НОМЕР СЛОТА хотбара, что совпадает с EquipSlot:
    [   4.590] Item_Equip  2
    [  93.965] Item_Equip  0
    [ 215.043] Item_Equip  2

  Автоподбор снаряжения (AccessoryEquip) в этом трейсе не сработал — в момент
  включения SetAutoEquip (282.259 -> 285.946) в инвентаре не было предметов со
  статами, поэтому сработала ветка "No stat gear owned".

  Что ещё видно в трейсе и куда относится:
    Combat_Service / Combat / 1..5     — боевые свинги (A5 = 0.13 на 1-м, 0.04 на 5-м)
    server_skill_controller_signaler   — блок/парирование (см. F3022["zero"])
      Blocking / Hold | UnHold, Vector3(0,0,0)   -> подсистема C (Auto Parry V3)
    AddQuest "Ill take 3 bandits"      — подсистема D (автоквесты)
    training_signaler StateChanged/Stop— тренировки
    VisitRegion <имя>                  — телепорт-роутер мира
    Swim / State 3|0                   — плавание
    SkillController.Attempt_Hold НЕ вызывался ни разу: в этом трейсе Auto Skills
    не включали, поэтому путь каста скиллов ещё не подтверждён (подсистема A).
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- Parry: ouroboros_parry.lua
-- ---------------------------------------------------------------------------
local Parry = (function()

--[[ ============================================================================
  Ouroboros — подсистема ЗАЩИТЫ (Auto Parry V3), реконструкция 1:1
  ----------------------------------------------------------------------------
  Источник:      ouroboros_ps2 (1).luau, пул cKb[136]
  Инструменты:   tools/deflatten.py --pool N, tools/prune_junk.py
  Трейсы-эталоны: data/traces/2026-09-25-autolevel-loot-parry.txt
                  data/traces/2026-09-25-parry-skills-digest.txt

  Подтверждено трейсами:
    * сигнал парирования — bn8("server_skill_controller_signaler", "Blocking",
                               "Hold", Vector3.zero)      (F3022 = Vector3)
      в трейсе A4 = Vector3(0.00,0.00,0.00) — совпадает;
    * "Keep Blocking After A Parry" (bnl["hold"]) меняет удержание с ~0.19 с
      на ровно 1.5 с:  cf2 = cfZ + 1.5  (в трейсе 14 пар по 1.501..1.510 с).

  Константы (cKb[61], строка 35139):
    windowNpc = 0.25   окно идеального блока по мобу
    windowPvp = 0.1    окно по игроку
    bias      = 0.25   сдвиг раннего нажатия
    relock    = 1      пауза после блока
    defaultRtt= 0.09   запас на пинг
    reachPad  = 8      запас дистанции
    closingPad= 14
    facingMin = -0.35  минимальная «лицом к цели»
    margin    = 0.005
    acknowledgement = 2   сколько ждать подтверждения от сервера
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Отправка сигналов (общий с ouroboros_equip.lua; оригинал bn8 = F651)
-- ---------------------------------------------------------------------------
local function Signal(name, ...)
    if type(bno["SignalEvent"]) ~= "table"
            or not cKb[118](bno["SignalEvent"]["ToServer"]) then
        cKb[100]("SignalEvent.ToServer")
        return false
    end
    return pcall(bno["SignalEvent"]["ToServer"], name, ...)
end

-- ---------------------------------------------------------------------------
-- Состояние подсистемы (bnl, строка 38242)
-- ---------------------------------------------------------------------------
local parry = {
    on = false, npc = true, pvp = true, mitigate = true, hold = false,
    lead = 0, radius = 40, generation = 0,
    entries = setmetatable({}, { __mode = "k" }),   -- bm0: входы блоков по трекам
    armed = setmetatable({}, { __mode = "k" }),     -- boX: взведённые треки
    watched = setmetatable({}, { __mode = "k" }),   -- cKb[50]: подписки по моделям
    blockEntry = nil,               -- bnl["blockEntry"]: вход, по которому идёт блок
    stats = { fired = 0, locked = 0, late = 0, missed = 0, cancelled = 0 },
    mitigate = true,
}
-- Опережающие объявления: на них ссылаются замыкания выше по файлу.
local TrackModel, RequestRelease, BeginBlock, BlockTick, BlockRelease, EntryWindow,
      OnAnimationPlayed, CombatCommand, LastHit, PresetFor

-- bnl == cKb[51]["BlockWork"]: в артефакте это одна и та же таблица.
-- Ссылку ставит сборка (tools/build_recon.py) после создания cKb[51].

-- bnl["in validate"] = F4744 (S2928): пересоздать набор целей блока.
parry["in validate"] = function()                  -- F4744 (S15950)
    parry.generation = parry.generation + 1        -- bnl["generation"] += 1
    table.clear(parry.entries)                     -- table.clear(bm0)
    for model in pairs(parry.watched) do           -- for x in pairs(cKb[50])
        TrackModel(model)                          -- cKb[14](x) — подписаться заново
    end
    RequestRelease()                               -- bpa()
end

-- bnl["reset"] = F6287 (S2928): обнулить счётчики блока
parry["reset"] = function()
    parry["stats"] = { fired = 0, locked = 0, late = 0, missed = 0, cancelled = 0 }
end

local CONFIG = {
    windowNpc = 0.25, windowPvp = 0.1, bias = 0.25, relock = 1,
    defaultRtt = 0.09, reachPad = 8, closingPad = 14, facingMin = -0.35,
    margin = 0.005, acknowledgement = 2,
}

-- ---------------------------------------------------------------------------
-- Мелкие утилиты, которые использует вся подсистема
-- ---------------------------------------------------------------------------
-- cKb[122] в шапках копий — то строка, то функция; по всем местам применения
-- (`not cKb[122](x)` на числах Speed/момент/пинг) это проверка «валидное число».
-- Списки состояний (cKb[80] и boL; в двух сборках они поменяны местами —
-- канон второй: cKb[80] = {Stun, CombatStun} → держать блок,
-- boL = длинный список → бездействовать).
local BLOCK_STATES = { Stun = true, CombatStun = true }
local boL_STATES = {
    Strict_Stun = true, KnockedOut = true, Swapping = true, Training = true,
    ["Cancel"] = true, ["pause_gameplay"] = true, ["combatdisabled"] = true,
    PierceBlock = true,
}

-- bpo = F781 (копия 2: F3490): когда по модели последний раз попали
LastHit = function(model)                              -- bpo (F781)
    if not model then return nil end                 -- S5170/S5171/S5173
    local dmg = model:FindFirstChild("DMG")
    if not dmg then return nil end                   -- S5173/S5168
    return tonumber(dmg:GetAttribute("LastAttacked")) -- S5169
end

local function ValidNumber(value)                   -- cKb[122]
    return type(value) == "number" and value == value
       and value ~= math.huge and value ~= -math.huge
end

-- bol = F4578: сетевой пинг в секундах (Stats.Network.ServerStatsItem.Data Ping)
local function Ping()                               -- bol (F4578)
    local ok, ping = pcall(function()               -- S5375
        return game:GetService("Stats")["Network"]["ServerStatsItem"]["Data Ping"]:GetValue() / 1000
    end)
    if ok and ValidNumber(ping) then                -- S5376/S5373
        return ping
    end
    return CONFIG.defaultRtt                        -- S5377/S5374/S5388 (запас из конфига)
end

-- bmL = F1290: снять вход по треку; при countCancelled — зачесть отмену
local function WithdrawEntry(track, countCancelled)  -- bmL (F1290)
    if not parry.entries[track] then return end      -- S4432
    parry.entries[track] = nil                       -- S4434
    if countCancelled then                           -- S4434/S4433
        local stats = parry["stats"]
        stats["cancelled"] = stats["cancelled"] + 1
    end
end

-- cKb[128] = F853: дотягивается ли цель (плоская дистанция + запас, при strict —
-- ещё и «лицом ли» цель). Тело читается по S5779..S5795.
local function InReach(target, reach, pad, strict)   -- cKb[128] (F853)
    if not target then return false end              -- S5781/S5787
    local parent = target["Parent"]                  -- S5785
    if not parent then return false end              -- S5790/S5793
    local root = cKb[145]()                          -- корень персонажа
    if not root then return false end
    if not parent["Position"] then return false end

    local delta = root["Position"] - parent["Position"]              -- S5791
    local flat = Vector3.new(delta.X, 0, delta.Z)
    if flat.Magnitude > reach + (pad or 0) then return false end     -- S5791/S5789
    if not strict then return true end                               -- S5792/S5784/S5788

    local look = parent["CFrame"] and parent["CFrame"]["LookVector"] -- S5782
    if not look then return false end
    local lookFlat = Vector3.new(look.X, 0, look.Z)
    if lookFlat.Magnitude < 0.01 then return false end               -- S5786
    -- TODO(F853): хвост «< 0.1» — проверка направления; ставлю dot по facingMin
    if flat.Magnitude < 0.01 then return true end
    return lookFlat.Unit:Dot(flat.Unit) >= CONFIG.facingMin
end

-- ---------------------------------------------------------------------------
-- Настройки из меню                                             [F3938 и др.]
-- ---------------------------------------------------------------------------
local function SetAutoParry(value)                  -- F3938
    if parry.on == (value == true) then return end
    parry["in validate"]()                          -- перечитать значения слайдеров
    parry.on = value == true
    if not parry.on then
        bpz["ParryStatus"] = "Off"
    end
end

local function SetParryHold(value)                  -- F6034
    if not parry then return end
    parry["in validate"]()
    parry.hold = value == true
end

local function SetParryLead(value)                  -- F2812
    if not parry then return end
    parry["in validate"]()
    parry.lead = math.clamp(tonumber(value), -120, 120) / 1000    -- мс -> с
end

local function SetParryRadius(value)                -- F1736
    if not parry then return end
    parry["in validate"]()
    parry.radius = math.clamp(tonumber(value) or 40, 10, 150)
end

-- ---------------------------------------------------------------------------
-- Гейт: можно ли сейчас вообще действовать (bnB = F1959)
-- ---------------------------------------------------------------------------
-- local function CanAct() return bnB() end

-- ---------------------------------------------------------------------------
-- Таблица пресетов боя (cKb[34]) и выбор пресета по анимации
--   Пресеты строит cKb[17]() = F3460: по детям папки анимаций собираются записи
--     { folder, preset, combo, running, swing, hit, reach, runTrim }
--   и складываются в cKb[34][<AnimationId без нецифр>] как список.
--   Тело F3460 прочитано частично (форма записи и источники полей:
--   delay_before_swing / delay_before_hit / Reaches / Default_Swing_Wait /
--   run_swing_remove_on_first); сама папка анимаций ещё не определена.
-- ---------------------------------------------------------------------------
local presets = {}                                   -- cKb[34]
parry.presets = presets

-- cKb[108] = F3490: по анимации найти запись пресета
local function PresetFor(animation)                  -- cKb[108] (F3490)
    if not animation then return nil end             -- S522/S527
    local id = tostring(animation["AnimationId"] or ""):match("%d+")   -- S524
    local list = id and presets[id] or nil           -- S525/S529
    if type(list) ~= "table" then return nil end     -- S530/S521
    local folder = animation["Parent"] and animation["Parent"]["Name"]  -- S523
    for _, item in ipairs(list) do                   -- S523 (поиск по папке)
        if item["folder"] == folder then return item end
    end
    return list[1]                                    -- S523 (иначе первая запись)
end

-- ---------------------------------------------------------------------------
-- Подписка на модель (cKb[14], S13307..S13324) + решение по анимации
--   cKb[14](model, isMob): находит Humanoid → Animator (или Animator из
--   Accessories/CustomRig/AnimController), помнит запись в cKb[50][model],
--   вешает AnimationPlayed и прогоняет уже играющие треки.
-- ---------------------------------------------------------------------------
TrackModel = function(model, isMob)                  -- cKb[14]
    if not model then return end                     -- S13310/S13315
    local humanoid = model:FindFirstChildOfClass("Humanoid")      -- S13310
    if not humanoid then return end                               -- S13312
    local animator = humanoid:FindFirstChildOfClass("Animator")   -- S13316

    local rig = model:FindFirstChild("Accessories")               -- S13312/S13324
    if rig then rig = rig:FindFirstChild("CustomRig") end         -- S13324
    if rig then rig = rig:FindFirstChild("AnimController") end    -- S13321
    if rig then                                                   -- S13307/S13325
        animator = rig:FindFirstChildOfClass("Animator") or animator
    end

    local record = parry.watched[model]                           -- S13327
    if record and record["animator"] == animator then return end   -- S13313/S13320
    if not ValidNumber(humanoid["Health"]) then return end         -- S13317/S13318
    if humanoid["Health"] <= 0 then return end                     -- S13326/S13311
    if not animator then return end                                -- S13325

    record = { animator = animator, stopped = {} }                 -- S13323
    parry.watched[model] = record                                  -- cKb[50][model]

    local onTrack = function(track)                                -- chu
        local ok, armed = pcall(OnAnimationPlayed, model, isMob, track, animator)  -- S15682
        if not ok then
            cKb[100]("auto parry:" .. tostring(armed))             -- S15685
            armed = nil
        end
        if armed and record["stopped"][track] == nil then           -- S15684/S15680
            record["stopped"][track] = track["Stopped"]:Connect(function()   -- S821
                WithdrawEntry(track, true)                          -- bmL(track, true)
                parry.armed[track] = nil
                local connection = record["stopped"][track]
                record["stopped"][track] = nil
                if connection then connection:Disconnect() end      -- S823
            end)
        end
    end

    record["played"] = animator["AnimationPlayed"]:Connect(onTrack)
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do   -- S13323 (хвост)
        onTrack(track)
    end
end

-- ---------------------------------------------------------------------------
-- Решение по играющей анимации (boh = F324, S3756..S3779)
--   Если трек ещё не взведён, анимация знакома (cKb[108]), цель в пределах
--   дистанции (cKb[128], closingPad) и проходит фильтр npc/pvp — заводим вход
--   bm0[track] и помечаем boX[track].
-- ---------------------------------------------------------------------------
OnAnimationPlayed = function(model, isMob, track, animator)          -- boh (F324)
    if parry.armed[track] ~= nil then return end         -- S3777/S3765
    if not bnB() then return end                         -- S3762/S3771
    if not parry["on"] then return end
    if not track["IsPlaying"] then return end            -- S3763/S3761

    -- S3756..S3774: фильтр «моб ↔ bnl.npc», «игрок ↔ bnl.pvp»
    -- (в рендере развилка свёрнута непрозрачным предикатом — сверено по смыслу)
    local allowed = (isMob and parry["npc"]) or ((not isMob) and parry["pvp"])
    if not allowed then return end

    local info = cKb[108](track["Animation"])            -- S3759: описание замаха
    if not info then return end                          -- S3776/S3775
    if not InReach(model, info["reach"] or 0, CONFIG["closingPad"], false) then
        return end                                       -- S3760/S3776
    parry.armed[track] = true                            -- S3764
    parry.entries[track] = {                             -- bm0[ate]
        model = model, isMob = isMob, ["in fo"] = info, track = track,
        animator = animator, owner = cKb[9](), generation = parry.generation,
    }
    return true                                          -- S3769
end

-- ---------------------------------------------------------------------------
-- Окно блока по треку (bmN = F2590, S658..S680)
--   Считает момент удара, окно (моб — windowNpc, игрок — windowPvp с поправкой
--   на скорость атаки), пинг (bol) и пишет в вход: earliest/latest/due/
--   protectUntil/window. Возвращает false, если трек ещё не пригоден.
-- ---------------------------------------------------------------------------
EntryWindow = function(entry, now)                       -- bmN (F2590)
    local info, track = entry["in fo"], entry["track"]   -- S658
    if not info or not track then return false end
    local invalid = not ValidNumber(track["Speed"])      -- S658/S672
    if not invalid then invalid = track["Speed"] <= 0 end -- S673
    if invalid then return false end                     -- S660

    local swingStart = track["TimePosition"] / track["Speed"]   -- S661
    local moment = info["hit"]

    if not entry["isMob"] then                           -- S661 → S656 (игрок)
        local speedOf = bno["CombatPresets"] and bno["CombatPresets"]["attackSpeedMult"]
        if not cKb[118](speedOf) then return false end   -- S656/S670
        local ok, speed = cKb[119](speedOf, entry["model"])       -- S662
        if (not ok) or (not ValidNumber(speed)) or speed <= 0 then
            return false end                             -- S674/S659/S665/S671
        moment = info["swing"]
               + math.max(0, info["hit"] - info["runTrim"] - info["swing"]) / speed  -- S678
    end

    if not (ValidNumber(swingStart) and ValidNumber(moment)) then
        return false end                                 -- S655/S679/S660

    local rtt = Ping()                                   -- S668: cgo = bol()
    local window = entry["isMob"] and CONFIG["windowNpc"] or CONFIG["windowPvp"]  -- S675/S663
    local base = now + moment - swingStart - rtt         -- S669

    entry["earliest"] = base - window + CONFIG["margin"]
    entry["latest"] = base - CONFIG["margin"]
    entry["due"] = math.clamp(base - window * CONFIG["bias"] + (parry["lead"] or 0),
                              entry["earliest"], entry["latest"])
    entry["protectUntil"] = base + rtt + 0.03
    entry["window"] = window

    if now > entry["due"] then                           -- S669/S666
        local stats = parry["stats"]
        stats["late"] = stats["late"] + 1
    end
    return true                                          -- S680
end

-- ---------------------------------------------------------------------------
-- Открытие блока: ждём подтверждения сервера и держим, пока нужно  [S1852..]
-- ---------------------------------------------------------------------------
BeginBlock = function(protectUntil)                   -- cKb[143] (S1839..S1857)
    if not bnB() then return false end                          -- S1839/S1840
    if not parry["on"] then return false end                     -- S1844/S1847/S1845
    if not cKb[17]() then                                        -- S1847 → S1842/S1843
        bpz["ParryStatus"] = "Combat presets unavailable"
        return false
    end

    local values = cKb[123]["playerValues"]()                    -- S1837
    if not values then return false end                          -- S1853
    local character = cKb[126]                                   -- S1838
    if not character then return false end                       -- S1857
    if not character:FindFirstChild("Blocking") then return false end   -- S1852/S1853/S1846

    local now = os.clock()
    local entry = {                                              -- S1854
        character = character,
        phase = "awaiting",
        keep = parry["hold"],
        lastHit = nil,
        releaseAt = nil,
        deadline = now + CONFIG["acknowledgement"],
        releaseRequested = false,
    }
    parry["blockEntry"] = entry
    cKb[51]["BlockWork"]["entry"] = entry

    entry["poll"] = function()                                   -- S1854 (хвост)
        return BlockTick(entry)                                  -- boA(cfX)
    end
    entry["connection"] = game:GetService("RunService").Heartbeat:Connect(function()
        BlockRelease(entry, true)                                -- bo_(cfX, true)
        if bnB() then
            local ok, err = pcall(BlockTick, entry)              -- F2175(boA, cfX)
            if not ok then
                cKb[100]("auto parry release:" .. tostring(err))
            end
        end
    end)

    local acknowledged = Signal("server_skill_controller_signaler", "Blocking",
                                "Hold", Vector3.zero)            -- прим. к S1854
    if not acknowledged then
        return true                                              -- сервер не принял
    end

    -- если включён hold — держим ровно 1.5 с (подтверждено трейсом: 1.501..1.510)
    if parry["hold"] then
        entry["releaseAt"] = now + 1.5                           -- cf2 = cfZ + 1.5
    end
    return true
end

-- ---------------------------------------------------------------------------
-- bpa = F1572: попросить отпустить текущий блок (перезагрузка настроек)
--   Если активный вход существует и совпадает с bnl["blockEntry"] —
--   ставим releaseRequested и сразу опрашиваем.
-- ---------------------------------------------------------------------------
RequestRelease = function()                            -- bpa (F1572)
    local entry = cKb[51]["BlockWork"]["entry"]
    if entry and entry == parry["blockEntry"] then               -- S8812/S8809
        entry["releaseRequested"] = true                         -- S8810
        BlockTick(entry)                                         -- boA(cfR)
    end
end

-- ---------------------------------------------------------------------------
-- boA = F5058 (в копии 1 — cKb[41]): «что делать по цели» → "block"/"none"/"parry"
--   Восстановлено по S14886..S14907. Аргумент — модель/персонаж (в артефакте
--   вызов идёт из poll каждого входа: boA(cfX)); принимаем и вход, и модель.
--   Списки состояний: cKb[80] (в копии 2 = {Stun, CombatStun}) → держать блок;
--   boL (KnockedOut, Swapping, Training, Cancel, pause_gameplay, combatdisabled,
--   PierceBlock, Strict_Stun) → не делать ничего.
-- ---------------------------------------------------------------------------
CombatCommand = function(subject)                      -- boA (F5058)
    local model = subject
    if type(model) == "table" and model["model"] ~= nil then model = model["model"] end
    if not model then return "none" end

    local character = cKb[9]()                         -- S14896
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")  -- S14892
    if not humanoid or not ValidNumber(humanoid["Health"]) then return "none" end  -- S14901/S14887
    if humanoid["Health"] <= 0 then return "none" end  -- S14895

    for tag in pairs(boL_STATES) do                    -- S14900
        if model:FindFirstChild(tag) then return "none" end
    end

    local blocking = model:FindFirstChild("Blocking")  -- S14900 (хвост)
    if not blocking then blocking = cKb[126] and cKb[126]:FindFirstChild("Blocking") end  -- S14886
    if not blocking then return "none" end             -- S14906/S14899/S14904
    if not ValidNumber(blocking["Value"]) then return "none" end
    if blocking["Value"] <= 0 then return "none" end    -- S14890

    for tag in pairs(BLOCK_STATES) do                  -- S14897
        if model:FindFirstChild(tag) then return "block" end
    end

    local lastHit = LastHit(model)                     -- bpo(model)
    if not lastHit then return "parry" end             -- S14897 → S14902
    local ok, tick = pcall(function()                  -- S14889
        return bno["Utility"] and bno["Utility"]["Tick"] and bno["Utility"]["Tick"]()
    end)
    if not ok or not ValidNumber(tick) then return "block" end      -- S14893
    if tick - lastHit < CONFIG["relock"] then return "block" end    -- S14894/S14905
    return "parry"                                     -- S14907/S14902
end
BlockTick = CombatCommand                              -- имя из Heartbeat-обвязки

-- ---------------------------------------------------------------------------
-- bo_ = F2854: отпускание блока (state machine S10402..S10435)
--   force=true (вызов из Heartbeat) — «попросить отпустить»: ставим
--   releaseRequested, чтобы следующий виток отправил UnHold.
-- ---------------------------------------------------------------------------
BlockRelease = function(entry, force)                  -- bo_ (F2854)
    if type(entry) ~= "table" then return false end
    if force then                                      -- S10402 (вызов bo_(cfX,true))
        entry["releaseRequested"] = true               -- S10434/S10405
        return true
    end
    if cKb[51]["BlockWork"]["entry"] ~= entry then     -- S10411
        return true                                    -- S10433 → S10406: bo_(arX,false)
    end
    if cKb[9]() ~= entry["character"] then return true end          -- S10415/S10433

    local now = os.clock()                             -- S10435
    local values = cKb[123]["playerValues"]()
    local blocking = values and values:FindFirstChild("Blocking")   -- S10421
    local previous = blocking                          -- S10427 (cfM)

    if entry["phase"] == "awaiting" then               -- S10427/S10428
        entry["block"] = blocking                      -- S10403
        entry["phase"] = "holding"
    elseif entry["block"] ~= previous then             -- S10431/S10422
        if entry["block"] == nil                          -- S10426/S10409/S10407
        or entry["block"]["Parent"] == nil
        or entry["block"]["Parent"] == cKb[126] then
            return true                                -- S10418 → S10430: bo_(arX,false)
        end
    end

    if entry["phase"] == "boxFill" then return false end            -- S10404/S10423
    local wanted
    if not entry["keep"] then                          -- S10414/S10416
        wanted = LastHit(entry["model"]) ~= entry["lastHit"]        -- S10417
    end
    if wanted or (now >= (entry["releaseAt"] or math.huge)) then    -- S10416/S10424
        entry["releaseRequested"] = true               -- S10405/S10434
    end
    if entry["releaseRequested"] and entry["phase"] == "holding" then   -- S10425/S10429
        entry["phase"] = "releasing"                   -- S10408
        entry["deadline"] = now + CONFIG["acknowledgement"]
        Signal("server_skill_controller_signaler", "Blocking", "UnHold", Vector3.zero)
        return true
    end
    if now >= (entry["deadline"] or math.huge) then    -- S10413/S10402
        return true                                    -- bo_(arX, true) → просьба отпустить
    end
    return false                                       -- S10420/S10432
end

-- ---------------------------------------------------------------------------
-- bnl["step"] = F288, строка 38250: надзор за активным входом блока
--   Порядок ветвей восстановлен по состояниям S9478..S9513 (entry=9479).
--   Тексты bpz["ParryStatus"] — дословно из артефакта.
--   TODO(F288): вызов bom() в S9508 и точные переходы двух «непрозрачных»
--   развилок (рендер свернул их в константы) — уточнить сырым телом пула.
-- ---------------------------------------------------------------------------
local function BlockWorkStep()                       -- F288
    local work = cKb[51]["BlockWork"]
    local entry = work["entry"]

    if entry and cKb[118](entry["poll"]) then        -- S9479 -> S9494
        entry["poll"]()                              -- S9511: опрос входа
        entry = work["entry"]                        -- S9508: перечитать
    end

    if entry and entry["character"] ~= cKb[9]() then -- S9501: вход от другого персонажа
        if entry["connection"] then                  -- S9493
            entry["connection"]:Disconnect()         -- S9485
        end
        if work["entry"] == entry then               -- S9509
            work["entry"] = nil                      -- S9484
        end
        entry = work["entry"]
    end

    if not entry then                                -- S9504
        if not parry["on"] then
            bpz["ParryStatus"] = "Off"               -- S9497
            return
        end
        if not cKb[17]() then                        -- S9487: боевые пресеты доступны?
            bpz["ParryStatus"] = "Combat presets unavailable"   -- S9491
            return
        end
        return                                       -- входа нет — докладывать нечего
    end

    if entry["phase"] == "boxFill" then              -- S9490
        bpz["ParryStatus"] = "Block acknowledgement unresolved"          -- S9481
    elseif entry ~= parry["blockEntry"] then         -- S9486
        bpz["ParryStatus"] = "Waiting for previous block release"        -- S9505
    elseif entry["phase"] == "releasing" then        -- S9478
        bpz["ParryStatus"] = "Waiting for block release"                 -- S9483
    else
        local s = parry["stats"]                     -- S9496
        bpz["ParryStatus"] = string.format(
            "%d attempts, %d blocks, %d missed, %d cancelled",
            s["fired"], s["locked"], s["missed"], s["cancelled"])
    end
end
parry["step"] = BlockWorkStep

-- ---------------------------------------------------------------------------
-- cKb[65] = F3871: планировщик блоков (перебор bm0 = parry.entries)
--   Восстановлено по состояниям S360..S386 и вложенным машинам (entry=21,
--   entry=7, entry=0). Две ветви, которые рендер свернул в непрозрачные
--   предикаты, читаются по смыслу (взведение/снятие входа, S13/S3/S18) —
--   отмечено ниже.
--     * первый проход: выбрать САМЫЙ СРОЧНЫЙ вход (cgJ):
--         - негодный (cKb[58])  → bmL(вход, true) — «перевзвести»;
--         - окно не посчитано (bmN(вход, now)) → bmL(вход, true);
--         - просрочен (now > entry.latest) → stats.missed += 1, bmL(вход, false);
--         - в окне (now >= due) и дотягивается (cKb[128](model, info.reach,
--           cKb[61].reachPad, true)) → кандидат; берём с наименьшим latest;
--     * если кандидата нет и нет активного входа (cKb[51].BlockWork.entry) — выход;
--     * cKb[123].playerValues() → cKb[41](values) даёт «block» / «none»;
--       «none» → выход; «block» при выключенном mitigate → выход;
--     * повторные проверки кандидата (cKb[58], latest) — выход, если протух;
--     * собрать группу входов в окне + максимум protectUntil,
--       и если cKb[143](protectUntil) разрешает — зачесть stats (fired, а для
--       «block» — locked) и снять группу: bmL(вход, false).
-- ---------------------------------------------------------------------------
local function ParryScheduler()                      -- cKb[65] (F3871)
    if not bnB() then return end                     -- S373
    if not parry["on"] then return end               -- S385

    local now = os.clock()                           -- S376
    local target = nil                               -- cgJ: самый срочный вход
    for track, entry in pairs(parry.entries) do
        if not EntryValid(entry) then                -- S21
            parry.armed[track] = true                -- bmL(track, true) — S13
        elseif (not entry["due"]) or (not EntryWindow(entry, now)) then   -- S6/S19
            parry.armed[track] = true                -- bmL(track, true) — S18
        elseif not EntryValid(entry) then            -- S9
            parry.armed[track] = true                -- bmL(track, true) — S3
        elseif now > entry["latest"] then            -- S5
            local stats = parry["stats"]
            stats["missed"] = stats["missed"] + 1    -- S8
            WithdrawEntry(track, false)              -- bmL(track, false) — S8
        elseif now >= entry["due"] then              -- S20/S23
            local reach = entry["in fo"] and entry["in fo"]["reach"]
            if InReach(entry["model"], reach, CONFIG["reachPad"], true) then
                if not target or entry["latest"] < target["latest"] then
                    target = entry                   -- S4/S22/S7
                end
            end
        end
    end

    if not target and not cKb[51]["BlockWork"]["entry"] then return end  -- S381/S362/S364

    local values = cKb[123]["playerValues"]()        -- S380
    if not values then return end                    -- S369
    local command = cKb[41](values)                  -- S377
    if command == "none" then return end             -- S386
    if command == "block" and not parry["mitigate"] then return end   -- S383/S374
    if not EntryValid(target) then return end        -- S366
    if os.clock() > target["latest"] then return end -- S371

    -- S378: группа входов в окне + максимум protectUntil
    local group, protectUntil = {}, target["protectUntil"]
    for track, entry in pairs(parry.entries) do
        local earliest = entry["earliest"]
        if earliest and now >= earliest and now <= entry["latest"] then
            group[#group + 1] = track
            protectUntil = math.max(protectUntil or 0, entry["protectUntil"] or 0)
        end
    end

    if BeginBlock(protectUntil) then                 -- cKb[143](protectUntil) — S378
        local stats = parry["stats"]
        if command == "block" then
            stats["locked"] = stats["locked"] + 1    -- S382
        else
            stats["fired"] = stats["fired"] + 1      -- S372
        end
        for _, track in ipairs(group) do             -- S367
            WithdrawEntry(track, false)              -- bmL(track, false)
        end
    end
end

-- bnl, cKb[58] = F4381: годен ли вход блока (S8933..S8961)
--   Проверки: модель жива (Humanoid, Health > 0), фильтр npc/pvp по isMob,
--   поколение входа совпадает с bnl["generation"], аниматор тот же,
--   трек ещё играет, скрипт может действовать.
function EntryValid(entry)
    if type(entry) ~= "table" then return false end
    local model, track = entry["model"], entry["track"]
    if not model or not model["Parent"] then return false end        -- S8959/S8952
    local humanoid = model:FindFirstChildOfClass("Humanoid")         -- S8933
    if not humanoid then return false end                            -- S8934
    if not ValidNumber(humanoid["Health"]) then return false end     -- S8958
    if humanoid["Health"] <= 0 then return false end                 -- S8956/S8947

    if entry["isMob"] then                                           -- S8939/S8935
        if not parry["npc"] then return false end
    else
        if not parry["pvp"] then return false end                    -- S8936/S8944
    end
    if entry["generation"] ~= parry.generation then return false end -- S8946
    if track and not track["IsPlaying"] then return false end        -- S8943
    local record = parry.watched[model]                              -- S8959 (cgz)
    if record and record["animator"] ~= entry["animator"] then return false end
    if not bnB() then return false end                               -- S8952
    return true
end

-- bnl-обёртка Heartbeat: F4910 (S2928). Флаг bn9 — защита от повторного входа.
local schedulerReentrant = false                     -- bn9
local function ParrySchedulerTick()                  -- F4910
    if schedulerReentrant then return end            -- S792
    schedulerReentrant = true
    local ok, err = pcall(ParryScheduler)            -- F2175(cKb[65])
    schedulerReentrant = false                       -- S787
    if not ok and bnB() then                         -- S787/S789/S793
        cKb[100]("auto parry scheduler:" .. tostring(err))   -- S788
    end
end

local schedulerConnection = nil
local function StartParryScheduler()                 -- S2928
    if schedulerConnection then return schedulerConnection end
    parry["in validate"] = parry["in validate"] or function() end
    schedulerConnection = game:GetService("RunService").Heartbeat:Connect(ParrySchedulerTick)
    return schedulerConnection
end

-- ---------------------------------------------------------------------------
-- Кнопка «Reset Counters»                                        [F5094]
-- ---------------------------------------------------------------------------
local function ResetParryStats()                    -- F5094
    for key in pairs(parry.stats) do parry.stats[key] = 0 end
end

return {
    SetAutoParry = SetAutoParry,
    SetParryHold = SetParryHold,
    SetParryLead = SetParryLead,
    SetParryRadius = SetParryRadius,
    ValidNumber = ValidNumber,
    CombatCommand = CombatCommand,
    PresetFor = PresetFor,
    LastHit = LastHit,
    Ping = Ping,
    InReach = InReach,
    WithdrawEntry = WithdrawEntry,
    TrackModel = TrackModel,
    EntryWindow = EntryWindow,
    RequestRelease = RequestRelease,
    BeginBlock = BeginBlock,
    BlockTick = BlockTick,
    BlockRelease = BlockRelease,
    ResetParryStats = ResetParryStats,
    BlockWorkStep = BlockWorkStep,
    EntryValid = EntryValid,
    Scheduler = ParryScheduler,
    SchedulerTick = ParrySchedulerTick,
    StartScheduler = StartParryScheduler,
    state = parry,
    CONFIG = CONFIG,
}

--[[ ============================================================================
  ЕЩЁ НЕ ДОЧИТАНО В АРТЕФАКТЕ (следующий заход):
    * выбор цели: радиус parry.radius, facingMin, reachPad/closingPad, отбор по
      bnl["npc"] / bnl["pvp"] (мобы против игроков);
    * собственно расчёт момента: windowNpc/windowPvp + bias + defaultRtt + lead;
    * ветка mitigate (ставить обычный блок, когда окно недоступно) и relock;
    * счётчики stats (fired/locked/late/missed/cancelled) и вывод ParryStatus;
    * обработка входящего свинга Combat_Service (A3=1, A5=0.13 — замах).
  Пока это помечено как «не дочитано» — не выдаю за готовое.
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- Config: ouroboros_config.lua
-- ---------------------------------------------------------------------------
local Config = (function()

--[[ ============================================================================
  Ouroboros — КОНФИГ: ключи SaveManager, дефолты, экспорт/импорт в буфер
  ----------------------------------------------------------------------------
  Всё вычитано из артефакта ouroboros_ps2 (1).luau (каноническая карта слотов).
  Карта UI — data/UI_MAP.md.

  Библиотека UI (ObsidianUltra) и аддон SaveManager — внешние:
    база   https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/
    файлы  Library.lua, addons/SaveManager.lua, addons/ThemeManager.lua
    папка  MyScriptHub → OuroborosHub/Ouwland,  дефолт-конфиг "Rosewater"
  Здесь воспроизведена та часть, что живёт в самом скрипте: привязка
  «ключ конфига → сеттер», чтение значений из виджетов при загрузке и
  экспорт/импорт JSON-конфига (лимиты и тексты уведомлений — дословно).
============================================================================ ]]

local M = {}

-- Настройки подсистем (таблица cKb[81]; тот же литерал в двух местах артефакта).
-- cKb[81] используется движком перемещения (movementMode, tweenSpeed) и
-- подсистемой подхода к цели (positionType, lookAtEnemy, offset, height).
M.SETTINGS = {
    positionType = "Above",
    lookAtEnemy = true,
    offset = 3,
    height = 0,
    movementMode = "Tween",
    tweenSpeed = 400,
    weapon = "",
    autoSkills = false,
    skills = {},
    holdTimes = {},
}

-- Лимиты импорта — дословно из артефакта (состояния 15274…15290)
M.MAX_IMPORT_BYTES = 262144          -- пул 2988: #текста > 262144 → «too large»
M.MAX_IMPORT_RECORDS = 2048          -- #objects > 2048 → «too many records»

local NOTIFY_TIME = 6                -- пул 1490 (второй аргумент Notify)

-- Привязка «ключ конфига → сеттер» (cKb[51]["Setter"]).
-- Тип виджета: "toggle" — cJc, читает aVS[key]["Value"];  "value" — cJb,
-- читает aVT[key]["Value"].
M.SETTER_OF = {
    PriorityOrder = "SetPriorityOrder",   -- value (cJb)
    PriorityPreempt = "SetPriorityPreempt",   -- toggle (cJc)
    PriorityMode = "SetPriorityMode",   -- toggle (cJc)
    PositionType = "SetPositionType",   -- value (cJb)
    LookAtEnemy = "SetLookAtEnemy",   -- toggle (cJc)
    OffsetDistance = "SetOffsetDistance",   -- value (cJb)
    HeightOffset = "SetHeightOffset",   -- value (cJb)
    MovementMode = "SetMovementMode",   -- value (cJb)
    TweenSpeed = "SetTweenSpeed",   -- value (cJb)
    WeaponChoice = "SetWeapon",   -- value (cJb)
    PotionChoice = "SetPotion",   -- value (cJb)
    DrinkBelow = "SetDrinkBelow",   -- value (cJb)
    ShopItems = "SetShopItems",   -- value (cJb)
    KeepAmount = "SetKeepAmount",   -- value (cJb)
    SkillChoices = "SetSkillSelection",   -- value (cJb)
    AutoSkills = "SetAutoSkills",   -- toggle (cJc)
    MobTarget = "SetMobTarget",   -- value (cJb)
    BossTargets = "SetBossSelection",   -- value (cJb)
    ChestTiers = "SetChestTiers",   -- value (cJb)
    BreathingChoice = "SetBreathing",   -- value (cJb)
    WenMob = "SetWenMob",   -- value (cJb)
    SkillNodes = "SetSkillNodes",   -- value (cJb)
    UnlockSkills = "SetUnlockSkills",   -- toggle (cJc)
    LevelDropForeign = "SetLevelDropForeign",   -- toggle (cJc)
    AutoChest = "SetAutoChest",   -- toggle (cJc)
    QuestTargets = "SetQuestSelection",   -- value (cJb)
    AutoLevel = "SetAutoLevel",   -- toggle (cJc)
    AutoQuest = "SetAutoQuest",   -- toggle (cJc)
    DemonMob = "SetDemonMob",   -- value (cJb)
    DemonDrink = "SetDemonDrink",   -- toggle (cJc)
    DemonDropForeign = "SetDemonDropForeign",   -- toggle (cJc)
    AutoDemon = "SetAutoDemon",   -- toggle (cJc)
    DungeonRange = "SetDungeonRange",   -- value (cJb)
    AutoDungeon = "SetAutoDungeon",   -- toggle (cJc)
    BringRange = "SetBringRange",   -- value (cJb)
    AutoBringEnemies = "SetAutoBringEnemies",   -- toggle (cJc)
    CardTargets = "SetCardSelection",   -- value (cJb)
    BlockBareHands = "SetBlockBareHands",   -- toggle (cJc)
    HealBelow = "SetHealBelow",   -- value (cJb)
    ForceHealCards = "SetForceHealCards",   -- toggle (cJc)
    AutoCards = "SetAutoCards",   -- toggle (cJc)
    AutoSkipWaves = "SetAutoSkipWaves",   -- toggle (cJc)
    AutoMob = "SetAutoMob",   -- toggle (cJc)
    AutoBoss = "SetAutoBoss",   -- toggle (cJc)
    HuntTiers = "SetHuntTiers",   -- value (cJb)
    HuntDropForeign = "SetHuntDropForeign",   -- toggle (cJc)
    AutoBossHunt = "SetAutoBossHunt",   -- toggle (cJc)
    AutoBreathing = "SetAutoBreathing",   -- toggle (cJc)
    AutoSkillTree = "SetAutoSkillTree",   -- toggle (cJc)
    AutoEquipBest = "SetAutoEquip",   -- toggle (cJc)
    AutoPotion = "SetAutoPotion",   -- toggle (cJc)
    AutoBuy = "SetAutoBuy",   -- toggle (cJc)
    FishBait = "SetFishBait",   -- value (cJb)
    AutoBuyBait = "SetAutoBuyBait",   -- toggle (cJc)
    AutoFish = "SetAutoFish",   -- toggle (cJc)
    Trainings = "SetTrainings",   -- value (cJb)
    TrainingMode = "SetTrainingMode",   -- value (cJb)
    AutoTraining = "SetAutoTraining",   -- toggle (cJc)
    LootRange = "SetLootRange",   -- value (cJb)
    AutoLoot = "SetAutoLoot",   -- toggle (cJc)
    SoulRange = "SetSoulRange",   -- value (cJb)
    AutoSoul = "SetAutoSoul",   -- toggle (cJc)
    KillThreshold = "SetKillThreshold",   -- value (cJb)
    ChestKillThreshold = "SetChestKillThreshold",   -- value (cJb)
    ChestInstantKill = "SetChestInstantKill",   -- toggle (cJc)
    NoStun = "SetNoStun",   -- toggle (cJc)
    NoRagdoll = "SetNoRagdoll",   -- toggle (cJc)
    NoAttackSlowdown = "SetNoAttackSlowdown",   -- toggle (cJc)
    InstantKill = "SetInstantKill",   -- toggle (cJc)
    InfiniteStamina = "SetInfiniteStamina",   -- toggle (cJc)
    InfiniteClimb = "SetInfiniteClimb",   -- toggle (cJc)
    InfiniteHorseStamina = "SetInfiniteHorseStamina",   -- toggle (cJc)
    NoDrown = "SetNoDrown",   -- toggle (cJc)
    DisableShiftLock = "SetDisableShiftLock",   -- toggle (cJc)
    NotifyBosses = "SetNotifyBosses",   -- value (cJb)
    NotifyWarnBefore = "SetNotifyWarn",   -- value (cJb)
    NoDashCooldown = "SetNoDashCooldown",   -- toggle (cJc)
    EspRange = "SetEspRange",   -- value (cJb)
}

-- Динамические семейства ключей (ключи строятся в цикле UI, сеттеры получают
-- дополнительный первый аргумент):
--   "SkillHold" .. <ключ скилла>     → SetSkillHold(name, value)      [cKb[51].HoldSkills()]
--   "CardPriority" .. <имя без %W>   → SetCardPriority(name, value)   [cKb[51].CardNames()]
--   уведомления (7): NotifyBosses/NotifyWarnBefore + 6 видов              → SetNotification(kind, v)
--   ESP-опции (9), ESP-цвета (16), ESP-категории (9)                      → SetEspOption/Colour/Category
M.DYNAMIC = {
    skillHold = { prefix = "SkillHold", setter = "SetSkillHold", kind = "value" },
    cardPriority = { prefix = "CardPriority", setter = "SetCardPriority", kind = "value" },
    notifications = {
        kind = "toggle", setter = "SetNotification",
        keys = { NotifyBossSpawns = "boss", NotifyMuzan = "muzan",
                 NotifyMarket = "market", NotifyTailor = "tailor",
                 NotifySelection = "selection", NotifyHunts = "hunt" },
    },
    espOptions = {
        kind = "toggle", setter = "SetEspOption",
        keys = { EspBox = "box", EspBoxFill = "boxFill", EspBox3D = "box3d",
                 EspName = "name", EspDistance = "distance",
                 EspHealthBar = "healthBar", EspHealthText = "healthText",
                 EspTracer = "tracer", EspPlayerInfo = "playerInfo" },
    },
    espCategories = {
        kind = "toggle", setter = "SetEspCategory",
        keys = { EspPlayers = "Players", EspMobs = "Mobs", EspBosses = "Bosses",
                 EspNpcs = "NPCs", EspMuzan = "Muzan", EspSpiderLily = "Spider Lily",
                 EspChest = "Chests", EspHorse = "Wild Horse", EspLever = "Levers" },
    },
    espColours = {
        setter = "SetEspColour",
        -- NB: в одной из копий артефакта часть значений подменена чужими строками
        -- (["EspBoxFill"] = "Warn Me Before" и т.п.) — ключи верны, значения нет.
        keys = { EspNameColour = "name", EspDistanceColour = "distance",
                 EspHealthBarColour = "health", EspDyingColour = "dying",
                 EspHealthTextColour = "healthText", EspPlayerInfoColour = "info",
                 EspEnemyColour = "Players", EspPartyColour = "Party",
                 EspMobsColour = "Mobs", EspBossesColour = "Bosses",
                 EspNpcColour = "NPCs", EspMuzanColour = "Muzan",
                 EspSpiderLilyColour = "Spider Lily", EspChestColour = "Chests",
                 EspHorseColour = "Wild Horse", EspLeverColour = "Levers" },
    },
}

-- Индексы, которые SaveManager не сохраняет: aVR:SetIgnoreIndexes({"MenuKeybind",
-- "SaveManager_ImportSource"}) — состояние 5931/5932.
M.IGNORE_INDEXES = { MenuKeybind = true, SaveManager_ImportSource = true }

-- Ошибки-строки (дословно, пул-индексы в скобках)
M.ERRORS = {
    tooLarge = "That config is too large",                              -- 6087
    tooManyRecords = "That config has too many records",                -- 897
    notValid = "That is not a valid exported config",                   -- 5672
    failedEncode = "Failed to encode the config",                       -- 3725
    noMatch = "No settings in that config matched this script",         -- 5777
    noClipboard = "Your executor does not support copying to the clipboard", -- 698
    copied = "Config copied to clipboard",                              -- 6482
    imported = "Imported %d setting%s",                                 -- 660
}

-- ---------------------------------------------------------------------------
-- Сборка записи по типу виджета (состояния 14251…14270, функция cI9)
-- widget — объект библиотеки; idx — ключ виджета.
-- ---------------------------------------------------------------------------
function M.EncodeRecord(idx, widget)
    local kind = widget["Type"]
    if kind == "Toggle" then
        return { idx = idx, type = "Toggle", value = widget["Value"] == true }
    elseif kind == "Slider" then
        return { idx = idx, type = "Slider", value = tostring(widget["Value"]) }
    elseif kind == "Dropdown" then
        return { idx = idx, type = "Dropdown", multi = widget["Multi"] == true,
                 value = widget["Value"] }
    elseif kind == "Input" then
        return { idx = idx, type = "Input", text = tostring(widget["Value"] or "") }
    elseif kind == "KeyPicker" then
        return { idx = idx, type = "KeyPicker", mode = widget["Mode"],
                 key = widget["Value"], modifiers = widget["Modifiers"],
                 toggled = widget["Toggled"] }
    elseif kind == "ColorPicker" then
        return { idx = idx, type = "ColorPicker", value = widget["Value"]:ToHex(),
                 transparency = widget["Transparency"] }
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Экспорт: собрать {objects = {...}} по таблицам виджетов и положить JSON в буфер
-- (кнопка «Export Config to Clipboard», состояния 5995…5990)
--   toggles = aVS, values = aVT, ignore = M.IGNORE_INDEXES
-- ---------------------------------------------------------------------------
function M.Export(toggles, values, ignore, HttpService, notify, setclipboard, toclipboard)
    ignore = ignore or M.IGNORE_INDEXES
    local objects = {}
    for _, table_ in ipairs({ toggles, values }) do
        for idx, widget in pairs(table_) do
            if type(widget) == "table" and type(widget["Type"]) == "string"
               and not ignore[idx] then
                local record = M.EncodeRecord(idx, widget)
                if record then objects[#objects + 1] = record end
            end
        end
    end
    table.sort(objects, function(a, b)
        if a["type"] ~= b["type"] then return a["type"] < b["type"] end
        return a["idx"] < b["idx"]
    end)

    local ok, payload = pcall(HttpService.JSONEncode, HttpService, { objects = objects })
    if not ok then
        notify(M.ERRORS.failedEncode)
        return false
    end
    if type(setclipboard) == "function" then
        pcall(setclipboard, payload)
    elseif type(toclipboard) == "function" then
        pcall(toclipboard, payload)
    else
        notify(M.ERRORS.noClipboard)
        return false
    end
    notify(M.ERRORS.copied, NOTIFY_TIME)
    return true
end

-- ---------------------------------------------------------------------------
-- Импорт: применить JSON-конфиг к виджетам (состояния 15270…15290)
--   onRecord(record) → true, если запись применена (реализует UI-слой)
--   beginLoad()/settle() — cKb[51]["BeginPriorityLoad"]/["SettlePriority"]
-- ---------------------------------------------------------------------------
function M.Import(text, HttpService, notify, onRecord, beginLoad, settle)
    if type(text) ~= "string" then return false end
    if #text > M.MAX_IMPORT_BYTES then
        notify(M.ERRORS.tooLarge)
        return false
    end
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, text)
    if not ok then
        notify(M.ERRORS.notValid)
        return false
    end
    if type(decoded) ~= "table" or type(decoded["objects"]) ~= "table" then
        notify(M.ERRORS.notValid)
        return false
    end
    if #decoded["objects"] > M.MAX_IMPORT_RECORDS then
        notify(M.ERRORS.tooManyRecords)
        return false
    end
    if beginLoad then beginLoad() end
    local applied = 0
    for _, record in ipairs(decoded["objects"]) do
        if onRecord(record) then applied = applied + 1 end
    end
    if settle then settle() end
    if applied == 0 then
        notify(M.ERRORS.noMatch)
        return false
    end
    notify(M.ERRORS.imported:format(applied, applied == 1 and "" or "s"), NOTIFY_TIME)
    return true
end

-- ---------------------------------------------------------------------------
-- Применение одной записи к виджету (состояния 8825…8840, функция cJa).
-- widget — найденный виджет или nil (тогда запись пропускается).
-- ---------------------------------------------------------------------------
function M.ApplyRecord(record, widget, Color3)
    if type(record) ~= "table" or type(record["idx"]) ~= "string" then return false end
    if not widget then return false end
    if type(record["type"]) ~= "string" then return false end
    pcall(function()
        if record["type"] == "Input" then
            if type(record["text"]) == "string" then widget:SetValue(record["text"]) end
        elseif record["type"] == "Toggle" then
            widget:SetValue(record["value"])
            widget["Toggled"] = record["toggled"]
            widget:Update()
        elseif record["type"] == "Slider" then
            widget:SetValue(record["value"])
        elseif record["type"] == "Dropdown" then
            widget:SetValue(record["value"])
        elseif record["type"] == "ColorPicker" then
            widget:SetValueRGB(Color3.fromHex(record["value"]), record["transparency"])
        elseif record["type"] == "KeyPicker" then
            widget:SetValue({ record["key"], record["mode"], record["modifiers"] })
            if record["mode"] == "Toggle" then
                widget["Toggled"] = record["toggled"]
                widget:Update()
            end
        end
    end)
    return true
end

-- ---------------------------------------------------------------------------
-- Стартовая загрузка (состояния 5931/5932): дефолт → приоритеты → авто-конфиг,
-- затем SettlePriority. Всё — через сеттеры из M.SETTER_OF.
-- ---------------------------------------------------------------------------
function M.LoadAll(toggles, values, setters)
    for key, setterName in pairs(M.SETTER_OF) do
        local setter = setters[setterName]
        if setter then
            local widget = toggles[key] or values[key]
            if widget then setter(widget["Value"]) end
        end
    end
    for _, family in pairs(M.DYNAMIC) do
        local setter = setters[family.setter]
        local keys = family.keys
        if setter and keys then
            for key, argument in pairs(keys) do
                local widget = toggles[key] or values[key]
                if widget then setter(argument, widget["Value"]) end
            end
        end
    end
end

return M

end)()


-- ---------------------------------------------------------------------------
-- UI: ouroboros_ui.lua
-- ---------------------------------------------------------------------------
local UI = (function()

--[[ ============================================================================
  Ouroboros — ИНТЕРФЕЙС (окно, вкладки, группы, виджеты)
  ----------------------------------------------------------------------------
  СГЕНЕРИРОВАНО: tools/gen_ui_widgets.py (дерево из артефакта) +
  tools/gen_ui_lua.py (этот файл). Не править вручную — правьте артефакт/генератор.

  Библиотека — внешняя (ObsidianUltra, WindUI-подобная):
    база  https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/
    файлы Library.lua, addons/ThemeManager.lua, addons/SaveManager.lua
  Загрузчик повторяет артефакт: HttpGet → loadstring → pcall, до 5 попыток,
  проверка «вернулась таблица», warn "[Ouroboros] could not load %s:%s".
============================================================================ ]]

local M = {}

M.BASE_URL = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/"
M.FILES = {
    library = "Library.lua",
    theme   = "addons/ThemeManager.lua",
    save    = "addons/SaveManager.lua",
}
M.SAVE_ROOT = "MyScriptHub"              -- aVQ:SetFolder
M.SAVE_FOLDER = "OuroborosHub/Ouwland"   -- aVR:SetFolder
M.DEFAULT_CONFIG = "Rosewater"           -- aVQ:SaveDefault
M.IGNORE_INDEXES = { "MenuKeybind", "SaveManager_ImportSource" }

M.WINDOW = {
    Title = "Ouroboros",
    Font = Enum.Font.BuilderSans,
    Footer = nil,                       -- см. Footer ниже (Discord/версия)
    Icon = 132608042600488,
    Size = UDim2.fromOffset(860, 660),
    NotifySide = "Right",
    ShowCustomCursor = false,
    CornerRadius = 0,
    SidebarCompacted = true,
    TabSwipeFrom = "bottom",
    Animations = { TabSwitch = true },
}

M.DISCORD = {
    Banner = 95892854151512,
    Avatar = 132608042600488,
    Title = "Ouroboros Hub",
    Subtitle = "Dupes, keyless scripts and updates",
}

-- Загрузчик внешних файлов: 5 попыток, как в артефакте (состояния 1059…1082).
function M.LoadFile(path, services)
    local HttpGet = services.HttpGet
    local wait = services.wait or task.wait
    local warnf = services.warn or warn
    local reason
    for attempt = 1, 5 do
        local ok, data = pcall(HttpGet, M.BASE_URL .. path)
        if ok and type(data) == "string" and data ~= "" then
            local chunk, err = loadstring(data)
            if chunk then
                local ok2, result = pcall(chunk)
                if ok2 then
                    if type(result) == "table" then return result end
                    reason = "returned " .. typeof(result) .. " instead of a table"
                else
                    reason = tostring(result)
                end
            else
                reason = "does not compile (" .. tostring(err) .. ")"
            end
        elseif ok then
            reason = (data == "") and "empty response" or "returned " .. typeof(data)
        else
            reason = tostring(data)            -- нет ответа
        end
        wait(0.2)
    end
    warnf(string.format("[Ouroboros] could not load %s:%s", path, tostring(reason)))
    return nil
end

-- Дерево окна, выгруженное из артефакта (data/ui_tree.json).
M.SPEC = {
    { name = "Farming", icon = "swords", groups = {
        { side = "left", name = "Dungeon Run", icon = "swords", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Run\", cKb [51] [\"DungeonName\"] ()), true" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"DungeonStatus\"]), true" },
            { kind = "Toggle", key = "AutoDungeon", setter = "SetAutoDungeon", text = "Auto Farm Nearby Enemies", default = false, tooltip = "Fights whatever wave enemy is closest, skipping the ones the run excludes" },
            { kind = "Slider", key = "DungeonRange", setter = "SetDungeonRange", text = "Search Range", default = 250, min = 0, max = 2000, suffix = " studs", tooltip = "How far to look for an enemy, 0 searches the whole floor" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"BringStatus\"]), true" },
            { kind = "Toggle", key = "AutoBringEnemies", setter = "SetAutoBringEnemies", text = "Bring Enemies", default = false, tooltip = "Drags every wave enemy this client owns onto you in stead of chasing them; passive spawns are left alone" },
            { kind = "Slider", key = "BringRange", setter = "SetBringRange", text = "Bring Range", default = 2000, min = 0, max = 5000, suffix = " studs", tooltip = "How far out to pull enemies from, 0 brings the whole floor" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"WaveStatus\"]), true" },
            { kind = "Toggle", key = "AutoSkipWaves", setter = "SetAutoSkipWaves", text = "Auto Skip Waves", default = false, tooltip = "Votes to skip each wave break as it opens; the run still needs enough votes to pass" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"CardStatus\"]), true" },
            { kind = "Toggle", key = "AutoCards", setter = "SetAutoCards", text = "Auto Pick Cards", default = false, tooltip = "Takes the best offered card you picked; leaves the hand alone if none of them show up" },
            { kind = "Toggle", key = "BlockBareHands", setter = "SetBlockBareHands", text = "Block Bare Hands Event", default = true, tooltip = "Never takes Bare Hands, in cluding when it arrives on an Event card; that floor bans weapons for 2.2x points and leaves you empty handed after it" },
            { kind = "Toggle", key = "ForceHealCards", setter = "SetForceHealCards", text = "Force Heal Cards", default = false, tooltip = "While your health sits at or below the threshold this takes the hand away from your selection and picks the best heal card in stead; the moment you are back above it your selection has the hand again" },
            { kind = "Slider", key = "HealBelow", setter = "SetHealBelow", text = "Force Heal Below", default = 40, min = 0, max = 100, suffix = "%", tooltip = "0% never forces a heal and 100% always takes one; a hand with no heal card in it is left to your selection either way" },
            { kind = "Dropdown", key = "CardTargets", setter = "SetCardSelection", text = "Select Cards", default = {}, multi = true },
            { kind = "Slider", setter = "SetCardPriority", default = 5, min = 1, max = 10, tooltip = "1 is taken first, 10 last; ties go to the rarer card", label = "CardPriority\" .. cDk:gsub (\"%W\", \"\"), {[\"Text\"] = cDk .. \" Priority\", [\"Tooltip\"] = \"1 is taken first, 10 last; ties go to the rarer card\"," },
        }},
        { side = "left", name = "Dungeon", icon = "swords", widgets = {
            { kind = "Button", action = "Dialogues", text = "Where Are Dungeons?", tooltip = "Explains where the dungeon run features went", label = "{[\"Text\"] = \"Where Are Dungeons?\", [\"Tooltip\"] = \"Explains where the dungeon run features went\", [\"Func\"] = function () local cC1; cC1 = nil" },
        }},
        { side = "left", name = "Auto Farming", icon = "swords", widgets = {
            { kind = "Toggle", key = "AutoLevel", setter = "SetAutoLevel", text = "Auto Level", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"LevelStatus\"]), true" },
            { kind = "Toggle", key = "LevelDropForeign", setter = "SetLevelDropForeign", default = false },
            { kind = "Toggle", key = "AutoQuest", setter = "SetAutoQuest", text = "Auto Farm Quests", default = false, tooltip = "Farms the picked quests on repeat, taking each one again after it is do ne" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"QuestStatus\"]), true" },
            { kind = "Dropdown", key = "QuestTargets", setter = "SetQuestSelection", text = "Select Quests", default = {}, tooltip = "Combat quests whose kill tasks all resolve to a mob this can find", multi = true },
            { kind = "Button", action = "RefreshQuestChoices", text = "Refresh Quests", label = "{[\"Text\"] = \"Refresh Quests\", [\"Func\"] = function () local cVN = cKb [136]; cKb [51] [\"RefreshQuestChoices\"] (); local cVO = F6128 [\"wait\"];" },
            { kind = "Toggle", key = "AutoMob", setter = "SetAutoMob", text = "Auto Farm Mob", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"MobStatus\"]), true" },
            { kind = "Dropdown", key = "MobTarget", setter = "SetMobTarget", text = "Select Mob", default = 1 },
            { kind = "Toggle", key = "AutoBoss", setter = "SetAutoBoss", text = "Auto Boss", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"BossStatus\"]), true" },
            { kind = "Dropdown", key = "BossTargets", setter = "SetBossSelection", text = "Select Bosses", default = {}, multi = true },
            { kind = "Toggle", key = "AutoBossHunt", setter = "SetAutoBossHunt", text = "Auto Boss Hunts", default = false, tooltip = "Claims the hunt or ders posted on the crow board and kills the boss each one names, on repeat" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"HuntStatus\"]), true" },
            { kind = "Dropdown", key = "HuntTiers", setter = "SetHuntTiers", text = "Hunt Tiers", default = {}, tooltip = "Which posted hunts to take.Nothing picked takes any of them", multi = true },
            { kind = "Toggle", key = "HuntDropForeign", setter = "SetHuntDropForeign", text = "Abandon Quest For A Hunt", default = false, tooltip = "There is one quest slot, so switch this on to drop an or dinary quest that is holding it" },
            { kind = "Toggle", key = "AutoDelivery", setter = "SetAutoDelivery", text = "Auto Delivery Quest", default = false, tooltip = "Takes Estate Worker Niko's supply run, carries the box to Shiori, reports back, and starts over" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"DeliveryStatus\"]), true" },
            { kind = "Toggle", key = "AutoChest", setter = "SetAutoChest", text = "Auto Sealed Cache", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"ChestStatus\"]), true" },
            { kind = "Dropdown", key = "ChestTiers", setter = "SetChestTiers", text = "Sealed Cache Tiers", default = {}, multi = true },
            { kind = "Toggle", key = "ChestInstantKill", setter = "SetChestInstantKill", text = "Instant Kill Cache Guards", default = false, tooltip = "Its own Instant Kill, only on the guards around a locked sealed cache and only while Auto Sealed Cache runs" },
            { kind = "Slider", key = "ChestKillThreshold", setter = "SetChestKillThreshold", text = "Damage Before Kill", default = 10, min = 0, max = 100, suffix = "%", tooltip = "How much of a guard's health to take off first, 0% kills it at full health" },
            { kind = "Toggle", key = "AutoLoot", setter = "SetAutoLoot", text = "Auto Loot", default = false, tooltip = "Collects eligible drops and boss chests within the pickup range, with highest priority when loot is ready" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"LootStatus\"]), true" },
            { kind = "Slider", key = "LootRange", setter = "SetLootRange", text = "Pickup Range", default = 150, min = 0, max = 2000, suffix = " studs", tooltip = "How far to travel for a drop, 0 collects at any distance" },
            { kind = "Toggle", key = "AutoSoul", setter = "SetAutoSoul", text = "Auto Claim Souls", default = false, tooltip = "Picks up Weak, Strong and Brave Souls, the Demon progression drops" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"SoulStatus\"]), true" },
            { kind = "Slider", key = "SoulRange", setter = "SetSoulRange", text = "Collect Range", default = 250, min = 0, max = 2000, suffix = " studs", tooltip = "How far to travel for a soul, 0 collects at any distance" },
            { kind = "Toggle", key = "AutoDemon", setter = "SetAutoDemon", text = "Become A Demon", default = false, tooltip = "Runs the whole Muzan route:reputation, the Biwa Bell, the lair, the Spider Lilies, Dr.Higoshima and the blood" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"MaxHealth\"]), true" },
            { kind = "Dropdown", key = "DemonMob", setter = "SetDemonMob", text = "Reputation Mob", default = "Mizunoto", tooltip = "Killed until reputation is low enough for Muzan.Mizunoto slayers move it fastest", multi = false },
            { kind = "Toggle", key = "DemonDrink", setter = "SetDemonDrink", text = "Drink Muzan's Blood", default = true, tooltip = "Off stops at the flask in stead of transforming, so the last step stays yours.Becoming a demon cannot be undone" },
            { kind = "Toggle", key = "DemonDropForeign", setter = "SetDemonDropForeign", text = "Abandon Quest For Muzan", default = false, tooltip = "Muzan only gives the task with the quest slot free, so switch this on to drop whatever is holding it" },
            { kind = "Button", action = "MobTarget", text = "Refresh Mob and Boss Lists", label = "{[\"Text\"] = \"Refresh Mob and Boss Lists\", [\"Func\"] = function () local cVP = cKb [136]; F2175 (function () local cC5 = nil; cC5 = 9; while t" },
        }},
        { side = "left", name = "Breathing", icon = "wind", widgets = {
            { kind = "Toggle", key = "AutoBreathing", setter = "SetAutoBreathing", text = "Auto Breathing", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"BreathStatus\"]), true" },
            { kind = "Dropdown", key = "BreathingChoice", setter = "SetBreathing", text = "Select Breathing" },
            { kind = "Dropdown", key = "WenMob", setter = "SetWenMob", text = "Wen Farm Mob" },
        }},
        { side = "left", name = "Skill Tree", icon = "git-branch", widgets = {
            { kind = "Toggle", key = "AutoSkillTree", setter = "SetAutoSkillTree", text = "Auto Skill Tree", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"SkillStatus\"]), true" },
            { kind = "Toggle", key = "UnlockSkills", setter = "SetUnlockSkills", text = "Unlock Skills", default = false },
            { kind = "Dropdown", key = "SkillNodes", setter = "SetSkillNodes", text = "Select Nodes", default = {}, multi = true },
            { kind = "Button", action = "SkillNodes", text = "Refresh Nodes", label = "{[\"Text\"] = \"Refresh Nodes\", [\"Func\"] = function () local cVQ = cKb; local cVR = cVQ [136]; cVQ [51] [cVR [2375]] (); local cVS = cVR [6128]" },
        }},
        { side = "left", name = "Auto Training", icon = "dumbbell", widgets = {
            { kind = "Toggle", key = "AutoTraining", setter = "SetAutoTraining", text = "Auto Training", default = false, tooltip = "Goes from one training station to the next, do es each one and moves on.Training credit counts towards quests that ask for it." },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"TrainStatus\"]), true" },
            { kind = "Dropdown", key = "Trainings", setter = "SetTrainings", text = "Trainings", default = {}, multi = true },
            { kind = "Dropdown", key = "TrainingMode", setter = "SetTrainingMode", text = "How To Play Them", default = 1, tooltip = "Instantly finishes the moment a station opens.Play It Out plays the game's own minigame in stead, which takes as long as it normally would." },
        }},
        { side = "left", name = "Fishing", icon = "fish", widgets = {
            { kind = "Toggle", key = "AutoFish", setter = "SetAutoFish", text = "Auto Fish", default = false, tooltip = "Gets the fishing permit and a rod if you have none, then fishes at the harbor and always lands the bite" },
            { kind = "Label", label = "bpe [\"field\"] (\"Status\", bpz [\"FishStatus\"]), true" },
            { kind = "Dropdown", key = "FishBait", setter = "SetFishBait", text = "Bait", default = 1, tooltip = "Bait gets used up on every bite" },
            { kind = "Toggle", key = "AutoBuyBait", setter = "SetAutoBuyBait", text = "Auto Buy Bait", default = false, tooltip = "Buys more of the selected bait when you run out" },
        }},
        { side = "left", name = "Tower Exp", icon = "gem", widgets = {
            { kind = "Toggle", key = "AutoBuyExp", setter = "SetAutoBuyExp", default = false, tooltip = "Spends Ouwigahara run points at the Tower Crystal on 1, 000 Exp bundles." },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"CrystalStatus\"]), true" },
            { kind = "Slider", key = "ExpBundles", setter = "SetExpBundles", text = "Bundles Per Trip", default = 99, min = 1, max = 99, tooltip = "99 is the most one purchase can carry; fewer only costs extra trips." },
            { kind = "Slider", key = "PointReserve", setter = "SetPointReserve", text = "Keep Points", default = 0, min = 0, max = 500000, tooltip = "Points held back for the Outfitter racks and the tower chest." },
            { kind = "Button", action = "BuyExpNow", text = "Buy Now", label = "{[\"Text\"] = \"Buy Now\", [\"Func\"] = function () cKb [51] [\"BuyExpNow\"] () end}" },
        }},
        { side = "left", name = "Schematics", icon = "square-pen", widgets = {
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"SchematicStatus\"]), true" },
            { kind = "Dropdown", key = "SchematicTargets", setter = "SetSchematicTargets", text = "Schematics To Collect", default = {}, tooltip = "Which set drawings to go and get.Ones you already have are skipped", multi = true },
            { kind = "Toggle", key = "SchematicReturn", setter = "SetSchematicReturn", text = "Teleport Back When Done", default = true, tooltip = "Puts you back where you started once the last drawing is studied" },
            { kind = "Button", action = "CollectSchematics", text = "Collect Schematics", tooltip = "Teleports to each schematic you picked that you do n't have yet and studies it", label = "{[\"Text\"] = \"Collect Schematics\", [\"Tooltip\"] = \"Teleports to each schematic you picked that you do n't have yet and studies it\", [\"Func\"] =" },
        }},
        { side = "right", name = "Player Info", icon = "user", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Level\", \"1\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Exp\", \"0 / 0\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Wen\", \"0\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Race\", \"-\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Skill Points\", \"0\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Run Points\", \"0\"), true" },
        }},
        { side = "right", name = "Quest Progress", icon = "scroll-text", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Quest\", \"None\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Progress\", \"-\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Breathing Cost\", \"None\"), true" },
        }},
        { side = "right", name = "Notifications", icon = "bell", widgets = {
            { kind = "Toggle", key = "NotifyBossSpawns", setter = "SetNotification", text = "Boss Spawns", default = false, tooltip = "Tells you when one of your bosses spawns, even when it's too far away to see" },
            { kind = "Dropdown", key = "NotifyBosses", setter = "SetNotifyBosses", text = "Bosses", default = {}, multi = true },
            { kind = "Toggle", key = "NotifyMuzan", setter = "SetNotification", text = "Muzan", default = false, tooltip = "Tells you when Muzan comes out at night and where he is.He walks around Mistfall Harbor, Hidden Mist Village or Iceveil Valley" },
            { kind = "Toggle", key = "NotifyMarket", setter = "SetNotification", text = "Black Marketer", default = false, tooltip = "Tells you when the Black Marketer comes to town, what he's selling, and when he leaves" },
            { kind = "Toggle", key = "NotifyTailor", setter = "SetNotification", text = "Tailor Restocks", default = false, tooltip = "Tells you the new clothes whenever Elara or Lynx restocks" },
            { kind = "Toggle", key = "NotifySelection", setter = "SetNotification", text = "Final Selection", default = false, tooltip = "Warns you before Final Selection starts.It happens every 2 hours, and it's how a Human of level 45 or higher becomes a Slayer" },
            { kind = "Slider", key = "NotifyWarnBefore", setter = "SetNotifyWarn", text = 1829555, default = 5, min = 1, max = 30, suffix = " min" },
            { kind = "Toggle", key = "NotifyHunts", setter = "SetNotification", text = "Boss Hunts", default = false, tooltip = "Tells you when a new boss hunt you can take is posted.Hunts are only for Slayers and Demons" },
            { kind = "Button", action = "TeleportToNotification", text = "Teleport to Last Notification", tooltip = "Travels to whatever the last not ification was about", label = "{[\"Text\"] = \"Teleport to Last Notification\", [\"Tooltip\"] = \"Travels to whatever the last not ification was about\", [\"Func\"] = function () cK" },
        }},
    }},
    { name = "Combat", icon = "sword", groups = {
        { side = "right", name = "Consumables", icon = "flask-round", widgets = {
            { kind = "Toggle", key = "AutoPotion", setter = "SetAutoPotion", text = "Auto Potion", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"PotionStatus\"]), true" },
            { kind = "Dropdown", key = "PotionChoice", setter = "SetPotion", text = "Select Potion", default = 1 },
            { kind = "Slider", key = "DrinkBelow", setter = "SetDrinkBelow", text = "Drink Below", default = 40, min = 1, max = 95, suffix = "%" },
        }},
        { side = "right", name = "Shop", icon = "store", widgets = {
            { kind = "Toggle", key = "AutoBuy", setter = "SetAutoBuy", text = "Auto Buy", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"ShopStatus\"]), true" },
            { kind = "Dropdown", key = "ShopItems", setter = "SetShopItems", text = "Select Items", default = {}, multi = true },
            { kind = "Slider", key = "KeepAmount", setter = "SetKeepAmount", text = "Keep Amount", default = 1, min = 1, max = 25 },
        }},
        { side = "left", name = "Farm Settings", icon = "move", widgets = {
            { kind = "Dropdown", key = "PositionType", setter = "SetPositionType", text = "Position Type", default = 1, tooltip = "Where to stand relative to the target while fighting it" },
            { kind = "Toggle", key = "LookAtEnemy", setter = "SetLookAtEnemy", text = "Look At Enemy", default = true, tooltip = "Always face the target, whatever the position type puts you" },
            { kind = "Slider", key = "OffsetDistance", setter = "SetOffsetDistance", text = "Offset Distance", default = 3, min = 0, max = 100, suffix = " studs", tooltip = "How far out from the target to sit, horizontally" },
            { kind = "Slider", key = "HeightOffset", setter = "SetHeightOffset", text = "Height Offset", default = 0, max = 50, suffix = " studs", tooltip = "Vertical offset from the target, positive sits higher" },
            { kind = "Dropdown", key = "MovementMode", setter = "SetMovementMode", text = "Movement Type", default = 1, tooltip = "How to cross ground:Tween glides there, Teleport blinks there in stantly" },
            { kind = "Slider", key = "TweenSpeed", setter = "SetTweenSpeed", text = "Tween Speed", default = 400, min = 50, max = 1000, suffix = " studs/s", tooltip = "How fast to glide, in studs per second" },
        }},
        { side = "left", name = "Equipment", icon = "shirt", widgets = {
            { kind = "Toggle", key = "AutoEquipBest", setter = "SetAutoEquip", text = "Auto Equip Best Equipment", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"EquipStatus\"]), true" },
        }},
        { side = "left", name = "Defence", icon = "RemoveQuest", widgets = {
            { kind = "Toggle", key = "AutoParry", setter = "SetAutoParry", text = "[Beta] Auto Parry V3", default = false, tooltip = "Times a block tap onto each in coming swing so it lands as a perfect block" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"ParryStatus\"]), true" },
            { kind = "Toggle", key = "ParryNpcs", setter = "SetParryNpcs", text = "Parry Mobs", default = true },
            { kind = "Toggle", key = "ParryPlayers", setter = "SetParryPlayers", text = "Parry Players", default = true, tooltip = "Player swings only give a 0.1s window, against 0.25s for a mob" },
            { kind = "Toggle", key = "ParryMitigate", setter = "SetParryMitigate", text = "Block When Parry Is Locked Out", default = true, tooltip = "The game refuses a perfect window while you are stunned, and for one second after any hit lands.This soaks those swings as a normal block for half damage in stead of taking them clean" },
            { kind = "Toggle", key = "ParryHold", setter = "SetParryHold", text = "Keep Blocking After A Parry", default = false, tooltip = "Costs block points and keeps the one second lockout alive, so the next swing cannot be parried.It also holds the block for a second and a half, and the game refuses every skill and every swing while a block is up, so leave it off when Auto Skills is on." },
            { kind = "Slider", key = "ParryLead", setter = "SetParryLead", text = "Parry Timing", default = 0, max = 120, suffix = " ms", tooltip = "Leave at 0 Only touch it if parries keep missing:higher blocks later, lower blocks earlier" },
            { kind = "Slider", key = "ParryRadius", setter = "SetParryRadius", text = "Parry Range", default = 40, min = 10, max = 150, suffix = " studs", tooltip = "How close an enemy has to be before auto parry watches it.The default is fine for melee" },
            { kind = "Button", action = "ResetParryStats", text = "Reset Counters", label = "{[\"Text\"] = \"Reset Counters\", [\"Func\"] = function () local cVZ = cKb [136]; cKb [51] [\"ResetParryStats\"] (); aVP:Notify (\"Parry counters res" },
        }},
        { side = "right", name = "Combat", icon = "sword", widgets = {
            { kind = "Dropdown", key = "WeaponChoice", setter = "SetWeapon", text = "Select Weapon", tooltip = "Leave empty to keep whatever you already have out" },
            { kind = "Button", action = "RefreshWeapons", text = "Refresh Weapons", label = "{[\"Text\"] = \"Refresh Weapons\", [\"Func\"] = function () local cV_ = cKb [136]; cKb [51] [\"RefreshWeapons\"] (); local cV0 = F6128 [\"wait\"]; F39" },
            { kind = "Toggle", key = "AutoSkills", setter = "SetAutoSkills", text = "Auto Skills", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"AutoSkillStatus\"]), true" },
            { kind = "Dropdown", key = "SkillChoices", setter = "SetSkillSelection", text = "Select Skills", default = {}, tooltip = "Leave empty to use every equipped skill.Blocking is left to Auto Parry and never cast from here.", multi = true },
        }},
    }},
    { name = "Priority", icon = "list-or dered", groups = {
        { side = "left", name = "Order", icon = "list-or dered", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Driving\", cKb [51] [\"PriorityHolder\"] ()), true" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"PriorityStatus\"]), true" },
            { kind = "Label", label = "bpe [\"field\"] (tostring (cEu), \"-\"), true" },
            { kind = "Dropdown", key = "PriorityPick", text = "Feature", default = 1, tooltip = "The feature the buttons below move", multi = false },
            { kind = "Button", action = "MovePriority", text = "Move Up", label = "{[\"Text\"] = \"Move Up\", [\"Func\"] = function () local cEe = nil; local cEf = nil; cEf = 1; while true do cEf = 4499 - cEf; do if cEf < 6181 th" },
            { kind = "Button", action = "ResetPriorityOrder", text = "Reset Order", label = "{[\"Text\"] = \"Reset Order\", [\"Func\"] = function () cEk (cKb [51] [\"ResetPriorityOrder\"] ()) end, [\"DoubleClick\"] = true}" },
        }},
        { side = "right", name = "Scheduling", icon = "sliders-horizontal", widgets = {
            { kind = "Toggle", key = "PriorityMode", setter = "SetPriorityMode", text = "Priority Scheduling", default = false, tooltip = "Lets several auto farms stay on at once and gives the character to the highest ranked one that has work" },
            { kind = "Toggle", key = "PriorityPreempt", setter = "SetPriorityPreempt", text = "Comma separated feature keys, highest priority first.Auto Loot stays first.Saved with the config", default = true, tooltip = "A higher ranked feature pauses the running one.Auto Loot always in terrupts when loot is ready" },
            { kind = "Input", key = "PriorityOrder", setter = "SetPriorityOrder", text = "Saved Order", tooltip = 11340532 },
        }},
    }},
    { name = "Player", icon = "person-standing", groups = {
        { side = "left", name = "Movement", icon = "footprints", widgets = {
            { kind = "Toggle", key = "Fly", text = "Fly", default = false },
            { kind = "Slider", key = "FlySpeed", text = "Fly Speed", default = 60, min = 10, max = 400 },
            { kind = "Toggle", key = "NoClip", text = "Noclip", default = false },
            { kind = "Toggle", key = "WalkSpeedEnabled", text = "Speed", default = false },
            { kind = "Slider", key = "WalkSpeed", text = "Speed Amount", default = 32, min = 16, max = 250 },
            { kind = "Toggle", key = "HighJump", text = "High Jump", default = false },
            { kind = "Slider", key = "JumpPower", text = "Jump Power", default = 90, min = 50, max = 400 },
            { kind = "Toggle", key = "AlwaysRun", setter = "SetAlwaysRun", text = "Always Run", default = false, tooltip = "Holds the game's own run toggle do wn so you never walk" },
        }},
        { side = "left", name = "Interaction", icon = "pointer", widgets = {
            { kind = "Toggle", key = "InstantProximityPrompt", text = "Instant ProximityPrompt", default = false },
            { kind = "Toggle", key = "DisableShiftLock", setter = "SetDisableShiftLock", text = "Disable Shift Lock", default = true, tooltip = "Turns the game's Left Alt shift lock back off whenever it comes on" },
        }},
        { side = "left", name = "Sustain", icon = "heart-pulse", widgets = {
            { kind = "Toggle", key = "InfiniteStamina", setter = "SetInfiniteStamina", text = "Infinite Stamina", default = false, tooltip = "Holds your stamina bar full so skills and sprinting stop being refused" },
            { kind = "Toggle", key = "InfiniteClimb", setter = "SetInfiniteClimb", text = "Infinite Climb", default = false, tooltip = "Keeps wall climb time topped up; needs the Wall Climb skill tree node" },
            { kind = "Toggle", key = "InfiniteHorseStamina", setter = "SetInfiniteHorseStamina", text = "Infinite Horse Stamina", default = false, tooltip = "Stops every horse speed mode draining stamina, so Run never times out" },
            { kind = "Toggle", key = "NoDrown", setter = "SetNoDrown", text = "No Drown", default = false, tooltip = "Holds your breath bar full underwater" },
        }},
        { side = "left", name = "Mitigation", icon = "RemoveQuest", widgets = {
            { kind = "Toggle", key = "NoStun", setter = "SetNoStun", text = "No Stun", default = true },
            { kind = "Toggle", key = "NoRagdoll", setter = "SetNoRagdoll", text = "No Ragdoll", default = false },
            { kind = "Toggle", key = "NoAttackSlowdown", setter = "SetNoAttackSlowdown", text = "No Attack Slowdown", default = false },
            { kind = "Toggle", key = "NoDashCooldown", setter = "SetNoDashCooldown", text = "No Dash Cooldown", default = false },
            { kind = "Toggle", key = "NoSunDamage", setter = "SetNoSunDamage", text = "No Sun Damage", default = false, tooltip = "If you're a demon, the sun no longer burns you.Does not hing for other races" },
        }},
        { side = "right", name = "Codes", icon = "ticket", widgets = {
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"CodeStatus\"]), true" },
            { kind = "Button", action = "DisabledTooltip", text = "Redeem All Codes", tooltip = "Redeems every active code, skipping ones already claimed or expired", label = "{[\"Text\"] = \"Redeem All Codes\", [\"Tooltip\"] = \"Redeems every active code, skipping ones already claimed or expired\", [\"DisabledTooltip\"] = \"" },
            { kind = "Label", label = "bpe [\"field\"] (\"Driving\", \"None\"), true" },
        }},
        { side = "right", name = "Instant Kill", icon = "zap", widgets = {
            { kind = "Toggle", key = "InstantKill", setter = "SetInstantKill", text = "Instant Kill", default = false, tooltip = "Kills any NPC your client has network ownership of" },
            { kind = "Label", label = "< font color = \"#e0788c\" > Instant kill is patched but it can still kill enemies, they just won't drop any items < /font > \", true" },
            { kind = "Slider", key = "KillThreshold", setter = "SetKillThreshold", text = "Damage Before Kill", default = 10, min = 0, max = 100, suffix = "%" },
            { kind = "Toggle", key = "OwnershipViewer", setter = "SetOwnershipViewer", text = "Ownership Viewer", default = false, tooltip = "Outlines monsters near you:green ones can be end ed right now, red ones can't" },
            { kind = "Slider", key = "OwnershipRange", setter = "SetOwnershipRange", text = "Viewer Range", default = 250, min = 50, max = 2000, suffix = " studs" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"TeleportStatus\"]), true" },
            { kind = "Dropdown", key = "ZoneTarget", text = "Select Zone", default = 1 },
            { kind = "Button", action = "ZoneTarget", text = "Teleport", label = "{[\"Text\"] = \"Teleport\", [\"Func\"] = function () local cEv, cEw, cEx = nil, nil, nil; local cEy = nil; cEy = 7; while true do cEy = 10562 - cE" },
            { kind = "Button", action = "TeleportToMuzan", text = "Teleport to Muzan", tooltip = "Goes to Muzan while he is out, otherwise to his lair arrival point", label = "{[\"Text\"] = \"Teleport to Muzan\", [\"Tooltip\"] = \"Goes to Muzan while he is out, otherwise to his lair arrival point\", [\"Func\"] = function ()" },
        }},
        { side = "right", name = "Matchmaking", icon = "swords", widgets = {
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"QueueStatus\"]), true" },
            { kind = "Dropdown", key = "QueueModes", setter = "SetQueueModes", text = "Gamemodes", default = {}, tooltip = "Queues for these in turn, skipping any the hub has locked for you", multi = true },
            { kind = "Toggle", key = "QueueRanked", setter = "SetQueueRanked", text = "Ranked", default = false, tooltip = "Queues ranked where the mode offers it; Zenith is ranked either way" },
            { kind = "Toggle", key = "QueueFill", setter = "SetQueueFill", text = "Fill", default = false, tooltip = "Lets the server fill the remaining slots with other players" },
            { kind = "Toggle", key = "AutoQueue", setter = "SetAutoQueue", text = "Auto Queue", default = false, tooltip = "Keeps you in queue and requeues as soon as one end s without a match" },
            { kind = "Button", action = "CancelQueue", text = "Leave Queue", tooltip = "Drops the current queue; the joiner places a new one on its next turn", label = "{[\"Text\"] = \"Leave Queue\", [\"Tooltip\"] = \"Drops the current queue; the joiner places a new one on its next turn\", [\"Func\"] = function () cKb" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"WorldStatus\"]), true" },
            { kind = "Dropdown", key = "WorldTarget", setter = "SetWorld", text = "World", default = 1, tooltip = "The overworld to teleport in to" },
            { kind = "Input", key = "PrivateOwner", setter = "SetPrivateOwner", text = "Private Server Owner", default = "", tooltip = "Username of whoever hosts the private server, yours or a fri end's; leave it empty to join a public server" },
            { kind = "Toggle", key = "AutoWorld", setter = "SetAutoWorld", text = "Auto Join World", default = false, tooltip = "Retries the teleport until it takes, for when the world is full or the hub is still settling" },
            { kind = "Button", action = "JoinWorld", text = "Join World", tooltip = "Teleports once", label = "{[\"Text\"] = \"Join World\", [\"Tooltip\"] = \"Teleports once\", [\"Func\"] = function () cKb [51] [\"JoinWorld\"] () end}" },
        }},
        { side = "right", name = "Unavailable", icon = "triangle-alert", widgets = {
            { kind = "Label", label = "Missing:\" .. table.concat (cKb [123] [\"missing\"], \", \"), true" },
        }},
    }},
    { name = "ESP", icon = "eye", groups = {
        { side = "left", name = "ESP", icon = "eye", widgets = {
            { kind = "Toggle", setter = "SetEspOption", default = false, label = "a38, {[\"Text\"] = a39, [\"Default\"] = false, [\"Callback\"] = function (a4e) cKb [51] [\"SetEspOption\"] (a4a, a4e) end}" },
            { kind = "Label", label = "Dying Colour" },
            { kind = "Slider", key = "EspRange", setter = "SetEspRange", text = "Max Distance", default = 5000, min = 0, max = 20000, suffix = " studs", tooltip = "Hides anything further away than this, 0 shows it at any distance" },
        }},
        { side = "left", name = "World", icon = "globe", widgets = {
        }},
        { side = "right", name = "Player ESP", icon = "users", widgets = {
            { kind = "Toggle", key = "EspPlayers", setter = "SetEspCategory", text = "Player ESP", default = false },
            { kind = "Toggle", key = "EspPlayerInfo", setter = "SetEspOption", text = "Level / Race / Clan", default = false },
            { kind = "Label", label = "Enemy Colour" },
            { kind = "Label", label = "Party Colour" },
        }},
        { side = "right", name = "Discord", icon = "message-circle", widgets = {
        }},
    }},
    { name = "Webhook", icon = "webhook", groups = {
        { side = "right", name = "Shared", icon = "settings-2", widgets = {
            { kind = "Toggle", key = "WebhookSkipQuiet", setter = "SetWebhookSkipQuiet", text = "Skip Empty Reports", default = true, tooltip = "Stay silent when not hing on the in clude list happened." },
            { kind = "Input", key = "WebhookPingId", setter = "SetWebhookPingId", text = "Discord User ID", default = "" },
            { kind = "Toggle", key = "WebhookPing", setter = "SetWebhookPing", text = "Ping Me", default = false, tooltip = "Mentions the user ID above on every report." },
        }},
        { side = "right", name = "Delivery", icon = "s end", widgets = {
            { kind = "Label", label = "cKb [51] [\"WebhookStatus\"] (), true" },
        }},
    }},
    { name = "Settings", icon = "settings", groups = {
        { side = "left", name = "Discord", icon = "message-circle", widgets = {
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Slider", setter = "SetSkillHold", min = 0, suffix = "s", tooltip = "How long to hold this skill before releasing it", label = "cDD [\"key\"], {[\"Text\"] = cDD [\"name\"] .. \" Hold\", [\"Tooltip\"] = \"How long to hold this skill before releasing it\", [\"Default\"] = cDD [\"defau" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Button", action = "SkillChoices", text = "Refresh Skills", label = "{[\"Text\"] = \"Refresh Skills\", [\"Func\"] = function () local cVV = cKb; local cVW = cVV [136]; cVV [51] [cVW [4599]] (); local cVX = cVW [6128" },
        }},
        { side = "left", name = "Menu", icon = "logs", widgets = {
            { kind = "Toggle", key = "AntiAfk", text = "Anti-AFK", default = true },
            { kind = "Label", label = "AFK triggers:0" },
            { kind = "Toggle", key = "AntiGameplayPause", text = "No Gameplay Paused", default = true },
            { kind = "Toggle", key = "AutoReconnect", text = "Auto Reconnect on Kick", default = false },
            { kind = "Toggle", key = "Disable3D", text = "Disable 3D Rendering", default = false },
            { kind = "Toggle", key = "FpsBoost", text = "FPS Boost", default = false },
            { kind = "Toggle", key = "HideUiOnStart", text = "Hide UI On Start", default = false },
            { kind = "Label", label = "Menu bind" },
        }},
        { side = "left", name = "Script", icon = "terminal", widgets = {
            { kind = "Button", text = "Unload Script", label = "{[\"Text\"] = \"Unload Script\", [\"Func\"] = function () local cW0 = cKb [136]; aVP:Unload () end}" },
        }},
    }},
    { name = "Player / Zones", icon = "map-pin", groups = {
    }},
    { name = "Player / NPCs", icon = "user", groups = {
    }},
    { name = "Player / Mobs", icon = "skull", groups = {
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Dropdown", key = "NpcTarget", text = "Select NPC", default = 1 },
            { kind = "Button", action = "NpcTarget", text = "Teleport", label = "{[\"Text\"] = \"Teleport\", [\"Func\"] = function () local cEz, cEA, cEB = nil, nil, nil; local cEC = nil; cEC = 3; while true do cEC = 14126 - cE" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Dropdown", key = "MobTeleport", text = "Select Mob", default = 1 },
            { kind = "Button", action = "MobTeleport", text = "Teleport", label = "{[\"Text\"] = \"Teleport\", [\"Func\"] = function () local cED, cEE, cEF, cEH, cEI, cEJ = nil, nil, nil, nil, nil, nil; local cEG = nil; cEG = 5;" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "ColorPicker", setter = "SetEspColour", label = "a38 .. \"Colour\", {[\"Default\"] = a4c, [\"Title\"] = a39 .. \" Colour\", [\"Callback\"] = function (a4k) cKb [51] [\"SetEspColour\"] (a4b, a4k) end}" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Toggle", setter = "SetEspCategory", default = false, label = "a4t, {[\"Text\"] = a4u, [\"Default\"] = false, [\"Callback\"] = function (a4x) cKb [51] [\"SetEspCategory\"] (a4v, a4x) end}" },
        }},
    }},
    { name = "ESP / Mobs", icon = "skull", groups = {
    }},
    { name = "ESP / Bosses", icon = "crown", groups = {
    }},
    { name = "ESP / NPCs", icon = "user", groups = {
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Button", action = "SendWebhookReport", text = "S end ", label = "{[\"Text\"] = \"S end \" .. cGS .. \" Report Now\", [\"Func\"] = function () cKb [51] [\"SendWebhookReport\"] (cGS, function (a5l, a5m) local cGs = ni" },
            { kind = "Input", setter = "SetWebhookUrl", text = "Webhook URL", default = "", tooltip = "Saved with your config, so do not share that file.", label = "cGJ, {[\"Text\"] = \"Webhook URL\", [\"Default\"] = \"\", [\"Placeholder\"] = cGL, [\"Tooltip\"] = \"Saved with your config, so do not share that file.\"," },
            { kind = "Dropdown", key = "WebhookItemCategories", setter = "SetItemCategories", text = "Name Drops From", tooltip = "Only these categories are listed by name.Materials are left out by default.", multi = true },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Slider", setter = "SetWebhookInterval", text = "Report Every", min = 1, max = 240, suffix = " min", label = "WebhookInterval\" .. cGS, {[\"Text\"] = \"Report Every\", [\"Default\"] = cGH [\"in terval\"], [\"Min\"] = 1, [\"Max\"] = 240, [\"Rounding\"] = 0, [\"Suffix" },
            { kind = "Dropdown", setter = "SetWebhookEvents", text = "Include", tooltip = "Lines left out are not counted and do not keep an otherwise empty report alive.", multi = true, label = "WebhookEvents\" .. cGS, {[\"Text\"] = \"Include\", [\"Values\"] = cKb [51] [\"WebhookEventLabels\"] (cGS), [\"Default\"] = cKb [51] [\"WebhookEventLabel" },
            { kind = "Label", label = "cGH [\"blurb\"], true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Report\", cKb [51] [\"WebhookChannelStatus\"] (cGS)), true" },
            { kind = "Toggle", setter = "SetWebhookEnabled", text = "Enable ", default = false, label = "Webhook\" .. cGS, {[\"Text\"] = \"Enable \" .. cGS .. \" Report\", [\"Default\"] = false, [\"Callback\"] = function (a45) cKb [51] [\"SetWebhookEnabled\"" },
        }},
    }},
    { name = "Webhook / cGS", icon = "cGH [\"icon\"]", groups = {
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Input", key = "SaveManager_ImportSource", text = "Paste exported config here" },
            { kind = "Button", key = "Export Config to Clipboard", action = "HttpService" },
            { kind = "Button", key = "Import Config from Clipboard Text", setter = "SettlePriority", action = "HttpService" },
        }},
    }},
}

-- Опции виджета из спецификации (имена полей — как у библиотеки).
local function options_of(w, handler)
    local options = {}
    if w.text then options.Text = w.text end
    if w.label then options.Text = options.Text or w.label end
    if w.tooltip then options.Tooltip = w.tooltip end
    if w.default ~= nil then options.Default = w.default end
    if w.min ~= nil then options.Min = w.min end
    if w.max ~= nil then options.Max = w.max end
    if w.suffix then options.Suffix = w.suffix end
    if w.multi then options.Multi = w.multi end
    if w.values then options.Values = w.values end
    if handler then options.Callback = handler end
    return options
end

-- Сборка окна. handlers — таблица «setter/action/ключ → функция(value)».
-- Возвращает { window, tabs, toggles, values } (toggles/values — таблицы библиотеки).
function M.Build(Library, handlers)
    handlers = handlers or {}
    local window = Library:CreateWindow(M.WINDOW)
    if window.SetGlow then window:SetGlow(false) end
    local tabs = {}
    for _, spec in ipairs(M.SPEC) do
        local tab = window:AddTab(spec.name, spec.icon)
        tabs[spec.name] = tab
        for _, group in ipairs(spec.groups) do
            local add = (group.side == "right") and tab.AddRightGroupbox or tab.AddLeftGroupbox
            local box = add(tab, group.name, group.icon)
            for _, w in ipairs(group.widgets) do
                local handler = handlers[w.action or w.setter or w.key]
                if w.kind == "Toggle" then
                    box:AddToggle(w.key, options_of(w, handler))
                elseif w.kind == "Slider" then
                    box:AddSlider(w.key, options_of(w, handler))
                elseif w.kind == "Dropdown" then
                    box:AddDropdown(w.key, options_of(w, handler))
                elseif w.kind == "Input" then
                    box:AddInput(w.key, options_of(w, handler))
                elseif w.kind == "KeyPicker" then
                    box:AddKeyPicker(w.key, options_of(w, handler))
                elseif w.kind == "ColorPicker" then
                    box:AddColorPicker(w.key, options_of(w, handler))
                elseif w.kind == "Label" then
                    box:AddLabel(w.text or w.label or "", true)
                elseif w.kind == "Button" then
                    box:AddButton({ Text = w.key or w.label or "", Func = handler })
                end
            end
        end
    end
    local ok, discord = pcall(function() window:AddDiscordBox(nil, M.DISCORD) end)
    return {
        window = window,
        tabs = tabs,
        toggles = Library.Toggles or {},
        values = Library.Values or {},
        discord = ok and discord or nil,
    }
end

-- Хвост инициализации UI (состояния 5931/5932), порядок как в артефакте:
-- дефолтный конфиг → приоритеты → авто-конфиг → SettlePriority.
function M.Finish(ui, library, theme, save, settingsTab, handlers)
    if save then
        save:SetLibrary(library)
        save:SetFolder(M.SAVE_ROOT)
        save:SaveDefault(M.DEFAULT_CONFIG)
        save:ApplyToTab(settingsTab)
        save:IgnoreThemeSettings()
        save:SetIgnoreIndexes(M.IGNORE_INDEXES)
    end
    if theme then
        theme:SetLibrary(library)
        theme:SetFolder(M.SAVE_FOLDER)
        theme:IgnoreThemeSettings()
    end
    if save then save:LoadAutoloadConfig() end
    local handlersT = handlers or {}
    local toggle, settle = handlersT.Toggle, handlersT.SettlePriority
    if library.Toggles and library.Toggles.HideUiOnStart and library.Toggles.HideUiOnStart.Value then
        if toggle then toggle(false) end
    end
    if settle then settle() end
    return ui
end

return M

end)()


-- ---------------------------------------------------------------------------
-- ESP: ouroboros_esp.lua
-- ---------------------------------------------------------------------------
local ESP = (function()

--[[ ============================================================================
  Ouroboros — подсистема «ownership» (подсветка своих/чужих мобов, ESP-метки)
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; номера строк — по ouroboros_main_pruned.txt.

  Роли (проверено по телам пула):
    S2855  bpp = { marks = {} }        -- реестр меток; он же cKb[99]["viewer"]
           cKb[99]["viewer"] = bpp
           bm8 = Color3.fromRGB(60, 255, 120)   -- «наш» моб
           bo9 = Color3.fromRGB(255, 70, 70)    -- «чужой» моб
    F4034  cKb[78](model)  — метка-подсветка Highlight ("OuroborosOuwlandOwnership",
                             DepthMode = AlwaysOnTop, FillTransparency 0.7,
                             OutlineTransparency 0, Adornee/Parent = модель);
                             если метка есть, но без Parent — пересоздать
    F1060  bpp["clear"]()  — снять все метки (по одной через cKb[112])
    cKb[112](model)        — удалить метку модели (Destroy под pcall)
    F3841  bm8 = task.delay(0, …) — цикл «ownership»: каждые 0.2 с подсвечивает
                             мобов ближе tweaks.ownershipRange, зелёным если
                             у модели атрибут ReceiveAge == 0, иначе красным;
                             снимает метки с тех, кого больше нет/далеко.
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Состояние
-- ---------------------------------------------------------------------------
local container = { tweaks = {}, viewer = { marks = {} } }  -- cKb[99] (S2855, F3841)
local viewer = container["viewer"]                   -- bpp
-- Цвета создаются лениво: модуль грузится и там, где Color3 ещё нет (смоук).
local COLORS = {}
COLORS["own"]   = nil                                -- bm8   = fromRGB(60,255,120)
COLORS["other"] = nil                                -- bo9   = fromRGB(255,70,70)
local COLORS_MT = { __index = function(t, key)
    local rgb = (key == "own") and { 60, 255, 120 } or { 255, 70, 70 }
    local ok, color = pcall(function() return Color3.fromRGB(rgb[1], rgb[2], rgb[3]) end)
    t[key] = ok and color or false
    return t[key]
end }
setmetatable(COLORS, COLORS_MT)
local CLEAR_INTERVAL = 0.2                           -- F3916(0.2)

local loopHandle = nil

-- ---------------------------------------------------------------------------
-- Метка модели (cKb[78] = F4034)
-- ---------------------------------------------------------------------------
local function MarkModel(model)                      -- cKb[78] (F4034)
    local mark = viewer["marks"][model]              -- S10507
    if mark then
        if mark["Parent"] then return mark end       -- S10512/S10511
    end                                              -- S10512/S10509 → пересоздать
    mark = Instance.new("Highlight")                 -- S10510 (F5725 = Instance)
    mark["Name"] = "OuroborosOuwlandOwnership"
    mark["DepthMode"] = Enum["HighlightDepthMode"]["AlwaysOnTop"]
    mark["FillTransparency"] = 0.7
    mark["OutlineTransparency"] = 0
    mark["Adornee"] = model
    mark["Parent"] = model
    viewer["marks"][model] = mark
    return mark
end

-- ---------------------------------------------------------------------------
-- Снять метку (cKb[112], S5803..S5805)
-- ---------------------------------------------------------------------------
local function DropMark(model)                       -- cKb[112]
    local mark = viewer["marks"][model]              -- S5805
    if not mark then return end                      -- S5804
    viewer["marks"][model] = nil                     -- S5803
    pcall(function() mark:Destroy() end)
end

-- ---------------------------------------------------------------------------
-- Снять все метки (bpp["clear"] = F1060, S4311)
-- ---------------------------------------------------------------------------
local function ClearMarks()
    for model in pairs(viewer["marks"]) do
        DropMark(model)
    end
end

-- ---------------------------------------------------------------------------
-- Один проход цикла (тело F3841, состояния S752..S759)
--   Возвращает false, когда прохода нет (ownership выключен или нет корня персонажа).
-- ---------------------------------------------------------------------------
local function OwnershipPass()
    local tweaks = container["tweaks"]
    if not tweaks["ownership"] then                   -- S752/S758
        if next(viewer["marks"]) ~= nil then ClearMarks() end   -- F3173 = «не пусто»
        return false                                  -- S753/S757 → clear → return
    end
    local root = cKb[145]()                           -- S754
    if not root then                                  -- S756 (нет корня персонажа)
        ClearMarks()
        return false
    end

    local range = tweaks["ownershipRange"]            -- S759
    local seen = {}                                   -- ciQ
    for _, mob in ipairs(boo()) do                    -- boo = F3280, список мобов
        local model = mob["model"]                    -- S3
        if model then
            local part = model:FindFirstChild("HumanoidRootPart")   -- S3
            if not part then part = model["PrimaryPart"] end        -- S6
            local isPart = part and part:IsA("BasePart")            -- S11
            if isPart then
                local delta = part["Position"] - root["Position"]    -- S4
                if delta["Magnitude"] <= range then                  -- S4
                    seen[model] = true                               -- S13
                    local mark = MarkModel(model)                    -- cKb[78]
                    local color = (part["ReceiveAge"] == 0) and COLORS["own"] or COLORS["other"]
                    if color then                                -- S8
                        mark["FillColor"] = color
                        mark["OutlineColor"] = color
                    end
                end
            end
        end
    end

    for model in pairs(viewer["marks"]) do            -- второй проход (уборка)
        if model["Parent"] == nil or not seen[model] then
            DropMark(model)                           -- cKb[112](ci3)
        end
    end
    return true
end

-- ---------------------------------------------------------------------------
-- Цикл bm8 = task.delay(0, F3841) — запускается один раз
-- ---------------------------------------------------------------------------
-- bm8 = task.delay(0, F3841): while true do
--     if bnB() then pcall(проход) task.wait(0.2) else return end end
local function StartOwnershipLoop(settings)
    if settings then
        if settings["tweaks"] then container["tweaks"] = settings["tweaks"] end
        if settings["viewer"] then container["viewer"] = settings["viewer"]
            viewer = container["viewer"] end
        if settings["marks"] then container["viewer"] = settings end
    end
    if loopHandle then return loopHandle end
    loopHandle = task.delay(0, function()
        while true do
            if not bnB() then return end              -- S227: bnB() = Core.CanAct
            pcall(OwnershipPass)                      -- S225: F2175(проход)
            task.wait(CLEAR_INTERVAL)                 -- F3916(0.2)
        end
    end)
    return loopHandle
end

-- bnB (Core.CanAct) — псевдоним артефакта из сборки (заголовок модулей, §6).

return {
    container = container,
    viewer = viewer,
    COLORS = COLORS,
    MarkModel = MarkModel,
    DropMark = DropMark,
    ClearMarks = ClearMarks,
    OwnershipPass = OwnershipPass,
    StartOwnershipLoop = StartOwnershipLoop,
}

--[[ ============================================================================
  ЧТО ЕЩЁ НЕ ДОЧИТАНО:
    * сам ESP (окно/вкладка ESP): cKb[51]["SetEspOption"/"SetEspColour"/
      "SetEspCategory"/"SetEspRange"] и дальше bna = { on = {}, entries = {},
      screen, ["in fo"] = {}, anyOn = false } (строка 22702) + cKb[147] —
      палитра (name/distance/health/dying/healthText/["in fo"]/Players/Party/
      Mobs/Bosses/NPCs/Muzan/Spider Lily/Chests/Wild Horse/Levers);
    * bpo/MobList хвост: у F3280 могут быть доп. поля (у нас используется model).
============================================================================ ]]

end)()


-- ---------------------------------------------------------------------------
-- 4b. ДАННЫЕ: строки пула cKb[136] (из data/pool_index.json) и константы
-- ---------------------------------------------------------------------------
local POOL = {
    [1] = "fish", [2] = 841, [3] = 2497, [4] = 2993805, [5] = "Hides anything further away than this, 0 shows it at any distance", [6] = 132,
    [7] = " report delivered", [8] = 3130, [9] = "boxFill", [10] = 3494, [11] = "rsyh", [12] = 18,
    [13] = 2896, [14] = "Mythic", [15] = "Mitigation", [16] = "Keeps wall climb time topped up; needs the Wall Climb skill tree node", [17] = 33, [18] = 2662,
    [19] = 422.42, [20] = "Nothing chosen, Bare Hands blocked", [21] = "collect", [22] = "SetEspDistance", [23] = 1110, [24] = 3188,
    [25] = "Abandon Quest", [26] = "Swings active, no target damage; check pose (%.1f studs) or immunity", [27] = "SetAutoCards", [28] = "ReplicatedStorage", [29] = 3257, [30] = "[Ouroboros] priority interrupt: ",
    [31] = "HeldSkill", [32] = "UDim2", [33] = 641.34, [34] = "Blood Hounded Demon", [35] = "workQuest", [36] = "footer",
    [37] = 1046754374, [38] = "ytdxg", [39] = 1304, [40] = 444, [41] = 3141, [42] = 2632,
    [43] = 1400, [45] = "Waiting for ", [46] = 3703, [47] = "FinalSelection", [48] = "Boulder Split", [50] = 3438.52,
    [52] = 1070, [53] = "CU", [54] = "Waiting for night (%ds)", [55] = "parry", [56] = "cache", [57] = 1215,
    [58] = 1834, [59] = 529, [60] = 743, [61] = 2927, [62] = 1000, [63] = "isParty",
    [64] = 2621, [65] = "Tally", [66] = 3220, [67] = 973, [68] = "TRAINING_NAMES", [69] = "LairArrival",
    [70] = 1064, [71] = "PREEMPT_COOLDOWN", [72] = "%d Wen (have %d)", [73] = 3810, [74] = "at", [75] = 2544,
    [77] = 3163, [78] = "run_swing_remove_on_first", [79] = 887, [81] = 1598, [82] = "Auto Delivery Quest", [83] = "PARRY_GAP",
    [85] = 1313183642, [86] = "Delivered", [87] = "Sign", [88] = 1689, [89] = "AutoBringEnemies", [90] = 187,
    [91] = 2071, [92] = 1227, [93] = 1798, [94] = "EspBox", [95] = " has spawned", [96] = 2120,
    [97] = 10062112, [98] = "TweenService", [99] = "Double_Jump", [100] = 2965481, [101] = "MovementRelative", [102] = 2099,
    [104] = "Add", [105] = 2470, [106] = "dungeonName", [107] = "Rule", [108] = 7394623, [109] = "byLabel",
    [110] = 2494, [111] = 2499, [112] = "Minigames Place", [113] = "zqkhoax", [114] = 817, [115] = "InputHandler",
    [116] = "byKey", [117] = 3196, [118] = "SkillHold", [119] = 2213, [120] = 13152669, [121] = "owns",
    [122] = "nhsxhbt", [123] = 3438688, [124] = 302027, [125] = "Paste an exported config into the box first", [126] = 3517, [128] = "exgefp",
    [129] = "Asking Muzan for the task", [131] = "Stop", [132] = "Souls", [133] = "Copied Discord invite to clipboard", [134] = 446, [135] = "Claims the hunt orders posted on the crow board and kills the boss each one names, on repeat",
    [136] = 3098, [137] = "Outlines monsters near you: green ones can be ended right now, red ones can't", [139] = "BLINK_HOLD", [140] = "DMG", [141] = 101, [142] = "ServerClientPortal module",
    [143] = 3514, [144] = 1821, [145] = "named", [146] = "Akazo", [147] = 4262748, [148] = 765,
    [149] = "Color3.fromRGB", [150] = "Cannot take a selected quest", [151] = "Instant Kill", [152] = "Collects eligible drops and boss chests within the pickup range, with highest priority when loot is ready", [153] = "FogEnd", [154] = "zfbo",
    [155] = 180, [156] = "Stopped", [157] = "Player Info", [158] = "attempts", [159] = 3962, [160] = 1915,
    [161] = 3508, [162] = 0.7, [164] = 568.75, [165] = 1138, [166] = "Checker", [167] = "protectUntil",
    [168] = 2786, [169] = 400, [170] = 8172489, [171] = "Body", [172] = "SetBreathing", [173] = 1009,
    [174] = "function()returnbpz[cKb[136][2494]]end", [175] = "store", [176] = "Kanoe Demon Slayer", [178] = 730, [179] = "ShopItems", [180] = "Hub",
    [181] = "ynmwxb", [182] = 4249684, [183] = 2811, [184] = "Chest ESP", [185] = "DayAndNightHandler", [186] = 3044,
    [188] = 9, [189] = 2670, [190] = "ltrassxj", [191] = 11113705, [192] = "AutoDemon", [194] = 4055,
    [195] = "CardNames", [196] = 2341, [197] = 949, [198] = 7181143, [199] = "earnPermit", [200] = "FISHING_RODS",
    [201] = "AutoDismiss", [202] = "Hunt Tiers", [203] = 4728076, [204] = "uwpfnr", [205] = "BlockBareHands", [206] = "None",
    [207] = "mode", [208] = "ReaperTrainee", [209] = "thread", [210] = "0", [211] = "boss", [212] = "SetMobTarget",
    [213] = 7404060, [214] = "%ds", [216] = "code", [217] = 1164880343, [218] = 234, [219] = 88,
    [220] = "%d cast, all on cooldown", [221] = 6832550, [222] = 12803533, [223] = 3366, [224] = "dvnygmdghder", [225] = "Obari",
    [226] = "BARE_HANDS_CARD", [227] = 883.8, [228] = 3466, [229] = "OuroborosHub/Ouwland", [230] = "Drags every wave enemy this client owns onto you instead of chasing them; passive spawns are left alone", [231] = "MainHolder",
    [232] = "mbqeguzxlqu", [233] = 749, [234] = 1079.33, [235] = "closeOnNpc", [236] = "Ping", [237] = "forceHeal",
    [239] = 3615, [240] = "Floors", [241] = 26447066, [242] = "luoq", [243] = 1210, [244] = "Select Potion",
    [245] = "NPC ESP", [246] = 2676, [247] = "Default", [248] = "label", [250] = 2684, [251] = "<@%s>",
    [252] = 2145, [253] = 2782, [254] = 9288524, [255] = 718, [256] = "Platform_Handler module", [257] = "Request",
    [258] = "DungeonStatus", [259] = 4045, [260] = "MobStatus", [262] = "FISHING_BAITS", [263] = 2032, [264] = "SetBossSelection",
    [265] = 1384, [267] = "Communication", [268] = 4074, [269] = 1679, [270] = 1519, [271] = 3961588,
    [272] = 3506, [273] = "EspDistance", [274] = 2275, [276] = "spftkml", [277] = "Never takes Bare Hands, including when it arrives on an Event card; that floor bans weapons for 2.2x points and leaves you empty handed after it", [278] = 3646,
    [279] = "Rengu", [280] = 150107, [281] = 2373122982, [282] = "DungeonHelp", [283] = "step", [284] = "A namespace is required",
    [285] = "Refresh Skills", [286] = "vlcp", [287] = "gcjxjvbo", [289] = 11576306, [290] = "Accent", [291] = "FishingRod",
    [292] = 2595, [293] = 1307, [294] = 2866, [295] = "Combat quests whose kill tasks all resolve to a mob this can find", [296] = 640, [297] = 3567,
    [298] = 14916519, [299] = 8169954, [300] = "TextLabel", [301] = "Waiting for night to find Muzan", [302] = "tliuctomch", [303] = 1767,
    [304] = "Nothing to reel in", [305] = 1156480, [307] = "QuestInstance", [308] = "lastClaim", [309] = "path", [310] = "KeyCode",
    [311] = 803755, [312] = 705, [313] = "Fights whatever wave enemy is closest, skipping the ones the run excludes", [314] = "Auto Boss Hunts", [315] = 11707552, [316] = "%S",
    [317] = "EspBox3D", [318] = "AutoMob", [319] = "TweenInfo", [320] = 2498, [321] = "Enemies", [322] = 3069162,
    [323] = "Floors Cleared", [325] = "Looted", [326] = 44148085, [327] = "Claiming ", [328] = "Enabled", [329] = 574,
    [330] = "add", [331] = "Asking Muzan for the bell", [332] = 967, [333] = 1224.2, [335] = "kcinktzwsqh", [336] = "Quests Completed",
    [337] = "Amount", [338] = "SetOwnershipViewer", [339] = "HealBelow", [340] = 1896, [341] = "ORBIT_SPEED", [342] = "point",
    [343] = 2251, [344] = 2597, [345] = 942, [346] = 4030, [347] = 3317, [348] = 2370,
    [349] = "OwnershipViewer", [350] = "drop", [351] = "Executor has no isnetworkowner", [352] = "Strong Soul", [353] = "No cards offered", [354] = "sisk",
    [355] = 837, [356] = "place", [357] = 1474, [359] = "SetInstantKill", [360] = 69.22, [361] = "BOSS_GUARDS",
    [362] = "ksa", [364] = 14594910, [365] = "Menu validators", [366] = 5394557, [367] = "qiaq", [368] = "Bought",
    [369] = "RotatingShop module", [370] = "oysjrgfkktl", [371] = 781.5, [372] = "Ball", [373] = "No Sun Damage", [374] = 20,
    [375] = "person-standing", [376] = "earliest", [377] = "ShowCustomCursor", [378] = 2739, [379] = 3878, [380] = 2048,
    [381] = 4008468592, [382] = 1747, [383] = 870, [384] = 2770, [385] = 103, [386] = "No quest for level ",
    [387] = 3591, [388] = "camera", [389] = 3675, [390] = 218, [392] = "Puts you back where you started once the last drawing is studied", [393] = 2571,
    [394] = 13937759, [395] = "LootDrop", [396] = 1888, [397] = 2554, [398] = 15262927, [399] = "attackSpeedMult",
    [400] = "SetAutoChest", [401] = 108, [403] = "Attachment0", [404] = "coroutine.create", [405] = "EspHealthBar", [406] = 3456,
    [407] = 3375, [409] = 932.69, [410] = "higoshima", [411] = "No permit quest in this place", [412] = 2228, [413] = "SchematicRunner",
    [414] = 770.52, [415] = "no response", [416] = 1688626, [417] = "refused", [418] = 3133, [419] = 3892,
    [420] = 10, [421] = 2677809881, [423] = 3662, [424] = 1227910604, [425] = "all", [426] = 5419101,
    [427] = 1673223, [430] = 2490, [431] = "POTION_NAMES", [432] = "Numeric", [433] = 251, [435] = "PriorityOrder",
    [436] = 1850, [437] = 1856, [438] = "xkbz", [439] = "BossTargets", [440] = 3314, [441] = 14159783,
    [442] = 539, [443] = "ZoneTarget", [446] = "Epic", [447] = 2996, [448] = 1652, [449] = "Icon",
    [450] = 3691, [451] = 476.99, [452] = "pubr", [453] = "Search Range", [454] = 2190, [455] = "retryAt",
    [456] = 1108, [457] = "CodeBusy", [458] = "Souls Collected", [459] = 547, [460] = 2307, [461] = " min",
    [462] = 3113, [463] = "ghsehmfrffz", [464] = 3965, [466] = 0, [468] = "Dupes, keyless scripts and updates", [469] = "pssu",
    [470] = 943, [471] = 851, [472] = "ngzaisa", [473] = "pause_gameplay", [474] = 2516, [475] = "s",
    [476] = "efmij", [477] = "Returning to ", [478] = "commit", [480] = 757, [481] = "rnkiun", [483] = 1145,
    [484] = "Health Bar", [485] = "brrxc", [486] = "Clock", [487] = "sync", [488] = "tcfpojnt", [489] = "preemptedAt",
    [490] = 2997, [491] = "A", [495] = "Watching for cards", [496] = "One", [497] = 2404, [499] = 483834,
    [500] = "NotifyWarnBefore", [501] = "Retrying ", [502] = 3277, [503] = 928, [504] = 2389, [505] = "iisfft",
    [506] = 5501509, [507] = "lrhkujuu", [508] = 1655, [509] = "ldpnivkcbn", [510] = 3199454, [511] = "BOSS_STREAM_GRACE",
    [512] = 2279, [513] = "Boss hunt in the quest slot", [515] = "CRYSTAL_POSITION", [516] = "HudGrid", [517] = "lpaffpwjp", [519] = 193,
    [520] = 3760, [521] = "Reaper", [523] = "slow_walk_duration", [524] = "PrivateServerHostable", [525] = "expPerLevel", [526] = "Ill learn ",
    [527] = "RemoveQuest", [528] = 366, [529] = "ParryPlayers", [530] = 3983, [531] = "Swapping", [532] = 153,
    [533] = 268, [535] = 714.73, [536] = 3755, [537] = "http", [538] = "TabSwipeFrom", [539] = "Tower Exp",
    [540] = 865, [542] = 2090, [543] = 9211145, [544] = "function()returnbpz[cKb[136][4449.]]end", [545] = 3971, [546] = "RaycastParams",
    [547] = 10419126, [548] = "LiveConfig module", [549] = 1547, [550] = 543.9, [551] = 3565, [552] = "Escorting Dr. Higoshima %d/%d",
    [553] = 525.38, [554] = "settings", [555] = "Cannot take the permit quest", [556] = "Lets several auto farms stay on at once and gives the character to the highest ranked one that has work", [557] = 269, [558] = "Unlocked ",
    [559] = 10514440, [560] = "oqoh", [561] = "Redeem All Codes (%ds)", [562] = 3263770966, [563] = "demx", [564] = "SetLookAtEnemy",
    [565] = "Reset Order", [566] = "Values", [567] = "AnimationId", [568] = "bellosgudwoa", [569] = 3851, [570] = 157,
    [571] = "OfferNpc", [572] = "Additional Damage Factor", [573] = 3960, [574] = 2635.57, [576] = " Breathing learned", [577] = 1948,
    [578] = 1421, [579] = "Human", [580] = "SetAutoBossHunt", [581] = 2895, [582] = " Schematic", [583] = "AnimationPlayed",
    [584] = 312, [585] = "Abandoning ", [586] = 774, [587] = 3420, [588] = 1365, [589] = 10233087,
    [590] = "Arrived at ", [591] = "progress", [592] = 1653, [594] = 361, [596] = 3444, [597] = 582,
    [598] = 525, [599] = 1456, [600] = 3949059254, [601] = " studs/s", [602] = 7160191, [603] = "Muzan Quest taken",
    [604] = 859, [605] = 2015, [606] = 1928, [607] = "Refreshed skills", [609] = 2815, [610] = "OnUnload",
    [611] = "Nothing to travel to", [612] = 5403107, [613] = 516437976, [616] = "Positions", [617] = 1468, [618] = "Shared",
    [620] = "cancelSkill", [621] = 1403671826, [623] = "denial", [624] = "navkjjs", [625] = "Hoyuzo Subordinate", [626] = "jel",
    [627] = 3794226, [628] = "TweenInfo.new", [630] = "Only these categories are listed by name. Materials are left out by default.", [631] = 63, [632] = "Queue is not available here", [633] = 880,
    [634] = 994, [635] = 3259, [637] = "lymcih", [638] = 6561018, [639] = "hpse", [640] = 8594346,
    [641] = "Banner", [642] = 2549, [643] = "Travelling to Muzan", [644] = 16509786, [645] = "HighlightDepthMode", [647] = 3658,
    [648] = 164, [649] = "elmp", [650] = 12383851, [652] = "Look At Enemy", [654] = 131, [655] = "Humanoids",
    [656] = "Locked", [658] = 130835525, [659] = 2660, [660] = "Imported %d setting%s", [661] = "J", [662] = 3980,
    [663] = "HEAL_CARDS", [664] = "Mode", [665] = 843, [666] = 2178, [667] = 326, [668] = 1315,
    [669] = "Movement", [670] = "CFrame", [671] = "wanted", [674] = "DemonDrink", [676] = "delay", [677] = "CombatSkills",
    [678] = 252, [679] = 2655158189, [680] = "Basic Fishing Rod", [681] = "zxfcp", [682] = 12212341, [683] = "Switching to ",
    [684] = 3031, [685] = 402, [686] = 2820, [687] = "How far to travel for a drop, 0 collects at any distance", [688] = "SkillService", [689] = "https://discord.com/api/webhooks/...",
    [690] = "side", [691] = 3814, [692] = 47, [694] = 3982, [695] = "Cleanup incomplete: ", [696] = "Inside",
    [697] = 1219, [698] = "Your executor does not support copying to the clipboard", [699] = 1837, [700] = 3678, [701] = "resourceTick", [702] = 3276492288,
    [703] = "Highlight", [704] = 4075, [705] = 3865, [706] = "lncgiqpnd", [707] = "Four", [709] = "noSlowdown",
    [710] = "ParticleEmitter", [713] = "MinigameRunEnded", [714] = 648, [715] = "Teleport", [716] = 1022, [717] = "UnCommon",
    [718] = "[Ouroboros] delivery step: ", [719] = "Boss Spawns", [720] = 346, [721] = 11122146, [722] = 465, [723] = "SetNoStun",
    [724] = 17043533, [725] = "vyisiw", [726] = "scccawebdpx", [727] = "color", [728] = "wyjmh", [729] = "ResetPriorityOrder",
    [730] = 125, [731] = 2813, [732] = 939, [733] = 1249, [735] = "Value", [736] = 1639809106,
    [737] = "ifrwftuai", [738] = "IsBranch", [740] = "time", [741] = "ChestId", [742] = 3917, [743] = "uloevojamvo",
    [745] = "Reputation", [746] = ": ", [748] = "Farms the picked quests on repeat, taking each one again after it is done", [749] = 3986, [750] = "Picked", [751] = "[Ouroboros] loop error: ",
    [752] = "RaycastParams.new", [753] = 45, [754] = "imkmr", [755] = 1923, [756] = 681, [757] = 2875822680,
    [758] = "LootDrops", [759] = 2775, [760] = "gggfceu", [761] = "ErrorPrompt", [762] = 1617, [763] = 915,
    [764] = "SetForceHealCards", [765] = "SetAutoBreathing", [766] = 2286, [767] = 4010, [768] = 2826, [769] = "Auto Join World",
    [770] = "N", [771] = 1264, [772] = "radius", [773] = "ready", [775] = 377, [777] = 1588,
    [778] = "SchematicReturn", [779] = 6787780, [780] = "AddQuest", [782] = "Network", [783] = "Tool_Mouse", [784] = 4103642534,
    [785] = 2665, [786] = 1177, [788] = "Part0", [789] = "Giyen", [791] = 211, [792] = 687,
    [793] = "Insect", [794] = "Farming", [795] = "setOption", [797] = 3249, [798] = 1272, [799] = 3501781,
    [800] = "hiimk", [801] = 3199, [804] = "Outfits", [805] = 3114748634, [806] = "Refreshed quest list", [807] = 1469,
    [809] = "Drink Below", [810] = "url", [812] = "window", [814] = 2591715, [815] = 2859, [817] = 4086,
    [818] = "mpkutb", [819] = 3351, [820] = "Auto Reconnect on Kick", [821] = 8152065, [822] = "Block When Parry Is Locked Out", [823] = "ActionText",
    [824] = 3639, [825] = 15450116, [826] = "udqicq", [827] = 1751, [829] = "bhzihoqdvoi", [830] = 946,
    [831] = "PotionStatus", [832] = "voted", [833] = "Reset", [834] = "yksszssxuo", [835] = 1281, [836] = "lastDamage",
    [837] = "canClaim", [838] = "ValueBase", [839] = 1930, [840] = "MinigameWaveBreak", [842] = 2220, [843] = ":",
    [844] = "ermgbxzksz", [846] = 3419, [847] = "ywnfiglp", [848] = "glny", [849] = 2833, [850] = "CancelQueue",
    [851] = 838, [852] = "Cannot take ", [854] = 3306, [855] = 368, [856] = "NpcSpawns", [857] = "SetAutoDemon",
    [858] = "HigoshimaSafeRadius", [859] = 5276014, [860] = "Times a block tap onto each incoming swing so it lands as a perfect block", [861] = 9288903, [862] = "wasted", [863] = 9400992,
    [864] = 1616, [865] = 6559242, [866] = 3970, [867] = "Order", [868] = "QuestController", [869] = "RotatingShop",
    [870] = 3001, [871] = 2893, [872] = "Requeueing", [873] = "Type", [874] = 28, [875] = 886,
    [876] = 1702126565, [877] = 5535280, [878] = "ZoneCache", [879] = 261.5, [880] = "margin", [881] = 1920.59,
    [882] = 9100988, [883] = "content", [884] = "Waiting for inventory", [885] = "Equipped ", [886] = "Select Cards", [887] = 1794,
    [888] = 777, [889] = 2953, [890] = 3685, [891] = "^Swing_(%d+)$", [893] = 1271, [894] = 925,
    [895] = 117, [896] = "Finish or drop ", [897] = "That config has too many records", [898] = 40106911, [899] = "DisplayName", [902] = "bpqche",
    [903] = 43, [904] = "Domae", [905] = 4909328, [906] = "Zone", [907] = "ozyztm", [908] = 860,
    [909] = "Viewer Range", [910] = "Box Fill", [911] = 212, [912] = 1287, [913] = "HigoshimaSpawn", [914] = 825.68,
    [915] = 1950, [916] = "inputError", [917] = "Out of ", [919] = 1124, [920] = 4190784600, [923] = "Bite",
    [924] = "\\u{203A} Hearts  **%s**", [925] = 1065, [926] = "%s+$", [927] = 113, [928] = "key", [930] = "resolveAt",
    [932] = "EspPartyColour", [933] = 9926679, [934] = "ParryNpcs", [935] = "VirtualUser", [936] = "Fly", [937] = 3731730,
    [938] = "__mode", [939] = "Z", [940] = 7577460, [941] = "KaruVillageBandit", [942] = "UnlockSkillTreeNode", [943] = "bossNames",
    [945] = "ldzworpz", [946] = 14782252, [947] = 2729, [948] = 1044, [949] = "cancel", [950] = 2149,
    [951] = 2191, [952] = "Combat_presets", [953] = 214, [954] = "Stay silent when nothing on the include list happened.", [955] = "qfzihoz", [956] = 502.63,
    [957] = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/", [958] = "Once", [959] = "DisabledTooltip", [960] = 7890012, [961] = 1730, [962] = "No ",
    [963] = "MaxValue", [964] = "ItemCategory", [965] = "Fresh", [966] = "Final Selection", [967] = 709, [968] = "nearestLily",
    [969] = 2891, [971] = "OuwigaharaOffers", [972] = "%1,%2", [973] = "WorldController", [974] = "Post", [975] = "refreshAnyOn",
    [976] = "Joining ", [977] = 691, [978] = 2711028246, [979] = "Report failed", [980] = "No cards selected", [981] = "lkdqgnem",
    [982] = "Takes the best offered card you picked; leaves the hand alone if none of them show up", [983] = "FPS Boost", [984] = 700, [985] = 1011, [986] = "POST", [987] = 2763352,
    [988] = 599.04, [989] = 1135, [990] = 136, [991] = 2976, [992] = 15981026, [993] = "RaycastFilterType",
    [995] = "yqnwbazmxfg", [996] = "Sound Trainee", [997] = "No Dash Cooldown", [998] = 812.23, [999] = "bobber", [1000] = "Waiting for a wave break",
    [1001] = "type", [1002] = "AlwaysRun", [1003] = 8087583, [1004] = "Interrupt Lower Priority", [1005] = 2141, [1006] = 2065,
    [1007] = "qpu", [1008] = "^(.+)_Combat_Anims$", [1009] = "ugpurlhcpdb", [1010] = 2127, [1011] = "noStun", [1012] = "The feature the buttons below move",
    [1013] = 26, [1014] = "Iceveil Settlement", [1015] = "Serpent Trainee", [1016] = "Thunder", [1017] = 839965, [1019] = 1105,
    [1020] = 780, [1021] = 2584, [1022] = 10954996, [1023] = " Priority", [1024] = 908, [1025] = "queueSignal",
    [1026] = 3665, [1027] = "en", [1028] = 1562, [1029] = 466, [1030] = "MAX_LEVEL", [1031] = 3473,
    [1032] = 1154, [1033] = 7382265, [1034] = "SoulRange", [1035] = "health", [1036] = 552, [1037] = 171.7,
    [1039] = 3189, [1040] = "timing", [1041] = "Ouwland", [1042] = "trees", [1043] = 3702, [1044] = "STAT_WEIGHTS",
    [1045] = "jgccgwmubh", [1046] = 15459732, [1047] = 3484, [1048] = "Active", [1049] = "Enable ", [1050] = 4837579,
    [1051] = 3037, [1052] = "SetSkillSelection", [1053] = "Horse", [1054] = "[Ouroboros] demon step: ", [1055] = 1985, [1056] = "modes",
    [1057] = "LastAttacked", [1058] = 3873, [1059] = 3166263, [1061] = "CardField", [1062] = 2388, [1063] = "ClickDetector",
    [1064] = 183.6, [1065] = 15244995, [1066] = 240, [1067] = "ShopController", [1068] = 3379, [1069] = "does not compile (",
    [1070] = "  <driving>", [1071] = "skm", [1073] = 3339, [1074] = "MouseButton1Up", [1075] = 5599643, [1076] = "RopeConstraint",
    [1077] = "gamemodeAllowed", [1079] = "TRAINING_TIMEOUT", [1080] = "Goes to Muzan while he is out, otherwise to his lair arrival point", [1081] = " has no private servers", [1082] = 1378, [1083] = "wants",
    [1084] = "setOrder", [1085] = "Shrink", [1086] = "releaseAt", [1087] = 2305, [1088] = "Stopped short of ", [1089] = 219,
    [1090] = "Weapon", [1091] = "SetAutoBoss", [1092] = "Revive", [1093] = 43995749, [1094] = 1425, [1095] = 2360,
    [1096] = "TransformLength", [1097] = "AutoDelivery", [1098] = "inputs", [1099] = "Previous instance did not release its namespace", [1100] = "items", [1101] = 1129,
    [1102] = 1825, [1103] = "Cannot afford the bundle", [1104] = "watch", [1105] = "Hoyuzo", [1106] = "MinigameSkipNeeded", [1107] = "item",
    [1108] = 3470615666, [1109] = 3283, [1110] = 3544, [1111] = "DeliveryStatus", [1112] = 60, [1113] = "moves",
    [1114] = 12, [1115] = 261, [1116] = "[Ouroboros] mob step: ", [1117] = "%s %d", [1118] = 520, [1119] = 341,
    [1120] = "%d / %d", [1121] = 15144417, [1122] = "Five", [1123] = "%s %d/%d", [1124] = "tbuksi", [1126] = "Stone",
    [1127] = 2108, [1128] = "ESP", [1129] = 3653, [1130] = "TrainController", [1131] = 2195, [1132] = 3714,
    [1133] = "Variant", [1134] = "The permit needs level %d", [1135] = 1776, [1136] = "Catalog", [1137] = "skull", [1138] = "threshold",
    [1139] = "Unavailable", [1140] = " did not register", [1141] = 388.87, [1142] = 206, [1143] = "Accessories", [1144] = "bosses",
    [1145] = "Waiting for game combat readiness", [1146] = "^%s+", [1147] = 396.44, [1148] = "describePlayer", [1149] = "Tasks", [1150] = 1023.5,
    [1151] = 1612, [1152] = "gykbbahizzt", [1153] = "Thunder Trainee", [1154] = "promptIn", [1155] = 2947, [1156] = 2476,
    [1158] = 2594, [1159] = "Cannot learn ", [1160] = "HighJumpKey", [1161] = 181119, [1163] = "GlobalShadows", [1164] = "LootRange",
    [1165] = "Cancel", [1167] = "Bought %d exp for %d points", [1168] = 3260, [1169] = "MAX_LOOK_PITCH", [1170] = "Checker module", [1171] = "ItemFolder",
    [1172] = 1813.01, [1173] = "No Attack Slowdown", [1174] = 13905510, [1175] = "Wind", [1176] = "PotionNames", [1177] = "idx",
    [1179] = "Lets the server fill the remaining slots with other players", [1180] = "No schematics selected", [1181] = 51, [1182] = "No skills equipped", [1183] = 284, [1184] = "region",
    [1185] = "vlbifxi", [1186] = 2732, [1187] = 77, [1188] = 6479665, [1189] = 10085436, [1190] = "Auto Farm Quests",
    [1191] = 5976282, [1193] = "Auto Training", [1194] = 0.07, [1195] = "IgnoreGuiInset", [1196] = " items", [1197] = "Wen",
    [1199] = 3913, [1200] = "Pick an NPC first", [1201] = 2704, [1202] = "hnwn", [1203] = "overlay", [1205] = 2377,
    [1206] = 625, [1208] = "Block Regen", [1209] = "axymwp", [1210] = "Pod", [1211] = 175, [1212] = 2776,
    [1214] = 2819, [1215] = 3543, [1216] = 98, [1217] = "tua", [1218] = "StudyProp", [1219] = 5,
    [1220] = 205497344, [1221] = 1076, [1223] = 14737652, [1224] = 883, [1225] = 1549, [1226] = "Discord",
    [1227] = "Server refused ", [1228] = "Cannot use ", [1229] = 1554, [1230] = 379.11, [1231] = 185, [1232] = "CardTargets",
    [1233] = "wwagpfyixh", [1234] = "Combat_presets module", [1235] = 1402, [1236] = "EspMuzanColour", [1237] = 3404, [1238] = 3210,
    [1239] = "Already collecting schematics", [1240] = 3673, [1241] = "TweenSpeed", [1242] = "Farming Wen %d/%d", [1244] = 144, [1245] = 836,
    [1246] = 2596320875, [1247] = 646795, [1248] = " is not on your toolbar", [1249] = "Biwa Bell", [1250] = "clock", [1251] = 140,
    [1252] = 1927, [1254] = " Hold", [1255] = "viewer", [1256] = "interrupt", [1257] = "New ", [1258] = "pending",
    [1259] = 2102, [1260] = 3411, [1261] = "map-pin", [1262] = 3522, [1263] = "Iceveil Valley", [1264] = "Lines left out are not counted and do not keep an otherwise empty report alive.",
    [1265] = 2420, [1266] = "max", [1268] = 3620, [1269] = "Enum", [1270] = "lajr", [1271] = 2329,
    [1272] = 4167650, [1273] = 3803, [1274] = 1687, [1276] = "zhbbrmsofdxt", [1278] = 2153, [1279] = 712.9,
    [1280] = "CardStatus", [1281] = 32.83, [1283] = "Holding ", [1284] = 3043, [1285] = "SetTrainingMode", [1286] = "Weak Soul",
    [1287] = 2299, [1288] = "Input", [1289] = 1020, [1291] = "SetAutoLevel", [1292] = "inCombat", [1293] = "Infinite Climb",
    [1294] = "dqwzvvhlmtc", [1295] = "DemonController", [1296] = 3096, [1297] = 815, [1298] = "EspMobsColour", [1300] = "Redeeming ",
    [1301] = 5337542, [1302] = 1617157414, [1303] = "Public servers", [1304] = "Chest", [1305] = 1005, [1307] = "CurPower",
    [1308] = "Wall Climb", [1309] = 4049, [1310] = "PriorityPreempt", [1311] = "QueueRanked", [1312] = 3224, [1313] = 237,
    [1314] = 6390516, [1315] = 5322795, [1316] = "DungeonRange", [1317] = "Holder", [1318] = "SetHeightOffset", [1321] = 2410,
    [1322] = "DialogueName", [1323] = 3911, [1324] = 2743, [1325] = "nkzhrko", [1326] = "Searching for Muzan", [1327] = 4004,
    [1328] = "set", [1330] = "Waiting for a bite", [1331] = 2078, [1332] = "zap", [1333] = 2582346555, [1334] = 8080668,
    [1335] = 3415558, [1336] = 150, [1337] = "Select Breathing", [1338] = "ToggleKeybind", [1339] = 2376, [1340] = 1488,
    [1341] = "Loaded", [1342] = "Channels", [1343] = "pajgocaplnib", [1344] = 439, [1345] = "Report", [1346] = 1445,
    [1347] = "SetAutoBuy", [1348] = 2362, [1349] = 2322874, [1351] = 1909, [1352] = 2184, [1353] = "Level01",
    [1354] = 1706, [1355] = 3, [1356] = "Waited", [1357] = 1018.88, [1358] = 3856, [1359] = 16425972,
    [1360] = 1651, [1361] = "geaypxkgzohl", [1362] = "99 is the most one purchase can carry; fewer only costs extra trips.", [1363] = "CODE_MOBS", [1364] = "push", [1365] = 1280,
    [1366] = 20191393, [1367] = 1329, [1368] = " yet", [1369] = "features", [1370] = "Auto Buy Bait", [1372] = 3304,
    [1373] = "%s  |  every %d min", [1374] = "WalkSpeed", [1375] = 16662136, [1376] = 493, [1377] = "AssemblyLinearVelocity", [1378] = "Events",
    [1379] = 254, [1380] = "play", [1382] = "OuwigaharaLastPickRarity", [1383] = 346130827, [1385] = 3074, [1386] = "priority",
    [1387] = "Gyorei", [1388] = 109805635, [1389] = "Back", [1390] = "BarHolder", [1391] = 3194, [1392] = "RagdollConstraints",
    [1393] = "Unload Script", [1394] = 200, [1395] = 3787, [1396] = 1016, [1397] = "SetQuestSelection", [1398] = "SkillNodeCache",
    [1399] = 830, [1400] = "No Gameplay Paused", [1401] = "user", [1402] = 2709, [1403] = 389, [1404] = "KillThreshold",
    [1405] = "CHEST_GUARD_RANGE", [1406] = "addons/SaveManager.lua", [1407] = 1600, [1408] = "BREATHINGS", [1409] = 1267, [1410] = "GetCycleIndex",
    [1411] = "KeyPicker", [1413] = "TeleportStatus", [1414] = "EspNpcs", [1415] = "kmvl", [1416] = 1471, [1417] = "teleporter",
    [1418] = 31, [1419] = 1074, [1420] = 2344, [1421] = "Teleports once", [1422] = "script", [1423] = "Right",
    [1425] = "Texture", [1426] = 1663, [1427] = "bvulo", [1428] = "igj", [1429] = "SetSkillHold", [1430] = "Health Elixir",
    [1431] = 3323, [1432] = "Height Offset", [1433] = "pkprgqzm", [1434] = "No combat item in toolbar", [1435] = 16418816, [1436] = 3215,
    [1437] = 3997, [1438] = "UI unload required", [1439] = "height", [1440] = 46, [1441] = "controller", [1442] = 1569,
    [1443] = 3728, [1444] = "Stun", [1445] = "Muzan npc module", [1446] = "Auto Sealed Cache", [1447] = "SpawnCountdown", [1448] = 2713,
    [1449] = "WorldStatus", [1450] = "ServerAndClient", [1451] = 3705, [1452] = "Tengai", [1453] = "ValidUrl", [1454] = "Box",
    [1455] = "noDrown", [1457] = "ExtraLife", [1458] = 3820, [1459] = 12293006, [1461] = "AnchorPoint", [1462] = 1001,
    [1463] = "Anti-AFK", [1464] = 282906, [1465] = 3516, [1466] = 1156, [1467] = 1003, [1468] = "Sound",
    [1469] = 4005, [1470] = "PlayerProfile", [1471] = "Landing the bite", [1472] = 941, [1474] = "Reputation %d of %d, killing %s", [1475] = "getBell",
    [1476] = 944, [1477] = 3598, [1478] = 3842, [1479] = 408413932, [1480] = 602, [1481] = "Drank ",
    [1482] = "Toggled", [1483] = "CARD_NAMES", [1485] = "Cooldown", [1486] = "ownership", [1487] = "crystalPoint", [1488] = 2693,
    [1489] = 1180, [1490] = 6, [1491] = 2124887, [1492] = 11249781, [1493] = "Leave at 0. Only touch it if parries keep missing: higher blocks later, lower blocks earlier", [1494] = 2579,
    [1495] = "SkillsProvider", [1496] = "chestKill", [1497] = "Summoning ", [1498] = 1522, [1499] = 162444, [1500] = "SetTweenSpeed",
    [1501] = "Refresh Quests", [1502] = "HudGrid module", [1503] = 420, [1504] = "Health %d%%", [1505] = 1038, [1506] = 104,
    [1507] = "online", [1508] = "healGate", [1509] = 3369, [1510] = "unlockSkills", [1511] = "pressing", [1513] = "Waiting for boss drops",
    [1514] = "Ranked", [1515] = 2900.49, [1516] = 2158, [1517] = 1043.24, [1518] = 6012262, [1519] = 623140791,
    [1520] = "lastUsed", [1523] = "logs", [1524] = 14491062, [1525] = "stats", [1526] = "wind", [1527] = "redeemed",
    [1528] = "BreathStatus", [1529] = 3061, [1530] = "Lost ", [1531] = 697, [1532] = "Health Regen Elixir", [1533] = "SkipQuiet",
    [1534] = "remember", [1535] = "behrpsagw", [1536] = "anchorPart", [1537] = 2306, [1538] = "askMuzan", [1539] = "ServerClientPortal",
    [1540] = "multi", [1541] = "Waiting for Muzan's Blood", [1542] = "ouuc", [1543] = 1559, [1544] = "Costs block points and keeps the one second lockout alive, so the next swing cannot be parried. It also holds the block for a second and a half, and the game refuses every skill and every swing while a block is up, so leave it off when Auto Skills is on.", [1545] = "Bait gets used up on every bite",
    [1546] = 12480818, [1547] = 9, [1548] = 2925, [1549] = 3623, [1550] = "windowNpc", [1551] = "Waiting for the current skill",
    [1552] = "Suffix", [1553] = 2687, [1554] = "\\u{203A} Nothing since the last report", [1555] = "AutoSkipWaves", [1556] = "nodes", [1557] = 0.01,
    [1558] = 13906407, [1559] = "Grove Raider", [1560] = 1427492, [1561] = 378, [1562] = "uino", [1563] = "Options",
    [1564] = 510, [1565] = "string", [1566] = "izkjauxpslz", [1567] = 4695965, [1568] = "Neck", [1569] = 2303,
    [1570] = "Matchmaking", [1571] = "uoaesb", [1573] = 12939089, [1574] = "Map", [1575] = "ClassName", [1576] = 1889,
    [1577] = "fields", [1579] = 1765, [1580] = 225, [1581] = "WebhookInterval", [1582] = 3380, [1583] = " left",
    [1584] = 1595, [1586] = "cgacpvwlyw", [1587] = "default_before_hit", [1588] = "Redeems every active code, skipping ones already claimed or expired", [1590] = "T3", [1591] = "PlayerSummary",
    [1592] = 1503, [1595] = 1199, [1596] = 2877, [1597] = 2594.49, [1598] = 3499, [1599] = "Linear",
    [1600] = "market", [1601] = 3556, [1602] = "SetDungeonRange", [1603] = "CombatRunHit", [1604] = "MainMenuRelay", [1605] = "Elara",
    [1606] = "Join World", [1607] = 668, [1608] = "hijzyz", [1609] = "clear", [1610] = "pqzpbkfh", [1611] = 699,
    [1612] = "SpawnTime", [1613] = "How far out from the target to sit, horizontally", [1614] = 9603970, [1616] = 1876, [1617] = 12456369, [1618] = 1077,
    [1619] = 1017.64, [1621] = "\\u{203A} Floor  **%s**", [1622] = "Bear Cub", [1623] = "asg", [1624] = "bossNearby", [1625] = "attribute",
    [1626] = 833, [1627] = 1735, [1628] = "SHCS", [1629] = 3786, [1630] = "stallUntil", [1631] = 2281,
    [1632] = "Colour", [1634] = "Stunned or locked out", [1635] = "Holds the game's own run toggle down so you never walk", [1636] = 3874, [1637] = "jfcvxwaqacs", [1638] = 3681,
    [1639] = "goal", [1640] = 2171, [1641] = 2128, [1642] = "Training ", [1643] = 1380.92, [1644] = "Clipboard is unavailable",
    [1645] = "huntWatch", [1646] = 2261, [1647] = 866, [1648] = "returned", [1649] = 258, [1650] = "No player values",
    [1651] = 1605, [1652] = "TaiChiTrainee", [1653] = "autoSkills", [1654] = "bait", [1655] = "myshhgtxgh", [1656] = "tlujkonoaj",
    [1657] = "HUNT_TIERS", [1658] = "pfvrctgjuor", [1659] = 1632, [1660] = "UnHold", [1661] = "Higoshima", [1662] = "Color",
    [1663] = "StaminaDrain", [1664] = 332, [1665] = 1390, [1666] = 1381, [1667] = "Already redeeming codes", [1668] = "isOpened",
    [1671] = "nextWeapon", [1672] = 1602, [1673] = "model", [1674] = 183, [1675] = 3324, [1676] = "awaitUntil",
    [1677] = 3589, [1678] = "SaveManager_ImportSource", [1680] = "yieldFrom", [1681] = "worldStep", [1682] = "kirbyootgb", [1683] = "#6a7080",
    [1684] = "TeleportToMob", [1685] = "answerBites", [1686] = 5345690, [1687] = 1995, [1688] = "Trainings", [1689] = "FooterButtons",
    [1690] = "NotifyMarket", [1691] = 494, [1692] = "slot", [1693] = 941.57, [1695] = 1515, [1696] = 2211,
    [1697] = "Bring Range", [1698] = 3138, [1699] = 3386, [1700] = "last_performed", [1701] = 1083, [1702] = "hmcoaunaaprx",
    [1704] = 1238, [1706] = "EXP_LISTING", [1707] = "CanSee", [1708] = "ExpBundleCost", [1709] = 1332.09, [1710] = "Keeps you in queue and requeues as soon as one ends without a match",
    [1711] = "boolean", [1712] = "SHOP_VENDORS", [1713] = 1.2, [1714] = "wre", [1715] = 4029, [1716] = 184,
    [1717] = "MobTeleport", [1718] = "Bait", [1719] = "Model", [1720] = "irbzl", [1721] = 315, [1722] = "tatycqyegtg",
    [1723] = "Rare Fishing Rod", [1724] = "healthText", [1725] = 3085, [1726] = "wcquo", [1727] = "FillColor", [1728] = "FrozenYeti",
    [1729] = 11946753, [1730] = 314, [1731] = 237.78, [1732] = "played", [1733] = 958, [1734] = "Hold",
    [1737] = 15, [1738] = 3602451, [1739] = "Abandon Quest For A Hunt", [1740] = 8661856, [1741] = 1326, [1742] = "Level / Race / Clan",
    [1743] = 3310, [1744] = "PlayerProfile module", [1745] = 3290, [1746] = "How close an enemy has to be before auto parry watches it. The default is fine for melee", [1747] = 1626, [1748] = "TimePosition",
    [1749] = "Behind", [1750] = 1416, [1752] = 544, [1753] = "kzfpvnebfoge", [1754] = "Comma separated feature keys, highest priority first. Auto Loot stays first. Saved with the config", [1755] = 3045,
    [1756] = "dying", [1757] = "Rarities", [1758] = "uncommit", [1760] = "EspLever", [1761] = 1263, [1763] = 1036,
    [1764] = "Running ", [1765] = "cxvhbolxskkr", [1768] = "Queues for these in turn, skipping any the hub has locked for you", [1769] = 1844, [1770] = "holdTimes", [1771] = "Collected ",
    [1772] = "You are a demon", [1773] = "lilies", [1774] = "tokbofkxq", [1776] = 597, [1777] = "gnqse", [1778] = "EligibleReputation",
    [1779] = "queueStep", [1780] = "PlaybackState", [1781] = "opened", [1782] = 2407, [1783] = "rxnzbvryrfy", [1784] = "Yeti Demon",
    [1786] = 3350, [1787] = 443, [1788] = "Skill Tree", [1789] = "redu", [1790] = "QuestChoices", [1791] = 9365538,
    [1792] = "Zuko", [1793] = 7916754, [1794] = "cards", [1795] = "PierceBlock", [1796] = "SetAutoMob", [1797] = 1190,
    [1798] = "Dragger", [1799] = "(.)", [1800] = 3893, [1802] = "Teleports", [1803] = "PlayerProfile.skill_info", [1804] = 11016780,
    [1805] = "value", [1806] = 1593, [1807] = 3201, [1809] = "castPoint", [1810] = "Parent", [1811] = "Space",
    [1812] = 4081, [1813] = "acknowledgement", [1814] = 650, [1815] = "Humanoid", [1816] = "Disable 3D Rendering", [1817] = 71,
    [1818] = "rxtf", [1819] = "FillTransparency", [1820] = 3535583, [1822] = "RenderStepped", [1824] = "Progress", [1825] = "Game refused ",
    [1826] = "Chests", [1827] = "Common", [1828] = "ZIndex", [1829] = 3931, [1830] = "EspMuzan", [1831] = "Dungeon",
    [1832] = 637, [1833] = "Fighting ", [1834] = 3185, [1835] = 348352207, [1836] = "boss hunt posted: ", [1837] = 10074123,
    [1838] = "SHC", [1839] = "ofdda", [1840] = "Fetching Dr. Higoshima", [1841] = "noSun", [1842] = " enemy", [1843] = "The game refuses a perfect window while you are stunned, and for one second after any hit lands. This soaks those swings as a normal block for half damage instead of taking them clean",
    [1844] = "Parry Mobs", [1845] = "FISHING_CAST_RANGE", [1846] = 59, [1847] = "QueueModes", [1848] = 25, [1849] = "Select Nodes",
    [1850] = "serialize", [1851] = "placeId", [1852] = "Black Marketer npc", [1853] = "Mistfall Harbor", [1854] = 1364, [1855] = 3510351,
    [1856] = "SignalEvent", [1857] = 2.5, [1858] = "Move Up", [1859] = "Card already picked", [1860] = "Auto Equip Best Equipment", [1861] = "Casting",
    [1862] = 2999, [1863] = "target", [1864] = "AllowNull", [1865] = "entries", [1866] = 2285, [1867] = "Quality",
    [1868] = "PERMIT_QUEST", [1869] = "Components", [1870] = 2262, [1871] = "Auto Farm Nearby Enemies", [1872] = 2226, [1873] = "AutoSkills",
    [1874] = "SetWebhookEnabled", [1875] = 3124, [1876] = "EquipStatus", [1877] = "Only queues from the hub", [1878] = 785, [1879] = "count",
    [1880] = "EquipBait", [1881] = "BOSS_NAMES", [1882] = "Gamemodes", [1883] = 2244, [1884] = 3305, [1885] = 10536976,
    [1886] = 6185100, [1887] = 3187, [1888] = "AbandonQuest", [1889] = 1772.15, [1890] = "%", [1891] = 373405525,
    [1892] = "Max Distance", [1893] = 221, [1894] = 323, [1895] = "tmgx", [1896] = "CrystalAt", [1897] = "Casting ",
    [1898] = 3070, [1899] = "WeaponNames", [1900] = 452.65, [1901] = 1572, [1902] = "Brave Soul", [1903] = "CrystalController",
    [1904] = "noDashCd", [1905] = 17, [1907] = "modifiers", [1908] = 12830501, [1909] = "Explains where the dungeon run features went", [1910] = 764,
    [1911] = 2034, [1912] = 1093, [1913] = "soxjqspsts", [1914] = 505, [1915] = "hunt", [1916] = "thjvgnk",
    [1918] = 275.95, [1919] = "reindex", [1920] = "Utility", [1921] = 398, [1922] = "Mizunoto", [1923] = "GetBranches",
    [1924] = 3352, [1925] = 100, [1926] = 15722291, [1927] = 3946, [1928] = 288.81, [1929] = "WebhookItemCategories",
    [1930] = 834, [1932] = 3258, [1933] = 11038627, [1934] = 3451.27, [1935] = 3498776, [1936] = "AccessoryEquip",
    [1937] = 1098, [1938] = 4204255839, [1939] = "Entry", [1940] = 6800100, [1941] = "Select Quests", [1942] = 3735,
    [1943] = "not callable", [1944] = 3871, [1945] = "climb", [1946] = "SignalFunction", [1947] = "No water to cast into", [1948] = "horse",
    [1949] = "__Active", [1950] = 661, [1951] = 375, [1952] = "Finishing the delivery", [1953] = "Clan", [1954] = 3112,
    [1955] = 3485, [1956] = "HuntStatus", [1957] = "Anchored", [1958] = "Boss Hunts", [1960] = "Drop disappeared; receipt unconfirmed: ", [1961] = "TRAINING_CODES",
    [1962] = 4372845, [1963] = "Auto Pick Cards", [1964] = "Auto Fish", [1965] = "EspPlayerInfo", [1966] = "Interval", [1967] = "CameraRelative",
    [1969] = 1660, [1970] = 4812608, [1971] = "BeginPriorityLoad", [1973] = 3568, [1974] = 329, [1975] = 11325730,
    [1976] = 4025, [1977] = 3638, [1978] = 3346, [1979] = "reachPad", [1980] = "AutoBuyExp", [1981] = "WorldNames",
    [1982] = 495, [1983] = "Driving", [1984] = "Auto Level", [1986] = "Combat readiness check failed", [1988] = "wworcfrj", [1989] = "begin",
    [1990] = "Dropdown", [1991] = "Picks up Weak, Strong and Brave Souls, the Demon progression drops", [1992] = "lobby", [1993] = 3094, [1994] = "The permit costs %d Wen", [1995] = "Stats",
    [1996] = 10265908, [1997] = 1137.5, [1998] = "coroutine.resume", [1999] = 2753, [2000] = "Discord replied ", [2001] = "Killed until reputation is low enough for Muzan. Mizunoto slayers move it fastest",
    [2002] = 1864, [2003] = 242, [2004] = 3559, [2005] = "Tween Speed", [2006] = 3511, [2007] = 517,
    [2008] = 3690, [2009] = 3751, [2010] = "Training", [2011] = "syoqpf", [2012] = "character", [2013] = 607,
    [2014] = "Double Jump", [2015] = 1486, [2016] = "settling", [2017] = "kaur", [2018] = 2403, [2019] = "AntiGameplayPause",
    [2020] = 13220840, [2021] = "Items_ConfigServer", [2022] = "Kaiden Subordinate", [2023] = "stall", [2024] = "vbi", [2026] = "AutoDungeon",
    [2027] = "oplnftgdc", [2028] = "jqpyobad", [2029] = 816, [2030] = "wait", [2031] = "Item", [2032] = "WebhookChannels",
    [2033] = "<", [2034] = "syn", [2035] = "triangle-alert", [2036] = "SendWebhookReport", [2037] = 1715, [2038] = 11340532,
    [2039] = 634.51, [2040] = "Queues ranked where the mode offers it; Zenith is ranked either way", [2042] = "CustomRig", [2043] = "EspChestColour", [2044] = 612, [2045] = 16517431,
    [2047] = 540, [2048] = "Arrived at Muzan", [2049] = 16344804, [2050] = 3948, [2051] = "get_current_keys", [2052] = "PriorityRows",
    [2056] = 1573637678, [2057] = 1879, [2058] = "rod", [2059] = "nrfg", [2060] = 486, [2061] = 3868,
    [2062] = "create", [2063] = 792, [2064] = 1122, [2065] = 2346, [2066] = "Playing ", [2067] = "No mob selected",
    [2068] = "SetDisableShiftLock", [2070] = 372, [2071] = 1645, [2073] = 2114, [2074] = 9688546, [2075] = "HumanoidRootPart",
    [2076] = 2315, [2077] = "text", [2079] = "SetWebhookSkipQuiet", [2080] = 609, [2081] = 2804, [2082] = "VirtualPress",
    [2083] = 3239, [2084] = 2964, [2085] = 3390, [2086] = 2353, [2087] = "TimedVendor module", [2088] = 911,
    [2089] = 90, [2090] = "workspace", [2091] = "Native combat input unavailable", [2093] = 3223, [2094] = "applySlowdown", [2095] = 265,
    [2096] = 11377735, [2098] = "Parry counters reset", [2099] = 988, [2100] = 3995, [2101] = 2414, [2103] = 3101,
    [2104] = "gflipxgo", [2105] = 0.5, [2106] = "QuestSummary", [2107] = "Already a demon", [2108] = 2557, [2109] = 3608,
    [2110] = "MobNames", [2111] = 3781, [2113] = "yucnzhhbsiy", [2114] = "CardLabel", [2115] = "defaultRtt", [2116] = "thwda",
    [2117] = 3047, [2119] = ">", [2120] = "event", [2121] = "SetAutoDungeon", [2122] = "nsfbwpgol", [2123] = 2160,
    [2124] = "uxg", [2126] = 1230, [2127] = 2280, [2128] = 2482, [2129] = "Stamina Regen Potion", [2130] = 1472,
    [2131] = "No sealed cache spawned", [2132] = 2728841, [2133] = "getEnvironment", [2134] = "Character_info_provider", [2135] = "shc", [2136] = "Constraint",
    [2137] = "sxyu", [2138] = ",", [2139] = "jxwqfpw", [2140] = "Refresh Nodes", [2141] = "CodeReadyAt", [2142] = "TrainStatus",
    [2143] = 136.4, [2144] = 679, [2145] = 2024, [2146] = 7439236, [2147] = "except", [2148] = 1972,
    [2149] = "mousepos", [2150] = "EXP_PER_LEVEL", [2151] = "Title", [2152] = "Primary", [2153] = 968, [2154] = 11372752,
    [2155] = "Waiting for %d points", [2156] = 1325, [2157] = "Failed", [2158] = 73662, [2159] = "Warns you before Final Selection starts. It happens every 2 hours, and it's how a Human of level 45 or higher becomes a Slayer", [2160] = "Items_Config",
    [2161] = 191324761, [2163] = "LOCKOUT_TAGS", [2164] = "delay_before_swing", [2165] = "exp", [2166] = "late", [2167] = "bwiaxr",
    [2168] = "Disable3D", [2169] = 2585, [2171] = 2310, [2172] = 3880, [2173] = "Off stops at the flask instead of transforming, so the last step stays yours. Becoming a demon cannot be undone", [2174] = "inline",
    [2175] = "pcall", [2176] = 3580454, [2178] = 5943876, [2179] = 2040, [2180] = "dnjixcm", [2181] = "No souls nearby",
    [2183] = "MuzanLairAssign", [2184] = 3425, [2185] = "Equipment", [2186] = 11202068, [2187] = "Chest opened", [2188] = "Waiting out the redeem cooldown",
    [2189] = 2757, [2190] = 2465, [2191] = "Vertical offset from the target, positive sits higher", [2193] = "Controllers", [2194] = "Entities", [2195] = "pvp",
    [2196] = "Enru", [2198] = 2230, [2200] = "addons/ThemeManager.lua", [2201] = 66, [2202] = "lamklcogvb", [2203] = 1073.6,
    [2204] = 14603049, [2205] = 4083, [2207] = 3780, [2209] = 8228441, [2210] = "call did not finish", [2211] = 2.12,
    [2212] = "bossWatch", [2213] = 1638, [2214] = "ghhbuypc", [2215] = 419, [2216] = 7451151, [2218] = 873,
    [2219] = "Payload", [2220] = "rannanbzel", [2221] = 553, [2222] = 3942185695, [2224] = 2974, [2225] = "putBack",
    [2226] = "Cannot cast from here", [2227] = 7784142, [2228] = "SetHuntDropForeign", [2230] = "BossNames", [2231] = "bgiki", [2232] = "Npcs",
    [2233] = 2257, [2234] = 2646, [2235] = "Spider Lily ESP", [2236] = "Label", [2237] = "newFrame", [2238] = "rdybmkbqdox",
    [2240] = 3273, [2241] = "udaferzxn", [2242] = "Water", [2243] = "Playing", [2244] = "backoff", [2245] = 3855,
    [2246] = 133873, [2247] = "vendorModel", [2248] = 11036146, [2249] = 1892, [2250] = 67, [2251] = "TargetShootingDarts",
    [2252] = 3981, [2255] = "Stopped short of Muzan", [2256] = 3518, [2257] = "Content", [2259] = "SetEspCategory", [2260] = "Library.lua",
    [2261] = "SetAutoWorld", [2263] = "getFunctionEnvironment", [2264] = "BAIT_RESTOCK", [2266] = "nkywvicn", [2267] = "Refresh Weapons", [2268] = "gap",
    [2270] = "rxjtti", [2271] = " is locked", [2272] = 1066, [2273] = 2452, [2274] = 1.8, [2275] = 1345,
    [2276] = 2631.34, [2277] = 7752208, [2278] = "Tier", [2279] = "Menu", [2281] = "Wen Earned", [2282] = "NumberValue",
    [2283] = 1423, [2284] = 2991, [2285] = 600, [2286] = "SetAutoLoot", [2287] = "drink", [2288] = "MobTarget",
    [2289] = "IsNotDemon", [2290] = 2037, [2291] = 3804, [2292] = 1858, [2293] = 1301, [2294] = "LootController",
    [2295] = "CurrentStamina", [2296] = 3592, [2297] = "NpcCache", [2298] = 2121, [2299] = 2574.57, [2300] = 926,
    [2302] = 669, [2303] = 2496, [2304] = "snxonydxxy", [2305] = 3539, [2306] = "Cannot read the delivery quest", [2307] = 717,
    [2308] = 3291, [2309] = 4082, [2310] = "SetNotifyBosses", [2311] = "RefreshWeapons", [2312] = "token", [2313] = 1277,
    [2314] = 3678656, [2316] = "MuzanSettings module", [2317] = 1448, [2318] = "vyte", [2319] = 2958, [2320] = "unresolved",
    [2321] = "muzanRoute", [2322] = "fresh", [2323] = 3303, [2324] = 2873, [2325] = "Killing ", [2326] = "Muzan only gives the task with the quest slot free, so switch this on to drop whatever is holding it",
    [2328] = "muzan", [2329] = "Skills", [2330] = "Cannot hold Muzan's Blood", [2331] = "worldRows", [2333] = "jcgfhel", [2335] = 2248,
    [2336] = 1189, [2337] = 2846, [2338] = 642.31, [2339] = "action", [2340] = 4270059, [2341] = "gethui",
    [2342] = 3217, [2343] = 1721, [2345] = "uagzhlxbg", [2346] = "oyvge", [2347] = 813038, [2348] = "SetDemonDrink",
    [2349] = 488, [2350] = "DateTime.now", [2351] = "tpauw", [2352] = "Redeem All Codes", [2353] = "kze", [2355] = 192.5,
    [2356] = "Leave empty to keep whatever you already have out", [2357] = 1986, [2358] = "TeleportToMuzan", [2359] = "stop", [2360] = 92.68, [2361] = 14706567,
    [2362] = "Needs level ", [2363] = 193.5, [2364] = "killThreshold", [2365] = 1840, [2366] = 16348111, [2367] = "Spider Lilies %d/%d",
    [2368] = 70000053, [2369] = 1531, [2370] = 3285, [2371] = "itemsforsale", [2372] = "CombatStun", [2373] = 2699,
    [2374] = "Takes Estate Worker Niko's supply run, carries the box to Shiori, reports back, and starts over", [2375] = "RefreshSkillNodes", [2376] = "Cannot find ", [2377] = "yuht", [2378] = "HumanoidStateType", [2379] = "CatchItem",
    [2381] = "name", [2382] = 1084, [2383] = "Schematics", [2384] = "LairAttribute", [2385] = 0.82, [2387] = "Strict_Stun",
    [2388] = 3362, [2389] = 3861, [2391] = "Nothing to upgrade", [2392] = "Picking ", [2393] = 3004, [2394] = "KnockedOut",
    [2395] = "DropItemId", [2396] = 2527, [2397] = "k", [2398] = 3912, [2399] = "Trail", [2401] = 585.71,
    [2402] = 250, [2403] = 894, [2404] = 8766636, [2405] = 844, [2407] = "breathing", [2408] = 733,
    [2409] = "Exp", [2410] = "DiveStart", [2411] = "CombatInputs", [2413] = 3197, [2414] = "Cannot hand in ", [2415] = 1518,
    [2416] = 1989, [2417] = "rwu", [2418] = "retrying", [2419] = "HoyuzoSub", [2420] = "Cooling down %ds", [2421] = 0.1,
    [2422] = 3740513864, [2423] = "jusa", [2424] = "GetBoundingBox", [2425] = 2551, [2427] = 2606, [2428] = 336,
    [2430] = "vybiaqmfda", [2431] = 14435314, [2432] = 1810, [2433] = "list-ordered", [2434] = "Greater Demon", [2435] = 1026,
    [2436] = 2906, [2437] = "Mention", [2438] = 924, [2439] = "Buying %d x %s", [2441] = "SchematicStatus", [2442] = 2523,
    [2443] = 2694, [2444] = "Cache Prowler", [2445] = 2570, [2446] = "pwjahi", [2447] = "adfyqe", [2448] = 16542068,
    [2449] = "beptqc", [2451] = "txpte", [2452] = 964.5, [2453] = "How fast to glide, in studs per second", [2454] = 808.69, [2455] = 737,
    [2456] = 8706366, [2457] = "delay_before_hit", [2458] = "SetWeapon", [2459] = 459, [2460] = 244.01, [2461] = 8146248,
    [2462] = "missing", [2463] = "Tracer", [2464] = "releaseRequested", [2465] = "xprxpgxkzu", [2466] = 34, [2467] = 2197,
    [2469] = "Head", [2470] = "0 / 0", [2471] = 1368, [2472] = 15351227, [2473] = "OuroborosAnswering", [2474] = "GetStock",
    [2475] = 134, [2476] = "How to cross ground: Tween glides there, Teleport blinks there instantly", [2477] = 204, [2478] = 52, [2479] = 1917, [2480] = 2466.3,
    [2481] = 413.61, [2482] = 1914, [2483] = "SetEspRange", [2484] = 37.87, [2485] = 1226, [2486] = 796590,
    [2487] = 2466, [2488] = 12826948, [2489] = "NPCs", [2490] = "dalrm", [2491] = 1431, [2492] = 2372,
    [2493] = "Levels", [2494] = "PotionCache", [2495] = 8562344, [2496] = "tweenSpeed", [2497] = "&gt;", [2498] = "SetAutoBuyExp",
    [2500] = "BreathController", [2501] = "xumoxpu", [2502] = "Player swings only give a 0.1s window, against 0.25s for a mob", [2503] = 3890, [2504] = "lines", [2505] = "ARRIVE_RADIUS",
    [2506] = 3054, [2507] = "SetLevelDropForeign", [2508] = 6767, [2509] = 13569643, [2511] = 1895, [2512] = "SetInfiniteStamina",
    [2513] = "SetDemonMob", [2514] = 3554, [2515] = 197.17, [2516] = 106, [2517] = 4026, [2518] = 2945,
    [2519] = 304, [2520] = 3766938, [2521] = "Select NPC", [2522] = 331, [2523] = "selectionWatch", [2524] = "Health Regen Potion",
    [2525] = 903, [2526] = "Auto Farm Mob", [2527] = "Prowler Captain", [2528] = 1370, [2529] = "dropForeign", [2530] = 1285,
    [2531] = 5618068, [2532] = 1551, [2533] = "Data Ping", [2534] = 37150085, [2535] = 1033, [2536] = 9369714,
    [2537] = "VirtualInputManager", [2538] = 3356, [2539] = 2205, [2540] = 3733, [2541] = "cdayforecd", [2542] = "'",
    [2543] = 13497197, [2544] = "ggkihaobc", [2546] = 190, [2548] = "Slider", [2549] = 9.6, [2550] = 3631,
    [2551] = 21, [2552] = 1897, [2553] = "bottom", [2554] = 3278819092, [2555] = 220, [2556] = 1132,
    [2557] = "noRagdoll", [2558] = "AntiAfk", [2559] = 285, [2560] = 1501689153, [2561] = 2379, [2562] = 2805,
    [2563] = 8711493, [2564] = 1782, [2566] = 1784, [2567] = 56, [2568] = 711, [2569] = 3602,
    [2570] = 2923, [2571] = "status", [2573] = "Refreshed target lists", [2574] = 3445, [2575] = 11874264, [2576] = "SetExpBundles",
    [2577] = "Stone Trainee", [2578] = "SetAutoSkipWaves", [2579] = "script.Name", [2580] = "ggbgi", [2582] = "tkpcihrp", [2583] = "ezpoqyhh",
    [2584] = "fegmccrbdbj", [2585] = "Bosses", [2586] = 3938, [2587] = 2784, [2588] = "locked", [2589] = 11738292,
    [2591] = 2924, [2593] = "Runs", [2594] = "fill", [2595] = 3447, [2596] = 1577, [2597] = 583,
    [2598] = "Infinite Stamina", [2599] = "almyc", [2600] = "bbsd", [2601] = 821, [2602] = "pairs", [2603] = 736549,
    [2604] = 8639028, [2605] = "reachNpc", [2606] = 1161, [2607] = 1347, [2608] = 1624, [2609] = 2803,
    [2610] = "spbhmzygqrv", [2611] = 3642, [2612] = 862, [2613] = "No Ragdoll", [2614] = "Three", [2615] = "ZoneNames",
    [2616] = "Drain", [2618] = 3776, [2619] = "sp", [2620] = 1148.534, [2621] = 763, [2622] = "vvetygdqdi",
    [2623] = "Bought ", [2624] = 3773, [2625] = "setDistance", [2626] = 2730, [2627] = "OutlineTransparency", [2628] = 2092,
    [2629] = 3618, [2630] = "DungeonName", [2631] = "Run Points Earned", [2632] = 1713425, [2633] = "Tooltip", [2634] = "High Demon",
    [2635] = "Waiting for block release", [2636] = "W", [2637] = "Caches", [2638] = "epoch", [2639] = 2601, [2640] = "rcgs",
    [2641] = 5696160, [2642] = "kfzapsvqf", [2643] = 165, [2644] = 519, [2645] = 1061, [2646] = "Unload",
    [2647] = 97, [2648] = "table", [2649] = 109, [2650] = 3750, [2651] = 1333, [2652] = "RedeemAllCodes",
    [2653] = 1975, [2654] = 1755, [2655] = 0.8, [2657] = 3131445, [2658] = 3616, [2659] = 3120,
    [2660] = 7194735, [2661] = 3818, [2662] = 5494760, [2663] = 3746, [2664] = 2928, [2665] = 2103,
    [2666] = 1887, [2667] = 1292, [2669] = 596351643, [2670] = 276, [2671] = 328, [2672] = "Size",
    [2673] = "Redeeming codes", [2674] = "inMenuPlace", [2675] = "Overworld", [2676] = "PlatformHandler", [2677] = 318, [2678] = "biasedCheck",
    [2679] = 13662575, [2681] = 2267, [2682] = "MobController", [2683] = "lykhai", [2684] = "DungeonController", [2685] = "Muzan would not give the task",
    [2686] = 842, [2687] = "iflaltxeb", [2688] = 2853, [2689] = "chumugxpa", [2690] = 2909, [2691] = 1356,
    [2692] = "MovePriority", [2693] = 344, [2694] = 503, [2695] = "CharacterAdded", [2696] = 2396, [2697] = 73,
    [2698] = 8345649, [2700] = "Wen Farm Mob", [2701] = "combat", [2702] = 16027535, [2703] = "Placeholder", [2704] = "SetInfiniteClimb",
    [2705] = "Floors, cards, run points and bought exp inside Ouwigahara.", [2706] = 12638668, [2707] = 3925, [2708] = 286, [2709] = "Toggle", [2710] = 3103,
    [2711] = 840, [2712] = "KeepAmount", [2713] = 1374.99, [2714] = "Max Health", [2715] = "SwimParts", [2716] = "Font",
    [2717] = 1296, [2718] = "Quest tasks blocked", [2719] = 2111, [2720] = 3332, [2721] = 1254449202, [2722] = 2611,
    [2723] = 2459.53, [2725] = 3885, [2726] = 821.78, [2728] = 434, [2729] = 2714, [2730] = "dyktuimjyd",
    [2731] = 2532, [2733] = "TimedVendor", [2734] = "Voting to skip", [2735] = "Enter a valid Discord webhook URL", [2737] = 3437, [2738] = "cop",
    [2739] = "DEMAND_WINDOW", [2740] = 128751233, [2741] = "Select Bosses", [2742] = 11039482, [2743] = 3790, [2744] = "AutoSkillStatus",
    [2745] = 7237923, [2747] = "Color3.toHSV", [2748] = "Delivery", [2749] = 1560, [2751] = 3596, [2753] = "Pick a gamemode",
    [2754] = 8, [2755] = "SetPointReserve", [2756] = 2140, [2757] = "MinigameKey", [2758] = "DropClaimedBy", [2759] = 1738,
    [2760] = 1320, [2761] = "Party", [2762] = "claim", [2763] = 3233, [2764] = "nlbiflqak", [2765] = "S",
    [2766] = "No codes available", [2767] = 4090, [2769] = 8433030, [2770] = "Item_Equip", [2771] = 1532, [2772] = 133,
    [2773] = "Mizunoe Demon Slayer", [2774] = 652, [2776] = "osm", [2777] = "HuntDropForeign", [2778] = " waiting on ", [2779] = "ticket",
    [2780] = 2851, [2781] = 2719, [2782] = "Shadows", [2784] = 3534, [2785] = 997, [2786] = "gameSettings module",
    [2787] = "ItemRequirements", [2788] = "T2", [2789] = 0.005, [2790] = 2701.99, [2791] = "wevbyav", [2792] = "vspoemfpikv",
    [2793] = "_Combat_Anims", [2794] = "Username of whoever hosts the private server, yours or a friend's; leave it empty to join a public server", [2795] = 5060900, [2796] = 854, [2797] = "tap", [2798] = "BruteForceAllSlow",
    [2799] = "mvw", [2800] = 1673, [2801] = 3571, [2802] = "WebhookSent", [2803] = "Level", [2804] = 2957,
    [2805] = "SetQueueModes", [2806] = 2182, [2808] = 1971, [2809] = 1984, [2810] = 347, [2811] = 1288,
    [2813] = "kyvxfkwmh", [2814] = "ColorPicker", [2815] = "roam", [2816] = "JobId", [2817] = "crz", [2818] = "Unloaded",
    [2819] = 2787, [2820] = "pointer", [2821] = 500, [2822] = "Buys more of the selected bait when you run out", [2823] = "Position Type", [2824] = 3034,
    [2825] = 8372582, [2826] = 3651, [2827] = "Auto Soul", [2828] = "Retries the teleport until it takes, for when the world is full or the hub is still settling", [2829] = "PlaceId", [2830] = "jjb",
    [2831] = 3975, [2832] = 11, [2833] = 3974, [2834] = "Copy Discord Invite", [2835] = 3287, [2836] = 1720,
    [2837] = "cwcyiyexjpq", [2838] = 1047081, [2839] = 2123, [2840] = "Drops the current queue; the joiner places a new one on its next turn", [2841] = 9230653, [2842] = "deearkxfg",
    [2843] = 7529224, [2844] = 632, [2846] = 1564, [2847] = "ohvaxe", [2848] = "Leave Queue", [2850] = "infClimb",
    [2851] = "Hide UI On Start", [2852] = 760, [2853] = "SetNoSunDamage", [2855] = 2598, [2856] = "Keep Amount", [2857] = "Meditation",
    [2858] = "ykanxuhqki", [2859] = "Muzan's Blood in hand, drinking is off", [2860] = 606, [2861] = "offset", [2862] = "SkillController", [2863] = "RunEnded",
    [2864] = "blocked", [2865] = "SetQueueRanked", [2866] = "Retrying missing bosses in %ds", [2867] = 3208, [2868] = 1302, [2869] = "Teleporter is not available here",
    [2870] = "globe", [2871] = 0.55, [2872] = 2793278142, [2873] = 499.37, [2875] = 1350, [2876] = "duration",
    [2877] = 1268, [2878] = "Civilian", [2879] = 3712, [2880] = 540.5, [2881] = 7909127, [2882] = "dumbbell",
    [2883] = 1846, [2884] = "part", [2885] = 3358, [2886] = "Requester", [2887] = 18278059, [2888] = 3495,
    [2889] = " enemies", [2890] = 588, [2891] = "default", [2892] = "pressInput", [2893] = "Folder", [2894] = 7387326,
    [2896] = "WaveController", [2897] = "track", [2898] = 1167093205, [2899] = 435, [2900] = "hblrrxmrjuu", [2901] = "hklfym",
    [2902] = "nxxusbkejd", [2904] = "skillsAt", [2905] = 3438351347, [2907] = 3976444, [2908] = 3643, [2909] = "vueh",
    [2910] = "  \\u{B7}  ", [2911] = "payload", [2912] = 13945596, [2913] = "Additional Damage", [2914] = "Mark", [2915] = 940.5,
    [2916] = 1980, [2917] = "Its own Instant Kill, only on the guards around a locked sealed cache and only while Auto Sealed Cache runs", [2918] = "AscendClan", [2919] = 2336, [2920] = "affordable", [2921] = 10914386,
    [2922] = "night", [2923] = 1639, [2925] = "MOVEMENT_MODES", [2926] = "SetHealBelow", [2927] = "Points held back for the Outfitter racks and the tower chest.", [2928] = "SetChestTiers",
    [2929] = 3034.39, [2930] = 3434, [2931] = "MUZAN_ROUTES", [2932] = "Counted", [2933] = "weaponCycle", [2934] = 2424,
    [2935] = "last", [2937] = "Rika", [2938] = 12165034, [2939] = "Distance", [2940] = 0.05, [2941] = 8065434,
    [2942] = "crcrhzr", [2943] = "TrainingModes", [2944] = 2215, [2945] = "PurchaseFromShop", [2946] = 120706411, [2947] = 85.06,
    [2949] = 2063, [2950] = "cancelled", [2951] = "PriorityStatus", [2952] = 246, [2953] = "tailorWatch", [2954] = "nkcfcsvakt",
    [2955] = "[^,]+", [2956] = 29, [2957] = 16777213, [2958] = "Offset Distance", [2959] = 1274, [2960] = "Inventory",
    [2961] = "Presets", [2962] = 300, [2963] = "GetSpotIndex", [2964] = 8661590, [2965] = 4039, [2966] = 22,
    [2967] = 706, [2968] = 2423, [2969] = 3611, [2970] = 712, [2972] = "SchematicTargets", [2973] = 5764923,
    [2975] = 2401, [2976] = "Webhook URL", [2977] = 3140, [2978] = "RotationType", [2980] = "3D Box", [2981] = 2697,
    [2982] = 3858, [2983] = "SetNoDrown", [2984] = "shiftLock", [2985] = "Front", [2986] = 1357, [2987] = "started",
    [2988] = 262144, [2989] = "SetLootRange", [2990] = "SwimDrowning", [2991] = "settle", [2992] = 3630, [2993] = 1146.55,
    [2995] = 2311, [2996] = "folder", [2997] = "BossHunts", [2998] = "Color3", [2999] = "gamemodeRows", [3000] = "Run_Handler",
    [3001] = "vyehzw", [3002] = 1664, [3003] = "SetPriorityMode", [3004] = 1093.53, [3005] = 3216, [3006] = 1789,
    [3007] = "Move Down", [3009] = "bounds", [3010] = 1830, [3011] = "Buy Now", [3012] = "[Ouroboros] combat: ", [3013] = 104182695,
    [3014] = "Max Stamina", [3015] = "[Ouroboros] boss hunt step: ", [3016] = "Include", [3017] = "UserId", [3018] = "render", [3019] = "Chest opening unconfirmed; retry delayed",
    [3020] = 5676778, [3021] = "Tween", [3022] = "Vector3", [3023] = "fireclickdetector", [3024] = "Buying ", [3025] = "Auto Skip Waves",
    [3026] = 1893, [3028] = "Fisherman Jeso", [3029] = 1960, [3030] = "transparency", [3031] = 302, [3032] = 2458,
    [3033] = "Travelling to the crystal", [3034] = 556.79, [3035] = "Runs Finished", [3036] = 475, [3037] = "rotatingShop", [3038] = "WeaponCache",
    [3039] = "dxqkboakx", [3040] = "toolBlocked", [3041] = "Boss", [3042] = " npc", [3043] = 9000000000, [3044] = "qmxb",
    [3046] = "Toggles", [3047] = 543.27, [3048] = "Cards", [3049] = "No hunt to take", [3050] = 2790, [3051] = 890,
    [3052] = "Fog", [3053] = " first", [3054] = 2219, [3055] = 3958, [3056] = "warnBefore", [3057] = 518,
    [3058] = 1718564, [3059] = "Runs the whole Muzan route: reputation, the Biwa Bell, the lair, the Spider Lilies, Dr. Higoshima and the blood", [3060] = 732, [3061] = "Teleport Back When Done", [3062] = "Position", [3063] = "BareHands",
    [3064] = 2600.11, [3065] = "ribl", [3066] = 405, [3067] = "Points", [3069] = 1157, [3071] = 3978,
    [3072] = "UrlFor", [3073] = 3722, [3074] = 2979, [3075] = 421, [3076] = "GetState", [3077] = 1136,
    [3078] = 13321206, [3079] = "finish", [3080] = "potion", [3081] = 13079616, [3082] = "ParryLead", [3083] = 129,
    [3084] = 746.88, [3086] = "SetUnlockSkills", [3087] = "Waiting for night", [3088] = 1470, [3089] = "FISHING_DOCK", [3090] = 13369788,
    [3091] = 2240, [3092] = 40, [3093] = "Dialogues", [3095] = "SetKeepAmount", [3096] = 5893751, [3097] = "SetAutoQuest",
    [3098] = "Ouwigahara", [3099] = "DisableShiftLock", [3100] = "SetNotification", [3101] = "InCombat module", [3102] = "UnlockSkills", [3103] = "Already in a world",
    [3104] = "SetAutoPotion", [3105] = 535, [3106] = 2707, [3107] = 5411277, [3108] = "SetShopItems", [3109] = "coroutine",
    [3111] = 2681, [3112] = "WalkSpeedEnabled", [3113] = "kppijz", [3114] = 2737, [3115] = 404, [3116] = 4011,
    [3117] = 3524, [3119] = "^https://[%w%-%.]*discord[%w%-%.]*%.com/api/webhooks/%d+/[%w%-_]+$", [3120] = "ParryStatus", [3121] = 1024, [3122] = 12785938, [3123] = "SetNotifyWarn",
    [3124] = "fired", [3126] = "jwvvaeuvvv", [3127] = 13185669, [3128] = "JSONEncode", [3129] = 3232, [3130] = "SetSchematicReturn",
    [3131] = " on cooldown", [3132] = "Orbit", [3133] = "kxezozv", [3134] = "SetAutoQueue", [3135] = 359, [3136] = "CRYSTAL_NAME",
    [3138] = 305, [3139] = 7262083, [3140] = 287, [3141] = 6757590, [3142] = "Waiting for character", [3143] = 2789,
    [3144] = "Ice Profound Demon", [3145] = 1407, [3146] = "NEVER_CAST", [3148] = 748055, [3149] = " needs a ", [3150] = "(T%d+)",
    [3151] = 3030, [3153] = 3244, [3154] = "SetSchematicTargets", [3156] = "GrantDistance", [3157] = 4157245, [3158] = "Join failed: ",
    [3159] = 8924228, [3160] = 7522224, [3161] = 308, [3162] = "FlyKey", [3163] = "Ignore", [3164] = "Fish Head",
    [3165] = "Cannot find Dr. Higoshima", [3166] = 3227, [3167] = "ehupc", [3168] = 3002, [3169] = "visit", [3171] = 2669,
    [3172] = "gsdxqqsayq", [3173] = "next", [3174] = "Sparkles", [3175] = "refvsmrvi", [3176] = 15886827, [3177] = "CollectSchematics",
    [3178] = "No selected boss is available", [3179] = "Opening chest", [3181] = 3433, [3183] = 3945, [3184] = "Clearing quest slot", [3185] = "BoolValue",
    [3186] = "MUZAN_LAIR", [3187] = 514, [3189] = "\010", [3190] = "BasePart", [3191] = "Stops after the spot it's on. It won't take you back", [3192] = 2614,
    [3193] = 2142723282, [3194] = 181, [3195] = "terminal", [3196] = "DefaultItemCategories", [3197] = 479, [3198] = "AutoBossHunt",
    [3199] = "Alerts", [3200] = "order", [3201] = "Exit", [3202] = "Kaiden", [3203] = 2378, [3204] = 4087,
    [3205] = 2448005365, [3207] = "before", [3208] = "targets", [3209] = 6166272, [3210] = "mitigate", [3211] = 3160,
    [3212] = "No", [3213] = 1667.85, [3214] = "Collecting schematics", [3215] = "SetAutoSkills", [3216] = "ResetParryStats", [3217] = 1832,
    [3218] = "TeleportToNpc", [3219] = 849, [3220] = 9062243, [3221] = 2072, [3222] = "quest", [3223] = 2660899843,
    [3224] = 3422, [3225] = "lootUntil", [3226] = "StopSchematics", [3227] = 506, [3228] = 3929, [3229] = 2609,
    [3230] = "ChestStatus", [3231] = "TeleportService", [3232] = 2326, [3233] = 2793, [3234] = "Sample", [3235] = 1339,
    [3236] = "psqieo", [3237] = "Always face the target, whatever the position type puts you", [3238] = 3270, [3239] = "dkdtmdhy", [3240] = "\\u{203A} Level  **%d** / %d", [3241] = 1128.9,
    [3242] = "shcSince", [3243] = 3122, [3244] = 382, [3245] = "ExpBundles", [3246] = 9646016, [3247] = 20000,
    [3248] = 2806397, [3249] = "Watching", [3250] = 2393442846, [3252] = "Price", [3253] = " ms", [3254] = 3476,
    [3255] = "No goal for ", [3256] = "Track", [3257] = "sweep", [3258] = 1643, [3259] = 358, [3260] = 2540,
    [3261] = 14, [3262] = 2293, [3263] = 87, [3265] = "Beam", [3266] = "final", [3267] = 13863017,
    [3268] = "WebhookChannelStatus", [3269] = 2368, [3271] = "Lever ", [3272] = "Fancy Katana", [3273] = "movementMode", [3274] = "AutoParry",
    [3275] = "Holds your breath bar full underwater", [3276] = 16667509, [3277] = "Heal", [3278] = 2330, [3279] = "Rendering", [3281] = "Refresh Mob and Boss Lists",
    [3282] = "cast", [3283] = 1916, [3284] = 2992.61, [3285] = "Auto Buy", [3286] = 267, [3287] = "Quests",
    [3288] = 14610110, [3289] = 57, [3290] = "EspCategories", [3291] = 9056099, [3292] = "%dm", [3293] = "0% never forces a heal and 100% always takes one; a hand with no heal card in it is left to your selection either way",
    [3294] = "spawn", [3295] = "SkillStatus", [3296] = "Instantly", [3297] = "Copy", [3298] = "SignalEvent module", [3299] = 1247,
    [3300] = 14191225, [3301] = "new", [3302] = 1921, [3303] = "Waiting for guards", [3304] = "holder", [3306] = 3985,
    [3307] = "IsMenu", [3308] = "FilterDescendantsInstances", [3309] = 2269, [3310] = "LastTime", [3311] = 1151, [3312] = 1838,
    [3314] = "description", [3315] = "Infinite Horse Stamina", [3316] = 422, [3317] = "Auto Skills", [3318] = "How long to hold this skill before releasing it", [3319] = "Instance",
    [3320] = "PrimaryPart", [3321] = "#7c8290", [3323] = "bell", [3324] = 451104766, [3325] = 1350.54, [3326] = "Workspace",
    [3327] = "Waiting for chest to unlock", [3328] = 759, [3329] = 152, [3330] = 2440, [3331] = "Rarity", [3332] = 2413,
    [3333] = "Consumables", [3334] = "JoinWorld", [3335] = 2070, [3336] = "Send ", [3337] = "CATEGORIES", [3338] = "DeliveryController",
    [3339] = "gynvvughz", [3340] = 7661480, [3341] = "Ouroboros Hub", [3342] = 1820, [3343] = "Auto Buy Exp", [3344] = "webhook",
    [3345] = "T%d+", [3346] = 2987, [3347] = 1200, [3348] = 296.47, [3349] = "The overworld to teleport into", [3350] = 2137,
    [3351] = "server_skill_controller_signaler", [3352] = 3605, [3353] = 1898567, [3354] = 1608, [3355] = 3906, [3356] = "error",
    [3357] = 826.5, [3358] = "This executor has no HTTP request function", [3359] = 1649, [3360] = 1255, [3361] = 99, [3362] = 2668,
    [3363] = 2083, [3364] = 3256, [3365] = 2952, [3366] = 3161, [3367] = "SetCardSelection", [3368] = "OnFarmClaim",
    [3369] = 278, [3370] = "ShopCache", [3371] = "SetTrainings", [3372] = "HttpGet", [3373] = "Fire Profound Demon", [3374] = "task.spawn",
    [3375] = 2655, [3376] = 1517, [3377] = "?", [3378] = "QuestTargets", [3379] = "Worlds module", [3380] = 880.99,
    [3381] = "dead", [3382] = 2014, [3383] = 11151122, [3384] = 272928, [3385] = 1753, [3386] = 742,
    [3387] = "Waiting to leave combat", [3388] = 3951, [3389] = "default_before_swing", [3390] = "parse", [3391] = 3148, [3392] = " (locked)",
    [3393] = 649, [3394] = 4019, [3395] = "preempt", [3396] = "SkillChoices", [3397] = "Combat checker unavailable", [3398] = "Parry Timing",
    [3399] = "Winter Store Rep Lynx", [3400] = 963.5, [3401] = 1450, [3402] = 14521725, [3403] = 5963332, [3405] = 3940,
    [3406] = 14792700, [3407] = 1373.62, [3408] = "Idled", [3409] = "Headers", [3410] = "questCompleted", [3411] = "npc",
    [3412] = "TextStrokeTransparency", [3413] = 4709238, [3414] = "gem", [3415] = "Walking to the harbour", [3416] = 1019.2, [3417] = 5000,
    [3418] = "Npc", [3419] = "Target Shooting", [3420] = "Tower Crystal", [3421] = 2907, [3422] = 30, [3423] = "lcukbgep",
    [3424] = "AssemblyAngularVelocity", [3425] = "Schematics To Collect", [3426] = "Cast error: ", [3427] = "A higher ranked feature pauses the running one. Auto Loot always interrupts when loot is ready", [3428] = "MinigameSettings", [3429] = "ChildAdded",
    [3430] = "bring", [3432] = 42, [3433] = 3195, [3435] = 3924, [3436] = "rxwddev", [3437] = 1691,
    [3438] = 244, [3439] = 727, [3441] = "Goes from one training station to the next, does each one and moves on. Training credit counts towards quests that ask for it.", [3442] = "Legendary Fishing Rod", [3443] = "boss:", [3444] = "heddcqu",
    [3445] = "Rarities module", [3446] = "DespawnedAt", [3447] = 1823, [3449] = "hunt:", [3450] = 1206050, [3451] = "dqvtfoy",
    [3452] = "Cannot read ", [3453] = "cjkz", [3454] = 2894, [3456] = 1270, [3457] = "block", [3458] = "pnwfbesgysp",
    [3459] = "MOB_NAMES", [3461] = 4035, [3462] = "CODE_GAP", [3463] = "nynjqxqwzvxa", [3464] = "stopped", [3465] = 2436,
    [3466] = 170, [3468] = "world", [3469] = "TrainingMode", [3470] = "v0.78", [3471] = 2043363, [3472] = "Fishing",
    [3473] = "[Ouroboros] level step: ", [3474] = 2937, [3476] = 1500, [3477] = 3768, [3478] = 2931, [3479] = "Haori",
    [3480] = "Reports", [3481] = 1348281, [3482] = "Cannot farm ", [3483] = "Golden Tentacle", [3484] = 1395.64, [3485] = "Cannot read quest tasks",
    [3486] = 95, [3487] = "SetAutoFish", [3488] = "fdpakzf", [3489] = "Starting", [3491] = 1983, [3492] = "release",
    [3493] = "mycphmbjn", [3494] = "waitSample", [3495] = "Root", [3496] = 2605, [3497] = "WorldCache", [3498] = 3698,
    [3499] = 4463893, [3500] = "Last_Punched_Jump", [3501] = "GameplayPaused", [3502] = "failures", [3504] = "Parry Players", [3505] = 2300,
    [3506] = "aygchtmdmqo", [3507] = "rpq", [3508] = 2018226274, [3510] = 961, [3511] = "Cannot claim ", [3512] = 3010559,
    [3513] = "Lesser Demon", [3514] = 900, [3515] = 10549990, [3516] = "facingMin", [3517] = 4916444, [3518] = 376,
    [3519] = "Unknown report", [3520] = "EspBoxFill", [3521] = 2087, [3522] = "RagDoll", [3523] = "BOSS_DWELL", [3524] = 1455689,
    [3525] = 2830, [3526] = "LookAtEnemy", [3527] = "kftok", [3528] = "gamemodeName", [3529] = "AutoCards", [3530] = "Waiting for the quest to load",
    [3531] = 3486, [3532] = "CaptureController", [3533] = "Draining", [3534] = 1473, [3535] = 3344, [3536] = 2472,
    [3537] = "Muzan is not out, waiting at the lair", [3538] = 2046, [3539] = 53, [3540] = "EspHealthBarColour", [3541] = "weapon", [3542] = "Skill Points",
    [3543] = 3579, [3544] = "clearance", [3545] = "baao", [3546] = "AutoQuest", [3547] = 871.43, [3548] = 3806,
    [3549] = "commitments", [3550] = "EspHorse", [3551] = "Water Trainee Sabito", [3552] = "Pick", [3553] = 876, [3554] = 2872,
    [3555] = "Travelling to Muzan's lair", [3556] = 8077124, [3558] = 2988, [3560] = 15553647, [3561] = 2334.51, [3563] = 3137,
    [3564] = "SetParryLead", [3565] = 109713599, [3566] = "Zentaro", [3567] = 4001537, [3568] = 1890, [3569] = 10646364,
    [3570] = "uepsz", [3571] = "wixesb", [3572] = 2726474680, [3573] = "mnkwxwgxrc", [3574] = 185965, [3575] = "SunDamage",
    [3576] = "promptOverlay", [3577] = "Noclip", [3578] = " (", [3579] = "Current", [3580] = 3879, [3581] = 4015,
    [3582] = " (leaves in ", [3583] = "Vector2.new", [3584] = "QueueStatus", [3585] = 1166, [3586] = "farm", [3587] = 2536,
    [3588] = "footprints", [3589] = 2854, [3590] = 1403, [3591] = "info", [3592] = 38, [3594] = "NoAttackSlowdown",
    [3595] = "Failed to copy", [3596] = 3512, [3597] = 3235.7, [3598] = "Cards Picked", [3599] = "Cannot position for combat", [3600] = 1785,
    [3601] = 9922832, [3602] = 2721329617, [3603] = 632928848, [3604] = 2023, [3605] = 2649, [3606] = 2809,
    [3607] = "BossController", [3608] = 2337, [3609] = "oopt", [3610] = 2780, [3611] = "Muzan is out in ", [3612] = "upqb",
    [3613] = "Exclude", [3614] = 484, [3615] = "LevelController", [3616] = 3811, [3618] = 3428, [3619] = 2869,
    [3621] = "owner", [3622] = "Black Marketer is in ", [3623] = "AutoChest", [3624] = "Get_equipped_tool", [3625] = 3388, [3626] = 2686.362,
    [3627] = "humanoid", [3628] = "Small Yeti", [3629] = 1594, [3630] = "mwkreerybug", [3631] = 3553, [3632] = 1352.74,
    [3633] = "jgg", [3634] = "RunHandler", [3635] = "Ping Me", [3636] = 1380.5, [3637] = 7821560, [3638] = "send",
    [3639] = "resume", [3640] = "SetSkillNodes", [3641] = 1157820, [3642] = 696, [3643] = 3119, [3644] = "holdItem",
    [3645] = "nrru", [3646] = "fromHex", [3647] = "TeleportToNotification", [3648] = "uzlij", [3649] = "Player ESP", [3650] = "No combat preset for ",
    [3651] = 2922, [3653] = "opt", [3654] = "OuwigaharaLastPick", [3656] = 879, [3657] = 1106, [3658] = "PointReserve",
    [3659] = "Items module", [3661] = "category", [3662] = "WenMob", [3663] = 7067412, [3664] = "reward", [3665] = 1590,
    [3666] = "awaiting", [3667] = 16566885, [3668] = 8250286, [3669] = "Animator", [3670] = "marketWatch", [3671] = 2406,
    [3672] = "Color3", [3673] = "Leave empty to use every equipped skill. Blocking is left to Auto Parry and never cast from here.", [3674] = "htqkset", [3675] = 1998235165, [3676] = 8912522, [3678] = "Cannot find Muzan",
    [3679] = "ctlyn", [3680] = "Speed Amount", [3681] = "ctv", [3682] = 3334696120, [3683] = "Kills", [3684] = 429,
    [3685] = 3075, [3686] = 5335615, [3687] = 2640, [3688] = 3256420, [3689] = "settings-2", [3690] = 2256,
    [3691] = "yieldUntil", [3692] = "rbgghrz", [3693] = 6176885, [3694] = "blockEntry", [3696] = "D", [3697] = "Frame",
    [3698] = "field", [3699] = 1131.97, [3700] = 2339, [3701] = "Blank uses the Overworld URL", [3702] = "stroke", [3703] = 3609,
    [3704] = "open", [3705] = "AutoReconnect", [3706] = "CODE_BACKOFF", [3707] = 7434256, [3708] = "Defeating ", [3709] = "HoldDuration",
    [3710] = 4052, [3711] = 1818.57, [3712] = "OuroborosLinking", [3713] = "blurb", [3715] = "frgm", [3717] = 793,
    [3718] = "NoStun", [3719] = 2144, [3720] = 3409, [3721] = 16288336, [3722] = 2932, [3723] = 1314.89,
    [3724] = 3711, [3725] = "Failed to encode the config", [3726] = "enabled", [3727] = "SetFishBait", [3728] = "buy", [3730] = "Blocking",
    [3731] = "No skill points", [3732] = "Subsets", [3733] = "price", [3734] = "HudState", [3736] = "LiveConfig", [3737] = "NoUI",
    [3738] = "InCombat", [3739] = 14284453, [3740] = "SetWebhookUrl", [3741] = 3383, [3743] = "Running", [3744] = 1693,
    [3745] = 1708, [3746] = 1492, [3747] = 1141, [3748] = 442, [3749] = 1286, [3750] = "OwnershipRange",
    [3751] = "playerValues", [3752] = 3177, [3753] = 714, [3754] = 3948836468, [3755] = 1527, [3756] = "OnItem",
    [3757] = "hold", [3758] = "BringController", [3759] = 4876217, [3760] = "Namespace is occupied", [3762] = "Below", [3763] = 1382,
    [3764] = "CardPriority", [3765] = "remaining", [3766] = "loot", [3767] = 1484, [3768] = 2836, [3769] = 549,
    [3770] = "Floor", [3771] = "tisrotbxw", [3772] = "Muzan's Blood", [3773] = "tracer", [3774] = "Skip", [3775] = 12166332,
    [3776] = "Need", [3777] = "qdemdumzylh", [3778] = "releasing", [3779] = 327, [3780] = 2835, [3781] = "aubvutacoem",
    [3782] = 882, [3783] = "OnServerEvent", [3784] = 2647, [3786] = "Completed", [3787] = "maxLevel", [3788] = 608,
    [3789] = "lastSwing", [3790] = 226, [3791] = 998, [3792] = "SyncToggleState", [3793] = 4003441, [3794] = 3930,
    [3795] = 3266, [3796] = "Talking to ", [3797] = "obofumjp", [3798] = 10483412, [3799] = 779, [3801] = 1597,
    [3802] = 1140, [3803] = 3654, [3804] = 35, [3805] = "\\u{203A} Exp  **%s** / %s", [3806] = "Insect Trainee", [3807] = 914.81,
    [3808] = "WenCostOnAccept", [3809] = "sword", [3810] = "Levers", [3811] = "%1%1", [3812] = 3012, [3813] = "Regular Katana",
    [3814] = "dwell", [3815] = 3179, [3816] = 0.75, [3817] = 1351, [3819] = 1681, [3820] = 1163,
    [3821] = "ForceHealCards", [3822] = "startedAt", [3824] = 601.99, [3825] = "EasingDirection", [3826] = 1147, [3827] = 1446,
    [3828] = 3453, [3829] = "Enemy Colour", [3830] = "codes", [3831] = "SetDrinkBelow", [3833] = 5750674, [3834] = 235,
    [3835] = "KaidenSub", [3836] = "MenuComponents", [3837] = 1207, [3838] = 6739750, [3839] = "WeaponChoice", [3840] = "combatdisabled",
    [3842] = "Up", [3843] = 1229, [3844] = 773, [3845] = "NpcNames", [3846] = "NumberRange", [3847] = "muzanWatch",
    [3848] = 3989, [3849] = "ItemCategories", [3850] = 3981175, [3851] = "EquipWeapon", [3852] = "bms", [3853] = 2288,
    [3854] = "Lever ESP", [3855] = "\\u{203A} Points  **%s**", [3856] = "Which posted hunts to take. Nothing picked takes any of them", [3857] = 893, [3858] = 54, [3859] = 5622006,
    [3860] = 2022, [3861] = "bundles", [3862] = "UserGameSettings", [3863] = 15006406, [3864] = "ehbjdp", [3865] = 901446698,
    [3866] = "How much of a guard's health to take off first, 0% kills it at full health", [3867] = 1087, [3868] = 3064, [3869] = "vtfvfxrpgxo", [3870] = "qsd", [3873] = "MuzanLairModel",
    [3874] = "wvghyzwgnwec", [3875] = "Collect Schematics", [3876] = 4085, [3877] = 1037, [3878] = "igdoyxwuty", [3879] = 2101,
    [3880] = "BOSS_COLLECT_CAP", [3881] = 453, [3882] = 861, [3883] = 1018, [3884] = 1404, [3885] = "phaseIn",
    [3886] = 3821, [3887] = "newLabel", [3888] = "swords", [3889] = 1253, [3890] = "prompt", [3891] = 734800,
    [3892] = "pyycutifh", [3893] = 2360.47, [3894] = 940, [3895] = 4060, [3896] = "Parry Range", [3897] = 4576059,
    [3898] = "Method", [3899] = "pksht", [3900] = "ScreenGui", [3901] = "Drink Muzan's Blood", [3902] = "QueueFill", [3903] = 2768,
    [3904] = "a match", [3905] = "djwxdjtt", [3906] = "race", [3907] = " Report", [3908] = 2891295469, [3909] = 3723,
    [3910] = 3400, [3911] = 558.31, [3912] = 2944, [3913] = 1199263, [3915] = "yafobj", [3916] = "task.wait",
    [3917] = 12993966, [3918] = 3448, [3919] = 256.15, [3920] = 3817, [3921] = "message-circle", [3922] = "&amp;",
    [3923] = 3424, [3924] = "SetNoAttackSlowdown", [3925] = 3398, [3926] = 397, [3927] = 2627, [3928] = "NoRagdoll",
    [3929] = "ResetOnSpawn", [3930] = "Ringing the Biwa Bell", [3931] = "Teleport to Muzan", [3932] = 3042, [3933] = "Smoke", [3934] = "Auto Skill Tree",
    [3935] = 355, [3936] = "Player", [3937] = "QueueController", [3939] = "icoxaoxg", [3940] = 115, [3942] = 762.66,
    [3943] = "[Ouroboros] breathing step: ", [3944] = 399, [3945] = "walk", [3946] = "Modules", [3947] = 2431, [3948] = 3876,
    [3949] = 86, [3950] = 1629, [3951] = 990, [3952] = 3899, [3953] = "SetInfiniteHorseStamina", [3954] = "WebhookPing",
    [3955] = 2886, [3956] = 1362, [3957] = 3846, [3958] = "TouchPart", [3959] = "Claim", [3960] = "Select Mob",
    [3961] = "jfprejoig", [3962] = "Pickup Range", [3963] = "Finish ", [3964] = "pna", [3965] = 2208, [3967] = 1496,
    [3968] = 16126068, [3969] = 1015, [3970] = 3324287, [3971] = 84, [3972] = 3456139, [3973] = 2283,
    [3974] = "Beast Born Demon", [3975] = 1814, [3976] = 2993, [3977] = "InOut", [3978] = 2581.31, [3979] = 1813,
    [3980] = 3622, [3981] = "EspMobs", [3982] = 2290, [3983] = 509, [3984] = 12829062, [3985] = "ActivityField",
    [3986] = 2807, [3987] = 3382, [3988] = 2617248, [3989] = "ret", [3990] = "muzanPositions", [3991] = "Skills_Provider",
    [3992] = 1082, [3993] = 2512, [3994] = 215, [3995] = 635, [3997] = "%dh %dm", [3999] = "No enemies nearby",
    [4000] = 1350.5, [4001] = "Get", [4002] = 2612, [4003] = 2800, [4004] = "task.delay", [4005] = 1397531524,
    [4006] = "Dungeon Run", [4007] = "lastHit", [4009] = 2503, [4010] = 902611, [4011] = 4064, [4013] = "Dash",
    [4015] = "MuzanSettings", [4016] = "AbsoluteRotation", [4017] = 9550487, [4018] = 3395, [4019] = "byyvpluv", [4020] = "Combat error: ",
    [4021] = 82, [4022] = 1955, [4023] = 1081, [4024] = 3476942, [4025] = "CAST_MIN_GAP", [4026] = "BlockWork",
    [4027] = "SkipFloor", [4028] = "ninqlhek", [4029] = "T1", [4030] = 1342, [4031] = 8609960, [4032] = "wenMob",
    [4033] = 970, [4035] = 458.25, [4036] = "Max_Hold_Time", [4037] = "on", [4038] = 929, [4039] = "DemonDropForeign",
    [4040] = "ItemHook", [4041] = 1234, [4042] = 2169, [4043] = 89, [4044] = 464, [4045] = "AFK triggers: ",
    [4046] = "DemonStatus", [4047] = "OuwigaharaRequest", [4048] = "No notification yet", [4049] = 2904, [4050] = "Underwater Breathing Potion", [4051] = 1641,
    [4052] = 3372, [4053] = "kakiqylmsfz", [4054] = "No trainer for ", [4055] = "copy", [4056] = "SchematicNames", [4057] = 2875,
    [4059] = 191281580, [4060] = "BuilderSansBold", [4061] = "Regions module", [4062] = 1724, [4063] = "GamemodeCache", [4064] = "tooldisabled",
    [4065] = 829459501, [4066] = 3627, [4067] = "Center", [4069] = 2705, [4070] = "reset", [4071] = "repMob",
    [4072] = "Cannot hold the Biwa Bell", [4073] = 3541, [4074] = 1467, [4075] = 418, [4076] = 3900, [4077] = "active",
    [4078] = 10994307, [4079] = 65, [4080] = "Stopped short of the notification", [4081] = 1740, [4082] = 2903, [4083] = 230,
    [4084] = "Gauge", [4085] = "Flame", [4086] = "https://discord.gg/synapsex", [4087] = "PASSIVE_MOBS", [4088] = 81, [4089] = "FishingLine",
    [4090] = 425.79, [4091] = 16546833, [4092] = 1964, [4093] = 4, [4094] = 1521, [4095] = 365,
    [4096] = "Start", [4097] = "SetWebhookEvents", [4098] = 2059, [4099] = 628, [4100] = 2467, [4102] = "OutsideClickDismiss",
    [4103] = 3028, [4104] = "tier", [4105] = "findFunctions", [4106] = 9575352, [4107] = 2954, [4108] = "Baitmonger Nori",
    [4109] = 850, [4110] = 1221, [4111] = 2816, [4112] = 1438050, [4113] = "gen", [4114] = "mhi",
    [4115] = 2342, [4116] = 13803396, [4117] = 4058222505, [4118] = 671, [4119] = "TakeNotifications", [4121] = 1336617159,
    [4122] = 2874, [4123] = 837.79, [4124] = 4072, [4125] = 1303, [4126] = "DoubleClick", [4127] = "to show you out here. Join a dungeon game mode and a Dungeon Run box ",
    [4128] = "Skill", [4129] = 2124, [4130] = "CombatPreset", [4131] = "Callback", [4133] = "rank", [4134] = 54619193,
    [4135] = "Levels Gained", [4136] = 1540269, [4137] = 31871233, [4138] = "NotifyBosses", [4139] = 2590, [4140] = 2042,
    [4141] = 15000450, [4142] = "lmx", [4143] = 9671241, [4144] = "expires", [4145] = 1968, [4146] = 3599,
    [4147] = "SetPrivateOwner", [4148] = "Exp Bought", [4149] = "Cannot equip the ", [4150] = "Fortune", [4151] = 3877, [4152] = 3550,
    [4153] = "ChestTiers", [4154] = "CombatPresets", [4155] = "title", [4156] = 1949, [4157] = "OffsetDistance", [4158] = 8008161,
    [4159] = "Mother Bear", [4160] = 2294, [4161] = "Text", [4163] = 829, [4164] = 989, [4165] = "shyafppwvoj",
    [4167] = "game", [4168] = 456, [4169] = "EspHealthText", [4170] = 426.98, [4171] = 371, [4172] = " selling ",
    [4173] = 3322, [4174] = 2785, [4175] = 3713, [4176] = "Combat presets unavailable", [4177] = "CanCollide", [4178] = 44129083,
    [4179] = "Shop", [4180] = 742.43, [4181] = "#e0788c", [4182] = "SignalFunction.ToServer", [4183] = 3455, [4185] = 2831,
    [4186] = "offers", [4187] = "BOSS_SKIP", [4188] = 2288885, [4189] = "EspPlayers", [4190] = 2685.18, [4191] = 145,
    [4192] = "HighJump", [4193] = 0.02, [4195] = "SkillRunner", [4196] = "Reroll", [4197] = "SetAlwaysRun", [4198] = 163.59,
    [4199] = 1187, [4200] = 953, [4201] = 2984, [4202] = "SkillSwap", [4203] = "BackgroundTransparency", [4204] = 139,
    [4205] = "EspHorseColour", [4208] = "tailor:", [4209] = 3154, [4210] = 560, [4211] = 1637, [4212] = 1763,
    [4213] = 580, [4214] = "EspPlayerInfoColour", [4215] = "function()returnbpz[cKb[136][1398.]]end", [4216] = "menuValidators", [4217] = "bihuniapm", [4218] = 1495,
    [4219] = "SetAutoBuyBait", [4221] = 3853, [4222] = "FishStatus", [4223] = "SetOffsetDistance", [4224] = 2212, [4225] = 2980,
    [4226] = "ByName", [4227] = 2060, [4228] = "Stamina Regen Speed", [4229] = 2838, [4231] = 62, [4232] = 13160918,
    [4233] = 3791, [4234] = 1194, [4235] = 1146, [4236] = 2661, [4237] = 1748, [4238] = 4058,
    [4239] = 808695, [4240] = "tiers", [4241] = 3613, [4242] = "naoinhy", [4244] = "chuzttl", [4245] = 3325432104,
    [4246] = 799, [4247] = 61448877, [4248] = 3009, [4249] = 563, [4250] = 3150, [4251] = "Quest Progress",
    [4252] = "IgnoreExecutor", [4253] = "DropTarget", [4254] = 707, [4255] = "application/json", [4256] = 729, [4257] = 1842,
    [4258] = "sfiusqbcddx", [4259] = 3005, [4260] = "queueWatcher", [4262] = "dmmwkwvjgku", [4263] = 1233, [4264] = 2962,
    [4265] = "quests", [4266] = "Ill deliver the supply box(Lv 70)", [4267] = 325, [4268] = "ckpqexbffc", [4269] = 1485, [4271] = 2253,
    [4273] = 335, [4274] = "Dr. Higoshima", [4275] = 2444, [4276] = 2425, [4277] = 2177, [4278] = "jwuimtijgne",
    [4279] = "GoalPosition", [4280] = 15713163, [4281] = "Event", [4282] = "Explosion", [4283] = 1136686, [4285] = 3169,
    [4286] = 4423320, [4287] = "releaseInput", [4288] = 685, [4289] = 14057951, [4291] = " Breathing", [4292] = 2680,
    [4293] = "Pick a mob first", [4294] = "names", [4295] = "nirzcm", [4296] = "detail", [4297] = 3147, [4298] = 13039779,
    [4299] = "player", [4300] = "AnimController", [4301] = 2299828559, [4302] = "CodeCooldown", [4304] = "Above", [4305] = "FishController",
    [4306] = "StationaryNpcs", [4307] = "ifvzvrza", [4308] = "-", [4310] = 573.91, [4311] = "route", [4312] = "[Ouroboros] training step: ",
    [4313] = "Muzan ESP", [4314] = 3677, [4315] = 32, [4316] = 3209, [4317] = "Block Bare Hands Event", [4318] = "ghvgl",
    [4319] = 9388395, [4320] = 80, [4322] = "PrivateOwner", [4323] = "Paste exported config here", [4324] = "Saneri", [4325] = 2004,
    [4326] = 14790973, [4327] = "EspLeverColour", [4328] = 1374, [4329] = "rankOf", [4330] = 2948, [4331] = 10975782,
    [4332] = 2543, [4333] = 3740, [4334] = 2437, [4335] = "zonePoints", [4336] = "Disable Shift Lock", [4337] = "wut",
    [4338] = 3213, [4339] = "Hunt cooldown", [4340] = 721370, [4341] = 8143282, [4342] = "\"", [4343] = " guards",
    [4344] = 3297, [4345] = 72, [4346] = 7207037, [4347] = "Quests module", [4348] = "ntnrclualsiu", [4349] = "wen",
    [4350] = "Heartbeat", [4351] = "CAM", [4352] = 3908, [4353] = "zero", [4354] = "Skip Empty Reports", [4355] = "contended",
    [4357] = "cnzyom", [4358] = ", nowhere to search", [4359] = "SetParryRadius", [4360] = 3225, [4361] = 2268, [4362] = "Reputation Mob",
    [4363] = "vex", [4364] = 485, [4365] = "\\u{203A} *%d earlier picks*", [4367] = 2435, [4368] = "generation", [4370] = "SetAutoTraining",
    [4371] = "Force Heal Below", [4372] = "Mob ESP", [4373] = 3726506252, [4375] = "Cannot afford ", [4376] = "%d+", [4377] = 994.42,
    [4378] = 3288, [4379] = "Unknown world", [4380] = 2395, [4382] = 1853901626, [4383] = 3889, [4384] = 2798,
    [4385] = 85827, [4386] = "IsPlaying", [4388] = 2017, [4389] = "Spawns", [4390] = "Rotation", [4391] = "Transparency",
    [4392] = 1561, [4393] = 163, [4394] = 8836425, [4395] = "ryjdndrod", [4396] = 16, [4397] = 2181,
    [4398] = 8601080, [4399] = "Farm Settings", [4400] = "Feature", [4401] = "Bandit", [4402] = "line", [4403] = "WebhookPingId",
    [4404] = 3582, [4405] = "Ownership Viewer", [4406] = "agbre", [4407] = 497, [4408] = "InfiniteClimb", [4409] = 3065,
    [4410] = "ActiveFor", [4411] = "ActiveNpcs", [4412] = "interruption", [4413] = "Subtitle", [4414] = "SetHuntTiers", [4415] = "MovementMode",
    [4416] = 2502, [4417] = "LevelStatus", [4418] = 79, [4420] = 2035831041, [4421] = "Fields", [4422] = "Searchable",
    [4423] = 381, [4424] = "plgvnusen", [4425] = "bkt", [4426] = 2822, [4427] = "catch", [4428] = 44,
    [4429] = 9446534, [4430] = "CostText", [4431] = "ciopduclcbr", [4432] = 16035289, [4433] = "niuqzqz", [4434] = "CharacterInfo",
    [4435] = 1443, [4436] = 2086, [4437] = 6997840, [4438] = 1158, [4439] = "Tells you when one of your bosses spawns, even when it's too far away to see", [4441] = "FishingCatch",
    [4442] = "SetItemCategories", [4443] = 1671, [4444] = 1428, [4445] = "tween", [4446] = 141.59, [4447] = "prepare",
    [4448] = 1406, [4449] = "SkillChoiceCache", [4450] = 2746562, [4451] = "EspNpcsColour", [4452] = "1 is taken first, 10 last; ties go to the rarer card", [4453] = 12213076,
    [4454] = 2764912, [4455] = 2644, [4456] = "AutoLoot", [4457] = "NoDrown", [4459] = "CurrentListeners", [4460] = "Waiting for previous block release",
    [4461] = "OuroborosOuwland", [4462] = 3538, [4463] = "InMenuPlace", [4464] = "The blood did not take", [4465] = "entry", [4466] = 5597266,
    [4467] = "mtxbvskqh", [4468] = "World", [4469] = "\\u{203A} Doing  %s", [4470] = "timedVendor", [4471] = 1654, [4472] = 3052,
    [4473] = "eye", [4474] = 3727, [4475] = "SkillTreeholder", [4477] = 1408816, [4478] = "PositionType", [4479] = "ParryHold",
    [4480] = 1902, [4481] = "Could not encode the message", [4484] = "fyzczdy", [4485] = "movementEpoch", [4486] = "training_signaler", [4487] = "Where to stand relative to the target while fighting it",
    [4488] = 1774, [4489] = 3029, [4490] = "NoClipKey", [4491] = "DisplayOrder", [4492] = "InfiniteHorseStamina", [4493] = 3862,
    [4494] = "Collectibles", [4496] = "Ouroboros", [4497] = 809, [4498] = "Interaction", [4499] = 98.47, [4500] = "questNode",
    [4501] = 7813904, [4502] = "BreathingChoice", [4503] = "pyyoilg", [4504] = 4003, [4505] = 1306, [4507] = 1214,
    [4509] = "<font color=\"#e0788c\">Instant kill is patched but it can still kill enemies, they just won't drop any items</font>", [4510] = 245, [4511] = "Boss ESP", [4513] = 296.7, [4514] = "hjudzg", [4515] = 263,
    [4516] = 3238, [4517] = 9861788, [4518] = 112255223, [4519] = 2524, [4520] = 0.75, [4521] = "Select Skills",
    [4522] = 1696, [4523] = "Arrived at the lair", [4524] = 1870, [4526] = 3520, [4527] = " restocked", [4528] = 3123,
    [4529] = "function()returnbpz[cKb[136][3038]]end", [4530] = "ownershipRange", [4531] = "container", [4532] = 1508, [4533] = "ExpBought", [4534] = 3724,
    [4535] = "SoulController", [4536] = "AutoWorld", [4537] = 15265850, [4538] = 794, [4539] = 15880479, [4540] = "EspNameColour",
    [4541] = 3764, [4542] = 1172, [4543] = "TaskNeedMet", [4544] = 12507121, [4545] = 1501, [4546] = 1563,
    [4547] = "Func", [4548] = 589, [4549] = "Turns the game's Left Alt shift lock back off whenever it comes on", [4552] = "TextButton", [4553] = "NotifyTailor", [4554] = "Accepting ",
    [4556] = "WebhookStatus", [4557] = "ukamijljpy", [4558] = 395, [4559] = "drinkBlood", [4560] = "HoldSkills", [4561] = 405258,
    [4562] = 316, [4563] = "getgc", [4564] = 1669, [4565] = "wjg", [4566] = 3026, [4567] = 3068,
    [4568] = 9804556, [4569] = "hit", [4570] = "AutoBoss", [4571] = "ddw", [4572] = "Discord User ID", [4573] = "Dismiss",
    [4575] = 3525, [4576] = 2823, [4577] = 1349, [4579] = 3229, [4580] = 2712, [4581] = "Waiting for %s (%ds)",
    [4582] = 8502409, [4584] = "tracker", [4585] = "EspDistanceColour", [4586] = "Run Points", [4587] = 8239267, [4588] = 7885417,
    [4589] = 1827, [4590] = 1336, [4591] = "Worlds", [4592] = "Auto Farm Quest", [4593] = "MaxClimbTime", [4594] = "AbsoluteSize",
    [4596] = 3604, [4598] = 16527912, [4599] = "RefreshSkillChoices", [4600] = "NotifyMuzan", [4601] = "objects", [4602] = 2686,
    [4603] = 2010, [4604] = 965, [4605] = 3697, [4606] = 1167, [4608] = 2076, [4609] = "fhyfymz",
    [4610] = "yield", [4611] = 8314872, [4612] = "lwtwdtmv", [4613] = "Travelling to ", [4614] = "holdingWeapon", [4615] = "setColour",
    [4616] = "qovyxnpf", [4617] = "setCategory", [4618] = "pvfdygfv", [4620] = "Collected %d, skipped %d", [4621] = "hug", [4622] = 2529,
    [4623] = 2747, [4624] = 266.96, [4625] = "Reaches", [4626] = 13736033, [4627] = "Combat timed out", [4628] = "ownerRun",
    [4630] = "thq", [4631] = 217, [4632] = 3364, [4634] = 389.59, [4635] = "positionType", [4636] = 3972,
    [4637] = 10427412, [4639] = 2505, [4640] = 2899, [4641] = 1008, [4642] = 1997, [4643] = "PriorityLabels",
    [4644] = 2752, [4645] = "SaveDisabledSlot", [4646] = 2445, [4647] = "infStamina", [4648] = "LiveConfig.get", [4649] = "Nothing",
    [4650] = "points", [4651] = 2969, [4652] = 1873, [4653] = "\\u{203A} Alive  %s", [4654] = 810, [4655] = "SetPriorityOrder",
    [4656] = "QuestStatus", [4657] = 173, [4658] = 2057, [4659] = "releaseFailed", [4660] = "fxrjmprqti", [4661] = "NextEdgeIn",
    [4662] = 3985782716, [4663] = "knqvlr", [4664] = 255, [4665] = "Settings", [4666] = 4094, [4667] = 457,
    [4668] = "clearInputs", [4669] = "Watching for a wave break", [4670] = "Skip voted", [4671] = 1459.53, [4674] = 1835, [4675] = 2276741021,
    [4676] = 3048, [4678] = 472, [4679] = "cac", [4680] = "[Ouroboros] chest step: ", [4681] = "BossHunt", [4682] = "fuj",
    [4683] = 2052, [4684] = "CODE_COOLDOWN", [4685] = "Multi", [4686] = 1737, [4687] = 159, [4688] = 3416,
    [4689] = "lumixspdu", [4690] = "High Jump", [4691] = "%s", [4694] = "Hybrid", [4695] = 9170927, [4696] = 3370,
    [4697] = "Magnitude", [4698] = 2622, [4699] = "BossHuntsRequest", [4700] = "EspName", [4701] = 19, [4702] = "bgmk",
    [4703] = "healthBar", [4704] = 605, [4705] = "Requirements", [4706] = 0.15, [4707] = 2633, [4708] = "Gameplay",
    [4709] = 535686, [4710] = "Run", [4712] = "BreathingCost", [4713] = 2450, [4714] = "foqist", [4715] = 282,
    [4716] = 1040, [4717] = 2885, [4718] = 1947, [4719] = "AutoBreathing", [4720] = "keep", [4721] = ")",
    [4722] = 4854192, [4723] = "wlpxtadpppl", [4724] = "isBoss", [4725] = 16758465, [4726] = 10196402, [4727] = 8032268,
    [4728] = 232, [4729] = "How far to look for an enemy, 0 searches the whole floor", [4730] = "Category", [4731] = "JSONDecode", [4732] = 1984016317, [4734] = "crown",
    [4735] = "begocswm", [4736] = 2492, [4737] = "StatusCode", [4738] = 1282, [4739] = "<font color=\"%s\">%s</font>", [4740] = 2066,
    [4741] = "source", [4745] = 112, [4746] = 3342, [4747] = 155, [4748] = "MuzanGiveBell", [4749] = "kzmhhgjhf",
    [4750] = "zugqsu", [4752] = "Tailor Restocks", [4753] = 2056, [4754] = "Datai", [4755] = 857, [4756] = "getgenv is unavailable",
    [4758] = 391, [4759] = 1042, [4761] = 920, [4762] = "Heading for ", [4763] = 2797, [4764] = "latest",
    [4765] = 1951, [4766] = 2602, [4767] = "Platform_Handler", [4768] = 3293, [4769] = 2547, [4770] = "1",
    [4771] = 2514, [4772] = "Collect Range", [4773] = 386, [4774] = "NoDashCooldown", [4775] = "Goal", [4776] = 2125,
    [4777] = 27, [4778] = "Shop module", [4779] = "Unit", [4780] = 1463, [4781] = "mfhoh", [4782] = "skills",
    [4783] = 36084, [4784] = "queue", [4785] = "|up", [4786] = 784, [4787] = "waitName", [4788] = 3744,
    [4789] = "restoreRagdoll", [4790] = 2119, [4791] = "priorityKey", [4792] = 2718, [4793] = "hfytwg", [4794] = 802,
    [4796] = "Unlock Skills", [4797] = "BackgroundColor3", [4798] = "mcixghmflzu", [4799] = 1219.26, [4800] = 350917, [4801] = "qakzhfhc",
    [4803] = "Vector3.new", [4804] = "kmixfpjnfivy", [4805] = 2625, [4806] = "interval", [4807] = "MyScriptHub", [4808] = 3959,
    [4810] = 3295, [4811] = "Tai Chi Trainee Suzume", [4812] = 272, [4813] = "ipairs", [4814] = "station", [4815] = 3719,
    [4816] = 2430, [4817] = "running", [4818] = "Become A Demon", [4819] = "ClickButton2", [4820] = 2634, [4821] = "Items are disabled on this floor",
    [4822] = "setInSun", [4823] = 1913, [4824] = "No Drown", [4825] = 1148, [4826] = 796, [4827] = "Frozen Heart",
    [4828] = 1388, [4829] = "BOSS_COLLECT_YIELD", [4830] = "function", [4831] = "Wind Trainee", [4832] = 266.12, [4833] = "jmyt",
    [4834] = 2314, [4835] = "HeightOffset", [4836] = "Select Zone", [4837] = "&quot;", [4838] = "AlwaysOnTop", [4840] = 2645,
    [4841] = "Sickles Levers", [4842] = 2222, [4843] = "cooldowns", [4844] = 609772, [4845] = "Skill release unresolved", [4846] = "SetNoDashCooldown",
    [4847] = "lead", [4848] = "bcnhtcix", [4849] = "SetParryNpcs", [4850] = "iyeqwlseeuc", [4851] = "Name Drops From", [4852] = "RequiresLineOfSight",
    [4853] = 398.71, [4854] = "&", [4855] = 814, [4856] = 531, [4857] = 1882, [4858] = 1763.05,
    [4859] = "PotionController", [4860] = "farmReputation", [4861] = 2551.99, [4862] = 2510, [4863] = "run", [4864] = "Saved Order",
    [4865] = "PriorityPick", [4866] = 1028, [4867] = 3913324262, [4868] = "workerActive", [4869] = 2934, [4870] = "Holding off for auto parry",
    [4871] = 1851, [4873] = "Demon", [4874] = " instead of a table", [4876] = "ObjectText", [4877] = "Sustain", [4878] = 2577,
    [4879] = 1211, [4880] = "Run_Handler module", [4881] = 2808, [4882] = "Flame Trainee", [4883] = "Stops every horse speed mode draining stamina, so Run never times out", [4884] = "Cannot farm this quest",
    [4885] = "function()returnbmK[cKb[136][5415.]]end", [4886] = "cancelQueue", [4887] = 1996, [4888] = "announceHudState", [4889] = 1772, [4890] = "rhdq",
    [4891] = 3175, [4892] = 2478, [4893] = 3181, [4894] = 5341707, [4895] = "flask-round", [4896] = "GuiService",
    [4897] = "SetAutoSoul", [4898] = "wysdiz", [4899] = "\\u{203A} *and %d more*", [4900] = 2582, [4902] = "Caught ", [4903] = "WebhookEventLabels",
    [4904] = 1436, [4905] = "MinigameSettings module", [4906] = "inDungeon", [4907] = 58, [4908] = "PriorityKeyFor", [4909] = "TAILORS",
    [4911] = "No pickable gamemode", [4912] = 1418, [4913] = "BaseStaminaDrain", [4914] = 2491, [4915] = "lru", [4916] = "Hearts Lost",
    [4917] = "Serpent", [4918] = "gqea", [4919] = 8886887, [4920] = 1548, [4922] = "touchGoal", [4923] = "valid",
    [4925] = 3393520597, [4926] = 1538, [4927] = "efoxetejbzjk", [4928] = "LastNotification", [4929] = 2783, [4930] = "Loot error: ",
    [4931] = 2079, [4932] = 2914, [4933] = "anyOn", [4934] = "reputation", [4935] = "Esp", [4936] = 3154877,
    [4937] = 3964, [4938] = 2000, [4939] = "zonjcjedc", [4940] = "Pushups", [4942] = "iuwxf", [4943] = 6428931,
    [4944] = "CrystalStatus", [4945] = 823, [4946] = "gqedine", [4947] = 1240, [4948] = "ragljmc", [4949] = 1481,
    [4950] = "Movement Speed Factor", [4951] = "Puzzles", [4952] = "QuestProgress", [4953] = "Changed", [4954] = "NpcTarget", [4955] = "Votes to skip each wave break as it opens; the run still needs enough votes to pass",
    [4956] = 767, [4957] = 2373, [4958] = 1071, [4959] = 500000, [4960] = 2133, [4961] = 927,
    [4962] = 3158, [4963] = "No stat gear owned", [4967] = "Rare", [4968] = "FeatureAPI required", [4969] = "Temporary", [4970] = "instantKill",
    [4971] = "Level %d is the cap", [4972] = "Cycle", [4973] = "mbvb", [4974] = "EspRange", [4975] = "goalPart", [4976] = 271.38,
    [4977] = 412, [4978] = "CFrame", [4979] = 15212890, [4980] = 2080, [4981] = 2794, [4982] = "Select Items",
    [4983] = 37, [4984] = 2920536, [4985] = "RefreshQuestChoices", [4986] = "Teleport to Last Notification", [4987] = "Cannot unlock ", [4988] = 1025,
    [4989] = 2958350136, [4990] = "lrs", [4991] = 3359151, [4992] = "yvmoo", [4993] = "While your health sits at or below the threshold this takes the hand away from your selection and picks the best heal card instead; the moment you are back above it your selection has the hand again", [4995] = "PlayerGui",
    [4996] = "Drowned Lure", [4997] = 3471, [4998] = 317, [4999] = "noragdoll", [5000] = "Quest complete", [5001] = 4544155,
    [5002] = 5312694, [5003] = 9663957, [5004] = 492, [5005] = 1845, [5006] = 1986743083, [5007] = "SetAutoEquip",
    [5009] = 3649, [5010] = "Pick a zone first", [5011] = "Speed", [5012] = 392.31, [5013] = 3165, [5014] = "OutlineColor",
    [5015] = "RightShift", [5016] = 48, [5017] = "gameSettings", [5018] = "  <on>", [5019] = "Misc", [5020] = 2600,
    [5021] = "regions", [5022] = "npcPoints", [5023] = 3551, [5024] = "Worm", [5025] = 301, [5026] = 3533,
    [5027] = 3126, [5028] = "Id", [5029] = "Cannot find the Tower Crystal", [5030] = "Quest", [5031] = 656, [5032] = 3887,
    [5033] = "kxrpltz", [5034] = "dhbxgmcziq", [5035] = 2572126484, [5036] = "Queued for ", [5037] = "Auto Boss", [5038] = 3957,
    [5039] = 9523072, [5040] = 878, [5041] = 4486301, [5042] = 1231, [5043] = 1089, [5044] = 4036482,
    [5045] = 1535.71, [5046] = 959, [5047] = 13983443, [5051] = "tweaks", [5052] = "cdpl", [5053] = 675,
    [5054] = 1582, [5055] = "Collecting ", [5056] = "Teleporting back", [5057] = "Run_Hit", [5059] = "Dying Colour", [5060] = 14271878,
    [5061] = 4009, [5062] = 1220, [5063] = "AutoFish", [5064] = "Ended", [5065] = "QueuWatcher", [5066] = 2864,
    [5067] = "dzplb", [5068] = "#ffb3d9", [5069] = "Stamina Regen Elixir", [5070] = "Drinking Muzan's Blood", [5071] = "EasingStyle", [5073] = "OuroborosOuwlandOwnership",
    [5076] = 39, [5077] = "raznnqy", [5078] = "skill_info", [5080] = "nlnunt", [5081] = "CHEST_TIERS", [5082] = "ParryMitigate",
    [5083] = 2029, [5084] = "Gets the fishing permit and a rod if you have none, then fishes at the harbor and always lands the bite", [5086] = "SkillPoints", [5087] = "committed", [5088] = 2860, [5091] = 12572325,
    [5092] = "pdeds", [5093] = "Send", [5095] = 2313, [5096] = 24, [5097] = 1678, [5098] = "No combat equipment ready",
    [5099] = 2274, [5100] = 127, [5101] = 280, [5102] = "current", [5103] = 11367670, [5104] = 6361996,
    [5105] = "shirt", [5106] = "ddpkuubute", [5107] = "combo", [5108] = "task.cancel", [5109] = "DayAndNightHandler module", [5110] = "EXP_PER_BUNDLE",
    [5111] = "Wrapper", [5112] = "SetWebhookInterval", [5113] = "AutoBuyBait", [5114] = "POSITION_TYPES", [5115] = 296, [5116] = "Only a Human can become a demon",
    [5117] = 1058, [5118] = 388, [5119] = 1381.88, [5120] = "Mentions the user ID above on every report.", [5121] = "ggizcjqwrwdu", [5123] = "SetCardPriority",
    [5124] = "Cups", [5125] = 0.3, [5126] = 3088, [5127] = "function()returnbpz[cKb[136][5386]]end", [5128] = 1073.63, [5129] = 3769,
    [5130] = 1029.05, [5131] = "Cannot study ", [5132] = "Join refused: ", [5133] = 1102, [5134] = "nvzdsw", [5135] = "fkkxqdvnwvqh",
    [5136] = "Force Heal Cards", [5137] = "Jump Power", [5138] = 1897430675, [5139] = 797, [5140] = 952, [5141] = 1859,
    [5142] = "Debree", [5143] = "vzcayuhndb", [5144] = "IsInMuzanLayor", [5145] = 2002, [5146] = 1059, [5147] = 2263,
    [5148] = "ubaa", [5149] = "WebhookUrl", [5150] = "Hearts", [5151] = 3709, [5153] = "SpeedKey", [5154] = "AllowEmpty",
    [5155] = "Level too low", [5156] = 1727, [5157] = 11981776, [5158] = "LeftAlt", [5159] = "Items Obtained", [5160] = "Instant Kill Cache Guards",
    [5161] = "start", [5162] = "number", [5163] = 1908, [5164] = "uksyx", [5166] = "There is one quest slot, so switch this on to drop an ordinary quest that is holding it", [5167] = "fixu",
    [5169] = "hide", [5170] = 762, [5171] = 2825, [5172] = 3334, [5173] = 0.03, [5174] = 2351,
    [5175] = "SoulStatus", [5176] = 2970, [5177] = 3222, [5178] = 3387, [5179] = "HuntTiers", [5180] = 3826,
    [5181] = 6124311, [5183] = 3414, [5184] = "Auto Breathing", [5185] = "Cannot read the permit quest", [5187] = 0.35, [5188] = "Tick",
    [5189] = 262, [5190] = "tpvcq", [5191] = "auto parry scheduler: ", [5192] = "Stepped", [5193] = 3072, [5194] = 3267,
    [5196] = 842707, [5197] = "Tells you when the Black Marketer comes to town, what he's selling, and when he leaves", [5198] = 2227, [5199] = "%d attempts, %d blocks, %d missed, %d cancelled", [5200] = "defaultOrder", [5201] = "Summary",
    [5202] = "Export Config to Clipboard", [5203] = 8142175, [5204] = 660, [5205] = "swccmwutbh", [5206] = 2734, [5207] = 502,
    [5208] = 1883, [5209] = 4632494, [5210] = 1945352, [5211] = "Content-Type", [5212] = "Tells you the new clothes whenever Elara or Lynx restocks", [5213] = "instance",
    [5215] = 470, [5216] = 3011, [5217] = "SetParryPlayers", [5218] = 1537, [5219] = "AutoQueue", [5220] = "Min",
    [5221] = 3353, [5222] = 3580, [5223] = " ", [5224] = "ProximityPrompt", [5225] = "SettlePriority", [5226] = 1771,
    [5227] = 2483, [5228] = "Sealed Caches", [5229] = "distance", [5230] = "[Ouroboros] fishing step: ", [5231] = "HigoshimaDeliverTo", [5232] = "Clearing ",
    [5233] = "MaxActivationDistance", [5234] = "ayk", [5235] = "closingPad", [5236] = 12656456, [5237] = 406, [5238] = "BOSS_SUMMONS",
    [5239] = "session", [5240] = "slow_walk_speed", [5241] = "StopHold", [5242] = "Y", [5243] = "Waiting for souls", [5244] = "request",
    [5245] = "n", [5246] = 805416, [5247] = "Waiting for the run to bank its points", [5248] = 1031, [5249] = "|", [5251] = 10191192,
    [5252] = "Character_info_provider module", [5253] = "eckzb", [5254] = "Equipped", [5255] = "Legendary", [5256] = 2908, [5257] = "Cup Game",
    [5258] = 440, [5260] = 3788, [5261] = 3500, [5262] = "\\u{203A} Wen  **%s**", [5263] = "the world", [5264] = 776,
    [5266] = 362, [5267] = 2030, [5268] = 2555, [5269] = 1348.5, [5270] = 2296732130, [5271] = "Thickness",
    [5272] = 3406, [5273] = "QueueSignal", [5274] = "cmgbtkh", [5275] = 1180218661, [5276] = "No Stun", [5277] = "dxbroufbmz",
    [5278] = " studs", [5279] = "Drowning", [5280] = "EspHealthTextColour", [5281] = "TrainingNames", [5282] = "Soryu Trainee Goki", [5283] = "K",
    [5284] = 1314, [5286] = 3700724094, [5287] = "kyxjlh", [5288] = 5949681, [5289] = "Quest cooldown %ds", [5290] = "ParryRadius",
    [5291] = 2, [5292] = 2624, [5293] = 2769, [5294] = 641, [5295] = "box3d", [5296] = "Rewards",
    [5297] = 1338, [5298] = 281, [5299] = "scnntzk", [5300] = "wwxe", [5301] = "BringStatus", [5302] = "Scale",
    [5303] = 991, [5304] = "busy", [5305] = 5811817, [5306] = 1248, [5307] = "EXP_MAX_BUNDLES", [5308] = 1707,
    [5309] = 1642, [5310] = 12148722, [5311] = "game.PlaceId", [5312] = 1046, [5313] = 85799311, [5314] = 3492,
    [5315] = "square-pen", [5316] = 1754, [5317] = 160, [5318] = "shield", [5319] = "BindItems", [5320] = "ours",
    [5321] = "Skills_Provider module", [5322] = 1536, [5323] = 222, [5324] = "TimedEvent", [5325] = "bossIds", [5326] = "PriorityMode",
    [5327] = 68, [5329] = "^(%-?%d+)(%d%d%d)", [5330] = "schedule", [5331] = 3183, [5332] = "tailor", [5334] = "amybpt",
    [5335] = "SHC_PATIENCE", [5336] = 10723500, [5337] = "ydcxjiiqjs", [5338] = "box", [5341] = "Skill_Controller module", [5342] = "maeiesadin",
    [5343] = "xsolunkw", [5344] = "AutoTraining", [5345] = "lwclcwjmuyc", [5346] = 1232, [5347] = "Skip voted %d/%d", [5348] = 621,
    [5349] = "BuyExpNow", [5350] = 2559, [5351] = "SetQueueFill", [5352] = "auto parry release: ", [5353] = "NoClip", [5354] = "DescendantAdded",
    [5355] = "/", [5357] = "Server", [5358] = 684, [5359] = "CollectionService", [5361] = "Reaper Trainee Kuzan", [5362] = 7056907,
    [5363] = 1217, [5364] = "invalidate", [5365] = "Refreshed skill tree nodes", [5366] = "fiigch", [5367] = "Stamina", [5368] = 811,
    [5369] = 3809, [5370] = "returned ", [5371] = 201, [5372] = "EquipController", [5373] = "marks", [5374] = "ehu",
    [5375] = "Race", [5376] = "FlySpeed", [5377] = 3882, [5379] = 5654070, [5380] = "TabSwitch", [5381] = "nyarmijwaxu",
    [5382] = "CombatChecker", [5383] = "poll", [5384] = 5604530, [5385] = "Notifications", [5386] = "QuestChoiceCache", [5387] = "Lancer Captain",
    [5389] = "EspEnemyColour", [5390] = 695, [5391] = "NotifyHunts", [5392] = "tvwdjxwy", [5393] = "dznebiwavy", [5394] = 859025,
    [5395] = "fromRGB", [5396] = "Fish", [5397] = "Pick a training", [5398] = "Cannot", [5399] = "SetBringRange", [5400] = "Actual",
    [5401] = "[Ouroboros] dungeon step: ", [5402] = "Cleanup must be callable", [5403] = "ToServer", [5404] = "GamemodeNames", [5405] = 1815, [5406] = "Movement Type",
    [5407] = 8820348, [5408] = 9307752, [5409] = 36, [5410] = "selection", [5411] = "SetKillThreshold", [5413] = 247,
    [5414] = "Auto Loot", [5415] = "CoreGui", [5416] = "healBelow", [5417] = "Skills_Module module", [5418] = "yzqktoxtin", [5419] = 3715,
    [5420] = 3100, [5421] = 2109, [5422] = "SecondsUntilPhaseChange", [5423] = "tint", [5424] = "Keep Blocking After A Parry", [5425] = "qtzizeotmclk",
    [5426] = 353, [5427] = 2409, [5428] = "Combat", [5429] = "nzzmykiqoxg", [5430] = "Instantly finishes the moment a station opens. Play It Out plays the game's own minigame instead, which takes as long as it normally would.", [5431] = 3979,
    [5432] = 1829555, [5433] = 10058816, [5434] = "Queue", [5435] = "GetData", [5436] = "connection", [5437] = "UserInputService",
    [5440] = 182.93, [5441] = "Health", [5442] = 1811.84, [5443] = "relock", [5444] = 55694221, [5445] = "EspTracer",
    [5446] = 2166, [5447] = "Trade", [5448] = 3081, [5450] = 2606.5, [5451] = "SignalFunction module", [5452] = 3698615652,
    [5453] = 1530, [5454] = 3504, [5455] = "Private Server Owner", [5456] = "SetWenMob", [5457] = 1810849168, [5458] = 3557,
    [5459] = 1709, [5460] = 1413, [5462] = 838260520, [5463] = "SetEspOption", [5464] = 197, [5465] = "CardController",
    [5466] = 7444633, [5467] = 1667, [5468] = "MaxHealth", [5472] = "nzvdt", [5473] = "coroutine.running", [5475] = "Fujiko",
    [5476] = "SidebarCompacted", [5477] = "[Ouroboros] notification error: ", [5478] = 642, [5479] = 770, [5480] = "sent %d  |  failed %d  |  queued %d", [5481] = 3573,
    [5482] = "umpvryt", [5483] = 521, [5484] = "\\u{203A} %s  **%s**", [5485] = 1202, [5487] = "queuedSince", [5488] = 1438,
    [5489] = "PotionChoice", [5490] = 3837, [5491] = 1032, [5492] = "TextSize", [5493] = "Sealed Cache", [5494] = 2917235,
    [5495] = "screen", [5496] = 851520923, [5497] = 2164, [5498] = 95892854151512, [5499] = "Dropping stuck ", [5501] = "pme",
    [5503] = 3186, [5504] = "fzekzrhl", [5506] = 3354, [5507] = "privateOwner", [5508] = "xfofzru", [5509] = " does not lower reputation",
    [5510] = "EquippedBaitId", [5511] = 334548, [5512] = 4024, [5513] = "Tells you when a new boss hunt you can take is posted. Hunts are only for Slayers and Demons", [5514] = "wegvgyh", [5515] = 3078,
    [5516] = "synddzagic", [5517] = 826, [5518] = "Two", [5519] = "SetWebhookPingId", [5520] = "Mounts", [5521] = 2603,
    [5522] = "MinigameSkipVotes", [5523] = "swing", [5524] = 2044, [5525] = 499, [5526] = "deliverTask", [5527] = "AFK triggers: 0",
    [5528] = "Waiting", [5529] = "Max", [5530] = 3010, [5532] = "kvoztwss", [5533] = "WebhookEvents", [5535] = "git-branch",
    [5536] = "Refreshed weapons", [5537] = "nextPunch", [5540] = "hudGridModule", [5541] = "Mobs", [5542] = "animator", [5543] = 2425.51,
    [5544] = 1830818757, [5545] = "BOOT_TIMEOUT", [5546] = "HttpService", [5547] = "State", [5548] = "SkillWork", [5549] = 3237,
    [5550] = 13809387, [5551] = 1849, [5552] = "gbrrcblwhu", [5553] = 2531, [5554] = "QuestString", [5555] = "Redeemed %d, failed %d, skipped %d",
    [5556] = 4294967291, [5557] = "\\u{203A} **%s**%s", [5558] = "alwaysRun", [5559] = 2943, [5560] = 4065, [5561] = "Muzan Quest",
    [5562] = "geekrodwkt", [5563] = "Shovel", [5564] = "breath", [5565] = 5373740, [5566] = "due", [5567] = 3349,
    [5568] = 848, [5569] = "GameSettings", [5570] = 1100603553, [5571] = "GamePlay", [5572] = 3683, [5573] = 3600,
    [5574] = "Footer", [5575] = "waix", [5576] = "ItemField", [5577] = "MinigameFloor", [5578] = "&lt;", [5579] = "Teleports to each schematic you picked that you don't have yet and studies it",
    [5580] = "Squat", [5581] = "EspSpiderLilyColour", [5582] = "wczqbtktoui", [5583] = "Muzan did not hand over the bell", [5584] = 2882, [5585] = "muzanPoint",
    [5586] = "Skill Nodes Unlocked", [5587] = "MenuKeybind", [5588] = "Adornee", [5589] = "\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}\\u{2500}", [5590] = "PingId", [5591] = "No nodes selected",
    [5592] = "NpcTalking", [5593] = 1862, [5594] = "WebhookFailed", [5595] = 692, [5596] = "sliders-horizontal", [5597] = 3991,
    [5598] = "CFrame.new", [5599] = 2726, [5600] = "TaskSpecs", [5601] = "euxcsimys", [5602] = "fwsfpjodetf", [5603] = "InventoryCategory",
    [5604] = 2772, [5605] = "Animation", [5606] = 2343, [5607] = "Passes", [5608] = "Card", [5609] = "CornerRadius",
    [5610] = 2868, [5611] = "boulder", [5612] = "Wild Horse ESP", [5614] = "facing", [5615] = 2036, [5616] = 2994,
    [5618] = 7470665, [5619] = "Forge", [5620] = 576, [5621] = 1690, [5623] = "Reeling in ", [5624] = 3831,
    [5625] = "mcuvhlpuud", [5626] = 1656, [5627] = 2539, [5628] = "*Civilian*", [5629] = 1039, [5630] = "Instant ProximityPrompt",
    [5631] = "HuntController", [5632] = "move", [5633] = "SOUL_NAMES", [5634] = 1962, [5635] = "longest", [5636] = "gomljirdhwpw",
    [5637] = "vvkoxyta", [5638] = 3822, [5639] = 3110, [5640] = "Cannot release ", [5641] = 2794.09, [5642] = 3018,
    [5643] = "Breathing", [5644] = 6297874, [5645] = 1805, [5646] = "%W", [5647] = "ForceCancel", [5648] = "[Ouroboros] input release: ",
    [5649] = "Quests.CanAddQuest", [5650] = 595, [5651] = "TextColor3", [5652] = "Toolbar", [5653] = "ChestKillThreshold", [5654] = "LookVector",
    [5656] = 2018, [5657] = 688, [5658] = 0.09, [5659] = 1773, [5661] = "Delta", [5662] = 1795,
    [5663] = 1245, [5664] = 3038, [5665] = 2963240135, [5666] = 599.05, [5667] = 2525, [5668] = 12570150,
    [5669] = "Breath", [5671] = 2105, [5672] = "That is not a valid exported config", [5673] = "WorldTarget", [5676] = 2026, [5677] = 13839057,
    [5679] = 2720996, [5680] = "SetEspColour", [5681] = 1047.04, [5682] = "held", [5683] = 1736, [5684] = "Global",
    [5685] = "SwapMap", [5686] = "WebhookSkipQuiet", [5687] = 133.51, [5688] = "piko", [5689] = "OnlyAtNight", [5690] = "How far to travel for a soul, 0 collects at any distance",
    [5691] = "RunService", [5692] = 2252, [5693] = 2143, [5694] = 3479, [5695] = 394, [5696] = "Parkour Dungeon",
    [5697] = "trm", [5698] = 1714, [5699] = "Party Colour", [5700] = "SetNoRagdoll", [5701] = "Final Selection starts in ", [5702] = "Codes on cooldown, %ds left",
    [5703] = "POSE_MODES", [5704] = "SignalEvent.ToServer", [5705] = ", ", [5706] = "ItemRequirements module", [5707] = 2104, [5708] = "the catch",
    [5709] = "FilterType", [5710] = 2317, [5711] = "SetPriorityPreempt", [5712] = "RightVector", [5713] = 3710, [5714] = "SetChestKillThreshold",
    [5715] = "Assets", [5716] = 3118, [5717] = 1620, [5718] = 2393, [5719] = "CameraOffset", [5720] = "Where Are Dungeons?",
    [5721] = 41, [5722] = 2573, [5723] = 8204346, [5725] = "Instance", [5726] = 2298, [5727] = "bias",
    [5728] = "EspBossesColour", [5729] = "Cannot accept ", [5730] = 3523, [5731] = 10236034, [5732] = 1055, [5734] = "lookAtEnemy",
    [5736] = "stamp", [5737] = "gtutucgmwr", [5738] = "lease", [5739] = "Commas", [5741] = "deadline", [5743] = "GuiObject",
    [5744] = 13685070, [5745] = 1174, [5746] = 2733, [5747] = 3460, [5748] = "Import Config from Clipboard Text", [5749] = "Name",
    [5750] = " is still locked", [5751] = 2366.914, [5752] = "BaitNames", [5753] = "Katana", [5754] = "zyugkxbvygv", [5756] = 5.5,
    [5757] = 55, [5758] = 70, [5759] = 951, [5760] = "fluxus", [5761] = "Pick a world", [5763] = 2096,
    [5764] = 165.5, [5765] = "Toolbar_Equip", [5766] = 1758, [5767] = 3950, [5768] = 1324950, [5769] = 2751,
    [5770] = 122, [5771] = 1361, [5772] = "cdxenrjk", [5773] = "aclakmgxtjet", [5775] = 2477, [5776] = 8387517,
    [5777] = "No settings in that config matched this script", [5778] = 2175, [5779] = "jjgqkpn", [5780] = 12614210, [5781] = "PriorityActive", [5782] = 1697,
    [5783] = "ndeifrkk", [5784] = 2173, [5785] = "DropOwnerUserId", [5786] = 1022.2, [5787] = "questString", [5788] = 7309519,
    [5789] = "SetMovementMode", [5790] = 3680, [5791] = "scroll-text", [5792] = "colour", [5793] = "rvpqwwma", [5794] = "tyxwmbpztar",
    [5795] = 441, [5796] = "SetParryHold", [5797] = "vplq", [5799] = 3162, [5800] = 7573018, [5801] = "function()returnbpz[cKb[136][2297]]end",
    [5802] = 52831205, [5804] = "Signals", [5805] = 15066413, [5806] = 2647850, [5807] = "ShopStatus", [5808] = 3253,
    [5809] = "Powers", [5810] = "Code", [5811] = "SetAutoParry", [5812] = "setNoSun", [5813] = "Off", [5814] = "Anim",
    [5815] = "yes", [5816] = "Loop", [5817] = 594, [5818] = "Your Discord ID", [5819] = "mzktdrdrsx", [5820] = "resolvePunch",
    [5821] = "EXP_BUNDLE_POINTS", [5822] = "Black Marketer", [5823] = 2955, [5824] = "DELIVERY_QUEST", [5825] = 1358, [5826] = 1139.73,
    [5827] = 1806127, [5828] = "InputHandler module", [5829] = "Default_Swing_Wait", [5831] = 1162, [5832] = 787, [5833] = "SetBlockBareHands",
    [5834] = 1974, [5835] = "rarity", [5836] = "function()returnbpz[cKb[136][3370]]end", [5837] = "isMob", [5838] = 1766, [5839] = 146,
    [5840] = "mxkce", [5841] = "icon", [5843] = "Fly Speed", [5844] = 8379738, [5845] = 2588, [5846] = "hsx",
    [5847] = 233, [5848] = "Boulder Push", [5849] = 2161, [5850] = 752, [5851] = 3095, [5853] = "IsMob",
    [5854] = 2589, [5855] = "IsMenuPlace", [5856] = "CodeStatus", [5857] = 3645, [5858] = "id", [5859] = "Always Run",
    [5860] = "Copyable", [5862] = 1363, [5864] = "qqurbbhyq", [5865] = 999999, [5866] = 2799, [5867] = 3782,
    [5868] = "Auto Queue", [5869] = "sxufs", [5870] = "Ouwigahara Rewards", [5872] = 2643, [5873] = 617, [5874] = "Animations",
    [5875] = 1337, [5877] = "SetAutoSkillTree", [5878] = "party", [5879] = "Down", [5880] = "Priority", [5881] = "No enemies in reach",
    [5882] = 148, [5883] = "asGameScript", [5884] = "vuxk", [5885] = "SetAutoBringEnemies", [5886] = "Training complete", [5887] = 4089469951,
    [5889] = 987, [5890] = 629, [5891] = 562, [5892] = 631, [5893] = 1958, [5894] = 2674,
    [5895] = 2133870, [5896] = 913, [5897] = "SaveDisabled", [5898] = 268.36, [5899] = 1123, [5900] = "fxijr",
    [5901] = 2426, [5902] = "CAST_GRACE", [5903] = "hookLink", [5904] = 2581, [5905] = "Nothing chosen in this hand", [5906] = "Instance.new",
    [5907] = 1940, [5908] = "Items", [5909] = 1685, [5910] = 11373522, [5911] = " Report Now", [5912] = "Not enough stamina",
    [5913] = 1480, [5914] = 78, [5915] = "Nezura", [5916] = "\\u{203A} **%s**  \\u{B7}  %s", [5917] = "Buying a ", [5918] = 2438,
    [5919] = 2332, [5921] = "Rounding", [5922] = 2981783653, [5923] = 2347, [5924] = "Skill_Controller", [5925] = 3594988781,
    [5926] = "ProfileService", [5928] = 8047989, [5930] = "BorderSizePixel", [5931] = "lalzjxjgjcr", [5932] = 3168, [5933] = "Fire",
    [5935] = 3866, [5936] = 469, [5938] = "Menu bind", [5939] = "Block Points", [5940] = "Holds your stamina bar full so skills and sprinting stop being refused", [5941] = 0.4,
    [5942] = 935.54, [5943] = "pnrtmwxr", [5944] = "PlatformStand", [5945] = "STAT_NODES", [5946] = "NotifySide", [5947] = 3236,
    [5948] = "missed", [5949] = "TeleportInitFailed", [5950] = 1398, [5951] = "ugf", [5952] = 3737, [5953] = "MaxLevel",
    [5954] = "reach", [5955] = "TargetNpc", [5957] = 3449, [5958] = 311, [5959] = 1408, [5960] = 1786,
    [5961] = "Scheduling", [5962] = 407747918, [5963] = 1343, [5964] = "FishBait", [5965] = 3282, [5966] = "LevelDropForeign",
    [5968] = "auto parry: ", [5970] = 1062, [5971] = 1371, [5973] = 1688, [5975] = "Url", [5976] = "CurrentMax",
    [5977] = "Raze", [5978] = 1043, [5980] = "Vector3", [5981] = "ExpGained", [5982] = 647, [5983] = "BuilderSans",
    [5984] = 790, [5985] = "check", [5986] = 7, [5987] = "Lvl %d  |  %s  |  %s", [5988] = "Buttons", [5989] = "otap",
    [5990] = "Lives", [5992] = 2892, [5993] = 3212, [5994] = "InDungeon", [5995] = 1439065166, [5996] = 2813247,
    [5997] = 2842, [5998] = "If you're a demon, the sun no longer burns you. Does nothing for other races", [5999] = 3205, [6000] = "ChestState", [6001] = "SetParryMitigate", [6002] = "SetPotion",
    [6003] = 224, [6004] = "Breathing Cost", [6005] = 993105258, [6006] = 50, [6008] = "No native swing observed; checking equipment and readiness", [6009] = "runs",
    [6010] = "Queued", [6011] = "Spends Ouwigahara run points at the Tower Crystal on 1,000 Exp bundles.", [6012] = "Description", [6013] = "jcvhlxginece", [6014] = 156, [6015] = "Stopped after %d collected",
    [6016] = "gffzqhjsa", [6017] = 232.73, [6018] = 3921, [6019] = 1719, [6020] = "InfiniteStamina", [6021] = "",
    [6022] = 2569, [6023] = 0.2, [6024] = 27796227, [6025] = 8477295, [6026] = 805, [6027] = 2608,
    [6028] = 901, [6029] = "AutoSkillTree", [6030] = "ServerStatsItem", [6031] = 342, [6035] = "phase", [6036] = "IsNight",
    [6037] = 2429, [6038] = "Shop Purchases", [6039] = "ChestInstantKill", [6040] = "heart-pulse", [6041] = "HudGamemode", [6042] = "^%a+",
    [6043] = 49, [6045] = 565, [6046] = 11380572, [6047] = 1.5, [6049] = 9016665, [6050] = 998909995,
    [6051] = "appears at the top of this tab with the run's own features in it.", [6052] = "InstantKill", [6053] = 2021, [6054] = 720, [6055] = "hlzzyopxqnnr", [6056] = 2745,
    [6057] = "[Beta] Auto Parry V3", [6058] = 2112820, [6059] = "No reputation mob picked", [6060] = 962, [6061] = "Lynx", [6062] = "Handing in ",
    [6063] = 3515, [6064] = 2981, [6065] = "SoryuTrainee", [6066] = "Modifiers", [6067] = 610, [6068] = "Play It Out",
    [6069] = "CanAddQuest", [6070] = "module", [6071] = 3833, [6072] = 806, [6073] = "SetChestInstantKill", [6074] = 1783,
    [6075] = "coroutine.status", [6076] = "The line came back empty", [6077] = 2180, [6078] = "sortedKeys", [6079] = "nothing", [6080] = "Skills_Module",
    [6081] = "bcwugdghtza", [6082] = "score", [6083] = "ringBell", [6084] = "next in %dm %02ds  |  %d lines", [6085] = "Side", [6086] = 23,
    [6087] = "That config is too large", [6088] = 800, [6090] = "SetEsp", [6091] = 1684, [6092] = "retire", [6093] = 4057,
    [6094] = 3836, [6095] = "Player_Service", [6096] = "OuroborosOuwlandEsp", [6097] = "%d studs", [6098] = 2849, [6099] = "VirtualRelease",
    [6100] = "Regions", [6101] = 3584, [6102] = "PointsSpent", [6103] = "Enemies Defeated", [6104] = "Session", [6105] = "IsOpen",
    [6106] = "runTrim", [6107] = "Quest slot busy", [6108] = "PlayerScripts", [6109] = 3558, [6110] = 1624536, [6111] = ", searching",
    [6112] = "Tells you when Muzan comes out at night and where he is. He walks around Mistfall Harbor, Hidden Mist Village or Iceveil Valley", [6113] = "Taking the permit quest", [6114] = 2384, [6115] = 2500, [6116] = "no", [6117] = 10145320,
    [6118] = "ViewportSize", [6119] = "Health Potion", [6120] = 1414, [6121] = "[Ouroboros] boss step: ", [6122] = "AutoPotion", [6123] = 3465,
    [6124] = "swq", [6125] = 1391, [6126] = 1733, [6127] = 3754, [6128] = "task", [6129] = 3812,
    [6130] = "function()returnbpz[cKb[136][878]]end", [6131] = 2520, [6132] = "LootStatus", [6133] = 1419, [6134] = "Saved with your config, so do not share that file.", [6135] = 1322,
    [6136] = "Teleporter", [6137] = 2812, [6138] = "Activity", [6139] = "Hunt already taken", [6140] = "preset", [6141] = 253.77,
    [6142] = "^%s*(.-)%s*$", [6143] = "Yahari", [6144] = "Abandon Quest For Muzan", [6145] = "BOSS_POINTS", [6146] = "Block acknowledgement unresolved", [6147] = "MIN_AIM_REACH",
    [6148] = "chestKillThreshold", [6149] = 3567075, [6150] = "%d.", [6152] = "a fish", [6153] = 891, [6154] = 2138,
    [6155] = "Status", [6156] = "ogayflbftt", [6157] = 8027485, [6158] = "Took the Biwa Bell", [6159] = 3450, [6160] = 12603011,
    [6161] = 3843601, [6162] = "Waiting for night to find Muzan (%ds)", [6163] = 3884, [6164] = "Waiting for work", [6165] = 187.55, [6166] = 788,
    [6167] = 3242, [6169] = 2271, [6170] = "ckiwtqgvzg", [6171] = 1134, [6172] = "Waiting for the combo to settle", [6173] = "ChestController",
    [6174] = "Spider Lily", [6175] = 7314368, [6176] = "Started", [6177] = 174, [6178] = "Character", [6179] = "NotifySelection",
    [6180] = "Redeeming...", [6181] = 1119, [6182] = 3176, [6183] = "Hunts", [6184] = "infHorse", [6185] = "rpsstogh",
    [6186] = "RunPoints", [6187] = "|down", [6188] = 2626262, [6189] = "Bar", [6190] = 3022, [6191] = "Auto Claim Souls",
    [6192] = "VillageSpy", [6193] = "The bell did not open the road", [6194] = "useTool", [6195] = 2841, [6196] = "rzawefqjerp", [6198] = 3843,
    [6200] = "1,000 Exp", [6201] = " Colour", [6202] = 2324, [6203] = "cjiitij", [6204] = "IsFriendsWith", [6205] = "Skill controller unavailable",
    [6206] = "Cannot close out the delivery", [6207] = "embeds", [6208] = 2152244013, [6209] = "RedeemCode", [6210] = "SkillTreeholder module", [6211] = "HasCombat",
    [6212] = 853, [6213] = "Lighting", [6214] = 1317, [6215] = "TransformCutsceneAt", [6216] = "punch", [6217] = 1334,
    [6218] = 2671, [6219] = "reserve", [6220] = 2308, [6222] = 2462, [6223] = 620.4, [6224] = "Attempt_Hold",
    [6225] = 2223, [6226] = 639, [6227] = "Priority Scheduling", [6229] = "Finished ", [6230] = "controllers", [6231] = 1216,
    [6232] = "tom", [6233] = 2020, [6234] = "Cache Lancer", [6235] = "Reset Counters", [6237] = "Idle", [6238] = 132608042600488,
    [6239] = "ogwqmw", [6240] = "ExpiresAt", [6241] = "Auto Potion", [6242] = "Potion", [6243] = "Utility.GetData", [6244] = "cursor",
    [6245] = "Connect", [6246] = 586, [6247] = 101.6, [6248] = "nwvrqkqbo", [6249] = "EspDyingColour", [6251] = 1839,
    [6253] = 3988, [6254] = "EspChest", [6255] = 955, [6256] = "cbzehyxlrg", [6257] = "Cannot take the delivery quest", [6258] = "Fill",
    [6259] = "[Ouroboros] quest step: ", [6260] = 815.35, [6261] = "Utility module", [6263] = "pushPlan", [6264] = 3060, [6265] = 2363097491,
    [6266] = "Purchase", [6267] = 1348, [6268] = "RobloxNetworkPauseNotification", [6269] = "SetDemonDropForeign", [6270] = "RobloxPromptGui", [6272] = "fzzwodrcd",
    [6273] = " held", [6274] = 2229, [6277] = "SetWebhookPing", [6278] = 3531, [6281] = 2422, [6282] = 2313342,
    [6283] = "wxhlhzmfk", [6284] = 2824, [6285] = 2005, [6288] = "UseJumpPower", [6289] = "Potions", [6290] = 1290,
    [6291] = "Client", [6292] = "TeleportToZone", [6293] = 3167, [6294] = "range", [6296] = "STARTER_ROD", [6297] = 103229621,
    [6298] = "; ", [6300] = "Link", [6301] = 540118, [6302] = "Bundles Per Trip", [6303] = "hwid", [6304] = 2116802,
    [6305] = "Shinora", [6306] = 3555, [6308] = "SkillTree", [6309] = 61, [6311] = "getgenv did not return a table", [6312] = "X",
    [6313] = "Webhook", [6314] = 3084, [6315] = 3650, [6316] = 2675, [6317] = "healthFill", [6318] = 76,
    [6319] = "REFUSAL_GAP", [6320] = 9652528, [6321] = 5373834, [6322] = "turn", [6323] = 1599, [6324] = "AutoSoul",
    [6325] = "Visible", [6327] = 15077962, [6328] = 4080, [6329] = "Finished", [6330] = 2204362235, [6331] = "Warn Me Before",
    [6332] = "want", [6334] = "LeftControl", [6335] = "Rosewater", [6336] = "DemonMob", [6337] = "ranked", [6338] = "skillState",
    [6339] = 2679, [6340] = 2889, [6341] = "Travels to whatever the last notification was about", [6342] = "AutoEquipBest", [6343] = 10256168, [6344] = "AutoLevel",
    [6345] = 1829, [6346] = 222.74, [6347] = "GoalName", [6348] = 343, [6349] = 3392, [6350] = 3706,
    [6351] = "done", [6352] = "Nothing to buy", [6353] = "PriorityHolder", [6355] = "Damage Before Kill", [6356] = 243, [6357] = 6551896,
    [6358] = "EspBosses", [6359] = "Studying ", [6360] = "[Ouroboros] could not load %s: %s", [6361] = "owned", [6362] = "Which set drawings to go and get. Ones you already have are skipped", [6363] = 3745,
    [6364] = 954, [6365] = "Collecting drops", [6366] = 905, [6367] = "<font color=\"%s\">%s</font>  <font color=\"%s\">%s</font>", [6369] = "AbsolutePosition", [6370] = "Ill find the permit stamp(Lv 45)",
    [6371] = 1704, [6372] = "detach", [6373] = 2350522, [6375] = 11967444, [6376] = 3625, [6377] = 2457,
    [6378] = 0.6, [6379] = "puxxmnreykpz", [6380] = 2504, [6381] = "empty response", [6382] = "Kills any NPC your client has network ownership of", [6383] = 2758,
    [6384] = "uyonuvahtkfj", [6385] = "Script", [6386] = 1771.65, [6387] = "BossInfo", [6388] = "get", [6389] = "tusdzc",
    [6390] = "_.*", [6391] = "Nodes", [6392] = "ReceiveAge", [6393] = "Validators", [6394] = 8236087, [6395] = "blockBareHands",
    [6396] = "SetWorld", [6397] = 1881, [6398] = 3006, [6400] = "Markers", [6401] = "inLair", [6402] = "Gyutai",
    [6403] = "SkillNodes", [6404] = 3171, [6405] = "__DeleteAfterCall", [6407] = "Quests.Holder", [6408] = "DropReservedFor", [6409] = "waterAt",
    [6410] = 1710, [6411] = "LocalPlayer", [6412] = 977, [6413] = 677, [6414] = 1966, [6415] = "ModuleScript",
    [6416] = 724.23, [6417] = 3391, [6418] = "ymxciu", [6419] = "JumpPower", [6420] = "uqilhntj", [6421] = 191,
    [6422] = "Minigames", [6423] = "QuestCD", [6424] = "Waiting for unresolved skill ", [6425] = "Cannot reach ", [6426] = "Weld", [6427] = 1614,
    [6428] = "Spectating", [6429] = 3000, [6430] = 452.46, [6431] = "SetOwnershipRange", [6432] = "Grid", [6433] = "WaveStatus",
    [6434] = "BringRange", [6435] = 104089371, [6436] = "SLOT_NAMES", [6437] = 1327, [6438] = 14589321, [6440] = "toggled",
    [6441] = "SetPositionType", [6442] = "fireproximityprompt", [6443] = "Teleporting to ", [6444] = "fromOffset", [6445] = "DepthMode", [6446] = "CurrentCamera",
    [6448] = "How To Play Them", [6450] = 1275, [6451] = 1178, [6452] = "   \\u{D7}%d", [6453] = "COMMIT_WINDOW", [6454] = "previous",
    [6455] = 559, [6456] = 2085, [6457] = 512183, [6458] = 536, [6459] = "Sumari", [6460] = "Missing: ",
    [6461] = 4047791, [6462] = "lrf", [6463] = 1499, [6464] = "HideUiOnStart", [6465] = 3489, [6466] = 2900,
    [6467] = "Waiting for pickup readiness", [6468] = "stations", [6469] = 2648, [6470] = 295, [6471] = 1901, [6472] = 821.5,
    [6473] = "BossStatus", [6474] = "Queued for %s (%ds)", [6475] = "Vector2", [6476] = "The dungeon features only exist inside a run, so there is nothing ", [6477] = 13, [6478] = "\\u{203A} Running  **%s**",
    [6479] = "users", [6480] = 933, [6481] = 2265, [6482] = "Config copied to clipboard", [6483] = 7304931, [6484] = 120,
    [6485] = "Defence", [6486] = "mvhmg", [6487] = "level", [6488] = "playerInfo", [6489] = "xvays", [6490] = 10150570,
    [6491] = "%s Report", [6493] = "Info Colour", [6494] = "VERTICAL_CLEARANCE", [6495] = 1291, [6496] = 2481, [6497] = 3159,
    [6499] = 256421, [6500] = "InstantProximityPrompt", [6501] = "vgjmm", [6502] = "oxymedo", [6503] = "ShopItemNames", [6504] = 1970,
    [6505] = "waves", [6506] = "clearPoint", [6507] = "rmnybfucud", [6508] = "Health %d%%, taking %s", [6509] = 168, [6510] = 3446,
    [6511] = "CFrame.lookAt", [6512] = "SetSoulRange", [6513] = "QualityLevel", [6514] = 1235, [6515] = "props", [6516] = "GetRotation",
    [6517] = "Avatar", [6518] = "Watching health", [6519] = "Final Selection Plains", [6520] = "UI library required", [6521] = 3189523, [6522] = "Report Every",
    [6523] = "Auto Farming", [6524] = 543, [6525] = 8354418, [6526] = "none", [6527] = 1197, [6528] = 568,
    [6529] = "Drinking ", [6530] = "AutoBuy", [6531] = "Zones", [6532] = 534, [6533] = "hgdvbxwyhrya", [6534] = "Bring Enemies",
    [6535] = "Face", [6536] = "lookAt", [6537] = "scna", [6538] = "qvlsvkfwzrg", [6539] = 1746.56, [6540] = "Health Text",
    [6541] = "odpd", [6542] = "Weapons", [6543] = "Raid Captain", [6544] = "windowPvp", [6545] = 0.25, [6546] = "Codes",
    [6548] = "error", [6549] = 79064267, [6550] = "gkxydknl", [6551] = "Select Weapon", [6552] = 4043, [6553] = "Native punch failed: ",
    [6554] = "Keep Points", [6555] = 651, [6556] = 4148984585, [6557] = "BOSS_GUARD_RANGE", [6558] = 1827300, [6559] = 1041,
    [6560] = "skip", [6561] = 1546, [6562] = "Sealed Cache Tiers", [6563] = 2157, [6564] = "NoSunDamage", [6566] = 3029059,
    [6567] = "Freefall", [6568] = 5540993, [6569] = 124, [6570] = "Players", [6571] = "FpsBoost", [6572] = "No loot nearby",
    [6573] = 3666, [6574] = 3845, [6576] = 3838, [6577] = "%dh %02dm", [6578] = "Waiting for loot", [6579] = "WaterTrainee",
    [6580] = "nwlilinv", [6581] = 1120, [6582] = 3262, [6583] = 6184240, [6584] = 1816, [6585] = "Levelling, drops, quests and kills outside a run.",
    [6586] = "lgqdgwr", [6587] = "Menu keybind", [6588] = 3859, [6589] = "Wild Horse", [6590] = 2902, [6591] = 1121,
    [6592] = "Drop", [6593] = "dcxabjn", [6594] = 2131, [6595] = 15957039, [6596] = 2867, [6597] = -1,
    [6598] = 2130, [6599] = 3279, [6600] = 3443, [6601] = "UIStroke", [6603] = 126, [6604] = "How far out to pull enemies from, 0 brings the whole floor",
    [6605] = 2963, [6607] = "LairEntryReputation", [6608] = 2679912, [6609] = "ltdrstwjzk", [6610] = "EspSpiderLily", [6611] = "tcax",
    [6612] = "&apos;", [6614] = 451, [6616] = "Stat", [6617] = 1672, [6618] = 1128, [6619] = "afterKill",
    [6620] = "Fish Caught", [6621] = "worldsModule", [6622] = "H", [6623] = "SetAutoDelivery", [6624] = 1804, [6625] = "Muzan",
    [6626] = 2314515, [6627] = "Auto Fishing", [6628] = "Health Regen Speed", [6629] = 1, [6630] = "DrinkBelow", [6631] = 1419144615,
    [6632] = "healthBack", [6633] = 2986, [6634] = "Abandon Non Combat Quests", [6636] = "holding", [6637] = "controllerValid", [6638] = "zhcqbzhcjpkv",
    [6639] = 986, [6640] = "buyBait", [6641] = "NotifyBossSpawns",
}
local CONST = {
    ["ARRIVE_RADIUS"] = 8,
    ["BAIT_RESTOCK"] = 25,
    ["BLINK_HOLD"] = 0.35,
    ["BOOT_TIMEOUT"] = 300,
    ["BOSS_COLLECT_CAP"] = 90,
    ["BOSS_COLLECT_YIELD"] = 15,
    ["BOSS_DWELL"] = 20,
    ["BOSS_GUARDS"] = {["Yeti Demon"] = {["Small Yeti"] = true}},
    ["BOSS_GUARD_RANGE"] = 300,
    ["BOSS_NAMES"] = {"Akazo", "Datai", "Domae", "Enru", "Flame Trainee", "Fujiko", "Giyen", "Gyorei", "Gyutai", "Hoyuzo", "Insect Trainee", "Kaiden", "Mother Bear", "Nezura", "Obari", "Reaper", "Reaper Trainee Kuzan", "Rengu", "Saneri", "Serpent Trainee", "Shinora", "Sound Trainee", "Soryu Trainee Goki", "Stone Trainee", "Sumari", "Tai Chi Trainee Suzume", "Tengai", "Thunder Trainee", "Water Trainee Sabito", "Wind Trainee", "Yahari", "Yeti Demon", "Zentaro", "Zuko"},
    ["BOSS_SKIP"] = 45,
    ["BOSS_STREAM_GRACE"] = 3,
    ["CARD_NAMES"] = {"AscendClan", "Clan", "Event", "ExtraLife", "Forge", "Fortune", "Heal", "Points", "Potion", "Reroll", "Revive", "Skill", "SkillSwap", "Skip", "SkipFloor", "Stat", "SwapMap", "Trade", "Weapon"},
    ["CAST_GRACE"] = 6,
    ["CAST_MIN_GAP"] = 0.2,
    ["CHEST_GUARD_RANGE"] = 220,
    ["CHEST_TIERS"] = {"T1", "T2", "T3"},
    ["CODE_BACKOFF"] = {3, 6},
    ["CODE_COOLDOWN"] = 20,
    ["CODE_GAP"] = 1.5,
    ["CODE_MOBS"] = {["KaruVillageBandit"] = "Bandit", ["VillageSpy"] = "*Civilian*", ["HoyuzoSub"] = "Hoyuzo Subordinate", ["KaidenSub"] = "Kaiden Subordinate", ["ReaperTrainee"] = "Reaper Trainee Kuzan", ["SoryuTrainee"] = "Soryu Trainee Goki", ["TaiChiTrainee"] = "Tai Chi Trainee Suzume", ["WaterTrainee"] = "Water Trainee Sabito"},
    ["CRYSTAL_NAME"] = "Tower Crystal",
    ["DELIVERY_QUEST"] = "Ill deliver the supply box(Lv 70)",
    ["EXP_BUNDLE_POINTS"] = 3500,
    ["EXP_LISTING"] = "1, 000 Exp",
    ["EXP_MAX_BUNDLES"] = 99,
    ["EXP_PER_BUNDLE"] = 1000,
    ["FISHING_BAITS"] = {"Worm", "Fish Head", "Golden Tentacle", "Drowned Lure"},
    ["FISHING_CAST_RANGE"] = {6, 8, 10, 12},
    ["FISHING_RODS"] = {"Legendary Fishing Rod", "Rare Fishing Rod", "Basic Fishing Rod"},
    ["HEAL_CARDS"] = {["Heal"] = true},
    ["HUNT_TIERS"] = {"Common", "UnCommon", "Rare", "Epic", "Legendary", "Mythic"},
    ["LOCKOUT_TAGS"] = {"Stun", "CombatStun", "Strict_Stun", "KnockedOut", "Swapping", "combatdisabled"},
    ["MAX_LOOK_PITCH"] = 0.82,
    ["MIN_AIM_REACH"] = 1,
    ["MOB_NAMES"] = {"Akazo", "Bandit", "Bear Cub", "Beast Born Demon", "Blood Hounded Demon", "Cache Lancer", "Cache Prowler", "Datai", "Domae", "Enru", "Fire Profound Demon", "Flame Trainee", "Fujiko", "Giyen", "Greater Demon", "Grove Raider", "Gyorei", "Gyutai", "High Demon", "Hoyuzo", "Hoyuzo Subordinate", "Ice Profound Demon", "Insect Trainee", "Kaiden", "Kaiden Subordinate", "Kanoe Demon Slayer", "Lancer Captain", "Lesser Demon", "Mizunoe Demon Slayer", "Mizunoto", "Mother Bear", "Nezura", "Prowler Captain", "Raid Captain", "Reaper", "Reaper Trainee Kuzan", "Rengu", "Saneri", "Serpent Trainee", "Shinora", "Soryu Trainee Goki", "Sound Trainee", "Stone Trainee", "Sumari", "Tai Chi Trainee Suzume", "Tengai", "Thunder Trainee", "Water Trainee Sabito", "Wind Trainee", "Yahari", "Zentaro", "Zuko"},
    ["MOVEMENT_MODES"] = {"Tween", "Teleport"},
    ["NEVER_CAST"] = {["Blocking"] = true, ["Dash"] = true, ["Double_Jump"] = true},
    ["ORBIT_SPEED"] = 1.8,
    ["PARRY_GAP"] = 0.1,
    ["PASSIVE_MOBS"] = {["Civilian"] = true, ["*Civilian*"] = true},
    ["PERMIT_QUEST"] = "Ill find the permit stamp(Lv 45)",
    ["POSITION_TYPES"] = {"Above", "Below", "Behind", "Front", "Side", "Orbit", "Inside"},
    ["POTION_NAMES"] = {"Health Elixir", "Health Potion", "Health Regen Elixir", "Health Regen Potion", "Stamina Regen Elixir", "Stamina Regen Potion", "Underwater Breathing Potion"},
    ["REFUSAL_GAP"] = 0.35,
    ["Reset"] = 4045,
    ["SHC_PATIENCE"] = 6,
    ["SHOP_VENDORS"] = {["Regular Katana"] = "Raze", ["Fancy Katana"] = "Raze", ["Health Regen Potion"] = "Rika", ["Stamina Regen Potion"] = "Rika", ["Basic Fishing Rod"] = "Fisherman Jeso", ["Rare Fishing Rod"] = "Fisherman Jeso", ["Worm"] = "Fisherman Jeso", ["Fish Head"] = "Baitmonger Nori", ["Shovel"] = "Winter Store Rep Lynx"},
    ["SLOT_NAMES"] = {"One", "Two", "Three", "Four", "Five"},
    ["SOUL_NAMES"] = {["Weak Soul"] = true, ["Strong Soul"] = true, ["Brave Soul"] = true},
    ["STARTER_ROD"] = "Basic Fishing Rod",
    ["STAT_NODES"] = {["Max Health"] = true, ["Max Stamina"] = true, ["Additional Damage"] = true, ["Stamina Regen Speed"] = true, ["Health Regen Speed"] = true, ["Block Regen"] = true, ["Block Points"] = true},
    ["STAT_WEIGHTS"] = {["Max Health"] = 1, ["Max Stamina"] = 0.6, ["Additional Damage"] = 25, ["Additional Damage Factor"] = 900, ["Movement Speed Factor"] = 300, ["Stamina Regen Speed"] = 120, ["Health Regen Speed"] = 120, ["Block Points"] = 30, ["Block Regen"] = 80},
    ["TRAINING_CODES"] = {["Meditation"] = true, ["Pushups"] = true, ["Squat"] = true, ["Boulder Push"] = true, ["Boulder Split"] = true, ["Target Shooting"] = true, ["Cup Game"] = true, ["Parkour Dungeon"] = true},
    ["TRAINING_NAMES"] = {"Boulder Push", "Boulder Split", "Cup Game", "Meditation", "Pushups", "Squat", "Target Shooting"},
    ["TRAINING_TIMEOUT"] = 180,
    ["VERTICAL_CLEARANCE"] = 2,
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
