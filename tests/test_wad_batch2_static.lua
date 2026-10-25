-- Static assertions over three RECOVERED WeAreDevs/WAD bodies published on
-- 2026-10-23: Slap Battles (Tryhard AI Demo), Prison Life (ESP/Freecam) and
-- Work at a Pizza Place (Order4).
--
-- These are NOT behavioural mock tests and do not claim to be: each recovered
-- top level builds GUI/Drawing objects, binds ContextActionService actions and
-- (for two of them) loadstring's external UI libraries at startup, so a
-- hand-written mock would mostly exercise the mock. What is checked is that the
-- body still compiles as Lua 5.1 and that its game-facing structure - remotes,
-- workspace paths, toggles and documented defects - survived the decode. The
-- protected inputs are never read, parsed or executed.
--
-- Lua 5.1: lua5.1 tests/test_wad_batch2_static.lua '<published file>' [case]
--   case = slapbattles | prisonlife | pizzaplace (auto-detected when omitted)
local path = assert(arg[1], "pass the recovered Lua file")
local published = assert(io.open(path, "r")):read("*a")
local body = assert(published:match("%]%]%s*(.+)$"), "missing provenance header")

local checks = 0
local function check(condition, message)
    checks = checks + 1
    assert(condition, message)
end
local function count(pattern)
    local _, total = body:gsub(pattern, "")
    return total
end
local function has(text)
    return body:find(text, 1, true) ~= nil
end

local function common()
    local chunk, syntaxError = loadstring(body)
    check(chunk ~= nil, "recovered body must compile as Lua 5.1: " .. tostring(syntaxError))
    check(body:find("pastefy.app", 1, true) == nil, "no prohibited loader host")
    check(count("goto ") == 0, "no dangling decoder goto may remain")
end

local function slapbattles()
    check(has('replicatedStorage:FindFirstChild(p5.Text .. "Slap")'),
        "per-glove slap remote lookup survived")
    check(has("b:FireServer(humanoidRootPart)"), "hit remote call survived")
    check(has("replicatedStorage.GeneralHit") and has("replicatedStorage.SnowHit"),
        "GeneralHit/SnowHit alternatives survived")
    check(count("LastSlappedBy") >= 4, "LastSlappedBy retaliation logic survived, found "
        .. count("LastSlappedBy"))
    check(has("workspace.Arena") and has("workspace.Lobby.Teleport"),
        "Slap Battles arena/lobby paths survived")
    check(has('"Control Panel"') and has("DisplayOrder = 123"),
        "the in-game control panel survived")
    check(has("1763809636.9279") and has("1763204836.9279"),
        "the original expiry window is still visible in the body")
    check(has("getgenv().BSF"), "the re-execution guard survived")
    check(has("rbxGeneral:SendAsync("), "TextChatService posting survived")
    check(has("rbxassetid://17184741588"), "own button image id survived")
    check(count("HttpGet") == 0 and count("loadstring%(") == 0,
        "this body fetches no external script")
end

local function prisonlife()
    check(has("https://friends.roproxy.com/v1/users/") and has("583171793"),
        "the followings gate is visible")
    check(has("Drawing.new("), "executor Drawing library is used")
    check(has('"Square"') and has("Tracer = self:createDrawing"),
        "ESP box/tracer components survived")
    check(has("HP = self:createDrawing") and has("Name = self:createDrawing"),
        "ESP hp/name components survived")
    check(has('"UpperTorso"') and has('"Left Arm"'),
        "R15 and R6 skeleton limb names survived")
    check(has("workspace.CellDoors") and has("workspace.Prison_ITEMS")
        and has("workspace.Prison_Fences"), "Prison Life world paths survived")
    check(has("function StartFreecam()") and has("function StopFreecam()"),
        "freecam entry points survived")
    check(has('"FC_KEYS"') and has('"FC_MOUSE"') and has('"FC_WHEEL"'),
        "freecam ContextActionService bindings survived")
    check(has("setfpscap("), "fps cap switching survived")
    check(has("lighting.ClockTime = 12"), "fullbright lighting toggle survived")
    check(has("AdvancedUtils.lua") and has("WindUI/releases/latest/download/main.lua"),
        "both mutable external dependencies are visible")
    check(count("FireServer%(") == 0 and count("InvokeServer%(") == 0,
        "this body makes no remote call")
end

local function pizzaplace()
    check(has('replicatedStorage.ManagerChannel:FireServer("GiveBonus"'),
        "GiveBonus remote call survived")
    check(has('"EmployeeOfTheDay"'), "EmployeeOfTheDay remote call survived")
    check(has('"OrderComplete"'), "OrderComplete remote call survived")
    check(has("workspace.Customers") and has("workspace.Ovens"),
        "customer/oven world paths survived")
    check(has("function GetVehicle()") and has("function GetCurrentVehicle()")
        and has("function GetManager()") and has("function FindFirstCustomer()"),
        "the vehicle/team/customer helpers survived")
    check(has('"HoodSeat"'), "delivery car seat detection survived")
    check(has('"CheesePizza"') and has('"PepperoniPizza"') and has('"SausagePizza"'),
        "pizza item names survived")
    check(has('"Auto steal items"') and has('"Auto bonus"')
        and has('"Auto employee of the day"'), "reward toggles survived")
    check(has('"Enable Noclip"') and has('"Enable Fling"') and has('"Enable Gravity"'),
        "movement toggles survived")
    check(count("loadstring%(game:HttpGet%(") == 3,
        "three mutable external UI libraries are loaded, found "
        .. count("loadstring%(game:HttpGet%("))
    check(has("Additional/Linoria.lua") and has("Additional/SaveManager.lua"),
        "the Linoria suite URLs are visible")
end


local function mm2()
    check(has('GetAttribute("MapID")'), "MM2 map lookup by MapID attribute survived")
    check(has('"CoinContainer"'), "coin container lookup survived")
    check(has('"GunDropHighlight"'), "gun drop highlight survived")
    check(has("function CreateHighlight(") and has("function UpdateHighlights()"),
        "role ESP helpers survived")
    check(has('"Sheriff"') and has('"Murderer"'), "role names survived")
    check(has("getPlayerLevel:InvokeServer(") and has('"GetPlayerData"'),
        "MM2 data remotes survived")
    check(has("function miniFling(") and has('"Fling murderer"') and has('"Fling sheriff"'),
        "fling helpers and toggles survived")
    check(has("function startFly()") and has("function stopFly()"), "fly survived")
    check(has("_G.SetFullBright("), "fullbright toggle survived")
    check(has('"Auto grab gun"') and has('"Coin farm speed"'), "farm toggles survived")
    check(has('SavedWebhookUrl = ""') and has("WebhookEnabled = false"),
        "the webhook is empty and disabled by default")
    check(has("WindUI/releases/latest/download/main.lua") and has("AdvancedUtils.lua"),
        "both mutable external dependencies are visible")
end

local CASES = { slapbattles = slapbattles, prisonlife = prisonlife, pizzaplace = pizzaplace,
                mm2 = mm2 }
local TITLES = {
    slapbattles = "Slap Battles",
    prisonlife = "Prison Life",
    pizzaplace = "Work at a Pizza Place",
    mm2 = "Murder Mystery 2",
}

local case = arg[2]
if not case then
    if has("workspace.Arena") then
        case = "slapbattles"
    elseif has("workspace.Prison_ITEMS") then
        case = "prisonlife"
    elseif has('GetAttribute("MapID")') then
        case = "mm2"
    else
        case = "pizzaplace"
    end
end
local run = assert(CASES[case], "unknown case: " .. tostring(case))

common()
run()

print(string.format("OK %s: %d static assertions on the recovered body; "
    .. "compiles as Lua 5.1, nothing executed, no Roblox", TITLES[case], checks))
