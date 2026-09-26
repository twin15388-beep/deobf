--[[ ============================================================================
  Ouroboros — ИНТЕРФЕЙС (окно, вкладки, группы, виджеты)
  ----------------------------------------------------------------------------
  СГЕНЕРИРОВАНО: tools/gen_ui_widgets.py (дерево из артефакта) +
  tools/gen_ui_lua.py (этот файл). Не править вручную — правьте артефакт/генератор.

  Библиотека — внешняя (ObsidianUltra, WindUI-подобная):
    база  https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/
    файлы Library.lua, addons/ThemeManager.lua, addons/SaveManager.lua
  Загрузчик повторяет артефакт: HttpGet → loadstring → pcall, до 5 попыток,
  проверка «вернулась таблица», warn "[Ouroboros] could not load %s:%s".
============================================================================ ]]

local M = {}

M.BASE_URL = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/"
M.FILES = {
    library = "Library.lua",
    theme   = "addons/ThemeManager.lua",
    save    = "addons/SaveManager.lua",
}
M.SAVE_ROOT = "MyScriptHub"              -- aVQ:SetFolder
M.SAVE_FOLDER = "OuroborosHub/Ouwland"   -- aVR:SetFolder
M.DEFAULT_CONFIG = "Rosewater"           -- aVQ:SaveDefault
M.IGNORE_INDEXES = { "MenuKeybind", "SaveManager_ImportSource" }

M.WINDOW = {
    Title = "Ouroboros",
    Font = Enum.Font.BuilderSans,
    Footer = nil,                       -- см. Footer ниже (Discord/версия)
    Icon = 132608042600488,
    Size = UDim2.fromOffset(860, 660),
    NotifySide = "Right",
    ShowCustomCursor = false,
    CornerRadius = 0,
    SidebarCompacted = true,
    TabSwipeFrom = "bottom",
    Animations = { TabSwitch = true },
}

M.DISCORD = {
    Banner = 95892854151512,
    Avatar = 132608042600488,
    Title = "Ouroboros Hub",
    Subtitle = "Dupes, keyless scripts and updates",
}

-- Загрузчик внешних файлов: 5 попыток, как в артефакте (состояния 1059…1082).
function M.LoadFile(path, services)
    local HttpGet = services.HttpGet
    local wait = services.wait or task.wait
    local warnf = services.warn or warn
    local reason
    for attempt = 1, 5 do
        local ok, data = pcall(HttpGet, M.BASE_URL .. path)
        if ok and type(data) == "string" and data ~= "" then
            local chunk, err = loadstring(data)
            if chunk then
                local ok2, result = pcall(chunk)
                if ok2 then
                    if type(result) == "table" then return result end
                    reason = "returned " .. typeof(result) .. " instead of a table"
                else
                    reason = tostring(result)
                end
            else
                reason = "does not compile (" .. tostring(err) .. ")"
            end
        elseif ok then
            reason = (data == "") and "empty response" or "returned " .. typeof(data)
        else
            reason = tostring(data)            -- нет ответа
        end
        wait(0.2)
    end
    warnf(string.format("[Ouroboros] could not load %s:%s", path, tostring(reason)))
    return nil
end

-- Дерево окна, выгруженное из артефакта (data/ui_tree.json).
M.SPEC = {
    { name = "Farming", icon = "swords", groups = {
        { side = "left", name = "Dungeon Run", icon = "swords", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Run\", cKb [51] [\"DungeonName\"] ()), true" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"DungeonStatus\"]), true" },
            { kind = "Toggle", key = "AutoDungeon", setter = "SetAutoDungeon", text = "Auto Farm Nearby Enemies", default = false, tooltip = "Fights whatever wave enemy is closest, skipping the ones the run excludes" },
            { kind = "Slider", key = "DungeonRange", setter = "SetDungeonRange", text = "Search Range", default = 250, min = 0, max = 2000, suffix = " studs", tooltip = "How far to look for an enemy, 0 searches the whole floor" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"BringStatus\"]), true" },
            { kind = "Toggle", key = "AutoBringEnemies", setter = "SetAutoBringEnemies", text = "Bring Enemies", default = false, tooltip = "Drags every wave enemy this client owns onto you in stead of chasing them; passive spawns are left alone" },
            { kind = "Slider", key = "BringRange", setter = "SetBringRange", text = "Bring Range", default = 2000, min = 0, max = 5000, suffix = " studs", tooltip = "How far out to pull enemies from, 0 brings the whole floor" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"WaveStatus\"]), true" },
            { kind = "Toggle", key = "AutoSkipWaves", setter = "SetAutoSkipWaves", text = "Auto Skip Waves", default = false, tooltip = "Votes to skip each wave break as it opens; the run still needs enough votes to pass" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"CardStatus\"]), true" },
            { kind = "Toggle", key = "AutoCards", setter = "SetAutoCards", text = "Auto Pick Cards", default = false, tooltip = "Takes the best offered card you picked; leaves the hand alone if none of them show up" },
            { kind = "Toggle", key = "BlockBareHands", setter = "SetBlockBareHands", text = "Block Bare Hands Event", default = true, tooltip = "Never takes Bare Hands, in cluding when it arrives on an Event card; that floor bans weapons for 2.2x points and leaves you empty handed after it" },
            { kind = "Toggle", key = "ForceHealCards", setter = "SetForceHealCards", text = "Force Heal Cards", default = false, tooltip = "While your health sits at or below the threshold this takes the hand away from your selection and picks the best heal card in stead; the moment you are back above it your selection has the hand again" },
            { kind = "Slider", key = "HealBelow", setter = "SetHealBelow", text = "Force Heal Below", default = 40, min = 0, max = 100, suffix = "%", tooltip = "0% never forces a heal and 100% always takes one; a hand with no heal card in it is left to your selection either way" },
            { kind = "Dropdown", key = "CardTargets", setter = "SetCardSelection", text = "Select Cards", default = {}, multi = true },
            { kind = "Slider", setter = "SetCardPriority", default = 5, min = 1, max = 10, tooltip = "1 is taken first, 10 last; ties go to the rarer card", label = "CardPriority\" .. cDk:gsub (\"%W\", \"\"), {[\"Text\"] = cDk .. \" Priority\", [\"Tooltip\"] = \"1 is taken first, 10 last; ties go to the rarer card\"," },
        }},
        { side = "left", name = "Dungeon", icon = "swords", widgets = {
            { kind = "Button", action = "Dialogues", text = "Where Are Dungeons?", tooltip = "Explains where the dungeon run features went", label = "{[\"Text\"] = \"Where Are Dungeons?\", [\"Tooltip\"] = \"Explains where the dungeon run features went\", [\"Func\"] = function () local cC1; cC1 = nil" },
        }},
        { side = "left", name = "Auto Farming", icon = "swords", widgets = {
            { kind = "Toggle", key = "AutoLevel", setter = "SetAutoLevel", text = "Auto Level", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"LevelStatus\"]), true" },
            { kind = "Toggle", key = "LevelDropForeign", setter = "SetLevelDropForeign", default = false },
            { kind = "Toggle", key = "AutoQuest", setter = "SetAutoQuest", text = "Auto Farm Quests", default = false, tooltip = "Farms the picked quests on repeat, taking each one again after it is do ne" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"QuestStatus\"]), true" },
            { kind = "Dropdown", key = "QuestTargets", setter = "SetQuestSelection", text = "Select Quests", default = {}, tooltip = "Combat quests whose kill tasks all resolve to a mob this can find", multi = true },
            { kind = "Button", action = "RefreshQuestChoices", text = "Refresh Quests", label = "{[\"Text\"] = \"Refresh Quests\", [\"Func\"] = function () local cVN = cKb [136]; cKb [51] [\"RefreshQuestChoices\"] (); local cVO = F6128 [\"wait\"];" },
            { kind = "Toggle", key = "AutoMob", setter = "SetAutoMob", text = "Auto Farm Mob", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"MobStatus\"]), true" },
            { kind = "Dropdown", key = "MobTarget", setter = "SetMobTarget", text = "Select Mob", default = 1 },
            { kind = "Toggle", key = "AutoBoss", setter = "SetAutoBoss", text = "Auto Boss", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"BossStatus\"]), true" },
            { kind = "Dropdown", key = "BossTargets", setter = "SetBossSelection", text = "Select Bosses", default = {}, multi = true },
            { kind = "Toggle", key = "AutoBossHunt", setter = "SetAutoBossHunt", text = "Auto Boss Hunts", default = false, tooltip = "Claims the hunt or ders posted on the crow board and kills the boss each one names, on repeat" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"HuntStatus\"]), true" },
            { kind = "Dropdown", key = "HuntTiers", setter = "SetHuntTiers", text = "Hunt Tiers", default = {}, tooltip = "Which posted hunts to take.Nothing picked takes any of them", multi = true },
            { kind = "Toggle", key = "HuntDropForeign", setter = "SetHuntDropForeign", text = "Abandon Quest For A Hunt", default = false, tooltip = "There is one quest slot, so switch this on to drop an or dinary quest that is holding it" },
            { kind = "Toggle", key = "AutoDelivery", setter = "SetAutoDelivery", text = "Auto Delivery Quest", default = false, tooltip = "Takes Estate Worker Niko's supply run, carries the box to Shiori, reports back, and starts over" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"DeliveryStatus\"]), true" },
            { kind = "Toggle", key = "AutoChest", setter = "SetAutoChest", text = "Auto Sealed Cache", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"ChestStatus\"]), true" },
            { kind = "Dropdown", key = "ChestTiers", setter = "SetChestTiers", text = "Sealed Cache Tiers", default = {}, multi = true },
            { kind = "Toggle", key = "ChestInstantKill", setter = "SetChestInstantKill", text = "Instant Kill Cache Guards", default = false, tooltip = "Its own Instant Kill, only on the guards around a locked sealed cache and only while Auto Sealed Cache runs" },
            { kind = "Slider", key = "ChestKillThreshold", setter = "SetChestKillThreshold", text = "Damage Before Kill", default = 10, min = 0, max = 100, suffix = "%", tooltip = "How much of a guard's health to take off first, 0% kills it at full health" },
            { kind = "Toggle", key = "AutoLoot", setter = "SetAutoLoot", text = "Auto Loot", default = false, tooltip = "Collects eligible drops and boss chests within the pickup range, with highest priority when loot is ready" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"LootStatus\"]), true" },
            { kind = "Slider", key = "LootRange", setter = "SetLootRange", text = "Pickup Range", default = 150, min = 0, max = 2000, suffix = " studs", tooltip = "How far to travel for a drop, 0 collects at any distance" },
            { kind = "Toggle", key = "AutoSoul", setter = "SetAutoSoul", text = "Auto Claim Souls", default = false, tooltip = "Picks up Weak, Strong and Brave Souls, the Demon progression drops" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"SoulStatus\"]), true" },
            { kind = "Slider", key = "SoulRange", setter = "SetSoulRange", text = "Collect Range", default = 250, min = 0, max = 2000, suffix = " studs", tooltip = "How far to travel for a soul, 0 collects at any distance" },
            { kind = "Toggle", key = "AutoDemon", setter = "SetAutoDemon", text = "Become A Demon", default = false, tooltip = "Runs the whole Muzan route:reputation, the Biwa Bell, the lair, the Spider Lilies, Dr.Higoshima and the blood" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"MaxHealth\"]), true" },
            { kind = "Dropdown", key = "DemonMob", setter = "SetDemonMob", text = "Reputation Mob", default = "Mizunoto", tooltip = "Killed until reputation is low enough for Muzan.Mizunoto slayers move it fastest", multi = false },
            { kind = "Toggle", key = "DemonDrink", setter = "SetDemonDrink", text = "Drink Muzan's Blood", default = true, tooltip = "Off stops at the flask in stead of transforming, so the last step stays yours.Becoming a demon cannot be undone" },
            { kind = "Toggle", key = "DemonDropForeign", setter = "SetDemonDropForeign", text = "Abandon Quest For Muzan", default = false, tooltip = "Muzan only gives the task with the quest slot free, so switch this on to drop whatever is holding it" },
            { kind = "Button", action = "MobTarget", text = "Refresh Mob and Boss Lists", label = "{[\"Text\"] = \"Refresh Mob and Boss Lists\", [\"Func\"] = function () local cVP = cKb [136]; F2175 (function () local cC5 = nil; cC5 = 9; while t" },
        }},
        { side = "left", name = "Breathing", icon = "wind", widgets = {
            { kind = "Toggle", key = "AutoBreathing", setter = "SetAutoBreathing", text = "Auto Breathing", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"BreathStatus\"]), true" },
            { kind = "Dropdown", key = "BreathingChoice", setter = "SetBreathing", text = "Select Breathing" },
            { kind = "Dropdown", key = "WenMob", setter = "SetWenMob", text = "Wen Farm Mob" },
        }},
        { side = "left", name = "Skill Tree", icon = "git-branch", widgets = {
            { kind = "Toggle", key = "AutoSkillTree", setter = "SetAutoSkillTree", text = "Auto Skill Tree", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"SkillStatus\"]), true" },
            { kind = "Toggle", key = "UnlockSkills", setter = "SetUnlockSkills", text = "Unlock Skills", default = false },
            { kind = "Dropdown", key = "SkillNodes", setter = "SetSkillNodes", text = "Select Nodes", default = {}, multi = true },
            { kind = "Button", action = "SkillNodes", text = "Refresh Nodes", label = "{[\"Text\"] = \"Refresh Nodes\", [\"Func\"] = function () local cVQ = cKb; local cVR = cVQ [136]; cVQ [51] [cVR [2375]] (); local cVS = cVR [6128]" },
        }},
        { side = "left", name = "Auto Training", icon = "dumbbell", widgets = {
            { kind = "Toggle", key = "AutoTraining", setter = "SetAutoTraining", text = "Auto Training", default = false, tooltip = "Goes from one training station to the next, do es each one and moves on.Training credit counts towards quests that ask for it." },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"TrainStatus\"]), true" },
            { kind = "Dropdown", key = "Trainings", setter = "SetTrainings", text = "Trainings", default = {}, multi = true },
            { kind = "Dropdown", key = "TrainingMode", setter = "SetTrainingMode", text = "How To Play Them", default = 1, tooltip = "Instantly finishes the moment a station opens.Play It Out plays the game's own minigame in stead, which takes as long as it normally would." },
        }},
        { side = "left", name = "Fishing", icon = "fish", widgets = {
            { kind = "Toggle", key = "AutoFish", setter = "SetAutoFish", text = "Auto Fish", default = false, tooltip = "Gets the fishing permit and a rod if you have none, then fishes at the harbor and always lands the bite" },
            { kind = "Label", label = "bpe [\"field\"] (\"Status\", bpz [\"FishStatus\"]), true" },
            { kind = "Dropdown", key = "FishBait", setter = "SetFishBait", text = "Bait", default = 1, tooltip = "Bait gets used up on every bite" },
            { kind = "Toggle", key = "AutoBuyBait", setter = "SetAutoBuyBait", text = "Auto Buy Bait", default = false, tooltip = "Buys more of the selected bait when you run out" },
        }},
        { side = "left", name = "Tower Exp", icon = "gem", widgets = {
            { kind = "Toggle", key = "AutoBuyExp", setter = "SetAutoBuyExp", default = false, tooltip = "Spends Ouwigahara run points at the Tower Crystal on 1, 000 Exp bundles." },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"CrystalStatus\"]), true" },
            { kind = "Slider", key = "ExpBundles", setter = "SetExpBundles", text = "Bundles Per Trip", default = 99, min = 1, max = 99, tooltip = "99 is the most one purchase can carry; fewer only costs extra trips." },
            { kind = "Slider", key = "PointReserve", setter = "SetPointReserve", text = "Keep Points", default = 0, min = 0, max = 500000, tooltip = "Points held back for the Outfitter racks and the tower chest." },
            { kind = "Button", action = "BuyExpNow", text = "Buy Now", label = "{[\"Text\"] = \"Buy Now\", [\"Func\"] = function () cKb [51] [\"BuyExpNow\"] () end}" },
        }},
        { side = "left", name = "Schematics", icon = "square-pen", widgets = {
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"SchematicStatus\"]), true" },
            { kind = "Dropdown", key = "SchematicTargets", setter = "SetSchematicTargets", text = "Schematics To Collect", default = {}, tooltip = "Which set drawings to go and get.Ones you already have are skipped", multi = true },
            { kind = "Toggle", key = "SchematicReturn", setter = "SetSchematicReturn", text = "Teleport Back When Done", default = true, tooltip = "Puts you back where you started once the last drawing is studied" },
            { kind = "Button", action = "CollectSchematics", text = "Collect Schematics", tooltip = "Teleports to each schematic you picked that you do n't have yet and studies it", label = "{[\"Text\"] = \"Collect Schematics\", [\"Tooltip\"] = \"Teleports to each schematic you picked that you do n't have yet and studies it\", [\"Func\"] =" },
        }},
        { side = "right", name = "Player Info", icon = "user", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Level\", \"1\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Exp\", \"0 / 0\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Wen\", \"0\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Race\", \"-\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Skill Points\", \"0\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Run Points\", \"0\"), true" },
        }},
        { side = "right", name = "Quest Progress", icon = "scroll-text", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Quest\", \"None\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Progress\", \"-\"), true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Breathing Cost\", \"None\"), true" },
        }},
        { side = "right", name = "Notifications", icon = "bell", widgets = {
            { kind = "Toggle", key = "NotifyBossSpawns", setter = "SetNotification", text = "Boss Spawns", default = false, tooltip = "Tells you when one of your bosses spawns, even when it's too far away to see" },
            { kind = "Dropdown", key = "NotifyBosses", setter = "SetNotifyBosses", text = "Bosses", default = {}, multi = true },
            { kind = "Toggle", key = "NotifyMuzan", setter = "SetNotification", text = "Muzan", default = false, tooltip = "Tells you when Muzan comes out at night and where he is.He walks around Mistfall Harbor, Hidden Mist Village or Iceveil Valley" },
            { kind = "Toggle", key = "NotifyMarket", setter = "SetNotification", text = "Black Marketer", default = false, tooltip = "Tells you when the Black Marketer comes to town, what he's selling, and when he leaves" },
            { kind = "Toggle", key = "NotifyTailor", setter = "SetNotification", text = "Tailor Restocks", default = false, tooltip = "Tells you the new clothes whenever Elara or Lynx restocks" },
            { kind = "Toggle", key = "NotifySelection", setter = "SetNotification", text = "Final Selection", default = false, tooltip = "Warns you before Final Selection starts.It happens every 2 hours, and it's how a Human of level 45 or higher becomes a Slayer" },
            { kind = "Slider", key = "NotifyWarnBefore", setter = "SetNotifyWarn", text = 1829555, default = 5, min = 1, max = 30, suffix = " min" },
            { kind = "Toggle", key = "NotifyHunts", setter = "SetNotification", text = "Boss Hunts", default = false, tooltip = "Tells you when a new boss hunt you can take is posted.Hunts are only for Slayers and Demons" },
            { kind = "Button", action = "TeleportToNotification", text = "Teleport to Last Notification", tooltip = "Travels to whatever the last not ification was about", label = "{[\"Text\"] = \"Teleport to Last Notification\", [\"Tooltip\"] = \"Travels to whatever the last not ification was about\", [\"Func\"] = function () cK" },
        }},
    }},
    { name = "Combat", icon = "sword", groups = {
        { side = "right", name = "Consumables", icon = "flask-round", widgets = {
            { kind = "Toggle", key = "AutoPotion", setter = "SetAutoPotion", text = "Auto Potion", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"PotionStatus\"]), true" },
            { kind = "Dropdown", key = "PotionChoice", setter = "SetPotion", text = "Select Potion", default = 1 },
            { kind = "Slider", key = "DrinkBelow", setter = "SetDrinkBelow", text = "Drink Below", default = 40, min = 1, max = 95, suffix = "%" },
        }},
        { side = "right", name = "Shop", icon = "store", widgets = {
            { kind = "Toggle", key = "AutoBuy", setter = "SetAutoBuy", text = "Auto Buy", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"ShopStatus\"]), true" },
            { kind = "Dropdown", key = "ShopItems", setter = "SetShopItems", text = "Select Items", default = {}, multi = true },
            { kind = "Slider", key = "KeepAmount", setter = "SetKeepAmount", text = "Keep Amount", default = 1, min = 1, max = 25 },
        }},
        { side = "left", name = "Farm Settings", icon = "move", widgets = {
            { kind = "Dropdown", key = "PositionType", setter = "SetPositionType", text = "Position Type", default = 1, tooltip = "Where to stand relative to the target while fighting it" },
            { kind = "Toggle", key = "LookAtEnemy", setter = "SetLookAtEnemy", text = "Look At Enemy", default = true, tooltip = "Always face the target, whatever the position type puts you" },
            { kind = "Slider", key = "OffsetDistance", setter = "SetOffsetDistance", text = "Offset Distance", default = 3, min = 0, max = 100, suffix = " studs", tooltip = "How far out from the target to sit, horizontally" },
            { kind = "Slider", key = "HeightOffset", setter = "SetHeightOffset", text = "Height Offset", default = 0, max = 50, suffix = " studs", tooltip = "Vertical offset from the target, positive sits higher" },
            { kind = "Dropdown", key = "MovementMode", setter = "SetMovementMode", text = "Movement Type", default = 1, tooltip = "How to cross ground:Tween glides there, Teleport blinks there in stantly" },
            { kind = "Slider", key = "TweenSpeed", setter = "SetTweenSpeed", text = "Tween Speed", default = 400, min = 50, max = 1000, suffix = " studs/s", tooltip = "How fast to glide, in studs per second" },
        }},
        { side = "left", name = "Equipment", icon = "shirt", widgets = {
            { kind = "Toggle", key = "AutoEquipBest", setter = "SetAutoEquip", text = "Auto Equip Best Equipment", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"EquipStatus\"]), true" },
        }},
        { side = "left", name = "Defence", icon = "RemoveQuest", widgets = {
            { kind = "Toggle", key = "AutoParry", setter = "SetAutoParry", text = "[Beta] Auto Parry V3", default = false, tooltip = "Times a block tap onto each in coming swing so it lands as a perfect block" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"ParryStatus\"]), true" },
            { kind = "Toggle", key = "ParryNpcs", setter = "SetParryNpcs", text = "Parry Mobs", default = true },
            { kind = "Toggle", key = "ParryPlayers", setter = "SetParryPlayers", text = "Parry Players", default = true, tooltip = "Player swings only give a 0.1s window, against 0.25s for a mob" },
            { kind = "Toggle", key = "ParryMitigate", setter = "SetParryMitigate", text = "Block When Parry Is Locked Out", default = true, tooltip = "The game refuses a perfect window while you are stunned, and for one second after any hit lands.This soaks those swings as a normal block for half damage in stead of taking them clean" },
            { kind = "Toggle", key = "ParryHold", setter = "SetParryHold", text = "Keep Blocking After A Parry", default = false, tooltip = "Costs block points and keeps the one second lockout alive, so the next swing cannot be parried.It also holds the block for a second and a half, and the game refuses every skill and every swing while a block is up, so leave it off when Auto Skills is on." },
            { kind = "Slider", key = "ParryLead", setter = "SetParryLead", text = "Parry Timing", default = 0, max = 120, suffix = " ms", tooltip = "Leave at 0 Only touch it if parries keep missing:higher blocks later, lower blocks earlier" },
            { kind = "Slider", key = "ParryRadius", setter = "SetParryRadius", text = "Parry Range", default = 40, min = 10, max = 150, suffix = " studs", tooltip = "How close an enemy has to be before auto parry watches it.The default is fine for melee" },
            { kind = "Button", action = "ResetParryStats", text = "Reset Counters", label = "{[\"Text\"] = \"Reset Counters\", [\"Func\"] = function () local cVZ = cKb [136]; cKb [51] [\"ResetParryStats\"] (); aVP:Notify (\"Parry counters res" },
        }},
        { side = "right", name = "Combat", icon = "sword", widgets = {
            { kind = "Dropdown", key = "WeaponChoice", setter = "SetWeapon", text = "Select Weapon", tooltip = "Leave empty to keep whatever you already have out" },
            { kind = "Button", action = "RefreshWeapons", text = "Refresh Weapons", label = "{[\"Text\"] = \"Refresh Weapons\", [\"Func\"] = function () local cV_ = cKb [136]; cKb [51] [\"RefreshWeapons\"] (); local cV0 = F6128 [\"wait\"]; F39" },
            { kind = "Toggle", key = "AutoSkills", setter = "SetAutoSkills", text = "Auto Skills", default = false },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"AutoSkillStatus\"]), true" },
            { kind = "Dropdown", key = "SkillChoices", setter = "SetSkillSelection", text = "Select Skills", default = {}, tooltip = "Leave empty to use every equipped skill.Blocking is left to Auto Parry and never cast from here.", multi = true },
        }},
    }},
    { name = "Priority", icon = "list-or dered", groups = {
        { side = "left", name = "Order", icon = "list-or dered", widgets = {
            { kind = "Label", label = "bpe [\"field\"] (\"Driving\", cKb [51] [\"PriorityHolder\"] ()), true" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"PriorityStatus\"]), true" },
            { kind = "Label", label = "bpe [\"field\"] (tostring (cEu), \"-\"), true" },
            { kind = "Dropdown", key = "PriorityPick", text = "Feature", default = 1, tooltip = "The feature the buttons below move", multi = false },
            { kind = "Button", action = "MovePriority", text = "Move Up", label = "{[\"Text\"] = \"Move Up\", [\"Func\"] = function () local cEe = nil; local cEf = nil; cEf = 1; while true do cEf = 4499 - cEf; do if cEf < 6181 th" },
            { kind = "Button", action = "ResetPriorityOrder", text = "Reset Order", label = "{[\"Text\"] = \"Reset Order\", [\"Func\"] = function () cEk (cKb [51] [\"ResetPriorityOrder\"] ()) end, [\"DoubleClick\"] = true}" },
        }},
        { side = "right", name = "Scheduling", icon = "sliders-horizontal", widgets = {
            { kind = "Toggle", key = "PriorityMode", setter = "SetPriorityMode", text = "Priority Scheduling", default = false, tooltip = "Lets several auto farms stay on at once and gives the character to the highest ranked one that has work" },
            { kind = "Toggle", key = "PriorityPreempt", setter = "SetPriorityPreempt", text = "Comma separated feature keys, highest priority first.Auto Loot stays first.Saved with the config", default = true, tooltip = "A higher ranked feature pauses the running one.Auto Loot always in terrupts when loot is ready" },
            { kind = "Input", key = "PriorityOrder", setter = "SetPriorityOrder", text = "Saved Order", tooltip = 11340532 },
        }},
    }},
    { name = "Player", icon = "person-standing", groups = {
        { side = "left", name = "Movement", icon = "footprints", widgets = {
            { kind = "Toggle", key = "Fly", text = "Fly", default = false },
            { kind = "Slider", key = "FlySpeed", text = "Fly Speed", default = 60, min = 10, max = 400 },
            { kind = "Toggle", key = "NoClip", text = "Noclip", default = false },
            { kind = "Toggle", key = "WalkSpeedEnabled", text = "Speed", default = false },
            { kind = "Slider", key = "WalkSpeed", text = "Speed Amount", default = 32, min = 16, max = 250 },
            { kind = "Toggle", key = "HighJump", text = "High Jump", default = false },
            { kind = "Slider", key = "JumpPower", text = "Jump Power", default = 90, min = 50, max = 400 },
            { kind = "Toggle", key = "AlwaysRun", setter = "SetAlwaysRun", text = "Always Run", default = false, tooltip = "Holds the game's own run toggle do wn so you never walk" },
        }},
        { side = "left", name = "Interaction", icon = "pointer", widgets = {
            { kind = "Toggle", key = "InstantProximityPrompt", text = "Instant ProximityPrompt", default = false },
            { kind = "Toggle", key = "DisableShiftLock", setter = "SetDisableShiftLock", text = "Disable Shift Lock", default = true, tooltip = "Turns the game's Left Alt shift lock back off whenever it comes on" },
        }},
        { side = "left", name = "Sustain", icon = "heart-pulse", widgets = {
            { kind = "Toggle", key = "InfiniteStamina", setter = "SetInfiniteStamina", text = "Infinite Stamina", default = false, tooltip = "Holds your stamina bar full so skills and sprinting stop being refused" },
            { kind = "Toggle", key = "InfiniteClimb", setter = "SetInfiniteClimb", text = "Infinite Climb", default = false, tooltip = "Keeps wall climb time topped up; needs the Wall Climb skill tree node" },
            { kind = "Toggle", key = "InfiniteHorseStamina", setter = "SetInfiniteHorseStamina", text = "Infinite Horse Stamina", default = false, tooltip = "Stops every horse speed mode draining stamina, so Run never times out" },
            { kind = "Toggle", key = "NoDrown", setter = "SetNoDrown", text = "No Drown", default = false, tooltip = "Holds your breath bar full underwater" },
        }},
        { side = "left", name = "Mitigation", icon = "RemoveQuest", widgets = {
            { kind = "Toggle", key = "NoStun", setter = "SetNoStun", text = "No Stun", default = true },
            { kind = "Toggle", key = "NoRagdoll", setter = "SetNoRagdoll", text = "No Ragdoll", default = false },
            { kind = "Toggle", key = "NoAttackSlowdown", setter = "SetNoAttackSlowdown", text = "No Attack Slowdown", default = false },
            { kind = "Toggle", key = "NoDashCooldown", setter = "SetNoDashCooldown", text = "No Dash Cooldown", default = false },
            { kind = "Toggle", key = "NoSunDamage", setter = "SetNoSunDamage", text = "No Sun Damage", default = false, tooltip = "If you're a demon, the sun no longer burns you.Does not hing for other races" },
        }},
        { side = "right", name = "Codes", icon = "ticket", widgets = {
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"CodeStatus\"]), true" },
            { kind = "Button", action = "DisabledTooltip", text = "Redeem All Codes", tooltip = "Redeems every active code, skipping ones already claimed or expired", label = "{[\"Text\"] = \"Redeem All Codes\", [\"Tooltip\"] = \"Redeems every active code, skipping ones already claimed or expired\", [\"DisabledTooltip\"] = \"" },
            { kind = "Label", label = "bpe [\"field\"] (\"Driving\", \"None\"), true" },
        }},
        { side = "right", name = "Instant Kill", icon = "zap", widgets = {
            { kind = "Toggle", key = "InstantKill", setter = "SetInstantKill", text = "Instant Kill", default = false, tooltip = "Kills any NPC your client has network ownership of" },
            { kind = "Label", label = "< font color = \"#e0788c\" > Instant kill is patched but it can still kill enemies, they just won't drop any items < /font > \", true" },
            { kind = "Slider", key = "KillThreshold", setter = "SetKillThreshold", text = "Damage Before Kill", default = 10, min = 0, max = 100, suffix = "%" },
            { kind = "Toggle", key = "OwnershipViewer", setter = "SetOwnershipViewer", text = "Ownership Viewer", default = false, tooltip = "Outlines monsters near you:green ones can be end ed right now, red ones can't" },
            { kind = "Slider", key = "OwnershipRange", setter = "SetOwnershipRange", text = "Viewer Range", default = 250, min = 50, max = 2000, suffix = " studs" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"TeleportStatus\"]), true" },
            { kind = "Dropdown", key = "ZoneTarget", text = "Select Zone", default = 1 },
            { kind = "Button", action = "ZoneTarget", text = "Teleport", label = "{[\"Text\"] = \"Teleport\", [\"Func\"] = function () local cEv, cEw, cEx = nil, nil, nil; local cEy = nil; cEy = 7; while true do cEy = 10562 - cE" },
            { kind = "Button", action = "TeleportToMuzan", text = "Teleport to Muzan", tooltip = "Goes to Muzan while he is out, otherwise to his lair arrival point", label = "{[\"Text\"] = \"Teleport to Muzan\", [\"Tooltip\"] = \"Goes to Muzan while he is out, otherwise to his lair arrival point\", [\"Func\"] = function ()" },
        }},
        { side = "right", name = "Matchmaking", icon = "swords", widgets = {
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"QueueStatus\"]), true" },
            { kind = "Dropdown", key = "QueueModes", setter = "SetQueueModes", text = "Gamemodes", default = {}, tooltip = "Queues for these in turn, skipping any the hub has locked for you", multi = true },
            { kind = "Toggle", key = "QueueRanked", setter = "SetQueueRanked", text = "Ranked", default = false, tooltip = "Queues ranked where the mode offers it; Zenith is ranked either way" },
            { kind = "Toggle", key = "QueueFill", setter = "SetQueueFill", text = "Fill", default = false, tooltip = "Lets the server fill the remaining slots with other players" },
            { kind = "Toggle", key = "AutoQueue", setter = "SetAutoQueue", text = "Auto Queue", default = false, tooltip = "Keeps you in queue and requeues as soon as one end s without a match" },
            { kind = "Button", action = "CancelQueue", text = "Leave Queue", tooltip = "Drops the current queue; the joiner places a new one on its next turn", label = "{[\"Text\"] = \"Leave Queue\", [\"Tooltip\"] = \"Drops the current queue; the joiner places a new one on its next turn\", [\"Func\"] = function () cKb" },
            { kind = "Label", label = "bpe [\"status\"] (bpz [\"WorldStatus\"]), true" },
            { kind = "Dropdown", key = "WorldTarget", setter = "SetWorld", text = "World", default = 1, tooltip = "The overworld to teleport in to" },
            { kind = "Input", key = "PrivateOwner", setter = "SetPrivateOwner", text = "Private Server Owner", default = "", tooltip = "Username of whoever hosts the private server, yours or a fri end's; leave it empty to join a public server" },
            { kind = "Toggle", key = "AutoWorld", setter = "SetAutoWorld", text = "Auto Join World", default = false, tooltip = "Retries the teleport until it takes, for when the world is full or the hub is still settling" },
            { kind = "Button", action = "JoinWorld", text = "Join World", tooltip = "Teleports once", label = "{[\"Text\"] = \"Join World\", [\"Tooltip\"] = \"Teleports once\", [\"Func\"] = function () cKb [51] [\"JoinWorld\"] () end}" },
        }},
        { side = "right", name = "Unavailable", icon = "triangle-alert", widgets = {
            { kind = "Label", label = "Missing:\" .. table.concat (cKb [123] [\"missing\"], \", \"), true" },
        }},
    }},
    { name = "ESP", icon = "eye", groups = {
        { side = "left", name = "ESP", icon = "eye", widgets = {
            { kind = "Toggle", setter = "SetEspOption", default = false, label = "a38, {[\"Text\"] = a39, [\"Default\"] = false, [\"Callback\"] = function (a4e) cKb [51] [\"SetEspOption\"] (a4a, a4e) end}" },
            { kind = "Label", label = "Dying Colour" },
            { kind = "Slider", key = "EspRange", setter = "SetEspRange", text = "Max Distance", default = 5000, min = 0, max = 20000, suffix = " studs", tooltip = "Hides anything further away than this, 0 shows it at any distance" },
        }},
        { side = "left", name = "World", icon = "globe", widgets = {
        }},
        { side = "right", name = "Player ESP", icon = "users", widgets = {
            { kind = "Toggle", key = "EspPlayers", setter = "SetEspCategory", text = "Player ESP", default = false },
            { kind = "Toggle", key = "EspPlayerInfo", setter = "SetEspOption", text = "Level / Race / Clan", default = false },
            { kind = "Label", label = "Enemy Colour" },
            { kind = "Label", label = "Party Colour" },
        }},
        { side = "right", name = "Discord", icon = "message-circle", widgets = {
        }},
    }},
    { name = "Webhook", icon = "webhook", groups = {
        { side = "right", name = "Shared", icon = "settings-2", widgets = {
            { kind = "Toggle", key = "WebhookSkipQuiet", setter = "SetWebhookSkipQuiet", text = "Skip Empty Reports", default = true, tooltip = "Stay silent when not hing on the in clude list happened." },
            { kind = "Input", key = "WebhookPingId", setter = "SetWebhookPingId", text = "Discord User ID", default = "" },
            { kind = "Toggle", key = "WebhookPing", setter = "SetWebhookPing", text = "Ping Me", default = false, tooltip = "Mentions the user ID above on every report." },
        }},
        { side = "right", name = "Delivery", icon = "s end", widgets = {
            { kind = "Label", label = "cKb [51] [\"WebhookStatus\"] (), true" },
        }},
    }},
    { name = "Settings", icon = "settings", groups = {
        { side = "left", name = "Discord", icon = "message-circle", widgets = {
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Slider", setter = "SetSkillHold", min = 0, suffix = "s", tooltip = "How long to hold this skill before releasing it", label = "cDD [\"key\"], {[\"Text\"] = cDD [\"name\"] .. \" Hold\", [\"Tooltip\"] = \"How long to hold this skill before releasing it\", [\"Default\"] = cDD [\"defau" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Button", action = "SkillChoices", text = "Refresh Skills", label = "{[\"Text\"] = \"Refresh Skills\", [\"Func\"] = function () local cVV = cKb; local cVW = cVV [136]; cVV [51] [cVW [4599]] (); local cVX = cVW [6128" },
        }},
        { side = "left", name = "Menu", icon = "logs", widgets = {
            { kind = "Toggle", key = "AntiAfk", text = "Anti-AFK", default = true },
            { kind = "Label", label = "AFK triggers:0" },
            { kind = "Toggle", key = "AntiGameplayPause", text = "No Gameplay Paused", default = true },
            { kind = "Toggle", key = "AutoReconnect", text = "Auto Reconnect on Kick", default = false },
            { kind = "Toggle", key = "Disable3D", text = "Disable 3D Rendering", default = false },
            { kind = "Toggle", key = "FpsBoost", text = "FPS Boost", default = false },
            { kind = "Toggle", key = "HideUiOnStart", text = "Hide UI On Start", default = false },
            { kind = "Label", label = "Menu bind" },
        }},
        { side = "left", name = "Script", icon = "terminal", widgets = {
            { kind = "Button", text = "Unload Script", label = "{[\"Text\"] = \"Unload Script\", [\"Func\"] = function () local cW0 = cKb [136]; aVP:Unload () end}" },
        }},
    }},
    { name = "Player / Zones", icon = "map-pin", groups = {
    }},
    { name = "Player / NPCs", icon = "user", groups = {
    }},
    { name = "Player / Mobs", icon = "skull", groups = {
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Dropdown", key = "NpcTarget", text = "Select NPC", default = 1 },
            { kind = "Button", action = "NpcTarget", text = "Teleport", label = "{[\"Text\"] = \"Teleport\", [\"Func\"] = function () local cEz, cEA, cEB = nil, nil, nil; local cEC = nil; cEC = 3; while true do cEC = 14126 - cE" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Dropdown", key = "MobTeleport", text = "Select Mob", default = 1 },
            { kind = "Button", action = "MobTeleport", text = "Teleport", label = "{[\"Text\"] = \"Teleport\", [\"Func\"] = function () local cED, cEE, cEF, cEH, cEI, cEJ = nil, nil, nil, nil, nil, nil; local cEG = nil; cEG = 5;" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "ColorPicker", setter = "SetEspColour", label = "a38 .. \"Colour\", {[\"Default\"] = a4c, [\"Title\"] = a39 .. \" Colour\", [\"Callback\"] = function (a4k) cKb [51] [\"SetEspColour\"] (a4b, a4k) end}" },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Toggle", setter = "SetEspCategory", default = false, label = "a4t, {[\"Text\"] = a4u, [\"Default\"] = false, [\"Callback\"] = function (a4x) cKb [51] [\"SetEspCategory\"] (a4v, a4x) end}" },
        }},
    }},
    { name = "ESP / Mobs", icon = "skull", groups = {
    }},
    { name = "ESP / Bosses", icon = "crown", groups = {
    }},
    { name = "ESP / NPCs", icon = "user", groups = {
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Button", action = "SendWebhookReport", text = "S end ", label = "{[\"Text\"] = \"S end \" .. cGS .. \" Report Now\", [\"Func\"] = function () cKb [51] [\"SendWebhookReport\"] (cGS, function (a5l, a5m) local cGs = ni" },
            { kind = "Input", setter = "SetWebhookUrl", text = "Webhook URL", default = "", tooltip = "Saved with your config, so do not share that file.", label = "cGJ, {[\"Text\"] = \"Webhook URL\", [\"Default\"] = \"\", [\"Placeholder\"] = cGL, [\"Tooltip\"] = \"Saved with your config, so do not share that file.\"," },
            { kind = "Dropdown", key = "WebhookItemCategories", setter = "SetItemCategories", text = "Name Drops From", tooltip = "Only these categories are listed by name.Materials are left out by default.", multi = true },
        }},
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Slider", setter = "SetWebhookInterval", text = "Report Every", min = 1, max = 240, suffix = " min", label = "WebhookInterval\" .. cGS, {[\"Text\"] = \"Report Every\", [\"Default\"] = cGH [\"in terval\"], [\"Min\"] = 1, [\"Max\"] = 240, [\"Rounding\"] = 0, [\"Suffix" },
            { kind = "Dropdown", setter = "SetWebhookEvents", text = "Include", tooltip = "Lines left out are not counted and do not keep an otherwise empty report alive.", multi = true, label = "WebhookEvents\" .. cGS, {[\"Text\"] = \"Include\", [\"Values\"] = cKb [51] [\"WebhookEventLabels\"] (cGS), [\"Default\"] = cKb [51] [\"WebhookEventLabel" },
            { kind = "Label", label = "cGH [\"blurb\"], true" },
            { kind = "Label", label = "bpe [\"field\"] (\"Report\", cKb [51] [\"WebhookChannelStatus\"] (cGS)), true" },
            { kind = "Toggle", setter = "SetWebhookEnabled", text = "Enable ", default = false, label = "Webhook\" .. cGS, {[\"Text\"] = \"Enable \" .. cGS .. \" Report\", [\"Default\"] = false, [\"Callback\"] = function (a45) cKb [51] [\"SetWebhookEnabled\"" },
        }},
    }},
    { name = "Webhook / cGS", icon = "cGH [\"icon\"]", groups = {
        { side = "left", name = "(root)", icon = nil, widgets = {
            { kind = "Input", key = "SaveManager_ImportSource", text = "Paste exported config here" },
            { kind = "Button", key = "Export Config to Clipboard", action = "HttpService" },
            { kind = "Button", key = "Import Config from Clipboard Text", setter = "SettlePriority", action = "HttpService" },
        }},
    }},
}

-- Опции виджета из спецификации (имена полей — как у библиотеки).
local function options_of(w, handler)
    local options = {}
    if w.text then options.Text = w.text end
    if w.label then options.Text = options.Text or w.label end
    if w.tooltip then options.Tooltip = w.tooltip end
    if w.default ~= nil then options.Default = w.default end
    if w.min ~= nil then options.Min = w.min end
    if w.max ~= nil then options.Max = w.max end
    if w.suffix then options.Suffix = w.suffix end
    if w.multi then options.Multi = w.multi end
    if w.values then options.Values = w.values end
    if handler then options.Callback = handler end
    return options
end

-- Сборка окна. handlers — таблица «setter/action/ключ → функция(value)».
-- Возвращает { window, tabs, toggles, values } (toggles/values — таблицы библиотеки).
function M.Build(Library, handlers)
    handlers = handlers or {}
    local window = Library:CreateWindow(M.WINDOW)
    if window.SetGlow then window:SetGlow(false) end
    local tabs = {}
    for _, spec in ipairs(M.SPEC) do
        local tab = window:AddTab(spec.name, spec.icon)
        tabs[spec.name] = tab
        for _, group in ipairs(spec.groups) do
            local add = (group.side == "right") and tab.AddRightGroupbox or tab.AddLeftGroupbox
            local box = add(tab, group.name, group.icon)
            for _, w in ipairs(group.widgets) do
                local handler = handlers[w.action or w.setter or w.key]
                if w.kind == "Toggle" then
                    box:AddToggle(w.key, options_of(w, handler))
                elseif w.kind == "Slider" then
                    box:AddSlider(w.key, options_of(w, handler))
                elseif w.kind == "Dropdown" then
                    box:AddDropdown(w.key, options_of(w, handler))
                elseif w.kind == "Input" then
                    box:AddInput(w.key, options_of(w, handler))
                elseif w.kind == "KeyPicker" then
                    box:AddKeyPicker(w.key, options_of(w, handler))
                elseif w.kind == "ColorPicker" then
                    box:AddColorPicker(w.key, options_of(w, handler))
                elseif w.kind == "Label" then
                    box:AddLabel(w.text or w.label or "", true)
                elseif w.kind == "Button" then
                    box:AddButton({ Text = w.key or w.label or "", Func = handler })
                end
            end
        end
    end
    local ok, discord = pcall(function() window:AddDiscordBox(nil, M.DISCORD) end)
    return {
        window = window,
        tabs = tabs,
        toggles = Library.Toggles or {},
        values = Library.Values or {},
        discord = ok and discord or nil,
    }
end

-- Хвост инициализации UI (состояния 5931/5932), порядок как в артефакте:
-- дефолтный конфиг → приоритеты → авто-конфиг → SettlePriority.
function M.Finish(ui, library, theme, save, settingsTab, handlers)
    if save then
        save:SetLibrary(library)
        save:SetFolder(M.SAVE_ROOT)
        save:SaveDefault(M.DEFAULT_CONFIG)
        save:ApplyToTab(settingsTab)
        save:IgnoreThemeSettings()
        save:SetIgnoreIndexes(M.IGNORE_INDEXES)
    end
    if theme then
        theme:SetLibrary(library)
        theme:SetFolder(M.SAVE_FOLDER)
        theme:IgnoreThemeSettings()
    end
    if save then save:LoadAutoloadConfig() end
    local handlersT = handlers or {}
    local toggle, settle = handlersT.Toggle, handlersT.SettlePriority
    if library.Toggles and library.Toggles.HideUiOnStart and library.Toggles.HideUiOnStart.Value then
        if toggle then toggle(false) end
    end
    if settle then settle() end
    return ui
end

return M
