# `a7dev_loader` — функционал и механики

Игра/тема: **gpo** · восстановленный код: `script.lua` (842 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `screengui`, `scrollingframe`, `textbutton`, `textlabel`, `toggle`
- **сеть / загрузка кода** — улики: `discord`, `httpget`, `httppost`, `loadstring`, `require`
- **инвентарь / предметы** — улики: `drop`, `item`
- **телепорт / движение** — улики: `tweenservice`
- **квесты / стадии** — улики: `quest`

## Вызовы API

- Сервисы: `CoreGui`, `HttpService`, `MarketplaceService`, `Players`, `TweenService`
- Классы/объекты: `Frame`, `ImageLabel`, `ScreenGui`, `ScrollingFrame`, `TextBox`, `TextButton`, `TextLabel`, `UICorner`, `UIStroke`
- Методы: `Connect`×21, `TweenService`×11, `Create`×11, `Destroy`×6, `GetService`×5, `loadstring`×3, `FindFirstChild`×2, `WaitForChild`×1, `HttpGet`×1, `HttpPost`×1

## Имена функций (31)

`New`, `Corner`, `Stroke`, `Text`, `Button`, `IsCurrentGame`, `LoadState`, `SaveState`, `LoadSecureSession`, `SaveSecureSession`, `ClearSecureSession`, `RequestSecure`, `SetAuthEnvironment`, `GetSessionRemaining`, `FormatSessionRemaining`, `AuthorizeSecure`, `ClaimManualGrant`, `FetchSecureScript`, `UpdateScale`, `MakeTab`, `Notify`, `HideAuthModal`, `ShowAuthModal`, `ResolveIcon`, `LaunchGame`, `runProtected`, `traceError`, `ApplyFilters`, `MakeSettingCard`, `CopyDiscord`, `SetPage`

## Строковые константы (UI, подписи)

- `A7DEV` ×3
- `HUB` ×3
- `Games` ×3
- `Settings` ×3
- `Access granted` ×2
- `A7DEV_HUB_LOADER` ×2
- `A7DEV_SESSION_STATUS` ×2
- `A7DEV KEY  •  LOCKED` ×2
- `UIGradient` ×2
- `a7med_hub` ×2
- `About` ×2
- `Unlock` ×2
- `☆  Favorites` ×2
- ` or ` ×2
- `A7DEV_loader_settings.json`

## Ссылки / webhooks / ассеты (4)

- `https://apis.roblox.com/universes/v1/places/%s/universe`
- `https://discord.gg/UHzMb4pZS`
- `https://linkunlocker.com/l38fg`
- `https://rbhasxhkhvldbbsvbmqj.supabase.co/functions/v1/a7dev-hub-secure`

## Парты / объекты (380)

- через `WaitForChild`/`FindFirstChild`: `PlayerGui`, `A7DEV_HUB_LOADER`, `A7DEV_SESSION_STATUS`
- идентификаторы в коде: `A7DEV`, `A7DEV_COMPAT_GAME`, `A7DEV_HUB_AUTH`, `A7DEV_HUB_EXPIRES_AT`, `A7DEV_HUB_LOADER`, `A7DEV_HUB_PERMANENT`, `A7DEV_HUB_SECONDS_LEFT`, `A7DEV_HUB_SESSION`, `A7DEV_SESSION_STATUS`, `A7DEV_loader_settings`, `A7DEV_secure_session`, `ABOUT`, `ANIMATION`, `AUTH_REQUIRED`, `AVAILABLE`, `About`, `Accept`, `Access`, `Activated`, `Active`, `Added`, `AnchorPoint`, `Anime`, `Any`, `ApplicationJson`, `ApplyFilters`, `ApplyStrokeMode`, `Authorization`, `AuthorizeSecure`, `AutoButtonColor`, `Available`, `BACKDROP`, `BAR`, `BEFORE`, `BRAND`, `BackgroundColor3`, `BackgroundTransparency`, `Blox`, `Body`, `Border`
