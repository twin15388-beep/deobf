"""Tests for scripts/wad_recover.py - the offline recovery pipeline.

Nothing here touches the network: the "clone" is a temporary git repository built
in a temp directory and the "decoder" is a two-line Node stub, so the pipeline's
own logic (pinned extraction, license gate, reproducibility check, audit gate,
draft manifest) is exercised without depending on local-results/.
"""

import contextlib
import io
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from scripts import wad_recover

NODE = shutil.which("node")
LICENSE = ("MIT License\n\nCopyright (c) 2025 Someone\n\n"
           + "Permission is hereby granted, free of charge, to any person obtaining a copy\n" * 4)
STUB_TOOL = """const fs = require("fs");
const args = process.argv.slice(2);
const input = args[0];
const out = args[args.indexOf("-o") + 1];
const body = fs.readFileSync(input, "utf8");
fs.writeFileSync(out, process.env.NONDETERMINISTIC ? body + Math.random() : body);
"""


def make_repo(directory: Path, with_license: bool = True) -> str:
    subprocess.run(["git", "init", "-q", str(directory)], check=True)
    subprocess.run(["git", "-C", str(directory), "config", "user.email", "t@example.invalid"],
                   check=True)
    subprocess.run(["git", "-C", str(directory), "config", "user.name", "Test"], check=True)
    (directory / "Game Script.lua").write_text("return(function(...) end)(...)\n", encoding="utf-8")
    if with_license:
        (directory / "LICENSE").write_text(LICENSE, encoding="utf-8")
    subprocess.run(["git", "-C", str(directory), "add", "-A"], check=True)
    subprocess.run(["git", "-C", str(directory), "commit", "-qm", "pinned"], check=True)
    return subprocess.run(["git", "-C", str(directory), "rev-parse", "HEAD"],
                          capture_output=True, text=True, check=True).stdout.strip()


def make_tool(directory: Path) -> Path:
    (directory / "bin").mkdir(parents=True)
    (directory / "bin" / "pdeobf.js").write_text(STUB_TOOL, encoding="utf-8")
    return directory


class PipelineTests(unittest.TestCase):
    def setUp(self):
        self._tmp = tempfile.TemporaryDirectory()
        self.tmp = Path(self._tmp.name)
        self.repo = self.tmp / "repo"
        self.commit = make_repo(self.repo)

    def tearDown(self):
        self._tmp.cleanup()

    def test_extract_input_pins_the_blob_by_hash(self):
        destination = self.tmp / "inputs" / "Game Script.lua"
        source = wad_recover.extract_input(self.repo, self.commit, "Game Script.lua",
                                           destination)
        self.assertEqual(destination.read_bytes(),
                         (self.repo / "Game Script.lua").read_bytes())
        self.assertEqual(source["sha256"],
                         wad_recover.sha256(destination.read_bytes()))
        self.assertEqual(source["commit"], self.commit)
        with self.assertRaisesRegex(ValueError, "40-character"):
            wad_recover.extract_input(self.repo, "deadbeef", "Game Script.lua", destination)
        with self.assertRaises(ValueError):
            wad_recover.extract_input(self.repo, self.commit, "Missing.lua", destination)

    def test_license_gate_refuses_an_unlicensed_commit(self):
        info = wad_recover.require_license(self.repo, self.commit)
        self.assertEqual(info["license_sha256"], wad_recover.sha256(LICENSE.encode()))
        bare = self.tmp / "bare"
        commit = make_repo(bare, with_license=False)
        with self.assertRaises(ValueError):
            wad_recover.require_license(bare, commit)

    def test_pipeline_refuses_to_write_into_the_catalog(self):
        for target in (Path("dobf scripts 1.0/out.lua"), Path("dobf scripts 1.0")):
            with self.subTest(str(target)):
                with self.assertRaisesRegex(ValueError, "catalog"):
                    wad_recover.assert_not_catalog(target)
        wad_recover.assert_not_catalog(Path("local-results/wad-out/out.lua"))

    def test_draft_artifact_carries_hashes_and_empty_human_fields(self):
        source = wad_recover.extract_input(self.repo, self.commit, "Game Script.lua",
                                           self.tmp / "in.lua")
        license_info = wad_recover.require_license(self.repo, self.commit)
        body = {"deterministic": True, "result_body_sha256": "a" * 64,
                "result_bytes": 10, "result_lines": 1}
        draft = wad_recover.draft_artifact("Game - Variant.lua", "Game", "Variant",
                                           source, body, license_info,
                                           static_assertions=12)
        self.assertEqual(draft["published_path"], "dobf scripts 1.0/Game - Variant.lua")
        self.assertEqual(draft["source"]["sha256"], source["sha256"])
        self.assertEqual(draft["source"]["license_sha256"], license_info["license_sha256"])
        self.assertEqual(draft["verification"]["static_body_assertions"], 12)
        self.assertIs(draft["verification"]["tested_in_roblox"], False)
        self.assertEqual(draft["functions"], [])
        self.assertTrue(any("TODO" in item for item in draft["limitations"]))
        self.assertTrue(any("TODO" in item for item in draft["external_dependencies"]))

    def test_apply_repair_requires_a_repair_function(self):
        broken = self.tmp / "broken.py"
        broken.write_text("VALUE = 1\n", encoding="utf-8")
        with self.assertRaisesRegex(ValueError, "repair"):
            wad_recover.apply_repair(broken, "text")
        good = self.tmp / "good.py"
        good.write_text("def repair(text):\n    return text.replace('a', 'b')\n",
                        encoding="utf-8")
        self.assertEqual(wad_recover.apply_repair(good, "abc"), "bbc")

    @unittest.skipIf(NODE is None, "node is not available")
    def test_decode_requires_two_identical_runs(self):
        tool = make_tool(self.tmp / "tool")
        source = self.tmp / "in.lua"
        source.write_text("local a = 1\n", encoding="utf-8")
        output = self.tmp / "out.lua"
        result = wad_recover.decode(source, output, tool)
        self.assertTrue(result["deterministic"])
        self.assertEqual(len(result["run_sha256"]), 2)
        self.assertEqual(result["result_body_sha256"], wad_recover.sha256(output.read_bytes()))
        with self.assertRaisesRegex(ValueError, "two runs"):
            wad_recover.decode(source, output, tool, runs=1)

    @unittest.skipIf(NODE is None, "node is not available")
    def test_decode_flags_a_nondeterministic_decoder(self):
        tool = make_tool(self.tmp / "tool")
        source = self.tmp / "in.lua"
        source.write_text("local a = 1\n", encoding="utf-8")
        import os
        os.environ["NONDETERMINISTIC"] = "1"
        try:
            result = wad_recover.decode(source, self.tmp / "out.lua", tool)
        finally:
            os.environ.pop("NONDETERMINISTIC", None)
        self.assertFalse(result["deterministic"])
        self.assertEqual(len(set(result["run_sha256"])), 2)

    def test_end_to_end_cli_reports_and_writes_a_draft(self):
        if NODE is None:
            self.skipTest("node is not available")
        tool = make_tool(self.tmp / "tool")
        draft = self.tmp / "draft.json"
        with contextlib.redirect_stdout(io.StringIO()):
            code = wad_recover.main([
                "--repo", str(self.repo), "--commit", self.commit,
                "--path", "Game Script.lua", "--game", "Game", "--variant", "Variant",
                "--out-dir", str(self.tmp / "out"), "--inputs-dir", str(self.tmp / "in"),
                "--tool-dir", str(tool), "--draft", str(draft),
            ])
        # The stub decoder emits a non-game body, so the audit must block it:
        # a pipeline that waves everything through is worse than no pipeline.
        self.assertEqual(code, 1)
        self.assertFalse(draft.exists())

    def test_cli_accepts_a_real_game_body(self):
        if NODE is None:
            self.skipTest("node is not available")
        game = (self.tmp / "repo" / "Game Script.lua")
        game.write_text(
            'local rs = game:GetService("ReplicatedStorage")\n'
            'rs.ManagerChannel:FireServer("GiveBonus", 1)\n'
            'local a = workspace.Customers\nlocal b = workspace.Ovens\n'
            'local c = workspace.Prison_ITEMS\n', encoding="utf-8")
        subprocess.run(["git", "-C", str(self.repo), "add", "-A"], check=True)
        subprocess.run(["git", "-C", str(self.repo), "commit", "-qm", "game"], check=True)
        commit = subprocess.run(["git", "-C", str(self.repo), "rev-parse", "HEAD"],
                                capture_output=True, text=True, check=True).stdout.strip()
        tool = make_tool(self.tmp / "tool")
        draft = self.tmp / "draft.json"
        with contextlib.redirect_stdout(io.StringIO()):
            code = wad_recover.main([
                "--repo", str(self.repo), "--commit", commit,
                "--path", "Game Script.lua", "--game", "Game", "--variant", "Variant",
                "--out-dir", str(self.tmp / "out"), "--inputs-dir", str(self.tmp / "in"),
                "--tool-dir", str(tool), "--draft", str(draft),
            ])
        self.assertEqual(code, 0)
        written = json.loads(draft.read_text())
        self.assertEqual(written["game"], "Game")
        self.assertEqual(written["result_body_sha256"], wad_recover.sha256(game.read_bytes()))
        self.assertTrue(written["verification"]["repeat_decoder_output_identical"])


if __name__ == "__main__":
    unittest.main()
