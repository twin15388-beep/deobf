# `pps_hub` — функционал и механики

Игра/тема: **blox_strike** · восстановленный код: `script.lua` (365 строк)

## Что делает (по восстановленному коду)

- **ESP / подсветка** — улики: `chams`, `esp`, `highlight`, `outline`
- **GUI / меню** — улики: `dropdown`, `slider`, `toggle`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`
- **аимбот / наведение** — улики: `mousebutton`
- **урон / убийство** — улики: `hitbox`
- **инвентарь / предметы** — улики: `drop`

## Вызовы API

- Сервисы: `Players`, `RunService`
- Классы/объекты: `Folder`, `Highlight`, `Humanoid`, `Model`, `Part`
- Методы: `FindFirstChild`×12, `Destroy`×5, `GetService`×3, `HttpGet`×3, `loadstring`×3, `Connect`×2, `GetPlayers`×2, `Create`×1, `GetMouse`×1

## Имена функций (8)

`cleanup`, `isEnemy`, `setupBypass`, `draw`, `createProxy`, `updateProxy`, `removeProxy`, `safeClick`

## Строковые константы (UI, подписи)

- `Head` ×6
- `UpperTorso` ×4
- `LowerTorso` ×3
- `Triggerbot` ×2
- `Chams` ×2
- `LeftUpperArm` ×2
- `LeftLowerArm` ×2
- `RightUpperArm` ×2
- `RightLowerArm` ×2
- `LeftUpperLeg` ×2
- `LeftLowerLeg` ×2
- `RightUpperLeg` ×2
- `RightLowerLeg` ×2
- `Line` ×2
- `Menu bind` ×2

## Ссылки / webhooks / ассеты (1)

- `https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/`

## Парты / объекты (189)

- через `WaitForChild`/`FindFirstChild`: `Head`, `HumanoidRootPart`, `Humanoid`
- идентификаторы в коде: `AccentColor`, `AddButton`, `AddColorPicker`, `AddDropdown`, `AddKeyPicker`, `AddLabel`, `AddLeftGroupbox`, `AddRightGroupbox`, `AddSlider`, `AddTab`, `AddToggle`, `Aiming`, `Anchored`, `ApplyToTab`, `Axis`, `AxisProxy`, `BONE_PAIRS`, `BOX_CONNECTIONS`, `BackgroundColor`, `Blox`, `BloxStrike`, `Box`, `BoxESP`, `BoxType`, `BuildConfigSection`, `BuiltInThemes`, `CFrame`, `Callback`, `CanCollide`, `CanQuery`, `CanTouch`, `Chams`, `ChamsColor`, `Character`, `Circle`, `Color`, `Color3`, `Compact`, `Config`, `Connect`
