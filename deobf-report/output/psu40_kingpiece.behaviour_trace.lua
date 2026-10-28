getgenv().Setting = {
	Slider = { LeftColor = Color3.fromRGB(255, 104, 0), RightColor = Color3.fromRGB(255, 185, 0) },
	Tab = { LeftColor = Color3.fromRGB(255, 104, 0), RightColor = Color3.fromRGB(255, 185, 0) },
	Toggle = { LeftColor = Color3.fromRGB(255, 104, 0), RightColor = Color3.fromRGB(255, 185, 0) }
}
game.CoreGui:FindFirstChild("MagmaLib")
local MagmaLib = game.CoreGui:FindFirstChild("MagmaLib")
MagmaLib:Destroy()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
Players.LocalPlayer:GetMouse()
wait()
wait()
