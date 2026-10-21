#!/usr/bin/env python3
"""Inspect *local, authorized* Lua delivery snapshots without fetching/executing code.

Luarmor/Jnkie loaders often contain only a URL, public script identifier, SDK
call or authentication handshake. Their server-side script is not in that file.
This adapter accepts a separately supplied local response body or HAR capture,
unwraps only explicit transport encodings and an *entire* literal loadstring
wrapper, and exports raw payloads for subsequent analysis. It never makes HTTP
requests, checks/guesses keys, evaluates Lua, or claims to devirtualize a VM.

Do not commit captures: HAR files may contain keys, headers or personal data.
Only analyze material you are authorized to possess and redistribute.
"""

from __future__ import annotations

import argparse
import base64
import binascii
import hashlib
import json
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import urlsplit

MAX_BODY = 4_000_000
MAX_HAR = 20_000_000
MAX_DEPTH = 6
ROOT = Path(__file__).resolve().parents[1]
CATALOG = (ROOT / "dobf scripts 1.0").resolve()
PRIVATE_OUTPUT = (ROOT / "local-results").resolve()

# Hostnames must match exactly or be subdomains, not merely contain the name.
PROVIDERS = {"luarmor": "luarmor.net", "jnkie": "jnkie.com"}
HTTP_LITERAL = re.compile(
    rb"\bHttpGet(?:Async)?\s*\(\s*(['\"])(https://[^\s'\"\\]+)\1",
    re.IGNORECASE,
)
# SDK wrappers sometimes store a URL in a local constant and pass that
# variable to HttpGet; record the literal without pretending to resolve the
# function call or execute arbitrary string concatenations.
URL_LITERAL = re.compile(rb"(['\"])(https://[^\s'\"\\]+)\1", re.IGNORECASE)
AUTH_MARKERS = (b"script_key", b"check_key(", b"checkkey(", b"load_script(")
VM_BANNERS = (
    b"this file was protected with moonsec", b"luraph obfuscator",
    b"psu obfuscator", b"wearedevs.net/obfuscator", b"ironbrew",
)
VM_CODE_MARKERS = (b"lph_encstr", b"lph_encfunc")
VM_COMMENT_LINE = re.compile(
    rb"^[ \t]*--[^\r\n]*(?:this file was protected with moonsec|luraph obfuscator|"
    rb"psu obfuscator|wearedevs\.net/obfuscator|ironbrew)", re.I | re.M,
)
# Some MoonSec versions use ([[banner]]):gsub(...) as *code* rather than a comment.
VM_INLINE_MOONSEC = re.compile(
    rb"^[ \t]*\(?[ \t]*\[=*\[\s*this file was protected with moonsec", re.I | re.M,
)
LUA_START = re.compile(
    rb"(?:local\b|return\b|function\b|do\b|if\b|while\b|repeat\b|"
    rb"loadstring\b|script_key\b|getgenv\s*\(|\(\s*function\b|\(\s*\[\[)", re.IGNORECASE,
)
REMOTE_CALL = re.compile(
    rb":\s*(?:FireServer|InvokeServer)\s*\(|\bfireproximityprompt\s*\(", re.IGNORECASE,
)
NETWORK_CALL = re.compile(rb"\bHttpGet(?:Async)?\s*\(|\blrm_load_script\s*\(|\bjnkie\.load_script\s*\(", re.I)
# Applied to code with comments/strings blanked, not to arbitrary downloaded text.
SIMPLE_HTTP_LOADER = re.compile(
    rb"(?:return\s+)?loadstring\s*\(\s*game\s*:\s*HttpGet(?:Async)?\s*\([^()]*\)\s*\)\s*\(\s*\)\s*;?\s*",
    re.IGNORECASE,
)
FIELDS = ("script", "source", "lua", "payload", "body", "content", "response", "data", "code")


class SnapshotError(ValueError):
    """Malformed or oversized local input; no Lua was run."""


def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def read_limited(path: Path, limit: int) -> bytes:
    if path.stat().st_size > limit:
        raise SnapshotError("local input exceeds size limit")
    data = path.read_bytes()
    if len(data) > limit:
        raise SnapshotError("local input exceeds size limit")
    return data


def _lua_without(raw: bytes, *, strings: bool) -> bytes:
    """Blank Lua comments, and optionally literals, preserving byte offsets.

    This is a lexical *hint* for metadata, not a Lua parser. In particular,
    Luau interpolated backtick strings are treated as opaque, so an embedded
    expression may be missed rather than misreported as recovered gameplay.
    """
    out = bytearray(raw)
    length = len(raw)

    def long_end(pos: int) -> int | None:
        if pos >= length or raw[pos] != ord("["):
            return None
        equals = pos + 1
        while equals < length and raw[equals] == ord("=") and equals - pos <= 64:
            equals += 1
        if equals >= length or raw[equals] != ord("["):
            return None
        closer = b"]" + raw[pos + 1:equals] + b"]"
        end = raw.find(closer, equals + 1)
        return length if end < 0 else end + len(closer)

    pos = 0
    while pos < length:
        start = pos
        if raw.startswith(b"--", pos):
            end = long_end(pos + 2)
            if end is None:
                newline = raw.find(b"\n", pos + 2)
                end = length if newline < 0 else newline
            out[pos:end] = b" " * (end - pos)
            pos = end
        elif raw[pos] in (ord("'"), ord('"'), ord("`")):
            quote = raw[pos]
            pos += 1
            while pos < length:
                if raw[pos] == 92:  # escaped quote or backslash
                    pos = min(length, pos + 2)
                elif raw[pos] == quote:
                    pos += 1
                    break
                else:
                    pos += 1
            if strings:
                out[start:pos] = b" " * (pos - start)
        elif raw[pos] == ord("[") and (end := long_end(pos)) is not None:
            if strings:
                out[pos:end] = b" " * (end - pos)
            pos = end
        else:
            pos += 1
    return bytes(out)


def provider_for_url(url: str) -> str | None:
    try:
        parts = urlsplit(url)
        if parts.scheme != "https" or parts.username or parts.password:
            return None
        host = parts.hostname or ""
    except ValueError:
        return None
    for provider, domain in PROVIDERS.items():
        if host == domain or host.endswith("." + domain):
            return provider
    return None


def route_for_url(url: str, provider: str) -> str:
    """Report route *type*, never a path, public token, query or key."""
    path = urlsplit(url).path.lower()
    if provider == "luarmor":
        if "/verified/" in path:
            return "verified-loader"
        if "/loaders/" in path:
            return "loader"
        if "/files/v3/l/" in path:
            return "script-endpoint"
    if provider == "jnkie":
        if path.endswith("/sdk/library.lua"):
            return "sdk-library"
        if re.fullmatch(r"/api/v1/(?:luascripts|loaders)/public/[^/]+/download", path):
            return "public-loader"
        if re.fullmatch(r"/api/v1/luascripts/delivery/[^/]+", path):
            return "delivery"
        if urlsplit(url).hostname == "cdn.jnkie.com" and path.endswith(".lua"):
            return "signed-payload"
    return "other"


def inspect_loader(raw: bytes) -> dict:
    """Extract delivery metadata from local Lua; never print script IDs/keys."""
    uncommented = _lua_without(raw, strings=False)
    code = _lua_without(raw, strings=True)
    direct_positions = {
        match.start(2) for match in HTTP_LITERAL.finditer(uncommented)
        if code[match.start():match.start() + 7].lower() == b"httpget"
    }
    found = []
    for match in URL_LITERAL.finditer(uncommented):
        url = match.group(2).decode("ascii", "ignore")
        provider = provider_for_url(url)
        if provider:
            found.append({"provider": provider, "route": route_for_url(url, provider),
                          "reference": ("direct-http" if match.start(2) in direct_positions
                                        else "literal-url")})
    lower = code.lower()
    providers = sorted({item["provider"] for item in found}
                       | ({"luarmor"} if b"lrm_load_script" in lower else set())
                       | ({"jnkie"} if b"jnkie.load_script" in lower else set()))
    http_calls = len(re.findall(rb"\bHttpGet(?:Async)?\s*\(", code, re.I))
    return {
        "bytes": len(raw), "sha256": digest(raw), "providers": providers,
        "literal_http_routes": found,
        "unresolved_http_calls": http_calls > len(direct_positions),
        "auth_or_sdk_call_seen": any(marker in lower for marker in AUTH_MARKERS),
        # Heuristic only: an HttpGet may refer to an unrelated URL variable.
        "delivery_call_seen": bool((found and http_calls) or b"lrm_load_script" in lower
                                   or b"jnkie.load_script" in lower),
        "inline_remote_call_hint_seen": bool(REMOTE_CALL.search(code)),
    }


def _skip_trivia(source: bytes, pos: int) -> int:
    while pos < len(source):
        if source[pos] in b" \r\n\t\v\f":
            pos += 1
        elif source.startswith(b"--", pos):
            long = re.match(rb"--\[(=*)\[", source[pos:pos + 20])
            if long:
                closing = b"]" + long.group(1) + b"]"
                end = source.find(closing, pos + long.end())
                if end < 0:
                    raise SnapshotError("unterminated Lua long comment")
                pos = end + len(closing)
            else:
                end = source.find(b"\n", pos + 2)
                pos = len(source) if end < 0 else end + 1
        else:
            break
    return pos


def _lua_literal(source: bytes, pos: int) -> tuple[bytes, int] | None:
    """Decode a single literal, not a Lua expression; return bytes and end."""
    if pos >= len(source):
        return None
    quote = source[pos]
    if quote in (ord("'"), ord('"')):
        pos += 1
        out = bytearray()
        simple = {ord("a"): 7, ord("b"): 8, ord("f"): 12, ord("n"): 10,
                  ord("r"): 13, ord("t"): 9, ord("v"): 11}
        while pos < len(source):
            ch = source[pos]
            pos += 1
            if ch == quote:
                return bytes(out), pos
            if ch in (10, 13):
                return None
            if ch != 92:  # backslash
                out.append(ch)
                continue
            if pos >= len(source):
                return None
            ch = source[pos]
            pos += 1
            if 48 <= ch <= 57:
                digits = bytes([ch])
                while len(digits) < 3 and pos < len(source) and 48 <= source[pos] <= 57:
                    digits += source[pos:pos + 1]
                    pos += 1
                value = int(digits)
                if value > 255:
                    return None
                out.append(value)
            elif ch == ord("x") and pos + 2 <= len(source):
                pair = source[pos:pos + 2]
                if not re.fullmatch(rb"[0-9a-fA-F]{2}", pair):
                    return None
                out.append(int(pair, 16))
                pos += 2
            elif ch == ord("z"):
                while pos < len(source) and source[pos] in b" \r\n\t\v\f":
                    pos += 1
            elif ch in simple:
                out.append(simple[ch])
            elif ch in (ord("'"), ord('"'), 92, 10):
                out.append(ch)
            elif ch == 13:
                if pos < len(source) and source[pos] == 10:
                    pos += 1
                out.append(10)
            else:
                return None
        return None
    long = re.match(rb"\[(=*)\[", source[pos:pos + 20])
    if long:
        closing = b"]" + long.group(1) + b"]"
        start = pos + long.end()
        end = source.find(closing, start)
        if end < 0:
            return None
        payload = source[start:end]
        if payload.startswith(b"\r\n"):
            payload = payload[2:]
        elif payload.startswith(b"\n"):
            payload = payload[1:]
        return payload, end + len(closing)
    return None


def unwrap_literal_loadstring(source: bytes) -> bytes | None:
    """Unwrap only when the *entire* chunk is a literal loadstring call.

    In particular, never strip a leading loader or skip intervening Lua code.
    This is a transport-layer transformation, not deobfuscation.
    """
    pos = _skip_trivia(source, 0)
    start = re.match(rb"(?:return\s+)?loadstring\s*\(\s*", source[pos:], re.I)
    if not start:
        return None
    pos += start.end()
    literal = _lua_literal(source, pos)
    if literal is None:
        return None
    data, pos = literal
    ending = re.match(rb"\s*\)\s*\(\s*\)\s*;?", source[pos:])
    if not ending:
        return None
    pos = _skip_trivia(source, pos + ending.end())
    if pos != len(source):
        return None
    if len(data) > MAX_BODY:
        raise SnapshotError("decoded Lua exceeds size limit")
    return data


def classify(data: bytes) -> str:
    if not data:
        return "no_payload"
    if data.startswith(b"\x1bLua") or data.startswith(b"\x1bLuau"):
        return "binary_bytecode"
    try:
        _skip_trivia(data, 0)
    except SnapshotError:
        return "unverified_data"
    code = _lua_without(data, strings=True).lstrip()
    if not code or (not LUA_START.match(code)
                    and not re.search(rb"\b(?:game|workspace)[:.]", code)):
        return "unverified_data"
    delivery = bool(NETWORK_CALL.search(code))
    remote_call = bool(REMOTE_CALL.search(code))
    # Quoted protection names are not proof of a VM. A banner must be a real
    # comment header or MoonSec's executable ([[banner]]):gsub(...) idiom.
    vm_marker = any(marker in code.lower() for marker in VM_CODE_MARKERS)
    if not vm_marker and any(marker in data.lower() for marker in VM_BANNERS):
        uncommented = _lua_without(data, strings=False)
        vm_marker = any(not uncommented[m.start():m.end()].strip()
                        for m in VM_COMMENT_LINE.finditer(data))
        if not vm_marker:
            vm_marker = any(code[m.start():m.start() + 32].lstrip().startswith((b"(", b"["))
                            for m in VM_INLINE_MOONSEC.finditer(data))
    # A VM banner pasted above a trivial network wrapper does not make the
    # loader itself a VM. Complex VM bodies take precedence over loader hints.
    if vm_marker and not (delivery and SIMPLE_HTTP_LOADER.fullmatch(code)):
        return "protected_payload"
    # No inline remote-call hint: *conservatively* withhold source export.
    # This does not prove that the whole file lacks game code or that remote
    # calls hidden in strings/interpolation have been decoded.
    if delivery and not remote_call:
        return "loader_only"
    return "lua_source_candidate"  # Not necessarily game-specific or recovered.


@dataclass(frozen=True)
class Decoded:
    data: bytes | None
    layers: tuple[dict, ...]
    status: str


def _layer(label: str, data: bytes) -> dict:
    return {"transform": label, "bytes": len(data), "sha256": digest(data)}


def _decode_base64(value: str) -> bytes:
    if len(value) > MAX_BODY * 2:
        raise SnapshotError("base64 input exceeds size limit")
    try:
        raw = base64.b64decode(value, validate=True)
    except (binascii.Error, ValueError) as exc:
        raise SnapshotError("invalid explicit base64 snapshot") from exc
    if len(raw) > MAX_BODY:
        raise SnapshotError("decoded base64 exceeds size limit")
    return raw


def decode_response(raw: bytes, initial_layers: tuple[dict, ...] = ()) -> Decoded:
    """Decode JSON/base64/whole-literal layers, without interpreting Lua."""
    if len(raw) > MAX_BODY:
        raise SnapshotError("response body exceeds size limit")

    def inner(data: bytes, layers: tuple[dict, ...], depth: int) -> Decoded:
        if depth > MAX_DEPTH:
            return Decoded(None, layers, "depth_limit")
        stripped = data.lstrip()
        if stripped.startswith((b"{", b"[", b'"')):
            try:
                obj = json.loads(data)
            except (ValueError, UnicodeDecodeError, RecursionError):
                obj = None
            if obj is not None:
                if isinstance(obj, str):
                    if len(obj.encode("utf-8")) <= MAX_BODY:
                        value = obj.encode("utf-8")
                        return inner(value, layers + (_layer("json-string", value),), depth + 1)
                elif isinstance(obj, dict):
                    ranks = {"loader_only": 1, "lua_source_candidate": 2,
                             "binary_bytecode": 3, "protected_payload": 4}
                    best: Decoded | None = None
                    ambiguous = False
                    for field in FIELDS:
                        value = obj.get(field)
                        if not isinstance(value, (str, dict)):
                            continue
                        if field == "code" and isinstance(value, str) and not LUA_START.match(value.lstrip().encode("utf-8")):
                            continue  # KEY_VALID/KEY_INVALID is a status, not code.
                        if obj.get("encoding") == "base64" and field != "code" and isinstance(value, str):
                            encoded = _decode_base64(value)
                            label = "json-base64"
                        else:
                            encoded = (value.encode("utf-8") if isinstance(value, str)
                                       else json.dumps(value, ensure_ascii=False).encode("utf-8"))
                            label = "json-" + field
                        if len(encoded) > MAX_BODY:
                            continue
                        decoded = inner(encoded, layers + (_layer(label, encoded),), depth + 1)
                        if decoded.status not in ranks:
                            continue
                        if best is None:
                            best = decoded
                        elif best.status == "loader_only" and decoded.status != "loader_only":
                            best, ambiguous = decoded, False
                        elif decoded.status != "loader_only" and best.status != "loader_only":
                            # Neither protected VM nor readable code is a
                            # safe default when both *different* bodies occur.
                            if decoded.data != best.data:
                                ambiguous = True
                            if ranks[decoded.status] > ranks[best.status]:
                                best = decoded
                        elif best.status == "loader_only" and decoded.data != best.data:
                            ambiguous = True
                    if ambiguous:
                        return Decoded(None, layers, "ambiguous_json_fields")
                    return best if best is not None else Decoded(None, layers, "auth_or_no_script")
                elif isinstance(obj, list):
                    return Decoded(None, layers, "ambiguous_json_array")
        try:
            unwrapped = unwrap_literal_loadstring(data)
        except SnapshotError:
            raise
        if unwrapped is not None:
            if unwrapped == data:
                return Decoded(data, layers, classify(data))
            return inner(unwrapped, layers + (_layer("literal-loadstring", unwrapped),), depth + 1)
        status = classify(data)
        return Decoded(data if status not in ("unverified_data", "no_payload") else None,
                       layers, status)

    return inner(raw, initial_layers, 0)


def decode_har(raw: bytes, response_index: int | None, loader: dict | None) -> tuple[Decoded, dict]:
    """Select a specific authorized provider response, never use request headers."""
    try:
        har = json.loads(raw)
        entries = har["log"]["entries"]
    except (ValueError, KeyError, TypeError, RecursionError) as exc:
        raise SnapshotError("invalid HAR structure") from exc
    if not isinstance(entries, list) or len(entries) > 1000:
        raise SnapshotError("invalid or oversized HAR entry list")
    responses = []
    for index, entry in enumerate(entries):
        if not isinstance(entry, dict):
            continue
        request = entry.get("request")
        response = entry.get("response")
        if not isinstance(request, dict) or not isinstance(response, dict):
            continue
        url = request.get("url")
        if not isinstance(url, str):
            continue
        provider = provider_for_url(url)
        if provider is None:
            continue  # Never report URLs/keys or decode unrelated traffic.
        content = response.get("content")
        if not isinstance(content, dict) or not isinstance(content.get("text"), str):
            continue
        status = response.get("status")
        item = {"index": index, "provider": provider,
                "route": route_for_url(url, provider),
                "http_status": status if type(status) is int else None}
        responses.append((item, content))
    meta = {"provider_entries": [item for item, _ in responses],
            "selected_index": response_index}
    if response_index is None:
        if len(responses) != 1:
            return Decoded(None, (), "ambiguous_har" if responses else "no_provider_response"), meta
        item, content = responses[0]
        meta["selected_index"] = item["index"]
    else:
        selected = [(item, content) for item, content in responses if item["index"] == response_index]
        if not selected:
            raise SnapshotError("HAR index does not select a supported provider response")
        item, content = selected[0]
    if loader is not None and loader["providers"] and item["provider"] not in loader["providers"]:
        return Decoded(None, (), "provider_mismatch"), meta
    if item["http_status"] != 200:
        return Decoded(None, (), "http_error"), meta
    if item["route"] == "sdk-library":
        # The Jnkie SDK is a library that may subsequently fetch a script.
        # Do not accidentally export its own Lua as the protected game body.
        return Decoded(None, (), "sdk_only"), meta
    text = content["text"]
    if content.get("encoding") == "base64":
        body = _decode_base64(text)
        layers = (_layer("har-base64", body),)
    else:
        body = text.encode("utf-8")
        layers = ()
    return decode_response(body, layers), meta


def export_payload(path: Path, decoded: Decoded) -> None:
    if decoded.status not in ("protected_payload", "lua_source_candidate") or decoded.data is None:
        raise SnapshotError("no code payload to export (loader/auth/transport is not a recovery)")
    target = path.resolve()
    if (target == ROOT or ROOT in target.parents) and PRIVATE_OUTPUT not in target.parents:
        raise SnapshotError("repository output must be under ignored local-results/ (or outside the repo)")
    path.parent.mkdir(parents=True, exist_ok=True)
    # Exclusive create prevents silent overwrites; only explicit --out writes code.
    with path.open("xb") as dest:
        dest.write(decoded.data)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--loader", type=Path, help="local Lua loader (metadata only)")
    snapshot = parser.add_mutually_exclusive_group()
    snapshot.add_argument("--capture", type=Path, help="local authorized response body, Lua or JSON")
    snapshot.add_argument("--har", type=Path, help="local HAR; never shared/uploaded")
    parser.add_argument("--response-index", type=int, help="zero-based HAR entry index; required if multiple provider responses")
    parser.add_argument("--out", type=Path, help="explicit scratch output for actual Lua payload (NOT the results catalog)")
    parser.add_argument("--report", type=Path, help="optional redacted JSON report")
    args = parser.parse_args(argv)
    if not (args.loader or args.capture or args.har):
        parser.error("supply --loader, --capture, or --har")
    if args.response_index is not None and (args.har is None or args.response_index < 0):
        parser.error("--response-index requires --har and must be non-negative")
    if args.out is not None and not (args.capture or args.har):
        parser.error("--out requires a response snapshot")
    try:
        loader_raw = read_limited(args.loader, MAX_BODY) if args.loader else None
        info = inspect_loader(loader_raw) if loader_raw is not None else None
        local_class = classify(loader_raw) if loader_raw is not None else None
        result: dict = {"mode": "offline-static-only", "loader": info}
        decoded = None
        if args.capture:
            raw = read_limited(args.capture, MAX_BODY)
            decoded = decode_response(raw)
            result["snapshot"] = {"kind": "local-response", "bytes": len(raw), "sha256": digest(raw)}
        elif args.har:
            raw = read_limited(args.har, MAX_HAR)
            decoded, meta = decode_har(raw, args.response_index, info)
            result["snapshot"] = {"kind": "local-har", "bytes": len(raw), "sha256": digest(raw), **meta}
        if decoded is not None:
            result["status"] = decoded.status
        elif info and info["delivery_call_seen"]:
            if local_class == "protected_payload":
                result["status"] = "loader_with_protected_code"
            elif info["inline_remote_call_hint_seen"]:
                result["status"] = "loader_with_inline_code"
            else:
                result["status"] = "loader_only"
        elif local_class == "protected_payload":
            result["status"] = "protected_local_file"
        else:
            result["status"] = "no_snapshot"
        result["layers"] = list(decoded.layers) if decoded else []
        if decoded and decoded.data is not None:
            result["payload"] = {"bytes": len(decoded.data), "sha256": digest(decoded.data)}
        result["gameplay_verified"] = False
        result["deobfuscated"] = False
        result["exported"] = False
        if args.out:
            export_payload(args.out, decoded)
            result["exported"] = True
        text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
        if args.report:
            args.report.parent.mkdir(parents=True, exist_ok=True)
            with args.report.open("x", encoding="utf-8") as dest:
                dest.write(text)
        print(text, end="")
        return 0
    except SnapshotError as exc:
        # All SnapshotError messages above are fixed text, never response data.
        print(f"offline snapshot rejected: {exc}", file=sys.stderr)
        return 2
    except (FileExistsError, OSError, UnicodeError) as exc:
        # OS/codec exceptions can contain filenames or input snippets.
        print(f"offline snapshot rejected: {type(exc).__name__}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
