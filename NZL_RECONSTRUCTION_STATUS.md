# NZL Studio — статус читаемой реконструкции Ouroboros

Текущая версия: **clean-0.23**  
Основное читаемое ядро: `ouroboros_clean_source.lua`  
Standalone с NZL Studio/Lumen: `ouwland_clean_main.lua`

> Важно: ниже отдельно указано, что действительно извлечено из runtime-графа оригинала, а что уже заново реализовано в читаемом виде. Это не заявление о дословном восстановлении авторского исходника.

## Что действительно извлечено из оригинального runtime

- Полный граф из **560 closures**, достигнутых от 19 публичных методов.
- Публичные корни:
  - `SetAutoLevel`, `SetAutoQuest`, `SetAutoMob`, `SetAutoBoss`, `SetAutoBossHunt`;
  - `SetAutoLoot`, `SetAutoChest`, `SetInstantKill`;
  - `SetAutoSkills`, `SetAutoSkillTree`, `SetAutoEquip`, `SetAutoPotion`;
  - `SetNoStun`, `SetNoRagdoll`, `SetNoAttackSlowdown`;
  - `SetNotifyBosses`, `TeleportToMob`, `TeleportToNpc`, `TeleportToZone`.
- Константы:
  - `MAX_LEVEL = 225`;
  - `EXP_PER_LEVEL = 60`.
- Иерархия модулей:
  - `ReplicatedStorage.CAM`;
  - `CAM.Client.Controllers`;
  - `Skills_Provider.CurPower`;
  - `Communication.ServerAndClient.Signals`;
  - `SignalEvent`, `SignalFunction`, `InputHandler`, `Skill_Controller`;
  - `Quests`, `RecommendedQuest`, `SkillTreeholder`, `Skills_Module`, `Items`.
- Подтверждённые сетевые действия и точки входа:
  - `AddQuest`;
  - `NpcTalking`, `Ended`;
  - `EndNpcTalk`;
  - `BossHuntsRequest`, `Request`;
  - `SkillService`, `UnlockSkillTreeNode`;
  - `server_skill_controller_signaler`;
  - `EquipWeapon`, `Item_Equip`, `AccessoryEquip`;
  - `RedeemCode`.
- Нативный combat route:
  - `InputHandler.VirtualPress("Combat")`;
  - `InputHandler.VirtualRelease("Combat")`;
  - M1 в игре далее вызывает `Combat_Service` с рассчитанным игрой timing/combo.
- Skill route:
  - `Skill_Controller.Attempt_Hold`;
  - `Skill_Controller.StopHold`;
  - фазы `Hold`, `UnHold`, `Cancel`, `Counter`, `Switch`, `UnHoldAfterClient`.
- Combat adapter оригинала:
  - `controllerValid`, `timing`, `resolvePunch`, `clearInputs`;
  - `pressInput`, `releaseInput`, `skillState`, `cancelSkill`;
  - `ready`, `stop`, `findFunctions`, `detach`.
- Protection markers:
  - stun: `Cancel`, `CombatStun`, `KnockedOut`, `Strict_Stun`, `Stun`;
  - ragdoll: `RagDoll`.
- Boss/chest architecture:
  - `bossIds`, `bossNearby`, `isBoss`, `isOpened`, `open`.
- Targeting state:
  - `generation`, `hold`, `lead`, `mitigate`, `npc`, `pvp`;
  - `radius = 40`, `reset`, `step`, `invalidate`.
- Оригинальные worker-связи:
  - F120 — Auto Level;
  - F121 — Auto Mob;
  - F122 — Auto Loot;
  - F123 — Auto Skill Tree;
  - F124 — boss notifications;
  - F126 — movement/tween;
  - F131 — model position;
  - F133/F134/F139/F141 — combat timing/input;
  - F169–F174 — boss/chest helpers.
- Shared status object с Activity Status, counters и priority state.

## Что уже реализовано в читаемом ядре

### 25 независимых worker-контроллеров

1. AutoLevel
2. AutoQuest
3. AutoMob
4. AutoBoss
5. AutoBossHunt
6. AutoLoot
7. AutoChest
8. AutoDelivery
9. AutoTraining
10. AutoSkills
11. AutoSkillTree
12. AutoEquip
13. AutoPotion
14. AutoSoul
15. AutoBreathing
16. AutoParry
17. AutoBringEnemies
18. AlwaysRun
19. AutoFish
20. AutoQueue
21. AutoSkipWaves
22. AutoCards
23. AutoDungeon
24. AutoDemon
25. AutoBuy

Каждый worker использует generation token и не должен оставлять дублирующиеся циклы после переключения toggle.

### Farming и quests

- Автоматический выбор рекомендуемого квеста.
- Поиск quest NPC.
- Перемещение к NPC до отправки `AddQuest`.
- Чтение `Quests.Holder`.
- Рекурсивное извлечение Mob/Target/Enemy из определения задания.
- Поиск нужной живой цели в `workspace.Humanoids.Regions`.
- Статичная позиция Above/Behind/Front.
- Автоматическая атака через нативный InputHandler.
- Delivery quest: поиск получателя/позиции, перемещение и prompt.
- Boss hunt request и охота на появившегося босса.

### Movement priority controller

Приоритеты предотвращают конфликт нескольких автоматизаций:

1. Manual Teleport — 100
2. Boss Hunt — 80
3. Auto Boss — 75
4. Quest — 70
5. Delivery — 65
6. Auto Level — 60
7. Auto Mob — 50
8. Training — 40
9. Chest — 30
10. Loot — 20
11. Soul — 10

Реализованы owner, priority, epoch, expiry, отмена старого tween и освобождение lease.

### Combat

- Native M1 input.
- Skills через Attempt_Hold/StopHold.
- Auto Parry по Action-анимациям.
- NPC/player filters, radius, lead и block hold.
- Instant Kill как ускоренная подача валидного native input, без прямого выдуманного damage remote.
- No Stun, No Ragdoll, No Attack Slowdown.
- Auto Potion и Heal Below.
- Auto Equip combat tool.
- Bring Enemies только после `isnetworkowner`.

### Loot, chests, items

- Loot tags и fallback-папки.
- ProximityPrompt, ClickDetector и touch activation.
- Chest tags, folders, `ChestId`, `ChestTier`, `ChestState`.
- Проверка opened state.
- Tier detection и фильтрация.
- Auto Soul.
- Auto Training с кэшированным поиском.
- Auto Fishing через найденный FishingRod, EquipBait, native Tool activation и InputHandler.

### Player

- Fly + speed.
- Noclip с восстановлением исходного CanCollide.
- Infinite Jump.
- Walk Speed.
- Infinite Stamina и Infinite Climb.
- No Drown, No Sun Damage, No Dash Cooldown.
- Always Run.

### ESP

- Mob, Boss, Chest, Player, NPC и Loot ESP.
- Highlight + Billboard label.
- Distance filter.
- Автоматическая очистка исчезнувших объектов.
- Boss notifications с защитой от повторов.

### Startup и UI

- NZL Studio/Lumen UI.
- Нет Original Engine / Connect Engine.
- Нет `getgc` bridge.
- Нет встроенного 2.2-МБ Luast core.
- Нет внешней загрузки Ouroboros через HttpGet.
- Игровые ModuleScript требуютcя асинхронно и не блокируют создание UI.
- Runtime module status и Retry Modules.
- Категории: Home, Farming, Combat, Player, Items, ESP, Teleports, Misc.

## Текущий читаемый API

В ядре сейчас **142 именованных метода Core** и 25 worker-контроллеров. Главные группы API:

- Runtime: `ResolveModule`, `RetryModules`, `GetModuleStatus`, `StopAll`, `Unload`.
- Farming: `AcquireQuest`, `QuestTargets`, `QuestTarget`, `Fight`, `SelectTarget`.
- Movement: `AcquireMovement`, `MoveTo`, `ReleaseMovement`, `TeleportToMob/Npc/Zone`.
- Combat: `Attack`, `UseSkill`, `StartBlock`, `ParryStep`, `EquipBestTool`.
- Discovery: `Entities`, `Names`, `TrainingObjects`, `NearestLoot`, `NearestTagged`.
- ESP: `AddEsp`, `RefreshEsp`, `RemoveEsp`.
- Misc: `RedeemAllCodes`, `RedeemCode`, `Rejoin`, `SetAntiAfk`.

## Что ещё не считается завершённым

- Нужна runtime-проверка в целевой игре всех сетевых сигнатур.
- Нужна проверка реальных форматов quest definition для каждого типа задания.
- Нужно подтвердить реальные inventory/equipment структуры.
- Нужна runtime-проверка Fishing и Queue/Waves/Cards; Shop и Demon/Muzan требуют runtime-проверки.
- Нужна проверка UI в executor на capability/thread identity.
- После runtime-проверки потребуется исправить несовпадающие action arguments и удалить нерабочие fallback-маршруты.

Статическая parse/full-compile проверка ядра и standalone успешно пройдена. Runtime-проверка в Roblox всё ещё требуется, поэтому версия ещё не помечена как **ВСЁ**.
