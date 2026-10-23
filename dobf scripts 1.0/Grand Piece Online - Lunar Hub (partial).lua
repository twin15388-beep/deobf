-- Grand Piece Online / Lunar Hub FREE: ЧАСТИЧНОЕ восстановление PSU 4.0.A.
-- Защищённый вход: c0deblox/Scripts:GPO.lua, commit 472dc5871faae68dfcfbba6485a619275063ee16.
-- Это не исходник автора 1:1 и НЕ полноценный исполняемый Lunar Hub.
-- Из поднятого Lua 5.1 bytecode вручную выделены только проверяемые фрагменты:
-- таблицы главного прототипа, #9/#11/#12 (движение), #17/#18 (урон),
-- #19/#20 (NPC), #22/#23 (подход к NPC), #31 (квест),
-- #72 (цикл покупки/продажи бочки из исправленного PSU-лифта), #90 (лёд).
-- Переименования локальных переменных и оболочка return {} добавлены для чтения.
-- В оригинале функции были частью большого UI и автофарма. Здесь они ничего не
-- запускают сами по себе. В teleportNumeric НЕ восстановлены входы userdata/CFrame
-- и ветка noclip; в Quest используются только числовые координаты.
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

-- Прототип #9: время движения до x, y, z в студах. Если x — userdata
-- (например, Roblox CFrame), берутся его X, Y, Z, как в исходном байткоде.
-- Используется _G.speed (175 в инициализации хаба); модуль его не устанавливает.
local function calculateTime(x, y, z)
    if type(x) == "userdata" then
        x, y, z = x.X, x.Y, x.Z
    end
    local current = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local duration = (Vector3.new(x, y, z)
        - Vector3.new(current.X, current.Y, current.Z)).Magnitude / _G.speed
    if tostring(duration):find("-") then
        duration = math.abs(duration)
    end
    return duration
end

-- Прототип #11: расстояние между двумя точками / _G.speed. Первая или
-- вторая точка может быть userdata-CFrame; её X/Y/Z подменяют числа.
-- Переданные после шестого аргумента компоненты поворота не используются.
local function calculateFromTo(fromX, fromY, fromZ, toX, toY, toZ)
    if type(fromX) == "userdata" then
        fromX, fromY, fromZ = fromX.X, fromX.Y, fromX.Z
    end
    if type(toX) == "userdata" then
        toX, toY, toZ = toX.X, toX.Y, toX.Z
    end
    local duration = (Vector3.new(fromX, fromY, fromZ)
        - Vector3.new(toX, toY, toZ)).Magnitude / _G.speed
    if tostring(duration):find("-") then
        duration = math.abs(duration)
    end
    return duration
end

-- Прототип #12: вручную выделен ТОЛЬКО маршрут (number, number, number),
-- когда getgenv().noclip == false. Оригинал поддерживает и userdata/CFrame
-- через components(), но там у декомпиляторов остались неоднозначные open-pack.
-- Для длинного пути (>1000 студов) и высоты >10 сначала спускает Position к
-- Y=0, затем двигает HumanoidRootPart.CFrame к координатам назначения.
-- Возвращает tween, duration. spawn и TweenService используются только при вызове.
local function teleportNumeric(x, y, z)
    if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
        error("teleportNumeric: only numeric coordinates were recovered", 2)
    end
    if getgenv().noclip then
        error("teleportNumeric: noclip branch was not recovered", 2)
    end
    local duration = calculateTime(x, y, z)
    _G.teleporting = true
    spawn(function()
        while _G.teleporting == true do
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(14)
        end
    end)

    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    local current = root.Position
    local distance = (Vector3.new(x, y, z)
        - Vector3.new(current.X, current.Y, current.Z)).Magnitude
    if distance > 1000 and current.Y > 10 then
        local lowerY = current.Y - current.Y -- 0 в поднятом байткоде
        local lowerTween = game:GetService("TweenService"):Create(root,
            TweenInfo.new(calculateTime(current.X, lowerY, current.Z),
                Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            { Position = Vector3.new(current.X, lowerY, current.Z) })
        lowerTween:Play()
        lowerTween.Completed:wait()
    end

    local tween = game:GetService("TweenService"):Create(root,
        TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        { CFrame = CFrame.new(x, y, z) })
    tween:Play()
    tween.Completed:Wait()
    _G.teleporting = false
    return tween, duration
end

-- Прототипы #22/#23, вызываются из НЕ восстановленного цикла AutoFarmNPC (#84).
-- targetNpc: модель NPC с Head.CFrame и HumanoidRootPart.CFrame.lookVector.
-- Цель Tween: 3 студа выше головы и 5 позади направления взгляда NPC.
-- Оригинальный upvalue LocalPlayer заменён явным game.Players.LocalPlayer.
-- Здесь нет цикла, выбора NPC, атаки или решения, когда нужен новый квест.
local function tweenAboveNpc(targetNpc)
    local duration = calculateTime(targetNpc.HumanoidRootPart.CFrame)
    _G.teleporting = true
    spawn(function()
        while _G.teleporting == true do
            wait(2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end)

    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    local goal = targetNpc.Head.CFrame + Vector3.new(0, 3, 0)
        + targetNpc.HumanoidRootPart.CFrame.lookVector * -5
    local tween = game:GetService("TweenService"):Create(root, TweenInfo.new(duration),
        { CFrame = goal })
    tween:Play()
    tween.Completed:Wait()
    _G.teleporting = false
    return tween
end

-- Прототип #31. npcName: ключ Quest/QuestPos (например, "Bandit").
-- В оригинале вызывается глобальная teleport(x,y,z); здесь ей соответствует
-- ТОЛЬКО восстановленный числовой путь без noclip. Нет QuestPos для трёх боссов.
local function takeQuest(npcName)
    if npcName ~= "None" then
        local questName = Quest[npcName]
        local position = QuestPos[npcName]
        teleportNumeric(position.X, position.Y, position.Z)
        game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest", questName})
    end
end

-- Прототип #72: игровой цикл покупки и продажи бочек Normal.
-- enabled — значение исходного UI-переключателя. deps.banner({Text=...})
-- заменяет UI-upvalue; deps.teleport опционально подменяет перемещение.
-- Без него используется teleportNumeric: только 3 координаты, noclip=false.
-- В поднятом прототипе #12 лишние 9 компонентов поворота игнорируются.
-- getgenv().good должен быть заранее инициализирован в false (как в хабе).
-- Пока ON=true цикл неограничен; в тестах wait() отключает ON за один проход.
-- Эти действия восстановлены из *исправленного* PSU-лифта, не из живого Roblox.
local function normalBarrelLoop(enabled, deps)
    local move = deps.teleport or teleportNumeric
    getgenv().ON = enabled
    local rootFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local firstTime = math.floor(calculateFromTo(rootFrame, 0, 0,
        -561.834045, 11.9474373, -4466.64453))
    local secondTime = math.floor(calculateFromTo(
        -561.834045, 11.9474373, -4466.64453,
        -4497.41309, 5.98184872, -2668.52979))
    local estimate = math.floor(firstTime + secondTime)
    if getgenv().ON == true then
        deps.banner({Text = ("It will take %s seconds to purchase and sell 1 barrel.")
            :format(estimate)})
    end

    while getgenv().ON do
        wait()
        if getgenv().good == false then
            getgenv().good = true
            local _, travelTime = move(
                -561.834045, 11.9474373, -4466.64453,
                0.0234939456, -5.12754212e-8, -0.999723971,
                -3.6866743e-9, 1, -5.13762188e-8,
                0.999723971, 4.8926867e-9, 0.0234939456)
            wait(travelTime)
            wait(1)
            game:GetService("ReplicatedStorage").Events.Barrel:FireServer({
                action = "Buy", barrelType = "Normal",
            })

            local _, returnTime = move(
                -4497.41309, 5.98184872, -2668.52979,
                -0.181074247, -2.66281965e-8, 0.983469486,
                2.14637765e-8, 1, 3.10276356e-8,
                -0.983469486, 2.67272782e-8, -0.181074247)
            wait(returnTime)
            wait(1)
            warn("soldd")
            game:GetService("ReplicatedStorage").Events.Barrel:FireServer({
                action = "Sell", barrelType = "Normal",
            })
            getgenv().good = false
        end
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
    calculateTime = calculateTime,
    calculateFromTo = calculateFromTo,
    teleportNumeric = teleportNumeric,
    tweenAboveNpc = tweenAboveNpc,
    takeQuest = takeQuest,
    normalBarrelLoop = normalBarrelLoop,
    damageNpc = damageNpc,
    hieWaterTouch = hieWaterTouch,
}
