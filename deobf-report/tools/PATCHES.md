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
