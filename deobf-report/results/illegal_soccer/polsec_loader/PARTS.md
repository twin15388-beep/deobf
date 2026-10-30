# `polsec_loader` — функционал и механики

Игра/тема: **illegal_soccer** · восстановленный код: `script.lua` (1580 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `screengui`, `scrollingframe`, `tab`, `textbutton`, `textlabel`
- **сеть / загрузка кода** — улики: `discord`, `httpget`, `loadstring`
- **ESP / подсветка** — улики: `highlight`, `outline`
- **аимбот / наведение** — улики: `mousebutton`, `mousemove`
- **квесты / стадии** — улики: `completed`, `quest`
- **телепорт / движение** — улики: `tweenservice`
- **деньги / ресурсы** — улики: `code`
- **анти-АФК / ввод** — улики: `inputbegan`

## Вызовы API

- Сервисы: `CoreGui`, `GuiService`, `HttpService`, `Lighting`, `MarketplaceService`, `Players`, `RunService`, `StarterGui`, `TextService`, `TweenService`, `UserInputService`, `Workspace`
- Классы/объекты: `Camera`, `Frame`, `GuiObject`, `ImageLabel`, `Lighting`, `ScreenGui`, `ScrollingFrame`, `TextBox`, `TextButton`, `TextLabel`, `UICorner`, `UIListLayout`, `UIStroke`
- Методы: `Create`×100, `Connect`×28, `GetService`×12, `HttpGet`×5, `loadstring`×5, `IsA`×5, `TweenService`×3, `Destroy`×2, `FindFirstChild`×1, `GetChildren`×1

## Имена функций (24)

`LPH_NO_VIRTUALIZE`, `LPH_ENCSTR`, `LRM_SANITIZE`, `StealAnEggBypass`, `StartRunAnalytics`, `ReportFirstGame`, `Copy`, `ReadJson`, `LoadSavedKey`, `SaveKey`, `LoadSettings`, `InstallDiscordGuard`, `Hook`, `TryDiscordAutoJoin`, `EnsureSniper`, `ApplyKey`, `LoadGame`, `TimeLeft`, `NormalizeError`, `ResolveError`, `CheckKey`, `TrySilent`, `gethui`, `GameCard`

## Строковые константы (UI, подписи)

- `UIPadding` ×10
- `Outline` ×9
- `Unselected` ×8
- `TextColor` ×7
- `UIShadow` ×6
- `):gsub(` ×5
- `OtherBackgrounds` ×5
- `Inline` ×5
- `Accent` ×5
- `^%s+` ×4
- `UIFlexItem` ×4
- `POST` ×3
- `Content-Type` ×3
- `application/json` ×3
- `Button` ×3

## Ссылки / webhooks / ассеты (12)

- `http://127.0.0.1:6463/rpc?v=1`
- `https://api.polsec.net/loader`
- `https://api.polsec.net/sdk`
- `https://discord.com`
- `https://discord.gg/gUbZegrB6g`
- `https://getsportsclub.com/adsystem`
- `https://getsportsclub.com/api/free-key/first-game`
- `https://loader.sportsclub.fun/clientv1.lua`
- `https://loader.sportsclub.fun/sniperduels_bypass.luau`
- `https://pastebin.com/raw/UwQPRTXQ`
- `https://pastebin.com/raw/nDTMkYuc`
- `https://sportsclub.fun/#store`

## Парты / объекты (674)

- через `WaitForChild`/`FindFirstChild`: `ModerationService`
- идентификаторы в коде: `AbsoluteSize`, `Accent`, `AccentText`, `Active`, `AddButton`, `AddInput`, `AddLoader`, `Alpha`, `Alt`, `AnalyticsClient`, `AnalyticsProject`, `AnalyticsVersion`, `AnchorPoint`, `AnimSizeX`, `AnimY`, `AnimatedColorpickers`, `Api`, `Apply`, `ApplyKey`, `ApplyTween`, `ApplyVisual`, `AssetId`, `Asterisk`, `AtEnd`, `AttributionUrl`, `AutoButtonColor`, `AutomaticCanvasSize`, `AutomaticSize`, `Back`, `BackSlash`, `Background`, `BackgroundColor3`, `BackgroundTransparency`, `Backquote`, `Backspace`, `BestColor`, `BestEnd`, `BestStart`, `Bin`, `BlurRadius`
