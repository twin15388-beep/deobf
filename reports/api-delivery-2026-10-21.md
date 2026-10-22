# API-зависимая доставка и пять запрошенных игр — 21 октября 2026

**Итог этого прохода: новых игровых `.lua` не опубликовано.** Каталог остаётся на **61 файле: 26 восстановлений/частичных результатов и 35 старых `(src)`**. Ни один просмотренный кандидат для Lone Survival, Trident Survival, Slayers 2, GPO и King Legacy не прошёл одновременно условия: защищённый *игровой* вход с подтверждёнными правами, содержательное восстановление игровых функций и проверка результата. Название плейса, готовый чужой «deobfuscated» файл, открытый исходник, SDK, UI или loader не засчитываются. Pastefy и API для получения скриптов **не использовались**: метаданные поиска GitHub служили только для отбора; содержимое доступных репозиториев проверялось локально после `git clone`.

## Что показал поиск

| Игра | Проверенные закреплённые кандидаты и вывод |
| --- | --- |
| **Lone Survival** | В [SWIMHUBISWIMMING/-@dfef970](https://github.com/SWIMHUBISWIMMING/-/tree/dfef9707a4dfbaa649a4a59490b0755e96836583) есть защищённый `loader` (**171 146 байт**, SHA-256 `ee68249d024fcb046651cb5af503b8f5e2c113f9d857f651d0bc33748b366dc1`) с пометкой `uwubfuscator ~~ custom vm ~~ ib2 fork` и GPL-3.0 в корне. Наш **статический** разбор снял только упаковку VM и константы: 29 046 байт LZW → 28 420 байт VM, **19 прототипов / 2 806 инструкций / 435 констант / 343 строк**. В строковых константах `HttpGet`: 4, `swimhub`: 12, `Lone Survival`/`lonesurvival`/`workspace`/`FireServer`: **0**. Среди констант есть адрес динамической загрузки `swimhub` из того же репозитория. Это **не доказательство отсутствия всей игровой логики**, но защищённый файл выглядит как UI/доставка, а не автономный игровой код: не публикуем его как «восстановленную Lone Survival». В том же репозитории `lonesurvival.lua` (**52 951 байт**, SHA-256 `d62c2a95edf01693db7be8904b45969fb5f43a46aedc1053d03af1ff5347c4c6`) уже **читаемый исходник**, а новые `(src)` пользователь просил не добавлять. Альтернативные защищённые [Lennox2010/LONE-SURVIVAL-LEGACY@8e3cdaf](https://github.com/Lennox2010/LONE-SURVIVAL-LEGACY/tree/8e3cdafdd7194aba95c9fe3f6bc7bf56f6af1d7f) (`.lua`, 66 899 байт) и [ScriptSkiddie69/vortexlol](https://github.com/ScriptSkiddie69/vortexlol) (`lone survival.lua`, 77fuscator, 134 230 байт) не имеют обнаруженной LICENSE. |
| **Trident Survival** | Защищённые [FAZMA-IKU/Trident-Survival-V4@09a338c](https://github.com/FAZMA-IKU/Trident-Survival-V4/tree/09a338c90b4ebc368bc9f11cf2f7fc91afa60147) (87 376 байт), [WaffleManTheGreat/DirtyFork@417e64c](https://github.com/WaffleManTheGreat/DirtyFork/tree/417e64caa2fa8ec62e812c845474eac3e55b0f74) (~177 КБ; upstream прямо пишет, что прежняя версия patched) и DirtySpoon не содержат обнаруженной лицензии на воспроизведение. Найденный [Babyhamsta/RBLX_Scripts](https://github.com/Babyhamsta/RBLX_Scripts) `Trident Survival/Main.lua` — читаемый код с предупреждением «script has been patched», не восстановление защиты. [PeakWhale/trident](https://github.com/PeakWhale/trident) — другое ПО, несмотря на совпадение имени/MIT. |
| **Slayers 2** | [trustedscript/tiki-script@0bf6b1d](https://github.com/trustedscript/tiki-script/tree/0bf6b1d8d571f0a804e0a8934d22ce135f51a694) заявляет уже «deobfuscated» `main.lua` (~1,0 МБ); проверены оба текстовых блока: `__uiSource` **152 436 байт**, `__backendSource` **890 554 байта**, они компилируются скриптом во время работы. Сам размер, включая UI, не подтверждает полноту/работу. В клонированном репозитории **нет LICENSE и проверяемой пары с защищённым входом**. [lurexh/Deobfuscate@206367f](https://github.com/lurexh/Deobfuscate/tree/206367f1c97b6fe45f7ebdb2b63d0e1108e3a459) также содержит уже готовый `slayers 2 script.lua` (57 452 байта) под заявленной MIT-лицензией репозитория, но защищённого upstream-входа и его прав для этого файла не установлено. **Ни то ни другое не результат нашей деобфускации.** Найденные файлы Luarmor с названием игры — в основном loader-ы, доступа к серверному телу нет. |
| **Grand Piece Online (GPO)** | [ModerkaScripts/Aztup-Hub-V3@45bcead](https://github.com/ModerkaScripts/Aztup-Hub-V3/tree/45bcead9541ad13c2adc631c1afaecf8bdfc8ed5/files/games/GrandPieceOnline) содержит открытый MIT `main.lua` (68 499 байт), **не новый защищённый вход**; существующие GPO `(src)` и Lunar Hub `(partial)` уже отдельно отражены в каталоге. Иные найденные совпадения MoonSec/GPO относятся к коллекциям без установленной лицензии либо к посторонним хабам/загрузчикам, а не к проверенному новому игровому восстановлению. |
| **King Legacy** | Уже есть ограниченный [`King Legacy - Luxury Core.lua`](../dobf%20scripts%201.0/King%20Legacy%20-%20Luxury%20Core.lua) из предыдущего прохода: **не полный автофарм**. Защищённый кандидат [NPConTop/Chaos-Hub](https://github.com/NPConTop/Chaos-Hub) `Main.lua` найден по сочетанию «King Legacy» и заголовка защиты, но разрешающая LICENSE не установлена. [FTBS2025/king-legacy](https://github.com/FTBS2025/king-legacy) имеет MIT-файл, но в клоне **только README и LICENSE, игрового Lua нет**. |

Карточки тоже просмотрены, но не подменяют вход: [RScripts — Oretachi Slayers 2](https://rscripts.net/script/oretachis-slayers-2-heavily-wip-BSXE) указывает **key required** и 527 байт кода на карточке, а [ScriptBlox — Project Cryptic](https://scriptblox.com/script/Slayers-2-Best-Auto-Farm-All-in-One-(KEYLESS)-229416) перечисляет множество функций, но не даёт там подтверждённой пары «защищённый вход → исходник» с правами на публикацию. Списки фич и метки «keyless/reviewed» **не равны** восстановленному игровому телу; ссылку Pastefy и API для получения кода не использовали.

**Другой инструмент/метод для Lone Survival:** для *точного* опубликованного IB2-fork входа сделан [`scripts/inspect_ib2_fork_constants.py`](../scripts/inspect_ib2_fork_constants.py). Он не подменяет декомпилятор: проверяет сигнатуру сериализатора, ограничивает размер/рекурсию, распаковывает base36-LZW, декодирует XOR-193 типизированные константы и считает вложенные инструкции/прототипы. Чужой код, Roblox, сеть и key-check **не исполняются**. Вывод содержит только хеши/счётчики, **не восстановленный игровой Lua**. Для воспроизведения на закреплённом входе:

```bash
# Вне каталога результатов; скачать ИМЕННО закреплённый коммит.
git clone --depth 1 --filter=blob:none https://github.com/SWIMHUBISWIMMING/-.git local-results/swim-upstream
git -C local-results/swim-upstream fetch origin dfef9707a4dfbaa649a4a59490b0755e96836583
git -C local-results/swim-upstream show dfef9707a4dfbaa649a4a59490b0755e96836583:loader > local-results/swim-loader.lua
python3 scripts/inspect_ib2_fork_constants.py local-results/swim-loader.lua
python3 -m unittest tests.test_ib2_fork_constants
```

`0x251/Prometheus-Deobfuscator@7d0582f` и V2 `@d06f1f5` изучены как альтернативы. Первый в `pol.py` использует Python `eval()` на входных выражениях — **не запускали на непроверенном VM**. CLI V2 требует соседний `Prometheus/src` и ориентирован на AST Prometheus, а не на этот IB2-fork; не выдаём его заявленную поддержку за проверенную. Отдельные попытки SixZensED с MoonSec V2/V3 в [предыдущем отчёте](game-sources-2026-10-21-protected.md) дали невалидный корень и не подтверждённый игровой код. На защищённых входах без права публикации **не публиковали** ни исходники, ни диагностические куски.

## Офлайн-адаптер для Luarmor, Jnkie и похожей доставки

[`scripts/inspect_api_delivery.py`](../scripts/inspect_api_delivery.py) **не обращается к API/сети**. Он распознаёт локальные Lua-загрузчики Luarmor (URL вида `/files/v3/loaders/…`, `/files/v3/l/…`, `lrm_load_script`) и Jnkie (`/sdk/library.lua`, `load_script`), даже когда адрес SDK записан в простую строковую константу и передан переменной. Вывод содержит **тип маршрута, но не URL с идентификатором, ключи или заголовки**. Для сходного сервиса без этих двух доменов можно передать локальный `--capture` напрямую, без привязки к провайдеру.

Если **сам пользователь уже располагает разрешённым локальным HTTP-ответом** с защищённым телом, адаптер может выделить из него Lua-кандидат: рекурсивно распаковать JSON-поля `script`/`data`/`payload` и пр., **только явно помеченный** base64 (JSON/HAR) и **только целиком состоящий из одного вызова** `loadstring('буквальный текст')()` или длинной Lua-строки. Он не выполняет Lua, не подставляет/не проверяет ключ, не имитирует HWID или SDK, не запрашивает серверные файлы и **не деобфусцирует полученный MoonSec/Luraph/IB2 VM**. JSON `KEY_VALID` без тела — ответ авторизации, а не найденный код. Без законного полученного тела серверный исходник получить невозможно; loader/SDK сами по себе не результат.

```bash
# Анализ одного локального загрузчика — без каких-либо сетевых вызовов:
python3 scripts/inspect_api_delivery.py --loader local-results/loader.lua

# Только при наличии собственного разрешённого снимка ответа:
python3 scripts/inspect_api_delivery.py \
  --loader local-results/loader.lua \
  --capture local-results/response.json \
  --out local-results/raw-protected.lua \
  --report local-results/inspection.json

# HAR может содержать cookie/ключи: НЕ загружать его на GitHub!
python3 scripts/inspect_api_delivery.py --har local-results/session.har
# Если подходящих записей несколько, выбрать индекс из обезличенного отчёта:
python3 scripts/inspect_api_delivery.py --har local-results/session.har \
  --response-index 3 --out local-results/raw-protected.lua
python3 -m unittest tests.test_api_delivery
```

`--out` создаёт файл **только по явному запросу**, только для найденного Lua/защищённого тела, разрешает запись внутри репозитория **только в игнорируемый `local-results/`** (или вне репозитория) и не перезаписывает существующие файлы. `status=protected_payload` означает **всё ещё обфусцированное тело**, `status=lua_source_candidate` — *непроверенный* Lua (не обязательно игровой), `loader_only`/`sdk_only`/`auth_or_no_script` — игрового тела нет. HAR-ответ именно `/sdk/library.lua` не экспортируется, даже если это корректный Lua. Во всех случаях `deobfuscated=false` и `gameplay_verified=false`. Проверять права источника, смысл игровых обработчиков, полноту, синтаксис и поведение нужно **отдельно**; сырые выгрузки не добавлять в каталог. Для этой операции в `.gitignore` уже есть `/local-results/` и добавлены `*.har`/`/captures/`; HAR по определению может содержать секреты даже при обезличенном отчёте.

**Проверено на 21 октября:** 13 синтетических офлайн-тестов адаптера (JSON/base64, Lua-escape, HAR-фильтр домена/индекса, секреты не попадают в отчёт, запрет loader-only/перезаписи/каталога, отсутствие исполнения) и три теста IB2-парсера. На реальном **локальном loader-файле**, но **без серверного ответа**: [`snowdevlol/OphynUI@ced5214/src/utilities/jnkie.lua`](https://github.com/snowdevlol/OphynUI/blob/ced52141991412ceb078c2d969c9c92669427d62/src/utilities/jnkie.lua) (2 809 байт, MIT-репозиторий; Jnkie SDK URL в переменной) распознан как `loader_only`.

**Исправление от 22 октября:** файл из уже находившегося в репозитории архива `Deobfuscator-Luraph-V15-master.zip/sample/BloxFruit.lua` (191 163 байта, SHA-256 `4863cc8547cddd373e90656367305fb0b5587bc476f01482ce7e015e01012063`) здесь **ошибочно** назван Luarmor `loader_only`. Это *ранее готовый* выход из Luraph v15, совпадающий побайтно с `sample/output/Blox Fruit.lua`: помимо ссылок-загрузчиков Luarmor он содержит локальные игровые вызовы Blox Fruits (`GetFruits`, `RegisterHit`, `FishingRequest`, `SetTeam`). Исправленный адаптер помечает его `loader_with_inline_code`; **строковые упоминания** `LPH_ENCSTR`/`LPH_ENCFUNC` не делают уже читаемый текст новой виртуальной машиной. Это **не наша деобфускация Luarmor**, не восстановление кода по этим ссылкам и не разрешение публиковать пример третьей стороны как игровой файл. Изменение и другие попытки — в [отчёте от 22 октября](offline-luarmor-jnkie-2026-10-22.md).

Документация провайдеров подтверждает разделение SDK/загрузчика и скачиваемого после аутентификации скрипта: [1](https://docs.jnkie.com/roblox-sdk/external-loader), [7](https://luarmor.mintlify.app/scripting/verification). Не следует делиться ключами, HAR или частным payload в pull request.
