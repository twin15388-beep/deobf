--[[
WaveHub / Anime War RNG: DEOBFUSCATED (static recovery), NOT an open src mirror.
Source: https://github.com/wavechayakon/WaveHub/blob/198b5d26877c44b0533b6c3f1826a87515d59faf/games/anime-war-rng.lua
Input SHA-256: 7377afb9d1b8cc7d6390b504080a4f8cddb5f04bb2373c7179dbca4397f4f643
Method: replace the 607 decoded strings at 1,070 literal call sites. No gameplay was executed.
Scope: the game module is present, but external WindUI code is not included.

MIT LICENSE BEGIN
MIT License

Copyright (c) 2026 WaveHub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
MIT LICENSE END
]]

pcall(function()
    local old = getgenv().WaveHubBase
    if old and type(old.Destroy) == "function" then
        old:Destroy()
    end
end)

local BASE_VERSION = "1.1.2"
local WINDUI_VERSION = "1.6.66"

local Brand = {
    Name = "WaveHub",
    Tagline = "Connect \226\128\162 Create \226\128\162 Go Further",
    Accent = Color3.fromHex("#1464FF"),
    Cyan = Color3.fromHex("#00D1FF"),
    Background = Color3.fromHex("#07111F"),
    Surface = Color3.fromHex("#0D1B2E"),
    Outline = Color3.fromHex("#183B5A"),
    Text = Color3.fromHex("#F5F8FF"),
    Placeholder = Color3.fromHex("#8294AA"),
    Icon = Color3.fromHex("#B9D6F2"),
}

local ScriptInfo = {
    Title = "WaveHub",
    Game = "Universal",
    Version = "1.1.2",
    Status = "Ready",
    Channel = "Stable",
    Updated = "2026-09-08",
}

local function loadWindUI()
    local urls = {
        "https://github.com/Footagesus/WindUI/releases/download/" .. WINDUI_VERSION .. "/main.lua",
        "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
    }

    local lastError
    for _, url in ipairs(urls) do
        local okFetch, source = pcall(game.HttpGet, game, url)
        if okFetch and type(source) == "string" and #source > 100 then
            local chunk, compileError = loadstring(source)
            if chunk then
                local okRun, library = pcall(chunk)
                if okRun and library then
                    return library
                end
                lastError = library
            else
                lastError = compileError
            end
        else
            lastError = source
        end
    end

    error("WindUI failed to load: " .. tostring(lastError))
end

local WindUI = loadWindUI()

pcall(function()
    WindUI:SetNotificationLower(true)
end)

pcall(function()
    WindUI:AddTheme({
        Name = "WaveHub",
        Accent = Brand.Accent,
        Background = Brand.Background,
        Outline = Brand.Outline,
        Text = Brand.Text,
        Placeholder = Brand.Placeholder,
        Button = Brand.Surface,
        Icon = Brand.Icon,
    })
    WindUI:SetTheme("WaveHub")
end)

local Window = WindUI:CreateWindow({
    Title = Brand.Name,
    Author = ScriptInfo.Game .. " \226\128\162 " .. ScriptInfo.Channel,
    Folder = "WaveHub",
    Icon = "waves",
    NewElements = true,
    Size = UDim2.fromOffset(720, 520),
    MinSize = Vector2.new(570, 410),
    MaxSize = Vector2.new(960, 700),
    ToggleKey = Enum.KeyCode.RightShift,
    Transparent = false,
    Theme = "WaveHub",
    Resizable = true,
    SideBarWidth = 190,
    HideSearchBar = false,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() end,
    },
    OpenButton = {
        Title = "WaveHub",
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 0.52,
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 1,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Brand.Accent),
            ColorSequenceKeypoint.new(1, Brand.Cyan),
        }),
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
})

assert(Window, "WaveHub window could not be created")

pcall(function()
    WindUI:ToggleAcrylic(false)
end)

pcall(function()
    Window:Tag({
        Title = "BASE " .. BASE_VERSION,
        Icon = "layers-3",
        Color = Brand.Accent,
        Border = true,
    })
end)

local WaveHub = {
    BaseVersion = BASE_VERSION,
    WindUIVersion = WindUI.Version or WINDUI_VERSION,
    WindUI = WindUI,
    Window = Window,
    Brand = Brand,
    Script = ScriptInfo,
    Pages = {},
    SettingsElements = {},
    _cleanup = {},
}

function WaveHub:Notify(title, content, icon, duration)
    return WindUI:Notify({
        Title = title or Brand.Name,
        Content = content or "",
        Icon = icon or "waves",
        Duration = duration or 3,
    })
end

function WaveHub:AddTabSection(title)
    return Window:Section({Title = title or "MODULE"})
end

function WaveHub:AddTab(options)
    options = options or {}
    return Window:Tab({
        Title = options.Title or "Module",
        Icon = options.Icon or "box",
        Locked = options.Locked == true,
    })
end

function WaveHub:CreateConfig(name, autoload)
    if not Window.ConfigManager then
        return nil
    end
    return Window.ConfigManager:CreateConfig(name or "default", autoload == true)
end

function WaveHub:AddCleanup(callback)
    if type(callback) == "function" then
        table.insert(self._cleanup, callback)
    end
end

function WaveHub:SetScriptInfo(info)
    info = info or {}
    for key, value in pairs(info) do
        if ScriptInfo[key] ~= nil and value ~= nil then
            ScriptInfo[key] = value
        end
    end

    if self._scriptInfoParagraph then
        pcall(function()
            self._scriptInfoParagraph:SetTitle(ScriptInfo.Game .. "  \226\128\162  " .. ScriptInfo.Status)
            self._scriptInfoParagraph:SetDesc(
                "Script v" .. ScriptInfo.Version
                .. "\nChannel: " .. ScriptInfo.Channel
                .. "\nUpdated: " .. ScriptInfo.Updated
            )
        end)
    end
end

function WaveHub:Destroy()
    for i = #self._cleanup, 1, -1 do
        pcall(self._cleanup[i])
    end
    table.clear(self._cleanup)

    pcall(function()
        Window:Destroy()
    end)

    if getgenv().WaveHubBase == self then
        getgenv().WaveHubBase = nil
    end
end

local Core = Window:Section({Title = "WAVEHUB"})

local Home = Core:Tab({Title = "Home", Icon = "house"})
WaveHub.Pages.Home = Home

Home:Section({
    Title = "WaveHub",
    TextSize = 22,
    TextTransparency = 0,
})

Home:Paragraph({
    Title = "Welcome back.",
    Desc = Brand.Tagline,
})

local CurrentScript = Home:Section({Title = "Current Script", Box = true, Opened = true})
WaveHub._scriptInfoParagraph = CurrentScript:Paragraph({
    Title = ScriptInfo.Game .. "  \226\128\162  " .. ScriptInfo.Status,
    Desc = "Script v" .. ScriptInfo.Version
        .. "\nChannel: " .. ScriptInfo.Channel
        .. "\nUpdated: " .. ScriptInfo.Updated,
    Color = "Blue",
})

local CoreInfo = Home:Section({Title = "Core", Box = true, Opened = false})
CoreInfo:Paragraph({
    Title = "Base " .. BASE_VERSION,
    Desc = "WindUI " .. tostring(WaveHub.WindUIVersion)
        .. "\nPlaceId: " .. tostring(game.PlaceId),
})

local Settings = Core:Tab({Title = "Settings", Icon = "settings"})
WaveHub.Pages.Settings = Settings

local Appearance = Settings:Section({Title = "Appearance", Box = true, Opened = true})

WaveHub.SettingsElements.Theme = Appearance:Dropdown({
    Title = "Theme",
    Values = {"WaveHub", "Dark"},
    Value = "WaveHub",
    Multi = false,
    AllowNone = false,
    Flag = "WH_Base_Theme",
    Callback = function(value)
        pcall(function()
            WindUI:SetTheme(value)
        end)
    end,
})

WaveHub.SettingsElements.Acrylic = Appearance:Toggle({
    Title = "Acrylic / Transparency",
    Icon = "blend",
    Value = false,
    Flag = "WH_Base_AcrylicFX",
    Callback = function(value)
        pcall(function()
            WindUI:ToggleAcrylic(value)
        end)
    end,
})

WaveHub.SettingsElements.UIScale = Appearance:Slider({
    Title = "Interface Scale",
    Step = 5,
    Value = {Min = 75, Max = 125, Default = 100},
    Flag = "WH_Base_UIScale",
    Callback = function(value)
        pcall(function()
            Window:SetUIScale(value / 100)
        end)
    end,
})

local Behavior = Settings:Section({Title = "Behavior", Box = true, Opened = true})

WaveHub.SettingsElements.NotificationLower = Behavior:Toggle({
    Title = "Mobile-safe Notifications",
    Icon = "bell",
    Value = true,
    Flag = "WH_Base_NotificationLower",
    Callback = function(value)
        pcall(function()
            WindUI:SetNotificationLower(value)
        end)
    end,
})

WaveHub.SettingsElements.ToggleKey = Behavior:Keybind({
    Title = "Toggle UI",
    Value = "RightShift",
    Flag = "WH_Base_ToggleKey",
    Callback = function(value)
        pcall(function()
            local key = Enum.KeyCode[value]
            if key then
                Window:SetToggleKey(key)
            end
        end)
    end,
})

local BaseConfig
pcall(function()
    if Window.ConfigManager then
        BaseConfig = Window.ConfigManager:CreateConfig("WaveHubBase", true)
        BaseConfig:SetAutoLoad(true)
    end
end)
WaveHub.BaseConfig = BaseConfig

local Config = Settings:Section({Title = "Base Settings", Box = true, Opened = false})

Config:Button({
    Title = "Save Settings",
    Icon = "save",
    Callback = function()
        if not BaseConfig then
            WaveHub:Notify("Settings", "Config storage is unavailable.", "triangle-alert")
            return
        end
        local ok, err = pcall(function()
            BaseConfig:SetAutoLoad(true)
            BaseConfig:Save()
        end)
        WaveHub:Notify(ok and "Settings saved" or "Save failed", ok and "WaveHub preferences saved." or tostring(err), ok and "circle-check" or "triangle-alert")
    end,
})

Config:Button({
    Title = "Load Settings",
    Icon = "folder-open",
    Callback = function()
        if not BaseConfig then
            WaveHub:Notify("Settings", "Config storage is unavailable.", "triangle-alert")
            return
        end
        local ok, err = pcall(function()
            BaseConfig:Load()
        end)
        WaveHub:Notify(ok and "Settings loaded" or "Load failed", ok and "WaveHub preferences loaded." or tostring(err), ok and "circle-check" or "triangle-alert")
    end,
})

local About = Settings:Section({Title = "About", Box = true, Opened = false})
About:Paragraph({
    Title = Brand.Name,
    Desc = Brand.Tagline .. "\nBase " .. BASE_VERSION .. "\nWindUI " .. tostring(WaveHub.WindUIVersion),
})
About:Button({
    Title = "Test Notification",
    Icon = "bell",
    Callback = function()
        WaveHub:Notify("WaveHub", "UI is running.", "sparkles")
    end,
})
About:Button({
    Title = "Unload WaveHub",
    Icon = "power",
    Color = Color3.fromHex("#B83A4B"),
    Callback = function()
        WaveHub:Destroy()
    end,
})

task.defer(function()
    task.wait(0.5)
    if BaseConfig and isfile and BaseConfig.Path then
        local ok, exists = pcall(isfile, BaseConfig.Path)
        if ok and exists then
            pcall(function()
                BaseConfig:Load()
            end)
        end
    end
end)

pcall(function()
    Home:Select()
end)

getgenv().WaveHubBase = WaveHub
WaveHub:Notify("WaveHub", "Base " .. BASE_VERSION .. " loaded.", "waves", 2.5)

local function BuildAnimeWarRNG(WaveHub)
    assert(WaveHub and WaveHub.Window, "WaveHub base is unavailable")

    local PLACE_ID = 79908803570376
    local VERSION = "0.3.2"

    WaveHub:SetScriptInfo({
        Title = "WaveHub \226\128\162 Anime War RNG",
        Game = "[FATE] Anime War RNG",
        Version = VERSION,
        Status = "Beta",
        Channel = "Beta",
        Updated = "2026-09-08",
    })

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VirtualUser = game:GetService("VirtualUser")
    local LocalPlayer = Players.LocalPlayer

    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 15)
    local Modules = ReplicatedStorage:FindFirstChild("Modules")
    local Shared = Modules and Modules:FindFirstChild("Shared")
    local Client = Modules and Modules:FindFirstChild("Client")

    local function tryRequire(name)
        if not Shared then
            return nil
        end
        local module = Shared:FindFirstChild(name)
        if not module or not module:IsA("ModuleScript") then
            return nil
        end
        local ok, result = pcall(require, module)
        return ok and result or nil
    end

    local function tryRequireClient(name)
        if not Client then
            return nil
        end
        local module = Client:FindFirstChild(name)
        if not module or not module:IsA("ModuleScript") then
            return nil
        end
        local ok, result = pcall(require, module)
        return ok and result or nil
    end

    local Network = tryRequire("Network")
    local UnitDefs = tryRequire("UnitDefs")
    local ItemDefs = tryRequire("ItemDefs")
    local TraitDefs = tryRequire("TraitDefs")
    local StatTierDefs = tryRequire("StatTierDefs")
    local StatRerollDefs = tryRequire("StatRerollDefs")
    local UpgradeTreeDefs = tryRequire("UpgradeTreeDefs")
    local MapDefs = tryRequire("MapDefs")
    local RewardDefs = tryRequire("RewardDefs")
    local BoostDefs = tryRequire("BoostDefs")
    local PanelRegistry = tryRequireClient("PanelRegistry")
    local TraitRerollController = tryRequireClient("TraitRerollController")
    local StatRerollController = tryRequireClient("StatRerollController")

    local Runtime = {
        Alive = true,
        Connections = {},
        LastCall = {},
        Inventory = {},
        Entries = {},
        InventoryCap = 0,
        InventoryListStamp = {},
        InventoryListCount = 0,
        ItemListStamp = {},
        ItemListCount = 0,
        Team = {},
        TeamSet = {},
        Items = {},
        Settings = {},
        Rewards = nil,
        RewardsAt = 0,
        Stats = {},
        Tree = {Owned = {}, Gold = 0, Gems = 0, TotalRolls = 0},
        TreeAuto = {Pending = false, SpendGems = false, LastNode = nil, NextCheck = 0},
        Fuse = {Unlocked = false, ChanceBonus = 0, Insurance = false, Equipped = {}},
        Raid = nil,
        Trial = nil,
        Rebirth = nil,
        Worlds = nil,
        ServerLuck = nil,
        Boosts = {},
        ObbyCooldowns = {},
        Leaderboard = {},
        AutoPlay = nil,
        AutoPlayLocked = nil,
        GameSpeed = 1,
        SelectedGuid = nil,
        SelectedItem = nil,
        SelectedGear = nil,
        Auto = {
            Deploy = false,
            Claim = false,
            Trait = false,
            Stat = false,
            Tree = false,
            RaidStart = false,
            TrialStart = false,
        },
        Safety = {
            UnitSpending = false,
            RerollSpending = false,
            ProgressSpending = false,
            Destructive = false,
            Rebirth = false,
        },
        Suppress = {
            Settings = false,
            Auto = false,
        },
        JobToken = {
            Deploy = 0,
            Claim = 0,
        },
        TraitJob = {
            Guid = nil,
            Mode = "Selected Traits",
            Targets = {},
            MinTier = "Mythic",
            Count = 0,
            Max = 100,
            Delay = 0.22,
            Pending = false,
        },
        StatJob = {Guid = nil, Mode = "All", Stat = "Damage", Target = "S", Rule = "Selected Stat", Count = 0, Max = 100, Delay = 0.22, Pending = false},
    }

    local UI = {
        UnitDropdowns = {},
        UnitMultiDropdowns = {},
        ItemDropdowns = {},
        GearDropdowns = {},
        UnitLabelToGuid = {},
        GuidToUnitLabel = {},
        ItemLabelToId = {},
        GearLabelToId = {},
        UnitValues = {},
        UsableValues = {},
        GearValues = {},
    }

    local function notify(title, text, icon, duration)
        WaveHub:Notify(title, text, icon or "waves", duration or 3)
    end

    local PERF = {
        RemoteMinInterval = 0.065,
        UnitRefreshDebounce = 0.30,
        ItemRefreshDebounce = 0.35,
        CurrencyPaintInterval = 0.75,
    }

    local RemoteCache = {}
    local ParagraphCache = setmetatable({}, {__mode = "k"})
    local ToggleCache = setmetatable({}, {__mode = "k"})
    local DropdownCache = setmetatable({}, {__mode = "k"})

    local function remote(name, refresh)
        if not Remotes then
            return nil
        end
        if not refresh then
            local cached = RemoteCache[name]
            if cached ~= nil then
                return cached or nil
            end
        end
        local target = Remotes:FindFirstChild(name)
        RemoteCache[name] = target or false
        return target
    end

    local function hasRemote(name)
        return remote(name) ~= nil
    end

    local function fire(name, ...)
        if not Runtime.Alive then
            return false, "unloaded"
        end

        local now = os.clock()
        if now - (Runtime.LastCall[name] or 0) < PERF.RemoteMinInterval then
            return false, "rate limited"
        end
        Runtime.LastCall[name] = now

        local args = table.pack(...)
        if Network and type(Network.FireServer) == "function" then
            local ok = pcall(Network.FireServer, name, table.unpack(args, 1, args.n))
            if ok then
                return true
            end
        end

        local target = remote(name)
        if not target or not target:IsA("RemoteEvent") then
            return false, "missing remote"
        end

        local ok, err = pcall(target.FireServer, target, table.unpack(args, 1, args.n))
        return ok, err
    end

    local function fireIfPresent(name, ...)
        if hasRemote(name) then
            return fire(name, ...)
        end
        return false
    end

    local function watch(name, callback)
        local target = remote(name)
        if not target or not target:IsA("RemoteEvent") then
            return false
        end
        local connection = target.OnClientEvent:Connect(function(...)
            if Runtime.Alive then
                callback(...)
            end
        end)
        table.insert(Runtime.Connections, connection)
        return true
    end

    local function setParagraph(paragraph, title, desc)
        if not paragraph then
            return
        end
        local cache = ParagraphCache[paragraph]
        if not cache then
            cache = {}
            ParagraphCache[paragraph] = cache
        end
        if title ~= nil and title ~= cache.Title then
            cache.Title = title
            pcall(paragraph.SetTitle, paragraph, title)
        end
        if desc ~= nil and desc ~= cache.Desc then
            cache.Desc = desc
            pcall(paragraph.SetDesc, paragraph, desc)
        end
    end

    local function setToggle(toggle, value)
        if not toggle then
            return
        end
        value = value == true
        if ToggleCache[toggle] == value then
            return
        end
        ToggleCache[toggle] = value
        pcall(toggle.Set, toggle, value)
    end

    local function refreshDropdown(dropdown, values, selected)
        if not dropdown then
            return
        end
        values = #values > 0 and values or {"None"}
        local cache = DropdownCache[dropdown]
        if not cache then
            cache = {}
            DropdownCache[dropdown] = cache
        end
        if cache.Values ~= values then
            cache.Values = values
            cache.Selected = nil
            pcall(dropdown.Refresh, dropdown, values)
        end
        if selected and selected ~= cache.Selected and table.find(values, selected) then
            cache.Selected = selected
            pcall(dropdown.Select, dropdown, selected)
        end
    end

    local function formatNumber(value)
        local n = tonumber(value) or 0
        if n >= 1e12 then
            return string.format("%.2fT", n / 1e12)
        elseif n >= 1e9 then
            return string.format("%.2fB", n / 1e9)
        elseif n >= 1e6 then
            return string.format("%.2fM", n / 1e6)
        elseif n >= 1e3 then
            return string.format("%.2fK", n / 1e3)
        end
        return tostring(math.floor(n + 0.5))
    end

    local function parseThreshold(text)
        local raw = tostring(text or ""):lower():gsub("[, ]", "")
        local numberPart, suffix = raw:match("^([%d%.]+)([kmbtqa]?)$")
        local n = tonumber(numberPart)
        if not n then
            return nil
        end
        local multipliers = {k = 1e3, m = 1e6, b = 1e9, t = 1e12, q = 1e15, a = 1e18}
        return math.clamp(math.floor(n * (multipliers[suffix] or 1) + 0.5), 0, 9e15)
    end

    local UnitDefCache = {}
    local UnitNameCache = {}
    local TraitNameCache = {}

    local function unitDef(entry)
        if not entry or not entry.DefId then
            return nil
        end
        local cached = UnitDefCache[entry.DefId]
        if cached ~= nil then
            return cached or nil
        end
        if not UnitDefs or type(UnitDefs.Get) ~= "function" then
            UnitDefCache[entry.DefId] = false
            return nil
        end
        local ok, def = pcall(UnitDefs.Get, entry.DefId)
        UnitDefCache[entry.DefId] = ok and def or false
        return ok and def or nil
    end

    local function unitName(entry)
        if not entry then
            return "Unknown"
        end
        local id = entry.DefId or "Unknown"
        local cached = UnitNameCache[id]
        if cached then
            return cached
        end
        local def = unitDef(entry)
        local name = (def and def.DisplayName) or id
        UnitNameCache[id] = name
        return name
    end

    local function traitName(id)
        if not id then
            return "None"
        end
        local cached = TraitNameCache[id]
        if cached then
            return cached
        end
        local value = tostring(id)
        if TraitDefs and type(TraitDefs.DisplayName) == "function" then
            local ok, display = pcall(TraitDefs.DisplayName, id)
            if ok and display then
                value = display
            end
        end
        TraitNameCache[id] = value
        return value
    end

    local TraitTierRank = {Rare = 1, Epic = 2, Legendary = 3, Mythic = 4}

    local function traitTier(id)
        if not id then
            return nil
        end
        if TraitDefs and type(TraitDefs.TierOf) == "function" then
            local ok, tier = pcall(TraitDefs.TierOf, id)
            if ok and tier then
                return tier
            end
        end
        if TraitDefs and type(TraitDefs.Get) == "function" then
            local ok, def = pcall(TraitDefs.Get, id)
            if ok and def then
                return def.Tier
            end
        end
        return nil
    end

    local function traitChance(id)
        if TraitDefs and type(TraitDefs.Get) == "function" then
            local ok, def = pcall(TraitDefs.Get, id)
            if ok and def then
                return tonumber(def.Chance) or 0
            end
        end
        return 0
    end

    local function closeGamePanels()
        if not PanelRegistry or type(PanelRegistry.NotifyOpened) ~= "function" then
            return false
        end
        return pcall(PanelRegistry.NotifyOpened, "WaveHubReroll")
    end

    local function closeControllerPanel(controller)
        local openFor = controller and controller.OpenFor
        if type(openFor) ~= "function" then
            return false
        end

        local function tryPanel(value)
            if type(value) ~= "table" or type(value.SetOpen) ~= "function" or type(value.IsOpen) ~= "function" then
                return false
            end
            local openOk, isOpen = pcall(value.IsOpen)
            if openOk and isOpen then
                local closeOk = pcall(value.SetOpen, false)
                return closeOk
            end
            return false
        end

        local allGetter = getupvalues or (debug and debug.getupvalues)
        if type(allGetter) == "function" then
            local ok, values = pcall(allGetter, openFor)
            if ok and type(values) == "table" then
                for _, value in pairs(values) do
                    if tryPanel(value) then
                        return true
                    end
                end
            end
        end

        local oneGetter = getupvalue or (debug and debug.getupvalue)
        if type(oneGetter) == "function" then
            for index = 1, 32 do
                local ok, first, second = pcall(oneGetter, openFor, index)
                if not ok then
                    break
                end
                local value = second ~= nil and second or first
                if value == nil then
                    break
                end
                if tryPanel(value) then
                    return true
                end
            end
        end
        return false
    end

    local hiddenRerollGuis = {}
    local function suppressNativeRerollUI()
        closeControllerPanel(TraitRerollController)
        closeControllerPanel(StatRerollController)
        closeGamePanels()

        local playerGui = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not playerGui then
            return
        end

        for _, name in ipairs({"TraitsUI", "Stat_Reroll"}) do
            local gui = playerGui:FindFirstChild(name)
            if gui and gui:IsA("ScreenGui") and gui.Enabled then
                hiddenRerollGuis[gui] = true
                gui.Enabled = false
            end
        end
    end

    local function restoreNativeRerollUI()
        if Runtime.Auto.Trait or Runtime.Auto.Stat then
            return
        end
        for gui in pairs(hiddenRerollGuis) do
            if gui.Parent then
                gui.Enabled = true
            end
        end
        table.clear(hiddenRerollGuis)
    end

    local function shortGuid(guid)
        local value = tostring(guid or "")
        return #value > 7 and value:sub(-7) or value
    end

    local function unitLabel(entry, displayName)
        local mutation = entry.Mutation and (" \226\128\162 " .. tostring(entry.Mutation)) or ""
        return string.format("%s%s \226\128\162 %s", displayName or unitName(entry), mutation, shortGuid(entry.Guid))
    end

    local function statRank(tier)
        if not tier then
            return -1
        end
        if StatTierDefs and type(StatTierDefs.Rank) == "function" then
            local ok, rank = pcall(StatTierDefs.Rank, tier)
            if ok and type(rank) == "number" then
                return rank
            end
        end
        local order = {D = 1, C = 2, B = 3, A = 4, S = 5, SS = 6, Z = 7, ["Z+"] = 8, ZZZ = 9}
        return order[tier] or -1
    end

    local function isEquipped(guid)
        return Runtime.TeamSet[guid] == true
    end

    local function unitListChanged(entries)
        local nextStamp = {}
        local count = 0
        local changed = #entries ~= Runtime.InventoryListCount

        for _, entry in ipairs(entries) do
            local guid = entry.Guid
            if guid then
                count += 1
                local stamp = table.concat({
                    tostring(entry.DefId or ""),
                    tostring(entry.Mutation or ""),
                }, "|")
                nextStamp[guid] = stamp
                if Runtime.InventoryListStamp[guid] ~= stamp then
                    changed = true
                end
            end
        end

        if count ~= Runtime.InventoryListCount then
            changed = true
        end

        Runtime.InventoryListStamp = nextStamp
        Runtime.InventoryListCount = count
        return changed
    end

    local ItemSelectorCache = {}
    local function itemAffectsSelector(id)
        local cached = ItemSelectorCache[id]
        if cached ~= nil then
            return cached
        end

        local selectable = false
        if ItemDefs and type(ItemDefs.Get) == "function" then
            local ok, def = pcall(ItemDefs.Get, id)
            if ok and def then
                selectable = def.Usable == true
                if not selectable and type(ItemDefs.IsGear) == "function" then
                    local gearOk, isGear = pcall(ItemDefs.IsGear, def)
                    selectable = gearOk and isGear == true
                end
            end
        end

        ItemSelectorCache[id] = selectable
        return selectable
    end

    local function itemListChanged(items)
        local nextStamp = {}
        local count = 0
        local changed = false

        for id, amount in pairs(items) do
            if (tonumber(amount) or 0) > 0 and itemAffectsSelector(id) then
                count += 1
                local stamp = true
                nextStamp[id] = stamp
                if Runtime.ItemListStamp[id] ~= stamp then
                    changed = true
                end
            end
        end

        if count ~= Runtime.ItemListCount then
            changed = true
        end

        Runtime.ItemListStamp = nextStamp
        Runtime.ItemListCount = count
        return changed
    end

    local function updateUnitLists()
        local rows = {}
        for _, entry in ipairs(Runtime.Entries) do
            local name = unitName(entry)
            rows[#rows + 1] = {
                Entry = entry,
                Name = name,
                Level = tonumber(entry.Level) or 1,
                Guid = tostring(entry.Guid or ""),
                Label = unitLabel(entry, name),
            }
        end

        table.sort(rows, function(a, b)
            if a.Name == b.Name then
                if a.Level == b.Level then
                    return a.Guid < b.Guid
                end
                return a.Level > b.Level
            end
            return a.Name < b.Name
        end)

        local values = table.create(#rows)
        UI.UnitLabelToGuid = {}
        UI.GuidToUnitLabel = {}
        for index, row in ipairs(rows) do
            values[index] = row.Label
            UI.UnitLabelToGuid[row.Label] = row.Entry.Guid
            UI.GuidToUnitLabel[row.Entry.Guid] = row.Label
        end
        UI.UnitValues = values

        if Runtime.SelectedGuid and not Runtime.Inventory[Runtime.SelectedGuid] then
            Runtime.SelectedGuid = nil
        end
        if not Runtime.SelectedGuid and rows[1] then
            Runtime.SelectedGuid = rows[1].Entry.Guid
        end

        local selected = Runtime.SelectedGuid and UI.GuidToUnitLabel[Runtime.SelectedGuid]
        for _, dropdown in ipairs(UI.UnitDropdowns) do
            refreshDropdown(dropdown, values, selected)
        end
        for _, record in ipairs(UI.UnitMultiDropdowns) do
            local selectedMulti = {}
            if type(record.GetSelected) == "function" then
                local ok, guids = pcall(record.GetSelected)
                if ok and type(guids) == "table" then
                    for _, guid in ipairs(guids) do
                        local label = UI.GuidToUnitLabel[guid]
                        if label then
                            selectedMulti[#selectedMulti + 1] = label
                        end
                    end
                end
            end
            refreshDropdown(record.Control, values, nil)
            if #selectedMulti > 0 then
                pcall(function()
                    record.Control:Select(selectedMulti)
                end)
            end
        end
    end

    local unitRefreshQueued = false
    local function queueUnitListRefresh()
        if unitRefreshQueued then
            return
        end
        unitRefreshQueued = true
        task.delay(PERF.UnitRefreshDebounce, function()
            unitRefreshQueued = false
            if Runtime.Alive then
                updateUnitLists()
            end
        end)
    end

    local ItemDefCache = {}
    local ItemNameCache = {}
    local function itemDisplay(id)
        local cached = ItemDefCache[id]
        if cached ~= nil then
            return ItemNameCache[id] or id, cached or nil
        end
        local def
        if ItemDefs and type(ItemDefs.Get) == "function" then
            local ok, value = pcall(ItemDefs.Get, id)
            if ok then
                def = value
            end
        end
        ItemDefCache[id] = def or false
        ItemNameCache[id] = (def and def.DisplayName) or id
        return ItemNameCache[id], def
    end

    local function updateItemLists()
        local usable = {}
        local gear = {}
        UI.ItemLabelToId = {}
        UI.GearLabelToId = {}

        for id, count in pairs(Runtime.Items) do
            if (tonumber(count) or 0) > 0 then
                local name, def = itemDisplay(id)
                local label = string.format("%s \226\128\162 %s", tostring(name), tostring(id))
                if def and def.Usable then
                    table.insert(usable, label)
                    UI.ItemLabelToId[label] = id
                end
                local isGear = false
                if def and ItemDefs and type(ItemDefs.IsGear) == "function" then
                    local ok, result = pcall(ItemDefs.IsGear, def)
                    isGear = ok and result == true
                end
                if isGear then
                    table.insert(gear, label)
                    UI.GearLabelToId[label] = id
                end
            end
        end

        table.sort(usable)
        table.sort(gear)

        UI.UsableValues = usable
        UI.GearValues = gear
        for _, dropdown in ipairs(UI.ItemDropdowns) do
            refreshDropdown(dropdown, usable, nil)
        end
        for _, dropdown in ipairs(UI.GearDropdowns) do
            refreshDropdown(dropdown, gear, nil)
        end
    end

    local itemRefreshQueued = false
    local function queueItemListRefresh()
        if itemRefreshQueued then
            return
        end
        itemRefreshQueued = true
        task.delay(PERF.ItemRefreshDebounce, function()
            itemRefreshQueued = false
            if Runtime.Alive then
                updateItemLists()
            end
        end)
    end

    local function registerUnitDropdown(dropdown)
        table.insert(UI.UnitDropdowns, dropdown)
        if #UI.UnitValues > 0 then
            local selected = Runtime.SelectedGuid and UI.GuidToUnitLabel[Runtime.SelectedGuid]
            refreshDropdown(dropdown, UI.UnitValues, selected)
        end
    end

    local function registerUnitMultiDropdown(dropdown, getSelected)
        table.insert(UI.UnitMultiDropdowns, {
            Control = dropdown,
            GetSelected = getSelected,
        })
        if #UI.UnitValues > 0 then
            refreshDropdown(dropdown, UI.UnitValues, nil)
        end
    end

    local function registerItemDropdown(dropdown)
        table.insert(UI.ItemDropdowns, dropdown)
        if #UI.UsableValues > 0 then
            refreshDropdown(dropdown, UI.UsableValues, nil)
        end
    end

    local function registerGearDropdown(dropdown)
        table.insert(UI.GearDropdowns, dropdown)
        if #UI.GearValues > 0 then
            refreshDropdown(dropdown, UI.GearValues, nil)
        end
    end

    local function selectedEntry()
        return Runtime.SelectedGuid and Runtime.Inventory[Runtime.SelectedGuid] or nil
    end

    local function stopTrait(reason)
        local hadRolls = (Runtime.TraitJob.Count or 0) > 0
        Runtime.Auto.Trait = false
        Runtime.TraitJob.Pending = false
        Runtime.TraitJob.Guid = nil
        if UI.TraitAutoToggle then
            Runtime.Suppress.Auto = true
            setToggle(UI.TraitAutoToggle, false)
            Runtime.Suppress.Auto = false
        end
        restoreNativeRerollUI()
        if hadRolls then
            task.defer(function()
                if Runtime.Alive then
                    fireIfPresent("RequestItems")
                end
            end)
        end
        if reason then
            notify("Trait Reroll", reason, "circle-check", 4)
        end
    end

    local function stopStat(reason)
        local hadRolls = (Runtime.StatJob.Count or 0) > 0
        Runtime.Auto.Stat = false
        Runtime.StatJob.Pending = false
        Runtime.StatJob.Guid = nil
        if UI.StatAutoToggle then
            Runtime.Suppress.Auto = true
            setToggle(UI.StatAutoToggle, false)
            Runtime.Suppress.Auto = false
        end
        restoreNativeRerollUI()
        if hadRolls then
            task.defer(function()
                if Runtime.Alive then
                    fireIfPresent("RequestItems")
                end
            end)
        end
        if reason then
            notify("Stat Reroll", reason, "circle-check", 4)
        end
    end

    local function traitResultReached(traitId, job)
        job = job or Runtime.TraitJob
        if not traitId then
            return false
        end
        if job.Mode == "Minimum Tier" then
            return (TraitTierRank[traitTier(traitId)] or -1) >= (TraitTierRank[job.MinTier] or math.huge)
        end
        return type(job.Targets) == "table" and job.Targets[traitId] == true
    end

    local function requestTraitRoll()
        local job = Runtime.TraitJob
        if not Runtime.Auto.Trait or not job.Guid or job.Pending then
            return
        end
        if (Runtime.Items.TraitRerolls or 0) <= 0 then
            stopTrait("No Trait Rerolls left.")
            return
        end

        job.Pending = true
        Runtime.Items.TraitRerolls = math.max((Runtime.Items.TraitRerolls or 0) - 1, 0)
        local ok = fire("RequestTraitReroll", {Guid = job.Guid})
        if not ok then
            job.Pending = false
            Runtime.Items.TraitRerolls = (Runtime.Items.TraitRerolls or 0) + 1
            stopTrait("Reroll request failed.")
        end
    end

    local function statCostItem(mode)
        if StatRerollDefs and StatRerollDefs.COSTS and StatRerollDefs.COSTS[mode] then
            return StatRerollDefs.COSTS[mode].Item, StatRerollDefs.COSTS[mode].Amount or 1
        end
        return mode == "Single" and "SuperStatCrystals" or "StatCrystals", 1
    end

    local function requestStatRoll()
        local job = Runtime.StatJob
        if not Runtime.Auto.Stat or not job.Guid or job.Pending then
            return
        end
        local item, amount = statCostItem(job.Mode)
        if (Runtime.Items[item] or 0) < amount then
            stopStat("No " .. item .. " left.")
            return
        end

        job.Pending = true
        Runtime.Items[item] = math.max((Runtime.Items[item] or 0) - amount, 0)
        local ok = fire("RequestStatReroll", {Guid = job.Guid, Mode = job.Mode, Stat = job.Mode == "Single" and job.Stat or nil})
        if not ok then
            job.Pending = false
            Runtime.Items[item] = (Runtime.Items[item] or 0) + amount
            stopStat("Reroll request failed.")
        end
    end

    local function statResultReached(payload)
        local job = Runtime.StatJob
        local target = statRank(job.Target)
        local after = type(payload) == "table" and payload.After or nil
        local entry = Runtime.Inventory[job.Guid]
        local tiers = entry and entry.StatTiers or {}

        if type(after) == "table" then
            tiers = after
        elseif type(after) == "string" and job.Mode == "Single" then
            tiers = table.clone(tiers or {})
            tiers[job.Stat] = after
        end

        if job.Mode == "All" and job.Rule == "All Stats" then
            for _, stat in ipairs({"Damage", "Health", "Range", "CDR"}) do
                if statRank(tiers and tiers[stat]) < target then
                    return false
                end
            end
            return true
        end

        return statRank(tiers and tiers[job.Stat]) >= target
    end

    local rerollSyncGeneration = 0
    local function queueRerollCurrencySync()
        rerollSyncGeneration += 1
        local generation = rerollSyncGeneration
        task.delay(1.25, function()
            if Runtime.Alive and generation == rerollSyncGeneration and not Runtime.Auto.Trait and not Runtime.Auto.Stat then
                fireIfPresent("RequestItems")
            end
        end)
    end

    local function rewardPlaytimeSeconds()
        local playtime = Runtime.Rewards and Runtime.Rewards.Playtime
        if not playtime then
            return 0
        end
        return (tonumber(playtime.Seconds) or 0) + math.max(0, os.clock() - Runtime.RewardsAt)
    end

    local function claimAvailablePlaytime()
        if not Runtime.Rewards or not RewardDefs or type(RewardDefs.Playtime) ~= "table" then
            return
        end
        local playtime = Runtime.Rewards.Playtime or {}
        local claimed = playtime.Claimed or {}
        local seconds = rewardPlaytimeSeconds()
        for index, def in ipairs(RewardDefs.Playtime) do
            local isClaimed = claimed[index] == true or claimed[tostring(index)] == true
            if not isClaimed and (tonumber(def.Minutes) or math.huge) * 60 <= seconds then
                fireIfPresent("RequestClaimPlaytime", index)
                task.wait(0.09)
            end
        end
    end

    local function claimBundle()
        local daily = Runtime.Rewards and Runtime.Rewards.Daily
        if daily and daily.CanClaim == true then
            fireIfPresent("RequestClaimDaily")
            task.wait(0.09)
        end
        claimAvailablePlaytime()
        for _, name in ipairs({
            "RequestClaimAll",
            "RequestClaimAllBattlePass",
            "RequestClaimOffline",
            "RequestGroupReward",
            "RequestClaimIndex",
        }) do
            if not Runtime.Alive then
                break
            end
            fireIfPresent(name)
            task.wait(0.09)
        end
    end

    local function requestCoreSync()
        task.spawn(function()
            for _, name in ipairs({
                "RequestInventory",
                "RequestTeamSync",
                "RequestItems",
                "RequestSettings",
                "RequestRewards",
                "RequestTreeUpgrades",
                "RequestStatsSync",
            }) do
                if not Runtime.Alive then
                    break
                end
                fireIfPresent(name)
                task.wait(0.09)
            end
        end)
    end

    local function requestFullSync()
        task.spawn(function()
            local names = {
                "RequestInventory",
                "RequestTeamSync",
                "RequestItems",
                "RequestSettings",
                "RequestRewards",
                "RequestQuests",
                "RequestBattlePass",
                "RequestOffline",
                "RequestIndexRewards",
                "RequestGroupRewardSync",
                "RequestTreeUpgrades",
                "RequestStatsSync",
                "RequestWorlds",
                "RequestFuseState",
                "RequestTraitPity",
                "RequestTraitSkip",
                "RequestStatSkip",
                "RequestRebirthSync",
                "RequestServerLuckSync",
                "RequestBoosts",
                "RequestObbyState",
                "RequestLeaderboard",
            }
            for _, name in ipairs(names) do
                if not Runtime.Alive then
                    break
                end
                fireIfPresent(name)
                task.wait(0.08)
            end
        end)
    end

    local function treeParentUnlocked(node)
        if not node or not node.Parent then
            return true
        end
        if Runtime.Tree.Owned[node.Parent] == true then
            return true
        end
        if UpgradeTreeDefs and type(UpgradeTreeDefs.IsTabRoot) == "function" then
            local ok, isRoot = pcall(UpgradeTreeDefs.IsTabRoot, node.Parent)
            return ok and isRoot == true
        end
        return false
    end

    local function treeNodeAffordable(node)
        if not node or not node.Id or node.Hidden or Runtime.Tree.Owned[node.Id] == true then
            return false
        end
        if type(node.Cost) ~= "table" or #node.Cost == 0 then
            return false
        end
        if UpgradeTreeDefs and type(UpgradeTreeDefs.IsTabRoot) == "function" then
            local ok, isRoot = pcall(UpgradeTreeDefs.IsTabRoot, node.Id)
            if ok and isRoot then
                return false
            end
        end
        if not treeParentUnlocked(node) then
            return false
        end
        if UpgradeTreeDefs and type(UpgradeTreeDefs.IsReachable) == "function" then
            local ok, reachable = pcall(UpgradeTreeDefs.IsReachable, node)
            if ok and not reachable then
                return false
            end
        end
        for _, cost in ipairs(node.Cost or {}) do
            if cost.Currency == "Gems" and not Runtime.TreeAuto.SpendGems then
                return false
            end
        end
        if UpgradeTreeDefs and type(UpgradeTreeDefs.Shortfalls) == "function" then
            local ok, shortfalls = pcall(UpgradeTreeDefs.Shortfalls, node, {
                Gold = Runtime.Tree.Gold,
                Gems = Runtime.Tree.Gems,
                TotalRolls = Runtime.Tree.TotalRolls,
            })
            if ok then
                return type(shortfalls) == "table" and #shortfalls == 0
            end
        end
        for _, cost in ipairs(node.Cost or {}) do
            if cost.Currency and (tonumber(Runtime.Tree[cost.Currency]) or 0) < (tonumber(cost.Amount) or 0) then
                return false
            elseif cost.Requirement and (tonumber(Runtime.Tree[cost.Requirement]) or 0) < (tonumber(cost.Amount) or 0) then
                return false
            end
        end
        return true
    end

    local function nextAffordableTreeNode()
        if not UpgradeTreeDefs or type(UpgradeTreeDefs.Nodes) ~= "table" then
            return nil
        end
        for _, node in ipairs(UpgradeTreeDefs.Nodes) do
            if treeNodeAffordable(node) then
                return node
            end
        end
        return nil
    end

    local function tryAutoTreePurchase(force)
        if not Runtime.Alive or not Runtime.Auto.Tree or Runtime.TreeAuto.Pending then
            return
        end
        local now = os.clock()
        if not force and now < Runtime.TreeAuto.NextCheck then
            return
        end
        Runtime.TreeAuto.NextCheck = now + 0.35
        if not Runtime.Safety.ProgressSpending then
            Runtime.Auto.Tree = false
            if UI.TreeAutoToggle then
                Runtime.Suppress.Auto = true
                setToggle(UI.TreeAutoToggle, false)
                Runtime.Suppress.Auto = false
            end
            return
        end
        local node = nextAffordableTreeNode()
        if not node then
            return
        end
        Runtime.TreeAuto.Pending = true
        Runtime.TreeAuto.LastNode = node.Id
        local sent = fire("RequestBuyTreeNode", node.Id)
        if not sent then
            Runtime.TreeAuto.Pending = false
            return
        end
        task.delay(1.5, function()
            if Runtime.Alive and Runtime.Auto.Tree and Runtime.TreeAuto.Pending and Runtime.TreeAuto.LastNode == node.Id then
                Runtime.TreeAuto.Pending = false
                fireIfPresent("RequestTreeUpgrades")
            end
        end)
    end

    WaveHub:AddCleanup(function()
        Runtime.Alive = false
        Runtime.Auto.Trait = false
        Runtime.Auto.Stat = false
        Runtime.Auto.Deploy = false
        Runtime.Auto.Claim = false
        Runtime.Auto.Tree = false
        Runtime.TreeAuto.Pending = false
        Runtime.JobToken.Deploy += 1
        Runtime.JobToken.Claim += 1
        restoreNativeRerollUI()
        for _, connection in ipairs(Runtime.Connections) do
            pcall(function()
                connection:Disconnect()
            end)
        end
        table.clear(Runtime.Connections)
    end)

    if game.PlaceId ~= PLACE_ID then
        notify("Wrong game", "This module targets PlaceId " .. PLACE_ID .. ".", "triangle-alert", 6)
    end

    local KnownRemotes = {
        "RequestAutoPlay", "AutoPlayState", "RequestGameSpeed", "GameSpeed", "RequestDeploy",
        "RequestInventory", "InventorySync", "RequestTeamSync", "TeamSync", "RequestItems", "ItemsSync",
        "RequestEquipBest", "RequestUnequipAll", "RequestEquip", "RequestUnequip", "RequestSetLocked",
        "RequestTrash", "RequestEquipGear", "RequestUnequipGear", "RequestUnitLevelUp", "RequestUnitLevelUpBulk",
        "RequestFuse", "RequestFuseState", "FuseSync", "FuseResult",
        "RequestTraitReroll", "TraitRerollResult", "RequestTraitPity", "RequestTraitSkip", "RequestTraitSkipSet",
        "RequestStatReroll", "StatRerollResult", "RequestStatSkip", "RequestStatSkipSet",
        "RequestRoll", "RequestSetting", "RequestSettings", "SettingsSync",
        "RequestRewards", "RewardsSync", "RequestClaimDaily", "RequestClaimPlaytime", "RequestClaimAll",
        "RequestBattlePass", "RequestClaimAllBattlePass", "RequestClaimOffline", "RequestGroupReward", "RequestClaimIndex",
        "RequestRedeemCode", "RequestRaidJoin", "RequestRaidStart", "RequestRaidLeave", "RequestRaidDifficulty",
        "RequestRaidAutoReplay", "RaidSync", "RequestTrialJoin", "RequestTrialStart", "RequestTrialLeave",
        "RequestTrialContinue", "RequestTrialAutoReplay", "TrialSync", "RequestWarp", "RequestWorlds", "WorldsSync",
        "RequestBuyTreeNode", "RequestTreeUpgrades", "TreeSync",
        "RequestRebirth", "RequestRebirthSync", "RebirthSync", "RequestUseItem", "RequestStatsSync", "StatsSync",
        "RequestServerLuckSync", "ServerLuckSync", "RequestSendHome", "RequestSellSlot",
        "RequestBoosts", "BoostSync", "RequestObbyState", "ObbySync", "RequestLeaderboard", "LeaderboardSync",
    }

    local function buildGameUI()
        local Section = WaveHub:AddTabSection("ANIME WAR RNG")
        local Main = Section:Tab({Title = "Main", Icon = "zap"})
        local Units = Section:Tab({Title = "Units", Icon = "users"})
        local Rerolls = Section:Tab({Title = "Rerolls", Icon = "refresh-cw"})
        local Roll = Section:Tab({Title = "Roll", Icon = "dices"})
        local Rewards = Section:Tab({Title = "Rewards", Icon = "gift"})
        local Activities = Section:Tab({Title = "Activities", Icon = "swords"})
        local Progression = Section:Tab({Title = "Progression", Icon = "trending-up"})
        local Misc = Section:Tab({Title = "Misc", Icon = "wrench"})

        local Link = Main:Section({Title = "Server Link", Box = true, Opened = true})
        UI.RemoteStatus = Link:Paragraph({Title = "Checking...", Desc = "Scanning game remotes.", Color = "Blue"})

        local function updateRemoteStatus()
            local found = 0
            local missing = {}
            for _, name in ipairs(KnownRemotes) do
                remote(name, true)
                if hasRemote(name) then
                    found += 1
                else
                    table.insert(missing, name)
                end
            end
            local desc = string.format("Remotes: %d/%d\nPlaceId: %s", found, #KnownRemotes, tostring(game.PlaceId))
            if #missing > 0 then
                desc ..= "\nMissing: " .. table.concat(missing, ", ")
            else
                desc ..= "\nAll mapped remotes are present."
            end
            setParagraph(UI.RemoteStatus, found == #KnownRemotes and "Server Link \226\128\162 Ready" or "Server Link \226\128\162 Partial", desc)
        end

        Link:Button({Title = "Recheck", Icon = "refresh-cw", Callback = updateRemoteStatus})

        local Combat = Main:Section({Title = "Combat", Box = true, Opened = true})
        UI.AutoPlayStatus = Combat:Paragraph({Title = "Auto Play", Desc = "State: unknown"})

        local function paintAutoPlay()
            local state = Runtime.AutoPlay == nil and "unknown" or (Runtime.AutoPlay and "ON" or "OFF")
            if Runtime.AutoPlayLocked then
                state = "LOCKED"
            end
            setParagraph(UI.AutoPlayStatus, "Auto Play", "State: " .. state)
            if UI.AutoPlayToggle and Runtime.AutoPlay ~= nil then
                Runtime.Suppress.Auto = true
                setToggle(UI.AutoPlayToggle, Runtime.AutoPlay)
                Runtime.Suppress.Auto = false
            end
        end

        UI.AutoPlayToggle = Combat:Toggle({
            Title = "Auto Play",
            Icon = "bot",
            Value = false,
            Callback = function(value)
                if Runtime.Suppress.Auto then
                    return
                end
                if Runtime.AutoPlay == value then
                    return
                end
                fire("RequestAutoPlay")
            end,
        })

        Combat:Dropdown({
            Title = "Game Speed",
            Values = {"1x", "1.25x", "1.5x", "1.75x", "2x"},
            Value = "1x",
            Multi = false,
            AllowNone = false,
            Flag = "WH_AWR_GameSpeed",
            Callback = function(value)
                local speed = tonumber(tostring(value):gsub("x", ""))
                if speed then
                    fire("RequestGameSpeed", speed)
                end
            end,
        })

        local deploySlot = 1
        Combat:Dropdown({
            Title = "Deploy Slot",
            Values = {"1", "2", "3", "4", "5", "6"},
            Value = "1",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                deploySlot = tonumber(value) or 1
            end,
        })

        Combat:Button({
            Title = "Deploy Selected",
            Icon = "mouse-pointer-click",
            Callback = function()
                fire("RequestDeploy", deploySlot)
            end,
        })

        Combat:Button({
            Title = "Sell Selected Slot",
            Desc = "Sells the deployed unit in the selected hotbar slot.",
            Icon = "circle-dollar-sign",
            Callback = function()
                fireIfPresent("RequestSellSlot", deploySlot)
            end,
        })

        Combat:Button({
            Title = "Deploy Team",
            Icon = "layers",
            Callback = function()
                task.spawn(function()
                    for slot = 1, 6 do
                        fire("RequestDeploy", slot)
                        task.wait(0.12)
                    end
                end)
            end,
        })

        local deployInterval = 2
        Combat:Slider({
            Title = "Auto Deploy Interval",
            Step = 0.5,
            Value = {Min = 1, Max = 10, Default = 2},
            Flag = "WH_AWR_DeployInterval",
            Callback = function(value)
                deployInterval = tonumber(value) or 2
            end,
        })

        Combat:Toggle({
            Title = "Auto Deploy",
            Icon = "repeat",
            Value = false,
            Flag = "WH_AWR_AutoDeploy",
            Callback = function(value)
                local enabled = value == true
                if Runtime.Auto.Deploy == enabled then
                    return
                end
                Runtime.Auto.Deploy = enabled
                Runtime.JobToken.Deploy += 1
                local token = Runtime.JobToken.Deploy
                if not enabled then
                    return
                end
                task.spawn(function()
                    for slot = 1, 6 do
                        if not Runtime.Alive or not Runtime.Auto.Deploy or Runtime.JobToken.Deploy ~= token then
                            return
                        end
                        fire("RequestDeploy", slot)
                        task.wait(0.11)
                    end
                    local slot = 1
                    while Runtime.Alive and Runtime.Auto.Deploy and Runtime.JobToken.Deploy == token do
                        task.wait(math.max(deployInterval, 1))
                        if not Runtime.Alive or not Runtime.Auto.Deploy or Runtime.JobToken.Deploy ~= token then
                            break
                        end
                        fire("RequestDeploy", slot)
                        slot = slot % 6 + 1
                    end
                end)
            end,
        })

        local Session = Main:Section({Title = "Session", Box = true, Opened = false})
        local antiIdle = false
        Session:Toggle({
            Title = "Anti Idle",
            Icon = "clock",
            Value = false,
            Flag = "WH_AWR_AntiIdle",
            Callback = function(value)
                antiIdle = value == true
            end,
        })

        local idleConnection = LocalPlayer.Idled:Connect(function()
            if not Runtime.Alive or not antiIdle then
                return
            end
            pcall(function()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.2)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end)
        table.insert(Runtime.Connections, idleConnection)

        Session:Button({Title = "Refresh Game Data", Icon = "refresh-cw", Callback = requestFullSync})
        Session:Button({Title = "Send Home", Icon = "house", Callback = function() fire("RequestSendHome") end})

        local UnitSelection = Units:Section({Title = "Unit Manager", Box = true, Opened = true})
        UI.UnitInfo = UnitSelection:Paragraph({Title = "No unit selected", Desc = "Syncing inventory..."})

        local lastUnitPaintStamp
        local function paintUnitInfo(force)
            local entry = selectedEntry()
            if not entry then
                if force or lastUnitPaintStamp ~= "none" then
                    lastUnitPaintStamp = "none"
                    setParagraph(UI.UnitInfo, "No unit selected", "Sync inventory to load your units.")
                end
                return
            end
            local trait = type(entry.Traits) == "table" and traitName(entry.Traits[1]) or "None"
            local tiers = entry.StatTiers or {}
            local equipped = isEquipped(entry.Guid)
            local stamp = table.concat({
                tostring(entry.Guid), tostring(entry.Level or 1), tostring(entry.Mutation or "Normal"), trait,
                tostring(tiers.Damage or "-"), tostring(tiers.Health or "-"), tostring(tiers.Range or "-"), tostring(tiers.CDR or "-"),
                entry.Locked and "1" or "0", equipped and "1" or "0"
            }, "|")
            if not force and stamp == lastUnitPaintStamp then
                return
            end
            lastUnitPaintStamp = stamp
            local desc = string.format(
                "Lv.%s • %s\nTrait: %s\nStats: Dmg %s | HP %s | Range %s | CDR %s\nLocked: %s • Equipped: %s\nGuid: %s",
                tostring(entry.Level or 1), tostring(entry.Mutation or "Normal"), trait,
                tostring(tiers.Damage or "-"), tostring(tiers.Health or "-"), tostring(tiers.Range or "-"), tostring(tiers.CDR or "-"),
                entry.Locked and "Yes" or "No", equipped and "Yes" or "No", tostring(entry.Guid)
            )
            setParagraph(UI.UnitInfo, unitName(entry), desc)
        end

        local unitDropdown = UnitSelection:Dropdown({
            Title = "Select Unit",
            SearchBarEnabled = true,
            Values = {"None"},
            Value = "None",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                local guid = UI.UnitLabelToGuid[value]
                if guid then
                    Runtime.SelectedGuid = guid
                    paintUnitInfo()
                end
            end,
        })
        registerUnitDropdown(unitDropdown)

        UnitSelection:Button({Title = "Refresh Inventory", Icon = "refresh-cw", Callback = function() fire("RequestInventory") end})

        local Team = Units:Section({Title = "Team", Box = true, Opened = true})
        Team:Button({
            Title = "Equip Selected",
            Icon = "plus",
            Callback = function()
                local entry = selectedEntry()
                if entry then
                    fire("RequestEquip", entry.Guid)
                end
            end,
        })
        Team:Button({
            Title = "Unequip Selected",
            Icon = "minus",
            Callback = function()
                local entry = selectedEntry()
                if entry then
                    fire("RequestUnequip", entry.DefId)
                end
            end,
        })
        Team:Button({Title = "Equip Best", Icon = "wand-sparkles", Callback = function() fire("RequestEquipBest") end})
        Team:Button({Title = "Unequip All", Icon = "archive-restore", Callback = function() fire("RequestUnequipAll") end})
        Team:Button({
            Title = "Lock Selected",
            Icon = "lock",
            Callback = function()
                local entry = selectedEntry()
                if entry then
                    fire("RequestSetLocked", entry.Guid, true)
                end
            end,
        })
        Team:Button({
            Title = "Unlock Selected",
            Icon = "unlock",
            Callback = function()
                local entry = selectedEntry()
                if entry then
                    fire("RequestSetLocked", entry.Guid, false)
                end
            end,
        })

        local Leveling = Units:Section({Title = "Leveling", Box = true, Opened = false})
        local levelCurrency = "Gold"
        local levelSteps = 10
        Leveling:Dropdown({
            Title = "Currency",
            Values = {"Gold", "Gems"},
            Value = "Gold",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                levelCurrency = tostring(value)
            end,
        })
        Leveling:Slider({
            Title = "Bulk Steps",
            Step = 1,
            Value = {Min = 1, Max = 100, Default = 10},
            Callback = function(value)
                levelSteps = math.floor(tonumber(value) or 10)
            end,
        })
        Leveling:Toggle({
            Title = "Enable Spending",
            Desc = "Session-only safety switch.",
            Value = false,
            Callback = function(value)
                Runtime.Safety.UnitSpending = value == true
            end,
        })
        Leveling:Button({
            Title = "Level Up Once",
            Icon = "arrow-up",
            Callback = function()
                local entry = selectedEntry()
                if not Runtime.Safety.UnitSpending then
                    notify("Level Up", "Enable Spending first.", "triangle-alert")
                    return
                end
                if entry then
                    fire("RequestUnitLevelUp", {Guid = entry.Guid, Currency = levelCurrency})
                end
            end,
        })
        Leveling:Button({
            Title = "Bulk Level Up",
            Icon = "chevrons-up",
            Callback = function()
                local entry = selectedEntry()
                if not Runtime.Safety.UnitSpending then
                    notify("Level Up", "Enable Spending first.", "triangle-alert")
                    return
                end
                if entry then
                    fire("RequestUnitLevelUpBulk", {Guid = entry.Guid, Currency = levelCurrency, Steps = levelSteps})
                end
            end,
        })

        local Gear = Units:Section({Title = "Gear", Box = true, Opened = false})
        local gearCategory = "Weapon"
        Gear:Dropdown({
            Title = "Category",
            Values = {"Weapon", "Equipment", "Relic"},
            Value = "Weapon",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                gearCategory = tostring(value)
            end,
        })
        local gearDropdown = Gear:Dropdown({
            Title = "Gear Item",
            SearchBarEnabled = true,
            Values = {"None"},
            Value = "None",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                Runtime.SelectedGear = UI.GearLabelToId[value]
            end,
        })
        registerGearDropdown(gearDropdown)
        Gear:Button({
            Title = "Equip Gear",
            Icon = "shield-plus",
            Callback = function()
                local entry = selectedEntry()
                if entry and Runtime.SelectedGear then
                    fire("RequestEquipGear", entry.Guid, gearCategory, Runtime.SelectedGear)
                end
            end,
        })
        Gear:Button({
            Title = "Unequip Category",
            Icon = "shield-minus",
            Callback = function()
                local entry = selectedEntry()
                if entry then
                    fire("RequestUnequipGear", entry.Guid, gearCategory)
                end
            end,
        })

        local Fuse = Units:Section({Title = "Fuse", Box = true, Opened = false})
        UI.FuseInfo = Fuse:Paragraph({Title = "Fuse", Desc = "Syncing fuse state..."})
        local fuseGuids = {}
        local paintFuse
        local fuseDropdown = Fuse:Dropdown({
            Title = "Select Copies",
            SearchBarEnabled = true,
            Desc = "Up to 8 copies from the same unit line and mutation.",
            Values = {"None"},
            Value = {},
            Multi = true,
            AllowNone = true,
            Callback = function(value)
                table.clear(fuseGuids)
                if type(value) ~= "table" then
                    return
                end
                for key, item in pairs(value) do
                    local label = type(key) == "number" and item or (item == true and key or nil)
                    local guid = label and UI.UnitLabelToGuid[label]
                    if guid then
                        table.insert(fuseGuids, guid)
                    end
                end
                if paintFuse then
                    paintFuse()
                end
            end,
        })
        registerUnitMultiDropdown(fuseDropdown, function()
            return table.clone(fuseGuids)
        end)

        UI.DestructiveToggle = Fuse:Toggle({
            Title = "Arm Destructive Actions",
            Desc = "Required for Fuse and Delete. Resets after use.",
            Value = false,
            Callback = function(value)
                Runtime.Safety.Destructive = value == true
            end,
        })

        local function fuseValidation()
            if #fuseGuids < 1 then
                return false, "Select at least one copy."
            end
            if #fuseGuids > 8 then
                return false, "Fuse accepts up to 8 copies."
            end
            local first = Runtime.Inventory[fuseGuids[1]]
            if not first then
                return false, "Selected unit is no longer in inventory."
            end
            for _, guid in ipairs(fuseGuids) do
                local entry = Runtime.Inventory[guid]
                if not entry then
                    return false, "A selected unit is missing."
                end
                if entry.Locked then
                    return false, unitName(entry) .. " is locked."
                end
                if isEquipped(guid) or Runtime.Fuse.Equipped[guid] then
                    return false, unitName(entry) .. " is equipped."
                end
                if entry.DefId ~= first.DefId or entry.Mutation ~= first.Mutation then
                    return false, "All copies must have the same unit and mutation."
                end
            end
            return true, first
        end

        paintFuse = function()
            local chance = math.min(#fuseGuids * 10 + (Runtime.Fuse.ChanceBonus or 0), 100)
            local insurance = Runtime.Fuse.Insurance and "On" or "Off"
            setParagraph(UI.FuseInfo, Runtime.Fuse.Unlocked and "Fuse \226\128\162 Unlocked" or "Fuse \226\128\162 Locked", string.format("Selected: %d/8 • Chance: %d%%\nInsurance: %s", #fuseGuids, chance, insurance))
        end

        Fuse:Button({
            Title = "Fuse Selected",
            Icon = "combine",
            Callback = function()
                if not Runtime.Safety.Destructive then
                    notify("Fuse", "Arm Destructive Actions first.", "triangle-alert")
                    return
                end
                if not Runtime.Fuse.Unlocked then
                    notify("Fuse", "Fuse is locked for this account.", "triangle-alert")
                    return
                end
                local ok, reason = fuseValidation()
                if not ok then
                    notify("Fuse", reason, "triangle-alert", 4)
                    return
                end
                fire("RequestFuse", {Guids = table.clone(fuseGuids)})
                Runtime.Safety.Destructive = false
                setToggle(UI.DestructiveToggle, false)
            end,
        })

        local Delete = Units:Section({Title = "Delete", Box = true, Opened = false})
        Delete:Paragraph({Title = "Selected unit only", Desc = "Locked/equipped restrictions are still enforced by the game server."})
        Delete:Button({
            Title = "Delete Selected Unit",
            Icon = "trash-2",
            Color = Color3.fromHex("#B83A4B"),
            Callback = function()
                local entry = selectedEntry()
                if not Runtime.Safety.Destructive then
                    notify("Delete", "Arm Destructive Actions in Fuse first.", "triangle-alert")
                    return
                end
                if not entry then
                    return
                end
                fire("RequestTrash", {entry.Guid})
                Runtime.Safety.Destructive = false
                setToggle(UI.DestructiveToggle, false)
            end,
        })

        local RerollUnit = Rerolls:Section({Title = "Target Unit", Box = true, Opened = true})
        UI.RerollInfo = RerollUnit:Paragraph({Title = "No unit selected", Desc = "Select a unit below."})
        local rerollDropdown = RerollUnit:Dropdown({
            Title = "Unit",
            Values = {"None"},
            Value = "None",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                local guid = UI.UnitLabelToGuid[value]
                if guid then
                    Runtime.SelectedGuid = guid
                    local entry = Runtime.Inventory[guid]
                    local trait = entry and type(entry.Traits) == "table" and traitName(entry.Traits[1]) or "None"
                    local tiers = entry and entry.StatTiers or {}
                    setParagraph(UI.RerollInfo, unitName(entry), string.format("Trait: %s\nDmg %s | HP %s | Range %s | CDR %s", trait, tostring(tiers.Damage or "-"), tostring(tiers.Health or "-"), tostring(tiers.Range or "-"), tostring(tiers.CDR or "-")))
                    paintUnitInfo()
                end
            end,
        })
        registerUnitDropdown(rerollDropdown)

        local RerollSafety = Rerolls:Section({Title = "Safety", Box = true, Opened = true})
        UI.RerollSpendToggle = RerollSafety:Toggle({
            Title = "Enable Reroll Spending",
            Desc = "Session-only. Required for manual and automatic rerolls.",
            Value = false,
            Callback = function(value)
                Runtime.Safety.RerollSpending = value == true
            end,
        })

        local traitValues = {}
        local traitLabelToId = {}
        if TraitDefs and type(TraitDefs.Order) == "table" then
            for _, id in ipairs(TraitDefs.Order) do
                local label = traitName(id)
                table.insert(traitValues, label)
                traitLabelToId[label] = id
            end
        end
        if #traitValues == 0 then
            traitValues = {"Monarch"}
            traitLabelToId.Monarch = "Monarch"
        end

        local Trait = Rerolls:Section({Title = "Trait Reroll", Box = true, Opened = true})
        UI.TraitStatus = Trait:Paragraph({Title = "Trait Rerolls", Desc = "Currency: 0"})
        UI.TraitTargetInfo = Trait:Paragraph({Title = "Stop Rule", Desc = "Monarch"})

        local defaultTrait = traitLabelToId[traitValues[#traitValues]] or "Monarch"
        local traitStopMode = "Selected Traits"
        local traitTargets = {[defaultTrait] = true}
        local traitMinTier = "Mythic"
        local traitMax = 100
        local rerollDelay = 0.22
        local lowLagReroll = true

        local function copyTraitTargets()
            local copy = {}
            for id, enabled in pairs(traitTargets) do
                if enabled then
                    copy[id] = true
                end
            end
            return copy
        end

        local function targetChance(mode, targets, minTier)
            local total = 0
            if mode == "Minimum Tier" then
                local minRank = TraitTierRank[minTier] or math.huge
                if TraitDefs and type(TraitDefs.Order) == "table" then
                    for _, id in ipairs(TraitDefs.Order) do
                        if (TraitTierRank[traitTier(id)] or -1) >= minRank then
                            total += traitChance(id)
                        end
                    end
                end
                return total
            end
            for id in pairs(targets) do
                total += traitChance(id)
            end
            return total
        end

        local function paintTraitRule()
            if traitStopMode == "Minimum Tier" then
                local chance = targetChance(traitStopMode, traitTargets, traitMinTier)
                setParagraph(UI.TraitTargetInfo, "Minimum Tier: " .. traitMinTier, string.format("Stops on %s or higher \226\128\162 Base chance %.2f%%", traitMinTier, chance))
                return
            end

            local names = {}
            if TraitDefs and type(TraitDefs.Order) == "table" then
                for _, id in ipairs(TraitDefs.Order) do
                    if traitTargets[id] then
                        names[#names + 1] = traitName(id)
                    end
                end
            else
                for id in pairs(traitTargets) do
                    names[#names + 1] = traitName(id)
                end
                table.sort(names)
            end
            local chance = targetChance(traitStopMode, traitTargets, traitMinTier)
            setParagraph(
                UI.TraitTargetInfo,
                #names > 0 and ("Selected Traits: " .. #names) or "No target selected",
                #names > 0 and (table.concat(names, ", ") .. string.format("\nCombined base chance: %.2f%%", chance)) or "Pick one or more traits before starting auto reroll."
            )
        end

        Trait:Dropdown({
            Title = "Stop Mode",
            Values = {"Selected Traits", "Minimum Tier"},
            Value = "Selected Traits",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                traitStopMode = tostring(value)
                paintTraitRule()
            end,
        })

        Trait:Dropdown({
            Title = "Target Traits",
            Desc = "Select every trait that should stop auto reroll.",
            Values = traitValues,
            Value = {traitValues[#traitValues]},
            Multi = true,
            AllowNone = true,
            Callback = function(value)
                table.clear(traitTargets)
                if type(value) == "table" then
                    for key, item in pairs(value) do
                        local label = type(key) == "number" and item or (item == true and key or nil)
                        local id = label and traitLabelToId[label]
                        if id then
                            traitTargets[id] = true
                        end
                    end
                end
                paintTraitRule()
            end,
        })

        local traitTierValues = {"Rare", "Epic", "Legendary", "Mythic"}
        if TraitDefs and type(TraitDefs.TierOrder) == "table" and #TraitDefs.TierOrder > 0 then
            traitTierValues = table.clone(TraitDefs.TierOrder)
        end
        Trait:Dropdown({
            Title = "Minimum Tier",
            Desc = "Example: Legendary also accepts Mythic.",
            Values = traitTierValues,
            Value = "Mythic",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                traitMinTier = tostring(value)
                paintTraitRule()
            end,
        })

        Trait:Slider({
            Title = "Reroll Delay",
            Desc = "Lower is faster. 0.20\226\128\1470.30s is a good range with Low-Lag Mode.",
            Step = 0.05,
            Value = {Min = 0.15, Max = 2.5, Default = 0.22},
            Callback = function(value)
                rerollDelay = math.max(0.15, tonumber(value) or 0.22)
            end,
        })

        Trait:Toggle({
            Title = "Low-Lag Mode",
            Desc = "Closes/hides the game's reroll panel while auto reroll is running to avoid stacked reveal animations.",
            Value = true,
            Callback = function(value)
                lowLagReroll = value == true
            end,
        })

        Trait:Slider({
            Title = "Max Attempts",
            Step = 1,
            Value = {Min = 1, Max = 5000, Default = 100},
            Callback = function(value)
                traitMax = math.floor(tonumber(value) or 100)
            end,
        })

        Trait:Button({
            Title = "Reroll Once",
            Icon = "refresh-cw",
            Callback = function()
                local entry = selectedEntry()
                if not Runtime.Safety.RerollSpending then
                    notify("Trait Reroll", "Enable Reroll Spending first.", "triangle-alert")
                    return
                end
                if entry then
                    fire("RequestTraitReroll", {Guid = entry.Guid})
                end
            end,
        })

        UI.TraitAutoToggle = Trait:Toggle({
            Title = "Auto Reroll",
            Icon = "repeat",
            Value = false,
            Callback = function(value)
                if Runtime.Suppress.Auto then
                    return
                end
                if not value then
                    stopTrait()
                    return
                end

                local entry = selectedEntry()
                if not Runtime.Safety.RerollSpending then
                    notify("Trait Reroll", "Enable Reroll Spending first.", "triangle-alert")
                    setToggle(UI.TraitAutoToggle, false)
                    return
                end
                if not entry then
                    setToggle(UI.TraitAutoToggle, false)
                    return
                end
                if traitStopMode == "Selected Traits" and next(traitTargets) == nil then
                    notify("Trait Reroll", "Select at least one target trait.", "triangle-alert")
                    setToggle(UI.TraitAutoToggle, false)
                    return
                end

                local job = {
                    Guid = entry.Guid,
                    Mode = traitStopMode,
                    Targets = copyTraitTargets(),
                    MinTier = traitMinTier,
                    Count = 0,
                    Max = traitMax,
                    Delay = rerollDelay,
                    Pending = false,
                }
                local current = type(entry.Traits) == "table" and entry.Traits[1] or nil
                if traitResultReached(current, job) then
                    notify("Trait Reroll", "Current trait already matches the stop rule.", "circle-check")
                    setToggle(UI.TraitAutoToggle, false)
                    return
                end

                Runtime.TraitJob = job
                Runtime.Auto.Trait = true
                if lowLagReroll then
                    suppressNativeRerollUI()
                end
                requestTraitRoll()
            end,
        })

        paintTraitRule()

        local TraitFilter = Rerolls:Section({Title = "Trait Skip Filter", Box = true, Opened = false})
        local skipTrait = defaultTrait
        TraitFilter:Dropdown({
            Title = "Trait",
            Values = traitValues,
            Value = traitValues[#traitValues],
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                skipTrait = traitLabelToId[value] or tostring(value)
            end,
        })
        TraitFilter:Button({Title = "Skip This Trait", Callback = function() fireIfPresent("RequestTraitSkipSet", {Trait = skipTrait, Skip = true}) end})
        TraitFilter:Button({Title = "Keep This Trait", Callback = function() fireIfPresent("RequestTraitSkipSet", {Trait = skipTrait, Skip = false}) end})

        local Stat = Rerolls:Section({Title = "Stat Reroll", Box = true, Opened = true})
        UI.StatStatus = Stat:Paragraph({Title = "Stat Crystals", Desc = "Normal: 0 \226\128\162 Super: 0"})
        local statMode = "All"
        local statTargetStat = "Damage"
        local statTargetTier = "S"
        local statRule = "Selected Stat"
        local statMax = 100
        local statTiers = {"D", "C", "B", "A", "S", "SS", "Z", "Z+", "ZZZ"}

        Stat:Dropdown({
            Title = "Mode",
            Values = {"All", "Single"},
            Value = "All",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                statMode = tostring(value)
            end,
        })
        Stat:Dropdown({
            Title = "Target Stat",
            Values = {"Damage", "Health", "Range", "CDR"},
            Value = "Damage",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                statTargetStat = tostring(value)
            end,
        })
        Stat:Dropdown({
            Title = "Target Tier",
            Values = statTiers,
            Value = "S",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                statTargetTier = tostring(value)
            end,
        })
        Stat:Dropdown({
            Title = "All-mode Stop Rule",
            Values = {"Selected Stat", "All Stats"},
            Value = "Selected Stat",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                statRule = tostring(value)
            end,
        })
        Stat:Slider({
            Title = "Max Attempts",
            Step = 1,
            Value = {Min = 1, Max = 1000, Default = 100},
            Callback = function(value)
                statMax = math.floor(tonumber(value) or 100)
            end,
        })
        Stat:Button({
            Title = "Reroll Once",
            Icon = "refresh-cw",
            Callback = function()
                local entry = selectedEntry()
                if not Runtime.Safety.RerollSpending then
                    notify("Stat Reroll", "Enable Reroll Spending first.", "triangle-alert")
                    return
                end
                if entry then
                    fire("RequestStatReroll", {Guid = entry.Guid, Mode = statMode, Stat = statMode == "Single" and statTargetStat or nil})
                end
            end,
        })

        UI.StatAutoToggle = Stat:Toggle({
            Title = "Auto Reroll to Tier",
            Icon = "repeat",
            Value = false,
            Callback = function(value)
                if Runtime.Suppress.Auto then
                    return
                end
                if not value then
                    stopStat()
                    return
                end
                local entry = selectedEntry()
                if not Runtime.Safety.RerollSpending then
                    notify("Stat Reroll", "Enable Reroll Spending first.", "triangle-alert")
                    setToggle(UI.StatAutoToggle, false)
                    return
                end
                if not entry then
                    setToggle(UI.StatAutoToggle, false)
                    return
                end
                Runtime.StatJob = {
                    Guid = entry.Guid,
                    Mode = statMode,
                    Stat = statTargetStat,
                    Target = statTargetTier,
                    Rule = statRule,
                    Count = 0,
                    Max = statMax,
                    Delay = rerollDelay,
                    Pending = false,
                }
                Runtime.Auto.Stat = true
                if statResultReached({After = entry.StatTiers, Mode = statMode}) then
                    stopStat("Target is already satisfied.")
                    return
                end
                if lowLagReroll then
                    suppressNativeRerollUI()
                end
                requestStatRoll()
            end,
        })

        local StatFilter = Rerolls:Section({Title = "Stat Skip Filter", Box = true, Opened = false})
        local skipTier = "S"
        StatFilter:Dropdown({
            Title = "Tier",
            Values = {"A", "S", "SS", "Z", "Z+", "ZZZ"},
            Value = "S",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                skipTier = tostring(value)
            end,
        })
        StatFilter:Button({Title = "Skip This Tier", Callback = function() fireIfPresent("RequestStatSkipSet", {Tier = skipTier, Skip = true}) end})
        StatFilter:Button({Title = "Keep This Tier", Callback = function() fireIfPresent("RequestStatSkipSet", {Tier = skipTier, Skip = false}) end})

        local RollControl = Roll:Section({Title = "Roll Control", Box = true, Opened = true})
        local rollRequestId = math.floor((workspace:GetServerTimeNow() % 100000) * 1000)
        RollControl:Button({
            Title = "Roll Once",
            Icon = "dices",
            Callback = function()
                rollRequestId += 1
                fire("RequestRoll", {reqId = rollRequestId})
            end,
        })

        UI.AutoRollToggle = RollControl:Toggle({
            Title = "Auto Roll",
            Icon = "repeat",
            Value = false,
            Flag = "WH_AWR_AutoRoll",
            Callback = function(value)
                if Runtime.Suppress.Settings then
                    return
                end
                if Runtime.Settings.AutoRoll == value then
                    return
                end
                fire("RequestSetting", {Key = "AutoRoll", Value = value == true})
            end,
        })

        UI.QuickRollToggle = RollControl:Toggle({
            Title = "Quick Roll",
            Icon = "fast-forward",
            Value = false,
            Flag = "WH_AWR_QuickRoll",
            Callback = function(value)
                if Runtime.Suppress.Settings then
                    return
                end
                if Runtime.Settings.QuickRoll == value then
                    return
                end
                fire("RequestSetting", {Key = "QuickRoll", Value = value == true})
            end,
        })

        local Thresholds = Roll:Section({Title = "Roll Thresholds", Box = true, Opened = true})
        local mergeText = "0"
        local cutsceneText = "0"
        UI.ThresholdStatus = Thresholds:Paragraph({Title = "Current", Desc = "Auto Merge: -\nCutscene Skip: -"})
        Thresholds:Input({
            Title = "Auto Merge Threshold",
            Desc = "Example: 1000 or 5m. 0 merges everything.",
            Value = "0",
            Placeholder = "0",
            Callback = function(value)
                mergeText = tostring(value or "0")
            end,
        })
        Thresholds:Button({
            Title = "Apply Auto Merge",
            Callback = function()
                local value = parseThreshold(mergeText)
                if value == nil then
                    notify("Auto Merge", "Invalid threshold.", "triangle-alert")
                    return
                end
                fire("RequestSetting", {Key = "AutoMergeThreshold", Value = value})
            end,
        })
        Thresholds:Input({
            Title = "Cutscene Skip Threshold",
            Desc = "Example: 50 or 5m. 0 turns it off.",
            Value = "0",
            Placeholder = "0",
            Callback = function(value)
                cutsceneText = tostring(value or "0")
            end,
        })
        Thresholds:Button({
            Title = "Apply Cutscene Skip",
            Callback = function()
                local value = parseThreshold(cutsceneText)
                if value == nil then
                    notify("Cutscene Skip", "Invalid threshold.", "triangle-alert")
                    return
                end
                fire("RequestSetting", {Key = "CutsceneSkipThreshold", Value = value})
            end,
        })

        local RewardState = Rewards:Section({Title = "Reward State", Box = true, Opened = true})
        UI.RewardStatus = RewardState:Paragraph({Title = "Rewards", Desc = "Syncing..."})

        local function paintRewards()
            local daily = Runtime.Rewards and Runtime.Rewards.Daily or {}
            local playtime = Runtime.Rewards and Runtime.Rewards.Playtime or {}
            local claimed = playtime.Claimed or {}
            local claimedCount = 0
            for i = 1, 7 do
                if claimed[i] == true or claimed[tostring(i)] == true then
                    claimedCount += 1
                end
            end
            setParagraph(UI.RewardStatus, daily.CanClaim and "Daily \226\128\162 Ready" or "Daily", string.format("Streak: %s/7\nPlaytime: %s min • Claimed: %d/7", tostring(daily.Streak or 0), tostring(math.floor(rewardPlaytimeSeconds() / 60)), claimedCount))
        end

        RewardState:Button({Title = "Claim Daily", Icon = "calendar-check", Callback = function() fire("RequestClaimDaily") end})
        RewardState:Button({Title = "Claim Available Playtime", Icon = "clock", Callback = claimAvailablePlaytime})
        RewardState:Button({Title = "Claim All Quests", Icon = "list-checks", Callback = function() fire("RequestClaimAll") end})
        RewardState:Button({Title = "Claim Battle Pass", Icon = "badge-check", Callback = function() fire("RequestClaimAllBattlePass") end})
        RewardState:Button({Title = "Claim Offline", Icon = "moon", Callback = function() fire("RequestClaimOffline") end})
        RewardState:Button({Title = "Claim Group Reward", Icon = "users", Callback = function() fire("RequestGroupReward") end})
        RewardState:Button({Title = "Claim Index Reward", Icon = "book-open-check", Callback = function() fire("RequestClaimIndex") end})
        RewardState:Button({Title = "Claim Everything", Icon = "package-check", Callback = function() task.spawn(claimBundle) end})

        local claimInterval = 30
        RewardState:Slider({
            Title = "Auto Claim Interval",
            Step = 1,
            Value = {Min = 10, Max = 120, Default = 30},
            Flag = "WH_AWR_ClaimInterval",
            Callback = function(value)
                claimInterval = tonumber(value) or 30
            end,
        })
        RewardState:Toggle({
            Title = "Smart Auto Claim",
            Icon = "repeat",
            Value = false,
            Flag = "WH_AWR_AutoClaim",
            Callback = function(value)
                local enabled = value == true
                if Runtime.Auto.Claim == enabled then
                    return
                end
                Runtime.Auto.Claim = enabled
                Runtime.JobToken.Claim += 1
                local token = Runtime.JobToken.Claim
                if not enabled then
                    return
                end
                task.spawn(function()
                    while Runtime.Alive and Runtime.Auto.Claim and Runtime.JobToken.Claim == token do
                        fireIfPresent("RequestRewards")
                        task.wait(0.25)
                        claimBundle()
                        task.wait(claimInterval)
                    end
                end)
            end,
        })

        local Codes = Rewards:Section({Title = "Codes", Box = true, Opened = false})
        local codeText = ""
        Codes:Input({
            Title = "Code",
            Value = "",
            Placeholder = "Enter code...",
            Callback = function(value)
                codeText = tostring(value or "")
            end,
        })
        Codes:Button({
            Title = "Redeem",
            Icon = "ticket-check",
            Callback = function()
                local code = codeText:match("^%s*(.-)%s*$")
                if code == "" then
                    notify("Codes", "Enter a code first.", "triangle-alert")
                    return
                end
                fire("RequestRedeemCode", code)
            end,
        })

        local Raid = Activities:Section({Title = "Raid", Box = true, Opened = true})
        UI.RaidStatus = Raid:Paragraph({Title = "Raid", Desc = "State: unknown"})
        local raidDifficulty = "Normal"
        Raid:Dropdown({
            Title = "Difficulty",
            Values = {"Easy", "Normal", "Hard", "Nightmare"},
            Value = "Normal",
            Multi = false,
            AllowNone = false,
            Flag = "WH_AWR_RaidDifficulty",
            Callback = function(value)
                raidDifficulty = tostring(value)
                fire("RequestRaidDifficulty", raidDifficulty)
            end,
        })
        Raid:Button({Title = "Join", Icon = "log-in", Callback = function() fire("RequestRaidJoin") end})
        Raid:Button({Title = "Start", Icon = "play", Callback = function() fire("RequestRaidStart") end})
        Raid:Button({Title = "Leave", Icon = "log-out", Callback = function() fire("RequestRaidLeave") end})
        UI.RaidReplayToggle = Raid:Toggle({
            Title = "Auto Replay",
            Value = false,
            Callback = function(value)
                if Runtime.Suppress.Auto then
                    return
                end
                if Runtime.Raid and Runtime.Raid.AutoReplay == value then
                    return
                end
                fire("RequestRaidAutoReplay")
            end,
        })
        Raid:Toggle({
            Title = "Auto Start as Leader",
            Value = false,
            Flag = "WH_AWR_RaidAutoStart",
            Callback = function(value)
                Runtime.Auto.RaidStart = value == true
            end,
        })

        local Trial = Activities:Section({Title = "Trial", Box = true, Opened = true})
        UI.TrialStatus = Trial:Paragraph({Title = "Trial", Desc = "State: unknown"})
        Trial:Button({Title = "Join", Icon = "log-in", Callback = function() fire("RequestTrialJoin") end})
        Trial:Button({Title = "Start", Icon = "play", Callback = function() fire("RequestTrialStart") end})
        Trial:Button({Title = "Continue", Icon = "step-forward", Callback = function() fire("RequestTrialContinue") end})
        Trial:Button({Title = "Leave", Icon = "log-out", Callback = function() fire("RequestTrialLeave") end})
        UI.TrialReplayToggle = Trial:Toggle({
            Title = "Auto Retry",
            Value = false,
            Callback = function(value)
                if Runtime.Suppress.Auto then
                    return
                end
                if Runtime.Trial and Runtime.Trial.AutoReplay == value then
                    return
                end
                fire("RequestTrialAutoReplay")
            end,
        })
        Trial:Toggle({
            Title = "Auto Start as Leader",
            Value = false,
            Flag = "WH_AWR_TrialAutoStart",
            Callback = function(value)
                Runtime.Auto.TrialStart = value == true
            end,
        })

        local Warp = Activities:Section({Title = "World Warp", Box = true, Opened = false})
        local worldValues = {}
        local worldLabelToId = {}
        if MapDefs and type(MapDefs.GetOrdered) == "function" then
            local ok, maps = pcall(MapDefs.GetOrdered)
            if ok and type(maps) == "table" then
                for _, row in ipairs(maps) do
                    local label = (row.Def and row.Def.DisplayName) or row.Id
                    table.insert(worldValues, label)
                    worldLabelToId[label] = row.Id
                end
            end
        end
        if #worldValues == 0 then
            worldValues = {"Leaf Village"}
        end
        local worldId = worldLabelToId[worldValues[1]]
        local worldDifficulty = "Normal"
        Warp:Dropdown({
            Title = "World",
            SearchBarEnabled = true,
            Values = worldValues,
            Value = worldValues[1],
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                worldId = worldLabelToId[value]
            end,
        })
        Warp:Dropdown({
            Title = "Difficulty",
            Values = {"Easy", "Normal", "Hard", "Nightmare"},
            Value = "Normal",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                worldDifficulty = tostring(value)
            end,
        })
        Warp:Button({
            Title = "Warp",
            Icon = "map-pin",
            Callback = function()
                if worldId then
                    fire("RequestWarp", worldId, worldDifficulty)
                end
            end,
        })

        local ProgressSafety = Progression:Section({Title = "Safety", Box = true, Opened = true})
        ProgressSafety:Toggle({
            Title = "Enable Tree Spending",
            Desc = "Session-only. Required for manual and automatic tree purchases.",
            Value = false,
            Callback = function(value)
                Runtime.Safety.ProgressSpending = value == true
                if not Runtime.Safety.ProgressSpending and Runtime.Auto.Tree then
                    Runtime.Auto.Tree = false
                    Runtime.TreeAuto.Pending = false
                    if UI.TreeAutoToggle then
                        Runtime.Suppress.Auto = true
                        setToggle(UI.TreeAutoToggle, false)
                        Runtime.Suppress.Auto = false
                    end
                end
            end,
        })

        local Tree = Progression:Section({Title = "Upgrade Tree", Box = true, Opened = true})
        UI.TreeInfo = Tree:Paragraph({Title = "Tree", Desc = "Syncing..."})
        local nodeValues = {}
        local nodeLabelToId = {}
        if UpgradeTreeDefs and type(UpgradeTreeDefs.Nodes) == "table" then
            for _, node in ipairs(UpgradeTreeDefs.Nodes) do
                if node.Cost and not node.Hidden then
                    local label = string.format("%s \226\128\162 %s", node.Title or node.Id, node.Id)
                    table.insert(nodeValues, label)
                    nodeLabelToId[label] = node.Id
                end
            end
        end
        if #nodeValues == 0 then
            nodeValues = {"No nodes loaded"}
        end
        local nodeId = nodeLabelToId[nodeValues[1]]

        local function treeCostText(node)
            if not node or type(node.Cost) ~= "table" then
                return "No cost"
            end
            local parts = {}
            for _, cost in ipairs(node.Cost) do
                if cost.Currency then
                    table.insert(parts, formatNumber(cost.Amount) .. " " .. tostring(cost.Currency))
                elseif cost.Requirement then
                    table.insert(parts, formatNumber(cost.Amount) .. " " .. tostring(cost.Requirement))
                end
            end
            return #parts > 0 and table.concat(parts, " + ") or "No cost"
        end

        local function paintTree()
            local node = nodeId and UpgradeTreeDefs and type(UpgradeTreeDefs.Get) == "function" and UpgradeTreeDefs.Get(nodeId) or nil
            if not node then
                setParagraph(UI.TreeInfo, "Upgrade Tree", string.format("Gold: %s \226\128\162 Gems: %s", formatNumber(Runtime.Tree.Gold), formatNumber(Runtime.Tree.Gems)))
                return
            end
            local owned = Runtime.Tree.Owned[nodeId] == true
            local autoState = Runtime.Auto.Tree and (Runtime.TreeAuto.Pending and "Buying" or "Watching") or "Off"
            setParagraph(
                UI.TreeInfo,
                (node.Title or nodeId) .. (owned and " \226\128\162 Owned" or ""),
                tostring(node.Description or "")
                    .. "\nCost: " .. treeCostText(node)
                    .. "\nParent: " .. tostring(node.Parent or "Root")
                    .. "\nAuto: " .. autoState
            )
        end

        Tree:Dropdown({
            Title = "Node",
            SearchBarEnabled = true,
            Values = nodeValues,
            Value = nodeValues[1],
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                nodeId = nodeLabelToId[value]
                paintTree()
            end,
        })
        Tree:Button({
            Title = "Buy Selected Node",
            Icon = "git-branch-plus",
            Callback = function()
                if not Runtime.Safety.ProgressSpending then
                    notify("Upgrade Tree", "Enable Tree Spending first.", "triangle-alert")
                    return
                end
                if nodeId then
                    fire("RequestBuyTreeNode", nodeId)
                end
            end,
        })
        Tree:Toggle({
            Title = "Allow Gem Nodes",
            Desc = "Off by default so Auto Upgrade does not spend Gems.",
            Value = false,
            Callback = function(value)
                Runtime.TreeAuto.SpendGems = value == true
                if Runtime.Auto.Tree then
                    task.defer(tryAutoTreePurchase)
                end
            end,
        })
        UI.TreeAutoToggle = Tree:Toggle({
            Title = "Auto Upgrade Tree",
            Desc = "Buys the next affordable unlocked node automatically.",
            Icon = "sparkles",
            Value = false,
            Callback = function(value)
                if Runtime.Suppress.Auto then
                    return
                end
                local enabled = value == true
                if enabled and not Runtime.Safety.ProgressSpending then
                    notify("Upgrade Tree", "Enable Tree Spending first.", "triangle-alert")
                    setToggle(UI.TreeAutoToggle, false)
                    return
                end
                Runtime.Auto.Tree = enabled
                Runtime.TreeAuto.Pending = false
                if enabled then
                    fireIfPresent("RequestTreeUpgrades")
                    fireIfPresent("RequestStatsSync")
                    task.defer(function()
                        tryAutoTreePurchase(true)
                    end)
                end
                paintTree()
            end,
        })

        local Rebirth = Progression:Section({Title = "Rebirth", Box = true, Opened = false})
        UI.RebirthInfo = Rebirth:Paragraph({Title = "Rebirth", Desc = "Syncing..."})
        UI.RebirthToggle = Rebirth:Toggle({
            Title = "Arm Rebirth",
            Desc = "Rebirth resets Gold to 0 and returns you to the start world.",
            Value = false,
            Callback = function(value)
                Runtime.Safety.Rebirth = value == true
            end,
        })
        Rebirth:Button({
            Title = "Rebirth Now",
            Icon = "rotate-ccw",
            Color = Color3.fromHex("#B8743A"),
            Callback = function()
                if not Runtime.Safety.Rebirth then
                    notify("Rebirth", "Arm Rebirth first.", "triangle-alert")
                    return
                end
                fire("RequestRebirth")
                Runtime.Safety.Rebirth = false
                setToggle(UI.RebirthToggle, false)
            end,
        })

        local Items = Misc:Section({Title = "Items", Box = true, Opened = true})
        UI.ItemInfo = Items:Paragraph({Title = "Usable Items", Desc = "Syncing..."})
        local useAmount = 1
        local itemDropdown = Items:Dropdown({
            Title = "Item",
            SearchBarEnabled = true,
            Values = {"None"},
            Value = "None",
            Multi = false,
            AllowNone = false,
            Callback = function(value)
                Runtime.SelectedItem = UI.ItemLabelToId[value]
                local id = Runtime.SelectedItem
                if id then
                    local name, def = itemDisplay(id)
                    setParagraph(UI.ItemInfo, name, "Owned: " .. formatNumber(Runtime.Items[id]) .. "\nCategory: " .. tostring(def and def.Category or "-"))
                end
            end,
        })
        registerItemDropdown(itemDropdown)
        Items:Slider({
            Title = "Amount",
            Step = 1,
            Value = {Min = 1, Max = 50, Default = 1},
            Callback = function(value)
                useAmount = math.floor(tonumber(value) or 1)
            end,
        })
        Items:Button({
            Title = "Use Item",
            Icon = "package-open",
            Callback = function()
                local id = Runtime.SelectedItem
                if not id then
                    return
                end
                local owned = tonumber(Runtime.Items[id]) or 0
                if owned <= 0 then
                    return
                end
                fire("RequestUseItem", id, math.clamp(useAmount, 1, owned))
            end,
        })

        local GameSettings = Misc:Section({Title = "Game Settings", Box = true, Opened = true})
        local settingDefs = {
            {"HideHealthBars", "Hide Health Bars"},
            {"HideDamageIndicators", "Hide Damage Indicators"},
            {"HideUnitVFX", "Hide Unit VFX"},
            {"HideWeatherVFX", "Hide Weather VFX"},
            {"PerformanceMode", "Performance Mode"},
            {"HideRollTimer", "Hide Roll Timer"},
            {"HideRollPreview", "Hide Roll Preview"},
            {"ShowBossNotification", "Show Boss Notification"},
            {"ShowBossDialogue", "Show Boss Dialogue"},
            {"ShowServerRolls", "Show Server Rolls"},
            {"ShowGlobalRolls", "Show Global Rolls"},
            {"ShowBaseStats", "Show Base Stats"},
        }
        UI.SettingToggles = {}
        for _, row in ipairs(settingDefs) do
            local key, title = row[1], row[2]
            UI.SettingToggles[key] = GameSettings:Toggle({
                Title = title,
                Value = false,
                Flag = "WH_AWR_Setting_" .. key,
                Callback = function(value)
                    if Runtime.Suppress.Settings then
                        return
                    end
                    fire("RequestSetting", {Key = key, Value = value == true})
                end,
            })
        end

        local Diagnostics = Misc:Section({Title = "Diagnostics", Box = true, Opened = false})
        UI.ServerLuckInfo = Diagnostics:Paragraph({Title = "Server Luck", Desc = "Syncing..."})
        Diagnostics:Button({Title = "Sync Server Luck", Icon = "clover", Callback = function() fireIfPresent("RequestServerLuckSync") end})
        Diagnostics:Button({Title = "Sync Everything", Icon = "refresh-cw", Callback = requestFullSync})
        Diagnostics:Button({Title = "Recheck Remotes", Icon = "radio", Callback = updateRemoteStatus})

        local WorldState = Misc:Section({Title = "World State", Box = true, Opened = false})
        UI.BoostInfo = WorldState:Paragraph({Title = "Active Boosts", Desc = "Syncing..."})
        UI.ObbyInfo = WorldState:Paragraph({Title = "Obby Cooldowns", Desc = "Syncing..."})
        UI.LeaderboardInfo = WorldState:Paragraph({Title = "Leaderboard", Desc = "Syncing..."})

        local function paintBoosts()
            local rows = {}
            local now = os.time()
            for id, endsAt in pairs(Runtime.Boosts) do
                local title = tostring(id)
                if BoostDefs and type(BoostDefs.Get) == "function" then
                    local ok, def = pcall(BoostDefs.Get, id)
                    if ok and def then
                        title = def.DisplayName or title
                    end
                end
                local left = math.max(0, math.floor((tonumber(endsAt) or now) - now))
                table.insert(rows, string.format("%s \226\128\162 %dm %02ds", title, math.floor(left / 60), left % 60))
            end
            table.sort(rows)
            setParagraph(UI.BoostInfo, "Active Boosts", #rows > 0 and table.concat(rows, "\n") or "None")
        end

        local function paintObby()
            local rows = {}
            local now = os.time()
            for id, endsAt in pairs(Runtime.ObbyCooldowns) do
                local left = math.max(0, math.floor((tonumber(endsAt) or now) - now))
                table.insert(rows, string.format("%s \226\128\162 %dm %02ds", tostring(id), math.floor(left / 60), left % 60))
            end
            table.sort(rows)
            setParagraph(UI.ObbyInfo, "Obby Cooldowns", #rows > 0 and table.concat(rows, "\n") or "Ready")
        end

        WorldState:Button({Title = "Sync Boosts", Icon = "sparkles", Callback = function() fireIfPresent("RequestBoosts") end})
        WorldState:Button({Title = "Sync Obby", Icon = "timer-reset", Callback = function() fireIfPresent("RequestObbyState") end})
        WorldState:Button({Title = "Sync Leaderboard", Icon = "trophy", Callback = function() fireIfPresent("RequestLeaderboard") end})

        local ConfigSection = Misc:Section({Title = "Game Config", Box = true, Opened = false})
        local GameConfig
        pcall(function()
            GameConfig = WaveHub:CreateConfig("AnimeWarRNG", true)
            if GameConfig then
                GameConfig:SetAutoLoad(true)
            end
        end)
        ConfigSection:Button({
            Title = "Save Config",
            Icon = "save",
            Callback = function()
                if not GameConfig then
                    notify("Config", "Config storage is unavailable.", "triangle-alert")
                    return
                end
                local ok, err = pcall(function()
                    GameConfig:SetAutoLoad(true)
                    GameConfig:Save()
                end)
                notify(ok and "Config saved" or "Save failed", ok and "Anime War RNG settings saved." or tostring(err), ok and "circle-check" or "triangle-alert")
            end,
        })
        ConfigSection:Button({
            Title = "Load Config",
            Icon = "folder-open",
            Callback = function()
                if not GameConfig then
                    notify("Config", "Config storage is unavailable.", "triangle-alert")
                    return
                end
                local ok, err = pcall(function()
                    GameConfig:Load()
                end)
                notify(ok and "Config loaded" or "Load failed", ok and "Anime War RNG settings loaded." or tostring(err), ok and "circle-check" or "triangle-alert")
            end,
        })

        UI.UpdateRemoteStatus = updateRemoteStatus
        UI.PaintAutoPlay = paintAutoPlay
        UI.PaintUnitInfo = paintUnitInfo
        UI.PaintFuse = paintFuse
        UI.PaintRewards = paintRewards
        UI.PaintTree = paintTree
        UI.PaintBoosts = paintBoosts
        UI.PaintObby = paintObby
        Runtime.FuseGuids = fuseGuids
    end

    buildGameUI()

    local function processInventorySync(payload)
        if type(payload) ~= "table" or type(payload.Entries) ~= "table" then
            return
        end
        local selectorChanged = unitListChanged(payload.Entries)
        Runtime.Entries = payload.Entries
        Runtime.InventoryCap = tonumber(payload.Cap) or Runtime.InventoryCap
        Runtime.Inventory = {}
        for _, entry in ipairs(payload.Entries) do
            if entry.Guid then
                Runtime.Inventory[entry.Guid] = entry
            end
        end
        if selectorChanged then
            queueUnitListRefresh()
        end
        UI.PaintUnitInfo()
        if selectorChanged then
            UI.PaintFuse()
        end
        local entry = selectedEntry()
        if entry then
            local trait = type(entry.Traits) == "table" and traitName(entry.Traits[1]) or "None"
            local tiers = entry.StatTiers or {}
            local rerollStamp = table.concat({tostring(entry.Guid), trait, tostring(tiers.Damage or "-"), tostring(tiers.Health or "-"), tostring(tiers.Range or "-"), tostring(tiers.CDR or "-")}, "|")
            if rerollStamp ~= Runtime.LastRerollInfoStamp then
                Runtime.LastRerollInfoStamp = rerollStamp
                setParagraph(UI.RerollInfo, unitName(entry), string.format("Trait: %s\nDmg %s | HP %s | Range %s | CDR %s", trait, tostring(tiers.Damage or "-"), tostring(tiers.Health or "-"), tostring(tiers.Range or "-"), tostring(tiers.CDR or "-")))
            end
        end
    end

    local pendingInventorySync
    local inventorySyncQueued = false
    watch("InventorySync", function(payload)
        pendingInventorySync = payload
        if inventorySyncQueued then
            return
        end
        inventorySyncQueued = true
        task.delay(0.08, function()
            inventorySyncQueued = false
            if not Runtime.Alive then
                return
            end
            local latest = pendingInventorySync
            pendingInventorySync = nil
            processInventorySync(latest)
        end)
    end)

    watch("TeamSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Team = type(payload.Team) == "table" and payload.Team or {}
        Runtime.TeamSet = {}
        local guids = type(payload.Guids) == "table" and payload.Guids or {}
        for _, guid in ipairs(guids) do
            Runtime.TeamSet[guid] = true
        end
        UI.PaintUnitInfo()
    end)

    local function processItemsSync(payload)
        if type(payload) ~= "table" or type(payload.Items) ~= "table" then
            return
        end
        local selectorChanged = itemListChanged(payload.Items)
        Runtime.Items = payload.Items
        if selectorChanged then
            queueItemListRefresh()
        end

        local now = os.clock()
        if not Runtime.Auto.Trait and not Runtime.Auto.Stat or now - (Runtime.LastCurrencyPaint or 0) >= PERF.CurrencyPaintInterval then
            Runtime.LastCurrencyPaint = now
            setParagraph(UI.TraitStatus, "Trait Rerolls", "Currency: " .. formatNumber(Runtime.Items.TraitRerolls or 0))
            setParagraph(UI.StatStatus, "Stat Crystals", "Normal: " .. formatNumber(Runtime.Items.StatCrystals or 0) .. " \226\128\162 Super: " .. formatNumber(Runtime.Items.SuperStatCrystals or 0))
        end
    end

    local pendingItemsSync
    local itemsSyncQueued = false
    watch("ItemsSync", function(payload)
        pendingItemsSync = payload
        if itemsSyncQueued then
            return
        end
        itemsSyncQueued = true
        task.delay(0.10, function()
            itemsSyncQueued = false
            if not Runtime.Alive then
                return
            end
            local latest = pendingItemsSync
            pendingItemsSync = nil
            processItemsSync(latest)
        end)
    end)

    watch("AutoPlayState", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.AutoPlay = payload.Enabled == true
        Runtime.AutoPlayLocked = payload.Locked == true
        UI.PaintAutoPlay()
    end)

    watch("GameSpeed", function(value)
        Runtime.GameSpeed = tonumber(value) or Runtime.GameSpeed
    end)

    watch("SettingsSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Settings = payload
        Runtime.Suppress.Settings = true
        setToggle(UI.AutoRollToggle, payload.AutoRoll == true)
        setToggle(UI.QuickRollToggle, payload.QuickRoll == true)
        for key, toggle in pairs(UI.SettingToggles or {}) do
            if payload[key] ~= nil then
                setToggle(toggle, payload[key] == true)
            end
        end
        Runtime.Suppress.Settings = false
        setParagraph(UI.ThresholdStatus, "Current", "Auto Merge: " .. formatNumber(payload.AutoMergeThreshold or 0) .. "\nCutscene Skip: " .. formatNumber(payload.CutsceneSkipThreshold or 0))
    end)

    watch("FuseSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Fuse.Unlocked = payload.Unlocked == true
        Runtime.Fuse.ChanceBonus = math.floor((tonumber(payload.ChanceBonus) or 0) * 100 + 0.5)
        Runtime.Fuse.Insurance = payload.Insurance == true
        Runtime.Fuse.Equipped = {}
        for _, guid in ipairs(type(payload.Equipped) == "table" and payload.Equipped or {}) do
            Runtime.Fuse.Equipped[guid] = true
        end
        UI.PaintFuse()
    end)

    watch("FuseResult", function(payload)
        if type(payload) ~= "table" then
            return
        end
        table.clear(Runtime.FuseGuids)
        if payload.Success then
            notify("Fuse", "Success.", "circle-check", 4)
        else
            local chance = math.floor((tonumber(payload.Chance) or 0) * 100 + 0.5)
            notify("Fuse", string.format("Failed at %d%% \226\128\162 Consumed: %s", chance, tostring(payload.Consumed or 0)), "triangle-alert", 5)
        end
        fireIfPresent("RequestInventory")
        fireIfPresent("RequestFuseState")
    end)

    watch("TraitRerollResult", function(payload)
        if type(payload) ~= "table" then
            return
        end
        if payload.Guid and Runtime.Inventory[payload.Guid] then
            Runtime.Inventory[payload.Guid].Traits = {payload.After}
        end
        if not Runtime.Auto.Trait or payload.Guid ~= Runtime.TraitJob.Guid then
            queueRerollCurrencySync()
            UI.PaintUnitInfo()
            return
        end

        local job = Runtime.TraitJob
        job.Pending = false
        job.Count += 1
        if traitResultReached(payload.After, job) then
            stopTrait("Stopped on " .. traitName(payload.After) .. " after " .. job.Count .. " rolls.")
        elseif job.Count >= job.Max then
            stopTrait("Stopped at max attempts (" .. job.Max .. ").")
        else
            task.delay(job.Delay or 0.22, requestTraitRoll)
        end
    end)

    watch("StatRerollResult", function(payload)
        if type(payload) ~= "table" then
            return
        end
        local entry = payload.Guid and Runtime.Inventory[payload.Guid]
        if entry then
            entry.StatTiers = entry.StatTiers or {}
            if payload.Mode == "All" and type(payload.After) == "table" then
                entry.StatTiers = payload.After
            elseif payload.Stat and type(payload.After) == "string" then
                entry.StatTiers[payload.Stat] = payload.After
            end
        end
        if not Runtime.Auto.Stat or payload.Guid ~= Runtime.StatJob.Guid then
            queueRerollCurrencySync()
            UI.PaintUnitInfo()
            return
        end

        local job = Runtime.StatJob
        job.Pending = false
        job.Count += 1
        if statResultReached(payload) then
            stopStat("Target reached in " .. job.Count .. " rolls.")
        elseif job.Count >= job.Max then
            stopStat("Stopped at max attempts (" .. job.Max .. ").")
        else
            task.delay(job.Delay or 0.22, requestStatRoll)
        end
    end)

    watch("RewardsSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Rewards = payload
        Runtime.RewardsAt = os.clock()
        UI.PaintRewards()
    end)


    watch("TreeSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Tree = {
            Owned = type(payload.Owned) == "table" and payload.Owned or {},
            Gold = tonumber(payload.Gold) or Runtime.Tree.Gold,
            Gems = tonumber(payload.Gems) or Runtime.Tree.Gems,
            TotalRolls = tonumber(payload.TotalRolls) or Runtime.Tree.TotalRolls,
        }
        Runtime.TreeAuto.Pending = false
        Runtime.TreeAuto.NextCheck = 0
        UI.PaintTree()
        if Runtime.Auto.Tree then
            task.defer(function()
                tryAutoTreePurchase(true)
            end)
        end
    end)

    local lastRaidStart = 0
    watch("RaidSync", function(payload)
        Runtime.Raid = type(payload) == "table" and payload or nil
        local raid = Runtime.Raid
        if not raid then
            setParagraph(UI.RaidStatus, "Raid", "State: none")
            return
        end
        local members = type(raid.Members) == "table" and #raid.Members or 0
        local leader = raid.LeaderUserId == LocalPlayer.UserId
        setParagraph(UI.RaidStatus, "Raid \226\128\162 " .. tostring(raid.State or "?"), string.format("Difficulty: %s\nParty: %d/%s • Leader: %s\nAuto Replay: %s", tostring(raid.Difficulty or "?"), members, tostring(raid.PartyMax or 4), leader and "You" or "No", raid.AutoReplay and "On" or "Off"))
        Runtime.Suppress.Auto = true
        setToggle(UI.RaidReplayToggle, raid.AutoReplay == true)
        Runtime.Suppress.Auto = false
        if Runtime.Auto.RaidStart and raid.State == "Forming" and leader and os.clock() - lastRaidStart > 2 then
            lastRaidStart = os.clock()
            task.delay(0.45, function()
                if Runtime.Auto.RaidStart and Runtime.Raid == raid then
                    fire("RequestRaidStart")
                end
            end)
        end
    end)

    local lastTrialStart = 0
    watch("TrialSync", function(payload)
        Runtime.Trial = type(payload) == "table" and payload or nil
        local trial = Runtime.Trial
        if not trial then
            setParagraph(UI.TrialStatus, "Trial", "State: none")
            return
        end
        local members = type(trial.Members) == "table" and #trial.Members or 0
        local leader = trial.LeaderUserId == LocalPlayer.UserId
        setParagraph(UI.TrialStatus, "Trial \226\128\162 " .. tostring(trial.State or "?"), string.format("Party: %d/%s • Leader: %s\nAuto Retry: %s", members, tostring(trial.PartyMax or 4), leader and "You" or "No", trial.AutoReplay and "On" or "Off"))
        Runtime.Suppress.Auto = true
        setToggle(UI.TrialReplayToggle, trial.AutoReplay == true)
        Runtime.Suppress.Auto = false
        if Runtime.Auto.TrialStart and trial.State == "Forming" and leader and os.clock() - lastTrialStart > 2 then
            lastTrialStart = os.clock()
            task.delay(0.45, function()
                if Runtime.Auto.TrialStart and Runtime.Trial == trial then
                    fire("RequestTrialStart")
                end
            end)
        end
    end)

    watch("RebirthSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Rebirth = payload
        local desc = string.format("Rebirths: %s\nGold: %s • Gems: %s\nStart World: %s\nMap Eligible: %s", tostring(payload.Rebirths or 0), formatNumber(payload.Gold or 0), formatNumber(payload.Gems or 0), tostring(payload.StartWorldName or "?"), payload.MapEligible and "Yes" or "No")
        setParagraph(UI.RebirthInfo, "Rebirth", desc)
    end)

    watch("StatsSync", function(payload)
        if type(payload) ~= "table" then
            return
        end
        Runtime.Stats = payload
        if type(payload.Gold) == "number" then
            Runtime.Tree.Gold = payload.Gold
        end
        if type(payload.Gems) == "number" then
            Runtime.Tree.Gems = payload.Gems
        end
        if Runtime.Auto.Tree and not Runtime.TreeAuto.Pending then
            task.defer(tryAutoTreePurchase)
        end
    end)

    watch("WorldsSync", function(payload)
        Runtime.Worlds = payload
    end)

    watch("BoostSync", function(payload)
        table.clear(Runtime.Boosts)
        local active = type(payload) == "table" and payload.Active or nil
        if type(active) == "table" then
            for _, row in ipairs(active) do
                if type(row) == "table" and type(row.Id) == "string" and type(row.EndsAt) == "number" then
                    Runtime.Boosts[row.Id] = row.EndsAt
                end
            end
        end
        UI.PaintBoosts()
    end)

    watch("ObbySync", function(payload)
        table.clear(Runtime.ObbyCooldowns)
        local cooldowns = type(payload) == "table" and payload.Cooldowns or nil
        if type(cooldowns) == "table" then
            for id, endsAt in pairs(cooldowns) do
                if type(id) == "string" and type(endsAt) == "number" then
                    Runtime.ObbyCooldowns[id] = endsAt
                end
            end
        end
        UI.PaintObby()
    end)

    watch("LeaderboardSync", function(payload)
        Runtime.Leaderboard = type(payload) == "table" and payload.entries or {}
        local count = type(Runtime.Leaderboard) == "table" and #Runtime.Leaderboard or 0
        setParagraph(UI.LeaderboardInfo, "Leaderboard", string.format("Entries loaded: %d", count))
    end)

    watch("ServerLuckSync", function(payload)
        Runtime.ServerLuck = payload
        if type(payload) == "table" then
            local value = payload.Multiplier or payload.Luck or payload.Value or "?"
            local time = payload.Seconds or payload.TimeLeft or payload.Duration
            setParagraph(UI.ServerLuckInfo, "Server Luck", "Multiplier: " .. tostring(value) .. (time and ("\nTime: " .. tostring(time) .. "s") or ""))
        else
            setParagraph(UI.ServerLuckInfo, "Server Luck", tostring(payload))
        end
    end)

    task.defer(function()
        task.wait(0.8)
        UI.UpdateRemoteStatus()
        requestCoreSync()
        task.wait(0.5)
        UI.PaintUnitInfo()
        UI.PaintFuse()
        UI.PaintRewards()
        UI.PaintTree()
        UI.PaintBoosts()
        UI.PaintObby()
        notify("Anime War RNG", "WaveHub v" .. VERSION .. " loaded.", "sparkles", 4)
    end)

    return WaveHub
end

local ok, err = xpcall(function()
    BuildAnimeWarRNG(WaveHub)
end, debug.traceback)

if not ok then
    warn("[WaveHub][AnimeWarRNG] " .. tostring(err))
    WaveHub:Notify("Anime War RNG", "Module failed to load. Check console.", "triangle-alert", 6)
end

return WaveHub
