--[[
Game-specific Luau: NOT DEOBFUSCATED / SRC / NOT TESTED IN ROBLOX
Source: https://github.com/MaddHub-Official/MaddHub/blob/2109e33d3d0f6cdd0a187eede1fc56af17630852/Games/096%20%5BSCP%5D/script.lua
Source SHA-256: 4801dfd84fd2c3d853629b9f41f82ce8eca97ee34dc998116b8299b86e12fb4b
Status: MIT source file, not a recovery.
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2025 MaddHub

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


local function returnObjs(loc, typ)
    local results = {}
    for _, v in pairs(loc:GetChildren()) do
        local t = v:GetAttribute("Type")
        if t == typ then
            table.insert(results, v)
        end
    end
    return results
end

local function consumeFood()
    local foods = returnObjs(Svc.RepStor.Foods, "Food")
    if #foods > 0 then
        local n = foods[math.random(1, #foods)].Name
        if n then
            Svc.RepStor:WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer("Consume", n)
        end
    end
end

local function maxStats()
    local my = { "Health", "Hunger", "Energy" }
    for _, v in ipairs(my) do
        local attr = Lp:GetAttribute(v)
        if attr then
            Lp:GetAttributeChangedSignal(v):Connect(function()
                if getgenv().MAXSTATS and attr < 100 then
                    consumeFood()
                    task.wait(1)
                end
            end)
        end
    end
end

local function maxBackpack()
    Lp:SetAttribute("HasExplorer", true)
    task.wait()
    Lp:SetAttribute("BackpackSlots", 70)
    task.wait()
    Lp:SetAttribute("BackpackSpace", 70)
end

local function getPartNames()
    local results = {}
    local lastPart = ""
    for _, v in ipairs(Svc.Ws.Interact:GetChildren()) do
        if v.Name ~= lastPart and not v:GetAttribute("Type") and v:FindFirstChild("Hitbox") then
            lastPart = v.Name
            table.insert(results, v.Name)
        end
    end
    table.sort(results, sort_alphabetical)
    return results
end

local function getMatches(partName)
    local matches = {}
    for _, v in pairs(Svc.Ws.Interact:GetChildren()) do
        if v.Name == partName then
            table.insert(matches, v)
        end
    end
    return matches
end

local function spawnPart(partName)
    local rnd = math.random(-10, 10)
    local m = getMatches(partName)
    local newPart = m[math.random(1, #m)].PrimaryPart
    if newPart then
        local newCf = HumRP.CFrame + Vector3.new(rnd, 0, rnd)
        newPart.Anchored = not newPart.Anchored
        newPart:SetAttribute("CFrame", newCf)
        newPart.CFrame = newCf
        newPart.CanCollide = true
    end
end

local function grantPerms()
    local s = Instance.new("StringValue")
    s.Name = Lp.Name
    for _, p in pairs(Svc.Plrs:GetPlayers()) do
        if not p["Perms"]:FindFirstChild(Lp.Name) then
            s:Clone().Parent = p["Perms"]
        end
    end
end

local function getSCP()
    local scp096 = Svc.Ws:FindFirstChild("SCP-096") or Svc.RepStor:FindFirstChild("SCP-096")
    -- local scp173 = Svc.Ws:FindFirstChild("SCP-173") or Svc.RepStor:FindFirstChild("SCP-173")
    return scp096
end

local function toolAction()
    Svc.RepStor:WaitForChild("Remotes"):WaitForChild("ToolAction"):FireServer()
end

local function equipTool(toolName)
    local mats = { "Wood", "Stone", "Iron" }
    for _, m in ipairs(mats) do
        local t = m .. " " .. toolName
        local args = {
            [1] = "Equip",
            [2] = t,
            [3] = "Tool"
        }
        Svc.RepStor:WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
        task.wait(0.1)
    end
end

local function farmMats(resource)
    local Decoration = Svc.Ws.Decoration
    local nodes = {}
    if resource == "Stone" then
        equipTool("Pickaxe")
    elseif resource == "Tree" then
        equipTool("Axe")
    end
    for _, v in ipairs(Decoration:GetChildren()) do
        if not getgenv().FARM then break end
        if v:GetAttribute("Type") == resource then
            table.insert(nodes, v)
        end
    end
    task.spawn(function()
        while getgenv().FARM do
            for _, v in pairs(nodes) do
                local u = v:FindFirstChild("Union")
                if u and u.CanCollide then
                    u.CanCollide = not u.CanCollide
                end
                while v.Parent ~= nil do
                    Chr:PivotTo(v:GetPivot())
                    if not getgenv().FARM then break end
                    toolAction()
                    task.wait(0.2)
                end
            end
        end
    end)
end

-- Tabs

GameTab:AddToggle({
    Name = "Maximum Health, Energy, Hunger",
    Default = false,
    Save = true,
    Flag = "MAXSTATS",
    Callback = function(Value)
        getgenv().MAXSTATS = Value
        if Value then
            maxStats()
        end
    end
})

getgenv().scpDropdown = TeleportSect:AddDropdown({
    Name = "Teleport SCP To Player",
    Default = "",
    Options = getPlayerNames(),
    Callback = function(Value)
        getgenv().scpDropdown:Refresh(getPlayerNames(), true)
        task.spawn(function()
            local scp = getSCP():FindFirstChildOfClass("Humanoid")
            if scp then
                local tar = Svc.Ws:FindFirstChild(Value)
                if tar then
                    scp.WalkSpeed = 300
                    scp.Parent:PivotTo(tar:GetPivot() + Vector3.new(5, 5, 0))
                    scp:SetAttribute("CanAggro", true)
                end
            end
        end)
    end
})

local EnvTab = Window:MakeTab({
    Name = "Environment",
    Icon = Icons.Runner,
    PremiumOnly = false
})

EnvTab:AddToggle({
    Name = "Unlock Map",
    Default = false,
    Save = true,
    Flag = "MAP",
    Callback = function(Value)
        if Value then
            task.spawn(function()
                local env = getsenv(Lp.PlayerGui.Main.Controller)
                if env then
                    env:startMap()
                end
            end)
        end
    end
})

EnvTab:AddToggle({
    Name = "Bypass Permissions",
    Default = false,
    Save = true,
    Flag = "PERMS",
    Callback = function(Value)
        if Value then
            grantPerms()
        end
    end
})

local InvTab = Window:MakeTab({
    Name = "Inventory",
    Icon = Icons.Inventory,
    PremiumOnly = false
})

InvTab:AddToggle({
    Name = "Maximum Backpack Space",
    Default = false,
    Save = true,
    Flag = "BACKPACK",
    Callback = function(Value)
        if Value then
            maxBackpack()
        end
    end
})

getgenv().partsDropdown = InvTab:AddDropdown({
    Name = "Bring Parts",
    Default = "",
    Options = getPartNames(),
    Callback = function(Value)
        spawnPart(Value)
        getgenv().partsDropdown:Refresh(getPartNames(), true)
    end
})

InvTab:AddDropdown({
    Name = "Select a Resource",
    Default = "Tree",
    Options = { "Stone", "Tree" },
    Callback = function(Value)
        getgenv().RESOURCE = Value
    end
})

InvTab:AddToggle({
    Name = "Auto Farm Resources",
    Default = false,
    Save = true,
    Flag = "FARM",
    Callback = function(Value)
        getgenv().FARM = Value
        if Value then
            farmMats(getgenv().RESOURCE)
        end
    end
})