#!/usr/bin/env node
// Static PSU bytecode lift with a *narrow* correction to CALL classification.
// Requires a separately obtained copy of memcpython/PSU-Deobfuscator@7d955d4.
// No protected script or third-party implementation is shipped in this repo.
// Usage: node scripts/lift_psu_multireturn.mjs <PSU-source-root> <input.lua> <output.luac>
import fs from 'node:fs';
import path from 'node:path';
import { pathToFileURL, fileURLToPath } from 'node:url';

export function repairMultireturnCall(instruction) {
  if (instruction.kind !== 'call') return false;
  const text = instruction.normalized ?? '';
  // The VM collects *multiple* return values and sets TOP from their count.
  // The argument packer, by contrast, reads a fixed range ending at I.B.
  // Upstream's name-specific "v_h(" test misses renamed result unpackers (v_U
  // for this GPO), and its args classifier mistakes result TOP for argument TOP.
  const fixedArgs = /R\[t0\]\(v_[A-Za-z0-9_]+\(R,\(t0\+1\),I\.B\)/.test(text);
  const multiResult = /local t\d+,t\d+=v_[A-Za-z0-9_]+\(R\[t0\]\(/.test(text)
    && /TOP=\(\(t\d+\+t0\)-1\)/.test(text);
  if (!fixedArgs && !multiResult) return false;
  let changed = false;
  if (fixedArgs && instruction.args === 'top') {
    instruction.args = 'b';
    changed = true;
  } else if (fixedArgs && instruction.args !== 'b') {
    throw new Error('Unexpected upstream CALL argument classification');
  }
  if (multiResult && instruction.results === 'none') {
    instruction.results = 'multi';
    changed = true;
  } else if (multiResult && instruction.results !== 'multi') {
    throw new Error('Unexpected upstream CALL return classification');
  }
  return changed;
}

function repairChunk(chunk) {
  let changes = 0;
  for (const instruction of chunk.instructions) {
    if (instruction.kind === 'unknown') {
      throw new Error('PSU lift contains an unknown instruction; refuse to guess');
    }
    if (repairMultireturnCall(instruction)) changes += 1;
  }
  for (const child of chunk.protos) changes += repairChunk(child);
  return changes;
}

async function main() {
  const [root, input, output] = process.argv.slice(2);
  if (!root || !input || !output || process.argv.length !== 5) {
    throw new Error('Usage: lift_psu_multireturn.mjs <PSU-source-root> <input.lua> <output.luac>');
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
  const changes = repairChunk(expanded);
  if (changes === 0) throw new Error('No matching misclassified CALL handlers; no output emitted');
  const bytecode = writeLua51Chunk(lowerToLua51(expanded));
  fs.writeFileSync(output, bytecode);
  console.log(`Lifted ${bytecode.length} bytes; corrected ${changes} CALL classifications. ` +
    'The bytecode is diagnostic until isolated behavior is checked.');
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main().catch((error) => { console.error(error); process.exitCode = 1; });
}
