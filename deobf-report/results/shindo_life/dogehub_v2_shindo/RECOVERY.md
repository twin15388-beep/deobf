# Shindo Life — DogeHub V2: полная цепочка восстановления (2026-11-17)

Статус: **Финальный слой восстановлен и прочитан** (обычный Lua, 14 298 строк).
Три промежуточных обфусцированных слоя пройдены/вынесены за скобки по факту.
Ничего не запускалось в Roblox; «работает» = `loadfile` (Lua 5.1.1) + чтение кода.

## Цепочка (от лоадера к коду)

```
ScriptBlox 224947 («Detected Key system» — предупреждение ложно для этого лоадера)
  └─ NoobieDoge/DogeHubV2@Separated:ShindoLife          44 639 B  plain Lua, IronBrew-VM
       │  печатает «DogeHub V2 Shindo Life», затем game:HttpGet(...) LOADSTRING
       ▼
  Kasep6720/Secret@DogeHubV2:Games/ShindoLife          506 964 B  PLAIN Lua (не обфусцирован)
       │  14 298 строк; содержит UI DogeHub V2 Shindo, фичи (авто-Spin REL Bloodline,
       │  Bloodline/Element/RC-shop changers, No CD Method, Project: Bullshit Rebooted,
       │  выбор устройства, логгер). Ремоуты грузятся в рантайме.
       │
       ├─ ChooseUrDevice                                  6 624 B  plain Lua
       │    (пишет Device.txt через writefile; UI выбора PC/MOBILE;
       │     грузит «pornhub page format gui(s)» из Kasep6720/Secret — третьи GUI)
       ├─ DogeHubV2ShindoSpinRecords                       1 812 B  plain Lua
       ├─ DogeHubV2UserLogs                                  715 B  plain Lua (POST вебхука, см. «Приватность»)
       ├─ ShindoAutoSpinRELLBloodline (меню)               29 374 B  plain Lua-обёртка:
       │    GameId==1511883870 ? загрузка REMOTE:
       │      NoobieDoge/DogeHubV2@Functions:ShindoLifeAutoSpinRELLBloodline  18 166 B  IronBrew-v1 (`return(function(...)local Q={...`), НЕ девиртуализирован
       │    иначе «Game not supported»
       ├─ Project: Bullshit: Rebooted                     100 591 B  plain Lua (+ внутри 1 loadstring на несуществующий DogeHub/DogeHub — мёртвая ссылка в комментарии)
       ├─ HDTerebi/Shindo-Life@main:No CD Method          221 422 B  AztupBrew V2.7.2, НЕ девиртуализирован
       ├─ NoobieDoge/DogeHub/Separated:ShindoBloodlineChanger 44 410 B  IronBrew-v1, НЕ девиртуализирован;
       │    в рантайме тянет Page:
       │      Kasep6720/Secret@Functions:…/Page Bloodline Changer     28 842 B  plain Lua (UI-страница)
       ├─ NoobieDoge/DogeHub/Separated:ShindoRCShopChanger   44 348 B  IronBrew-v1, НЕ девиртуализирован;
       │    в рантайме тянет Page:
       │      Kasep6720/Secret@Functions:…/Page RC Shop Changer       28 852 B  plain Lua (UI-страница)
       └─ (2 упоминания KylnDantas/InfRellCoinsSL — все в комментариях, «--patched»)
```

## Как восстановлен финальный слой

1. Внешний слой (`recovered/dogehub_v2_shindo_loader_outer_vm.lua`) — плейнтекст
   с VM-обфускацией IronBrew-2-подобной формы, но **все операции VM, влияющие на
   поток, статические**; VM не расшифровывает payload сам — она просто вызывает
   `game:HttpGet(<url>)` и `loadstring(body)()`.
2. Прямой запуск в стоковом Lua 5.1.1 падает на Roblox-глобалах; вместо дешифровки
   написан чёрный ящик `work/sources/dogehub_sandbox.lua`: настоящие базовые
   библиотеки + болванки всех Roblox/executor-глобалов (метатаблицы-чёрные дыры),
   `bit`/`bit32` — чистая арифметика на Lua, `loadstring` перехватывается и дампит
   тело. Запуск: `timeout 10 work/lua51/lua work/sources/dogehub_sandbox.lua`.
   Трасса: `GET game.HttpGet(sandbox-stub, https://…/Games/ShindoLife, true)` →
   `LOADSTRING(34 bytes)` (внутренний стаб из IronBrew-контейнера; в песочнице
   HttpGet не ходит в сеть, поэтому аргумент — строка-болванка). Сам файл по URL
   скачан отдельно, напрямую через `gh api` (публичный, remote в sandboxе доступен).
3. Финальный файл — **не обфусцирован вообще**: это исходный Lua-исходник.
   Проверка: `loadfile` (Lua 5.1.1) OK для всех файлов в `recovered/`; маркеры
   IronBrew/AztupBrew (`L<digit>_<digits>`, десятичные `\\ddd`) = 0 совпадений в
   финальном payload.
4. IronBrew/AztupBrew-модули (`mod_bloodlinechanger`, `mod_rcshopchanger`,
   `mod_shindoautospinrellbloodline`, `mod_nocdmethod`, `mod_pagercshopchanger`
   НЕТ — он plain) **не девиртуализированы**; их функциональность восстанавливается
   из загрузочных страниц (plain) и из имён. `loadfile` проходит (синтаксически
   валидны), семантика VM не разобрана.
5. `mod_nocdmethod` (AztupBrew V2.7.2) — Aztup-деобфускатор не применялся
   (вне приоритета, третий источник, 221 КБ). Честно: НЕ восстановлен.

## Восстановленные файлы (`recovered/`, sha256 в `SHA256SUMS`)

| Файл | Размер | Шифр? | Что это |
|---|---|---|---|
| dogehub_v2_shindo_loader_outer_vm.lua | 44 639 | VM (плейнтекст) | Внешний лоадер DogeHub V2 Shindo |
| dogehub_v2_shindo_payload_remote_plaintext.lua | 506 964 | НЕТ | **Основной скрипт DogeHub V2 Shindo** (UI + фичи) |
| mod_chooseurdevice.lua | 6 624 | НЕТ | Выбор PC/MOBILE, Device.txt |
| mod_spinrecords.lua | 1 812 | НЕТ | Счётчик спинов (readfile/writefile) |
| mod_spinblood_loader.lua | 29 374 | НЕТ (читаемо) | Проверка GameId, грузит IronBrew remote |
| mod_shindoautospinrellbloodline_IRONBREW_notdeobfed.lua | 18 166 | IronBrew-1 | Remote-тело (за GameId-gate) |
| mod_projectbullshit_rebooted.lua | 100 591 | НЕТ | «Project: Bullshit Rebooted» (самостоятельное HUB-меню игры) |
| mod_nocdmethod_AZTUPBREW_notdeobfed.lua | 221 422 | AztupBrew V2.7.2 | «No CD Method» (fast-cast/домен) |
| mod_bloodlinechanger_IRONBREW_notdeobfed.lua | 44 410 | IronBrew-1 | Лоадер страницы Bloodline Changer |
| mod_pagebloodlinechanger_ui.lua | 28 842 | НЕТ | UI-страница Bloodline Changer |
| mod_rcshopchanger_IRONBREW_notdeobfed.lua | 44 348 | IronBrew-1 | Лоадер страницы RC Shop Changer |
| mod_pagercshopchanger_ui.lua | 28 852 | НЕТ | UI-страница RC Shop Changer |
| mod_userlogs.lua | 715 | НЕТ | POST на внешний вебхук (см. ниже) |

## Приватность / ответственно

`mod_userlogs.lua` отправляет JSON-POST на внешний Discord-совместимый вебхук
(URL и token в файле). Содержимое включает `game.PlaceId`/`LocalPlayer.Name`
(точные поля — `Body` в файле). Мы его НЕ вызывали; он отмечен для пользователя.
Токен вебхука в чат/отчёты не копируем.

## Что НЕ восстановлено (честно)

- Девиртуализация IronBrew-1 модулей (Bloodline/RCShop changers, AutoSpin RELL remote) —
  только обёртки пройдены; их тела: IronBrew VM (см. `ironbrew_dump.py` методология:
  контейнер парсится на 100 %, финальный слой — мини-VM с K13).
- AztupBrew V2.7.2 тело «No CD Method».
- К13/мини-VM слой внешнего лоадера (365 B, sha256 29a8ed28…) — в рантайме не
  использовался лоадером для payload (payload тянется по сети), ценности нет.
- Рунтайм-поведение в Roblox не проверялось (по правилам).

## Метод, пригодный для других IronBrew-обёрток

Чёрный ящик `work/sources/dogehub_sandbox.lua` + `loadstring`-перехват работает для
любых «IronBrew-лоадер ходит в сеть» схем. Для тел, дешифруемых локально (AztupBrew),
нужен девиртуализатор, которого под эту версию нет.
