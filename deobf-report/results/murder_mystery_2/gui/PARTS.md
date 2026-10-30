# `gui` — функционал и механики

Игра/тема: **murder_mystery_2** · восстановленный код: `script.lua` (1148 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `teleport`, `walkspeed`
- **GUI / меню** — улики: `screengui`, `textbutton`, `textlabel`, `toggle`
- **урон / убийство** — улики: `god mode`, `godmode`, `noclip`
- **ESP / подсветка** — улики: `billboardgui`, `esp`
- **анти-АФК / ввод** — улики: `inputbegan`, `keydown`
- **аимбот / наведение** — улики: `mousebutton`
- **деньги / ресурсы** — улики: `coin`
- **инвентарь / предметы** — улики: `drop`

## Вызовы API

- Сервисы: `CoreGui`, `Players`, `RunService`, `UserInputService`, `Workspace`
- Классы/объекты: `BasePart`, `BillboardGui`, `BodyGyro`, `BodyVelocity`, `Frame`, `Humanoid`, `ScreenGui`, `TextButton`, `TextLabel`
- Методы: `GetService`×12, `GetChildren`×11, `Create`×11, `FindFirstChild`×7, `IsA`×3, `Clone`×1, `GetMouse`×1

## Имена функций (12)

`Create`, `findmurderer`, `findsheriff`, `findplayers`, `Clear`, `XrayOn`, `XrayOff`, `sFLY`, `FLY`, `NOFLY`, `coingrabberfunc`, `godmodefunc`

## Строковые константы (UI, подписи)

- `Inactive` ×35
- `Active` ×24
- `None` ×7
- `Head missing from sheriff!` ×6
- `Head missing from murderer!` ×4
- `Knife` ×2
- `Murderer` ×2
- ` is Murderer` ×2
- `Revolver` ×2
- `Gun` ×2
- `Sheriff` ×2
- ` is Sheriff` ×2
- `Torso` ×2
- `Murderer/Sheriff` ×2
- `Noclip Enabled` ×2

## Ссылки / webhooks / ассеты (0)

_нет_

## Парты / объекты (183)

- через `WaitForChild`/`FindFirstChild`: `Humanoid`, `Torso`, `Head`
- идентификаторы в коде: `Active`, `Adornee`, `All`, `AlwaysOnTop`, `Animate`, `ArialBold`, `BackgroundColor3`, `BackgroundTransparency`, `Backpack`, `BasePart`, `Big`, `BorderColor3`, `BorderSizePixel`, `Bring`, `BringGun`, `Buttons`, `CFrame`, `CONTROL`, `CameraSubject`, `CanCollide`, `Change`, `Character`, `CharacterAdded`, `Checks`, `Clear`, `Clears`, `Clone`, `Coin`, `CoinGrabber`, `Color3`, `CoordinateFrame`, `Create`, `Ctrl`, `CurrentCamera`, `Disabled`, `Disables`, `Don`, `Draggable`, `Enabled`, `Enables`
