# Shindo Life — DogeHub V2: полная цепочка восстановления (2026-11-17)

Статус: **финальный слой восстановлен и прочитан** (обычный Lua, 14 298 строк).
Ничего не запускалось в Roblox; «работает» = `loadfile` (Lua 5.1.1) + чтение кода.

## Один файл на проект (2026-11-17, дедуп)

Единый файл результата: **`../script.combined.lua`** — шапка + `PARTS.md`
(статический разбор контейнера) как комментарии + **финальный payload дословно**
(раздел 2/2, sha256 `64df436148bdf00b6257ac62fdf345cecad66c16713d8150b6a3880b9f7ea700`).
Отдельная копия payload в репозитории больше не хранится (в git-истории — до коммита дедупа).

Каталог `recovered/` — только **plain Lua**-модули цепочки (7 файлов, `SHA256SUMS`):

| Файл | Размер | Что это |
|---|---|---|
| mod_chooseurdevice.lua | 6 624 B | Выбор PC/MOBILE, пишет Device.txt |
| mod_spinrecords.lua | 1 812 B | Счётчик спинов (readfile/writefile) |
| mod_spinblood_loader.lua | 29 374 B | Проверка `GameId==1511883870`, грузит IronBrew remote |
| mod_projectbullshit_rebooted.lua | 100 591 B | «Project: Bullshit: Rebooted» (самостоятельное HUB-меню) |
| mod_pagebloodlinechanger_ui.lua | 28 842 B | UI-страница Bloodline Changer |
| mod_pagercshopchanger_ui.lua | 28 852 B | UI-страница RC Shop Changer |
| mod_userlogs.lua | 715 B | POST на внешний вебхук (см. «Приватность») |

Все 7 — `loadfile` (Lua 5.1.1) OK.

## Цепочка (от лоадера к коду)

```
ScriptBlox 224947 (badge «Detected Key system» — для этого лоадера не подтверждается)
  └─ NoobieDoge/DogeHubV2@Separated:ShindoLife          44 639 B  plain Lua, IronBrew-VM
       │  печатает «DogeHub V2 Shindo Life», затем game:HttpGet(...) + loadstring()
       ▼
  Kasep6720/Secret@DogeHubV2:Games/ShindoLife          506 964 B  PLAIN Lua — раздел 2/2 combined
       │  14 298 строк; UI DogeHub V2 Shindo + фичи. Ремоуты грузятся в рантайме.
       ├─ ChooseUrDevice (plain) ─ грузит «pornhub page format gui(s)» (не скачивались)
       ├─ DogeHubV2ShindoSpinRecords (plain)
       ├─ DogeHubV2UserLogs (plain, вебхук)
       ├─ ShindoAutoSpinRELLBloodline (plain-обёртка) ─ GameId-gate ─ IronBrew-1 remote (НЕ включён)
       ├─ Project: Bullshit: Rebooted (plain)
       ├─ HDTerebi/Shindo-Life:No CD Method (AztupBrew V2.7.2, НЕ включён)
       ├─ NoobieDoge BloodlineChanger / RCShopChanger (IronBrew-1, НЕ включены)
       │     └─ Page Bloodline/RCShop Changer (plain, в recovered/)
       └─ KylnDantas/InfRellCoinsSL — упоминается только в комментариях («--patched»)
```

## Как восстановлен финальный слой

1. Внешний слой — плейнтекстовый контейнер IronBrew-VM (`@Ironbrew/netcoreapp2.0/out.lua`,
   OpArg-перетасовка; контейнер распарсен на 100 % инструментами `deobf-report/tools/ironbrew_*`,
   см. `dump.txt`/`disasm.txt` в этом каталоге).
2. Внешняя VM не расшифровывает payload локально — она вызывает `game:HttpGet(...)` и `loadstring(body)()`.
   Подтверждено чёрным ящиком `work/sources/dogehub_sandbox.lua` (стоковый Lua 5.1.1, болванки
   Roblox-глобалов, `bit`/`bit32` на чистой арифметике, перехват `loadstring`; сеть в sandbox не ходит).
3. Файл по URL скачан отдельно через `gh api` (публичный). Финальный файл — **не обфусцирован**:
   `loadfile` OK; маркеры IronBrew/AztupBrew (`L<digit>_<digits>`, десятичные `\ddd`) = 0 совпадений.
4. Остальные IronBrew/AztupBrew-тела цепочки **не девиртуализированы** (нет деобфускатора под эти билды).

## Что НЕ включено в репозиторий (и почему)

Чужой **обфусцированный** код в `results/` не хранится (правило папки). Это исходные, не
девиртуализированные тела; восстановить можно скачиванием по URL (все публичные):

| Файл (не деобфусцирован) | Размер | sha256 | Источник |
|---|---|---|---|
| dogehub_v2_shindo_loader_outer_vm.lua | 44 639 B | ee0525fff7d34e74e384180b4adcf74fb4ab1ff45fd0f0e5f5da9243189932ed | `github.com/NoobieDoge/DogeHubV2/contents/ShindoLife?ref=Separated` |
| mod_bloodlinechanger (IronBrew-1) | 44 410 B | d96206f41f5bf15cbdcff088c393eafd19be2a47b7ed7e226263d862f5b45810 | `github.com/NoobieDoge/DogeHub/contents/ShindoBloodlineChanger?ref=Separated` |
| mod_rcshopchanger (IronBrew-1) | 44 348 B | 0de74a95b0856b19063065d1e0c246342ac5067c6b83fe5a433f33efab80455c | `github.com/NoobieDoge/DogeHub/contents/ShindoRCShopChanger?ref=Separated` |
| mod_shindoautospinrellbloodline (IronBrew-1) | 18 166 B | 076113a530cfdd0dc9a8d8f5c3eeacf7da43ed5969417675c788b408360f1d3e | `github.com/NoobieDoge/DogeHubV2/contents/ShindoLifeAutoSpinRELLBloodline?ref=Functions` |
| mod_nocdmethod (AztupBrew V2.7.2) | 221 422 B | c3369e9982df5f93a4cc682ee92300fc124581474ed65c82d327be2ae0ee7eb4 | `github.com/HDTerebi/Shindo-Life/contents/No%20CD%20Method?ref=main` |

## Приватность / ответственно

`mod_userlogs.lua` отправляет JSON-POST на внешний Discord-совместимый вебхук (URL/токен в файле):
тело включает `game.PlaceId`/`LocalPlayer.Name` (точные поля — `Body` в файле). **Не вызывался.**
Токен вебхука в отчёты/чат не копировался.

## Что честно НЕ восстановлено

- Девиртуализация IronBrew-1 тел (Bloodline/RCShop changers, AutoSpin-RELL remote).
- AztupBrew V2.7.2 «No CD Method».
- Офлайн-дешифровка 365 B мини-VM слоя внешнего лоадера (sha256 `29a8ed28…`) — в рантайме
  не используется (payload тянется по сети); ценности нет.
- Рунтайм в Roblox не проверялся (по правилам).

## Метод (пригоден для других «лоадер ходит в сеть»)

Blackhole-песочница с перехватом `loadstring` работает для любых IronBrew-обёрток такого типа.
Для тел с **локальной** дешифровкой (AztupBrew) нужен девиртуализатор — под эти версии его нет.
