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
