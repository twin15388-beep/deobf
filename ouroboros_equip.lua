--[[ ============================================================================
  Ouroboros — подсистема ЭКИПИРОВКИ, реконструкция 1:1 из артефакта
  ----------------------------------------------------------------------------
  Источник:      ouroboros_ps2 (1).luau  (luast v1.0.1, пул cKb[136])
  Инструменты:   tools/deflatten.py --pool N / --slot N, tools/prune_junk.py
  Трейс-эталон:  data/traces/2026-09-25-autolevel-loot-parry.txt

  Каждая функция помечена ссылкой на оригинал: F<n> = запись пула cKb[136][n],
  S<k> = состояние (state) в де-flattened машине.  Номера строк — в
  ouroboros_main_pruned.txt.

  Схема (подтверждена трейсом):
     SetAutoEquip(true)  -> воркер EquipController (интервал 20 c)
                              шаг: pcall(cKb[83])
     cKb[83]             -> скор всех предметов, сортировка, AccessoryEquip
     cKb[27](slot, true) -> Item_Equip  (смена слоя хотбара)
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- 1. Отправка сигналов на сервер игры                             [F651]
--    Оригинал: bn8 = F651.  Трейс: A1="Item_Equip" A2=2 и т.д.
-- ---------------------------------------------------------------------------
local function Signal(name, ...)
    if type(bno["SignalEvent"]) ~= "table" or not cKb[118](bno["SignalEvent"]["ToServer"]) then
        cKb[100]("SignalEvent.ToServer")        -- warn: сигналы недоступны
        return false
    end
    return pcall(bno["SignalEvent"]["ToServer"], name, ...)
end

-- ---------------------------------------------------------------------------
-- 2. Инвентарь и «Equipped»-контейнер                             [F4012]
--    Items_Config.Equipped — объект, чей .Value = индекс текущего слота.
-- ---------------------------------------------------------------------------
local function Inventory()                                  -- cKb[36]
    local cfg = cKb[126]:FindFirstChild("Items_Config")
    if not cfg then return nil end
    return cfg:FindFirstChild("Equipped")
end

local function EquippedValue()                               -- cKb[55]
    return Inventory()           -- тот же аксессор: Items_Config.Equipped
end

local function EquippedByName(name)                          -- cKb[60] = F3695
    local inv = Inventory()
    if not inv then return nil end
    return inv:FindFirstChild(name)
end

-- ---------------------------------------------------------------------------
-- 3. Оценка предмета по статам                                    [F900]
--    score = Σ value * STAT_WEIGHTS[stat]; неизвестный стат вес 10.
--    cKb[141]["STAT_WEIGHTS"] (строка 28566):
--      Max Health 1 | Max Stamina 0.6 | Additional Damage 25
--      Additional Damage Factor 900 | Movement Speed Factor 300
--      Stamina Regen Speed 120 | Health Regen Speed 120
--      Block Points 30 | Block Regen 80
-- ---------------------------------------------------------------------------
local function ItemScore(item)                               -- cKb[104]
    local stats = item and item["Stats"]
    if type(stats) ~= "table" then return nil end
    local score = 0
    for stat, value in pairs(stats) do
        local weight = cKb[141]["STAT_WEIGHTS"][stat] or 10
        if type(value) == "number" then
            score += value * weight
        end
    end
    return score
end

-- ---------------------------------------------------------------------------
-- 4. Смена слота хотбара                                          [S4899..S4912]
--    Оригинал: cKb[27] = function(slot, force)   (строка 20759)
--    force=true — реально отправить Item_Equip (трейс: A2 = 0/2/3).
-- ---------------------------------------------------------------------------
local SLOT_NAMES = { "One", "Two", "Three", "Four", "Five" }  -- cKb[141]["SLOT_NAMES"]

local function EquipSlot(slot, force)                        -- cKb[27]
    local holder = EquippedValue()
    slot = tonumber(slot)
    if not holder or not slot then return false end           -- S4909/S4908
    if slot < 0 then return false end                         -- S4910
    if slot > #SLOT_NAMES then return false end               -- S4902
    if holder["Value"] == slot then                           -- S4900
        if force then                                         -- S4911
            Signal("Item_Equip", slot)                        -- S4904
        end
        return true                                           -- S4905
    end
    -- S4901: значение ставится локально; сигнал отправит следующий вызов с force
    return pcall(function() holder["Value"] = slot end)
end

-- ---------------------------------------------------------------------------
-- 5. «Auto Equip Best»: подбор лучшего снаряжения в каждый слот   [F4194]
--    Оригинал: cKb[83], строка 28569.
-- ---------------------------------------------------------------------------
local function EquipBest()                                   -- cKb[83]
    local inv = Inventory()                                  -- cKb[36]()
    local ready = EquippedValue()                            -- bnY()
    if not inv or not ready then                             -- S12032/S12033
        bpz["EquipStatus"] = "Waiting for inventory"         -- S12026
        return false
    end

    -- 5.1 собрать и оценить всё, что лежит в инвентаре
    local scored = {}
    local isNil = false
    for _, item in ipairs(inv:GetChildren()) do              -- S12027
        local score = ItemScore(item)                        -- cKb[104](item["Name"])
        local id = EquippedByName(item["Name"])              -- cKb[60](item["Name"])
        if score then
            scored[#scored + 1] = { name = item["Name"], score = score, id = id }
        else
            isNil = true
        end
    end
    if #scored == 0 then                                     -- S12034
        bpz["EquipStatus"] = "No stat gear owned"
        return false
    end
    table.sort(scored, function(a, b) return a["score"] > b["score"] end)  -- S12028

    -- 5.2 пройти слоты и надеть лучшее, если оно ещё не надето
    local equipped = 0
    local done = false
    for index, slotName in ipairs(SLOT_NAMES) do             -- S6010 / S12028
        local best = scored[index]
        if best then
            local current = inv:FindFirstChild(slotName)     -- b2u = имя слота
            local currentId = current and tonumber(current["Value"])
            if currentId ~= best["id"] then
                Signal("AccessoryEquip", best["id"], index, "Stats")   -- S4
                equipped += 1
                task.wait(0.35)                              -- пауза между слотами
            end
        end
        -- в артефакте здесь проверяется флаг выхода (S4): прерываем обход слотов
        if done then break end
    end

    -- 5.3 статус
    if equipped > 0 then
        bpz["EquipStatus"] = "Equipped " .. equipped .. " items"  -- S12037
        return true
    end
    bpz["EquipStatus"] = "Nothing to upgrade"                -- S12036
    return true
end

-- ---------------------------------------------------------------------------
-- 6. Включение/выключение автоподбора                             [F5830]
--    Оригинал: cKb[51]["SetAutoEquip"], строка 256.
--    EquipController = { interval = 20, cancel = 0 }  (cKb[91], строка 34309)
--    cKb[84]  — старт воркера, bmX — остановка, cKb[23] — интервал 1110 мс
-- ---------------------------------------------------------------------------
local function SetAutoEquip(enabled)                         -- F5830
    local controller = cKb[91]["EquipController"]
    if enabled then
        bpz["EquipStatus"] = "Starting"
        controller["running"] = true
        cKb[84](controller, 1110)                            -- cKb[23] = 1110
    else
        controller["running"] = false
        bmX(controller)
        bpz["EquipStatus"] = "Idle"
    end
end

-- Шаг воркера, который вызывает cKb[84]                      [F2994]
local function EquipStep()                                   -- cKb[23] в копии 2
    if not bnB() then return end                             -- гейт «можно действовать»
    pcall(cKb[83])                                           -- = EquipBest()
end

-- ---------------------------------------------------------------------------
-- 7. Кнопка «Equip Weapon» в меню                                 [F1125]
--    Оригинал: cKb[102]["EquipWeapon"] = F1125.
--    cKb[31]() — экипировать следующее боевое оружие, cKb[107]() — его имя.
-- ---------------------------------------------------------------------------
local function EquipWeapon()                                 -- F1125
    local delay = task["delay"]                              -- F6128["delay"]
    cKb[4004](0, function()                                  -- F4004 = отложенный запуск
        if cKb[31]() then                                    -- есть что надеть
            bpz["LevelStatus"] = "Equipped " .. tostring(cKb[107]())
        else
            bpz["LevelStatus"] = "No combat item in toolbar"
        end
    end)
end

return {
    Signal = Signal,
    Inventory = Inventory,
    EquippedValue = EquippedValue,
    EquippedByName = EquippedByName,
    ItemScore = ItemScore,
    EquipSlot = EquipSlot,
    EquipBest = EquipBest,
    SetAutoEquip = SetAutoEquip,
    EquipStep = EquipStep,
    EquipWeapon = EquipWeapon,
    SLOT_NAMES = SLOT_NAMES,
}

--[[ ============================================================================
  ДОКАЗАТЕЛЬСТВА ИЗ ТРЕЙСА (data/traces/2026-09-25-autolevel-loot-parry.txt)

  Item_Equip — аргумент это НОМЕР СЛОТА хотбара, что совпадает с EquipSlot:
    [   4.590] Item_Equip  2
    [  93.965] Item_Equip  0
    [ 215.043] Item_Equip  2

  Автоподбор снаряжения (AccessoryEquip) в этом трейсе не сработал — в момент
  включения SetAutoEquip (282.259 -> 285.946) в инвентаре не было предметов со
  статами, поэтому сработала ветка "No stat gear owned".

  Что ещё видно в трейсе и куда относится:
    Combat_Service / Combat / 1..5     — боевые свинги (A5 = 0.13 на 1-м, 0.04 на 5-м)
    server_skill_controller_signaler   — блок/парирование (см. F3022["zero"])
      Blocking / Hold | UnHold, Vector3(0,0,0)   -> подсистема C (Auto Parry V3)
    AddQuest "Ill take 3 bandits"      — подсистема D (автоквесты)
    training_signaler StateChanged/Stop— тренировки
    VisitRegion <имя>                  — телепорт-роутер мира
    Swim / State 3|0                   — плавание
    SkillController.Attempt_Hold НЕ вызывался ни разу: в этом трейсе Auto Skills
    не включали, поэтому путь каста скиллов ещё не подтверждён (подсистема A).
============================================================================ ]]
