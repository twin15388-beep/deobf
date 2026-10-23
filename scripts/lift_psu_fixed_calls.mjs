#!/usr/bin/env node
// Static PSU -> Lua 5.1 lift with three *specific* CALL-handler corrections.
// Requires a separately obtained memcpython/PSU-Deobfuscator@7d955d4.
// No protected source or third-party implementation is stored in this repo.
// Usage: node scripts/lift_psu_fixed_calls.mjs <PSU-source-root> <input.lua> <output.luac>
// WARNING: A valid lifted chunk is NOT proof that the VM or game works. Run
// selected children with isolated mocks; never execute an untrusted top level.
import fs from 'node:fs';
import path from 'node:path';
import { pathToFileURL, fileURLToPath } from 'node:url';
import { repairMultireturnCall } from './lift_psu_multireturn.mjs';

// The exact VM handler calls R[t0] with R[t0+1] (one argument), even though
// upstream calls it "none" because its matcher expects the opposite sum order.
const ONE_ARG_NO_RESULT =
  'local t0=I.A;R[t0](R[(1+t0)]);for t1=t0,v_i do R[t1]=nil end';
// TOP is assigned by the *results* packer, NOT read for this call's arguments.
const ONE_ARG_MULTI_RESULT =
  'local t0=I.A;local t1,t2=v_h(R[t0](R[(t0+1)]));' +
  'TOP=((t2+t0)-1);for t3=t0,TOP do t2=(t2+1);R[t3]=t1[t2] end';

export function repairFixedCalls(instruction) {
  if (instruction.kind !== 'call') return null;
  if (instruction.normalized === ONE_ARG_NO_RESULT) {
    if (instruction.args !== 'none' || instruction.results !== 'none') {
      throw new Error('Unexpected classification of one-argument no-result handler');
    }
    instruction.args = 'one';
    return 'fixedOneArg';
  }
  if (instruction.normalized === ONE_ARG_MULTI_RESULT) {
    if (instruction.args !== 'top' || instruction.results !== 'multi') {
      throw new Error('Unexpected classification of one-argument multi-result handler');
    }
    instruction.args = 'one';
    return 'multiOneArg';
  }
  if (repairMultireturnCall(instruction)) return 'multireturn';
  return null;
}

function repairChunk(chunk, counts) {
  for (const instruction of chunk.instructions) {
    if (instruction.kind === 'unknown') {
      throw new Error('PSU lift contains an unknown instruction; refuse to guess');
    }
    const change = repairFixedCalls(instruction);
    if (change) counts[change] += 1;
  }
  for (const child of chunk.protos) repairChunk(child, counts);
}

async function main() {
  const [root, input, output] = process.argv.slice(2);
  if (!root || !input || !output || process.argv.length !== 5) {
    throw new Error('Usage: lift_psu_fixed_calls.mjs <PSU-root> <input.lua> <output.luac>');
  }
  const source = fs.readFileSync(input);
  if (source.length > 8_000_000 || !source.includes(Buffer.from('PSU|'))) {
    throw new Error('Expected a bounded PSU-protected Lua source');
  }
  const importFrom = (file) => import(pathToFileURL(path.resolve(root, 'src', file)).href);
  const { analyzeWrapper } = await importFrom('core/wrapperAnalyzer.js');
  const { decodePayload } = await importFrom('core/payload.js');
  const { decodeChunkPayload } = await importFrom('core/chunkDecoder.js');
  const { classifyHandlers, expandSuperinstructions, scoreChunkSemantics } =
    await importFrom('core/handlerClassifier.js');
  const { lowerToLua51 } = await importFrom('ir/lua51Lowerer.js');
  const { writeLua51Chunk } = await importFrom('bytecode/lua51Writer.js');

  const script = source.toString('latin1');
  const analysis = classifyHandlers(analyzeWrapper(script));
  const decoded = decodeChunkPayload(decodePayload(script), analysis.tags,
    (chunk) => scoreChunkSemantics(chunk, analysis));
  const expanded = expandSuperinstructions(decoded.chunk, analysis);
  const counts = { fixedOneArg: 0, multiOneArg: 0, multireturn: 0 };
  repairChunk(expanded, counts);
  if (!counts.fixedOneArg || !counts.multiOneArg) {
    throw new Error('Required exact one-argument CALL handlers were not found');
  }
  const bytecode = writeLua51Chunk(lowerToLua51(expanded));
  fs.writeFileSync(output, bytecode);
  console.log(`Lifted ${bytecode.length} bytes; corrected ` +
    `${counts.fixedOneArg} fixed one-arg, ${counts.multiOneArg} multi-result ` +
    `one-arg and ${counts.multireturn} other CALLs. Behavior remains unverified.`);
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main().catch((error) => { console.error(error); process.exitCode = 1; });
}
