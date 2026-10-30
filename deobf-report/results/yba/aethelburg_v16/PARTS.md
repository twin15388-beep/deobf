# `aethelburg_v16` — функционал и механики

Игра/тема: **yba** · восстановленный код: `script.lua` (681 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `screengui`, `scrollingframe`, `slider`, `tab`, `textbutton`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `teleport`, `tweenservice`, `walkspeed`
- **автофарм / авто-клик** — улики: `auto collect`, `autocollect`, `farm`
- **ESP / подсветка** — улики: `billboardgui`, `esp`
- **аимбот / наведение** — улики: `mousebutton`, `mousemove`
- **инвентарь / предметы** — улики: `drop`, `item`
- **анти-АФК / ввод** — улики: `idled`, `inputbegan`

## Вызовы API

- Сервисы: `CoreGui`, `Players`, `RunService`, `TweenService`, `UserInputService`, `Workspace`
- Классы/объекты: `Animation`, `BasePart`, `BillboardGui`, `Camera`, `ClickDetector`, `Folder`, `Frame`, `Humanoid`, `Model`, `Part`, `ProximityPrompt`, `ScreenGui`, `ScrollingFrame`, `TextButton`, `TextLabel`, `UICorner`, `UIListLayout`, `UIStroke`
- Методы: `Create`×29, `FindFirstChild`×21, `Connect`×17, `IsA`×10, `TweenService`×9, `GetService`×7, `Destroy`×7, `GetChildren`×3, `GetMouse`×2, `WaitForChild`×1

## Имена функций (8)

`SecureCleanUI`, `CreateTab`, `CreateToggle`, `CreateButton`, `CreateSlider`, `UpdateSlider`, `BuildItemCache`, `GlideToNearestItem`

## Строковые константы (UI, подписи)

- `Common` ×4
- `All` ×3
- `Epic` ×3
- `Legendary` ×2
- `s Corpse` ×2
- `AethelApexUI` ×2
- `AethelApexESP` ×2
- `AethelCombatRaft` ×2
- `Living` ×2
- `UPDATE ENEMY LIST` ×2
- `VirtualInputManager`
- `PlayerGui`
- `Lucky Arrow`
- `Pelvis of The Saint`
- `Left Arm of The Saint`

## Ссылки / webhooks / ассеты (0)

_нет_

## Парты / объекты (409)

- через `WaitForChild`/`FindFirstChild`: `HumanoidRootPart`, `Humanoid`, `Living`, `PlayerGui`, `AethelApexUI`, `AethelApexESP`, `Stand`
- идентификаторы в коде: `AETHELBURG`, `AFK`, `AND`, `APEX`, `ARCHITECTURE`, `AbsoluteContentSize`, `AbsolutePosition`, `AbsoluteSize`, `Active`, `ActiveESP`, `ActiveFilters`, `ActivePage`, `ActiveTabBtn`, `Adornee`, `AethelApexESP`, `AethelApexUI`, `AethelCombatRaft`, `AethelConfig`, `AethelGui`, `Aethelburg`, `All`, `AlwaysOnTop`, `Anchored`, `Ancient`, `Anti`, `AntiAFK`, `AntiTimeStop`, `Apex`, `ApplyStrokeMode`, `Architecture`, `Arm`, `Arrow`, `AssemblyLinearVelocity`, `Attack`, `AttackDistance`, `AttackHeight`, `Auto`, `AutoButtonColor`, `AutoCollect`, `AutoHeal`
