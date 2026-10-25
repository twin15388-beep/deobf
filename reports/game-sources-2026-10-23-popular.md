# Проход по популярным играм: Murder Mystery 2, и почему ASTD с Bloxstrike не пополнили каталог — 23 октября 2026

Запрос был на **All Star Tower Defense**, **Bloxstrike** и другие популярные игры. Результат: **одно новое полное раскрытие** (Murder Mystery 2) и документированные причины, по которым ASTD и Bloxstrike не дали нового игрового файла. В [`dobf scripts 1.0/`](../dobf%20scripts%201.0/README.md) теперь **67 файлов: 32 восстановления/частичных результата и 35 прежних `(src)`**. Pastefy и API для получения скриптов не использовались (через GitHub API — только метаданные, поиск и лицензии), ключи не подбирались, защищённый top-level не исполнялся, Roblox не запускался. [Манифест с SHA-256](game-sources-2026-10-23-popular.json).

## Murder Mystery 2 — полное раскрытие из MIT-входа

| Поле | Значение |
| --- | --- |
| Вход | [`volmaksDev/My-Scripts@231da028`](https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/test.lua), файл `test.lua`, MIT (LICENSE, SHA-256 `24ba1203…`) |
| Размер / SHA-256 входа | 412 745 байт, `144d0c252f0246add56d0ae721d1d667e1365b41d61ee492416ac266dd60b7cf` |
| Результат | [Murder Mystery 2 - volmaks Coin Farm.lua](../dobf%20scripts%201.0/Murder%20Mystery%202%20-%20volmaks%20Coin%20Farm.lua), 48 598 байт (тело 44 904 / 1 931 строка), SHA-256 `23d847f31d7ef1b63a5faa674e1bacd29fb3ca89960af0ad77ed5c9e88e87256` |
| Тело | SHA-256 `7e19e208846af00ff68be7de8a80e8de91a11d96280ee7273675acbaff21ea6e`, два прогона декодера побайтово идентичны |

Вход — WAD-стиль **без** баннера v1.0.0, поэтому декодирование шло с `--force`. Прогон шёл через новый конвейер: `python3 scripts/wad_recover.py … --game 'Murder Mystery 2'` — лицензионный гейт пройден, два прогона совпали, аудит дал `game_code` и `publishable=True`, внешние хосты перечислены.

**Игровая привязка в самом теле:** карта ищется как `Model` с `GetAttribute("MapID")` (`f9`), монеты — из `CoinContainer` у ребёнка `workspace` (`f20`), выпавшее оружие подсвечивается `"GunDropHighlight"` (`f12`), роли — `Sheriff`/`Murderer`/`Innocent`, данные читаются через `getPlayerLevel:InvokeServer(lp)`, `getProfileData:InvokeServer()` и `ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()`. Дополнительно игра подтверждена совпадением имён `GunDropHighlight` и `SolunaFlingVel` с другими MM2-скриптами на GitHub (14 и 2 совпадения, включая `Soluna-Development/API:src/scripts/Murder-Mystery-2.lua`); **PlaceId в коде не проверяется**.

| Обработчик (имя декодера) | Параметры | Что делает |
| --- | --- | --- |
| `f20()` | — | Возвращает `CoinContainer` — источник монет для Coin Farm |
| `f12(p6)` | `p6: Instance` выпавшего оружия | Создаёт `"GunDropHighlight"`, если ESP включён и подсветки ещё нет |
| `CreateHighlight(p7)` / `UpdateHighlights()` | `p7: Player` | ESP игроков по ролям, локальный игрок пропускается |
| `f15()` / `f16()` / `f17()` | — | Выбор цели по роли, аимбот, слежение камерой; вариант «Aimbot (Camera Lock)» |
| `miniFling(p9)` / `f18(p10, p11, p12)` | `p9: Player` | Флинг по тумблерам «Fling murderer» / «Fling sheriff»; при nil — уведомление |
| `f28()` / `f30()` | — | Auto grab gun: сбор выпавшего оружия и цикл `while Script.AutoGrabGun` |
| `f6()` / `f11()` | — | Чтение уровня/профиля/баланса MM2 через `InvokeServer` под `pcall` |
| `f8()` | — | Webhook-уведомление: только при `Script.WebhookEnabled` и непустом `Script.SavedWebhookUrl`, один раз |
| `startFly()` / `stopFly()` | — | Полёт (PC и мобильные), W/A/S/D/Space/LeftShift |
| `f27()` / `f26()` / `_G.SetFullBright(p15)` | `p15: boolean` | Полный свет и возврат сохранённых `_G.NormalLightingSettings` |
| `f1(p1)` / `f2()` | `p1: Model` | CharacterAdded, кэш Humanoid/HRP, поиск `workspace.Lobby` |

**Риски и зависимости.** Аимбот, ESP по ролям и флинг направлены на других игроков; меняются `workspace.Gravity` и `Lighting`. Есть отправка уведомления в Discord-webhook — URL вводит сам пользователь, по умолчанию `SavedWebhookUrl = ""` и `WebhookEnabled = false`. Внешние зависимости: WindUI (mutable release-URL) и `AdvancedUtils.lua` (mutable raw-URL того же репозитория) — не включены и не аудированы.

**Проверка.** Поведенческого макета нет (top-level грузит внешние UI-библиотеки и строит меню): **15 статических проверок** тела в `tests/test_wad_batch2_static.lua` (кейс `mm2`) плюс компиляция Lua 5.1; в манифесте `mock_game_assertions: 0`, и верификатор такой файл без `static_body_assertions` не принимает.

## All Star Tower Defense — входа с правами нет

- Поиск по имени файла дал **23 репозитория** с `ASTD*.lua` и **7** с `All Star Tower Defense*.lua`; лицензия проверена по API у каждого — **ни одной** (`CenteredSniper/Kenzen`, `IsNanTinfem/Krypton`, `search-scripts/CodeSourcers` и остальные).
- Единственный MIT-репозиторий [`jewmin/astd`](https://github.com/jewmin/astd) — открытый исходник китайского UI-помощника (модули `activity.lua`, `equip.lua`, `training.lua` по 2–14 КБ), то есть `(src)`, а новые `(src)` сейчас не добавляются.
- Поиск кода по сочетанию «заголовок обфускатора + название игры» даёт 0 совпадений: индекс GitHub не покрывает крупные минифицированные файлы, так что это **не** доказательство отсутствия входов — но и права на публикацию найденного отсутствуют.

Итог: счётчик по ASTD не менялся, опубликованы прежние [Assasine03 Autofarm (partial)](../dobf%20scripts%201.0/All%20Star%20Tower%20Defense%20-%20Assasine03%20Autofarm%20%28partial%29.lua) и `KarmaPanda (src)`.

## Bloxstrike — лицензированный вход есть, но это дубликат

Проверено **18 репозиториев** с `Bloxstrike*.lua` — все без лицензии (`ArtChivegroup/Roblox`, `jiajia67-code/BloxStrike`, `KScroom/universal-duels`, `d0inks/moon.lua`, `Slided/laughing-octo-train` и др.).

Лицензированные находки:

- [`orjinalwasexd/bloxstrike@7f1babe4`](https://github.com/orjinalwasexd/bloxstrike) — **MIT** («onyxinc»), `bloxstrike.lua` 231 625 байт, WAD v1.0.0, SHA-256 входа `5f8a56ddbda201521d57d71f0823608c01b03f896631e8c934a514b99f04b05a`. Раскрывается полностью и детерминированно: **37 203 байта / 1 269 строк**, SHA-256 `121cc122d2cca52a21139ab8aa63da9c8c0f293b7a277487505b7d355feb82ca`. **Не опубликовано:** это другая сборка уже имеющегося в каталоге [Bloxstrike - Hotline UI](../dobf%20scripts%201.0/Bloxstrike%20-%20Hotline%20UI.lua) (тело 37 042 байта, `d76c2de4f311246a38ffcb924efc8d40586660e64aef569ccc3850aaa7d8c9a5`) — тот же заголовок `"HOTLINE"`, та же подпись автора `"ony - orjinalwase"`, тот же набор ESP/Silent. Новое в этой сборке — стартовая загрузка телеметрии `loadstring(game:HttpGet("https://rscripts.net/api/telemetry/client.lua?s=6a93a507d8beafc771722214"))()`, которой в опубликованной версии нет; наш гейт классифицировал тело как `loader_only` именно из-за неё. Публиковать почти копию ради счётчика не стали.
- [`InfinitelyMNDEV/Tetoware`](https://github.com/InfinitelyMNDEV/Tetoware) (MIT) — `SupportedGames/Bloxstrike/Bloxstrike_verision2.3.lua` и три более ранние версии: **открытый исходник** (в шапке заявлен GNU GPL при MIT-файле LICENSE), то есть `(src)`.
- `xqmt/Bloxstrike-Memesense` (MIT) — уже опубликован как `Bloxstrike - Memesense (src)`; `Infinite-Unknown/CaseBot_Bloxstrike` (MIT) — Python-бот без Lua.

## Другие проверенные входы из того же MIT-репозитория

- `Tower Of Hell.lua` (82 289 байт) → 8 882 байта / 370 строк: **loader** с гейтом подписки и внешней загрузкой, гейт отклонил (`loader_only` + висячий `goto L14560661`).
- `Additional/t1.lua` (495 633 байт) → 56 133 байта / 2 316 строк, «SKRR HUB»: **не опубликовано**, тело грузит внешний модуль обхода античита (`[SKRR] AC Bypass Module Loaded`).
- `io-obfuscated.lua`, `Additional/59e9d2b153e52232.lua`, `Additional/lunarsectest.lua`, `Additional/Cobalt.luau` — другие обфускаторы (string.unpack-VM, «obfuscated @ discord.gg/25ms», Lunar-константы) и инструмент разработчика; инструмента для них нет, игровой код не публиковался.

**Контроль:** **98** Python-тестов (пропусков нет), [`verify_results.py`](../scripts/verify_results.py) — **67** опубликованных игровых файлов и 9 манифестов, [`verify_sources.py`](../scripts/verify_sources.py) — 40 архивов, `node --test` — 1 тест, `git diff --check` чисто; Lua-тест тела MM2 проходит на собранном Lua 5.1.1. Сырые входы, выводы декодера и клоны остались в игнорируемом `local-results/`.
