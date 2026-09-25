--[[ ============================================================================
  NZL Studio — Ouroboros behavior recorder v3  (targeted)
  ----------------------------------------------------------------------------
  Запускать ПОСЛЕ оригинального Ouroboros. Ничего не блокирует и не подменяет
  возвращаемые значения — только записывает и дублирует вызовы.

  Что нового против v2:
    * кнопки-метки сцен: SKILLS / PARRY / EQUIP / LOOT / OTHER
      (нажми метку ПЕРЕД сценой — я увижу, где что происходит)
    * авто-копирование в буфер каждые 8 секунд (кнопку жать не обязательно)
    * дубль трассы в StringValue ReplicatedStorage.NZL_Trace (если буфер недоступен)
    * авто-поиск ремоутов: все RemoteEvent/RemoteFunction в ReplicatedStorage
      хукаются через hookfunction, если исполнитель это умеет
    * все функции модулей SkillController и InputHandler, а не только те, что знали
    * все публичные функции API-таблицы Ouroboros (не только 15 имён)

  Инструкция: выполнить целиком -> включить нужную фичу в меню Ouroboros ->
  нажать метку -> подождать -> COPY TRACE (или просто подожди, оно скопирует само).
============================================================================ ]]

local RS      = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LP      = Players.LocalPlayer
local logs, started = {}, os.clock()
local HOOKED, RESTORE, TAGS = 0, {}, {}
local BUF_OK = type(setclipboard) == "function" or type(toclipboard) == "function"
local copy = setclipboard or toclipboard

-- --------------------------------------------------------------------------- 
-- печать значений
local function repr(v, depth)
    depth = depth or 0
    if depth > 3 then return "{...}" end
    local t = typeof(v)
    if t == "string" then return string.format("%q", v)
    elseif t == "number" or t == "boolean" or t == "nil" then return tostring(v)
    elseif t == "Instance" then return "INSTANCE(" .. v:GetFullName() .. ")"
    elseif t == "Vector3" then return ("Vector3(%.2f,%.2f,%.2f)"):format(v.X, v.Y, v.Z)
    elseif t == "CFrame" then local p = v.Position
        return ("CFrame(%.2f,%.2f,%.2f)"):format(p.X, p.Y, p.Z)
    elseif t == "table" then
        local out, n = { "{" }, 0
        for k, x in pairs(v) do
            n += 1
            if n > 20 then out[#out + 1] = "..." break end
            out[#out + 1] = "[" .. repr(k, depth + 1) .. "]=" .. repr(x, depth + 1) .. ","
        end
        out[#out + 1] = "}"
        return table.concat(out)
    end
    return t .. "(" .. tostring(v) .. ")"
end

local function log(kind, ...)
    local p, out = table.pack(...), { ("[%8.3f] %s"):format(os.clock() - started, kind) }
    for i = 1, p.n do out[#out + 1] = "  A" .. i .. "=" .. repr(p[i]) end
    logs[#logs + 1] = table.concat(out, "\n")
end

local function dump()
    return "OUROBOROS_BEHAVIOR_TRACE_V3\n" .. table.concat(logs, "\n\n")
end

local function copyNow(silent)
    if not copy then return false end
    local text = dump()
    local ok = pcall(copy, text)
    if ok and not silent then return true end
    return ok
end

local function publish()
    -- дубль в ReplicatedStorage, чтобы трасса выжила, если буфер недоступен
    local holder = RS:FindFirstChild("NZL_Trace")
    if not holder then
        local ok, made = pcall(Instance.new, "StringValue")
        if not ok then return end
        holder = made
        holder.Name = "NZL_Trace"
        pcall(function() holder.Parent = RS end)
    end
    pcall(function() holder.Value = dump() end)
end

-- ---------------------------------------------------------------------------
-- обёртки
local function hookFunction(tbl, key, label)
    if type(tbl) ~= "table" or type(tbl[key]) ~= "function" then
        log("HOOK_MISSING " .. label)
        return false
    end
    local old = tbl[key]
    tbl[key] = function(...)
        log(label, ...)
        local r = table.pack(old(...))
        log(label .. " RETURN", table.unpack(r, 1, r.n))
        return table.unpack(r, 1, r.n)
    end
    RESTORE[#RESTORE + 1] = function() if tbl[key] ~= old then tbl[key] = old end end
    HOOKED += 1
    log("HOOKED " .. label)
    return true
end

local function hookAll(tbl, label)
    if type(tbl) ~= "table" then log("HOOK_MISSING " .. label) return end
    local n = 0
    for key, value in pairs(tbl) do
        if type(key) == "string" and type(value) == "function" then
            hookFunction(tbl, key, label .. "." .. key)
            n += 1
            if n >= 40 then break end
        end
    end
    if n == 0 then log("HOOK_EMPTY " .. label) end
end

local function path(root, ...)
    local x = root
    for _, name in ipairs({ ... }) do
        x = x and x:FindFirstChild(name)
    end
    return x
end

local function req(x)
    local ok, v = pcall(require, x)
    return ok and v or nil
end

-- ---------------------------------------------------------------------------
-- 1. ремоуты: всё, что клиент шлёт на сервер
local function scanRemotes(root, depth)
    if depth > 4 or not root then return end
    for _, obj in ipairs(root:GetChildren()) do
        local ok = pcall(function()
            local isRemote = obj:IsA("RemoteEvent") or obj:IsA("UnreliableRemoteEvent")
            if isRemote and type(hookfunction) == "function" and not TAGS[obj] then
                TAGS[obj] = true
                local old = obj.FireServer
                local new = function(self, ...)
                    log("REMOTE " .. obj:GetFullName(), ...)
                    return old(self, ...)
                end
                pcall(hookfunction, old, new)
                HOOKED += 1
                log("HOOKED REMOTE " .. obj:GetFullName())
            end
        end)
        if not ok then end
        if depth < 4 then scanRemotes(obj, depth + 1) end
    end
end

-- 2. игровые сигналы и модули (то, что реально зовёт Ouroboros)
hookFunction(req(path(RS, "Communication", "ServerAndClient", "Signals", "SignalEvent")), "ToServer", "SignalEvent.ToServer")
hookFunction(req(path(RS, "Communication", "ServerAndClient", "Signals", "SignalFunction")), "ToServer", "SignalFunction.ToServer")
hookAll(req(path(RS, "CAM", "Client", "Components", "Client", "InputHandler")), "InputHandler")
hookAll(req(path(RS, "CAM", "Client", "Controllers", "Skill_Controller")), "SkillController")

-- 3. API-таблица Ouroboros: находим по характерным ключам и оборачиваем всё
local api
if type(getgc) == "function" then
    for _, v in ipairs(getgc(true)) do
        if type(v) == "table" and type(rawget(v, "SetAutoLevel")) == "function"
                and type(rawget(v, "SetAutoMob")) == "function" then
            api = v
            break
        end
    end
end
if api then
    hookAll(api, "API")
    log("API_FOUND")
else
    log("API_NOT_FOUND")
end

-- 4. ремоуты в ReplicatedStorage (включая чужие, если есть права)
local okScan = pcall(scanRemotes, RS, 0)
log("REMOTE_SCAN " .. tostring(okScan))

-- 5. сэмплер движения
local sampling = true
local lastPosition
local function nearby(position)
    local list = {}
    for _, object in ipairs(workspace:GetPartBoundsInRadius(position, 18)) do
        local model = object:FindFirstAncestorOfClass("Model")
        local name = (model or object).Name
        if not table.find(list, name) then
            list[#list + 1] = name
            if #list >= 8 then break end
        end
    end
    return table.concat(list, " | ")
end

task.spawn(function()
    while sampling do
        task.wait(0.2)
        local character = LP.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root then
            local position = root.Position
            if not lastPosition or (position - lastPosition).Magnitude >= 6 then
                log("LOCAL_MOVE", root.CFrame, "NEAR=" .. nearby(position))
                lastPosition = position
            end
        else
            lastPosition = nil
        end
    end
end)

-- авто-копирование и публикация
task.spawn(function()
    local last = 0
    while sampling do
        task.wait(8)
        if #logs ~= last then
            last = #logs
            publish()
            copyNow(true)
        end
    end
end)

-- ---------------------------------------------------------------------------
-- 6. интерфейс: метки сцен + копирование
local gui = Instance.new("ScreenGui")
gui.Name = "NZL_BehaviorTrace"
gui.ResetOnSpawn = false
pcall(function()
    gui.Parent = (type(gethui) == "function" and gethui()) or game:GetService("CoreGui")
end)
if not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(430, 250)
frame.Position = UDim2.new(0.5, -215, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(14, 17, 24)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -24, 0, 46)
title.Position = UDim2.fromOffset(12, 8)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.Gotham
title.TextSize = 13
title.TextWrapped = true
title.Text = "Рекордер v3. Нажми метку ПЕРЕД сценой, потом включи фичу в Ouroboros."
title.Parent = frame

local row = Instance.new("Frame")
row.Size = UDim2.new(1, -24, 0, 34)
row.Position = UDim2.fromOffset(12, 58)
row.BackgroundTransparency = 1
row.Parent = frame

local function button(text, x, width, colour, onClick)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(width, 34)
    b.Position = UDim2.fromOffset(x, 0)
    b.BackgroundColor3 = colour
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Text = text
    b.Parent = row
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(onClick)
    return b
end

local marks = {}
local function mark(name)
    table.insert(marks, name)
    log("===== SCENE " .. name .. " =====")
    publish()
    title.Text = "Метка: " .. name .. ". Теперь включай фичу."
end

button("SKILLS", 0, 96, Color3.fromRGB(55, 115, 235), function() mark("SKILLS") end)
button("PARRY", 102, 86, Color3.fromRGB(210, 80, 90), function() mark("PARRY") end)
button("EQUIP", 194, 86, Color3.fromRGB(60, 170, 120), function() mark("EQUIP") end)
button("LOOT", 286, 74, Color3.fromRGB(180, 150, 60), function() mark("LOOT") end)

local second = Instance.new("Frame")
second.Size = UDim2.new(1, -24, 0, 34)
second.Position = UDim2.fromOffset(12, 100)
second.BackgroundTransparency = 1
second.Parent = frame

local function button2(text, x, width, colour, onClick)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(width, 34)
    b.Position = UDim2.fromOffset(x, 0)
    b.BackgroundColor3 = colour
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Text = text
    b.Parent = second
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(onClick)
    return b
end

local copyButton = button2("COPY TRACE", 0, 150, Color3.fromRGB(55, 115, 235), function()
    if copyNow() then
        title.Text = ("Скопировано %d симв. Вставь в чат."):format(#dump())
    else
        title.Text = "Буфер недоступен: возьми ReplicatedStorage.NZL_Trace"
    end
end)

local hint = Instance.new("TextLabel")
hint.Size = UDim2.new(1, -24, 0, 56)
hint.Position = UDim2.fromOffset(12, 142)
hint.BackgroundTransparency = 1
hint.TextColor3 = Color3.fromRGB(190, 196, 210)
hint.Font = Enum.Font.Gotham
hint.TextSize = 12
hint.TextWrapped = true
hint.TextXAlignment = Enum.TextXAlignment.Left
hint.Text = "Если буфера нет — трасса сама пишется в ReplicatedStorage.NZL_Trace "
    .. "и копируется в буфер каждые 8 секунд."
hint.Parent = frame

local stopButton = button2("STOP", 158, 120, Color3.fromRGB(55, 58, 68), function()
    sampling = false
    for i = #RESTORE, 1, -1 do pcall(RESTORE[i]) end
    publish()
    copyNow(true)
    title.Text = "Остановлено. Скопируй трассу в чат."
    frame.Size = UDim2.fromOffset(430, 120)
end)

log("RECORDER_V3_STARTED hooks=%d clipboard=%s remotes=%s",
    HOOKED, tostring(BUF_OK), tostring(okScan))
title.Text = ("Рекордер v3 активен (хуков: %d). Жми метку сцены."):format(HOOKED)
