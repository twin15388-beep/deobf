-- Заглушки Roblox/executor, чтобы прогнать собранный файл вне игры.
-- Запуск: cat tools/smoke_stub.lua ouroboros_recon.lua tools/smoke_tail.lua > /tmp/smoke.lua && luau /tmp/smoke.lua
local function noop() end
local function stub_table(name)
    return setmetatable({}, { __index = function(_, key) return noop end,
                              __call = function() return nil end,
                              __tostring = function() return name end })
end

task = {
    wait = function() return 0 end,
    delay = function() end,
    spawn = function(fn) end,
    defer = function(fn) end,
}
local Signal = { Connect = function() return { Disconnect = noop } end,
                 Once = function() return { Disconnect = noop } end,
                 Wait = function() end }
local Instance_mt = {}
Instance = {
    new = function(class) return setmetatable({ ClassName = class, Name = class }, Instance_mt) end,
}
function typeof(v)
    local t = type(v)
    if t == "table" then
        if getmetatable(v) == Instance_mt then return "Instance" end
        return "table"
    end
    return t
end
function cloneref(v) return v end
function fireproximityprompt() end
function setclipboard() end
function toclipboard() end
getgenv = function() return _G end

Enum = setmetatable({}, { __index = function(_, k) return stub_table(k) end })
Vector3 = { new = function(x, y, z) return { X = x or 0, Y = y or 0, Z = z or 0 } end, zero = { X = 0, Y = 0, Z = 0 } }
Vector2 = Vector3
CFrame = { new = function() return {} end }
Color3 = { new = function() return { ToHex = function() return "ffffff" end } end,
           fromHex = function() return {} end, fromRGB = function() return {} end }
UDim2 = { fromOffset = function() return {} end, new = function() return {} end }
TweenInfo = { new = function() return {} end }
Ray = { new = function() return {} end }
Random = { new = function() return { NextNumber = function() return 0 end } end }
DateTime = { now = function() return { UnixTimestamp = 0 } end }

local services = {}
local function make_service(name)
    local service = {
        Name = name,
        GetDescendants = function() return {} end,
        GetChildren = function() return {} end,
        FindFirstChild = function() return nil end,
        FindFirstChildOfClass = function() return nil end,
        FindFirstChildWhichIsA = function() return nil end,
        WaitForChild = function() return nil end,
        IsA = function() return false end,
        GetAttribute = function() return nil end,
        GetPropertyChangedSignal = function() return Signal end,
        ChildAdded = Signal, DescendantAdded = Signal, Heartbeat = Signal, Stepped = Signal,
    }
    return service          -- неизвестные поля = nil, как у настоящих объектов
end
game = {
    GetService = function(_, name) services[name] = services[name] or make_service(name); return services[name] end,
    PlaceId = 136406881576517,
    Players = stub_table("Players"),
}
workspace = make_service("Workspace")
script = make_service("Script")
services.Players = { LocalPlayer = make_service("LocalPlayer") }
services.HttpService = make_service("HttpService")
HttpGet = function() return "" end

-- Цепной заглушечный объект для библиотеки UI: любой метод возвращает такой же stub
local function chain(name)
    local obj = {}
    return setmetatable(obj, {
        __index = function(t, key)
            local child = chain(name .. "." .. tostring(key))
            rawset(t, key, child)
            return child
        end,
        __call = function() return chain(name .. "()") end,
        __tostring = function() return name end,
    })
end
LIBRARY_STUB = chain("Library")

function warn(...) print("[warn]", ...) end
