'use strict';

// Conservative post-pass for the small numeric-state loops emitted by
// LuaObfuscator Alpha and similar source-to-source flatteners. The INPUT is
// parsed, never executed. The parser/printer come from the pinned pdeobf ZIP.
const fs = require('node:fs');
const path = require('node:path');
const { createRequire } = require('node:module');

function makeUnflattener(engineRoot) {
  const engineRequire = createRequire(path.join(engineRoot, 'package.json'));
  const engine = engineRequire('./src/index.js');
  const ast = engineRequire('./src/lua/ast.js');
  const { walk } = engineRequire('./src/lua/walk.js');
  const { resolve } = engineRequire('./src/lua/scope.js');
  const K = ast.Kind;

  function nodes(node, predicate) {
    let found = false;
    walk(node, {
      enter(one) {
        if (predicate(one)) found = true;
      },
    });
    return found;
  }

  // A break inside a nested loop belongs to that loop, not to the loop
  // currently being lifted. Never alter a loop with other jump targets.
  function hasOuterJump(node) {
    if (node.kind === K.Break || node.kind === K.Continue || node.kind === K.Goto
      || node.kind === K.Label) return true;
    let jump = false;
    walk(node, {
      enter(one) {
        if (one !== node && (one.kind === K.Function || one.kind === K.While
          || one.kind === K.Repeat || one.kind === K.NumericFor
          || one.kind === K.GenericFor)) return false;
        if (one.kind === K.Break || one.kind === K.Continue || one.kind === K.Goto
          || one.kind === K.Label) jump = true;
      },
    });
    return jump;
  }

  function stateTest(node) {
    const expr = ast.unparen(node);
    if (!expr || expr.kind !== K.Binary || expr.operator !== '==') return null;
    const left = ast.unparen(expr.lhs);
    const right = ast.unparen(expr.rhs);
    const pairs = [[left, right], [right, left]];
    for (const [name, literal] of pairs) {
      if (name.kind === K.Name && name.binding && name.binding.kind === 'local'
        && literal.kind === K.Number && Number.isSafeInteger(literal.value)) {
        return { name: name.name, binding: name.binding, number: literal.value };
      }
    }
    return null;
  }

  function initializer(statements, at, binding) {
    // A flattening variable is set immediately before its loop. A few
    // uninitialised local declarations may be interleaved by the formatter.
    for (let i = at - 1; i >= Math.max(0, at - 5); i -= 1) {
      const statement = statements[i];
      if (statement.kind !== K.LocalDeclaration) return null;
      if (statement.names.length === 1 && statement.bindings[0] === binding
        && statement.expressions.length === 1
        && ast.unparen(statement.expressions[0]).kind === K.Number
        && Number.isSafeInteger(ast.unparen(statement.expressions[0]).value)) {
        return { index: i, number: ast.unparen(statement.expressions[0]).value };
      }
      if (statement.expressions.length > 0) return null;
    }
    return null;
  }

  function transition(body, binding) {
    const statements = body.statements;
    if (!statements.length) return null;
    const last = statements[statements.length - 1];
    // An earlier de-flattened nested loop may leave the state assignment
    // inside a single do block. Preserve that block and its scope.
    const doTail = last.kind === K.Do ? last.body.statements : null;
    const action = doTail && doTail.length ? doTail[doTail.length - 1] : last;
    let next;
    let terminal = false;
    if (action.kind === K.Assignment && action.targets.length === 1
      && action.expressions.length === 1 && action.targets[0].kind === K.Name
      && action.targets[0].binding === binding
      && ast.unparen(action.expressions[0]).kind === K.Number
      && Number.isSafeInteger(ast.unparen(action.expressions[0]).value)) {
      next = ast.unparen(action.expressions[0]).value;
    } else if (!doTail && (last.kind === K.Break || last.kind === K.Return)) {
      terminal = true;
    } else {
      return null;
    }
    const earlier = [...statements.slice(0, -1), ...(doTail || []).slice(0, -1)];
    for (const statement of earlier) {
      if (nodes(statement, (n) => n.kind === K.Name && n.binding === binding)
        || hasOuterJump(statement)) return null;
    }
    return { next, terminal, statements };
  }

  function stateMachine(statements, at, loop) {
    if (loop.condition.kind !== K.True) return null;
    const items = loop.body.statements;
    if (items.length < 2 || !items.every((one) => one.kind === K.If
      && !one.elseBody && (!one.elseIfs || !one.elseIfs.length))) return null;
    const first = stateTest(items[0].condition);
    if (!first) return null;
    const init = initializer(statements, at, first.binding);
    if (!init) return null;
    const arms = [];
    const seen = new Set();
    for (const item of items) {
      const test = stateTest(item.condition);
      if (!test || test.binding !== first.binding || seen.has(test.number)) return null;
      seen.add(test.number);
      const tail = transition(item.body, first.binding);
      if (!tail) return null;
      arms.push({ number: test.number, ...tail });
    }

    // Lua tests the arms in textual order, even after an earlier arm updates
    // the state. Simulate that order, including transitions across sweeps.
    const output = [];
    const starts = new Set();
    let state = init.number;
    for (let sweep = 0; sweep < 128; sweep += 1) {
      if (starts.has(state)) return null; // real loop (or undecidable cycle)
      starts.add(state);
      let progress = false;
      for (const arm of arms) {
        if (arm.number !== state) continue;
        progress = true;
        const last = arm.statements[arm.statements.length - 1];
        const body = arm.statements.slice(0, -1);
        if (last.kind === K.Return) body.push(last);
        // Keep the assignment until we have established the state is purely
        // a dispatcher, not an observable local captured outside the loop.
        if (!arm.terminal) body.push(last);
        if (body.length) output.push(ast.doStatement(ast.block(body)));
        if (arm.terminal) {
          const loopNames = new Set();
          walk(loop, {
            enter(one) {
              if (one.kind === K.Name && one.binding === first.binding) loopNames.add(one);
            },
          });
          const outside = first.binding.captured
            || first.binding.reads.some((node) => !loopNames.has(node))
            || first.binding.writes.some((node) => !loopNames.has(node));
          if (!outside) {
            // The dispatcher assignments are no longer needed. These are
            // direct final assignments, never side-effectful expressions.
            for (const item of output) {
              const list = item.body.statements;
              if (!list.length) continue;
              let tail = list[list.length - 1];
              if (tail.kind === K.Do && tail.body.statements.length) {
                const inner = tail.body.statements;
                const assignment = inner[inner.length - 1];
                if (assignment.kind === K.Assignment && assignment.targets.length === 1
                  && assignment.targets[0].kind === K.Name
                  && assignment.targets[0].binding === first.binding) {
                  inner.pop();
                  if (!inner.length) list.pop();
                }
              } else if (tail.kind === K.Assignment && tail.targets.length === 1
                && tail.targets[0].kind === K.Name
                && tail.targets[0].binding === first.binding) {
                list.pop();
              }
            }
          }
          return { output, initializer: outside ? null : init.index };
        }
        state = arm.next;
      }
      if (!progress) return null; // no matching branch: original spins
    }
    return null;
  }

  function oneShot(loop) {
    if (loop.condition.kind !== K.True) return null;
    const body = loop.body.statements;
    if (!body.length || body[body.length - 1].kind !== K.Break) return null;
    for (const statement of body.slice(0, -1)) {
      if (hasOuterJump(statement)) return null;
    }
    return ast.doStatement(ast.block(body.slice(0, -1)));
  }

  function unfold(source) {
    const chunk = engine.parse(source);
    resolve(chunk);
    const counts = { numericLoops: 0, oneShotLoops: 0, remainingLoops: 0 };
    walk(chunk, {
      leave(node) {
        if (node.kind !== K.Block) return;
        const list = node.statements;
        for (let at = 0; at < list.length; at += 1) {
          const loop = list[at];
          if (loop.kind !== K.While) continue;
          const machine = stateMachine(list, at, loop);
          if (machine) {
            list.splice(at, 1, ...machine.output);
            if (machine.initializer !== null) {
              list.splice(machine.initializer, 1);
              at -= 1;
            }
            at += machine.output.length - 1;
            counts.numericLoops += 1;
            continue;
          }
          const once = oneShot(loop);
          if (once) {
            list[at] = once;
            counts.oneShotLoops += 1;
          } else {
            counts.remainingLoops += 1;
          }
        }
      },
    });
    const result = engine.unparse(chunk);
    // The same parser must accept the output (we only publish real Lua).
    engine.parse(result);
    return { code: result, counts };
  }

  return { unfold };
}

if (require.main === module) {
  if (process.argv.length !== 5) {
    console.error('usage: node scripts/unflatten_game_lua.cjs ENGINE_ROOT in.lua out.lua');
    process.exitCode = 2;
  } else {
    const [, , root, input, output] = process.argv;
    // pdeobf represents Lua source as byte-valued JS strings; UTF-8 input
    // must be loaded as latin1 and written back as latin1 to keep escapes and
    // non-ASCII Roblox labels byte-for-byte stable.
    const result = makeUnflattener(root).unfold(fs.readFileSync(input, 'latin1'));
    fs.writeFileSync(output, result.code, 'latin1');
    console.error(JSON.stringify(result.counts));
  }
}

module.exports = { makeUnflattener };
