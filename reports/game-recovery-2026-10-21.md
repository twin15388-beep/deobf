# Дополнение: GPO и новые инструменты — 21 октября 2026

**Результат:** сохранены прежние 12 Lua-файлов для 10 заявленных игр; улучшен **только частичный** [Grand Piece Online — Lunar Hub](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua), добавлены пять лицензированных source-only архивов (всего **40** в каталоге). Никакой готовый открытый скрипт, загрузчик или универсальный хаб не выдаётся за восстановление. Защищённый вход — [`c0deblox/Scripts:GPO.lua@472dc587`](https://github.com/c0deblox/Scripts/blob/472dc5871faae68dfcfbba6485a619275063ee16/GPO.lua), PSU 4.0.A, SHA-256 `0f6a4be8f4477de671068d6b19977088281e9fc098a00f72b5c53bf3f0320f30`. Детали остальных игр — в [инвентаре](game-recovery-2026-10-19.md) и [машинном отчёте](game-recovery-2026-10-19.json).

## Что действительно получилось восстановить

`memcpython/PSU-Deobfuscator@7d955d4` статически поднял **48 400 байт** Lua 5.1-байткода, SHA-256 `fe7dc0be0ad15266fd53765c2e53d60c4a4c61277696a93cc50cad3e06542241`, 99 прототипов без неизвестных инструкций. Целый вывод `unluac-js@1.4.4` содержит **49 ошибок восстановления**; `viruscamp/luadec@895d923` падает на целом файле. **Это не полный хаб.**

Три самостоятельных прототипа байткода позволили проверить подлинное числовое поведение и квестовый вызов вместо доверия ошибочному псевдокоду:

| Исходная функция | Путь luadec / extract | Параметры и действие | Ограничения |
| --- | --- | --- | --- |
| `calculatetime` (#9) | `0_7` | `(x, y, z)` → расстояние между `Vector3.new(x,y,z)` и `HumanoidRootPart.Position`, делённое на `_G.speed` (изначально 175), в секундах | В опубликованном `calculateTime` гарантирован **только числовой** вариант; требуется `_G.speed` |
| `teleport` (#12) | `0_10` | `(x, y, z)` → `_G.teleporting = true`; `spawn` цикла удержания состояния/скорости; при расстоянии **>1000** и высоте **>10** Tween `Position` до `Y=0`; затем Tween `CFrame.new(x,y,z)`, ожидание `Completed:Wait()`, сброс флага, возврат `(tween, duration)` | Опубликован как `teleportNumeric` **только для трёх чисел и `getgenv().noclip == false`**; userdata/CFrame и noclip явно отклоняются |
| Квестовый обработчик (#31) | `0_20` | `(npcName)` → поиск `Quest` и `QuestPos`, вызов глобальной `teleport(position.X, position.Y, position.Z)`, затем `Events.Quest:InvokeServer({"takequest", questTitle})` | В опубликованном `takeQuest` глобальная функция заменена на локальную `teleportNumeric`; сравнение проведено только для `None`, `Bandit` и отсутствующего `QuestPos` у `Bandit Boss` |

`takeQuest(npcName)` в исходном квестовом прототипе #31 передаёт `position.X`, `.Y`, `.Z` в глобальную `teleport`. В частичном модуле этот **числовой** вызов заменён локальным проверенным `teleportNumeric`, после завершения которого отправляется `ReplicatedStorage.Events.Quest:InvokeServer({"takequest", questName})`. Это делает квестовый фрагмент менее зависимым от отсутствующей глобальной функции; `npcName` — ключ `Quest`/`QuestPos`, не произвольный NPC. Для `Bandit Boss`, `Axe Hand Logan`, `Gorilla King` в исходной таблице нет `QuestPos`; модуль по-прежнему выдаёт ошибку, а не выдумывает координаты. Остальные игровые функции (NPC, урон, лёд) не заменены и описаны [рядом с кодом](../dobf%20scripts%201.0/README.md).

**Почему нельзя назвать `teleport()` целиком восстановленным:** в `unluac-js` есть неоднозначные `open-pack` в ветках `components()` для userdata/CFrame, а также в числовом `CFrame.new(...)`. У числового пути последний вызов был дополнительно **проверен выполнением именно выделенного байткодного прототипа под макетами**: переданы ровно три аргумента `(x,y,z)`. Та же проверка **не** проводилась для userdata или noclip. Запуск полного защищённого хаба или Roblox-кода не выполнялся.

## Проверка настоящего байткода, не запуск хаба

[`extract_lua51_prototype.py`](../scripts/extract_lua51_prototype.py) читает структуру Lua 5.1 chunk и выводит *неизменённый* дочерний прототип как отдельный chunk. Он отвергает прототипы с upvalue, не интерпретирует игровой скрипт и не включает поднятый байткод в Git. Для воспроизведения сначала статически поднимите `/tmp/gpo.luac` из указанного защищённого входа по [методике PSU](game-recovery-2026-10-19.md#процесс-и-воспроизведение) и проверьте приведённый выше SHA-256:

```bash
python3 scripts/extract_lua51_prototype.py /tmp/gpo.luac 0_7 /tmp/gpo-time.luac
python3 scripts/extract_lua51_prototype.py /tmp/gpo.luac 0_10 /tmp/gpo-teleport.luac
# SHA-256 производных chunks: c63d7d3ef22f26a2a8af1261cf829e04d2b51925e424f3a379b06fd14abecff1
# и 774f5595b8c830ba3ee3821677580f902ca06358a16c59185ad3ee5a527fc590
python3 scripts/extract_lua51_prototype.py /tmp/gpo.luac 0_20 /tmp/gpo-quest.luac
# SHA-256 третьего chunk: ecd7f329f850330b1259f97dd6990878b15087fc3b667c77fce97f007d509c89
lua5.1 tests/test_gpo_teleport_numeric.lua \
  'dobf scripts 1.0/Grand Piece Online - Lunar Hub (partial).lua' \
  /tmp/gpo-time.luac /tmp/gpo-teleport.luac /tmp/gpo-quest.luac
lua5.1 tests/test_gpo_lunar_fragment.lua \
  'dobf scripts 1.0/Grand Piece Online - Lunar Hub (partial).lua'
```

В тесте два изолированных Lua 5.1-окружения с подставными `Vector3`, `TweenService`, `CFrame`, `game`, `getgenv`, `_G`. Поднятый **отдельный** оригинальный прототип и опубликованная реконструкция независимо вызываются с одинаковыми координатами; `spawn` откладывается, чтобы не исполнять бесконечный цикл. Сравниваются длительность, последовательность `Create`/`Play`/`wait`/`Wait`, свойства цели, число аргументов конструктора CFrame и сброс `_G.teleporting`. Пройдены **пять** числовых траекторий: короткая `(0,0,0)→(3,0,4)` при speed=2 (2,5 с), длинная с Y>10 `(0,20,0)→(1100,20,0)` при speed=100 (два Tween, 11 с), высота ровно 10 (без спуска), расстояние ровно 1000 (без спуска) и 1001 (со спуском). Квест проверен **ещё и против настоящего отдельного прототипа #31**: `None` не вызывает удалённые события, `Bandit` вызывает числовой Tween перед `{"takequest", "Help Raphtalia"}`, `Bandit Boss` у обоих вариантов заканчивается ошибкой из-за отсутствующего `QuestPos`. Сравнивались также порядок событий и конечный флаг. Защищённый top-level Lua, сеть, Roblox, userdata и noclip **не исполнялись**. Работа асинхронного цикла стабилизации в Roblox не подтверждена.

**Выход:** 11 541 байт, 223 строки, SHA-256 `c5be6b26a5b4c086ece6974c8ce7a3df888c9ade1843aba6b0cf0ca9e3346ee2`. Это **адаптированный частичный Lua-модуль**, не оригинальный файл автора и не доказательство полной эквивалентности PSU-VM.

## Ещё пять инструментов: результат, а не обещание

Все новые ZIP — **исходники** с сохранённой лицензией и commit/SHA-256 в [`sources/manifest.json`](../sources/manifest.json); скомпилированные бинарники, примеры защищённых скриптов и полученные байтовые потоки в репозиторий не добавлены.

| Инструмент | Проверка здесь | Вывод и предел |
| --- | --- | --- |
| [Jeong-Min-Cho/unluac](https://github.com/Jeong-Min-Cho/unluac) (MIT) | Найдены исходники Java для Lua 5.0–5.4; JRE Java 17 из `jdk4py==17.0.9.2` запущена и проверена на `jdk.compiler`/`javac` | **Сборка/прогон GPO заблокированы:** JRE не содержит компилятор; непрозрачный сторонний JAR не выполнялся |
| [CPunch/LuaDecompy](https://github.com/CPunch/LuaDecompy) (MIT) | Запущен на полном GPO `.luac`, на частичном модуле и на `return 42` из Lua 5.1 | `unsupported instruction: SELF` на GPO, `LOADNIL` на модуле; на тривиальном входе псевдокод пуст. **Не пригоден здесь для реконструкции** |
| [Coldzer0/LuaDecompiler](https://github.com/Coldzer0/LuaDecompiler) (AGPL-3.0) | Исходники Free Pascal/валидация проверены | **Не собран:** нет FPC/Lazarus; решение на GPO пока неизвестно |
| [coazy/luraph-v14.7-unwrap](https://github.com/coazy/luraph-v14.7-unwrap) (MIT) | Статический Node-экстрактор запущен на **GPO Luraph v13.x**, не на v14.7 | `expected 2 long-bracket literals, found 0`: ожидаемая несовместимость оболочек. Даже на v14.7 извлекает VM-байткод, **не исходный Lua**; включённый `sandbox.lua` выполняет распакованный код и здесь **не запускался** |
| [Melodieshusband/Luraph-v14.3-deobfuscator](https://github.com/Melodieshusband/Luraph-v14.3-deobfuscator) (Apache-2.0) | **Только статический** `luraph_decoder.py` на собственном защищённом образце upstream с заголовком v14.3 | Экстрактор выдал 380 240 байт **непрозрачного внутреннего потока**, не исходный Lua и не скрипт GPO; образец `sunjingwoo.lua` исключён из архивированного кода |

Кандидаты без кода/лицензии и несовместимые утилиты не приписываются к работоспособным решениям. Luraph v15.0/v15.1, MoonVeil, MoonSec V3, IronBrew и Prometheus остаются в [общем каталоге](../README.md#приоритетные-семейства-и-версии), но инструмент, восстанавливающий исследованные входы **GPO Luraph v13.x**, пока не подтверждён. Старые GPO Luraph v13.x и другие отвергнутые варианты описаны в [отрицательных результатах](game-recovery-2026-10-19.md#ограничения-отказы-и-отрицательные-проверки).

**Проверка репозитория:** `python3 scripts/verify_sources.py` (40 архивов), `python3 scripts/verify_results.py` (12 файлов и их SHA-256), `python3 -m unittest discover -s tests`, два Lua-макетных теста выше, ASTD/Ro-Ghoul-макеты, `luac` Lua 5.1 на трёх частичных файлах и `luau-compile --null` на всех 12 выходах. Здесь не проводилась попытка выдать диагностический псевдокод за готовый скрипт.
