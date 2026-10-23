#!/usr/bin/env python3
"""Pin and publish the MIT Deepwoken Aztup *source*, disabling automatic telemetry.

This is NOT a deobfuscator or a runnable standalone replacement for Aztup Hub.
The result retains the upstream game's remote calls and optional user-configured
webhooks, and still requires the original hub and executor. Never runs the input.

    python -m scripts.sanitize_aztup_deepwoken \
      /path/to/Aztup-Hub-V3/files/games/DeepWoken.lua \
      'dobf scripts 1.0/Deepwoken - Aztup main (src).lua'
"""

from __future__ import annotations

import hashlib
from pathlib import Path
import sys

COMMIT = "45bcead9541ad13c2adc631c1afaecf8bdfc8ed5"
SOURCE_SHA256 = "535232a58188f77c8793fbd25b2433fe7d05e1a913cf619b36bbc5c960bae190"
LICENSE = """MIT License

Copyright (c) 2024 ttwiz_z

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""
HEADER = f"""--[[
Deepwoken - Aztup main: OPEN SOURCE (src), NOT DEOBFUSCATED.
Source: https://github.com/ModerkaScripts/Aztup-Hub-V3/blob/{COMMIT}/files/games/DeepWoken.lua
Input SHA-256: {SOURCE_SHA256}
Modifications: automatic debug HTTP POST and auto-parry upload removed;
  unreachable loot analytics and unused analytics import removed;
  empty-URL debug webhook replaced with local warn().
IMPORTANT: NOT STANDALONE. Requires Aztup Hub's sharedRequire, globals and UI.
The enabled moderator-detection GET and sound downloads, and user-configured
webhook notifiers remain. Never run unreviewed or with a sensitive account.

MIT LICENSE BEGIN
{LICENSE}MIT LICENSE END
]]

"""


def replace_once(source: str, old: str, new: str) -> str:
    if source.count(old) != 1:
        raise ValueError(f"Expected exactly one source fragment, found {source.count(old)}: {old[:90]!r}")
    return source.replace(old, new, 1)


def drop_between(source: str, start: str, end: str, replacement: str,
                 required: tuple[str, ...]) -> str:
    if source.count(start) != 1 or source.count(end) != 1:
        raise ValueError(f"Could not uniquely locate telemetry block: {start[:70]!r}")
    left = source.index(start)
    right = source.index(end, left)
    block = source[left:right]
    for marker in required:
        if marker not in block:
            raise ValueError(f"Changed telemetry block, missing: {marker!r}")
    return source[:left] + replacement + source[right:]


def sanitize(data: bytes) -> str:
    if hashlib.sha256(data).hexdigest() != SOURCE_SHA256:
        raise ValueError("Unexpected Deepwoken source SHA-256; manually re-audit changes")
    source = data.decode("utf-8")
    source = replace_once(
        source,
        "local AnalyticsAPI = sharedRequire('../classes/AnalyticsAPI.lua');",
        "-- The unused AnalyticsAPI import was removed (the only call was commented out).",
    )
    source = replace_once(
        source,
        """local function logError(msg)
\ttask.spawn(syn.request, {
\t\tUrl = '',
\t\tMethod = 'POST',
\t\tHeaders = {['Content-Type'] = 'application/json'},
\t\tBody = HttpService:JSONEncode({content = msg .. ' ' .. accountData.username})
\t});
end;

local debugWebhook = Webhook.new('');""",
        """local function logError(msg)
    -- Formerly posted a message and account username to an empty debug URL.
    warn('[Aztup Debug] ' .. tostring(msg));
end;

local debugWebhook = {
    Send = function(_, message)
        warn('[Aztup Debug] ' .. tostring(message));
    end;
};""",
    )
    source = drop_between(
        source,
        "\t-- Auto Loot Analytics\n\ttask.spawn(function()",
        "\tfunction functions.autoSprint(toggle)",
        "\t-- Disabled upstream Auto Loot Analytics block with unreachable POST removed.\n\n",
        ("if (true) then return end;", "syn.request({", "Url = ''", "Method = 'POST'"),
    )
    source = drop_between(
        source,
        "\t\ttask.spawn(function()\n\t\t\twhile (true) do\n\t\t\t\ttask.wait(10);\n\t\t\t\tif (#dataset == 0) then continue end;",
        "\t\t-- Utility.listenToChildAdded(workspace.Live, animLogger, {listenToDestroying = true});",
        "\t\t-- Removed periodic POST of parry telemetry; capture was disabled upstream.\n\n",
        ("Method = 'POST'", "misc/submit-parry-timing", "table.clear(dataset);"),
    )
    for forbidden in ("Method = 'POST'", "task.spawn(syn.request", "debugWebhook = Webhook.new",
                      "misc/submit-parry-timing"):
        # All remaining Aztup webhooks are user-configured and pass through
        # Webhook:Send rather than the removed anonymous syn.request blocks.
        if forbidden in source:
            raise ValueError(f"Automatic telemetry remains: {forbidden}")
    return source


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print(f"usage: {argv[0]} pinned-DeepWoken.lua output.lua", file=sys.stderr)
        return 2
    source = sanitize(Path(argv[1]).read_bytes())
    output = Path(argv[2])
    output.write_text(HEADER + source, encoding="utf-8")
    print(f"Sanitized MIT src: {len(source.splitlines())} body lines, {output}")
    return 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv))
