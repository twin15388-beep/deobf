--[[
	Made by Lau#0114 & Jethrootje#0289
--]]
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local upgrade = Instance.new("TextButton")
local towerspawn = Instance.new("TextButton")
local player = Instance.new("TextBox")
local tower = Instance.new("TextBox")
local credits = Instance.new("TextLabel")
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.BackgroundTransparency = 0.5
Frame.BorderSizePixel = 3
Frame.Active = true
Frame.Draggable = true
Frame.Position = UDim2.new(0.295620441, 0, 0.234082401, 0)
Frame.Size = UDim2.new(0, 313, 0, 260)

upgrade.Name = "upgrade"
upgrade.Parent = Frame
upgrade.BackgroundColor3 = Color3.new(1, 1, 1)
upgrade.BackgroundTransparency = 0.5
upgrade.BorderSizePixel = 0
upgrade.Position = UDim2.new(0.0543131009, 0, 0.161538467, 0)
upgrade.Size = UDim2.new(0, 130, 0, 49)
upgrade.Font = Enum.Font.Cartoon
upgrade.FontSize = Enum.FontSize.Size14
upgrade.Text = "Upgrade Towers"
upgrade.TextSize = 14

towerspawn.Name = "towerspawn"
towerspawn.Parent = Frame
towerspawn.BackgroundColor3 = Color3.new(1, 1, 1)
towerspawn.BackgroundTransparency = 0.5
towerspawn.BorderSizePixel = 0
towerspawn.Position = UDim2.new(0.527156591, 0, 0.161538467, 0)
towerspawn.Size = UDim2.new(0, 130, 0, 49)
towerspawn.Font = Enum.Font.Cartoon
towerspawn.FontSize = Enum.FontSize.Size14
towerspawn.Text = "Spawn Tower"
towerspawn.TextSize = 14

player.Name = "player"
player.Parent = Frame
player.BackgroundColor3 = Color3.new(1, 1, 1)
player.BackgroundTransparency = 0.5
player.BorderSizePixel = 0
player.Position = UDim2.new(0.0750798732, 0, 0.424999982, 0)
player.Size = UDim2.new(0, 117, 0, 39)
player.Font = Enum.Font.Cartoon
player.FontSize = Enum.FontSize.Size14
player.Text = "Player Name"
player.TextSize = 14

tower.Name = "tower"
tower.Parent = Frame
tower.BackgroundColor3 = Color3.new(1, 1, 1)
tower.BackgroundTransparency = 0.5
tower.BorderSizePixel = 0
tower.Position = UDim2.new(0.546325862, 0, 0.424999982, 0)
tower.Size = UDim2.new(0, 117, 0, 39)
tower.Font = Enum.Font.Cartoon
tower.FontSize = Enum.FontSize.Size14
tower.Text = "Tower Name"
tower.TextSize = 14

credits.Name = "credits"
credits.Parent = Frame
credits.BackgroundColor3 = Color3.new(1, 1, 1)
credits.BackgroundTransparency = 1
credits.Position = UDim2.new(0.115015969, 0, 0.911538422, 0)
credits.Size = UDim2.new(0, 147, 0, 23)
credits.Font = Enum.Font.Cartoon
credits.FontSize = Enum.FontSize.Size14
credits.Text = "Made by Lau#0114 & Jethrootje#0289"
credits.TextSize = 14

towerspawn.MouseButton1Click:connect(function()
	game.Workspace.PlacingTower:InvokeServer(tower.text, -25222220)
end)
upgrade.MouseButton1Click:connect(function()
	local ws = workspace
local plr = game:GetService('Players')[player.Text]
for i,v in pairs(ws.Towers:GetChildren()) do
if v.Owner.Value == plr and v.Tower.UP1.Value < 4 then
repeat
workspace.HasEnough:InvokeServer('Cash',0)
workspace.Spend:InvokeServer(0)
workspace.UpgradeTower:InvokeServer(v.Name,0)
until v.Tower.UP1.Value >= 4
end
end
end)