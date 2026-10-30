# `twistedk1d` — функционал и механики

Игра/тема: **blox_strike** · восстановленный код: `script.lua` (410 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `tab`, `toggle`
- **телепорт / движение** — улики: `cframe`, `tweenservice`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`
- **аимбот / наведение** — улики: `mousebutton`
- **деньги / ресурсы** — улики: `code`
- **инвентарь / предметы** — улики: `drop`

## Вызовы API

- Сервисы: `ContextActionService`, `Players`, `ReplicatedStorage`, `RunService`, `TweenService`
- Классы/объекты: `AnimationController`, `Animator`, `BasePart`, `Camera`, `MeshPart`, `Motor6D`, `SurfaceAppearance`, `Texture`
- Методы: `FindFirstChild`×33, `Create`×23, `WaitForChild`×19, `GetChildren`×6, `IsA`×6, `GetService`×5, `Clone`×5, `Destroy`×4, `TweenService`×3, `Connect`×2, `HttpGet`×1, `loadstring`×1

## Имена функций (13)

`isAlive`, `getKnifeInCamera`, `cleanPart`, `disableCollisions`, `hideOriginalKnife`, `playSound`, `attachAsset`, `handleAction`, `removeViewmodel`, `spawnViewmodel`, `isAlive_Skin`, `applyWeaponSkin`, `CreateSkinDropdown`

## Строковые константы (UI, подписи)

- `Left Arm` ×8
- `Right Arm` ×8
- `Butterfly Knife` ×5
- `Glove` ×5
- `SkinApplied` ×4
- `Karambit` ×3
- `M9 Bayonet` ×3
- `Flip Knife` ×3
- `Gut Knife` ×3
- `Terrorists` ×3
- `Sports Gloves` ×3
- `[📜] Blox Strike` ×2
- `Skins` ×2
- `Counter-Terrorists` ×2
- `T Knife` ×2

## Ссылки / webhooks / ассеты (1)

- `https://raw.githubusercontent.com/twistedk1d/BloxStrike/refs/heads/main/Source/UI/source.lua`

## Парты / объекты (288)

- через `WaitForChild`/`FindFirstChild`: `Camera`, `Terrorists`, `Counter-Terrorists`, `Characters`, `T Knife`, `CT Knife`, `T Glove`, `IDF`, `CT Glove`, `CameraAnimations`, `Equip`, `Idle`, `Inspect`, `Heavy Swing`, `Swing1`, `Swing2`, `Assets`, `Skins`, `Left Arm`, `Right Arm`, `Sports Gloves`, `Glove`, `Weapon`
- идентификаторы в коде: `ACTION_ATTACK`, `ACTION_INSPECT`, `ATTACK_COOLDOWN`, `AUG`, `AWP`, `Action`, `All`, `Anchored`, `AnimationController`, `Any`, `Apply`, `Arm`, `Assets`, `AttackKnifeAction`, `BasePart`, `Bayonet`, `Begin`, `Berettas`, `BindAction`, `Blox`, `BloxStrike`, `Butterfly`, `CAS`, `CFrame`, `COOLDOWN`, `CT_ONLY`, `Callback`, `CameraAnimations`, `CanCollide`, `CanQuery`, `CanTouch`, `CastShadow`, `Changer`, `Characters`, `ChildAdded`, `Clone`, `Color3`, `ConfigurationSaving`, `Connect`, `ContextActionResult`
