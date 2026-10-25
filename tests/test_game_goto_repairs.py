"""Guards for the two narrowly scoped game-script control-flow repairs.

These do not attempt to run the recovered Roblox programs.
"""

import unittest

from pathlib import Path

from scripts.repair_prison_life_goto import (
    BEFORE as PRISON_BEFORE,
    REMOVED as PRISON_REMOVED,
    repair as repair_prison,
)
from scripts.repair_violence_district_goto import BEFORE, AFTER, repair as repair_violence
from scripts.repair_wild_horse_goto import repair as repair_wild_horse

ROOT = Path(__file__).resolve().parents[1]
# Either the name the pipeline produces or the one from a manual decoder run.
PRISON_CANDIDATES = (ROOT / "local-results/wad-out/Prison Life.decoded.raw.lua",
                     ROOT / "local-results/wad-out/prisonlife-raw.lua")
PRISON_RAW = next((path for path in PRISON_CANDIDATES if path.is_file()),
                  PRISON_CANDIDATES[0])
PRISON_PUBLISHED = ROOT / "dobf scripts 1.0/Prison Life - volmaks ESP Freecam.lua"


class GotoRepairTests(unittest.TestCase):
    def test_violence_repair_matches_only_known_fallthrough(self):
        self.assertEqual(repair_violence(BEFORE), AFTER)
        with self.assertRaisesRegex(ValueError, "layout"):
            repair_violence(BEFORE.replace("unpack(v216)", "unpack(other)"))
        with self.assertRaisesRegex(ValueError, "additional jumps"):
            repair_violence(BEFORE + "\ngoto ELSEWHERE")

    def test_wild_horse_repair_duplicates_only_wait_at_jump_site(self):
        before = (
            "if not found then\n"
            "      ::L13094772::\n"
            "      task.wait()\n"
            "else\n"
            "        f38(v99)\n"
            "        goto L13094772\n"
            "end\n"
        )
        expected = (
            "if not found then\n"
            "      task.wait()\n"
            "else\n"
            "        f38(v99)\n"
            "        task.wait()\n"
            "end\n"
        )
        self.assertEqual(repair_wild_horse(before), expected)
        with self.assertRaisesRegex(ValueError, "layout"):
            repair_wild_horse(before.replace("f38(v99)", "f38(other)"))
        with self.assertRaisesRegex(ValueError, "additional jumps"):
            repair_wild_horse(before + "\ngoto SOMEWHERE")

    def test_prison_life_repair_only_deletes_the_dangling_jump(self):
        source = (
            "local function f1(p1)\n"
            "  local nextPageCursor\n"
            "  repeat\n"
            "    local v2 = url\n"
            "    if nextPageCursor then\n"
            "      v2 = v2 .. nextPageCursor\n"
            "    end\n"
            "    for index, value in ipairs(data) do\n"
            "      if value.id == 583171793 then\n"
            "        return true\n"
            "      end\n"
            "    end\n"
            + PRISON_BEFORE
            + "  return false\nend\n"
        )
        repaired = repair_prison(source)
        self.assertEqual(repaired, source.replace(PRISON_REMOVED, ""))
        self.assertEqual(len(source) - len(repaired), len(PRISON_REMOVED))
        self.assertNotIn("goto ", repaired)
        # Guards: any other layout, any extra jump or any real label is refused.
        with self.assertRaisesRegex(ValueError, "layout"):
            repair_prison(source.replace("jsonDecode.nextPageCursor", "other.cursor"))
        with self.assertRaisesRegex(ValueError, "additional jumps"):
            repair_prison(source + "\ngoto ELSEWHERE")
        # A real label anywhere (layout intact) is also refused: the repair is
        # only for the audited "no labels at all" decoder output.
        with self.assertRaisesRegex(ValueError, "additional jumps"):
            repair_prison(source.replace("  local nextPageCursor\n",
                                         "  local nextPageCursor\n  ::L555::\n"))
        with self.assertRaisesRegex(ValueError, "additional jumps"):
            repair_prison(source + "::L555::\n")

    @unittest.skipIf(not PRISON_RAW.is_file(),
                     "raw decoder output is not in the ignored local-results/")
    def test_prison_life_repair_reproduces_the_published_body(self):
        raw = PRISON_RAW.read_bytes().decode("utf-8")
        published = PRISON_PUBLISHED.read_bytes().partition(b"]]\n\n")[2].decode("utf-8")
        self.assertEqual(repair_prison(raw), published)
