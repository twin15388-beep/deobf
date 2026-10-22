-- All Star Tower Defense / Assasine03 Autofarm: ЧАСТИЧНОЕ восстановление PSU.
-- Вход: c0deblox/Scripts:ASTD.lua, commit 472dc5871faae68dfcfbba6485a619275063ee16.
-- Только выбранные действия из Lua 5.1 bytecode (#18, #19/#21, #22, #23).
-- Файл НЕ является целым автофармом. Полная декомпиляция содержит ошибки.
-- Исходный скрипт запускал циклы и читал флаги UI: здесь один явный вызов
-- функции заменяет ОДНУ итерацию действия. Циклы, UI и выбор позиции не включены.
-- Функции переименованы и получили явные параметры; return-оболочка добавлена.
-- Выполнение в Roblox / эквивалентность всей защищённой VM не проверялись.

local function inputRemote()
    return game:GetService("ReplicatedStorage").Remotes.Input
end

-- #19/#21: unitName из выбора юнита, position из НЕ восстановенного здесь
-- расчёта точки размещения (#4). В исходном цикле также проверяли UnitPlaceAble
-- и оборачивали этот вызов в pcall; в выделенном фрагменте этих проверок нет.
local function summonAt(unitName, position)
    if position then
        inputRemote():FireServer("Summon", {
            Rotation = 0,
            cframe = CFrame.new(position.X, position.Y, position.Z),
            Unit = unitName,
        })
    end
end

-- #18: при включённом флаге и достижении порога волны отправляет Sell для
-- КАЖДОГО workspace.Unit; оригинальный обработчик не проверял Owner.
-- enabled: бывший SellWaveTF; selectedWave: бывшее значение SellAtWave.
local function sellAtWave(enabled, selectedWave)
    if enabled == true
        and game:GetService("ReplicatedStorage").WaveValue.Value >= tonumber(selectedWave) then
        for _, unit in pairs(game:GetService("Workspace").Unit:GetChildren()) do
            inputRemote():FireServer("Sell", unit)
        end
    end
end

-- #22: действие над ОДНИМ юнитом; в оригинале #22 перебирал все Unit раз в 3 с.
-- enabled: бывший AutoUpgradeTF; maxUpgrade: бывший MaxUpgrade.
-- Зависимость от флага паузы автофарма r0_68 в выделенную функцию не входит.
local function upgradeOwnedUnit(enabled, unit, maxUpgrade)
    if enabled == true and unit.MaxUpgradeTag.Value ~= unit.UpgradeTag.Value then
        local limit = tonumber(maxUpgrade) or 0
        if unit:FindFirstChild("Owner")
            and unit.Owner.Value == game.Players.LocalPlayer
            and unit.UpgradeTag.Value < limit then
            wait(0.25)
            inputRemote():FireServer("Upgrade", unit)
            wait(0.25)
        end
    end
end

-- #23: один шаг из цикла SkipWaveTF. Проверяет видимость голосования,
-- отправляет VoteWaveConfirm и локально закрывает окно голосования.
local function confirmNextWave(enabled)
    if enabled == true then
        local vote = game:GetService("Players").LocalPlayer.PlayerGui.HUD.NextWaveVote
        if vote.Visible == true then
            wait(1)
            inputRemote():FireServer("VoteWaveConfirm")
            vote.Visible = false
            wait(1)
        end
    end
end

return {
    summonAt = summonAt,
    sellAtWave = sellAtWave,
    upgradeOwnedUnit = upgradeOwnedUnit,
    confirmNextWave = confirmNextWave,
}
