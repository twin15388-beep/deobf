#!/usr/bin/env python3
"""Replace the single three-label fallthrough emitted for ANCH Hax by pdeobf.

This is deliberately NOT a general goto remover. All three labels are adjacent,
all three jumps target the same `return`, and there is no work in their `else`
branches. For any different input the transform refuses to write an output.
Neither the input nor its dependencies are executed.
"""

from pathlib import Path
import sys

BEFORE = '''          return v213(p9, unpack(v216))
        else
          ::L5333832::
          ::L6835924::
          ::L10523329::
          return v213(p9, ...)
        end
      else
        goto L5333832
      end
    else
      goto L6835924
    end
  else
    goto L10523329
  end
end)))'''
AFTER = '''          return v213(p9, unpack(v216))
        end
      end
    end
  end

  return v213(p9, ...)
end)))'''


def repair(source: str) -> str:
    if source.count(BEFORE) != 1:
        raise ValueError("ANCH Hax callback does not have the expected label layout")
    # The only goto/label pair in this source is the one handled above.
    if source.count("goto ") != 3 or source.count("::L") != 3:
        raise ValueError("additional jumps require a separate control-flow audit")
    return source.replace(BEFORE, AFTER)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("usage: python3 scripts/repair_violence_district_goto.py in.lua out.lua")
    input_file, output_file = map(Path, sys.argv[1:])
    output_file.write_bytes(repair(input_file.read_bytes().decode("utf-8")).encode("utf-8"))
