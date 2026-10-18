-- ЗАЯВЛЕННАЯ ИГРА: Grand Piece Online; исходник SeaHubCrackGPO.lua.
-- Частичная СТАТИЧЕСКАЯ декомпиляция PSU 4.5.A -> Lua 5.1 bytecode.
-- ЭКВИВАЛЕНТНОСТЬ, назначение payload и работоспособность НЕ ПОДТВЕРЖДЕНЫ.
-- НЕ ЗАПУСКАТЬ: код может вызывать Roblox remotes; Lua-пейлоад не исполнялся.

-- file: @psu
-- dialect: lua5.1
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local function r0_0(...) -- proto#1 params=0 locals=0 upvalues=0 vararg=true source=@psu
    return ...
end

local r0_1 = 2000
local r0_2 = {
    "DefaultChatSystemChatEvents", "secrun", "is_beta", "secure_call", "cache_replace",
    "get_thread_identity", "request", "protect_gui", "run_secure_lua", "cache_invalidate",
    "queue_on_teleport", "is_cached", "set_thread_identity", "write_clipboard",
    "run_secure_function", "crypto", "websocket", "unprotect_gui", "create_secure_function", "crypt",
    "syn", "request", "SayMessageRequest", "FireServer", "InvokeServer", "tick", "pcall", "spawn",
    "print", "warn", "game", "GetService", "getgc", "getreg", "getrenv", "getgenv", "debug",
    "require", "ModuleScript", "LocalScript", "GetChildren", "GetDescendants", "function",
    "settings", "GameSettings", "RenderSettings", "string", "sub", "service", "IsA", "Parent",
    "Name", "RunService", "Stepped", "wait", "Changed", "FindFirstChild", "Terrain", "Lighting",
    "Enabled", "getconnections", "firesignal", "workspace", "true", "false", "tostring", "table",
    "math", "random", "floor", "Humanoid", "Character", "FederalWasHereAttribute", "LocalPlayer",
    "plr", "Players", "Player", "WalkSpeed", "Enum", "KeyCode", "_G", "BreakJoints", "Health",
    "Chatted", "RemoteEvent", "RemoteFunction", "getrawmetatable", "make_writable", "setreadonly",
    "PointsService", "JointsService", "VRService", "Ragdoll", "SimulationRadiusLocaleId",
    "gethiddenproperty", "sethiddenproperty", "syn", "Zombies", "GameId", "JobId", "Tool",
    "Accessory", "RightGrip", "Weld", "HumanoidRootPart", "GuiService", "CoreGui", "BindableEvent",
    "fire", "BodyForce", "Chat", "PlayerGui", "NetworkMarker", "Geometry", "TextService",
    "LogService", "error", "LuaSettings", "UserInputService", "fireclickdetector", "Trail", "Camera",
    "CurrentCamera", "FOV", "Path", "InputObject", "Frame", "TextBox", "ScreenGui", "hookfunction",
    "Debris", "ReplicatedStorage", "ReplicatedFirst", "decompile", "saveinstance", "TweenService",
    "SoundService", "Teams", "Tween", "BasePart", "Seat", "Decal", "Instance", "new", "Ray",
    "TweenInfo", "Color3", "CFrame", "Vector3", "Vector2", "UDim", "UDim2", "NumberRange",
    "NumberSequence", "Handle", "Gravity", "HopperBin", "Shirt", "Pants", "Mouse", "IntValue",
    "StringValue", "Value", "VirtualUser", "MouseButton1Click", "Activated", "FileMesh",
    "TeleportService", "Teleport", "userdata", "string", "int", "number", "bool", "BodyGyro",
    "Backpack", "SkateboardPlatform", "FilteringEnabled", "Shoot", "Shell", "Asset", "checkifgay",
    "create", "god", "BrianSucksVexu", "checkifalive", "getteams", "getnearest", "getcross",
    "autoshoot", "chatspam", "changeupvalues", "modifyguns", "infammo", "godmode", "aimbot", "esp",
    "crashserver", "antiaim", "usertype", "type"
}
local r0_3 = {}
for r0_4 = 1, r0_1 do
    table.insert(r0_3, "FLupsUeaz = '" .. tostring(r0_2[math.random(1, #r0_2)]) .. "'")
end
table.concat(r0_3, "\n")
local r0_5 = "fire"
local r0_6 = {
    Start = CFrame.new(0, 0, 0), Gun = "Rifle", ["Lon rua handicap"] = "true",
    Position = Vector3.new(0, 0, 0)
}
for r0_7 = 1, 10 do
    game:GetService("ReplicatedStorage").Events.CIcklcon:FireServer(r0_5, r0_6)
end
while wait() do
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
