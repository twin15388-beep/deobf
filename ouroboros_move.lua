--[[ ============================================================================
  Ouroboros — ДВИЖОК ПЕРЕМЕЩЕНИЯ: арбитр `bob`, `Reach` (bqd), `MoveTo` (cKb[120])
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; номера строк — по ouroboros_main_pruned.txt.
  Всё вычитано из состояний, а не угадано; спорные места помечены в конце файла.

  Роли слотов (каноническая карта — заголовок второй сборки, см. ROADMAP):
    cKb[9]()    = персонаж (Character)
    cKb[124]()  = Humanoid        (пул 2170: cKb[9]():FindFirstChildOfClass("Humanoid"))
    cKb[145]()  = корневая часть  (пул 5863: HumanoidRootPart; если сам персонаж —
                                   BasePart, возвращается он)
    cKb[97](b)  = переключатель столкновений (inline, копия B @1 941 283):
                                   true  → вернуть сохранённые CanCollide
                                   false → выключить CanCollide у персонажа,
                                           запомнив прежние значения
    cKb[87]()   = отмена текущего перемещения (ниже CancelMove)
    cKb[37]()   = detach переносимой детали (bqn; bny["detach"])
    cKb[86](s)  = ожидание готовности (WaitReady; см. состояния 5671…5679)
    bqd         = Reach(цель, доп. пауза, отмена)
    cKb[120]    = MoveTo(цель, доп. пауза, отмена)
    bpm         = Alive() — пул 796
    bob         = {tween = nil, token = 0} + ARRIVE_RADIUS = 8, BLINK_HOLD = 0.35
    cKb[81]     = настройки: movementMode = "Tween", tweenSpeed = 400,
                  positionType = "Above", lookAtEnemy = true, offset = 3,
                  height = 0, weapon = "", autoSkills = false,
                  skills = {}, holdTimes = {}
    cKb[141]    = константы: ARRIVE_RADIUS = 8, BLINK_HOLD = 0.35 (стр. 21156)
============================================================================ ]]

local CONFIG = {
    positionType = "Above",
    lookAtEnemy = true,
    offset = 3,
    height = 0,
    movementMode = "Tween",       -- "Tween" | "Teleport"
    tweenSpeed = 400,
    weapon = "",
    autoSkills = false,
    skills = {},
    holdTimes = {},
}

-- Арбитр движения: у каждого «поколения» ходьбы свой token; тот, кто видит
-- чужой token, обязан немедленно сдаться (проверки в bqd/MoveTo повсюду).
local bob = {
    tween = nil,
    token = 0,
    ARRIVE_RADIUS = 8,            -- cKb[141]["ARRIVE_RADIUS"] = 8 (стр. 21156)
    BLINK_HOLD = 0.35,            -- cKb[141]["BLINK_HOLD"] = 0.35 (стр. 21157)
}

-- Персонаж: cKb[9] = пул 4555 (`cKb[126]["Character"]`)
local function GetCharacter()                        -- cKb[9]
    return cKb[9]()
end

-- Humanoid: cKb[124] = пул 2170
local function GetHumanoid()                         -- cKb[124]
    local character = cKb[9]()
    if not character then return nil end
    return character:FindFirstChildOfClass("Humanoid")
end

-- Корневая часть (или сам персонаж, если он BasePart): cKb[145] = пул 5863
local function GetRootPart()                         -- cKb[145]
    local character = cKb[9]()
    if not character then return nil end
    if character:IsA("BasePart") then return character end
    return character:FindFirstChild("HumanoidRootPart")
end

-- Жив ли персонаж: bpm = пул 796.
-- Опакованный предикат разрешён точно: для «Humanoid есть» сравнение
-- (1637*2317 + 1474*2351 + 1637*1474) % 16777213 == 9671241 истинно, поэтому
-- реальный код — `if humanoid then return GetRootPart() ~= nil end; return false`
-- (проверка Health > 0 вычисляется, но её результат отбрасывается).
local function Alive()                               -- bpm
    local humanoid = GetHumanoid()
    if humanoid then
        return GetRootPart() ~= nil
    end
    return false
end

-- Переключатель столкновений: cKb[97] (копия B @1 941 283; в копии A тот же
-- код лежит в слоте 145). Семантика выведена из состояний: bmV — карта
-- «часть → прежнее CanCollide».
local savedCollide = {}                              -- bmV (setmetatable({}, {__mode = "k"}))
local function SetCollide(enabled)                   -- cKb[97]
    if enabled then
        -- Возврат прежних значений: bmV = {часть → CanCollide}
        for part, was in pairs(savedCollide) do
            if part["Parent"] then
                pcall(function() part["CanCollide"] = was end)
                savedCollide[part] = nil
            end
        end
        return
    end
    -- Выключение: у всех BasePart персонажа запоминаем CanCollide и гасим его
    local character = cKb[9]()
    if not character then return end
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") and savedCollide[descendant] == nil then
            savedCollide[descendant] = descendant["CanCollide"]
            descendant["CanCollide"] = false
        end
    end
end

-- Отмена текущего перемещения: cKb[87] (стр. 3886).
--   token += 1 → все активные ходьбы считают себя устаревшими;
--   активный твин отменяется через pcall; у персонажа снимается Anchored
--   и возвращаются столкновения (cKb[97](false)); затем — «сброс управления».
local function CancelMove()                          -- cKb[87]
    bob["token"] = bob["token"] + 1
    if bob["tween"] then
        pcall(function() bob["tween"]:Cancel() end)
        bob["tween"] = nil
    end
    local part = GetRootPart()
    if part then
        pcall(function() part["Anchored"] = false end)
    end
    SetCollide(false)
end

-- Перенос детали: cKb[37] = bqn = bny["detach"] (стр. 20989). Перед началом
-- любой ходьбы переносимая деталь сбрасывается.
local function Detach()                              -- cKb[37]
    if bny["detach"] then bny["detach"]() end
end

-- Ожидание готовности: cKb[86](f8) — состояния 5671…5679, зеркало bvI,
--   deadline = os.clock() + (f8 or 20)   -- 5671/5678/5666
--   ready()  = bnB() and (нет записи запуска или controllerValid(controller))
--   loop:  если не ready() → false
--          если время вышло → вернуть bpm()
--          если bpm() → true; иначе task.wait(0.2) и снова
-- Замечание: в первой реконструкции здесь был простой дедлайн-цикл — это
-- исправлено по состояниям 5674/5677/5665: без bpm() ожидание не прекращается.
local function WaitReady(seconds)                     -- cKb[86]
    local record = bny["runs"][coroutine.running()]   -- F5473() = coroutine.running
    local function ready()
        if not bnB() then return false end
        if record and not bny["controllerValid"](record["controller"]) then
            return false
        end
        return true
    end
    local deadline = os.clock() + (seconds or 20)
    while true do
        if not ready() then return false end
        if os.clock() >= deadline then return Alive() end
        if Alive() then return true end
        task.wait(0.2)
    end
end

-- ---------------------------------------------------------------------------
-- MoveTo(hb, hc, hd) — cKb[120] (стр. 4370), зеркало bwg = 14945 - bwg.
--   hb = цель (Vector3), hc = доп. пауза после прибытия, hd = предикат отмены.
--   В отличие от Reach, здесь всегда «блинк»: корень ставится Anchored и
--   CFrame переставляется шагами не дольше BLINK_HOLD.
-- ---------------------------------------------------------------------------
local function MoveTo(target, waitSeconds, cancel)    -- cKb[120]
    if typeof(target) ~= "Vector3" then return false end          -- 14863
    local record = bny["runs"][coroutine.running()]                -- 14867
    local userCancel = cancel
    local aborted = function()
        if not bnB() then return true end
        if record and not bny["controllerValid"](record["controller"]) then
            return true
        end
        if userCancel then return userCancel() end
        return false
    end
    if aborted() then return false end                             -- 14841

    Detach()                                                       -- 14875
    CancelMove()
    local token = bob["token"]
    if not WaitReady(15) then return false end                     -- 14875/14859/14862
    if bob["token"] ~= token then return false end                 -- 14837

    local part = GetRootPart()                                     -- 14880
    if not part then return false end
    local distance = (target - part["Position"])["Magnitude"]      -- 14839
    if distance <= bob["ARRIVE_RADIUS"] then                       -- 14879
        if waitSeconds then task.wait(waitSeconds) end             -- 14871
        if aborted() then return false end                         -- 14850
        return bob["token"] == token                               -- 14852/14868
    end

    bob["token"] = bob["token"] + 1                                -- 14878
    token = bob["token"]
    local goal = Vector3.new(target)
    SetCollide(true)
    local humanoid = GetHumanoid()
    if humanoid then
        pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end)
    end

    local blinkUntil = os.clock() + bob["BLINK_HOLD"]              -- 14870
    part = nil
    while true do                                                  -- 14858
        if bob["token"] ~= token then return false end              -- 14876
        part = GetRootPart()                                       -- 14874
        if not part then break end                                 -- 14845
        if part["Anchored"] then                                   -- 14856
            pcall(function() part["Anchored"] = false end)         -- 14872
        end
        part["CFrame"] = goal                                      -- 14842
        part["AssemblyLinearVelocity"] = Vector3.zero
        part["AssemblyAngularVelocity"] = Vector3.zero
        task.wait()
        if os.clock() >= blinkUntil then break end                 -- 14873/14838
        if aborted() then break end                                -- 14843/14873/14848
    end

    if bob["token"] ~= token then return false end                 -- 14851/14849
    SetCollide(false)                                              -- 14840
    if waitSeconds then task.wait(waitSeconds) end                 -- 14869
    part = GetRootPart()                                           -- 14866
    local ok = not aborted()                                       -- 14850 → 14852
    if ok then ok = bob["token"] == token end
    if ok then ok = part ~= nil end                                -- 14853
    if ok then ok = (part["Position"] - target)["Magnitude"] < 25 end  -- 14860
    return ok
end

-- ---------------------------------------------------------------------------
-- Reach(go, gp, gq) — bqd (стр. 4013), зеркало bvZ = 11941 - bvZ.
--   go = цель (Vector3), gp = доп. пауза, gq = предикат отмены.
--   Два режима по cKb[81]["movementMode"]:
--     "Teleport" — Anchored + CFrame шагами по BLINK_HOLD (проход сквозь стены,
--                  столкновения выключены на время);
--     иначе      — TweenService:Create(... Linear/InOut, {CFrame = цель}) со
--                  скоростью clamp(tweenSpeed, 50, 1000) и длительностью
--                  clamp(путь / скорость, 0.05, 25).
-- ---------------------------------------------------------------------------
local function Reach(target, waitSeconds, cancel)     -- bqd
    if typeof(target) ~= "Vector3" then return false end           -- 11941
    local record = bny["runs"][coroutine.running()]                -- 11866
    local userCancel = cancel
    local aborted = function()
        if not bnB() then return true end
        if record and not bny["controllerValid"](record["controller"]) then
            return true
        end
        if userCancel then return userCancel() end
        return false
    end
    if aborted() then return false end                             -- 11939

    Detach()                                                       -- 11884
    CancelMove()
    local token = bob["token"]
    if not WaitReady(15) then return false end                     -- 11884/11871/11904
    if aborted() then return false end                             -- 11900
    if bob["token"] ~= token then return false end                 -- 11933

    local part = GetRootPart()                                     -- 11890
    if not part then return false end
    local distance = (target - part["Position"])["Magnitude"]      -- 11887
    if distance <= bob["ARRIVE_RADIUS"] then                       -- 11924
        if waitSeconds then task.wait(waitSeconds) end             -- 11908
        local ok = not aborted()                                   -- 11919
        if ok then ok = bob["token"] == token end                  -- 11921/11903
        return ok
    end

    bob["token"] = bob["token"] + 1                                -- 11909
    token = bob["token"]
    local goal = Vector3.new(target)
    SetCollide(true)                                               -- «сквозь стены»
    part["AssemblyLinearVelocity"] = Vector3.zero
    part["AssemblyAngularVelocity"] = Vector3.zero
    local humanoid = GetHumanoid()
    if humanoid then
        pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end)
    end

    local cancelledInTween = false                                 -- bvW
    if CONFIG["movementMode"] == "Teleport" then                   -- 11880/11893
        local blinkUntil = os.clock() + bob["BLINK_HOLD"]
        local moving = nil
        while true do
            if bob["token"] ~= token then return false end         -- 11905/11934
            moving = GetRootPart()                                 -- 11888
            if not moving then break end                           -- 11917
            if moving["Anchored"] then                             -- 11913
                pcall(function() moving["Anchored"] = false end)   -- 11940
            end
            moving["CFrame"] = goal                                -- 11910
            moving["AssemblyLinearVelocity"] = Vector3.zero
            moving["AssemblyAngularVelocity"] = Vector3.zero
            task.wait()
            if os.clock() >= blinkUntil then break end             -- 11878/11927/11926
            if aborted() then break end                            -- 11869
        end
    else
        -- Твин: корень Anchored, скорость clamp(50…1000), время clamp(0.05…25)
        part["Anchored"] = true                                    -- 11898
        local speed = math.clamp(CONFIG["tweenSpeed"], 50, 1000)
        local duration = math.clamp(distance / speed, 0.05, 25)
        local tween = bmK["TweenService"]:Create(                  -- F319["new"]
            part,
            TweenInfo.new(duration,
                Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            { CFrame = goal })
        bob["tween"] = tween
        tween:Play()
        local deadline = os.clock() + duration + 3
        while true do                                              -- 11930
            if not bnB() then break end                            -- 11915/11892/11874
            if os.clock() >= deadline then break end
            if bob["token"] ~= token then return false end          -- 11868
            if aborted() then cancelledInTween = true end           -- 11931/11923/11886/11882
            if tween["PlaybackState"] ~= Enum.PlaybackState.Playing then break end  -- 11876
            if GetRootPart() ~= part then break end                 -- 11914/11885
            task.wait(0.05)                                         -- 11889
        end
        if bob["token"] ~= token then return false end              -- 11870/11879
        if tween["PlaybackState"] == Enum.PlaybackState.Playing then
            pcall(function() tween:Cancel() end)                    -- 11935
        end
        bob["tween"] = nil                                          -- 11925
    end

    -- Общий хвост (11867): снять Anchored/скорость, вернуть столкновения,
    -- выждать gp, проверить отмену и расстояние (25 studs).
    if bob["token"] ~= token then return false end                  -- 11867/11920
    local finalPart = GetRootPart()                                 -- 11891
    if finalPart ~= nil then                                        -- 11911/11936
        pcall(function() finalPart["Anchored"] = false end)
        finalPart["AssemblyLinearVelocity"] = Vector3.zero
    end
    SetCollide(false)                                               -- 11881
    if cancelledInTween then return false end                       -- 11873
    if waitSeconds then task.wait(waitSeconds) end                   -- 11899/11938
    local ok = not aborted()                                        -- 11932
    if ok then ok = bob["token"] == token end                       -- 11895/11928
    if ok then ok = finalPart ~= nil end                            -- 11897
    if ok then ok = (finalPart["Position"] - target)["Magnitude"] < 25 end  -- 11902
    return ok                                                       -- 11918
end

-- Регистрация отмены в трекере ходьбы: `cKb[51]["Track"](cKb[87])` (стр. 3919).
-- cKb[51] — реестр задач движения; CancelMove попадает в него, чтобы общий
-- сброс (например, при выходе из меню) останавливал шаг.
local function TrackCancel(tracker, fn)               -- cKb[51]["Track"]
    tracker["Track"](fn or CancelMove)
end

return {
    bob = bob,
    CONFIG = CONFIG,
    GetCharacter = GetCharacter,
    GetHumanoid = GetHumanoid,
    GetRootPart = GetRootPart,
    Alive = Alive,
    SetCollide = SetCollide,
    CancelMove = CancelMove,
    Detach = Detach,
    WaitReady = WaitReady,
    MoveTo = MoveTo,
    Reach = Reach,
    TrackCancel = TrackCancel,
}

--[[ ============================================================================
  НЕ ДОЧИТАНО ЗДЕСЬ:
    * cKb[51] — сам реестр задач движения (в разных сборках слот 51 указывает на
      разные тела: пул 4619, таблицу {}, функцию(G,H) и т.д.). Здесь используется
      только контракт `["Track"](fn)`; полный разбор реестра — в UI/каркасе.
    * cKb[81] — таблица настроек: читается movementMode/tweenSpeed; остальные
      поля (positionType, lookAtEnemy, offset, height, weapon, skills, holdTimes)
      разбираются в подсистеме «подход к цели» (выше по стеку).
    * порядок проверок в теле SetCollide (внешний разбор веток true/false)
      восстановлен по опакованному предикату: du = true → ветка возврата,
      du = false → ветка выключения; микродетали внутренних машин опущены.
============================================================================ ]]
