# `hub` — функционал и механики

Игра/тема: **counter_blox** · восстановленный код: `script.lua` (6915 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `screengui`, `scrollingframe`, `slider`, `tab`, `textbutton`
- **ESP / подсветка** — улики: `billboardgui`, `boxhandle`, `chams`, `esp`, `outline`
- **аимбот / наведение** — улики: `aim assist`, `aimbot`, `mousebutton`, `mousemove`, `silent aim`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `jumppower`, `tweenservice`
- **инвентарь / предметы** — улики: `chest`, `drop`, `inventory`, `item`
- **урон / убийство** — улики: `damage`, `hitbox`, `kill`
- **деньги / ресурсы** — улики: `cash`, `inf`, `infinite`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`, `require`
- **анти-АФК / ввод** — улики: `button2down`, `inputbegan`, `keydown`

## Вызовы API

- Сервисы: `CoreGui`, `HttpService`, `Lighting`, `Players`, `ReplicatedStorage`, `RunService`, `SoundService`, `TextService`, `TweenService`, `UserInputService`
- Классы/объекты: `Accessory`, `Animation`, `BasePart`, `BillboardGui`, `BlockMesh`, `BodyVelocity`, `Camera`, `Decal`, `Folder`, `ForceField`, `Frame`, `Humanoid`, `ImageButton`, `ImageLabel`, `Lighting`, `MeshPart`, `Model`, `NumberValue`, `Pants`, `Part`
- Методы: `FindFirstChild`×195, `Connect`×191, `IsA`×58, `GetService`×54, `GetChildren`×53, `Destroy`×26, `Clone`×25, `FireServer`×19, `GetPlayers`×12, `GetMouse`×10, `TweenService`×3, `loadstring`×2

## Имена функций (24)

`rgbtotbl`, `tbltorgb`, `deepCopy`, `keybindadd`, `keybindremove`, `update`, `updatetext`, `updateColor`, `updateHue`, `updateTrans`, `VectorRGB`, `new`, `UpdateWeapon`, `MapSkin`, `GetDeg`, `AddLegit`, `AddRage`, `add`, `YROTATION`, `XYROTATION`, `GetWeaponRage`, `GetStatsRage`, `GetStatsLegit`, `CollisionTBL`

## Строковые константы (UI, подписи)

- `Button` ×25
- `ToggleColor` ×17
- `Map` ×17
- `Left` ×15
- `ToggleKeybind` ×14
- `Right` ×13
- `Color3Value` ×13
- `double tap` ×13
- `Jumbobox` ×12
- `Hold` ×12
- `Always` ×11
- `self chams` ×11
- `override default` ×11
- `Head` ×10
- `silent aim` ×10

## Ссылки / webhooks / ассеты (4)

- `http://www.roblox.com/asset/?id=6724771531`
- `http://www.roblox.com/asset/?id=6724808282`
- `http://www.roblox.com/asset/?id=7265208537`
- `https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua`

## Парты / объекты (695)

- через `WaitForChild`/`FindFirstChild`: `Humanoid`, `Map`, `UpperTorso`, `HumanoidRootPart`, `Gun`, `Smokes`, `AIMING`, `Killers`, `Mesh`, `Shirt`, `Pants`, `Fires`, `Kevlar`, `Helmet`, `Melee`, `FakeHead`, `Animated`, `Head`, `KillersClone`, `BackC4`, `Climbing`, `OldPosition`, `v_`, `Right Arm`, `Left Arm`
- идентификаторы в коде: `ACOS`, `AIMING`, `AK47`, `ATAN2`, `AUG`, `AWP`, `AbsolutePosition`, `AbsoluteSize`, `Accessory`, `Action`, `Active`, `AddLegit`, `AddRage`, `Additionals`, `AdornCullingMode`, `Adornee`, `Alive`, `AllCharacters`, `AllGloves`, `AllKnives`, `AllSkins`, `AllWeapons`, `Always`, `AlwaysOnTop`, `Amount`, `AnchorPoint`, `Anchored`, `Angle`, `Angles`, `Animated`, `AnimationId`, `AnimationPriority`, `Arguments`, `Arm`, `Armor`, `ArmorPenetration`, `Arms`, `Auto`, `AutoButtonColor`, `AutoRotate`
