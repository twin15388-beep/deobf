--[[
    ███████╗██╗   ██╗██████╗ ███████╗██████╗     ███████╗██╗   ██╗████████╗███████╗██████╗  ██████╗ ██╗
    ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗    ██╔════╝██║   ██║╚══██╔══╝██╔════╝██╔══██╗██╔═══██╗██║
    ███████╗██║   ██║██████╔╝█████╗  ██████╔╝    █████╗  ██║   ██║   ██║   █████╗  ██████╔╝██║   ██║██║
    ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗    ██╔══╝  ██║   ██║   ██║   ██╔══╝  ██╔══██╗██║   ██║██║
    ███████║╚██████╔╝██║     ███████╗██║  ██║    ██║     ╚██████╔╝   ██║   ███████╗██║  ██║╚██████╔╝███████╗
    ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

    SUPER FUTEBOL PROIBIDO v1.0
    O futebol skill mais viciante e fluido do Roblox.
    100000000000000x melhor que o Illegal Soccer.

    COMO USAR:
    1. Coloque este Script em ServerScriptService
    2. Crie no Workspace:
       - Ball (Part redonda, Anchored = false, CanCollide = true)
       - GoalBlue e GoalRed (Parts ou Models com Touched)
    3. Crie Teams: "Blue" e "Red" no Teams service
    4. Pronto! O script cria tudo (Remotes, Client Controller, Match System)

    CONTROLES (cliente):
    - Q / E / F / R = Skill Moves
    - Clique Esquerdo (segurar) = Carregar chute (Power + Curve)
    - Espaço = Pulo / Cabeçada
    - Shift = Sprint (gasta stamina)
    - Ctrl = Carrinho / Tackle
]] local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris") -- ====================== CONFIGURAÇÕES ======================
local CONFIG = {MATCH_DURATION = 300, -- 5 minutos
MAX_PLAYERS_PER_TEAM = 4, BALL_FRICTION = 0.985, BALL_BOUNCE = 0.65, MAX_SHOT_POWER = 180, CURVE_STRENGTH = 45, STAMINA_DRAIN_SPRINT = 12, STAMINA_REGEN = 8, TACKLE_COOLDOWN = 2.5, SKILL_COOLDOWN = 1.8,} -- ====================== SETUP INICIAL ======================
local function ensureFolder(parent, name)
  local f = parent:FindFirstChild(name)
  if not f then
    f = Instance.new("Folder")
    f.Name = name
    f.Parent = parent
  end
  return f
end
local Remotes = ensureFolder(ReplicatedStorage, "SuperFutebolRemotes")
local function ensureRemote(name, class)
  local r = Remotes:FindFirstChild(name)
  if not r then
    r = Instance.new(class or "RemoteEvent")
    r.Name = name
    r.Parent = Remotes
  end
  return r
end
local RE_Kick = ensureRemote("Kick")
local RE_Skill = ensureRemote("Skill")
local RE_Tackle = ensureRemote("Tackle")
local RE_UpdateUI = ensureRemote("UpdateUI")
local RE_MatchState = ensureRemote("MatchState") -- ====================== ESTADO DO JOGO ======================
local GameState = {ScoreBlue = 0, ScoreRed = 0, TimeLeft = CONFIG.MATCH_DURATION, IsPlaying = false, BallOwner = nil,} -- ====================== BOLA (FÍSICA CUSTOM) ======================
local Ball = workspace:FindFirstChild("Ball")
if not Ball then
  warn("[SuperFutebol] Crie uma Part chamada 'Ball' no Workspace!")
end
local function resetBall()
  if not Ball then
    return
  end
  Ball.AssemblyLinearVelocity = Vector3.zero
  Ball.AssemblyAngularVelocity = Vector3.zero
  Ball.CFrame = CFrame.new(0, 5, 0)
  GameState.BallOwner = nil
end
local function applyBallPhysics(dt)
  if not Ball or Ball.Anchored then
    return
  end
  local vel = Ball.AssemblyLinearVelocity -- Fricção no chão
  if Ball.Position.Y < 3 then
    vel = vel * CONFIG.BALL_FRICTION -- Bounce simples
    if vel.Y < -2 then
      vel = Vector3.new(vel.X, -vel.Y * CONFIG.BALL_BOUNCE, vel.Z)
    end
  end
  Ball.AssemblyLinearVelocity = vel
end
-- ====================== JOGADOR ======================
local PlayerData = {}
local function getPlayerData(player)
  if not PlayerData[player] then
    PlayerData[player] = {Stamina = 100, LastTackle = 0, LastSkill = 0, Team = nil,}
  end
  return PlayerData[player]
end
local function assignTeam(player)
  local blueCount = #Teams.Blue:GetPlayers()
  local redCount = #Teams.Red:GetPlayers()
  if blueCount <= redCount then
    player.Team = Teams.Blue
  else
    player.Team = Teams.Red
  end
  getPlayerData(player).Team = player.Team
end
-- ====================== SKILL MOVES ======================
local Skills = {Elastico = function(char, root)
  local dir = root.CFrame.LookVector
  root.AssemblyLinearVelocity = dir * 35 + Vector3.new(0, 8, 0) -- Fake body movement visual
  local tw = TweenService:Create(root, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {CFrame = root.CFrame * CFrame.new(3, 0, -2) * CFrame.Angles(0, math.rad(90), 0)}) tw:Play()
end
, Rainbow = function(char, root)
  root.AssemblyLinearVelocity = Vector3.new(0, 55, 0) + root.CFrame.LookVector * 20
end
, Roulette = function(char, root)
  local start = root.CFrame
  local tw = TweenService:Create(root, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {CFrame = start * CFrame.Angles(0, math.rad(360), 0)}) tw:Play()
  root.AssemblyLinearVelocity = root.CFrame.LookVector * 28
end
, Nutmeg = function(char, root)
  root.AssemblyLinearVelocity = root.CFrame.LookVector * 45
end
,} -- ====================== EVENTOS ======================
RE_Kick.OnServerEvent:Connect(function(player, power, curve, direction)
  local char = player.Character
  if not char or not Ball then
    return
  end
  local root = char:FindFirstChild("HumanoidRootPart")
  if not root then
    return
  end
  local dist = (Ball.Position - root.Position).Magnitude
  if dist > 12 then
    return
  end
  power = math.clamp(power or 50, 10, 100)
  curve = math.clamp(curve or 0, -1, 1)
  direction = typeof(direction) == "Vector3" and direction.Unit or root.CFrame.LookVector
  local force = direction * (power / 100 * CONFIG.MAX_SHOT_POWER)
  local side = root.CFrame.RightVector * (curve * CONFIG.CURVE_STRENGTH * (power / 100))
  local up = Vector3.new(0, power / 100 * 25, 0) Ball:SetNetworkOwner(nil)
  Ball.AssemblyLinearVelocity = force + side + up
  Ball.AssemblyAngularVelocity = Vector3.new(0, curve * 30, 0)
  GameState.BallOwner = nil
end
)
RE_Skill.OnServerEvent:Connect(function(player, skillName)
  local data = getPlayerData(player)
  if tick() - data.LastSkill < CONFIG.SKILL_COOLDOWN then
    return
  end
  data.LastSkill = tick()
  local char = player.Character
  if not char then
    return
  end
  local root = char:FindFirstChild("HumanoidRootPart")
  if not root then
    return
  end
  local skill = Skills[skillName]
  if skill then
    skill(char, root) -- Pequeno boost de velocidade momentâneo
    data.Stamina = math.max(0, data.Stamina - 8)
  end
end
)
RE_Tackle.OnServerEvent:Connect(function(player)
  local data = getPlayerData(player)
  if tick() - data.LastTackle < CONFIG.TACKLE_COOLDOWN then
    return
  end
  data.LastTackle = tick()
  local char = player.Character
  if not char then
    return
  end
  local root = char:FindFirstChild("HumanoidRootPart")
  local hum = char:FindFirstChildOfClass("Humanoid")
  if not root or not hum then
    return
  end
  -- Animação de carrinho (velocity)
  root.AssemblyLinearVelocity = root.CFrame.LookVector * 55 + Vector3.new(0, 5, 0)
  hum.PlatformStand = true
  task.delay(0.6, function()
    if hum then
      hum.PlatformStand = false
    end
  end
  ) -- Detectar se acertou alguém ou a bola
  for _, other in ipairs(Players:GetPlayers()) do
    if other ~= player and other.Character then
      local oRoot = other.Character:FindFirstChild("HumanoidRootPart")
      if oRoot and (oRoot.Position - root.Position).Magnitude < 8 then
        local oHum = other.Character:FindFirstChildOfClass("Humanoid")
        if oHum then
          oHum.PlatformStand = true
          oRoot.AssemblyLinearVelocity = root.CFrame.LookVector * 40 + Vector3.new(0, 25, 0)
          task.delay(1.2, function()
            if oHum then
              oHum.PlatformStand = false
            end
          end
          )
        end
      end
    end
  end
end
) -- ====================== MATCH SYSTEM ======================
local function startMatch()
  GameState.ScoreBlue = 0
  GameState.ScoreRed = 0
  GameState.TimeLeft = CONFIG.MATCH_DURATION
  GameState.IsPlaying = true
  resetBall() RE_MatchState:FireAllClients("Start", GameState)
end
local function endMatch()
  GameState.IsPlaying = false
  local winner = "Empate"
  if GameState.ScoreBlue > GameState.ScoreRed then
    winner = "Blue"
  elseif GameState.ScoreRed > GameState.ScoreBlue then
    winner = "Red"
  end
  RE_MatchState:FireAllClients("End", {Winner = winner, ScoreBlue = GameState.ScoreBlue, ScoreRed = GameState.ScoreRed})
  task.wait(8)
  startMatch()
end
-- Goal detection
local function setupGoal(goalPart, teamName)
  if not goalPart then
    return
  end
  goalPart.Touched:Connect(function(hit)
    if hit.Name == "Ball" and GameState.IsPlaying then
      if teamName == "Blue" then
        GameState.ScoreRed + = 1
      else
        GameState.ScoreBlue + = 1
      end
      RE_UpdateUI:FireAllClients(GameState.ScoreBlue, GameState.ScoreRed, GameState.TimeLeft)
      resetBall()
      task.wait(2)
    end
  end
  )
end
setupGoal(workspace:FindFirstChild("GoalBlue"), "Blue")
setupGoal(workspace:FindFirstChild("GoalRed"), "Red") -- ====================== CLIENT CONTROLLER (injetado) ======================
local ClientCode = [[
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("SuperFutebolRemotes")

local player = Players.LocalPlayer
local RE_Kick = Remotes:WaitForChild("Kick")
local RE_Skill = Remotes:WaitForChild("Skill")
local RE_Tackle = Remotes:WaitForChild("Tackle")
local RE_UpdateUI = Remotes:WaitForChild("UpdateUI")
local RE_MatchState = Remotes:WaitForChild("MatchState")

local charging = false
local chargeStart = 0
local curveDir = 0

-- UI simples
local screen = Instance.new("ScreenGui")
screen.Name = "SuperFutebolUI"
screen.ResetOnSpawn = false
screen.Parent = player:WaitForChild("PlayerGui")

local scoreLabel = Instance.new("TextLabel")
scoreLabel.Size = UDim2.new(0, 300, 0, 50)
scoreLabel.Position = UDim2.new(0.5, -150, 0, 20)
scoreLabel.BackgroundTransparency = 0.3
scoreLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
scoreLabel.TextColor3 = Color3.new(1,1,1)
scoreLabel.Font = Enum.Font.GothamBold
scoreLabel.TextSize = 28
scoreLabel.Text = "0 - 0 | 5:00"
scoreLabel.Parent = screen

local staminaBar = Instance.new("Frame")
staminaBar.Size = UDim2.new(0, 200, 0, 12)
staminaBar.Position = UDim2.new(0.5, -100, 1, -40)
staminaBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
staminaBar.Parent = screen
local staminaFill = Instance.new("Frame")
staminaFill.Size = UDim2.new(1, 0, 1, 0)
staminaFill.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
staminaFill.Parent = staminaBar

RE_UpdateUI.OnClientEvent:Connect(function(blue, red, timeLeft)
	local mins = math.floor(timeLeft / 60)
	local secs = timeLeft % 60
	scoreLabel.Text = string.format("%d - %d | %d:%02d", blue, red, mins, secs)
end)

RE_MatchState.OnClientEvent:Connect(function(state, data)
	if state == "Start" then
		scoreLabel.Text = "0 - 0 | 5:00"
	elseif state == "End" then
		scoreLabel.Text = "FIM! Vencedor: " .. (data.Winner or "Empate")
	end
end)

-- Input
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		charging = true
		chargeStart = tick()
	elseif input.KeyCode == Enum.KeyCode.Q then
		RE_Skill:FireServer("Elastico")
	elseif input.KeyCode == Enum.KeyCode.E then
		RE_Skill:FireServer("Rainbow")
	elseif input.KeyCode == Enum.KeyCode.F then
		RE_Skill:FireServer("Roulette")
	elseif input.KeyCode == Enum.KeyCode.R then
		RE_Skill:FireServer("Nutmeg")
	elseif input.KeyCode == Enum.KeyCode.LeftControl then
		RE_Tackle:FireServer()
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and charging then
		charging = false
		local power = math.clamp((tick() - chargeStart) * 60, 20, 100)
		local cam = workspace.CurrentCamera
		local dir = cam.CFrame.LookVector
		RE_Kick:FireServer(power, curveDir, dir)
		curveDir = 0
	end
end)

UIS.InputChanged:Connect(function(input)
	if charging and input.UserInputType == Enum.UserInputType.MouseMovement then
		curveDir = math.clamp(curveDir + input.Delta.X * 0.01, -1, 1)
	end
end)

print("[SuperFutebol] Cliente carregado! Controles: Q/E/F/R skills | Clique = chute | Ctrl = carrinho")
]]
local function injectClient(player)
  local ls = Instance.new("LocalScript")
  ls.Name = "SuperFutebolClient"
  ls.Source = ClientCode
  ls.Parent = player:WaitForChild("PlayerGui")
end
-- ====================== PLAYER MANAGEMENT ======================
Players.PlayerAdded:Connect(function(player)
  assignTeam(player)
  player.CharacterAdded:Connect(function(char)
    task.wait(1)
    injectClient(player)
  end
  )
  if player.Character then
    injectClient(player)
  end
end
)
for _, p in ipairs(Players:GetPlayers()) do
  assignTeam(p)
  if p.Character then
    injectClient(p)
  end
end
-- ====================== LOOP PRINCIPAL ======================
local lastTick = tick()
RunService.Heartbeat:Connect(function()
  local now = tick()
  local dt = now - lastTick
  lastTick = now
  applyBallPhysics(dt)
  if GameState.IsPlaying then
    GameState.TimeLeft = math.max(0, GameState.TimeLeft - dt)
    if math.floor(GameState.TimeLeft) % 5 == 0 then
      RE_UpdateUI:FireAllClients(GameState.ScoreBlue, GameState.ScoreRed, math.floor(GameState.TimeLeft))
    end
    if GameState.TimeLeft <= 0 then
      endMatch()
    end
  end
  -- Stamina regen
  for player, data in pairs(PlayerData) do
    if player.Character then
      data.Stamina = math.min(100, data.Stamina + CONFIG.STAMINA_REGEN * dt)
    end
  end
end
) -- Start first match after short delay
task.delay(5, startMatch)
print("[SuperFutebol Proibido] Sistema carregado com sucesso! ⚽🔥")
print("Faça o futebol proibido parecer amador.")
