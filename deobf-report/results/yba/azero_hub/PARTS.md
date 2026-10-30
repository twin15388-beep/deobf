# `azero_hub` — функционал и механики

Игра/тема: **yba** · восстановленный код: `script.lua` (992 строк)

## Что делает (по восстановленному коду)

- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `moveto`, `teleport`, `tweenservice`
- **GUI / меню** — улики: `dropdown`, `tab`, `textlabel`, `toggle`
- **инвентарь / предметы** — улики: `chest`, `drop`, `item`
- **аимбот / наведение** — улики: `mousebutton`, `mousemove`
- **квесты / стадии** — улики: `completed`, `quest`
- **автофарм / авто-клик** — улики: `farm`
- **деньги / ресурсы** — улики: `coin`
- **сеть / загрузка кода** — улики: `loadstring`
- **анти-АФК / ввод** — улики: `inputbegan`

## Вызовы API

- Сервисы: `Players`, `ReplicatedStorage`, `RunService`, `TweenService`, `UserInputService`
- Классы/объекты: `Attachment`, `Backpack`, `BasePart`, `Frame`, `Humanoid`, `IntValue`, `Model`, `NumberValue`, `ProximityPrompt`, `RemoteEvent`, `RemoteFunction`, `StringValue`, `TextBox`, `TextLabel`, `Tool`, `UICorner`, `UIListLayout`, `UIStroke`
- Методы: `FindFirstChild`×22, `Connect`×19, `IsA`×16, `Create`×12, `TweenService`×9, `GetService`×5, `WaitForChild`×4, `GetChildren`×3, `InvokeServer`×2, `FireServer`×1, `loadstring`×1, `Destroy`×1

## Имена функций (44)

`CreateNotifier`, `makeCard`, `extractNumber`, `getCharacter`, `getHumanoid`, `getRemoteFunction`, `getRemoteEvent`, `getPlayerStats`, `getCurrentPity`, `getCurrentStandName`, `hasStand`, `isShinyStand`, `countToolsByName`, `unequipAllTools`, `holdOneTool`, `toggleStand`, `desummonStand`, `acceptDialogue`, `getWorthiness`, `ensureWorthiness`, `waitForStandResult`, `useArrow`, `useRokakaka`, `useRibcage`, `hasAnySelected`, `targetHit`, `stopIfTargetOrShiny`, `farmNormalStand`, `farmRibStand`, `farmPity`, `AddTextBox`, `getPromptItemName`, `itemMatchesTarget`, `stopItemSpawnWatcher`, `startItemSpawnWatcher`, `getRootPart`, `stopItemTween`, `getPromptPosition`, `moveToItemPosition`, `triggerPrompt`

## Строковые константы (UI, подписи)

- `None` ×8
- `Ribcages` ×5
- `Shiny ` ×5
- `Items` ×4
- `Tween` ×4
- `Shiny` ×3
- `Dialogue2` ×3
- `Option1` ×3
- `Worthiness failed` ×3
- `No rokakaka left` ×3
- `Wanted: ` ×3
- `Mysterious Arrow` ×2
- `Rokakaka` ×2
- `Rib Cage of The Saint` ×2
- `PlayerStats` ×2

## Ссылки / webhooks / ассеты (1)

- `https://raw.githubusercontent.com/thatguyscousin9/personal-project2/main/YBA_UI`

## Парты / объекты (384)

- через `WaitForChild`/`FindFirstChild`: `PlayerStats`, `StandName`, `StandMorph`, `Humanoid`, `RemoteFunction`, `RemoteEvent`, `PityCount`, `Objects`, `HUD`, `Main`, `Frames`, `Store`, `List`, `StandShop`, `Stand`, `StandSkin`, `CharacterSkillTree`, `Worthiness`, `HumanoidRootPart`
- идентификаторы в коде: `ACT`, `Activate`, `Active`, `ActiveItemTween`, `AddDropdown`, `AddTab`, `AddTextBox`, `AddToggle`, `Aerosmith`, `Album`, `Alternate`, `AnchorPoint`, `Ancient`, `Anubis`, `Arrow`, `Arrows`, `Azero`, `BackgroundColor3`, `BackgroundTransparency`, `Backpack`, `Ball`, `BasePart`, `Beach`, `Body`, `BorderSizePixel`, `Bottom`, `Boy`, `CFrame`, `Caesar`, `Cage`, `Callback`, `Cancel`, `Candies`, `Center`, `Character`, `CharacterAdded`, `CharacterSkillTree`, `Chariot`, `Chili`, `Christmas`
