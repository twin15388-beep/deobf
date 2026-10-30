# `cmd_gui` — функционал и механики

Игра/тема: **prison_life** · восстановленный код: `script.lua` (3477 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `jumppower`, `teleport`, `tp`, `walkspeed`
- **урон / убийство** — улики: `damage`, `fling`, `god mode`, `godmode`, `kill`, `noclip`
- **GUI / меню** — улики: `screengui`, `scrollingframe`, `textbutton`, `textlabel`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`, `require`
- **ESP / подсветка** — улики: `outline`
- **аимбот / наведение** — улики: `mousebutton`
- **квесты / стадии** — улики: `quest`
- **инвентарь / предметы** — улики: `item`
- **анти-АФК / ввод** — улики: `keydown`

## Вызовы API

- Сервисы: `Chat`, `CoreGui`, `Lighting`, `MarketplaceService`, `Players`, `ReplicatedStorage`, `RunService`, `StarterGui`, `Teams`, `Workspace`
- Классы/объекты: `Animation`, `Beam`, `Camera`, `Frame`, `HopperBin`, `Humanoid`, `Lighting`, `Part`, `ScreenGui`, `ScrollingFrame`, `StringValue`, `TextBox`, `TextButton`, `TextLabel`, `Tool`, `UIListLayout`, `Weld`
- Методы: `FindFirstChild`×106, `InvokeServer`×76, `Connect`×30, `GetPlayers`×28, `FireServer`×24, `Destroy`×22, `GetService`×16, `GetChildren`×11, `Create`×7, `Clone`×6, `GetMouse`×4, `IsA`×3

## Имена функций (34)

`GetPlayer`, `GetPos`, `GetCamPos`, `GetTeam`, `Goto`, `Split`, `ChatNotify`, `Chat`, `WaitForChild`, `Kill`, `Tase`, `Teleport`, `TeleportV`, `ArrestEvent`, `Arrest`, `CreateBeam`, `CreateBeam2`, `CreateBeam3`, `Beam`, `LagBeam`, `DetectMove`, `FeGodMode`, `GetPlayerPart`, `CopyChat`, `Died`, `PlayerPickUp`, `Notify`, `Loadstring`, `Command`, `PrefixCommand`, `PlayerChatted`, `Punch`, `AdminPlayerChatted`, `CheckPermissions`

## Строковые константы (UI, подписи)

- `Success` ×119
- ` .. Prefix .. ` ×34
- `Error` ×30
- `Remington 870` ×23
- `Medium stone grey` ×13
- `AK-47` ×12
- `No player found` ×12
- `Bright orange` ×11
- `Really red` ×11
- `Changed name tag color to ` ×11
- `), Color3.fromRGB(0, 255, 0), ` ×11
- `CurrentAmmo` ×10
- `Bright blue` ×8
- `handcuffedGui` ×8
- `MaxAmmo` ×8

## Ссылки / webhooks / ассеты (1)

- `https://pastebin.com/raw/9ab2s523`

## Парты / объекты (506)

- через `WaitForChild`/`FindFirstChild`: `M9`, `HumanoidRootPart`, `handcuffedGui`, `Remington 870`, `GunStates`, `AK-47`, `Head`, `Taser`, `Crude Knife`, `Backpack`, `Torso`, `ShieldFolder`, `Doors`, `Bat`, `Bin_1`, `Bin_2`, `Bin_3`, `Bin_4`, `ForceField`, `meleeEvent`
- идентификаторы в коде: `ALL`, `ALl`, `ARE`, `Activate`, `Activated`, `Active`, `Admin`, `AdminPlayerChatted`, `AmmoPerClip`, `Anchored`, `Animate`, `AnimationId`, `Anti`, `Anti_Crash`, `Anti_Fling`, `Anti_Shield`, `Anti_Spam_Arrest`, `Anti_Void`, `Arg1`, `Arg2`, `Arg3`, `Arg4`, `Arguaments`, `Arrest`, `ArrestEvent`, `Arrested`, `Attacked`, `Attacking`, `Auto`, `AutoFire`, `Auto_Guns`, `Auto_RapidFire`, `Auto_Refresh`, `AutomaticCanvasSize`, `BEEP`, `BEPP`, `BOP`, `Background`, `Background2`, `Background3`
