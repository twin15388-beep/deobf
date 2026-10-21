"""Remove outbound telemetry from a pinned MIT Aztup GPO source snapshot.

Usage: python -m scripts.sanitize_aztup_gpo UPSTREAM_MAIN.lua OUTPUT.lua
This is a *source-code* edit: the Roblox script is never executed. The input
hash pins ModerkaScripts/Aztup-Hub-V3@45bcead9/files/games/GrandPieceOnline/main.lua.
The original hub runtime is NOT bundled; it must be audited separately.
"""

import argparse
import hashlib
from pathlib import Path
import re

SOURCE_SHA256 = "03c1e5270797a413a551d99e74d2b552155da9439661b5cd513a0a2ad421a2d3"


def strip_telemetry(source: bytes) -> bytes:
    if hashlib.sha256(source).hexdigest() != SOURCE_SHA256:
        raise ValueError("GPO upstream SHA-256 mismatch; inspect changed input manually")
    text = source.decode("utf-8")

    def remove_once(old: str, new: str = "") -> None:
        nonlocal text
        count = text.count(old)
        if count != 1:
            raise ValueError(f"GPO telemetry pattern expected once, found {count}: {old[:65]!r}")
        text = text.replace(old, new, 1)

    remove_once("local prettyPrint = sharedRequire('@utils/prettyPrint.lua');\n")
    remove_once("local BLACKLISTED_PLACE_IDS = debugMode and {} or {LOBBY_PLACE_ID, UNIVERSE_PLACE_ID, TRADE_HUB_PLACE_ID};\n")
    remove_once("local BanWebhook = Webhook.new('someURL');\nlocal FireWebhook = Webhook.new('someURL');\n\n")
    remove_once(
        "local usedFeatures = {};\n\nlocal function addUsedFeature(name)\n"
        "    if (not table.find(usedFeatures, name)) then\n"
        "        table.insert(usedFeatures, name);\n"
        "    end;\nend;\n\n"
    )
    remove_once(
        "do -- // GPO Ban Analytics\n"
        "    if (game.PlaceId == BATTLE_ROYALE_PLACE_ID) then\n"
        "        local sent = {};\n\n"
        "        LocalPlayer.OnTeleport:Connect(function(_, placeId)\n"
        "            if (not table.find(BLACKLISTED_PLACE_IDS, placeId) and not sent[placeId]) then\n"
        "                sent[placeId] = true;\n\n"
        "                local webhookMsg = string.format('User:%s\\nPlaceId:%s\\nUser Features:\\n`%s`', accountData and accountData.uuid or 'non', tostring(placeId), table.concat(usedFeatures, '\\n'));\n"
        "                BanWebhook:Send(webhookMsg)\n"
        "            end;\n"
        "        end);\n\n"
        "        local function onErrorMessageChanged()\n"
        "            local errorCode = GuiService:GetErrorCode();\n"
        "            if (errorCode ~= Enum.ConnectionError.DisconnectLuaKick) then return end;\n\n"
        "            local errorMessage = GuiService:GetErrorMessage();\n\n"
        "            if (sent[errorMessage]) then return end;\n"
        "            sent[errorMessage] = true;\n\n"
        "            local webhookMsg = string.format('User:%s\\nMsg:%s\\nUser Features:\\n`%s`', accountData and accountData.uuid or 'non', tostring(errorMessage), table.concat(usedFeatures, '\\n'));\n"
        "            BanWebhook:Send(webhookMsg);\n"
        "        end;\n\n"
        "        GuiService.ErrorMessageChanged:Connect(onErrorMessageChanged);\n"
        "    end;\nend;\n\n"
    )
    remove_once(
        "                if (string.find(tra, 'trade.LocalScript')) then\n"
        "                    local payload = {...};\n"
        "                    task.spawn(function()\n"
        "                        payload._remote = self;\n"
        "                        payload._type = 'nc';\n"
        "                        payload._tra = tra;\n"
        "                        payload = prettyPrint(payload);\n"
        "                        FireWebhook:Send(payload);\n"
        "                    end);\n"
        "                end;\n\n"
    )
    remove_once(
        "                    else\n"
        "                        local payload = {...};\n\n"
        "                        task.spawn(function()\n"
        "                            if (#payload == 2 and payload[1] == 10 and payload[2] == 'dash') then return end;\n"
        "                            payload = prettyPrint(payload);\n"
        "                            FireWebhook:Send(string.format('%s - %s - %s', accountData.uuid, tra, payload));\n"
        "                        end);\n"
    )
    remove_once(
        "                if (string.find(tra, 'LocalScript2.ModuleScript')) then\n"
        "                    local payload = {...};\n"
        "                    task.spawn(function()\n"
        "                        payload._remote = self;\n"
        "                        payload._type = 'nc';\n"
        "                        payload._tra = tra;\n"
        "                        payload = prettyPrint(payload);\n"
        "                        FireWebhook:Send(payload);\n"
        "                    end);\n"
        "                    return;\n"
        "                end;\n",
        "                if (string.find(tra, 'LocalScript2.ModuleScript')) then\n"
        "                    return;\n"
        "                end;\n",
    )
    remove_once(
        "                task.spawn(function()\n"
        "                    local payload2 = string.format('Ban attempt lol\\nUser:%s\\nTrace:%s\\nPayload:%s', accountData.uuid, tra, prettyPrint(payload));\n"
        "                    FireWebhook:Send(payload2);\n"
        "                end);\n\n"
    )
    remove_once(
        "            if (string.find(tra, 'trade.LocalScript')) then\n\n"
        "                task.spawn(function()\n"
        "                    payload._remote = self;\n"
        "                    payload._type = 'hf';\n"
        "                    payload._tra = tra;\n"
        "                    payload = prettyPrint(payload);\n"
        "                    FireWebhook:Send(payload);\n"
        "                end);\n"
        "            end;\n\n"
    )
    remove_once(
        "                if (string.find(tra, 'LocalScript2.ModuleScript')) then\n"
        "                    local payload = {...};\n\n"
        "                    task.spawn(function()\n"
        "                        payload._remote = self;\n"
        "                        payload._type = 'hf';\n"
        "                        payload._tra = tra;\n"
        "                        payload = prettyPrint(payload);\n"
        "                        FireWebhook:Send(payload);\n"
        "                    end);\n"
        "                    return;\n"
        "                end;\n",
        "                if (string.find(tra, 'LocalScript2.ModuleScript')) then\n"
        "                    return;\n"
        "                end;\n",
    )

    # The sole remaining use of this list was the outbound report above.
    text, count = re.subn(r"(?m)^\s*addUsedFeature\([^\n]*\);\n", "", text)
    if count != 11:
        raise ValueError(f"expected eleven instrumentation calls, found {count}")
    remove_once("                    -- addUsedFeature('no ship dmg');\n")
    remove_once("        --         addUsedFeature('no jump cd');\n")
    for marker in ("BanWebhook", "FireWebhook", "usedFeatures", "prettyPrint(",
                   "addUsedFeature(", "rscripts.net/api/telemetry"):
        if marker in text:
            raise ValueError(f"outbound telemetry remains: {marker}")
    # Note: the configurable DF notifier Webhook.new(webhookLink) remains
    # deliberately, because it is disabled unless the user sets a URL.
    return text.encode("utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    args.output.write_bytes(strip_telemetry(args.source.read_bytes()))


if __name__ == "__main__":
    main()
