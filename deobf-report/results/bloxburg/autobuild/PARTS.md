# `autobuild` — функционал и механики

Игра/тема: **bloxburg** · восстановленный код: `script.lua` (13315 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `screengui`, `scrollingframe`, `tab`, `textbutton`, `textlabel`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `teleport`, `tweenservice`, `walkspeed`
- **анти-АФК / ввод** — улики: `button2down`, `idled`, `inputbegan`, `keydown`, `virtualuser`
- **деньги / ресурсы** — улики: `cash`, `code`, `money`
- **инвентарь / предметы** — улики: `drop`, `item`, `sell`
- **сеть / загрузка кода** — улики: `discord`, `loadstring`, `require`
- **аимбот / наведение** — улики: `mousebutton`, `mousemove`
- **квесты / стадии** — улики: `completed`, `quest`
- **автофарм / авто-клик** — улики: `autofarm`
- **урон / убийство** — улики: `noclip`

## Вызовы API

- Сервисы: `CoreGui`, `HttpService`, `MarketplaceService`, `Players`, `ReplicatedStorage`, `RunService`, `TweenService`, `UserInputService`, `VirtualUser`, `Workspace`
- Классы/объекты: `BodyForce`, `BodyGyro`, `BodyVelocity`, `Folder`, `Frame`, `Humanoid`, `ImageButton`, `ImageLabel`, `MeshPart`, `Model`, `ModuleScript`, `Motor6D`, `Part`, `RemoteEvent`, `RemoteFunction`, `ScreenGui`, `ScrollingFrame`, `TextBox`, `TextButton`, `TextLabel`
- Методы: `FindFirstChild`×133, `FireServer`×50, `InvokeServer`×49, `GetChildren`×46, `GetService`×44, `IsA`×22, `Connect`×12, `Create`×12, `Destroy`×10, `WaitForChild`×9, `SetPrimaryPartCFrame`×8, `TweenService`×3

## Имена функций (0)

_имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), смысл восстанавливается по вызовам выше_

## Строковые константы (UI, подписи)

- `ColorObject` ×20
- `Linear` ×14
- `InOut` ×13
- `BasePart` ×12
- `PlaceObject` ×12
- `Interact` ×11
- `ItemHolder` ×11
- `Plot_` ×10
- `AttachPos` ×9
- `Building %s...` ×9
- `GET` ×7
- `ObjectData` ×7
- `JobCompleted` ×6
- `CFrameValue` ×5
- `ChromaAutoBuildPreview` ×5

## Ссылки / webhooks / ассеты (7)

- `https://api.applebee1558.com/alphax/v2/bloxburg/pixelart`
- `https://api.applebee1558.com/alphax/v2/bloxburg_bases`
- `https://api.applebee1558.com/alphax/v2/bloxburg_bases/%s`
- `https://api.applebee1558.com/lumbsmasher/role/`
- `https://api.applebee1558.com/lumbsmasher/server_message`
- `https://lumbsmasherapi.applebee1558.com/discordtag/`
- `https://api.applebee1558.com/alphax/v2/bloxburg_bases/%s/preview`

## Парты / объекты (653)

- идентификаторы в коде: `API`, `AbsoluteContentSize`, `Activated`, `Active`, `AddIceCreamScoop`, `AddIceCreamTopping`, `After`, `Amount`, `AnchorPoint`, `Anchored`, `Angles`, `Art`, `AttachPos`, `AttachPos1`, `AttachWeld`, `Attempt`, `Attempted`, `AutoBuild`, `AutoFarm`, `Autobuild`, `Autofarm`, `BFF`, `BPole`, `BSPrice`, `BackgroundColor3`, `BackgroundTransparency`, `BackwardsSpeed`, `BagCrate`, `Bags`, `BagsLeft`, `Baker`, `BakerWorkstations`, `Ball`, `Ball1`, `Ball2`, `Base`, `BasePart`, `Basements`, `Because`, `BensIceCreamCustomer`
