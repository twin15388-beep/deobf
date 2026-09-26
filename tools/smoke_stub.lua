-- Заглушки Roblox/executor, чтобы прогнать собранный файл вне игры.
-- Запуск: cat tools/smoke_stub.lua ouroboros_recon.lua tools/smoke_tail.lua > /tmp/smoke.lua && luau /tmp/smoke.lua
local function noop() end
local function stub_table(name)
    return setmetatable({}, { __index = function(_, key) return noop end,
                              __call = function() return nil end,
                              __tostring = function() return name end })
end

STUB_DELAYED = {}
STUB_ON_WAIT = nil

task = {
    wait = function(...)
        local hook = STUB_ON_WAIT
        if hook then STUB_ON_WAIT = nil hook() end
        return 0
    end,
    delay = function(_, fn)                     -- отложенные задачи складываем
        STUB_DELAYED[#STUB_DELAYED + 1] = fn
        return #STUB_DELAYED
    end,
    spawn = function(fn) STUB_DELAYED[#STUB_DELAYED + 1] = fn end,
    defer = function(fn) end,
}
local Signal = { Connect = function() return { Disconnect = noop } end,
                 Once = function() return { Disconnect = noop } end,
                 Wait = function() end }
local Instance_mt = {}
Instance = {
    new = function(class) return setmetatable({ ClassName = class, Name = class }, Instance_mt) end,
}
-- Роблоксовые типы: typeof() должен узнавать их (иначе Bounds/Health не срабатывают)
local ROBLOX_TYPES = setmetatable({}, { __mode = "k" })
function typeof(v)
    local t = type(v)
    if t == "table" then
        if getmetatable(v) == Instance_mt then return "Instance" end
        return ROBLOX_TYPES[v] or "table"
    end
    return t
end
function cloneref(v) return v end
function fireproximityprompt() end
function setclipboard() end
function toclipboard() end
getgenv = function() return _G end
gethui = function() return nil end

Enum = setmetatable({}, { __index = function(_, k) return stub_table(k) end })
-- Мини-Vector3: нужны вычитание, Magnitude, Unit, Dot (InReach и др.)
local V3
local V3MT = {
    __index = {
        Dot = function(a, b) return a.X * b.X + a.Y * b.Y + a.Z * b.Z end,
    },
    __sub = function(a, b) return V3(a.X - b.X, a.Y - b.Y, a.Z - b.Z) end,
    __add = function(a, b) return V3(a.X + b.X, a.Y + b.Y, a.Z + b.Z) end,
    __mul = function(a, b)                  -- Vector3 * число / число * Vector3
        if type(b) == "number" then return V3(a.X * b, a.Y * b, a.Z * b) end
        return V3(a.X * b.X, a.Y * b.Y, a.Z * b.Z)
    end,
    __div = function(a, b) return V3(a.X / b, a.Y / b, a.Z / b) end,
}
-- Magnitude/Unit считаются сразу: в Roblox это свойства, а не методы
local function magnitude(x, y, z) return math.sqrt(x * x + y * y + z * z) end
local function build(x, y, z, m)
    local v = setmetatable({ X = x, Y = y, Z = z, Magnitude = m }, V3MT)
    ROBLOX_TYPES[v] = "Vector3"
    if m and m > 0 then
        v.Unit = setmetatable({ X = x / m, Y = y / m, Z = z / m, Magnitude = 1 }, V3MT)
        ROBLOX_TYPES[v.Unit] = "Vector3"
    end
    return v
end
V3 = function(x, y, z)
    x, y, z = x or 0, y or 0, z or 0
    return build(x, y, z, magnitude(x, y, z))
end
Vector3 = { new = V3, zero = V3(0, 0, 0) }
ROBLOX_TYPES[Vector3.zero] = "Vector3"
local V2                                     -- объявим заранее: метатаблица на него ссылается
local V2MT = {
    __index = { Dot = function(a, b) return a.X * b.X + a.Y * b.Y end },
    __sub = function(a, b) return V2(a.X - b.X, a.Y - b.Y) end,
    __add = function(a, b) return V2(a.X + b.X, a.Y + b.Y) end,
    __mul = function(a, b)
        if type(b) == "number" then return V2(a.X * b, a.Y * b) end
        return V2(a.X * b.X, a.Y * b.Y)
    end,
}
local C3                                     -- так же: Color3 нужен внутри своей метатаблицы
local CFMT = {
    __mul = function(a, b)          -- CFrame * Vector3 → сдвиг (как в игре)
        if typeof(b) == "Vector3" then return V3(a.Position.X + b.X, a.Position.Y + b.Y, a.Position.Z + b.Z) end
        return a
    end,
    __index = {
        PointToWorldSpace = function(_, vector) return vector end,   -- без поворотов: локальные оси = мировые
        ToWorldSpace = function(_, other) return other end,
        LookVector = V3(0, 0, -1),
    },
}
local C3MT = { __index = { Lerp = function(a, _, alpha)    -- Color3:Lerp → переход к другому цвету
        return C3(a.R + ((255 - a.R) * (alpha or 1)), a.G + ((255 - a.G) * (alpha or 1)),
                  a.B + ((255 - a.B) * (alpha or 1)))
    end } }
V2 = function(x, y)
    local v = setmetatable({ X = x or 0, Y = y or 0 }, V2MT)
    v.Magnitude = magnitude(x or 0, y or 0, 0)
    ROBLOX_TYPES[v] = "Vector2"
    return v
end
Vector2 = { new = V2 }
-- CFrame: минимально нужны Position и PointToWorldSpace (проекция углов ESP)
local CF = function(...)
    local args = table.pack(...)
    local position = V3(args[1], args[2], args[3])
    if typeof(args[1]) == "Vector3" then position = args[1] end
    local cf = setmetatable({ Position = position, X = position.X, Y = position.Y, Z = position.Z }, CFMT)
    ROBLOX_TYPES[cf] = "CFrame"
    return cf
end
CFrame = { new = CF, fromEulerAnglesXYZ = function() return CF() end }
C3 = function(r, g, b)
    local colour = setmetatable({ R = r or 0, G = g or 0, B = b or 0 }, C3MT)
    ROBLOX_TYPES[colour] = "Color3"
    return colour
end
Color3 = { new = C3, fromRGB = function(r, g, b) return C3(r, g, b) end, fromHex = function() return C3() end }
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
services.Players = { LocalPlayer = { Character = nil, Name = "stub" } }
services.Workspace = services.Workspace or make_service("Workspace")
services.Workspace.Position = Vector3.new(0, 0, 0)
services.Workspace.CFrame = { LookVector = Vector3.new(0, 0, -1) }
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

-- Stats.Network.ServerStatsItem.Data Ping:GetValue() и Utility.Tick() для парирования
local statsService = {
    Network = { ServerStatsItem = { ["Data Ping"] = { GetValue = function() return 42 end } } },
}
services.Stats = statsService
bno_extra = { Utility = { Tick = function() return os.clock() end } }
