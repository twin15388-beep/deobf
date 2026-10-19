"""Static VM-to-Lua-5.1 bytecode lift for FOUR pinned Script-Dump files.

This is intentionally NOT a universal AztupBrew deobfuscator: opcode numbers,
mega-instruction lengths, constant tags and prototype layouts are permuted
between these files.  Unknown instructions and unknown input SHA-256s are
rejected instead of silently generating plausible but incorrect Lua.

The VM interpreter in each protected input was *read*, not run.  The opcode
profiles below map its effects to Lua 5.1 instructions.  The last stage can be
fed to a separately installed Lua 5.1 decompiler; it never executes Roblox Lua.
"""

from __future__ import annotations

from dataclasses import dataclass
import hashlib
import struct

from .decode import parse_bytes, walk


@dataclass(frozen=True)
class Profile:
    name: str
    sha256: str
    tags: tuple[int, int, int]  # bool, number, string; the remaining tag is nil
    layout: str  # a: parameter count, i: instruction list, p: nested prototypes
    superops: dict[int, tuple[str, ...]]
    simple: dict[int, str]
    child_upvalues: int = 0
    canonical_tdm: bool = False
    liftable: bool = True
    expected_protos: int = 1
    expected_ins: int = 0


GOG = Profile(
    name="GodOfGlory_DestroyWorld_OBED.lua",
    sha256="08c0dc490d952d4991c78531ede1c0adfc8faab6b5bd8198822beb2fb9fc23f5",
    tags=(2, 0, 1), layout="aip", expected_protos=2, expected_ins=81,
    superops={
        44: ("GETGLOBAL", "SELF", "LOADK", "CALLRET", "GETTABLE", "GETTABLE", "SETGLOBAL", "GETGLOBAL", "SELF", "LOADK"),
        7: ("GETTABLE", "GETTABLE", "SETGLOBAL", "GETGLOBAL", "SELF", "LOADK", "CALLRET", "GETTABLE", "EQ_NEJMP"),
        12: ("GETGLOBAL", "GETGLOBAL", "SELF", "CALLMULTI", "CALLRETCOUNT", "JMP"),
        1: ("SELF", "NEWTABLE", "GETGLOBAL", "SELF", "CALLMULTI", "CALLVARRET", "SETTABLE", "CALLVOID"),
    },
    simple={0: "CALLRET", 3: "JMP", 5: "GETTABLE", 10: "SETTABLE", 16: "SELF",
            24: "CALL1VOID", 26: "RETURN0", 29: "CLOSURE", 34: "GETGLOBAL",
            39: "CALLRET", 41: "LOADK", 14: "TFORLOOP", 20: "EQ_JMPNE",
            22: "TRUTHJMP", 25: "CALL1MULTI", 30: "CALLVARRETCOUNT"},
)

PRIOR = Profile(
    name="PriorExtinction_AntiBanKick_Probably_OBed.lua",
    sha256="7af27dd60d387483855d9c38f2f7e3601ca81d03c5b6b5f3878018adc7e00914",
    tags=(0, 2, 1), layout="pia", expected_protos=2, expected_ins=55,
    child_upvalues=1,
    superops={
        11: ("GETGLOBAL", "GETGLOBAL", "CALL1RET", "GETTABLE", "GETGLOBAL", "MOVE", "LOADBOOL", "CALLVOID", "GETGLOBAL"),
        36: ("CALL1RET", "SETTABLE", "GETGLOBAL", "MOVE", "LOADBOOL", "CALLVOID", "GETGLOBAL", "LOADK", "CALL1VOID", "RETURN0"),
        18: ("MOVE", "VARARGALL", "TAILCALLVAR", "RETURNVAR", "RETURN0"),
    },
    simple={0: "CALLRET", 1: "LOADK", 2: "MOVE", 6: "GETTABLE", 9: "CLOSURE",
            12: "CALL1VOID", 15: "GETGLOBAL", 17: "RETURN1", 22: "CALL0RET",
            23: "JMP", 25: "LOADK", 28: "NEWTABLE", 33: "SETLISTVAR",
            39: "VARARGALL", 40: "EQ_JMPNE", 42: "GETUPVAL", 45: "EQ_NEJMP"},
)

NERF_MONEY = Profile(
    name="NerfFPS_546_INFMONIES_OBED.lua",
    sha256="c3088b181f635b0377b759edfcc104c86eb2d6beb74f5da87d30b29de7378564",
    tags=(0, 3, 1), layout="pia", expected_protos=2, expected_ins=62,
    child_upvalues=1,
    superops={
        7: ("GETGLOBAL", "SELF", "LOADK", "CALLRET", "GETTABLE", "GETTABLE", "GETGLOBAL", "SELF", "CALL1MULTI", "CALLVARRETCOUNT"),
        52: ("GETGLOBAL", "CALL1RET", "GETTABLE", "GETGLOBAL", "MOVE", "LOADBOOL", "CALLVOID", "GETGLOBAL"),
        33: ("CALL1RET", "SETTABLE", "GETGLOBAL", "MOVE", "LOADBOOL", "CALLVOID", "RETURN0"),
        16: ("MOVE", "VARARGALL", "TAILCALLVAR", "RETURNVAR", "RETURN0"),
    },
    simple={1: "CALL0RET", 5: "SETLISTVAR", 9: "NEWTABLE", 11: "EQ_JMPNE",
            13: "CALLRET", 18: "SELF", 19: "GETUPVAL", 24: "VARARGALL",
            26: "TFORLOOP", 27: "CALL1VOID", 28: "RETURN1", 31: "LOADK",
            32: "SETTABLE", 34: "TRUTHJMP", 36: "GETGLOBAL", 37: "LOADNIL",
            40: "MOVE", 45: "JMP", 46: "GETTABLE", 60: "CLOSURE"},
)

NERF_TDM = Profile(
    name="NerfFPS_546_TDM_KillALL_OBED.lua",
    sha256="58cefb372766fec7eded3ece0661654b6d245ef3aabcd5f3df9bb6f1252e4d22",
    tags=(2, 0, 3), layout="aip", expected_protos=1, expected_ins=81,
    canonical_tdm=True,
    superops={
        19: ("GETGLOBAL", "SELF", "LOADK", "CALLRET", "GETTABLE", "GETGLOBAL", "SELF", "LOADK", "CALLRET", "GETTABLE"),
        22: ("SELF", "LOADK", "CALLRET", "SELF", "CALL1RET", "NEWTABLE", "GETGLOBAL", "MOVE", "CALL1RETCOUNT", "JMP"),
        5: ("LEN", "CALL1VOID", "GETGLOBAL", "LOADK", "GETTABLE", "CONCAT", "CALL1VOID"),
        24: ("LOADK", "CALL1VOID", "SELF", "LOADK", "GETTABLE", "LOADK", "LOADK", "LOADBOOL", "CALLVOID", "GETGLOBAL"),
        43: ("GETTABLE", "GETTABLE", "GETTABLE", "CONCAT", "CALL1VOID", "GETTABLE", "GETTABLE", "GETTABLE", "TRUTH_FALSEJMP"),
        18: ("LOADK", "LOADK", "GETTABLE", "LOADK", "LOADK", "CONCAT", "CALL1VOID"),
    },
    simple={6: "TFORLOOP", 7: "CALLVOID", 8: "LOADK", 9: "RETURN0",
            16: "EQ_JMPNE_REG", 17: "MOVE", 25: "JMP", 29: "GETGLOBAL",
            30: "GETTABLE", 42: "CALL1RETCOUNT"},
)

# The entire GOG V3 container parses, but this profile deliberately has no VM
# opcode map; a decoded prototype tree alone is NOT deobfuscated source code.
GOG_V3 = Profile(
    name="GOGV3OBED.lua",
    sha256="f1798b8ba88c1445a70b9f27a46a23fa3441fe192933edbe189a574a43736d03",
    tags=(0, 1, 3), layout="pai", expected_protos=32, expected_ins=733,
    superops={}, simple={}, liftable=False,
)

PROFILES = {profile.name: profile for profile in (GOG, PRIOR, NERF_MONEY, NERF_TDM, GOG_V3)}
BY_SHA256 = {profile.sha256: profile for profile in PROFILES.values()}

# Lua 5.1 instruction numbers, not the shuffled virtual opcodes above.
OP = {"MOVE": 0, "LOADK": 1, "LOADBOOL": 2, "LOADNIL": 3,
      "GETUPVAL": 4, "GETGLOBAL": 5, "GETTABLE": 6, "SETGLOBAL": 7,
      "SETTABLE": 9, "NEWTABLE": 10, "SELF": 11, "LEN": 20, "CONCAT": 21,
      "JMP": 22, "EQ": 23, "TEST": 26, "CALL": 28, "TAILCALL": 29,
      "RETURN": 30, "TFORLOOP": 33, "SETLIST": 34, "CLOSURE": 36, "VARARG": 37}


class LiftError(ValueError):
    """A sample is not safely covered by a complete VM opcode profile."""


def read_profile(content: bytes) -> tuple[Profile, dict, bytes]:
    digest = hashlib.sha256(content).hexdigest()
    profile = BY_SHA256.get(digest)
    if profile is None:
        raise LiftError(f"unknown input SHA-256 {digest}; refusing to guess a VM profile")
    tree, blob = parse_bytes(content, profile.tags, profile.layout)
    protos = list(walk(tree))
    if len(protos) != profile.expected_protos or sum(len(p["ins"]) for p in protos) != profile.expected_ins:
        raise LiftError("prototype/instruction totals disagree with the pinned profile")
    return profile, tree, blob


def actions(proto: dict, profile: Profile) -> dict[int, str]:
    instructions = proto["ins"]
    semantic: dict[int, str] = {}
    consumed: set[int] = set()
    for pc, row in enumerate(instructions, start=1):
        if pc in consumed:
            continue
        code = row[0]
        if code in profile.superops:
            for offset, action in enumerate(profile.superops[code]):
                current = pc + offset
                if current > len(instructions):
                    raise LiftError(f"superinstruction overruns prototype at pc {pc}")
                if offset:
                    if instructions[current - 1][0] != 0:
                        raise LiftError(f"nonzero superinstruction operand at pc {current}")
                    consumed.add(current)
                semantic[current] = action
        elif code in profile.simple:
            semantic[pc] = profile.simple[code]
        else:
            raise LiftError(f"unmapped virtual opcode {code} at depth {proto['depth']}, pc {pc}")
    if set(semantic) != set(range(1, len(instructions) + 1)):
        raise LiftError("incomplete VM instruction coverage")
    if profile.canonical_tdm:
        # This variant has redundant jumps at two equality branches, after
        # each generic-for VM instruction, and after the repeat/until test.
        # They are unreachable in the VM.  Dropping them gives canonical Lua
        # 5.1 branch shapes and avoids false structure-recovery errors.
        for pc, action in tuple(semantic.items()):
            if action == "EQ_JMPNE_REG":
                if (pc + 2 > len(instructions)
                        or instructions[pc][0] != 25
                        or instructions[pc + 1][0] != 25
                        or instructions[pc][2] != pc + 2):
                    raise LiftError(f"unexpected equality jump layout at pc {pc}")
                semantic[pc], semantic[pc + 1], semantic[pc + 2] = "EQ_CANONICAL", "DEAD", "DEAD"
            elif action == "TFORLOOP":
                if pc >= len(instructions) or (instructions[pc][0] != 25
                        or instructions[pc][2] != instructions[pc - 1][2]):
                    raise LiftError(f"unexpected generic-for jump at pc {pc}")
                semantic[pc + 1] = "DEAD"
            elif action == "TRUTH_FALSEJMP":
                if pc >= len(instructions) or (instructions[pc][0] != 25
                        or instructions[pc][2] != instructions[pc - 1][2]):
                    raise LiftError(f"unexpected repeat/until jump at pc {pc}")
                semantic[pc], semantic[pc + 1] = "TRUTH_CANONICAL", "DEAD"
    return semantic


def lift_proto(proto: dict, profile: Profile) -> tuple[list[list[int | str]], dict[int, str]]:
    semantic = actions(proto, profile)
    raw = proto["raw"]
    records: list[list[int | str | None]] = []
    entry: dict[int, int] = {}
    for pc, action in semantic.items():
        entry[pc] = len(records)
        if action == "DEAD":
            continue
        numbers, mask = raw[pc - 1]["nums"], raw[pc - 1]["mask"]
        _, a, b, c = numbers
        if not isinstance(a, int) or a > 240:
            raise LiftError(f"bad register at pc {pc}")

        def const_index(field: int, value: int | None) -> int:
            if (not mask & (1 << (field - 1)) or not isinstance(value, int)
                    or not 1 <= value < len(proto["const"])):
                raise LiftError(f"expected constant reference at pc {pc}, field {field}")
            return value - 1

        def rk(field: int, value: int | None) -> int:
            if mask & (1 << (field - 1)):
                index = const_index(field, value)
                if index > 255:
                    raise LiftError("constant too large for Lua 5.1 RK operand")
                return index + 256
            if not isinstance(value, int):
                raise LiftError(f"missing register at pc {pc}, field {field}")
            return value

        def add(name: str, A: int = 0, B: int = 0, C: int = 0) -> None:
            records.append([name, A, B, C, pc])

        def jump(target: int) -> None:
            records.append(["JMP", 0, target, None, pc])

        def call(last: int | None, result_count: int, open_args: bool = False) -> None:
            # These VM handlers use zero as a sentinel for Lua's open-top
            # argument pack, even when the call register is also zero.
            if last is None or (last < a and last != 0 and not open_args):
                raise LiftError(f"invalid call register at pc {pc}")
            add("CALL", a, 0 if open_args or last == 0 else last - a + 1, result_count)

        if action in ("GETGLOBAL", "SETGLOBAL", "LOADK"):
            add(action, a, const_index(2, b))
        elif action == "GETUPVAL":
            add("GETUPVAL", a, b)
        elif action == "LOADBOOL":
            add("LOADBOOL", a, int(bool(b)))
        elif action in ("MOVE", "LOADNIL", "LEN"):
            add(action, a, b)
        elif action in ("GETTABLE", "SELF"):
            add(action, a, b, rk(3, c))
        elif action == "SETTABLE":
            add("SETTABLE", a, rk(2, b), rk(3, c))
        elif action == "CONCAT":
            add("CONCAT", a, b, c)
        elif action == "NEWTABLE":
            add("NEWTABLE", a)
        elif action == "CLOSURE":
            add("CLOSURE", a, b)
        elif action in ("CALLRET", "CALLVOID"):
            call(b, 2 if action == "CALLRET" else 1)
        elif action == "CALL1RET":
            add("CALL", a, 2, 2)
        elif action == "CALL1VOID":
            add("CALL", a, 2, 1)
        elif action == "CALL0RET":
            add("CALL", a, 1, 2)
        elif action == "CALL1MULTI":
            add("CALL", a, 2, 0)
        elif action == "CALLMULTI":
            call(b, 0)
        elif action == "CALLRETCOUNT":
            if not isinstance(c, int) or c < a:
                raise LiftError(f"bad fixed return range at pc {pc}")
            call(b, c - a + 2)
        elif action == "CALL1RETCOUNT":
            if not isinstance(c, int) or c < a:
                raise LiftError(f"bad one-arg call returns at pc {pc}")
            add("CALL", a, 2, c - a + 2)
        elif action == "CALLVARRET":
            add("CALL", a, 0, 2)
        elif action == "CALLVARRETCOUNT":
            if not isinstance(c, int) or c < a:
                raise LiftError(f"bad variable-arg call at pc {pc}")
            add("CALL", a, 0, c - a + 2)
        elif action == "JMP":
            jump(b + 1)
        elif action in ("EQ_JMPNE", "EQ_NEJMP"):
            # These handlers have opposite polarity.  This distinction is
            # necessary for God of Glory's StreamingEnabled == true branch.
            add("EQ", 1 if action == "EQ_NEJMP" else 0, a, rk(3, c))
            jump(b + 1)
            jump(pc + 2)
        elif action == "EQ_CANONICAL":
            # VM: equal -> skip to following exit JMP; unequal -> body.
            # The intervening VM JMP pair is redundant: emit one branch.
            add("EQ", 1, a, c)
            jump(raw[pc + 1]["nums"][2] + 1)
        elif action == "TRUTHJMP":
            add("TEST", a, 0, 1)
            jump(b + 1)
            jump(pc + 2)
        elif action == "TRUTH_CANONICAL":
            add("TEST", a, 0, 0)
            jump(b + 1)
        elif action == "TFORLOOP":
            add("TFORLOOP", a, 0, c)
            jump(b + 1)
            if not profile.canonical_tdm:
                jump(pc + 2)
        elif action == "RETURN0":
            add("RETURN", a, 1)
        elif action == "RETURN1":
            add("RETURN", a, 2)
        elif action == "VARARGALL":
            add("VARARG", a, 0)
        elif action == "SETLISTVAR":
            add("SETLIST", a, 0, 1)
        elif action == "TAILCALLVAR":
            add("TAILCALL", a, 0)
        elif action == "RETURNVAR":
            add("RETURN", a, 0)
        else:
            raise LiftError(f"unmapped virtual action {action} at pc {pc}")
    entry[len(semantic) + 1] = len(records)
    for index, (name, _a, target, _c, pc) in enumerate(records):
        if name == "JMP":
            if target not in entry or semantic.get(target) == "DEAD":
                raise LiftError(f"jump to missing/unreachable pc {target} from {pc}")
            offset = entry[target] - index - 1
            if not -131_071 <= offset <= 131_071:
                raise LiftError("Lua 5.1 jump is out of range")
            records[index][2] = offset
    return [row[:4] for row in records], semantic


def u32(value: int) -> bytes:
    return struct.pack("<I", value & 0xFFFFFFFF)


def lua_string(value: str | None) -> bytes:
    if value is None:
        return struct.pack("<Q", 0)
    data = value.encode("utf-8")
    return struct.pack("<Q", len(data) + 1) + data + b"\x00"


def constant(value) -> bytes:
    if value is None:
        return b"\x00"
    if isinstance(value, bool):
        return b"\x01" + bytes([value])
    if isinstance(value, (int, float)):
        return b"\x03" + struct.pack("<d", value)
    if isinstance(value, str):
        return b"\x04" + lua_string(value)
    raise LiftError(f"unsupported Lua constant {type(value)!r}")


def instruction(row: list[int | str]) -> bytes:
    name, a, b, c = row
    opcode = OP[name]
    if name in ("LOADK", "GETGLOBAL", "SETGLOBAL", "CLOSURE"):
        if not 0 <= b <= 262143:
            raise LiftError(f"invalid ABx operand: {row}")
        return u32(opcode | (a << 6) | (b << 14))
    if name == "JMP":
        return u32(opcode | (a << 6) | ((b + 131071) << 14))
    if not all(isinstance(value, int) and 0 <= value <= limit for value, limit in ((a, 255), (b, 511), (c, 511))):
        raise LiftError(f"invalid ABC operand: {row}")
    return u32(opcode | (a << 6) | (c << 14) | (b << 23))


def serialize(proto: dict, profile: Profile, name: str, root: bool = True) -> bytes:
    instructions, _ = lift_proto(proto, profile)
    if len(proto["protos"]) > 1 and profile.liftable:
        raise LiftError("unexpected number of child functions in this profile")
    if profile.child_upvalues and not root and proto["protos"]:
        raise LiftError("nested upvalue binding not mapped")
    stack = max(32, max((row[1] for row in instructions), default=0) + 12)
    if stack > 250:
        raise LiftError("too many Lua registers")
    upvalues = 0 if root else profile.child_upvalues
    body = lua_string(name) + u32(0) + u32(0)
    body += bytes([upvalues, proto["params"], 2 if root or profile.child_upvalues else 0, stack])
    body += u32(len(instructions)) + b"".join(instruction(row) for row in instructions)
    body += u32(len(proto["const"]) - 1) + b"".join(constant(item) for item in proto["const"][1:])
    body += u32(len(proto["protos"]))
    body += b"".join(serialize(child, profile, f"{name}:proto{index}", False)
                     for index, child in enumerate(proto["protos"]))
    body += u32(0) + u32(0) + u32(0)  # source lines, locals, upvalue names
    return body


def lift(content: bytes) -> tuple[Profile, bytes, dict]:
    profile, tree, blob = read_profile(content)
    if not profile.liftable:
        raise LiftError(f"{profile.name}: container decoded, but VM opcode map is incomplete")
    header = b"\x1bLua\x51\x00\x01\x04\x08\x04\x08\x00"
    bytecode = header + serialize(tree, profile, "@" + profile.name.removesuffix(".lua") + "_static")
    return profile, bytecode, {"decoded_bytes": len(blob),
                               "prototypes": len(list(walk(tree))),
                               "vm_instructions": sum(len(p["ins"]) for p in walk(tree))}
