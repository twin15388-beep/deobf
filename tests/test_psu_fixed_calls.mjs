// Pure unit tests for narrow classification corrections; no protected input.
import assert from 'node:assert/strict';
import { repairFixedCalls } from '../scripts/lift_psu_fixed_calls.mjs';

const cases = [
  {
    normalized: 'local t0=I.A;R[t0](R[(1+t0)]);for t1=t0,v_i do R[t1]=nil end',
    args: 'none', results: 'none', expected: 'fixedOneArg', finalArgs: 'one'
  },
  {
    normalized: 'local t0=I.A;local t1,t2=v_h(R[t0](R[(t0+1)]));' +
      'TOP=((t2+t0)-1);for t3=t0,TOP do t2=(t2+1);R[t3]=t1[t2] end',
    args: 'top', results: 'multi', expected: 'multiOneArg', finalArgs: 'one'
  },
  {
    normalized: 'local t0=I.A;local t1,t2=v_h(R[t0](v_t(R,(t0+1),I.B)));' +
      'TOP=((t2+t0)-1);for t3=t0,TOP do t2=(t2+1);R[t3]=t1[t2] end',
    args: 'top', results: 'none', expected: 'multireturn', finalArgs: 'b'
  },
];
for (const item of cases) {
  const handler = {kind:'call', normalized:item.normalized,
    args:item.args, results:item.results};
  assert.equal(repairFixedCalls(handler), item.expected);
  assert.equal(handler.args, item.finalArgs);
  assert.equal(handler.results, item.expected === 'multireturn' ? 'multi' : item.results);
}
assert.equal(repairFixedCalls({kind:'move'}), null);
assert.equal(repairFixedCalls({kind:'call', normalized:'unrelated', args:'b', results:'none'}), null);
assert.throws(() => repairFixedCalls({kind:'call', normalized:cases[0].normalized,
  args:'b', results:'none'}), /Unexpected classification/);
assert.throws(() => repairFixedCalls({kind:'call', normalized:cases[1].normalized,
  args:'top', results:'one'}), /Unexpected classification/);
console.log('PSU fixed-call narrow classifications: 5 cases');
