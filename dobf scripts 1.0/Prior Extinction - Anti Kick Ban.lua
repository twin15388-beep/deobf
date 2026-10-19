-- STATIC RECOVERY: Base36/LZW/XOR -> VM instruction lift -> Lua 5.1 decompile.
-- Original file: https://github.com/DohmBoyOG/Script-Dump/blob/da2dea31c28d620a85111a8f9cc1bd776141eb91/PriorExtinction_AntiBanKick_Probably_OBed.lua
-- Role label chosen by analyst (not recovered original name): guardNamecall(self, ...) — anonymous newcclosure callback
-- Syntax checked with Lua 5.1; NOT executed or validated in Roblox.
-- Caveat: Lua operator precedence makes FireServer apply only to KickPlayer.
-- file: @PriorExtinction_AntiBanKick_Probably_OBed_static
-- dialect: lua5.1
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local r0_0 = getrawmetatable(game)
local r0_1 = r0_0.__namecall
setreadonly(r0_0, false)
r0_0.__namecall = newcclosure(function(p1_0, ...) -- proto#1 params=1 locals=3 upvalues=1 vararg=true source=@PriorExtinction_AntiBanKick_Probably_OBed_static:proto0
    local r1_0 = { ... }
    if not (getnamecallmethod() == "FireServer" and p1_0.Name == "KickPlayer"
        or p1_0.Name == "Ban"
        or p1_0.Name == "ServerBan"
        or p1_0.Name == "Teleport") then
        local r1_1 = r0_1
        local r1_2 = p1_0
        return r1_1(r1_2, ...)
    end
    print("Someone tried to kick or ban us!")
    return 9000000000
end)
setreadonly(r0_0, true)
print("Anti Kick/Ban Loaded, Pray that it works!")
