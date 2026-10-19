"""Guards for the two narrowly scoped game-script control-flow repairs.

These do not attempt to run the recovered Roblox programs.
"""

import unittest

from scripts.repair_violence_district_goto import BEFORE, AFTER, repair as repair_violence
from scripts.repair_wild_horse_goto import repair as repair_wild_horse


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
