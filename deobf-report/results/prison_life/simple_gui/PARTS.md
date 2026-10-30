# `simple_gui` — функционал и механики

Игра/тема: **prison_life** · восстановленный код: `script.lua` (2755 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `jumppower`, `teleport`, `walkspeed`
- **урон / убийство** — улики: `breakjoints`, `godmode`, `kill`, `noclip`
- **GUI / меню** — улики: `screengui`, `textbutton`, `textlabel`, `toggle`
- **аимбот / наведение** — улики: `mousebutton`
- **анти-АФК / ввод** — улики: `keydown`

## Вызовы API

- Сервисы: `ContextActionService`, `Players`, `ReplicatedStorage`, `RunService`, `Teams`, `Workspace`
- Классы/объекты: `BodyGyro`, `BodyPosition`, `Frame`, `HopperBin`, `Humanoid`, `ImageButton`, `Model`, `Part`, `ScreenGui`, `TextBox`, `TextButton`, `TextLabel`
- Методы: `GetService`×25, `GetPlayers`×11, `Destroy`×9, `GetMouse`×7, `FindFirstChild`×6, `WaitForChild`×5, `GetChildren`×5, `InvokeServer`×5, `FireServer`×4, `Clone`×2

## Имена функций (4)

`plrlist`, `toggleKillAura`, `start`, `allcrims`

## Строковые константы (UI, подписи)

- `Text` ×43
- `Teleport` ×12
- `Execute` ×10
- `Close` ×6
- `Activate` ×6
- `Turn On` ×4
- `Turn Off` ×4
- `Open` ×4
- `EPIXPOS` ×4
- `Villanity GUI V3` ×3
- `CloseButton` ×3
- `Prison Gate` ×3
- `Prison Yard` ×2
- `Respawn` ×2
- `meleeEvent` ×2

## Ссылки / webhooks / ассеты (0)

_нет_

## Парты / объекты (364)

- через `WaitForChild`/`FindFirstChild`: `HumanoidRootPart`, `PlayerGui`
- идентификаторы в коде: `Activate`, `Activated`, `Active`, `All`, `AllCrimsB`, `Anchored`, `Angles`, `Animate`, `Arrest`, `ArrestAllB`, `BackgroundColor3`, `BackgroundTransparency`, `Backpack`, `Base`, `Begin`, `BinType`, `BindAction`, `BodyPosition`, `BorderColor3`, `BorderSizePixel`, `BreakJoints`, `Bright`, `Btools`, `BtoolsOn`, `Button1Down`, `CAOnB`, `CFrame`, `Cafeteria`, `CameraSubject`, `CanCollide`, `Cartoon`, `Cells`, `ChangeState`, `Character`, `Click`, `ClickArrestOn`, `Clone`, `Close`, `CloseButton`, `CloseButton_2`
