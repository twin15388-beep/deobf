# Проход 2: GPO-хаб из MoonSec V2, четыре WAD-входа и частичный Luraph 14.8 — 28 октября 2026

Продолжение [первого прохода](multi-game-2026-10-28.md). В этот раз удалось **снять защиту с пяти входов**, которые раньше не поддавались, и частично разобрать шестой. Каталог [`dobf scripts 1.0/`](../dobf%20scripts%201.0/README.md) **не менялся: 67 = 32 + 35 `(src)`** — ни у одного из новых входов нет лицензии, разрешающей перераспространение. Pastefy и API для получения скриптов не использовались, Roblox не запускался, чужой top-level не исполнялся.

## Главное: GPO Wave hub из MoonSec V2 поднят целиком

| Поле | Значение |
| --- | --- |
| Вход | `Frescript/-2X-FREE-Grand-Piece-Online` → `Wave hub -- Funnyx`, 833 167 Б, SHA-256 `47fcb1b8ec6d773a0c7ca1b0a1030cc9aef9a689d49d9df6678c6e83f76388d5` |
| Защита | **MoonSec V2** (шапка `_, Protected_by_MoonSecV2, Discord = 'discord.gq/gQEH2uZxUk'`) — в первом проходе версия была определена неверно |
| Метод | новый статический лифтер MoonSec V2 (`neosnappp/moonsec-v2-deobfuscator`, Python, без сети, без `eval`/`exec` над входом) — 29 с на файл |
| Выход | 1 015 268 Б, **23 872 строки**, SHA-256 `281f3da82e197d98d28cf044db731eb91767b5a975cfd0ffd7476d486d8db67b`; два прогона дают побайтово один файл |
| Аудит | [`scripts/check_decoder_output.py`](../scripts/check_decoder_output.py) → `game_code`, `workspace=6`, 23 872 строки |
| Привязка к игре | в коде прямая проверка `game.PlaceId == 1730877806` (PlaceId Grand Piece Online) |
| Компиляция | 354 `function`, 6 944 `local`; `luau-compile --text` упирается в **лимит Luau «200 локальных регистров»** на строке 8 147 — это ограничение компилятора на один кадр, а не синтаксическая ошибка (тот же эффект уже был у `Blue Lock Rivals`) |

**Что внутри** (имена — из самого выхода, не переименованы составителем):

- окно «Funny x hub - Grand Piece Online», вкладки `Genaral`, `Mise Function`, `Islands` на UI-библиотеке **XeNonUi** (`raw.githubusercontent.com/naypramx/Ui__Project/Script/XeNonUi`);
- `AUTO FARM`: цикл поиска мобов, `Hitbox`/`FindNearest`, телепорт-твин к цели, авто-респавн, режимы `FarmMode`;
- `Stats Gun Mastery`: `stats:FireServer("GunMastery", nil, 1)` в цикле;
- `Auto Buso Quest` / `Auto Buso Haki`: `haki:FireServer("Buso")`, `quest:InvokeServer(...)`, скиллы `Party Table Kick Course`, `Rapid Slashes` через `skill:InvokeServer`;
- `Settings Farm`, `Auto Farm Beli 300`, `ShipFarm` (фарм корабля, `Set Ship Farm Position Complete`);
- телепорты по островам: Town of Beginnings, Shell Town, Roca Island, Orange Town, Zou Island, Colloseum, Fort F1, Marine Base G-1, Gravito Fort, Fishman Cave, Reverse Mountain, Arlong, Coco Island, Sphinx Island, Land of the Sky, Restaurant Baratie;
- утилиты: `BOOST FPS` (внешний модуль `xlostpexz/FPSBoost/main/FPSBoost`), `No Drown`, `Water No Damage`, `Walk on Water`, `No Fall Damage`, `Dash No Stamina`, `Anti AFK`, `NameEsp` (BillboardGui), `geppo`, `Blackout`, `InvisSandd`;
- остаточные неразобранные константы: **224** литерала вида `"\113\038\246..."` (менифицированные строки, которые лифтер не раскрыл) — поэтому выход честно считается **частичным**: структура и большинство имён восстановлены, часть строковых ключей осталась в экранированном виде.

## Четыре входа WAD v1.0.0 раскрыты закреплённым декодером

Все четыре нашлись в новых клонах (поиск по заголовку `wearedevs.net/obfuscator`) и декодированы закреплённым `prostone4/Prometheus-Deobfuscator@6ee3291e` с `--force`:

| Игра | Вход | Размер | SHA-256 входа | Результат |
| --- | --- | --- | --- | --- |
| **BloxStrike** | `slandermeuntildeath/bloxstrike5x` → `bloxstrike5x` | 535 409 Б | `c47864b721803f96…31170d` | **2 941 строка**, `48b43b6e0353d664…ef6b11c`, `luau-compile` **OK** |
| **YBA** | `KutuBimba/YBAkeyless` → `kryakbykutubimba` | 812 929 Б | `e1d7ae31f55786cf…0844edf` | **4 167 строк**, `98863917351a2942…454b16ad`, 1 висячий `goto` → не компилируется |
| **YBA** | `krekde92-glitch/YBA-Roblox` → `AUTO PB HWID.lua` | 178 045 Б | `fe3d74292810e999…6ef16` | **591 строка**, `3ea42a828a1a7172…1d103`, `luau-compile` **OK** |
| **YBA** | `tiger098145/yba_script` → `main.lua` | 108 440 Б | `beae1cd563ca5ea8…a96f8` | **706 строк**, `bf9f10a0e3dd040d…bd223d`, 1 висячий `goto` |

Содержимое (без копирования больших фрагментов — входы без лицензии):

- **BloxStrike → «FiveXHub»**: ESP с рамкой 5,5×2,8 студов и обновлением каждые 0,0167 с (имя, HP, дистанция, chams с заливкой 0,5/контуром 0,1, трассеры толщиной 1 и прозрачностью 0,8 от `Bottom`), проверка команды, прицеливание по `ReplicatedStorage.Client.Events.AimTarget.OnClientEvent` (окно цели 0,75 с), патч «косметических» таблиц (`[5X COSMETIC] Patched %d cosmetic tables`), универсальный вызов remotes из `Events` (`FireServer`/`InvokeServer`), ввод через `VirtualUser`.
- **YBA → «KutuBimba HUB»** (Rayfield с `sirius.menu`): Auto Farm, Auto Buy Lucky Arrow (от 75k), Auto Sell, Auto Server Hop, ESP игроков и предметов, Fullbright, свой FOV, Fly, NoClip, Infinity Dash, Stand Pilot, «Stand Sticker»-троллинг, браузер серверов со «Smart Join». Remotes: `PurchaseShopItem {ItemName = "1x Lucky Arrow"}`, `ToggleStand`, `EndDialogue`. Есть свой key-system с HWID (`KutuBimba_Key`).
- **YBA → «AutoPB»**: автоблок по цели с подсветкой, remotes `StartBlocking`/`StopBlocking`, HWID-гейт («ACCESS DENIED», «Copy HWID»).
- **YBA → `tiger098145`**: скупка Lucky Arrow у NPC «Suno the Arrowsmith», телепорт к предметам (Rokakaka, Ancient Scroll, Stone Mask, Diamond, Quiver…), `LearnSkill {Skill = "Worthiness", SkillTreeType = "Character"}`.

Про **висячие `goto`**: это уже описанный дефект закреплённого декодера ([разбор](decoder-goto-defect-2026-10-23.md)) — `goto LNNN` без метки. На двух YBA-файлах он один на файл, поэтому они остаются непрошедшими `luau-compile`; узкую правку не делали, чтобы не выдавать догадку за восстановленный код.

## Luraph 14.8 (BloxStrike NickHub) — частичное восстановление

| Поле | Значение |
| --- | --- |
| Вход | `Nickk-GG/BloxStrike-NickHub-New-Gen` → `sc.lua`, 488 134 Б, `ca4c574178b1d74d…d32adba` |
| Инструмент | [`caomod2077/Deobfuscator-Luraph-V15`](https://github.com/caomod2077/Deobfuscator-Luraph-V15) (MIT, уже в `sources/`), детект `luraph_v14` с уверенностью **1.00**, `luau`/`luau-ast` собраны локально |
| Ход | round 1 — 1 функция, 43 константы; round 2 — **21 функция**, 2 нелифченных блока, 71 с |
| Итог | полный лифт **отвергнут самим инструментом** («still Luraph VM/bootstrap scaffolding»), вместо него — поведенческий фрагмент 39 строк + дамп прототипов `.protos.json` (966 hex-констант, из них **628** читаемых строк) |

Что удалось прочитать из констант: это **не хаб, а ключевой шлюз** `NickHub Lite` для BloxStrike —

- `Key System`, `Enter your key to continue.`, `Enter Key...`, кнопки `GET KEY`/`VERIFY`;
- файл лицензии `NickHub_Lite_BS.key`, имя `NickHub_Lite_Bloxstrike_Key`;
- HWID через `gethwid()`, запросы к `https://api.platoboost.app` и `https://api.platoboost.net` (`/public/connectivity`);
- проверка игры: `Wrong Game! Use in BloxStrike.`, `TargetGameIDs`, `GameId`, `PlaceId`;
- `gethui()`, `NickHub_Notifs` (тост с твинами 0,3 с), ASCII-баннер `NICKHUB`.

То есть игровая логика выдаётся сервером Platoboost после валидного ключа — локально её нет. Приватные ключи/HWID не подбирались, запросы к серверу не выполнялись. Поведение совпадает с прошлой находкой [Symbiote Key System](symbiote-bloxstrike-2026-10-25.md).

## Что по-прежнему не берётся

| Вход | Защита | Почему |
| --- | --- | --- |
| `Stephen102/CuHub_Repost/main.lua`, 561 196 Б, `0e9e7d48…` | Luraph **13.6.6** | инструменты v15.1/v15 детектируют как `generic`; наш трассер в новой версии (с дампом `string.char`) видит, как VM расшифровывает **свой байткод** (сотни килобайт), и не доходит до полезной нагрузки за 200 с; декомпилятора Luraph 13 нет |
| `PH4NT0MGTX/ComboHub/message.txt`, 70 793 Б, `670991dd…` | Luraph 13.4.5 | payload — тролль: единственное действие `LocalPlayer:Kick("You are banned for 99 yr(s)…")`, игровой логики нет (подтверждено повторно) |
| `Kchan420/KingLegacyScript`, 156 861 Б | MoonSec V3 | лифтер MoonSec V2 выдаёт только каркас: **0 читаемых строк**, 0 remotes, строковые блобы остались зашифрованными; поведенчески payload вызывает несуществующий глобал, а переданное ему тело — пустая функция (проверено флагом `--invoke-missing`) |
| `goofyahh-hub/Your-Bizarre-Adventure/Main`, 53 504 Б | MoonSec V3 | то же: каркас без строк; поведение — `HttpGet` на KaVo UI и больше ничего |
| `Its-LALOL/LALOL-Hub/ESP-Library/script`, 48 471 Б | MoonSec V3 | тот же мёртвый стаб |
| `batch3/…` BloxStrike 14.8 «не хаб» | — | см. выше: ключевой шлюз, серверная выдача |

**Вывод по MoonSec V3:** публичного лифтера по-прежнему нет. Инструмент `tupsutumppu/MoonsecDeobfuscator` (GPL-3.0, C#) в этой среде не собирается — **нет .NET**; всё, что даёт Python-лифтер V2 на V3-файлах, — это каркас диспетчера с зашифрованными блоками.

## Инструменты: что нового и что проверено

| Инструмент | Лицензия | Проверено здесь |
| --- | --- | --- |
| [`neosnappp/moonsec-v2-deobfuscator`](https://github.com/neosnappp/moonsec-v2-deobfuscator) | **нет** (только локальное использование, в `sources/` не добавлен) | **работает**: GPO 833 КБ → 23 872 строки за 29 с; ещё 3 из 3 MoonSec V2-образцов (32 КБ, 183 КБ, 1 МБ) тоже дали читаемый выход — от 85 строк лоадера до 19 931 строки (всего 4 из 4). На V3 — только каркас |
| [`caomod2077/Deobfuscator-Luraph-V15`](https://github.com/caomod2077/Deobfuscator-Luraph-V15) | MIT | детект v14.8 = 1.00, devirt 21 функция, полный лифт отвергнут, но **дамп констант** (`.protos.json` с `--debug`) отдал 628 строк |
| [`larpcorrupt/luraph-v15-v14.x-deobfuscator`](https://github.com/larpcorrupt/luraph-v15-v14.x-deobfuscator) | нет | по структуре — тот же движок с модулями `luraph_v14_7/14_8/14_9`, но упакован в `.rar` и без лицензии → не берём |
| [`mehCake/Luraph-V15.1-V15-Deobfuscator`](https://github.com/mehCake/Luraph-V15.1-V15-Deobfuscator) | нет | 6,6 МБ, но кода нет: демо-видео + один вход/выход (`1/gwigren45626.lua` → `1/out.lua`) |
| [`ServerDeadd/Luraph-v15.1-Deobfuscator`](https://github.com/ServerDeadd/Luraph-v15.1-Deobfuscator) | MIT | уже в `sources/`; v13/v14 не распознаёт вовсе |
| [`tumbalakbseu2-oss/Luraph_v15-deobfuscator-build-with-rust`](https://github.com/tumbalakbseu2-oss/Luraph_v15-deobfuscator-build-with-rust) | MIT | Rust; в этой среде нет Cargo → не собирали |
| [`luau.site/deobfuscators/`](https://luau.site/deobfuscators/) | — | индекс со статусами: Prometheus/MoonSec-инструменты «Stale», MoonSec V3 — только GPL-C#, WeAreDevs «unrated» |

Окружение, которое понадобилось: **Lua 5.1** (`scripts/prepare_lua51.py`) для проверки Mafy-выхода, **Luau 0.744** (`luau` + `luau-compile`, собраны из `codeload` через `make`, ~65 с, CMake не нужен) для проверки выходов WAD/лифтера, **cmake из PyPI** для `scripts/prepare_luau.py` (закреплённый 0.739 в этой ревизии апстрима не собирается: скрипт ждёт `CLI/Compile.cpp`, а файл уже переехал в `CLI/src/`).

## Новые скрипты в репозитории

- [`scripts/luau_behaviour_trace.py`](../scripts/luau_behaviour_trace.py) расширен: `--dump-strings` перехватывает `string.char`/`table.concat` и восстанавливает расшифрованную таблицу строк, `--invoke-missing` вызывает переданное тело у несуществующего глобала (так доказано, что MoonSec V3-стабы пустые), `--extract` превращает трассу в список строк. Плюс ~20 executor/datatype-заглушек, которые не дают VM зависнуть на `clonefunction`/`islclosure`.
- [`scripts/scan_protected_inputs.py`](../scripts/scan_protected_inputs.py) — триаж: обход дерева, определение семейства и версии по шапке, размер, SHA-256, TSV/JSON. Именно им найдены четыре WAD-входа в новых клонах.
- Тестов теперь **130** (`python3 -m unittest discover -s tests -p 'test_*.py'`).

## Проверки

```
python3 -m unittest discover -s tests -p 'test_*.py'   # 130 OK (2 skip без интерпретаторов)
python3 scripts/verify_results.py                       # 67 = 32 + 35 (src)
python3 scripts/verify_sources.py                       # 46 архив
node --test tests/test_psu_fixed_calls.mjs
git diff --check
```

Roblox не тестировался, эквивалентность защищённым VM не доказана, выходы MoonSec V2 и Luraph 14.8 честно помечены как частичные (224 экранированных литерала в GPO, 21 из ~∞ функций в Luraph-лифте).
