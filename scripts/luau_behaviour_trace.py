#!/usr/bin/env python3
"""Wrap a protected Lua/Luau sample into a self-contained behaviour-trace driver.

Why this exists
---------------
The stock `luau` CLI ships without `io`, `arg` or `os.getenv`, so a tracer that
runs under it cannot read the sample from disk and cannot receive parameters.
The workaround used here is to inline the sample into the driver as a long
bracket string and let every observable request the payload makes go to stdout,
which the caller redirects to a file:

    python3 scripts/luau_behaviour_trace.py sample.lua local-results/trace.luau
    luau local-results/trace.luau > local-results/trace.txt

The generated driver never reaches the network and never patches a licence
check.  It gives the payload stub `game`/`workspace`/service proxies, records
`Connect`/index/assignment/call events, answers `HttpGet` with a tiny no-op
module and answers datatype constructors (`Vector3`, `UDim2`, ...) with stubs.
That is enough to watch which request the payload sends to the game, which is
how the MoonSec V3 samples in `local-results/scan/` were classified
(undefined-global call vs. KaVo-UI fetch vs. VM bootstrap stall).

Notes
-----
* The `luau` CLI marks its own globals readonly (`luaL_sandbox`), so the driver
  replaces `getfenv(0)`/`getfenv()`/`_G`/`shared` with its own writable table.
* Output is line buffered only if the CLI flushes after `print`; a runaway trace
  killed by `timeout` therefore loses at most the last stdio buffer.  Build the
  CLI with `fflush(stdout)` in `luaB_print` if you need every line.
* The event cap (`LIMIT`, 20 000) keeps a looping VM from filling the disk.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

HEADER = """
local SRC = [===[
"""

FOOTER_HEAD = r"""
]===]

local DUMP_STRINGS = __DUMP_STRINGS__
-- Some samples are fragments whose entry point is a global the loader defines
-- (e.g. `SomeGlobal(function(...) <decoded body> end)`).  With this flag an
-- unknown global invoked with a single function argument calls that function
-- instead of swallowing it, which is how the already-decoded body gets traced.
local INVOKE_MISSING = __INVOKE_MISSING__

local N, LIMIT = 0, 20000
local function rec(line)
	N = N + 1
	if N <= LIMIT then
		print("T " .. line)
	end
end

local function ser(v, depth)
	local t = type(v)
	if t == "string" then
		if #v > 200 then return string.format("%q..(%d)", string.sub(v, 1, 200), #v) end
		return string.format("%q", v)
	elseif t == "number" or t == "boolean" or t == "nil" then
		return tostring(v)
	elseif t == "table" then
		if (depth or 0) > 0 then return "{...}" end
		local parts = {}
		for k, val in pairs(v) do
			parts[#parts + 1] = tostring(k) .. "=" .. ser(val, 1)
			if #parts >= 8 then parts[#parts + 1] = "..." break end
		end
		return "{" .. table.concat(parts, ",") .. "}"
	end
	return "<" .. t .. ">"
end

local real = _G
local nextid, stubs = 0, {}
local function stub(name, invoke)
	local cached = stubs[name]
	if cached then return cached end
	nextid = nextid + 1
	local id = nextid
	local props = {}
	local obj = {}
	local proxy
	proxy = setmetatable(obj, {
		__index = function(_, k)
			if k == "Connect" or k == "connect" then
				return function(self, fn)
					rec("CONNECT " .. name .. "#" .. id)
					return stub(name .. ":conn" .. id)
				end
			end
			if k == "Wait" or k == "wait" then
				return function() return stub(name .. ":wait") end
			end
			if k == "Destroy" or k == "Remove" or k == "disconnect" then
				return function() rec("DESTROY " .. name .. "#" .. id) end
			end
			local got = props[k]
			if got == nil then
				rec("GET " .. name .. "#" .. id .. "[" .. tostring(k) .. "]")
				got = stub(name .. "#" .. id .. "." .. tostring(k))
				props[k] = got
			end
			return got
		end,
		__newindex = function(_, k, v)
			rec("SET " .. name .. "#" .. id .. "[" .. tostring(k) .. "]=" .. ser(v, 0))
			props[k] = v
		end,
		__call = function(_, ...)
			local n = select("#", ...)
			local args = {}
			for i = 1, math.min(n, 6) do args[#args + 1] = ser((select(i, ...)), 0) end
			rec("CALL " .. name .. "#" .. id .. "(" .. table.concat(args, ",") .. ")")
			if invoke and n >= 1 and type((...)) == "function" then
				rec("INVOKE " .. name .. "#" .. id)
				local packed = table.pack(pcall((...)))
				if not packed[1] then rec("INVOKE-ERR " .. tostring(packed[2])) end
				return packed[2]
			end
			local lower = string.lower(name)
			if string.find(lower, "httpget", 1, true) or string.find(lower, "getasync", 1, true) then
				-- remote UI/module fetches: hand back a callable no-op module so the
				-- payload's own loadstring path keeps running
				return "local M M = setmetatable({}, {__index = function() return function() return M end end, __call = function() return M end}) return M"
			end
			return stub(name .. "#" .. id .. "()")
		end,
		__tostring = function() return "<stub " .. name .. ">" end,
		__concat = function(a, b) return tostring(a) .. tostring(b) end,
		__len = function() return 1 end,
		__add = function() return stub(name .. "+") end,
		__div = function() return stub(name .. "/") end,
		__mul = function() return stub(name .. "*") end,
		__sub = function() return stub(name .. "-") end,
		__mod = function() return stub(name .. "%") end,
		__pow = function() return stub(name .. "^") end,
		__unm = function() return stub(name .. "_unm") end,
		__lt = function() return false end,
		__le = function() return false end,
		__eq = function() return false end,
	})
	stubs[name] = proxy
	return proxy
end

local env = {}
local MISSING = {}
setmetatable(env, {
	__index = function(_, k)
		local v = rawget(real, k)
		if v ~= nil then return v end
		MISSING[k] = true
		local s = stub(tostring(k), INVOKE_MISSING)
		rawset(env, k, s)
		return s
	end,
})
env.getgenv = function() return env end
env.getrenv = function() return env end
env.getfenv = function(x)
	-- getfenv(0)/getfenv() must hand back the writable sandbox table: the real
	-- Luau CLI globals are readonly (luaL_sandbox), which breaks every payload
	-- that does getfenv(0).x = ...
	if x == nil or x == 0 then return env end
	if type(x) == "number" then
		local ok, res = pcall(real.getfenv, x)
		if ok and res ~= real then return res end
		return env
	end
	return env
end
env.setfenv = function(x, t)
	if type(x) == "number" then pcall(real.setfenv, x + 1, t) end
	return true
end
env._G = env
env.shared = env
env._ENV = env
env.setclipboard = function(s) rec("SETCLIPBOARD " .. ser(s, 0)) end
env.writefile = function(p, d) rec("WRITEFILE " .. ser(p, 0) .. " " .. ser(d, 0)) end
env.readfile = function(p) rec("READFILE " .. ser(p, 0)) return "{}" end
env.isfile = function() return true end
env.warn = function(...)
	local p = {}
	for i = 1, select("#", ...) do p[#p + 1] = ser((select(i, ...)), 0) end
	rec("WARN " .. table.concat(p, " "))
end
env.print = function(...)
	local p = {}
	for i = 1, select("#", ...) do p[#p + 1] = ser((select(i, ...)), 0) end
	rec("PRINT " .. table.concat(p, " "))
end
env.request = function(o)
	rec("REQUEST " .. ser(o, 0))
	return { StatusCode = 200, Body = "{}", Success = true, Headers = {} }
end
-- executor / datatype shims: enough surface for a protected VM to bootstrap so
-- that its request stream to the game becomes visible
env.islclosure = function() return false end
env.iscclosure = function() return true end
env.iscfunction = env.iscclosure
env.newcclosure = function(f) return f end
env.checkcaller = function() return true end
env.identifyexecutor = function() return "tracer", "tracer" end
env.getexecutorname = function() return "tracer" end
env.getscriptbytecode = function() return "" end
env.hookfunction = function(f) return f end
env.replaceclosure = function(_, f) return f end
env.restorefunction = function() end
env.getrawmetatable = function(t) return getmetatable(t) end
env.setreadonly = function() end
env.isreadonly = function() return false end
env.getnamecallmethod = function() return "" end
env.getconnections = function() return {} end
env.firesignal = function() end
env.fireclickdetector = function() end
env.firetouchinterest = function() end
env.setthreadidentity = function() end
env.getthreadidentity = function() return 8 end
env.setidentity = env.setthreadidentity
env.syn_context = function() end
env.queue_on_teleport = function() rec("QUEUE_ON_TELEPORT") end
env.getcustomasset = function(p) rec("GETCUSTOMASSET " .. ser(p, 0)) return "rbxassetid://0" end
-- executor helpers that must return *functions/values*, not stub tables: a stub
-- here makes a protected VM loop forever instead of proceeding
env.clonefunction = function(f) return f end
env.getgenv = env.getgenv
env.getinstances = function() return {} end
env.getnilinstances = function() return {} end
env.getscripts = function() return {} end
env.getrunningscripts = function() return {} end
env.getloadedmodules = function() return {} end
env.getcallingscript = function() return nil end
env.getsenv = function() return env end
env.getmenv = function() return env end
env.getucenv = env.getsenv
env.getgc = function() return {} end
env.getupvalue = function(f, n) return nil end
env.getupvalues = function() return {} end
env.setupvalue = function() return true end
env.getconstants = function() return {} end
env.getproto = function() return nil end
env.getfunctionhash = function() return "0" end
env.setrawmetatable = function() return true end
env.getreg = function() return env end
env.getregistry = env.getreg
env.require = function() return {} end
env.getthreadcontext = function() return {} end
for _, datatype in ipairs({"Vector3", "Vector2", "Vector3int16", "UDim", "UDim2", "CFrame", "Color3", "ColorSequence",
	"NumberSequence", "NumberRange", "Ray", "Rect", "Region3", "TweenInfo", "BrickColor", "Instance", "Random",
	"PhysicalProperties", "Faces", "Axes"}) do
	env[datatype] = stub(datatype)
end
env.Enum = stub("Enum")
env.game = stub("game")
env.workspace = stub("workspace")
env.task = {
	wait = function() return 0 end,
	spawn = function(fn, ...) return fn(...) end,
	delay = function(_, fn, ...) return fn(...) end,
	defer = function(fn, ...) return fn(...) end,
}
env.wait = function() return 0 end
env.tick = function() return 0 end
env.time = function() return 0 end
env.loadstring = function(s, n)
	rec("LOADSTRING len=" .. tostring(type(s) == "string" and #s or -1))
	return real.loadstring(s, n)
end
env.load = env.loadstring

-- Optional string-table dump.  A protected VM rebuilds its plaintext constants
-- at run time with string.char(byte) in a loop and table.concat(...) over the
-- pieces; hooking those two is enough to read the decrypted table back.
local str_flush = function() end
if DUMP_STRINGS then
	local sbuf, seen, chars = {}, {}, 0
	local real_string, real_concat = real.string, real.table.concat
	str_flush = function()
		if #sbuf == 0 then return end
		local s = real_concat(sbuf, "")
		sbuf = {}
		if #s >= 2 and not seen[s] then
			seen[s] = true
			print("S " .. string.gsub(s, ".", function(c) return string.format("%02x", string.byte(c)) end))
		end
	end
	env.string = setmetatable({
		char = function(...)
			local s = real_string.char(...)
			sbuf[#sbuf + 1] = s
			chars = chars + 1
			if chars % 256 == 0 then str_flush() end
			return s
		end,
	}, { __index = real_string })
	env.table = setmetatable({
		concat = function(t, sep, i, j)
			local s = real_concat(t, sep, i, j)
			if type(s) == "string" and #s >= 8 then sbuf[#sbuf + 1] = s end
			return s
		end,
	}, { __index = real.table })
end

local chunk, err = real.loadstring(SRC, "protected")
if not chunk then
	print("PARSE FAILED: " .. tostring(err))
	return
end
real.setfenv(chunk, env)
print("BEGIN tracer")
local ok, res = pcall(chunk)
str_flush()
print("TOPRUN ok=" .. tostring(ok) .. " err=" .. tostring(res))
local miss = {}
for k in pairs(MISSING) do miss[#miss + 1] = tostring(k) end
table.sort(miss)
print("EVENTS " .. tostring(N) .. " MISSING " .. table.concat(miss, ","))
"""


TERMINATOR = "]===]"


def build_driver(sample_text: str, dump_strings: bool = False, invoke_missing: bool = False) -> str:
    """Return a self-contained Luau driver that traces `sample_text`."""
    if TERMINATOR in sample_text:
        raise ValueError("sample contains the long-bracket terminator ']===]'")
    footer = (FOOTER_HEAD
              .replace("__DUMP_STRINGS__", "true" if dump_strings else "false")
              .replace("__INVOKE_MISSING__", "true" if invoke_missing else "false"))
    return HEADER + sample_text + footer


def extract_strings(trace_text: str, min_length: int = 1) -> list[str]:
    """Pull the decoded string-table entries out of a dumped trace.

    The driver prints one `S <hex>` line per recovered string; this turns them
    back into text, drops non-printable results and de-duplicates while keeping
    first-seen order.
    """
    seen: dict[str, None] = {}
    for line in trace_text.splitlines():
        if not line.startswith("S "):
            continue
        hex_part = line[2:].strip()
        if not hex_part or len(hex_part) % 2:
            continue
        try:
            raw = bytes.fromhex(hex_part)
        except ValueError:
            continue
        text = raw.decode("utf-8", errors="replace")
        if not any(32 <= ord(ch) < 127 for ch in text):
            continue
        if not text.isascii():
            continue
        if len(text) >= min_length and text not in seen:
            seen[text] = None
    return list(seen)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("sample", type=Path, nargs="?", help="Lua/Luau sample to trace")
    parser.add_argument("driver", type=Path, nargs="?", help="where to write the Luau driver")
    parser.add_argument("--dump-strings", action="store_true",
                        help="hook string.char/table.concat to recover the decrypted string table")
    parser.add_argument("--extract", type=Path, metavar="TRACE",
                        help="print the strings recovered from an existing trace file")
    parser.add_argument("--min-length", type=int, default=4, help="minimum string length for --extract")
    parser.add_argument("--invoke-missing", action="store_true",
                        help="call the single function argument of an unknown global (fragment entry points)")
    args = parser.parse_args(argv)

    if args.extract:
        strings = extract_strings(args.extract.read_text(encoding="utf-8", errors="replace"),
                                  min_length=args.min_length)
        for text in strings:
            if len(text) >= args.min_length:
                print(text)
        print(f"-- {len(strings)} recovered strings", file=sys.stderr)
        return 0
    if not args.sample or not args.driver:
        parser.error("SAMPLE and DRIVER are required unless --extract is used")

    text = args.sample.read_text(encoding="utf-8", errors="replace")
    try:
        driver = build_driver(text, dump_strings=args.dump_strings, invoke_missing=args.invoke_missing)
    except ValueError as exc:
        parser.error(str(exc))
    args.driver.parent.mkdir(parents=True, exist_ok=True)
    args.driver.write_text(driver, encoding="utf-8")
    print(f"wrote {args.driver} ({len(driver)} bytes)")
    print(f"run: luau {args.driver} > <trace.txt>")
    return 0


if __name__ == "__main__":
    sys.exit(main())
