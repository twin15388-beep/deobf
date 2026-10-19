# Новая попытка: восстановление Roblox VM-кода, 19 октября 2026 г.

**Итог:** четыре защищённых файла, **три разные игры**, четыре читаемых файла Lua 5.1 в [`dobf scripts 1.0/`](../dobf%20scripts%201.0/README.md). Ранее опубликованные неполные результаты Ninja Masters, Tower Battles, GPO, Untitled Boxing Game, SeaHub и старые отчёты удалены по требованию пользователя, а не переименованы в успехи. Коллекция потенциально применимых инструментов сохранена. Не выдаём число игр за обещанные десять: на этой итерации удалось подтвердить именно **три**.

## Новые входы, не исходники из открытых пар

Все четыре защищённых файла взяты через `git show` из `DohmBoyOG/Script-Dump` commit [`da2dea31c28d620a85111a8f9cc1bd776141eb91`](https://github.com/DohmBoyOG/Script-Dump/tree/da2dea31c28d620a85111a8f9cc1bd776141eb91). Соседние **необфусцированные** пары рассматривались только как независимый контроль и не копировались в папку результатов. SHA-256 входов, результатов и поднятого bytecode, число прототипов/инструкций, точные ссылки — в [JSON](vm-recovery-2026-10-19.json). Исходные защищённые файлы в репозиторий не добавлялись.

| Защищённый вход | Поток VM | Выход | Аналитическое название обработчика |
| --- | ---: | --- | --- |
| `GodOfGlory_DestroyWorld_OBED.lua` | 2 прототипа, 81 инструкция | [God of Glory](../dobf%20scripts%201.0/God%20of%20Glory%20-%20Destroy%20World.lua) | `destroyWorldDestructibles()` — анонимная функция в `spawn` |
| `NerfFPS_546_INFMONIES_OBED.lua` | 2 прототипа, 62 инструкции | [Nerf FPS: деньги](../dobf%20scripts%201.0/Nerf%20FPS%205.46%20-%20Infinite%20Money.lua) | `blockSubCash(self, ...)` — callback `__namecall` |
| `NerfFPS_546_TDM_KillALL_OBED.lua` | 1 прототип, 81 инструкция | [Nerf FPS: TDM](../dobf%20scripts%201.0/Nerf%20FPS%205.46%20-%20TDM%20Kill%20All.lua) | Только основной chunk/циклы, объявленной функции нет |
| `PriorExtinction_AntiBanKick_Probably_OBed.lua` | 2 прототипа, 55 инструкций | [Prior Extinction](../dobf%20scripts%201.0/Prior%20Extinction%20-%20Anti%20Kick%20Ban.lua) | `guardNamecall(self, ...)` — callback `__namecall` |

**Зачем здесь исходный код, а не только названия:** [README самой папки результатов](../dobf%20scripts%201.0/README.md) содержит тело каждого обработчика с параметрами, условиями, вызываемыми API и ограничениями; `.lua` содержат полный восстановленный chunk, включая установки хуков и циклы. Имена `destroyWorldDestructibles`, `blockSubCash`, `guardNamecall` **даны аналитиком**, оригинальные функции были анонимными; не утверждаем восстановление имён переменных.

## Как получен код, без исполнения защищённого Lua

1. **Семейство, не «все инструменты подряд».** Эти образцы имеют Base36-строку с LZW, XOR-ключом и сериализованные VM-прототипы. Теги типов и порядок секций отличаются даже внутри одного набора. Нельзя применять к ним декодер Luraph 15.1 / MoonVeil / MoonSec V3 / Prometheus только потому, что он есть в коллекции.
2. [`scripts/vm_static/decode.py`](../scripts/vm_static/decode.py): статически распакованы литерал, LZW, XOR и всё дерево прототипов; неполное чтение/неизвестный SHA/некорректные ссылки на константы отвергаются. Профиль GOGV3 тоже парсится, **но это ещё не Lua**.
3. [`scripts/vm_static/lift.py`](../scripts/vm_static/lift.py): для **четырёх точных SHA-256** отдельно разобраны ветви диспетчера, развёрнуты составные VM-инструкции, восстановлены вызовы, `SELF`, захваченный `oldNamecall`, условные переходы, generic-for и `repeat`/`until`. TDM требует удаления неисполняемых переходов, иначе декомпилятор возвращает диагностический псевдокод. В God of Glory проверена полярность `StreamingEnabled`: требуется **`== true`**, не обратная ветвь.
4. На каждом `.luac`: `Lua 5.1 luac -p` (валидный bytecode). На **каждом** поднятом bytecode `unluac-js@1.4.4`, режим `lua5.1/strict`, вернул `kind=source` и **0** `[unluac error]`. На каждом результирующем `.lua`: снова `luac -p`. Более слабые признаки («exit code 0», «синтаксис верен», «найдены константы») **сами по себе не считаются** доказательством восстановления.
5. Вручную сравнены значимые ветви и эффекты с четырьмя отдельно открытыми контрольными файлами того же commit. Их код **не использован в качестве выходного файла**. Проверены, например, `TagFullName` и место `FireServer`; порядок `setreadonly` и захват `old`; фильтр `TeamColor` и параметры `VULCAN`; приоритет `and/or` в Prior Extinction. Ни защищённый код, ни результат, ни Roblox не запускались; это не формальная проверка эквивалентности.

### Воспроизведение одного файла

Зависимости: Python 3.10+ (стандартная библиотека), Node.js, `unluac-js@1.4.4` и Lua 5.1 `luac` для дополнительной проверки. Получить вход **через Git, не через API и не из Pastefy**:

```sh
git clone --no-checkout https://github.com/DohmBoyOG/Script-Dump.git /tmp/script-dump
git -C /tmp/script-dump show da2dea31c28d620a85111a8f9cc1bd776141eb91:GodOfGlory_DestroyWorld_OBED.lua > /tmp/gog-obfuscated.lua
sha256sum /tmp/gog-obfuscated.lua  # 08c0dc490d952d4991c78531ede1c0adfc8faab6b5bd8198822beb2fb9fc23f5
python3 scripts/recover_vm_samples.py /tmp/gog-obfuscated.lua --output /tmp/gog-recovered.luac
luac -p /tmp/gog-recovered.luac
npm install --no-save --no-package-lock --prefix scripts unluac-js@1.4.4
node scripts/decompile_lua51.mjs /tmp/gog-recovered.luac /tmp/gog-recovered.lua
luac -p /tmp/gog-recovered.lua
```

Для остальных трёх входов заменить только исходное имя файла; выбор декодера/VM-профиля происходит по SHA-256. Байт-код в `/tmp`, а не в папке публикуемых исходников. Полный прогон локально клонированных входов: `VM_SAMPLE_DIR=/path/to/copies python3 -m unittest discover -s tests -p test_vm_static.py -v`. Финальная сверка опубликованных файлов: `python3 scripts/verify_results.py`.

## Сравнение попыток и конкретные ограничения

| Семейство/образец | Подходы, которые проверили или предметно изучили | Исход |
| --- | --- | --- |
| Эти четыре Base36/LZW/VM входа | Написанный статический парсер + отдельно сопоставленные opcode-профили + Lua 5.1 `luac` + `unluac-js` | **4 читаемых chunk**, код и функции выше. `viruscamp/luadec` на сложных циклах давал ошибки структуры, потому не используется как доказательство. `noahcoolboy/bad-aztupbrew-deobfuscator` и Rust-проход `1-3-7/disrobe` изучены как профильные альтернативы; первый ограничен жёсткими шаблонами и **не испытывался** на этих входах, релиз второго не скачался (`EOF`), `rustc` в среде нет. |
| God of Glory V3 | Тот же декодер контейнера | **32 прототипа, 733 инструкции:** байты прочитаны полностью, но картирование диспетчера/составных opcode не закончено. Подмена именами констант была бы ложной «деобфускацией»; `.lua` не публикуется. |
| Tropical Resort Tycoon | `memcpython/PSU-Deobfuscator`, `unluac-js`, `viruscamp/luadec` | VM снята до bytecode, но `unluac-js` — `open-pack`, LuaDec — `SetList fails`/ошибки регистров. Надёжного Lua нет. |
| Tapping Simulator (Luast L1) | `paglsj43dx/Luast-Dumper` с `--raw --keep-dead` | Генерирует файл, **теряющий почти всю игровую логику**, поэтому успехом не считается. |
| WW2 Tycoon (LuaObfuscator.com) | `nexus1877/LuaObfuscator-Deobfuscator`, изучен `1-3-7/disrobe` | Первый: `incomplete_evil:missing_xor_bootstrap`. Для второго получение бинарника прервалось, Rust не установлен. |
| GPO и старые входы | Профильные Luraph/PSU/AST-подходы из предыдущих попыток | Подтверждённого полного GPO Lua пока **нет**; прежние частичные файлы удалены по запросу. |

Заявленные инструменты для Luraph 14.x/15.0/15.1, MoonVeil, MoonSec V3, IronBrew и Prometheus остаются в [`sources/`](../sources/manifest.json), но **не применяются бессмысленно к неподходящей VM** и не объявляются прошедшими тест на этих четырёх файлах. **Steal an Egg не исследовался.** Никаких скриптов из Pastefy или через API не получали. RScripts использовался ранее лишь как указатель на игровые названия, не как источник публикуемого кода.

У репозитория Script-Dump корневой `LICENSE` не обнаружен; право на повторное распространение исходных скриптов и безопасность их запуска **не подтверждены**. Результаты предоставлены по запросу владельца репозитория для статического изучения, не как готовые к запуску читы.
