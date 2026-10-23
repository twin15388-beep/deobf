-- Offline mock test of the RECOVERED WeAreDevs/WAD output, never its protected input.
-- No network, no executor file APIs, no real WindUI, no Roblox services: every
-- service is a stub and the script's endless loops are cut by a step budget.
-- Lua 5.1: lua5.1 tests/test_yba_revenge_hub.lua 'dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua'
local path = assert(arg[1], "pass the recovered Lua file")
local published = assert(io.open(path, "r")):read("*a")
-- Only the recovered body counts: our own header may name TeleportService.
local body = published:match("%]%]%s*(.+)$") or published

local checks = 0
local function check(condition, message)
    checks = checks + 1
    assert(condition, message)
end

-- ---------------------------------------------------------------- mock world
local events = {}
local function record(kind, value)
    events[#events + 1] = {kind, value}
end
local function count(kind)
    local n = 0
    for _, event in ipairs(events) do
        if event[1] == kind then n = n + 1 end
    end
    return n
end
local function countValue(kind, value)
    local n = 0
    for _, event in ipairs(events) do
        if event[1] == kind and event[2] == value then n = n + 1 end
    end
    return n
end
local function last(kind)
    for i = #events, 1, -1 do
        if events[i][1] == kind then return events[i][2] end
    end
end

local STEPS = 5000
local budget = STEPS
local function refill() budget = STEPS end
local function step()
    budget = budget - 1
    if budget <= 0 then error("loop budget exhausted", 3) end
    return 0.05
end

local vectorMeta = {}
local function vector(x, y, z)
    return setmetatable({X = x or 0, Y = y or 0, Z = z or 0}, vectorMeta)
end
local function vectorLerp(self, other, alpha)
    return vector(self.X + (other.X - self.X) * alpha,
                  self.Y + (other.Y - self.Y) * alpha,
                  self.Z + (other.Z - self.Z) * alpha)
end
vectorMeta.__index = function(self, key)
    if key == "Magnitude" then
        return math.sqrt(self.X ^ 2 + self.Y ^ 2 + self.Z ^ 2)
    end
    if key == "Lerp" then
        return function(_, other, alpha) return vectorLerp(self, other, alpha) end
    end
end
vectorMeta.__add = function(a, b) return vector(a.X + b.X, a.Y + b.Y, a.Z + b.Z) end
vectorMeta.__sub = function(a, b) return vector(a.X - b.X, a.Y - b.Y, a.Z - b.Z) end
vectorMeta.__eq = function(a, b) return a.X == b.X and a.Y == b.Y and a.Z == b.Z end
vectorMeta.__tostring = function(self)
    return string.format("%.3f, %.3f, %.3f", self.X, self.Y, self.Z)
end

local cframeMeta = {}
local function cframe(position, look)
    return setmetatable({Position = position or vector(0, 0, 0),
                         LookVector = look or vector(0, 0, -1)}, cframeMeta)
end

-- Instances keep their children in sync when .Parent is assigned, and Position
-- is derived from CFrame the way a real BasePart behaves.
local instanceMeta = {}
local parents = setmetatable({}, {__mode = "k"})
local function isInstance(value)
    return type(value) == "table" and getmetatable(value) == instanceMeta
end
instanceMeta.__index = function(self, key)
    if key == "Parent" then return parents[self] end
    if key == "Position" then
        local frame = rawget(self, "CFrame")
        if frame then return frame.Position end
    end
    if key == "ChildAdded" or key == "ChildRemoved" then
        local signal = {handlers = {}}
        function signal:Connect(handler)
            self.handlers[#self.handlers + 1] = handler
            record("connected", key)
            return {Disconnect = function() record("disconnected", key) end}
        end
        rawset(self, key, signal)
        return signal
    end
    for _, child in ipairs(rawget(self, "children") or {}) do
        if child.Name == key then return child end
    end
end
instanceMeta.__newindex = function(self, key, value)
    if key == "Parent" then
        local previous = parents[self]
        parents[self] = value
        for _, holder in ipairs(previous and {previous, value} or {value}) do
            if isInstance(holder) then
                local children = rawget(holder, "children") or {}
                for index, child in ipairs(children) do
                    if child == self then
                        table.remove(children, index)
                        break
                    end
                end
                rawset(holder, "children", children)
            end
        end
        if isInstance(value) then
            local children = rawget(value, "children") or {}
            children[#children + 1] = self
            rawset(value, "children", children)
        end
        return
    end
    rawset(self, key, value)
end

local function node(values)
    values = values or {}
    if not rawget(values, "children") then values.children = {} end
    local initialParent = rawget(values, "Parent")
    rawset(values, "Parent", nil)
    function values:FindFirstChild(name)
        if rawget(self, name) ~= nil then return rawget(self, name) end
        for _, child in ipairs(rawget(self, "children")) do
            if child.Name == name then return child end
        end
        return nil
    end
    function values:WaitForChild(name)
        local found = self:FindFirstChild(name)
        if not found then error("WaitForChild timed out: " .. tostring(name), 2) end
        return found
    end
    function values:GetChildren() return rawget(self, "children") end
    function values:GetDescendants()
        local out = {}
        for _, child in ipairs(rawget(self, "children")) do
            out[#out + 1] = child
            for _, deep in ipairs(child:GetDescendants()) do out[#out + 1] = deep end
        end
        return out
    end
    function values:GetFullName() return self.Name end
    function values:IsA(class) return self.ClassName == class end
    function values:Destroy()
        record("destroyed", self.Name)
        self.Parent = nil
    end
    local instance = setmetatable(values, instanceMeta)
    if initialParent then instance.Parent = initialParent end
    return instance
end

local function part(name, position)
    return node({Name = name, ClassName = "BasePart", CFrame = cframe(position)})
end

-- ------------------------------------------------------------------- fixtures
local SELLABLE = "Rokakaka"
local money = node({Name = "Money", ClassName = "IntValue", Value = 50000})
local rootPart = part("HumanoidRootPart", vector(0, 0, 0))
local humanoid = node({Name = "Humanoid", ClassName = "Humanoid", Health = 100})
local sellRemote = node({Name = "RemoteEvent", ClassName = "RemoteEvent"})
function sellRemote:FireServer(...)
    local args = {...}
    record(args[1] == "PurchaseShopItem" and "purchase" or "sell", args)
end
local backpack = node({Name = "Backpack", ClassName = "Backpack"})
local character = node({Name = "volmaks", ClassName = "Model",
                        HumanoidRootPart = rootPart, Humanoid = humanoid,
                        RemoteEvent = sellRemote})
character.children = {rootPart, humanoid, sellRemote}
function humanoid:EquipTool(tool)
    record("equip", tool.Name)
    tool.Parent = character
end
local localPlayer = node({Name = "volmaks", ClassName = "Player", Character = character,
                          Backpack = backpack,
                          PlayerStats = node({Name = "PlayerStats", Money = money,
                              Stand = node({Name = "Stand", Value = "The World"}),
                              Race = node({Name = "Race", Value = "Vampire"})})})
localPlayer.CharacterAdded = {Connect = function() record("connected", "CharacterAdded") end,
                              Wait = function() return character end}
-- The farm validates its target with `instance.Parent`, so the character needs one.
character.Parent = localPlayer

local function fastTravelEntry(name, position)
    return node({Name = name, ClassName = "Folder",
                 TeleportTo = node({Name = "TeleportTo",
                     Value = node({Name = "Value", Position = position})})})
end
local merchantKeep = vector(11.5, -6.25, 88.25)
local ascendedDio = vector(8490.5439453125, -469.50018310547, 8151.3793945312)
local fastTravel = node({Name = "FastTravel", ClassName = "Folder", children = {
    fastTravelEntry("Merchant's Keep", merchantKeep),
    fastTravelEntry("Parking Lot", vector(1, 1, 1)),
    fastTravelEntry("Prison Bridge", vector(2, 2, 2)),
    fastTravelEntry("Train Station", vector(3, 3, 3)),
    fastTravelEntry("Via Toledo", vector(4, 4, 4)),
    fastTravelEntry("Via dell'Oceano", vector(5, 5, 5)),
}})

-- Item_Spawns/Items with one sellable item and one junk item.
local function makeItem(name)
    local item = part(name, vector(6, 0, 0))
    local prompt = node({Name = "Pickup", ClassName = "ProximityPrompt", Enabled = true,
                         MaxActivationDistance = 8, Parent = item})
    item.children = {prompt}
    return item
end
local items = node({Name = "Items", ClassName = "Folder",
                    children = {makeItem(SELLABLE), makeItem("Plain Rock")}})
for _, spawned in ipairs(items.children) do rawset(spawned, "Parent", items) end
local itemSpawns = node({Name = "Item_Spawns", ClassName = "Folder", children = {items}})

local camera = node({Name = "Camera", ClassName = "Camera", CameraType = "Custom",
                     CFrame = cframe(vector(0, 10, 0))})

local function otherPlayer(name, position)
    local otherRoot = part("HumanoidRootPart", position)
    local head = part("Head", position)
    local model = node({Name = name, ClassName = "Model", HumanoidRootPart = otherRoot,
                        children = {otherRoot, head}})
    local player = node({Name = name, ClassName = "Player", Character = model,
                         PlayerStats = node({Name = "PlayerStats",
                             Stand = node({Name = "Stand", Value = "Star Platinum"}),
                             Race = node({Name = "Race", Value = "Human"})})})
    return player, model, otherRoot, head
end
local dioPlayer, dioModel, dioRoot, dioHead = otherPlayer("DioFan", vector(50, 0, 50))
local jotaroPlayer, jotaroModel, jotaroRoot, jotaroHead = otherPlayer("Jotaro", vector(80, 0, 80))
local living = node({Name = "Living", ClassName = "Folder", children = {dioModel, jotaroModel}})

local workspace = node({Name = "Workspace", ClassName = "Workspace",
                        CurrentCamera = camera, Living = living,
                        children = {fastTravel, itemSpawns, living}})
function workspace:FindFirstChild(name)
    for _, child in ipairs(rawget(self, "children")) do
        if child.Name == name then return child end
    end
    return nil
end

local players = node({Name = "Players", ClassName = "Players", LocalPlayer = localPlayer})
rawset(players, localPlayer.Name, localPlayer)
rawset(players, dioPlayer.Name, dioPlayer)
rawset(players, jotaroPlayer.Name, jotaroPlayer)
function players:GetPlayers() return {localPlayer, dioPlayer, jotaroPlayer} end
function players:FindFirstChild(name)
    for _, player in ipairs(self:GetPlayers()) do
        if player.Name == name then return player end
    end
    return nil
end

-- ------------------------------------------------------------------- services
local heartbeatHandlers, renderHandlers = {}, {}
local function makeSignal(kind)
    return {
        Connect = function(_, handler)
            local list = kind == "Heartbeat" and heartbeatHandlers or renderHandlers
            list[#list + 1] = handler
            record("connected", kind)
            return {Disconnect = function() record("disconnected", kind) end}
        end,
        Wait = function() return step() end,
    }
end
local runService = node({Name = "RunService", Heartbeat = makeSignal("Heartbeat"),
                         RenderStepped = makeSignal("RenderStepped")})
local virtualInputManager = node({Name = "VirtualInputManager"})
function virtualInputManager:SendKeyEvent(pressed, keyCode)
    if not pressed then return end
    record("key", keyCode)
    -- Emulate the game: pressing E on a spawn hands the item to the player.
    for index, item in ipairs(items.children) do
        if item.Parent ~= nil then
            item.Parent = nil
            local tool = node({Name = item.Name, ClassName = "Tool"})
            tool.Parent = backpack
            break
        end
    end
end
local httpService = node({Name = "HttpService"})
function httpService:JSONDecode(text)
    assert(type(text) == "string", "JSONDecode needs a string")
    return {}
end
function httpService:JSONEncode(value)
    assert(type(value) == "table", "JSONEncode needs a table")
    return "[1]"
end

local function makeWindow(log)
    local window = {}
    function window:Tab(config)
        log.tabs[config.Title] = true
        log.tabOrder[#log.tabOrder + 1] = config.Title
        local tab = {}
        function tab:Toggle(config2) log.controls[config2.Title] = config2; return config2 end
        function tab:Button(config2) log.controls[config2.Title] = config2; return config2 end
        function tab:Input(config2) log.controls[config2.Title] = config2; return config2 end
        function tab:Section(config2) return config2 end
        function tab:Paragraph(config2) return config2 end
        function tab:Divider() return true end
        return tab
    end
    return window
end

local function newEnvironment(options)
    options = options or {}
    local log = {tabs = {}, tabOrder = {}, controls = {}, notifies = {},
                 files = {}, urls = {}}
    local env = {}
    env._G = {}
    env.game = node({Name = "Game", PlaceId = 0, HttpService = httpService,
                     RunService = runService, Players = players,
                     VirtualInputManager = virtualInputManager})
    function env.game:GetService(name)
        local service = ({HttpService = httpService, RunService = runService,
                          Players = players, VirtualInputManager = virtualInputManager})[name]
        if not service then error("unexpected GetService " .. tostring(name)) end
        return service
    end
    function env.game:HttpGet(url)
        log.urls[#log.urls + 1] = url
        record("httpget", url)
        return "-- stubbed WindUI text, never executed"
    end
    env.workspace = workspace
    env.loadstring = function()
        record("loadstring", true)
        local windUI = {}
        function windUI:CreateWindow(config)
            log.window = config.Title
            local window = makeWindow(log)
            if options.globalWindow then
                -- Upstream WindUI only tracks its window internally, so the
                -- recovered script's global `Window` stays nil unless the host
                -- defines it. Phase B supplies it on purpose.
                env.Window = window
            end
            return window
        end
        function windUI:Notify(note) log.notifies[#log.notifies + 1] = note end
        return function() return windUI end
    end
    env.Instance = {new = function(class, parent)
        return node({Name = class, ClassName = class, Parent = parent})
    end}
    env.Vector3 = {new = vector}
    env.CFrame = {new = cframe}
    env.UDim2 = {new = function() return {} end}
    env.Color3 = {new = function() return {} end, fromRGB = function() return {} end}
    local function enumGroup()
        return setmetatable({}, {__index = function(self, key)
            rawset(self, key, tostring(key))
            return rawget(self, key)
        end})
    end
    env.Enum = setmetatable({}, {__index = function(self, key)
        local group = enumGroup()
        rawset(self, key, group)
        return group
    end})
    env.math = setmetatable({clamp = function(value, low, high)
        return math.max(low, math.min(high, value))
    end}, {__index = math})
    env.os = os
    env.task = {wait = function() return step() end, spawn = function(fn) fn() end}
    env.wait = function() return step() end
    env.tick = function() return 1000 end
    env.typeof = function(value)
        if isInstance(value) then return "Instance" end
        if type(value) == "table" and getmetatable(value) == vectorMeta then return "Vector3" end
        return type(value)
    end
    env.readfile = function(name)
        log.files[#log.files + 1] = "read:" .. name
        record("readfile", name)
        error("no such file", 2)
    end
    env.writefile = function(name)
        log.files[#log.files + 1] = "write:" .. name
        record("writefile", name)
    end
    env.delfile = function(name) record("delfile", name) end
    env.print = function() end
    env.warn = function() end
    for _, name in ipairs({"assert", "error", "pcall", "select", "tonumber", "tostring",
                           "string", "table", "ipairs", "pairs", "unpack", "setmetatable",
                           "getmetatable", "type", "rawget", "rawset", "next"}) do
        env[name] = _G[name]
    end
    return env, log
end

local chunk = assert(loadfile(path))

local function run(options)
    refill()
    events = {}
    local env, log = newEnvironment(options)
    setfenv(chunk, env)
    local ok, message = pcall(chunk)
    return {ok = ok, message = message, env = env, log = log}
end

local function heartbeatTimes(times)
    for _ = 1, times do
        for _, handler in ipairs(heartbeatHandlers) do handler() end
    end
end
local function renderTimes(times)
    for _ = 1, times do
        for _, handler in ipairs(renderHandlers) do handler() end
    end
end
local function bounded(fn)
    refill()
    local ok, message = pcall(fn)
    if not ok and not tostring(message):find("loop budget", 1, true) then
        error("unexpected failure: " .. tostring(message), 2)
    end
    return ok
end

-- ============================ phase A: no global `Window` (upstream WindUI) ====
heartbeatHandlers, renderHandlers = {}, {}
local a = run()
check(not a.ok, "loading without a global Window must fail as recovered")
check(tostring(a.message):find("Window", 1, true) ~= nil,
      "expected the failure to name the global Window: " .. tostring(a.message))
check(a.log.urls[1] == "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
      "WindUI must be requested from the mutable releases URL")
check(count("loadstring") == 1, "the fetched UI text is handed to loadstring")
check(a.log.files[1] == "read:NotSameServers.json", "server history is read first")
check(countValue("writefile", "NotSameServers.json") == 1, "a missing history file is recreated")
check(a.log.controls["Enable Money Farm"] ~= nil, "money farm toggle exists before the failure")
check(a.log.controls["Enable Auto buy Lucky Arrow"] ~= nil, "lucky arrow toggle exists")
check(a.log.controls["YBA god mode"] ~= nil, "god mode toggle exists")
check(a.log.tabs["Fast Travel"] == nil, "Fast Travel tab is never created in phase A")
check(a.log.tabs["Visual"] == nil, "Visual/ESP tab is never created in phase A")

-- ================= phase B: host supplies the global `Window` the code wants ==
heartbeatHandlers, renderHandlers = {}, {}
local b = run({globalWindow = true})
check(b.ok, "with a global Window the script finishes loading: " .. tostring(b.message))
check(#b.log.tabOrder == 7, "seven tabs are created, found " .. #b.log.tabOrder)
local controls, flags = b.log.controls, b.env._G

-- Fast travel reads the game's own FastTravel folders; bosses are hard-coded.
refill()
controls["Travel to Merchant"].Callback()
check(rootPart.CFrame.Position == merchantKeep, "Merchant button uses workspace.FastTravel")
refill()
controls["Travel to Ascended Dio"].Callback()
check(rootPart.CFrame.Position == ascendedDio, "Ascended Dio uses the hard-coded vector")

-- Money farm: enqueue, walk to the prompt, press E, then sell through dialogue.
bounded(function() controls["Enable Money Farm"].Callback(true) end)
check(countValue("connected", "ChildAdded") == 1, "the farm watches Items.ChildAdded")
check(countValue("connected", "ChildRemoved") == 1, "the farm watches Items.ChildRemoved")
check(count("key") >= 2, "collecting presses E through VirtualInputManager")
check(camera.CameraType == "Custom", "the camera is restored after collecting")
check(count("equip") >= 1 and last("equip") == SELLABLE, "sellable tools are equipped to sell")
check(countValue("equip", "Plain Rock") == 0, "junk items are collected but never equipped")
local sold = last("sell")
check(sold and sold[1] == "EndDialogue"
      and sold[2].Option == "Option2" and sold[2].Dialogue == "Dialogue5"
      and sold[2].NPC == "Merchant", "selling uses the Merchant dialogue remote")

-- ESP toggles attach billboards that read PlayerStats.
controls["Esp players"].Callback(true)
renderTimes(1)
check(dioHead:FindFirstChild("playerEsp") ~= nil, "player ESP creates a billboard on other heads")
check(dioHead:FindFirstChild("playerEsp").TextLabel.Text == "DioFan", "player ESP shows the name")
controls["Esp Stand"].Callback(true)
renderTimes(1)
check(jotaroHead:FindFirstChild("standEsp").TextLabel.Text == "Star Platinum",
      "stand ESP reads PlayerStats.Stand.Value")
controls["Esp Race"].Callback(true)
renderTimes(1)
check(jotaroHead:FindFirstChild("raceEsp").TextLabel.Text == "Human",
      "race ESP reads PlayerStats.Race.Value")
controls["Esp players"].Callback(false)
check(dioHead:FindFirstChild("playerEsp") == nil, "turning ESP off destroys the billboards")

-- God mode pulls every other character to the local one, except the ignore list.
controls["Add people to the ignore list"].Callback("Jotaro")
controls["YBA god mode"].Callback(true)
check(flags.YbaGodMode_Enabled == true, "god mode flag is set")
heartbeatTimes(1)
check(dioRoot.CFrame.Position == rootPart.CFrame.Position, "unlisted players are pulled in")
check(jotaroRoot.CFrame.Position ~= rootPart.CFrame.Position, "ignored players are left alone")

-- Lucky arrow spends real in-game money only at the 50000 threshold.
money.Value = 49999
bounded(function() controls["Enable Auto buy Lucky Arrow"].Callback(true) end)
check(count("purchase") == 0, "no arrow is bought below 50000 money")
controls["Enable Auto buy Lucky Arrow"].Callback(false)
money.Value = 50000
bounded(function() controls["Enable Auto buy Lucky Arrow"].Callback(true) end)
local purchase = last("purchase")
check(purchase and purchase[1] == "PurchaseShopItem"
      and purchase[2].ItemName == "1x Lucky Arrow", "the arrow purchase remote and payload")
controls["Enable Auto buy Lucky Arrow"].Callback(false)
check(flags.AutoBuyLuckyArrow == false, "the arrow loop can be switched off")

-- Server Hop only lists servers forever; the script never teleports.
check(bounded(function() controls["Server Hop"].Callback() end) == false,
      "Server Hop is an endless loop")
check(count("httpget") > 1, "Server Hop keeps requesting the games.roblox.com server list")
check(not body:find("TeleportService", 1, true), "no TeleportService call exists in the script")

print(string.format("OK Your Bizarre Adventure: %d offline mock assertions; "
    .. "network/files/WindUI stubbed, loops bounded, no Roblox", checks))
