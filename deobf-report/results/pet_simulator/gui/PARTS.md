# `gui` — функционал и механики

Игра/тема: **pet_simulator** · восстановленный код: `script.lua` (1353 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `jumppower`, `teleport`, `tp`, `walkspeed`
- **GUI / меню** — улики: `screengui`, `textbutton`, `textlabel`
- **деньги / ресурсы** — улики: `coin`, `coins`
- **инвентарь / предметы** — улики: `chest`, `inventory`
- **анти-АФК / ввод** — улики: `idled`, `virtualuser`
- **автофарм / авто-клик** — улики: `farm`
- **аимбот / наведение** — улики: `mousebutton`
- **сеть / загрузка кода** — улики: `require`

## Вызовы API

- Сервисы: `CoreGui`, `Players`, `ReplicatedStorage`, `StarterGui`, `VirtualUser`, `Workspace`
- Классы/объекты: `Frame`, `Hint`, `Humanoid`, `ScreenGui`, `TextBox`, `TextButton`, `TextLabel`
- Методы: `WaitForChild`×18, `InvokeServer`×13, `GetService`×6, `FindFirstChild`×5, `GetChildren`×2, `FireServer`×1

## Имена функций (4)

`PetTable`, `hint`, `notify`, `mine`

## Строковые константы (UI, подписи)

- `__REMOTES` ×16
- `Shop` ×6
- `Buy` ×5
- `Core` ×4
- `Get Other Stats` ×4
- `Save` ×4
- `Pets` ×4
- ` - ID: ` ×4
- `Walk:1` ×3
- `Jump:1` ×3
- `Buy Pets` ×3
- `Lord Fed: OFF` ×3
- `Black Domino: OFF` ×3
- `Buy Hats` ×3
- `Coin/Chest Health` ×3

## Ссылки / webhooks / ассеты (0)

_нет_

## Парты / объекты (298)

- через `WaitForChild`/`FindFirstChild`: `__REMOTES`, `Game`, `Coins`, `Core`, `Get Other Stats`
- идентификаторы в коде: `ADHatLabel1`, `ADPetLabel1`, `AGILITY`, `ALL`, `Active`, `Agony`, `AllHealthLabel`, `AllHealthMax`, `AllHealthMaxLabel`, `AllHealthMin`, `AllHealthMinLabel`, `Amount`, `Anti`, `Any`, `Area`, `Area10`, `Area11`, `Area12`, `Area2`, `Area3`, `Area4`, `Area5`, `Area6`, `Area7`, `Area8`, `Area9`, `AreaDivider`, `Auto`, `BEST`, `BUY`, `BackgroundColor3`, `BackgroundTransparency`, `Barriers`, `Black`, `BorderColor3`, `BorderSizePixel`, `Buy`, `BuyEgg`, `BuyHatAmount1`, `BuyHatAmount2`
