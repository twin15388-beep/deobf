"""Synthetic, no-network tests for offline Luarmor/Jnkie delivery inspection."""

import base64
import contextlib
import io
import json
import tempfile
import unittest
from pathlib import Path

from scripts.inspect_api_delivery import (
    CATALOG, MAX_BODY, ROOT, SnapshotError, classify, decode_har, decode_response,
    export_payload, inspect_loader, main, provider_for_url, route_for_url,
    unwrap_literal_loadstring,
)


LUARMOR_URL = "https://api.luarmor.net/files/v3/loaders/NOT_A_REAL_PUBLIC_ID.lua"
JNKIE_URL = "https://jnkie.com/sdk/library.lua"
GAME = (b"local ReplicatedStorage = game:GetService('ReplicatedStorage')\n"
        b"workspace.Quest.Remote:FireServer('AcceptQuest')\n")
VM = b"-- This file was protected with MoonSec V3\nreturn(function(...) end)()\n"


class DeliveryTests(unittest.TestCase):
    def test_luarmor_loader_redacts_key_and_identifier(self):
        loader = (b'script_key = "TOP_SECRET_KEY"\nloadstring(game:HttpGet("'
                  + LUARMOR_URL.encode() + b'?key=ANOTHER_SECRET"))()')
        info = inspect_loader(loader)
        self.assertEqual(info["providers"], ["luarmor"])
        self.assertEqual(info["literal_http_routes"], [{"provider": "luarmor", "route": "loader",
                                                        "reference": "direct-http"}])
        self.assertTrue(info["auth_or_sdk_call_seen"])
        self.assertTrue(info["delivery_call_seen"])
        self.assertNotIn("SECRET", json.dumps(info))
        self.assertNotIn("PUBLIC_ID", json.dumps(info))
        self.assertEqual(provider_for_url("https://luarmor.net.attacker.invalid/x"), None)
        self.assertEqual(provider_for_url("http://api.luarmor.net/"), None)
        self.assertEqual(provider_for_url("https://api.luarmor.net@evil.invalid/x"), None)

    def test_jnkie_sdk_is_not_the_game_script(self):
        loader = (b'local Junkie = loadstring(game:HttpGet("' + JNKIE_URL.encode()
                  + b'"))()\nJunkie.script_id="PUBLIC"\ngetgenv().SCRIPT_KEY="SECRET"\n'
                  + b'Junkie.load_script()')
        info = inspect_loader(loader)
        self.assertEqual(info["providers"], ["jnkie"])
        self.assertEqual(info["literal_http_routes"], [{"provider": "jnkie", "route": "sdk-library",
                                                        "reference": "direct-http"}])
        self.assertEqual(classify(loader), "loader_only")
        self.assertTrue(info["auth_or_sdk_call_seen"])
        self.assertNotIn("SECRET", json.dumps(info))

    def test_jnkie_public_delivery_routes_are_redacted(self):
        urls = {
            "https://api.jnkie.com/api/v1/luascripts/public/FAKE/download?key=SECRET": "public-loader",
            "https://api.jnkie.com/api/v1/loaders/public/FAKE/download": "public-loader",
            "https://api.jnkie.com/api/v1/luascripts/delivery/FAKE": "delivery",
            "https://cdn.jnkie.com/signed/FAKE.lua?sig=SECRET": "signed-payload",
        }
        for url, expected in urls.items():
            self.assertEqual(provider_for_url(url), "jnkie")
            self.assertEqual(route_for_url(url, "jnkie"), expected)
        loader = inspect_loader(('loadstring(game:HttpGet("' + next(iter(urls)) + '"))()').encode())
        self.assertEqual(loader["literal_http_routes"][0]["route"], "public-loader")
        self.assertNotIn("SECRET", json.dumps(loader))
        self.assertNotIn("FAKE", json.dumps(loader))

    def test_jnkie_sdk_url_passed_through_a_variable(self):
        loader = (b'local SDK_URL = "' + JNKIE_URL.encode() + b'"\n'
                  b'local function safeLoad(url) return loadstring(game:HttpGet(url))() end\n'
                  b'function Jnkie:CheckKey(key) return safeLoad(SDK_URL) end')
        info = inspect_loader(loader)
        self.assertEqual(info["providers"], ["jnkie"])
        self.assertEqual(info["literal_http_routes"], [{"provider": "jnkie", "route": "sdk-library",
                                                        "reference": "literal-url"}])
        self.assertTrue(info["unresolved_http_calls"])
        self.assertTrue(info["delivery_call_seen"])
        self.assertTrue(info["auth_or_sdk_call_seen"])

    def test_explicit_json_base64_and_whole_decimal_wrapper(self):
        literal = b"".join(b"\\%03d" % b for b in GAME)
        wrapper = b"--[=[ transport ]=] return loadstring('" + literal + b"')() -- tail\n"
        response = json.dumps({"encoding": "base64", "data": {"irrelevant": "x"},
                               "payload": base64.b64encode(wrapper).decode()}).encode()
        result = decode_response(response)
        self.assertEqual(result.status, "lua_source_candidate")
        self.assertEqual(result.data, GAME)
        self.assertEqual([part["transform"] for part in result.layers],
                         ["json-base64", "literal-loadstring"])

    def test_base64_data_field_and_multiple_json_fields(self):
        response = json.dumps({"encoding": "base64", "data": base64.b64encode(VM).decode()}).encode()
        result = decode_response(response)
        self.assertEqual(result.status, "protected_payload")
        self.assertEqual(result.data, VM)
        self.assertEqual(result.layers[0]["transform"], "json-base64")

        # A loader in the first field must not hide the actual local body.
        loader = 'loadstring(game:HttpGet("' + LUARMOR_URL + '"))()'
        result = decode_response(json.dumps({"script": loader, "payload": VM.decode()}).encode())
        self.assertEqual(result.status, "protected_payload")
        self.assertEqual(result.data, VM)
        self.assertEqual(result.layers[0]["transform"], "json-payload")

        # Two distinct source candidates require explicit human selection.
        for other in ("local x = 1", VM.decode()):
            result = decode_response(json.dumps({"script": GAME.decode(), "payload": other}).encode())
            self.assertEqual(result.status, "ambiguous_json_fields")
            self.assertIsNone(result.data)

    def test_comments_and_strings_do_not_invent_gameplay_or_providers(self):
        loader = b'loadstring(game:HttpGet("' + LUARMOR_URL.encode() + b'"))()'
        commented = (b'-- game.Quest.Remote:FireServer("fake")\n'
                     b'-- loadstring(game:HttpGet("' + JNKIE_URL.encode() + b'"))()\n'
                     b'local note = ":InvokeServer(fake)"\n' + loader)
        info = inspect_loader(commented)
        self.assertEqual(info["providers"], ["luarmor"])
        self.assertEqual(len(info["literal_http_routes"]), 1)
        self.assertEqual(info["literal_http_routes"][0]["reference"], "direct-http")
        self.assertFalse(info["inline_remote_call_hint_seen"])
        self.assertEqual(classify(commented), "loader_only")
        quoted_banner = b'local note = "This file was protected with MoonSec V3"\n' + loader
        self.assertEqual(classify(quoted_banner), "loader_only")
        self.assertEqual(classify(b"-- Luraph Obfuscator v15\n"), "unverified_data")
        self.assertEqual(classify(b"-- Luraph Obfuscator v15\n" + loader), "loader_only")

    def test_loader_with_inline_remote_calls_is_not_loader_only(self):
        script = (b"repeat task.wait() until game:IsLoaded()\n"
                  b'local lib=loadstring(game:HttpGet("' + LUARMOR_URL.encode() + b'"))()\n'
                  b'local optional_hook = "LPH_ENCSTR" -- quoted API name, not a VM\n'
                  b'game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")\n')
        self.assertEqual(classify(script), "lua_source_candidate")
        self.assertTrue(inspect_loader(script)["inline_remote_call_hint_seen"])
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "mixed.lua"
            path.write_bytes(script)
            with contextlib.redirect_stdout(io.StringIO()) as buf:
                self.assertEqual(main(["--loader", str(path)]), 0)
            result = json.loads(buf.getvalue())
            self.assertEqual(result["status"], "loader_with_inline_code")
            self.assertFalse(result["gameplay_verified"])
            self.assertFalse(result["deobfuscated"])

    def test_loader_plus_embedded_vm_not_reported_loader_only(self):
        mixed = (b'local sdk = loadstring(game:HttpGet("' + JNKIE_URL.encode() + b'"))()\n'
                 b'-- This file was protected using Luraph Obfuscator v14.6\n'
                 b'return(function() local virtualized = {} end)()\n')
        self.assertEqual(classify(mixed), "protected_payload")
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "jnkie.lua"
            path.write_bytes(mixed)
            with contextlib.redirect_stdout(io.StringIO()) as buf:
                self.assertEqual(main(["--loader", str(path)]), 0)
            result = json.loads(buf.getvalue())
            self.assertEqual(result["status"], "loader_with_protected_code")
            self.assertEqual(result["loader"]["providers"], ["jnkie"])
            self.assertFalse(result["deobfuscated"])

    def test_long_brackets_and_escapes_preserve_exact_payload(self):
        self.assertEqual(unwrap_literal_loadstring(
            b"-- hi\nloadstring([==[\n" + GAME + b"]==])(); -- done\n"), GAME)
        self.assertEqual(unwrap_literal_loadstring(
            rb"loadstring('\065\x42\z " + b"\n   " + rb"\n\"\\')()"), b'AB\n"\\')
        self.assertIsNone(unwrap_literal_loadstring(b"loadstring('\\256')()"))
        self.assertIsNone(unwrap_literal_loadstring(b"loadstring('\\xQ1')()"))

    def test_never_extract_partial_wrapper_or_dynamic_http(self):
        for raw in (b"print('before'); loadstring('local x=1')()",
                    b"loadstring('local x=1')() ; print('after')",
                    b"loadstring(game:HttpGet('https://api.luarmor.net/x'))()",
                    b"loadstring('local x=1'.. dynamic)()"):
            self.assertIsNone(unwrap_literal_loadstring(raw))

    def test_auth_json_is_not_source_or_game_recovery(self):
        for response in ({"code": "KEY_INVALID", "message": "secret"},
                         {"code": "KEY_VALID", "data": {"auth_expire": 123}},
                         {"success": True, "data": {"key": "NOT_SCRIPT"}}):
            result = decode_response(json.dumps(response).encode())
            self.assertEqual(result.status, "auth_or_no_script")
            self.assertIsNone(result.data)

    def test_vm_remains_protected_and_loader_not_exportable(self):
        self.assertEqual(decode_response(VM).status, "protected_payload")
        self.assertEqual(classify(b"-- Luraph Obfuscator v15\nlocal x=1"), "protected_payload")
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "vm.lua"
            export_payload(path, decode_response(VM))
            self.assertEqual(path.read_bytes(), VM)
            with self.assertRaises(SnapshotError):
                export_payload(Path(temp) / "not-code.lua", decode_response(
                    b'loadstring(game:HttpGet("' + LUARMOR_URL.encode() + b'"))()'))
            self.assertFalse((Path(temp) / "not-code.lua").exists())

    def test_no_execution_even_when_payload_has_side_effects(self):
        with tempfile.TemporaryDirectory() as temp:
            sentinel = Path(temp) / "never_created"
            # A downloaded script is *data*, even when it contains system calls.
            lua = ("local x = os.execute('touch " + str(sentinel) + "')\n").encode()
            response = json.dumps({"script": lua.decode()}).encode()
            self.assertEqual(decode_response(response).data, lua)
            self.assertFalse(sentinel.exists())

    def test_har_explicit_selection_and_host_filter(self):
        har = {"log": {"entries": [
            {"request": {"url": "https://api.luarmor.net.attacker.invalid/"},
             "response": {"status": 200, "content": {"text": "secret"}}},
            {"request": {"url": JNKIE_URL + "?token=SECRET"},
             "response": {"status": 200, "content": {"text": "local SDK = {}\nreturn SDK"}}},
            {"request": {"url": "https://jnkie.com/get/PUBLIC?key=SECRET"},
             "response": {"status": 200, "content": {"text": base64.b64encode(VM).decode(),
                                                      "encoding": "base64"}}},
        ]}}
        loader = inspect_loader(b'local Junkie = loadstring(game:HttpGet("'
                                + JNKIE_URL.encode() + b'"))(); Junkie.load_script()')
        raw = json.dumps(har).encode()
        result, meta = decode_har(raw, None, loader)
        self.assertEqual(result.status, "ambiguous_har")
        self.assertEqual([item["index"] for item in meta["provider_entries"]], [1, 2])
        self.assertNotIn("SECRET", json.dumps(meta))
        sdk_result, _ = decode_har(raw, 1, loader)
        self.assertEqual(sdk_result.status, "sdk_only")
        with tempfile.TemporaryDirectory() as temp, self.assertRaises(SnapshotError):
            export_payload(Path(temp) / "not-game.lua", sdk_result)
        result, meta = decode_har(raw, 2, loader)
        self.assertEqual(result.status, "protected_payload")
        self.assertEqual(result.data, VM)
        self.assertEqual(result.layers[0]["transform"], "har-base64")
        wrong_loader = inspect_loader(b'loadstring(game:HttpGet("'
                                      + LUARMOR_URL.encode() + b'"))()')
        self.assertEqual(decode_har(raw, 2, wrong_loader)[0].status, "provider_mismatch")
        with self.assertRaises(SnapshotError):
            decode_har(raw, 0, loader)

    def test_har_http_error_and_bad_base64(self):
        entry = {"request": {"url": LUARMOR_URL},
                 "response": {"status": 403, "content": {"text": "not authorized"}}}
        self.assertEqual(decode_har(json.dumps({"log": {"entries": [entry]}}).encode(),
                                    None, None)[0].status, "http_error")
        entry["response"] = {"status": 200, "content": {"text": "NOT BASE64",
                                                        "encoding": "base64"}}
        with self.assertRaises(SnapshotError):
            decode_har(json.dumps({"log": {"entries": [entry]}}).encode(), None, None)

    def test_size_limits_and_no_tracked_repository_output(self):
        with self.assertRaises(SnapshotError):
            decode_response(b" " * (MAX_BODY + 1))
        for target in (CATALOG / "Do Not Publish.lua", ROOT / "scripts" / "Do Not Publish.lua"):
            with self.assertRaises(SnapshotError):
                export_payload(target, decode_response(GAME))
            self.assertFalse(target.exists())

    def test_cli_redacted_report_and_exclusive_scratch_output(self):
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            loader = directory / "input.lua"
            loader.write_text('script_key="SECRET_KEY"\nloadstring(game:HttpGet("'
                              + LUARMOR_URL + '?token=SECRET_TOKEN"))()')
            capture = directory / "local-response.json"
            capture.write_text(json.dumps({"data": {"script": VM.decode()}}))
            output = directory / "private" / "payload.lua"
            report = directory / "redacted.json"
            buf = io.StringIO()
            with contextlib.redirect_stdout(buf):
                self.assertEqual(main(["--loader", str(loader), "--capture", str(capture),
                                       "--out", str(output), "--report", str(report)]), 0)
            self.assertEqual(output.read_bytes(), VM)
            self.assertEqual(json.loads(buf.getvalue())["status"], "protected_payload")
            for forbidden in ("SECRET_KEY", "SECRET_TOKEN", "NOT_A_REAL_PUBLIC_ID"):
                self.assertNotIn(forbidden, buf.getvalue())
                self.assertNotIn(forbidden, report.read_text())
            with contextlib.redirect_stderr(io.StringIO()):
                self.assertEqual(main(["--capture", str(capture), "--out", str(output)]), 2)
            self.assertEqual(output.read_bytes(), VM)


if __name__ == "__main__":
    unittest.main()
