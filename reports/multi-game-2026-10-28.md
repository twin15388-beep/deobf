# Мульти-игровой проход: GPO, King Legacy, Illegal Soccer, BloxStrike, YBA — 28 октября 2026

Запрос: найти скрипты по **Grand Piece Online**, **King Legacy**, **Illegal Soccer**, **BloxStrike**, **Your Bizarre Adventure** и другим популярным играм, деобфусцировать их, кратко описать результат и ошибки, а также посмотреть, что нового можно скачать для деобфускации.

Коротко: **новых игровых `.lua` в каталог не добавлено** (счётчик прежний — **67 = 32 + 35 `(src)`**), потому что ни один защищённый вход из этого прохода не дал подтверждённой игровой логики. Зато впервые **полностью прочитан Mafy Obfuscator** (код → [`scripts/mafy_decode.py`](../scripts/mafy_decode.py)), **поведенчески классифицированы три входа MoonSec V3/V2 и один Luraph 13.4.5**, а по открытым (незащищённым) репозиториям собран ответ, где вообще лежит логика этих игр. Pastefy и API для получения скриптов не использовались, ключи не подбирались, чужой top-level не исполнялся вне песочницы, Roblox не запускался. Все образцы остались в игнорируемом `local-results/scan/`.

## Как искали

- GitHub search по метаданным: `gpo`, `grand piece online`, `king legacy`, `illegal soccer`, `bloxstrike`, `yba`, `your bizarre adventure` + варианты «hub/script/mit» — 197 кандидатов, отфильтровано по размеру и лицензии, `git clone --depth 1` для ~50 репозиториев (один клон упал: `angel-elpepes492-lgtm/BloxStrike-2-Remecide`).
- Сигнатурный скан всех файлов ≥3 КБ (WAD, MoonSec V2/V3, Luraph+версия, Mafy, Prometheus, IronBrew, Clyde, Wynfuscate, LuaObfuscator, 77fuscator, Luast, Umbra, Koralys, LuaGuard, Hercules): **1059 файлов открытого кода** и **8 защищённых**. Всё остальное — читаемый Lua.
- Дополнительно: `search/code` по баннерам обфускаторов даёт 0 совпадений (индекс не покрывает крупные минифицированные файлы) — это не доказательство отсутствия входов, каналом разведки он не работает.

## Результаты деобфускации (8 защищённых входов)

| Игра | Вход | Защита | Итог |
| --- | --- | --- | --- |
| BloxStrike | `hametsumer20-del/Annihilator-Hub/Mafy`, 11 006 Б, `77e785e7…ace87c` | Mafy | **Раскрыт полностью** статически (без запуска). Полезной нагрузки нет: интро-`ScreenGui` «By .Mafy» с благодарностью. Декодер [`scripts/mafy_decode.py`](../scripts/mafy_decode.py), воспроизводит прежний ручной разбор побайтово (sha256 `9819ee49…5644`) |
| (ComboHub) | `PH4NT0MGTX/ComboHub/message.txt`, 70 793 Б, `670991dd…722922` | Luraph 13.4.5 | **Тролль, а не хаб.** Поведенческая трасса: 4 события, единственное действие — `game.Players.LocalPlayer:Kick("You are banned for 99 yr(s),12 mon(s),0 wek(s), 0 day(s), 1 hr(s), 1 min(s), and 37 sec(s)")`. Строка бана лежит в файле открытым текстом; логики нет. Трасса детерминирована (два прогона → `45907c07…c74f`) |
| (CuHub) | `Stephen102/CuHub-Repost/main.lua`, 561 196 Б, `0e9e7d48…eb5d5` | Luraph 13.6.6 | **Не раскрыт.** Инструмент Luraph v15.1 не распознаёт версию («unknown obfuscator»), трасса стопорится на `clonefunction(...)` и не двигается 20 минут. Статически в файле нет ни одной читаемой строки кроме баннера — все литералы в шифрованных блобах |
| BloxStrike | `Nickk-GG/BloxStrike-NickHub-New-Gen/sc.lua`, 488 134 Б, `ca4c5741…32adba` | Luraph 14.8 | **Не раскрыт.** Тот же инструмент версию не признаёт; Luau-трассер проходит бутстрап VM (`UDim/UDim2/Vector3.new`) и зависает в слое типов. Литералов в открытом виде нет |
| King Legacy | `Kchan420/KingLegacyScript`, 156 861 Б, `9d664238…f75c23` | MoonSec V3 | **Оболочка нерабочая.** Payload выполняется до конца в песочнице и делает ровно один вызов несуществующего глобала `MkZnyHZJvsgBHGW(function…)`; игровых обращений нет — файл не жилец (обрезок/заглушка) |
| YBA | `goofyahh-hub/Your-Bizarre-Adventure/Main`, 53 504 Б, `b4a60d8d…6ef16` | MoonSec V3 | **Частично:** payload — хаб на **KaVo UI**: `game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua")` + `loadstring`. Дальше всё уходит в загружаемый модуль, своей игровой логики в наблюдаемом потоке нет |
| (ESP-Library) | `Its-LALOL/LALOL-Hub/ESP-Library/script`, 48 471 Б, `2df5d216…5daa` | MoonSec V3 (Federal#9999) | **Тот же дефект, что у King Legacy:** один вызов несуществующего `xgAGbZOQanLggQy` и завершение |
| **GPO** | `Frescript/-2X-FREE-Grand-Piece-Online/Wave hub -- Funnyx`, 833 167 Б, `47fcb1b8…388d5` | **MoonSec V2** (в шапке `Protected_by_MoonSecV2`, Discord `gQEH2uZxUk`), не V3, как считалось раньше | **Не раскрыт.** Песочница падает на 4-й строке (`arithmetic on nil`), т.е. VM требует специфичного окружения исполнения; лицензированного девиртуализатора MoonSec V2 по-прежнему нет |

Метод для MoonSec и Luraph 13.4.5 — новый офлайн-трассер [`scripts/luau_behaviour_trace.py`](../scripts/luau_behaviour_trace.py): он заворачивает образец в самодостаточный Luau-драйвер (штатный `luau` CLI не имеет `io`/`arg`), подменяет `game`/`workspace`/сервисы заглушками с логированием `Connect`/индексации/присваивания/вызова, отвечает на `HttpGet` пустым модулем и даёт песочнице **записываемые** `getfenv(0)`/`_G`/`shared` (глобалы самого CLI только для чтения). Сеть не используется, проверки лицензий не обходятся.

## Что нашлось в открытом виде (для ориентира, не как результат)

- **Grand Piece Online:** `ModerkaScripts/Aztup-Hub-V3` → `files/games/GrandPieceOnline/main.lua` (68,5 КБ: `TeleportService`, острова, `Chat Logger`, копирование ника/ID, отчёт на игрока, «Script will not run in lobby») + `PerfectBlock.lua` (8,8 КБ: автопарирование по ID анимации, список игнора); `TheGreatSageThatEqualToHeaven/GpoHub` — `Kaitun`/`FishKaitun` (43 КБ каждый, tween-телепорт-фарм «Ферма Pelи → Buy Rifle → Fishman Island», Discord-webhook со статистикой); `Spade324/SpadesHub` (38 КБ, «Nav v2.1», меню Rayfield, правки F1/F2); `NRSB26/gpo-script` (43 КБ, «Venixce»); `Nerotish/gpo-hub-rework`.
- **BloxStrike:** полный **клиент игры** в `RobloxGameTesting/BloxStrike` (Controllers/Components/Visibility/Database: `AimAssistController`, `WeaponComponent`, `PVS*`, `Terrain`) и дамп `graveyard-love/bloxstrike-dump` (`bloxstrike@1.0.1/ReplicatedStorage/...`); читы: `fbdfbfvbfgf3432/BloxStrike` («PASTEHUB full build», трассеры/ESP/GRENADE ESP, 199 КБ), `Syynn/Bloxstrike` («CLIENT 1.6.10 / Matcha», 183 КБ, `KontraESP`, RCS), `Unwalker1337/shitaro-bloxstrike-crack` (873 КБ **чужой** девирт-дамп с `X-Shitaro-Token`), `Emirhangjf2/...crack` (347 КБ), `llimon32-vibecode` (Neverpaste BS V2, 4 варианта), `Rostik22803/Ocel-hub` (182 КБ), `spo1dev/BloxStrike-sp1` (скин-ченджер).
- **Illegal Soccer:** `Pitaya-real/Illegal-Soccer` (22,5 КБ, «Smart GK System», грузит NovaUI с raw.githubusercontent), `marciofernandesemanuel123-gif/IllegalSoccerHub` («V3.4», AUTO PLAY/AUTO SAVE/AutoSprint, P — реальный курсор), `Aquraja/illegal-soccer-hub` (INFINITE STAMINA, SPEED CONTROL).
- **King Legacy:** `WHITEDRAGONx/WHITE-HUB-Legacy` (33,7 КБ, телепорты к предметам: Rokakaka, Ancient Scroll, Lucky Arrow…, конфиг `WhiteHubConfig.json` через `HttpService`), `XproDevApril/KingLegacyHUB` (5,7 КБ), `itz-axiom/Zen-hub-King-legacy`, `Featurestarlight833` и `abdulqadi6633` (GPL-3.0, но README/архив).
- **YBA:** `acount20061-lgtm/YBA-Hub` (30 КБ, «Azero Hub»: стенды Star Platinum/The World/Killer Queen…, предметы, рибкейджи), `KieurOo/YbaScript` (21,7 КБ, автофарм: TP to items, авто-продажа), `Doge8/YBA-Script` (9,7 КБ, «Dark Ice UI»), `Vuffi2007/YBA-Teleport-to-Items-GUI` (8 КБ).
- Попутно: `bocaj111004/Abysall` (Doors), `Commandcracker/Magma-Hub` (8 игр по PlaceId), `Its-LALOL/LALOL-Hub/Backdoor-Scanner` (47 КБ, открытый сканер).

## Ошибки и что не обошли

1. **Luraph 13.6.6 и 14.8 (два входа, 1 МБ суммарно)** — не раскрыты. `ServerDeadd/Luraph-v15.1` и `ludicious-claw/Luraph-V15-1` версию не детектируют; трасса на 14.8 доходит до инициализации типов VM и встаёт, на 13.6.6 — до `clonefunction`. Строк в открытом виде нет, поэтому даже «краткая выжимка» невозможна без девиртуализации.
2. **Luraph 13.4.5** — трасса дала результат, но это тролль (`Kick` с фальшивым баном). Инструмент v15.1 всё равно не признал версию — работал только режим «behaviour trace».
3. **MoonSec V3 (King Legacy, LALOL)** — оболочка снимается исполнением, но payload вызывает неопределённый глобал: файлы в репозиториях нерабочие. Девиртуализатор `tupsutumppu/MoonsecDeobfuscator` (GPL-3.0) в этой среде **не собирается: нет .NET**.
4. **MoonSec V2 (GPO Wave hub, 833 КБ)** — падение в песочнице на 4-й строке; лицензированного девиртуализатора V2 на GitHub нет (ранее проверено), а сам файл — один минифицированный литерал.
5. **Mafy** — решён, но результат пустой по смыслу (интро-GUI), в каталог не идёт.
6. **Права.** У всех перечисленных репозиториев, кроме GPL-3.0 `Featurestarlight833/king-legacy-script-hub` и `abdulqadi6633/king-legacy-desktop-script-hub` (там только README/архив) и MIT-репозиториев без кода, лицензии нет. `RobloxGameTesting/BloxStrike` и `graveyard-love/bloxstrike-dump` — републикация клиента игры, прав на перераспространение нет. Поэтому ничего не скопировано в `dobf scripts 1.0/`.
7. **Отдельно про «чужой деобфусцированный» файл:** `Unwalker1337/shitaro-bloxstrike-crack/bloxstrike.lua` (873 КБ) — не наш результат и не проверенная пара «вход → выход»; в отчёте он указан только как факт существования.

## Что можно скачать нового (инструменты)

- [`caomod2077/Deobfuscator-Luraph-V15`](https://github.com/caomod2077/Deobfuscator-Luraph-V15) — MIT, Luraph v15 (175★, обновлён 4 октября 2026), Node 18+ / Python 3.10+; в репозитории только **Windows**-бинари `luau`, поэтому на Linux нужен свой `luau`+`luau-ast`. По сути та же линейка, что уже в `sources/`.
- [`mehCake/Luraph-V15.1-V15-Deobfuscator`](https://github.com/mehCake/Luraph-V15.1-V15-Deobfuscator) — **без лицензии**, кода в репозитории почти нет: брать нельзя.
- [`tupsutumppu/MoonsecDeobfuscator`](https://github.com/tupsutumppu/MoonsecDeobfuscator) — GPL-3.0, MoonSec V3 → Lua 5.1 байткод; **нужен .NET** (`dotnet build -c Release`). Уже лежит в `sources/`.
- [`luau.site`](https://luau.site/deobfuscators/) — индекс деобфускаторов со статусами: Prometheus/MoonSec-инструменты помечены «Stale», MoonSec V3 поднимается только GPL-инструментом, WeAreDevs — «unrated». Полезен как трекер новых появлений.
- `tr4ash/moonsec-v3-deobfuscator` — платный Discord-сервис, не инструмент; `901wia/moonscv3-deobfuscator-discord-bot` требует Windows + `MoonsecDeobfuscator.exe`.
- **Сделано локально (не в Git):** собраны **Luau 0.744 CLI и `luau-ast`** из тега `0.744` (Makefile апстрима не содержит цели `luau-ast` — она добавлена локально), на них заработали Luraph-инструменты и наш трассер. Сборка занимает ~65 с и не требует CMake. Бинарь `luau` пропатчен `fflush(stdout)` в `luaB_print`, иначе трасса теряется при жёстком таймауте.

## Проверки

`python3 -m unittest discover -s tests -p 'test_*.py'` — 120 тестов, включая новые [`tests/test_mafy_decode.py`](../tests/test_mafy_decode.py) (6) и [`tests/test_luau_behaviour_trace.py`](../tests/test_luau_behaviour_trace.py) (6); `python3 scripts/verify_results.py` (67 = 32 + 35); `python3 scripts/verify_sources.py`; `node --test tests/test_psu_fixed_calls.mjs`; `git diff --check`. Синтаксис: выход Mafy-декодера проверен `lua5.1` (`check_syntax.lua` → OK). Roblox не тестировался; эквивалентность защищённых VM не доказана.
