--[[
Game-specific SRC | NOT DEOBFUSCATED | NOT TESTED IN ROBLOX
Game / variant: A Universal Time / Hyper Zoro
Original: https://scriptblox.com/raw/JUJUTSU-KAISEN-A-Universal-Time-3.8-Universl-OP-uto-scend-20583
Source SHA-256: 3a64589ff6c8e472624b1f19db944d16e5ec9c9436c38f602901bbe830e7c96e
Snapshot: ScriptBlox View Raw, 2026-10-21
Source status: self-described open source (no SPDX license)
Note: Three remote calls on EVERY Heartbeat without rate limiting; only uploader open-source claim, no SPDX license.
Uploader neutral calls the code "open source" in the ScriptBlox card.
No standard LICENSE was supplied; scope of permission unverified.
]]

local game = game;
local player = game:GetService("Players").LocalPlayer;
local ability = player.Data.Ability.Value;
local knit_services = game:GetService("ReplicatedStorage").ReplicatedModules.KnitPackage.Knit.Services;
local CheckDialogue = knit_services.DialogueService.RF.CheckDialogue;
local PickedUpSword = knit_services.AdventureService.RF.PickedUpSword;
local ascend = knit_services.LevelService.RF.AscendAbility;


local invokeserver = PickedUpSword.InvokeServer;
local spawn = task.spawn;

if (getgenv().farm) then
      getgenv().farm:Disconnect();
end;
getgenv().farm = game:GetService('RunService').Heartbeat:Connect(function()
    spawn(function()
            invokeserver(CheckDialogue, "Zoros_Swords_Adventure");
            invokeserver(PickedUpSword);
            invokeserver(ascend,ability);
    end);
end);
