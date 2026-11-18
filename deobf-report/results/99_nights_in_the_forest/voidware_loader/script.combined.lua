--======================================================================
-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации
-- Игра/тема: 99_nights_in_the_forest · Сэмпл: voidware_loader
-- Каталог:   deobf-report/results/99_nights_in_the_forest/voidware_loader/
-- Дата сборки: 2026-11-17 · Сгенерировано deobf-report/tools/build_combined.py
--
-- Состав (в этом порядке):
--   * PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии
--   * script.lua — ниже дословно (sha256=5b759f6d44811853a6ce4ec66a34a0e7bcf84b00e552b1d83ce31fe02d71538c)
--
-- Раздел 1/2 ниже — содержимое PARTS.md, построчно как Lua-комментарии.
-- Раздел 2/2 — восстановленный код (script.lua) ДОСЛОВНО, без изменений.
-- Комментарии в этом файле НЕ являются частью исходного кода игры.
-- ВНИМАНИЕ: это чужой код (игровой скрипт/хаб). Не запускайте его в Roblox,
-- не понимая, что он делает; результаты получены статической деобфускацией.
--======================================================================
--======================================================================
-- РАЗДЕЛ 1/2: PARTS.md (инвентарь: механики / Roblox API / имена функций / парты)
--======================================================================
-- ## Что делает (по восстановленному коду)
--
-- - **сеть / загрузка кода** — улики: `discord`, `httpget`, `loadstring`, `require`
-- - **телепорт / движение** — улики: `teleport`
--
-- ## Вызовы API
--
-- - Сервисы: `Players`, `StarterGui`, `Workspace`
-- - Классы/объекты: `TextChatMessageProperties`
-- - Методы: `GetService`×14, `loadstring`×11, `HttpGet`×9, `FindFirstChild`×6, `Destroy`×2, `Connect`×1
--
-- ## Имена функций (6)
--
-- `checkExecutor`, `checkDebug`, `__index`, `__call`, `__newindex`, `traceback`
--
-- ## Строковые константы (UI, подписи)
--
-- - `SendNotification` ×10
-- - `<font color=` ×8
-- - `__OwnsVIPGamepass` ×4
-- - `VIPChatTag` ×4
-- - `_CurrentLevel` ×4
-- - `>[</font><font color=` ×4
-- - `>]</font> ` ×4
-- - `PlayerTagValue` ×4
-- - `voidware_libraries/loader.lua` ×3
-- - `queue_on_teleport disabled!` ×2
-- - `Not Implemented` ×2
-- - `{key}` ×2
-- - `>[VIP]</font> ` ×2
-- - `>%s</font><font color=` ×2
-- - `>#%s</font><font color=` ×2
--
-- ## Ссылки / webhooks / ассеты (6)
--
-- - `https://raw.githubusercontent.com/VapeVoidware/VW-Add/`
-- - `https://raw.githubusercontent.com/VapeVoidware/VWRewrite/`
-- - `https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua`
-- - `https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader2.lua`
-- - `https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest2.lua`
-- - `https://raw.githubusercontent.com/VapeVoidware/VWExtra/3ec1c4abde539b3587265577e5c3dfe94d2f1b30/libraries/loader.lua`
--
-- ## Парты / объекты (142)
--
-- - через `WaitForChild`/`FindFirstChild`: `PlayerTagValue`
-- - идентификаторы в коде: `ACTIVE_LOADER`, `AND`, `Abort`, `Add`, `Bedwars`, `Booting`, `COPY`, `ChatService`, `ChatVersion`, `CheatEngineMode`, `Color3`, `ColorSequenceKeypoint`, `Colors`, `Connect`, `CustomCommit`, `CustomPrefix`, `Data`, `Destroy`, `Duration`, `EXECUTOR`, `EXPLOITS`, `Enum`, `Error`, `FULL`, `Failed`, `Fetching`, `FindFirstChild`, `Finishing`, `For`, `ForcePlayerGui`, `Forest`, `Forsaken`, `Functions`, `GUI`, `Game`, `GameId`, `GetAttribute`, `GetPlayerByUserId`, `GetService`, `Gradient`
--======================================================================
-- КОНЕЦ PARTS.md
--======================================================================
-- РАЗДЕЛ 2/2: восстановленный код (дословно)
--======================================================================
-- VoidWare — 99 Nights In The Forest: публичная ЦЕПОЧКА ЗАГРУЗЧИКОВ (plain Lua, получена как есть).
-- Каждый раздел — дословно файл по указанному URL; файлы не редактировались.
-- Финальная полезная нагрузка — Luraph v14.7, НЕ деобфусцирована (см. LOG.txt/RECOVERY).

-- ============================================================
-- SECTION: 00_voidware_entry.lua
-- SOURCE : EXPLOITS-SCRIPTS repo: exploiters-scripts/99NightsInTheForest-Script → файл «VoidWare» (точка входа анти-debug/executor-проверки)
-- ============================================================

--[[
██╗   ██╗ ██████╗ ██╗██████╗ ██╗    ██╗ █████╗ ██████╗ ███████╗
██║   ██║██╔═══██╗██║██╔══██╗██║    ██║██╔══██╗██╔══██╗██╔════╝
██║   ██║██║   ██║██║██║  ██║██║ █╗ ██║███████║██████╔╝█████╗  
╚██╗ ██╔╝██║   ██║██║██║  ██║██║███╗██║██╔══██║██╔═══╝ ██╔══╝  
 ╚████╔╝ ╚██████╔╝██║██████╔╝╚███╔███╔╝██║  ██║██║     ███████╗
  ╚═══╝   ╚═════╝ ╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚══════╝

                🚀 VOIDWARE — 99 Nights In The Forest 🚀
----------------------------------------------------------------------------
  IMPORTANT:
  You must copy and use the FULL script below. Do NOT press on the link.:

  loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))()

----------------------------------------------------------------------------
  For support head over to discord.gg/voidware
----------------------------------------------------------------------------
]]
if not game:IsLoaded() then return end
local CheatEngineMode = false
if (not getgenv) or (getgenv and type(getgenv) ~= "function") then CheatEngineMode = true end
if getgenv and not getgenv().shared then CheatEngineMode = true; getgenv().shared = {}; end
if getgenv and not getgenv().debug then CheatEngineMode = true; getgenv().debug = {traceback = function(string) return string end} end
if getgenv and not getgenv().require then CheatEngineMode = true; end
if getgenv and getgenv().require and type(getgenv().require) ~= "function" then CheatEngineMode = true end
local debugChecks = {
    Type = "table",
    Functions = {
        "getupvalue",
        "getupvalues",
        "getconstants",
        "getproto"
    }
}
local function checkExecutor()
    if identifyexecutor ~= nil and type(identifyexecutor) == "function" then
        local suc, res = pcall(function()
            return identifyexecutor()
        end)   
        --local blacklist = {'appleware', 'cryptic', 'delta', 'wave', 'codex', 'swift', 'solara', 'vega'}
        local blacklist = {'solara', 'cryptic', 'xeno', 'ember', 'ronix'}
        local core_blacklist = {'solara', 'xeno'}
        if suc then
            for i,v in pairs(blacklist) do
                if string.find(string.lower(tostring(res)), v) then CheatEngineMode = true end
            end
            for i,v in pairs(core_blacklist) do
                if string.find(string.lower(tostring(res)), v) then
                    pcall(function()
                        getgenv().queue_on_teleport = function() warn('queue_on_teleport disabled!') end
                    end)
                end
            end
            if string.find(string.lower(tostring(res)), "delta") then
                getgenv().isnetworkowner = function()
                    return true
                end
            end
        end
    end
end
task.spawn(function() pcall(checkExecutor) end)
local function checkDebug()
    if CheatEngineMode then return end
    if not getgenv().debug then 
        CheatEngineMode = true 
    else 
        if type(debug) ~= debugChecks.Type then 
            CheatEngineMode = true
        else 
            for i, v in pairs(debugChecks.Functions) do
                if not debug[v] or (debug[v] and type(debug[v]) ~= "function") then 
                    CheatEngineMode = true 
                else
                    local suc, res = pcall(debug[v]) 
                    if tostring(res) == "Not Implemented" then 
                        CheatEngineMode = true 
                    end
                end
            end
        end
    end
end
--if (not CheatEngineMode) then checkDebug() end
shared.CheatEngineMode = shared.CheatEngineMode or CheatEngineMode
shared.ForcePlayerGui = true

if game.PlaceId == 79546208627805 then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Voidware | 99 Nights In The Forest",
            Text = "Go In Game for Voidware to load :D [You are in lobby currently]",
            Duration = 10
        })
    end)
    return
end 

task.spawn(function()
    pcall(function()
        local Services = setmetatable({}, {
            __index = function(self, key)
                local suc, service = pcall(game.GetService, game, key)
                if suc and service then
                    self[key] = service
                    return service
                else
                    warn(`[Services] Warning: "{key}" is not a valid Roblox service.`)
                    return nil
                end
            end
        })

        local Players = Services.Players
        local TextChatService = Services.TextChatService
        local ChatService = Services.ChatService
        repeat
            task.wait()
        until game:IsLoaded() and Players.LocalPlayer ~= nil
        local chatVersion = TextChatService and TextChatService.ChatVersion or Enum.ChatVersion.LegacyChatService
        local TagRegister = shared.TagRegister or {}
        if not shared.CheatEngineMode then
            --if chatVersion == Enum.ChatVersion.TextChatService then
                TextChatService.OnIncomingMessage = function(data)
                    TagRegister = shared.TagRegister or {}
                    local properties = Instance.new("TextChatMessageProperties", game:GetService("Workspace"))
                    local TextSource = data.TextSource
                    local PrefixText = data.PrefixText or ""
                    if TextSource then
                        local plr = Players:GetPlayerByUserId(TextSource.UserId)
                        if plr then
                            local prefix = ""
                            if TagRegister[plr] then
                                prefix = prefix .. TagRegister[plr]
                            end
                            if plr:GetAttribute("__OwnsVIPGamepass") and plr:GetAttribute("VIPChatTag") ~= false then
                                prefix = prefix .. "<font color='rgb(255,210,75)'>[VIP]</font> "
                            end
                            local currentLevel = plr:GetAttribute("_CurrentLevel")
                            if currentLevel then
                                prefix = prefix .. string.format("<font color='rgb(173,216,230)'>[</font><font color='rgb(255,255,255)'>%s</font><font color='rgb(173,216,230)'>]</font> ", tostring(currentLevel))
                            end
                            local playerTagValue = plr:FindFirstChild("PlayerTagValue")
                            if playerTagValue and playerTagValue.Value then
                                prefix = prefix .. string.format("<font color='rgb(173,216,230)'>[</font><font color='rgb(255,255,255)'>#%s</font><font color='rgb(173,216,230)'>]</font> ", tostring(playerTagValue.Value))
                            end
                            prefix = prefix .. PrefixText
                            properties.PrefixText = string.format("<font color='rgb(255,255,255)'>%s</font>", prefix)
                        end
                    end
                    return properties
                end
            --[[elseif chatVersion == Enum.ChatVersion.LegacyChatService then
                ChatService:RegisterProcessCommandsFunction("CustomPrefix", function(speakerName, message)
                    TagRegister = shared.TagRegister or {}
                    local plr = Players:FindFirstChild(speakerName)
                    if plr then
                        local prefix = ""
                        if TagRegister[plr] then
                            prefix = prefix .. TagRegister[plr]
                        end
                        if plr:GetAttribute("__OwnsVIPGamepass") and plr:GetAttribute("VIPChatTag") ~= false then
                            prefix = prefix .. "[VIP] "
                        end
                        local currentLevel = plr:GetAttribute("_CurrentLevel")
                        if currentLevel then
                            prefix = prefix .. string.format("[%s] ", tostring(currentLevel))
                        end
                        local playerTagValue = plr:FindFirstChild("PlayerTagValue")
                        if playerTagValue and playerTagValue.Value then
                            prefix = prefix .. string.format("[#%s] ", tostring(playerTagValue.Value))
                        end
                        prefix = prefix .. speakerName
                        return prefix .. " " .. message
                    end
                    return message
                end)
            end--]]
        end
    end)
end)

local commit = shared.CustomCommit and tostring(shared.CustomCommit) or shared.StagingMode and "staging" or "0e5c57c1c5a062b8b521818e366e7823893000a9"

loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/"..tostring(commit).."/newnightsintheforest.lua", true))()

-- ============================================================
-- SECTION: 01_loader.lua
-- SOURCE : VapeVoidware/VW-Add@main:loader.lua (заглушка-редирект)
-- ============================================================

-- COPY THIS AND PASTE IT IN YOUR EXECUTOR 👇
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader2.lua", true))()


-- ============================================================
-- SECTION: 02_loader2.lua
-- SOURCE : VapeVoidware/VW-Add@main:loader2.lua (основной plain-загрузчик: реестр игр, Obsidian GUI, оркестрация)
-- ============================================================

--[[
██╗   ██╗ ██████╗ ██╗██████╗ ██╗    ██╗ █████╗ ██████╗ ███████╗
██║   ██║██╔═══██╗██║██╔══██╗██║    ██║██╔══██╗██╔══██╗██╔════╝
██║   ██║██║   ██║██║██║  ██║██║ █╗ ██║███████║██████╔╝█████╗  
╚██╗ ██╔╝██║   ██║██║██║  ██║██║███╗██║██╔══██║██╔═══╝ ██╔══╝  
 ╚████╔╝ ╚██████╔╝██║██████╔╝╚███╔███╔╝██║  ██║██║     ███████╗
  ╚═══╝   ╚═════╝ ╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚══════╝

                🚀 VOIDWARE — Loader 🚀
----------------------------------------------------------------------------
  IMPORTANT:
  You must copy and use the FULL script below. Do NOT press on the link.:

  loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))()

----------------------------------------------------------------------------
  For support head over to discord.gg/voidware
----------------------------------------------------------------------------
]]
repeat
	task.wait()
until game:IsLoaded()
local meta = {
	[2619619496] = {
		title = "Bedwars",
		dev = "vwdev/vwrw.lua",
		script = "https://raw.githubusercontent.com/VapeVoidware/VWRewrite/" .. (shared.CustomCommit and tostring(
			shared.CustomCommit
		) or "main") .. "/NewMainScript.lua",
	},
	[7008097940] = {
		no = true,
		title = "Ink Game",
		dev = "vwdev/inkgame.lua",
		script = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/" .. (shared.CustomCommit and tostring(
			shared.CustomCommit
		) or "main") .. "/inkgame.lua",
	},
	[6331902150] = {
		title = "Forsaken",
		dev = "vwdev/forsaken.lua",
		script = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/" .. (shared.CustomCommit and tostring(
			shared.CustomCommit
		) or "main") .. "/forsaken.lua",
	},
	[7326934954] = {
		title = "99 Nights In The Forest",
		dev = "vwdev/nightsintheforest.lua",
		script = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/" .. (shared.CustomCommit and tostring(
			shared.CustomCommit
		) or "main") .. "/nightsintheforest.lua",
	}
}
local data = meta[game.GameId]
pcall(function()
	shared.ACTIVE_LOADER:Destroy()
end)
local timedFunction = function(call, timeout, resFunction, ...)
	local suc, err
	local args = {}
	if call ~= nil and call == true then
		call = timeout
		timeout = 5
		args = { resFunction, ... }
	end
	task.spawn(function()
		suc, err = pcall(function()
			return call(unpack(args))
		end)
	end)
	timeout = timeout or 5
	local start = tick()
	repeat
		task.wait()
	until suc ~= nil or tick() - start >= timeout
	if suc == nil then
		suc = false
		err = "TIMEOUT_EXCEEDED"
	end
	if not suc then
		warn(debug.traceback(err))
	end
	if resFunction ~= nil and type(resFunction) == "function" then
		return resFunction(suc, err)
	end
	return suc, err
end
local __def_table = setmetatable({}, {
	__index = function(self)
		return self
	end,
	__call = function(self)
		return self
	end,
	__newindex = function(self)
		return self
	end,
})
local loaderFile
if data ~= nil and data.no then
	loaderFile = __def_table
end
loaderFile = loaderFile
	or timedFunction(
		function()
			local data = game:HttpGet(
				"https://raw.githubusercontent.com/VapeVoidware/VWExtra/3ec1c4abde539b3587265577e5c3dfe94d2f1b30/libraries/loader.lua",
				true
			)
			if data ~= nil then
				timedFunction(function()
					if not isfolder("voidware_libraries") then
						makefolder("voidware_libraries")
					end
					writefile("voidware_libraries/loader.lua", data)
				end, 1)
			end
			return loadstring(data)()
		end,
		5,
		function(suc, err)
			return suc and err
				or timedFunction(
					function()
						if not isfolder("voidware_libraries") then
							makefolder("voidware_libraries")
						end
						if not isfile("voidware_libraries/loader.lua") then
							error("loader file missing!")
							return
						end
						return loadstring(readfile("voidware_libraries/loader.lua"))()
					end,
					5,
					function(suc, err)
						return suc and err or __def_table
					end
				)
		end
	)
loaderFile.Colors.Gradient = {
	ColorSequenceKeypoint.new(0, Color3.fromHex("#ffd6e8")),
	ColorSequenceKeypoint.new(0.5, Color3.fromHex("#ff8fab")),
	ColorSequenceKeypoint.new(1, Color3.fromHex("#ff477e")),
}
local stitle = "Voidware"
local sicon = nil
pcall(function()
	if tostring(shared.VOIDWARE_SCRIPT_TYPE) == "99_NIGHTS_7Z" then
		loaderFile.Colors.Gradient = {
			ColorSequenceKeypoint.new(0, Color3.fromHex("#e879f9")),
			ColorSequenceKeypoint.new(0.5, Color3.fromHex("#c026d3")),
			ColorSequenceKeypoint.new(1, Color3.fromHex("#7b2fff")),
		}
		stitle = "Pedrin Hub"
		sicon = "rbxassetid://112092059649589"
	end
end)
local loader = loaderFile:Loader(sicon)
shared.ACTIVE_LOADER = loader
loader:Connect(function(res)
	if shared.VoidDev then
		warn(`LOADER RESULT: {tostring(res)}`)
	end
	shared.ACTIVE_LOADER = nil
end)
loader:Update("Booting Up...", 0)
loader:Update("Fetching Game Data...", 10)

if data and data.staging and not shared.VoidDev then
	data = nil
end
if not data then
	loader:Abort(`Unsupported game :c`)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = stitle .. " | Loader",
		Text = "Unsupported game :c",
		Duration = 15,
	})
	return
else
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = stitle .. " | Loader",
		Text = "Loading for " .. tostring(data.title) .. "...",
		Duration = 15,
	})
	loader:Update(`Preparing {tostring(stitle)} {tostring(data.title)}...`, 40)
	local res, err
	if shared.VoidDev and data.dev ~= nil and pcall(function()
		return isfile(data.dev)
	end) then
		res, err = loadstring(readfile(data.dev))
	else
		res, err = loadstring(game:HttpGet(data.script, true))
	end
	if type(res) ~= "function" then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = stitle .. " Loading Error",
			Text = tostring(res),
			Duration = 15,
		})
		loader:Abort(`Loading Failed {tostring(err)} :c \n Please try again later\n`)
		task.delay(0.5, function()
			if shared.VoidDev then
				return
			end
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = stitle .. " Loading Error",
				Text = "Please report this issue to erchodev#0 \n or in discord.gg/voidware",
				Duration = 15,
			})
		end)
	else
		loader:Update(`Loading {tostring(stitle)}...`, 60)
		local suc, err = pcall(res)
		if not suc then
			loader:Abort(`Main Loading Error {tostring(err)} :c \n Please try again later\n`)
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = stitle .. " Main Error",
				Text = tostring(err),
				Duration = 15,
			})
			task.delay(0.5, function()
				if shared.VoidDev then
					return
				end
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = stitle .. " Main Error",
					Text = "Please report this issue to erchodev#0 \n or in discord.gg/voidware",
					Duration = 15,
				})
			end)
		else
			loader:Update(`Finishing Up...`, 80)
			shared.ACTIVE_LOADER = nil
			loader:Update(`Successfully loaded {tostring(stitle)} {tostring(data.title)} :D`, 100)
			task.delay(0.5, function()
				pcall(function()
					loader:Destroy()
				end)
			end)
		end
	end
end

-- ============================================================
-- SECTION: 03_nightsintheforest.lua
-- SOURCE : VapeVoidware/VW-Add@main:nightsintheforest.lua (редирект конкретно под 99 Nights)
-- ============================================================

-- COPY THIS AND PASTE IT IN YOUR EXECUTOR 👇
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest2.lua", true))()


-- ============================================================
-- SECTION: 04_nightsintheforest2.lua
-- SOURCE : VapeVoidware/VW-Add@main:nightsintheforest2.lua (выбор компонента, финал: newnightsintheforest.lua — Luraph v14.7, НЕ включён)
-- ============================================================

--[[
██╗   ██╗ ██████╗ ██╗██████╗ ██╗    ██╗ █████╗ ██████╗ ███████╗
██║   ██║██╔═══██╗██║██╔══██╗██║    ██║██╔══██╗██╔══██╗██╔════╝
██║   ██║██║   ██║██║██║  ██║██║ █╗ ██║███████║██████╔╝█████╗  
╚██╗ ██╔╝██║   ██║██║██║  ██║██║███╗██║██╔══██║██╔═══╝ ██╔══╝  
 ╚████╔╝ ╚██████╔╝██║██████╔╝╚███╔███╔╝██║  ██║██║     ███████╗
  ╚═══╝   ╚═════╝ ╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚══════╝

                🚀 VOIDWARE — 99 Nights In The Forest 🚀
----------------------------------------------------------------------------
  IMPORTANT:
  You must copy and use the FULL script below. Do NOT press on the link.:

  loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))()

----------------------------------------------------------------------------
  For support head over to discord.gg/voidware
----------------------------------------------------------------------------
]]
if not game:IsLoaded() then return end
local CheatEngineMode = false
if (not getgenv) or (getgenv and type(getgenv) ~= "function") then
	CheatEngineMode = true
end
if getgenv and not getgenv().shared then
	CheatEngineMode = true
	getgenv().shared = {}
end
if getgenv and not getgenv().debug then
	CheatEngineMode = true
	getgenv().debug = {
		traceback = function(string)
			return string
		end,
	}
end
if getgenv and not getgenv().require then
	CheatEngineMode = true
end
if getgenv and getgenv().require and type(getgenv().require) ~= "function" then CheatEngineMode = true end
local debugChecks = {
    Type = "table",
    Functions = {
        "getupvalue",
        "getupvalues",
        "getconstants",
        "getproto"
    }
}
local function checkExecutor()
    if identifyexecutor ~= nil and type(identifyexecutor) == "function" then
        local suc, res = pcall(function()
            return identifyexecutor()
        end)   
        --local blacklist = {'appleware', 'cryptic', 'delta', 'wave', 'codex', 'swift', 'solara', 'vega'}
        local blacklist = {'solara', 'cryptic', 'xeno', 'ember', 'ronix'}
        local core_blacklist = {'solara', 'xeno'}
        if suc then
            for i,v in pairs(blacklist) do
                if string.find(string.lower(tostring(res)), v) then CheatEngineMode = true end
            end
            for i,v in pairs(core_blacklist) do
                if string.find(string.lower(tostring(res)), v) then
                    pcall(function()
                        getgenv().queue_on_teleport = function() warn('queue_on_teleport disabled!') end
                    end)
                end
            end
            if string.find(string.lower(tostring(res)), "delta") then
                getgenv().isnetworkowner = function()
                    return true
                end
            end
        end
    end
end
task.spawn(function() pcall(checkExecutor) end)
local function checkDebug()
    if CheatEngineMode then return end
    if not getgenv().debug then 
        CheatEngineMode = true 
    else 
        if type(debug) ~= debugChecks.Type then 
            CheatEngineMode = true
        else 
            for i, v in pairs(debugChecks.Functions) do
                if not debug[v] or (debug[v] and type(debug[v]) ~= "function") then 
                    CheatEngineMode = true 
                else
                    local suc, res = pcall(debug[v]) 
                    if tostring(res) == "Not Implemented" then 
                        CheatEngineMode = true 
                    end
                end
            end
        end
    end
end
--if (not CheatEngineMode) then checkDebug() end
shared.CheatEngineMode = shared.CheatEngineMode or CheatEngineMode
shared.ForcePlayerGui = true

if game.PlaceId == 79546208627805 then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Voidware | 99 Nights In The Forest",
            Text = "Go In Game for Voidware to load :D [You are in lobby currently]",
            Duration = 10
        })
    end)
    return
end 

task.spawn(function()
    pcall(function()
        local Services = setmetatable({}, {
            __index = function(self, key)
                local suc, service = pcall(game.GetService, game, key)
                if suc and service then
                    self[key] = service
                    return service
                else
                    warn(`[Services] Warning: "{key}" is not a valid Roblox service.`)
                    return nil
                end
            end
        })

        local Players = Services.Players
        local TextChatService = Services.TextChatService
        local ChatService = Services.ChatService
        repeat
            task.wait()
        until game:IsLoaded() and Players.LocalPlayer ~= nil
        local chatVersion = TextChatService and TextChatService.ChatVersion or Enum.ChatVersion.LegacyChatService
        local TagRegister = shared.TagRegister or {}
        if not shared.CheatEngineMode then
            --if chatVersion == Enum.ChatVersion.TextChatService then
                TextChatService.OnIncomingMessage = function(data)
                    TagRegister = shared.TagRegister or {}
                    local properties = Instance.new("TextChatMessageProperties", game:GetService("Workspace"))
                    local TextSource = data.TextSource
                    local PrefixText = data.PrefixText or ""
                    if TextSource then
                        local plr = Players:GetPlayerByUserId(TextSource.UserId)
                        if plr then
                            local prefix = ""
                            if TagRegister[plr] then
                                prefix = prefix .. TagRegister[plr]
                            end
                            if plr:GetAttribute("__OwnsVIPGamepass") and plr:GetAttribute("VIPChatTag") ~= false then
                                prefix = prefix .. "<font color='rgb(255,210,75)'>[VIP]</font> "
                            end
                            local currentLevel = plr:GetAttribute("_CurrentLevel")
                            if currentLevel then
                                prefix = prefix .. string.format("<font color='rgb(173,216,230)'>[</font><font color='rgb(255,255,255)'>%s</font><font color='rgb(173,216,230)'>]</font> ", tostring(currentLevel))
                            end
                            local playerTagValue = plr:FindFirstChild("PlayerTagValue")
                            if playerTagValue and playerTagValue.Value then
                                prefix = prefix .. string.format("<font color='rgb(173,216,230)'>[</font><font color='rgb(255,255,255)'>#%s</font><font color='rgb(173,216,230)'>]</font> ", tostring(playerTagValue.Value))
                            end
                            prefix = prefix .. PrefixText
                            properties.PrefixText = string.format("<font color='rgb(255,255,255)'>%s</font>", prefix)
                        end
                    end
                    return properties
                end
            --[[elseif chatVersion == Enum.ChatVersion.LegacyChatService then
                ChatService:RegisterProcessCommandsFunction("CustomPrefix", function(speakerName, message)
                    TagRegister = shared.TagRegister or {}
                    local plr = Players:FindFirstChild(speakerName)
                    if plr then
                        local prefix = ""
                        if TagRegister[plr] then
                            prefix = prefix .. TagRegister[plr]
                        end
                        if plr:GetAttribute("__OwnsVIPGamepass") and plr:GetAttribute("VIPChatTag") ~= false then
                            prefix = prefix .. "[VIP] "
                        end
                        local currentLevel = plr:GetAttribute("_CurrentLevel")
                        if currentLevel then
                            prefix = prefix .. string.format("[%s] ", tostring(currentLevel))
                        end
                        local playerTagValue = plr:FindFirstChild("PlayerTagValue")
                        if playerTagValue and playerTagValue.Value then
                            prefix = prefix .. string.format("[#%s] ", tostring(playerTagValue.Value))
                        end
                        prefix = prefix .. speakerName
                        return prefix .. " " .. message
                    end
                    return message
                end)
            end--]]
        end
    end)
end)

local commit = shared.CustomCommit and tostring(shared.CustomCommit) or shared.StagingMode and "staging" or "3f69683b400710b2dc234dd0a5454e40eccae108"
--[[local suc, res = pcall(function()
    local exec = identifyexecutor()
    if not exec then return false end
    exec = string.lower(tostring(exec))
    if exec:find("xeno") then
        return true
    end
end)
if suc and res and shared.CustomCommit == nil then
    commit = "68ac5d3e4e95dccc6608412bb0425e9b7f199a61"
    task.spawn(function()
        pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Voidware | Xeno",
				Text = "Your executor currently doesn't support the newest version of the script!",
				Duration = 10,
			})
            task.wait(0.5)
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Voidware | Xeno",
				Text = "For more info head over to discord.gg/voidware",
				Duration = 10,
			})
        end)
    end)
end--]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/"..tostring(commit).."/newnightsintheforest.lua", true))()
