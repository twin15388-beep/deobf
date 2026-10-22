-- Ro-Ghoul Auto Farm: ЧАСТИЧНОЕ восстановление PSU-байткода.
-- Вход: c0deblox/Scripts:Ro-Ghoul.lua, commit 472dc5871faae68dfcfbba6485a619275063ee16.
-- Выбраны таблицы главного прототипа, проверка квеста из #35 и #24/#25
-- (Yoshimura Task / ReputationCashOut). Полный UI и автофарм НЕ восстановлены.
-- Имена функций и дополнительный параметр deps введены для чтения/тестирования:
-- в исходнике #24 получал только shouldTakeQuest и захватывал внешние upvalues.
-- Требует объектов игры, remotes и предоставленной вызывающим кодом функции
-- перемещения moveTo; эта функция здесь НЕ восстановлена. Работа в Roblox
-- и эквивалентность всей защищённой программе не проверены.

local BossRequirements = {
    ["Eto Yoshimura"] = { bool = false, level = 1250 },
    ["Koutarou Amon"] = { bool = false, level = 750 },
    ["Nishiki Nishio"] = { bool = false, level = 250 },
}

local SpawnGroups = {
    ["Aogiri Members"] = "GhoulSpawns",
    Investigators = "CCGSpawns",
    Humans = "HumanSpawns",
}

-- Из условия в #35: если Aogiri Member нет либо прогресс достиг Max,
-- исходный цикл при включённом флаге репутации снова вызывает #24(true).
-- Здесь только проверка, без решения о запуске цикла/перемещении.
local function needsAogiriQuest(player)
    local complete = player.PlayerFolder.CurrentQuest.Complete
    local quest = complete:FindFirstChild("Aogiri Member")
    return not quest or quest.Value == complete["Aogiri Member"].Max.Value
end

-- #24/#25. shouldTakeQuest: true = запрос Aogiri Member; false/nil = обмен
-- репутации. deps содержит status (текстовую метку), moveTo(cframe), remotes,
-- player, questUI {prefix, label}; lastCashOut обновляется при обмене.
-- Оригинал дважды вызывал Yoshimura.Task:InvokeServer() с паузой между ними
-- и подписывался на Changed у счётчика квеста.
local function yoshimuraAction(shouldTakeQuest, deps)
    deps.status.Text = "Moving to quest NPC"
    deps.moveTo(workspace.Anteiku.Yoshimura.HumanoidRootPart.CFrame)
    wait(1.5)
    if shouldTakeQuest then
        deps.status.Text = "Getting quest..."
        deps.remotes.Yoshimura.Task:InvokeServer()
        wait()
        deps.remotes.Yoshimura.Task:InvokeServer()
        local progress = deps.player.PlayerFolder.CurrentQuest.Complete:WaitForChild("Aogiri Member")
        deps.questUI.label.Text = deps.questUI.prefix .. progress.Value .. "/" .. progress.Max.Value
        progress.Changed:connect(function(value)
            deps.questUI.label.Text = deps.questUI.prefix .. value .. "/" .. progress.Max.Value
        end)
    else
        deps.status.Text = "Withdrawing reputation"
        deps.remotes.ReputationCashOut:InvokeServer()
        deps.lastCashOut = tick()
    end
end

return {
    BossRequirements = BossRequirements,
    SpawnGroups = SpawnGroups,
    needsAogiriQuest = needsAogiriQuest,
    yoshimuraAction = yoshimuraAction,
}
