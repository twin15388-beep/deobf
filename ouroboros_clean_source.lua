--[[
    NZL Studio — Ouwland clean controller reconstruction
    Stage 23: compile-validated lifecycle, automation, farming, combat and ESP

    This file is intentionally readable and contains no Luast VM, telemetry, loader,
    foreign UI, or dynamic getgc bridge. Further controllers are added here as they
    are reconstructed.
]]

local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local RunService=game:GetService("RunService")
local CollectionService=game:GetService("CollectionService")
local UserInputService=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local StarterGui=game:GetService("StarterGui")
local TeleportService=game:GetService("TeleportService")
local VirtualUser=game:GetService("VirtualUser")
local GuiService=game:GetService("GuiService")
local LocalPlayer=Players.LocalPlayer

local Core={
    Version="clean-0.25",
    MAX_LEVEL=225,
    EXP_PER_LEVEL=60,
    Alive=true,
    Connections={},
    Threads={},
    ThreadTokens={},
    Errors={},
    Tweens={},
    EspObjects={},
    SeenBosses=setmetatable({},{__mode="k"}),
    CollisionState=setmetatable({},{__mode="k"}),
    Movement={Owner=nil,Priority=0,Epoch=0,Expires=0},
}

-- Recovered shared activity/status object.
Core.Status={
    AutoSkillStatus="Idle", BossStatus="Idle", BreathStatus="Idle",
    BringStatus="Idle", CardStatus="Idle", ChestStatus="Idle",
    CodeStatus="Idle", CrystalStatus="Idle", DeliveryStatus="Idle",
    DemonStatus="Idle", DungeonStatus="Idle", EquipStatus="Idle",
    FishStatus="Idle", HuntStatus="Idle", LevelStatus="Idle",
    LootStatus="Idle", MobStatus="Idle", ParryStatus="Off",
    PotionStatus="Idle", PriorityStatus="Off", QuestStatus="Idle",
    QueueStatus="Idle", SchematicStatus="Idle", ShopStatus="Idle",
    SkillStatus="Idle", SoulStatus="Idle", TeleportStatus="Idle",
    TrainStatus="Idle", WaveStatus="Idle", WorldStatus="Idle",
    PriorityHolder="None", CostText="None",
    Bought=0, Cards=0, Chests=0, ExpBundles=0, ExpGained=0, Fish=0, FloorsCleared=0, Hunts=0,
    Kills=0, Looted=0, Nodes=0, PointsSpent=0, Potions=0, Quests=0,
    Souls=0, Trainings=0, WebhookFailed=0, WebhookSent=0,
    CodeBusy=false, CodeReadyAt=0, InMenuPlace=false,
}

Core.Options={
    AutoLevel=false, AutoQuest=false, AutoMob=false, AutoBoss=false,
    AutoBossHunt=false, AutoLoot=false, AutoChest=false, AutoSkills=false,
    AutoSkillTree=false, AutoEquip=false, AutoPotion=false, AutoDelivery=false, AutoTraining=false, AutoFish=false, AutoBuy=false,
    InstantKill=false, NoStun=false, NoRagdoll=false,
    NoAttackSlowdown=false, NotifyBosses=false, Noclip=false, AntiAfk=false, AutoReconnect=false,
    InfiniteJump=false, WalkSpeedEnabled=false, WalkSpeed=16, Fly=false, FlySpeed=90,
    InfiniteStamina=false, InfiniteClimb=false, NoDrown=false, NoSunDamage=false,
    NoDashCooldown=false, AlwaysRun=false, AutoBreathing=false, AutoSoul=false,
    AutoParry=false, ParryNpcs=true, ParryPlayers=false, AutoBringEnemies=false,
    AutoQueue=false, AutoSkipWaves=false, AutoCards=false, AutoDungeon=false, DungeonRange=500,
    AutoDemon=false, DemonDrink=true, DrinkBelow=65, DemonMob=nil,
    ParryRadius=40, ParryLead=.18, ParryHold=.22, ParryMitigate=true,
    SoulRange=300, HealBelow=45,
    EspMobs=false, EspBosses=false, EspChest=false, EspPlayers=false, EspNpcs=false, EspLoot=false, EspMuzan=false, EspRange=1500,
    EspMobsColour=Color3.fromRGB(255,210,80),
    EspBossesColour=Color3.fromRGB(255,70,70),
    EspChestColour=Color3.fromRGB(90,220,255),
    EspPlayersColour=Color3.fromRGB(120,170,255),
    EspNpcsColour=Color3.fromRGB(170,255,150),
    EspLootColour=Color3.fromRGB(220,140,255),
    EspMuzanColour=Color3.fromRGB(255,60,170),
    TweenSpeed=190, HeightOffset=8, OffsetDistance=4,
    LootRange=200, KillThreshold=0, BringRange=100,
    PositionType="Above", LookAtEnemy=true,
    SelectedMob=nil, SelectedBoss=nil, SelectedQuest=nil,
    SelectedZone=nil, SelectedNpc=nil, SelectedTraining=nil, SelectedSkills={}, SelectedSkillNodes={},
    SelectedPotion="Health Potion", HuntTiers={}, SkillHold=.08,
    ChestTiers={}, ChestInstantKill=false, ChestKillThreshold=0,
    FishBait=nil, FishCastDelay=1.2,
    QueueModes={}, QueueRanked=false, QueueFill=true,
    CardSelection={}, CardPriority={}, ForceHealCards=false,
    ShopItems={}, BuyAmount=1, BuyInterval=2,
}

local function connect(signal,fn)
    local c=signal:Connect(fn); Core.Connections[#Core.Connections+1]=c; return c
end
local function path(root,...)
    local x=root
    for _,name in ipairs({...}) do x=x and x:FindFirstChild(name) end
    return x
end
local function safeRequire(x)
    if not x then return nil end
    local ok,v=pcall(require,x); return ok and v or nil
end

-- Recovered game module tree. Requires run independently so a yielding game module
-- can never block NZL Studio UI construction.
Core.Modules={}
Core.ModuleScripts={
    SignalEvent=path(ReplicatedStorage,"Communication","ServerAndClient","Signals","SignalEvent"),
    SignalFunction=path(ReplicatedStorage,"Communication","ServerAndClient","Signals","SignalFunction"),
    InputHandler=path(ReplicatedStorage,"CAM","Client","Components","Client","InputHandler"),
    SkillController=path(ReplicatedStorage,"CAM","Client","Controllers","Skill_Controller"),
    SkillsProvider=path(ReplicatedStorage,"CAM","Client","Controllers","Skills_Provider"),
    Quests=path(ReplicatedStorage,"CAM","Global","Subsets","Gameplay","Quests"),
    RecommendedQuest=path(ReplicatedStorage,"CAM","Client","Modules","RecommendedQuest"),
    SkillTreeholder=ReplicatedStorage:FindFirstChild("SkillTreeholder",true),
    SkillsModule=ReplicatedStorage:FindFirstChild("Skills_Module",true),
    Items=ReplicatedStorage:FindFirstChild("Items",true),
}
Core.ModuleState={}
function Core:ResolveModule(name)
    if self.Modules[name]~=nil then return self.Modules[name] end
    if self.ModuleState[name]=="loading" then return nil end
    local scriptObject=self.ModuleScripts[name];if not scriptObject then self.ModuleState[name]="missing";return nil end
    self.ModuleState[name]="loading"
    task.spawn(function()
        local value=safeRequire(scriptObject)
        if value~=nil then Core.Modules[name]=value;Core.ModuleState[name]="ready" else Core.ModuleState[name]="failed" end
    end)
    return nil
end
function Core:ResolveAllModules()
    for name in pairs(self.ModuleScripts) do self:ResolveModule(name) end
end
function Core:GetModuleStatus()
    local ready,total,loading,failed=0,0,0,0
    for name in pairs(self.ModuleScripts) do
        total+=1;local state=self.ModuleState[name]
        if state=="ready" then ready+=1 elseif state=="loading" then loading+=1 elseif state=="failed" or state=="missing" then failed+=1 end
    end
    return {Ready=ready,Total=total,Loading=loading,Failed=failed}
end
function Core:RetryModules()
    for name,state in pairs(self.ModuleState) do if state=="failed" or state=="missing" then self.ModuleState[name]=nil end end
    self:ResolveAllModules();return true
end
task.defer(function()if Core.Alive then Core:ResolveAllModules()end end)

function Core:Event(action,...)
    local m=self.Modules.SignalEvent or self:ResolveModule("SignalEvent")
    if not m or type(m.ToServer)~="function" then return false,"SignalEvent unavailable" end
    return pcall(m.ToServer,action,...)
end
function Core:Invoke(action,...)
    local m=self.Modules.SignalFunction or self:ResolveModule("SignalFunction")
    if not m or type(m.ToServer)~="function" then return false,"SignalFunction unavailable" end
    return pcall(m.ToServer,action,...)
end
function Core:Character()
    local c=LocalPlayer.Character
    return c,c and c:FindFirstChildOfClass("Humanoid"),c and c:FindFirstChild("HumanoidRootPart")
end
function Core:Profile()
    return path(ReplicatedStorage,"Player_Service","Data",LocalPlayer.Name)
end
function Core:ActiveSlot()
    local p=self:Profile(); if not p then return end
    local n=p:FindFirstChild("slotEquipped"); return path(p,"slots","Slot"..tostring(n and n.Value or 1))
end
function Core:CurrentLevel()
    for _,root in ipairs({self:ActiveSlot(),path(ReplicatedStorage,"Player_Service","Values",LocalPlayer.Name),LocalPlayer:FindFirstChild("leaderstats")}) do
        if root then for _,v in ipairs(root:GetDescendants()) do
            if v:IsA("ValueBase") and v.Name:lower()=="level" and type(v.Value)=="number" then return v.Value end
        end end
    end
    return 1
end

-- Recovered humanoid discovery: Regions/ActiveNpcs is authoritative.
function Core:Entities()
    local out,seen={},{ }
    local regions=path(workspace,"Humanoids","Regions") or workspace:FindFirstChild("Humanoids")
    if not regions then return out end
    for _,h in ipairs(regions:GetDescendants()) do
        if h:IsA("Humanoid") and h.Health>0 and h.Parent and not Players:GetPlayerFromCharacter(h.Parent) then
            local model=h.Parent; local root=model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
            if root and not seen[model] then seen[model]=true;out[#out+1]={Model=model,Humanoid=h,Root=root,Name=model.Name} end
        end
    end
    return out
end
function Core:Closest(name)
    local _,_,root=self:Character(); if not root then return end
    local best,distance
    for _,e in ipairs(self:Entities()) do if not name or e.Name==name then
        local d=(root.Position-e.Root.Position).Magnitude
        if not distance or d<distance then best,distance=e,d end
    end end
    return best,distance
end

-- Recovered combat-input adapter (controllerValid/pressInput/releaseInput/clearInputs).
Core.CombatInput={Pressed={}}
function Core.CombatInput:Press(key)
    local input=Core.Modules.InputHandler or Core:ResolveModule("InputHandler"); if not input then return false end
    self.Pressed[key]=true; return pcall(input.VirtualPress,key)
end
function Core.CombatInput:Release(key)
    local input=Core.Modules.InputHandler or Core:ResolveModule("InputHandler"); self.Pressed[key]=nil
    return input and pcall(input.VirtualRelease,key) or false
end
function Core.CombatInput:Clear()
    for key in pairs(self.Pressed) do self:Release(key) end
end
-- Runtime-confirmed Ouroboros M1 protocol. The original emits Combat_Service
-- directly; InputHandler is retained only as a fallback while modules resolve.
Core.CombatSequence={Index=1,Last=0}
function Core:Attack()
    local sequence=self.CombatSequence;local now=os.clock()
    if now-sequence.Last>2.2 then sequence.Index=1 end
    local combo=sequence.Index
    local hitDelay=(combo==1 and .13) or (combo==5 and .04) or 0
    local ok=self:Event("Combat_Service","Combat",combo,false,hitDelay,false,nil)
    if not ok then
        ok=self.CombatInput:Press("Combat")
        task.delay(.03,function() if Core.Alive then Core.CombatInput:Release("Combat") end end)
    end
    sequence.Last=now;sequence.Index=combo>=5 and 1 or combo+1
    return ok,({.39,.26,.26,.32,1.47})[combo]
end
function Core:UseSkill(skill)
    local controller=self.Modules.SkillController or self:ResolveModule("SkillController")
    if type(controller)=="table" and type(controller.Attempt_Hold)=="function" then
        local ok=pcall(controller.Attempt_Hold,skill,skill)
        task.wait(self.Options.SkillHold)
        if type(controller.StopHold)=="function" then pcall(controller.StopHold,skill) end
        return ok
    end
    self.CombatInput:Press(skill);task.wait(self.Options.SkillHold);self.CombatInput:Release(skill)
    return true
end

Core.Parry={Commitments=setmetatable({},{__mode="k"}),Blocking=false,Generation=0,Attempts=0}
function Core:StartBlock(duration)
    local p=self.Parry;p.Generation+=1;local generation=p.Generation
    if not p.Blocking then
        p.Blocking=true
        local controller=self.Modules.SkillController or self:ResolveModule("SkillController")
        if type(controller)=="table" and type(controller.Attempt_Hold)=="function" then pcall(controller.Attempt_Hold,"Blocking","F")
        else self.CombatInput:Press("Block") end
    end
    task.delay(duration or self.Options.ParryHold,function()
        if not Core.Alive or p.Generation~=generation then return end
        local controller=Core.Modules.SkillController or Core:ResolveModule("SkillController")
        if type(controller)=="table" and type(controller.StopHold)=="function" then pcall(controller.StopHold,"Blocking")
        else Core.CombatInput:Release("Block") end
        p.Blocking=false
    end)
end
function Core:ParryCandidates()
    local out={};local _,_,localRoot=self:Character();if not localRoot then return out end
    if self.Options.ParryNpcs then
        for _,entity in ipairs(self:Entities()) do if (localRoot.Position-entity.Root.Position).Magnitude<=self.Options.ParryRadius then out[#out+1]=entity.Model end end
    end
    if self.Options.ParryPlayers then
        for _,player in ipairs(Players:GetPlayers()) do if player~=LocalPlayer and player.Character then
            local root=player.Character:FindFirstChild("HumanoidRootPart");local hum=player.Character:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health>0 and (localRoot.Position-root.Position).Magnitude<=self.Options.ParryRadius then out[#out+1]=player.Character end
        end end
    end
    return out
end
function Core:ParryStep()
    local now=os.clock()
    for _,model in ipairs(self:ParryCandidates()) do
        local humanoid=model:FindFirstChildOfClass("Humanoid");local animator=humanoid and humanoid:FindFirstChildOfClass("Animator")
        if animator then for _,track in ipairs(animator:GetPlayingAnimationTracks()) do
            local action=track.Priority==Enum.AnimationPriority.Action or track.Priority==Enum.AnimationPriority.Action2 or track.Priority==Enum.AnimationPriority.Action3 or track.Priority==Enum.AnimationPriority.Action4
            local speed=math.abs(track.Speed);local length=track.Length
            if action and speed>.01 and length>.12 and track.TimePosition>0 then
                local remaining=(length-track.TimePosition)/speed;local last=self.Parry.Commitments[track] or 0
                if remaining<=self.Options.ParryLead and now-last>.35 then
                    self.Parry.Commitments[track]=now;self.Parry.Attempts+=1;self.Status.ParryStatus="Blocking "..model.Name
                    self:StartBlock(self.Options.ParryHold);return true
                end
            end
        end end
    end
    if not self.Parry.Blocking then self.Status.ParryStatus="Watching" end
    return false
end

-- Recovered protection sets from closure F108.
local STUN_MARKERS={Cancel=true,CombatStun=true,KnockedOut=true,Strict_Stun=true,Stun=true}
local RAGDOLL_MARKERS={RagDoll=true}
connect(RunService.Stepped,function(_,dt)
    if not Core.Alive then return end
    local c,h=Core:Character(); if not c then return end
    if Core.Options.NoStun then
        for _,v in ipairs(c:GetDescendants()) do
            if STUN_MARKERS[v.Name] then
                if v:IsA("BoolValue") then v.Value=false elseif v:IsA("NumberValue") then v.Value=0 end
            end
        end
    end
    if Core.Options.NoRagdoll then
        for _,v in ipairs(c:GetDescendants()) do
            if RAGDOLL_MARKERS[v.Name] and v:IsA("BoolValue") then v.Value=false end
        end
        if h then pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false) end) end
    end
    if Core.Options.NoAttackSlowdown then
        for _,v in ipairs(c:GetDescendants()) do
            local n=v.Name:lower()
            if (n:find("attackslow",1,true) or n=="attackspeedreduction" or n=="combatslow") then
                if v:IsA("BoolValue") then v.Value=false elseif v:IsA("NumberValue") then v.Value=0 end
            end
        end
    end
    if h and Core.Options.WalkSpeedEnabled then h.WalkSpeed=Core.Options.WalkSpeed end
    local _,_,root=Core:Character()
    if root and Core.Options.Fly then
        local camera=workspace.CurrentCamera;local direction=Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction+=camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction-=camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction+=camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction-=camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction+=Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction-=Vector3.yAxis end
        root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=Vector3.zero
        if direction.Magnitude>0 then root.CFrame+=direction.Unit*Core.Options.FlySpeed*math.min(dt or 0,1/15) end
    end
    if Core.Options.InfiniteStamina or Core.Options.InfiniteClimb or Core.Options.NoDrown or Core.Options.NoSunDamage or Core.Options.NoDashCooldown then
        local profile=Core:ActiveSlot()
        for _,root in ipairs({c,profile}) do if root then for _,v in ipairs(root:GetDescendants()) do if v:IsA("ValueBase") then
            local n=v.Name:lower()
            if Core.Options.InfiniteStamina and (n=="stamina" or n=="currentstamina") and type(v.Value)=="number" then
                local maximum=v.Parent and (v.Parent:FindFirstChild("MaxStamina") or v.Parent:FindFirstChild("CurrentMax"));v.Value=maximum and maximum.Value or math.max(v.Value,100)
            elseif Core.Options.InfiniteClimb and (n=="climbtime" or n=="maxclimbtime") and type(v.Value)=="number" then v.Value=math.max(v.Value,999)
            elseif Core.Options.NoDrown and (n=="oxygen" or n=="breath") and type(v.Value)=="number" then v.Value=math.max(v.Value,100)
            elseif Core.Options.NoSunDamage and (n=="insun" or n=="sunburn" or n=="sundamage") then
                if v:IsA("BoolValue") then v.Value=false elseif type(v.Value)=="number" then v.Value=0 end
            elseif Core.Options.NoDashCooldown and n:find("dash",1,true) and n:find("cooldown",1,true) and type(v.Value)=="number" then v.Value=0 end
        end end end end
    end
    for _,part in ipairs(c:GetDescendants()) do if part:IsA("BasePart") then
        if Core.Options.Noclip or Core.Options.Fly then
            if Core.CollisionState[part]==nil then Core.CollisionState[part]=part.CanCollide end
            part.CanCollide=false
        elseif Core.CollisionState[part]~=nil then
            part.CanCollide=Core.CollisionState[part];Core.CollisionState[part]=nil
        end
    end end
end)
connect(UserInputService.JumpRequest,function()
    if Core.Options.InfiniteJump then local _,h=Core:Character();if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)
connect(LocalPlayer.Idled,function()
    if Core.Options.AntiAfk then pcall(function()VirtualUser:CaptureController();VirtualUser:ClickButton2(Vector2.zero,workspace.CurrentCamera.CFrame)end) end
end)
connect(LocalPlayer.CharacterAdded,function()
    if Core.ActiveTween then pcall(function()Core.ActiveTween:Cancel()end);Core.ActiveTween=nil end
    Core.Movement.Owner=nil;Core.Movement.Priority=0;Core.Movement.Expires=0
    Core.Status.PriorityHolder="None";Core.Status.TeleportStatus="Respawned"
    Core.CombatInput:Clear();table.clear(Core.CollisionState)
end)
connect(GuiService.ErrorMessageChanged,function(message)
    if not Core.Options.AutoReconnect or Core.ReconnectBusy or tostring(message)=="" then return end
    Core.ReconnectBusy=true;Core.Status.WorldStatus="Disconnected; rejoining"
    task.delay(2,function()
        if not Core.Alive then return end
        local ok,err=pcall(TeleportService.TeleportToPlaceInstance,TeleportService,game.PlaceId,game.JobId,LocalPlayer)
        if not ok then Core:RecordError("AutoReconnect",err);Core.ReconnectBusy=false end
    end)
end)

-- Recovered boss/chest helper layout: isOpened, bossIds, isBoss, open, bossNearby.
Core.Chests={}
function Core.Chests:IsOpened(model)
    if model:GetAttribute("IsOpen")==true or model:GetAttribute("Opened")==true then return true end
    local state=model:FindFirstChild("ChestState",true) or model:FindFirstChild("Opened",true)
    if state and state:IsA("BoolValue") then return state.Value end
    if state and state:IsA("StringValue") then return state.Value:lower()=="opened" or state.Value:lower()=="open" end
    return false
end
function Core.Chests:IsBoss(model)
    local name=model.Name:lower()
    return model:GetAttribute("Boss")==true or model:GetAttribute("IsBoss")==true or name:find("boss",1,true)~=nil
end
function Core.Chests:Tier(model)
    local tier=model:GetAttribute("ChestTier") or model:GetAttribute("Tier")
    if tier~=nil then return tostring(tier) end
    return model.Name:match("[Tt]ier%s*(%d+)") or model.Name:match("[Tt](%d+)") or "Unknown"
end
function Core.Chests:TierAllowed(model)
    local selected=Core.Options.ChestTiers;if next(selected)==nil then return true end
    local tier=self:Tier(model)
    return selected[tier]==true or selected["T"..tier]==true or table.find(selected,tier)~=nil or table.find(selected,"T"..tier)~=nil
end
function Core.Chests:Tagged()
    local out,seen={},{}
    local function add(object) if object and object.Parent and not seen[object] then seen[object]=true;out[#out+1]=object end end
    for _,tag in ipairs({"Chest","Chests","TreasureChest","BossChest"}) do for _,x in ipairs(CollectionService:GetTagged(tag)) do add(x) end end
    for _,folderName in ipairs({"Chests","ChestSpawns","LootChests"}) do
        local folder=workspace:FindFirstChild(folderName,true)
        if folder then for _,x in ipairs(folder:GetChildren()) do add(x) end end
    end
    local debree=workspace:FindFirstChild("Debree")
    if debree then for _,x in ipairs(debree:GetDescendants()) do
        if (x:IsA("Model") or x:IsA("BasePart")) and (x:GetAttribute("ChestId")~=nil or x:GetAttribute("ChestTier")~=nil) then add(x) end
    end end
    return out
end
function Core.Chests:Open(model)
    if self:IsOpened(model) then return true end
    for _,x in ipairs(model:GetDescendants()) do
        if x:IsA("ProximityPrompt") and type(fireproximityprompt)=="function" then pcall(fireproximityprompt,x,0) end
        if x:IsA("ClickDetector") and type(fireclickdetector)=="function" then pcall(fireclickdetector,x) end
    end
    return self:IsOpened(model)
end

-- Readable worker controllers reconstructed from F120-F126 and F169-F174.
-- Each worker has a generation token: toggling it never creates duplicate loops.
Core.Generation={}
function Core:RecordError(source,message)
    self.Errors[#self.Errors+1]={Time=os.clock(),Source=tostring(source),Message=tostring(message)}
    while #self.Errors>30 do table.remove(self.Errors,1) end
end
function Core:SpawnWorker(name,fn)
    self.Generation[name]=(self.Generation[name] or 0)+1
    local generation=self.Generation[name];local token={};self.ThreadTokens[name]=token
    self.Threads[name]=task.spawn(function()
        local ok,err=xpcall(function() fn(generation) end,debug.traceback)
        if not ok and Core.Alive then Core:RecordError(name,err);warn("[NZL Studio/"..name.."] "..tostring(err)) end
        if Core.ThreadTokens[name]==token then Core.Threads[name]=nil;Core.ThreadTokens[name]=nil end
    end)
end
function Core:WorkerAlive(name,generation)
    return self.Alive and self.Options[name]==true and self.Generation[name]==generation
end
function Core:SetStatus(name,text) self.Status[name.."Status"]=text end
function Core:Notify(title,text)
    pcall(StarterGui.SetCore,StarterGui,"SendNotification",{Title=title,Text=text,Duration=5})
end

function Core:TargetCFrame(entity)
    local _,_,root=self:Character(); if not root or not entity or not entity.Root then return end
    local target=entity.Root.CFrame
    local kind=self.Options.PositionType
    if kind=="Behind" then target=target*CFrame.new(0,0,self.Options.OffsetDistance)
    elseif kind=="Front" then target=target*CFrame.new(0,0,-self.Options.OffsetDistance)
    else target=target*CFrame.new(0,self.Options.HeightOffset,0)*CFrame.Angles(math.rad(-90),0,0) end
    if self.Options.LookAtEnemy then return CFrame.lookAt(target.Position,entity.Root.Position) end
    return target
end
local MOVE_PRIORITY={Soul=10,Loot=20,Chest=30,Training=40,AutoMob=50,AutoLevel=60,Delivery=65,AutoQuest=70,Quest=70,AutoBoss=75,AutoBossHunt=80,AutoDungeon=85,AutoDemon=90,Teleport=100}
function Core:AcquireMovement(owner,seconds)
    owner=owner or "Teleport";local priority=MOVE_PRIORITY[owner] or 40;local movement=self.Movement;local now=os.clock()
    if movement.Owner and movement.Owner~=owner and movement.Expires>now and movement.Priority>priority then return false end
    if movement.Owner~=owner then
        movement.Epoch+=1
        if self.ActiveTween then pcall(function()self.ActiveTween:Cancel()end);self.ActiveTween=nil end
    end
    movement.Owner=owner;movement.Priority=priority;movement.Expires=now+(seconds or .75)
    self.Status.PriorityHolder=owner;self.Status.PriorityStatus="Active"
    return true,movement.Epoch
end
function Core:ReleaseMovement(owner,epoch)
    local movement=self.Movement
    if movement.Owner==owner and (not epoch or movement.Epoch==epoch) then
        movement.Owner=nil;movement.Priority=0;movement.Expires=0
        self.Status.PriorityHolder="None";self.Status.PriorityStatus="Off"
    end
end
function Core:MoveTo(destination,statusName)
    local _,humanoid,root=self:Character(); if not root or not destination then return false end
    local owner=statusName or "Teleport";local cf=typeof(destination)=="CFrame" and destination or destination.CFrame
    local distance=(root.Position-cf.Position).Magnitude
    local allowed,epoch=self:AcquireMovement(owner,math.max(.5,distance/self.Options.TweenSpeed+.25));if not allowed then return false,"movement busy" end
    if distance<3 then root.CFrame=cf;self:ReleaseMovement(owner,epoch);return true end
    local statusKey=({AutoMob="Mob",AutoBoss="Boss",AutoBossHunt="Hunt",AutoLevel="Level",AutoQuest="Quest",AutoDungeon="Dungeon",AutoDemon="Demon"})[owner] or owner
    self:SetStatus(statusKey,"Moving")
    if self.ActiveTween then pcall(function() self.ActiveTween:Cancel() end) end
    local tween=TweenService:Create(root,TweenInfo.new(distance/self.Options.TweenSpeed,Enum.EasingStyle.Linear),{CFrame=cf})
    self.ActiveTween=tween;tween:Play();tween.Completed:Wait()
    if self.ActiveTween==tween then self.ActiveTween=nil end
    local arrived=root.Parent~=nil and (root.Position-cf.Position).Magnitude<12
    self:ReleaseMovement(owner,epoch);return arrived
end
function Core:HoldTarget(entity,owner)
    if not entity or not entity.Model.Parent or entity.Humanoid.Health<=0 then return false end
    local cf=self:TargetCFrame(entity);local _,_,root=self:Character()
    if cf and root then
        -- Approach distant targets smoothly, then lock to the configured offset.
        -- Re-tweening to an old moving CFrame caused the rejected trailing behavior.
        if (root.Position-cf.Position).Magnitude>40 then self:MoveTo(cf,owner or "AutoMob")
        else
            if self.ActiveTween then pcall(function()self.ActiveTween:Cancel()end);self.ActiveTween=nil end
            root.CFrame=cf
        end
    end
    if root and entity.Root.Parent then
        root.AssemblyLinearVelocity=Vector3.zero
        root.AssemblyAngularVelocity=Vector3.zero
    end
    return true
end
function Core:IsBoss(entity)
    return entity.Model:GetAttribute("Boss")==true or entity.Model:GetAttribute("IsBoss")==true
        or CollectionService:HasTag(entity.Model,"Boss") or entity.Name:lower():find("boss",1,true)~=nil
end
function Core:SelectTarget(mode)
    local selected=mode=="Boss" and self.Options.SelectedBoss or self.Options.SelectedMob
    local best,distance
    local _,_,root=self:Character(); if not root then return end
    for _,entity in ipairs(self:Entities()) do
        local boss=self:IsBoss(entity)
        local allowed=(mode=="Boss" and boss) or (mode~="Boss" and not boss)
        if allowed and (not selected or selected=="" or selected=="All" or entity.Name==selected) then
            local d=(root.Position-entity.Root.Position).Magnitude
            if not distance or d<distance then best,distance=entity,d end
        end
    end
    return best,distance
end
function Core:Fight(entity,worker,generation)
    if not entity then return false end
    local statusKey=({AutoMob="Mob",AutoBoss="Boss",AutoBossHunt="Hunt",AutoLevel="Level",AutoQuest="Quest",AutoDungeon="Dungeon",AutoDemon="Demon"})[worker] or worker
    self:SetStatus(statusKey,entity.Name)
    while self:WorkerAlive(worker,generation) and entity.Model.Parent and entity.Humanoid.Health>0 do
        self:HoldTarget(entity,worker)
        local _,attackWait=self:Attack()
        -- Runtime traces show Instant Kill still uses the normal Combat_Service
        -- route; never invent a damage remote or overlap invalid combo indices.
        task.wait(self.Options.InstantKill and math.max(.04,(attackWait or .12)*.35) or (attackWait or .12))
    end
    if entity.Humanoid.Health<=0 then self.Status.Kills+=1 end
    return true
end

function Core:QuestFolder()
    return path(self:ActiveSlot(),"Quests")
end
function Core:HasQuest(name)
    local folder=self:QuestFolder(); if not folder then return false end
    if name and name~="" and name~="Recommended" then return folder:FindFirstChild(name,true)~=nil end
    return #folder:GetChildren()>0
end
function Core:RecommendedQuest()
    local selected=self.Options.SelectedQuest
    if selected and selected~="" and selected~="Recommended" then return selected end
    local module=self.Modules.RecommendedQuest or self:ResolveModule("RecommendedQuest")
    if type(module)=="table" then
        for _,method in ipairs({"Get","GetQuest","Recommended","Resolve"}) do
            if type(module[method])=="function" then
                local ok,result=pcall(module[method],self:CurrentLevel())
                if ok and type(result)=="string" then return result end
            end
        end
    end
    return selected
end
function Core:FindQuestNpc(questName)
    local regions=path(workspace,"Debree","Regions") or path(workspace,"Humanoids","Regions")
    if not regions then return end
    local _,_,root=self:Character(); local best,distance
    for _,model in ipairs(regions:GetDescendants()) do
        if model:IsA("Model") and (model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart) then
            local declared=model:GetAttribute("Quest") or model:GetAttribute("QuestName")
            if declared==questName or model.Name==questName or model:FindFirstChild("QuestGiver",true) then
                local part=model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                local d=root and (root.Position-part.Position).Magnitude or 0
                if not distance or d<distance then best,distance=part,d end
            end
        end
    end
    return best
end
function Core:QuestDefinition(questName)
    local quests=self.Modules.Quests or self:ResolveModule("Quests")
    if type(quests)=="table" and type(quests.Holder)=="table" then return quests.Holder[questName] end
end
function Core:QuestTargets(questName)
    local definition=self:QuestDefinition(questName);local names,seen={},{}
    local function add(value)
        if type(value)=="string" and value~="" and not seen[value] then seen[value]=true;names[#names+1]=value end
    end
    local function walk(value,key,depth)
        if depth>7 then return end
        if type(value)=="table" then
            for k,v in pairs(value) do
                local label=tostring(k):lower()
                if type(v)=="string" and (label:find("mob",1,true) or label:find("target",1,true) or label:find("enemy",1,true) or label=="name") then add(v)
                elseif type(v)=="table" then walk(v,k,depth+1) end
            end
        end
    end
    walk(definition,nil,0);return names
end
function Core:ActiveQuestNames()
    local out={};local folder=self:QuestFolder();if not folder then return out end
    for _,quest in ipairs(folder:GetChildren()) do out[#out+1]=quest.Name end
    return out
end
function Core:QuestTarget(questName)
    local targetSet={};for _,name in ipairs(self:QuestTargets(questName)) do targetSet[name]=true end
    local _,_,root=self:Character();if not root then return end
    local best,distance
    for _,entity in ipairs(self:Entities()) do
        local match=targetSet[entity.Name]
        if not match then for name in pairs(targetSet) do if entity.Name:find(name,1,true) or name:find(entity.Name,1,true) then match=true;break end end end
        if match then local d=(root.Position-entity.Root.Position).Magnitude;if not distance or d<distance then best,distance=entity,d end end
    end
    return best,distance
end
function Core:DeliveryQuestName()
    local selected=self.Options.SelectedQuest
    if selected and selected:lower():find("delivery",1,true) then return selected end
    local quests=self.Modules.Quests or self:ResolveModule("Quests")
    if type(quests)=="table" and type(quests.Holder)=="table" then
        for name,definition in pairs(quests.Holder) do
            local lower=tostring(name):lower()
            if lower:find("delivery",1,true) or (type(definition)=="table" and tostring(definition.Type or definition.QuestType):lower()=="delivery") then return name end
        end
    end
end
function Core:DeliveryDestination(questName)
    local definition=self:QuestDefinition(questName);local position,npcName
    local function walk(value,key,depth)
        if depth>7 or position then return end
        if typeof(value)=="CFrame" then position=value
        elseif typeof(value)=="Vector3" then position=CFrame.new(value)
        elseif type(value)=="string" then
            local label=tostring(key or ""):lower()
            if label:find("receiver",1,true) or label:find("destination",1,true) or label:find("deliver",1,true) or label:find("targetnpc",1,true) then npcName=value end
        elseif type(value)=="table" then for k,v in pairs(value) do walk(v,k,depth+1) end end
    end
    walk(definition,nil,0)
    if position then return position end
    if npcName then local part=self:FindNamedWorldPart(npcName,"Npc");if part then return part.CFrame end end
end
function Core:AcquireQuest(questName)
    if not questName or self:HasQuest(questName) then return true end
    local npc=self:FindQuestNpc(questName)
    if npc then self:MoveTo(npc.CFrame*CFrame.new(0,0,4),"Quest") end
    local quests=self.Modules.Quests or self:ResolveModule("Quests")
    if type(quests)=="table" and type(quests.CanAddQuest)=="function" then
        local ok,allowed=pcall(quests.CanAddQuest,questName)
        if ok and not allowed then return false end
    end
    self:Event("AddQuest",questName);self:Event("EndNpcTalk");self:Event("NpcTalking","Ended");task.wait(.6)
    return self:HasQuest(questName)
end

function Core:NearestLoot()
    local _,_,root=self:Character(); if not root then return end
    local best,distance
    local candidates={}
    local seen={}
    local function add(object) if object and object.Parent and not seen[object] then seen[object]=true;candidates[#candidates+1]=object end end
    for _,tag in ipairs({"LootDrop","Drop","ItemDrop"}) do for _,object in ipairs(CollectionService:GetTagged(tag)) do add(object) end end
    for _,folderName in ipairs({"LootDrops","Drops","DroppedItems"}) do
        local folder=workspace:FindFirstChild(folderName,true);if folder then for _,object in ipairs(folder:GetChildren()) do add(object) end end
    end
    for _,object in ipairs(candidates) do
        local part=object:IsA("BasePart") and object or object:FindFirstChildWhichIsA("BasePart",true)
        if part then local d=(root.Position-part.Position).Magnitude
            if d<=self.Options.LootRange and (not distance or d<distance) then best,distance=object,d end
        end
    end
    return best
end
function Core:Activate(object)
    local used=false
    for _,x in ipairs(object:GetDescendants()) do
        if x:IsA("ProximityPrompt") and type(fireproximityprompt)=="function" then used=true;pcall(fireproximityprompt,x,0) end
        if x:IsA("ClickDetector") and type(fireclickdetector)=="function" then used=true;pcall(fireclickdetector,x) end
        if x:IsA("TouchTransmitter") then local _,_,root=self:Character(); if root and type(firetouchinterest)=="function" then used=true;pcall(firetouchinterest,root,x.Parent,0);pcall(firetouchinterest,root,x.Parent,1) end end
    end
    return used
end

local workerBodies={}
workerBodies.AutoMob=function(g) while Core:WorkerAlive("AutoMob",g) do local target=Core:SelectTarget("Mob");if target then Core:Fight(target,"AutoMob",g) else Core:SetStatus("Mob","Searching");task.wait(.5) end end Core:SetStatus("Mob","Idle") end
workerBodies.AutoBoss=function(g) while Core:WorkerAlive("AutoBoss",g) do local target=Core:SelectTarget("Boss");if target then Core:Fight(target,"AutoBoss",g) else Core:SetStatus("Boss","Searching");task.wait(.7) end end Core:SetStatus("Boss","Idle") end
workerBodies.AutoQuest=function(g)
    while Core:WorkerAlive("AutoQuest",g) do
        local quest=Core:RecommendedQuest();Core:SetStatus("Quest",quest and "Checking" or "No quest")
        if quest and not Core:HasQuest(quest) then Core:AcquireQuest(quest) end
        if quest and Core:HasQuest(quest) then
            local target=Core:QuestTarget(quest)
            if not target and Core.Options.SelectedMob then target=Core:Closest(Core.Options.SelectedMob) end
            if target then
                Core:Fight(target,"AutoQuest",g)
                if not Core:HasQuest(quest) then Core.Status.Quests+=1 end
            else Core:SetStatus("Quest","Target unavailable");task.wait(.7) end
        else task.wait(.7) end
    end
    Core:SetStatus("Quest","Idle")
end
workerBodies.AutoLevel=function(g)
    while Core:WorkerAlive("AutoLevel",g) do
        if Core:CurrentLevel()>=Core.MAX_LEVEL then Core:SetStatus("Level","Max level");Core.Options.AutoLevel=false;break end
        local quest=Core:RecommendedQuest();if quest and not Core:HasQuest(quest) then Core:AcquireQuest(quest) end
        local target=quest and Core:QuestTarget(quest) or nil
        if not target then target=Core:SelectTarget("Mob") end
        if target then Core:Fight(target,"AutoLevel",g) else Core:SetStatus("Level","Searching");task.wait(.5) end
    end
    Core:SetStatus("Level","Idle")
end
function Core:TrainingObjects(force)
    if not force and self.TrainingCache and os.clock()-(self.TrainingCacheAt or 0)<8 then return self.TrainingCache end
    local out,seen={},{}
    local function add(object)
        if object and object.Parent and not seen[object] then
            local part=object:IsA("BasePart") and object or object:FindFirstChildWhichIsA("BasePart",true)
            if part then seen[object]=true;out[#out+1]={Object=object,Part=part,Name=object.Name} end
        end
    end
    for _,tag in ipairs({"Training","TrainingProp","Minigame","StudyProp"}) do for _,object in ipairs(CollectionService:GetTagged(tag)) do add(object) end end
    for _,prompt in ipairs(workspace:GetDescendants()) do if prompt:IsA("ProximityPrompt") then
        local text=(prompt.ActionText.." "..prompt.ObjectText):lower()
        if text:find("train",1,true) or text:find("practice",1,true) or text:find("study",1,true) then add(prompt:FindFirstAncestorOfClass("Model") or prompt.Parent) end
    end end
    self.TrainingCache=out;self.TrainingCacheAt=os.clock();return out
end
function Core:TrainingNames()
    local found,out={},{};for _,entry in ipairs(self:TrainingObjects()) do if not found[entry.Name] then found[entry.Name]=true;out[#out+1]=entry.Name end end;table.sort(out);return out
end
function Core:SetTrainingMode(name) self.Options.SelectedTraining=(name==nil or tostring(name)=="Nearest") and nil or tostring(name) end
function Core:FishingRod()
    local character=LocalPlayer.Character
    local backpack=LocalPlayer:FindFirstChildOfClass("Backpack")
    for _,container in ipairs({character,backpack}) do
        if container then
            for _,tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") then
                    local name=tool.Name:lower()
                    if name:find("fishing rod",1,true) or tool:GetAttribute("FishingRod") then return tool,container==character end
                end
            end
        end
    end
end
function Core:SetFishBait(name) self.Options.FishBait=name and tostring(name) or nil end
function Core:SetFishCastDelay(value) self.Options.FishCastDelay=math.clamp(tonumber(value) or 1.2,.4,5) end
workerBodies.AutoFish=function(g)
    while Core:WorkerAlive("AutoFish",g) do
        local tool,equipped=Core:FishingRod()
        if not tool then Core:SetStatus("Fish","No fishing rod");task.wait(2)
        else
            if not equipped then local _,humanoid=Core:Character();if humanoid then humanoid:EquipTool(tool);task.wait(.4) end end
            if Core.Options.FishBait then Core:Event("EquipBait",Core.Options.FishBait) end
            Core:SetStatus("Fish","Casting")
            pcall(function()tool:Activate()end);Core.CombatInput:Press("Fishing");task.wait(.05);Core.CombatInput:Release("Fishing")
            task.wait(Core.Options.FishCastDelay)
            local line=tool:FindFirstChild("FishingLine",true) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("FishingLine",true))
            local bite=tool:GetAttribute("Bite") or tool:GetAttribute("Hooked") or (line and (line:GetAttribute("Bite") or line:GetAttribute("Hooked")))
            if bite then
                Core:SetStatus("Fish","Reeling in");pcall(function()tool:Activate()end);Core.CombatInput:Press("Fishing");task.wait(.05);Core.CombatInput:Release("Fishing");Core.Status.Fish+=1
            end
            task.wait(.35)
        end
    end
    Core.CombatInput:Release("Fishing");Core:SetStatus("Fish","Idle")
end
function Core:SetQueueModes(values) self.Options.QueueModes=type(values)=="table" and values or {} end
function Core:SetQueueRanked(value) self.Options.QueueRanked=value==true end
function Core:SetQueueFill(value) self.Options.QueueFill=value==true end
function Core:SetCardSelection(values) self.Options.CardSelection=type(values)=="table" and values or {} end
function Core:SetCardPriority(values) self.Options.CardPriority=type(values)=="table" and values or {} end
function Core:SetForceHealCards(value) self.Options.ForceHealCards=value==true end
function Core:CardOffers()
    local offers=path(self:ActiveSlot(),"OuwigaharaOffers") or path(ReplicatedStorage,"Player_Service","Values",LocalPlayer.Name,"OuwigaharaOffers")
    local out={};if not offers then return out end
    for _,item in ipairs(offers:GetChildren()) do
        local name=item:IsA("StringValue") and item.Value or item.Name
        if type(name)=="string" and name~="" then out[#out+1]=name end
    end
    return out
end
function Core:ChooseCard()
    local offers=self:CardOffers();if #offers==0 then return end
    local selected={};for _,name in ipairs(self.Options.CardSelection) do selected[name]=true end
    for _,priority in ipairs(self.Options.CardPriority) do for _,offer in ipairs(offers) do if offer==priority and (next(selected)==nil or selected[offer]) then return offer end end end
    for _,offer in ipairs(offers) do if next(selected)==nil or selected[offer] then return offer end end
end
function Core:SetDungeonRange(value) self.Options.DungeonRange=math.clamp(tonumber(value) or 500,25,3000) end
function Core:SetDemonDrink(value) self.Options.DemonDrink=value==true end
function Core:SetDrinkBelow(value) self.Options.DrinkBelow=math.clamp(tonumber(value) or 65,1,100) end
function Core:SetDemonMob(value) self.Options.DemonMob=value and tostring(value) or nil end
function Core:IsDemon()
    local slot=self:ActiveSlot();if not slot then return false end
    local notDemon=slot:FindFirstChild("IsNotDemon",true);if notDemon and notDemon:IsA("BoolValue") then return not notDemon.Value end
    local race=slot:FindFirstChild("Race",true) or slot:FindFirstChild("Faction",true)
    return race and tostring(race.Value):lower():find("demon",1,true)~=nil or false
end
function Core:FindMuzan()
    if self.MuzanCache and self.MuzanCache.Parent then return self.MuzanCache end
    if self.MuzanScanAt and os.clock()-self.MuzanScanAt<5 then return end;self.MuzanScanAt=os.clock()
    local exact=workspace:FindFirstChild("Muzan",true)
    if exact then
        local part=exact:IsA("BasePart") and exact or exact:FindFirstChild("HumanoidRootPart") or (exact:IsA("Model") and exact.PrimaryPart) or exact:FindFirstChildWhichIsA("BasePart",true)
        if part then self.MuzanCache=part;return part end
    end
    for _,object in ipairs(workspace:GetDescendants()) do if object:IsA("Model") and object.Name:lower():find("muzan",1,true) then
        local part=object:FindFirstChild("HumanoidRootPart") or object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart",true);if part then self.MuzanCache=part;return part end
    end end
end
function Core:TeleportToMuzan()
    local part=self:FindMuzan();if not part then return false,"Muzan not found" end
    return self:MoveTo(part.CFrame*CFrame.new(0,0,4),"Teleport")
end
function Core:DrinkMuzanBlood()
    local character,humanoid=self:Character();if not character or not humanoid then return false end
    if humanoid.Health/humanoid.MaxHealth>self.Options.DrinkBelow/100 then return false,"health above threshold" end
    local backpack=LocalPlayer:FindFirstChildOfClass("Backpack");local tool=(backpack and backpack:FindFirstChild("Muzan's Blood")) or character:FindFirstChild("Muzan's Blood")
    if not tool or not tool:IsA("Tool") then return false,"blood unavailable" end
    humanoid:EquipTool(tool);task.wait(.15);pcall(function()tool:Activate()end);return true
end
workerBodies.AutoDemon=function(g)
    while Core:WorkerAlive("AutoDemon",g) do
        if Core:IsDemon() then Core:SetStatus("Demon","You are a demon");Core.Options.AutoDemon=false;break end
        if Core.Options.DemonDrink then local ok=Core:DrinkMuzanBlood();if ok then Core:SetStatus("Demon","Drinking Muzan's Blood");task.wait(2);continue end end
        local muzan=Core:FindMuzan()
        if muzan then
            Core:SetStatus("Demon","Travelling to Muzan");Core:MoveTo(muzan.CFrame*CFrame.new(0,0,4),"AutoDemon")
            for _,object in ipairs(muzan.Parent:GetDescendants()) do if object:IsA("ProximityPrompt") and type(fireproximityprompt)=="function" then pcall(fireproximityprompt,object,0) end end
            Core:Event("MuzanLairAssign");Core:Event("MuzanGiveBell");task.wait(2)
        else
            Core:SetStatus("Demon","Searching for Muzan")
            local target=Core.Options.DemonMob and Core:Closest(Core.Options.DemonMob) or nil
            if target then Core:Fight(target,"AutoDemon",g) else task.wait(2) end
        end
    end
    Core:SetStatus("Demon","Idle")
end
function Core:InDungeon()
    local roots={self:ActiveSlot(),path(ReplicatedStorage,"Player_Service","Values",LocalPlayer.Name),workspace}
    for _,root in ipairs(roots) do if root then
        local value=root:FindFirstChild("InDungeon",true)
        if value and value:IsA("BoolValue") then return value.Value end
        local dungeon=root:FindFirstChild("DungeonName",true)
        if dungeon and dungeon:IsA("StringValue") and dungeon.Value~="" then return true end
    end end
    return game.PlaceId~=136406881576517 and workspace:FindFirstChild("Floors")~=nil
end
function Core:DungeonTarget()
    local _,_,root=self:Character();if not root then return end
    local best,distance
    for _,entity in ipairs(self:Entities()) do
        local d=(root.Position-entity.Root.Position).Magnitude
        if d<=self.Options.DungeonRange and (not distance or d<distance) then best,distance=entity,d end
    end
    return best,distance
end
workerBodies.AutoDungeon=function(g)
    local lastFloor
    while Core:WorkerAlive("AutoDungeon",g) do
        if not Core:InDungeon() then Core:SetStatus("Dungeon","Waiting for dungeon");task.wait(2)
        else
            local values=path(ReplicatedStorage,"Player_Service","Values",LocalPlayer.Name)
            local floor=values and values:FindFirstChild("MinigameFloor",true)
            if floor and floor:IsA("ValueBase") and floor.Value~=lastFloor then if lastFloor~=nil then Core.Status.FloorsCleared+=1 end;lastFloor=floor.Value end
            local target=Core:DungeonTarget()
            if target then Core:SetStatus("Dungeon","Floor "..tostring(lastFloor or "?"));Core:Fight(target,"AutoDungeon",g)
            else
                Core:SetStatus("Dungeon","Collecting drops");local loot=Core:NearestLoot()
                if loot then local part=loot:IsA("BasePart") and loot or loot:FindFirstChildWhichIsA("BasePart",true);if part then Core:MoveTo(part.CFrame,"AutoDungeon") end;Core:Activate(loot) end
                task.wait(.5)
            end
        end
    end
    Core:SetStatus("Dungeon","Idle")
end
workerBodies.AutoQueue=function(g)
    while Core:WorkerAlive("AutoQueue",g) do
        local mode=Core.Options.QueueModes[1] or next(Core.Options.QueueModes)
        if not mode then Core:SetStatus("Queue","No mode selected");task.wait(2)
        else
            Core:SetStatus("Queue","Queueing "..tostring(mode))
            local ok=Core:Invoke("OuwigaharaRequest","Queue",mode,Core.Options.QueueRanked,Core.Options.QueueFill)
            if not ok then Core:Event("OuwigaharaRequest","Queue",mode,Core.Options.QueueRanked,Core.Options.QueueFill) end
            task.wait(5)
        end
    end
    Core:SetStatus("Queue","Idle")
end
workerBodies.AutoSkipWaves=function(g)
    while Core:WorkerAlive("AutoSkipWaves",g) do
        Core:SetStatus("Wave","Watching for a wave break")
        local values=path(ReplicatedStorage,"Player_Service","Values",LocalPlayer.Name)
        local breakValue=values and (values:FindFirstChild("MinigameWaveBreak",true) or values:FindFirstChild("WaveBreak",true))
        if breakValue and breakValue:IsA("BoolValue") and breakValue.Value then
            Core:SetStatus("Wave","Voting to skip");Core:Event("OuwigaharaRequest","SkipFloor");Core:Event("SkipFloor");task.wait(2)
        else task.wait(.5) end
    end
    Core:SetStatus("Wave","Idle")
end
workerBodies.AutoCards=function(g)
    while Core:WorkerAlive("AutoCards",g) do
        Core:SetStatus("Card","Watching for cards");local card=Core:ChooseCard()
        if card then
            Core:SetStatus("Card","Picking "..card)
            local ok=Core:Invoke("OuwigaharaRequest","Card",card)
            if not ok then Core:Event("OuwigaharaRequest","Card",card) end
            Core.Status.Cards+=1;task.wait(2)
        else task.wait(.6) end
    end
    Core:SetStatus("Card","Idle")
end
function Core:SetShopItems(values) self.Options.ShopItems=type(values)=="table" and values or {} end
function Core:SetBuyAmount(value) self.Options.BuyAmount=math.clamp(math.floor(tonumber(value) or 1),1,100) end
function Core:SetBuyInterval(value) self.Options.BuyInterval=math.clamp(tonumber(value) or 2,.5,30) end
function Core:ShopItemNames()
    local found,out={},{}
    local function add(name)if type(name)=="string" and name~="" and not found[name] then found[name]=true;out[#out+1]=name end end
    local items=self.Modules.Items or self:ResolveModule("Items")
    local function walk(value,depth)
        if depth>5 or type(value)~="table" then return end
        for key,item in pairs(value) do
            if type(key)=="string" and type(item)=="table" then
                if item.Price~=nil or item.Cost~=nil or item.Wen~=nil or item.ItemCategory~=nil then add(key) end
                walk(item,depth+1)
            elseif type(item)=="string" and (tostring(key):lower():find("name",1,true) or tostring(key):lower():find("item",1,true)) then add(item) end
        end
    end
    walk(items,0);table.sort(out);return out
end
function Core:PurchaseItem(name,amount)
    name=tostring(name or "");if name=="" then return false,"no item" end
    amount=math.clamp(math.floor(tonumber(amount) or self.Options.BuyAmount),1,100)
    local ok=self:Event("PurchaseFromShop",name,amount)
    if not ok then ok=self:Invoke("PurchaseSelection",{Item=name,Amount=amount}) end
    return ok
end
workerBodies.AutoBuy=function(g)
    while Core:WorkerAlive("AutoBuy",g) do
        if #Core.Options.ShopItems==0 then Core:SetStatus("Shop","No items selected");task.wait(2)
        else for _,item in ipairs(Core.Options.ShopItems) do
            if not Core:WorkerAlive("AutoBuy",g) then break end
            Core:SetStatus("Shop","Buying "..tostring(item));local ok=Core:PurchaseItem(item,Core.Options.BuyAmount)
            if ok then Core.Status.Bought+=Core.Options.BuyAmount end;task.wait(Core.Options.BuyInterval)
        end end
    end
    Core:SetStatus("Shop","Idle")
end
workerBodies.AutoTraining=function(g)
    while Core:WorkerAlive("AutoTraining",g) do
        local selected=Core.Options.SelectedTraining;local best,distance;local _,_,root=Core:Character()
        for _,entry in ipairs(Core:TrainingObjects()) do if not selected or selected=="" or selected==entry.Name then
            local d=root and (root.Position-entry.Part.Position).Magnitude or 0;if not distance or d<distance then best,distance=entry,d end
        end end
        if best then
            Core:SetStatus("Train","Training "..best.Name);Core:MoveTo(best.Part.CFrame*CFrame.new(0,0,4),"Training")
            if Core:Activate(best.Object) then Core.Status.Trainings+=1 end;task.wait(1)
        else Core:SetStatus("Train","Searching");task.wait(2) end
    end
    Core:SetStatus("Train","Idle")
end
workerBodies.AutoDelivery=function(g)
    while Core:WorkerAlive("AutoDelivery",g) do
        local quest=Core:DeliveryQuestName()
        if not quest then Core:SetStatus("Delivery","No delivery quest");task.wait(2)
        elseif not Core:HasQuest(quest) then
            Core:SetStatus("Delivery","Taking quest");Core:AcquireQuest(quest);task.wait(.7)
        else
            local destination=Core:DeliveryDestination(quest)
            if destination then
                Core:SetStatus("Delivery","Delivering");Core:MoveTo(destination*CFrame.new(0,0,4),"Delivery")
                local _,_,root=Core:Character();if root then
                    for _,part in ipairs(workspace:GetPartBoundsInRadius(root.Position,15)) do
                        for _,object in ipairs(part:GetChildren()) do if object:IsA("ProximityPrompt") and type(fireproximityprompt)=="function" then pcall(fireproximityprompt,object,0) end end
                    end
                end
                Core:Event("NpcTalking","Ended");task.wait(1)
                if not Core:HasQuest(quest) then Core.Status.Quests+=1 end
            else Core:SetStatus("Delivery","Destination unavailable");task.wait(1) end
        end
    end
    Core:SetStatus("Delivery","Idle")
end
workerBodies.AutoLoot=function(g) while Core:WorkerAlive("AutoLoot",g) do local loot=Core:NearestLoot();if loot then local part=loot:IsA("BasePart") and loot or loot:FindFirstChildWhichIsA("BasePart",true);if part then Core:MoveTo(part.CFrame,"Loot") end;if Core:Activate(loot) then Core.Status.Looted+=1 end;task.wait(.2) else Core:SetStatus("Loot","Searching");task.wait(.6) end end Core:SetStatus("Loot","Idle") end
workerBodies.AutoChest=function(g) while Core:WorkerAlive("AutoChest",g) do local found=false;for _,chest in ipairs(Core.Chests:Tagged()) do if Core:WorkerAlive("AutoChest",g) and chest.Parent and not Core.Chests:IsOpened(chest) and Core.Chests:TierAllowed(chest) then found=true;local part=chest:IsA("BasePart") and chest or chest:FindFirstChildWhichIsA("BasePart",true);if part then Core:MoveTo(part.CFrame,"Chest") end;if Core.Chests:Open(chest) then Core.Status.Chests+=1 end end end;if not found then Core:SetStatus("Chest","Searching");task.wait(.8) end end Core:SetStatus("Chest","Idle") end
workerBodies.AutoSkills=function(g) local keys=next(Core.Options.SelectedSkills) and Core.Options.SelectedSkills or {"Z","X","C","V","B","N"};while Core:WorkerAlive("AutoSkills",g) do for _,key in ipairs(keys) do if not Core:WorkerAlive("AutoSkills",g) then break end;Core:UseSkill(key);task.wait(.25) end end Core:SetStatus("Skill","Idle") end
workerBodies.AutoSkillTree=function(g)
    while Core:WorkerAlive("AutoSkillTree",g) do
        Core:SetStatus("AutoSkill","Checking points")
        local attempted=false
        for _,node in ipairs(Core.Options.SelectedSkillNodes) do
            if not Core:WorkerAlive("AutoSkillTree",g) then break end
            attempted=true
            -- Runtime-confirmed original protocol: this is a SignalFunction call,
            -- not either of the previously guessed SignalEvent variants.
            local ok,result=Core:Invoke("UnlockSkillTreeNode",node)
            if ok and result==true then Core.Status.PointsSpent+=1 end
            task.wait(.3)
        end
        if not attempted then Core:SetStatus("AutoSkill","No selected nodes") end
        task.wait(1.5)
    end
    Core:SetStatus("AutoSkill","Idle")
end
function Core:EquipBestTool()
    local _,humanoid=self:Character();local backpack=LocalPlayer:FindFirstChildOfClass("Backpack")
    if not humanoid or not backpack then return false end
    local best,score
    for _,tool in ipairs(backpack:GetChildren()) do if tool:IsA("Tool") then
        local category=tostring(tool:GetAttribute("ItemCategory") or tool:GetAttribute("InventoryCategory") or ""):lower()
        if category:find("weapon",1,true) or tool:GetAttribute("Damage") or tool:FindFirstChild("WeaponValue") then
            local value=tonumber(tool:GetAttribute("Damage") or tool:GetAttribute("Power") or tool:GetAttribute("RarityValue")) or 0
            if not score or value>score then best,score=tool,value end
        end
    end end
    if best then humanoid:EquipTool(best);self:Event("EquipWeapon",best.Name);return true end
    return false
end
workerBodies.AutoEquip=function(g)
    while Core:WorkerAlive("AutoEquip",g) do
        Core:SetStatus("Equip","Checking")
        if Core:EquipBestTool() then Core:SetStatus("Equip","Equipped") else Core:SetStatus("Equip","No combat item") end
        task.wait(4)
    end
    Core:SetStatus("Equip","Idle")
end
workerBodies.AutoPotion=function(g) while Core:WorkerAlive("AutoPotion",g) do local _,h=Core:Character();if h and h.Health/h.MaxHealth<(Core.Options.HealBelow/100) then Core:Event("Item",Core.Options.SelectedPotion);Core.Status.Potions+=1 end;task.wait(1) end Core:SetStatus("Potion","Idle") end

function Core:NearestTagged(tags,range)
    local _,_,root=self:Character();if not root then return end
    local best,distance
    for _,tag in ipairs(tags) do for _,object in ipairs(CollectionService:GetTagged(tag)) do
        local part=object:IsA("BasePart") and object or object:FindFirstChildWhichIsA("BasePart",true)
        if part then local d=(root.Position-part.Position).Magnitude;if (range==0 or d<=range) and (not distance or d<distance) then best,distance=object,d end end
    end end
    return best,distance
end
workerBodies.AutoSoul=function(g)
    while Core:WorkerAlive("AutoSoul",g) do
        local soul=Core:NearestTagged({"Soul","SoulDrop","BraveSoul"},Core.Options.SoulRange)
        if soul then
            Core:SetStatus("Soul","Collecting")
            local part=soul:IsA("BasePart") and soul or soul:FindFirstChildWhichIsA("BasePart",true)
            if part then Core:MoveTo(part.CFrame,"Soul") end
            if Core:Activate(soul) then Core.Status.Souls+=1 end
            task.wait(.25)
        else Core:SetStatus("Soul","Searching");task.wait(.8) end
    end
    Core:SetStatus("Soul","Idle")
end
workerBodies.AutoBreathing=function(g)
    while Core:WorkerAlive("AutoBreathing",g) do
        Core:SetStatus("Breath","Breathing")
        Core.CombatInput:Press("Breathing");task.wait(.35);Core.CombatInput:Release("Breathing");task.wait(.4)
    end
    Core.CombatInput:Release("Breathing");Core:SetStatus("Breath","Idle")
end
workerBodies.AlwaysRun=function(g)
    while Core:WorkerAlive("AlwaysRun",g) do Core.CombatInput:Press("Run");task.wait(.5) end
    Core.CombatInput:Release("Run")
end

workerBodies.AutoBringEnemies=function(g)
    while Core:WorkerAlive("AutoBringEnemies",g) do
        local _,_,root=Core:Character()
        if root and type(isnetworkowner)=="function" then for _,entity in ipairs(Core:Entities()) do
            if entity.Humanoid.Health>0 and (root.Position-entity.Root.Position).Magnitude<=Core.Options.BringRange then
                local ok,owned=pcall(isnetworkowner,entity.Root)
                if ok and owned then
                    entity.Root.AssemblyLinearVelocity=Vector3.zero;entity.Root.AssemblyAngularVelocity=Vector3.zero
                    entity.Root.CFrame=root.CFrame*CFrame.new(0,0,-6)
                end
            end
        end end
        task.wait(.12)
    end
end
workerBodies.AutoParry=function(g)
    Core.Status.ParryStatus="Watching"
    while Core:WorkerAlive("AutoParry",g) do Core:ParryStep();task.wait(.03) end
    Core.Parry.Generation+=1
    local controller=Core.Modules.SkillController or Core:ResolveModule("SkillController")
    if Core.Parry.Blocking then
        if type(controller)=="table" and type(controller.StopHold)=="function" then pcall(controller.StopHold,"Blocking") else Core.CombatInput:Release("Block") end
    end
    Core.Parry.Blocking=false;Core.Status.ParryStatus="Off"
end

workerBodies.AutoBossHunt=function(g)
    while Core:WorkerAlive("AutoBossHunt",g) do
        local target=Core:SelectTarget("Boss")
        if target then
            Core:Fight(target,"AutoBossHunt",g)
            Core.Status.Hunts+=1
        else
            Core:SetStatus("Hunt","Requesting")
            local ok=Core:Invoke("BossHuntsRequest","Request",Core.Options.HuntTiers)
            if not ok then Core:Event("BossHuntsRequest","Request",Core.Options.HuntTiers) end
            task.wait(2)
        end
    end
    Core:SetStatus("Hunt","Idle")
end

local setters={AutoLevel=true,AutoQuest=true,AutoMob=true,AutoBoss=true,AutoBossHunt=true,AutoLoot=true,AutoChest=true,AutoSkills=true,AutoSkillTree=true,AutoEquip=true,AutoPotion=true,AutoDelivery=true,AutoTraining=true,AutoFish=true,AutoBuy=true,AutoSoul=true,AutoBreathing=true,AlwaysRun=true,AutoParry=true,AutoBringEnemies=true,AutoQueue=true,AutoSkipWaves=true,AutoCards=true,AutoDungeon=true,AutoDemon=true}
for methodName in pairs(setters) do
    -- Capture a unique method key. On Lua 5.1-style executors, closing over the
    -- generic-for variable made every generated setter control one final worker.
    local method=methodName
    Core["Set"..method]=function(self,value)
        value=value==true;self.Options[method]=value;self.Generation[method]=(self.Generation[method] or 0)+1
        if value then self:SpawnWorker(method,workerBodies[method])
        else
            local owner=({AutoQuest="Quest",AutoDelivery="Delivery",AutoTraining="Training",AutoLoot="Loot",AutoChest="Chest",AutoSoul="Soul"})[method] or method
            self:ReleaseMovement(owner)
        end
        return true
    end
end
for _,methodName in ipairs({"InstantKill","NoStun","NoRagdoll","NoAttackSlowdown","NotifyBosses"}) do
    local method=methodName
    Core["Set"..method]=function(self,value) self.Options[method]=value==true return true end
end

-- Boss appearance notifications use collection tags instead of scanning every frame.
for _,tag in ipairs({"Boss","BossNPC"}) do
    connect(CollectionService:GetInstanceAddedSignal(tag),function(model)
        if Core.Options.NotifyBosses then Core:Notify("Boss appeared",model.Name) end
    end)
end

-- Lightweight local ESP. Objects are owned by Core and fully removed on unload.
function Core:RemoveEsp(object)
    local data=self.EspObjects[object]
    if data then for _,gui in ipairs(data) do pcall(function() gui:Destroy() end) end end
    self.EspObjects[object]=nil
end
function Core:AddEsp(object,kind,colour)
    if self.EspObjects[object] or not object.Parent then return end
    local part=object:IsA("BasePart") and object or object:FindFirstChild("HumanoidRootPart") or object:FindFirstChildWhichIsA("BasePart",true)
    if not part then return end
    local highlight=Instance.new("Highlight")
    highlight.Name="NZL_"..kind;highlight.Adornee=object;highlight.FillColor=colour
    highlight.FillTransparency=.72;highlight.OutlineColor=colour;highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent=object
    local billboard=Instance.new("BillboardGui")
    billboard.Name="NZL_Label";billboard.Adornee=part;billboard.AlwaysOnTop=true
    billboard.Size=UDim2.fromOffset(180,28);billboard.StudsOffset=Vector3.new(0,3,0);billboard.Parent=part
    local label=Instance.new("TextLabel");label.BackgroundTransparency=1;label.Size=UDim2.fromScale(1,1)
    label.Font=Enum.Font.GothamBold;label.TextSize=13;label.TextColor3=colour;label.TextStrokeTransparency=.25
    label.Text=object.Name;label.Parent=billboard
    self.EspObjects[object]={highlight,billboard}
end
function Core:RefreshEsp()
    local wanted={}
    local _,_,root=self:Character()
    for _,entity in ipairs(self:Entities()) do
        local boss=self:IsBoss(entity)
        if boss and not self.SeenBosses[entity.Model] then self.SeenBosses[entity.Model]=true;if self.Options.NotifyBosses then self:Notify("Boss appeared",entity.Name) end end
        local enabled=boss and self.Options.EspBosses or (not boss and self.Options.EspMobs)
        if enabled and (not root or self.Options.EspRange==0 or (root.Position-entity.Root.Position).Magnitude<=self.Options.EspRange) then
            wanted[entity.Model]=true;self:AddEsp(entity.Model,boss and "Boss" or "Mob",boss and self.Options.EspBossesColour or self.Options.EspMobsColour)
        end
    end
    if self.Options.EspChest then for _,chest in ipairs(self.Chests:Tagged()) do
        local part=chest:IsA("BasePart") and chest or chest:FindFirstChildWhichIsA("BasePart",true)
        if part and (not root or self.Options.EspRange==0 or (root.Position-part.Position).Magnitude<=self.Options.EspRange) then
            wanted[chest]=true;self:AddEsp(chest,"Chest",self.Options.EspChestColour)
        end
    end end
    if self.Options.EspPlayers then for _,player in ipairs(Players:GetPlayers()) do if player~=LocalPlayer and player.Character then
        local part=player.Character:FindFirstChild("HumanoidRootPart")
        if part and (not root or self.Options.EspRange==0 or (root.Position-part.Position).Magnitude<=self.Options.EspRange) then wanted[player.Character]=true;self:AddEsp(player.Character,"Player",self.Options.EspPlayersColour) end
    end end end
    if self.Options.EspNpcs then
        local regions=path(workspace,"Debree","Regions")
        if regions then for _,folder in ipairs(regions:GetDescendants()) do if folder.Name=="StationaryNpcs" then for _,npc in ipairs(folder:GetChildren()) do
            local part=npc:IsA("Model") and (npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart or npc:FindFirstChildWhichIsA("BasePart",true))
            if part and (not root or self.Options.EspRange==0 or (root.Position-part.Position).Magnitude<=self.Options.EspRange) then wanted[npc]=true;self:AddEsp(npc,"NPC",self.Options.EspNpcsColour) end
        end end end end
    end
    if self.Options.EspLoot then for _,tag in ipairs({"LootDrop","Drop","ItemDrop","SoulDrop"}) do for _,loot in ipairs(CollectionService:GetTagged(tag)) do
        local part=loot:IsA("BasePart") and loot or loot:FindFirstChildWhichIsA("BasePart",true)
        if part and (not root or self.Options.EspRange==0 or (root.Position-part.Position).Magnitude<=self.Options.EspRange) then wanted[loot]=true;self:AddEsp(loot,"Loot",self.Options.EspLootColour) end
    end end end
    if self.Options.EspMuzan then
        local part=self:FindMuzan();local object=part and (part:FindFirstAncestorOfClass("Model") or part)
        if part and object and (not root or self.Options.EspRange==0 or (root.Position-part.Position).Magnitude<=self.Options.EspRange) then wanted[object]=true;self:AddEsp(object,"Muzan",self.Options.EspMuzanColour) end
    end
    for object in pairs(self.EspObjects) do if not object.Parent or not wanted[object] then self:RemoveEsp(object) end end
end
Core.Threads.Esp=task.spawn(function() while Core.Alive do Core:RefreshEsp();task.wait(.65) end end)

function Core:SetTweenSpeed(v) self.Options.TweenSpeed=math.clamp(tonumber(v) or 190,20,400) end
function Core:SetHeightOffset(v) self.Options.HeightOffset=tonumber(v) or 8 end
function Core:SetOffsetDistance(v) self.Options.OffsetDistance=math.max(0,tonumber(v) or 4) end
function Core:SetLootRange(v) self.Options.LootRange=math.max(0,tonumber(v) or 200) end
function Core:SetKillThreshold(v) self.Options.KillThreshold=math.clamp(tonumber(v) or 0,0,100) end
function Core:SetBringRange(v) self.Options.BringRange=math.clamp(tonumber(v) or 100,10,500) end
function Core:SetNoclip(v) self.Options.Noclip=v==true end
function Core:SetInfiniteJump(v) self.Options.InfiniteJump=v==true end
function Core:SetWalkSpeedEnabled(v) self.Options.WalkSpeedEnabled=v==true end
function Core:SetWalkSpeed(v) self.Options.WalkSpeed=math.clamp(tonumber(v) or 16,0,250) end
function Core:SetFly(v) self.Options.Fly=v==true;if self.Options.Fly and self.ActiveTween then self.ActiveTween:Cancel();self.ActiveTween=nil end end
function Core:SetFlySpeed(v) self.Options.FlySpeed=math.clamp(tonumber(v) or 90,10,300) end
function Core:SetInfiniteStamina(v) self.Options.InfiniteStamina=v==true end
function Core:SetInfiniteClimb(v) self.Options.InfiniteClimb=v==true end
function Core:SetNoDrown(v) self.Options.NoDrown=v==true end
function Core:SetNoSunDamage(v) self.Options.NoSunDamage=v==true end
function Core:SetNoDashCooldown(v) self.Options.NoDashCooldown=v==true end
function Core:SetSoulRange(v) self.Options.SoulRange=math.max(0,tonumber(v) or 300) end
function Core:SetHealBelow(v) self.Options.HealBelow=math.clamp(tonumber(v) or 45,1,99) end
function Core:SetParryNpcs(v) self.Options.ParryNpcs=v==true end
function Core:SetParryPlayers(v) self.Options.ParryPlayers=v==true end
function Core:SetParryRadius(v) self.Options.ParryRadius=math.clamp(tonumber(v) or 40,5,100) end
function Core:SetParryLead(v) self.Options.ParryLead=math.clamp(tonumber(v) or .18,.02,1) end
function Core:SetParryHold(v) self.Options.ParryHold=math.clamp(tonumber(v) or .22,.05,2) end
function Core:SetParryMitigate(v) self.Options.ParryMitigate=v==true end
function Core:ResetParryStats() self.Parry.Attempts=0 return true end
function Core:SetEspMobs(v) self.Options.EspMobs=v==true end
function Core:SetEspBosses(v) self.Options.EspBosses=v==true end
function Core:SetEspChest(v) self.Options.EspChest=v==true end
function Core:SetEspPlayers(v) self.Options.EspPlayers=v==true end
function Core:SetEspNpcs(v) self.Options.EspNpcs=v==true end
function Core:SetEspLoot(v) self.Options.EspLoot=v==true end
function Core:SetEspMuzan(v) self.Options.EspMuzan=v==true end
function Core:SetEspRange(v) self.Options.EspRange=math.max(0,tonumber(v) or 1500) end
function Core:SetEspColour(kind,colour)
    if typeof(colour)~="Color3" then return false end
    local key=({Mob="EspMobsColour",Mobs="EspMobsColour",Boss="EspBossesColour",Bosses="EspBossesColour",Chest="EspChestColour",Players="EspPlayersColour",Player="EspPlayersColour",NPC="EspNpcsColour",Npcs="EspNpcsColour",Loot="EspLootColour",Muzan="EspMuzanColour"})[kind]
    if not key then return false end;self.Options[key]=colour
    for object in pairs(self.EspObjects) do self:RemoveEsp(object) end
    return true
end
function Core:SetMobTarget(v) self.Options.SelectedMob=tostring(v) end
function Core:SetBossSelection(v) self.Options.SelectedBoss=tostring(v) end
function Core:SetQuestSelection(v) self.Options.SelectedQuest=tostring(v) end
function Core:SetZoneSelection(v) self.Options.SelectedZone=tostring(v) end
function Core:SetNpcSelection(v) self.Options.SelectedNpc=tostring(v) end
function Core:SetPotion(v) self.Options.SelectedPotion=tostring(v) end
function Core:SetSkillHold(v) self.Options.SkillHold=math.clamp(tonumber(v) or .08,.02,10) end
function Core:SetSkillSelection(values) self.Options.SelectedSkills=type(values)=="table" and values or {} end
function Core:SetSkillNodes(values) self.Options.SelectedSkillNodes=type(values)=="table" and values or {} end
function Core:SetHuntTiers(values) self.Options.HuntTiers=type(values)=="table" and values or {} end
function Core:SetChestTiers(values) self.Options.ChestTiers=type(values)=="table" and values or {} end
function Core:SetChestInstantKill(v) self.Options.ChestInstantKill=v==true end
function Core:SetChestKillThreshold(v) self.Options.ChestKillThreshold=math.clamp(tonumber(v) or 0,0,100) end
function Core:ChestTierNames()
    local found,out={},{};for _,chest in ipairs(self.Chests:Tagged()) do local tier=self.Chests:Tier(chest);if not found[tier] then found[tier]=true;out[#out+1]=tier end end;table.sort(out);return out
end

function Core:Names(kind)
    local found,out={},{}
    local function add(name) if type(name)=="string" and name~="" and not found[name] then found[name]=true;out[#out+1]=name end end
    if kind=="Mob" or kind=="Boss" then
        for _,entity in ipairs(self:Entities()) do
            if (kind=="Boss") == self:IsBoss(entity) then add(entity.Name) end
        end
    elseif kind=="Npc" then
        local regions=path(workspace,"Debree","Regions") or path(workspace,"Humanoids","Regions")
        if regions then for _,x in ipairs(regions:GetDescendants()) do
            if x:IsA("Model") and (x.Parent.Name=="StationaryNpcs" or x:GetAttribute("NPC")) then add(x.Name) end
        end end
    elseif kind=="Zone" then
        for _,root in ipairs({workspace:FindFirstChild("Zones"),workspace:FindFirstChild("Map"),workspace:FindFirstChild("Locations")}) do
            if root then for _,x in ipairs(root:GetChildren()) do add(x.Name) end end
        end
        local regions=path(workspace,"Humanoids","Regions");if regions then for _,x in ipairs(regions:GetChildren()) do add(x.Name) end end
    elseif kind=="Quest" then
        local quests=self.Modules.Quests or self:ResolveModule("Quests")
        if type(quests)=="table" and type(quests.Holder)=="table" then for name in pairs(quests.Holder) do add(name) end end
    end
    table.sort(out);return out
end
function Core:FindNamedWorldPart(name,kind)
    if not name or name=="" then return end
    local roots={workspace:FindFirstChild("Zones"),workspace:FindFirstChild("Map"),workspace:FindFirstChild("Locations"),path(workspace,"Humanoids","Regions"),path(workspace,"Debree","Regions")}
    for _,root in ipairs(roots) do if root then
        local object=root:FindFirstChild(name,true)
        if object then
            if object:IsA("BasePart") then return object end
            if object:IsA("Model") then return object:FindFirstChild("HumanoidRootPart") or object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart",true) end
            return object:FindFirstChildWhichIsA("BasePart",true)
        end
    end end
end
function Core:TeleportToMob(name)
    local target=self:Closest(name or self.Options.SelectedMob)
    if not target then return false,"Mob not found" end
    return self:MoveTo(self:TargetCFrame(target),"Teleport")
end
function Core:TeleportToNpc(name)
    local part=self:FindNamedWorldPart(name or self.Options.SelectedNpc,"Npc")
    if not part then return false,"NPC not found" end
    return self:MoveTo(part.CFrame*CFrame.new(0,0,4),"Teleport")
end
function Core:TeleportToZone(name)
    local part=self:FindNamedWorldPart(name or self.Options.SelectedZone,"Zone")
    if not part then return false,"Zone not found" end
    return self:MoveTo(part.CFrame*CFrame.new(0,5,0),"Teleport")
end

function Core:SetAntiAfk(v) self.Options.AntiAfk=v==true return true end
function Core:SetAutoReconnect(v) self.Options.AutoReconnect=v==true;if not v then self.ReconnectBusy=false end;return true end
function Core:Rejoin()
    self.Status.WorldStatus="Rejoining"
    return pcall(TeleportService.TeleportToPlaceInstance,TeleportService,game.PlaceId,game.JobId,LocalPlayer)
end
function Core:RedeemCode(code)
    code=tostring(code or "");if code=="" then return false end
    local ok=self:Event("RedeemCode",code)
    if not ok then ok=self:Event("Codes",code) end
    return ok
end
function Core:RedeemAllCodes()
    if self.Status.CodeBusy then return false,"already running" end
    self.Status.CodeBusy=true;self.Status.CodeStatus="Discovering"
    task.spawn(function()
        local codes,seen={},{}
        local function add(value)
            if type(value)=="string" and #value>=3 and #value<=40 and value:match("^[%w_%-]+$") and not seen[value] then seen[value]=true;codes[#codes+1]=value end
        end
        local function walk(value,depth)
            if depth>5 or type(value)~="table" then return end
            for key,item in pairs(value) do
                if type(key)=="string" and (item==true or type(item)=="table") then add(key) end
                if type(item)=="string" then add(item) elseif type(item)=="table" then walk(item,depth+1) end
            end
        end
        for _,moduleScript in ipairs(ReplicatedStorage:GetDescendants()) do
            if moduleScript:IsA("ModuleScript") and moduleScript.Name:lower():find("code",1,true) then
                Core.Status.CodeStatus="Reading "..moduleScript.Name
                local value=safeRequire(moduleScript);if value then walk(value,0) end
            end
        end
        table.sort(codes)
        for _,code in ipairs(codes) do if not Core.Alive then break end;Core.Status.CodeStatus="Redeeming "..code;Core:RedeemCode(code);task.wait(.25) end
        Core.Status.CodeBusy=false;Core.Status.CodeStatus="Finished ("..#codes..")"
    end)
    return true
end
function Core:StopAll()
    for name,value in pairs(self.Options) do if type(value)=="boolean" and (name:sub(1,4)=="Auto" or name=="AlwaysRun") then self.Options[name]=false end end
    for name in pairs(self.Generation) do self.Generation[name]+=1 end
    self.CombatInput:Clear();self.Parry.Generation+=1;self.Parry.Blocking=false
    if self.ActiveTween then pcall(function()self.ActiveTween:Cancel()end);self.ActiveTween=nil end
    self.Movement.Owner=nil;self.Movement.Priority=0;self.Movement.Expires=0
    self.Status.PriorityHolder="None";self.Status.PriorityStatus="Off"
    for _,name in ipairs({"Level","Quest","Mob","Boss","Loot","Chest","Skill","AutoSkill","Equip","Potion","Breath","Hunt","Soul","Teleport"}) do self:SetStatus(name,"Idle") end
    self.Status.ParryStatus="Off";return true
end
function Core:GetStatusSnapshot()
    return {
        Level=self:CurrentLevel(),LevelStatus=self.Status.LevelStatus,QuestStatus=self.Status.QuestStatus,
        MobStatus=self.Status.MobStatus,BossStatus=self.Status.BossStatus,Priority=self.Status.PriorityHolder,
        Kills=self.Status.Kills,Looted=self.Status.Looted,Chests=self.Status.Chests,Souls=self.Status.Souls,
        ParryAttempts=self.Parry.Attempts,ParryStatus=self.Status.ParryStatus,Errors=#self.Errors,
    }
end
function Core:GetErrors()
    local out={};for _,entry in ipairs(self.Errors) do out[#out+1]=( "[%0.2f] %s: %s"):format(entry.Time,entry.Source,entry.Message) end;return out
end
function Core:ClearErrors() table.clear(self.Errors) return true end
function Core:HealthCheck()
    local modules=self:GetModuleStatus();local enabled,running=0,0
    for name in pairs(workerBodies) do if self.Options[name] then enabled+=1;if self.Threads[name] then running+=1 end end end
    return {Alive=self.Alive,Modules=modules,EnabledWorkers=enabled,RunningWorkers=running,Errors=#self.Errors,MovementOwner=self.Movement.Owner}
end
function Core:Unload()
    if not self.Alive then return end;self:StopAll();self.Alive=false;self.CombatInput:Clear()
    if self.ActiveTween then pcall(function() self.ActiveTween:Cancel() end);self.ActiveTween=nil end
    for object in pairs(self.EspObjects) do self:RemoveEsp(object) end
    for part,canCollide in pairs(self.CollisionState) do if part.Parent then part.CanCollide=canCollide end end
    table.clear(self.CollisionState)
    for _,c in ipairs(self.Connections) do pcall(function() c:Disconnect() end) end
    table.clear(self.Connections)
end

return Core
