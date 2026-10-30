# `tempest_hub` — функционал и механики

Игра/тема: **gpo** · восстановленный код: `script.lua` (290 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `tp`, `tweenservice`
- **автофарм / авто-клик** — улики: `auto farm`, `autofarm`, `farm`
- **ESP / подсветка** — улики: `billboardgui`, `highlight`, `outline`
- **аимбот / наведение** — улики: `aim assist`, `mousebutton`
- **квесты / стадии** — улики: `completed`, `quest`
- **GUI / меню** — улики: `textlabel`, `toggle`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`
- **анти-АФК / ввод** — улики: `idled`

## Вызовы API

- Сервисы: `Players`, `RunService`, `TweenService`
- Классы/объекты: `BillboardGui`, `CFrameValue`, `Frame`, `Highlight`, `Model`, `Part`, `TextLabel`
- Методы: `FindFirstChild`×21, `Connect`×11, `GetService`×10, `Create`×4, `HttpGet`×3, `loadstring`×3, `TweenService`×3, `IsA`×2, `GetPlayers`×2, `Destroy`×1, `Clone`×1, `SetPrimaryPartCFrame`×1

## Имена функций (10)

`tweenModel`, `GetCFrame`, `autofarmcolar`, `autoenterimpelodown`, `autoimpelodown`, `createESP`, `onPlayerAdded`, `arma`, `UpdateWatermark`, `Unload`

## Строковые константы (UI, подписи)

- `UI Settings` ×5
- `Head` ×4
- `VirtualInputManager` ×3
- `AutoFarmColar` ×3
- `Failed to create tween` ×2
- `NPCCHAT` ×2
- `MouseCF` ×2
- `[TEMPEST HUB] Loading Bypass`
- `[TEMPEST HUB] Loading Ui`
- `Library.lua`
- `addons/ThemeManager.lua`
- `addons/SaveManager.lua`
- `Welcome to Tempest Hub`
- `[TEMPEST HUB] Loading Function`
- `[TEMPEST HUB] Loading Toggles`

## Ссылки / webhooks / ассеты (1)

- `https://raw.githubusercontent.com/TrapstarKSSKSKSKKS/LinoriaLib/main/`

## Парты / объекты (209)

- через `WaitForChild`/`FindFirstChild`: `Head`, `HumanoidRootPart`, `NPCCHAT`, `Torso`, `Sarah`, `Quest`, `Part`, `Frame`, `go`, `Impel Base`, `ImpelBase`, `castle`, `Bookshelf`, `Book`, `Model`, `Highlight`
- идентификаторы в коде: `Add`, `AddButton`, `AddKeyPicker`, `AddLabel`, `AddLeftGroupbox`, `AddTab`, `AddToggle`, `Adiciona`, `Adornee`, `Aim`, `AlwaysOnTop`, `Angles`, `Apply`, `ApplyToTab`, `Assist`, `Atualiza`, `Auto`, `AutoFarmColar`, `AutoShow`, `BackgroundTransparency`, `Base`, `Begin`, `Book`, `Bookshelf`, `BuildConfigSection`, `Bypass`, `CFrame`, `CFrameValue`, `CPU`, `Callback`, `Center`, `Character`, `CharacterAdded`, `Checking`, `Clone`, `Colar`, `Color3`, `Completed`, `Connect`, `Create`
