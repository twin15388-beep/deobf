-- STATIC RECOVERY: Base36/LZW/XOR -> VM instruction lift -> Lua 5.1 decompile.
-- Original file: https://github.com/DohmBoyOG/Script-Dump/blob/da2dea31c28d620a85111a8f9cc1bd776141eb91/NerfFPS_546_TDM_KillALL_OBED.lua
-- Role label chosen by analyst (not recovered original name): main chunk (no original user-defined function; two loops, repeat/until)
-- Syntax checked with Lua 5.1; NOT executed or validated in Roblox.
-- file: @NerfFPS_546_TDM_KillALL_OBED_static
-- dialect: lua5.1
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local r0_0 = game:GetService("ReplicatedStorage").sumiisbestgirl
local r0_1 = game:GetService("Players").LocalPlayer
local r0_2 = game:GetService("Players"):GetPlayers()
local r0_3 = {}
for r0_4, r0_5 in pairs(r0_2) do
    if r0_5.TeamColor ~= r0_1.TeamColor and r0_5 ~= r0_1 then
        table.insert(r0_3, r0_5)
    end
end
for r0_6, r0_7 in pairs(r0_3) do
    print(#r0_3)
    print("[Current Target]: " .. r0_7.name)
    local r0_8
    repeat
        wait(1)
        r0_0:FireServer(149306230, r0_7.Character, 100, "VULCAN", false)
        local r0_9 = print
        local r0_10 = r0_7.Character.Humanoid.Health
        local r0_11 = "[Targets Heath] " .. r0_10
        r0_10 = nil
        r0_9(r0_11)
        r0_8 = r0_7.Character.Humanoid.Died
    until r0_8
    local r0_12 = print
    local r0_13 = r0_7.name
    local r0_14 = "Target " .. "[" .. r0_13 .. "]" .. " Elimated"
    r0_13 = nil
    r0_12(r0_14)
end
