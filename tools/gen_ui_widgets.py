"""Extract the UI widget tree (tabs -> groupboxes -> widgets) from the artifact.

The UI is built in one function (render lines ~6771..6900 and the second copy at
~33515). Every constructor call has an explicit receiver (`aV7[4]:AddLeftGroupbox`,
`cGi:AddTab`, `cGj:AddToggle`), so the tree is rebuilt by tracking, in source
order, which object each assignment creates and which receiver each call uses.

Writes data/ui_tree.json:
    {"tabs": [{"name", "icon", "groups": [{"side", "name", "icon", "widgets": [...]}]}]}

Usage: python3 tools/gen_ui_widgets.py [first|second]
"""
import json
import re
import sys

SRC = "ouroboros_main_pruned.txt"
OUT = "data/ui_tree.json"

HEAD = re.compile(r'[A-Za-z_][\w.]*(\s*\[[^\]]*\])?\s*:\s*$')


def match_call(text, open_paren):
    depth, j = 1, open_paren + 1
    while j < len(text) and depth > 0:
        c = text[j]
        if c == '(':
            depth += 1
        elif c == ')':
            depth -= 1
        elif c == '"':
            j += 1
            while j < len(text) and text[j] != '"':
                if text[j] == "\\":
                    j += 1
                j += 1
        j += 1
    return text[open_paren + 1:j - 1], j


def field(body, name):
    m = re.search(r'\["%s"\] = ("(?:[^"\\]|\\.)*"|true|false|-?[\d.]+|\{[^{}]*\})' % name, body)
    return m.group(1) if m else None


def unq(s):
    return s.strip().strip('"') if s else s


def norm(expr):
    return re.sub(r'\s+', '', expr)


def main():
    which = sys.argv[1] if len(sys.argv) > 1 else "first"
    lines = open(SRC, encoding="utf-8", errors="replace").read().split("\n")
    start = 6760 if which == "first" else 33505
    end = 6910 if which == "first" else 33660
    text = "\n".join(lines[start:end])

    CALL = re.compile(r'([A-Za-z_][\w.\[\]\s]*?)\s*:\s*Add(Toggle|Slider|Dropdown|Input|KeyPicker|'
                      r'ColorPicker|Button|Label|Divider|LeftGroupbox|RightGroupbox|Groupbox|'
                      r'Tab|Tabbox|LeftTabbox|RightTabbox|DependencyBox|DiscordBox|SubButton)\s*\(')

    tabs, tab_of, group_of, tabbox_of, cur_tab = [], {}, {}, {}, None


    def tab_entry(name, icon):
        for tb in tabs:
            if tb["name"] == name:
                return tb
        tabs.append({"name": name, "icon": icon, "groups": []})
        return tabs[-1]

    # `aV7 = {[1] = aV6:AddTab("Farming", "swords"), ...}` — табы окна
    skip = set()
    for cm in re.finditer(r'(\w+)\s*=\s*\{((?:\s*\[\d+\]\s*=\s*\w+\s*:\s*AddTab\s*\([^)]*\)\s*,?)+)\}', text):
        owner = cm.group(1)
        for tm in re.finditer(r'\[\s*(\d+)\s*\]\s*=\s*\w+\s*:\s*AddTab\s*\(\s*"([^"]+)"\s*(?:,\s*"([^"]*)")?\s*\)', cm.group(2)):
            idx, name, icon = tm.group(1), tm.group(2), tm.group(3)
            tb = tab_entry(name, icon)
            tab_of["%s[%s]" % (owner, idx)] = tb
            cur_tab = tb
            skip.add(cm.start(2) + tm.start())


    for m in CALL.finditer(text):
        if m.start() in skip:
            continue
        recv = norm(m.group(1))
        kind = m.group(2)
        inner, _ = match_call(text, m.end() - 1)
        # assignment target: the identifier right before `=` preceding the call
        before = text[max(0, m.start() - 80):m.start()]
        am = re.search(r'([A-Za-z_]\w*)\s*(?:\[\s*(\d+)\s*\])?\s*=\s*$', before)
        target = None
        if am:
            target = am.group(1) if am.group(2) is None else "%s[%s]" % (am.group(1), am.group(2))

        if kind in ("Tab", "Tabbox", "LeftTabbox", "RightTabbox"):
            name = unq(inner.split(",")[0])
            if kind == "Tab":
                parent_tab = tab_of.get(recv) or tabbox_of.get(recv)
                tb = tab_entry(("%s / %s" % (parent_tab["name"], name)) if parent_tab else name,
                               unq(inner.split(",")[1]) if "," in inner else None)
                if target:
                    tab_of[target] = tb
                    if target.startswith("aV7[") or "[" not in recv:
                        cur_tab = tb
            else:                                   # tabbox: remember the owning tab
                if target:
                    tabbox_of[target] = tab_of.get(recv, cur_tab) or cur_tab
            continue

        if kind in ("LeftGroupbox", "RightGroupbox", "Groupbox"):
            tb = tab_of.get(recv) or tabbox_of.get(recv) or cur_tab or tab_entry("(root)", None)
            name = unq(inner.split(",")[0])
            icon = unq(inner.split(",")[1]) if "," in inner else None
            side = "right" if kind == "RightGroupbox" else "left"
            grp = {"side": side, "name": name, "icon": icon, "widgets": []}
            tb["groups"].append(grp)
            if target:
                group_of[target] = grp
            continue

        if kind == "DependencyBox":
            if target:
                group_of[target] = group_of.get(recv) or group_of.get("(last)")
            continue
        if kind in ("Divider", "DiscordBox", "SubButton"):
            continue

        grp = group_of.get(recv)
        if grp is None:
            tb = cur_tab or tab_entry("(root)", None)
            grp = {"side": "left", "name": "(root)", "icon": None, "widgets": []}
            tb["groups"].append(grp)
            group_of[recv] = grp
        key = None
        km = re.match(r'\s*"([^"]+)"\s*,', inner)
        if km:
            key = km.group(1)
        sm = re.search(r'\["(Set[A-Za-z0-9_]+)"\]', inner)
        action = None
        if kind == "Button":
            acts = [x for x in re.findall(r'\["([A-Za-z][A-Za-z0-9_]*)"\]', inner)
                    if not x.startswith(("Text", "Tooltip", "Func", "Default"))]
            action = acts[0] if acts else None
        grp["widgets"].append({
            "kind": kind, "key": key, "setter": sm.group(1) if sm else None,
            "action": action,
            "text": field(inner, "Text"), "default": field(inner, "Default"),
            "min": field(inner, "Min"), "max": field(inner, "Max"),
            "suffix": field(inner, "Suffix"), "tooltip": field(inner, "Tooltip"),
            "values": field(inner, "Values"), "multi": field(inner, "Multi"),
            "label": None if key else unq(inner.strip())[:140],
        })

    json.dump({"tabs": tabs}, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    w = sum(len(g["widgets"]) for tb in tabs for g in tb["groups"])
    print("tabs=%d groups=%d widgets=%d -> %s" %
          (len(tabs), sum(len(tb["groups"]) for tb in tabs), w, OUT))
    for tb in tabs:
        print("  %-22s groups=%-3d widgets=%d" % (tb["name"], len(tb["groups"]),
              sum(len(g["widgets"]) for g in tb["groups"])))
        for g in tb["groups"]:
            print("      [%s] %-22s %s" % (g["side"], g["name"],
                  ", ".join(x["kind"] + (":" + x["key"] if x["key"] else "") for x in g["widgets"])))


if __name__ == "__main__":
    main()
