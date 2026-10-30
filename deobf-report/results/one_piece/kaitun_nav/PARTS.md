# `kaitun_nav` — функционал и механики

Игра/тема: **one_piece** · восстановленный код: `script.lua` (1107 строк)

## Что делает (по восстановленному коду)

- **GUI / меню** — улики: `dropdown`, `screengui`, `slider`, `tab`, `textlabel`, `toggle`
- **автофарм / авто-клик** — улики: `auto collect`, `autofarm`, `farm`
- **телепорт / движение** — улики: `cframe`, `humanoidrootpart`, `tp`
- **инвентарь / предметы** — улики: `chest`, `drop`
- **сеть / загрузка кода** — улики: `httpget`, `loadstring`
- **анти-АФК / ввод** — улики: `keydown`

## Вызовы API

- Сервисы: `Lighting`, `Players`, `ReplicatedStorage`, `RunService`, `UserInputService`
- Классы/объекты: `BasePart`, `Frame`, `Humanoid`, `Lighting`, `ScreenGui`, `TextLabel`, `UICorner`, `UIListLayout`, `ValueBase`
- Методы: `Create`×44, `FindFirstChild`×22, `GetService`×6, `FireServer`×3, `IsA`×3, `InvokeServer`×2, `Connect`×1, `HttpGet`×1, `loadstring`×1, `Destroy`×1

## Имена функций (35)

`getRoot`, `getHum`, `find_ocean`, `ocean`, `refresh_filter`, `ray`, `water_surface_y_at`, `apply_water_walk`, `tick_footstep`, `tick_stam`, `write_cframe`, `check_correction`, `init_toasts`, `toast`, `apply_no_fog`, `get_peli`, `has_rifle`, `chest_visible_at`, `any_chest_visible`, `probe_obstacle`, `step_walk`, `read_input`, `step_fly`, `resolve_pos`, `orb_fired`, `nudge_orb`, `retp_to_orb`, `confirm_orb_fired`, `travel_to`, `key_hold`, `press_e`, `press_t`, `buy_rifle`, `set_spawn`, `claim_chest`

## Строковые константы (UI, подписи)

- `Chest ` ×3
- `, PlaceholderText = ` ×3
- `, CurrentValue = ` ×3
- `SetSpawn` ×2
- `Ocean` ×2
- `Stats` ×2
- `Nav` ×2
- `Fly` ×2
- `Kaitun`
- `Events`
- `Town of Beginners`
- `Sandora`
- `Shell`
- `Rifle`
- `Env`

## Ссылки / webhooks / ассеты (1)

- `https://sirius.menu/rayfield`

## Парты / объекты (257)

- через `WaitForChild`/`FindFirstChild`: `SetSpawn`, `Stats`, `Events`, `footstep`, `takestam`, `HumanoidRootPart`, `Env`, `WaterStuff`, `Ocean`, `PlayerGui`, `Peli`, `Backpack`, `BuyableItems`, `Shop`, `Tools`
- идентификаторы в коде: `AFTER_SPAWN_POS`, `AUTOFARM`, `Actions`, `All`, `AnchorPoint`, `AssemblyLinearVelocity`, `Auto`, `Autofarm`, `BUY`, `Back`, `BackgroundColor3`, `BackgroundTransparency`, `Backpack`, `BasePart`, `Beginners`, `BorderSizePixel`, `Bright`, `Brightness`, `BuyableItems`, `Buying`, `CFG`, `CFrame`, `CHEST`, `CHESTS`, `Cache`, `Callback`, `CanCollide`, `Character`, `Check`, `Chest`, `Chests`, `Claiming`, `ClockTime`, `Collect`, `Color3`, `ConfigurationSaving`, `Connect`, `Coord`, `Coords`, `CornerRadius`
