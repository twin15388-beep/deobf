--[[
Game-specific Luau: NOT DEOBFUSCATED / SRC / NOT TESTED IN ROBLOX
Source: https://github.com/Truyem/Anime-Origins/blob/a8bb98346af9a6446c46de1b8d24fcb2896e3329/AnimeOriginsUltimate.lua
Source SHA-256: b9dd7bf5f19e4d3179540dd87913b0c968ca8300a6322ab87511a1bced97f809
Status: MIT source file, not a recovery.
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2026 Truyem789

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
MIT LICENSE END
]]

local earlyPlayers = game:GetService("Players")
if not game:IsLoaded() then game.Loaded:Wait() end
while not earlyPlayers.LocalPlayer do
    task.wait()
end
local earlyLocalPlayer = earlyPlayers.LocalPlayer
local earlyReplicatedStorage = game:GetService("ReplicatedStorage")
local earlyStartedAt = os.clock()
do
    local runtimeEnvironment = type(getgenv) == "function" and getgenv() or _G
    local fpsSetter = type(setfpscap) == "function" and setfpscap or runtimeEnvironment.setfpscap
    if type(fpsSetter) == "function" then
        local fpsLimit = 60
        pcall(function()
            local path = "AnimeOrigins_" .. earlyLocalPlayer.UserId .. "/AutoSave/lobby.json"
            if type(isfile) == "function" and isfile(path) and type(readfile) == "function" then
                local saved = game:GetService("HttpService"):JSONDecode(readfile(path))
                fpsLimit = math.clamp(math.floor(tonumber(saved.FPSLimit) or 60), 10, 240)
            end
        end)
        pcall(fpsSetter, fpsLimit)
    end
end
local function leaveBrokenGameLoad(reason)
    warn("[AnimeOriginsUltimate] Native game load failed; returning to lobby: " .. tostring(reason))
    local remotes = earlyReplicatedStorage:FindFirstChild("Remotes")
    local remote = remotes and remotes:FindFirstChild("RemoteEvent")
    if remote then pcall(function() remote:FireServer("TeleportToLobby") end) end
    task.delay(3, function()
        if game.PlaceId == 116173040971120 then
            pcall(function()
                game:GetService("TeleportService"):Teleport(129932912185311, earlyLocalPlayer)
            end)
        end
    end)
end
local function waitForCritical(parent, name)
    local instance = parent and parent:WaitForChild(name, 60)
    if not instance then
        warn("[AnimeOriginsUltimate] Critical instance " .. tostring(name) .. " did not finish loading; startup cancelled safely.")
    end
    return instance
end
local earlyPlayerGui = waitForCritical(earlyLocalPlayer, "PlayerGui")
local earlyPlayerScripts = waitForCritical(earlyLocalPlayer, "PlayerScripts")
local earlyAssets = waitForCritical(earlyReplicatedStorage, "Assets")
if not earlyPlayerGui or not earlyPlayerScripts or not earlyAssets
    or not waitForCritical(earlyAssets, "Misc")
    or not waitForCritical(earlyAssets.Misc, "DamageIndicator") then
    warn("[AnimeOriginsUltimate] Critical assets did not finish loading; startup cancelled safely.")
    if game.PlaceId == 116173040971120 then leaveBrokenGameLoad("critical assets are missing") end
    return
end
if game.PlaceId == 116173040971120 then
    if not waitForCritical(earlyReplicatedStorage, "AttributeHolder")
        or not waitForCritical(earlyPlayerGui, "GameUI")
        or not waitForCritical(earlyPlayerScripts, "GameHandlerLocal") then
        leaveBrokenGameLoad("critical game instances are missing")
        return
    end
else
    if not waitForCritical(earlyPlayerGui, "MainUI")
        or not waitForCritical(earlyPlayerScripts, "UIHandlerLocal") then return end
end
if game.PlaceId == 116173040971120 then
    local attributeHolder = earlyReplicatedStorage:FindFirstChild("AttributeHolder")
    local loading = game:GetService("ReplicatedFirst"):FindFirstChild("Loading")
    local readySince, identity, deadline = nil, nil, earlyStartedAt + 120
    repeat
        local gameUI = earlyPlayerGui:FindFirstChild("GameUI")
        local currentIdentity = attributeHolder and table.concat({
            tostring(attributeHolder:GetAttribute("GameMode")),
            tostring(attributeHolder:GetAttribute("WorldName")),
            tostring(attributeHolder:GetAttribute("Act")),
            tostring(attributeHolder:GetAttribute("Difficulty")),
        }, "|") or ""
        local ready = game:IsLoaded()
            and earlyLocalPlayer:GetAttribute("DataLoaded") == true
            and earlyLocalPlayer:GetAttribute("Loaded") == true
            and earlyLocalPlayer:GetAttribute("LoadingScreenLoaded") == true
            and earlyLocalPlayer:GetAttribute("ControlsEnabled") == true
            and loading ~= nil and loading:GetAttribute("ModulesInitialised") == true
            and earlyPlayerGui:FindFirstChild("MainUI") ~= nil
            and gameUI ~= nil and gameUI:FindFirstChild("TopUI") ~= nil
            and gameUI:FindFirstChild("TowerInfoFrameFolder") ~= nil
            and attributeHolder and attributeHolder:GetAttribute("GameMode") ~= nil
            and attributeHolder:GetAttribute("WorldName") ~= nil
            and attributeHolder:GetAttribute("Act") ~= nil
            and attributeHolder:GetAttribute("Difficulty") ~= nil
            and (workspace:FindFirstChild("PlacementParts") ~= nil or workspace:FindFirstChild("Map") ~= nil)
        if not ready or currentIdentity ~= identity then
            readySince, identity = nil, currentIdentity
        else
            readySince = readySince or os.clock()
        end
        if readySince and os.clock() - readySince >= 5 then break end
        task.wait(0.25)
    until os.clock() >= deadline
    if not readySince or os.clock() - readySince < 5 then
        leaveBrokenGameLoad("native readiness timeout")
        return
    end
else
    task.wait(2)
end
local earlyHttpService = game:GetService("HttpService")
local function aoRequest(options)
    local environment = type(getgenv) == "function" and getgenv() or _G
    local callback = syn and syn.request or environment and (environment.request or environment.http_request)
        or request or http_request
    if type(callback) ~= "function" then
        return nil, "HTTP request is unavailable"
    end
    local ok, response = pcall(callback, options)
    return ok and response or nil, ok and nil or response
end
local cachedGameIconUrl
local function gameIconUrl()
    if cachedGameIconUrl then
        return cachedGameIconUrl
    end
    local response = aoRequest({
        Url = "https://thumbnails.roblox.com/v1/places/gameicons?placeIds=" .. tostring(129932912185311)
            .. "&returnPolicy=PlaceHolder&size=512x512&format=Png&isCircular=false",
        Method = "GET",
    })
    if response and tonumber(response.StatusCode) == 200 then
        local ok, decoded = pcall(earlyHttpService.JSONDecode, earlyHttpService, tostring(response.Body or ""))
        cachedGameIconUrl = ok and decoded.data and decoded.data[1] and decoded.data[1].imageUrl or nil
    end
    return cachedGameIconUrl
end
local function sendDiscordWebhook(url, payload)
    if tostring(url or "") == "" then
        return false, "Webhook URL is empty"
    end
    local batches, current, currentSize = {}, {}, 0
    for _, embed in ipairs(type(payload.embeds) == "table" and payload.embeds or {}) do
        local size = #tostring(embed.title or "") + #tostring(embed.description or "")
            + #tostring((embed.author or {}).name or "") + #tostring((embed.footer or {}).text or "")
        for _, field in ipairs(type(embed.fields) == "table" and embed.fields or {}) do
            size += #tostring(field.name or "") + #tostring(field.value or "")
        end
        if #current > 0 and (currentSize + size > 5500 or #current >= 10) then
            table.insert(batches, current)
            current, currentSize = {}, 0
        end
        table.insert(current, embed)
        currentSize += size
    end
    if #current > 0 then table.insert(batches, current) end
    if #batches == 0 then batches[1] = nil end
    local lastStatus
    for _, embeds in ipairs(#batches > 0 and batches or {{}}) do
        local body = {}
        for key, value in pairs(payload) do body[key] = value end
        body.embeds = #embeds > 0 and embeds or payload.embeds
        local response, err = aoRequest({
            Url = tostring(url),
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = earlyHttpService:JSONEncode(body),
        })
        if not response then return false, tostring(err or "HTTP request failed") end
        lastStatus = tonumber(response.StatusCode or response.Status)
        if not lastStatus or lastStatus < 200 or lastStatus >= 300 then
            return false, lastStatus and ("Discord response: " .. lastStatus) or "Invalid Discord response"
        end
    end
    return true, "Discord response: " .. tostring(lastStatus)
end
local AO_WEBHOOK_CURRENCIES = {
    {Key = "Gems", Label = "Gems", Emoji = "<:Gem:1540630520973754428>"},
    {Key = "Gold", Label = "Gold", Emoji = "<:Gold:1540630311514284083>"},
    {Key = "PerfectStatPrism", Label = "Perfect Stat Prism", Emoji = "<:PerfectStatPrism:1540630426463248394>"},
    {Key = "StatPrism", Label = "Stat Prism", Emoji = "<:StatPrism:1540630459799834655>"},
    {Key = "TraitReroll", Label = "Trait Reroll", Emoji = "<:TraitReroll:1540630494113169488>"},
}
local AO_ITEM_EMOJIS = {}
do
    local encoded = [[
Appa|1545909134581301509
Artifact_KatakuraTown1|1540808295613206558
Artifact_KatakuraTown1Ascendant|1545291569370898566
Artifact_KatakuraTown1Empowered|1545291580850704475
Artifact_KatakuraTown1Perfected|1545291601369374771
Artifact_KatakuraTown2|1540808300172673127
Artifact_KatakuraTown2Ascendant|1545291610630266950
Artifact_KatakuraTown2Empowered|1545291648148181032
Artifact_KatakuraTown2Perfected|1545291656327331902
Artifact_KatakuraTown3|1540808306379984946
Artifact_KatakuraTown3Ascendant|1545291665445748767
Artifact_KatakuraTown3Empowered|1545291678863335547
Artifact_KatakuraTown3Perfected|1545291685888663643
Artifact_PleiadesLibrary1|1545909141329944637
Artifact_PleiadesLibrary1Ascenda|1545909147340513351
Artifact_PleiadesLibrary1Empower|1545909153464188968
Artifact_PleiadesLibrary1Perfect|1545909159852249251
Artifact_PleiadesLibrary2|1545909164994469908
Artifact_PleiadesLibrary2Ascenda|1545909170505519365
Artifact_PleiadesLibrary2Empower|1545909176448843827
Artifact_PleiadesLibrary2Perfect|1545909182103027793
Artifact_SandVillage1|1540808312809988228
Artifact_SandVillage1Ascendant|1545291753601372240
Artifact_SandVillage1Empowered|1545291822811582574
Artifact_SandVillage1Perfected|1545291845037465682
Artifact_SandVillage2|1540808319667535933
Artifact_SandVillage2Ascendant|1545291873856528487
Artifact_SandVillage2Empowered|1545291880978190367
Artifact_SandVillage2Perfected|1545291897705078854
Artifact_SandVillage3|1540808325875236875
Artifact_SandVillage3Ascendant|1545291928147329024
Artifact_SandVillage3Empowered|1545291935001088060
Artifact_SandVillage3Perfected|1545291948997218345
Artifact_SandVillage4|1545291955628408936
Artifact_SandVillage4Ascendant|1545291973618040922
Artifact_SandVillage4Empowered|1545291982367105104
Artifact_SandVillage4Perfected|1545291990831464539
ArtifactBundle|1540808269222907914
AzureRemnant|1540807977706201208
AzureSpiritBlade|1540807982479183888
BattlePassExp|1540807897339138209
BeatriceBookOfWisdom|1545909188256071722
BlackWolfSpiritPistols|1540807987965468842
ButterflyPin|1540807993866584194
CandyApple|1540808256660967504
ChakraPaper|1540807998795161681
CrimsonBundle|1540808331428495441
CrimsonshoulderPad|1540808004306337942
CursedTickets|1540807901407617035
Denreishinki|1540808009280917558
DragonBall|1540808013760430261
DragonRadar|1540808025516802048
DragonRadarPiece|1540808019431006310
DreadbeastHorn|1545909194421440572
EmiliaSpiritCrystal|1545909199785959546
EnvyBlessing|1545909208762032178
Exp|1540807906927181824
FairyPeach|1540808262692241588
FinalGetsugaEssence|1540808033276534908
Foodpill|1540808039731437679
FusionChip|1540807912325386370
FusionCore|1540808045288882298
Gems|1540807916427411477
GluttonyBlessing|1545909213862039626
GojoSunglasses|1540808050816852029
Gold|1540807922198773861
GreedBlessing|1545909218358333606
GyutaroSickles|1540808055829045258
Halo|1540808061361586208
Hellbutterfly|1540808066088435832
HoiBoi|1540808246892429352
IceCream|1545909225065291886
IgrisToken|1540807927022227516
ItakiEyes|1540808071180460093
JuliusSpiritCrystals|1545909236179931280
KenpachiSword|1540808075483676672
KenshinSakabato|1545909241758355468
LanternsToken|1540807933112361026
LoneWolfEyepatch|1540808078960885854
Lostvayne|1540808083691798619
LuckyPotion|1540808273421271122
LustBlessing|1545909246204317786
MadaraGunbai|1540808104940277880
MadaraGunbaiSub1|1540808088242626600
MadaraGunbaiSub2|1540808095234793692
MadaraGunbaiSub3|1540808100456566895
MadaraKey|1540808110292213790
MadaraScroll|1540808115996327977
MikeyCoin|1540808121415376936
NarutoSeal|1540808127996362773
NinjaScroll|1540808133268611134
PerfectStatPrism|1540807939097362534
PremiumPass|1540808283613434037
PremiumPassHeadStart|1540808278399914057
PrideBlessing|1545909250658672653
PriscillaFan|1545909255666663466
PrismaticRemnant|1540808139325177966
QueenPiece|1540808144588902400
RadiantRemnant|1540808150800670781
Ramen|1540808240768483489
ReinhardEmblem|1545909261320585257
ReinhardTrialKey|1545909266274324602
ReleaseBundle|1540808343394717766
ReZeroBundle1|1545909271827578910
ReZeroBundle2|1545909278588665876
ReZeroToken|1545909282858475541
Rinnegon|1540808156693799073
RoxyBundle|1540808337325694996
RoxyManaCrystal|1540808161445814312
RoyalSelectionInsignia|1545909287275204609
Scouter|1540808166521180180
SenzuBean|1540808171147493518
ShaulaNeedle|1545909292152913950
SlothBlessing|1545909296704004237
SoulCandy|1540808236519657543
SpiritPetals|1540807945321709752
StarterBundle|1540808349673726073
StatPrism|1540807950904336514
SubstituteBadge|1540808176470069258
SuperLuckyPotion|1540808288894066899
Takoyaki|1540808251380203580
TengenSwords|1540808183646527538
theFountainofYouth|1540808232497578024
TojiSpear|1540808188159598664
TraitReroll|1540807955870388375
Trophy|1540807961054679091
UmbralSplinters|1540807966331113634
Update1BundleBig|1545909303305707531
Update1BundleSmall|1545909307747344387
VampireEssence|1540808194220232757
VioletRemnant|1540808199681081416
Witchtea|1545909314064220251
WolfSpiritPistols|1540808205209305152
WorldBossKey|1540807971318141001
WrathBlessing|1545909320280178779
YatoShrine|1540808210926272605
YutaRing|1540808216857022515
YutaSword|1540808221298659348
ZeldrisCommandment|1540808227363749979
    ]]
    for name, id in string.gmatch(encoded, "([%w_]+)|(%d+)") do
        AO_ITEM_EMOJIS[name] = string.format("<:%s:%s>", name, id)
    end
end
do
    local encoded = [[
Akeno|1541206809723932673
Akeno_Evolved|1541207038296588299
Ban|1541207044118548673
Ban_Evolved|1541207048501461153
Bulma|1541207053639614514
Bulma_Evolved|1541207058777374841
Emilia|1545908717541662770
Emilia_Evolved|1545908723179061289
Gojo|1541207063777251358
Gojo_Evolved|1541207067795128381
GokuSSJ|1541207073554042981
GokuSSJ3|1541207077526052957
Gyutaro|1541207083611988030
Gyutaro_Evolved|1541207090020884562
IchigoDangai|1541207095150649384
IchigoDangai_Evolved|1541207100158513204
Igris|1541207104835158066
Igris_Evolved|1541207108916088946
Julius|1545908729118199818
Julius_Evolved|1545908733530480684
Kenpachi|1541207113827745913
Kenpachi_Evolved|1541207119314026546
Meliodas|1541207123436904598
Meliodas_Evolved|1541207127656235099
Mikey|1541207133964599326
Mikey_Evolved|1541207139995877548
NarutoLink|1541207145096155196
NarutoLink_Evolved|1541207150615855145
Priscilla|1545908738571903066
Priscilla_Evolved|1545908745069138131
Roxy|1541207156357857410
Roxy_Evolved|1541207160875257997
Sasuke|1541207166772318329
Sasuke_Evolved|1541207172719841320
Shaula|1545908750022606929
Shaula_Evolved|1545908755223547947
Shinobu|1541207177576841396
Shinobu_Evolved|1541207182639366265
Starrk|1541207186800119859
Starrk_Evolved|1541207192579874876
StarrkSwords|1541207196707323976
StarrkSwords_Evolved|1541207202226770021
SubaruBeako|1545908759899930716
SubaruBeako_Evolved|1545908765172310179
Tengen|1541207205968224300
Tengen_Evolved|1541207211743776878
Toji|1541207216663826462
Toji_Evolved|1541207220862062735
VegetaSSJ|1541207226033766442
VegetaSSJ_Evolved|1541207231641682060
Zeldris|1541207236905271506
Zeldris_Evolved|1541207241900818574
    ]]
    for name, id in string.gmatch(encoded, "([%w_]+)|(%d+)") do
        AO_ITEM_EMOJIS[name] = string.format("<:%s:%s>", name, id)
    end
end
local function aoItemEmoji(itemName)
    itemName = tostring(itemName or "")
    return AO_ITEM_EMOJIS[itemName]
end
for _, entry in ipairs(AO_WEBHOOK_CURRENCIES) do
    entry.Emoji = aoItemEmoji(entry.Key) or entry.Emoji
end
local function aoRewardFields(lines)
    local fields, chunk, size = {}, {}, 0
    for _, line in ipairs(lines) do
        line = tostring(line)
        if size > 0 and size + #line + 1 > 1000 then
            table.insert(fields, {name = #fields == 0 and "Gained Rewards" or "Gained Rewards (cont.)", value = table.concat(chunk, "\n"), inline = false})
            chunk, size = {}, 0
        end
        table.insert(chunk, line)
        size += #line + (size > 0 and 1 or 0)
    end
    if #chunk > 0 then
        table.insert(fields, {name = #fields == 0 and "Gained Rewards" or "Gained Rewards (cont.)", value = table.concat(chunk, "\n"), inline = false})
    end
    return fields
end
local AO_JSON_LIMIT = 2 * 1024 * 1024
local AO_BLACK_SCREEN_VERSION = 1
local AO_SCRIPT_STARTED_AT = os.clock()
local AO_MEAL_COOLDOWN = 60
local AO_RIFT_INTERVAL = 600
local AO_UNIVERSE_ID = 8946565814
local function applyGameIcon(imageButton)
    local function thumbnail()
        local universeId = tonumber(game.GameId) or 0
        if universeId <= 0 then universeId = AO_UNIVERSE_ID end
        return "rbxthumb://type=GameIcon&id=" .. tostring(universeId) .. "&w=150&h=150"
    end
    imageButton.Image = thumbnail()
    task.spawn(function()
        for _ = 1, 40 do
            if not imageButton.Parent or imageButton.IsLoaded then return end
            task.wait(0.25)
            imageButton.Image = thumbnail()
        end
    end)
end
local function aoInstallAutoReconnect(options)
    local state = options.State
    local localPlayer = options.LocalPlayer
    local teleportService = game:GetService("TeleportService")
    local coreGui = game:GetService("CoreGui")
    local guiService = game:GetService("GuiService")
    local watchedPrompts = setmetatable({}, {__mode = "k"})
    local function enabled()
        return state.Running and options.Enabled() == true
    end
    local function reconnect(reason)
        if not enabled() or state.ReconnectLoopRunning then return end
        state.ReconnectLoopRunning = true
        state.ReconnectReason = tostring(reason or "Connection lost")
        task.spawn(function()
            while enabled() do
                if type(options.Log) == "function" then
                    options.Log("Auto reconnect to lobby: " .. state.ReconnectReason)
                end
                pcall(teleportService.Teleport, teleportService, options.LobbyPlace, localPlayer)
                task.wait(8)
            end
            state.ReconnectLoopRunning = false
        end)
    end
    local function watchPrompt(instance)
        if watchedPrompts[instance] or instance.Name ~= "ErrorPrompt" or not instance:IsA("GuiObject") then return end
        watchedPrompts[instance] = true
        local function inspect()
            if instance.Parent and instance.Visible then reconnect("Roblox error prompt") end
        end
        table.insert(state.Connections, instance:GetPropertyChangedSignal("Visible"):Connect(inspect))
        task.defer(inspect)
    end
    for _, instance in ipairs(coreGui:GetDescendants()) do watchPrompt(instance) end
    table.insert(state.Connections, coreGui.DescendantAdded:Connect(watchPrompt))
    local ok, connection = pcall(function()
        return guiService.ErrorMessageChanged:Connect(function(message)
            if tostring(message or "") ~= "" then reconnect(message) end
        end)
    end)
    if ok and connection then table.insert(state.Connections, connection) end
    table.insert(state.Connections, teleportService.TeleportInitFailed:Connect(function(player, result, message)
        if player == localPlayer then reconnect(tostring(result) .. ": " .. tostring(message)) end
    end))
    local controller = {Reconnect = reconnect}
    function controller.Scan()
        for _, instance in ipairs(coreGui:GetDescendants()) do watchPrompt(instance) end
    end
    state.ReconnectController = controller
    return controller
end
local function readRiftTimerFromUI()
    local lp = LocalPlayer or earlyLocalPlayer
    local gui = lp and lp:FindFirstChild("PlayerGui")
    if not gui then return nil, nil end
    local riftFrame = gui:FindFirstChild("MainUI")
    if not riftFrame then return nil, nil end
    riftFrame = riftFrame:FindFirstChild("HUD")
    if not riftFrame then return nil, nil end
    riftFrame = riftFrame:FindFirstChild("BottomRight")
    if not riftFrame then return nil, nil end
    riftFrame = riftFrame:FindFirstChild("Rift")
    if not riftFrame then return nil, nil end
    local info = riftFrame:FindFirstChild("Info")
    if not info then return nil, nil end
    local statusText = ""
    pcall(function()
        for _, child in ipairs(info:GetChildren()) do
            if child:IsA("TextLabel") and child.Name ~= "TimeLeft" then
                statusText = statusText .. " " .. tostring(child.Text or "")
            end
        end
        for _, child in ipairs(riftFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                statusText = statusText .. " " .. tostring(child.Text or "")
            end
        end
    end)
    statusText = string.lower(tostring(statusText))
    local isCloseHint = string.find(statusText, "close", 1, true) ~= nil or string.find(statusText, "open", 1, true) ~= nil
    local timeLeft = info:FindFirstChild("TimeLeft")
    if not timeLeft or not timeLeft:IsA("TextLabel") then return nil, nil end
    local text = timeLeft.Text or ""
    local h, m, s = text:match("(%d+)h%s*(%d+)m%s*(%d+)s")
    local seconds
    if h then
        seconds = tonumber(h) * 3600 + tonumber(m) * 60 + tonumber(s)
    else
        m, s = text:match("(%d+)m%s*(%d+)s")
        if m then
            seconds = tonumber(m) * 60 + tonumber(s)
        else
            s = text:match("(%d+)s")
            if s then seconds = tonumber(s) end
        end
    end
    if not seconds then return nil, nil end
    local hasPortal = false
    pcall(function()
        local crash = workspace:FindFirstChild("CrashSite")
        hasPortal = crash and crash:FindFirstChild("RiftPart") ~= nil
    end)
    if hasPortal then
        return seconds, true
    end
    if isCloseHint then
        return seconds, true
    end
    return seconds, false
end
local function aoChallengeTimerPath(userId)
    return "AnimeOrigins_" .. tostring(userId) .. "/AutoSave/challenge-timer.json"
end
local function aoReadChallengeTimer(userId)
    local path = aoChallengeTimerPath(userId)
    if type(isfile) ~= "function" or type(readfile) ~= "function" or not isfile(path) then return nil end
    local ok, decoded = pcall(function() return earlyHttpService:JSONDecode(readfile(path)) end)
    return ok and type(decoded) == "table" and decoded.Format == "AnimeOriginsChallengeTimer"
        and tonumber(decoded.Version) == 1 and decoded or nil
end
local function aoUnifiedTimerPath(userId)
    return "AnimeOrigins_" .. tostring(userId) .. "/AutoSave/timers.json"
end
local aoWriteUnifiedTimer
local function aoReadUnifiedTimer(userId)
    local path = aoUnifiedTimerPath(userId)
    if type(isfile) == "function" and type(readfile) == "function" and isfile(path) then
        local ok, decoded = pcall(function() return earlyHttpService:JSONDecode(readfile(path)) end)
        local unified = ok and type(decoded) == "table" and decoded.Format == "AnimeOriginsTimers"
            and tonumber(decoded.Version) == 1 and decoded or nil
        if unified then return unified end
    end
    local legacyChallengePath = "AnimeOrigins_" .. tostring(userId) .. "/AutoSave/challenge-timer.json"
    local legacyRiftPath = "AnimeOrigins_" .. tostring(userId) .. "/AutoSave/rift-timer.json"
    local migrated = {Challenge = {}, Rift = {}}
    local hasLegacy = false
    if type(isfile) == "function" and type(readfile) == "function" then
        if isfile(legacyChallengePath) then
            local ok, dec = pcall(function() return earlyHttpService:JSONDecode(readfile(legacyChallengePath)) end)
            if ok and type(dec) == "table" and dec.Format == "AnimeOriginsChallengeTimer" then
                migrated.Challenge = {NextCheckAt = tonumber(dec.NextCheckAt) or 0, Reason = dec.Reason, Seeds = dec.Seeds, LastScheduledAt = dec.UpdatedAt}
                hasLegacy = true
            end
        end
        if isfile(legacyRiftPath) then
            local ok, dec = pcall(function() return earlyHttpService:JSONDecode(readfile(legacyRiftPath)) end)
            if ok and type(dec) == "table" and dec.Format == "AnimeOriginsRiftTimer" then
                migrated.Rift = {
                    NextCheckAt = tonumber(dec.NextCheckAt) or tonumber(dec.RiftSpawnAt) or 0,
                    RiftSpawnAt = tonumber(dec.RiftSpawnAt) or tonumber(dec.NextCheckAt) or 0,
                    RiftCloseAt = tonumber(dec.RiftCloseAt) or 0,
                    Reason = dec.Reason,
                    LastScheduledAt = dec.UpdatedAt
                }
                hasLegacy = true
            end
        end
    end
    if hasLegacy then
        pcall(function() aoWriteUnifiedTimer(userId, migrated) end)
        return {Format = "AnimeOriginsTimers", Version = 1, UpdatedAt = os.time(), Challenge = migrated.Challenge, Rift = migrated.Rift}
    end
    return nil
end
function aoWriteUnifiedTimer(userId, payload)
    if type(writefile) ~= "function" then return false end
    local root = "AnimeOrigins_" .. tostring(userId)
    local folder = root .. "/AutoSave"
    pcall(function()
        if type(makefolder) == "function" and type(isfolder) == "function" then
            if not isfolder(root) then makefolder(root) end
            if not isfolder(folder) then makefolder(folder) end
        end
    end)
    payload = type(payload) == "table" and payload or {}
    payload.Format, payload.Version, payload.UpdatedAt = "AnimeOriginsTimers", 1, os.time()
    return pcall(writefile, aoUnifiedTimerPath(userId), earlyHttpService:JSONEncode(payload))
end
local function aoReadChallengeTimer(userId)
    local data = aoReadUnifiedTimer(userId)
    return data and data.Challenge or nil
end
local function aoWriteChallengeTimer(userId, payload)
    local data = aoReadUnifiedTimer(userId) or {Challenge = {}, Rift = {}}
    data.Challenge = payload or {}
    return aoWriteUnifiedTimer(userId, data)
end
local function aoReadRiftTimer(userId)
    local data = aoReadUnifiedTimer(userId)
    return data and data.Rift or nil
end
local function aoWriteRiftTimer(userId, payload)
    local data = aoReadUnifiedTimer(userId) or {Challenge = {}, Rift = {}}
    data.Rift = payload or {}
    return aoWriteUnifiedTimer(userId, data)
end
local function aoOptimizeMacroV2(payload)
    if type(payload) ~= "table"
        or payload.Format ~= "AnimeOriginsMacro"
        or tonumber(payload.Version) ~= 2
        or type(payload.Actions) ~= "table" then
        error("Expected AnimeOriginsMacro v2 object with an Actions array")
    end
    local actions = payload.Actions
    local count, highest = 0, 0
    for index, action in pairs(actions) do
        if type(index) ~= "number" or index < 1 or index % 1 ~= 0 or type(action) ~= "table" then
            error("Actions must be a dense array of action objects")
        end
        count += 1
        highest = math.max(highest, index)
    end
    if count ~= highest then
        error("Actions must be a dense array")
    end
    local originalOrder = {}
    for index, action in ipairs(actions) do
        originalOrder[action] = index
    end
    local sequenceTime = nil
    local firstPlaceSeen = false
    local optimizedCount = 0
    local function oneDecimal(value)
        return math.floor(value * 10 + 0.5) / 10
    end
    local optimizationEnd = #actions
    for index, action in ipairs(actions) do
        local actionType = tostring(action.Type or "")
        if actionType == "Sell" or actionType == "SellAll" then
            optimizationEnd = index - 1
            break
        end
    end
    for index = 1, optimizationEnd do
        local action = actions[index]
        local actionType = tostring(action.Type or "")
        if actionType == "Place" then
            if not firstPlaceSeen then
                firstPlaceSeen = true
                sequenceTime = 0.0
            else
                sequenceTime = oneDecimal((sequenceTime or 0) + 0.3)
            end
            action.Time = sequenceTime
            optimizedCount += 1
        elseif actionType == "VoteStart" then
            sequenceTime = oneDecimal((sequenceTime or 0) + 0.1)
            action.Time = sequenceTime
            optimizedCount += 1
        end
    end
    if not firstPlaceSeen then
        return payload, 0
    end
    local optimizedPrefix = {}
    for index = 1, optimizationEnd do optimizedPrefix[index] = actions[index] end
    table.sort(optimizedPrefix, function(left, right)
        local leftTime = tonumber(left.Time) or 0
        local rightTime = tonumber(right.Time) or 0
        if leftTime == rightTime then
            return (originalOrder[left] or 0) < (originalOrder[right] or 0)
        end
        return leftTime < rightTime
    end)
    for index = 1, optimizationEnd do actions[index] = optimizedPrefix[index] end
    return payload, optimizedCount
end
local function aoIsBaseMythic(towerInfo, key)
    local info = type(towerInfo) == "table" and towerInfo[tostring(key)] or nil
    return type(info) == "table"
        and tostring(info.Rarity or info.TowerRarity or "") == "Mythic"
        and info.Evolved == nil
        and not string.match(tostring(key), "_Evolved$")
end
local function aoMigrateBlackScreen(config)
    if type(config) ~= "table" then return false end
    if tonumber(config.BlackScreenVersion) == nil then
        config.BlackScreen = true
        config.BlackScreenVersion = AO_BLACK_SCREEN_VERSION
        return true
    end
    config.BlackScreenVersion = AO_BLACK_SCREEN_VERSION
    config.BlackScreen = config.BlackScreen == true
    return false
end
local function aoBuildNamedConfigManager(options)
    local tab, prefix, config, defaults = options.Tab, options.Prefix, options.Config, options.Defaults
    local folder = options.Folder
    local selected = "Auto Save"
    local function ensureFolder()
        if type(makefolder) ~= "function" or type(isfolder) ~= "function" then
            error("Local folder access is unavailable")
        end
        if not isfolder(options.RootFolder) then makefolder(options.RootFolder) end
        if not isfolder(folder) then makefolder(folder) end
    end
    local function safeName(raw)
        local name = tostring(raw or ""):match("^%s*(.-)%s*$") or ""
        if name == "" then return nil, "Enter a config name" end
        if #name > 64 then return nil, "Config names are limited to 64 characters" end
        if name == "." or name == ".." or string.find(name, "..", 1, true)
            or string.find(name, "[/\\:%z\1-\31]") then
            return nil, "Paths, traversal, control characters, and ':' are not allowed"
        end
        name = string.gsub(name, "[^A-Za-z0-9 _%-]", "_")
        name = string.gsub(name, "%s+", " ")
        name = name:match("^%s*(.-)%s*$") or ""
        if name == "" or string.lower(name) == "auto save" then
            return nil, "That config name is reserved"
        end
        return name
    end
    local function names()
        local values = {"Auto Save"}
        if type(listfiles) == "function" and type(isfolder) == "function" and isfolder(folder) then
            local ok, files = pcall(listfiles, folder)
            if ok then
                for _, path in ipairs(files) do
                    local name = string.match(tostring(path), "([^/\\]+)%.json$")
                    if name and safeName(name) then table.insert(values, name) end
                end
            end
        end
        table.sort(values, function(a, b)
            if a == "Auto Save" then return true end
            if b == "Auto Save" then return false end
            return string.lower(a) < string.lower(b)
        end)
        return values
    end
    local function namedPath(name)
        local valid, err = safeName(name)
        if not valid then error(err) end
        return folder .. "/" .. valid .. ".json", valid
    end
    local function bundleForCurrent()
        local saved = {}
        for key in pairs(defaults) do
            if key ~= "QuestRuntimeTarget" then saved[key] = config[key] end
        end
        saved.QuestRuntimeTarget = nil
        return {format = "AnimeOriginsConfig", version = 1, gameId = tostring(game.GameId), config = saved}
    end
    local function writeNamed(name)
        if type(writefile) ~= "function" then error("Local file writing is unavailable") end
        ensureFolder()
        local path, valid = namedPath(name)
        local text = earlyHttpService:JSONEncode(bundleForCurrent())
        if #text > AO_JSON_LIMIT then error("Config exceeds the 2MB limit") end
        local ok, err = pcall(writefile, path, text)
        if not ok then error("Could not write config: " .. tostring(err)) end
        return valid, path
    end
    local function readSelection(name)
        local path
        if name == "Auto Save" then
            path = options.AutoSavePath
        else
            path = namedPath(name)
        end
        if type(isfile) ~= "function" or type(readfile) ~= "function" or not isfile(path) then
            error("Config file does not exist: " .. tostring(name))
        end
        local text = readfile(path)
        if #text > AO_JSON_LIMIT then error("Config exceeds the 2MB limit") end
        local decoded = earlyHttpService:JSONDecode(text)
        if type(decoded) ~= "table" then error("Config JSON root must be an object") end
        local source = decoded
        if decoded.config ~= nil or decoded.format ~= nil then
            if decoded.format ~= "AnimeOriginsConfig" or tonumber(decoded.version) ~= 1
                or tostring(decoded.gameId) ~= tostring(game.GameId) or type(decoded.config) ~= "table" then
                error("Invalid Anime Origins config bundle")
            end
            source = decoded.config
        end
        for key in pairs(defaults) do
            if key ~= "QuestRuntimeTarget" and source[key] ~= nil then config[key] = source[key] end
        end
        if tonumber(source.BlackScreenVersion) == nil then
            config.BlackScreen, config.BlackScreenVersion = true, AO_BLACK_SCREEN_VERSION
        end
        config.QuestRuntimeTarget = nil
        options.Normalize(config)
        options.Apply(config)
        options.Save(config)
        return path
    end
    tab:AddParagraph({
        Title = "Named Configs",
        Content = "Auto Save is updated automatically whenever a setting changes and cannot be deleted. Named configs are local snapshots shared by the lobby and game UI.",
    })
    local nameInput = tab:AddInput(prefix .. "_NamedConfigName", {
        Title = "Config name", Default = "", Placeholder = "Farm setup", Numeric = false, Finished = true,
    })
    local dropdown = tab:AddDropdown(prefix .. "_NamedConfigSelect", {
        Title = "Saved config", Values = names(), Default = selected, Multi = false,
    })
    dropdown:OnChanged(function(value) selected = tostring(value or "Auto Save") end)
    local function refresh(selectName)
        local values = names()
        selected = selectName and table.find(values, selectName) and selectName
            or table.find(values, selected) and selected or "Auto Save"
        dropdown:SetValues(values)
        dropdown:SetValue(selected)
        return values
    end
    local function guarded(callback)
        return function()
            local ok, title, content = pcall(callback)
            options.Notify(ok and title or "Config Error", ok and content or title)
        end
    end
    tab:AddButton({Title = "Refresh", Callback = guarded(function()
        local values = refresh()
        return "Configs Refreshed", string.format("Found %d named config(s).", #values - 1)
    end)})
    tab:AddButton({Title = "Create / Save", Callback = guarded(function()
        local entered = tostring(nameInput.Value or ""):match("^%s*(.-)%s*$") or ""
        local target = entered ~= "" and entered or selected ~= "Auto Save" and selected or ""
        local valid, path = writeNamed(target)
        selected = valid
        nameInput:SetValue("")
        refresh(valid)
        return "Config Saved", valid .. " saved to " .. path
    end)})
    tab:AddButton({Title = "Load", Callback = guarded(function()
        local path = readSelection(selected)
        return "Config Loaded", "Loaded " .. selected .. " into Auto Save from " .. path .. ". Rerun/rebuild may be needed to refresh all controls."
    end)})
    tab:AddButton({Title = "Delete", Callback = guarded(function()
        if selected == "Auto Save" then error("Auto Save cannot be deleted") end
        if type(delfile) ~= "function" then error("Local file deletion is unavailable") end
        local path, old = namedPath(selected)
        if type(isfile) ~= "function" or not isfile(path) then error("Config file does not exist") end
        delfile(path)
        selected = "Auto Save"
        refresh(selected)
        return "Config Deleted", old .. " was deleted."
    end)})
    local api = {
        Refresh = refresh,
        List = names,
        Save = writeNamed,
        Load = readSelection,
        Delete = function(name)
            if name == "Auto Save" then error("Auto Save cannot be deleted") end
            local path = namedPath(name)
            if type(delfile) ~= "function" then error("Local file deletion is unavailable") end
            delfile(path)
            return true
        end,
    }
    options.State.NamedConfigManager = api
    return api
end
local function aoCreateBlackScreenController(options)
    local state, globalTables, towerInfo, itemInfo = options.State, options.GlobalTables, options.TowerInfo, options.ItemInfo
    local controller = {Enabled = false, Visible = false, Generation = 0, Rewards = {}, RewardOrder = {}}
    local userInput = game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    local function amountSnapshot()
        local snapshot = {}
        for category, items in pairs((globalTables.Inventory or {})) do
            if category ~= "Towers" and type(items) == "table" then
                for asset, amount in pairs(items) do
                    amount = tonumber(amount)
                    if amount then snapshot[tostring(category) .. ":" .. tostring(asset)] = amount end
                end
            end
        end
        return snapshot
    end
    local function towerSnapshot()
        local snapshot = {}
        for uuid, unit in pairs((globalTables.Inventory or {}).Towers or {}) do
            if type(unit) == "table" then
                snapshot[tostring(uuid)] = {Asset = tostring(unit.Name or "Unknown"), Shiny = unit.Shiny == true}
            end
        end
        return snapshot
    end
    local function totalWins()
        return tonumber((((globalTables.PlayerData or {}).Total_Games_Won or {}).Total)) or 0
    end
    controller.LastAmounts = amountSnapshot()
    controller.LastTowers = towerSnapshot()
    controller.MatchBaseline = totalWins()
    controller.RewardBaselineReady = true
    controller.StartedAt = AO_SCRIPT_STARTED_AT
    state.BlackScreenRewards = controller.Rewards
    state.BlackScreenRewardBaseline = {Amounts = controller.LastAmounts, Towers = controller.LastTowers}
    local rarityColors = {
        Rare = Color3.fromRGB(88, 154, 255), Epic = Color3.fromRGB(174, 101, 255),
        Legendary = Color3.fromRGB(255, 183, 76), Mythic = Color3.fromRGB(255, 83, 145),
        Secret = Color3.fromRGB(106, 239, 207),
    }
    local function metadata(reward)
        if reward.Type == "Tower" then return towerInfo[reward.Asset] or {} end
        return type(itemInfo[reward.Category]) == "table" and itemInfo[reward.Category][reward.Asset] or {}
    end
    local function addReward(kind, category, asset, amount, shiny)
        amount = tonumber(amount) or 0
        if amount <= 0 then return false end
        local key = table.concat({kind, tostring(category or ""), tostring(asset), shiny and "Shiny" or "Normal"}, ":")
        local reward = controller.Rewards[key]
        if reward then reward.Amount += amount else
            reward = {Type = kind, Category = category, Asset = tostring(asset), Amount = amount, Shiny = shiny == true, Order = #controller.RewardOrder + 1}
            controller.Rewards[key] = reward
            table.insert(controller.RewardOrder, reward)
        end
        return true
    end
    local function scanRewards()
        if os.clock() < (controller.NextRewardScanAt or 0) then return false end
        controller.NextRewardScanAt = os.clock() + 5
        local changed = false
        local amounts = amountSnapshot()
        for key, amount in pairs(amounts) do
            local gained = amount - (controller.LastAmounts[key] or 0)
            if gained > 0 then
                local category, asset = string.match(key, "^([^:]+):(.*)$")
                changed = addReward("Item", category, asset, gained) or changed
            end
        end
        local towers = towerSnapshot()
        for uuid, unit in pairs(towers) do
            if not controller.LastTowers[uuid] then changed = addReward("Tower", "Towers", unit.Asset, 1, unit.Shiny) or changed end
        end
        controller.LastAmounts, controller.LastTowers = amounts, towers
        return changed
    end
    controller.ScanRewards = scanRewards
    local function disconnectAll()
        for _, connection in ipairs(controller.Connections or {}) do pcall(function() connection:Disconnect() end) end
        controller.Connections = {}
    end
    local function destroyGui()
        controller.Generation += 1
        disconnectAll()
        if controller.Gui then controller.Gui:Destroy(); controller.Gui = nil end
        for _, parent in ipairs({game:GetService("CoreGui"), options.LocalPlayer:FindFirstChildOfClass("PlayerGui")}) do
            local old = parent and parent:FindFirstChild("AnimeOriginsBlackScreen")
            if old then old:Destroy() end
        end
        controller.Visible = false
        state.BlackScreenGui = nil
    end
    controller.Destroy = destroyGui
    local function build(showImmediately)
        destroyGui()
        controller.Connections = {}
        local generation = controller.Generation
        local gui = Instance.new("ScreenGui")
        gui.Name, gui.ResetOnSpawn, gui.IgnoreGuiInset, gui.DisplayOrder = "AnimeOriginsBlackScreen", false, true, 1999
        local backdrop = Instance.new("Frame", gui)
        backdrop.Name, backdrop.Size, backdrop.BackgroundColor3, backdrop.BorderSizePixel = "Backdrop", UDim2.fromScale(1, 1), Color3.new(), 0
        backdrop.Visible = showImmediately == true
        local panel = Instance.new("Frame", backdrop)
        panel.AnchorPoint, panel.Position, panel.Size = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), UDim2.fromOffset(960, 650)
        panel.BackgroundColor3, panel.BackgroundTransparency, panel.BorderSizePixel = Color3.fromRGB(7, 7, 12), 0.08, 0
        Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 22)
        local stroke = Instance.new("UIStroke", panel)
        stroke.Color, stroke.Transparency, stroke.Thickness = Color3.fromRGB(111, 83, 224), 0.45, 1.5
        local scale = Instance.new("UIScale", panel)
        local function updateScale()
            local size = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
            scale.Scale = math.clamp(math.min((size.X - 24) / 960, (size.Y - 24) / 650), 0.42, 1)
        end
        updateScale()
        local function label(parent, text, position, size, textSize, color, font)
            local value = Instance.new("TextLabel", parent)
            value.BackgroundTransparency, value.Text, value.Position, value.Size = 1, text, position, size
            value.TextSize, value.TextColor3, value.Font = textSize, color or Color3.fromRGB(226, 226, 236), font or Enum.Font.GothamMedium
            return value
        end
        local title = label(panel, "ANIME ORIGINS", UDim2.fromOffset(0, 22), UDim2.new(1, 0, 0, 34), 25, Color3.fromRGB(242, 241, 248), Enum.Font.GothamBold)
        local fps = label(panel, "FPS: 0", UDim2.fromOffset(0, 56), UDim2.new(1, 0, 0, 18), 11, Color3.fromRGB(166, 137, 255), Enum.Font.GothamBold)
        local timer = label(panel, "00:00:00", UDim2.fromOffset(0, 84), UDim2.new(1, 0, 0, 66), 53, Color3.fromRGB(248, 248, 252), Enum.Font.GothamBold)
        local mapText = label(panel, "", UDim2.fromOffset(60, 164), UDim2.new(1, -120, 0, 42), 13, Color3.fromRGB(169, 165, 184), Enum.Font.GothamMedium)
        mapText.TextWrapped = true
        local matches = label(panel, "SESSION MATCHES  0", UDim2.new(0.5, -130, 0, 215), UDim2.fromOffset(260, 42), 14, Color3.fromRGB(194, 174, 255), Enum.Font.GothamBold)
        matches.BackgroundTransparency, matches.BackgroundColor3 = 0, Color3.fromRGB(18, 15, 29)
        Instance.new("UICorner", matches).CornerRadius = UDim.new(1, 0)
        label(panel, "REWARDS RECEIVED", UDim2.fromOffset(0, 276), UDim2.new(1, 0, 0, 24), 15, Color3.fromRGB(231, 229, 239), Enum.Font.GothamBold)
        local divider = Instance.new("Frame", panel)
        divider.Position, divider.Size, divider.BackgroundColor3, divider.BorderSizePixel = UDim2.new(0.08, 0, 0, 310), UDim2.new(0.84, 0, 0, 1), Color3.fromRGB(42, 35, 61), 0
        local rewardsFrame = Instance.new("ScrollingFrame", panel)
        rewardsFrame.Name, rewardsFrame.Position, rewardsFrame.Size = "Rewards", UDim2.fromOffset(50, 326), UDim2.new(1, -100, 0, 285)
        rewardsFrame.BackgroundTransparency, rewardsFrame.BorderSizePixel, rewardsFrame.ScrollBarThickness = 1, 0, 3
        rewardsFrame.ScrollBarImageColor3, rewardsFrame.AutomaticCanvasSize, rewardsFrame.CanvasSize = Color3.fromRGB(131, 99, 242), Enum.AutomaticSize.Y, UDim2.new()
        local layout = Instance.new("UIListLayout", rewardsFrame)
        layout.Padding, layout.SortOrder = UDim.new(0, 7), Enum.SortOrder.LayoutOrder
        local empty = label(rewardsFrame, "No rewards received since this script started", UDim2.new(), UDim2.new(1, 0, 0, 70), 14, Color3.fromRGB(101, 96, 116), Enum.Font.GothamMedium)
        empty.Name = "EmptyState"
        local close = Instance.new("TextButton", backdrop)
        close.Name, close.AnchorPoint, close.Position, close.Size = "Close", Vector2.new(1, 0), UDim2.new(1, -22, 0, 22), UDim2.fromOffset(52, 52)
        close.BackgroundColor3, close.Text, close.TextColor3, close.TextSize, close.Font, close.ZIndex = Color3.fromRGB(20, 18, 27), "X", Color3.fromRGB(240, 239, 246), 20, Enum.Font.GothamBold, 20
        Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
        local closeStroke = Instance.new("UIStroke", close)
        closeStroke.Color, closeStroke.Transparency = Color3.fromRGB(126, 100, 220), 0.25
        local function refreshCards()
            for _, child in ipairs(rewardsFrame:GetChildren()) do if child.Name == "RewardCard" then child:Destroy() end end
            empty.Visible = #controller.RewardOrder == 0
            for _, reward in ipairs(controller.RewardOrder) do
                local meta = metadata(reward)
                local rarity = tostring(meta.Rarity or "Rare")
                local accent = rarityColors[rarity] or Color3.fromRGB(138, 112, 230)
                local card = Instance.new("Frame", rewardsFrame)
                card.Name, card.LayoutOrder, card.Size, card.BackgroundColor3, card.BorderSizePixel = "RewardCard", reward.Order, UDim2.new(1, -5, 0, 61), Color3.fromRGB(13, 12, 20), 0
                Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
                local cardStroke = Instance.new("UIStroke", card)
                cardStroke.Color, cardStroke.Transparency = accent, 0.65
                local iconBack = Instance.new("Frame", card)
                iconBack.Position, iconBack.Size, iconBack.BackgroundColor3, iconBack.BorderSizePixel = UDim2.fromOffset(9, 7), UDim2.fromOffset(47, 47), Color3.fromRGB(24, 21, 34), 0
                Instance.new("UICorner", iconBack).CornerRadius = UDim.new(0, 10)
                local image = tostring(meta.Image or meta.Icon or "")
                if image ~= "" then
                    local icon = Instance.new("ImageLabel", iconBack)
                    icon.Size, icon.BackgroundTransparency, icon.Image, icon.ScaleType = UDim2.fromScale(1, 1), 1, image, Enum.ScaleType.Fit
                else
                    local initials = reward.Type == "Tower" and "UNIT" or string.upper(string.sub(reward.Asset, 1, 2))
                    label(iconBack, initials, UDim2.new(), UDim2.fromScale(1, 1), reward.Type == "Tower" and 10 or 15, accent, Enum.Font.GothamBold)
                end
                local kind = label(card, reward.Type == "Tower" and "UNIT" or string.upper(tostring(reward.Category)), UDim2.fromOffset(70, 8), UDim2.fromOffset(130, 18), 9, accent, Enum.Font.GothamBold)
                kind.TextXAlignment = Enum.TextXAlignment.Left
                local display = tostring(meta.DisplayName or meta.Name or reward.Asset) .. (reward.Shiny and " (Shiny)" or "")
                local name = label(card, display, UDim2.fromOffset(70, 27), UDim2.new(1, -215, 0, 25), 13, Color3.fromRGB(222, 220, 231), Enum.Font.GothamMedium)
                name.TextXAlignment, name.TextTruncate = Enum.TextXAlignment.Left, Enum.TextTruncate.AtEnd
                local amount = label(card, "x" .. tostring(math.floor(reward.Amount)), UDim2.new(1, -130, 0, 0), UDim2.fromOffset(110, 61), 18, Color3.fromRGB(198, 176, 255), Enum.Font.GothamBold)
                amount.TextXAlignment = Enum.TextXAlignment.Right
            end
        end
        controller.RefreshCards = refreshCards
        controller.Refresh = function()
            local changed = scanRewards()
            local elapsed = math.max(0, math.floor(os.clock() - AO_SCRIPT_STARTED_AT))
            timer.Text = string.format("%02d:%02d:%02d", math.floor(elapsed / 3600), math.floor(elapsed % 3600 / 60), elapsed % 60)
            local map = options.MapInfo()
            mapText.Text = string.format("%s  |  %s  |  WAVE %s", tostring(map.Map or "Lobby"), tostring(map.Mode or "Lobby"), tostring(map.Wave or "-"))
            matches.Text = "SESSION MATCHES  " .. tostring(math.max(0, totalWins() - controller.MatchBaseline))
            if changed then refreshCards() end
            state.BlackScreenVisible = backdrop.Visible
            return changed
        end
        state.RefreshBlackScreen = controller.Refresh
        local lastInputAt = os.clock()
        controller.LastInputAt = lastInputAt
        local function hideAndReset()
            lastInputAt = os.clock()
            controller.LastInputAt = lastInputAt
            backdrop.Visible, controller.Visible, state.BlackScreenVisible = false, false, false
        end
        controller.Show = function()
            if controller.Enabled and backdrop.Parent then
                backdrop.Visible, controller.Visible, state.BlackScreenVisible = true, true, true
            end
        end
        controller.Hide = hideAndReset
        table.insert(controller.Connections, close.Activated:Connect(hideAndReset))
        table.insert(controller.Connections, userInput.InputBegan:Connect(function(input)
            local kind = input.UserInputType
            if kind == Enum.UserInputType.MouseButton1 or kind == Enum.UserInputType.MouseButton2
                or kind == Enum.UserInputType.MouseButton3 or kind == Enum.UserInputType.Touch then
                lastInputAt = os.clock()
                controller.LastInputAt = lastInputAt
            end
        end))
        if workspace.CurrentCamera then table.insert(controller.Connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)) end
        local frames, fpsAt = 0, os.clock()
        table.insert(controller.Connections, runService.RenderStepped:Connect(function()
            frames += 1
            local now = os.clock()
            if now - fpsAt >= 2 then
                local measured = math.floor(frames / (now - fpsAt) + 0.5)
                local limit = tonumber((state.Config or {}).FPSLimit)
                fps.Text = "FPS: " .. tostring(measured) .. (limit and "  |  LIMIT: " .. tostring(limit) or "")
                frames, fpsAt = 0, now
            end
        end))
        local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
        if not ok then gui.Parent = options.LocalPlayer:WaitForChild("PlayerGui") end
        controller.Gui, state.BlackScreenGui = gui, gui
        controller.Visible, state.BlackScreenVisible = backdrop.Visible, backdrop.Visible
        refreshCards()
        controller.Refresh()
        task.spawn(function()
            while controller.Enabled and controller.Generation == generation and gui.Parent and task.wait(1) do
                controller.Refresh()
                if not backdrop.Visible and os.clock() - lastInputAt >= 120 then controller.Show() end
            end
        end)
    end
    function controller:SetEnabled(enabled, showImmediately)
        self.Enabled = enabled == true
        if not self.Enabled then destroyGui(); return end
        build(showImmediately == true)
    end
    state.BlackScreenController = controller
    state.ShowBlackScreen = function() controller.Show() end
    state.HideBlackScreen = function() controller.Hide() end
    return controller
end
function AOCreateFixLagController(options)
    local state = options.State
    local config = options.Config
    local controller = {Enabled = false, Generation = 0, Processed = 0, Connections = {}}
    local runtimeEnvironment = type(getgenv) == "function" and getgenv() or _G
    for _, previous in ipairs(runtimeEnvironment.AOFixLagControllers or {}) do
        if previous ~= controller and type(previous.SetEnabled) == "function" then
            pcall(function() previous:SetEnabled(false) end)
        end
    end
    runtimeEnvironment.AOFixLagControllers = {controller}
    local function memoryMb()
        local ok, value = pcall(function() return game:GetService("Stats"):GetTotalMemoryUsageMb() end)
        return ok and math.floor(value * 10 + 0.5) / 10 or nil
    end
    local function optimize(instance, stripTextures)
        if not controller.Enabled or not instance then return end
        controller.Processed += 1
        if instance:IsA("ParticleEmitter") then
            instance.Enabled = false
            if stripTextures then pcall(function() instance.Texture = "" end) end
        elseif instance:IsA("Beam") or instance:IsA("Trail") then
            instance.Enabled = false
            if stripTextures then pcall(function() instance.Texture = "" end) end
        elseif instance:IsA("Smoke") or instance:IsA("Fire") or instance:IsA("Sparkles") then
            instance.Enabled = false
        elseif instance:IsA("Light") or instance:IsA("Highlight") or instance:IsA("PostEffect") then
            instance.Enabled = false
        elseif instance:IsA("Sound") then
            pcall(function() instance:Stop() end)
            pcall(function() instance.SoundId = "" end)
        elseif instance:IsA("SurfaceAppearance") then
            if stripTextures then
                pcall(function() instance:Destroy() end)
            end
        elseif instance:IsA("MeshPart") then
            instance.CastShadow = false
            instance.Reflectance = 0
            if stripTextures then pcall(function() instance.TextureID = "" end) end
        elseif instance:IsA("Decal") or instance:IsA("Texture") then
            if stripTextures then pcall(function() instance:Destroy() end) end
        elseif instance:IsA("BasePart") then
            instance.CastShadow = false
            instance.Reflectance = 0
        elseif instance:IsA("Atmosphere") then
            instance.Density = 0
            instance.Haze = 0
            instance.Glare = 0
        elseif instance:IsA("Clouds") then
            instance.Enabled = false
        end
        if stripTextures and instance:IsA("BasePart") then
            local enemies = workspace:FindFirstChild("Enemies")
            local towers = workspace:FindFirstChild("Towers")
            local allies = workspace:FindFirstChild("Allies")
            local characters = workspace:FindFirstChild("Characters")
            local map = workspace:FindFirstChild("Map")
            local mapTrash = workspace:FindFirstChild("MapTrash")
            local debris = workspace:FindFirstChild("Debris")
            if (enemies and instance:IsDescendantOf(enemies))
                or (towers and instance:IsDescendantOf(towers))
                or (allies and instance:IsDescendantOf(allies))
                or (characters and instance:IsDescendantOf(characters))
                or (map and instance:IsDescendantOf(map))
                or (mapTrash and instance:IsDescendantOf(mapTrash))
                or (debris and instance:IsDescendantOf(debris)) then
                instance.LocalTransparencyModifier = 1
            end
        end
    end
    local function disconnect()
        for _, connection in ipairs(controller.Connections) do
            pcall(function() connection:Disconnect() end)
        end
        table.clear(controller.Connections)
    end
    local function watch(root, stripTextures)
        if not root then return end
        table.insert(controller.Connections, root.DescendantAdded:Connect(function(instance)
            if controller.Enabled then optimize(instance, stripTextures) end
        end))
    end
    local function applyRenderingSettings()
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
        pcall(function()
            local userSettings = UserSettings():GetService("UserGameSettings")
            userSettings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        end)
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.EnvironmentDiffuseScale = 0
        lighting.EnvironmentSpecularScale = 0
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            pcall(function() terrain.Decoration = false end)
            pcall(function() terrain.WaterWaveSize = 0 end)
            pcall(function() terrain.WaterWaveSpeed = 0 end)
            pcall(function() terrain.WaterReflectance = 0 end)
        end
    end
    function controller:SetEnabled(enabled)
        enabled = enabled == true
        config.FixLag = enabled
        self.Generation += 1
        self.Enabled = enabled
        state.FixLagEnabled = enabled
        if not enabled then
            disconnect()
            return
        end
        disconnect()
        self.MemoryBefore = memoryMb()
        self.Processed = 0
        applyRenderingSettings()
        local roots = {
            {game:GetService("ReplicatedStorage"):FindFirstChild("Assets"), false},
            {game:GetService("ReplicatedStorage"):FindFirstChild("Sounds"), false},
            {workspace, true},
            {game:GetService("Lighting"), true},
        }
        for _, entry in ipairs(roots) do watch(entry[1], entry[2]) end
        local generation = self.Generation
        task.spawn(function()
            for _, entry in ipairs(roots) do
                if not self.Enabled or self.Generation ~= generation then return end
                local root, stripTextures = entry[1], entry[2]
                if not root then continue end
                optimize(root, stripTextures)
                for index, instance in ipairs(root:GetDescendants()) do
                    if not self.Enabled or self.Generation ~= generation then return end
                    optimize(instance, stripTextures)
                    if index % 750 == 0 then task.wait() end
                end
            end
            pcall(function() collectgarbage("collect") end)
            task.wait(3)
            self.MemoryAfter = memoryMb()
            state.FixLagProcessed = self.Processed
            state.FixLagMemoryBefore = self.MemoryBefore
            state.FixLagMemoryAfter = self.MemoryAfter
            if type(options.Log) == "function" then
                options.Log(string.format(
                    "Fix Lag processed %d instances; memory %s MB -> %s MB",
                    self.Processed,
                    tostring(self.MemoryBefore or "?"),
                    tostring(self.MemoryAfter or "?")
                ))
            end
        end)
    end
    state.FixLagController = controller
    state.SetFixLag = function(enabled) controller:SetEnabled(enabled) end
    return controller
end
if game.PlaceId == 116173040971120 then
    local Players = earlyPlayers
    local ReplicatedStorage = earlyReplicatedStorage
    local TeleportService = game:GetService("TeleportService")
    local ReplicatedFirst = game:GetService("ReplicatedFirst")
    local HttpService = game:GetService("HttpService")
    local CoreGui = game:GetService("CoreGui")
    local RunService = game:GetService("RunService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local LocalPlayer = earlyLocalPlayer
    local environment = type(getgenv) == "function" and getgenv()
        or type(shared) == "table" and shared
        or type(_G) == "table" and _G
        or {}
    local function stopRuntime(runtime)
        if runtime and type(runtime.Stop) == "function" then
            pcall(runtime.Stop)
        elseif runtime then
            runtime.Running = false
        end
    end
    stopRuntime(environment.AnimeOriginsUltimate)
    local oldStandaloneMacro = environment.AOIngameMacroTest
    stopRuntime(oldStandaloneMacro)
    stopRuntime(environment.AOIngameMapScanner)
    if oldStandaloneMacro and oldStandaloneMacro.OldNamecall and type(hookmetamethod) == "function" then
        pcall(hookmetamethod, game, "__namecall", oldStandaloneMacro.OldNamecall)
    end
    local Modules = ReplicatedStorage:WaitForChild("Modules")
    local GlobalTables = require(Modules:WaitForChild("GlobalTables"))
    local GameInfo = require(Modules:WaitForChild("GameInfo"))
    local CalculateStuff = require(Modules:WaitForChild("CalculateStuff"))
    local TowerInfo = require(Modules:WaitForChild("TowerInfo"))
    local TowerAbilitiesInfo = require(Modules:WaitForChild("TowerAbilitiesInfo"))
    local ItemInfo = require(Modules:WaitForChild("ItemInfo"))
    local ProductsModule = require(Modules:WaitForChild("ProductsModule"))
    local QuestInfo = require(Modules:WaitForChild("QuestInfo"))
    local AttributeHolder = ReplicatedStorage:WaitForChild("AttributeHolder")
    local TowerRemotes = ReplicatedStorage:WaitForChild("LobbyRemotes"):WaitForChild("TowerHandlerRemotes")
    local TowerFunction = TowerRemotes:WaitForChild("TowerHandlerFunction")
    local TowerRemote = TowerRemotes:WaitForChild("TowerHandlerRemote")
    local GameRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RemoteEvent")
    local SettingsRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SettingsRemote")
    local ActRemoteEvent = ReplicatedStorage:WaitForChild("LobbyRemotes"):WaitForChild("ActRemoteEvent")
    local PassiveBarRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PassiveBarRemote")
    local TowerHandlerModuleScript = earlyPlayerScripts:WaitForChild("GameHandlerLocal"):WaitForChild("TowerHandlerLocal")
    local TowerHandlerModule = require(TowerHandlerModuleScript)
    local PreActiveHandlers = require(TowerHandlerModuleScript:WaitForChild("TowerInfoFrame"):WaitForChild("PreActiveHandlers"))
    local PlaceIDs = require(ReplicatedStorage:WaitForChild("PlaceIDs"))
    local state = {
        Running = true,
        Recording = false,
        Playing = false,
        TimelineDone = false,
        Actions = {},
        Connections = {},
        UUIDToRef = {},
        RefToUUID = {},
        RecordedPlacements = {},
        ObservedAutoModes = {},
        RecordedAutoModes = {},
        PlaybackAutoModes = {},
        PlaybackAutoAbilities = {},
        NextRef = 0,
        NativeAutomationReady = false,
        RuntimeType = "Ingame",
        ChallengeTeleporting = false,
        RiftTeleporting = false,
        DefeatTeleporting = false,
        ChallengeSweepResolved = false,
        RiftSweepResolved = false,
        NextChallengeTimerReadAt = 0,
        NextRiftTimerReadAt = 0,
    }
    environment.AnimeOriginsUltimate = state
    environment.AOIngameMacroTest = state
    state.ManualAutoUpgradeRequests = {}
    state.OriginalNativeAutoUpgrade = TowerHandlerModule.AutoUpgrade
    state.OriginalNativeStopAutoUpgrade = TowerHandlerModule.StopAutoUpgrade
    state.NativeAutoUpgradeWrapper = function(uuid, mode)
        local tower = GlobalTables.TowerDict and GlobalTables.TowerDict[uuid]
        local beforeMode = tower and (tonumber(tower.AutoUpgradeMode) or 0) or nil
        local results = table.pack(state.OriginalNativeAutoUpgrade(uuid, mode))
        tower = GlobalTables.TowerDict and GlobalTables.TowerDict[uuid]
        local afterMode = tower and (tonumber(tower.AutoUpgradeMode) or 0) or nil
        if type(state.RecordManualAutoUpgrade) == "function" then
            state.RecordManualAutoUpgrade(uuid, beforeMode, afterMode)
        end
        return table.unpack(results, 1, results.n)
    end
    state.NativeStopAutoUpgradeWrapper = function(uuid)
        local tower = GlobalTables.TowerDict and GlobalTables.TowerDict[uuid]
        local beforeMode = tower and (tonumber(tower.AutoUpgradeMode) or 0) or nil
        local results = table.pack(state.OriginalNativeStopAutoUpgrade(uuid))
        tower = GlobalTables.TowerDict and GlobalTables.TowerDict[uuid]
        local afterMode = tower and (tonumber(tower.AutoUpgradeMode) or 0) or nil
        if type(state.RecordManualAutoUpgrade) == "function" then
            state.RecordManualAutoUpgrade(uuid, beforeMode, afterMode)
        end
        return table.unpack(results, 1, results.n)
    end
    TowerHandlerModule.AutoUpgrade = state.NativeAutoUpgradeWrapper
    TowerHandlerModule.StopAutoUpgrade = state.NativeStopAutoUpgradeWrapper
    local RewardPopupModule = require(Modules:WaitForChild("VisualStuff"):WaitForChild("Popup"))
    state.OriginalRewardPopup = RewardPopupModule.Popup
    state.SkipRewardPopup = function() end
    RewardPopupModule.Popup = state.SkipRewardPopup
    local function nativeLoadingComplete()
        local loading = ReplicatedFirst:FindFirstChild("Loading")
        return game:IsLoaded()
            and LocalPlayer:GetAttribute("DataLoaded") == true
            and LocalPlayer:GetAttribute("Loaded") == true
            and LocalPlayer:GetAttribute("LoadingScreenLoaded") == true
            and loading ~= nil and loading:GetAttribute("ModulesInitialised") == true
    end
    state.NativeLoadingComplete = nativeLoadingComplete
    local function nativeGameplayCoreReady()
        return LocalPlayer:GetAttribute("DataLoaded") == true
            and type(GlobalTables.PlayerData) == "table" and next(GlobalTables.PlayerData) ~= nil
            and type(GlobalTables.Inventory) == "table" and next(GlobalTables.Inventory) ~= nil
            and type(GlobalTables.CurrentGame) == "table"
            and AttributeHolder:GetAttribute("GameMode") ~= nil
            and AttributeHolder:GetAttribute("WorldName") ~= nil
            and earlyPlayerGui:FindFirstChild("GameUI") ~= nil
            and earlyPlayerScripts:FindFirstChild("GameHandlerLocal") ~= nil
            and (workspace:FindFirstChild("PlacementParts") ~= nil or workspace:FindFirstChild("Map") ~= nil)
    end
    state.NativeGameplayCoreReady = nativeGameplayCoreReady
    state.BrokenHotbarWatchdog = function()
        local brokenSince
        while state.Running and not state.BrokenLoadLeaving do
            local gameUI = earlyPlayerGui:FindFirstChild("GameUI")
            local startFrame = gameUI and gameUI:FindFirstChild("StartSelectFrame")
            local selectUnits = startFrame and startFrame:FindFirstChild("SelectUnits")
            local toolbar = gameUI and gameUI:FindFirstChild("BottomUI")
            toolbar = toolbar and toolbar:FindFirstChild("TowersToolbar")
            local occupied = 0
            if toolbar then
                for index = 1, 6 do
                    local slot = toolbar:FindFirstChild("Tower" .. index)
                    local image = slot and slot:FindFirstChild("ImageLabel")
                    local empty = slot and slot:FindFirstChild("Empty")
                    if image and image.Visible and not (empty and empty.Visible) then
                        occupied += 1
                    end
                end
            end
            local broken = startFrame ~= nil and startFrame.Visible
                and selectUnits ~= nil and selectUnits.Visible
                and toolbar ~= nil and occupied == 0
                and not GlobalTables.GameStarted
                and type(GlobalTables.CurrentGame) == "table"
                and (tonumber(AttributeHolder:GetAttribute("Wave")) or 0) == 0
            if broken then
                brokenSince = brokenSince or os.clock()
                if os.clock() - brokenSince >= 10 then
                    state.BrokenLoadLeaving = true
                    leaveBrokenGameLoad("Select Units remained visible with an empty hotbar")
                    return
                end
            else
                brokenSince = nil
            end
            task.wait(0.5)
        end
    end
    task.spawn(state.BrokenHotbarWatchdog)
    local function dismissStaleTeleportGui()
        local deadline = os.clock() + 180
        local ready = false
        repeat
            ready = nativeLoadingComplete()
                and AttributeHolder:GetAttribute("GameMode") ~= nil
                and AttributeHolder:GetAttribute("WorldName") ~= nil
                and earlyPlayerGui:FindFirstChild("GameUI") ~= nil
                and (workspace:FindFirstChild("PlacementParts") ~= nil or workspace:FindFirstChild("Map") ~= nil)
            if not ready then task.wait(0.25) end
        until ready or not state.Running or os.clock() >= deadline
        if not ready or not state.Running then return end
        task.wait(2)
        pcall(function()
            local arriving = TeleportService:GetArrivingTeleportGui()
            if arriving then arriving:Destroy() end
        end)
        for _, parent in ipairs({CoreGui, earlyPlayerGui}) do
            for _, instance in ipairs(parent:GetDescendants()) do
                if instance:IsA("TextLabel") and string.find(tostring(instance.Text), "Traveling to", 1, true) then
                    local gui = instance:FindFirstAncestorOfClass("ScreenGui")
                    if gui then gui:Destroy() end
                    break
                end
            end
        end
    end
    state.DismissStaleTeleportGui = dismissStaleTeleportGui
    task.spawn(dismissStaleTeleportGui)
    local scanner = {Running = true, Current = nil, LastSignature = nil}
    environment.AOIngameMapScanner = scanner
    local rootFolder = "AnimeOrigins_" .. LocalPlayer.UserId
    local autoSaveFolder = rootFolder .. "/AutoSave"
    local configsFolder = rootFolder .. "/Configs"
    local macrosFolder = rootFolder .. "/macros"
    local exportsFolder = rootFolder .. "/Exports"
    local logsFolder = rootFolder .. "/Logs"
    local mapPath = autoSaveFolder .. "/current-map.json"
    local mapLogPath = logsFolder .. "/ingame-map.log"
    local macroLogPath = logsFolder .. "/macro-test.log"
    local function ensureFolders()
        if type(makefolder) ~= "function" or type(isfolder) ~= "function" then
            return
        end
        for _, folder in ipairs({rootFolder, autoSaveFolder, configsFolder, macrosFolder, exportsFolder, logsFolder}) do
            if not isfolder(folder) then
                pcall(makefolder, folder)
            end
        end
    end
    local function appendLog(prefix, path, message)
        local line = string.format("[%s] %s", os.date("!%Y-%m-%dT%H:%M:%SZ"), message)
        warn(prefix .. " " .. line)
        if type(appendfile) == "function" then
            task.defer(function()
                ensureFolders()
                pcall(appendfile, path, line .. "\n")
            end)
        end
    end
    local function teleportData()
        local ok, data = pcall(function()
            return TeleportService:GetLocalPlayerTeleportData()
        end)
        return ok and type(data) == "table" and data or {}
    end
    local function safeAttributes(instance)
        local found = {}
        for key, value in pairs(instance:GetAttributes()) do
            local normalized = string.lower(tostring(key))
            if string.find(normalized, "map", 1, true)
                or string.find(normalized, "world", 1, true)
                or string.find(normalized, "act", 1, true)
                or string.find(normalized, "mode", 1, true)
                or string.find(normalized, "difficulty", 1, true)
                or string.find(normalized, "wave", 1, true)
                or string.find(normalized, "state", 1, true) then
                found[key] = value
            end
        end
        return found
    end
    local function scanValueObjects()
        local values = {}
        local count = 0
        for _, root in ipairs({workspace, ReplicatedStorage, LocalPlayer}) do
            for _, instance in ipairs(root:GetDescendants()) do
                if instance:IsA("ValueBase") then
                    local name = string.lower(instance.Name)
                    if string.find(name, "map", 1, true)
                        or string.find(name, "world", 1, true)
                        or string.find(name, "act", 1, true)
                        or string.find(name, "mode", 1, true)
                        or string.find(name, "difficulty", 1, true)
                        or string.find(name, "wave", 1, true)
                        or string.find(name, "state", 1, true) then
                        values[instance:GetFullName()] = instance.Value
                        count += 1
                        if count >= 30 then
                            return values
                        end
                    end
                end
            end
        end
        return values
    end
    local function buildSnapshot()
        local data = teleportData()
        local gameMode = AttributeHolder:GetAttribute("GameMode") or data.GameMode or data.Gamemode or data.Mode
        local worldName = AttributeHolder:GetAttribute("WorldName") or data.WorldName or data.MapName or data.Map
        local act = AttributeHolder:GetAttribute("Act") or data.Act or data.ActName
        local difficulty = AttributeHolder:GetAttribute("Difficulty") or data.Difficulty
        local canonicalKey = gameMode and worldName and act and difficulty
            and table.concat({tostring(gameMode), tostring(worldName), tostring(act), tostring(difficulty)}, "|") or nil
        return {
            Timestamp = os.time(), PlaceId = game.PlaceId, UniverseId = game.GameId, JobId = game.JobId,
            PlaceRole = "GamePlace", IsReservedServer = data.ReservedCode ~= nil,
            GameMode = gameMode, WorldName = worldName, DisplayWorldName = data.DisplayWorldName,
            Act = act, DisplayAct = data.DisplayAct, Difficulty = difficulty,
            CanonicalMacroKey = canonicalKey, TeleportData = data,
            Attributes = {
                Game = safeAttributes(game), Workspace = safeAttributes(workspace), Player = safeAttributes(LocalPlayer),
            },
            ValueObjects = canonicalKey and {} or scanValueObjects(),
        }
    end
    local function snapshotSignature(snapshot)
        return table.concat({
            tostring(snapshot.PlaceId), tostring(snapshot.GameMode), tostring(snapshot.WorldName),
            tostring(snapshot.Act), tostring(snapshot.Difficulty),
            tostring(snapshot.Attributes.Player.GameState), tostring(snapshot.Attributes.Player.Wave),
        }, "|")
    end
    local function scan(reason)
        local snapshot = buildSnapshot()
        local signature = snapshotSignature(snapshot)
        if signature ~= scanner.LastSignature then
            scanner.LastSignature = signature
            scanner.Current = snapshot
            environment.AnimeOriginsCurrentMap = snapshot
            if type(writefile) == "function" then
                ensureFolders()
                pcall(writefile, mapPath, HttpService:JSONEncode(snapshot))
            end
            appendLog("[AO Map Scanner]", mapLogPath, string.format(
                "[place=%s job=%s] %s | role=%s | mode=%s | world=%s | act=%s | difficulty=%s | macroKey=%s",
                tostring(game.PlaceId), game.JobId ~= "" and game.JobId or "none", reason,
                snapshot.PlaceRole, tostring(snapshot.GameMode), tostring(snapshot.WorldName),
                tostring(snapshot.Act), tostring(snapshot.Difficulty), tostring(snapshot.CanonicalMacroKey)
            ))
        end
        return snapshot
    end
    scanner.ScanNow = function()
        return scan("manual scan")
    end
    local function currentMap()
        local scanned = environment.AnimeOriginsCurrentMap
        local data = teleportData()
        scanned = type(scanned) == "table" and scanned or {}
        local mode = AttributeHolder:GetAttribute("GameMode") or data.GameMode or data.Gamemode or scanned.GameMode or "UnknownMode"
        local world = AttributeHolder:GetAttribute("WorldName") or data.WorldName or data.MapName or scanned.WorldName or "UnknownWorld"
        local act = AttributeHolder:GetAttribute("Act") or data.Act or data.ActName or scanned.Act or "UnknownAct"
        local difficulty = AttributeHolder:GetAttribute("Difficulty") or data.Difficulty or scanned.Difficulty or "UnknownDifficulty"
        return {
            PlaceId = game.PlaceId, GameMode = mode, WorldName = world, Act = act, Difficulty = difficulty,
            CanonicalMacroKey = table.concat({mode, world, act, difficulty}, "|"),
        }
    end
    local mapInfo
    local macroKey
    local macroPath
    local function refreshMapIdentity()
        mapInfo = currentMap()
        macroKey = mapInfo.CanonicalMacroKey
        macroPath = macrosFolder .. "/" .. string.gsub(macroKey, "[^%w%-_]", "_") .. ".json"
        state.Map, state.MacroKey, state.MacroPath = mapInfo, macroKey, macroPath
    end
    refreshMapIdentity()
    local function stageSignature(info)
        return table.concat({tostring(info.GameMode), tostring(info.WorldName), tostring(info.Act), tostring(info.Difficulty)}, "|")
    end
    state.StageSignature = stageSignature(mapInfo)
    local function autoStoryConfig()
        local path = autoSaveFolder .. "/lobby.json"
        if type(isfile) ~= "function" or not isfile(path) then
            return nil
        end
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        return ok and type(decoded) == "table" and decoded or nil
    end
    local ingameDefaults = {
        AutoClaim = false, ClaimQuests = true, ClaimDaily = true, ClaimPlaytime = true,
        ClaimBattlepass = true, ClaimLevelMilestones = true, ClaimTowerIndex = true,
        ClaimGroupReward = true, ClaimInfinityRank = true, AntiAFK = true, AutoReconnect = true, MobileButton = true,
        FPSLimit = 60, FixLag = false,
        AutoPlayMacro = false, AutoRestartInfinite = false, AutoRestartInfiniteWave = 100,
        HidePlayerNames = false, BlackScreen = true, BlackScreenVersion = AO_BLACK_SCREEN_VERSION,
        AutoSummon = false, AutoSummonUnits = {}, AutoSummonAmount = "Max", AutoSummonReserve = 0,
        AutoJoin = false, AutoArtifact = false, ArtifactName = "", ArtifactRewardPriority = {},
        AutoReplayGame = false,
        AutoCardPick = false, CardPriority = {}, AutoFeed = false,
        FeedPlans = {},
        AutoQuest = false, AutoQuestSummon = false,
        AutoChallenge = false, AutoChallengeLeave = false, ChallengeFlowVersion = 0,
        ChallengeLeaveAfterMatch = false,
        ChallengeTypes = {"Daily", "Normal"}, ChallengeNextCheckAt = 0,
        ChallengeAttemptedSeeds = {}, ChallengeLosses = {}, ChallengeRuntimeTarget = nil,
        ChallengeLastInfo = {}, ChallengeMacroByWorld = {},
        QuestWorld = "WestCity", QuestAct = "1", QuestDifficulty = "Normal",
        AutoStory = false, AutoStoryDifficulty = "Normal", StoryMacroByWorld = {},
        GameMode = "Story", World = "WestCity", Act = "1", Difficulty = "Normal",
        AutoCraft = false, CraftItems = {}, AutoGoldShop = false, GoldShopItems = {},
        AutoShops = {}, ShopItems = {},
        AutoRedeemCodes = false, Codes = "", WebhookUrl = "",
        WebhookCompletionEnabled = false, WebhookUnitEnabled = false,
        AutoRift = false, AutoRiftLeave = false, RiftMacro = "",
        AutoFrag = false, AutoClash = false, AutoParry = false, AutoFindBook = false, AutoChest = false,
        AutoYutaAbility = false, YutaAutoAbilities = {}, AutoMadaraMaxBonus = false,
    }
    local function normalizeIngameConfig(config)
        config = type(config) == "table" and config or {}
        aoMigrateBlackScreen(config)
        for key, default in pairs(ingameDefaults) do
            if config[key] == nil then
                config[key] = type(default) == "table" and {} or default
            end
        end
        for _, key in ipairs({
            "AutoClaim", "ClaimQuests", "ClaimDaily", "ClaimPlaytime", "ClaimBattlepass",
            "ClaimLevelMilestones", "ClaimTowerIndex", "ClaimGroupReward", "ClaimInfinityRank",
            "AntiAFK", "AutoReconnect", "MobileButton", "FixLag", "AutoPlayMacro", "AutoRestartInfinite", "HidePlayerNames", "BlackScreen",
            "AutoSummon", "AutoJoin", "AutoArtifact", "AutoCardPick", "AutoReplayGame", "AutoQuest", "AutoQuestSummon", "AutoChallenge", "AutoChallengeLeave", "ChallengeLeaveAfterMatch",
            "AutoStory", "AutoCraft",
            "AutoGoldShop", "AutoRedeemCodes", "WebhookCompletionEnabled", "WebhookUnitEnabled",
            "AutoRift", "AutoRiftLeave", "AutoFrag", "AutoClash", "AutoParry", "AutoFindBook", "AutoChest", "AutoYutaAbility", "AutoMadaraMaxBonus",
        }) do
            config[key] = config[key] == true
        end
        for _, key in ipairs({"CraftItems", "GoldShopItems"}) do
            local normalized, seen = {}, {}
            for itemKey, itemValue in pairs(type(config[key]) == "table" and config[key] or {}) do
                local item = type(itemKey) == "number" and itemValue or itemValue and itemKey or nil
                item = item and tostring(item) or nil
                if item and item ~= "" and not seen[item] then
                    seen[item] = true
                    table.insert(normalized, item)
                end
            end
            table.sort(normalized)
            config[key] = normalized
        end
        config.AutoShops = type(config.AutoShops) == "table" and config.AutoShops or {}
        config.ShopItems = type(config.ShopItems) == "table" and config.ShopItems or {}
        config.ShopItems.GoldShop = type(config.ShopItems.GoldShop) == "table" and config.ShopItems.GoldShop or {}
        if config.AutoGoldShop then config.AutoShops.GoldShop = true end
        if next(config.ShopItems.GoldShop) == nil and #config.GoldShopItems > 0 then
            config.ShopItems.GoldShop = table.clone(config.GoldShopItems)
        end
        local storyMacros = {}
        for world, macro in pairs(type(config.StoryMacroByWorld) == "table" and config.StoryMacroByWorld or {}) do
            if type(world) == "string" and type(macro) == "string" and macro ~= "" and macro ~= "None" then
                storyMacros[world] = macro
            end
        end
        config.StoryMacroByWorld = storyMacros
        local units, seen = {}, {}
        for key, value in pairs(type(config.AutoSummonUnits) == "table" and config.AutoSummonUnits or {}) do
            local unit = type(key) == "number" and value or value and key or nil
            unit = unit and tostring(unit):match("%[(.-)%]$") or unit and tostring(unit) or nil
            if unit and unit ~= "" and aoIsBaseMythic(TowerInfo, unit) and not seen[unit] then
                seen[unit] = true
                table.insert(units, unit)
            end
        end
        table.sort(units)
        config.AutoSummonUnits = units
        config.Codes, config.WebhookUrl = tostring(config.Codes or ""), tostring(config.WebhookUrl or "")
        config.AutoSummonAmount = table.find({"1", "10", "50", "Max"}, tostring(config.AutoSummonAmount))
            and tostring(config.AutoSummonAmount) or "Max"
        config.AutoSummonReserve = math.max(0, math.floor(tonumber(config.AutoSummonReserve) or 0))
        config.AutoRestartInfiniteWave = math.max(1, math.floor(tonumber(config.AutoRestartInfiniteWave) or 100))
        config.FPSLimit = math.clamp(math.floor(tonumber(config.FPSLimit) or 60), 10, 240)
        local challengeTypes, challengeSeen = {}, {}
        for key, value in pairs(type(config.ChallengeTypes) == "table" and config.ChallengeTypes or {}) do
            local kind = type(key) == "number" and value or value and key or nil
            kind = tostring(kind or "")
            if (kind == "Daily" or kind == "Normal") and not challengeSeen[kind] then
                challengeSeen[kind] = true
                table.insert(challengeTypes, kind)
            end
        end
        config.ChallengeTypes = challengeTypes
        if tonumber(config.ChallengeFlowVersion) ~= 2 then
            config.ChallengeAttemptedSeeds, config.ChallengeLosses = {}, {}
        end
        config.ChallengeFlowVersion = 2
        config.ChallengeNextCheckAt = math.max(0, math.floor(tonumber(config.ChallengeNextCheckAt) or 0))
        config.ChallengeAttemptedSeeds = type(config.ChallengeAttemptedSeeds) == "table" and config.ChallengeAttemptedSeeds or {}
        config.ChallengeLosses = type(config.ChallengeLosses) == "table" and config.ChallengeLosses or {}
        config.ChallengeLastInfo = type(config.ChallengeLastInfo) == "table" and config.ChallengeLastInfo or {}
        local challengeMacros = {}
        for world, macro in pairs(type(config.ChallengeMacroByWorld) == "table" and config.ChallengeMacroByWorld or {}) do
            if type(world) == "string" and type(macro) == "string" and macro ~= "" and macro ~= "None" then
                challengeMacros[world] = macro
            end
        end
        config.ChallengeMacroByWorld = challengeMacros
        config.ChallengeRuntimeTarget = config.AutoChallenge and type(config.ChallengeRuntimeTarget) == "table"
            and config.ChallengeRuntimeTarget.Owner == "Challenge" and config.ChallengeRuntimeTarget or nil
        config.QuestWorld, config.QuestAct = tostring(config.QuestWorld or "WestCity"), tostring(config.QuestAct or "1")
        config.World = tostring(config.World or (config.GameMode == "WorldBoss" and "Igris" or "WestCity"))
        config.Act = tostring(config.Act or (config.GameMode == "WorldBoss" and "None" or "1"))
        config.GameMode = table.find({"Story", "Infinite", "Raid", "Rift", "Legend", "Artifact", "Trial", "ReZero", "WorldBoss"}, tostring(config.GameMode)) and tostring(config.GameMode) or "Story"
        config.ArtifactName = tostring(config.ArtifactName or "")
        if config.GameMode == "Artifact" then
            if not (ItemInfo.Artifacts and ItemInfo.Artifacts[config.ArtifactName]) then
                config.ArtifactName = ItemInfo.Artifacts and ItemInfo.Artifacts[config.World] and tostring(config.World) or ""
            end
            if config.ArtifactName == "" then
                local candidates = {}
                for name, info in pairs(type(ItemInfo.Artifacts) == "table" and ItemInfo.Artifacts or {}) do
                    local selectInfo = type(info) == "table" and info.MapSelectInfo
                    if type(selectInfo) == "table" and tostring(selectInfo.WorldName) == tostring(mapInfo.WorldName)
                        and tostring(selectInfo.Act) == tostring(mapInfo.Act)
                        and tostring(selectInfo.Difficulty) == tostring(mapInfo.Difficulty) then
                        table.insert(candidates, tostring(name))
                    end
                end
                table.sort(candidates)
                config.ArtifactName = candidates[1] or ""
            end
            if config.ArtifactName ~= "" then config.World = config.ArtifactName end
        end
        config.QuestDifficulty = table.find({"Normal", "Hard"}, tostring(config.QuestDifficulty)) and tostring(config.QuestDifficulty) or "Normal"
        config.Difficulty = table.find({"Normal", "Hard", "None"}, tostring(config.Difficulty)) and tostring(config.Difficulty) or (config.GameMode == "WorldBoss" and "None" or "Normal")
        config.CardPriority = type(config.CardPriority) == "table" and config.CardPriority or {}
        config.ArtifactRewardPriority = type(config.ArtifactRewardPriority) == "table" and config.ArtifactRewardPriority or {}
        config.FeedPlans = type(config.FeedPlans) == "table" and config.FeedPlans or {}
        local yutaAbilities, yutaSeen = {}, {}
        for key, value in pairs(type(config.YutaAutoAbilities) == "table" and config.YutaAutoAbilities or {}) do
            local ability = type(key) == "number" and value or value and key or nil
            ability = ability and tostring(ability) or nil
            local info = ability and TowerAbilitiesInfo.Actives[ability]
            if info and info.CanCopy == true and info.AutoUse ~= false and not yutaSeen[ability] then
                yutaSeen[ability] = true
                table.insert(yutaAbilities, ability)
            end
        end
        table.sort(yutaAbilities)
        config.YutaAutoAbilities = yutaAbilities
        if config.GameMode == "Trial" and table.find({"PleiadesSand", "PleiadesLibrary"}, config.World) then
            config.GameMode = "ReZero"
        elseif config.GameMode == "ReZero" and config.World == "PleiadesGrass" then
            config.GameMode = "Trial"
        end
        if config.GameMode == "Infinite" then
            config.Act, config.Difficulty = "Infinite", "Hard"
        elseif config.GameMode == "Raid" or config.GameMode == "Legend" or config.GameMode == "Artifact" then
            config.Difficulty = "Hard"
        elseif config.GameMode == "Trial" then
            if config.World == "PleiadesGrass" then
                config.Act = "Trial"
            else
                config.World, config.Act = "SandVillage", "MadaraStage"
            end
            config.Difficulty = "None"
        elseif config.GameMode == "ReZero" then
            config.World = table.find({"PleiadesSand", "PleiadesLibrary"}, config.World) and config.World or "PleiadesSand"
            config.Act = table.find({"1", "2"}, config.Act) and config.Act or "1"
            config.Difficulty = "None"
        elseif config.GameMode == "WorldBoss" then
            config.World, config.Act, config.Difficulty = "Igris", "None", "None"
        end
        config.QuestRuntimeTarget = config.AutoQuest and type(config.QuestRuntimeTarget) == "table"
            and config.QuestRuntimeTarget.Owner == "Quest" and config.QuestRuntimeTarget or nil
        return config
    end
    local ingameConfig = normalizeIngameConfig(autoStoryConfig())
    state.Config = ingameConfig
    state.ReplayArtifact = function(allowed)
        local selected = tostring(ingameConfig.ArtifactName or "")
        local owned = tonumber((((GlobalTables.Inventory or {}).Artifacts) or {})[selected]) or 0
        if selected == "" or owned <= 0 then return nil end
        if type(allowed) == "table" and not table.find(allowed, selected) and allowed[selected] ~= true then return nil end
        return selected
    end
    state.RiftReplayAvailable = function()
        local ok, available = pcall(function()
            local rotations = require(ReplicatedStorage.LobbyModules.TimeRotations)
            local general = require(Modules.GeneralModule)
            local _, elapsed = general.CalculateTimeRotation(rotations.Rift)
            return rotations.Rift - elapsed < rotations.RiftDuration
        end)
        if ok then return available == true end
        local timer = aoReadRiftTimer(LocalPlayer.UserId)
        local closeAt = timer and tonumber(timer.RiftCloseAt) or 0
        return closeAt > os.time()
    end
    do
        local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("MapSelectFunction", 10)
        if remote then
            local original
            local callbackGetter = type(getcallbackvalue) == "function" and getcallbackvalue
                or type(environment.getcallbackvalue) == "function" and environment.getcallbackvalue
            if callbackGetter then
                pcall(function() original = callbackGetter(remote, "OnClientInvoke") end)
            end
            state.MapSelectInvokeWrapper = function(action, ...)
                if action == "PromptArtifactSelection" and ingameConfig.AutoReplayGame == true then
                    local choice = state.ReplayArtifact((...))
                    if choice then return choice end
                end
                if type(original) == "function" then return original(action, ...) end
            end
            local ok, err = pcall(function()
                remote.OnClientInvoke = state.MapSelectInvokeWrapper
            end)
            if ok then
                state.OriginalMapSelectInvoke = original
                state.MapSelectFunction = remote
                state.MapSelectHookInstalled = true
            else
                state.MapSelectInvokeWrapper = nil
                warn("[AnimeOriginsUltimate] MapSelectFunction hook failed: " .. tostring(err))
            end
        end
    end
    state.PendingChallengeLeave = ingameConfig.ChallengeLeaveAfterMatch == true
    state.SetFPSLimit = function(value)
        ingameConfig.FPSLimit = math.clamp(math.floor(tonumber(value) or 60), 10, 240)
        local setter = type(setfpscap) == "function" and setfpscap or environment.setfpscap
        if type(setter) == "function" then pcall(setter, ingameConfig.FPSLimit) end
    end
    state.SetFPSLimit(ingameConfig.FPSLimit)
    aoInstallAutoReconnect({
        State = state,
        LocalPlayer = LocalPlayer,
        LobbyPlace = PlaceIDs.LobbyPlace,
        Enabled = function() return ingameConfig.AutoReconnect end,
        Log = function(message) warn("[AnimeOriginsUltimate] " .. message) end,
    })
    state.InitialChallengeTarget = type(ingameConfig.ChallengeRuntimeTarget) == "table"
        and ingameConfig.ChallengeRuntimeTarget.Owner == "Challenge" and ingameConfig.ChallengeRuntimeTarget or nil
    local blackScreen = aoCreateBlackScreenController({
        State = state, LocalPlayer = LocalPlayer, GlobalTables = GlobalTables, TowerInfo = TowerInfo, ItemInfo = ItemInfo,
        MapInfo = function()
            return {
                Map = AttributeHolder:GetAttribute("WorldName") or mapInfo.WorldName or "Unknown",
                Mode = AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "Unknown",
                Wave = AttributeHolder:GetAttribute("Wave") or "-",
            }
        end,
    })
    local hiddenNameGuis = {}
    local function isCharacterBillboard(instance)
        if not instance:IsA("BillboardGui") then return false end
        local ancestor = instance.Parent
        while ancestor and ancestor ~= workspace do
            if ancestor:IsA("Model") and Players:GetPlayerFromCharacter(ancestor) then return true end
            ancestor = ancestor.Parent
        end
        return false
    end
    local function hideNameGui(instance)
        local namedOverhead = (instance.Name == "PlayerOverhead" or instance.Name == "NpcOverhead")
            and (instance:IsA("BillboardGui") or instance:IsA("ScreenGui") or instance:IsA("SurfaceGui"))
        if (namedOverhead or isCharacterBillboard(instance)) and instance.Enabled then
            hiddenNameGuis[instance] = true
            instance.Enabled = false
        end
    end
    function state.SetHidePlayerNames(enabled)
        ingameConfig.HidePlayerNames = enabled == true
        if ingameConfig.HidePlayerNames then
            local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            if playerGui then for _, instance in ipairs(playerGui:GetDescendants()) do hideNameGui(instance) end end
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then for _, instance in ipairs(player.Character:GetDescendants()) do hideNameGui(instance) end end
            end
        else
            for instance in pairs(hiddenNameGuis) do
                if instance.Parent then pcall(function() instance.Enabled = true end) end
                hiddenNameGuis[instance] = nil
            end
        end
    end
    local function destroyBlackScreen()
        blackScreen:SetEnabled(false)
    end
    function state.SetBlackScreen(enabled, showImmediately)
        ingameConfig.BlackScreen = enabled == true
        blackScreen:SetEnabled(ingameConfig.BlackScreen, showImmediately)
    end
    local function createIngameMobileButton()
        for _, parent in ipairs({CoreGui, LocalPlayer:WaitForChild("PlayerGui")}) do
            local old = parent:FindFirstChild("AnimeOriginsMobileButton")
            if old then old:Destroy() end
        end
        local gui = Instance.new("ScreenGui")
        gui.Name, gui.ResetOnSpawn, gui.IgnoreGuiInset, gui.DisplayOrder = "AnimeOriginsMobileButton", false, true, 2000
        local button = Instance.new("ImageButton")
        button.Name, button.AnchorPoint, button.Position = "OpenUI", Vector2.new(1, 0.5), UDim2.new(1, -14, 0.38, 0)
        button.Size, button.BackgroundColor3, button.BorderSizePixel = UDim2.fromOffset(45, 45), Color3.fromRGB(30, 30, 30), 0
        button.ScaleType, button.Parent = Enum.ScaleType.Crop, gui
        applyGameIcon(button)
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
        table.insert(state.Connections, button.Activated:Connect(function()
            if state.Window then
                local fluentGui = state.FluentScreenGui
                if fluentGui and fluentGui.Parent and not fluentGui.Enabled then
                    fluentGui.Enabled = true
                else
                    pcall(function() state.Window:Minimize() end)
                end
            elseif state.Gui then
                state.Gui.Enabled = not state.Gui.Enabled
            end
        end))
        local ok = pcall(function() gui.Parent = CoreGui end)
        if not ok then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
        state.MobileButton = gui
        gui.Enabled = ingameConfig.MobileButton == true
    end
    local function saveLobbyConfig(config)
        if type(config) ~= "table" or type(writefile) ~= "function" then
            return
        end
        ensureFolders()
        pcall(writefile, autoSaveFolder .. "/lobby.json", HttpService:JSONEncode(config))
    end
    saveLobbyConfig(ingameConfig)
    environment.AnimeOriginsIngameDefaults = ingameDefaults
    environment.AnimeOriginsIngameConfig = ingameConfig
    environment.AnimeOriginsNormalizeIngame = normalizeIngameConfig
    environment.AnimeOriginsSaveLobbyConfig = saveLobbyConfig
    AOCreateFixLagController({
        State = state,
        Config = ingameConfig,
        InGame = true,
        Log = function(message) warn("[AnimeOriginsUltimate] " .. message) end,
    }):SetEnabled(ingameConfig.FixLag)
    state.SetFPSLimit(ingameConfig.FPSLimit)
    table.insert(state.Connections, ReplicatedStorage.Remotes.CardSelection.OnClientEvent:Connect(function(action, cards)
        if action ~= "StartModifierSelection" or type(cards) ~= "table"
            or not (ingameConfig.AutoCardPick or state.AutoCardPickOverride) then return end
        local pick
        for _, wanted in ipairs(ingameConfig.CardPriority or {}) do
            if cards[wanted] ~= nil then
                pick = wanted
                break
            end
        end
        if not pick then
            for modifier in pairs(cards) do
                pick = modifier
                break
            end
        end
        if pick then
            ReplicatedStorage.Remotes.CardSelection:FireServer("ModifierSelectionVote", pick)
        end
    end))
    state.CardPriorityOptions = {}
    for key in pairs(require(Modules:WaitForChild("ModifiersInfo"))) do
        if type(key) == "string" then table.insert(state.CardPriorityOptions, key) end
    end
    table.sort(state.CardPriorityOptions)
    state.ArtifactRewardOptions = {}
    state.ArtifactRewardOptionSet = {}
    for _, artifact in pairs(ItemInfo.Artifacts or {}) do
        for _, rewards in pairs(type(artifact.ArtifactRewards) == "table" and artifact.ArtifactRewards or {}) do
            for _, reward in pairs(type(rewards) == "table" and rewards or {}) do
                local option = tostring(reward.ItemType) .. "|" .. tostring(reward.ItemName)
                if not state.ArtifactRewardOptionSet[option] then
                    state.ArtifactRewardOptionSet[option] = true
                    table.insert(state.ArtifactRewardOptions, option)
                end
            end
        end
    end
    table.sort(state.ArtifactRewardOptions)
    local function questTargetMatches(config)
        local target = config and config.AutoQuest and config.QuestRuntimeTarget
        if type(target) ~= "table" or target.Owner ~= "Quest" then
            return nil
        end
        return tostring(target.GameMode) == tostring(mapInfo.GameMode)
            and tostring(target.World) == tostring(mapInfo.WorldName)
            and tostring(target.Act) == tostring(mapInfo.Act)
            and tostring(target.Difficulty) == tostring(mapInfo.Difficulty) and target or nil
    end
    local function challengeTargetMatches(config)
        local target = config and config.ChallengeRuntimeTarget or state.InitialChallengeTarget
        if type(target) ~= "table" or target.Owner ~= "Challenge" then
            if not string.find(tostring(mapInfo.GameMode), "Challenge") or not (config and config.AutoChallenge) then return nil end
            for _, kind in ipairs({"Daily", "Normal"}) do
                local entry = type(config.ChallengeLastInfo) == "table" and config.ChallengeLastInfo[kind] or nil
                if type(entry) == "table" and tostring(entry.World) == tostring(mapInfo.WorldName)
                    and tostring(entry.Act) == tostring(mapInfo.Act)
                    and tostring(entry.Difficulty) == tostring(mapInfo.Difficulty) then
                    target = {
                        Owner = "Challenge", ChallengeKind = kind, ChallengeSeed = entry.Seed,
                        GameMode = "Challenge", World = entry.World, Act = entry.Act, Difficulty = entry.Difficulty,
                    }
                    break
                end
            end
            target = target or {
                Owner = "Challenge", ChallengeKind = "Normal",
                GameMode = "Challenge", World = mapInfo.WorldName,
                Act = mapInfo.Act, Difficulty = mapInfo.Difficulty,
            }
        end
        if type(target) ~= "table" then return nil end
        return tostring(target.GameMode) == tostring(mapInfo.GameMode)
            and tostring(target.World) == tostring(mapInfo.WorldName)
            and tostring(target.Act) == tostring(mapInfo.Act)
            and tostring(target.Difficulty) == tostring(mapInfo.Difficulty) and target or nil
    end
    local function returnToLobbyForChallenge(config, target, options)
        options = type(options) == "table" and options or {}
        local forRift = options.Rift == true
        if state.ChallengeTeleporting or state.RiftTeleporting then return end
        if forRift then
            state.RiftTeleporting = true
        else
            state.ChallengeTeleporting = true
            state.PendingChallengeLeave = false
            if type(config) == "table" then config.ChallengeLeaveAfterMatch = false end
        end
        SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
        SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
        if target then
            config.ChallengeAttemptedSeeds = type(config.ChallengeAttemptedSeeds) == "table" and config.ChallengeAttemptedSeeds or {}
            if options.MarkAttempted then
                config.ChallengeAttemptedSeeds[tostring(target.ChallengeKind or "Normal")] = target.ChallengeSeed
            end
            config.ChallengeRuntimeTarget = nil
            config.ChallengeNextCheckAt = 0
        end
        if options.DisableAutoChallenge then config.AutoChallenge = false end
        saveLobbyConfig(config)
        pcall(function() GameRemote:FireServer("TeleportToLobby") end)
        pcall(function() ActRemoteEvent:FireServer("ReturnToLobby") end)
        task.spawn(function()
            task.wait(0.6)
            local ok, err = pcall(TeleportService.Teleport, TeleportService, 129932912185311, LocalPlayer)
            if not ok then warn("[AnimeOriginsUltimate] Challenge lobby teleport fallback failed: " .. tostring(err)) end
        end)
    end
    local function updateAutoLeaveStatus(st, cfg, mInfo, player)
        local paragraph = st and st.AutoLeaveStatus
        if paragraph then
            local timer = aoReadChallengeTimer(player and player.UserId or 0)
            local nextCheck = timer and tonumber(timer.NextCheckAt) or 0
            if nextCheck <= 0 then nextCheck = tonumber(cfg and cfg.ChallengeNextCheckAt) or 0 end
            local text
            local currentMode = tostring(AttributeHolder:GetAttribute("GameMode") or (mInfo and mInfo.GameMode) or "")
            local inChallenge = string.find(currentMode, "Challenge", 1, true) ~= nil
            local inRift = string.find(currentMode, "Rift", 1, true) ~= nil
            if not (cfg and cfg.AutoChallengeLeave) then
                text = "Auto Leave disabled."
            elseif inChallenge or inRift then
                text = "In " .. currentMode .. " map (Auto Leave paused until the match finishes)."
            elseif st.PendingChallengeLeave then
                text = "Challenge due - returning to lobby after this match finishes."
            elseif nextCheck <= 0 then
                text = "Enabled but not scheduled."
            elseif os.time() >= nextCheck then
                text = "DUE NOW - returning to lobby."
            else
                text = string.format("Next check in %ds", nextCheck - os.time())
            end
            pcall(function()
                if type(paragraph.SetDesc) == "function" then paragraph:SetDesc(text)
                else paragraph.Content = text end
            end)
        end
        local infoParagraph = st and st.SavedChallengeInfo
        if infoParagraph then
            local lines = {}
            local selected = {}
            if type(cfg and cfg.ChallengeTypes) == "table" then
                for k, v in pairs(cfg.ChallengeTypes) do
                    local item = type(k) == "number" and v or v and k or nil
                    if item then selected[tostring(item)] = true end
                end
            end
            local lastInfo = type(cfg and cfg.ChallengeLastInfo) == "table" and cfg.ChallengeLastInfo or {}
            local timer = aoReadChallengeTimer(player and player.UserId or 0)
            local nextCheck = timer and tonumber(timer.NextCheckAt) or 0
            for _, kind in ipairs({"Daily", "Normal"}) do
                local entry = lastInfo[kind]
                if entry then
                    local rotation = math.max(1, tonumber(entry.Rotation) or (kind == "Daily" and 86400 or 900))
                    local rotatesIn = rotation - os.time() % rotation
                    local status = entry.Completed and "COMPLETED" or entry.Attempted and "ATTEMPTED"
                        or not selected[kind] and "DISABLED" or "PENDING"
                    local line = string.format("%s [%s] - %s Act %s %s\nLosses: %s/3\nModifiers: %s",
                        kind, status, tostring(entry.World), tostring(entry.Act), tostring(entry.Difficulty),
                        tostring(entry.Losses or 0), tostring(entry.Modifiers))
                    if entry.Completed then
                        line = line .. "\nCompleted - leaves on next reset"
                    elseif nextCheck > 0 and os.time() >= nextCheck and selected[kind] then
                        line = line .. "\nDue now - returning to lobby"
                    else
                        line = line .. string.format("\nAuto leave in: %ss", tostring(rotatesIn))
                    end
                    table.insert(lines, line)
                end
            end
            local infoText = #lines > 0 and table.concat(lines, "\n\n")
                or "Return to lobby to scan current challenges."
            pcall(function()
                if type(infoParagraph.SetDesc) == "function" then infoParagraph:SetDesc(infoText)
                else infoParagraph.Content = infoText end
            end)
        end
    end
    local function recordChallengeLoss(config, target)
        local kind = tostring(target.ChallengeKind or "Normal")
        config.ChallengeLosses = type(config.ChallengeLosses) == "table" and config.ChallengeLosses or {}
        local record = type(config.ChallengeLosses[kind]) == "table" and config.ChallengeLosses[kind] or {}
        if tostring(record.Seed) ~= tostring(target.ChallengeSeed) then record = {Seed = target.ChallengeSeed, Count = 0} end
        record.Count = math.max(0, math.floor(tonumber(record.Count) or 0)) + 1
        config.ChallengeLosses[kind] = record
        return record.Count
    end
    local function incompleteGenericQuestSignature()
        local entries = {}
        local data = GlobalTables.PlayerData or {}
        for _, category in ipairs({"Daily", "Weekly"}) do
            for slot, quest in ipairs(((data.Quests or {})[category]) or {}) do
                local definition = (QuestInfo.QuestPools[category] or {})[quest.QuestIndex]
                if definition and not quest.Claimed and definition.GameMode == nil
                    and (definition.QuestType == "Kill" or definition.QuestType == "Waves" or definition.QuestType == "Games") then
                    local rawProgress = QuestInfo.CalculateQuestProgress(data, quest, definition)
                    local progress = tonumber(rawProgress) or 0
                    if progress < (tonumber(definition.Amount) or 0) then
                        table.insert(entries, category .. ":" .. slot .. ":" .. progress)
                    end
                end
            end
        end
        table.sort(entries)
        return table.concat(entries, "|"), #entries > 0
    end
    local questTransitionBusy = false
    local function refreshQuestRefProgress(target)
        local changed = false
        local data = GlobalTables.PlayerData or {}
        for _, ref in ipairs(target.Refs or {}) do
            local quest = (((data.Quests or {})[ref.Category]) or {})[ref.Slot]
            local definition = quest and (QuestInfo.QuestPools[ref.Category] or {})[quest.QuestIndex]
            if quest and definition then
                local rawProgress = QuestInfo.CalculateQuestProgress(data, quest, definition)
                local progress = tonumber(rawProgress) or 0
                if quest.Claimed or progress ~= (tonumber(ref.Progress) or 0) then changed = true end
                ref.Progress, ref.Amount = progress, tonumber(definition.Amount) or 0
            end
        end
        return changed
    end
    local function disableQuestVotes()
        SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
        SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
    end
    local function returnQuestToLobby(config)
        if state.QuestTeleporting then return end
        state.QuestTeleporting = true
        config.QuestRuntimeTarget = nil
        saveLobbyConfig(config)
        pcall(function() GameRemote:FireServer("TeleportToLobby") end)
        pcall(function() ActRemoteEvent:FireServer("ReturnToLobby") end)
        task.spawn(function()
            task.wait(0.6)
            local ok, err = pcall(TeleportService.Teleport, TeleportService, PlaceIDs.LobbyPlace, LocalPlayer)
            if not ok then warn("[AnimeOriginsUltimate] Quest lobby teleport fallback failed: " .. tostring(err)) end
        end)
    end
    local function finishFiniteQuestAct()
        if questTransitionBusy then return end
        local config = autoStoryConfig()
        local target = questTargetMatches(config)
        if not target or target.QuestKind ~= "Generic" then return end
        questTransitionBusy = true
        disableQuestVotes()
        task.spawn(function()
            local deadline = os.clock() + 8
            repeat
                task.wait(0.25)
                if refreshQuestRefProgress(target) then break end
            until os.clock() >= deadline or not state.Running
            local liveConfig = autoStoryConfig()
            if not questTargetMatches(liveConfig) then
                questTransitionBusy = false
                return
            end
            local _, hasGeneric = incompleteGenericQuestSignature()
            if liveConfig.AutoQuest and hasGeneric then
                liveConfig.QuestRuntimeTarget = target
                saveLobbyConfig(liveConfig)
                ActRemoteEvent:FireServer("ReplayActVote")
                questTransitionBusy = false
            else
                returnQuestToLobby(liveConfig)
            end
        end)
    end
    local function formatNumber(value)
        local text = tostring(math.floor(tonumber(value) or 0))
        repeat
            local replaced
            text, replaced = string.gsub(text, "^(-?%d+)(%d%d%d)", "%1,%2")
        until replaced == 0
        return text
    end
    function state.CurrentPlayerLevel()
        local data = GlobalTables.PlayerData or {}
        local ok, level = pcall(CalculateStuff.GetPlayerLevelFromExp, data.Exp or 0)
        return ok and tonumber(level) or 1
    end
    function state.CurrentBattlePassExp()
        local total = 0
        for _, battlepass in pairs((GlobalTables.PlayerData or {}).Battlepasses or {}) do
            if type(battlepass) == "table" then total += tonumber(battlepass.Exp) or 0 end
        end
        return total
    end
    local function rewardInventorySnapshot()
        local snapshot = {
            Amounts = {}, Towers = {},
            PlayerExp = tonumber((GlobalTables.PlayerData or {}).Exp) or 0,
            BattlePassExp = state.CurrentBattlePassExp(),
        }
        for category, items in pairs(GlobalTables.Inventory or {}) do
            if category == "Towers" and type(items) == "table" then
                for uuid, unit in pairs(items) do
                    if type(unit) == "table" then snapshot.Towers[tostring(uuid)] = tostring(unit.Name or "Unknown") end
                end
            elseif type(items) == "table" then
                snapshot.Amounts[tostring(category)] = {}
                for itemName, amount in pairs(items) do
                    amount = tonumber(amount)
                    if amount then snapshot.Amounts[tostring(category)][tostring(itemName)] = amount end
                end
            end
        end
        return snapshot
    end
    local function rewardsSinceSnapshot(before)
        local rewards, grouped = {ItemRewards = {}, Gems = 0, PlayerExp = 0, BattlePassExp = 0}, {}
        for category, items in pairs(GlobalTables.Inventory or {}) do
            if category == "Towers" and type(items) == "table" then
                for uuid, unit in pairs(items) do
                    if type(unit) == "table" and not before.Towers[tostring(uuid)] then
                        local key = "Towers\0" .. tostring(unit.Name or "Unknown")
                        grouped[key] = (grouped[key] or 0) + 1
                    end
                end
            elseif type(items) == "table" then
                local oldItems = before.Amounts[tostring(category)] or {}
                for itemName, amount in pairs(items) do
                    local gained = (tonumber(amount) or 0) - (tonumber(oldItems[tostring(itemName)]) or 0)
                    if gained > 0 then
                        if tostring(category) == "Currency" and tostring(itemName) == "Gems" then
                            rewards.Gems += gained
                        else
                            local key = tostring(category) .. "\0" .. tostring(itemName)
                            grouped[key] = (grouped[key] or 0) + gained
                        end
                    end
                end
            end
        end
        rewards.PlayerExp = math.max(0, (tonumber((GlobalTables.PlayerData or {}).Exp) or 0) - before.PlayerExp)
        rewards.BattlePassExp = math.max(0, state.CurrentBattlePassExp() - (tonumber(before.BattlePassExp) or 0))
        local count = rewards.Gems + rewards.PlayerExp + rewards.BattlePassExp
        for key, amount in pairs(grouped) do
            local itemType, itemName = string.match(key, "^(.-)%z(.*)$")
            table.insert(rewards.ItemRewards, {ItemType = itemType, ItemName = itemName, Amount = amount})
            count += amount
        end
        table.sort(rewards.ItemRewards, function(left, right)
            return tostring(left.ItemType) .. tostring(left.ItemName) < tostring(right.ItemType) .. tostring(right.ItemName)
        end)
        return rewards, count
    end
    function state.MatchWebhookPayload(result)
        local stats = type(result.PlayerStats) == "table" and result.PlayerStats or {}
        local rewards = type(result.Rewards) == "table" and result.Rewards or {}
        local currencyGains = {Gems = math.max(0, tonumber(rewards.Gems) or 0)}
        local trackedCurrencies = {}
        for _, entry in ipairs(AO_WEBHOOK_CURRENCIES) do
            trackedCurrencies[entry.Key] = true
        end
        local rewardLines = {}
        for _, reward in pairs(type(rewards.ItemRewards) == "table" and rewards.ItemRewards or {}) do
            local itemType, itemName = tostring(reward.ItemType or "Item"), tostring(reward.ItemName or "Unknown")
            local gained = math.max(0, tonumber(reward.Amount) or 1)
            if itemType == "Currency" and trackedCurrencies[itemName] then
                currencyGains[itemName] = (currencyGains[itemName] or 0) + gained
                continue
            end
            local towerKey = itemName
            if itemType == "Towers" and not TowerInfo[towerKey] then
                local entry = ((GlobalTables.Inventory or {}).Towers or {})[itemName]
                if type(entry) == "table" and entry.Name then
                    towerKey = tostring(entry.Name)
                end
            end
            local metadata = itemType == "Towers" and TowerInfo[towerKey]
                or ItemInfo[itemType] and ItemInfo[itemType][itemName]
            local displayName = metadata and (metadata.DisplayName or metadata.Name) or (itemType == "Towers" and towerKey or itemName)
            local currentAmount = 0
            if itemType == "Towers" then
                for _, unit in pairs((GlobalTables.Inventory or {}).Towers or {}) do
                    if type(unit) == "table" and tostring(unit.Name) == towerKey then currentAmount += 1 end
                end
            else
                currentAmount = tonumber((((GlobalTables.Inventory or {})[itemType] or {})[itemName])) or 0
            end
            local previousAmount = result.TestRewards and currentAmount or math.max(0, currentAmount - gained)
            local emoji = itemType == "Towers" and (aoItemEmoji(towerKey) or aoItemEmoji(itemName)) or aoItemEmoji(itemName)
            table.insert(rewardLines, string.format(
                "%s**%s:** %s + %s",
                emoji and (emoji .. " ") or "",
                tostring(displayName),
                formatNumber(previousAmount),
                formatNumber(gained)
            ))
        end
        if tonumber(rewards.PlayerExp) and tonumber(rewards.PlayerExp) > 0 then
            local value = result.TestRewards
                and formatNumber((tonumber((GlobalTables.PlayerData or {}).Exp) or 0)) .. " + " .. formatNumber(rewards.PlayerExp)
                or "+" .. formatNumber(rewards.PlayerExp)
            table.insert(rewardLines, (aoItemEmoji("Exp") or "") .. " **Player EXP:** " .. value)
        end
        if tonumber(rewards.BattlePassExp) and tonumber(rewards.BattlePassExp) > 0 then
            local value = result.TestRewards
                and formatNumber(state.CurrentBattlePassExp()) .. " + " .. formatNumber(rewards.BattlePassExp)
                or "+" .. formatNumber(rewards.BattlePassExp)
            table.insert(rewardLines, (aoItemEmoji("BattlePassExp") or "") .. " **Battlepass EXP:** " .. value)
        end
        if #rewardLines == 0 then
            table.insert(rewardLines, "No additional item rewards")
        end
        local resourceLines = {}
        local currencyInventory = (GlobalTables.Inventory or {}).Currency or {}
        for _, entry in ipairs(AO_WEBHOOK_CURRENCIES) do
            local currentAmount = tonumber(currencyInventory[entry.Key]) or 0
            local gained = math.max(0, tonumber(currencyGains[entry.Key]) or 0)
            local previousAmount = result.TestRewards and currentAmount or math.max(0, currentAmount - gained)
            local amountText = gained > 0
                and string.format("%s + %s", formatNumber(previousAmount), formatNumber(gained))
                or formatNumber(currentAmount)
            table.insert(resourceLines, string.format("%s **%s:** %s", entry.Emoji, entry.Label, amountText))
        end
        local resourceText = string.sub(table.concat(resourceLines, "\n"), 1, 1024)
        local clearTime = tonumber(stats.ClearTime) or 0
        local icon = gameIconUrl()
        local mode = tostring(result.GameMode or AttributeHolder:GetAttribute("GameMode") or "Story")
        local world = tostring(result.WorldName or AttributeHolder:GetAttribute("WorldName") or "Unknown")
        local act = tostring(result.Act or AttributeHolder:GetAttribute("Act") or "?")
        local difficulty = tostring(result.Difficulty or AttributeHolder:GetAttribute("Difficulty") or "Normal")
        local level = tostring(state.CurrentPlayerLevel())
        local pityLines, totalClears = {}, nil
        do
            local progressMode = string.lower(mode) == "trial" and "Story" or mode
            local ok, clears, pityAmounts = pcall(
                CalculateStuff.CalculateClears,
                GlobalTables.PlayerData,
                progressMode,
                world,
                act,
                difficulty
            )
            if ok then totalClears = tonumber(clears) end
            local worldInfo = GameInfo[world] or {}
            local actKey = tonumber(act) and ("Act" .. act) or act
            local actInfo = ((GlobalTables.CurrentGame or {}).ActInfo) or worldInfo[actKey] or {}
            local stageRewards = ((GlobalTables.CurrentGame or {}).Rewards) or actInfo.Rewards or worldInfo.DefaultRewards
            local itemRewards = string.lower(mode) == "infinite" and stageRewards or (stageRewards and stageRewards.ItemRewards)
            if ok and type(pityAmounts) == "table" and type(itemRewards) == "table" then
                for itemType, items in pairs(itemRewards) do
                    for itemName, rewardInfo in pairs(type(items) == "table" and items or {}) do
                        local maxPity = type(rewardInfo) == "table" and tonumber(rewardInfo.Pity)
                        if maxPity and maxPity > 0 then
                            local amount = tonumber(type(pityAmounts[itemType]) == "table" and pityAmounts[itemType][itemName]) or 0
                            local metadata = itemType == "Towers" and TowerInfo[itemName]
                                or ItemInfo[itemType] and ItemInfo[itemType][itemName]
                            local displayName = metadata and (metadata.DisplayName or metadata.Name) or itemName
                            local emoji = aoItemEmoji(itemName)
                            local chance = tonumber(rewardInfo.DropChance)
                            table.insert(pityLines, string.format(
                                "%s**%s:** %d/%d%s",
                                emoji and (emoji .. " ") or "",
                                tostring(displayName),
                                amount,
                                maxPity,
                                chance and string.format(" (%g%%)", chance * 100) or ""
                            ))
                        end
                    end
                end
            end
        end
        local fields = {
            {name = "Clear Time", value = string.format("%dm %ds", math.floor(clearTime / 60), math.floor(clearTime % 60)), inline = true},
            {name = string.lower(mode) == "infinite" and "Infinite Wave" or "Waves", value = formatNumber(stats.WavesCompleted), inline = true},
            {name = "Kills", value = formatNumber(stats.Kills), inline = true},
            {name = "Total Damage", value = formatNumber(stats.TotalDamage), inline = true},
            {name = "Money Earned", value = formatNumber(stats.MoneyEarned), inline = true},
            {name = "Resources", value = resourceText, inline = false},
        }
        if totalClears then
            table.insert(fields, 3, {name = "Total Clears", value = formatNumber(totalClears), inline = true})
        end
        if pityLines[1] then
            table.insert(fields, {name = "Pity Progress", value = string.sub(table.concat(pityLines, "\n"), 1, 1024), inline = false})
        end
        local rewardFields = aoRewardFields(rewardLines)
        if rewardFields[1] then table.insert(fields, rewardFields[1]) end
        local embed = {
            author = {name = "Anime Origins", icon_url = icon},
            title = string.format("[%s] ||%s (Lv.%s)|| - %s", mode, LocalPlayer.Name, level, result.Success and "Victory" or "Defeat"),
            description = string.format("**Map:** %s | Act %s | %s", world, act, difficulty),
            color = result.Success and 0x54D17A or 0xE45C68,
            thumbnail = {url = icon},
            fields = fields,
            timestamp = DateTime.now():ToIsoDate(),
            footer = {text = "Anime Origins Ultimate"},
        }
        local embeds = {embed}
        for index = 2, #rewardFields do
            table.insert(embeds, {
                author = {name = "Anime Origins", icon_url = icon},
                title = "Gained Rewards (continued " .. tostring(index - 1) .. ")",
                color = result.Success and 0x54D17A or 0xE45C68,
                fields = {rewardFields[index]},
                timestamp = DateTime.now():ToIsoDate(),
                footer = {text = "Anime Origins Ultimate"},
            })
        end
        return {username = "Anime Origins Auto", avatar_url = icon, embeds = embeds}
    end
    local function postMatchWebhook(result, forceCompletion)
        local config = autoStoryConfig()
        if not config or tostring(config.WebhookUrl or "") == "" then
            return
        end
        if not forceCompletion and not config.WebhookCompletionEnabled then
            return
        end
        local ok, message = sendDiscordWebhook(config.WebhookUrl, state.MatchWebhookPayload(result))
        warn("[AO Webhook] " .. (ok and "sent" or "failed") .. ": " .. tostring(message))
    end
    state.PostMatchWebhookAfterData = function(result, baseline)
        baseline = type(baseline) == "table" and baseline or rewardInventorySnapshot()
        local observed, deadline = nil, os.clock() + 3
        repeat
            task.wait(0.25)
            observed = rewardsSinceSnapshot(baseline)
        until not state.Running or (tonumber(observed.BattlePassExp) or 0) > 0 or os.clock() >= deadline
        if not state.Running then return end
        result.Rewards = type(result.Rewards) == "table" and result.Rewards or {}
        result.Rewards.PlayerExp = math.max(
            tonumber(result.Rewards.PlayerExp) or 0,
            tonumber(observed and observed.PlayerExp) or 0
        )
        result.Rewards.BattlePassExp = math.max(
            tonumber(result.Rewards.BattlePassExp) or 0,
            tonumber(observed and observed.BattlePassExp) or 0
        )
        postMatchWebhook(result)
        state.WebhookRewardBaseline = rewardInventorySnapshot()
    end
    local function postRestartWebhookAfterRewards(result, baseline)
        local deadline, stableSince, lastCount = os.clock() + 8, nil, -1
        local rewards, count
        repeat
            task.wait(0.25)
            rewards, count = rewardsSinceSnapshot(baseline)
            if count > 0 then
                if count ~= lastCount then stableSince, lastCount = os.clock(), count end
                if os.clock() - stableSince >= 1 then break end
            end
        until not state.Running or os.clock() >= deadline
        if not state.Running then return end
        result.Rewards = rewards or {}
        postMatchWebhook(result, true)
        state.InfiniteRewardBaseline = rewardInventorySnapshot()
    end
    local function processPendingInfiniteWebhook(pending)
        if type(pending) ~= "table" or type(pending.Result) ~= "table" or type(pending.Baseline) ~= "table" then
            return
        end
        postRestartWebhookAfterRewards(pending.Result, pending.Baseline)
        if environment.AOPendingInfiniteWebhook == pending then
            environment.AOPendingInfiniteWebhook = nil
        end
    end
    local knownUnitIds = {}
    for uuid in pairs((GlobalTables.Inventory or {}).Towers or {}) do
        knownUnitIds[tostring(uuid)] = true
    end
    local function scanNewUnitWebhooks()
        if os.clock() < (state.NextUnitWebhookScanAt or 0) then return end
        state.NextUnitWebhookScanAt = os.clock() + 1
        local newUnits = {}
        for uuid, unit in pairs((GlobalTables.Inventory or {}).Towers or {}) do
            uuid = tostring(uuid)
            if not knownUnitIds[uuid] then
                knownUnitIds[uuid] = true
                table.insert(newUnits, unit)
            end
        end
        local config = autoStoryConfig()
        if #newUnits == 0 or not config or not config.WebhookUnitEnabled or tostring(config.WebhookUrl or "") == "" then return end
        local icon, embeds = gameIconUrl(), {}
        local rarityColors = {Rare = 0x62A8FF, Epic = 0xB56CFF, Legendary = 0xFFD45A, Mythic = 0xFF5E90, Secret = 0xF5F5F5}
        for index, unit in ipairs(newUnits) do
            if index > 10 then break end
            local name = tostring(unit.Name or "Unknown")
            local info = TowerInfo[name] or {}
            local rarity = tostring(info.Rarity or "Unknown")
            local ok, unitLevel = pcall(CalculateStuff.GetTowerLevelFromExp, unit.Exp or 0, info.Rarity)
            local unitEmoji = aoItemEmoji(name)
            local embed = {
                author = {name = "Anime Origins", icon_url = icon},
                title = (unitEmoji and (unitEmoji .. " ") or "") .. "New Unit: " .. tostring(info.DisplayName or info.Name or name),
                color = rarityColors[rarity] or 0x8A7DFF,
                fields = {
                    {name = "Rarity", value = rarity, inline = true},
                    {name = "Unit Level", value = tostring(ok and unitLevel or 1), inline = true},
                    {name = "Shiny", value = unit.Shiny and "Yes" or "No", inline = true},
                    {name = "Player", value = string.format("||%s (Lv.%d)||", LocalPlayer.Name, state.CurrentPlayerLevel()), inline = false},
                },
                timestamp = DateTime.now():ToIsoDate(), footer = {text = "Anime Origins Ultimate"},
            }
            if type(info.EmbedImage) == "string" and string.match(info.EmbedImage, "^https?://") then
                embed.thumbnail = {url = info.EmbedImage}
            end
            table.insert(embeds, embed)
        end
        task.spawn(function()
            local ok, message = sendDiscordWebhook(config.WebhookUrl, {username = "Anime Origins Auto", avatar_url = icon, embeds = embeds})
            warn("[AO Webhook] new unit " .. (ok and "sent" or "failed") .. ": " .. tostring(message))
        end)
    end
    local speedModes = {{"One", "1x"}, {"Two", "1.4x"}}
    local hasIncreasedSpeed = false
    pcall(function()
        hasIncreasedSpeed = ProductsModule.HasGamePass(LocalPlayer, "IncreasedGameSpeed") == true
    end)
    state.HasIncreasedGameSpeed = hasIncreasedSpeed
    if hasIncreasedSpeed then
        table.insert(speedModes, {"Three", "2x"})
    end
    state.SpeedMode = tostring(((GlobalTables.PlayerData or {}).Settings or {}).AutoGameSpeed or "One")
    function state.SetGameSpeed(mode)
        for _, entry in ipairs(speedModes) do
            if entry[1] == mode then
                state.SpeedMode = mode
                GameRemote:FireServer("ChangeSpeed", mode)
                return true
            end
        end
        return false
    end
    local function speedLabel()
        for _, entry in ipairs(speedModes) do
            if entry[1] == state.SpeedMode then
                return entry[2]
            end
        end
        return "1x"
    end
    local function cycleGameSpeed()
        local current = 1
        for index, entry in ipairs(speedModes) do
            if entry[1] == state.SpeedMode then
                current = index
                break
            end
        end
        state.SetGameSpeed(speedModes[current % #speedModes + 1][1])
    end
    local function playbackMacroPath()
        local config = autoStoryConfig()
        local isChallengeMap = string.find(tostring(mapInfo.GameMode), "Challenge", 1, true) ~= nil
        local isStoryMap = tostring(mapInfo.GameMode) == "Story"
        local challengeTarget = config and config.AutoChallenge and type(config.ChallengeRuntimeTarget) == "table"
            and config.ChallengeRuntimeTarget.Owner == "Challenge" and config.ChallengeRuntimeTarget or nil
        local selected = isChallengeMap and challengeTarget and type(config.ChallengeMacroByWorld) == "table"
            and config.ChallengeMacroByWorld[mapInfo.WorldName]
            or isStoryMap and config and (config.AutoStory or config.AutoQuest) and type(config.StoryMacroByWorld) == "table"
                and config.StoryMacroByWorld[mapInfo.WorldName] or nil
        if selected and selected ~= "" then
            local path = tostring(selected)
            if not string.find(path, "[/\\]") then
                path = macrosFolder .. "/" .. path
            end
            if string.sub(path, -5) ~= ".json" then
                path ..= ".json"
            end
            if type(isfile) == "function" and isfile(path) then
                return path
            end
        end
        return macroPath
    end
    local function log(message)
        appendLog("[AO Macro]", macroLogPath, string.format("[%s] %s", macroKey, message))
    end
    local function vectorToArray(value)
        if typeof(value) == "Vector3" then
            return {value.X, value.Y, value.Z}
        elseif typeof(value) == "CFrame" then
            return {value.Position.X, value.Position.Y, value.Position.Z}
        end
    end
    local function arrayToVector(value)
        return type(value) == "table" and Vector3.new(tonumber(value[1]) or 0, tonumber(value[2]) or 0, tonumber(value[3]) or 0) or nil
    end
    local function ownedTower(uuid)
        local tower = GlobalTables.TowerDict and GlobalTables.TowerDict[uuid]
        return tower and tower.Owner == LocalPlayer and tower or nil
    end
    local towerClient
    local function refreshTowerUI(uuid)
        pcall(function()
            towerClient = towerClient or require(LocalPlayer.PlayerScripts.GameHandlerLocal.TowerHandlerLocal)
            towerClient.Modules.UnitManagerModule.UpdateUnitManager(uuid)
            towerClient.Modules.TowerInfoFrameModule.UpdateTowerInfoFrame(uuid)
            local frame = towerClient.Modules.TowerInfoFrameModule.GetTowerInfoFrame(uuid)
            local tower = ownedTower(uuid)
            if frame and tower and frame:FindFirstChild("ButtonFrame") then
                frame.ButtonFrame.Priority.TextLabel.Text = tower.TargetMode
            end
        end)
    end
    local function towerPosition(tower)
        if tower and typeof(tower.cf) == "CFrame" then
            return tower.cf.Position
        elseif tower and tower.Rig and tower.Rig.Parent then
            return tower.Rig:GetPivot().Position
        end
    end
    local function refForUUID(uuid)
        if uuid and not state.UUIDToRef[uuid] then
            state.NextRef += 1
            local ref = "U" .. state.NextRef
            state.UUIDToRef[uuid], state.RefToUUID[ref] = ref, uuid
        end
        return uuid and state.UUIDToRef[uuid] or nil
    end
    local function towerDescriptor(uuid)
        local tower = ownedTower(uuid)
        return {Ref = refForUUID(uuid), UUID = tostring(uuid), TowerName = tower and tower.TowerName, Position = vectorToArray(towerPosition(tower))}
    end
    local statusLabel
    local countLabel
    local function updateUI(message)
        local text = message or (state.PendingMode and ("RESTARTING FOR " .. string.upper(state.PendingMode))
            or state.Recording and "RECORDING" or state.Playing and "PLAYING" or "IDLE")
        if statusLabel and statusLabel.Text ~= text then statusLabel.Text = text end
        local wave = tostring(AttributeHolder:GetAttribute("Wave") or 0)
        if countLabel then
            local countText = string.format("%s\nActions: %d | Wave: %s", macroKey, #state.Actions, wave)
            if countLabel.Text ~= countText then countLabel.Text = countText end
        end
        local riftInfo = ""
        if ingameConfig.AutoRift then
            local riftTimerData = aoReadRiftTimer(LocalPlayer.UserId)
            local closeAt = riftTimerData and tonumber(riftTimerData.RiftCloseAt) or 0
            if closeAt and closeAt > os.time() then
                riftInfo = string.format("\nRift OPEN: closes in %ds", closeAt - os.time())
            else
                local riftSpawnAt = riftTimerData and tonumber(riftTimerData.RiftSpawnAt) or 0
                if riftSpawnAt > 0 then
                    local timeLeft = riftSpawnAt - os.time()
                    if timeLeft > 0 then
                        riftInfo = string.format("\nNext Rift spawn in: %ds", timeLeft)
                    else
                        riftInfo = "\nNext Rift spawn: now"
                    end
                else
                    riftInfo = "\nNext Rift spawn: unknown"
                end
            end
        end
        state.PendingMacroStatusDesc = string.format(
            "MacroKey: %s\nActions: %d | Wave: %s\nStatus: %s%s",
            tostring(macroKey), #state.Actions, wave, text, riftInfo
        )
    end
    local function addAction(action)
        if not state.Recording then return end
        action.Time = math.max(0, os.clock() - state.RecordStartedAt)
        action.Wave = AttributeHolder:GetAttribute("Wave") or 0
        table.insert(state.Actions, action)
        task.defer(log, string.format("recorded #%d %s at %.2fs", #state.Actions, tostring(action.Type), action.Time))
        updateUI("RECORDING: " .. tostring(action.Type))
    end
    state.RecordManualAutoUpgrade = function(uuid, beforeMode, afterMode)
        if not state.Recording or beforeMode == nil or afterMode == nil or beforeMode == afterMode then return end
        state.ObservedAutoModes[uuid] = afterMode
        state.RecordedAutoModes[uuid] = afterMode
        addAction({
            Type = "AutoUpgrade",
            Mode = afterMode,
            Manual = afterMode == 0 or nil,
            Target = towerDescriptor(uuid),
        })
    end
    local towerInfoFrameFolder = LocalPlayer.PlayerGui:WaitForChild("GameUI"):WaitForChild("TowerInfoFrameFolder")
    local autoAbilityButtons = setmetatable({}, {__mode = "k"})
    local function nativeAutoAbilityContext(button)
        local autoFrame = button and button.Parent
        local abilityFrame = autoFrame and autoFrame.Name == "AutoFrame" and autoFrame.Parent or nil
        local abilityName = abilityFrame and abilityFrame.Name or nil
        local abilityInfo = abilityName and TowerAbilitiesInfo.Actives[abilityName]
        if not abilityInfo or abilityInfo.AutoUse == false then return nil end
        local towerFrame = abilityFrame
        while towerFrame and towerFrame.Parent ~= towerInfoFrameFolder do towerFrame = towerFrame.Parent end
        if not towerFrame then return nil end
        return tostring(towerFrame.Name), tostring(abilityName)
    end
    local function nativeAutoAbilityEnabled(button)
        local circle = button and button:FindFirstChild("CircleFrame")
        circle = circle and circle:FindFirstChild("Circle")
        if not circle then return false end
        return circle.Position.X.Scale >= 0.3 or circle.BackgroundColor3.G > circle.BackgroundColor3.R
    end
    local function findNativeAutoAbilityButton(uuid, abilityName)
        local towerFrame = towerInfoFrameFolder:FindFirstChild(tostring(uuid))
        if not towerFrame then return nil end
        for _, instance in ipairs(towerFrame:GetDescendants()) do
            if instance.Name == tostring(abilityName) then
                local autoFrame = instance:FindFirstChild("AutoFrame")
                local button = autoFrame and autoFrame:FindFirstChild("Button")
                if button and button:IsA("GuiButton") and autoFrame.Visible then return button end
            end
        end
    end
    local function setNativeAutoAbility(uuid, abilityName, enabled)
        local button = findNativeAutoAbilityButton(uuid, abilityName)
        if not button then return false, "native auto ability button not found" end
        if nativeAutoAbilityEnabled(button) == (enabled == true) then return true end
        local environmentFireSignal = environment.firesignal or firesignal
        if type(environmentFireSignal) ~= "function" then return false, "firesignal unavailable" end
        local ok, err = pcall(environmentFireSignal, button.MouseButton1Click)
        return ok, err
    end
    local function watchNativeAutoAbilityButton(instance)
        if not instance:IsA("GuiButton") or instance.Name ~= "Button"
            or not instance.Parent or instance.Parent.Name ~= "AutoFrame" or autoAbilityButtons[instance] then return end
        local uuid, abilityName = nativeAutoAbilityContext(instance)
        if not uuid then return end
        autoAbilityButtons[instance] = true
        table.insert(state.Connections, instance.MouseButton1Click:Connect(function()
            if not state.Recording then return end
            task.delay(0.3, function()
                if not state.Running or not state.Recording or not instance.Parent then return end
                local tower = ownedTower(uuid)
                if not tower then return end
                addAction({
                    Type = "AutoAbility",
                    Enabled = nativeAutoAbilityEnabled(instance),
                    AbilityName = abilityName,
                    Target = towerDescriptor(uuid),
                })
            end)
        end))
    end
    for _, instance in ipairs(towerInfoFrameFolder:GetDescendants()) do watchNativeAutoAbilityButton(instance) end
    table.insert(state.Connections, towerInfoFrameFolder.DescendantAdded:Connect(function(instance)
        task.defer(watchNativeAutoAbilityButton, instance)
    end))
    local function initializeObservedModes()
        table.clear(state.ObservedAutoModes)
        table.clear(state.RecordedAutoModes)
        for uuid, tower in pairs(GlobalTables.TowerDict or {}) do
            if tower.Owner == LocalPlayer then
                state.ObservedAutoModes[uuid] = tonumber(tower.AutoUpgradeMode) or 0
                refForUUID(uuid)
            end
        end
    end
    local function ownedTowerCount()
        local count = 0
        for _, tower in pairs(GlobalTables.TowerDict or {}) do
            if tower.Owner == LocalPlayer then count += 1 end
        end
        return count
    end
    state.ConsumableEventMode = function()
        local mode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
        return mode == "Artifact" or string.find(mode, "Rift", 1, true) ~= nil
    end
    local function requestRestart(mode)
        if not state.NativeAutomationReady then
            updateUI("WAITING FOR MOBILE GAME LOAD")
            log("blocked RestartGame for " .. tostring(mode) .. "; native game is not ready")
            return false
        end
        local currentMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
        local eventMode = string.find(currentMode, "Challenge", 1, true) ~= nil
            or string.find(currentMode, "Rift", 1, true) ~= nil
            or currentMode == "Artifact"
        if currentMode == "Artifact" or string.find(currentMode, "Rift", 1, true) ~= nil then
            updateUI(string.upper(currentMode) .. " RESTART BLOCKED; WAIT FOR REPLAY")
            log("blocked RestartGame in " .. currentMode .. " mode; replay must use the native end-of-match flow")
            return false
        end
        state.Recording, state.Playing, state.TimelineDone = false, false, false
        state.PlayGeneration = {}
        table.clear(state.PlaybackAutoAbilities)
        state.PendingMode, state.PendingStartedAt = mode, os.clock()
        state.PendingInitialWave = AttributeHolder:GetAttribute("Wave")
        state.PendingInitialMoney = LocalPlayer:GetAttribute("Money")
        state.PendingInitialTowers = ownedTowerCount()
        state.PendingTransitionSeen = false
        if eventMode then
            state.EnsureAutoReplay = false
            state.PendingStageAutoPlay = false
            pcall(function()
                SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
                SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
            end)
            log("event restart guard: AutoReplayGame/AutoNextGame forced OFF before RestartGame")
        end
        updateUI(mode == "Record" and "RESTARTING FOR RECORD" or "RESTARTING FOR PLAYBACK")
        log("requested RestartGame for " .. mode)
        GameRemote:FireServer("RestartGame")
        return true
    end
    function state.Save()
        ensureFolders()
        if #state.Actions == 0 then
            log("save skipped: 0 actions (refusing to overwrite existing macro)")
            updateUI("RECORDING STOPPED (0 ACTIONS)")
            return false
        end
        local payload = {Format = "AnimeOriginsMacro", Version = 2, MacroKey = macroKey, Actions = state.Actions}
        if type(writefile) == "function" then
            local ok, err = pcall(writefile, macroPath, HttpService:JSONEncode(payload))
            if not ok then log("save failed: " .. tostring(err)); return false end
        end
        log("saved " .. #state.Actions .. " actions to " .. macroPath)
        updateUI("SAVED " .. #state.Actions .. " ACTIONS")
        return true
    end
    function state.OptimizeCurrentMacro()
        if state.Recording or state.PendingMode == "Record" then
            updateUI("STOP RECORDING BEFORE OPTIMIZE")
            return false
        end
        if type(isfile) ~= "function" or type(readfile) ~= "function" or type(writefile) ~= "function" then
            updateUI("LOCAL FILE ACCESS UNAVAILABLE")
            return false
        end
        local path = playbackMacroPath()
        if not isfile(path) then
            updateUI("NO SAVED MACRO")
            return false
        end
        local ok, payload = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        if not ok or type(payload) ~= "table" then
            updateUI("INVALID MACRO JSON")
            return false
        end
        local optimized, optimizedPayload, changedOrErr = pcall(aoOptimizeMacroV2, payload)
        if not optimized then
            updateUI("OPTIMIZE FAILED")
            log("optimize failed: " .. tostring(optimizedPayload))
            return false
        end
        payload = optimizedPayload
        local encodedOk, encoded = pcall(function()
            return HttpService:JSONEncode(payload)
        end)
        if not encodedOk then
            updateUI("OPTIMIZE ENCODE FAILED")
            log("optimize encode failed: " .. tostring(encoded))
            return false
        end
        local writeOk, writeErr = pcall(writefile, path, encoded)
        if not writeOk then
            updateUI("OPTIMIZE SAVE FAILED")
            log("optimize save failed: " .. tostring(writeErr))
            return false
        end
        state.Actions = payload.Actions
        state.LoadedMacroPath = path
        updateUI("OPTIMIZED " .. tostring(changedOrErr) .. " PLACE/VOTESTART")
        log("optimized macro in place: " .. path .. " (" .. tostring(changedOrErr) .. " pre-Sell Place/VoteStart actions)")
        return true, encoded
    end
    function state.Load()
        local path = playbackMacroPath()
        if type(isfile) ~= "function" or not isfile(path) then updateUI("NO SAVED MACRO"); return false end
        local ok, decoded = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
        if not ok or type(decoded) ~= "table" then updateUI("LOAD FAILED"); return false end
        local actions = type(decoded.Actions) == "table" and decoded.Actions or decoded
        local count, highest = 0, 0
        for index, action in pairs(actions) do
            if type(index) ~= "number" or index < 1 or index % 1 ~= 0 or type(action) ~= "table" then
                updateUI("INVALID MACRO ACTIONS")
                return false
            end
            count, highest = count + 1, math.max(highest, index)
        end
        if count ~= highest then updateUI("INVALID MACRO ACTIONS"); return false end
        state.Actions = actions
        table.sort(state.Actions, function(left, right) return (tonumber(left.Time) or 0) < (tonumber(right.Time) or 0) end)
        state.LoadedMacroPath = path
        updateUI("LOADED " .. #state.Actions .. " ACTIONS")
        return true
    end
    local function beginRecording()
        state.PendingMode, state.Recording, state.Actions = nil, true, {}
        state.UUIDToRef, state.RefToUUID, state.RecordedPlacements, state.NextRef = {}, {}, {}, 0
        state.RecordStartedAt = os.clock()
        initializeObservedModes()
        log("recording started")
        updateUI("RECORDING")
    end
    function state.StartRecording()
        if state.PendingMode or state.Recording then updateUI("RECORD ALREADY ACTIVE"); return false end
        if state.Playing then state.StopPlayback() end
        if state.ConsumableEventMode() then
            if (tonumber(AttributeHolder:GetAttribute("Wave")) or 0) <= 1 and ownedTowerCount() == 0 then
                return beginRecording()
            end
            updateUI("EVENT RECORD REQUIRES A FRESH RUN")
            log("blocked consumable-event recording restart; enter a fresh run")
            return false
        end
        return requestRestart("Record")
    end
    function state.StopRecording(save)
        if state.PendingMode == "Record" then
            state.PendingMode = nil
            updateUI("RECORD RESTART CANCELLED")
            log("pending record cancelled")
            return
        end
        state.Recording = false
        log("recording stopped with " .. #state.Actions .. " actions")
        if save ~= false then state.Save() else updateUI("RECORDING STOPPED") end
    end
    local function resolveTower(action)
        local target = action.Target or {}
        local mapped = target.Ref and state.RefToUUID[target.Ref]
        if mapped and ownedTower(mapped) then return mapped end
        local expected = arrayToVector(target.Position)
        local best, bestDistance = nil, math.huge
        for uuid, tower in pairs(GlobalTables.TowerDict or {}) do
            if tower.Owner == LocalPlayer and (not target.TowerName or tower.TowerName == target.TowerName) then
                local position = towerPosition(tower)
                local distance = expected and position and (position - expected).Magnitude or 0
                if distance < bestDistance and distance <= 15 then best, bestDistance = uuid, distance end
            end
        end
        if best and target.Ref then state.RefToUUID[target.Ref] = best end
        return best
    end
    local function invokeWithRetry(actionName, ...)
        local deadline, args = os.clock() + 5, table.pack(...)
        repeat
            local results = table.pack(pcall(function() return TowerFunction:InvokeServer(actionName, table.unpack(args, 1, args.n)) end))
            if results[1] and results[2] then return table.unpack(results, 2, results.n) end
            task.wait(0.1)
        until not state.Playing or os.clock() >= deadline
    end
    local function executeAction(action)
        if action.Type == "Place" then
            local position, normal = arrayToVector(action.Position), arrayToVector(action.Normal) or Vector3.yAxis
            if not position then return false, "missing placement position" end
            local before = {}
            for existingUUID, tower in pairs(GlobalTables.TowerDict or {}) do
                if tower.Owner == LocalPlayer then before[existingUUID] = true end
            end
            local function uuidAlreadyMapped(uuid)
                if before[uuid] then return true end
                for _, mappedUUID in pairs(state.RefToUUID) do
                    if tostring(mappedUUID) == tostring(uuid) then return true end
                end
                return false
            end
            local function recoverPlacedUUID()
                local bestUUID, bestDistance
                for candidateUUID, tower in pairs(GlobalTables.TowerDict or {}) do
                    if tower.Owner == LocalPlayer and not uuidAlreadyMapped(candidateUUID) then
                        local candidatePosition = towerPosition(tower)
                        local distance = candidatePosition and (candidatePosition - position).Magnitude or math.huge
                        if distance <= 3 and (bestDistance == nil or distance < bestDistance) then
                            bestUUID, bestDistance = candidateUUID, distance
                        end
                    end
                end
                return bestUUID
            end
            local function placeOnce(usePhantom)
                local ok, result = pcall(function()
                    return TowerFunction:InvokeServer(
                        "PlaceTower", action.Slot, position, normal, tonumber(action.Rotation) or 0,
                        action.Extra, usePhantom == true
                    )
                end)
                local uuid = ok and type(result) == "table" and result.UUID or nil
                if uuid and uuidAlreadyMapped(uuid) then uuid = nil end
                if not uuid then
                    task.wait(0.25)
                    uuid = recoverPlacedUUID()
                end
                return uuid, result
            end
            local uuid, normalResult = placeOnce(false)
            local phantomResult
            if not uuid and state.Playing then
                log(string.format(
                    "normal Place failed for slot=%s result=%s; retrying as Phantom",
                    tostring(action.Slot), tostring(normalResult)
                ))
                local deadline = os.clock() + 5
                repeat
                    uuid, phantomResult = placeOnce(true)
                    if uuid then
                        log(string.format(
                            "Phantom fallback Place succeeded for slot=%s uuid=%s",
                            tostring(action.Slot), tostring(uuid)
                        ))
                        break
                    end
                    task.wait(0.1)
                until not state.Playing or os.clock() >= deadline
            end
            if uuid and action.Ref then state.RefToUUID[action.Ref] = uuid end
            if uuid then return true end
            return false, "PlaceTower failed after Phantom fallback (slot=" .. tostring(action.Slot)
                .. ", normalResult=" .. tostring(normalResult)
                .. ", phantomResult=" .. tostring(phantomResult) .. ")"
        elseif action.Type == "SellAll" then
            TowerRemote:FireServer("SellTower", "All")
            table.clear(state.RefToUUID)
            table.clear(state.PlaybackAutoModes)
            table.clear(state.PlaybackAutoAbilities)
            return true
        elseif action.Type == "PriorityAll" then
            local result = TowerFunction:InvokeServer("SetPriority", "All", action.Priority)
            if type(result) == "table" then
                for uuid, priority in pairs(result) do
                    local tower = ownedTower(uuid)
                    if tower then tower.TargetMode = priority; refreshTowerUI(uuid) end
                end
            end
            task.defer(log, string.format("PriorityAll requested=%s server=%s", tostring(action.Priority), HttpService:JSONEncode(result or {})))
            return result ~= nil, result and nil or "SetPriority All failed"
        end
        local uuid = resolveTower(action)
        local deadline = os.clock() + 5
        while not uuid and state.Playing and os.clock() < deadline do task.wait(0.1); uuid = resolveTower(action) end
        if not uuid then return false, "target tower not found" end
        if action.Type == "Upgrade" then
            local success = invokeWithRetry("UpgradeTower", uuid)
            return success ~= nil and success ~= false, success and nil or "UpgradeTower failed"
        elseif action.Type == "Sell" then
            TowerRemote:FireServer("SellTower", uuid)
            state.PlaybackAutoModes[uuid] = nil
            state.PlaybackAutoAbilities[uuid] = nil
            return true
        elseif action.Type == "Priority" then
            local result = TowerFunction:InvokeServer("SetPriority", uuid, action.Priority)
            local tower = ownedTower(uuid)
            if tower and result ~= nil then tower.TargetMode = type(result) == "table" and result[uuid] or action.Priority; refreshTowerUI(uuid) end
            task.defer(log, string.format("Priority requested=%s server=%s local=%s uuid=%s", tostring(action.Priority), tostring(type(result) == "table" and result[uuid] or result), tostring(tower and tower.TargetMode), tostring(uuid)))
            return result ~= nil, result and nil or "SetPriority failed"
        elseif action.Type == "AutoUpgrade" then
            local mode = math.clamp(tonumber(action.Mode) or 0, 0, 5)
            if mode == 0 and action.Manual ~= true then return true end
            state.PlaybackAutoModes[uuid] = mode > 0 and mode or nil
            local tower = ownedTower(uuid)
            if tower then
                pcall(function()
                    if mode == 0 then
                        TowerHandlerModule.StopAutoUpgrade(uuid)
                    else
                        TowerHandlerModule.AutoUpgrade(uuid, mode)
                    end
                end)
                tower.AutoUpgradeMode = mode
                refreshTowerUI(uuid)
            end
            return true
        elseif action.Type == "AutoAbility" then
            local abilityName = tostring(action.AbilityName or "")
            local abilityInfo = TowerAbilitiesInfo.Actives[abilityName]
            if not abilityInfo or abilityInfo.AutoUse == false then
                return false, "ability does not support native auto use"
            end
            local enabled = action.Enabled == true
            local changed, err
            local abilityDeadline = os.clock() + 5
            repeat
                changed, err = setNativeAutoAbility(uuid, abilityName, enabled)
                if changed then break end
                task.wait(0.1)
            until not state.Playing or os.clock() >= abilityDeadline
            if not changed then return false, err end
            state.PlaybackAutoAbilities[uuid] = state.PlaybackAutoAbilities[uuid] or {}
            state.PlaybackAutoAbilities[uuid][abilityName] = enabled or nil
            if next(state.PlaybackAutoAbilities[uuid]) == nil then state.PlaybackAutoAbilities[uuid] = nil end
            return true
        end
        return false, "unsupported action " .. tostring(action.Type)
    end
    function state.StopPlayback()
        state.PendingMode, state.Playing, state.TimelineDone = nil, false, false
        state.PlayGeneration = {}
        for uuid, abilities in pairs(state.PlaybackAutoAbilities) do
            for abilityName, enabled in pairs(abilities) do
                if enabled then pcall(setNativeAutoAbility, uuid, abilityName, false) end
            end
        end
        table.clear(state.PlaybackAutoModes)
        table.clear(state.PlaybackAutoAbilities)
        updateUI("PLAYBACK STOPPED")
        log("playback stopped")
    end
    local function beginPlayback()
        state.PendingStageAutoPlay = false
        state.PendingMode, state.Playing, state.TimelineDone = nil, true, false
        state.RefToUUID, state.PlaybackAutoModes, state.PlaybackAutoAbilities, state.PlayStartedAt = {}, {}, {}, os.clock()
        local generation = {}
        state.PlayGeneration = generation
        updateUI("PLAYING")
        log("playback started with " .. #state.Actions .. " actions")
        task.spawn(function()
            for index, action in ipairs(state.Actions) do
                while state.Playing and state.PlayGeneration == generation and os.clock() - state.PlayStartedAt < (tonumber(action.Time) or 0) do task.wait(0.02) end
                if not state.Playing or state.PlayGeneration ~= generation then return end
                local ok, success, err = pcall(executeAction, action)
                if not ok or not success then
                    log(string.format("action #%d %s failed: %s", index, tostring(action.Type), tostring(ok and err or success)))
                    updateUI("FAILED: " .. tostring(action.Type))
                else
                    log(string.format("played #%d %s", index, tostring(action.Type)))
                    updateUI("PLAYING: " .. tostring(action.Type))
                end
            end
            if state.Playing and state.PlayGeneration == generation then
                state.TimelineDone = true
                if next(state.PlaybackAutoModes) == nil and next(state.PlaybackAutoAbilities) == nil then
                    state.Playing = false
                    updateUI("PLAYBACK COMPLETED")
                else updateUI("TIMELINE DONE; AUTOMATION ACTIVE") end
                log("timeline completed")
            end
        end)
        return true
    end
    function state.Play()
        if state.PendingMode or state.Playing then updateUI("PLAYBACK ALREADY ACTIVE"); return false end
        if not state.NativeAutomationReady then updateUI("WAITING FOR MOBILE GAME LOAD"); return false end
        if state.Recording then state.StopRecording(true) end
        if not state.Load() then return false end
        if state.ConsumableEventMode() then
            if (tonumber(AttributeHolder:GetAttribute("Wave")) or 0) <= 1 and ownedTowerCount() == 0 then
                return beginPlayback()
            end
            state.PendingStageAutoPlay = true
            updateUI("EVENT AUTO PLAY WAITING FOR A FRESH RUN")
            log("consumable-event playback queued without restarting the active match")
            return true
        end
        return requestRestart("Play")
    end
    function state.RecordMacro()
        if state.Recording or state.PendingMode == "Record" then
            state.StopRecording(true)
        else
            state.StartRecording()
        end
    end
    function state.SetPlayMacro(enabled)
        ingameConfig.AutoPlayMacro = enabled == true
        saveLobbyConfig(ingameConfig)
        if enabled then
            state.Play()
        else
            state.PendingStageAutoPlay = false
            state.StopPlayback()
        end
    end
    local function ensureAutomatedGameStart()
        if not (ingameConfig.AutoPlayMacro or ingameConfig.AutoRestartInfinite or ingameConfig.AutoJoin
            or ingameConfig.AutoQuest or ingameConfig.AutoStory) then return end
        if GlobalTables.GameStarted or (tonumber(AttributeHolder:GetAttribute("Wave")) or 0) ~= 0 then return end
        if os.clock() < (state.NextStartGameVoteAt or 0) then return end
        local gameUI = earlyPlayerGui:FindFirstChild("GameUI")
        if not gameUI then return end
        local mapSelect = gameUI:FindFirstChild("MapSelect")
        if mapSelect and mapSelect.Visible then
            if ingameConfig.GameMode == "WorldBoss" and ingameConfig.AutoJoin then
                local remote = ReplicatedStorage:WaitForChild("LobbyRemotes"):WaitForChild("MapSelectRemote")
                remote:FireServer("IgrisBossFight")
                log("sent Igris World Boss map selection: IgrisBossFight")
                task.wait(0.5)
            end
        end
        local vote = gameUI:FindFirstChild("TopUI") and gameUI.TopUI:FindFirstChild("Vote")
        local main = vote and vote:FindFirstChild("Main")
        local header = main and main:FindFirstChild("Header")
        if not (vote and vote.Visible and header and string.find(tostring(header.Text), "Start Game", 1, true)) then return end
        state.NextStartGameVoteAt = os.clock() + 2
        if ingameConfig.GameMode == "WorldBoss" and ingameConfig.AutoJoin then
            ActRemoteEvent:FireServer("WaveVote", true)
            log("sent start game vote for World Boss")
        else
            ActRemoteEvent:FireServer("WaveVote", true)
            log("sent automatic Start Game vote")
        end
    end
    state.EnsureAutomatedGameStart = ensureAutomatedGameStart
    local function infiniteModeActive()
        local mode = string.lower(tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or ""))
        return mode == "infinite" or mode == "infinity"
    end
    local function restartInfiniteRun(wave)
        state.InfiniteRestartArmed = false
        state.InfiniteRestartRequestedAt = os.clock()
        local rewardBaseline = state.InfiniteRewardBaseline or rewardInventorySnapshot()
        local syntheticResult = {
            Success = true,
            GameMode = "Infinite",
            WorldName = AttributeHolder:GetAttribute("WorldName") or mapInfo.WorldName,
            Act = AttributeHolder:GetAttribute("Act") or "Infinite",
            Difficulty = AttributeHolder:GetAttribute("Difficulty") or mapInfo.Difficulty,
            PlayerStats = {
                ClearTime = math.max(0, os.clock() - (state.InfiniteRunStartedAt or AO_SCRIPT_STARTED_AT)),
                WavesCompleted = wave,
                Kills = 0,
                TotalDamage = 0,
                UnitsPlaced = ownedTowerCount(),
                MoneyEarned = 0,
            },
            Rewards = {},
        }
        local pendingWebhook = {
            Result = syntheticResult,
            Baseline = rewardBaseline,
            CreatedAt = os.time(),
        }
        environment.AOPendingInfiniteWebhook = pendingWebhook
        task.spawn(processPendingInfiniteWebhook, pendingWebhook)
        state.InfiniteRunStartedAt = os.clock()
        if state.Recording then state.StopRecording(true) end
        if state.Playing then state.StopPlayback() end
        state.PendingStageAutoPlay = ingameConfig.AutoPlayMacro == true
        updateUI("RESTARTING INFINITE AT WAVE " .. tostring(wave))
        log("Auto Restart Infinite requested at wave " .. tostring(wave))
        GameRemote:FireServer("RestartGame")
    end
    local function installHook()
        if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" then log("hook APIs unavailable"); return false end
        local oldNamecall
        local closure = type(newcclosure) == "function" and newcclosure or function(callback) return callback end
        oldNamecall = hookmetamethod(game, "__namecall", closure(function(self, ...)
            local method, args = getnamecallmethod(), table.pack(...)
            local callerIsScript = type(checkcaller) ~= "function" or not checkcaller()
            if state.Running and ingameConfig.AutoParry == true and self == ActRemoteEvent
                and method == "FireServer" and args[1] == "ShaulaAttack" then
                args[2] = true
                return oldNamecall(self, table.unpack(args, 1, args.n))
            elseif state.Running and state.Recording and callerIsScript and self == TowerFunction and method == "InvokeServer" then
                local actionName = args[1]
                local beforeTower = actionName == "UpgradeTower" and ownedTower(args[2]) or nil
                local results = table.pack(oldNamecall(self, table.unpack(args, 1, args.n)))
                if actionName == "PlaceTower" then
                    local result = results[1]
                    local uuid = type(result) == "table" and result.UUID or nil
                    addAction({Type = "Place", Ref = refForUUID(uuid), Slot = args[2], Position = vectorToArray(args[3]), Normal = vectorToArray(args[4]), Rotation = args[5], Extra = args[6]})
                    if uuid then state.RecordedPlacements[uuid] = true end
                elseif actionName == "UpgradeTower" then
                    if not beforeTower or (tonumber(beforeTower.AutoUpgradeMode) or 0) == 0 then addAction({Type = "Upgrade", Target = towerDescriptor(args[2])}) end
                elseif actionName == "SetPriority" or actionName == "ChangePriority" then
                    local priority = args[3]
                    if actionName == "ChangePriority" and args[2] ~= "All" and priority == nil then priority = results[1] end
                    addAction(args[2] == "All" and {Type = "PriorityAll", Priority = priority} or {Type = "Priority", Priority = priority, Target = towerDescriptor(args[2])})
                end
                if type(setnamecallmethod) == "function" then pcall(setnamecallmethod, method) end
                return table.unpack(results, 1, results.n)
            elseif state.Running and state.Recording and callerIsScript and self == TowerRemote and method == "FireServer" and args[1] == "SellTower" then
                local target = args[2]
                local descriptor = target ~= "All" and towerDescriptor(target) or nil
                local results = table.pack(oldNamecall(self, table.unpack(args, 1, args.n)))
                addAction(target == "All" and {Type = "SellAll"} or {Type = "Sell", Target = descriptor})
                if type(setnamecallmethod) == "function" then pcall(setnamecallmethod, method) end
                return table.unpack(results, 1, results.n)
            end
            return oldNamecall(self, ...)
        end))
        state.OldNamecall = oldNamecall
        return true
    end
    local function createUI()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        for _, parent in ipairs({CoreGui, playerGui}) do
            local old = parent:FindFirstChild("AOIngameMacroTestUI")
            if old then old:Destroy() end
        end
        local gui = Instance.new("ScreenGui")
        gui.Name, gui.ResetOnSpawn, gui.DisplayOrder, gui.ZIndexBehavior = "AOIngameMacroTestUI", false, 1000, Enum.ZIndexBehavior.Sibling
        gui.Parent = playerGui
        local panel = Instance.new("Frame")
        panel.Name, panel.AnchorPoint, panel.Position, panel.Size = "Panel", Vector2.zero, UDim2.fromOffset(300, 20), UDim2.fromOffset(300, 232)
        panel.BackgroundColor3, panel.BorderSizePixel, panel.Active, panel.Draggable, panel.Parent = Color3.fromRGB(18, 20, 29), 0, true, true, gui
        Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
        local title = Instance.new("TextLabel")
        title.Size, title.Position, title.BackgroundTransparency = UDim2.new(1, -20, 0, 34), UDim2.fromOffset(10, 6), 1
        title.Text, title.TextColor3, title.Font, title.TextSize, title.Parent = "AO MACRO", Color3.fromRGB(126, 105, 255), Enum.Font.GothamBold, 17, panel
        statusLabel = Instance.new("TextLabel")
        statusLabel.Size, statusLabel.Position, statusLabel.BackgroundTransparency = UDim2.new(1, -20, 0, 26), UDim2.fromOffset(10, 40), 1
        statusLabel.Text, statusLabel.TextColor3, statusLabel.Font, statusLabel.TextSize, statusLabel.Parent = "IDLE", Color3.fromRGB(240, 240, 245), Enum.Font.GothamBold, 14, panel
        countLabel = Instance.new("TextLabel")
        countLabel.Size, countLabel.Position, countLabel.BackgroundTransparency, countLabel.TextWrapped = UDim2.new(1, -20, 0, 48), UDim2.fromOffset(10, 66), 1, true
        countLabel.TextColor3, countLabel.Font, countLabel.TextSize, countLabel.Parent = Color3.fromRGB(175, 180, 195), Enum.Font.Gotham, 12, panel
        local function button(text, y, color, callback)
            local control = Instance.new("TextButton")
            control.Size, control.Position, control.BackgroundColor3, control.BorderSizePixel = UDim2.new(1, -20, 0, 32), UDim2.fromOffset(10, y), color, 0
            control.Text, control.TextColor3, control.Font, control.TextSize, control.Parent = text, Color3.new(1, 1, 1), Enum.Font.GothamBold, 13, panel
            Instance.new("UICorner", control).CornerRadius = UDim.new(0, 7)
            table.insert(state.Connections, control.Activated:Connect(callback))
            return control
        end
        button("RECORD MACRO", 118, Color3.fromRGB(185, 55, 75), state.RecordMacro)
        local playButton
        playButton = button("PLAY MACRO: " .. (ingameConfig.AutoPlayMacro and "ON" or "OFF"), 156, Color3.fromRGB(83, 76, 180), function()
            state.SetPlayMacro(not ingameConfig.AutoPlayMacro)
            playButton.Text = "PLAY MACRO: " .. (ingameConfig.AutoPlayMacro and "ON" or "OFF")
        end)
        local speedButton
        speedButton = button("GAME SPEED: " .. speedLabel(), 194, Color3.fromRGB(45, 105, 145), function()
            cycleGameSpeed()
            speedButton.Text = "GAME SPEED: " .. speedLabel()
        end)
        state.Gui = gui
        updateUI()
    end
    local JSON_LIMIT = 2 * 1024 * 1024
    local function validMacroActions(actions)
        if type(actions) ~= "table" then return false end
        local count, highest = 0, 0
        for index, action in pairs(actions) do
            if type(index) ~= "number" or index < 1 or index % 1 ~= 0 or type(action) ~= "table" then
                return false
            end
            count, highest = count + 1, math.max(highest, index)
        end
        return count == highest
    end
    local function canonicalMacroKey(value)
        if type(value) ~= "string" or value == "" or string.find(value, "[%z\1-\31]") then return nil end
        local mode, world, act, difficulty = string.match(value, "^([^|]+)|([^|]+)|([^|]+)|([^|]+)$")
        return mode and table.concat({mode, world, act, difficulty}, "|") or nil
    end
    local function filenameMacroKey(path)
        local name = string.match(tostring(path or ""), "([^/\\]+)%.json$")
        if not name then return nil end
        local mode, world, act, difficulty = string.match(name, "^([^_]+)_(.+)_([^_]+)_([^_]+)$")
        return mode and canonicalMacroKey(table.concat({mode, world, act, difficulty}, "|")) or nil
    end
    local function payloadMacroKey(payload, path)
        if type(payload) ~= "table" then return filenameMacroKey(path) end
        local map = type(payload.Map) == "table" and payload.Map or nil
        local mapKey = map and (map.CanonicalMacroKey
            or map.GameMode and map.WorldName and map.Act and map.Difficulty
                and table.concat({tostring(map.GameMode), tostring(map.WorldName), tostring(map.Act), tostring(map.Difficulty)}, "|"))
        return canonicalMacroKey(payload.MacroKey) or canonicalMacroKey(payload.Key)
            or canonicalMacroKey(payload.CanonicalMacroKey) or canonicalMacroKey(mapKey) or filenameMacroKey(path)
    end
    local function payloadActions(payload)
        if type(payload) ~= "table" then return nil end
        return validMacroActions(payload.Actions) and payload.Actions or validMacroActions(payload) and payload or nil
    end
    local function readMacroFile(path)
        if type(isfile) ~= "function" or not isfile(path) then return nil, "file does not exist" end
        if type(readfile) ~= "function" then return nil, "local file reading is unavailable" end
        local ok, text = pcall(readfile, path)
        if not ok then return nil, tostring(text) end
        if #text > JSON_LIMIT then return nil, "file exceeds the 2MB limit" end
        local decodedOk, decoded = pcall(HttpService.JSONDecode, HttpService, text)
        if not decodedOk or type(decoded) ~= "table" then return nil, "file is not valid JSON" end
        return decoded
    end
    local function checkedMacroEncode(value)
        local text = HttpService:JSONEncode(value)
        if #text > JSON_LIMIT then error("JSON output exceeds the 2MB limit") end
        return text
    end
local function igrisAutomationLog(kind, message)
    state.IgrisAutomationStatus = tostring(kind) .. ": " .. tostring(message)
    local now = os.clock()
    local key = tostring(kind) .. "|" .. tostring(message)
    if state.LastIgrisAutomationLog ~= key or now - (state.LastIgrisAutomationLogAt or 0) >= 3 then
        state.LastIgrisAutomationLog = key
        state.LastIgrisAutomationLogAt = now
        if not (kind == "Frag" and (message == "waiting for shards" or message == "waiting for character")) then
            log("[Igris " .. tostring(kind) .. "] " .. tostring(message))
        end
    end
end
function state.IsIgrisWorldBossContext()
    local gm = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo and mapInfo.GameMode or "")
    local world = tostring(AttributeHolder:GetAttribute("WorldName") or mapInfo and mapInfo.WorldName or "")
    if gm == "WorldBoss" or gm == "IgrisBossFight" or string.find(gm, "Igris", 1, true) then return true end
    if world == "Igris" or string.find(world, "Igris", 1, true) then return true end
    return false
end
local function collectIgrisShardParts()
    local shards = {}
    local debris = workspace:FindFirstChild("Debris")
    if debris then
        for _, ch in ipairs(debris:GetChildren()) do
            if string.find(ch.Name, "Shard", 1, true) and ch:IsA("BasePart") then
                if ch.Transparency < 1 or ch:FindFirstChild("Attachment") then
                    table.insert(shards, ch)
                end
            end
        end
    end
    if #shards == 0 then
        local map = workspace:FindFirstChild("Map")
        if map then
            for _, inst in ipairs(map:GetDescendants()) do
                if string.find(inst.Name, "Shard", 1, true)
                    and inst:IsA("BasePart")
                    and inst.Transparency < 1 then
                    table.insert(shards, inst)
                    if #shards >= 5 then break end
                end
            end
        end
    end
    return shards
end
task.spawn(function()
    while state.Running do
        task.wait(0.25)
        if ingameConfig.AutoFrag ~= true then continue end
        if not state.IsIgrisWorldBossContext() then
            task.wait(1)
            continue
        end
        local shards = collectIgrisShardParts()
        if #shards == 0 then
            continue
        end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not char or not hrp then
            continue
        end
        igrisAutomationLog("Frag", "collecting " .. tostring(#shards) .. " shard(s)")
        for _, shard in ipairs(shards) do
            if not state.Running or ingameConfig.AutoFrag ~= true then break end
            if not shard or not shard.Parent then continue end
            local okCF, targetCF = pcall(function()
                return shard.CFrame + Vector3.new(0, 2, 0)
            end)
            if not okCF then continue end
            pcall(function() char:PivotTo(targetCF) end)
            pcall(function() hrp.CFrame = targetCF end)
            task.wait(0.12)
            if type(firetouchinterest) == "function" then
                pcall(firetouchinterest, hrp, shard, 0)
                task.wait(0.04)
                pcall(firetouchinterest, hrp, shard, 1)
            end
            local prompt
            pcall(function()
                prompt = shard:FindFirstChildWhichIsA("ProximityPrompt", true)
            end)
            if prompt and type(fireproximityprompt) == "function" then
                pcall(fireproximityprompt, prompt)
            end
            task.wait(0.16)
        end
    end
end)
task.spawn(function()
    local handledClash = false
    while state.Running do
        if ingameConfig.AutoClash ~= true then
            handledClash = false
            task.wait(0.08)
            continue
        end
        RunService.RenderStepped:Wait()
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local gameUI = playerGui and playerGui:FindFirstChild("GameUI")
        local misc = gameUI and gameUI:FindFirstChild("Misc")
        local clash = misc and misc:FindFirstChild("ClashMiniGame")
        if not clash or not clash.Visible then
            handledClash = false
            continue
        end
        if handledClash then
            continue
        end
        handledClash = true
        local ok, err = pcall(ActRemoteEvent.FireServer, ActRemoteEvent, "IgrisClash", true)
        if ok then
            igrisAutomationLog("Clash", "Reported success=true")
        else
            handledClash = false
            igrisAutomationLog("Clash", "result report error: " .. tostring(err))
        end
    end
end)
do
    local ok, effectStatements = pcall(function()
        return require(ReplicatedStorage.EffectStatements)
    end)
    local fireClient = ok and type(effectStatements) == "table" and effectStatements.FireClient or nil
    state.ReZeroHealthSnapshot = function()
        local enemyCount, enemyMaxHealth, enemyTotalHealth = 0, 0, 0
        for _, enemy in pairs(GlobalTables.EnemyDict or {}) do
            if type(enemy) == "table" then
                enemyCount += 1
                enemyMaxHealth = math.max(enemyMaxHealth, tonumber(enemy.MaxHealth) or 0)
                enemyTotalHealth += math.max(0, tonumber(enemy.Health) or 0)
            end
        end
        return {
            BaseHealth = tonumber(AttributeHolder:GetAttribute("BaseHealth")),
            MaxBaseHealth = tonumber(AttributeHolder:GetAttribute("MaxBaseHealth")),
            EnemyCount = enemyCount,
            EnemyMaxHealth = enemyMaxHealth,
            EnemyTotalHealth = enemyTotalHealth,
        }
    end
    if type(fireClient) == "table" and type(fireClient.ShaulaAttackStart) == "function" then
        state.EffectStatementsFireClient = fireClient
        state.OriginalShaulaAttackStart = fireClient.ShaulaAttackStart
        state.ShaulaAttackStartWrapper = function(player, ...)
            if ingameConfig.AutoParry == true and player == LocalPlayer then
                state.ShaulaParryAttempts = (state.ShaulaParryAttempts or 0) + 1
                local attempt = state.ShaulaParryAttempts
                local before = state.ReZeroHealthSnapshot()
                local rbdCount = state.ReturnByDeathCount or 0
                log(string.format(
                    "[Hell Snipe #%d] detected | BaseHP=%s/%s Enemies=%d MaxEnemyHP=%s",
                    attempt, tostring(before.BaseHealth), tostring(before.MaxBaseHealth),
                    before.EnemyCount, tostring(before.EnemyMaxHealth)
                ))
                local sent, err = pcall(ActRemoteEvent.FireServer, ActRemoteEvent, "ShaulaAttack", true)
                if sent then
                    state.ShaulaParryStatus = "Forced Hell Snipe success"
                    log(string.format("[Hell Snipe #%d] sent ShaulaAttack success=true", attempt))
                else
                    state.ShaulaParryStatus = "Remote error: " .. tostring(err)
                    log(string.format("[Hell Snipe #%d] %s", attempt, state.ShaulaParryStatus))
                end
                task.delay(2, function()
                    if not state.Running then return end
                    local after = state.ReZeroHealthSnapshot()
                    local baseDamaged = before.BaseHealth and after.BaseHealth and after.BaseHealth < before.BaseHealth
                    local rbdTriggered = (state.ReturnByDeathCount or 0) > rbdCount
                    state.ShaulaParryVerified = sent and not baseDamaged and not rbdTriggered
                    log(string.format(
                        "[Hell Snipe #%d] VERIFY after 2s: %s | BaseHP %s->%s RBD=%s",
                        attempt, state.ShaulaParryVerified and "PASS" or "FAIL",
                        tostring(before.BaseHealth), tostring(after.BaseHealth),
                        tostring(rbdTriggered)
                    ))
                end)
                return
            end
            return state.OriginalShaulaAttackStart(player, ...)
        end
        fireClient.ShaulaAttackStart = state.ShaulaAttackStartWrapper
    else
        state.ShaulaParryStatus = "ReZero effect hook unavailable"
    end
    if type(fireClient) == "table" and type(fireClient.ReturnByDeath) == "function" then
        state.EffectStatementsFireClient = fireClient
        state.OriginalReturnByDeath = fireClient.ReturnByDeath
        state.ReturnByDeathWrapper = function(player, returnPosition, ...)
            state.ReturnByDeathCount = (state.ReturnByDeathCount or 0) + 1
            state.LastReturnByDeathAt = os.clock()
            local before = state.ReZeroHealthSnapshot()
            log(string.format(
                "[Return By Death #%d] TRIGGERED | BaseHP=%s/%s",
                state.ReturnByDeathCount, tostring(before.BaseHealth), tostring(before.MaxBaseHealth)
            ))
            if ingameConfig.FixLag == true then
                local character = LocalPlayer.Character
                if character and returnPosition then
                    pcall(function() character:PivotTo(CFrame.new(returnPosition)) end)
                end
                local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                local notification = playerGui and playerGui:FindFirstChild("NotificationUI")
                local gameUI = playerGui and playerGui:FindFirstChild("GameUI")
                local misc = gameUI and gameUI:FindFirstChild("Misc")
                local rbdFrame = misc and misc:FindFirstChild("RBDFrame")
                if notification then notification.Enabled = true end
                if rbdFrame then rbdFrame.Visible = false end
                state.ReturnByDeathStatus = "Cutscene skipped"
                log("[ReZero] skipped Return By Death cutscene")
                return
            end
            return state.OriginalReturnByDeath(player, returnPosition, ...)
        end
        fireClient.ReturnByDeath = state.ReturnByDeathWrapper
    end
    state.ActivateLibraryBook = function(holder)
        if typeof(holder) ~= "Instance" or state.LibraryBookBusy then return end
        state.LibraryBookBusy = true
        state.LibraryBookAttempts = (state.LibraryBookAttempts or 0) + 1
        local attempt = state.LibraryBookAttempts
        task.spawn(function()
            local character = LocalPlayer.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not (character and root) then
                state.LibraryBookBusy = false
                log(string.format("[Auto Book #%d] failed: character unavailable", attempt))
                return
            end
            local originalPivot = character:GetPivot()
            local bookSeen = false
            local deadline = os.clock() + 8
            log(string.format("[Auto Book #%d] correct holder: %s", attempt, holder:GetFullName()))
            while state.Running and ingameConfig.AutoFindBook == true and holder.Parent and os.clock() < deadline do
                local book = holder:FindFirstChild("Book")
                if book then bookSeen = true end
                if bookSeen and not book then
                    log(string.format("[Auto Book #%d] success: correct book consumed", attempt))
                    break
                end
                local ok, targetPivot = pcall(function()
                    return holder:IsA("BasePart") and holder.CFrame or holder:GetPivot()
                end)
                if ok then pcall(function() character:PivotTo(targetPivot * CFrame.new(0, 3, 0)) end) end
                local prompt = holder:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt and type(fireproximityprompt) == "function" then
                    pcall(fireproximityprompt, prompt, 0)
                end
                local click = holder:FindFirstChildWhichIsA("ClickDetector", true)
                if click and type(fireclickdetector) == "function" then
                    pcall(fireclickdetector, click)
                end
                if type(firetouchinterest) == "function" then
                    if holder:IsA("BasePart") then
                        pcall(firetouchinterest, root, holder, 0)
                        pcall(firetouchinterest, root, holder, 1)
                    end
                    if book then
                        for _, part in ipairs(book:GetDescendants()) do
                            if part:IsA("BasePart") then
                                pcall(firetouchinterest, root, part, 0)
                                pcall(firetouchinterest, root, part, 1)
                            end
                        end
                    end
                end
                task.wait(0.2)
            end
            if holder.Parent and holder:FindFirstChild("Book") then
                log(string.format("[Auto Book #%d] timeout: interaction was not accepted", attempt))
            end
            if character.Parent then pcall(function() character:PivotTo(originalPivot) end) end
            state.LibraryBookBusy = false
        end)
    end
    if type(fireClient) == "table" and type(fireClient.SpawnBooks) == "function" then
        state.OriginalSpawnBooks = fireClient.SpawnBooks
        state.SpawnBooksWrapper = function(correctHolder, ...)
            local results = table.pack(state.OriginalSpawnBooks(correctHolder, ...))
            if ingameConfig.AutoFindBook == true
                and string.find(tostring(AttributeHolder:GetAttribute("WorldName") or ""), "PleiadesLibrary", 1, true) then
                state.ActivateLibraryBook(correctHolder)
            end
            return table.unpack(results, 1, results.n)
        end
        fireClient.SpawnBooks = state.SpawnBooksWrapper
    end
end
local disabledIgrisChestConnections = {}
local function refreshIgrisChestBypass()
    if type(getconnections) ~= "function" or type(debug) ~= "table" or type(debug.info) ~= "function" then
        state.IgrisChestBypassReady = false
        return
    end
    if ingameConfig.AutoChest == true then
        for _, connection in ipairs(getconnections(ActRemoteEvent.OnClientEvent)) do
            local source = ""
            pcall(function() source = tostring(debug.info(connection.Function, "s") or "") end)
            if string.find(source, "GameModeStuff.IgrisChests", 1, true) then
                if connection.Enabled then connection:Disable() end
                disabledIgrisChestConnections[connection] = true
            end
        end
    else
        for connection in pairs(disabledIgrisChestConnections) do
            pcall(function() connection:Enable() end)
            disabledIgrisChestConnections[connection] = nil
        end
    end
    state.IgrisChestBypassReady = ingameConfig.AutoChest == true and next(disabledIgrisChestConnections) ~= nil
end
table.insert(state.Connections, ActRemoteEvent.OnClientEvent:Connect(function(action, chestRemote)
    if action ~= "PickIgrisChest" or ingameConfig.AutoChest ~= true
        or not state.IgrisChestBypassReady or state.IgrisChestBypassBusy then return end
    if typeof(chestRemote) ~= "Instance" or not chestRemote:IsA("RemoteFunction") then
        igrisAutomationLog("Chest", "bypass received an invalid chest remote")
        return
    end
    state.IgrisChestBypassBusy = true
    task.spawn(function()
        local keyAmount = 0
        pcall(function()
            keyAmount = tonumber(GlobalTables.GetItemAmount("Currency", "WorldBossKey")) or 0
        end)
        local choice = keyAmount > 0 and "Key" or "Normal"
        local ok, rewards = pcall(chestRemote.InvokeServer, chestRemote, "PickIgrisChest", choice)
        if ok then
            state.LastIgrisChestRewards = type(rewards) == "table" and rewards or {}
            ActRemoteEvent:FireServer("IgrisChestFinished")
            igrisAutomationLog(
                "Chest",
                string.format("Bypassed %s chest visuals; keys=%d rewards=%d", choice, keyAmount, #state.LastIgrisChestRewards)
            )
        else
            igrisAutomationLog("Chest", "bypass invoke failed: " .. tostring(rewards))
        end
        state.IgrisChestBypassBusy = false
    end)
end))
task.spawn(function()
    local visibleSince
    local lastAttemptAt = 0
    while state.Running do
        refreshIgrisChestBypass()
        if ingameConfig.AutoChest ~= true then
            visibleSince = nil
            task.wait(0.08)
            continue
        end
        if state.IgrisChestBypassReady then
            visibleSince = nil
            task.wait(0.08)
            continue
        end
        RunService.RenderStepped:Wait()
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local gameUI = playerGui and playerGui:FindFirstChild("GameUI")
        local misc = gameUI and gameUI:FindFirstChild("Misc")
        local selection = misc and misc:FindFirstChild("IgrisChestSelection")
        if not selection or not selection.Visible then
            visibleSince = nil
            continue
        end
        visibleSince = visibleSince or os.clock()
        local now = os.clock()
        if now - visibleSince < 1.5 or now - lastAttemptAt < 0.4 then
            continue
        end
        local keyAmount = 0
        pcall(function()
            keyAmount = tonumber(GlobalTables.GetItemAmount("Currency", "WorldBossKey")) or 0
        end)
        local choice = keyAmount > 0 and "Key" or "Normal"
        local debris = workspace:FindFirstChild("Debris")
        local chest = debris and debris:FindFirstChild(choice .. "Chest")
        local primaryPart = chest and chest.PrimaryPart
        local camera = workspace.CurrentCamera
        if not primaryPart or not camera then
            continue
        end
        local screenPosition, onScreen = camera:WorldToViewportPoint(primaryPart.Position)
        if not onScreen or screenPosition.Z <= 0 then
            continue
        end
        lastAttemptAt = now
        local x = math.floor(screenPosition.X + 0.5)
        local y = math.floor(screenPosition.Y + 0.5)
        VirtualInputManager:SendMouseMoveEvent(x, y, game)
        RunService.RenderStepped:Wait()
        VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
        igrisAutomationLog(
            "Chest",
            string.format("Selecting %s chest; keys=%d", choice, keyAmount)
        )
    end
end)
task.spawn(function()
    local recentRequests = {}
    while state.Running do
        task.wait(0.2)
        if ingameConfig.AutoMadaraMaxBonus ~= true then
            table.clear(recentRequests)
            continue
        end
        local activeInfo = TowerAbilitiesInfo.Actives.Madara_Active
        local elapsed = tonumber((GlobalTables.SuperGlobalTimeElapsed or {}).Madara_Active)
        if elapsed and elapsed < (tonumber(activeInfo and activeInfo.Cooldown) or 99999999) then
            continue
        end
        local now = os.clock()
        for uuid, tower in pairs(GlobalTables.TowerDict or {}) do
            if tower.Owner ~= LocalPlayer or tower.TowerName ~= "Madara_Evolved" then continue end
            local node = tower.Node or workspace:FindFirstChild("UnitNodes")
                and workspace.UnitNodes:FindFirstChild(tostring(uuid))
            local storedTime = tonumber(node and node:GetAttribute("PassiveValue")) or 0
            if storedTime < 180 then continue end
            local requestKey = tostring(uuid)
            if now - (recentRequests[requestKey] or 0) < 5 then continue end
            recentRequests[requestKey] = now
            TowerRemote:FireServer("TowerActive", uuid, "Madara_Active")
            log(string.format("Madara active requested at max stored time: uuid=%s time=%s", requestKey, tostring(storedTime)))
            break
        end
        for uuid, requestedAt in pairs(recentRequests) do
            if now - requestedAt > 30 then recentRequests[uuid] = nil end
        end
    end
end)
task.spawn(function()
    local recentRequests = {}
    local recentCopyRequests = {}
    local function towerHasAbility(tower, abilityName)
        local towerInfo = tower and TowerInfo[tower.TowerName]
        if not towerInfo then return false end
        for stage = 1, math.max(1, tonumber(tower.Stage) or 1) do
            local stageInfo = towerInfo.StageStats and towerInfo.StageStats[stage]
            for _, activeName in ipairs(stageInfo and stageInfo.Actives or {}) do
                if tostring(activeName) == tostring(abilityName) then return true end
            end
        end
        return false
    end
    while state.Running do
        task.wait(0.15)
        if ingameConfig.AutoYutaAbility ~= true then
            table.clear(recentRequests)
            continue
        end
        local selected, selectedOrder = {}, {}
        for key, value in pairs(type(ingameConfig.YutaAutoAbilities) == "table" and ingameConfig.YutaAutoAbilities or {}) do
            local ability = type(key) == "number" and value or value and key or nil
            if ability and not selected[tostring(ability)] then
                ability = tostring(ability)
                selected[ability] = true
                table.insert(selectedOrder, ability)
            end
        end
        if next(selected) == nil then continue end
        local now = os.clock()
        for uuid, tower in pairs(GlobalTables.TowerDict or {}) do
            if tower.Owner ~= LocalPlayer or (tower.TowerName ~= "Yuta" and tower.TowerName ~= "Yuta_Evolved") then
                continue
            end
            local node = tower.Node or workspace:FindFirstChild("UnitNodes")
                and workspace.UnitNodes:FindFirstChild(tostring(uuid))
            if not node then continue end
            local copied, freeSlot = {}, nil
            for slot = 1, 4 do
                local copiedAbility = node:GetAttribute("Ability" .. slot)
                if copiedAbility then copied[tostring(copiedAbility)] = true elseif not freeSlot then freeSlot = slot end
            end
            if freeSlot and now - (recentCopyRequests[tostring(uuid)] or 0) >= 120 then
                local abilityToCopy, providerUUID
                for _, selectedAbility in ipairs(selectedOrder) do
                    if not copied[selectedAbility] then
                        for candidateUUID, candidate in pairs(GlobalTables.TowerDict or {}) do
                            if candidate.Owner == LocalPlayer and tostring(candidateUUID) ~= tostring(uuid)
                                and towerHasAbility(candidate, selectedAbility) then
                                abilityToCopy, providerUUID = selectedAbility, candidateUUID
                                break
                            end
                        end
                    end
                    if providerUUID then break end
                end
                if providerUUID then
                    recentCopyRequests[tostring(uuid)] = now
                    PassiveBarRemote:FireServer({
                        Action = "CopyAbility",
                        YutaUUID = tostring(uuid),
                        TargetTowerUUID = tostring(providerUUID),
                    })
                    log(string.format(
                        "Yuta auto copy requested: %s from uuid=%s to uuid=%s",
                        tostring(abilityToCopy), tostring(providerUUID), tostring(uuid)
                    ))
                end
            end
            for slot = 1, 4 do
                local abilityName = node:GetAttribute("Ability" .. slot)
                local abilityInfo = abilityName and TowerAbilitiesInfo.Actives[abilityName]
                if not abilityInfo or not selected[tostring(abilityName)] or abilityInfo.AutoUse == false then
                    continue
                end
                local requestKey = tostring(uuid) .. "|" .. tostring(slot) .. "|" .. tostring(abilityName)
                if now - (recentRequests[requestKey] or 0) < 1 then continue end
                local elapsedTable
                if abilityInfo.SuperGlobal then
                    elapsedTable = GlobalTables.SuperGlobalTimeElapsed
                elseif abilityInfo.Global then
                    elapsedTable = GlobalTables.GlobalTimeElapsed
                else
                    tower.LocalTimeElapsed = tower.LocalTimeElapsed or {}
                    elapsedTable = tower.LocalTimeElapsed
                end
                elapsedTable = elapsedTable or {}
                local cooldownKey = "YutaCopied_" .. tostring(abilityName)
                local elapsed = elapsedTable[cooldownKey]
                if elapsed ~= nil and elapsed < (tonumber(abilityInfo.Cooldown) or 0) + 1 then
                    continue
                end
                if abilityInfo.TargetRequired ~= false then
                    local targetUUID = tower.TargetUUID
                    if not targetUUID or not (GlobalTables.EnemyDict or {})[targetUUID] then continue end
                end
                local inputData
                local handler = PreActiveHandlers[abilityName]
                if handler then
                    local ok, allowed, data = pcall(handler, {
                        IsAuto = true,
                        IsCopied = true,
                        Tower = tower,
                        ActiveName = abilityName,
                        ActiveInfo = abilityInfo,
                        CopySlot = slot,
                    })
                    if not ok or not allowed then continue end
                    inputData = data
                end
                recentRequests[requestKey] = now
                elapsedTable[cooldownKey] = 0
                PassiveBarRemote:FireServer({
                    Action = "UseCopiedAbility",
                    YutaUUID = tostring(uuid),
                    Slot = slot,
                    InputData = inputData,
                })
                log(string.format("Yuta auto ability used: %s slot=%d uuid=%s", abilityName, slot, tostring(uuid)))
            end
        end
        for requestKey, requestedAt in pairs(recentRequests) do
            if now - requestedAt > 300 then recentRequests[requestKey] = nil end
        end
    end
end)
local function fetchMacroShareInput(value)
        local url = tostring(value or ""):match("^%s*(.-)%s*$")
        if not url:match("^https://") then return url end
        if not string.find(url, "/m/", 1, true) and not string.find(url, "/api/macros/", 1, true) then
            error("Macro share link must use /m/<id> or /api/macros/<id>")
        end
        local origin, id = url:match("^(https://[^/]+)/m/([a-fA-F0-9]+)")
        if origin and id then url = origin .. "/api/macros/" .. string.lower(id) end
        if type(request) == "function" then
            local ok, response = pcall(request, {Url = url, Method = "GET", Headers = {Accept = "application/json"}})
            if not ok or type(response) ~= "table" then error("Macro share request failed") end
            local status = tonumber(response.StatusCode or response.Status)
            if status and (status < 200 or status >= 300) then error("Macro share request returned HTTP " .. tostring(status)) end
            return tostring(response.Body or "")
        end
        local ok, body = pcall(function() return game:HttpGet(url, true) end)
        if not ok then error("Macro share request failed: " .. tostring(body)) end
        return body
    end
    local function igApplyFields(target, defaultsTable, source)
        local webhook = target.WebhookUrl
        for key in pairs(defaultsTable) do
            if key ~= "WebhookUrl" and key ~= "QuestRuntimeTarget" and source[key] ~= nil then
                target[key] = source[key]
            end
        end
        target.WebhookUrl, target.QuestRuntimeTarget = webhook, nil
    end
    local function igExportConfigShare(notifyFn)
        local ingame = {}
        for key in pairs(ingameDefaults) do
            if key ~= "QuestRuntimeTarget" and key ~= "WebhookUrl" then ingame[key] = ingameConfig[key] end
        end
        local text = HttpService:JSONEncode({format = "AnimeOriginsConfigBundle", version = 1, gameId = tostring(game.GameId), config = {Lobby = {}, InGame = ingame}})
        local response = aoRequest({
            Url = "https://originsmarcoshare.netlify.app/api/macros",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = text,
        })
        if not response then error("Config upload request failed") end
        local status = tonumber(response.StatusCode or response.Status)
        if status and (status < 200 or status >= 300) then
            error("Config upload returned HTTP " .. tostring(status) .. ": " .. tostring(response.Body or ""))
        end
        local decoded = HttpService:JSONDecode(tostring(response.Body or ""))
        if type(decoded) ~= "table" or not decoded.shareUrl then error("Upload response has no share link") end
        return decoded.shareUrl, text
    end
    local function igImportConfigShare(rawText, notifyFn)
        if rawText == "" then error("Paste a config share link or JSON bundle") end
        if rawText:match("^https://") then rawText = fetchMacroShareInput(rawText) end
        local ok, bundle = pcall(function() return HttpService:JSONDecode(rawText) end)
        if not ok or type(bundle) ~= "table" then error("Config bundle JSON is invalid") end
        if bundle.format ~= "AnimeOriginsConfigBundle" or bundle.version ~= 1
            or tostring(bundle.gameId) ~= tostring(game.GameId) or type(bundle.config) ~= "table" then
            error("Invalid config bundle format, version, or gameId")
        end
        local igc = type(bundle.config.InGame) == "table" and bundle.config.InGame
            or type(bundle.config.Lobby) == "table" and bundle.config.Lobby or bundle.config
        igApplyFields(ingameConfig, ingameDefaults, igc)
        normalizeIngameConfig(ingameConfig)
        saveLobbyConfig(ingameConfig)
        if state.SetHidePlayerNames then state.SetHidePlayerNames(ingameConfig.HidePlayerNames) end
    end
    environment.AnimeOriginsConfigShare = {Export = igExportConfigShare, Import = igImportConfigShare}
    local function safeMacroName(key)
        local canonical = canonicalMacroKey(key)
        if not canonical then return nil end
        local name = string.gsub(canonical, "[^A-Za-z0-9_-]", "_")
        name = string.gsub(name, "^_+", "")
        return name ~= "" and string.sub(name, 1, 180) or nil
    end
    local function writeMacroExport(name, text)
        if type(writefile) ~= "function" then error("Local file writing is unavailable") end
        ensureFolders()
        local path = exportsFolder .. "/" .. name
        local ok, err = pcall(writefile, path, text)
        if not ok then error("Could not write " .. path .. ": " .. tostring(err)) end
        return path
    end
    local function currentMacroExport()
        local payload, err = readMacroFile(macroPath)
        if not payload then error("No exact saved macro for " .. macroKey .. ": " .. err) end
        local savedKey = payloadMacroKey(payload)
        if savedKey and savedKey ~= macroKey then
            error("The exact macro file belongs to " .. savedKey .. ", not " .. macroKey)
        end
        local actions = payloadActions(payload)
        if not actions or #actions == 0 then error("The exact saved macro for " .. macroKey .. " has no actions") end
        local text = checkedMacroEncode({
            format = "AnimeOriginsMacros", version = 2, gameId = tostring(game.GameId), macros = {[macroKey] = actions},
        })
        return text, 1, writeMacroExport("current-macro.json", text)
    end
    local function allMacrosExport()
        local macros, count = {}, 0
        if type(listfiles) == "function" and type(isfolder) == "function" and isfolder(macrosFolder) then
            local listed, files = pcall(listfiles, macrosFolder)
            if listed then
                for _, path in ipairs(files) do
                    if string.lower(string.sub(path, -5)) == ".json" then
                        local payload = readMacroFile(path)
                        local key = payload and payloadMacroKey(payload, path) or nil
                        local actions = payload and payloadActions(payload) or nil
                        if key and actions and #actions > 0 and macros[key] == nil then
                            macros[key], count = actions, count + 1
                        end
                    end
                end
            end
        end
        local text = checkedMacroEncode({
            format = "AnimeOriginsMacros", version = 2, gameId = tostring(game.GameId), macros = macros,
        })
        return text, count, writeMacroExport("all-macros.json", text)
    end
    local function showMacroImportPopup(imports, onApply, notifyFn)
        local function popupNotify(title, content)
            pcall(function()
                if type(notifyFn) == "function" then notifyFn(title, content)
                elseif Fluent then Fluent:Notify({Title = title, Content = content, Duration = 6}) end
            end)
        end
        local names = {}
        for key in pairs(imports) do
            if type(key) == "string" and key ~= "" and imports[key] then table.insert(names, key) end
        end
        table.sort(names, function(a, b) return string.lower(a) < string.lower(b) end)
        if #names == 0 then
            popupNotify("Import Macro", "Bundle contains no macros.")
            return
        end
        local old = CoreGui:FindFirstChild("AnimeOriginsMacroImport")
        if old then old:Destroy() end
        local gui = Instance.new("ScreenGui")
        gui.Name = "AnimeOriginsMacroImport"
        gui.DisplayOrder = 10000
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false
        local parented = pcall(function() gui.Parent = CoreGui end)
        if not parented then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
        local shade = Instance.new("TextButton")
        shade.AutoButtonColor = false
        shade.Text = ""
        shade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        shade.BackgroundTransparency = 0.25
        shade.Size = UDim2.fromScale(1, 1)
        shade.Parent = gui
        local panel = Instance.new("Frame")
        panel.AnchorPoint = Vector2.new(0.5, 0.5)
        panel.Position = UDim2.fromScale(0.5, 0.5)
        panel.Size = UDim2.new(0.88, 0, 0.78, 0)
        panel.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
        panel.Parent = shade
        Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
        local constraint = Instance.new("UISizeConstraint", panel)
        constraint.MinSize = Vector2.new(290, 330)
        constraint.MaxSize = Vector2.new(520, 560)
        local title = Instance.new("TextLabel")
        title.BackgroundTransparency = 1
        title.Position = UDim2.fromOffset(18, 14)
        title.Size = UDim2.new(1, -36, 0, 26)
        title.Font = Enum.Font.GothamBold
        title.Text = "Import Macro from link"
        title.TextColor3 = Color3.fromRGB(245, 245, 248)
        title.TextSize = 19
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = panel
        local details = Instance.new("TextLabel")
        details.BackgroundTransparency = 1
        details.Position = UDim2.fromOffset(18, 42)
        details.Size = UDim2.new(1, -36, 0, 22)
        details.Font = Enum.Font.Gotham
        details.Text = tostring(#names) .. " Macro | Only ticked entries are imported"
        details.TextColor3 = Color3.fromRGB(165, 168, 180)
        details.TextSize = 12
        details.TextXAlignment = Enum.TextXAlignment.Left
        details.Parent = panel
        local selected, rows = {}, {}
        for _, name in ipairs(names) do selected[name] = true end
        local selectAll = Instance.new("TextButton")
        selectAll.AutoButtonColor = false
        selectAll.BackgroundColor3 = Color3.fromRGB(37, 39, 49)
        selectAll.Position = UDim2.fromOffset(18, 70)
        selectAll.Size = UDim2.new(1, -36, 0, 34)
        selectAll.Font = Enum.Font.GothamSemibold
        selectAll.TextColor3 = Color3.fromRGB(220, 222, 230)
        selectAll.TextSize = 13
        Instance.new("UICorner", selectAll).CornerRadius = UDim.new(0, 7)
        selectAll.Parent = panel
        local list = Instance.new("ScrollingFrame")
        list.BackgroundTransparency = 1
        list.BorderSizePixel = 0
        list.Position = UDim2.fromOffset(18, 112)
        list.Size = UDim2.new(1, -36, 1, -178)
        list.ScrollBarThickness = 4
        list.ScrollBarImageColor3 = Color3.fromRGB(100, 105, 125)
        list.CanvasSize = UDim2.fromOffset(0, 0)
        list.Parent = panel
        local layout = Instance.new("UIListLayout", list)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        local function renderSelectAll()
            local count = 0
            for _, name in ipairs(names) do if selected[name] then count += 1 end end
            selectAll.Text = (count == #names and "[x] " or "[ ] ") .. "Select all (" .. tostring(count) .. "/" .. tostring(#names) .. ")"
        end
        for index, name in ipairs(names) do
            local row = Instance.new("TextButton")
            row.AutoButtonColor = false
            row.BackgroundColor3 = Color3.fromRGB(31, 33, 42)
            row.Size = UDim2.new(1, -6, 0, 40)
            row.LayoutOrder = index
            row.Font = Enum.Font.Gotham
            row.Text = "[x]  " .. name .. "  (" .. tostring(#imports[name]) .. ")"
            row.TextColor3 = Color3.fromRGB(232, 233, 239)
            row.TextSize = 13
            row.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)
            local padding = Instance.new("UIPadding", row)
            padding.PaddingLeft = UDim.new(0, 12)
            row.Parent = list
            rows[name] = row
            row.Activated:Connect(function()
                selected[name] = not selected[name]
                row.Text = (selected[name] and "[x]  " or "[ ]  ") .. name .. "  (" .. tostring(#imports[name]) .. ")"
                renderSelectAll()
            end)
        end
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            list.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 4)
        end)
        renderSelectAll()
        selectAll.Activated:Connect(function()
            local enable = false
            for _, name in ipairs(names) do if not selected[name] then enable = true break end end
            for _, name in ipairs(names) do
                selected[name] = enable
                rows[name].Text = (enable and "[x]  " or "[ ]  ") .. name .. "  (" .. tostring(#imports[name]) .. ")"
            end
            renderSelectAll()
        end)
        local cancel = Instance.new("TextButton")
        cancel.BackgroundColor3 = Color3.fromRGB(46, 48, 59)
        cancel.Position = UDim2.new(0, 18, 1, -54)
        cancel.Size = UDim2.new(0.38, -4, 0, 38)
        cancel.Font = Enum.Font.GothamSemibold
        cancel.Text = "Cancel"
        cancel.TextColor3 = Color3.fromRGB(225, 226, 232)
        cancel.TextSize = 13
        Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 7)
        cancel.Parent = panel
        cancel.Activated:Connect(function() gui:Destroy() end)
        local confirm = Instance.new("TextButton")
        confirm.BackgroundColor3 = Color3.fromRGB(86, 118, 255)
        confirm.Position = UDim2.new(0.38, 22, 1, -54)
        confirm.Size = UDim2.new(0.62, -40, 0, 38)
        confirm.Font = Enum.Font.GothamBold
        confirm.Text = "Import selected"
        confirm.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirm.TextSize = 13
        Instance.new("UICorner", confirm).CornerRadius = UDim.new(0, 7)
        confirm.Parent = panel
        confirm.Activated:Connect(function()
            local picked = {}
            for _, name in ipairs(names) do if selected[name] then picked[name] = imports[name] end end
            gui:Destroy()
            if next(picked) then
                if onApply then onApply(picked) end
            else
                popupNotify("Import Macro", "No macro was selected.")
            end
        end)
    end
    local function createFluentUI()
        if state.Window then
            pcall(function() state.Window:Destroy() end)
            state.Window = nil
        end
        local window
        local ok, err = pcall(function()
            local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
            window = Fluent:CreateWindow({
                Title = "Anime Origins Ultimate",
                SubTitle = "In-Game Macro",
                TabWidth = 140,
                Size = UDim2.fromOffset(560, 420),
                Acrylic = false,
                Theme = "Dark",
                MinimizeKey = Enum.KeyCode.RightControl,
            })
            state.Window = window
            local function notify(title, content)
                Fluent:Notify({Title = title, Content = tostring(content), Duration = 6})
            end
            local function withJsonError(callback)
                return function()
                    local success, message = pcall(callback)
                    if not success then notify("JSON Error", message) end
                end
            end
            local function setMacroJsonOutput(input, text)
                if #text > JSON_LIMIT then error("JSON output exceeds the 2MB limit") end
                input:SetValue(text)
                local clipboard = type(setclipboard) == "function" and setclipboard
                    or type(toclipboard) == "function" and toclipboard or nil
                if clipboard then pcall(clipboard, text) end
            end
            local lobbyTab = window:AddTab({Title = "Lobby Info", Icon = "home"})
            local claimTab = window:AddTab({Title = "Auto Claim", Icon = "gift"})
            local questTab = window:AddTab({Title = "Auto Quest", Icon = "target"})
            local riftTab = window:AddTab({Title = "Auto Rift", Icon = "zap"})
            local challengeTab = window:AddTab({Title = "Auto Challenge", Icon = "swords"})
            local storyTab = window:AddTab({Title = "Auto Story", Icon = "book-open"})
            local joinTab = window:AddTab({Title = "Auto Join", Icon = "map"})
            local craftTab = window:AddTab({Title = "Auto Craft", Icon = "hammer"})
            state.IngameShopTab = window:AddTab({Title = "Auto Shop", Icon = "shopping-cart"})
            local summonTab = window:AddTab({Title = "Auto Summon", Icon = "sparkles"})
            local macroTab = window:AddTab({Title = "Macro In-Game", Icon = "play"})
            local webhookTab = window:AddTab({Title = "Webhook", Icon = "message-circle"})
            local settingsTab = window:AddTab({Title = "Settings", Icon = "settings"})
            local configsTab = window:AddTab({Title = "Configs", Icon = "folder"})
            local deferredText = "Configured in game; automation runs after returning to lobby."
            for _, tab in ipairs({claimTab, questTab, riftTab, challengeTab, storyTab, joinTab, craftTab, state.IngameShopTab, summonTab}) do
                tab:AddParagraph({Title = "Lobby-only automation", Content = deferredText})
            end
            lobbyTab:AddParagraph({
                Title = "Current Game",
                Content = string.format(
                    "Place: %s\nMap: %s\nAct: %s\nDifficulty: %s",
                    tostring(game.PlaceId), tostring(mapInfo.WorldName), tostring(mapInfo.Act), tostring(mapInfo.Difficulty)
                ),
            })
            lobbyTab:AddParagraph({
                Title = "Automation Paused",
                Content = "Lobby automations are paused in this game server. Configure them here; they will run after returning to lobby.",
            })
            local function saveToggle(tab, id, key, title, callback)
                tab:AddToggle(id, {Title = title, Default = ingameConfig[key] == true}):OnChanged(function(value)
                    ingameConfig[key] = value == true
                    if callback then callback(ingameConfig[key]) end
                    saveLobbyConfig(ingameConfig)
                end)
            end
            local function selectionSet(values)
                local selected = {}
                for key, value in pairs(type(values) == "table" and values or {}) do
                    local item = type(key) == "number" and value or value and key or nil
                    if item then selected[tostring(item)] = true end
                end
                return selected
            end
            local function worldOptions(mode)
                if mode == "Artifact" then
                    local artifacts, seen = {}, {}
                    for name, amount in pairs(((GlobalTables.Inventory or {}).Artifacts) or {}) do
                        if tonumber(amount) and tonumber(amount) > 0 and ItemInfo.Artifacts and ItemInfo.Artifacts[name] then
                            seen[tostring(name)] = true
                            table.insert(artifacts, tostring(name))
                        end
                    end
                    table.sort(artifacts)
                    return artifacts
                end
                if mode == "Trial" then
                    return {"SandVillage", "PleiadesGrass"}
                end
                if mode == "ReZero" then
                    return {"PleiadesSand", "PleiadesLibrary"}
                end
                if mode == "Legend" then
                    local legendWorlds = {}
                    for _, w in ipairs(GameInfo.Ordering or {}) do
                        local info = GameInfo[w]
                        if info and (info.LegendAmount or 0) > 0 then
                            table.insert(legendWorlds, tostring(w))
                        end
                    end
                    return #legendWorlds > 0 and legendWorlds or {"WestCity"}
                end
                if mode == "WorldBoss" then
                    return {"Igris"}
                end
                local ordering = mode == "Raid" and GameInfo.RaidOrdering
                    or mode == "Rift" and GameInfo.RiftOrdering or GameInfo.Ordering
                local options = {}
                for _, world in ipairs(ordering or {}) do table.insert(options, tostring(world)) end
                return #options > 0 and options or {"WestCity"}
            end
            local function actOptions(world, mode)
                if mode == "Infinite" then return {"Infinite"} end
                if mode == "Trial" then return world == "PleiadesGrass" and {"Trial"} or {"MadaraStage"} end
                if mode == "ReZero" then return {"1", "2"} end
                if mode == "WorldBoss" then return {"None"} end
                local options, info = {}, GameInfo[world]
                if mode == "Legend" then
                    for act = 1, tonumber(info and info.LegendAmount) or 0 do table.insert(options, "Legend" .. tostring(act)) end
                    return #options > 0 and options or {"Legend1"}
                end
                for act = 1, tonumber(info and info.ActAmount) or 1 do table.insert(options, tostring(act)) end
                return options
            end
            local function ensureOption(options, value)
                value = tostring(value or "")
                return table.find(options, value) and value or options[1]
            end
            local function clearQuestTarget()
                ingameConfig.QuestRuntimeTarget = nil
            end
            for _, entry in ipairs({
                {"AutoClaim", "Enable Auto Claim"}, {"ClaimQuests", "Quests"},
                {"ClaimDaily", "Daily Rewards"}, {"ClaimPlaytime", "Playtime Rewards"},
                {"ClaimBattlepass", "Battlepass"}, {"ClaimLevelMilestones", "Level Milestones"},
                {"ClaimTowerIndex", "Tower Index and Milestones"}, {"ClaimGroupReward", "Group Reward"},
                {"ClaimInfinityRank", "Infinity Castle Rank Reward"},
            }) do
                saveToggle(claimTab, "IG_Claim_" .. entry[1], entry[1], entry[2])
            end
            saveToggle(questTab, "IG_Quest_AutoQuest", "AutoQuest", "Enable Auto Quest", clearQuestTarget)
            saveToggle(questTab, "IG_Quest_AutoQuestSummon", "AutoQuestSummon", "Allow Standard banner spending", clearQuestTarget)
            local questWorlds = worldOptions("Story")
            ingameConfig.QuestWorld = ensureOption(questWorlds, ingameConfig.QuestWorld)
            local questActs = actOptions(ingameConfig.QuestWorld)
            ingameConfig.QuestAct = ensureOption(questActs, ingameConfig.QuestAct)
            local questActDropdown
            local questWorldDropdown = questTab:AddDropdown("IG_Quest_World", {
                Title = "Story world", Values = questWorlds, Default = ingameConfig.QuestWorld,
            })
            questActDropdown = questTab:AddDropdown("IG_Quest_Act", {
                Title = "Story act", Values = questActs, Default = ingameConfig.QuestAct,
            })
            questWorldDropdown:OnChanged(function(value)
                ingameConfig.QuestWorld = tostring(value)
                local acts = actOptions(ingameConfig.QuestWorld)
                ingameConfig.QuestAct = table.find(acts, tostring(ingameConfig.QuestAct)) and tostring(ingameConfig.QuestAct) or acts[1]
                clearQuestTarget()
                questActDropdown:SetValues(acts)
                questActDropdown:SetValue(ingameConfig.QuestAct)
                saveLobbyConfig(ingameConfig)
            end)
            questActDropdown:OnChanged(function(value)
                ingameConfig.QuestAct = tostring(value)
                clearQuestTarget()
                saveLobbyConfig(ingameConfig)
            end)
            questTab:AddDropdown("IG_Quest_Difficulty", {
                Title = "Story difficulty", Values = {"Normal", "Hard"}, Default = ingameConfig.QuestDifficulty,
            }):OnChanged(function(value)
                ingameConfig.QuestDifficulty = tostring(value)
                clearQuestTarget()
                saveLobbyConfig(ingameConfig)
            end)
            saveToggle(storyTab, "IG_Story_AutoStory", "AutoStory", "Enable Auto Story Targeting (requires Auto Join)")
            storyTab:AddParagraph({
                Title = "One Macro for every Act",
                Content = "Choose a local compact or legacy macro for each Story world. Changing this in game only saves the selection.",
            })
            local function storyMacroOptions(world)
                local options, seen = {"None"}, {None = true}
                if type(listfiles) ~= "function" or type(isfolder) ~= "function" or not isfolder(macrosFolder) then return options end
                local listed, files = pcall(listfiles, macrosFolder)
                if not listed then return options end
                for _, path in ipairs(files) do
                    if string.lower(string.sub(path, -5)) == ".json" then
                        local name = string.match(path, "([^/\\]+)%.json$")
                        local decodedOk, decoded = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
                        local key = decodedOk and type(decoded) == "table" and (decoded.MacroKey or decoded.Key
                            or decoded.CanonicalMacroKey or type(decoded.Map) == "table" and decoded.Map.CanonicalMacroKey) or nil
                        if not key and name then
                            local mode, fileWorld, act, difficulty = string.match(name, "^([^_]+)_(.+)_([^_]+)_([^_]+)$")
                            if mode then key = table.concat({mode, fileWorld, act, difficulty}, "|") end
                        end
                        local _, keyWorld = string.match(tostring(key or ""), "^([^|]+)|(.+)|([^|]+)|([^|]+)$")
                        if name and tostring(keyWorld) == tostring(world) and not seen[name] then
                            seen[name] = true
                            table.insert(options, name)
                        end
                    end
                end
                table.sort(options, function(left, right)
                    if left == "None" then return true end
                    if right == "None" then return false end
                    return left < right
                end)
                return options
            end
            for index, world in ipairs(GameInfo.Ordering or {}) do
                local options = storyMacroOptions(world)
                local selected = ingameConfig.StoryMacroByWorld[world]
                if selected and not table.find(options, selected) then table.insert(options, selected) end
                storyTab:AddDropdown("IG_Story_Macro_" .. index, {
                    Title = tostring((GameInfo[world] or {}).DisplayName or world), Values = options,
                    Default = selected or "None", Multi = false,
                }):OnChanged(function(value)
                    ingameConfig.StoryMacroByWorld[world] = value ~= "None" and value or nil
                    saveLobbyConfig(ingameConfig)
                end)
            end
            state.SavedChallengeInfo = challengeTab:AddParagraph({
                Title = "Saved Challenge Information",
                Content = "Return to lobby to scan current challenges.",
            })
            saveToggle(challengeTab, "IG_Challenge_Enable", "AutoChallenge", "Enable Auto Challenge", function(value)
                if value then ingameConfig.ChallengeNextCheckAt = 0 else ingameConfig.ChallengeRuntimeTarget = nil end
            end)
            saveToggle(challengeTab, "IG_Challenge_AutoLeave", "AutoChallengeLeave", "Auto Leave For Challenge")
            state.AutoLeaveStatus = challengeTab:AddParagraph({
                Title = "Auto Leave Timer",
                Content = "Enabled but not scheduled.",
            })
            local challengeTypeDefaults = {}
            for _, kind in ipairs(ingameConfig.ChallengeTypes) do challengeTypeDefaults[kind] = true end
            challengeTab:AddDropdown("IG_Challenge_Types", {
                Title = "Challenge list", Values = {"Daily", "Normal"}, Multi = true, Default = challengeTypeDefaults,
            }):OnChanged(function(values)
                local selected = selectionSet(values)
                local kinds = {}
                for _, kind in ipairs({"Daily", "Normal"}) do if selected[kind] then table.insert(kinds, kind) end end
                ingameConfig.ChallengeTypes = kinds
                ingameConfig.ChallengeNextCheckAt = 0
                saveLobbyConfig(ingameConfig)
            end)
            challengeTab:AddParagraph({
                Title = "Dedicated Challenge Macros",
                Content = "Separate from Auto Story. Select one local macro for each challenge world.",
            })
            for index, world in ipairs(GameInfo.Ordering or {}) do
                local options = storyMacroOptions(world)
                local selected = ingameConfig.ChallengeMacroByWorld[world]
                if selected and not table.find(options, selected) then table.insert(options, selected) end
                challengeTab:AddDropdown("IG_Challenge_Macro_" .. index, {
                    Title = tostring((GameInfo[world] or {}).DisplayName or world), Values = options,
                    Default = selected or "None", Multi = false,
                }):OnChanged(function(value)
                    ingameConfig.ChallengeMacroByWorld[world] = value ~= "None" and value or nil
                    ingameConfig.ChallengeNextCheckAt = 0
                    saveLobbyConfig(ingameConfig)
                end)
            end
            saveToggle(joinTab, "IG_Join_AutoJoin", "AutoJoin", "Enable Auto Join")
            saveToggle(joinTab, "IG_Join_AutoArtifact", "AutoArtifact", "Auto Artifact Reward")
            joinTab:AddDropdown("IG_Join_ArtifactRewardPriority", {
                Title = "Artifact reward priority", Values = state.ArtifactRewardOptions,
                Multi = true, Default = selectionSet(ingameConfig.ArtifactRewardPriority),
            }):OnChanged(function(values)
                local selected = selectionSet(values)
                ingameConfig.ArtifactRewardPriority = {}
                for _, option in ipairs(state.ArtifactRewardOptions) do
                    if selected[option] then table.insert(ingameConfig.ArtifactRewardPriority, option) end
                end
                saveLobbyConfig(ingameConfig)
            end)
            saveToggle(joinTab, "IG_Join_AutoCardPick", "AutoCardPick", "Auto Pick Card")
            joinTab:AddDropdown("IG_Join_CardPriority", {
                Title = "Pick card priority", Values = state.CardPriorityOptions,
                Multi = true, Default = selectionSet(ingameConfig.CardPriority),
            }):OnChanged(function(values)
                local selected = selectionSet(values)
                ingameConfig.CardPriority = {}
                for _, option in ipairs(state.CardPriorityOptions) do
                    if selected[option] then table.insert(ingameConfig.CardPriority, option) end
                end
                saveLobbyConfig(ingameConfig)
            end)
            local joinModes = {"Story", "Infinite", "Raid", "Legend", "Artifact", "Trial", "ReZero", "WorldBoss"}
            ingameConfig.GameMode = table.find(joinModes, tostring(ingameConfig.GameMode)) and tostring(ingameConfig.GameMode) or "Story"
            local joinWorlds = worldOptions(ingameConfig.GameMode)
            if ingameConfig.GameMode == "Artifact" and ingameConfig.ArtifactName ~= "" then
                ingameConfig.World = ingameConfig.ArtifactName
            end
            ingameConfig.World = ensureOption(joinWorlds, ingameConfig.World)
            if ingameConfig.GameMode == "Artifact" then ingameConfig.ArtifactName = tostring(ingameConfig.World or "") end
            local joinActs = actOptions(ingameConfig.World, ingameConfig.GameMode)
            ingameConfig.Act = ensureOption(joinActs, ingameConfig.Act)
            local joinWorldDropdown, joinActDropdown, joinDifficultyDropdown
            local refreshingJoin = false
            local joinModeDropdown = joinTab:AddDropdown("IG_Join_Mode", {
                Title = "Mode", Values = joinModes, Default = ingameConfig.GameMode,
            })
            joinWorldDropdown = joinTab:AddDropdown("IG_Join_World", {
                Title = "World", Values = joinWorlds, Default = ingameConfig.World,
            })
            joinActDropdown = joinTab:AddDropdown("IG_Join_Act", {
                Title = "Act", Values = joinActs, Default = ingameConfig.Act,
            })
            joinDifficultyDropdown = joinTab:AddDropdown("IG_Join_Difficulty", {
                Title = "Difficulty", Values = ingameConfig.GameMode == "Story" and {"Normal", "Hard"}
                    or ((ingameConfig.GameMode == "Infinite" or ingameConfig.GameMode == "Raid"
                        or ingameConfig.GameMode == "Legend" or ingameConfig.GameMode == "Artifact") and {"Hard"} or {"None"}),
                Default = ingameConfig.Difficulty,
            })
            local function refreshJoinWorlds()
                if refreshingJoin then return end
                refreshingJoin = true
                local worlds = worldOptions(ingameConfig.GameMode)
                if ingameConfig.GameMode == "Artifact" and ingameConfig.ArtifactName ~= "" then
                    ingameConfig.World = ingameConfig.ArtifactName
                end
                ingameConfig.World = table.find(worlds, tostring(ingameConfig.World)) and tostring(ingameConfig.World) or worlds[1]
                if ingameConfig.GameMode == "Artifact" then ingameConfig.ArtifactName = tostring(ingameConfig.World or "") end
                local acts = actOptions(ingameConfig.World, ingameConfig.GameMode)
                ingameConfig.Act = table.find(acts, tostring(ingameConfig.Act)) and tostring(ingameConfig.Act) or acts[1]
                local diffOptions
                if ingameConfig.GameMode == "Infinite" or ingameConfig.GameMode == "Raid"
                    or ingameConfig.GameMode == "Legend" or ingameConfig.GameMode == "Artifact" then
                    ingameConfig.Difficulty = "Hard"
                    diffOptions = {"Hard"}
                elseif ingameConfig.GameMode == "Trial" then
                    if ingameConfig.World == "PleiadesGrass" then
                        ingameConfig.Act = "Trial"
                    else
                        ingameConfig.World, ingameConfig.Act = "SandVillage", "MadaraStage"
                    end
                    ingameConfig.Difficulty = "None"
                    worlds, acts, diffOptions = {"SandVillage", "PleiadesGrass"}, actOptions(ingameConfig.World, "Trial"), {"None"}
                elseif ingameConfig.GameMode == "ReZero" then
                    ingameConfig.World = table.find({"PleiadesSand", "PleiadesLibrary"}, ingameConfig.World) and ingameConfig.World or "PleiadesSand"
                    ingameConfig.Act = table.find({"1", "2"}, ingameConfig.Act) and ingameConfig.Act or "1"
                    ingameConfig.Difficulty = "None"
                    worlds, acts, diffOptions = {"PleiadesSand", "PleiadesLibrary"}, {"1", "2"}, {"None"}
                elseif ingameConfig.GameMode == "WorldBoss" then
                    ingameConfig.World, ingameConfig.Act, ingameConfig.Difficulty = "Igris", "None", "None"
                    worlds, acts, diffOptions = {"Igris"}, {"None"}, {"None"}
                else
                    if ingameConfig.Difficulty ~= "Normal" and ingameConfig.Difficulty ~= "Hard" then
                        ingameConfig.Difficulty = "Normal"
                    end
                    diffOptions = {"Normal", "Hard"}
                end
                local ok, err = pcall(function()
                    joinWorldDropdown:SetValues(worlds)
                    joinWorldDropdown:SetValue(ingameConfig.World)
                    joinActDropdown:SetValues(acts)
                    joinActDropdown:SetValue(ingameConfig.Act)
                    joinDifficultyDropdown:SetValues(diffOptions)
                    joinDifficultyDropdown:SetValue(ingameConfig.Difficulty)
                end)
                refreshingJoin = false
                if not ok then
                    warn("[AnimeOriginsUltimate] Failed to refresh in-game join options:", err)
                end
            end
            joinModeDropdown:OnChanged(function(value)
                if refreshingJoin then return end
                ingameConfig.GameMode = tostring(value)
                refreshJoinWorlds()
                saveLobbyConfig(ingameConfig)
            end)
            joinWorldDropdown:OnChanged(function(value)
                if refreshingJoin then return end
                ingameConfig.World = tostring(value)
                if ingameConfig.GameMode == "Artifact" then ingameConfig.ArtifactName = ingameConfig.World end
                local acts = actOptions(ingameConfig.World, ingameConfig.GameMode)
                ingameConfig.Act = table.find(acts, tostring(ingameConfig.Act)) and tostring(ingameConfig.Act) or acts[1]
                refreshingJoin = true
                joinActDropdown:SetValues(acts)
                joinActDropdown:SetValue(ingameConfig.Act)
                refreshingJoin = false
                saveLobbyConfig(ingameConfig)
            end)
            joinActDropdown:OnChanged(function(value)
                if refreshingJoin then return end
                ingameConfig.Act = tostring(value)
                saveLobbyConfig(ingameConfig)
            end)
            joinDifficultyDropdown:OnChanged(function(value)
                if refreshingJoin then return end
                if ingameConfig.GameMode == "Infinite" or ingameConfig.GameMode == "Raid"
                    or ingameConfig.GameMode == "Legend" or ingameConfig.GameMode == "Artifact" then
                    ingameConfig.Difficulty = "Hard"
                    if tostring(value) ~= "Hard" then
                        refreshingJoin = true
                        joinDifficultyDropdown:SetValue("Hard")
                        refreshingJoin = false
                    end
                elseif ingameConfig.GameMode == "Trial" or ingameConfig.GameMode == "ReZero" then
                    ingameConfig.Difficulty = "None"
                    if tostring(value) ~= "None" then
                        refreshingJoin = true
                        joinDifficultyDropdown:SetValue("None")
                        refreshingJoin = false
                    end
                elseif ingameConfig.GameMode == "WorldBoss" then
                    ingameConfig.Difficulty = "None"
                    if tostring(value) ~= "None" then
                        refreshingJoin = true
                        joinDifficultyDropdown:SetValue("None")
                        refreshingJoin = false
                    end
                else
                    ingameConfig.Difficulty = tostring(value)
                end
                saveLobbyConfig(ingameConfig)
            end)
            saveToggle(craftTab, "IG_Craft_AutoCraft", "AutoCraft", "Enable Auto Craft")
            craftTab:AddParagraph({Title = "Craft items", Content = "Retained selection: " .. (#ingameConfig.CraftItems > 0 and table.concat(ingameConfig.CraftItems, ", ") or "None") .. "\nDetailed selection is deferred to lobby."})
            saveToggle(craftTab, "IG_Craft_AutoCodes", "AutoRedeemCodes", "Enable Auto Redeem Codes")
            craftTab:AddInput("IG_Craft_Codes", {
                Title = "Codes", Default = ingameConfig.Codes, Placeholder = "CODE1, CODE2", Numeric = false, Finished = true,
            }):OnChanged(function(value)
                ingameConfig.Codes = tostring(value or "")
                saveLobbyConfig(ingameConfig)
            end)
            state.AddIngameShop = function(key, title)
                ingameConfig.AutoShops[key] = ingameConfig.AutoShops[key] == true
                ingameConfig.ShopItems[key] = type(ingameConfig.ShopItems[key]) == "table" and ingameConfig.ShopItems[key] or {}
                state.IngameShopTab:AddToggle("IG_Shop_" .. string.gsub(key, "[^%w]", "_"), {
                    Title = "Enable " .. title,
                    Default = ingameConfig.AutoShops[key],
                }):OnChanged(function(value)
                    ingameConfig.AutoShops[key] = value == true
                    if key == "GoldShop" then ingameConfig.AutoGoldShop = value == true end
                    saveLobbyConfig(ingameConfig)
                end)
                state.IngameShopTab:AddParagraph({
                    Title = title .. " items",
                    Content = "Retained selection: " .. (#ingameConfig.ShopItems[key] > 0 and table.concat(ingameConfig.ShopItems[key], ", ") or "None") .. "\nDetailed selection is deferred to lobby.",
                })
            end
            state.AddIngameShop("GoldShop", "Gold Shop")
            state.AddIngameShop("CustomizationShop", "Customization Shop")
            for _, world in ipairs(GameInfo.RaidOrdering or {}) do
                state.AddIngameShop("RaidShop|" .. world, "Raid - " .. tostring((GameInfo[world] or {}).DisplayName or world))
            end
            for _, world in ipairs(GameInfo.RiftOrdering or {}) do
                state.AddIngameShop("RiftShop|" .. world, "Rift - " .. tostring((GameInfo[world] or {}).DisplayName or world))
            end
            if GameInfo.IgrisThroneRoom and GameInfo.IgrisThroneRoom.BossFightShopInfo then
                state.AddIngameShop("IgrisShop", "World Boss - " .. tostring(GameInfo.IgrisThroneRoom.DisplayName or "Igris"))
            end
            if GameInfo.PleiadesSand and GameInfo.PleiadesSand.ShopInfo then
                state.AddIngameShop("ReZeroShop", tostring(GameInfo.PleiadesSand.ShopInfo.ShopDisplayName or "Shali's Stash"))
            end
            summonTab:AddParagraph({Title = "Lobby scanner", Content = "Banner scanning and summoning execute only in lobby. No banner or summon remote is invoked here."})
            saveToggle(summonTab, "IG_Summon_AutoSummon", "AutoSummon", "Enable standalone Auto Summon")
            local mythicLabels, labelToKey, keyToLabel = {}, {}, {}
            for key, info in pairs(TowerInfo) do
                if aoIsBaseMythic(TowerInfo, key) then
                    local label = string.format("%s [%s]", tostring(info.DisplayName or info.Name or key), tostring(key))
                    table.insert(mythicLabels, label)
                    labelToKey[label], keyToLabel[tostring(key)] = tostring(key), label
                end
            end
            for _, key in ipairs(ingameConfig.AutoSummonUnits) do
                if aoIsBaseMythic(TowerInfo, key) and not keyToLabel[key] then
                    local info = TowerInfo[key] or {}
                    local label = string.format("%s [%s]", tostring(info.DisplayName or info.Name or key), key)
                    table.insert(mythicLabels, label)
                    labelToKey[label], keyToLabel[key] = key, label
                end
            end
            table.sort(mythicLabels)
            state.AutoSummonTargetKeys = {}
            for key in pairs(keyToLabel) do state.AutoSummonTargetKeys[key] = true end
            local summonDefaults = {}
            for _, key in ipairs(ingameConfig.AutoSummonUnits) do summonDefaults[keyToLabel[key] or key] = true end
            summonTab:AddDropdown("IG_Summon_Units", {
                Title = "Target Mythic", Description = "Display name [internal key]", Values = mythicLabels,
                Multi = true, Default = summonDefaults,
            }):OnChanged(function(values)
                local units = {}
                for label in pairs(selectionSet(values)) do
                    local key = labelToKey[label] or label:match("%[(.-)%]$") or label
                    if aoIsBaseMythic(TowerInfo, key) then table.insert(units, key) end
                end
                table.sort(units)
                ingameConfig.AutoSummonUnits = units
                saveLobbyConfig(ingameConfig)
            end)
            summonTab:AddDropdown("IG_Summon_Amount", {
                Title = "Amount per request", Values = {"1", "10", "50", "Max"}, Default = ingameConfig.AutoSummonAmount,
            }):OnChanged(function(value)
                ingameConfig.AutoSummonAmount = tostring(value)
                saveLobbyConfig(ingameConfig)
            end)
            summonTab:AddInput("IG_Summon_Reserve", {
                Title = "Currency reserve", Default = tostring(ingameConfig.AutoSummonReserve), Placeholder = "0", Numeric = true, Finished = true,
            }):OnChanged(function(value)
                ingameConfig.AutoSummonReserve = math.max(0, math.floor(tonumber(value) or 0))
                saveLobbyConfig(ingameConfig)
            end)
            state.fluentStatusParagraph = macroTab:AddParagraph({Title = "Current Macro", Content = "Initializing..."})
            if not state.MacroStatusUiPumpStarted then
                state.MacroStatusUiPumpStarted = true
                task.spawn(function()
                    local lastDesc
                    while state.Running do
                        local paragraph = state.fluentStatusParagraph
                        local desc = state.PendingMacroStatusDesc
                        if paragraph and desc and desc ~= lastDesc then
                            local ok = pcall(function()
                                paragraph:SetDesc(desc)
                            end)
                            if ok then lastDesc = desc end
                        end
                        task.wait(0.2)
                    end
                end)
            end
            macroTab:AddParagraph({Title = "Macro Controls", Content = "Record restarts before capture and saves when the match ends. Play is an on/off toggle."})
            macroTab:AddButton({Title = "Record Macro", Callback = state.RecordMacro})
            macroTab:AddButton({Title = "Optimize Current Macro", Callback = function()
                local ok, encoded = state.OptimizeCurrentMacro()
                if ok then
                    local clipboard = type(setclipboard) == "function" and setclipboard
                        or type(toclipboard) == "function" and toclipboard or nil
                    if clipboard then pcall(clipboard, encoded) end
                    notify("Macro Optimized", "Only pre-Sell Place/VoteStart times changed. Sell and its full suffix were preserved.")
                else
                    notify("Macro Optimize", "Could not optimize the current macro. Check the Current Macro status/log.")
                end
            end})
            macroTab:AddToggle("IG_Macro_Play", {Title = "Play Macro", Default = ingameConfig.AutoPlayMacro == true}):OnChanged(state.SetPlayMacro)
            macroTab:AddToggle("IG_Macro_AutoReplay", {Title = "Auto Replay", Default = ingameConfig.AutoReplayGame == true}):OnChanged(function(value)
                local currentMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
                ingameConfig.AutoReplayGame = value == true
                saveLobbyConfig(ingameConfig)
                local blocked = string.find(currentMode, "Challenge", 1, true) ~= nil
                    or string.find(currentMode, "Rift", 1, true) ~= nil and not state.RiftReplayAvailable()
                    or currentMode == "Artifact" and not state.ReplayArtifact()
                if blocked then
                    state.EnsureAutoReplay = false
                    state.PendingStageAutoPlay = false
                    SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
                    SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
                    updateUI("AUTO REPLAY BLOCKED IN " .. string.upper(currentMode))
                else
                    state.EnsureAutoReplay = value == true
                    SettingsRemote:FireServer("SetSetting", "AutoReplayGame", value == true)
                    if currentMode == "Artifact" or string.find(currentMode, "Rift", 1, true) then
                        SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
                    end
                end
            end)
            macroTab:AddToggle("IG_Macro_AutoRestartInfinite", {
                Title = "Auto Restart Infinite", Default = ingameConfig.AutoRestartInfinite == true,
            }):OnChanged(function(value)
                ingameConfig.AutoRestartInfinite = value == true
                state.InfiniteRestartArmed = true
                saveLobbyConfig(ingameConfig)
            end)
            macroTab:AddInput("IG_Macro_AutoRestartInfiniteWave", {
                Title = "Restart Wave", Default = tostring(ingameConfig.AutoRestartInfiniteWave),
                Placeholder = "100", Numeric = true, Finished = true,
            }):OnChanged(function(value)
                ingameConfig.AutoRestartInfiniteWave = math.max(1, math.floor(tonumber(value) or 100))
                state.InfiniteRestartArmed = true
                saveLobbyConfig(ingameConfig)
            end)
            local labels, modesByLabel = {}, {}
            for _, entry in ipairs(speedModes) do
                table.insert(labels, entry[2])
                modesByLabel[entry[2]] = entry[1]
            end
            macroTab:AddDropdown("IG_Macro_GameSpeed", {
                Title = "Game Speed", Values = labels, Default = speedLabel(), Multi = false,
            }):OnChanged(function(value)
                state.SetGameSpeed(modesByLabel[value])
            end)
            macroTab:AddToggle("IG_Macro_AutoYutaAbility", {
                Title = "Auto Ability Yuta", Default = ingameConfig.AutoYutaAbility == true,
            }):OnChanged(function(value)
                ingameConfig.AutoYutaAbility = value == true
                saveLobbyConfig(ingameConfig)
            end)
            macroTab:AddToggle("IG_Macro_AutoMadaraMaxBonus", {
                Title = "Auto Madara Active (3:00)",
                Description = "Uses Heaven Splitter only after stored Susanoo time reaches 180 seconds.",
                Default = ingameConfig.AutoMadaraMaxBonus == true,
            }):OnChanged(function(value)
                ingameConfig.AutoMadaraMaxBonus = value == true
                saveLobbyConfig(ingameConfig)
            end)
            local yutaAbilityLabels, yutaAbilityByLabel, yutaLabelByAbility = {}, {}, {}
            for abilityName, abilityInfo in pairs(TowerAbilitiesInfo.Actives or {}) do
                if abilityInfo.CanCopy == true and abilityInfo.AutoUse ~= false then
                    local label = string.format("%s [%s]", tostring(abilityInfo.DisplayName or abilityName), tostring(abilityName))
                    table.insert(yutaAbilityLabels, label)
                    yutaAbilityByLabel[label] = tostring(abilityName)
                    yutaLabelByAbility[tostring(abilityName)] = label
                end
            end
            table.sort(yutaAbilityLabels)
            local yutaAbilityDefaults = {}
            for _, abilityName in ipairs(ingameConfig.YutaAutoAbilities) do
                local label = yutaLabelByAbility[tostring(abilityName)]
                if label then yutaAbilityDefaults[label] = true end
            end
            macroTab:AddDropdown("IG_Macro_YutaAutoAbilities", {
                Title = "Yuta Copied Auto Abilities",
                Description = "Only selected copied abilities are used automatically.",
                Values = yutaAbilityLabels,
                Multi = true,
                Default = yutaAbilityDefaults,
            }):OnChanged(function(values)
                local abilities = {}
                for label in pairs(selectionSet(values)) do
                    local abilityName = yutaAbilityByLabel[label]
                    if abilityName then table.insert(abilities, abilityName) end
                end
                table.sort(abilities)
                ingameConfig.YutaAutoAbilities = abilities
                saveLobbyConfig(ingameConfig)
            end)
            saveToggle(macroTab, "IG_AutoFrag", "AutoFrag", "Auto Frag (5 shards)")
            saveToggle(macroTab, "IG_AutoClash", "AutoClash", "Auto Clash")
            saveToggle(macroTab, "IG_AutoParry", "AutoParry", "Auto Hell Snipe Parry")
            saveToggle(macroTab, "IG_AutoFindBook", "AutoFindBook", "Auto Find Cultist Book")
            saveToggle(macroTab, "IG_AutoChest", "AutoChest", "Auto Chest (Key > Red, No Key > Blue)")
            local igrisStatusParagraph = macroTab:AddParagraph({
                Title = "Combat Automation Status",
                Content = tostring(state.IgrisAutomationStatus or "Idle"),
            })
            task.spawn(function()
                local last
                while state.Running do
                    local current = tostring(state.IgrisAutomationStatus or "Idle")
                    if current ~= last then
                        pcall(function() igrisStatusParagraph:SetDesc(current) end)
                        last = current
                    end
                    task.wait(0.3)
                end
            end)
            macroTab:AddParagraph({Title = "Auto Passive Bon", Content = "Ban (chef) cooks meals each wave. Enable feeds below and pick a target tower for each meal."})
            macroTab:AddToggle("IG_Macro_AutoFeed", {Title = "Enable Auto Feed (Bon)", Default = ingameConfig.AutoFeed == true}):OnChanged(function(value)
                ingameConfig.AutoFeed = value == true
                saveLobbyConfig(ingameConfig)
            end)
            local feedLabels, feedLabelToKey = {}, {}
            for tk, tinfo in pairs(TowerInfo) do
                local rarity = type(tinfo) == "table" and tostring(tinfo.Rarity or tinfo.TowerRarity or "") or ""
                if rarity == "Mythic" or rarity == "Secret" then
                    local tlabel = string.format("%s [%s]", tostring(tinfo.DisplayName or tinfo.Name or tk), tostring(tk))
                    table.insert(feedLabels, tlabel)
                    feedLabelToKey[tlabel] = tostring(tk)
                end
            end
            table.sort(feedLabels)
            for _, mealDef in ipairs({{"WholeChicken", "Whole Chicken"}, {"Curry", "Spicy Curry"}, {"Fish", "Fresh Fish"}, {"Soup", "Hearty Soup"}, {"Steak", "Champion's Steak"}, {"Sushi", "Master Chef Sushi"}}) do
                local key, label = mealDef[1], mealDef[2]
                local plan = type(ingameConfig.FeedPlans) == "table" and ingameConfig.FeedPlans[key] or nil
                macroTab:AddToggle("IG_Macro_FeedPlan_" .. key, {Title = "Feed " .. label, Default = type(plan) == "table" and plan.Enabled == true or false}):OnChanged(function(value)
                    ingameConfig.FeedPlans = ingameConfig.FeedPlans or {}
                    ingameConfig.FeedPlans[key] = ingameConfig.FeedPlans[key] or {}
                    ingameConfig.FeedPlans[key].Enabled = value == true
                    saveLobbyConfig(ingameConfig)
                end)
                local feedDefaults = {}
                local planKeys = type(plan) == "table" and type(plan.TargetKeys) == "table" and plan.TargetKeys or {}
                for tk in pairs(planKeys) do
                    local tinfo = TowerInfo[tk]
                    local tlabel = tinfo and string.format("%s [%s]", tostring(tinfo.DisplayName or tinfo.Name or tk), tostring(tk)) or tk
                    feedDefaults[tlabel] = true
                end
                macroTab:AddDropdown("IG_Macro_FeedTarget_" .. key, {
                    Title = label .. " target units", Description = "Feeds this meal to every copy of the selected units",
                    Values = feedLabels, Multi = true, Default = feedDefaults,
                }):OnChanged(function(values)
                    local keys = {}
                    for tlabel in pairs(selectionSet(values)) do
                        local tk = feedLabelToKey[tlabel] or tostring(tlabel:match("%[(.-)%]$") or tlabel)
                        keys[tk] = true
                    end
                    ingameConfig.FeedPlans = ingameConfig.FeedPlans or {}
                    ingameConfig.FeedPlans[key] = ingameConfig.FeedPlans[key] or {}
                    ingameConfig.FeedPlans[key].TargetKeys = keys
                    saveLobbyConfig(ingameConfig)
                end)
            end
            local macroJsonInput = macroTab:AddInput("IG_Macro_JSON", {
                Title = "Macro JSON", Default = "", Placeholder = "Paste a macro or macro bundle", Numeric = false, Finished = false,
            })
            function state.UploadMacroShare(exportFn)
                local text, count = exportFn()
                local response = aoRequest({
                    Url = "https://originsmarcoshare.netlify.app/api/macros",
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = text,
                })
                if not response then error("Macro upload request failed") end
                local status = tonumber(response.StatusCode or response.Status)
                if status and (status < 200 or status >= 300) then
                    error("Macro upload returned HTTP " .. tostring(status) .. ": " .. tostring(response.Body or ""))
                end
                local decoded = HttpService:JSONDecode(tostring(response.Body or ""))
                if type(decoded) ~= "table" or not decoded.shareUrl then error("Upload response has no share link") end
                setMacroJsonOutput(macroJsonInput, decoded.shareUrl)
                notify("Macro Share Link", "Uploaded " .. count .. " macro(s): " .. decoded.shareUrl)
            end
            macroTab:AddButton({Title = "Share Current Macro", Callback = withJsonError(function()
                state.UploadMacroShare(currentMacroExport)
            end)})
            macroTab:AddButton({Title = "Share All Macros", Callback = withJsonError(function()
                state.UploadMacroShare(allMacrosExport)
            end)})
            macroTab:AddButton({Title = "Import Macro", Callback = withJsonError(function()
                if type(writefile) ~= "function" then error("Local file writing is unavailable") end
                local text = fetchMacroShareInput(macroJsonInput.Value)
                if text == "" then error("JSON input is empty") end
                if #text > JSON_LIMIT then error("JSON input exceeds the 2MB limit") end
                local decoded = HttpService:JSONDecode(text)
                if type(decoded) ~= "table" then error("JSON root must be an object") end
                local imports = {}
                local bundleMacros = decoded.macros or decoded.Macros
                if bundleMacros ~= nil then
                    local format, version, gameId = decoded.format or decoded.Format, decoded.version or decoded.Version,
                        decoded.gameId or decoded.GameId
                    local acceptedFormat = format == "AnimeOriginsMacros" or format == "AnimeOriginsMacroBundle"
                    local acceptedGame = gameId == nil or tostring(gameId) == tostring(game.GameId) or tostring(gameId) == tostring(game.PlaceId)
                    if not acceptedFormat or (tonumber(version) ~= 1 and tonumber(version) ~= 2)
                        or not acceptedGame or type(bundleMacros) ~= "table" then
                        error("Invalid macro bundle format, version, or gameId")
                    end
                    for rawKey, payload in pairs(bundleMacros) do
                        local key = canonicalMacroKey(rawKey)
                        local actions = payloadActions(payload)
                        if not actions then error("Invalid actions for macro: " .. tostring(rawKey)) end
                        if type(payload) == "table" and payload.Actions ~= nil then
                            key = payloadMacroKey(payload) or key
                        end
                        if not key then error("Macro target stage is unknown: " .. tostring(rawKey)) end
                        imports[key] = actions
                    end
                else
                    local actions = payloadActions(decoded)
                    if not actions then error("Invalid single macro payload") end
                    local key = decoded.Actions ~= nil and payloadMacroKey(decoded) or nil
                    if not key then error("A raw actions array has no known MacroKey; the target stage is unknown") end
                    imports[key] = actions
                end
                showMacroImportPopup(imports, function(picked)
                    local plans, targets = {}, {}
                    for key, actions in pairs(picked) do
                        local name = safeMacroName(key)                        if not name then error("Could not derive a safe macro filename for: " .. tostring(key)) end
                        local path = macrosFolder .. "/" .. name .. ".json"
                        if targets[path] and targets[path] ~= key then
                            error("Macro keys resolve to the same local filename: " .. targets[path] .. " and " .. key)
                        end
                        targets[path] = key
                        table.insert(plans, {Key = key, Actions = actions, Path = path})
                    end
                    ensureFolders()
                    for _, plan in ipairs(plans) do
                        local compact = checkedMacroEncode({
                            Format = "AnimeOriginsMacro", Version = 2, MacroKey = plan.Key, Actions = plan.Actions,
                        })
                        local wrote, writeErr = pcall(writefile, plan.Path, compact)
                        if not wrote then error("Could not write " .. plan.Path .. ": " .. tostring(writeErr)) end
                    end
                    notify("Macros Imported", string.format("Imported %d validated macro(s).", #plans))
                end, notify)
            end)})
            webhookTab:AddParagraph({Title = "Discord Webhook", Content = "The in-game completion and new-unit runtime reads this saved file dynamically."})
            webhookTab:AddInput("IG_Webhook_Url", {
                Title = "Discord Webhook URL", Default = ingameConfig.WebhookUrl,
                Placeholder = "https://discord.com/api/webhooks/...", Numeric = false, Finished = false,
            }):OnChanged(function(value)
                ingameConfig.WebhookUrl = tostring(value or "")
                saveLobbyConfig(ingameConfig)
            end)
            saveToggle(webhookTab, "IG_Webhook_Completion", "WebhookCompletionEnabled", "Notify when Match Completed")
            saveToggle(webhookTab, "IG_Webhook_Unit", "WebhookUnitEnabled", "Notify when New Unit Obtained")
            webhookTab:AddButton({Title = "Test Match Webhook", Callback = function()
                task.spawn(function()
                    local config = autoStoryConfig() or ingameConfig
                    local testRewards = {}
                    for itemType, items in pairs(ItemInfo) do
                        if type(items) == "table" then
                            for itemName, itemData in pairs(items) do
                                if type(itemData) == "table" and itemName ~= "Gems"
                                    and itemName ~= "Exp" and itemName ~= "BattlePassExp" then
                                    table.insert(testRewards, {ItemType = tostring(itemType), ItemName = tostring(itemName), Amount = 1})
                                end
                            end
                        end
                    end
                    table.sort(testRewards, function(left, right)
                        return left.ItemType .. left.ItemName < right.ItemType .. right.ItemName
                    end)
                    local payload = state.MatchWebhookPayload({
                        TestRewards = true,
                        Success = true,
                        GameMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "Story"),
                        WorldName = tostring(AttributeHolder:GetAttribute("WorldName") or mapInfo.WorldName or "WestCity"),
                        Act = tostring(AttributeHolder:GetAttribute("Act") or mapInfo.Act or "1"),
                        Difficulty = tostring(AttributeHolder:GetAttribute("Difficulty") or mapInfo.Difficulty or "Normal"),
                        PlayerStats = {
                            ClearTime = 135,
                            WavesCompleted = tonumber(AttributeHolder:GetAttribute("Wave")) or 15,
                            Kills = 100,
                            TotalDamage = 1000000,
                            UnitsPlaced = 6,
                            MoneyEarned = 25000,
                        },
                        Rewards = {
                            Gems = 1,
                            PlayerExp = 1,
                            BattlePassExp = 1,
                            ItemRewards = testRewards,
                        },
                    })
                    local ok, message = sendDiscordWebhook(config.WebhookUrl, payload)
                    notify(ok and "Webhook Sent" or "Webhook Error", tostring(message))
                end)
            end})
            settingsTab:AddToggle("IG_Settings_HideNames", {Title = "Hide Player Names", Default = ingameConfig.HidePlayerNames == true}):OnChanged(function(value)
                state.SetHidePlayerNames(value)
                saveLobbyConfig(ingameConfig)
            end)
            settingsTab:AddToggle("IG_Settings_BlackScreen", {Title = "Black Screen", Default = ingameConfig.BlackScreen == true}):OnChanged(function(value)
                state.SetBlackScreen(value, true)
                saveLobbyConfig(ingameConfig)
            end)
            saveToggle(settingsTab, "IG_Settings_AntiAFK", "AntiAFK", "Anti AFK")
            saveToggle(settingsTab, "IG_Settings_AutoReconnect", "AutoReconnect", "Auto Reconnect", function(value)
                if value and state.ReconnectController then state.ReconnectController.Scan() end
            end)
            settingsTab:AddToggle("IG_Settings_MobileButton", {Title = "Mobile UI Button", Default = ingameConfig.MobileButton == true}):OnChanged(function(value)
                ingameConfig.MobileButton = value == true
                if state.MobileButton then state.MobileButton.Enabled = ingameConfig.MobileButton end
                saveLobbyConfig(ingameConfig)
            end)
            settingsTab:AddInput("IG_Settings_FPSLimit", {
                Title = "FPS Limit", Default = tostring(ingameConfig.FPSLimit),
                Placeholder = "60", Numeric = true, Finished = true,
            }):OnChanged(function(value)
                state.SetFPSLimit(value)
                saveLobbyConfig(ingameConfig)
            end)
            settingsTab:AddToggle("IG_Settings_FixLag", {
                Title = "Fix Lag (Low Detail)",
                Description = "Strips heavy 3D textures, VFX and sounds. Rejoin to restore visuals.",
                Default = ingameConfig.FixLag == true,
            }):OnChanged(function(value)
                state.SetFixLag(value)
                state.SetFPSLimit(ingameConfig.FPSLimit)
                saveLobbyConfig(ingameConfig)
            end)
            riftTab:AddParagraph({Title = "Auto Rift", Content = "Auto join Rift (Shibuya Train Station) from lobby. Requires Auto Join + timer."})
            riftTab:AddToggle("IG_Rift_Auto", {Title = "Enable Auto Join Rift", Default = ingameConfig.AutoRift == true}):OnChanged(function(value)
                ingameConfig.AutoRift = value == true
                saveLobbyConfig(ingameConfig)
            end)
            riftTab:AddToggle("IG_Rift_AutoLeave", {Title = "Auto Leave Rift", Default = ingameConfig.AutoRiftLeave == true}):OnChanged(function(value)
                ingameConfig.AutoRiftLeave = value == true
                saveLobbyConfig(ingameConfig)
            end)
            local riftMacroOptions = storyMacroOptions("ShibuyaTrainStation")
            local selectedRiftMacro = ingameConfig.RiftMacro
            if selectedRiftMacro and not table.find(riftMacroOptions, selectedRiftMacro) then table.insert(riftMacroOptions, selectedRiftMacro) end
            riftTab:AddDropdown("IG_Rift_Macro", {
                Title = "Rift Macro", Values = riftMacroOptions, Default = selectedRiftMacro or "None", Multi = false,
            }):OnChanged(function(value)
                ingameConfig.RiftMacro = value ~= "None" and value or ""
                saveLobbyConfig(ingameConfig)
            end)
            local riftStatusPara = riftTab:AddParagraph({Title = "Rift Timer Status", Content = "Loading..."})
            task.spawn(function()
                while state.Running do
                    task.wait(2)
                    local riftTimer = aoReadRiftTimer(LocalPlayer.UserId)
                    local riftSpawnAt = riftTimer and tonumber(riftTimer.RiftSpawnAt) or 0
                    local text = ""
                    if riftSpawnAt > 0 then
                        local timeLeft = riftSpawnAt - os.time()
                        if timeLeft > 0 then
                            text = "Next rift spawn in: " .. timeLeft .. "s"
                        else
                            text = "Next rift spawn: now"
                        end
                    else
                        text = "Next rift spawn: unknown"
                    end
                    pcall(function() riftStatusPara:SetDesc(text) end)
                end
            end)
            aoBuildNamedConfigManager({
                Tab = configsTab, Prefix = "IG_Configs", Config = ingameConfig, Defaults = ingameDefaults,
                RootFolder = rootFolder, Folder = configsFolder, AutoSavePath = autoSaveFolder .. "/lobby.json",
                Normalize = normalizeIngameConfig, Save = saveLobbyConfig, Notify = notify, State = state,
                Apply = function()
                    state.SetHidePlayerNames(ingameConfig.HidePlayerNames)
                    state.SetBlackScreen(ingameConfig.BlackScreen, true)
                    state.SetFPSLimit(ingameConfig.FPSLimit)
                    state.SetFixLag(ingameConfig.FixLag)
                    state.SetFPSLimit(ingameConfig.FPSLimit)
                    if state.MobileButton then state.MobileButton.Enabled = ingameConfig.MobileButton == true end
                end,
            })
            local configJsonInput = configsTab:AddInput("IG_Configs_JSON", {
                Title = "Config JSON", Default = "", Placeholder = "Paste an Anime Origins config bundle", Numeric = false, Finished = false,
            })
            configsTab:AddParagraph({Title = "Config Transfer", Content = "Exports and imports both lobby and in-game settings via a permanent share link. WebhookUrl and QuestRuntimeTarget are never shared. Maximum size: 2MB."})
            configsTab:AddButton({Title = "Export Config Share Link", Callback = withJsonError(function()
                local share = environment.AnimeOriginsConfigShare
                if not share or type(share.Export) ~= "function" then error("Config share helpers are unavailable") end
                local shareUrl = share.Export(notify)
                configJsonInput:SetValue(shareUrl)
                local clipboard = type(setclipboard) == "function" and setclipboard or type(toclipboard) == "function" and toclipboard
                if clipboard then pcall(clipboard, shareUrl) end
                notify("Config Share Link", "Uploaded config: " .. shareUrl)
            end)})
            configsTab:AddButton({Title = "Import Config from Link / JSON", Callback = withJsonError(function()
                local share = environment.AnimeOriginsConfigShare
                if not share or type(share.Import) ~= "function" then error("Config share helpers are unavailable") end
                share.Import(tostring(configJsonInput.Value or ""):match("^%s*(.-)%s*$"), notify)
                notify("Config Imported", "Allowed settings were saved. Rerun to refresh all control values.")
            end)})
            updateUI()
        end)
        if ok then return true end
        state.fluentStatusParagraph = nil
        state.Window = nil
        if window then pcall(function() window:Destroy() end) end
        warn("[AnimeOriginsUltimate] Fluent in-game UI failed to load: " .. tostring(err))
        return false
    end
    local lastCardPickAt = nil
    local lastArtifactPickAt = nil
    local lastArtifactChoice = nil
    local function handleCardSelection()
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local cardGui = playerGui and playerGui:FindFirstChild("GameUI") and playerGui.GameUI:FindFirstChild("CardSelection")
        if not (cardGui and cardGui.Visible) then
            lastCardPickAt = nil
            return
        end
        local selection = cardGui:FindFirstChild("Main") and cardGui.Main:FindFirstChild("Selection")
        if not selection then return end
        local cards = {}
        for _, child in ipairs(selection:GetChildren()) do
            if child:IsA("ImageButton") then
                table.insert(cards, child)
            end
        end
        if #cards == 0 then return end
        local cooldown = lastCardPickAt and (os.clock() - lastCardPickAt) < 0.5
        if cooldown then return end
        if not (ingameConfig.AutoCardPick or state.AutoCardPickOverride) then return end
        local pick
        local priority = ingameConfig.CardPriority
        if type(priority) == "table" then
            for _, name in ipairs(priority) do
                local n = tostring(name):lower()
                if n == "" then return end
                for _, card in ipairs(cards) do
                    local display = card:FindFirstChild("Main") and card.Main:FindFirstChild("InfoFrame")
                        and card.Main.InfoFrame:FindFirstChild("ModiferName")
                    local disp = display and tostring(display.Text):lower() or ""
                    if tostring(card.Name):lower() == n or string.find(tostring(card.Name):lower(), n, 1, true) or disp == n then
                        pick = card
                        break
                    end
                end
                if pick then break end
            end
        end
        pick = pick or cards[1]
        lastCardPickAt = os.clock()
        local modifier = pick:GetAttribute("ModifierName") or pick.Name
        ReplicatedStorage.Remotes.CardSelection:FireServer("ModifierSelectionVote", modifier)
    end
    state.HandleCardSelection = handleCardSelection
    local function handleArtifactReward()
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local gameUi = playerGui and playerGui:FindFirstChild("GameUI")
        local misc = gameUi and gameUi:FindFirstChild("Misc")
        local ars = misc and misc:FindFirstChild("ArtifactRewardSelection")
        if not (ars and ars.Visible) then
            lastArtifactPickAt = nil
            lastArtifactChoice = nil
            return
        end
        if not (ingameConfig.AutoArtifact or state.AutoArtifactOverride) then return end
        local cooldown = lastArtifactPickAt and (os.clock() - lastArtifactPickAt) < 0.5
        if cooldown then return end
        local list = ars:FindFirstChild("List")
        if not list then return end
        local buttons = {}
        for _, child in ipairs(list:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("ImageButton") then
                local interactable = pcall(function() return child.Interactable end) and child.Interactable ~= false
                local activeOk, active = pcall(function() return child.Active end)
                if interactable and activeOk and active ~= false then
                    table.insert(buttons, child)
                end
            end
        end
        if #buttons == 0 then return end
        local pick
        for _, wanted in ipairs(ingameConfig.ArtifactRewardPriority or {}) do
            for _, btn in ipairs(buttons) do
                local option = tostring(btn:GetAttribute("ItemType")) .. "|" .. tostring(btn:GetAttribute("ItemName"))
                if option == tostring(wanted) then
                    pick = btn
                    break
                end
            end
            if pick then break end
        end
        for _, btn in ipairs(buttons) do
            if pick then break end
            if tostring(btn.Name) == tostring(LocalPlayer.UserId) then
                pick = btn
                break
            end
            local main = btn:FindFirstChild("ScaleThis") and btn.ScaleThis:FindFirstChild("Main")
            local owner = main and main:FindFirstChild("Owner") and main.Owner:FindFirstChild("TextLabel")
            if not pick and owner and (owner.Text == LocalPlayer.Name or owner.Text == LocalPlayer.DisplayName) then
                pick = btn
            end
        end
        pick = pick or buttons[1]
        lastArtifactPickAt = os.clock()
        updateRuntime({Phase = "In game", JoinStatus = "Claiming artifact reward", LastAction = "Choosing " .. tostring(pick.Name)})
        local target = tostring(pick.Name)
        if target ~= "" and target ~= lastArtifactChoice then
            lastArtifactChoice = target
            ActRemoteEvent:FireServer("UpdateArtifactRewardChoice", target)
        end
    end
    state.HandleArtifactReward = handleArtifactReward
    state.LastFeedScanAt = 0
    state.NotificationRemote = ReplicatedStorage:FindFirstChild("Remotes")
    state.NotificationRemote = state.NotificationRemote and state.NotificationRemote:FindFirstChild("Notification")
    if state.NotificationRemote then
        table.insert(state.Connections, state.NotificationRemote.OnClientEvent:Connect(function(kind, title, data)
                if type(data) == "table" and type(data.Text) == "string" then
                    local msg = data.Text
                    local m, s = msg:match("Wait%s*(%d+):(%d+)")
                    if m and s then
                        state.MealLockUntil = os.time() + tonumber(m) * 60 + tonumber(s)
                    else
                        local seconds = msg:match("Wait%s*(%d+)%s*[sS]")
                        if seconds then
                            state.MealLockUntil = os.time() + tonumber(seconds)
                        end
                    end
                end
            end))
    end
    state.FeedTargetMatches = function(info, targetKeys)
        if type(info) ~= "table" or type(targetKeys) ~= "table" then return false end
        for _, candidate in ipairs({
            info.TowerName,
            info.Name,
            info.Asset,
            info.TowerKey,
        }) do
            if candidate ~= nil and targetKeys[tostring(candidate)] then
                return true
            end
        end
        return false
    end
    state.HandleAutoFeed = function()
        if not (ingameConfig.AutoFeed or state.AutoFeedOverride) then
            state.LastFeedScanAt = 0
            state.FeedRecentRequests = {}
            return
        end
        if os.clock() - state.LastFeedScanAt < 0.25 then return end
        state.LastFeedScanAt = os.clock()
        if os.time() < (state.MealLockUntil or 0) then return end
        local dict = type(GlobalTables.TowerDict) == "table" and GlobalTables.TowerDict or {}
        local chefUUID, chefNode
        for uuid, info in pairs(dict) do
            if type(info) == "table"
                and info.Owner == LocalPlayer
                and type(info.Passives) == "table" then
                for _, passive in ipairs(info.Passives) do
                    if tostring(passive) == "BanPassive2" then
                        chefUUID, chefNode = uuid, info.Node
                        break
                    end
                end
            end
            if chefUUID then break end
        end
        if not chefUUID or not chefNode then return end
        local plans = type(ingameConfig.FeedPlans) == "table" and ingameConfig.FeedPlans or {}
        local recent = state.FeedRecentRequests
        if type(recent) ~= "table" then
            recent = {}
            state.FeedRecentRequests = recent
        end
        local now = os.clock()
        local sentCount = 0
        for slot = 1, 6 do
            local okAttr, meal = pcall(function()
                return chefNode:GetAttribute("Meal" .. slot)
            end)
            if not okAttr or meal == nil or tostring(meal) == "" then
                continue
            end
            meal = tostring(meal)
            local plan = plans[meal]
            local targetKeys = type(plan) == "table"
                and plan.Enabled == true
                and type(plan.TargetKeys) == "table"
                and plan.TargetKeys
                or nil
            if not targetKeys or next(targetKeys) == nil then
                continue
            end
            for uuid, info in pairs(dict) do
                if type(info) == "table"
                    and info.Owner == LocalPlayer
                    and state.FeedTargetMatches(info, targetKeys) then
                    local requestKey = table.concat({
                        tostring(slot),
                        meal,
                        tostring(uuid),
                    }, "|")
                    if not recent[requestKey] or now - recent[requestKey] >= 2 then
                        recent[requestKey] = now
                        sentCount += 1
                        print(string.format(
                            "[Feed Burst] %s Meal%d -> %s (%s)",
                            meal,
                            slot,
                            tostring(uuid),
                            tostring(info.TowerName or info.Name or "Unknown")
                        ))
                        pcall(function()
                            PassiveBarRemote:FireServer({
                                Action = "FeedMeal",
                                BanUUID = tostring(chefUUID),
                                MealSlot = slot,
                                TargetTowerUUID = tostring(uuid),
                            })
                        end)
                    end
                end
            end
        end
        if sentCount > 0 then
            state.LastFeedBurstAt = os.clock()
            state.LastFeedBurstCount = sentCount
            print("[Feed Burst] sent " .. tostring(sentCount) .. " feed request(s)")
        end
        for requestKey, at in pairs(recent) do
            if now - at > 30 then
                recent[requestKey] = nil
            end
        end
    end
    function scanner.Stop()
        scanner.Running = false
    end
    function state.Stop()
        if not state.Running then return end
        state.Running, scanner.Running, state.Recording, state.Playing = false, false, false, false
        if state.FixLagController then state.FixLagController:SetEnabled(false) end
        state.PlayGeneration = {}
        for _, connection in ipairs(state.Connections) do pcall(function() connection:Disconnect() end) end
        table.clear(state.Connections)
        state.SetHidePlayerNames(false)
        destroyBlackScreen()
        if state.MobileButton then state.MobileButton:Destroy(); state.MobileButton = nil end
        if state.Gui then state.Gui:Destroy(); state.Gui = nil end
        if state.Window then pcall(function() state.Window:Destroy() end); state.Window = nil end
        state.fluentStatusParagraph = nil
        if state.MapSelectFunction and state.MapSelectHookInstalled then
            pcall(function()
                state.MapSelectFunction.OnClientInvoke = state.OriginalMapSelectInvoke
            end)
            state.MapSelectHookInstalled = false
        end
        if state.EffectStatementsFireClient
            and state.EffectStatementsFireClient.ShaulaAttackStart == state.ShaulaAttackStartWrapper then
            state.EffectStatementsFireClient.ShaulaAttackStart = state.OriginalShaulaAttackStart
        end
        if state.EffectStatementsFireClient
            and state.EffectStatementsFireClient.ReturnByDeath == state.ReturnByDeathWrapper then
            state.EffectStatementsFireClient.ReturnByDeath = state.OriginalReturnByDeath
        end
        if state.EffectStatementsFireClient
            and state.EffectStatementsFireClient.SpawnBooks == state.SpawnBooksWrapper then
            state.EffectStatementsFireClient.SpawnBooks = state.OriginalSpawnBooks
        end
        if TowerHandlerModule.AutoUpgrade == state.NativeAutoUpgradeWrapper then
            TowerHandlerModule.AutoUpgrade = state.OriginalNativeAutoUpgrade
        end
        if TowerHandlerModule.StopAutoUpgrade == state.NativeStopAutoUpgradeWrapper then
            TowerHandlerModule.StopAutoUpgrade = state.OriginalNativeStopAutoUpgrade
        end
        for connection in pairs(disabledIgrisChestConnections) do
            pcall(function() connection:Enable() end)
            disabledIgrisChestConnections[connection] = nil
        end
        if RewardPopupModule.Popup == state.SkipRewardPopup then
            RewardPopupModule.Popup = state.OriginalRewardPopup
        end
        if state.OldNamecall and type(hookmetamethod) == "function" then
            pcall(hookmetamethod, game, "__namecall", state.OldNamecall)
            state.OldNamecall = nil
        end
        log("script stopped")
    end
    table.insert(state.Connections, ActRemoteEvent.OnClientEvent:Connect(function(action, result)
        if action == "ActOver" and type(result) == "table" then
            if state.Recording then state.StopRecording(true) end
            task.spawn(state.PostMatchWebhookAfterData, result, state.WebhookRewardBaseline)
            local config = autoStoryConfig() or ingameConfig
            local resultMode = tostring(result.GameMode or "")
            local liveMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
            local isChallengeResult = string.find(resultMode, "Challenge", 1, true) ~= nil
                or string.find(liveMode, "Challenge", 1, true) ~= nil
            local isRiftResult = string.find(resultMode, "Rift", 1, true) ~= nil
                or string.find(liveMode, "Rift", 1, true) ~= nil
            local artifactInfo = ItemInfo.Artifacts and ItemInfo.Artifacts[tostring(config.ArtifactName or "")]
            artifactInfo = artifactInfo and artifactInfo.MapSelectInfo
            local configuredArtifact = config.AutoJoin == true and config.GameMode == "Artifact" and artifactInfo
                and tostring(result.WorldName or mapInfo.WorldName) == tostring(artifactInfo.WorldName)
                and tostring(result.Act or mapInfo.Act) == tostring(artifactInfo.Act)
            local isArtifactResult = resultMode == "Artifact" or liveMode == "Artifact" or configuredArtifact == true
            local replayArtifact = isArtifactResult and config.AutoReplayGame == true and state.ReplayArtifact() ~= nil
            local replayRift = isRiftResult and config.AutoReplayGame == true and state.RiftReplayAvailable()
            if replayArtifact or replayRift then
                if state.Playing then state.StopPlayback() end
                state.PendingStageAutoPlay = config.AutoPlayMacro == true
                state.EnsureAutoReplay = true
                SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
                SettingsRemote:FireServer("SetSetting", "AutoReplayGame", true)
                updateUI(replayArtifact and "ARTIFACT REPLAY; WAITING FOR ITEM SELECTION" or "RIFT REPLAY; ROTATION STILL OPEN")
                log((replayArtifact and "Artifact" or "Rift") .. " ActOver: native replay retained")
                return
            end
            if isChallengeResult or isRiftResult or isArtifactResult then
                if state.Playing then state.StopPlayback() end
                state.PendingStageAutoPlay = false
                state.EnsureAutoReplay = false
                SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
                SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
                local challengeTarget
                if isChallengeResult then
                    challengeTarget = challengeTargetMatches(config)
                    if not challengeTarget then
                        local initial = state.InitialChallengeTarget or {}
                        challengeTarget = {
                            Owner = "Challenge",
                            ChallengeKind = initial.ChallengeKind or "Normal",
                            ChallengeSeed = initial.ChallengeSeed,
                            GameMode = "Challenge",
                            World = result.WorldName or mapInfo.WorldName,
                            Act = result.Act or mapInfo.Act,
                            Difficulty = result.Difficulty or mapInfo.Difficulty,
                        }
                    end
                    local kind = tostring(challengeTarget.ChallengeKind or "Normal")
                    config.ChallengeLosses = type(config.ChallengeLosses) == "table"
                        and config.ChallengeLosses or {}
                    if result.Success == true then
                        config.ChallengeLosses[kind] = nil
                    else
                        recordChallengeLoss(config, challengeTarget)
                    end
                end
                updateUI(isArtifactResult and "ARTIFACT FINISHED; RETURNING TO LOBBY"
                    or isRiftResult and "RIFT FINISHED; RETURNING TO LOBBY"
                    or "CHALLENGE FINISHED; RETURNING TO LOBBY")
                log((resultMode ~= "" and resultMode or liveMode) .. " ActOver: replay unavailable; returning to lobby")
                returnToLobbyForChallenge(
                    config,
                    challengeTarget,
                    isChallengeResult and {MarkAttempted = true} or nil
                )
                return
            end
            if state.PendingChallengeLeave then
                state.PendingChallengeLeave = false
                if state.Playing then state.StopPlayback() end
                state.PendingStageAutoPlay = false
                state.EnsureAutoReplay = false
                SettingsRemote:FireServer("SetSetting", "AutoNextGame", false)
                SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
                updateUI("MATCH FINISHED; RETURNING FOR CHALLENGE")
                log(resultMode .. " ActOver: pending Challenge Auto Leave released after match completion")
                returnToLobbyForChallenge(config)
                return
            end
            if ingameConfig.AutoReplayGame == true then
                if state.Playing then state.StopPlayback() end
                state.PendingStageAutoPlay = true
                log("ActOver: armed macro for next Auto Replay")
                updateUI("WAITING NEXT AUTO REPLAY")
            end
            finishFiniteQuestAct()
        end
    end))
    state.LastObservedWave = tonumber(AttributeHolder:GetAttribute("Wave")) or 0
    table.insert(state.Connections, AttributeHolder:GetAttributeChangedSignal("Wave"):Connect(function()
        local config = autoStoryConfig()
        local target = questTargetMatches(config)
        local previousWave = tonumber(state.LastObservedWave) or 0
        local wave = tonumber(AttributeHolder:GetAttribute("Wave")) or 0
        state.LastObservedWave = wave
        local currentMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
        local eventMode = string.find(currentMode, "Challenge", 1, true) ~= nil
            or string.find(currentMode, "Rift", 1, true) ~= nil
            or currentMode == "Artifact"
        if target and target.QuestKind == "Infinite" and wave >= (tonumber(target.TargetWave) or math.huge) then
            disableQuestVotes()
            returnQuestToLobby(config)
            return
        end
        if not eventMode
            and wave <= 1
            and previousWave > 1
            and state.NativeAutomationReady
            and not state.PendingMode
            and not state.Recording
            and (not state.Playing or state.TimelineDone) then
            local replay = config and (config.AutoPlayMacro == true or config.AutoChallenge == true
                or config.AutoStory == true or config.AutoQuest == true) or false
            if replay then
                if state.Playing and state.TimelineDone then state.StopPlayback() end
                state.PendingStageAutoPlay = true
                log(string.format("re-armed auto play after wave reset %s -> %s", tostring(previousWave), tostring(wave)))
            end
        end
    end))
    table.insert(state.Connections, LocalPlayer.Idled:Connect(function()
        if not state.Running or not ingameConfig.AntiAFK then return end
        pcall(function()
            local virtualUser = game:GetService("VirtualUser")
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end)
    end))
    table.insert(state.Connections, game.DescendantAdded:Connect(function(instance)
        if ingameConfig.HidePlayerNames then task.defer(hideNameGui, instance) end
    end))
    local function ensureAutoReplay()
        local currentMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
        local challenge = string.find(currentMode, "Challenge", 1, true) ~= nil
        local rift = string.find(currentMode, "Rift", 1, true) ~= nil
        local artifact = currentMode == "Artifact"
        local desired = ingameConfig.AutoReplayGame == true
        if challenge or rift and not state.RiftReplayAvailable() or artifact and not state.ReplayArtifact() then
            desired = false
        end
        if not desired and (challenge or rift or artifact) then
            state.PendingStageAutoPlay = false
            state.EnsureAutoReplay = false
        end
        local native = ((GlobalTables.PlayerData or {}).Settings or {}).AutoReplayGame == true
        if native ~= desired then
            SettingsRemote:FireServer("SetSetting", "AutoReplayGame", desired)
        end
        if challenge or rift or artifact then SettingsRemote:FireServer("SetSetting", "AutoNextGame", false) end
        local frame
        local function findReplay(inst)
            if not inst then return end
            if inst.Name == "AutoReplayGame" and inst:IsA("Frame") then frame = inst return end
            for _, child in pairs(inst:GetChildren()) do findReplay(child) end
        end
        local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        findReplay(gui)
        if not frame then findReplay(game:GetService("StarterGui")) end
        if not frame then return end
        local btn = frame:FindFirstChild("Main") and frame.Main:FindFirstChild("Toggle") and frame.Main.Toggle:FindFirstChild("Button")
        local on = btn and btn:FindFirstChild("On")
        if on and on.Visible ~= desired then
            pcall(function() firesignal(btn.MouseButton1Click) end)
        end
    end
    task.spawn(function()
        while state.Running do
            task.wait(5)
            ensureAutoReplay()
        end
    end)
    scan("scanner started")
    installHook()
    state.UltimateUIInitialized = false
    function state.InitializeUltimateUI()
        if state.UltimateUIInitialized or not state.Running then return end
        state.UltimateUIInitialized = true
        if not createFluentUI() then createUI() end
        createIngameMobileButton()
        state.SetHidePlayerNames(ingameConfig.HidePlayerNames)
        state.SetBlackScreen(ingameConfig.BlackScreen)
    end
    state.InfiniteRestartArmed = true
    state.InfiniteRunStartedAt = os.clock()
    state.InfiniteRewardBaseline = rewardInventorySnapshot()
    state.WebhookRewardBaseline = rewardInventorySnapshot()
    if environment.AOPendingInfiniteWebhook then
        task.spawn(processPendingInfiniteWebhook, environment.AOPendingInfiniteWebhook)
    end
    task.spawn(function()
        local deadline = os.clock() + 180
        while state.Running and os.clock() < deadline
            and (not nativeLoadingComplete() or type(GlobalTables.CurrentGame) ~= "table") do
            updateUI("WAITING FOR MOBILE GAME LOAD")
            task.wait(0.25)
        end
        if not state.Running or not nativeLoadingComplete() or type(GlobalTables.CurrentGame) ~= "table" then
            log("native game loading did not complete within 180 seconds")
            updateUI("NATIVE GAME LOAD TIMEOUT")
            return
        end
        state.InitializeUltimateUI()
        while state.Running and not GlobalTables.GameStarted
            and (tonumber(AttributeHolder:GetAttribute("Wave")) or 0) < 1 do
            updateUI("WAITING FOR START GAME VOTE")
            ensureAutomatedGameStart()
            task.wait(0.25)
        end
        if not state.Running then return end
        state.NativeAutomationReady = true
        updateUI("GAME READY")
        log(tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "") == "Artifact"
            and "native game ready; Artifact playback unlocked without restart"
            or "native game ready; macro restarts unlocked")
        if ingameConfig.AutoPlayMacro or challengeTargetMatches(ingameConfig)
            or ingameConfig.AutoStory or ingameConfig.AutoQuest then
            task.wait(2)
            state.Play()
        end
    end)
    task.spawn(function()
        while state.Running do
            handleCardSelection()
            handleArtifactReward()
            state.HandleAutoFeed()
            scanNewUnitWebhooks()
            ensureAutomatedGameStart()
            updateAutoLeaveStatus(state, ingameConfig, mapInfo, LocalPlayer)
            local gameMode = tostring(AttributeHolder:GetAttribute("GameMode") or mapInfo.GameMode or "")
            local isChallengeMode = string.find(gameMode, "Challenge", 1, true) ~= nil
            local isRiftMode = string.find(gameMode, "Rift", 1, true) ~= nil
            local isEventMode = isChallengeMode or isRiftMode
            if not isEventMode then
                if state.PendingChallengeLeave and infiniteModeActive() and not state.ChallengeTeleporting then
                    log("Pending Challenge Auto Leave entered Infinite; returning immediately because Infinite has no ActOver")
                    returnToLobbyForChallenge(ingameConfig)
                end
                if not state.ChallengeTeleporting
                    and not state.PendingChallengeLeave
                    and state.NativeAutomationReady
                    and ingameConfig.AutoChallengeLeave
                    and ingameConfig.AutoChallenge
                    and os.clock() >= (state.NextChallengeTimerReadAt or 0) then
                    state.NextChallengeTimerReadAt = os.clock() + 2
                    local timer = aoReadChallengeTimer(LocalPlayer.UserId)
                    local nextCheck = timer and tonumber(timer.NextCheckAt) or 0
                    if nextCheck <= 0 then
                        nextCheck = tonumber(ingameConfig.ChallengeNextCheckAt) or 0
                    end
                    if nextCheck > 0 and os.time() >= nextCheck then
                        if timer then
                            timer.NextCheckAt, timer.ConsumedAt = 0, os.time()
                            timer.Reason = "Consumed by ingame Auto Leave"
                            aoWriteChallengeTimer(LocalPlayer.UserId, timer)
                        end
                        ingameConfig.ChallengeNextCheckAt = 0
                        saveLobbyConfig(ingameConfig)
                        if infiniteModeActive() then
                            log("Challenge due during Infinite; returning immediately because Infinite has no ActOver")
                            returnToLobbyForChallenge(ingameConfig)
                        else
                            state.PendingChallengeLeave = true
                            ingameConfig.ChallengeLeaveAfterMatch = true
                            saveLobbyConfig(ingameConfig)
                            updateUI("CHALLENGE DUE; LEAVING AFTER MATCH")
                            log(gameMode .. " Challenge Auto Leave pending until ActOver")
                        end
                    end
                end
            end
            if not isRiftMode
                    and not state.ChallengeTeleporting
                    and not state.RiftTeleporting
                    and ingameConfig.AutoRiftLeave
                    and os.clock() >= (state.NextRiftTimerReadAt or 0) then
                    state.NextRiftTimerReadAt = os.clock() + 2
                    local timer = aoReadRiftTimer(LocalPlayer.UserId)
                    local nextCheck = timer and tonumber(timer.NextCheckAt) or 0
                    local closeAt = timer and tonumber(timer.RiftCloseAt) or 0
                    local isOpen = state.RiftReplayAvailable()
                    if nextCheck <= 0 then
                        nextCheck = tonumber(ingameConfig.RiftNextCheckAt) or 0
                    end
                    local isDue = false
                    if nextCheck > 0 and os.time() >= nextCheck then
                        isDue = true
                    elseif isOpen then
                        isDue = true
                    end
                    if isDue then
                        if timer then
                            if closeAt == 0 or os.time() < closeAt then
                                timer.NextCheckAt = 0
                            else
                                timer.NextCheckAt, timer.ConsumedAt = 0, os.time()
                            end
                            timer.Reason = "Rift open; ingame Auto Leave returning to lobby"
                            if closeAt > 0 then timer.RiftCloseAt = closeAt end
                            aoWriteRiftTimer(LocalPlayer.UserId, timer)
                        end
                        ingameConfig.RiftNextCheckAt = 0
                        saveLobbyConfig(ingameConfig)
                        returnToLobbyForChallenge(ingameConfig, nil, {Rift = true})
                    end
            end
    local liveMap = currentMap()
    local liveSignature = stageSignature(liveMap)
    local liveWave = tonumber(AttributeHolder:GetAttribute("Wave")) or 0
            if not ingameConfig.AutoRestartInfinite or not infiniteModeActive() then
                state.InfiniteRestartArmed = true
            elseif liveWave <= 1 then
                state.InfiniteRestartArmed = true
            elseif state.NativeAutomationReady and state.InfiniteRestartArmed
                and liveWave >= ingameConfig.AutoRestartInfiniteWave and not state.PendingMode then
                restartInfiniteRun(liveWave)
            end
            if liveSignature ~= state.StageSignature then
                state.StageSignature = liveSignature
                if state.Playing then state.StopPlayback() end
                refreshMapIdentity()
                local config = autoStoryConfig()
                state.PendingStageAutoPlay = config and (config.AutoPlayMacro == true or config.AutoChallenge == true
                    or config.AutoStory == true or config.AutoQuest == true) or false
                log("stage changed to " .. macroKey)
                updateUI(state.PendingStageAutoPlay and "WAITING AUTO STORY MACRO" or "STAGE CHANGED")
            end
            if state.NativeAutomationReady and state.PendingStageAutoPlay
                and not state.PendingMode and not state.Recording and not state.Playing then
                local wave = tonumber(AttributeHolder:GetAttribute("Wave"))
                if wave and wave <= 1 then
                    state.PendingStageAutoPlay = false
                    if state.Load() then beginPlayback() else updateUI("NO AUTOMATION MACRO FOR " .. tostring(mapInfo.WorldName)) end
                end
            end
            if state.PendingMode then
                local elapsed = os.clock() - state.PendingStartedAt
                local wave, money, towers = AttributeHolder:GetAttribute("Wave"), LocalPlayer:GetAttribute("Money"), ownedTowerCount()
                if wave ~= state.PendingInitialWave or money ~= state.PendingInitialMoney or towers < state.PendingInitialTowers then state.PendingTransitionSeen = true end
                local atRoundStart = tonumber(wave) ~= nil and tonumber(wave) <= 1
                if elapsed >= 0.75 and atRoundStart and (state.PendingTransitionSeen or elapsed >= 2.5) then
                    local mode = state.PendingMode
                    log(string.format("restart confirmed at wave %s after %.2fs", tostring(wave), elapsed))
                    if mode == "Record" then beginRecording() else beginPlayback() end
                elseif elapsed >= 20 then
                    local mode = state.PendingMode
                    state.PendingMode = nil
                    updateUI("RESTART TIMEOUT")
                    log("RestartGame timeout for " .. tostring(mode))
                end
            end
            if state.Recording then
                for uuid, tower in pairs(GlobalTables.TowerDict or {}) do
                    if tower.Owner == LocalPlayer then
                        local mode, previousMode = tonumber(tower.AutoUpgradeMode) or 0, state.ObservedAutoModes[uuid]
                        if previousMode == nil then
                            state.ObservedAutoModes[uuid] = mode
                            refForUUID(uuid)
                        elseif mode ~= previousMode then
                            state.ObservedAutoModes[uuid] = mode
                            if state.RecordedPlacements[uuid] == true and state.RecordedAutoModes[uuid] ~= mode then
                                state.RecordedAutoModes[uuid] = mode
                                if mode ~= 0 then
                                    addAction({
                                        Type = "AutoUpgrade",
                                        Mode = mode,
                                        Target = towerDescriptor(uuid),
                                    })
                                end
                            end
                        end
                    end
                end
            end
            if next(state.PlaybackAutoModes) ~= nil then
                local candidates = {}
                for uuid in pairs(state.PlaybackAutoModes) do
                    local tower = ownedTower(uuid)
                    local mode = tower and tonumber(tower.AutoUpgradeMode) or 0
                    if not tower or mode <= 0 then state.PlaybackAutoModes[uuid] = nil
                    else
                        local info = TowerInfo[tower.TowerName]
                        local maxed = not info or not info.StageStats or tower.Stage >= #info.StageStats
                        local cost = not maxed and CalculateStuff.TowerCost(tower, tower.Stage + 1) or nil
                        if maxed or not cost then
                            state.PlaybackAutoModes[uuid] = nil; pcall(function() TowerHandlerModule.StopAutoUpgrade(uuid) end); tower.AutoUpgradeMode = 0; refreshTowerUI(uuid)
                        elseif cost <= (LocalPlayer:GetAttribute("Money") or 0) then
                            table.insert(candidates, {UUID = uuid, Mode = mode, Cost = cost})
                        end
                    end
                end
                table.sort(candidates, function(left, right)
                    if left.Mode ~= right.Mode then return left.Mode < right.Mode end
                    if left.Cost ~= right.Cost then return left.Cost < right.Cost end
                    return tostring(left.UUID) < tostring(right.UUID)
                end)
                if candidates[1] and os.clock() >= (state.NextAutoUpgradeAt or 0) then
                    state.NextAutoUpgradeAt = os.clock() + 0.15
                    pcall(function() TowerFunction:InvokeServer("UpgradeTower", candidates[1].UUID) end)
                end
            end
updateUI()
            task.wait(0.1)
        end
    end
    )
    task.spawn(function()
            task.wait(5)
            if scanner.Running then
                local ok, err = pcall(scan, "state changed")
                if not ok then appendLog("[AO Map Scanner]", mapLogPath, "scan error: " .. tostring(err)) end
            end
end
        )
    log("loaded; macro path=" .. macroPath)
    return
end
local Players = earlyPlayers
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local LocalPlayer = earlyLocalPlayer
local environment
if type(getgenv) == "function" then
    environment = getgenv()
elseif type(shared) == "table" then
    environment = shared
elseif type(_G) == "table" then
    environment = _G
else
    environment = {}
end
local previous = environment.AnimeOriginsUltimate
if previous then
    if type(previous.Stop) == "function" then pcall(previous.Stop) else previous.Running = false end
end
local previousFluent = environment.Fluent
if previousFluent and previousFluent.Window and type(previousFluent.Destroy) == "function" then
    pcall(previousFluent.Destroy, previousFluent)
    environment.Fluent = nil
end
local state = {Running = true, Connections = {}}
environment.AnimeOriginsUltimate = state
function state.Stop()
    if not state.Running then return end
    state.Running = false
    if state.FixLagController then state.FixLagController:SetEnabled(false) end
    for _, connection in ipairs(state.Connections) do pcall(function() connection:Disconnect() end) end
    table.clear(state.Connections)
    if state.SetHidePlayerNames then state.SetHidePlayerNames(false) end
    if state.SetBlackScreen then state.SetBlackScreen(false) end
    if state.MobileButton then state.MobileButton:Destroy(); state.MobileButton = nil end
    if state.Window then pcall(function() state.Window:Destroy() end); state.Window = nil end
    local fluent = environment.Fluent
    if fluent and fluent.Window and type(fluent.Destroy) == "function" then
        pcall(fluent.Destroy, fluent)
        environment.Fluent = nil
    end
end
local Modules = ReplicatedStorage:WaitForChild("Modules")
local LobbyRemotes = ReplicatedStorage:WaitForChild("LobbyRemotes")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local GlobalTables = require(Modules:WaitForChild("GlobalTables"))
local GameInfo = require(Modules:WaitForChild("GameInfo"))
local CalculateStuff = require(Modules:WaitForChild("CalculateStuff"))
local TowerInfo = require(Modules:WaitForChild("TowerInfo"))
local ItemInfo = require(Modules:WaitForChild("ItemInfo"))
local BattlepassInfo = require(Modules:WaitForChild("BattlepassInfo"))
local QuestInfo = require(Modules:WaitForChild("QuestInfo"))
local ModifiersInfo = require(Modules:WaitForChild("ModifiersInfo"))
local BannerModule = require(ReplicatedStorage.LobbyModules:WaitForChild("BannerModule"))
local ProductsModule = require(Modules:WaitForChild("ProductsModule"))
local TimeRotations = require(ReplicatedStorage.LobbyModules:WaitForChild("TimeRotations"))
local GeneralModule = require(Modules:WaitForChild("GeneralModule"))
local PartyLocal = require(ReplicatedStorage.LobbyModules:WaitForChild("UIHandler"):WaitForChild("PartyLocal"))
local RemoteEvent = Remotes:WaitForChild("RemoteEvent")
local InventoryRemote = Remotes:WaitForChild("InventoryRemotes"):WaitForChild("InventoryRemote")
local QuestRemote = LobbyRemotes:WaitForChild("QuestRemote")
local SummonFunction = LobbyRemotes:WaitForChild("SummonFunction")
local BattlepassRemote = LobbyRemotes:WaitForChild("BattlepassRemote")
local PlayTimeRewardsRemote = LobbyRemotes:WaitForChild("PlayTimeRewardsRemote")
local MapSelectRemote = Remotes:WaitForChild("MapSelectRemote")
local PartyRemote = Remotes:WaitForChild("PartyRemote")
local MiscRemote = LobbyRemotes:WaitForChild("MiscRemote")
local CraftingRemote = LobbyRemotes:WaitForChild("CraftingRemote")
local ShopRemote = LobbyRemotes:WaitForChild("ShopRemote")
local ShopFunction = LobbyRemotes:WaitForChild("ShopFunction")
local CodesFunction = LobbyRemotes:WaitForChild("CodesFunction")
local ChallengeFunction = Remotes:WaitForChild("ChallengeFunction")
local SettingsRemote = Remotes:WaitForChild("SettingsRemote")
local ItemRemote = Remotes:WaitForChild("ItemRemotes"):WaitForChild("ItemRemote")
local configFolder = "AnimeOrigins_" .. LocalPlayer.UserId
local autoSaveFolder = configFolder .. "/AutoSave"
local configsFolder = configFolder .. "/Configs"
local lobbyConfigPath = autoSaveFolder .. "/lobby.json"
local ingameConfigPath = autoSaveFolder .. "/ingame.json"
local macrosFolder = configFolder .. "/macros"
local exportsFolder = configFolder .. "/Exports"
local logsFolder = configFolder .. "/Logs"
local function aoLog(message)
    pcall(function()
        if type(makefolder) == "function" and type(isfolder) == "function" then
            if not isfolder(configFolder) then makefolder(configFolder) end
            if not isfolder(logsFolder) then makefolder(logsFolder) end
        end
        appendLog("[AO Lobby]", logsFolder .. "/lobby.log", tostring(message))
    end)
end
local defaults = {
    AutoClaim = false,
    ClaimQuests = true,
    ClaimDaily = true,
    ClaimPlaytime = true,
    ClaimBattlepass = true,
    ClaimLevelMilestones = true,
    ClaimTowerIndex = true,
    ClaimGroupReward = true,
    ClaimInfinityRank = true,
    AntiAFK = true,
    AutoReconnect = true,
    MobileButton = true,
    FPSLimit = 60,
    FixLag = false,
    AutoPlayMacro = false,
    AutoRestartInfinite = false,
    AutoRestartInfiniteWave = 100,
    HidePlayerNames = false,
    BlackScreen = true,
    BlackScreenVersion = AO_BLACK_SCREEN_VERSION,
    AutoSummon = false,
    AutoSummonUnits = {},
    AutoSummonAmount = "Max",
    AutoSummonReserve = 0,
    AutoJoin = false,
    AutoArtifact = false,
    ArtifactName = "",
    ArtifactRewardPriority = {},
    AutoCardPick = false,
    CardPriority = {},
    AutoFeed = false,
    FeedPlans = {},
    AutoReplayGame = false,
    AutoQuest = false,
    AutoQuestSummon = false,
    AutoChallenge = false,
    AutoChallengeLeave = false,
    ChallengeLeaveAfterMatch = false,
    AutoRift = false,
    AutoRiftLeave = false,
    ChallengeFlowVersion = 0,
    ChallengeTypes = {"Daily", "Normal"},
    ChallengeNextCheckAt = 0,
    ChallengeAttemptedSeeds = {},
    ChallengeLosses = {},
    ChallengeRuntimeTarget = nil,
    RiftNextCheckAt = 0,
    RiftAttemptedSeeds = {},
    RiftRuntimeTarget = nil,
    RiftMacro = "",
    ChallengeLastInfo = {},
    ChallengeMacroByWorld = {},
    QuestWorld = "WestCity",
    QuestAct = "1",
    QuestDifficulty = "Normal",
    QuestRuntimeTarget = {},
    AutoStory = false,
    AutoStoryDifficulty = "Normal",
    StoryMacroByWorld = {},
    GameMode = "Story",
    World = "WestCity",
    Act = "1",
    Difficulty = "Normal",
    AutoCraft = false,
    CraftItems = {},
    AutoGoldShop = false,
    GoldShopItems = {},
    AutoShops = {},
    ShopItems = {},
    AutoRedeemCodes = false,
    Codes = "",
    WebhookUrl = "",
    WebhookCompletionEnabled = false,
    WebhookUnitEnabled = false,
    AutoFrag = false,
    AutoClash = false,
    AutoParry = false,
    AutoFindBook = false,
    AutoChest = false,
    AutoYutaAbility = false,
    YutaAutoAbilities = {},
    AutoMadaraMaxBonus = false,
}
local config = {}
for key, value in pairs(defaults) do
    config[key] = value
end
local function saveConfig()
    if type(writefile) ~= "function" then
        return
    end
    pcall(function()
        if type(makefolder) == "function" and type(isfolder) == "function" then
            if not isfolder(configFolder) then
                makefolder(configFolder)
            end
            for _, folder in ipairs({autoSaveFolder, configsFolder, macrosFolder, exportsFolder}) do
                if not isfolder(folder) then makefolder(folder) end
            end
        end
        writefile(lobbyConfigPath, HttpService:JSONEncode(config))
        if type(isfile) ~= "function" or not isfile(ingameConfigPath) then
            writefile(ingameConfigPath, HttpService:JSONEncode({}))
        end
    end)
end
local loadPath
local blackScreenNeedsMigration = true
if type(isfile) == "function" then
    loadPath = isfile(lobbyConfigPath) and lobbyConfigPath or isfile(configFolder .. "/config.json") and configFolder .. "/config.json" or nil
end
if loadPath then
    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(readfile(loadPath))
    end)
    if ok and type(decoded) == "table" then
        blackScreenNeedsMigration = tonumber(decoded.BlackScreenVersion) == nil
        for key, value in pairs(defaults) do
            if decoded[key] ~= nil then
                config[key] = decoded[key]
            end
        end
    end
end
local function normalizeLobbyConfig(value)
    value.CraftItems = type(value.CraftItems) == "table" and value.CraftItems or {}
    value.GoldShopItems = type(value.GoldShopItems) == "table" and value.GoldShopItems or {}
    value.AutoShops = type(value.AutoShops) == "table" and value.AutoShops or {}
    value.ShopItems = type(value.ShopItems) == "table" and value.ShopItems or {}
    value.ShopItems.GoldShop = type(value.ShopItems.GoldShop) == "table" and value.ShopItems.GoldShop or {}
    if value.AutoGoldShop then value.AutoShops.GoldShop = true end
    if next(value.ShopItems.GoldShop) == nil and #value.GoldShopItems > 0 then
        value.ShopItems.GoldShop = table.clone(value.GoldShopItems)
    end
    if tonumber(value.BlackScreenVersion) == nil then aoMigrateBlackScreen(value) end
    value.BlackScreenVersion = AO_BLACK_SCREEN_VERSION
    value.BlackScreen = value.BlackScreen == true
    do
        local normalized, seen = {}, {}
        for key, selected in pairs(type(value.AutoSummonUnits) == "table" and value.AutoSummonUnits or {}) do
            local unit = type(key) == "number" and selected or selected and key or nil
            unit = unit and tostring(unit):match("%[(.-)%]$") or unit and tostring(unit) or nil
            if unit and unit ~= "" and aoIsBaseMythic(TowerInfo, unit) and not seen[unit] then
                seen[unit] = true
                table.insert(normalized, unit)
            end
        end
        table.sort(normalized)
        value.AutoSummonUnits = normalized
    end
    value.Codes = tostring(value.Codes or "")
    value.WebhookUrl = tostring(value.WebhookUrl or "")
    value.StoryMacroByWorld = type(value.StoryMacroByWorld) == "table" and value.StoryMacroByWorld or {}
    value.QuestRuntimeTarget = type(value.QuestRuntimeTarget) == "table"
        and value.QuestRuntimeTarget.Owner == "Quest" and value.QuestRuntimeTarget or nil
    if not value.AutoQuest then value.QuestRuntimeTarget = nil end
    local amount = tostring(value.AutoSummonAmount or "Max")
    value.AutoSummonAmount = amount == "Max" and "Max"
        or tostring(math.clamp(math.floor(tonumber(amount) or 1), 1, 50))
    value.AutoSummonReserve = math.max(0, math.floor(tonumber(value.AutoSummonReserve) or 0))
    value.AutoRestartInfinite = value.AutoRestartInfinite == true
    value.AutoReconnect = value.AutoReconnect == true
    value.FixLag = value.FixLag == true
    value.AutoRestartInfiniteWave = math.max(1, math.floor(tonumber(value.AutoRestartInfiniteWave) or 100))
    value.FPSLimit = math.clamp(math.floor(tonumber(value.FPSLimit) or 60), 10, 240)
    value.AutoChallenge = value.AutoChallenge == true
    value.AutoChallengeLeave = value.AutoChallengeLeave == true
    value.ChallengeLeaveAfterMatch = value.ChallengeLeaveAfterMatch == true
    value.AutoRift = value.AutoRift == true
    value.AutoRiftLeave = value.AutoRiftLeave == true
    value.AutoFrag = value.AutoFrag == true
    value.AutoClash = value.AutoClash == true
    value.AutoParry = value.AutoParry == true
    value.AutoFindBook = value.AutoFindBook == true
    value.AutoChest = value.AutoChest == true
    value.AutoYutaAbility = value.AutoYutaAbility == true
    value.YutaAutoAbilities = type(value.YutaAutoAbilities) == "table" and value.YutaAutoAbilities or {}
    value.AutoMadaraMaxBonus = value.AutoMadaraMaxBonus == true
    value.RiftNextCheckAt = math.max(0, math.floor(tonumber(value.RiftNextCheckAt) or 0))
    value.RiftMacro = tostring(value.RiftMacro or "")
    if tonumber(value.ChallengeFlowVersion) ~= 2 then
        value.ChallengeAttemptedSeeds, value.ChallengeLosses = {}, {}
        value.ChallengeRuntimeTarget, value.ChallengeNextCheckAt = nil, 0
    end
    value.ChallengeFlowVersion = 2
    do
        local normalized, seen = {}, {}
        for key, selected in pairs(type(value.ChallengeTypes) == "table" and value.ChallengeTypes or {}) do
            local kind = type(key) == "number" and selected or selected and key or nil
            kind = tostring(kind or "")
            if (kind == "Daily" or kind == "Normal") and not seen[kind] then
                seen[kind] = true
                table.insert(normalized, kind)
            end
        end
        value.ChallengeTypes = normalized
    end
    value.ChallengeNextCheckAt = math.max(0, math.floor(tonumber(value.ChallengeNextCheckAt) or 0))
    value.ChallengeAttemptedSeeds = type(value.ChallengeAttemptedSeeds) == "table" and value.ChallengeAttemptedSeeds or {}
    value.ChallengeLosses = type(value.ChallengeLosses) == "table" and value.ChallengeLosses or {}
    value.ChallengeLastInfo = type(value.ChallengeLastInfo) == "table" and value.ChallengeLastInfo or {}
    do
        local normalized = {}
        for world, macro in pairs(type(value.ChallengeMacroByWorld) == "table" and value.ChallengeMacroByWorld or {}) do
            if type(world) == "string" and type(macro) == "string" and macro ~= "" and macro ~= "None" then
                normalized[world] = macro
            end
        end
        value.ChallengeMacroByWorld = normalized
    end
    value.ChallengeRuntimeTarget = value.AutoChallenge and type(value.ChallengeRuntimeTarget) == "table"
        and value.ChallengeRuntimeTarget.Owner == "Challenge" and value.ChallengeRuntimeTarget or nil
    value.World = tostring(value.World or "WestCity")
    value.Act = tostring(value.Act or "1")
    value.GameMode = table.find({"Story", "Infinite", "Raid", "Rift", "Legend", "Artifact", "Trial", "ReZero", "WorldBoss"}, tostring(value.GameMode)) and tostring(value.GameMode) or "Story"
    value.ArtifactName = tostring(value.ArtifactName or "")
    if value.ArtifactName == "" and type(ItemInfo.Artifacts) == "table" and ItemInfo.Artifacts[value.World] then
        value.ArtifactName = tostring(value.World)
    end
    if value.GameMode == "Artifact" and value.ArtifactName ~= "" then value.World = value.ArtifactName end
    if value.GameMode == "Trial" and table.find({"PleiadesSand", "PleiadesLibrary"}, value.World) then
        value.GameMode = "ReZero"
    elseif value.GameMode == "ReZero" and value.World == "PleiadesGrass" then
        value.GameMode = "Trial"
    end
    if value.GameMode == "Infinite" then
        value.Act, value.Difficulty = "Infinite", "Hard"
    elseif value.GameMode == "Raid" or value.GameMode == "Legend" or value.GameMode == "Artifact" then
        value.Difficulty = "Hard"
    elseif value.GameMode == "Trial" then
        if value.World == "PleiadesGrass" then
            value.Act = "Trial"
        else
            value.World, value.Act = "SandVillage", "MadaraStage"
        end
        value.Difficulty = "None"
    elseif value.GameMode == "ReZero" then
        value.World = table.find({"PleiadesSand", "PleiadesLibrary"}, value.World) and value.World or "PleiadesSand"
        value.Act = table.find({"1", "2"}, value.Act) and value.Act or "1"
        value.Difficulty = "None"
    elseif value.GameMode == "WorldBoss" then
        value.World, value.Act, value.Difficulty = "Igris", "None", "None"
    end
    return value
end
if blackScreenNeedsMigration then config.BlackScreen, config.BlackScreenVersion = true, AO_BLACK_SCREEN_VERSION end
normalizeLobbyConfig(config)
state.Config = config
state.SetFPSLimit = function(value)
    config.FPSLimit = math.clamp(math.floor(tonumber(value) or 60), 10, 240)
    local setter = type(setfpscap) == "function" and setfpscap or environment.setfpscap
    if type(setter) == "function" then pcall(setter, config.FPSLimit) end
end
state.SetFPSLimit(config.FPSLimit)
AOCreateFixLagController({State = state, Config = config, InGame = false, Log = aoLog}):SetEnabled(config.FixLag)
state.SetFPSLimit(config.FPSLimit)
aoInstallAutoReconnect({
    State = state,
    LocalPlayer = LocalPlayer,
    LobbyPlace = require(ReplicatedStorage.PlaceIDs).LobbyPlace,
    Enabled = function() return config.AutoReconnect end,
    Log = aoLog,
})
local hiddenNameGuis = {}
local function isCharacterBillboard(instance)
    if not instance:IsA("BillboardGui") then return false end
    local ancestor = instance.Parent
    while ancestor and ancestor ~= workspace do
        if ancestor:IsA("Model") and Players:GetPlayerFromCharacter(ancestor) then return true end
        ancestor = ancestor.Parent
    end
    return false
end
local function hideNameGui(instance)
    local namedOverhead = (instance.Name == "PlayerOverhead" or instance.Name == "NpcOverhead")
        and (instance:IsA("BillboardGui") or instance:IsA("ScreenGui") or instance:IsA("SurfaceGui"))
    if (namedOverhead or isCharacterBillboard(instance)) and instance.Enabled then
        hiddenNameGuis[instance] = true
        instance.Enabled = false
    end
end
function state.SetHidePlayerNames(enabled)
    config.HidePlayerNames = enabled == true
    if config.HidePlayerNames then
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if playerGui then for _, instance in ipairs(playerGui:GetDescendants()) do hideNameGui(instance) end end
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then for _, instance in ipairs(player.Character:GetDescendants()) do hideNameGui(instance) end end
        end
    else
        for instance in pairs(hiddenNameGuis) do
            if instance.Parent then pcall(function() instance.Enabled = true end) end
            hiddenNameGuis[instance] = nil
        end
    end
end
local function destroyBlackScreen()
    for _, parent in ipairs({game:GetService("CoreGui"), LocalPlayer:FindFirstChildOfClass("PlayerGui")}) do
        local old = parent and parent:FindFirstChild("AnimeOriginsBlackScreen")
        if old then old:Destroy() end
    end
    state.BlackScreenGui = nil
    state.BlackScreenVisible = false
end
function state.SetBlackScreen(enabled, showImmediately)
    config.BlackScreen = enabled == true
    destroyBlackScreen()
end
table.insert(state.Connections, game.DescendantAdded:Connect(function(instance)
    if config.HidePlayerNames then task.defer(hideNameGui, instance) end
end))
state.SetHidePlayerNames(config.HidePlayerNames)
state.SetBlackScreen(config.BlackScreen)
local function playerData()
    return GlobalTables.PlayerData or {}
end
local function selectedChallengeTypes()
    local selected = {}
    for key, value in pairs(type(config.ChallengeTypes) == "table" and config.ChallengeTypes or {}) do
        local kind = type(key) == "number" and value or value and key or nil
        if kind then selected[tostring(kind)] = true end
    end
    return selected
end
local function challengeMacroReady(world)
    local selected = type(config.ChallengeMacroByWorld) == "table" and config.ChallengeMacroByWorld[world] or nil
    if type(selected) ~= "string" or selected == "" or selected == "None" then return false end
    local path = selected
    if not string.find(path, "[/\\]") then path = macrosFolder .. "/" .. path end
    if string.sub(path, -5) ~= ".json" then path ..= ".json" end
    return type(isfile) ~= "function" or isfile(path), selected
end
local function challengeRewardText(rewards)
    rewards = type(rewards) == "table" and rewards or {}
    local lines = {}
    local gems, exp = tonumber(rewards.Gems), tonumber(rewards.PlayerExp)
    if gems and gems > 0 then table.insert(lines, "Gems x" .. tostring(gems)) end
    if exp and exp > 0 then table.insert(lines, "EXP x" .. tostring(exp)) end
    for itemType, items in pairs(type(rewards.ItemRewards) == "table" and rewards.ItemRewards or {}) do
        for itemName, item in pairs(type(items) == "table" and items or {}) do
            table.insert(lines, string.format("%s x%s", tostring(itemName), tostring(type(item) == "table" and item.Amount or item or 1)))
        end
    end
    table.sort(lines)
    return #lines > 0 and table.concat(lines, ", ") or "No listed rewards"
end
local function challengeModifierText(modifiers)
    local names = {}
    for key in pairs(type(modifiers) == "table" and modifiers or {}) do
        local info = ModifiersInfo[key]
        table.insert(names, tostring(type(info) == "table" and info.DisplayName or key))
    end
    table.sort(names)
    return #names > 0 and table.concat(names, ", ") or "None"
end
local function refreshChallengeInfo(force)
    if not force and state.ChallengeInfo and os.clock() - (state.LastChallengeScanAt or 0) < 15 then
        return state.ChallengeInfo
    end
    state.LastChallengeScanAt = os.clock()
    local ok, raw = pcall(function() return ChallengeFunction:InvokeServer("GetChallengeInfo") end)
    if not ok or type(raw) ~= "table" then
        state.ChallengeScanError = tostring(raw or "Challenge info unavailable")
        return nil
    end
    local data, compact = playerData(), {}
    for _, kind in ipairs({"Daily", "Normal"}) do
        local nativeType = kind == "Normal" and "Regular" or kind
        local challenge = raw[kind] or raw[nativeType]
        if type(challenge) ~= "table" then
            for key, candidate in pairs(type(raw.Rotation) == "table" and raw.Rotation or {}) do
                if type(candidate) == "table" and (candidate.Type == nativeType or key == nativeType or key == kind) then
                    challenge = candidate
                    break
                end
            end
        end
        local challengeSeed = type(challenge) == "table" and (challenge.ChallengeSeed or challenge.Seed)
        if type(challenge) == "table" and challengeSeed then
            local seed = tonumber(challengeSeed) or challengeSeed
            local completedSeed = kind == "Daily" and data.DailyChallengeIdCompleted or data.ChallengeIdCompleted
            local lossRecord = type(config.ChallengeLosses[kind]) == "table" and config.ChallengeLosses[kind] or nil
            local losses = lossRecord and tostring(lossRecord.Seed) == tostring(seed)
                and math.max(0, math.floor(tonumber(lossRecord.Count) or 0)) or 0
            compact[kind] = {
                Kind = kind,
                NativeType = nativeType,
                Seed = seed,
                World = tostring(challenge.WorldName or challenge.World or "Unknown"),
                Act = tostring(challenge.Act or "1"),
                Difficulty = tostring(challenge.Difficulty or "Hard"),
                Modifiers = challengeModifierText(challenge.Modifiers),
                Rewards = challengeRewardText(challenge.Rewards),
                Completed = tostring(completedSeed) == tostring(seed),
                Attempted = tostring(config.ChallengeAttemptedSeeds[kind]) == tostring(seed),
                Losses = losses,
                Rotation = kind == "Daily" and TimeRotations.DailyChallenges or TimeRotations.NormalChallenges,
            }
        end
    end
    state.ChallengeInfo, state.ChallengeScanError = compact, nil
    state.ChallengeInitialScanComplete = true
    local signature = HttpService:JSONEncode(compact)
    if signature ~= state.ChallengeInfoSignature then
        state.ChallengeInfoSignature = signature
        config.ChallengeLastInfo = compact
        saveConfig()
    end
    return compact
end
local function updateChallengeTimerFromInfo(info, reason)
    local selected = selectedChallengeTypes()
    local now, nextAt, seeds = os.time(), nil, {}
    for _, kind in ipairs({"Daily", "Normal"}) do
        local entry = type(info) == "table" and info[kind] or nil
        if selected[kind] and entry then
            seeds[kind] = entry.Seed
            local rotation = math.max(1, tonumber(entry.Rotation) or (kind == "Daily" and 86400 or 900))
            local rotationAt = now - now % rotation + rotation
            nextAt = not nextAt and rotationAt or math.min(nextAt, rotationAt)
        end
    end
    local payload = {
        NextCheckAt = nextAt or 0,
        Reason = tostring(reason or "Challenge rotation"),
        Seeds = seeds,
    }
    aoWriteChallengeTimer(LocalPlayer.UserId, payload)
    config.ChallengeNextCheckAt = payload.NextCheckAt
    saveConfig()
    state.ChallengeTimer = payload
    return payload
end
local function challengeStatusText()
    local info = state.ChallengeInfo or config.ChallengeLastInfo or {}
    local selected = selectedChallengeTypes()
    local timer = aoReadChallengeTimer(LocalPlayer.UserId) or state.ChallengeTimer
    local nextCheckAt = timer and tonumber(timer.NextCheckAt) or 0
    local lines = {
        config.AutoChallenge and "Auto Challenge enabled (requires Auto Join)" or "Auto Challenge disabled",
        config.AutoChallengeLeave and string.format("Auto Leave timer: %s", nextCheckAt <= 0 and "not scheduled"
            or os.time() >= nextCheckAt and "due now" or tostring(nextCheckAt - os.time()) .. "s")
            or "Auto Leave For Challenge disabled",
    }
    for _, kind in ipairs({"Daily", "Normal"}) do
        local entry = info[kind]
        if entry then
            local macroReady, macroName = challengeMacroReady(entry.World)
            local status = entry.Completed and "COMPLETED" or entry.Attempted and "ATTEMPTED"
                or not macroReady and "NO MACRO"
                or selected[kind] and "PENDING" or "DISABLED"
            table.insert(lines, string.format(
                "%s [%s] - %s Act %s %s\nLosses: %s/3\nMacro: %s\nModifiers: %s\nRewards: %s\nRotates in: %ss",
                kind, status, entry.World, entry.Act, entry.Difficulty, tostring(entry.Losses or 0),
                tostring(macroName or "None"), entry.Modifiers, entry.Rewards,
                tostring((entry.Rotation or 1) - os.time() % (entry.Rotation or 1))
            ))
        else
            table.insert(lines, kind .. ": unavailable")
        end
    end
    if state.ChallengeScanError then table.insert(lines, "Scan error: " .. state.ChallengeScanError) end
    return table.concat(lines, "\n\n")
end
local function autoChallengeTarget()
    state.ChallengeCheckBlocking = false
    if not (config.AutoChallenge and config.AutoJoin) or state.ChallengeSweepResolved then
        aoLog(string.format("[AutoChallengeTarget] early nil: autoChallenge=%s autoJoin=%s sweepResolved=%s",
            tostring(config.AutoChallenge), tostring(config.AutoJoin), tostring(state.ChallengeSweepResolved)))
        return nil
    end
    local info = refreshChallengeInfo(false)
    if not info then
        state.ChallengeCheckBlocking = true
        aoLog("[AutoChallengeTarget] nil info (scan failed)")
        return nil
    end
    local selected = selectedChallengeTypes()
    for _, kind in ipairs({"Daily", "Normal"}) do
        local entry = info[kind]
        local macroReady = entry and challengeMacroReady(entry.World)
        aoLog(string.format("[AutoChallengeTarget] %s: selected=%s entry=%s macroReady=%s completed=%s attempted=%s",
            kind, tostring(selected[kind]), tostring(entry ~= nil), tostring(macroReady),
            tostring(entry and entry.Completed), tostring(entry and entry.Attempted)))
        if selected[kind] and entry and macroReady and not entry.Completed and not entry.Attempted then
            return {
                Owner = "Challenge", ChallengeKind = kind, Type = entry.NativeType, ChallengeSeed = entry.Seed,
                Summary = string.format("%s challenge: %s Act %s | %s", kind, entry.World, entry.Act, entry.Modifiers),
                GameMode = "Challenge", DisplayGameMode = kind .. " Challenge",
                World = entry.World, Act = entry.Act, Difficulty = entry.Difficulty,
            }
        end
    end
    config.ChallengeRuntimeTarget = nil
    state.ChallengeSweepResolved = true
    updateChallengeTimerFromInfo(info, "Lobby challenge sweep completed")
    saveConfig()
    aoLog("[AutoChallengeTarget] sweep done, no joinable challenge")
    return nil
end
state.RefreshChallengeInfo = refreshChallengeInfo
state.GetChallengeTarget = autoChallengeTarget
local function updateRiftTimer(nextAt, reason, closeAt)
    nextAt = math.max(0, math.floor(tonumber(nextAt) or 0))
    closeAt = math.max(0, math.floor(tonumber(closeAt) or 0))
    local payload = aoReadRiftTimer(LocalPlayer.UserId) or {}
    payload.NextCheckAt = nextAt
    payload.RiftSpawnAt = nextAt
    if closeAt > 0 then
        payload.RiftCloseAt = closeAt
    end
    if closeAt > 0 and nextAt == 0 then
        payload.Reason = tostring(reason or "Rift open; closes at " .. closeAt)
    else
        payload.Reason = tostring(reason or "Rift timer updated")
    end
    payload.LastScheduledAt = os.time()
    aoWriteRiftTimer(LocalPlayer.UserId, payload)
    config.RiftNextCheckAt = nextAt
    state.RiftTimer = payload
    saveConfig()
    return payload
end
local function ensureRiftTimer()
    local secondsLeft, isCloseTimer = readRiftTimerFromUI()
    local now = os.time()
    local payload = aoReadRiftTimer(LocalPlayer.UserId) or {}
    if secondsLeft and secondsLeft > 0 then
        if isCloseTimer then
            payload.RiftSpawnAt = 0
            payload.RiftCloseAt = now + secondsLeft
            payload.NextCheckAt = 0
            payload.Reason = "Rift open, closes in " .. secondsLeft .. "s"
        else
            payload.RiftSpawnAt = now + secondsLeft
            payload.RiftCloseAt = 0
            payload.NextCheckAt = payload.RiftSpawnAt
            payload.Reason = "Rift spawns in " .. secondsLeft .. "s"
        end
    else
        local hasPortal = false
        pcall(function()
            local crash = workspace:FindFirstChild("CrashSite")
            hasPortal = crash and crash:FindFirstChild("RiftPart") ~= nil
        end)
        if hasPortal then
            payload.RiftSpawnAt = 0
            if not payload.RiftCloseAt or payload.RiftCloseAt <= now then
                payload.RiftCloseAt = 0
            end
            payload.NextCheckAt = 0
            payload.Reason = "Rift open (portal visible)"
        else
            if payload.RiftSpawnAt and payload.RiftSpawnAt > now then
                payload.NextCheckAt = payload.RiftSpawnAt
                payload.RiftCloseAt = 0
                payload.Reason = payload.Reason or "Rift spawn pending"
            else
                if payload.RiftCloseAt and payload.RiftCloseAt > now then
                    payload.RiftSpawnAt = 0
                    payload.NextCheckAt = 0
                else
                    payload.RiftSpawnAt = 0
                    payload.RiftCloseAt = 0
                    payload.NextCheckAt = 0
                    payload.Reason = "Rift spawn unknown"
                end
            end
        end
    end
    payload.LastScheduledAt = now
    aoWriteRiftTimer(LocalPlayer.UserId, payload)
    config.RiftNextCheckAt = payload.NextCheckAt
    state.RiftTimer = payload
    saveConfig()
    return payload
end
local function scheduleNextRift(reason)
    local now = os.time()
    local secondsLeft, isClose = readRiftTimerFromUI()
    local payload = aoReadRiftTimer(LocalPlayer.UserId) or {}
    if secondsLeft and secondsLeft > 0 then
        if isClose then
            payload.RiftSpawnAt = 0
            payload.RiftCloseAt = now + secondsLeft
            payload.NextCheckAt = 0
            payload.Reason = reason or ("Rift open, closes in " .. secondsLeft .. "s (from UI)")
        else
            payload.RiftSpawnAt = now + secondsLeft
            payload.RiftCloseAt = 0
            payload.NextCheckAt = payload.RiftSpawnAt
            payload.Reason = reason or ("Rift spawns in " .. secondsLeft .. "s (from UI)")
        end
    else
        payload.RiftSpawnAt = now + AO_RIFT_INTERVAL
        payload.RiftCloseAt = 0
        payload.NextCheckAt = payload.RiftSpawnAt
        payload.Reason = reason or "Rift prompt fired; next check scheduled"
    end
    payload.LastRiftAttemptAt = now
    payload.LastScheduledAt = now
    aoWriteRiftTimer(LocalPlayer.UserId, payload)
    config.RiftNextCheckAt = payload.NextCheckAt
    state.RiftTimer = payload
    saveConfig()
    return payload
end
local function autoRiftTarget()
    state.RiftCheckBlocking = false
    aoLog(string.format("[AutoRiftTarget] called: autoRift=%s autoJoin=%s sweepResolved=%s",
        tostring(config.AutoRift), tostring(config.AutoJoin), tostring(state.RiftSweepResolved)))
    if not config.AutoRift or state.RiftSweepResolved then
        aoLog(string.format("[AutoRiftTarget] early nil: autoRift=%s sweepResolved=%s",
            tostring(config.AutoRift), tostring(state.RiftSweepResolved)))
        return nil
    end
    local crash = workspace:FindFirstChild("CrashSite")
    local rift = crash and crash:FindFirstChild("RiftPart")
    local rotationOk, rotationOpen = pcall(function()
        local _, elapsed = GeneralModule.CalculateTimeRotation(TimeRotations.Rift)
        return TimeRotations.Rift - elapsed < TimeRotations.RiftDuration
    end)
    rotationOpen = rotationOk and rotationOpen == true
    aoLog(string.format("[AutoRiftTarget] CrashSite=%s RiftPart=%s",
        tostring(crash ~= nil), tostring(rift ~= nil)))
    if not rift and not rotationOpen then
        local timer = ensureRiftTimer()
        local nextCheckAt = tonumber(timer.NextCheckAt) or 0
        local closeAt = tonumber(timer.RiftCloseAt) or 0
        local reasonLower = string.lower(tostring(timer.Reason or ""))
        local isUnknown = (nextCheckAt == 0 and (closeAt == 0 or closeAt <= os.time())) and string.find(reasonLower, "unknown", 1, true) ~= nil
        if isUnknown then
            state.RiftCheckBlocking = true
            aoLog("[AutoRiftTarget] blocking: Rift timer unknown, need timer before any join")
        elseif nextCheckAt > os.time() then
            aoLog("[AutoRiftTarget] waiting spawn " .. tostring(nextCheckAt - os.time()) .. "s (no portal) - not blocking Challenge")
        else
            aoLog("[AutoRiftTarget] nil: RiftPart not found and no due timer")
        end
        return nil
    end
    local timer = ensureRiftTimer()
    local nextCheckAt = tonumber(timer.NextCheckAt) or 0
    local closeAt = tonumber(timer.RiftCloseAt) or 0
    aoLog(string.format("[AutoRiftTarget] timer NextCheckAt=%s CloseAt=%s configRiftNextCheckAt=%s",
        tostring(nextCheckAt), tostring(closeAt), tostring(config.RiftNextCheckAt)))
    if closeAt > 0 and os.time() >= closeAt and not rotationOpen then
        state.RiftCheckBlocking = true
        aoLog("[AutoRiftTarget] rift close expired, waiting next spawn")
        return nil
    end
    if nextCheckAt > os.time() and not rotationOpen then
        state.RiftCheckBlocking = true
        aoLog("[AutoRiftTarget] waiting " .. tostring(nextCheckAt - os.time()) .. "s")
        return nil
    end
    local selectedMacro = config.RiftMacro
    aoLog("[AutoRiftTarget] returning due Rift target")
    return {
        Owner = "Rift",
        Summary = "Shibuya Rift",
        GameMode = "ShibuyaRift",
        DisplayGameMode = "Rift",
        World = "ShibuyaTrainStation",
        Act = "1",
        Difficulty = "Hard",
        RiftMacro = selectedMacro,
    }
end
local summonTargetDropdown
local bannerLabelToKey, bannerKeyToLabel, knownBannerLabels = {}, {}, {}
local function refreshStandardBanner(force)
    local now = os.clock()
    if not force and state.StandardBanner and now - (state.LastBannerScanAt or 0) < 30 then
        return state.StandardBanner
    end
    local ok, banners = pcall(function() return SummonFunction:InvokeServer("GetBanner") end)
    local standard = ok and type(banners) == "table" and banners.Standard or nil
    if type(standard) ~= "table" then
        standard = type(BannerModule.Banners) == "table" and BannerModule.Banners.Standard or nil
    end
    state.LastBannerScanAt = now
    if type(standard) ~= "table" then
        state.StandardBanner, state.StandardMythics = nil, {}
        state.StandardBannerError = "Standard banner unavailable"
        return nil
    end
    local mythicPool = type(standard.BannerTowersChances) == "table"
        and standard.BannerTowersChances.Mythic or nil
    local mythicChance = type(standard.SummonChances) == "table"
        and tonumber(standard.SummonChances.Mythic) or 0
    local entries = {}
    for key, weight in pairs(type(mythicPool) == "table" and mythicPool or {}) do
        key = tostring(key)
        weight = tonumber(weight) or 0
        local info = TowerInfo[key] or {}
        local displayName = tostring(info.DisplayName or info.Name or key)
        local label = string.format("%s [%s]", displayName, key)
        if aoIsBaseMythic(TowerInfo, key) then
            bannerLabelToKey[label], bannerKeyToLabel[key], knownBannerLabels[label] = key, label, true
        end
        table.insert(entries, {
            Key = key,
            Label = label,
            DisplayName = displayName,
            Weight = weight,
            ConditionalPercent = weight * 100,
            PerSummonPercent = mythicChance * weight * 100,
        })
    end
    local minimumWeight = math.huge
    for _, entry in ipairs(entries) do minimumWeight = math.min(minimumWeight, entry.Weight) end
    for _, entry in ipairs(entries) do
        entry.IsRateUp = #entries == 1 or entry.Weight > minimumWeight + 1e-9
    end
    table.sort(entries, function(a, b) return a.Label < b.Label end)
    local labels = {}
    for label in pairs(knownBannerLabels) do table.insert(labels, label) end
    table.sort(labels)
    state.StandardBanner = standard
    state.StandardMythics = entries
    state.StandardBannerLabels = labels
    state.AutoSummonTargetKeys = {}
    for key in pairs(bannerKeyToLabel) do state.AutoSummonTargetKeys[key] = true end
    state.StandardBannerError = nil
    if summonTargetDropdown then pcall(function() summonTargetDropdown:SetValues(labels) end) end
    return standard
end
local function bannerStatusText()
    local entries = state.StandardMythics or {}
    if #entries == 0 then return state.StandardBannerError or "No Mythic entries found in Standard banner" end
    local lines = {"Current Standard RATE-UP Mythics (conditional | actual per summon):"}
    for _, entry in ipairs(entries) do
        if entry.IsRateUp then
            table.insert(lines, string.format("%s: %.6g%% | %.6g%%",
                entry.Label, entry.ConditionalPercent, entry.PerSummonPercent))
        end
    end
    if #lines == 1 then table.insert(lines, "No Mythic RATE-UP detected") end
    return table.concat(lines, "\n")
end
state.RefreshStandardBanner = refreshStandardBanner
state.GetStandardBannerState = function()
    return state.StandardBanner, state.StandardMythics
end
refreshStandardBanner(true)
state.NextBannerScanAt = os.clock() + 30
local function currentPlayerLevel()
    local ok, level = pcall(CalculateStuff.GetPlayerLevelFromExp, playerData().Exp or 0)
    return ok and tonumber(level) or 1
end
local knownUnitIds = {}
for uuid in pairs((GlobalTables.Inventory or {}).Towers or {}) do
    knownUnitIds[tostring(uuid)] = true
end
local function scanNewUnitWebhooks()
    if not config.WebhookUnitEnabled or tostring(config.WebhookUrl or "") == "" then return end
    if os.clock() < (state.NextUnitWebhookScanAt or 0) then return end
    state.NextUnitWebhookScanAt = os.clock() + 5
    local newUnits = {}
    for uuid, unit in pairs((GlobalTables.Inventory or {}).Towers or {}) do
        uuid = tostring(uuid)
        if not knownUnitIds[uuid] then
            knownUnitIds[uuid] = true
            table.insert(newUnits, unit)
        end
    end
    if #newUnits == 0 then return end
    local icon = gameIconUrl()
    local embeds = {}
    local rarityColors = {Rare = 0x62A8FF, Epic = 0xB56CFF, Legendary = 0xFFD45A, Mythic = 0xFF5E90, Secret = 0xF5F5F5}
    for index, unit in ipairs(newUnits) do
        if index > 10 then break end
        local name = tostring(unit.Name or "Unknown")
        local info = TowerInfo[name] or {}
        local rarity = tostring(info.Rarity or "Unknown")
        local ok, unitLevel = pcall(CalculateStuff.GetTowerLevelFromExp, unit.Exp or 0, info.Rarity)
        local unitEmoji = aoItemEmoji(name)
        local embed = {
            author = {name = "Anime Origins", icon_url = icon},
            title = string.format("%sNew Unit: %s", unitEmoji and (unitEmoji .. " ") or "", tostring(info.DisplayName or info.Name or name)),
            color = rarityColors[rarity] or 0x8A7DFF,
            fields = {
                {name = "Rarity", value = rarity, inline = true},
                {name = "Unit Level", value = tostring(ok and unitLevel or 1), inline = true},
                {name = "Shiny", value = unit.Shiny and "Yes" or "No", inline = true},
                {name = "Player", value = string.format("||%s (Lv.%d)||", LocalPlayer.Name, currentPlayerLevel()), inline = false},
            },
            timestamp = DateTime.now():ToIsoDate(),
            footer = {text = "Anime Origins Ultimate"},
        }
        if type(info.EmbedImage) == "string" and string.match(info.EmbedImage, "^https?://") then
            embed.thumbnail = {url = info.EmbedImage}
        end
        table.insert(embeds, embed)
    end
    task.spawn(function()
        local ok, message = sendDiscordWebhook(config.WebhookUrl, {
            username = "Anime Origins Auto",
            avatar_url = icon,
            embeds = embeds,
        })
        warn("[AO Webhook] new unit " .. (ok and "sent" or "failed") .. ": " .. tostring(message))
    end)
end
local function questSnapshot()
    local snapshot = {Entries = {}, Supported = {}, Unsupported = {}, Claimable = {}}
    local data = playerData()
    for _, category in ipairs({"Daily", "Weekly"}) do
        for slot, quest in ipairs(((data.Quests or {})[category]) or {}) do
            local definition = (QuestInfo.QuestPools[category] or {})[quest.QuestIndex]
            if definition and not quest.Claimed then
                local rawProgress = QuestInfo.CalculateQuestProgress(data, quest, definition)
                local progress = tonumber(rawProgress) or 0
                local amount = tonumber(definition.Amount) or 0
                local entry = {
                    Category = category, Slot = slot, Quest = quest, Definition = definition,
                    Progress = progress, Amount = amount,
                    Summary = string.format("%s %d/%d", tostring(definition.DisplayName or definition.QuestType), progress, amount),
                }
                table.insert(snapshot.Entries, entry)
                if QuestInfo.CanClaimQuest(data, quest, definition) == 0 then
                    table.insert(snapshot.Claimable, entry)
                elseif definition.GameMode == "Challenge" then
                    entry.UnsupportedReason = "Challenge rotation unsupported"
                    table.insert(snapshot.Unsupported, entry)
                elseif definition.GameMode == "Infinite" and definition.QuestType == "Waves" then
                    entry.SupportKind = "Infinite"
                    table.insert(snapshot.Supported, entry)
                elseif definition.GameMode == nil and (definition.QuestType == "Kill"
                    or definition.QuestType == "Waves" or definition.QuestType == "Games") then
                    entry.SupportKind = "Generic"
                    table.insert(snapshot.Supported, entry)
                elseif definition.QuestType == "Summon" then
                    entry.SupportKind = "Summon"
                    entry.UnsupportedReason = config.AutoQuestSummon and nil or "Summon spending disabled"
                    if config.AutoQuestSummon then table.insert(snapshot.Supported, entry) else table.insert(snapshot.Unsupported, entry) end
                else
                    entry.UnsupportedReason = "Unsupported quest type"
                    table.insert(snapshot.Unsupported, entry)
                end
            end
        end
    end
    return snapshot
end
local function playableQuestMap(infinite)
    local progress = playerData().StoryProgress or {}
    local act = infinite and "Infinite" or tostring(config.QuestAct)
    if table.find(GameInfo.Ordering or {}, config.QuestWorld)
        and CalculateStuff.CanPlayAct(progress, config.QuestWorld, act, "Story") then
        return config.QuestWorld, act
    end
    for _, world in ipairs(GameInfo.Ordering or {}) do
        if CalculateStuff.CanPlayAct(progress, world, act, "Story") then
            return world, act
        end
    end
end
local function questMapTarget(snapshot)
    snapshot = snapshot or questSnapshot()
    local primary
    for _, entry in ipairs(snapshot.Supported) do
        if entry.SupportKind == "Infinite" then primary = entry; break end
    end
    if not primary then
        for _, entry in ipairs(snapshot.Supported) do
            if entry.SupportKind == "Generic" then primary = entry; break end
        end
    end
    if not primary then return nil end
    local infinite = primary.SupportKind == "Infinite"
    local world, act = playableQuestMap(infinite)
    if not world and infinite then
        for _, entry in ipairs(snapshot.Supported) do
            if entry.SupportKind == "Generic" then
                primary, infinite = entry, false
                world, act = playableQuestMap(false)
                break
            end
        end
    end
    if not world then return nil end
    local refs, objectives, maxWave = {}, {}, 0
    for _, kind in ipairs(infinite and {"Infinite", "Generic"} or {"Generic"}) do
        for _, entry in ipairs(snapshot.Supported) do
            if entry.SupportKind == kind then
                table.insert(refs, {
                    Category = entry.Category, Slot = entry.Slot, QuestIndex = entry.Quest.QuestIndex,
                    Progress = entry.Progress, Amount = entry.Amount,
                })
                table.insert(objectives, entry.Summary)
                if kind == "Infinite" then maxWave = math.max(maxWave, entry.Amount) end
            end
        end
    end
    return {
        Owner = "Quest", QuestKind = infinite and "Infinite" or "Generic", Refs = refs, Objectives = objectives,
        Summary = table.concat(objectives, "; "), GameMode = "Story", DisplayGameMode = infinite and "Infinite" or "Story",
        World = world, Act = act,
        Difficulty = infinite and "Hard" or config.QuestDifficulty,
        TargetWave = infinite and maxWave or nil,
        RemainingWaves = infinite and math.max(0, maxWave - primary.Progress) or nil,
    }
end
local function autoQuestTarget()
    if not config.AutoQuest then return nil end
    local snapshot = questSnapshot()
    state.QuestSnapshot = snapshot
    state.QuestTarget = questMapTarget(snapshot)
    return state.QuestTarget
end
state.GetQuestSnapshot = questSnapshot
state.GetQuestTarget = function()
    local snapshot = questSnapshot()
    return questMapTarget(snapshot), snapshot
end
local function nextStoryTarget()
    local progress = playerData().StoryProgress or {}
    for _, world in ipairs(GameInfo.Ordering or {}) do
        local info = GameInfo[world]
        for act = 1, (info and info.ActAmount or 0) do
            local actName = tostring(act)
            local actProgress = progress[world] and progress[world][actName]
            local cleared = actProgress and (tonumber(actProgress.Clears) or 0) > 0
            if not cleared and CalculateStuff.CanPlayAct(progress, world, actName, "Story") then
                return {
                    GameMode = "Story",
                    World = world,
                    Act = actName,
                    Difficulty = config.AutoStoryDifficulty,
                }
            end
        end
    end
end
local function artifactMapInfo(name)
    local info = type(ItemInfo.Artifacts) == "table" and ItemInfo.Artifacts[name]
    return info and info.MapSelectInfo or nil
end
local function currentJoinTarget()
    if not config.AutoJoin then return nil end
    if config.AutoRift and state.RiftRuntimeTarget then return state.RiftRuntimeTarget end
    if config.AutoChallenge then
        local challengeTarget = autoChallengeTarget()
        if challengeTarget then
            aoLog("[JoinTarget] challenge selected: " .. tostring(challengeTarget.Summary or challengeTarget.World))
            return challengeTarget
        end
        aoLog(string.format("[JoinTarget] challenge nil: checkBlocking=%s sweepResolved=%s autoJoin=%s autoChallenge=%s",
            tostring(state.ChallengeCheckBlocking), tostring(state.ChallengeSweepResolved),
            tostring(config.AutoJoin), tostring(config.AutoChallenge)))
        if state.ChallengeCheckBlocking or state.ChallengeSweepResolved == false then return nil end
    end
    local questTarget = autoQuestTarget()
    if questTarget then
        aoLog("[JoinTarget] quest selected: " .. tostring(questTarget.Summary or questTarget.World))
        return questTarget
    end
    if config.AutoStory then
        aoLog("[JoinTarget] story selected")
        return nextStoryTarget()
    end
    if config.GameMode == "Trial" then
        local pleiadesTrial = config.World == "PleiadesGrass"
        local itemName = pleiadesTrial and "ReinhardTrialKey" or "MadaraKey"
        local keyAmount = tonumber((((GlobalTables.Inventory or {}).Materials) or {})[itemName]) or 0
        if keyAmount <= 0 then
            aoLog("[JoinTarget] Trial waiting: Materials/" .. itemName .. " is unavailable")
            return nil
        end
        if pleiadesTrial then
            return {
                GameMode = "ReZero",
                DisplayGameMode = "Trial",
                World = "PleiadesGrass",
                Act = "1",
                DisplayAct = "Trial",
                Difficulty = "None",
                Owner = "Trial",
                ItemType = "Materials",
                ItemName = itemName,
                SelectionKind = "ReZero",
                Summary = "Sword Saint's Garden (Scorpion's Key)",
            }
        end
        return {
            GameMode = "Story",
            DisplayGameMode = "Trial",
            World = "SandVillage",
            Act = "MadaraStage",
            Difficulty = "None",
            Owner = "Trial",
            ItemType = "Materials",
            ItemName = "MadaraKey",
            Summary = "Ghost's Trial II (permanent key)",
        }
    end
    if config.GameMode == "Artifact" then
        local selectedArtifact = tostring(config.ArtifactName or "")
        local mapInfo = artifactMapInfo(selectedArtifact)
        if not mapInfo then
            aoLog("[JoinTarget] artifact nil: no saved Artifact selection")
            return nil
        end
        local artifactAmount = tonumber((((GlobalTables.Inventory or {}).Artifacts) or {})[selectedArtifact]) or 0
        if artifactAmount <= 0 then
            aoLog("[JoinTarget] artifact waiting: selected item unavailable: " .. selectedArtifact)
            return nil
        end
        return {
            GameMode = "Story",
            DisplayGameMode = "Artifact",
            World = mapInfo.WorldName,
            Act = mapInfo.Act,
            Difficulty = mapInfo.Difficulty,
            Owner = "Artifact",
            ArtifactName = selectedArtifact,
            Summary = "Artifact " .. selectedArtifact,
        }
    end
    local selectedMode = tostring(config.GameMode)
    local selectedDifficulty = config.Difficulty
    if selectedMode == "Infinite" or selectedMode == "Raid" or selectedMode == "Legend" then
        selectedDifficulty = "Hard"
    elseif selectedMode == "ReZero" or selectedMode == "WorldBoss" then
        selectedDifficulty = "None"
    end
    return {
        GameMode = (config.GameMode == "Infinite" or config.GameMode == "Legend") and "Story" or config.GameMode,
        DisplayGameMode = config.GameMode,
        World = config.World,
        Act = config.GameMode == "Infinite" and "Infinite" or config.Act,
        Difficulty = selectedDifficulty,
    }
end
state.Runtime = {
    Phase = "Initializing",
    JoinStatus = "Idle",
    PodStatus = "Outside pod",
    LastAction = "Script loaded",
    LastError = "None",
    RetryCount = 0,
}
local statusParagraphs = {}
local function selectedMapText()
    local target = state.ActiveJoinTarget or currentJoinTarget()
    if not target then
        return not config.AutoJoin and "Auto Join disabled"
            or config.AutoQuest and "No supported Auto Quest map target"
            or config.AutoStory and "Auto Story completed" or "No map selected"
    end
    local parts = {target.DisplayGameMode or target.GameMode, target.World, "Act " .. tostring(target.DisplayAct or target.Act)}
    if target.Difficulty and target.Difficulty ~= "None" then table.insert(parts, target.Difficulty) end
    local text = table.concat(parts, " > ")
    return (target.Owner == "Quest" or target.Owner == "Challenge") and (text .. "\n" .. tostring(target.Summary)) or text
end
local function riftStatusText()
    local timer = aoReadRiftTimer(LocalPlayer.UserId) or state.RiftTimer
    local nextCheckAt = timer and tonumber(timer.NextCheckAt) or 0
    local closeAt = timer and tonumber(timer.RiftCloseAt) or 0
    local lines = {
        config.AutoRift and "Auto Rift enabled (requires Auto Join)" or "Auto Rift disabled",
        config.AutoRiftLeave and string.format("Auto Leave timer: %s", nextCheckAt <= 0 and "not scheduled"
            or os.time() >= nextCheckAt and "due now" or tostring(nextCheckAt - os.time()) .. "s")
            or "Auto Leave For Rift disabled",
        config.RiftMacro ~= "" and ("Macro: " .. config.RiftMacro) or "Macro: None selected",
    }
    local riftSpawnTimer = timer and tonumber(timer.RiftSpawnAt) or 0
    if closeAt and closeAt > os.time() then
        local tl = closeAt - os.time()
        table.insert(lines, string.format("Rift OPEN: closes in %ds", tl))
        table.insert(lines, string.format("Rift CloseAt: %d (in %ds)", closeAt, tl))
    elseif riftSpawnTimer > 0 then
        local timeLeft = riftSpawnTimer - os.time()
        if timeLeft > 0 then
            table.insert(lines, string.format("Next rift spawn in: %ds", timeLeft))
        else
            table.insert(lines, "Next rift spawn: now")
        end
        if closeAt and closeAt > 0 then
            table.insert(lines, string.format("Rift CloseAt: %d", closeAt))
        end
    else
        if closeAt and closeAt > 0 then
            table.insert(lines, string.format("Rift CloseAt: %d", closeAt))
        else
            table.insert(lines, "Next rift spawn: unknown")
        end
        if riftSpawnTimer == 0 and (not closeAt or closeAt == 0) then
            if nextCheckAt > os.time() then
                table.insert(lines, string.format("NextCheckAt in %ds", nextCheckAt - os.time()))
            end
        end
    end
    table.insert(lines, string.format("SpawnAt=%s CloseAt=%s NextCheckAt=%s", tostring(riftSpawnTimer), tostring(closeAt), tostring(nextCheckAt)))
    return table.concat(lines, "\n\n")
end
local function questStatusText()
    local snapshot = state.QuestSnapshot or questSnapshot()
    local target = state.QuestTarget or questMapTarget(snapshot)
    local lines = {not config.AutoQuest and "Auto Quest disabled"
        or target and ("Target: " .. target.Summary)
        or "No playable supported map objective; lower-priority automation may run."}
    for _, entry in ipairs(snapshot.Entries) do
        local suffix = "supported"
        if entry.Definition.GameMode == "Challenge" then suffix = "handled by Auto Challenge"
        elseif entry.Definition.QuestType == "Summon" then suffix = config.AutoQuestSummon and "summon opt-in enabled" or "summon spending disabled"
        elseif entry.SupportKind == "Infinite" and not playableQuestMap(true) then suffix = "supported, but Infinite is locked" end
        table.insert(lines, string.format("%s [%s]", entry.Summary, suffix))
    end
    return table.concat(lines, "\n")
end
local function setParagraph(paragraph, text)
    if paragraph then
        pcall(function()
            paragraph:SetDesc(text)
        end)
    end
end
local function refreshStatusPanel()
    local runtime = state.Runtime
    setParagraph(statusParagraphs.Lobby, string.format(
        "Place: Lobby\nPlaceId: %s\nJobId: %s",
        tostring(game.PlaceId),
        game.JobId ~= "" and game.JobId or "none"
    ))
    setParagraph(statusParagraphs.Map, selectedMapText())
    setParagraph(statusParagraphs.Story, config.AutoStory and selectedMapText() or "Auto Story disabled")
    setParagraph(statusParagraphs.Challenge, challengeStatusText())
    setParagraph(statusParagraphs.Rift, riftStatusText())
    setParagraph(statusParagraphs.Quest, questStatusText())
    setParagraph(statusParagraphs.Summon, config.AutoSummon
        and (state.AutoSummonStatus or "Enabled; waiting for safe Standard summon check")
        or "Standalone Auto Summon disabled")
    setParagraph(statusParagraphs.Banner, bannerStatusText())
    setParagraph(statusParagraphs.Join, string.format(
        "Phase: %s\nJoin: %s\nPod: %s\nRetries: %d",
        runtime.Phase,
        runtime.JoinStatus,
        runtime.PodStatus,
        runtime.RetryCount
    ))
    setParagraph(statusParagraphs.Action, string.format(
        "Last action: %s\nLast remote: %s\nLast error: %s",
        runtime.LastAction,
        runtime.LastRemote or "None",
        runtime.LastError
    ))
end
local function updateRuntime(values)
    for key, value in pairs(values) do
        state.Runtime[key] = value
    end
    refreshStatusPanel()
end
local function selectionToSet(values)
    local selected = {}
    for key, value in pairs(type(values) == "table" and values or {}) do
        local item = type(key) == "number" and value or value and key or nil
        if item then
            selected[tostring(item)] = true
        end
    end
    return selected
end
local function selectionToList(values)
    local list = {}
    for value in pairs(selectionToSet(values)) do
        table.insert(list, value)
    end
    table.sort(list)
    return list
end
table.insert(state.Connections, LocalPlayer.Idled:Connect(function()
    if not state.Running or not config.AntiAFK then
        return
    end
    pcall(function()
        local virtualUser = game:GetService("VirtualUser")
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)
end))
local function canUseLobby()
    return game.PlaceId == require(ReplicatedStorage.PlaceIDs).LobbyPlace
end
local function currentBattlepassCanClaim(data)
    local season = BattlepassInfo.CurrentBattlepass
    local pass = data.Battlepasses and data.Battlepasses[season]
    if not pass then
        return false
    end
    local level = BattlepassInfo.GetBattlepassLevelFromExp(season, pass.Exp or 0)
    return level > (tonumber(pass.Claimed) or 0)
        or (pass.Premium and level > (tonumber(pass.PremiumClaimed) or 0))
end
local function claimDaily(data)
    local rewards = data.DailyRewards
    if not rewards then
        return
    end
    local now = os.time()
    local cooldown = TimeRotations.DailyReward
    if now >= (rewards.LastClaimTime or 0) + cooldown then
        RemoteEvent:FireServer("ClaimDailyReward", "Normal")
    end
    if LocalPlayer.MembershipType == Enum.MembershipType.Premium
        and now >= (rewards.UpgradedLastClaimTime or rewards.LastClaimTime or 0) + cooldown then
        RemoteEvent:FireServer("ClaimDailyReward", "Upgraded")
    end
end
local function claimPlaytime(data)
    local rewards = data.PlayTimeRewards
    if not rewards or type(rewards.Claimed) ~= "table" then
        return
    end
    local rotation = GeneralModule.CalculateTimeRotation(TimeRotations.PlayTimeRewards)
    if rotation ~= rewards.Seed then
        return
    end
    local playtime = (rewards.PlayTime or 0) + (tick() - state.PlaytimeStartedAt)
    local requirements = {300, 900, 1800, 3600, 7200, 10800}
    for index, required in ipairs(requirements) do
        if playtime >= required and not table.find(rewards.Claimed, index) then
            PlayTimeRewardsRemote:FireServer("ClaimPlayTimeReward", index)
            task.wait(0.15)
        end
    end
end
local function claimLevelMilestone(data)
    local level = CalculateStuff.GetPlayerLevelFromExp(data.Exp or 0)
    local milestone = CalculateStuff.CurrentLevelMilestone(data)
    if milestone and level >= milestone and not table.find(data.LevelMilestones or {}, milestone) then
        RemoteEvent:FireServer("ClaimLevelMilestone")
    end
end
local function claimTowerIndex(data)
    local level = CalculateStuff.GetPlayerLevelFromExp(data.Exp or 0)
    if level < CalculateStuff.RequiredTowerIndexLevel then
        return
    end
    local index = data.TowerIndex or {}
    local claimable = {}
    for towerName in pairs(TowerInfo) do
        if index[towerName] == 0 then
            table.insert(claimable, towerName)
        end
    end
    if #claimable > 0 then
        InventoryRemote:FireServer("ClaimIndexReward", claimable)
    end
    local claimedMilestones = data.TowerIndexMilestones or {}
    local milestones = {}
    for _, rarity in ipairs(CalculateStuff.TowerRarities) do
        local requirements = CalculateStuff.IndexCollectionMilestone[rarity]
        if requirements then
            local discovered = CalculateStuff.CountDiscoveredTowers(index, rarity) or 0
            for amount in pairs(requirements) do
                if not claimedMilestones[rarity .. "." .. amount] and discovered >= amount then
                    table.insert(milestones, {Rarity = rarity, Count = amount})
                end
            end
        end
    end
    if #milestones > 0 then
        InventoryRemote:FireServer("ClaimIndexMilestoneReward", milestones)
    end
end
local function claimGroupReward(data)
    if data.ClaimedGroupReward then
        return
    end
    local groupId = require(ReplicatedStorage.PlaceIDs).GroupId
    local ok, isMember = pcall(function()
        return LocalPlayer:IsInGroup(groupId)
    end)
    if ok and isMember then
        RemoteEvent:FireServer("ClaimGroupReward")
    end
end
local function canClaimInfinityRank()
    local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local frame = gui and gui:FindFirstChild("MainUI")
    frame = frame and frame:FindFirstChild("Misc")
    frame = frame and frame:FindFirstChild("InfinityCastleFrame")
    local claim = frame and frame:FindFirstChild("PreviousRankings", true)
    claim = claim and claim:FindFirstChild("Claim", true)
    return claim and claim:IsA("GuiButton") and claim.Active and claim.Visible
end
local shopRotations = {}
local redeemedCodes = {}
state.BuildShopCatalogs = function()
    local catalogs = {
        {Key = "GoldShop", Title = "Gold Shop", ShopType = "GoldShop", RotationAction = "GetCurrentGoldShopRotation"},
        {Key = "CustomizationShop", Title = "Customization Shop", ShopType = "CustomizationShop", RotationAction = "GetCurrentCustomizationShopRotation"},
    }
    for _, world in ipairs(GameInfo.RaidOrdering or {}) do
        local gameInfo = GameInfo[world]
        if gameInfo and gameInfo.RaidShopInfo then
            table.insert(catalogs, {Key = "RaidShop|" .. world, Title = "Raid - " .. tostring(gameInfo.DisplayName or world), ShopType = "RaidShop", World = world, Info = gameInfo.RaidShopInfo})
        end
    end
    for _, world in ipairs(GameInfo.RiftOrdering or {}) do
        local gameInfo = GameInfo[world]
        if gameInfo and gameInfo.RiftShopInfo then
            table.insert(catalogs, {Key = "RiftShop|" .. world, Title = "Rift - " .. tostring(gameInfo.DisplayName or world), ShopType = "RiftShop", World = world, Info = gameInfo.RiftShopInfo})
        end
    end
    local igris = GameInfo.IgrisThroneRoom
    if igris and igris.BossFightShopInfo then
        table.insert(catalogs, {Key = "IgrisShop", Title = "World Boss - " .. tostring(igris.DisplayName or "Igris"), ShopType = "IgrisShop", Info = igris.BossFightShopInfo})
    end
    local reZero = GameInfo.PleiadesSand
    if reZero and reZero.ShopInfo then
        table.insert(catalogs, {Key = "ReZeroShop", Title = tostring(reZero.ShopInfo.ShopDisplayName or "Shali's Stash"), ShopType = "ReZeroShop", Info = reZero.ShopInfo})
    end
    return catalogs
end
state.ShopCatalogs = state.BuildShopCatalogs()
local function runAutoCraft()
    if not config.AutoCraft then
        return false
    end
    local selected = selectionToSet(config.CraftItems)
    for id in pairs(selected) do
        local itemType, itemName = string.match(id, "^([^|]+)|(.+)$")
        if itemType and itemName and CalculateStuff.CanCraft(playerData(), itemType, itemName, 1) then
            updateRuntime({Phase = "Lobby preparation", LastAction = "Crafting " .. itemName})
            CraftingRemote:FireServer("CraftItem", itemType, itemName, 1)
            return true
        end
    end
    return false
end
local function refreshShopInfo(catalog)
    if catalog.Info then
        local seed = GeneralModule.CalculateTimeRotation(catalog.Info.ResetTime or catalog.Info.Interval)
        return catalog.Info, seed
    end
    local cached = shopRotations[catalog.Key]
    if cached and os.clock() - cached.UpdatedAt < 60 then return cached.Info, cached.Seed end
    local ok, items, seed = pcall(function()
        return ShopFunction:InvokeServer(catalog.RotationAction)
    end)
    if not ok or type(items) ~= "table" then return nil end
    local info = {Currency = {ItemType = "Currency", ItemName = "Gold"}, ShopItems = items, CurrentSeed = seed}
    shopRotations[catalog.Key] = {Info = info, Seed = seed, UpdatedAt = os.clock()}
    return info, seed
end
local function runAutoShops()
    local inventory = GlobalTables.Inventory or {}
    local shops = playerData().Shops or {}
    for _, catalog in ipairs(state.ShopCatalogs) do
        if config.AutoShops[catalog.Key] then
            local selected = selectionToSet(config.ShopItems[catalog.Key])
            local shopInfo, seed = refreshShopInfo(catalog)
            if shopInfo and type(shopInfo.ShopItems) == "table" then
                local currency = shopInfo.Currency or {}
                local balance = inventory[currency.ItemType] and tonumber(inventory[currency.ItemType][currency.ItemName]) or 0
                local shopState = shops[catalog.ShopType] or {}
                if catalog.World then shopState = shopState[catalog.World] or {} end
                for index, item in pairs(shopInfo.ShopItems) do
                    local itemKey = tostring(item.ItemType) .. "|" .. tostring(item.ItemName)
                    if selected[itemKey] or selected[item.ItemName] then
                        local bought = shopState.Seed == seed and shopState.BoughtItems
                            and tonumber(shopState.BoughtItems[tostring(index)] or shopState.BoughtItems[index]) or 0
                        local stock = item.Stock and math.max(0, item.Stock - bought) or math.huge
                        local price = tonumber(item.Price) or 0
                        local amount = price > 0 and math.min(stock, math.floor(balance / price)) or 0
                        local itemInfo = ItemInfo[item.ItemType] and ItemInfo[item.ItemType][item.ItemName]
                        if itemInfo and itemInfo.MaxAmount then
                            local owned = inventory[item.ItemType] and tonumber(inventory[item.ItemType][item.ItemName]) or 0
                            amount = math.min(amount, math.max(0, itemInfo.MaxAmount - owned))
                        end
                        if amount > 0 then
                            updateRuntime({Phase = "Lobby preparation", LastAction = "Buying " .. catalog.Title .. ": " .. item.ItemName .. " x" .. amount})
                            if catalog.World then
                                ShopRemote:FireServer("BuyShopItem", catalog.ShopType, catalog.World, index, amount)
                            else
                                ShopRemote:FireServer("BuyShopItem", catalog.ShopType, index, amount)
                            end
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
local function runAutoCodes()
    if not config.AutoRedeemCodes then
        return false
    end
    for rawCode in string.gmatch(config.Codes, "[^,\n]+") do
        local code = string.gsub(rawCode, "%s+", "")
        if code ~= "" and not redeemedCodes[code] then
            redeemedCodes[code] = true
            updateRuntime({Phase = "Lobby preparation", LastAction = "Redeeming code " .. code})
            local ok, message, success = pcall(function()
                return CodesFunction:InvokeServer("RedeemCode", code)
            end)
            if not ok then
                redeemedCodes[code] = nil
                error(message)
            end
            updateRuntime({LastAction = tostring(message or code) .. (success and " (success)" or "")})
            return true
        end
    end
    return false
end
local function runClaims()
    if not (state.Running and config.AutoClaim and canUseLobby()) then
        return
    end
    local data = playerData()
    if config.ClaimQuests then
        QuestRemote:FireServer("ClaimAllQuests")
    end
    if config.ClaimDaily then
        claimDaily(data)
    end
    if config.ClaimPlaytime then
        claimPlaytime(data)
    end
    if config.ClaimBattlepass and currentBattlepassCanClaim(data) then
        BattlepassRemote:FireServer("ClaimBattlepass", BattlepassInfo.CurrentBattlepass)
    end
    if config.ClaimLevelMilestones then
        claimLevelMilestone(data)
    end
    if config.ClaimTowerIndex then
        claimTowerIndex(data)
    end
    if config.ClaimGroupReward then
        claimGroupReward(data)
    end
    if config.ClaimInfinityRank and canClaimInfinityRank() then
        MiscRemote:FireServer("ClaimRankRewards", "InfinityCastle")
    end
    state.LastClaimCycle = os.clock()
    updateRuntime({Phase = "Lobby ready", LastAction = "Claim cycle completed"})
end
local function standardSummonPreview(requestedAmount, reserve)
    reserve = math.max(0, math.floor(tonumber(reserve) or 0))
    local standard = refreshStandardBanner(false)
    if type(standard) ~= "table" then return nil, "Standard banner unavailable" end
    local currency = standard.SummonCurrency
    if type(currency) ~= "table" or currency.ItemType ~= "Currency" or type(currency.ItemName) ~= "string" then
        return nil, "Standard banner currency unavailable"
    end
    local price = tonumber(standard.SummonPrice)
    if not price or price <= 0 then return nil, "Standard banner price unavailable" end
    local vipOk, hasVip = pcall(ProductsModule.HasGamePass, LocalPlayer, "VIP")
    if vipOk and hasVip then price *= 0.8 end
    local inventory = GlobalTables.Inventory or {}
    local ownedCurrency = inventory[currency.ItemType] and tonumber(inventory[currency.ItemType][currency.ItemName]) or 0
    local spendable = math.max(0, ownedCurrency - reserve)
    if spendable < price then
        return nil, string.format("Reserve blocks summon: %d %s available after %d reserve", spendable, currency.ItemName, reserve)
    end
    local towerCount = 0
    for _ in pairs(inventory.Towers or {}) do towerCount += 1 end
    local freeSlots = math.max(0, (tonumber(playerData().MaxTowerSlot) or 0) - towerCount)
    if freeSlots <= 0 then return nil, "No free unit slots" end
    local affordable = math.floor(spendable / price)
    local request = tostring(requestedAmount) == "Max" and 50
        or math.clamp(math.floor(tonumber(requestedAmount) or 1), 1, 50)
    local preview = {
        Amount = math.min(50, request, affordable, freeSlots),
        Affordable = affordable,
        FreeSlots = freeSlots,
        OwnedCurrency = ownedCurrency,
        Reserve = reserve,
        Price = price,
        Currency = currency.ItemName,
        Requested = tostring(requestedAmount) == "Max" and "Max" or tostring(request),
    }
    if preview.Amount <= 0 then return nil, "Currency reserve or unit slots block summon" end
    state.LastSummonPreview = preview
    return preview
end
state.PreviewStandardSummon = standardSummonPreview
local function standardSummon(requestedAmount, reserve, owner)
    if os.clock() < (state.NextStandardSummonAt or 0) then
        return false, "Waiting for summon throttle"
    end
    local preview, reason = standardSummonPreview(requestedAmount, reserve)
    if not preview then return false, reason end
    state.NextStandardSummonAt = os.clock() + 5
    local amount = preview.Amount
    updateRuntime({
        Phase = owner .. " summon",
        LastAction = string.format("Summoning %d Standard units for %g %s", amount, amount * preview.Price, preview.Currency),
        LastError = "None",
    })
    local summonOk, result = pcall(function()
        return SummonFunction:InvokeServer("SummonTower", "Standard", amount)
    end)
    if not summonOk then return false, owner .. " summon failed: " .. tostring(result) end
    return true, string.format("Summoned %d Standard units", amount)
end
local function runAutoSummonCycle()
    if not (state.Running and config.AutoSummon and canUseLobby()) then return false end
    refreshStandardBanner(false)
    if #config.AutoSummonUnits == 0 then
        state.AutoSummonStatus = "Select at least one Mythic target"
        return false
    end
    local selected = selectionToSet(config.AutoSummonUnits)
    local matches = {}
    for _, entry in ipairs(state.StandardMythics or {}) do
        if selected[entry.Key] and entry.IsRateUp then table.insert(matches, entry.Label) end
    end
    if #matches == 0 then
        state.AutoSummonStatus = "Waiting for selected Mythic to become RATE-UP"
        return false
    end
    local acted, reason = standardSummon(config.AutoSummonAmount, config.AutoSummonReserve, "Auto")
    state.AutoSummonStatus = table.concat(matches, ", ") .. " active | " .. reason
    if not acted and reason ~= "Waiting for summon throttle" then updateRuntime({LastError = "Auto Summon: " .. reason}) end
    return acted
end
local function runAutoQuestCycle()
    if not (state.Running and config.AutoQuest and canUseLobby()) then return false end
    local snapshot = questSnapshot()
    state.QuestSnapshot = snapshot
    state.QuestTarget = questMapTarget(snapshot)
    for _, entry in ipairs(snapshot.Claimable) do
        QuestRemote:FireServer("ClaimQuest", entry.Category, entry.Slot)
        updateRuntime({Phase = "Claiming", LastAction = "Claiming " .. entry.Summary})
        return true
    end
    if state.QuestTarget or not config.AutoQuestSummon then return false end
    local summonEntry
    for _, entry in ipairs(snapshot.Supported) do
        if entry.SupportKind == "Summon" then summonEntry = entry; break end
    end
    if not summonEntry then return false end
    local acted, reason = standardSummon(math.min(50, summonEntry.Amount - summonEntry.Progress), 0, "Auto Quest")
    if not acted and reason ~= "Waiting for summon throttle" then updateRuntime({LastError = "Auto Quest summon: " .. reason}) end
    return acted
end
local joinBusy = false
local waitingForMapSelect = false
local function automationJoinEnabled()
    return config.AutoJoin == true
end
local function partyModeMatches(target, infoMode)
    infoMode = tostring(infoMode or "")
    if infoMode == "" then return true end
    if target.Owner == "Artifact" then return infoMode == "Artifact" end
    if target.Owner == "Challenge" then return infoMode == "Challenge" end
    if target.Owner == "Rift" or target.GameMode == "Rift" then
        return string.find(infoMode, "Rift", 1, true) ~= nil
    end
    if target.GameMode == "ReZero" or target.SelectionKind == "ReZero" then return infoMode == "ReZero" end
    local expected = tostring(target.DisplayGameMode or target.GameMode or "")
    return infoMode == expected or infoMode == tostring(target.GameMode or "") or infoMode == "Story"
end
local function partyInfoMatches(target, info)
    if type(info) ~= "table" or not info.WorldName then return false end
    local world = tostring(info.WorldName)
    if target.DisplayGameMode == "WorldBoss" then
        return world == "Igris" or world == "IgrisThroneRoom"
    end
    if world ~= tostring(target.World) then return false end
    if not partyModeMatches(target, info.GameMode) then return false end
    if target.Act == "Infinite" or target.DisplayGameMode == "Infinite" then return true end
    if target.Act ~= nil and info.Act ~= nil and tostring(info.Act) ~= tostring(target.Act) then return false end
    if tostring(target.DisplayGameMode or target.GameMode) == "Story"
        and target.Difficulty and info.Difficulty
        and tostring(info.Difficulty) ~= tostring(target.Difficulty) then return false end
    return true
end
local function applyJoinReplaySettings(target)
    local replay = config.AutoReplayGame == true
    if target.Owner == "Challenge" then
        replay = false
    elseif target.Owner == "Quest" then
        replay = target.QuestKind == "Generic"
    elseif config.AutoStory then
        replay = false
    end
    SettingsRemote:FireServer("SetSetting", "AutoNextGame", config.AutoStory == true and target.Owner == nil)
    SettingsRemote:FireServer("SetSetting", "AutoReplayGame", replay)
end
local function selectPartyTarget(target)
    applyJoinReplaySettings(target)
    if target.DisplayGameMode == "WorldBoss" then
        MapSelectRemote:FireServer("IgrisBossFight")
    elseif target.Owner == "Challenge" then
        MapSelectRemote:FireServer("Challenge", target.Type or (target.ChallengeKind == "Normal" and "Regular" or target.ChallengeKind) or "Regular")
    elseif target.Owner == "Artifact" then
        ItemRemote:FireServer("UseItem", "Artifacts", target.ArtifactName, 1)
    elseif target.Owner == "Trial" and target.SelectionKind ~= "ReZero" then
        ItemRemote:FireServer("UseItem", target.ItemType, target.ItemName, 1)
    elseif target.GameMode == "ReZero" or target.SelectionKind == "ReZero" then
        MapSelectRemote:FireServer("ReZero", target.World, tonumber(target.Act) or target.Act)
    elseif target.Owner == "Rift" or target.GameMode == "Rift" then
        MapSelectRemote:FireServer("ShibuyaRift")
    else
        local selection = {
            GameMode = target.GameMode,
            DisplayGameMode = target.DisplayGameMode or target.GameMode,
            StageType = target.DisplayGameMode == "Legend" and "Legend" or "Story",
            WorldName = target.World,
            Act = target.Act,
            Difficulty = target.Difficulty,
            Type = target.ChallengeKind,
        }
        MapSelectRemote:FireServer(
            "SelectMap",
            selection.GameMode,
            selection.WorldName,
            selection.Act,
            selection.Difficulty,
            selection
        )
    end
end
local continuePartyJoin
local function enterRiftPortal(attempt)
    if state.RiftPortalEntered or state.RiftEntryInProgress then return end
    local crash = workspace:FindFirstChild("CrashSite")
    local rift = crash and crash:FindFirstChild("RiftPart")
    local prompt = rift and rift:FindFirstChildOfClass("ProximityPrompt")
    local character = LocalPlayer.Character
    if not (rift and prompt and character and character:FindFirstChild("HumanoidRootPart")) then
        updateRuntime({JoinStatus = "Waiting for Rift portal", LastError = "Rift portal or character is unavailable"})
        return
    end
    state.RiftEntryInProgress = true
    updateRuntime({JoinStatus = "Entering Rift portal", PodStatus = "Teleporting to Rift", LastAction = "Activating Enter Rift prompt", LastError = "None"})
    local moved, moveError = pcall(function()
        character:PivotTo(rift.CFrame * CFrame.new(0, 3, 5))
    end)
    if not moved then
        state.RiftEntryInProgress = false
        updateRuntime({JoinStatus = "Rift portal teleport failed", LastError = tostring(moveError)})
        return
    end
    task.delay(0.3, function()
        if attempt ~= state.JoinAttempt or not joinBusy then return end
        local fired = false
        if type(fireproximityprompt) == "function" then
            fired = pcall(fireproximityprompt, prompt, 0)
        end
        if not fired then
            fired = pcall(function()
                local input = game:GetService("VirtualInputManager")
                input:SendKeyEvent(true, prompt.KeyboardKeyCode, false, game)
                task.wait(0.05)
                input:SendKeyEvent(false, prompt.KeyboardKeyCode, false, game)
            end)
        end
        state.RiftEntryInProgress = false
        state.RiftPortalEntered = fired
        if not fired then
            updateRuntime({JoinStatus = "Rift prompt failed", LastError = "Could not activate Enter Rift prompt"})
            return
        end
        updateRuntime({JoinStatus = "Rift portal entered", PodStatus = "Preparing Rift party", LastAction = "Enter Rift prompt activated"})
        task.delay(0.5, continuePartyJoin)
    end)
end
continuePartyJoin = function()
    if not (joinBusy and state.Running and automationJoinEnabled() and canUseLobby()) then return end
    local target = state.ActiveJoinTarget
    if not target then return end
    if target.Owner == "Rift" and not state.RiftPortalEntered then
        enterRiftPortal(state.JoinAttempt)
        return
    end
    if not PartyLocal.PartyLeader then
        if os.clock() >= (state.NextPartyCreateAt or 0) then
            state.NextPartyCreateAt = os.clock() + 3
            state.AutomationPartyOwned = true
            updateRuntime({JoinStatus = "Creating solo party", PodStatus = "Party pending", LastAction = "Sending CreateParty"})
            PartyRemote:FireServer("CreateParty", true)
        end
        return
    end
    if PartyLocal.PartyLeader ~= LocalPlayer then
        joinBusy = false
        waitingForMapSelect = false
        updateRuntime({Phase = "Lobby ready", JoinStatus = "Party leader required", LastError = "Auto Join cannot control another player's party"})
        return
    end
    if not partyInfoMatches(target, PartyLocal.Info) then
        if os.clock() >= (state.NextPartySelectAt or 0) then
            state.NextPartySelectAt = os.clock() + 3
            waitingForMapSelect = true
            updateRuntime({JoinStatus = "Selecting party map", PodStatus = "Party created", LastAction = "Selecting " .. tostring(target.Summary or target.World)})
            selectPartyTarget(target)
        end
        return
    end
    waitingForMapSelect = false
    local canStart, reason = PartyLocal.CanStart()
    if not canStart then
        updateRuntime({JoinStatus = "Waiting for party requirements", PodStatus = "Party map selected", LastError = tostring(reason or "A party member cannot play this map")})
        return
    end
    applyJoinReplaySettings(target)
    updateRuntime({Phase = "Teleporting", JoinStatus = "Starting party", PodStatus = "Party ready", LastAction = "Sending StartParty", LastError = "None"})
    PartyRemote:FireServer("StartParty")
end
local function joinSelectedMap()
    if joinBusy or not (state.Running and automationJoinEnabled() and canUseLobby()) then
        return
    end
    state.ActiveJoinTarget = currentJoinTarget()
    local target = state.ActiveJoinTarget
    if not target then
        updateRuntime({Phase = "Lobby ready", JoinStatus = "No automation target", LastAction = "No supported quest, Story, or fixed Join target"})
        return
    end
    if target.Owner ~= "Rift" and config.AutoClaim and not state.LastClaimCycle then
        return
    end
    config.QuestRuntimeTarget = target.Owner == "Quest" and target or nil
    config.ChallengeRuntimeTarget = target.Owner == "Challenge" and target or nil
    saveConfig()
    joinBusy = true
    waitingForMapSelect = false
    state.JoinAttempt = (state.JoinAttempt or 0) + 1
    local attempt = state.JoinAttempt
    state.NextPartyCreateAt, state.NextPartySelectAt = 0, 0
    state.RiftEntryScheduled = false
    state.RiftPortalEntered = false
    state.RiftEntryInProgress = false
    updateRuntime({Phase = "Joining", JoinStatus = "Preparing party", PodStatus = "Party coordinator active", LastAction = "Join attempt " .. attempt})
    continuePartyJoin()
    task.delay(20, function()
        if attempt ~= state.JoinAttempt or not joinBusy then
            return
        end
        waitingForMapSelect = false
        joinBusy = false
        updateRuntime({
            Phase = "Lobby ready",
            JoinStatus = "Timed out; retrying",
            RetryCount = state.Runtime.RetryCount + 1,
            LastError = "Party join timed out",
        })
    end)
end
state.PlaytimeStartedAt = tick()
table.insert(state.Connections, MapSelectRemote.OnClientEvent:Connect(function(action)
    updateRuntime({LastRemote = tostring(action)})
    if not (state.Running and automationJoinEnabled()) then
        return
    end
    if action == "ToggleMapSelectUI" then
        updateRuntime({JoinStatus = "Map selector UI updated"})
    end
    task.defer(continuePartyJoin)
end))
table.insert(state.Connections, PartyRemote.OnClientEvent:Connect(function(action)
    updateRuntime({LastRemote = "Party:" .. tostring(action)})
    if action == "UpdateParty" or action == "UpdateCanPlay" then
        task.defer(continuePartyJoin)
    end
end))
table.insert(state.Connections, LocalPlayer.OnTeleport:Connect(function(teleportState, placeId)
    updateRuntime({Phase = "Teleporting", JoinStatus = tostring(teleportState), LastAction = "Teleport to " .. tostring(placeId)})
    if state.ActiveJoinTarget and state.ActiveJoinTarget.Owner == "Rift"
        and teleportState ~= Enum.TeleportState.Failed and not state.RiftEntryScheduled then
        state.RiftEntryScheduled = true
        scheduleNextRift("Rift teleport confirmed; next check scheduled")
    end
    state.JoinAttempt = (state.JoinAttempt or 0) + 1
end))
table.insert(state.Connections, game:GetService("TeleportService").TeleportInitFailed:Connect(function(player, result, message)
    if player == LocalPlayer then
        joinBusy = false
        updateRuntime({Phase = "Lobby ready", JoinStatus = "Teleport failed", LastError = tostring(result) .. ": " .. tostring(message)})
    end
end))
local function coordinatorStep()
    if not state.Running or not canUseLobby() then
        return
    end
    scanNewUnitWebhooks()
    local now = os.clock()
    state.RiftRuntimeTarget = nil
    if config.AutoRift then
        local ok, target = pcall(autoRiftTarget)
        if ok then state.RiftRuntimeTarget = target else state.RiftScanError = tostring(target) end
        refreshStatusPanel()
        if not state.RiftRuntimeTarget and state.RiftCheckBlocking then return end
        if state.RiftRuntimeTarget and joinBusy
            and state.ActiveJoinTarget and state.ActiveJoinTarget.Owner ~= "Rift" then
            joinBusy = false
            waitingForMapSelect = false
            state.ActiveJoinTarget = nil
            state.JoinAttempt = (state.JoinAttempt or 0) + 1
        end
        if state.RiftRuntimeTarget then
            if automationJoinEnabled() and joinBusy then
                continuePartyJoin()
            elseif automationJoinEnabled() and (not state.NextJoinAt or now >= state.NextJoinAt) then
                state.NextJoinAt = now + 15
                joinSelectedMap()
            end
            return
        end
    end
    if not state.NextBannerScanAt or now >= state.NextBannerScanAt then
        refreshStandardBanner(true)
        state.NextBannerScanAt = now + 30
        refreshStatusPanel()
    end
    local challengePriority = false
    if (config.AutoChallenge or config.AutoChallengeLeave) and not state.ChallengeSweepResolved
        and (not state.NextChallengeInfoAt or now >= state.NextChallengeInfoAt) then
        state.NextChallengeInfoAt = now + 15
        local ok, target = pcall(function()
            if config.AutoChallenge then return autoChallengeTarget() end
            local info = refreshChallengeInfo(false)
            if not info then state.ChallengeCheckBlocking = true; return nil end
            updateChallengeTimerFromInfo(info, "Lobby timer check completed")
            state.ChallengeSweepResolved = true
        end)
        challengePriority = ok and target ~= nil or state.ChallengeCheckBlocking == true
        if not ok then state.ChallengeScanError = tostring(target) end
        refreshStatusPanel()
    elseif config.AutoChallenge and not state.ChallengeSweepResolved then
        local target = autoChallengeTarget()
        challengePriority = target ~= nil or state.ChallengeCheckBlocking == true
    end
    if not challengePriority and config.AutoQuest and (not state.NextQuestAt or now >= state.NextQuestAt) then
        local ok, acted = pcall(runAutoQuestCycle)
        state.NextQuestAt = now + 5
        refreshStatusPanel()
        if not ok then
            updateRuntime({Phase = "Lobby ready", LastError = "Auto Quest: " .. tostring(acted)})
        elseif acted then
            return
        end
    end
    if config.AutoClaim and (not state.NextClaimAt or now >= state.NextClaimAt) then
        updateRuntime({Phase = "Claiming", LastAction = "Running claim cycle"})
        local ok, err = pcall(runClaims)
        state.NextClaimAt = now + 30
        if not ok then
            state.LastClaimCycle = state.LastClaimCycle or now
            updateRuntime({Phase = "Lobby ready", LastError = "Claim: " .. tostring(err)})
        end
        return
    end
    if not state.PreparationBypass and (not state.NextUtilityAt or now >= state.NextUtilityAt) then
        local ok, acted = pcall(function()
            return runAutoCodes() or runAutoCraft() or runAutoShops()
        end)
        state.NextUtilityAt = now + 5
        if not ok then
            updateRuntime({Phase = "Lobby ready", LastError = "Preparation: " .. tostring(acted)})
        elseif acted then
            state.PreparationStartedAt = state.PreparationStartedAt or now
            if now - state.PreparationStartedAt >= 45 then
                state.PreparationBypass = true
                updateRuntime({Phase = "Lobby ready", LastError = "Lobby preparation exceeded 45s; join unlocked"})
            end
            return
        else
            state.PreparationStartedAt = nil
        end
    end
    if config.AutoSummon and (not state.NextAutoSummonAt or now >= state.NextAutoSummonAt) then
        local ok, acted = pcall(runAutoSummonCycle)
        state.NextAutoSummonAt = now + 5
        refreshStatusPanel()
        if not ok then
            state.AutoSummonStatus = "Error: " .. tostring(acted)
            updateRuntime({LastError = "Auto Summon: " .. tostring(acted)})
        elseif acted then
            return
        end
    end
    if automationJoinEnabled() and joinBusy then
        continuePartyJoin()
    elseif automationJoinEnabled() and (not state.NextJoinAt or now >= state.NextJoinAt) then
        state.NextJoinAt = now + 15
        joinSelectedMap()
    elseif not automationJoinEnabled() then
        local hadPendingJoin = waitingForMapSelect or joinBusy or state.ActiveJoinTarget ~= nil
        waitingForMapSelect = false
        joinBusy = false
        state.ActiveJoinTarget = nil
        if hadPendingJoin then state.JoinAttempt = (state.JoinAttempt or 0) + 1 end
        updateRuntime({
            Phase = "Lobby ready",
            JoinStatus = "Auto Join disabled",
        })
    end
end
task.spawn(function()
        while state.Running do
            local ok, err = pcall(coordinatorStep)
            if not ok then
                updateRuntime({Phase = "Error", LastError = tostring(err)})
            end
            task.wait(1)
        end
    end)
local function ownedArtifacts()
    local inv = type(GlobalTables.Inventory) == "table" and GlobalTables.Inventory.Artifacts
    local list = {}
    if type(inv) == "table" then
        for name, amount in pairs(inv) do
            if type(ItemInfo.Artifacts) == "table" and ItemInfo.Artifacts[name] then
                local count = tonumber(amount)
                if count and count > 0 then
                    table.insert(list, tostring(name))
                end
            end
        end
    end
    table.sort(list)
    return list
end
local function worldOptions(mode)
    if mode == "Artifact" then
        return ownedArtifacts()
    end
    if mode == "Trial" then
        return {"SandVillage", "PleiadesGrass"}
    end
    if mode == "ReZero" then
        return {"PleiadesSand", "PleiadesLibrary"}
    end
    if mode == "WorldBoss" then
        return {"Igris"}
    end
    local ordering = mode == "Raid" and GameInfo.RaidOrdering or mode == "Rift" and GameInfo.RiftOrdering or GameInfo.Ordering
    local options = {}
    for _, world in ipairs(ordering or {}) do
        table.insert(options, world)
    end
    return options
end
local function actOptions(world, mode)
    if mode == "Infinite" then return {"Infinite"} end
    if mode == "Trial" then return world == "PleiadesGrass" and {"Trial"} or {"MadaraStage"} end
    if mode == "ReZero" then return {"1", "2"} end
    local mapInfo = artifactMapInfo(world)
    if mapInfo then
        return {mapInfo.Act}
    end
    local info = GameInfo[world]
    if mode == "Legend" then
        local options = {}
        for act = 1, (info and info.LegendAmount or 0) do
            table.insert(options, "Legend" .. tostring(act))
        end
        return #options > 0 and options or {"Legend1"}
    end
    if mode == "WorldBoss" then
        return {"None"}
    end
    local options = {}
    for act = 1, (info and info.ActAmount or 1) do
        table.insert(options, tostring(act))
    end
    return options
end
local function craftOptions()
    local options = {}
    for itemType, items in pairs(ItemInfo) do
        if type(items) == "table" then
            for itemName, info in pairs(items) do
                if type(info) == "table" and info.CraftingInfo then
                    table.insert(options, itemType .. "|" .. itemName)
                end
            end
        end
    end
    for itemName, info in pairs(TowerInfo) do
        if type(info) == "table" and info.CraftingInfo then
            table.insert(options, "Towers|" .. itemName)
        end
    end
    table.sort(options)
    return options
end
local function modifierOptions()
    local list = {}
    if type(ModifiersInfo) == "table" then
        for key in pairs(ModifiersInfo) do
            if type(key) == "string" then table.insert(list, key) end
        end
        table.sort(list)
    end
    return #list > 0 and list or {
        "Armored", "BaseHealth", "Cooldown", "Damage", "DarkResistance", "DarkWeakness",
        "DeathHealer", "EarthResistance", "EarthWeakness", "ExplosiveDeath", "FireResistance",
        "FireWeakness", "HighCost", "LightResistance", "LightWeakness", "LightningResistance",
        "LightningWeakness", "MagicResistance", "Multiplying", "NatureResistance", "NatureWeakness",
        "PhysicalResistance", "Purifier", "Range", "Regenerator", "Shielded", "Speed", "Tank",
        "TowerLimit", "Traitless", "UpgradeLimit", "WaterResistance", "WaterWeakness",
    }
end
local function shopOptions(catalog)
    local options = {}
    local shopInfo = refreshShopInfo(catalog)
    if shopInfo and type(shopInfo.ShopItems) == "table" then
        for _, item in pairs(shopInfo.ShopItems) do
            table.insert(options, tostring(item.ItemType) .. "|" .. tostring(item.ItemName))
        end
    end
    table.sort(options)
    return options
end
local function artifactRewardOptions()
    local list, seen = {}, {}
    for _, artifact in pairs(ItemInfo.Artifacts or {}) do
        for _, rewards in pairs(type(artifact.ArtifactRewards) == "table" and artifact.ArtifactRewards or {}) do
            for _, reward in pairs(type(rewards) == "table" and rewards or {}) do
                local option = tostring(reward.ItemType) .. "|" .. tostring(reward.ItemName)
                if not seen[option] then
                    seen[option] = true
                    table.insert(list, option)
                end
            end
        end
    end
    table.sort(list)
    return list
end
state.ShopSelectionDefault = function(catalog)
    local defaults = {}
    local selected = selectionToSet(config.ShopItems[catalog.Key])
    for _, option in ipairs(shopOptions(catalog)) do
        local itemName = string.match(option, "^[^|]+|(.+)$")
        if selected[option] or selected[itemName] then defaults[option] = true end
    end
    return defaults
end
local function storyMacroOptions(world)
    local options = {"None"}
    if type(listfiles) ~= "function" or type(isfolder) ~= "function" or not isfolder(macrosFolder) then
        return options
    end
    local ok, files = pcall(listfiles, macrosFolder)
    if not ok then
        return options
    end
    for _, path in ipairs(files) do
        if string.lower(string.sub(path, -5)) == ".json" then
            local decodedOk, decoded = pcall(function()
                return HttpService:JSONDecode(readfile(path))
            end)
            local fileName = string.match(path, "([^/\\]+)%.json$")
            local key = decodedOk and type(decoded) == "table" and (decoded.MacroKey or decoded.Key
                or type(decoded.Map) == "table" and decoded.Map.CanonicalMacroKey) or nil
            if not key and fileName then
                local mode, fileWorld, act, difficulty = string.match(fileName, "^([^_]+)_(.+)_([^_]+)_([^_]+)$")
                if mode then key = table.concat({mode, fileWorld, act, difficulty}, "|") end
            end
            local _, keyWorld = string.match(tostring(key or ""), "^([^|]+)|(.+)|([^|]+)|([^|]+)$")
            if tostring(keyWorld) == tostring(world) then
                if fileName then
                    table.insert(options, fileName)
                end
            end
        end
    end
    table.sort(options, function(left, right)
        if left == "None" then return true end
        if right == "None" then return false end
        return left < right
    end)
    return options
end
local function loadFluent()
    if getgenv and getgenv().Fluent and not getgenv().Fluent.Unloaded then return getgenv().Fluent end
    local ok, fluent = pcall(function()
        return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    end)
    if ok and fluent then
        if getgenv then getgenv().Fluent = fluent end
        return fluent
    end
    return nil
end
local Fluent = loadFluent()
if not Fluent then
    warn("[AnimeOriginsUltimate] Fluent UI failed to load. Configure AnimeOriginsUltimateConfig in the script environment manually.")
    environment.AnimeOriginsUltimateConfig = config
    return
end
local function buildUI()
local Window = Fluent:CreateWindow({
    Title = "Anime Origins Ultimate",
    SubTitle = "Lobby Automation",
    TabWidth = 140,
    Size = UDim2.fromOffset(560, 420),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl,
})
state.Window = Window
state.Config = config
environment.AnimeOriginsUltimateConfig = config
local LobbyTab = Window:AddTab({Title = "Lobby Info", Icon = "home"})
local ClaimTab = Window:AddTab({Title = "Auto Claim", Icon = "gift"})
local QuestTab = Window:AddTab({Title = "Auto Quest", Icon = "target"})
            local RiftTab = Window:AddTab({Title = "Auto Rift", Icon = "zap"})
            local ChallengeTab = Window:AddTab({Title = "Auto Challenge", Icon = "swords"})
local SummonTab = Window:AddTab({Title = "Auto Summon", Icon = "sparkles"})
local StoryTab = Window:AddTab({Title = "Auto Story", Icon = "book-open"})
local JoinTab = Window:AddTab({Title = "Auto Join", Icon = "map"})
local CraftTab = Window:AddTab({Title = "Auto Craft", Icon = "hammer"})
state.ShopTab = Window:AddTab({Title = "Auto Shop", Icon = "shopping-cart"})
local MacroTab = Window:AddTab({Title = "Macro In-Game", Icon = "play"})
local WebhookTab = Window:AddTab({Title = "Webhook", Icon = "message-circle"})
local FakeVisualTab = Window:AddTab({Title = "FakeVisual", Icon = "eye"})
local SettingsTab = Window:AddTab({Title = "Settings", Icon = "settings"})
local ConfigsTab = Window:AddTab({Title = "Configs", Icon = "folder"})
LobbyTab:AddParagraph({Title = "Information", Content = "Lobby preparation runs before Auto Join. Macro record and playback controls appear automatically inside a game."})
statusParagraphs.Lobby = LobbyTab:AddParagraph({Title = "Lobby Status", Content = "Initializing..."})
statusParagraphs.Map = LobbyTab:AddParagraph({Title = "Selected Map", Content = selectedMapText()})
statusParagraphs.Join = LobbyTab:AddParagraph({Title = "Join Status", Content = "Initializing coordinator..."})
statusParagraphs.Action = LobbyTab:AddParagraph({Title = "Runtime", Content = "Waiting for first scheduler cycle..."})
statusParagraphs.Quest = QuestTab:AddParagraph({Title = "Quest Status", Content = "Scanning Daily and Weekly quests..."})
refreshChallengeInfo(true)
statusParagraphs.Challenge = ChallengeTab:AddParagraph({Title = "Challenge Information", Content = challengeStatusText()})
statusParagraphs.Summon = SummonTab:AddParagraph({Title = "Auto Summon Status", Content = "Standalone Auto Summon disabled"})
statusParagraphs.Banner = SummonTab:AddParagraph({Title = "Standard Banner Scanner", Content = bannerStatusText()})
statusParagraphs.Story = StoryTab:AddParagraph({Title = "Next Story Target", Content = "Scanning progression..."})
refreshStatusPanel()
local fakeVisualStatus = FakeVisualTab:AddParagraph({
    Title = "FakeVisual Status",
    Content = environment._AllInOneInstalled and "Loaded; press Load FakeVisual to activate controls" or "Not loaded",
})
local fakeVisualActivated = false
FakeVisualTab:AddParagraph({
    Title = "Client-side only",
    Content = "Fake visuals and resource changes are local to this client. Rejoining restores server values.",
})
FakeVisualTab:AddButton({Title = "Load FakeVisual", Callback = function()
    if environment._AllInOneInstalled then
        fakeVisualActivated = true
        fakeVisualStatus:SetDesc("Activated for this session")
        Fluent:Notify({Title = "FakeVisual", Content = "FakeVisual controls activated.", Duration = 5})
        return
    end
    fakeVisualStatus:SetDesc("Downloading encrypted loader...")
    local ok, err = pcall(function()
        return loadstring(game:HttpGet("https://truyem789.site/kocogi.lua"))()
    end)
    ok = ok and environment._AllInOneInstalled == true
    if not ok and err == nil then err = "FakeVisual loader did not install" end
    fakeVisualActivated = ok
    fakeVisualStatus:SetDesc(ok and "Loaded and activated for this session" or ("Load failed: " .. tostring(err)))
    Fluent:Notify({
        Title = ok and "FakeVisual Loaded" or "FakeVisual Error",
        Content = ok and "Encrypted FakeVisual script loaded." or tostring(err),
        Duration = 6,
    })
end})
local fakeResourceValues, fakeResourceLookup = {}, {}
for _, itemType in ipairs({"Currency", "Materials", "Food", "Misc"}) do
    for itemName, info in pairs(ItemInfo[itemType] or {}) do
        if type(info) == "table" then
            local label = string.format("%s | %s [%s]", itemType, tostring(info.DisplayName or itemName), tostring(itemName))
            table.insert(fakeResourceValues, label)
            fakeResourceLookup[label] = {ItemType = itemType, ItemName = tostring(itemName)}
        end
    end
end
table.sort(fakeResourceValues)
local selectedFakeResource = fakeResourceValues[1]
FakeVisualTab:AddDropdown("FakeVisualResource", {
    Title = "Resource",
    Values = fakeResourceValues,
    Default = selectedFakeResource,
}):OnChanged(function(value)
    selectedFakeResource = value
end)
local fakeResourceAmount = FakeVisualTab:AddInput("FakeVisualResourceAmount", {
    Title = "Amount",
    Default = "100000",
    Placeholder = "0",
    Numeric = true,
    Finished = true,
})
local function changeFakeResource(add)
    if not fakeVisualActivated or not environment._AllInOneInstalled then
        error("Press Load FakeVisual before using Set/Add Resource")
    end
    local selected = fakeResourceLookup[selectedFakeResource]
    if not selected then error("Select a resource first") end
    if type(firesignal) ~= "function" then error("firesignal is unavailable") end
    local amount = math.floor(tonumber(fakeResourceAmount.Value) or 0)
    local inventory = GlobalTables.Inventory and GlobalTables.Inventory[selected.ItemType]
    local current = tonumber(inventory and inventory[selected.ItemName]) or 0
    local target = add and current + amount or amount
    firesignal(
        InventoryRemote.OnClientEvent,
        "AddItem",
        selected.ItemType,
        selected.ItemName,
        target,
        target - current,
        nil,
        true
    )
    fakeVisualStatus:SetDesc(string.format(
        "%s %s: %s -> %s",
        add and "Added to" or "Set", selected.ItemName, tostring(current), tostring(target)
    ))
end
FakeVisualTab:AddButton({Title = "Set Resource Amount", Callback = function()
    local ok, err = pcall(changeFakeResource, false)
    if not ok then Fluent:Notify({Title = "FakeVisual Error", Content = tostring(err), Duration = 6}) end
end})
FakeVisualTab:AddButton({Title = "Add Resource Amount", Callback = function()
    local ok, err = pcall(changeFakeResource, true)
    if not ok then Fluent:Notify({Title = "FakeVisual Error", Content = tostring(err), Duration = 6}) end
end})
local function toggle(tab, key, title)
    tab:AddToggle(key, {Title = title, Default = config[key]}):OnChanged(function(value)
        config[key] = value
        state.PreparationBypass = false
        saveConfig()
        refreshStatusPanel()
    end)
end
ChallengeTab:AddParagraph({
    Title = "Challenge automation",
    Content = "Auto Challenge requires Auto Join and handles challenge maps. Auto Leave is independent and returns from regular games only when the timestamp file reaches the next challenge rotation.",
})
ChallengeTab:AddToggle("AutoChallenge", {Title = "Enable Auto Challenge", Default = config.AutoChallenge}):OnChanged(function(value)
    config.AutoChallenge = value == true
    config.ChallengeNextCheckAt = value and 0 or config.ChallengeNextCheckAt
    if not value then config.ChallengeRuntimeTarget = nil end
    state.ActiveJoinTarget, state.NextJoinAt, state.LastChallengeScanAt = nil, 0, 0
    state.ChallengeSweepResolved, state.ChallengeInitialScanComplete = false, false
    saveConfig()
    refreshChallengeInfo(true)
    refreshStatusPanel()
end)
ChallengeTab:AddToggle("AutoChallengeLeave", {
    Title = "Auto Leave For Challenge", Default = config.AutoChallengeLeave,
}):OnChanged(function(value)
    config.AutoChallengeLeave = value == true
    state.ChallengeSweepResolved, state.LastChallengeScanAt, state.NextChallengeInfoAt = false, 0, 0
    local info = refreshChallengeInfo(true)
    if info then
        updateChallengeTimerFromInfo(info, value and "Auto Leave enabled in lobby" or "Auto Leave disabled but timer updated")
        state.ChallengeSweepResolved = true
    elseif not value then
        aoWriteChallengeTimer(LocalPlayer.UserId, {NextCheckAt = 0, Reason = "Auto Leave disabled"})
    end
    saveConfig()
    refreshStatusPanel()
end)
ChallengeTab:AddDropdown("ChallengeTypes", {
    Title = "Challenge list", Values = {"Daily", "Normal"}, Multi = true,
    Default = selectionToSet(config.ChallengeTypes),
}):OnChanged(function(values)
    config.ChallengeTypes = selectionToList(values)
    config.ChallengeNextCheckAt = 0
    state.ActiveJoinTarget, state.NextJoinAt = nil, 0
    state.ChallengeSweepResolved = false
    saveConfig()
    refreshStatusPanel()
end)
ChallengeTab:AddButton({Title = "Refresh Challenge Information", Callback = function()
    state.LastChallengeScanAt = 0
    refreshChallengeInfo(true)
    refreshStatusPanel()
end})
ChallengeTab:AddParagraph({
    Title = "Dedicated Challenge Macros",
    Content = "Choose a separate macro for each Story world. These selections do not use or overwrite Auto Story macros.",
})
for index, world in ipairs(GameInfo.Ordering or {}) do
    local options = storyMacroOptions(world)
    local selected = config.ChallengeMacroByWorld[world]
    if selected and not table.find(options, selected) then table.insert(options, selected) end
    ChallengeTab:AddDropdown("ChallengeMacro_" .. index, {
        Title = tostring((GameInfo[world] or {}).DisplayName or world), Values = options,
        Default = selected or "None", Multi = false,
    }):OnChanged(function(value)
        config.ChallengeMacroByWorld[world] = value ~= "None" and value or nil
        config.ChallengeNextCheckAt = 0
        state.ActiveJoinTarget, state.NextJoinAt = nil, 0
        state.ChallengeSweepResolved = false
        saveConfig()
        refreshStatusPanel()
    end)
end
QuestTab:AddParagraph({
    Title = "Supported automation",
    Content = "Priority: unlocked Infinite Waves, then generic Kill/Waves/Any Games on Story. Challenge maps are handled separately by Auto Challenge.",
})
QuestTab:AddToggle("AutoQuest", {Title = "Enable Auto Quest", Default = config.AutoQuest}):OnChanged(function(value)
    config.AutoQuest = value
    state.ActiveJoinTarget = nil
    state.QuestTarget = nil
    state.NextQuestAt = 0
    state.NextJoinAt = 0
    if not value then config.QuestRuntimeTarget = nil end
    saveConfig()
    refreshStatusPanel()
end)
QuestTab:AddParagraph({
    Title = "Banner spending warning",
    Content = "Disabled by default. Enabling allows Auto Quest to spend Standard banner currency only after no playable map objective remains, up to 50 remaining summons when currency and slots allow.",
})
QuestTab:AddToggle("AutoQuestSummon", {Title = "Allow Standard banner spending", Default = config.AutoQuestSummon}):OnChanged(function(value)
    config.AutoQuestSummon = value
    state.NextQuestAt = 0
    saveConfig()
    refreshStatusPanel()
end)
local questActDropdown
local questWorldDropdown = QuestTab:AddDropdown("QuestWorld", {
    Title = "Story world", Values = worldOptions("Story"), Default = config.QuestWorld,
})
questActDropdown = QuestTab:AddDropdown("QuestAct", {
    Title = "Story act", Values = actOptions(config.QuestWorld), Default = config.QuestAct,
})
questWorldDropdown:OnChanged(function(value)
    config.QuestWorld = value
    local acts = actOptions(value)
    if not table.find(acts, config.QuestAct) then config.QuestAct = acts[1] end
    questActDropdown:SetValues(acts)
    questActDropdown:SetValue(config.QuestAct)
    state.ActiveJoinTarget, state.QuestTarget, state.NextJoinAt = nil, nil, 0
    saveConfig()
    refreshStatusPanel()
end)
questActDropdown:OnChanged(function(value)
    config.QuestAct = tostring(value)
    state.ActiveJoinTarget, state.QuestTarget, state.NextJoinAt = nil, nil, 0
    saveConfig()
    refreshStatusPanel()
end)
QuestTab:AddDropdown("QuestDifficulty", {
    Title = "Story difficulty", Values = {"Normal", "Hard"}, Default = config.QuestDifficulty,
}):OnChanged(function(value)
    config.QuestDifficulty = value
    state.ActiveJoinTarget, state.QuestTarget, state.NextJoinAt = nil, nil, 0
    saveConfig()
    refreshStatusPanel()
end)
SummonTab:AddParagraph({
    Title = "Target Mythic / Snipe",
    Content = "Select any Mythic target in advance. The scanner summons only when a selected unit is currently RATE-UP; normal pool availability does not trigger rolls.",
})
SummonTab:AddParagraph({
    Title = "Summon Max",
    Content = "Max automatically uses the affordable count after currency reserve and free unit slots, capped at 50 per server request. VIP discount and all safety limits remain enforced.",
})
SummonTab:AddToggle("AutoSummon", {Title = "Enable standalone Auto Summon", Default = config.AutoSummon}):OnChanged(function(value)
    config.AutoSummon = value
    state.NextAutoSummonAt = 0
    state.AutoSummonStatus = value and "Enabled; waiting for safe Standard summon check" or "Standalone Auto Summon disabled"
    saveConfig()
    refreshStatusPanel()
end)
for _, key in ipairs(config.AutoSummonUnits) do
    if aoIsBaseMythic(TowerInfo, key) and not bannerKeyToLabel[key] then
        local info = TowerInfo[key] or {}
        local label = string.format("%s [%s]", tostring(info.DisplayName or info.Name or key), key)
        bannerLabelToKey[label], bannerKeyToLabel[key], knownBannerLabels[label] = key, label, true
        table.insert(state.StandardBannerLabels, label)
    end
end
table.sort(state.StandardBannerLabels)
local summonTargetDefaults = {}
for _, key in ipairs(config.AutoSummonUnits) do summonTargetDefaults[bannerKeyToLabel[key] or key] = true end
summonTargetDropdown = SummonTab:AddDropdown("AutoSummonUnits", {
    Title = "Target Mythic",
    Description = "Display name [internal key]",
    Values = state.StandardBannerLabels,
    Multi = true,
    Default = summonTargetDefaults,
})
summonTargetDropdown:OnChanged(function(values)
    local selected, seen = {}, {}
    for label in pairs(selectionToSet(values)) do
        local key = bannerLabelToKey[label] or label:match("%[(.-)%]$") or label
        if key ~= "" and aoIsBaseMythic(TowerInfo, key) and not seen[key] then seen[key] = true; table.insert(selected, key) end
    end
    table.sort(selected)
    config.AutoSummonUnits = selected
    state.NextAutoSummonAt = 0
    saveConfig()
    refreshStatusPanel()
end)
SummonTab:AddDropdown("AutoSummonAmount", {
    Title = "Amount per request", Values = {"1", "10", "50", "Max"}, Default = config.AutoSummonAmount,
}):OnChanged(function(value)
    local amount = tostring(value)
    config.AutoSummonAmount = amount == "Max" and "Max"
        or tostring(math.clamp(math.floor(tonumber(amount) or 1), 1, 50))
    saveConfig()
end)
SummonTab:AddInput("AutoSummonReserve", {
    Title = "Currency reserve", Default = tostring(config.AutoSummonReserve), Placeholder = "0", Numeric = true, Finished = true,
}):OnChanged(function(value)
    config.AutoSummonReserve = math.max(0, math.floor(tonumber(value) or 0))
    saveConfig()
end)
WebhookTab:AddParagraph({
    Title = "Discord Webhook",
    Content = "Sends structured notifications for completed matches and newly obtained units, using the current game icon.",
})
WebhookTab:AddInput("WebhookUrl", {
    Title = "Discord Webhook URL",
    Default = config.WebhookUrl,
    Placeholder = "https://discord.com/api/webhooks/...",
    Numeric = false,
    Finished = false,
}):OnChanged(function(value)
    config.WebhookUrl = tostring(value or "")
    saveConfig()
end)
toggle(WebhookTab, "WebhookCompletionEnabled", "Notify when Match Completed")
toggle(WebhookTab, "WebhookUnitEnabled", "Notify when New Unit Obtained")
WebhookTab:AddButton({Title = "Test Match Webhook", Callback = function()
    local icon = gameIconUrl()
    local currencyInventory = (GlobalTables.Inventory or {}).Currency or {}
    local resourceLines = {}
    for _, entry in ipairs(AO_WEBHOOK_CURRENCIES) do
        table.insert(resourceLines, string.format(
            "%s **%s:** %s + 1",
            entry.Emoji, entry.Label, tostring(tonumber(currencyInventory[entry.Key]) or 0)
        ))
    end
    local rewardLines = {}
    for itemType, items in pairs(ItemInfo) do
        if type(items) == "table" then
            for itemName, metadata in pairs(items) do
                if type(metadata) == "table" and itemName ~= "Gems" and itemName ~= "Gold"
                    and itemName ~= "PerfectStatPrism" and itemName ~= "StatPrism"
                    and itemName ~= "TraitReroll" and itemName ~= "Exp" and itemName ~= "BattlePassExp" then
                    local current = tonumber((((GlobalTables.Inventory or {})[itemType] or {})[itemName])) or 0
                    local displayName = tostring(metadata.DisplayName or metadata.Name or itemName)
                    if string.find(itemName, "Ascendant$", 1) or string.find(itemName, "Empowered$", 1)
                        or string.find(itemName, "Perfected$", 1) then
                        displayName ..= " [" .. tostring(itemName) .. "]"
                    end
                    table.insert(rewardLines, string.format(
                        "%s**%s:** %s + 1",
                        aoItemEmoji(itemName) and (aoItemEmoji(itemName) .. " ") or "",
                        displayName,
                        tostring(current)
                    ))
                end
            end
        end
    end
    table.sort(rewardLines)
    table.insert(rewardLines, 1, string.format(
        "%s **Player EXP:** %s + 1",
        aoItemEmoji("Exp") or "", tostring(tonumber((GlobalTables.PlayerData or {}).Exp) or 0)
    ))
    local battlePassExp = 0
    for _, battlepass in pairs((GlobalTables.PlayerData or {}).Battlepasses or {}) do
        if type(battlepass) == "table" then battlePassExp += tonumber(battlepass.Exp) or 0 end
    end
    table.insert(rewardLines, 2, string.format(
        "%s **Battlepass EXP:** %s + 1",
        aoItemEmoji("BattlePassExp") or "", tostring(battlePassExp)
    ))
    local rewardFields = aoRewardFields(rewardLines)
    local fields = {
        {name = "Clear Time", value = "2m 15s", inline = true},
        {name = "Waves", value = "15", inline = true},
        {name = "Kills", value = "100", inline = true},
        {name = "Total Damage", value = "1,000,000", inline = true},
        {name = "Units Placed", value = "6", inline = true},
        {name = "Money Earned", value = "25,000", inline = true},
        {name = "Resources", value = table.concat(resourceLines, "\n"), inline = false},
    }
    if rewardFields[1] then table.insert(fields, rewardFields[1]) end
    local embeds = {{
        author = {name = "Anime Origins", icon_url = icon},
        title = string.format("[Story] ||%s (Lv.%d)|| - Test Match", LocalPlayer.Name, currentPlayerLevel()),
        description = "**Map:** West City | Act 1 | Normal",
        color = 0xF2C94C,
        thumbnail = {url = icon},
        fields = fields,
        timestamp = DateTime.now():ToIsoDate(),
        footer = {text = "Anime Origins Ultimate"},
    }}
    for index = 2, #rewardFields do
        table.insert(embeds, {
            author = {name = "Anime Origins", icon_url = icon},
            title = "All Items (continued " .. tostring(index - 1) .. ")",
            color = 0xF2C94C,
            fields = {rewardFields[index]},
            timestamp = DateTime.now():ToIsoDate(),
            footer = {text = "Anime Origins Ultimate"},
        })
    end
    local payload = {
        username = "Anime Origins Auto",
        avatar_url = icon,
        embeds = embeds,
    }
    local ok, message = sendDiscordWebhook(config.WebhookUrl, payload)
    Fluent:Notify({Title = ok and "Webhook Sent" or "Webhook Error", Content = tostring(message), Duration = 6})
end})
StoryTab:AddParagraph({
    Title = "Story progression",
    Content = "Selects the first unlocked uncleared Story act only while Auto Join is enabled. Auto Story never enters a map by itself.",
})
StoryTab:AddToggle("AutoStory", {Title = "Enable Auto Story Targeting (requires Auto Join)", Default = config.AutoStory}):OnChanged(function(value)
    config.AutoStory = value
    state.ActiveJoinTarget = nil
    state.NextJoinAt = 0
    SettingsRemote:FireServer("SetSetting", "AutoNextGame", value)
    if value then
        SettingsRemote:FireServer("SetSetting", "AutoReplayGame", false)
    end
    saveConfig()
    refreshStatusPanel()
end)
StoryTab:AddParagraph({
    Title = "One Macro for every Act",
    Content = "Choose one recorded macro for each World. The ingame macro test will use it as a fallback for every Act in that World.",
})
for _, world in ipairs(GameInfo.Ordering or {}) do
    local options = storyMacroOptions(world)
    local selected = config.StoryMacroByWorld[world]
    if selected and not table.find(options, selected) then
        table.insert(options, selected)
    end
    StoryTab:AddDropdown("StoryMacro_" .. world, {
        Title = GameInfo[world].DisplayName or world,
        Values = options,
        Multi = false,
        Default = selected or "None",
    }):OnChanged(function(value)
        config.StoryMacroByWorld[world] = value ~= "None" and value or nil
        saveConfig()
    end)
end
ClaimTab:AddParagraph({Title = "Claim priority", Content = "Auto Claim runs before Auto Join every 30 seconds."})
toggle(ClaimTab, "AutoClaim", "Enable Auto Claim")
toggle(ClaimTab, "ClaimQuests", "Quests")
toggle(ClaimTab, "ClaimDaily", "Daily Rewards")
toggle(ClaimTab, "ClaimPlaytime", "Playtime Rewards")
toggle(ClaimTab, "ClaimBattlepass", "Battlepass")
toggle(ClaimTab, "ClaimLevelMilestones", "Level Milestones")
toggle(ClaimTab, "ClaimTowerIndex", "Tower Index and Milestones")
toggle(ClaimTab, "ClaimGroupReward", "Group Reward")
toggle(ClaimTab, "ClaimInfinityRank", "Infinity Castle Rank Reward")
ClaimTab:AddButton({Title = "Claim Now", Callback = runClaims})
CraftTab:AddParagraph({
    Title = "Preparation priority",
    Content = "Codes > Craft > Shops > Auto Join. Preparation unlocks Join after a 45-second timeout.",
})
toggle(CraftTab, "AutoCraft", "Enable Auto Craft")
CraftTab:AddDropdown("CraftItems", {
    Title = "Craft items",
    Values = craftOptions(),
    Multi = true,
    Default = selectionToSet(config.CraftItems),
}):OnChanged(function(values)
    config.CraftItems = selectionToList(values)
    state.PreparationBypass = false
    saveConfig()
end)
state.AddShopControls = function(tab)
    tab:AddParagraph({
        Title = "Scanned shops",
        Content = "Gold, Customization, Raid, Rift, World Boss, and Shali's Stash. Each catalog has an independent toggle and item selection.",
    })
    for _, catalog in ipairs(state.ShopCatalogs) do
        local current = catalog
        local id = string.gsub(current.Key, "[^%w]", "_")
        config.AutoShops[current.Key] = config.AutoShops[current.Key] == true
        config.ShopItems[current.Key] = type(config.ShopItems[current.Key]) == "table" and config.ShopItems[current.Key] or {}
        tab:AddToggle("AutoShop_" .. id, {
            Title = "Enable " .. current.Title,
            Default = config.AutoShops[current.Key],
        }):OnChanged(function(value)
            config.AutoShops[current.Key] = value == true
            if current.Key == "GoldShop" then config.AutoGoldShop = value == true end
            state.PreparationBypass = false
            saveConfig()
        end)
        tab:AddDropdown("ShopItems_" .. id, {
            Title = current.Title .. " items",
            Values = shopOptions(current),
            Multi = true,
            Default = state.ShopSelectionDefault(current),
        }):OnChanged(function(values)
            config.ShopItems[current.Key] = selectionToList(values)
            if current.Key == "GoldShop" then config.GoldShopItems = table.clone(config.ShopItems[current.Key]) end
            state.PreparationBypass = false
            saveConfig()
        end)
    end
end
state.AddShopControls(state.ShopTab)
toggle(CraftTab, "AutoRedeemCodes", "Enable Auto Redeem Codes")
CraftTab:AddInput("CodeList", {
    Title = "Codes",
    Default = config.Codes,
    Placeholder = "CODE1, CODE2",
    Numeric = false,
    Finished = true,
}):OnChanged(function(value)
    config.Codes = tostring(value or "")
    table.clear(redeemedCodes)
    state.PreparationBypass = false
    saveConfig()
end)
local worldDropdown
local actDropdown
local difficultyDropdown
local refreshingJoinOptions = false
local function applyJoinDropdownChanges(callback)
    task.defer(function()
        local ok, err = pcall(callback)
        refreshingJoinOptions = false
        if not ok then
            warn("[AnimeOriginsUltimate] Failed to refresh join options:", err)
        end
    end)
end
local function refreshActs()
    if refreshingJoinOptions then
        return
    end
    refreshingJoinOptions = true
    local options = actOptions(config.World, config.GameMode)
    if not table.find(options, config.Act) then
        config.Act = options[1]
    end
    applyJoinDropdownChanges(function()
        actDropdown:SetValues(options)
        actDropdown:SetValue(config.Act)
    end)
end
local function refreshWorlds()
    if refreshingJoinOptions then
        return
    end
    refreshingJoinOptions = true
    local options = worldOptions(config.GameMode)
    if config.GameMode == "Artifact" and config.ArtifactName ~= "" then config.World = config.ArtifactName end
    if not table.find(options, config.World) then
        config.World = options[1]
    end
    if config.GameMode == "Artifact" then config.ArtifactName = tostring(config.World or "") end
    local acts = actOptions(config.World, config.GameMode)
    if not table.find(acts, config.Act) then
        config.Act = acts[1]
    end
    if config.GameMode == "Infinite" or config.GameMode == "Raid"
        or config.GameMode == "Legend" or config.GameMode == "Artifact" then config.Difficulty = "Hard" end
    if config.GameMode == "Trial" then
        if config.World == "PleiadesGrass" then
            config.Act = "Trial"
        else
            config.World, config.Act = "SandVillage", "MadaraStage"
        end
        config.Difficulty = "None"
        options, acts = {"SandVillage", "PleiadesGrass"}, actOptions(config.World, "Trial")
    elseif config.GameMode == "ReZero" then
        config.World = table.find({"PleiadesSand", "PleiadesLibrary"}, config.World) and config.World or "PleiadesSand"
        config.Act = table.find({"1", "2"}, config.Act) and config.Act or "1"
        config.Difficulty = "None"
        options, acts = {"PleiadesSand", "PleiadesLibrary"}, {"1", "2"}
    end
    if config.GameMode == "WorldBoss" then config.Difficulty = "None" end
    local diffOptions = config.GameMode == "Story" and {"Normal", "Hard"}
        or ((config.GameMode == "Infinite" or config.GameMode == "Raid"
            or config.GameMode == "Legend" or config.GameMode == "Artifact") and {"Hard"} or {"None"})
    applyJoinDropdownChanges(function()
        worldDropdown:SetValues(options)
        worldDropdown:SetValue(config.World)
        actDropdown:SetValues(acts)
        actDropdown:SetValue(config.Act)
        difficultyDropdown:SetValues(diffOptions)
        difficultyDropdown:SetValue(config.Difficulty)
    end)
end
JoinTab:AddParagraph({Title = "Join flow", Content = "Creates a solo Party, selects the map, validates requirements, then starts the Party."})
JoinTab:AddToggle("AutoJoin", {Title = "Enable Auto Join", Default = config.AutoJoin}):OnChanged(function(value)
    config.AutoJoin = value
    state.NextJoinAt = 0
    if not value then
        waitingForMapSelect = false
        joinBusy = false
        state.ActiveJoinTarget = nil
        state.JoinAttempt = (state.JoinAttempt or 0) + 1
        state.RiftRuntimeTarget = nil
        if state.AutomationPartyOwned and PartyLocal.PartyLeader == LocalPlayer then
            PartyRemote:FireServer("LeaveParty")
            state.AutomationPartyOwned = false
        end
    end
    saveConfig()
    refreshStatusPanel()
end)
JoinTab:AddToggle("AutoArtifact", {Title = "Auto Artifact Reward", Default = config.AutoArtifact}):OnChanged(function(value)
    config.AutoArtifact = value == true
    saveConfig()
end)
JoinTab:AddDropdown("ArtifactRewardPriority", {
    Title = "Artifact reward priority",
    Values = artifactRewardOptions(),
    Multi = true,
    Default = selectionToSet(config.ArtifactRewardPriority),
}):OnChanged(function(values)
    config.ArtifactRewardPriority = selectionToList(values)
    saveConfig()
end)
JoinTab:AddToggle("AutoCardPick", {Title = "Auto Pick Card", Default = config.AutoCardPick}):OnChanged(function(value)
    config.AutoCardPick = value == true
    state.AutoCardPickOverride = nil
    saveConfig()
end)
JoinTab:AddDropdown("CardPriority", {
    Title = "Pick card priority",
    Values = modifierOptions(),
    Multi = true,
    Default = selectionToSet(config.CardPriority),
}):OnChanged(function(values)
    config.CardPriority = selectionToList(values)
    saveConfig()
end)
local function resetJoinAttempt()
    waitingForMapSelect = false
    joinBusy = false
    state.ActiveJoinTarget = nil
    state.JoinAttempt = (state.JoinAttempt or 0) + 1
    state.NextJoinAt = 0
end
local modeDropdown = JoinTab:AddDropdown("JoinMode", {Title = "Mode", Values = {"Story", "Infinite", "Raid", "Legend", "Artifact", "Trial", "ReZero", "WorldBoss"}, Default = config.GameMode})
worldDropdown = JoinTab:AddDropdown("JoinWorld", {Title = "World", Values = worldOptions(config.GameMode), Default = config.World})
actDropdown = JoinTab:AddDropdown("JoinAct", {Title = "Act", Values = actOptions(config.World, config.GameMode), Default = config.Act})
difficultyDropdown = JoinTab:AddDropdown("JoinDifficulty", {Title = "Difficulty", Values = {"Normal", "Hard", "None"}, Default = config.Difficulty})
modeDropdown:OnChanged(function(value)
    if refreshingJoinOptions then
        return
    end
    resetJoinAttempt()
    config.GameMode = value
    refreshWorlds()
    saveConfig()
    refreshStatusPanel()
end)
worldDropdown:OnChanged(function(value)
    if refreshingJoinOptions then
        return
    end
    resetJoinAttempt()
    config.World = value
    if config.GameMode == "Artifact" then config.ArtifactName = tostring(value) end
    refreshActs()
    saveConfig()
    refreshStatusPanel()
end)
actDropdown:OnChanged(function(value)
    if refreshingJoinOptions then
        return
    end
    resetJoinAttempt()
    config.Act = value
    saveConfig()
    refreshStatusPanel()
end)
difficultyDropdown:OnChanged(function(value)
    if refreshingJoinOptions then
        return
    end
    resetJoinAttempt()
    if config.GameMode == "Infinite" or config.GameMode == "Raid"
        or config.GameMode == "Legend" or config.GameMode == "Artifact" then
        config.Difficulty = "Hard"
        if tostring(value) ~= "Hard" then
            refreshingJoinOptions = true
            difficultyDropdown:SetValue("Hard")
            refreshingJoinOptions = false
        end
    elseif config.GameMode == "Trial" or config.GameMode == "ReZero" then
        config.Difficulty = "None"
        if tostring(value) ~= "None" then
            refreshingJoinOptions = true
            difficultyDropdown:SetValue("None")
            refreshingJoinOptions = false
        end
    elseif config.GameMode == "WorldBoss" then
        config.Difficulty = "None"
        if tostring(value) ~= "None" then
            refreshingJoinOptions = true
            difficultyDropdown:SetValue("None")
            refreshingJoinOptions = false
        end
    else
        config.Difficulty = tostring(value)
    end
    saveConfig()
    refreshStatusPanel()
end)
JoinTab:AddButton({Title = "Join Selected Map Now", Callback = joinSelectedMap})
            RiftTab:AddParagraph({Title = "Auto Join Rift", Content = "Uses the current Rift rotation in a solo Party and starts it through the native Party System."})
            RiftTab:AddToggle("AutoRift", {Title = "Enable Auto Join Rift", Default = config.AutoRift}):OnChanged(function(value)
                config.AutoRift = value == true
                if config.AutoRift then
                    ensureRiftTimer()
                    if not canUseLobby() then
                        task.spawn(function()
                            local ok, err = pcall(function()
                                local ts = game:GetService("TeleportService")
                                local ids = require(ReplicatedStorage:WaitForChild("PlaceIDs"))
                                ts:Teleport(ids.LobbyPlace, LocalPlayer)
                            end)
                            if not ok then warn("[AnimeOriginsUltimate] Rift lobby teleport failed: " .. tostring(err)) end
                        end)
                    end
                else
                    state.RiftBlockingJoin = false
                end
                saveConfig()
                refreshStatusPanel()
            end)
            RiftTab:AddToggle("AutoRiftLeave", {Title = "Auto Leave For Rift", Default = config.AutoRiftLeave}):OnChanged(function(value)
                config.AutoRiftLeave = value == true
                if config.AutoRift then ensureRiftTimer() end
                saveConfig()
                refreshStatusPanel()
            end)
            local riftMacroOptions = storyMacroOptions("ShibuyaTrainStation")
            local selectedRiftMacro = config.RiftMacro
            if selectedRiftMacro and not table.find(riftMacroOptions, selectedRiftMacro) then table.insert(riftMacroOptions, selectedRiftMacro) end
            RiftTab:AddDropdown("RiftMacro", {
                Title = "Rift Macro", Values = riftMacroOptions, Default = selectedRiftMacro or "None", Multi = false,
            }):OnChanged(function(value)
                config.RiftMacro = value ~= "None" and value or ""
                config.RiftNextCheckAt = 0
                state.RiftSweepResolved = false
                saveConfig()
                refreshStatusPanel()
            end)
            SettingsTab:AddToggle("HidePlayerNames", {Title = "Hide Player Names", Default = config.HidePlayerNames}):OnChanged(function(value)
    state.SetHidePlayerNames(value)
    saveConfig()
end)
toggle(SettingsTab, "AntiAFK", "Anti AFK")
SettingsTab:AddToggle("AutoReconnect", {Title = "Auto Reconnect", Default = config.AutoReconnect}):OnChanged(function(value)
    config.AutoReconnect = value == true
    saveConfig()
    if config.AutoReconnect and state.ReconnectController then state.ReconnectController.Scan() end
end)
SettingsTab:AddToggle("MobileButton", {Title = "Mobile UI Button", Default = config.MobileButton}):OnChanged(function(value)
    config.MobileButton = value
    if state.MobileButton then state.MobileButton.Enabled = value end
    saveConfig()
end)
SettingsTab:AddInput("FPSLimit", {
    Title = "FPS Limit", Default = tostring(config.FPSLimit),
    Placeholder = "60", Numeric = true, Finished = true,
}):OnChanged(function(value)
    state.SetFPSLimit(value)
    saveConfig()
end)
SettingsTab:AddToggle("FixLag", {
    Title = "Fix Lag (Low Detail)",
    Description = "Strips heavy 3D textures, VFX and sounds. Rejoin to restore visuals.",
    Default = config.FixLag == true,
}):OnChanged(function(value)
    state.SetFixLag(value)
    state.SetFPSLimit(config.FPSLimit)
    saveConfig()
end)
local JSON_LIMIT = AO_JSON_LIMIT
local function notify(title, content)
    Fluent:Notify({Title = title, Content = tostring(content), Duration = 6})
end
aoBuildNamedConfigManager({
    Tab = ConfigsTab, Prefix = "Lobby_Configs", Config = config, Defaults = defaults,
    RootFolder = configFolder, Folder = configsFolder, AutoSavePath = lobbyConfigPath,
    Normalize = normalizeLobbyConfig, Save = function() saveConfig() end, Notify = notify, State = state,
    Apply = function()
        state.SetHidePlayerNames(config.HidePlayerNames)
        state.SetBlackScreen(config.BlackScreen, true)
        state.SetFPSLimit(config.FPSLimit)
        state.SetFixLag(config.FixLag)
        state.SetFPSLimit(config.FPSLimit)
        if state.MobileButton then state.MobileButton.Enabled = config.MobileButton == true end
    end,
})
local configJsonInput = ConfigsTab:AddInput("ConfigJson", {
    Title = "Config JSON", Default = "", Placeholder = "Paste a config JSON bundle", Numeric = false, Finished = false,
})
local macroFiles = {}
if type(listfiles) == "function" and type(isfolder) == "function" and isfolder(macrosFolder) then
    local ok, files = pcall(listfiles, macrosFolder)
    if ok then
        for _, path in ipairs(files) do
            if string.lower(string.sub(path, -5)) == ".json" then
                local name = string.match(path, "([^/\\]+)%.json$")
                if name then table.insert(macroFiles, name) end
            end
        end
    end
end
table.sort(macroFiles)
local macroList = #macroFiles > 0 and table.concat(macroFiles, ", ") or "None"
if #macroList > 500 then macroList = string.sub(macroList, 1, 497) .. "..." end
MacroTab:AddParagraph({
    Title = "Macro Controls",
    Content = "Record is available inside a match. Play Macro is saved here and starts automatically in game.",
})
local function notifyIngameOnly()
    Fluent:Notify({
        Title = "Macro In-Game",
        Content = "Record and playback are available after entering a game",
        Duration = 5,
    })
end
MacroTab:AddButton({Title = "Record Macro", Callback = notifyIngameOnly})
MacroTab:AddToggle("PlayMacro", {Title = "Play Macro", Default = config.AutoPlayMacro}):OnChanged(function(value)
    config.AutoPlayMacro = value
    saveConfig()
end)
MacroTab:AddToggle("AutoRestartInfinite", {Title = "Auto Restart Infinite", Default = config.AutoRestartInfinite}):OnChanged(function(value)
    config.AutoRestartInfinite = value == true
    saveConfig()
end)
MacroTab:AddInput("AutoRestartInfiniteWave", {
    Title = "Restart Wave", Default = tostring(config.AutoRestartInfiniteWave),
    Placeholder = "100", Numeric = true, Finished = true,
}):OnChanged(function(value)
    config.AutoRestartInfiniteWave = math.max(1, math.floor(tonumber(value) or 100))
    saveConfig()
end)
MacroTab:AddParagraph({
    Title = "Macro JSON",
    Content = string.format("Saved macros: %d\n%s", #macroFiles, macroList),
})
local macroJsonInput = MacroTab:AddInput("MacroJson", {
    Title = "Macro JSON", Default = "", Placeholder = "Paste a macro or macro bundle", Numeric = false, Finished = false,
})
local function setJsonOutput(input, text)
    if #text > JSON_LIMIT then error("JSON exceeds the 2MB limit") end
    input:SetValue(text)
    local clipboard = type(setclipboard) == "function" and setclipboard
        or type(toclipboard) == "function" and toclipboard or nil
    if clipboard then pcall(clipboard, text) end
end
local function jsonText(input)
    local value = tostring(input.Value or "")
    if #value == 0 then error("JSON input is empty") end
    if #value > JSON_LIMIT then error("JSON input exceeds the 2MB limit") end
    return value
end
local function checkedEncode(value)
    local text = HttpService:JSONEncode(value)
    if #text > JSON_LIMIT then error("JSON output exceeds the 2MB limit") end
    return text
end
local function checkedDecode(input)
    local decoded = HttpService:JSONDecode(jsonText(input))
    if type(decoded) ~= "table" then error("JSON root must be an object") end
    return decoded
end
local function applyConfigFields(target, defaultsTable, source)
    local webhook = target.WebhookUrl
    for key in pairs(defaultsTable) do
        if key ~= "WebhookUrl" and key ~= "QuestRuntimeTarget" and source[key] ~= nil then
            target[key] = source[key]
        end
    end
    target.WebhookUrl, target.QuestRuntimeTarget = webhook, nil
end
local function exportConfigShare(notifyFn)
    local lobby = {}
    for key in pairs(defaults) do
        if key ~= "QuestRuntimeTarget" and key ~= "WebhookUrl" then lobby[key] = config[key] end
    end
    local ingame = {}
    local igDefaults = environment.AnimeOriginsIngameDefaults
    local igConfig = environment.AnimeOriginsIngameConfig
    if type(igDefaults) == "table" and type(igConfig) == "table" then
        for key in pairs(igDefaults) do
            if key ~= "QuestRuntimeTarget" and key ~= "WebhookUrl" then ingame[key] = igConfig[key] end
        end
    end
    local text = checkedEncode({format = "AnimeOriginsConfigBundle", version = 1, gameId = tostring(game.GameId), config = {Lobby = lobby, InGame = ingame}})
    local response = aoRequest({
        Url = "https://originsmarcoshare.netlify.app/api/macros",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = text,
    })
    if not response then error("Config upload request failed") end
    local status = tonumber(response.StatusCode or response.Status)
    if status and (status < 200 or status >= 300) then
        error("Config upload returned HTTP " .. tostring(status) .. ": " .. tostring(response.Body or ""))
    end
    local decoded = HttpService:JSONDecode(tostring(response.Body or ""))
    if type(decoded) ~= "table" or not decoded.shareUrl then error("Upload response has no share link") end
    return decoded.shareUrl, text
end
local function importConfigShare(rawText, notifyFn)
    if rawText == "" then error("Paste a config share link or JSON bundle") end
    if rawText:match("^https://") then rawText = fetchMacroShareInput(rawText) end
    local ok, bundle = pcall(function() return HttpService:JSONDecode(rawText) end)
    if not ok or type(bundle) ~= "table" then error("Config bundle JSON is invalid") end
    if bundle.format ~= "AnimeOriginsConfigBundle" or bundle.version ~= 1
        or tostring(bundle.gameId) ~= tostring(game.GameId) or type(bundle.config) ~= "table" then
        error("Invalid config bundle format, version, or gameId")
    end
    local cfg = type(bundle.config.Lobby) == "table" and bundle.config.Lobby or bundle.config
    local igc = type(bundle.config.InGame) == "table" and bundle.config.InGame or nil
    applyConfigFields(config, defaults, cfg)
    normalizeLobbyConfig(config)
    if igc then
        local igDefaults = environment.AnimeOriginsIngameDefaults
        local igConfig = environment.AnimeOriginsIngameConfig
        local igNormalize = environment.AnimeOriginsNormalizeIngame
        local igSave = environment.AnimeOriginsSaveLobbyConfig
        if type(igDefaults) == "table" and type(igConfig) == "table" then
            applyConfigFields(igConfig, igDefaults, igc)
            if type(igNormalize) == "function" then igNormalize(igConfig) end
            if type(igSave) == "function" then igSave(igConfig) end
        end
    end
    saveConfig()
    state.SetHidePlayerNames(config.HidePlayerNames)
    state.SetBlackScreen(config.BlackScreen, true)
    if state.MobileButton then state.MobileButton.Enabled = config.MobileButton == true end
end
environment.AnimeOriginsConfigShare = {Export = exportConfigShare, Import = importConfigShare}
local function validActions(actions)
    if type(actions) ~= "table" then return false end
    local count, highest = 0, 0
    for index, action in pairs(actions) do
        if type(index) ~= "number" or index < 1 or index % 1 ~= 0 or type(action) ~= "table" then return false end
        count, highest = count + 1, math.max(highest, index)
    end
    return count == highest
end
local function filenameMacroKey(path)
    local name = string.match(tostring(path or ""), "([^/\\]+)%.json$")
    if not name then return nil end
    local mode, world, act, difficulty = string.match(name, "^([^_]+)_(.+)_([^_]+)_([^_]+)$")
    return mode and table.concat({mode, world, act, difficulty}, "|") or name
end
local function payloadMacroKey(payload, path)
    if type(payload) ~= "table" then return filenameMacroKey(path) end
    return payload.MacroKey or payload.Key or payload.CanonicalMacroKey
        or type(payload.Map) == "table" and (payload.Map.CanonicalMacroKey
            or payload.Map.GameMode and payload.Map.WorldName and payload.Map.Act and payload.Map.Difficulty
                and table.concat({tostring(payload.Map.GameMode), tostring(payload.Map.WorldName),
                    tostring(payload.Map.Act), tostring(payload.Map.Difficulty)}, "|"))
        or filenameMacroKey(path)
end
local function payloadActions(payload)
    if type(payload) ~= "table" then return nil end
    return validActions(payload.Actions) and payload.Actions or validActions(payload) and payload or nil
end
local function safeMacroName(key)
    key = tostring(key or "")
    if key == "" or string.find(key, "[%z\1-\31]") then return nil end
    local name = string.gsub(key, "[^A-Za-z0-9_-]", "_")
    name = string.gsub(name, "^_+", "")
    return name ~= "" and string.sub(name, 1, 180) or nil
end
local function withJsonError(callback)
    return function()
        local ok, result = pcall(callback)
        if not ok then notify("JSON Error", result) end
    end
end
local function showLobbyMacroImportPopup(imports, onApply, notifyFn)
    local CoreGui = game:GetService("CoreGui")
    local function popupNotify(title, content)
        pcall(function()
            if type(notifyFn) == "function" then notifyFn(title, content)
            elseif Fluent then Fluent:Notify({Title = title, Content = content, Duration = 6}) end
        end)
    end
    local names = {}
    for key in pairs(imports) do
        if type(key) == "string" and key ~= "" and imports[key] then table.insert(names, key) end
    end
    table.sort(names, function(a, b) return string.lower(a) < string.lower(b) end)
    if #names == 0 then
        popupNotify("Import Macro", "Bundle contains no macros.")
        return
    end
    local old = CoreGui:FindFirstChild("AnimeOriginsMacroImport")
    if old then old:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "AnimeOriginsMacroImport"
    gui.DisplayOrder = 10000
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    local parented = pcall(function() gui.Parent = CoreGui end)
    if not parented then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    local shade = Instance.new("TextButton")
    shade.AutoButtonColor = false
    shade.Text = ""
    shade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shade.BackgroundTransparency = 0.25
    shade.Size = UDim2.fromScale(1, 1)
    shade.Parent = gui
    local panel = Instance.new("Frame")
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position = UDim2.fromScale(0.5, 0.5)
    panel.Size = UDim2.new(0.88, 0, 0.78, 0)
    panel.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    panel.Parent = shade
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
    local constraint = Instance.new("UISizeConstraint", panel)
    constraint.MinSize = Vector2.new(290, 330)
    constraint.MaxSize = Vector2.new(520, 560)
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(18, 14)
    title.Size = UDim2.new(1, -36, 0, 26)
    title.Font = Enum.Font.GothamBold
    title.Text = "Import Macro from link"
    title.TextColor3 = Color3.fromRGB(245, 245, 248)
    title.TextSize = 19
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel
    local details = Instance.new("TextLabel")
    details.BackgroundTransparency = 1
    details.Position = UDim2.fromOffset(18, 42)
    details.Size = UDim2.new(1, -36, 0, 22)
    details.Font = Enum.Font.Gotham
    details.Text = tostring(#names) .. " Macro | Only ticked entries are imported"
    details.TextColor3 = Color3.fromRGB(165, 168, 180)
    details.TextSize = 12
    details.TextXAlignment = Enum.TextXAlignment.Left
    details.Parent = panel
    local selected, rows = {}, {}
    for _, name in ipairs(names) do selected[name] = true end
    local selectAll = Instance.new("TextButton")
    selectAll.AutoButtonColor = false
    selectAll.BackgroundColor3 = Color3.fromRGB(37, 39, 49)
    selectAll.Position = UDim2.fromOffset(18, 70)
    selectAll.Size = UDim2.new(1, -36, 0, 34)
    selectAll.Font = Enum.Font.GothamSemibold
    selectAll.TextColor3 = Color3.fromRGB(220, 222, 230)
    selectAll.TextSize = 13
    Instance.new("UICorner", selectAll).CornerRadius = UDim.new(0, 7)
    selectAll.Parent = panel
    local list = Instance.new("ScrollingFrame")
    list.BackgroundTransparency = 1
    list.BorderSizePixel = 0
    list.Position = UDim2.fromOffset(18, 112)
    list.Size = UDim2.new(1, -36, 1, -178)
    list.ScrollBarThickness = 4
    list.ScrollBarImageColor3 = Color3.fromRGB(100, 105, 125)
    list.CanvasSize = UDim2.fromOffset(0, 0)
    list.Parent = panel
    local layout = Instance.new("UIListLayout", list)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    local function renderSelectAll()
        local count = 0
        for _, name in ipairs(names) do if selected[name] then count += 1 end end
        selectAll.Text = (count == #names and "[x] " or "[ ] ") .. "Select all (" .. tostring(count) .. "/" .. tostring(#names) .. ")"
    end
    for index, name in ipairs(names) do
        local row = Instance.new("TextButton")
        row.AutoButtonColor = false
        row.BackgroundColor3 = Color3.fromRGB(31, 33, 42)
        row.Size = UDim2.new(1, -6, 0, 40)
        row.LayoutOrder = index
        row.Font = Enum.Font.Gotham
        row.Text = "[x]  " .. name .. "  (" .. tostring(#imports[name]) .. ")"
        row.TextColor3 = Color3.fromRGB(232, 233, 239)
        row.TextSize = 13
        row.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)
        local padding = Instance.new("UIPadding", row)
        padding.PaddingLeft = UDim.new(0, 12)
        row.Parent = list
        rows[name] = row
        row.Activated:Connect(function()
            selected[name] = not selected[name]
            row.Text = (selected[name] and "[x]  " or "[ ]  ") .. name .. "  (" .. tostring(#imports[name]) .. ")"
            renderSelectAll()
        end)
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        list.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 4)
    end)
    renderSelectAll()
    selectAll.Activated:Connect(function()
        local enable = false
        for _, name in ipairs(names) do if not selected[name] then enable = true break end end
        for _, name in ipairs(names) do
            selected[name] = enable
            rows[name].Text = (enable and "[x]  " or "[ ]  ") .. name .. "  (" .. tostring(#imports[name]) .. ")"
        end
        renderSelectAll()
    end)
    local cancel = Instance.new("TextButton")
    cancel.BackgroundColor3 = Color3.fromRGB(46, 48, 59)
    cancel.Position = UDim2.new(0, 18, 1, -54)
    cancel.Size = UDim2.new(0.38, -4, 0, 38)
    cancel.Font = Enum.Font.GothamSemibold
    cancel.Text = "Cancel"
    cancel.TextColor3 = Color3.fromRGB(225, 226, 232)
    cancel.TextSize = 13
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 7)
    cancel.Parent = panel
    cancel.Activated:Connect(function() gui:Destroy() end)
    local confirm = Instance.new("TextButton")
    confirm.BackgroundColor3 = Color3.fromRGB(86, 118, 255)
    confirm.Position = UDim2.new(0.38, 22, 1, -54)
    confirm.Size = UDim2.new(0.62, -40, 0, 38)
    confirm.Font = Enum.Font.GothamBold
    confirm.Text = "Import selected"
    confirm.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirm.TextSize = 13
    Instance.new("UICorner", confirm).CornerRadius = UDim.new(0, 7)
    confirm.Parent = panel
    confirm.Activated:Connect(function()
        local picked = {}
        for _, name in ipairs(names) do if selected[name] then picked[name] = imports[name] end end
        gui:Destroy()
        if next(picked) then
            if onApply then onApply(picked) end
        else
            popupNotify("Import Macro", "No macro was selected.")
        end
    end)
end
environment.AnimeOriginsImportPopup = showLobbyMacroImportPopup
ConfigsTab:AddButton({Title = "Export Config Share Link", Callback = withJsonError(function()
    local shareUrl, text = exportConfigShare(notify)
    configJsonInput:SetValue(shareUrl)
    local clipboard = type(setclipboard) == "function" and setclipboard or type(toclipboard) == "function" and toclipboard or nil
    if clipboard then pcall(clipboard, shareUrl) end
    notify("Config Share Link", "Uploaded config: " .. shareUrl)
end)})
ConfigsTab:AddButton({Title = "Import Config from Link / JSON", Callback = withJsonError(function()
    importConfigShare(tostring(configJsonInput.Value or ""):match("^%s*(.-)%s*$"), notify)
    notify("Config Imported", "Allowed settings were saved. Rerun the script to apply all controls.")
end)})
function state.UploadLobbyMacroShare(currentOnly)
    local macros, count = {}, 0
    if currentOnly then
        local mode, world, act, difficulty = config.GameMode, config.World, config.Act, config.Difficulty
        if mode == "Trial" and world == "PleiadesGrass" then
            mode, act, difficulty = "ReZero", "1", "Normal"
        elseif mode == "Trial" then
            mode, world, act, difficulty = "Story", "SandVillage", "MadaraStage", "Normal"
        elseif mode == "Infinite" or mode == "Legend" then
            mode = "Story"
        elseif mode == "Artifact" then
            local info = artifactMapInfo(config.ArtifactName)
            if info then world, act, difficulty = info.WorldName, info.Act, info.Difficulty end
        end
        local key = table.concat({tostring(mode), tostring(world), tostring(act), tostring(difficulty)}, "|")
        local path = macrosFolder .. "/" .. string.gsub(key, "[^%w%-_]", "_") .. ".json"
        if type(isfile) ~= "function" or not isfile(path) then error("No saved macro for " .. key) end
        local ok, payload = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
        local savedKey = ok and payloadMacroKey(payload, path) or nil
        local actions = ok and payloadActions(payload) or nil
        if not actions then error("Invalid macro for " .. key) end
        if savedKey and tostring(savedKey) ~= key then error("Selected macro belongs to " .. tostring(savedKey)) end
        macros[key], count = actions, 1
    elseif type(listfiles) == "function" and type(isfolder) == "function" and isfolder(macrosFolder) then
        for _, path in ipairs(listfiles(macrosFolder)) do
            if string.lower(string.sub(path, -5)) == ".json" then
                local ok, payload = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
                local key = ok and payloadMacroKey(payload, path) or nil
                local actions = ok and payloadActions(payload) or nil
                if key and actions then macros[tostring(key)], count = actions, count + 1 end
            end
        end
    end
    if count == 0 then error("No macros to upload") end
    local text = checkedEncode({format = "AnimeOriginsMacros", version = 2, gameId = tostring(game.GameId), macros = macros})
    local response = aoRequest({
        Url = "https://originsmarcoshare.netlify.app/api/macros",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = text,
    })
    if not response then error("Macro upload request failed") end
    local status = tonumber(response.StatusCode or response.Status)
    if status and (status < 200 or status >= 300) then
        error("Macro upload returned HTTP " .. tostring(status) .. ": " .. tostring(response.Body or ""))
    end
    local decoded = HttpService:JSONDecode(tostring(response.Body or ""))
    if type(decoded) ~= "table" or not decoded.shareUrl then error("Upload response has no share link") end
    macroJsonInput:SetValue(decoded.shareUrl)
    local clipboard = type(setclipboard) == "function" and setclipboard or type(toclipboard) == "function" and toclipboard or nil
    if clipboard then pcall(clipboard, decoded.shareUrl) end
    notify("Macro Share Link", "Uploaded " .. count .. " macro(s): " .. decoded.shareUrl)
end
MacroTab:AddButton({Title = "Share Current Macro", Callback = withJsonError(function()
    state.UploadLobbyMacroShare(true)
end)})
MacroTab:AddButton({Title = "Share All Macros", Callback = withJsonError(function()
    state.UploadLobbyMacroShare(false)
end)})
MacroTab:AddButton({Title = "Import Macros JSON", Callback = withJsonError(function()
    if type(writefile) ~= "function" then error("Local file writing is unavailable") end
    saveConfig()
    local rawText = tostring(macroJsonInput.Value or ""):match("^%s*(.-)%s*$")
    if rawText:match("^https://") then rawText = fetchMacroShareInput(rawText) end
    local decoded, imports = HttpService:JSONDecode(rawText), {}
    local singleActions = payloadActions(decoded)
    if singleActions then
        local key = decoded.Actions and payloadMacroKey(decoded) or nil
        if not key then error("A raw actions array has no MacroKey; the target stage is unknown") end
        imports[tostring(key)] = singleActions
    else
        local acceptedFormat = decoded.format == "AnimeOriginsMacros" or decoded.format == "AnimeOriginsMacroBundle"
        local acceptedGame = decoded.gameId == nil or tostring(decoded.gameId) == tostring(game.GameId) or tostring(decoded.gameId) == tostring(game.PlaceId)
        if not acceptedFormat or (tonumber(decoded.version) ~= 1 and tonumber(decoded.version) ~= 2)
            or not acceptedGame or type(decoded.macros) ~= "table" then
            error("Invalid macro bundle format, version, or gameId")
        end
        for rawKey, payload in pairs(decoded.macros) do
            if type(rawKey) ~= "string" or rawKey == "" then error("Invalid macro key: " .. tostring(rawKey)) end
            local actions = payloadActions(payload)
            if not actions then error("Invalid actions for macro: " .. tostring(rawKey)) end
            local key = type(payload) == "table" and payload.Actions and payloadMacroKey(payload) or rawKey
            key = key or rawKey
            if not key then error("Macro target stage is unknown: " .. tostring(rawKey)) end
            imports[tostring(key)] = actions
        end
    end
    environment.AnimeOriginsImportPopup(imports, function(picked)
        local count = 0
        for key, actions in pairs(picked) do
            local name = safeMacroName(key)
            if not name then error("Could not derive a safe macro filename for: " .. tostring(key)) end
            local text = checkedEncode({Format = "AnimeOriginsMacro", Version = 2, MacroKey = key, Actions = actions})
            writefile(macrosFolder .. "/" .. name .. ".json", text)
            count += 1
        end
        notify("Macros Imported", string.format("Imported %d validated macro(s).", count))
    end, notify)
end)})
local function createMobileButton()
    for _, parent in ipairs({game:GetService("CoreGui"), LocalPlayer:WaitForChild("PlayerGui")}) do
        local old = parent:FindFirstChild("AnimeOriginsMobileButton")
        if old then old:Destroy() end
    end
    local gui = Instance.new("ScreenGui")
    gui.Name = "AnimeOriginsMobileButton"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 2000
    local button = Instance.new("ImageButton")
    button.Name = "OpenUI"
    button.AnchorPoint = Vector2.new(1, 0.5)
    button.Position = UDim2.new(1, -14, 0.38, 0)
    button.Size = UDim2.fromOffset(45, 45)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.BorderSizePixel = 0
    button.ScaleType = Enum.ScaleType.Crop
    button.Parent = gui
    applyGameIcon(button)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    table.insert(state.Connections, button.Activated:Connect(function()
        local toggled = pcall(function()
            local input = game:GetService("VirtualInputManager")
            input:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
            task.wait(0.1)
            input:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
        end)
        if not toggled then pcall(function() Window:Minimize() end) end
    end))
    local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not ok then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    state.MobileButton = gui
    gui.Enabled = config.MobileButton
end
createMobileButton()
saveConfig()
            Fluent:Notify({Title = "Anime Origins Ultimate", Content = "Loaded. Configure Auto Quest, Auto Claim, and map automation from the tabs.", Duration = 5})
            end
            buildUI()
