"""Tests for the pre-publish audit in scripts/check_decoder_output.py.

Nothing is executed and no network is used: the checks read text only.
"""

import unittest

from scripts.check_decoder_output import (
    audit,
    classify,
    dangling_gotos,
    external_hosts,
    paste_hosts,
    strip_header,
)

GAME_BODY = """local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
replicatedStorage.ManagerChannel:FireServer("GiveBonus", v1)
local customers = workspace.Customers:GetChildren()
local ovens = workspace.Ovens
local doors = workspace.CellDoors
local camera = workspace.CurrentCamera
"""

LOADER_BODY = """local windUI = loadstring(game:HttpGet("https://example.invalid/ui.lua"))()
windUI:CreateWindow({ Title = "hub" })
"""

VM_DUMP = "return {" + ",".join("218070" for _ in range(400)) + "}\n"

UI_BODY = "\n".join(f'Instance.new("TextLabel", gui{i})' for i in range(12)) + "\n"


class DanglingGotoTests(unittest.TestCase):
    def test_missing_label_is_reported_with_its_line(self):
        text = "repeat\n  f()\n  goto L9209319\nuntil not cursor\n"
        self.assertEqual(dangling_gotos(text), [(3, "L9209319")])

    def test_defined_label_is_not_reported(self):
        text = "while true do\n  ::L9209319::\n  f()\n  goto L9209319\nend\n"
        self.assertEqual(dangling_gotos(text), [])

    def test_header_prose_is_not_audited(self):
        header = ('--[[\nWe deleted the line "      goto L9209319" because the '
                  'decoder emitted no label.\n]]\n\n')
        body = "repeat\n  f()\nuntil not cursor\n"
        self.assertEqual(dangling_gotos(strip_header(header + body)), [])
        # Without stripping, the documented jump would look like a defect.
        self.assertEqual(dangling_gotos(header + body), [(2, "L9209319")])
        self.assertEqual(strip_header(body), body)


class ClassificationTests(unittest.TestCase):
    def test_game_code_by_remotes_or_paths(self):
        self.assertEqual(classify(GAME_BODY), "game_code")

    def test_loader_only_when_it_only_fetches(self):
        self.assertEqual(classify(LOADER_BODY), "loader_only")

    def test_vm_dump_by_digit_density(self):
        self.assertEqual(classify(VM_DUMP), "vm_dump")

    def test_ui_library_without_game_paths(self):
        self.assertEqual(classify(UI_BODY), "ui_library")


class AuditGateTests(unittest.TestCase):
    def test_clean_game_body_is_publishable(self):
        report = audit(GAME_BODY)
        self.assertTrue(report["publishable"], report["blockers"])
        self.assertEqual(report["classification"], "game_code")

    def test_dangling_goto_blocks_publication(self):
        report = audit(GAME_BODY + "goto L42\n")
        self.assertFalse(report["publishable"])
        self.assertTrue(any("dangling goto" in item for item in report["blockers"]))

    def test_paste_host_blocks_publication(self):
        report = audit(GAME_BODY + '\nloadstring(game:HttpGet("https://paste.ee/r/abc"))()\n')
        self.assertFalse(report["publishable"])
        self.assertIn("paste.ee", report["paste_hosts"])
        self.assertIn("paste.ee", external_hosts(GAME_BODY + "https://paste.ee/r/abc"))

    def test_non_game_body_blocks_publication(self):
        for body, kind in ((LOADER_BODY, "loader_only"), (VM_DUMP, "vm_dump"),
                           (UI_BODY, "ui_library")):
            with self.subTest(kind):
                report = audit(body)
                self.assertFalse(report["publishable"])
                self.assertIn(kind, " ".join(report["blockers"]))

    def test_published_bodies_still_pass_the_gate(self):
        """Regression guard over the real catalog files (headers excluded)."""
        from pathlib import Path
        root = Path(__file__).resolve().parents[1]
        names = [
            "dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua",
            "dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua",
            "dobf scripts 1.0/Slap Battles - Tryhard AI Demo.lua",
            "dobf scripts 1.0/Prison Life - volmaks ESP Freecam.lua",
            "dobf scripts 1.0/Work at a Pizza Place - Order4.lua",
        ]
        for name in names:
            with self.subTest(name):
                text = (root / name).read_bytes().decode("utf-8")
                report = audit(text)
                self.assertEqual(report["classification"], "game_code")
                self.assertEqual(report["dangling_gotos"], [])
                self.assertEqual(report["paste_hosts"], [])


if __name__ == "__main__":
    unittest.main()
