"""Static check of ouroboros_recon.lua: every Module.Name in the glue must exist.

Usage: python3 tools/check_bundle.py
"""
import re

FILES = [("Core", "ouroboros_core.lua"), ("Move", "ouroboros_move.lua"),
         ("Farm", "ouroboros_farm.lua"), ("Skills", "ouroboros_skills.lua"),
         ("Combat", "ouroboros_combat.lua"), ("Equip", "ouroboros_equip.lua"),
         ("Parry", "ouroboros_parry.lua"), ("Config", "ouroboros_config.lua"),
         ("UI", "ouroboros_ui.lua"), ("ESP", "ouroboros_esp.lua")]


def exports(name, path):
    src = open(path, encoding="utf-8").read()
    if name == "Core":
        return set(re.findall(r'\bCore\.([A-Za-z_]\w*)\s*=', src))
    if name == "Config":
        return set(re.findall(r'\bM\.([A-Za-z_]\w*)\s*=', src)) | \
               set(re.findall(r'function M\.([A-Za-z_]\w*)', src))
    if name == "UI":
        return set(re.findall(r'\bM\.([A-Za-z_]\w*)\s*=', src)) | \
               set(re.findall(r'function M\.([A-Za-z_]\w*)', src))
    i = src.rindex("\nreturn {")
    return set(re.findall(r'^\s{4,8}([A-Za-z_]\w*)\s*=', src[i:], re.M))


def main():
    mods = {name: exports(name, path) for name, path in FILES}
    bundle = open("ouroboros_recon.lua", encoding="utf-8").read()
    glue = bundle[bundle.rindex("-- 4b. ДАННЫЕ"):]
    bad = set()
    for m in re.finditer(r'\b(Core|Move|Farm|Skills|Combat|Equip|Parry|Config|UI)\.([A-Za-z_]\w*)', glue):
        mod, attr = m.group(1), m.group(2)
        if attr not in mods.get(mod, set()):
            bad.add("%s.%s" % (mod, attr))
    for b in sorted(bad):
        print("НЕТ:", b)
    print("проверено модулей: %d, проблем: %d" % (len(mods), len(bad)))
    return 1 if bad else 0


if __name__ == "__main__":
    raise SystemExit(main())
