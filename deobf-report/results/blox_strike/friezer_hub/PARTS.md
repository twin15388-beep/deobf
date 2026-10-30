# `friezer_hub` — функционал и механики

Игра/тема: **blox_strike** · восстановленный код: `script.lua` (1360 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `screengui`, `slider`, `tab`, `textlabel`, `toggle`
- **ESP / подсветка** — улики: `chams`, `esp`, `highlight`, `outline`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `tweenservice`
- **аимбот / наведение** — улики: `aimbot`, `mousebutton`, `mousemove`
- **урон / убийство** — улики: `hitbox`, `kill`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`
- **анти-АФК / ввод** — улики: `inputbegan`, `keydown`
- **деньги / ресурсы** — улики: `code`
- **инвентарь / предметы** — улики: `drop`

## Вызовы API

- Сервисы: `ContextActionService`, `Lighting`, `Players`, `ReplicatedStorage`, `RunService`, `TweenService`, `UserInputService`, `Workspace`
- Классы/объекты: `AnimationController`, `Animator`, `Attachment`, `BasePart`, `Camera`, `Explosion`, `Frame`, `Highlight`, `Humanoid`, `Lighting`, `MeshPart`, `Model`, `Motor6D`, `Part`, `ParticleEmitter`, `ScreenGui`, `SurfaceAppearance`, `TextLabel`, `Texture`
- Методы: `Create`×95, `FindFirstChild`×60, `WaitForChild`×20, `Destroy`×17, `GetChildren`×14, `Connect`×10, `GetService`×8, `IsA`×7, `TweenService`×5, `Clone`×5, `GetMouse`×3, `HttpGet`×1

## Имена функций (30)

`getTFolder`, `getCTFolder`, `isAlive`, `getEnemyFolder`, `isVisible`, `getClosestEnemyToMouse`, `getKnifeInCamera`, `cleanPart`, `disableCollisions`, `hideOriginalKnife`, `playSound`, `attachAsset`, `handleAction`, `removeViewmodel`, `spawnViewmodel`, `applyWeaponSkin`, `CreateSkinDropdown`, `getRainbowColor`, `newDrawing`, `makeESPForEnemy`, `destroyESP`, `hideAllInESP`, `clearAllESP`, `w2s`, `getPos`, `updatePlayerChams`, `updateWeaponChams`, `createAdvancedTracer`, `createParticleEffect`, `createKillEffects`

## Строковые константы (UI, подписи)

- `Line` ×12
- `Left Arm` ×8
- `Right Arm` ×8
- `Butterfly Knife` ×5
- `Glove` ×5
- `SkinApplied` ×4
- `Head` ×3
- `Karambit` ×3
- `M9 Bayonet` ×3
- `Flip Knife` ×3
- `Gut Knife` ×3
- `Sports Gloves` ×3
- `Straight` ×3
- `Spark` ×3
- ` sec` ×3

## Ссылки / webhooks / ассеты (1)

- `https://raw.githubusercontent.com/twistedk1d/BloxStrike/refs/heads/main/Source/UI/source.lua`

## Парты / объекты (703)

- через `WaitForChild`/`FindFirstChild`: `Head`, `Camera`, `Weapon`, `Characters`, `Terrorists`, `Counter-Terrorists`, `T Knife`, `CT Knife`, `T Glove`, `IDF`, `CT Glove`, `CameraAnimations`, `Equip`, `Idle`, `Inspect`, `Heavy Swing`, `Swing1`, `Swing2`, `Assets`, `Skins`, `Left Arm`, `Right Arm`, `Sports Gloves`, `Glove`, `HumanoidRootPart`
- идентификаторы в коде: `ACTION_ATTACK`, `ACTION_INSPECT`, `AIMBOT`, `ANTI`, `ATTACK_COOLDOWN`, `AUG`, `AWP`, `Adornee`, `Advanced`, `AimKey`, `Aimbot`, `AimbotEnabled`, `AimbotSmoothing`, `AimbotToggle`, `All`, `AlwaysOnTop`, `Amount`, `Anchored`, `AnimationController`, `Anti`, `AntiFlashEnabled`, `AntiFlashToggle`, `AntiSmokeEnabled`, `AntiSmokeToggle`, `Arm`, `Assets`, `AttackKnifeAction`, `BAR`, `BHOP`, `BOX`, `BULLET`, `BackgroundColor3`, `BackgroundTransparency`, `Bar`, `BasePart`, `Bayonet`, `Begin`, `Berettas`, `BhopEnabled`, `BhopToggle`
