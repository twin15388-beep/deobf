-- STATIC RECOVERY: Base36/LZW/XOR -> VM instruction lift -> Lua 5.1 decompile.
-- Original file: https://github.com/DohmBoyOG/Script-Dump/blob/da2dea31c28d620a85111a8f9cc1bd776141eb91/GodOfGlory_DestroyWorld_OBED.lua
-- Role label chosen by analyst (not recovered original name): destroyWorldDestructibles() — anonymous spawn callback, 0 params
-- Syntax checked with Lua 5.1; NOT executed or validated in Roblox.
-- file: @GodOfGlory_DestroyWorld_OBED_static
-- dialect: lua5.1
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local r0_0 = game
local r0_1 = r0_0:GetService("Workspace")
r0_1 = r0_1.GameWorlds.NormalWorlds
worlds = r0_1
r0_1 = game
local r0_2 = r0_1
r0_1 = r0_2.GetService
r0_1 = r0_1(r0_2, "ReplicatedStorage")
r0_1 = r0_1.Remotes.BreakBuilding
remote = r0_1
r0_1 = game
r0_2 = r0_1
r0_1 = r0_2.GetService
r0_1 = r0_1(r0_2, "Workspace")
r0_1 = r0_1.StreamingEnabled
if r0_1 == true then
    local r0_3 = game:GetService("Workspace")
    r0_3.StreamingEnabled = false
end
spawn(function() -- proto#1 params=0 locals=16 upvalues=0 vararg=false source=@GodOfGlory_DestroyWorld_OBED_static:proto0
    local r1_0 = pairs
    local r1_1 = worlds
    for r1_2, r1_3 in r1_0(r1_1:GetChildren()) do
        if r1_3:IsA("Folder") then
            for r1_4, r1_5 in pairs(r1_3:GetDescendants()) do
                if r1_5:IsA("Folder") and r1_5.Name == "Destructibles" then
                    for r1_6, r1_7 in pairs(r1_5:GetChildren()) do
                        local r1_8 = remote
                        local r1_9 = r1_8.FireServer
                        local r1_10 = {}
                        local r1_11 = tostring
                        r1_11 = r1_11(r1_7:GetFullName())
                        r1_10.TagFullName = r1_11
                        r1_11 = nil
                        r1_9(r1_8, r1_10)
                    end
                    print("Destruction Loop Done")
                end
            end
        end
    end
end)
