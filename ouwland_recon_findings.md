# Ouwland / Project Slayers 2 recon findings

Place ID: `136406881576517`

## Network architecture
- Physical remotes found under `ReplicatedStorage.CAM.Global.ServerClientPortal`, `Communication.ServerAndClient`, and `OCIServerHolder`.
- The game also uses logical wrapper modules, notably `Communication.ServerAndClient.Signals.SignalEvent`, `SignalFunction`, and `ReplicatedStorage.RemotePlus` (`Eventer`, `Invoker`, `Unreliable`).
- Remote names such as `Event` and `Function` are duplicated, so exports must use unique full-path-derived keys rather than instance names.

## NPC and mob layout
- Live NPCs are under `workspace.Debree.Regions.<region>.ActiveNpcs` and related region folders, not only top-level `Living/Mobs/Enemies`.
- Stationary NPCs are under `workspace.Debree.Regions.<region>.StationaryNpcs`.
- Replicated templates are under `ReplicatedStorage.Ouwland.Content.<region>.ActiveNpcs` and `NpcShared`.
- Known regions include Windy Peak, Bamboo Grove, Butterfly Estate, Final Selection Plains, Hidden Mist Village, Iceveil Valley, Mistfall Harbor, Stone Sanctuary, Verdant Cliffs, and Misc.

## Quests/dialogue
- Quest/dialogue definitions are ModuleScripts under `ReplicatedStorage.Ouwland.Content.<region>.NpcContents.Dialogues`, including `Quests`, `Yap`, and `Functions`.
- Runtime player quests are under `ReplicatedStorage.Player_Service.Data.<profile>.slots.<slot>.Quests`.
- Generic quest-state modules exist under `ReplicatedStorage.QuestStates`.

## Important modules
- Combat client: `PlayerScripts.CU.Combat.Main_Combat_Script_Client`.
- Core game systems under `ReplicatedStorage.CAM.Global`, including `PlayerStatResolver`, `SkillService`, powers, quest helpers, collectibles, and server-client portal.
- Skill client/server modules under `ReplicatedStorage.Skills`.

## Confirmed combat/skill architecture from v4.2 targeted sources
- Native M1 ultimately calls `SignalEvent.ToServer("Combat_Service", weaponStyle, comboValue, runHit, hitDelay, airCombo, swingStyle)`; safest automation path is the game's `InputHandler.VirtualPress("Combat")` / `VirtualRelease("Combat")` so combo timing is calculated natively.
- Skills route through `SignalEvent`/`SignalFunction` action `server_skill_controller_signaler` with phases `Hold`, `UnHold`, `Cancel`, `Counter`, `Switch`, and `UnHoldAfterClient`.
- `Skill_Controller.Attempt_Hold(name, key)` and `StopHold(name)` are the safest native entry points.
- Dash uses `Dash_Handler.Perform("W"|"A"|"S"|"D")`, which internally invokes the skill controller.
- Blocking is the `Blocking` skill and should be controlled through Skill_Controller rather than direct remotes.
- Live enemies are primarily under `workspace.Humanoids.Regions.<region>.ActiveNpcs`; `workspace.Debree` is not the authoritative live humanoid root.
- Quest definitions are available from `Quests.Holder`; client acceptance uses `SignalEvent.ToServer("AddQuest", questName)` after `Quests.CanAddQuest`.

## Confirmed protocol actions from decompiled dialogue system
- `SignalEvent.ToServer("AddQuest", questName)` accepts a quest after local requirement checks.
- `SignalEvent.ToServer("PurchaseFromShop", itemName, amount)` buys a shop item.
- `SignalFunction.ToServer("PurchaseSelection", selection)` submits a cart purchase.
- `SignalEvent.ToServer("NpcTalking", "Ended")` closes NPC conversation state.
- Dialogue client checks `Quests.Holder[questName]`, `Quests.CanAddQuest(questName)`, `ItemRequirements.Passes`, `AcceptCost.Check`, and local Wen before `AddQuest`.

## Confirmed runtime behavior from OUROBOROS_BEHAVIOR_TRACE_V1
- `SetAutoLevel(true)` first accepted quest `"Ill take 3 bandits"` through `SignalEvent.ToServer("AddQuest", questName)`, then closed dialogue with `SignalEvent.ToServer("NpcTalking", "Ended")` (twice in this sample), equipped slot `2` using `SignalEvent.ToServer("Item_Equip", 2)`, and entered the `Wilderness` region.
- Native M1 emitted a timed five-hit sequence: `SignalEvent.ToServer("Combat_Service", "Combat", comboIndex, runHit, hitDelay, false, nil)`, where combo indices progress 1..5. Observed ordinary first-hit delay was `0.13`; intermediate hits generally used `0`; fifth-hit delay varied around `0.04` to `0.15`.
- A movement/run-context attack was observed with combo 1 having `runHit=true` and delay `0.038`.
- Auto Skills toggling caused native combat input and item-slot changes (`Item_Equip`, observed slots 1 then 0); no non-Dash offensive skill was emitted in that short sample.
- Skill controller invocation is exact: `Attempt_Hold("Dash", directionKey)` emits `server_skill_controller_signaler, "Dash", "Hold", position`; `StopHold("Dash")` emits `UnHold` then `Cancel` with current position. Blocking uses `Attempt_Hold("Blocking", "F")` and `StopHold("Blocking")` similarly.
- `SetInstantKill` did not itself emit a special kill remote. Combat stayed on the normal `Combat_Service` combo route; this supports accelerated native combo timing rather than a guessed damage remote.
- Follow-up V2 confirmed Auto Mob/Level movement is continuous high-speed travel to a live nearby NPC followed by the same direct five-hit `Combat_Service` sequence. Region crossings emit `VisitRegion`; there is no separate farm/damage remote.
- Auto Quest order was observed as travel to quest region/NPC, `AddQuest`, two `NpcTalking/Ended` calls, `Item_Equip(2)`, travel to mob region, then native five-hit combat.
- `SetAutoLoot` and `SetAutoChest` emitted neither remotes nor movement in the supplied intervals, indicating no eligible nearby target in that run; their successful interaction path remains unobserved.
- Auto Skill Tree exact call was confirmed as `SignalFunction.ToServer("UnlockSkillTreeNode", nodeName)` and returned `true` for `"Additional Damage"`.

## Received decompiles that need not be resent
- Module-return dumps for player biome presets, `Main_Combat_Script_Client` surface (`Do`, `CanAirCombo`, `UpdraftRequested`), Roblox PlayerModule/controls, clan tables/skills/rarities, visibility sets, chest/UI helpers, DialogueUtility, and numerous UI modules.
- These module-return dumps expose public tables but not function bodies; the combat module still needs direct `decompile()` source rather than `require()` serialization.
- Core Dialogue module and dialogue UI component.
- DialogueUtility and OpenDialogue client handler.
- Several unrelated UI, mobile, Faye framework, title, inventory, health, and visual-effect modules.
- Full module path inventory from the v3.8 deep dump.

## Previous dumper deficiencies observed
- Mob output was empty because only top-level conventional folders were checked.
- NPC output was empty because game-specific `Debree/Regions` and replicated dialogue layouts were not recognized.
- Remote table overwrote duplicate keys like `Event` and `Function`.
- Generic serializer truncated module output and emitted `{...}` at shallow depth.
- Crate models often reported zero positions because nested parts were not searched recursively.
