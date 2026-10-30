# `hub` — функционал и механики

Игра/тема: **grow_a_garden** · восстановленный код: `script.lua` (10450 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `screengui`, `scrollingframe`, `slider`, `tab`, `textbutton`
- **деньги / ресурсы** — улики: `code`, `coin`, `coins`, `gem`, `infinite`, `money`
- **инвентарь / предметы** — улики: `chest`, `drop`, `inventory`, `item`, `sell`, `trade`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `moveto`, `teleport`, `walkspeed`
- **ESP / подсветка** — улики: `billboardgui`, `boxhandle`, `esp`, `highlight`, `outline`
- **сеть / загрузка кода** — улики: `discord`, `httpget`, `loadstring`, `require`, `webhook`
- **автофарм / авто-клик** — улики: `auto collect`, `farm`, `grind`
- **урон / убийство** — улики: `god mode`, `kill`, `noclip`
- **квесты / стадии** — улики: `auto skip`, `daily`, `quest`
- **аимбот / наведение** — улики: `mousebutton`
- **анти-АФК / ввод** — улики: `virtualuser`

## Вызовы API

- Сервисы: `CollectionService`, `CoreGui`, `GuiService`, `HttpService`, `Lighting`, `MarketplaceService`, `Players`, `ReplicatedStorage`, `RunService`, `StarterGui`, `Teams`, `UserInputService`, `VirtualUser`, `Workspace`
- Классы/объекты: `Animation`, `AnimationController`, `BasePart`, `Beam`, `BillboardGui`, `BlurEffect`, `BoxHandleAdornment`, `Decal`, `Fire`, `Folder`, `Frame`, `Highlight`, `Humanoid`, `Lighting`, `Model`, `Part`, `ParticleEmitter`, `PointLight`, `ProximityPrompt`, `ScreenGui`
- Методы: `FindFirstChild`×289, `IsA`×139, `GetChildren`×102, `FireServer`×101, `Destroy`×36, `Create`×25, `GetService`×24, `InvokeServer`×18, `Connect`×17, `WaitForChild`×10, `HttpGet`×8, `loadstring`×7

## Имена функций (118)

`_unpack`, `_pcall`, `fn`, `LPH_NO_VIRTUALIZE`, `LPH_JIT_MAX`, `LPH_JIT`, `LPH_ENCNUM`, `LPH_ENCSTR`, `LPH_ENCFUNC`, `LPH_ENCBUF`, `LPH_ATTRIBUTES`, `LPH_REWRITE`, `LPH_STACKALLOC`, `LPH_PRECHECK`, `VM`, `PRESET`, `ENCRYPT`, `OPTIMIZE`, `ERROR_HANDLING`, `TRANSFORM`, `fn2`, `fn3`, `fn4`, `fn5`, `fn12`, `GetMagnitude`, `GetTo`, `MoveTo`, `GetOwnerFarm`, `GetFarmPath`, `Webhook`, `IsAlive`, `GetImageURL`, `FireDelay`, `FruitFilter`, `PetFilter`, `ClickUI`, `FormatNumber`, `FormatNumer1`, `fn13`

## Строковые константы (UI, подписи)

- `None` ×41
- `Plants_Physical` ×31
- `, false, { ` ×31
- `N/A` ×24
- `Auto Switch Loadouts` ×23
- `Speed Hub X` ×23
- `Auto Switch File` ×23
- `Normal` ×22
- `):gsub(` ×22
- `OWNER` ×21
- `Above` ×21
- `Selling Pet` ×19
- `Hatching Egg` ×17
- `Stop Switch` ×17
- `Instant Collect` ×17

## Ссылки / webhooks / ассеты (11)

- `https://api.luarmor.net/files/v3/loaders/`
- `https://discord.gg/speedhubx`
- `https://games.roblox.com/v1/games/`
- `https://sdkapi-public.luarmor.net/sync`
- `https://thumbnails.roblox.com/v1/assets?assetIds=`
- `https://raw.githubusercontent.com/AhmadV99/Main/refs/heads/main/Data%20Game/Grow%20A%20Garden/`
- `https://raw.githubusercontent.com/AhmadV99/Main/refs/heads/main/Library/Key%20System/Encrypted`
- `https://raw.githubusercontent.com/AhmadV99/Main/refs/heads/main/Library/Key%20System/Get%20Key%20API.lua`
- `https://raw.githubusercontent.com/AhmadV99/Main/refs/heads/main/Library/KeySystemV2.5.lua`
- `https://raw.githubusercontent.com/AhmadV99/Main/refs/heads/main/Library/Lib_5.5.0.lua`
- `https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua\`

## Парты / объекты (1876)

- через `WaitForChild`/`FindFirstChild`: `PetsPhysical`, `Humanoid`, `Weight`, `Backpack`, `TextLabel`, `ESP`, `Frame`, `val`, `HumanoidRootPart`, `Shovel [Destroy Plants]`, `Important`, `Variant`, `BillboardGui`, `Fruits`, `SurfaceGui`, `American Traveling Merchant`, `Gnome Traveling Merchant`, `Honey Traveling Merchant`, `SkyTravelingMerchant`, `Spray Traveling Merchant`, `Sprinkler Traveling Merchant`, `Summer Traveling Merchant`, `Fall Traveling Merchant`, `Halloween Traveling Merchant`, `Safari Traveling Merchant`
- идентификаторы в коде: `AFK`, `API`, `Above`, `AbsolutePosition`, `AbsoluteSize`, `Accept`, `Accident`, `Acidwing`, `Acorn`, `ActionText`, `Activate`, `Activated`, `Active`, `ActivePetService`, `ActivePetUI`, `ActivePetsService_Replicator`, `AddButton`, `AddDropdown`, `AddInput`, `AddParagraph`, `AddSection`, `AddSeperator`, `AddSettingUi`, `AddSlider`, `AddToggle`, `Admin`, `Adornee`, `AdvanceToNextPageAsync`, `Advanced`, `Age`, `AhmadV99`, `Alien`, `All`, `AllSlots`, `AllWeather`, `Allow`, `AllowFakePurchase`, `Allows`, `AlwaysOnTop`, `Amber`
