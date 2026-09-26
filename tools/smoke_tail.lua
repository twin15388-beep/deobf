
-- ---------------------------------------------------------------------------
-- Дымовой тест: Boot с фальшивой библиотекой UI + вызовы ключевых функций
-- ---------------------------------------------------------------------------
print("[smoke] сборка загружена без ошибок")
print("[probe] type(cKb)=", type(cKb), "type(bnB)=", type(bnB), "type(bno)=", type(bno),
      "type(bny)=", type(bny), "type(bn8)=", type(bn8))
print("[probe] Core.CanAct=", type(__RECON and nil), type(rawget(__RECON.Core, "CanAct")),
      "Core.bny=", type(rawget(__RECON.Core, "bny")), "Core.Signal=", type(rawget(__RECON.Core, "Signal")))
print("[probe] cKb[9]=", type(cKb[9]), "cKb[124]=", type(cKb[124]), "cKb[131]=", type(cKb[131]))
print("[smoke] слотов в cKb:", (function() local n = 0 for _ in pairs(cKb) do n = n + 1 end return n end)())

local M = __RECON

local fake_library = setmetatable({
    Toggles = { HideUiOnStart = { Value = false } },
    Values = {},
}, { __index = function(_, key)
        local child = LIBRARY_STUB[key]
        return child
    end })

local ok, result = pcall(function() return M.Boot({ library = fake_library }) end)
print("[smoke] Boot:", ok, tostring(result))

local ok2, err2 = pcall(function()
    return M.Farm.QuestStep()
end)
print("[smoke] Farm.QuestStep:", ok2, tostring(err2))

local ok3, err3 = pcall(function()
    return M.Combat.CombatTick()
end)
print("[smoke] Combat.CombatTick:", ok3, tostring(err3))

local ok4, err4 = pcall(function()
    return M.Skills.SkillStep()
end)
print("[smoke] Skills.SkillStep:", ok4, tostring(err4))

local ok5, err5 = pcall(function()
    return M.Equip.EquipStep()
end)
print("[smoke] Equip.EquipStep:", ok5, tostring(err5))

local ok6, err6 = pcall(function()
    return M.Parry.BlockTick()
end)
print("[smoke] Parry.BlockTick:", ok6, tostring(err6))

local ok7, err7 = pcall(function()
    return M.Move.Reach(Vector3.new(1, 2, 3), 0.1, function() return true end)
end)
print("[smoke] Move.Reach:", ok7, tostring(err7))

local ok8, err8 = pcall(function()
    return M.Config.Import("{ not json", services.HttpService, print, function() return false end,
                           function() end, function() end)
end)
print("[smoke] Config.Import(bad):", ok8, tostring(err8))
