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

## 8. `Deobfuscator-Luraph-V15` под Linux (bin/luau, bin/luau-ast)

В релизе лежат только `luau.exe`/`luau-ast.exe`, поэтому deob.js падал `luau-ast ENOENT`.
Сборка из `luau-lang/luau` 0.744 без cmake:

```bash
# bin/luau (раннер из deobf-report/tools/luau_runner.cpp)
g++ -std=c++17 -O1 $INC -c luau_runner.cpp -o obj/luau_runner.o
g++ -o bin/luau obj/luau_runner.o $(ls obj/*.o | grep -v luau_runner) -lm -ldl -lpthread

# bin/luau-ast (JSON-дамп AST)
g++ -std=c++17 -O1 $INC -o bin/luau-ast \
    luau-src/CLI/src/Ast.cpp luau-src/Analysis/src/AstJsonEncoder.cpp \
    luau-src/CLI/src/FileUtils.cpp luau-src/Ast/src/PrettyPrinter.cpp \
    luau-src/Ast/src/Allocator.cpp flags_stub.cpp locstub.cpp \
    $(ls obj/*.o | grep -vE "luau_runner|PrettyPrinter|Allocator") -lm -ldl -lpthread
```

Стабы (без них линковка падает):

```cpp
// flags_stub.cpp
#include "Luau/Common.h"
LUAU_FASTFLAGVARIABLE(LuauExperimentalIfLocalAnalysis);
// locstub.cpp
#include <string>
#include "Luau/Location.h"
namespace Luau { std::string toString(const Location&, int, bool) { return ""; } }
```

Плюс в `src/driver.js` добавлен проброс prelude через env (нужно, чтобы подделать `game.PlaceId`
для скриптов с проверкой места):

```js
if (process.env.GAME_PLACEID) cfg.prelude = `setprop(game, 'PlaceId', ${process.env.GAME_PLACEID})`;
if (process.env.PRELUDE) cfg.prelude = process.env.PRELUDE;
```

## 9. `CASCADE` (IronBrew/AztupBrew): девиртуализация доходит до конца

Три правки в `_work/tools/CASCADE`:

1. `obfuscators/ironbrew/devirtualize.js` — два места с `throw "ayo"` (несовпавшая
   sub-инструкция и несовпавшая инструкция) заменены на лог + `continue`.
   Раньше девиртуализация падала на середине, теперь доходит до `RETURN`
   (`output.luac` на `Blox Piece 232.lua`: 211 B → 25 831 B).

2. `utility/binary.js`, `writeChunkHeader` — **nups всегда писался нулём**, а
   `is_vararg` — константой `2` (`VARARG_NEEDSARG` без `VARARG_HASARG`).
   Из-за этого `luaG_checkcode` ругался `bad code`, а unluac — `Index N out of bounds`.
   Теперь:
   ```js
   // nups по фактическим GETUPVAL(4)/SETUPVAL(8)
   let upvalue_count = 0
   for (...) if ((ins.OpCode === 4 || ins.OpCode === 8) && typeof ins.B === "number")
       upvalue_count = Math.max(upvalue_count, ins.B + 1)
   buffer.writeUInt8(upvalue_count)
   buffer.writeUInt8(chunk.Parameters)
   buffer.writeUInt8(1)   // is_vararg = VARARG_ISVARARG
   ```

3. `maxstacksize` — вместо жёсткого `250` считается `luac_fix.py` уже постфактум
   (см. §10): CASCADE не знает реальных регистровых диапазонов `CALL/RETURN/SETLIST/...`.

## 10. Свой Lua 5.1.1 и «ремонт» чанков (`tools/`)

`lua/lua` на GitHub тега 5.1.5 не имеет — собран 5.1.1 (`_work/tools/lua51`):

```bash
gcc -O2 -w -DLUA_USE_POSIX -DLUA_USE_DLOPEN -o lua lua.c $(ls *.c | grep -v '^lua.c$') -lm -ldl
```

* `make linux` в 5.1.1 отсутствует, `-DLUA_USE_LINUX` требует `readline/readline.h`
  (его нет) → собираем с `LUA_USE_POSIX`; в `luaconf.h` добавлен дефолт `LUA_ROOT`.
* IronBrew/Xen-скрипты требуют `bit.bxor`, которого в ванильном 5.1 нет →
  `_work/tools/lua51/bit.lua` (чистый Lua, 32-бит) + обёртка `luarun`
  (`LUA_INIT=@.../bit.lua exec .../lua`), символическая ссылка `/usr/local/bin/lua`.

Новые инструменты в `deobf-report/tools/` (все — самостоятельные CLI):

| файл | что делает |
|---|---|
| `luac32to64.py` | перепаковывает чанк Lua 5.1 из 32-битного формата (`sizeof(size_t)=4`, как пишет CASCADE) в 64-битный; без него `loadfile` → `bad header in precompiled chunk` |
| `luac_inspect.py` | разбирает чанк, печатает дерево прототипов/инструкции и находит ошибки: регистры ≥ maxstack, константы вне диапазона, `CALL C=0` без «открывающей» инструкции, прыжки за пределы кода, `GETUPVAL` при `nups=0`, отсутствие `RETURN` |
| `luac_fix.py` | пересчитывает `maxstacksize` (по реальным регистровым операндам + диапазоны `CALL/RETURN/SETLIST/TFORLOOP/FORPREP/LOADNIL/CONCAT/SELF`), `nups` и `is_vararg` прямо в байтах чанка |
| `chunk_parts.py` | вытаскивает «имена партов»/классы Roblox/ссылки из строковых констант чанка — работает даже если чанк не грузится |
| `batch_ib.sh`, `postprocess_ib.sh` | прогон CASCADE по корпусу IronBrew и полный пост-процессинг (fix → 64 бит → проверка загрузки → unluac → PARTS.md) |
