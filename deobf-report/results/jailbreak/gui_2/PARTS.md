# `gui_2` — функционал и механики

Игра/тема: **jailbreak** · восстановленный код: `script.lua` (1833 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `jumppower`, `moveto`, `teleport`, `tp`
- **GUI / меню** — улики: `screengui`, `scrollingframe`, `textbutton`, `textlabel`, `toggle`
- **ESP / подсветка** — улики: `billboardgui`, `esp`
- **урон / убийство** — улики: `god mode`, `godmode`
- **анти-АФК / ввод** — улики: `inputbegan`, `keydown`
- **аимбот / наведение** — улики: `mousebutton`
- **деньги / ресурсы** — улики: `infinite`
- **квесты / стадии** — улики: `quest`
- **сеть / загрузка кода** — улики: `loadstring`

## Вызовы API

- Сервисы: `CoreGui`, `Players`, `ReplicatedStorage`, `RunService`, `StarterGui`, `Teams`, `UserInputService`, `Workspace`
- Классы/объекты: `BasePart`, `BillboardGui`, `BindableFunction`, `BodyAngularVelocity`, `BodyGyro`, `BodyPosition`, `BodyVelocity`, `Camera`, `ClickDetector`, `Decal`, `Frame`, `HopperBin`, `Humanoid`, `ImageButton`, `ImageLabel`, `MeshPart`, `Model`, `ObjectValue`, `Part`, `ScreenGui`
- Методы: `GetService`×31, `FindFirstChild`×18, `GetChildren`×14, `Destroy`×12, `WaitForChild`×4, `GetPlayers`×3, `Connect`×2, `loadstring`×2, `Create`×2, `IsA`×2, `Clone`×2, `GetMouse`×2

## Имена функций (12)

`Bypass`, `onButton1Down`, `onButton1Up`, `onSelected`, `Create`, `Find`, `Clear`, `AddLasso`, `RemoveLasso`, `ToggleTracers`, `CharAdded`, `PlrAdded`

## Строковые константы (UI, подписи)

- `UnionOperation` ×4
- `Teleport` ×4
- `None` ×4
- `Back` ×3
- `Low Gravity` ×3
- `JailFix` ×2
- `Teleports` ×2
- `Game Related` ×2
- `Multi Purpose` ×2
- `Moving` ×2
- `Criminal` ×2
- `Infinite Jump: ` ×2
- `Off` ×2
- `SourceSansBold` ×2
- `Size10` ×2

## Ссылки / webhooks / ассеты (0)

_нет_

## Парты / объекты (311)

- через `WaitForChild`/`FindFirstChild`: `Model`, `Rob`, `Camera`, `Givers`, `Banks`, `Jewelrys`, `Trains`, `BoxCar`, `Skeleton`, `UpperTorso`
- идентификаторы в коде: `AIM_AT`, `Active`, `AddLasso`, `Adornee`, `All`, `AlwaysOnTop`, `Ammo`, `Anchored`, `Angles`, `AngularVelocity`, `Animate`, `ArialBold`, `Arrest`, `AutoRob`, `Back`, `BackgroundColor3`, `BackgroundTransparency`, `Backpack`, `Bank`, `Banks`, `Base`, `BasePart`, `BinType`, `BindableFunction`, `Blocks`, `BodyAngularVelocity`, `BodyPosition`, `BorderColor3`, `BorderSizePixel`, `BoxCar`, `Btools`, `Buggy`, `Button1`, `Button2`, `Bypass`, `CESP`, `CFrame`, `Call`, `Callback`, `CameraSubject`
