-- Static assertions over the RECOVERED Jujutsu Shenanigans body.
--
-- This is NOT a behavioural mock test and it does not claim one: the recovered
-- top level instantiates dozens of Roblox types (ColorSequence, NumberRange,
-- RaycastParams, TweenService, Debris, Stats, ...), spawns unbounded loops and
-- needs executor APIs (writefile/getcustomasset), so a hand-written mock would
-- mostly exercise the mock. What is checked here is (a) that the recovered body
-- still compiles as Lua 5.1 and (b) that its game-facing structure survived the
-- decode. The protected input is never read, parsed or executed.
-- Lua 5.1: lua5.1 tests/test_jjs_sonic_static.lua 'dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua'
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

-- (a) The body is still valid Lua 5.1; loadstring compiles without running it.
local chunk, syntaxError = loadstring(body)
check(chunk ~= nil, "recovered body must compile as Lua 5.1: " .. tostring(syntaxError))

-- (b) Game-facing structure: JJS Knit services, not generic UI code.
check(body:find("Knit.Knit.Services.CursoryImpactService.RE.Activated", 1, true) ~= nil,
      "CursoryImpact remote path recovered")
check(body:find("Knit.Knit.Services.NaoyaService.RE.RightActivated", 1, true) ~= nil,
      "Naoya right-attack remote path recovered")
check(body:find("Knit.Knit.Services.JoinService.RE.Talk", 1, true) ~= nil,
      "voice/talk remote path recovered")
check(count('GetAttribute%("Moveset"%) ~= "Naoya"') >= 3,
      "every handler stays gated on the Naoya moveset")
check(body:find('workspace:WaitForChild("Characters")', 1, true) ~= nil,
      "target scan uses workspace.Characters")
check(body:find('"Pin"', 1, true) ~= nil and body:find('"GreenPin"', 1, true) ~= nil,
      "target weighting keeps Pin/GreenPin modifiers")
check(body:find("* 0.75", 1, true) ~= nil and body:find("* 1.25", 1, true) ~= nil,
      "pin weighting factors survived")

-- Moveset content: the four renamed skills plus the passive Extender slot.
for _, skill in ipairs({"Mach Breaker", "Strike Of The Wind", "Sonic Wind", "Extender"}) do
    check(body:find('"' .. skill .. '"', 1, true) ~= nil, "skill slot renamed: " .. skill)
end
check(body:find('SetAttribute("Key", 9)', 1, true) ~= nil, "Extender keeps its keybind slot")
check(body:find('SetAttribute("Tip", "PASSIVE")', 1, true) ~= nil, "Extender stays passive")
check(body:find("workspace.Gravity = 170", 1, true) ~= nil, "custom gravity is applied")
check(body:find("HipHeight = 0.05", 1, true) ~= nil, "character scaling is adjusted")

-- Keybinds the script binds, and the movement state machine constants.
for _, key in ipairs({"Space", "T", "Q", "Y", "C", "One", "Two", "Three", "Four", "L"}) do
    check(body:find("Enum.KeyCode." .. key, 1, true) ~= nil, "keybind recovered: " .. key)
end
check(body:find("v73 = 66", 1, true) ~= nil, "base WalkSpeed constant recovered")
check(body:find("v73 * 0.5", 1, true) ~= nil, "stunned WalkSpeed halving recovered")
check(body:find("f16(v9, 120) or f16(v9, 144)", 1, true) ~= nil,
      "speed branches recovered")

-- Assets and executor surface that a user must know about before running it.
check(count("rbxassetid://") == 8, "eight rbxassetid sounds/animations, found "
      .. count("rbxassetid://"))
check(body:find("https://github.com/CelerityRBLX/Roblox/raw/refs/heads/main/wontstopjustgo.mp3",
      1, true) ~= nil, "the mutable mp3 download is visible")
check(body:find("getcustomasset(", 1, true) ~= nil, "executor asset API is used")
check(body:find("writefile(", 1, true) ~= nil, "executor file API is used")
check(body:find("loadstring(", 1, true) == nil, "no loadstring remains in the body")
check(body:find("pastefy.app", 1, true) == nil, "no prohibited loader host")

print(string.format("OK Jujutsu Shenanigans: %d static assertions on the recovered body; "
    .. "compiles as Lua 5.1, nothing executed, no Roblox", checks))
