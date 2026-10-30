# `super_futebol` — функционал и механики

Игра/тема: **illegal_soccer** · восстановленный код: `script.lua` (398 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `tweenservice`
- **аимбот / наведение** — улики: `mousebutton`, `mousemove`
- **GUI / меню** — улики: `screengui`, `textlabel`
- **анти-АФК / ввод** — улики: `inputbegan`

## Вызовы API

- Сервисы: `Players`, `ReplicatedStorage`, `RunService`, `ServerScriptService`, `Teams`, `TweenService`, `UserInputService`, `Workspace`
- Классы/объекты: `Folder`, `Frame`, `Humanoid`, `LocalScript`, `Part`, `RemoteEvent`, `ScreenGui`, `TextLabel`
- Методы: `Connect`×12, `FindFirstChild`×11, `GetService`×10, `WaitForChild`×8, `FireServer`×6, `TweenService`×4, `GetPlayers`×4, `Create`×2

## Имена функций (10)

`ensureFolder`, `ensureRemote`, `resetBall`, `applyBallPhysics`, `getPlayerData`, `assignTeam`, `startMatch`, `endMatch`, `setupGoal`, `injectClient`

## Строковые константы (UI, подписи)

- `Blue` ×4
- `Red` ×3
- `SuperFutebolRemotes` ×2
- `Kick` ×2
- `Skill` ×2
- `Tackle` ×2
- `UpdateUI` ×2
- `MatchState` ×2
- `Ball` ×2
- `Start` ×2
- `Empate` ×2
- `End` ×2
- `PlayerGui` ×2
- `Debris`
- ` no Workspace!`

## Ссылки / webhooks / ассеты (0)

_нет_

## Парты / объекты (215)

- через `WaitForChild`/`FindFirstChild`: `HumanoidRootPart`, `PlayerGui`, `Ball`, `GoalBlue`, `GoalRed`, `SuperFutebolRemotes`, `Kick`, `Skill`, `Tackle`, `UpdateUI`, `MatchState`
- идентификаторы в коде: `Anchored`, `Angles`, `AssemblyAngularVelocity`, `AssemblyLinearVelocity`, `BALL_BOUNCE`, `BALL_FRICTION`, `BOLA`, `BackgroundColor3`, `BackgroundTransparency`, `Ball`, `BallOwner`, `Blue`, `Bounce`, `CFrame`, `CLIENT`, `COMO`, `CONFIG`, `CONTROLES`, `CONTROLLER`, `CURVE_STRENGTH`, `CUSTOM`, `CanCollide`, `Carregar`, `Carrinho`, `Character`, `CharacterAdded`, `Client`, `ClientCode`, `Cliente`, `Clique`, `Coloque`, `Color3`, `Connect`, `Controles`, `Controller`, `Create`, `Crie`, `Ctrl`, `CurrentCamera`, `Curve`
