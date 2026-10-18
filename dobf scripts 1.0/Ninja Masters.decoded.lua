game:GetService("StarterGui"):SetCore("SendNotification", {Title = "FunTratOr On V3rm", Text = "IMAGINE EXPLOITING IN A LEGO GAME!"})
local DarkDevs = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local header2 = Instance.new("Frame")
local title = Instance.new("TextLabel")
local title_2 = Instance.new("TextLabel")
local title_3 = Instance.new("TextLabel")
local title_4 = Instance.new("TextLabel")
local farm = Instance.new("TextButton")
local sell = Instance.new("TextButton")
local pth = Instance.new("TextBox")
local name = Instance.new("TextBox")
DarkDevs.Name = "DarkDevs"
DarkDevs.Parent = game.CoreGui
Main.Name = "Main"
Main.Parent = DarkDevs
Main.Active = true
Main.Draggable = true
Main.BackgroundColor3 = Color3.new(0, 0.0941177, 0.0156863)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.56320709, 0, 0.282215774, 0)
Main.Size = UDim2.new(0, 251, 0, 163)
header2.Name = "header2"
header2.Parent = Main
header2.BackgroundColor3 = Color3.new(0.0862745, 0.223529, 0.00392157)
header2.BorderSizePixel = 0
header2.Position = UDim2.new(0, 0, -0.00129949849, 0)
header2.Size = UDim2.new(0, 250, 0, 29)
title.Name = "title"
title.Parent = header2
title.BackgroundColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Position = UDim2.new(-0.0817396864, 0, 0.0344827585, 0)
title.Size = UDim2.new(0, 170, 0, 28)
title.Font = Enum.Font.GothamBold
title.Text = "ark Devs"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title_2.Name = "title"
title_2.Parent = header2
title_2.BackgroundColor3 = Color3.new(1, 1, 1)
title_2.BackgroundTransparency = 1
title_2.Position = UDim2.new(-0.247512206, 0, 0.0344827585, 0)
title_2.Size = UDim2.new(0, 167, 0, 28)
title_2.Font = Enum.Font.GothamBold
title_2.Text = "D"
title_2.TextColor3 = Color3.new(1, 0.0313726, 0.0470588)
title_2.TextSize = 18
title_3.Name = "title"
title_3.Parent = header2
title_3.BackgroundColor3 = Color3.new(1, 1, 1)
title_3.BackgroundTransparency = 1
title_3.BorderSizePixel = 0
title_3.Position = UDim2.new(-0.0120000001, 0, 5.17241383, 0)
title_3.Size = UDim2.new(0, 251, 0, 13)
title_3.Font = Enum.Font.GothamBold
title_3.Text = "Created By FunTratOr | DarkDevs.Pro"
title_3.TextColor3 = Color3.new(1, 1, 1)
title_3.TextSize = 10
title_4.Name = "title"
title_4.Parent = header2
title_4.BackgroundColor3 = Color3.new(1, 1, 1)
title_4.BackgroundTransparency = 1
title_4.BorderSizePixel = 0
title_4.Position = UDim2.new(0.547999978, 0, 0.517241359, 0)
title_4.Size = UDim2.new(0, 135, 0, 13)
title_4.Font = Enum.Font.GothamBold
title_4.Text = "NINJA MASTERS"
title_4.TextColor3 = Color3.new(1, 1, 1)
title_4.TextSize = 10
farm.Name = "farm"
farm.Parent = Main
farm.BackgroundColor3 = Color3.new(0.215686, 0.219608, 0.219608)
farm.BorderSizePixel = 0
farm.Position = UDim2.new(0.0805032253, 0, 0.579085469, 0)
farm.Size = UDim2.new(0, 202, 0, 20)
farm.Font = Enum.Font.GothamBold
farm.Text = "AUTO FARM MOBS"
farm.TextColor3 = Color3.new(1, 1, 1)
farm.TextSize = 14
sell.Name = "sell"
sell.Parent = Main
sell.BackgroundColor3 = Color3.new(0.215686, 0.219608, 0.219608)
sell.BorderSizePixel = 0
sell.Position = UDim2.new(0.0805031806, 0, 0.753614426, 0)
sell.Size = UDim2.new(0, 202, 0, 20)
sell.Font = Enum.Font.GothamBold
sell.Text = "AUTO SELL EVERYTHING"
sell.TextColor3 = Color3.new(1, 1, 1)
sell.TextSize = 14
pth.Name = "pth"
pth.Parent = Main
pth.BackgroundColor3 = Color3.new(0.215686, 0.219608, 0.219608)
pth.BorderColor3 = Color3.new(0.384314, 0, 0.00392157)
pth.Position = UDim2.new(0.0836653411, 0, 0.242140874, 0)
pth.Size = UDim2.new(0, 202, 0, 18)
pth.Font = Enum.Font.Gotham
pth.Text = "Start Area Back"
pth.TextColor3 = Color3.new(1, 1, 1)
pth.TextSize = 14
name.Name = "name"
name.Parent = Main
name.BackgroundColor3 = Color3.new(0.215686, 0.219608, 0.219608)
name.BorderColor3 = Color3.new(0.384314, 0, 0.00392157)
name.Position = UDim2.new(0.0836653411, 0, 0.389380157, 0)
name.Size = UDim2.new(0, 202, 0, 18)
name.Font = Enum.Font.Gotham
name.Text = "NO NEED!!!!!!"
name.TextColor3 = Color3.new(1, 1, 1)
name.TextSize = 14
farm.MouseButton1Down:connect(function()
farm.BackgroundColor3 = Color3.new(0.00392157, 0.372549, 0.137255)
	local path = pth.Text -- Path For Mobs
local lp = game.Players.LocalPlayer
local target;
local enemies = {}
while true do
lp.Character.HumanoidRootPart.Anchored = false
wait()
enemies = game.Workspace.NPCs.Spawns[path]:GetChildren() -- All the mobs targeted
 for i,v in pairs(enemies) do
 if v.ClassName == 'Model' then
target = enemies[i]
			               lp.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0,1,3),v.HumanoidRootPart.Position)
game.Workspace[game.Players.LocalPlayer.Name]:FindFirstChildOfClass('Tool'):Activate() wait()
    end
end
end
end)
sell.MouseButton1Down:connect(function()
	sell.BackgroundColor3 = Color3.new(0.00392157, 0.372549, 0.137255)
	local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
while wait() do
game.Workspace.Rings.Sell.CFrame = plr.CFrame
end
end)
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "WARNING!", Text = "EQUIP YOUR WEAPON BEFORE USING!"})