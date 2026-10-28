import test from 'node:test';
import assert from 'node:assert/strict';
import { repairMultireturnCall } from '../scripts/lift_psu_multireturn.mjs';

const fixedArgs = 'R[t0](v_d(R,(t0+1),I.B))';
const result = 'local t1,t2=v_U(R[t0](v_d(R,(t0+1),I.B)));' +
  'TOP=((t2+t0)-1);for t3=t0,TOP do t2=(t2+1);R[t3]=t1[t2] end';

test('a renamed unpacker retains all return values without losing the fixed arg range', () => {
  const item = { kind: 'call', normalized: result, args: 'top', results: 'none' };
  assert.equal(repairMultireturnCall(item), true);
  assert.deepEqual([item.args, item.results], ['b', 'multi']);
  assert.equal(repairMultireturnCall(item), false); // idempotent
});

test('a fixed-argument call that writes TOP elsewhere must not become a top-arg call', () => {
  const item = { kind: 'call', normalized: 'R[t0]=' + fixedArgs + ';TOP=((t2+t0)-1)',
    args: 'top', results: 'one' };
  assert.equal(repairMultireturnCall(item), true);
  assert.deepEqual([item.args, item.results], ['b', 'one']);
});

test('a genuine top-argument call can have renamed multi-return unpacking', () => {
  const item = { kind: 'call', normalized: result.replace('I.B', 'TOP'),
    args: 'top', results: 'none' };
  assert.equal(repairMultireturnCall(item), true);
  assert.deepEqual([item.args, item.results], ['top', 'multi']);
});

test('unrelated calls are untouched and unexpected classifications are rejected', () => {
  assert.equal(repairMultireturnCall({ kind: 'move', normalized: result }), false);
  assert.equal(repairMultireturnCall({ kind: 'call', normalized: 'R[t0]=R[t0]()',
    args: 'none', results: 'one' }), false);
  assert.throws(() => repairMultireturnCall({ kind: 'call', normalized: result,
    args: 'one', results: 'none' }), /argument classification/);
});
