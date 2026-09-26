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
