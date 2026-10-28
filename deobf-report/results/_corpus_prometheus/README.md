# Проверка инструмента unprom (Prometheus + ребренды)

6 эталонных сэмплов из `1-3-7/disrobe` (`corpus/lua/obfuscators/*`, `corpus/lua/prometheus/*`),
прогнаны через `_work/tools/unprom/unprom.py` без правок.

| Файл | Что это | Результат |
|---|---|---|
| `obfuscators_hello.prometheus.lua` | Prometheus, hello-world | 986 строк, снят WrapInFunction, ConstantArray, EncryptStrings |
| `obfuscators_wearedevs_real_sample.lua` | ребренд wearedevs v1.0.0 | 1 027 строк |
| `obfuscators_luaobfuscator_com_sample_default_obf_v1.lua` | luaobfuscator.com | 1 392 строки (в 3-й итерации падал — теперь проходит) |
| `prometheus_medium_obfuscated.lua` | Medium preset | 922 строки |
| `prometheus_vmify_nested_obfuscated.lua` | Vmify + вложенность | 577 строк |
| `prometheus_vmify_upvalue_obfuscated.lua` | Vmify + upvalue | 100 строк |

Важно: `Vmify`-сэмплы разворачиваются в **плоский CFG** (блоки `while`/`if pos < K`), а не в исходный
структурированный Lua — лифтер `--devirt lift` в этой сборке unprom не поддерживается
(флаг принимается молча, результат идентичен обычному прогону). Строки, константные массивы и
арифметика при этом восстанавливаются полностью, поэтому код читается, но это всё ещё «расплющенная» VM.
