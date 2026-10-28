"""Guards for the licensed tool snapshots added on 25 October 2026.

These tests do not run any vendored tool. They only check that the vendored
archives stay source-only (no binaries, no bundled third-party protected
samples), that each one still carries its upstream license at the archive root,
and that the repository documents every archive it ships.
"""

import json
from pathlib import Path
import py_compile
import tempfile
import unittest
import zipfile

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "sources" / "manifest.json"
README = ROOT / "README.md"

EXPECTED = {
    "ServerDeadd/Luraph-v15.1-Deobfuscator": "MIT",
    "Nonition/MoonveilDeobfuscator": "MIT",
    "uddudh/luaguard-unpack": "MIT",
    "focatdev/Koralys": "GPL-3.0",
    "Collafranca/Umbra": "GPL-3.0",
    "vurvdev/LuaPro": "GPL-3.0",
}

FORBIDDEN_SUFFIXES = {
    ".exe", ".dll", ".pdb", ".so", ".dylib", ".bin", ".o", ".a", ".lib",
    ".class", ".jar", ".pyc", ".luac", ".zip", ".7z", ".rar",
}


def load_manifest():
    return json.loads(MANIFEST.read_text(encoding="utf-8"))


class VendoredToolsTests(unittest.TestCase):
    def setUp(self):
        self.sources = {entry["repository"]: entry
                        for entry in load_manifest()["sources"]}

    def test_entries_are_pinned_and_licensed(self):
        for repository, license_id in EXPECTED.items():
            with self.subTest(repository=repository):
                entry = self.sources[repository]
                self.assertEqual(entry["license"], license_id)
                self.assertRegex(entry["commit"], r"^[0-9a-f]{40}$")
                self.assertEqual(entry["archive"],
                                 f"sources/{repository.replace('/', '--')}.zip")
                self.assertGreater(entry["files"], 0)

    def test_archives_are_source_only(self):
        for repository in EXPECTED:
            with self.subTest(repository=repository):
                entry = self.sources[repository]
                with zipfile.ZipFile(ROOT / entry["archive"]) as snapshot:
                    names = [info.filename for info in snapshot.infolist()
                             if not info.is_dir()]
                self.assertEqual(len(names), entry["files"])
                prefix = f"{repository.replace('/', '--')}-{entry['commit'][:12]}/"
                for name in names:
                    self.assertTrue(name.startswith(prefix), name)
                    relative = name[len(prefix):]
                    self.assertNotIn("node_modules/", relative)
                    self.assertNotIn("__pycache__/", relative)
                    self.assertIn(Path(relative).suffix.lower(),
                                  FORBIDDEN_SUFFIXES | {""} | _allowed(relative),
                                  f"unexpected file type: {name}")

    def test_archives_keep_upstream_license(self):
        for repository in EXPECTED:
            with self.subTest(repository=repository):
                entry = self.sources[repository]
                prefix = f"{repository.replace('/', '--')}-{entry['commit'][:12]}/"
                with zipfile.ZipFile(ROOT / entry["archive"]) as snapshot:
                    roots = {name for name in snapshot.namelist()
                             if name.startswith(prefix)
                             and "/" not in name[len(prefix):].rstrip("/")}
                self.assertTrue(
                    any(Path(name[len(prefix):]).name.upper().startswith(("LICENSE", "COPYING"))
                        for name in roots),
                    f"missing LICENSE at archive root: {repository}")

    def test_readme_links_every_archive(self):
        readme = README.read_text(encoding="utf-8")
        for repository, entry in self.sources.items():
            archive = Path(entry["archive"]).name
            with self.subTest(repository=repository):
                self.assertIn(archive, readme)

    def test_helper_scripts_compile(self):
        for name in ("vendor_tool_sources.py", "prepare_luau.py"):
            with self.subTest(script=name):
                path = ROOT / "scripts" / name
                self.assertTrue(path.is_file())
                with tempfile.TemporaryDirectory() as tmp:
                    py_compile.compile(str(path), cfile=str(Path(tmp) / "out.pyc"),
                                       doraise=True)


def _allowed(relative):
    """Text/config/data files that are legitimate parts of these tools."""
    return {
        ".lua", ".luau", ".py", ".js", ".mjs", ".cjs", ".json", ".md", ".txt",
        ".toml", ".cfg", ".ini", ".yml", ".yaml", ".ps1", ".sh", ".bat", ".cmd",
        ".gitignore", ".gitattributes", ".env", ".example", ".luaparse", ".lock",
        ".ts", ".html", ".css", ".dockerfile", ".1", ".sha256", ".expected", ".log",
    }


if __name__ == "__main__":
    unittest.main()
