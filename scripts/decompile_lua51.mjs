// Reproducible, static bytecode -> Lua step for the pinned VM samples.
// Install unluac-js@1.4.4 under scripts/ first (see results README).
// This does NOT load/execute the recovered Lua or the protected input.
import {decompileRich} from 'unluac-js';
import {readFile, writeFile} from 'node:fs/promises';

if (process.argv.length !== 4) {
  console.error('usage: node scripts/decompile_lua51.mjs INPUT.luac OUTPUT.lua');
  process.exit(2);
}
const [, , input, output] = process.argv;
const bytecode = await readFile(input);
const result = await decompileRich(bytecode, {
  dialect: 'lua5.1',
  parse: {mode: 'strict'},
});
if (result.kind !== 'source' || !result.source
    || result.source.includes('[unluac error]')) {
  throw new Error(`Refusing incomplete decompilation: ${result.kind}`);
}
await writeFile(output, result.source, 'utf8');
console.log(`Recovered ${result.protos?.length ?? 'unknown'} Lua 5.1 prototypes → ${output}`);
