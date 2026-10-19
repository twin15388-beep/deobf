-- Grand Piece Online / Lunar Hub FREE: ЧАСТИЧНОЕ восстановление PSU 4.0.A.
-- Защищённый вход: c0deblox/Scripts:GPO.lua, commit 472dc5871faae68dfcfbba6485a619275063ee16.
-- Это не исходник автора 1:1 и НЕ полноценный исполняемый Lunar Hub.
-- Из поднятого Lua 5.1 bytecode вручную выделены только проверяемые фрагменты:
-- главный прототип (таблицы), #17/#18 (урон), #19/#20 (NPC), #31 (квест), #90 (лёд).
-- Переименования локальных переменных и оболочка return {} добавлены для чтения.
-- В оригинале функции были частью большого UI и автофарма. Здесь они ничего не
-- запускают сами по себе. teleport() принадлежит НЕ восстановленной части хаба.
-- Нельзя считать Lua 5.1/Luau-компиляцию доказательством работы в живой игре.

local Quest = {
    Bandit = "Help Raphtalia",
    ["Bandit Boss"] = "Help Ronny",
    ["Desert Bandit"] = "Help Noah",
    Lucid = "Take down Lucid",
    ["Corrupt Marine"] = "Help Robert",
    ["Axe Hand Logan"] = "Serve Justice",
    ["Zou Inhabitant"] = "Help Zen",
    ["Krieg Pirate"] = "Help Rice",
    Buggy = "Help Nami",
    Monkey = "Help gonny",
    ["Gorilla King"] = "Help max",
}

-- Координаты перенесены из восстановленной таблицы без округления.
-- В оригинале нет QuestPos для Bandit Boss, Axe Hand Logan, Gorilla King:
-- takeQuest() для них без дополнительной логики вызовет ошибку обращения к nil.
local QuestPos = {
    Bandit = CFrame.new(1014.99664, 8.99998856, 1227.58508,
        -0.992317319, -0.000052314288, 0.123718798,
        -0.0000640122817, 1, -0.0000905780398,
        -0.123718791, -0.000097801676, -0.992317319),
    ["Desert Bandit"] = CFrame.new(-1403.57751, 10.4286785, 1120.92944,
        -0.118798777, 9.54868113e-8, 0.992918372,
        -7.45614626e-10, 1, -9.62570468e-8,
        -0.992918372, -1.21755539e-8, -0.118798777),
    Lucid = CFrame.new(-1391.28723, 10.4348574, 1219.97644,
        -0.972531736, 0.0000116513738, 0.232770488,
        0.00000634778144, 1, -0.0000235337175,
        -0.232770488, -0.0000214097072, -0.972531736),
    ["Corrupt Marine"] = CFrame.new(-707.784302, 10.9474649, -4494.29346,
        0.975640655, 4.06419929e-8, 0.219374746,
        -4.49203164e-8, 1, 1.45144048e-8,
        -0.219374746, -2.40152271e-8, 0.975640655),
    ["Zou Inhabitant"] = CFrame.new(-4453.12598, 6.99241638, -2528.52344,
        0.0694791302, -0.000076478711, 0.997583151,
        1.23372059e-8, 1, 0.0000766631128,
        -0.997583151, -0.00000531418436, 0.0694791302),
    ["Krieg Pirate"] = CFrame.new(-3906.3689, 6.31296635, -5518.6377,
        0.994920433, -0.00000344777436, -0.100662626,
        0.0000127579806, 1, 0.0000918457154,
        0.100662626, -0.0000926634457, 0.994920433),
    Buggy = CFrame.new(-7107.16602, 6.30073881, -5382.53418,
        0.99388504, -0.000462164578, -0.110417411,
        0.000359227299, 0.999999464, -0.000952147122,
        0.110417828, 0.000906659639, 0.993884683),
    Monkey = CFrame.new(-6552.78174, 42.1655617, -9922.64453,
        0.851197243, -2.34630644e-8, -0.524845958,
        -3.22979332e-8, 1, -9.70855893e-8,
        0.524845958, 9.9590423e-8, 0.851197243),
}

-- Прототип #19. npcName: подстрока имени NPC, string.find использует Lua-паттерн.
-- При нескольких подходящих NPC выбирается ближайший к LocalPlayer.
local function nearestNpc(npcName)
    local bestDistance = math.huge
    local nearest = nil
    for _, npc in next, workspace.NPCs:GetChildren() do
        if npc.Name:find(npcName) and npc:FindFirstChildWhichIsA("Humanoid") then
            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                - npc.HumanoidRootPart.Position).Magnitude
            if distance < bestDistance then
                bestDistance, nearest = distance, npc
            end
        end
    end
    return nearest
end

-- Прототип #20. excludedName: точное имя NPC, который не должен попадать в выбор.
local function nearestNpcExcept(npcName, excludedName)
    local bestDistance = math.huge
    local nearest = nil
    for _, npc in next, workspace.NPCs:GetChildren() do
        if npc.Name:find(npcName)
            and npc:FindFirstChildWhichIsA("Humanoid")
            and npc.Name ~= excludedName then
            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                - npc.HumanoidRootPart.Position).Magnitude
            if distance < bestDistance then
                bestDistance, nearest = distance, npc
            end
        end
    end
    return nearest
end

-- Прототип #31. npcName: ключ Quest/QuestPos (например, "Bandit").
-- Требует глобальную teleport(x, y, z) из полного хаба: она здесь не восстановлена.
local function takeQuest(npcName)
    if npcName ~= "None" then
        local questName = Quest[npcName]
        local position = QuestPos[npcName]
        teleport(position.X, position.Y, position.Z)
        game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest", questName})
    end
end

-- Прототипы #17/#18. targetNpc: модель NPC; selectedWeapon: текст UI.
-- Katana/Kiribachi -> Sword, Black Leg -> BlackLeg; отправляется пять ударов.
local function damageNpc(targetNpc, selectedWeapon)
    selectedWeapon = selectedWeapon == "Katana" and "Sword"
        or selectedWeapon == "Melee" and "Melee"
        or selectedWeapon == "Black Leg" and "BlackLeg"
        or selectedWeapon == "Kiribachi" and "Sword"
        or selectedWeapon
    for strike = 1, 5 do
        spawn(function()
            game:GetService("ReplicatedStorage").Events.CombatRegister:InvokeServer({
                "damage", targetNpc.HumanoidRootPart, selectedWeapon,
                {strike, "Ground", selectedWeapon},
            })
        end)
    end
end

-- Прототип #90: тело обработчика Touched для способности фрукта Hie-Hie.
-- foot: объект, коснувшийся воды; подписка на Water.Touched была в UI-части
-- полного хаба и в этот фрагмент намеренно не скопирована.
local function hieWaterTouch(foot)
    if (foot.Name == "LeftFoot" or foot.Name == "RightFoot")
        and _G.WalkOnWater == "Hie-Hie" and _G.WalkOnWater ~= nil then
        local ice = game.Players.LocalPlayer.Backpack:FindFirstChild("WaterLogia")["Hie-Hie"].floor:Clone()
        ice.Parent = workspace
        game.Debris:AddItem(ice, 5)
        ice.Position = Vector3.new(foot.Position.X, workspace.Effects.Water.Position.Y - 1.5,
            foot.Position.Z)
        ice.Rotation = Vector3.new(0, math.random(0, 180), 0)
        ice.Size = Vector3.new(ice.Size.X, ice.Size.Y + 5, ice.Size.Z)
        spawn(function()
            wait(0.5)
            ice.sm2:Destroy()
            ice.sm3:Destroy()
        end)
    end
end

-- return-оболочка нужна только для безопасного изучения фрагментов как модуля.
-- Оригинальный GPO-скрипт НЕ возвращал эту таблицу и имел дополнительные функции.
return {
    Quest = Quest,
    QuestPos = QuestPos,
    nearestNpc = nearestNpc,
    nearestNpcExcept = nearestNpcExcept,
    takeQuest = takeQuest,
    damageNpc = damageNpc,
    hieWaterTouch = hieWaterTouch,
}
