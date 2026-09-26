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
-- Данные ESP-вкладки — состояние 3477 рабочей сборки (вариант B)
--   @1 947 331: bna["opt"] = cKb[92] (тумблеры), @1 948 160: cKb[147] (палитра),
--   @1 961 295: cKb[57] (углы). В варианте A (@1 756 346) то же самое собрано
--   иначе: cKb[92] — модуль с полями CATEGORIES/opt/colour/clear, палитра —
--   cKb[51]. Подробности и доказательства — data/BUILD_MAP.md.
-- ---------------------------------------------------------------------------
-- Список категорий (bna["CATEGORIES"], рабочая сборка)
local CATEGORIES = { "Players", "Mobs", "Bosses", "NPCs", "Muzan", "Spider Lily",
                     "Chests", "Wild Horse", "Levers" }
-- Тумблеры экрана ESP (cKb[92]): снимок «по умолчанию» — всё выключено,
-- дальность 5000; ключ "Warn Me Before" — предупреждение до входа в радиус.
local toggles = {                                  -- cKb[92] (bna["opt"])
    ["box"]          = false,
    ["Warn Me Before"] = false,
    ["box3d"]        = false,
    ["name"]         = false,
    ["distance"]     = false,
    ["healthBar"]    = false,
    ["healthText"]   = false,
    ["tracer"]       = false,
    ["playerInfo"]   = false,
    ["range"]        = 5000,
}

-- Палитра подписей (cKb[147]): категория → Color3.fromRGB(r, g, b).
-- Значения 1:1 из артефакта; Color3 создаётся лениво (модуль грузится и там,
-- где его нет — смоук).
local PALETTE_RGB = {                              -- cKb[147]
    ["name"]        = { 255, 255, 255 },
    ["distance"]    = { 255, 255, 255 },
    ["health"]      = { 0,   255, 0   },
    ["dying"]       = { 255, 0,   0   },
    ["healthText"]  = { 255, 255, 255 },
    ["info"]        = { 255, 255, 255 },
    ["Players"]     = { 255, 0,   0   },
    ["Party"]       = { 0,   255, 0   },
    ["Mobs"]        = { 0,   170, 255 },
    ["Bosses"]      = { 255, 170, 0   },
    ["NPCs"]        = { 120, 255, 150 },
    ["Muzan"]       = { 200, 0,   60  },
    ["Spider Lily"] = { 255, 80,  160 },
    ["Chests"]      = { 255, 200, 40  },
    ["Wild Horse"]  = { 215, 175, 120 },
    ["Levers"]      = { 170, 120, 255 },
}
local palette = setmetatable({}, {               -- cKb[147]
    __index = function(t, key)
        local rgb = PALETTE_RGB[key]
        if not rgb then return nil end
        local ok, color = pcall(function() return Color3.fromRGB(rgb[1], rgb[2], rgb[3]) end)
        t[key] = ok and color or false
        return t[key]
    end,
})

-- Восемь углов куба (cKb[57]) — обход углов при 3D-боксе (box3d).
local corners = {                                  -- cKb[57]
    Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1),
    Vector3.new(-1, 1, -1),  Vector3.new(-1, 1, 1),
    Vector3.new(1, -1, -1),  Vector3.new(1, -1, 1),
    Vector3.new(1, 1, -1),   Vector3.new(1, 1, 1),
}

-- Два представления одного и того же (в артефакте встречаются оба варианта):
local screen = {                       -- bna (рабочая сборка)
    ["on"] = {},                       -- включённые категории
    ["entries"] = {},                  -- модель → { holder = рамка }
    ["screen"] = nil,                  -- GuiObject экрана
    ["in fo"] = {},                    -- строки «info» по категории
    ["anyOn"] = false,
    ["CATEGORIES"] = CATEGORIES,
    ["opt"] = toggles,
    ["colour"] = nil,                  -- заполняется после палитры
}
local module = {                       -- cKb[92] в варианте A
    ["CATEGORIES"] = CATEGORIES,
    ["opt"] = toggles,
    ["colour"] = nil,
    ["clear"] = nil,                   -- F3998
}
screen["colour"] = palette
module["colour"] = palette

-- ===========================================================================
-- МОДУЛЬ ESP (в артефакте — таблица `bpc`, поля camera…collect + bounds/health/
-- hide/tint/render). Ниже — тела, вычитанные из пула (номера в скобках):
--   camera F5089, container F6613, newFrame F4132, newLabel F2752, line F5265,
--   anchorPart F5538, bounds F790, health F675, tint F4525, hide F163,
--   add (сборка записи), drop, bossNames F4162, render F5471, clear F3998.
-- ===========================================================================

-- 12 рёбер куба (cKb[39]) — пары индексов в cKb[57] (углы куба)
local EDGES = { { 1, 3 }, { 7, 8 }, { 2, 6 }, { 3, 4 }, { 5, 7 }, { 5, 6 },
                { 1, 2 }, { 6, 8 }, { 4, 8 }, { 3, 7 }, { 1, 5 }, { 2, 4 } }

-- Куда вешать ScreenGui: gethui() → CoreGui → PlayerGui (в артефакте — bpZ(CoreGui))
local function UIContainer()
    local ok, gethui = pcall(function() return gethui end)
    if ok and type(gethui) == "function" then
        local ok2, handle = pcall(gethui)
        if ok2 and handle then return handle end
    end
    local ok3, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if ok3 and coreGui then return coreGui end
    local player = game:GetService("Players").LocalPlayer
    return player and player:FindFirstChild("PlayerGui") or nil
end

local function Camera()                                  -- F5089
    return workspace["CurrentCamera"]
end

local function Container()                               -- F6613
    if screen["screen"] and screen["screen"]["Parent"] then return screen["screen"] end
    local gui = Instance.new("ScreenGui")
    gui["Name"] = "OuroborosOuwlandEsp"
    gui["ResetOnSpawn"] = false
    gui["IgnoreGuiInset"] = true
    gui["DisplayOrder"] = 999999
    gui["Parent"] = UIContainer()
    screen["screen"] = gui
    return gui
end

local function NewFrame(parent, zIndex)                  -- F4132
    local frame = Instance.new("Frame")
    frame["AnchorPoint"] = Vector2.new(0.5, 0.5)
    frame["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    frame["BorderSizePixel"] = 0
    frame["Visible"] = false
    frame["ZIndex"] = zIndex
    frame["Parent"] = parent
    return frame
end

local function NewLabel(parent, zIndex)                  -- F2752
    local label = Instance.new("TextLabel")
    label["AnchorPoint"] = Vector2.new(0.5, 0.5)
    label["BackgroundTransparency"] = 1
    label["Size"] = UDim2.fromOffset(240, 14)
    label["Font"] = Enum.Font.BuilderSansBold
    label["TextSize"] = 13
    label["TextStrokeTransparency"] = 0.4
    label["Visible"] = false
    label["ZIndex"] = zIndex
    label["Parent"] = parent
    return label
end

local function Line(frame, pointA, pointB)               -- F5265
    local delta = pointB - pointA
    frame["Size"] = UDim2.fromOffset(math.max(delta.Magnitude, 1), 1)
    frame["Position"] = UDim2.fromOffset((pointA.X + pointB.X) * 0.5, (pointA.Y + pointB.Y) * 0.5)
    frame["Rotation"] = math.deg(math.atan2(delta.Y, delta.X))
end

local function AnchorPart(model)                         -- F5538
    local part = model:FindFirstChild("HumanoidRootPart")
    if part then return part end
    part = model["PrimaryPart"]
    if part then return part end
    return model:FindFirstChildWhichIsA("BasePart", true)
end

local function Bounds(model)                             -- F790
    local ok, cf, size = pcall(model.GetBoundingBox, model)
    if not ok or typeof(cf) ~= "CFrame" or typeof(size) ~= "Vector3" then return nil, nil end
    if size.Magnitude < 0.1 then return cf, Vector3.new(4, 8, 4) end
    return cf, size
end

local function Health(entry)                             -- F675
    local humanoid = entry["humanoid"]
    if humanoid and humanoid["Parent"] and humanoid["Health"] and humanoid["Health"] > 0 then
        return humanoid["Health"], humanoid["MaxHealth"]
    end
    local instance = entry["instance"]
    if not (instance and instance["GetAttribute"]) then return nil, nil end
    return tonumber(instance:GetAttribute("Health")), tonumber(instance:GetAttribute("Serpent"))
end

local function Tint(entry)                               -- F4525
    local color = palette[entry["category"]]
    if color then return color end
    if entry["category"] == "Players" then
        return entry["party"] and palette["Party"] or palette["Players"]
    end
    return Color3.fromRGB(255, 255, 255)
end

local function Hide(entry)                               -- F163
    entry["box"]["Visible"] = false
    entry["tracer"]["Visible"] = false
    entry["name"]["Visible"] = false
    entry["distance"]["Visible"] = false
    entry["info"]["Visible"] = false
    entry["healthText"]["Visible"] = false
    entry["healthBack"]["Visible"] = false
    entry["healthFill"]["Visible"] = false
    for _, line in ipairs(entry["lines"]) do line["Visible"] = false end
end

local function DropEntry(model)                          -- cKb[147]["drop"]
    local entry = screen["entries"][model]
    if not entry then return end
    screen["entries"][model] = nil
    if entry["holder"] then
        pcall(function() entry["holder"]:Destroy() end)
    end
end

-- Сборка записи — как в артефакте (bpc["add"]): папка Entry → рамка (box) со
-- штрихом, таблица линий (12), трейсер, четыре подписи и полоса здоровья.
local function AddEntry(model, label, category, player)  -- cKb[147]["add"]
    if screen["entries"][model] then return end
    local holder = Instance.new("Folder")
    holder["Name"] = "Entry"
    holder["Parent"] = Container()

    local box = NewFrame(holder, 2)
    local stroke = Instance.new("UIStroke")
    stroke["Thickness"] = 1
    stroke["Color"] = Color3.fromRGB(255, 255, 255)
    stroke["Parent"] = box

    local lines = table.create(#EDGES)
    for index = 1, #EDGES do
        lines[index] = NewFrame(holder, 3)
    end

    local healthBack = NewFrame(holder, 2)
    healthBack["BackgroundColor3"] = Color3.fromRGB(15, 15, 15)
    local healthFill = NewFrame(holder, 3)
    healthFill["AnchorPoint"] = Vector2.new(0.5, 1)

    screen["entries"][model] = {
        ["instance"] = model,
        ["part"] = AnchorPart(model),
        ["label"] = label,
        ["category"] = category,
        ["player"] = player,
        ["humanoid"] = model:FindFirstChildOfClass("Humanoid"),
        ["holder"] = holder,
        ["box"] = box,
        ["stroke"] = stroke,
        ["lines"] = lines,
        ["tracer"] = NewFrame(holder, 2),
        ["name"] = NewLabel(holder, 4),
        ["distance"] = NewLabel(holder, 4),
        ["info"] = NewLabel(holder, 4),
        ["healthText"] = NewLabel(holder, 4),
        ["healthBack"] = healthBack,
        ["healthFill"] = healthFill,
    }
end

local CombatPresets                                  -- bno["CombatPresets"] (см. Core)
local function SetPresetSource(source)                -- вызывается сборкой после загрузки ядра
    CombatPresets = source
end

local function BossNames()                               -- F4162
    local names = {}
    local presets = CombatPresets and CombatPresets["Presets"] or {}
    for _, record in ipairs(presets) do
        local folder = record["folder"]
        if folder and folder:FindFirstChild("BossInfo") then
            names[folder["Name"]] = true
        end
    end
    return names
end

local function ClearScreen()                             -- cKb[92]["clear"] (F3998)
    if screen["screen"] then
        pcall(function() screen["screen"]:Destroy() end)
    end
    screen["screen"] = nil
    for model in pairs(screen["entries"]) do
        DropEntry(model)
    end
end

-- Отрисовка кадра — F5471: по каждой записи считаем экранные координаты восьми
-- углов габарита, рисуем рамку/имя/дистанцию/здоровье/трейсер/3D-бокс.
local function Render()
    local camera = Camera()
    if not camera then return end
    local cameraPosition = camera["CFrame"]["Position"]
    local viewport = camera["ViewportSize"]
    local range = toggles["range"] or 5000
    local anyOn = false

    for model, entry in pairs(screen["entries"]) do
        local part = entry["part"] or AnchorPart(model)
        entry["part"] = part
        if not (part and part:IsDescendantOf(game)) then
            DropEntry(model)
        else
            local distance = (part["Position"] - cameraPosition).Magnitude
            if range > 0 and distance > range then
                Hide(entry)
            else
                local color = Tint(entry)
                local cf, size = Bounds(model)
                local points = table.create(#corners)
                local minX, minY, maxX, maxY
                if cf and size then
                    for index, cornerOffset in ipairs(corners) do
                        local projected, onScreen = camera:WorldToViewportPoint(
                            cf:PointToWorldSpace(cornerOffset * size * 0.5))
                        if onScreen then
                            points[index] = Vector2.new(projected.X, projected.Y)
                            minX = math.min(minX or projected.X, projected.X)
                            maxX = math.max(maxX or projected.X, projected.X)
                            minY = math.min(minY or projected.Y, projected.Y)
                            maxY = math.max(maxY or projected.Y, projected.Y)
                        end
                    end
                end

                if not (minX and minY) then
                    Hide(entry)
                else
                    anyOn = true
                    local centerX = (minX + maxX) * 0.5
                    local centerY = (minY + maxY) * 0.5
                    local width = maxX - minX
                    local height = maxY - minY

                    local box = entry["box"]
                    box["Position"] = UDim2.fromOffset(centerX, centerY)
                    box["Size"] = UDim2.fromOffset(width, height)
                    box["BackgroundColor3"] = color
                    box["BackgroundTransparency"] = 0.75
                    box["Visible"] = toggles["box"] and true or false
                    entry["stroke"]["Enabled"] = toggles["box"] and true or false
                    entry["stroke"]["Color"] = color

                    for index, edge in ipairs(EDGES) do
                        local line = entry["lines"][index]
                        local first, second = points[edge[1]], points[edge[2]]
                        line["Visible"] = toggles["box3d"] and (first ~= nil and second ~= nil) or false
                        if first and second then
                            line["BackgroundColor3"] = color
                            Line(line, first, second)
                        end
                    end

                    entry["name"]["Text"] = entry["label"]
                    entry["name"]["TextColor3"] = palette["name"]
                    entry["name"]["Position"] = UDim2.fromOffset(centerX, minY - 9)
                    entry["name"]["Visible"] = toggles["name"] and true or false

                    entry["distance"]["Text"] = string.format("%d studs", math.floor(distance))
                    entry["distance"]["TextColor3"] = palette["distance"]
                    entry["distance"]["Position"] = UDim2.fromOffset(centerX, maxY + 9)
                    entry["distance"]["Visible"] = toggles["distance"] and true or false

                    local health, maxHealth = Health(entry)
                    if toggles["healthBar"] and health and maxHealth and maxHealth > 0 then
                        local ratio = math.clamp(health / maxHealth, 0, 1)
                        entry["healthBack"]["Position"] = UDim2.fromOffset(minX - 5, centerY)
                        entry["healthBack"]["Size"] = UDim2.fromOffset(3, height)
                        entry["healthBack"]["Visible"] = true
                        entry["healthFill"]["Position"] = UDim2.fromOffset(minX - 5, centerY + height * 0.5)
                        entry["healthFill"]["Size"] = UDim2.fromOffset(3, height * ratio)
                        entry["healthFill"]["BackgroundColor3"] = palette["health"]:Lerp(palette["dying"], 1 - ratio)
                        entry["healthFill"]["Visible"] = true
                    else
                        entry["healthBack"]["Visible"] = false
                        entry["healthFill"]["Visible"] = false
                    end

                    if toggles["healthText"] and health and maxHealth and maxHealth > 0 then
                        entry["healthText"]["Text"] = string.format("%d / %d", math.floor(health), math.floor(maxHealth))
                        entry["healthText"]["TextColor3"] = palette["healthText"]
                        entry["healthText"]["Position"] = UDim2.fromOffset(centerX - 40, centerY)
                        entry["healthText"]["Visible"] = true
                    else
                        entry["healthText"]["Visible"] = false
                    end

                    local detail = entry["info"]
                    if toggles["playerInfo"] and entry["category"] == "Players" then
                        detail["Text"] = entry["detail"] or entry["label"]
                        detail["TextColor3"] = palette["info"]
                        detail["Position"] = UDim2.fromOffset(centerX, maxY - 0.75)
                        detail["Visible"] = true
                    else
                        detail["Visible"] = false
                    end

                    local tracer = entry["tracer"]
                    tracer["Visible"] = toggles["tracer"] and true or false
                    if toggles["tracer"] then
                        tracer["BackgroundColor3"] = color
                        Line(tracer, Vector2.new(viewport.X * 0.5, viewport.Y), Vector2.new(centerX, maxY))
                    end
                end
            end
        end
    end

    if screen["screen"] then
        screen["screen"]["Enabled"] = anyOn
    end
end

local function StartEspLoop()                            -- bpz: RunService.RenderStepped
    local runService = game:GetService("RunService")
    return runService["RenderStepped"]:Connect(function() pcall(Render) end)
end

-- Поля модуля — как в артефакте (bpc[...]): цвета остаются в palette (cKb[147])
module["camera"] = Camera
module["container"] = Container
module["newFrame"] = NewFrame
module["newLabel"] = NewLabel
module["line"] = Line
module["anchorPart"] = AnchorPart
module["bounds"] = Bounds
module["health"] = Health
module["hide"] = Hide
module["tint"] = Tint
module["add"] = AddEntry
module["drop"] = DropEntry
module["bossNames"] = BossNames
module["clear"] = ClearScreen
module["render"] = Render

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
    CATEGORIES = CATEGORIES,           -- bna["CATEGORIES"]
    screen = screen,                   -- bna: состояние экрана ESP
    module = module,                   -- вариант A: cKb[92] как модуль
    toggles = toggles,                 -- cKb[92]/["opt"]: тумблеры ESP
    palette = palette,                 -- cKb[147]: цвета подписей
    PALETTE_RGB = PALETTE_RGB,         -- «сырые» значения палитры
    corners = corners,                 -- cKb[57]: углы для box3d
    EDGES = EDGES,                     -- cKb[39]: 12 рёбер куба (box3d)
    Camera = Camera,
    Container = Container,
    NewFrame = NewFrame,
    NewLabel = NewLabel,
    Line = Line,
    AnchorPart = AnchorPart,
    Bounds = Bounds,
    Health = Health,
    Tint = Tint,
    HideEntry = Hide,
    AddEntry = AddEntry,               -- cKb[147]["add"]
    DropEntry = DropEntry,             -- cKb[147]["drop"]
    BossNames = BossNames,             -- cKb[147]["bossNames"]
    SetPresetSource = SetPresetSource, -- источник списка пресетов (bno.CombatPresets)
    ClearScreen = ClearScreen,         -- cKb[92]["clear"]
    Render = Render,                   -- cKb[147]["render"]
    StartEspLoop = StartEspLoop,
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
