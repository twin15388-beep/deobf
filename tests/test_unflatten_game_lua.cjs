'use strict';

// Run after: PDEOBF_ROOT=$(python3 scripts/prepare_pdeobf.py) node --test tests/test_unflatten_game_lua.cjs
const assert = require('node:assert/strict');
const test = require('node:test');
const path = require('node:path');
const { createRequire } = require('node:module');
const { makeUnflattener } = require('../scripts/unflatten_game_lua.cjs');

const root = process.env.PDEOBF_ROOT;
if (!root) throw new Error('set PDEOBF_ROOT to the path printed by scripts/prepare_pdeobf.py');
const load = createRequire(path.join(root, 'package.json'));
const engine = load('./src/index.js');
const { Interpreter } = load('./src/interp/interpreter.js');
const unfold = makeUnflattener(root).unfold;

function output(code) {
  const runtime = new Interpreter({ stepLimit: 10000 });
  runtime.execBlock(engine.parse(code).body, runtime.rootScope());
  return runtime.output;
}

function permutations(items) {
  if (items.length === 0) return [[]];
  return items.flatMap((item, at) => permutations(items.filter((_, pos) => pos !== at))
    .map((rest) => [item, ...rest]));
}

test('all branch orders preserve state updates within the same loop sweep', () => {
  for (const order of permutations([0, 1, 2, 3])) {
    const branches = order.map((index) => index === 3
      ? `if s == 3 then text = text .. "3"; break end`
      : `if ${index} == s then text = text .. "${index}"; s = ${index + 1} end`);
    const source = `local text = ""; local s = 0; while true do ${branches.join(' ')} end; print(text)`;
    const result = unfold(source);
    assert.equal(result.counts.numericLoops, 1);
    assert.equal(result.counts.remainingLoops, 0);
    assert.doesNotMatch(result.code, /while true/);
    assert.deepEqual(output(source), ['0123']);
    assert.deepEqual(output(result.code), output(source), `order=${order}`);
  }
});

test('nested do wrapper and a state read after the loop are retained safely', () => {
  const input = `local text = ""; local s = 0;
    while true do
      if s == 1 then text = text .. 'B'; break end
      if s == 0 then do text = text .. 'A'; s = 1 end end
    end
    print(text); print(s)`;
  const result = unfold(input);
  assert.equal(result.counts.numericLoops, 1);
  assert.match(result.code, /local s = 0/);
  assert.match(result.code, /s = 1/);
  assert.deepEqual(output(result.code), ['AB', '1']);
});

test('a provably one-shot loop retains early return and the outer scope', () => {
  const source = `local function check(flag)
    while true do
      if flag then return 'early' end
      local value = 'done'
      print(value)
      break
    end
    return 'late'
  end
  print(check(false)); print(check(true))`;
  const result = unfold(source);
  assert.equal(result.counts.oneShotLoops, 1);
  assert.deepEqual(output(result.code), output(source));
});

test('unknown exits, state reads inside actions, and cycles are not removed', () => {
  const inputs = [
    `local s = 0; while true do if s == 0 then s = 0 end; if s == 1 then break end end`,
    `local s = 0; while true do if s == 0 then print(s); s = 1 end; if s == 1 then break end end`,
    `while true do if x then break end; print('unknown'); break end`,
  ];
  for (const input of inputs) {
    const result = unfold(input);
    assert.equal(result.counts.numericLoops, 0);
    assert.equal(result.counts.oneShotLoops, 0);
    assert.equal(result.counts.remainingLoops, 1);
  }
});
