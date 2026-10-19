-- STATIC RECOVERY: Base36/LZW/XOR -> VM instruction lift -> Lua 5.1 decompile.
-- Original file: https://github.com/DohmBoyOG/Script-Dump/blob/da2dea31c28d620a85111a8f9cc1bd776141eb91/NerfFPS_546_INFMONIES_OBED.lua
-- Role label chosen by analyst (not recovered original name): blockSubCash(self, ...) — anonymous newcclosure callback
-- Syntax checked with Lua 5.1; NOT executed or validated in Roblox.
-- file: @NerfFPS_546_INFMONIES_OBED_static
-- dialect: lua5.1
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local r0_0 = game:GetService("Players").LocalPlayer.leaderstats
for r0_1, r0_2 in pairs(r0_0:GetChildren()) do
    if r0_2:IsA("NumberValue") and r0_2.name == "CashMoney" then
        r0_2.Value = 9000000000
    end
end
local r0_3 = getrawmetatable(game)
local r0_4 = r0_3.__namecall
setreadonly(r0_3, false)
r0_3.__namecall = newcclosure(function(p1_0, ...) -- proto#1 params=1 locals=4 upvalues=1 vararg=true source=@NerfFPS_546_INFMONIES_OBED_static:proto0
    local r1_0 = { ... }
    local r1_1 = getnamecallmethod()
    if r1_1 == "FireServer" and p1_0.Name == "SubCash" then
        print("Trying to take cash from me NO!")
        return nil
    end
    local r1_2 = r0_4
    local r1_3 = p1_0
    return r1_2(r1_3, ...)
end)
setreadonly(r0_3, true)
