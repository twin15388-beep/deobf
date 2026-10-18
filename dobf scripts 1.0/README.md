# dobf scripts 1.0

Файлы названы **по игре, для которой заявлен исходный скрипт**. Суффиксы `partial`, `inner-vm`, `vm-deflattened` и `container` сохранены намеренно: **полностью восстановленных и проверенных в Roblox исходников нет**. Из 10 файлов — 5 частичных результатов и 5 неудач. Не запускайте эти файлы: в них могут оставаться VM, сетевые загрузчики и неизвестная логика.

## Сначала открыть — восстановлена структура кода

| Игра | Файл | Что получилось |
| --- | --- | --- |
| **Grand Piece Online** | [Grand Piece Online.partial.luau](Grand%20Piece%20Online.partial.luau) | Структура 22 обнаруженных функций Prometheus/WeAreDevs VM, 535 констант. Имена/обвязка остаются; эквивалентность исходной программе не проверена. |
| **Untitled Boxing Game** | [Untitled Boxing Game.partial.luau](Untitled%20Boxing%20Game.partial.luau) | Структура 15 обнаруженных функций, 294 константы. Это не доказательство полной деобфускации или работоспособности. |

Промежуточные данные для проверки: [Grand Piece Online.analysis.json](Grand%20Piece%20Online.analysis.json) и [Untitled Boxing Game.analysis.json](Untitled%20Boxing%20Game.analysis.json).

## Только частичная распаковка — не готовые скрипты

- **Grow a Garden:** [Grow a Garden.inner-vm.luau](Grow%20a%20Garden.inner-vm.luau) — снят внешний слой Luraph v14.4.1, прикладной код всё ещё виртуализирован.
- **DOORS:** [DOORS.vm-deflattened.lua](DOORS.vm-deflattened.lua) — константы и управление частично восстановлены, исходная логика не поднята.
- **Grand Piece Online, другой файл:** [Grand Piece Online (Luraph v13.5.8).container.bin](Grand%20Piece%20Online%20%28Luraph%20v13.5.8%29.container.bin) — **не Lua-код**, пригоден только для дальнейшего анализа.

## Не считать GPO-автофармом

У кандидата из RScripts после замены 922 строковых вызовов обнаружился **интерфейс проверки ключа**, а не заявленный GPO-автофарм. Он **не входит в десятку**: [Key System (not GPO).strings-decoded.lua](Key%20System%20%28not%20GPO%29.strings-decoded.lua) · [Key System (not GPO).formatted.lua](Key%20System%20%28not%20GPO%29.formatted.lua).

Для GPOKAIZEN, Blade Ball, Arcane Odyssey, Blox Fruits и Fruit Battlegrounds код не восстановлен; под видом результата их исходные обфусцированные файлы сюда не добавлены. Название игры у нераспакованных VM следует из имени файла/страницы источника, а не из подтверждённой работы payload.

[Подробный отчёт](../reports/roblox-batch-2026-10-18.md) · [Коммиты источников и SHA-256 каждого файла](../reports/roblox-batch-2026-10-18.json). **Steal an Egg не анализировался; Pastefy/API не использовались; защищённые скрипты не исполнялись.**

> Производные файлы содержат чужой код из публичных репозиториев. Публичная доступность исходника не равна лицензии на повторное распространение; права и условия исходных авторов не установлены. Публикация здесь сделана по запросу владельца этого репозитория и не даёт дополнительной лицензии на код.
