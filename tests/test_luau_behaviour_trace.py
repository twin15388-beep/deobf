"""Checks for the Luau behaviour-trace driver builder (scripts/luau_behaviour_trace.py)."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.luau_behaviour_trace import HEADER, TERMINATOR, build_driver, extract_strings  # noqa: E402


class BuildDriverTest(unittest.TestCase):
    def test_sample_is_inlined_verbatim(self) -> None:
        sample = 'local x = 1\nprint("hello")\n'
        driver = build_driver(sample)
        self.assertTrue(driver.startswith(HEADER))
        self.assertIn("TOPRUN ok=", driver)
        self.assertIn(sample, driver)

    def test_sample_appears_exactly_once(self) -> None:
        sample = "return 42\n"
        self.assertEqual(build_driver(sample).count(sample), 1)

    def test_terminator_is_rejected(self) -> None:
        with self.assertRaises(ValueError):
            build_driver("local a = [==[opened\n]===]\n")

    def test_driver_never_executes_at_build_time(self) -> None:
        # A sample that would explode if it were ever run by the builder: only
        # the text is copied, so building it must stay silent and side-effect free.
        sample = 'error("must not run while building")\n'
        self.assertIn(sample, build_driver(sample))

    def test_executor_shims_and_event_cap_present(self) -> None:
        driver = build_driver("return nil\n")
        for marker in ("islclosure", "getgenv", "httpget", "LOADSTRING", "LIMIT"):
            self.assertIn(marker, driver)
        self.assertIn("BEGIN tracer", driver)
        self.assertIn("TOPRUN ok=", driver)

    def test_string_dump_is_opt_in(self) -> None:
        off = build_driver("return nil\n")
        on = build_driver("return nil\n", dump_strings=True)
        self.assertIn("local DUMP_STRINGS = false", off)
        self.assertIn("local DUMP_STRINGS = true", on)
        self.assertIn('print("S " .. string.gsub', on)

    def test_extract_strings_decodes_and_dedupes(self) -> None:
        trace = "BEGIN tracer\nS 4b616974756e204661726d\nS 4b616974756e204661726d\nS 00ff\nT event\n"
        self.assertEqual(extract_strings(trace), ["Kaitun Farm"])

    def test_extract_strings_ignores_malformed_lines(self) -> None:
        trace = "S 4b616974\nS zz\nS 4b61\nS\n"
        self.assertEqual(extract_strings(trace), ["Kait", "Ka"])
        self.assertEqual(extract_strings(trace, min_length=4), ["Kait"])

    def test_writable_environment_replaces_readonly_globals(self) -> None:
        driver = build_driver("return nil\n")
        self.assertIn("if x == nil or x == 0 then return env end", driver)
        self.assertIn("env._G = env", driver)
        self.assertIn(TERMINATOR, driver)


if __name__ == "__main__":
    unittest.main()
