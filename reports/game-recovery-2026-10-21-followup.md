# GPO: восстановление двух обработчиков и исправление PSU-лифта — 21 октября 2026

**Результат:** улучшен существующий частичный [Grand Piece Online — Lunar Hub](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua), **16 606 байт / 327 строк**, SHA-256 `a5063f297e7e6d06ff3d449db1c1df799411a804e4cd8f156a0b29fa7947e0ac`. Параметры и сами функции описаны [рядом с кодом](../dobf%20scripts%201.0/README.md). Это **не восстановленный целиком хаб и не готовый автономный автофарм**. Прочие 11 опубликованных файлов десяти игр сохранены. Исходный защищённый [`c0deblox/Scripts:GPO.lua@472dc587`](https://github.com/c0deblox/Scripts/blob/472dc5871faae68dfcfbba6485a619275063ee16/GPO.lua), SHA-256 `0f6a4be8f4477de671068d6b19977088281e9fc098a00f72b5c53bf3f0320f30`, не запускался (как и любой top-level восстановленного хаба). Права на сторонний скрипт не проверены.

## Почему раньше ломались бочки и как это исправлено

`memcpython/PSU-Deobfuscator@7d955d4d8e3bc14b744dc4afd52118787fc2bda4` статически выдаёт 48 400 байт Lua 5.1, SHA-256 `fe7dc0be0ad15266fd53765c2e53d60c4a4c61277696a93cc50cad3e06542241`. Прототип Barrels **#72 / `0_56`** в таком байткоде не исполнялся: `math.floor` получал **function** вместо числа. Причина оказалась в **классификации CALL обработчика VM**, а не в моках. Нормализованный VM-обработчик вызывает `R[t0](v_d(R,(t0+1),I.B))`, затем упаковщик многозначного результата (в этом входе переименован из ожидаемого инструментом `v_h` в `v_U`) записывает возвращённые значения в регистры и меняет `TOP`. Upstream классифицировал аргументы как `top` из-за присутствия слова `TOP` **в части результатов**, а результаты как `none`, потому что распознавал только имя `v_h`. В результате появились `CALL R2 0 1; CALL R1 0 2`, отбрасывавшие числовое значение.

Опубликован [узкий собственный постпроход по IR](../scripts/lift_psu_multireturn.mjs): **не изменяя upstream**, он распознаёт фиксированную границу аргументов `I.B` отдельно от записи `TOP` и переименованный упаковщик результатов, правит классификации перед записью Lua 5.1 chunk. На данном GPO исправлены **22 CALL-классификации**, длина остаётся 48 400 байт, SHA-256 нового диагностического байткода `07e7b0509484109009e887c5a8da8c3976788840be5e5028ec72aedf9a804974`. Для Barrels это стало `CALL R2 16 0; CALL R1 0 2` (и аналогично на обратном маршруте): первый вызов сохраняет многозначный результат и задаёт TOP, второй передаёт его в `math.floor`. Воспроизводимые тесты этого постпрохода: [tests/test_lift_psu_multireturn.mjs](../tests/test_lift_psu_multireturn.mjs). `unluac-js@1.4.4` по-прежнему даёт **диагностический**, а не пригодный для публикации полный файл: ошибок стало **24 вместо 49**. **Правильность исправления всей исходной VM, а не выбранных функций, не доказана.**

## Сами новые игровые функции: параметры, назначение и предел

| Восстановленная функция в частичном модуле | Выбранный прототип | Параметры и эффект | Проверено / не обещается |
| --- | --- | --- | --- |
| `calculateFromTo(fromX,fromY,fromZ,toX,toY,toZ)` | #11 / `0_9` | Расстояние между двумя точками `Vector3` / `_G.speed`; вместо первого или четвёртого аргумента допустим userdata-CFrame, берутся `.X/.Y/.Z`; лишняя ориентация игнорируется исходной функцией с шестью параметрами | Три набора чисел/userdata сверены с отделённым байткодом #11; требует корректной `_G.speed` и Roblox-совместимых `Vector3` |
| `tweenAboveNpc(targetNpc)` | #22 / `0_16` с upvalue `LocalPlayer` | Считает время до `targetNpc.HumanoidRootPart.CFrame`; переносит игрока Tween на **3 студа над `Head.CFrame` и 5 позади `lookVector`**, ждёт завершения и снимает `_G.teleporting`; этот прототип вызывается из исходного цикла NPC #84 | Два сценария и userdata-время сравнены с байткодом #22/#9; **не** выбирает NPC, не атакует и не включает цикл NPC |
| `normalBarrelLoop(enabled,deps)` | #72 / `0_56` с UI-upvalue | `enabled` устанавливает `getgenv().ON`; считает два плеча ETA, показывает `deps.banner({Text=...})`; пока ON, идёт к **(-561.834045, 11.9474373, -4466.64453)**, ждёт и отправляет `Events.Barrel:FireServer({action="Buy",barrelType="Normal"})`, затем к **(-4497.41309, 5.98184872, -2668.52979)** и отправляет `Sell` | Три исхода (одна покупка/продажа, флаг `good=true`, выключенный цикл) сверены **только с исправленным** выбранным байткодом. По умолчанию использует `teleportNumeric` при `getgenv().noclip=false`: дополнительные 9 аргументов поворота прототип #12 с тремя параметрами игнорирует; `deps.teleport` — необязательная подмена. Нужны `deps.banner`, `_G.speed`, изначально `getgenv().good=false`, `wait` и игровые объекты; нет GUI или полного пути `teleport` для userdata/noclip |

Реальный фрагмент **опубликованного кода**, не просто название обработчика (полная версия [в Lua-файле](../dobf%20scripts%201.0/Grand%20Piece%20Online%20-%20Lunar%20Hub%20%28partial%29.lua)):

```lua
local function normalBarrelLoop(enabled, deps)
    local move = deps.teleport or teleportNumeric
    getgenv().ON = enabled
    -- calculateFromTo + math.floor определяют ETA двух плеч маршрута;
    -- deps.banner показывает исходное сообщение UI при включённом ON.
    while getgenv().ON do
        wait()
        if getgenv().good == false then
            getgenv().good = true
            local _, travelTime = move(-561.834045, 11.9474373,
                -4466.64453, 0.0234939456, -5.12754212e-8,
                -0.999723971, -3.6866743e-9, 1, -5.13762188e-8,
                0.999723971, 4.8926867e-9, 0.0234939456)
            wait(travelTime)
            wait(1)
            game:GetService("ReplicatedStorage").Events.Barrel:FireServer({
                action = "Buy", barrelType = "Normal",
            })
            -- Потом: второе перемещение; wait(returnTime); wait(1);
            -- FireServer({action="Sell",barrelType="Normal"}); good=false.
        end
    end
end
```

Это **сокращённая цитата**: не копируйте её вместо полного кода — ETA и обратное плечо находятся в Lua-файле. Подмена `deps.teleport` **не обязательна**: при выключенном noclip работает локально восстановленный числовой `teleportNumeric`. Две 12-аргументные траектории бочек отдельно сравнены с прототипом #12: поднятый прототип объявляет лишь три параметра и не использует девять добавочных компонентов поворота. Однако **нельзя** объявить исходный `teleport()` восстановленным для всех путей (userdata/noclip остаются проблемными). При `getgenv().good=nil`, а не `false`, исходный `if good == false` тоже не совершает сделку. Синтетическая модульная оболочка и зависимость `deps` — наши изменения интерфейса, не авторский исходный скрипт.

## Байткод и воспроизведение

[scripts/extract_lua51_prototype.py](../scripts/extract_lua51_prototype.py) дополнен `--wrap-upvalues`: делает минимального синтетического родителя, принимающего явно переданные захваченные значения и возвращающего closure через `CLOSURE`/`MOVE`; **байты выбранного дочернего прототипа не меняются**. Для NPC вводится макет `LocalPlayer`, для бочек — макет UI-таблицы с `Banner`. Прототип #22 до/после исправления одинаковый: 945 байт / SHA-256 `1779994f62cb6445b4f80436958b6f7d25fb31b77e532fd4158fa4a8f2e031f8`. Прототип #72 — **исправленный** ребёнок размером 1421 байт / SHA-256 `242dfcba868812f05553f22779e71ebf41f5841fb3fb5c7a64f8dd22a0aefc32`; он **отличается** от дефектного ребёнка в исходном лифте. `tests/test_extract_lua51_prototype.py` побайтово проверяет сохранение выбранного ребёнка при 1 и 7 upvalue.

После отдельного получения того же защищённого входа и исходников PSU по зафиксированному коммиту (проверить SHA-256 входа, **не исполнять** top-level GPO):

```bash
node scripts/lift_psu_multireturn.mjs /path/to/PSU-Deobfuscator \
  /path/to/GPO.lua /tmp/GPO-fixed.luac
python3 scripts/extract_lua51_prototype.py /tmp/GPO-fixed.luac 0_7 /tmp/gpo-time.luac
python3 scripts/extract_lua51_prototype.py /tmp/GPO-fixed.luac 0_9 /tmp/gpo-fromto.luac
python3 scripts/extract_lua51_prototype.py /tmp/GPO-fixed.luac 0_10 /tmp/gpo-teleport.luac
python3 scripts/extract_lua51_prototype.py /tmp/GPO-fixed.luac 0_16 /tmp/gpo-npc.luac --wrap-upvalues
python3 scripts/extract_lua51_prototype.py /tmp/GPO-fixed.luac 0_56 /tmp/gpo-barrels.luac --wrap-upvalues
lua5.1 tests/test_gpo_npc_tween.lua \
  'dobf scripts 1.0/Grand Piece Online - Lunar Hub (partial).lua' \
  /tmp/gpo-time.luac /tmp/gpo-npc.luac
lua5.1 tests/test_gpo_barrels.lua \
  'dobf scripts 1.0/Grand Piece Online - Lunar Hub (partial).lua' \
  /tmp/gpo-fromto.luac /tmp/gpo-barrels.luac \
  /tmp/gpo-time.luac /tmp/gpo-teleport.luac
lua5.1 tests/test_gpo_teleport_numeric.lua \
  'dobf scripts 1.0/Grand Piece Online - Lunar Hub (partial).lua' \
  /tmp/gpo-time.luac /tmp/gpo-teleport.luac
node --test tests/test_lift_psu_multireturn.mjs
python3 -m unittest discover -s tests -p 'test_extract_lua51_prototype.py'
python3 scripts/verify_results.py
```

Макеты используют userdata через Lua 5.1 `newproxy` (проверка настоящей ветви `type(x)=="userdata"`), **не отправляют запросы в Roblox**. Для Barrels `wait()` подставной среды выключает флаг ON на первом цикле, позволяя измерить одну сделку; отдельно проверены уже занятый и отключённый варианты. Также сравнены **совместные** действия #72 → #12: два вызова remote (`Buy` и `Sell`), числовое движение до обеих точек (с ветвью спуска к Y=0) и время ожидания; семь числовых траекторий #12 включают два 12-аргументных вызова из Barrels. Не исполняются UI, защищённый top-level или реальная сеть. Числовые пути `teleportNumeric` и квесты из [первой итерации](game-recovery-2026-10-21.md) остаются отдельными тестами.

## Исследованные альтернативы и оставшиеся сбои

* `sztupy/luadec51@35cddc8` v2.0.2 из [лицензированного архива исходников](../sources/sztupy--luadec51.zip) собран против Lua 5.1: на целом **исходном** поднятом GPO завершился SIGSEGV, код 139, файл вывода пуст. `viruscamp/luadec@895d923` тоже падал на целом исходном байткоде. `unluac-js` даже с исправлением CALL оставляет 24 ошибки, включая open-pack в `teleport()`; целый декомпилированный хаб **не опубликован**.
* Для `Jeong-Min-Cho/unluac` проверены доступные runtime-пакеты `jdk4py` **17 и 21**: оба дают JRE без `javac`/`jdk.compiler`; сборка Java-исходников в этой среде не состоялась. Непрозрачный patched JAR без проверенного происхождения не запускался. Это не оценка `unluac` в полноценном JDK.
* Дефектный байткод Barrels исходного лифта **сам по себе не стал эталоном** и не выдаётся за рабочий. Сравнение сделано только после узкого исправления конкретной классификации CALL. Изолированное совпадение трёх трасс с исправленным лифтом **не доказывает** равенства защищённой VM, работоспособности сервера, безопасности или реальной прибыли в игре.

**Граница результата:** функция покупки/продажи, её параметры, точки, payload и проверки действительно опубликованы; числовой путь перемещения при выключенном noclip включён. Полный хаб, исходный UI, userdata/noclip-пути `teleport()` и автоколлекторы сундуков/NPC по-прежнему не восстановлены. Steal an Egg не обрабатывался.
