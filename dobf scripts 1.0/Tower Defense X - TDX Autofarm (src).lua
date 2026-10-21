--[[
Game source provenance | SRC | NOT TESTED IN ROBLOX
Original: https://github.com/jellyfishhhhhhh/TDXAutofarm/blob/ca430b23ce3f1395d8d972ddfcb34d61785104cb/main.lua
Source SHA-256: 2ed20ebb6a5ea0604aa3a806bee90dacb9b245041cf570f0273ad74e5721128f
Open source (src); no deobfuscation claimed.
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2024 jellyfish

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
]]

local replStorage = game:GetService("ReplicatedStorage")
local remotes = replStorage:WaitForChild("Remotes")
local network = nil
if game.PlaceId == 9503261072 then
    network = replStorage:WaitForChild("Network")
end
local localPlayer = game:GetService("Players").LocalPlayer
local playerGui = localPlayer.PlayerGui

local tdxScript = {}

local function verboseLog(message)
    if getfenv().enableVerbose == true then
        print("AUTOFARM | "..message)
    end
end
-- IN LOBBY --

function tdxScript:StartLogging()
    print("logging started")
    local startTime = time()
    local offset = 0
    local fileName = 1
    local fileContent = isfile(tostring(fileName)..".txt")

    while fileContent do
        fileName = fileName + 1
        fileContent = isfile(tostring(fileName)..".txt")
    end
    fileName = tostring(fileName)..".txt"

    writefile(fileName, "")
    local function serialize(value)
        if type(value) == "table" then
            local result = "{"
            for k, v in pairs(value) do
                result = result .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ", "
            end

            if result ~= "{" then
                result = result:sub(1, -3)
            end

            return result .. "}"
        else
            return tostring(value)
        end
    end
    
    local function serializeArgs(...)
        local args = {...}
        local strArgs = {}
    
        for i, v in ipairs(args) do
            strArgs[i] = serialize(v)
        end
    
        return table.concat(strArgs, ", ")
    end

    local oldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
        local serializedArgs = serializeArgs(...)
        log(namecallmethod, self, serializedArgs)
    
        return oldFireServer(self, ...)
    end)
   
    local oldInvokeServer = hookfunction(Instance.new("RemoteFunction").InvokeServer, function(self, ...)
        local serializedArgs = serializeArgs(...)
        log(namecallmethod, self, serializedArgs)
    
        return oldInvokeServer(self, ...)
    end)
    
    local oldNameCall
    oldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
        local namecallmethod = getnamecallmethod()
    
        if namecallmethod == "FireServer" or namecallmethod == "InvokeServer" then
            local serializedArgs = serializeArgs(...)
            log(namecallmethod, self, serializedArgs)
        end
 
        return oldNameCall(self, ...)
    end)
    
    function log(method, self, serializedArgs)
        local text = tostring(self.Name).." "..tostring(serializedArgs).."\n"
        print(text)


        if self.Name == "PlaceTower" then
            appendfile(fileName, "task.wait("..tostring((time()-offset)-startTime)..")".."\n")
            appendfile(fileName, "TDX:placeTower("..tostring(serializedArgs)..")".."\n")

            startTime = time() - offset
        elseif self.Name == "SellTower" then
            appendfile(fileName, "task.wait("..tostring((time()-offset)-startTime)..")".."\n")
            appendfile(fileName, "TDX:sellTower("..tostring(serializedArgs)..")".."\n")

            startTime = time() - offset
        elseif self.Name == "TowerUpgradeRequest" then
            appendfile(fileName, "task.wait("..tostring((time()-offset)-startTime)..")".."\n")
            appendfile(fileName, "TDX:upgradeTower("..tostring(serializedArgs)..")".."\n")

            startTime = time() - offset
        elseif self.Name == "DifficultyVoteReady" then
            offset = time()
            appendfile(fileName, "TDX:Start('ENTER DIFFICULTY')".."\n")
            startTime = time() - offset
            print(offset)
        end
    end
end

function tdxScript:JoinMap(mapName)
    if game.PlaceId == 9503261072 then
        while task.wait() do
            local display = nil
            local chosenDisplay = nil
            for i,v in pairs(workspace:WaitForChild("APCs"):GetChildren()) do
                display = v.mapdisplay.screen.displayscreen
                if display.map.Text == mapName then
                    if display.plrcount.Text == "0/4" then
                        print("map is available and there are no people in it")
                        chosenDisplay = display
                        localPlayer.Character.HumanoidRootPart.CFrame = v.APC.Detector.CFrame
                        break
                    end
                end
            end
            task.wait(1)
            if chosenDisplay then
                repeat task.wait()
                until tonumber(string.match(display.plrcount.Text, "^(%d+)/")) >= 2 and 0 < tonumber(string.match(display.plrcount.Text, "^(%d+)/"))
               network.LeaveQueue:FireServer()
            end
        end
    end
end

function tdxScript:SetLoadout(args)
    if game.PlaceId == 9503261072 then
        network:WaitForChild("UpdateLoadout"):FireServer(args)
    end
end
-- IN GAME --

function tdxScript:Start(Difficulty)
    remotes:WaitForChild("DifficultyVoteCast"):FireServer(Difficulty)
    task.wait()
    remotes:WaitForChild("DifficultyVoteReady"):FireServer()
end

function tdxScript:placeTower(tower, strangeValue, location, tryUntilSucceed)
    local args = { strangeValue, tower, location, 0 }
    local towerCountText = playerGui.Interface.BottomBar.TowerCountFrame.Text.Text
    local currentPlacedTowers = string.match(towerCountText, "^(%d+)/")

    local args = {
        [1] = strangeValue,
        [2] = tower,
        [3] = location,
        [4] = 0
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlaceTower"):InvokeServer(unpack(args))
    
    local newTowerCountText = playerGui.Interface.BottomBar.TowerCountFrame.Text.Text
    local newPlacedTowers = string.match(newTowerCountText, "^(%d+)/")

    if currentPlacedTowers < newPlacedTowers then
        verboseLog("Placed tower")
    else
        if tryUntilSucceed then
            repeat task.wait()
                newPlacedTowers = string.match(newTowerCountText, "^(%d+)/")
            until currentPlacedTowers < newPlacedTowers
        end
    end
end

function tdxScript:upgradeTower(tower, option)
    local args = {
        [1] = tower,
        [2] = option
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TowerUpgradeRequest"):FireServer(unpack(args))    
end

function tdxScript:sellTower(towerId)
    remotes:WaitForChild("SellTower"):FireServer(towerId)
end

function tdxScript:skipWave()
    remotes:WaitForChild("SkipWaveVoteCast"):FireServer(true)
end

return tdxScript
