#!/usr/bin/env python3
"""Differentially check all 607 WaveHub strings against its isolated Luau helper.

Requires the *pinned* WaveHub input and an offline Luau CLI. Only the initial
string pool/decryptor is executed; no game/UI/HTTP code is in the temp script.

    python -m scripts.verify_wavehub_strings /path/to/anime-war-rng.lua /path/to/luau
"""

from __future__ import annotations

from hashlib import sha256
from pathlib import Path
import subprocess
import sys
import tempfile

from .decode_wavehub_anime_war_rng import decode_source, quote_lua, COUNT

EXPECTED_POOL_DIGEST = '422321a3b2d44518208e1ad91d08bb9bdaa0f1afbabc44569e4a2dde38849b4d'


def verify(data: bytes, luau: str) -> str:
    recovery = decode_source(data)  # SHA-256 and helper shape must match first
    source = data.decode('utf-8')
    marker = '\npcall(function()'
    if source.count(marker) < 1:
        raise ValueError('No safe gameplay boundary found')
    # No gameplay code, shared bootstrap or network requests are copied into the
    # temporary script: the helper is the sole function in this prefix.
    prefix = source[:source.index(marker)]
    assert prefix.count('local function ') == 2  # decryptor plus its emit() helper
    literals = ',\n'.join(quote_lua(recovery.constants[i]) for i in range(1, COUNT + 1))
    script = prefix + '\nlocal recoveredLiterals = {\n' + literals + '\n}\n' + f'''
for i=1,{COUNT} do
    local value = _MmmjvvlZHicC(i)
    if value ~= recoveredLiterals[i] then error("literal mismatch: "..i) end
    local hex = {{}}
    for p=1,#value do hex[p]=string.format("%02x", string.byte(value,p)) end
    print(i..":"..table.concat(hex))
end
'''
    with tempfile.TemporaryDirectory(prefix='wavehub-pool-') as temp:
        path = Path(temp) / 'isolated_pool.luau'
        path.write_text(script, encoding='utf-8')
        result = subprocess.run([luau, str(path)], cwd=temp,
                                capture_output=True, text=True, check=True, timeout=30)
    got: dict[int, bytes] = {}
    for line in result.stdout.splitlines():
        idx, hexvalue = line.split(':', 1)
        index = int(idx)
        if index in got:
            raise ValueError(f'Duplicate Luau value {index}')
        got[index] = bytes.fromhex(hexvalue)
    if got != recovery.constants:
        raise ValueError(f'Luau comparison failed: {len(got)}/{len(recovery.constants)} strings')
    raw = b''.join(index.to_bytes(2, 'big') + len(value).to_bytes(2, 'big') + value
                   for index, value in sorted(got.items()))
    digest = sha256(raw).hexdigest()
    if digest != EXPECTED_POOL_DIGEST:
        raise ValueError(f'Pool digest mismatch: {digest}')
    return f'{len(got)}/{COUNT} byte-exact strings, {sum(map(len, got.values()))} decoded bytes, SHA-256 {digest}'


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print(f'usage: {argv[0]} pinned-input.lua /path/to/luau', file=sys.stderr)
        return 2
    print(verify(Path(argv[1]).read_bytes(), argv[2]))
    return 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv))
