# Патчи, без которых инструменты не работают в этой песочнице

## 1. `Deobfuscator-Luraph-V15-master/src/devirt_bridge.py`

Без этого девиртуализация падает (`DummyArgs` не знает про `keep_harness`) и вместо кода
пишется behaviour trace.

```diff
     class DummyArgs:
         def __init__(self, d):
             for k, v in d.items():
                 setattr(self, k, v)
+
+        def __getattr__(self, name):
+            # атрибуты, которые JS-сторона передаёт не всегда (keep_harness, studio, ...)
+            return False
```

## 2. `PSU-Deobfuscator/src/cli.js`

Без JVM (`java`/`unluac.jar`) скрипт падал на этапе декомпайла и терял уже восстановленный
Lua 5.1 байткод.

```diff
-  const result = options.check
-    ? liftFile(options.input)
-    : deobfuscateFile(options.input, outputPath, options);
+  let result;
+  if (options.check) {
+    result = liftFile(options.input);
+  } else {
+    try {
+      result = deobfuscateFile(options.input, outputPath, options);
+    } catch (error) {
+      if (options.bytecode) {
+        result = liftFile(options.input);
+        console.error("decompile step failed (" + (error?.message || error) + "); bytecode only");
+      } else {
+        throw error;
+      }
+    }
+  }
```

## 3. Luau-рантайм вместо `bin/luau.exe` / `bin/luau-ast.exe`

`build_luau.sh` + `build_ast.sh` кладут `bin/luau` и `bin/luau-ast` (Linux) рядом с
`deob.js`. `luau_runner.cpp` — минимальный CLI, но с REPL-режимом по stdin, `require`,
`loadstring`, `warn`, `task.*`, `debug.profilebegin*` — без этого харнесс либо не стартует,
либо теряет долгоживущий HarnessServer и работает в разы медленнее.

## 4. `Prometheus-Deobfuscator` (не починен)

`pol.py` и `modules/vmify.py` содержат f-строки с `\` внутри выражений (валидно только с
Python 3.12). Даже после двух правок в `modules/vmify.py` остаётся синтаксически битая
строка (`'"...".encode("latin-1")...'`). Требуется Python 3.12+.

## 5. `axomtools/ironbrew2-deobfuscator` (не подходит для IB 2.7.2)

Репозиторий заявляет IronBrew 2.7.0/2.7.1/AztupBrew 2.7.2, но написан под другую версию
`luaparser`: в `utils/asttools.py` используются `node.obj` / `node.index`, а в `luaparser` 3.3 и 4.2
у `Index` поля называются `value` / `idx`. Патч:

```python
# utils/asttools.py
"Base": _convert_node(getattr(node, "obj", getattr(node, "value", None))),
"Index": _convert_node(getattr(node, "index", getattr(node, "idx", None))),
```

После патча разбор проходит, но `modules/luaengine/detect.py` не срабатывает на реальных IB 2.7.2:
его регулярки рассчитаны на обёртку вида `return f(true,{},g())`, а в наших файлах
`return f(true,{},g())(...)` с другим набором аргументов (`string.byte, table.insert, setmetatable`).
Инструмент оставлен в `_work/tools/ironbrew2-deobfuscator-main` (вне git).

## 6. `CASCADE` на IronBrew 2.7.2

`node index.js` требует `input.lua` и `npm i` (`chalk`). На IB 2.7.2 совпадает менее 10 инструкций,
на выходе `output.luac` размером 301 байт (пустой чанк) — девиртуализация не выполняется.

## 7. Свой `lua_beautify.py`

Первая версия приклеивала строчные комментарии друг к другу (`-- a -- b -- c<код>`), из-за чего
код после третьего комментария попадал в комментарий. Поймано встроенной проверкой «поток токенов
до == поток токенов после»; исправлено немедленным `flush()` после токена `comment`.
