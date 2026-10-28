// Minimal Luau script runner (stand-in for the official `luau` CLI)
#include "lua.h"
#include "lualib.h"
#include "luacode.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <vector>

static int l_loadstring(lua_State* L)
{
    size_t len = 0;
    const char* src = luaL_checklstring(L, 1, &len);
    const char* chunkname = luaL_optstring(L, 2, "loadstring");
    lua_CompileOptions opts;
    memset(&opts, 0, sizeof(opts));
    opts.optimizationLevel = 1;
    opts.debugLevel = 1;
    size_t bytecodeSize = 0;
    char* bytecode = luau_compile(src, len, &opts, &bytecodeSize);
    if (!bytecode || bytecodeSize == 0)
    {
        free(bytecode);
        lua_pushnil(L);
        lua_pushstring(L, "compile error");
        return 2;
    }
    int ok = luau_load(L, chunkname, bytecode, bytecodeSize, 0);
    free(bytecode);
    if (ok != 0)
    {
        lua_pushnil(L);
        lua_insert(L, -2);
        return 2;
    }
    return 1;
}

static int l_warn(lua_State* L)
{
    int n = lua_gettop(L);
    for (int i = 1; i <= n; i++)
    {
        size_t len = 0;
        const char* s = luaL_tolstring(L, i, &len);
        if (i > 1)
            fputc(' ', stderr);
        fwrite(s, 1, len, stderr);
        lua_pop(L, 1);
    }
    fputc('\n', stderr);
    return 0;
}

static int l_test(lua_State* L)
{
    lua_pushnumber(L, 7);
    lua_pushstring(L, "abc");
    return 2;
}

static int l_noop(lua_State* L)
{
    (void)L;
    return 0;
}

// prelude that fills in Roblox/executor globals that stock Luau lacks
static const char* PRELUDE =
    "local warn, noop = warn, __noop\n"
    "warn = warn or function(...) local t = {} for i = 1, select('#', ...) do t[i] = tostring((select(i, ...))) end __warn(table.concat(t, ' ')) end\n"
    "collectgarbage = collectgarbage or function() return 0 end\n"
    "tick = tick or os.clock\n"
    "time = time or os.time\n"
    "elapsedTime = elapsedTime or os.clock\n"
    "debug.profilebegin = debug.profilebegin or noop\n"
    "debug.profileend = debug.profileend or noop\n"
    "debug.setmemorycategory = debug.setmemorycategory or noop\n"
    "debug.resetmemorycategory = debug.resetmemorycategory or noop\n"
    "if not task then\n"
    "  task = {}\n"
    "  task.spawn = function(f, ...) return f(...) end\n"
    "  task.defer = function(f, ...) return f(...) end\n"
    "  task.delay = function(_, f, ...) return f(...) end\n"
    "  task.wait = function() return 0 end\n"
    "  task.cancel = noop\n"
    "end\n"
    "if __reqchunk then\n"
    "  require = function(name)\n"
    "    local chunk = __reqchunk(name)\n"
    "    local v = chunk()\n"
    "    return v\n"
    "  end\n"
    "end\n"
    "__noop = nil\n";

static std::string readFile(const char* path);

static int l_require(lua_State* L);

static std::string readFile(const char* path)
{
    FILE* f = fopen(path, "rb");
    if (!f)
        return std::string();
    std::string out;
    char buf[65536];
    size_t n;
    while ((n = fread(buf, 1, sizeof(buf), f)) > 0)
        out.append(buf, n);
    fclose(f);
    return out;
}

static int tracebackHandler(lua_State* L)
{
    const char* msg = lua_tostring(L, 1);
    fprintf(stderr, "ERROR: %s\n", msg ? msg : "(non-string error)");
    fprintf(stderr, "%s\n", lua_debugtrace(L));
    lua_pushvalue(L, 1);
    return 1;
}

static int l_require(lua_State* L)
{
    const char* name = luaL_checkstring(L, 1);
    std::string base = name;
    if (base.rfind("./", 0) == 0)
        base = base.substr(2);
    std::string path = base;
    if (path.size() < 5 || path.compare(path.size() - 5, 5, ".luau") != 0)
    {
        FILE* probe = fopen((path + ".luau").c_str(), "rb");
        if (probe)
        {
            fclose(probe);
            path += ".luau";
        }
        else
        {
            probe = fopen((path + ".lua").c_str(), "rb");
            if (probe)
            {
                fclose(probe);
                path += ".lua";
            }
        }
    }
    std::string src = readFile(path.c_str());
    if (src.empty())
    {
        lua_pushfstring(L, "require: cannot load %s", path.c_str());
        lua_error(L);
        return 0;
    }
    lua_CompileOptions opts;
    memset(&opts, 0, sizeof(opts));
    opts.optimizationLevel = 1;
    opts.debugLevel = 1;
    size_t n = 0;
    char* bc = luau_compile(src.data(), src.size(), &opts, &n);
    if (!bc || !n)
    {
        free(bc);
        lua_pushfstring(L, "require: compile failed for %s", path.c_str());
        lua_error(L);
        return 0;
    }
    std::string chunkname = "@" + path;
    int ok = luau_load(L, chunkname.c_str(), bc, n, 0);
    free(bc);
    if (ok != 0)
    {
        lua_error(L);
        return 0;
    }
    return 1;
}

static int reportError(lua_State* L)
{
    const char* msg = lua_tostring(L, -1);
    fprintf(stderr, "%s\n", msg ? msg : "(non-string error)");
    return 1;
}

int main(int argc, char** argv)
{
    const char* file = NULL;
    std::vector<std::string> scriptArgs;
    for (int i = 1; i < argc; i++)
    {
        const char* a = argv[i];
        if (a[0] == '-' && a[1] != '\0')
            continue; // ignore flags such as -O2/-I
        if (!file)
            file = a;
        else
            scriptArgs.push_back(a);
    }
    if (!file)
    {
        // REPL mode: execute stdin line by line in one persistent state
        lua_State* L = luaL_newstate();
        luaL_openlibs(L);
        lua_pushcfunction(L, l_loadstring, "loadstring");
        lua_setglobal(L, "loadstring");
        lua_pushcfunction(L, l_warn, "warn");
        lua_setglobal(L, "warn");
        lua_pushcfunction(L, l_require, "__reqchunk");
        lua_setglobal(L, "__reqchunk");

        lua_pushcfunction(L, l_noop, "__noop");
        lua_setglobal(L, "__noop");
        lua_pushcfunction(L, l_warn, "__warn");
        lua_setglobal(L, "__warn");
        {
            lua_CompileOptions popts;
            memset(&popts, 0, sizeof(popts));
            popts.optimizationLevel = 1;
            popts.debugLevel = 1;
            size_t psize = 0;
            char* pbc = luau_compile(PRELUDE, strlen(PRELUDE), &popts, &psize);
            if (pbc && psize && luau_load(L, "=prelude", pbc, psize, 0) == 0)
                lua_pcall(L, 0, 0, 0);
            free(pbc);
        }
        char* line = NULL;
        size_t cap = 0;
        ssize_t got;
        std::string pending;
        while ((got = getline(&line, &cap, stdin)) > 0)
        {
            std::string stmt(line, got);
            pending += stmt;
            lua_CompileOptions opts;
            memset(&opts, 0, sizeof(opts));
            opts.optimizationLevel = 1;
            opts.debugLevel = 1;
            size_t n = 0;
            char* bc = luau_compile(pending.data(), pending.size(), &opts, &n);
            if (!bc || !n)
            {
                free(bc);
                if (pending.find("\n\n") != std::string::npos)
                    pending.clear();
                continue;
            }
            if (luau_load(L, "=repl", bc, n, 0) != 0)
            {
                const char* err = lua_tostring(L, -1);
                fprintf(stderr, "repl load error: %s\n", err ? err : "?");
                lua_pop(L, 1);
                pending.clear();
                fflush(stdout);
                continue;
            }
            free(bc);
            pending.clear();
            lua_pushcfunction(L, tracebackHandler, "traceback");
            lua_insert(L, 1);
            int status = lua_pcall(L, 0, 0, 1);
            lua_remove(L, 1);
            if (status != 0)
            {
                lua_pop(L, 1);
            }
            fflush(stdout);
        }
        free(line);
        lua_close(L);
        return 0;
    }

    std::string src = readFile(file);
    if (src.empty())
    {
        fprintf(stderr, "luau: cannot read %s\n", file);
        return 1;
    }

    lua_CompileOptions opts;
    memset(&opts, 0, sizeof(opts));
    opts.optimizationLevel = 1;
    opts.debugLevel = 1;
    size_t bytecodeSize = 0;
    char* bytecode = luau_compile(src.data(), src.size(), &opts, &bytecodeSize);
    if (!bytecode || bytecodeSize == 0)
    {
        fprintf(stderr, "luau: compile failed\n");
        return 1;
    }

    lua_State* L = luaL_newstate();
    if (!L)
    {
        fprintf(stderr, "luau: cannot create state\n");
        free(bytecode);
        return 1;
    }
    luaL_openlibs(L);
    lua_pushcfunction(L, l_loadstring, "loadstring");
    lua_setglobal(L, "loadstring");
    lua_pushcfunction(L, l_warn, "warn");
    lua_setglobal(L, "warn");
    lua_pushcfunction(L, l_noop, "__noop");
    lua_setglobal(L, "__noop");
    lua_pushcfunction(L, l_warn, "__warn");
    lua_setglobal(L, "__warn");
    {
        lua_CompileOptions popts;
        memset(&popts, 0, sizeof(popts));
        popts.optimizationLevel = 1;
        popts.debugLevel = 1;
        size_t psize = 0;
        char* pbc = luau_compile(PRELUDE, strlen(PRELUDE), &popts, &psize);
        if (pbc && psize && luau_load(L, "=prelude", pbc, psize, 0) == 0)
        {
            if (lua_pcall(L, 0, 0, 0) != 0)
            {
                fprintf(stderr, "prelude error: %s\n", lua_tostring(L, -1));
                lua_pop(L, 1);
            }
        }
        free(pbc);
    }

    // global `arg` table, like the official CLI
    lua_createtable(L, (int)scriptArgs.size() + 1, 0);
    lua_pushstring(L, file);
    lua_rawseti(L, -2, 0);
    for (size_t i = 0; i < scriptArgs.size(); i++)
    {
        lua_pushstring(L, scriptArgs[i].c_str());
        lua_rawseti(L, -2, (int)i + 1);
    }
    lua_setglobal(L, "arg");

    int rc = 0;
    if (luau_load(L, file, bytecode, bytecodeSize, 0) != 0)
    {
        rc = reportError(L);
    }
    else
    {
        lua_pushcfunction(L, tracebackHandler, "traceback");
        lua_insert(L, 1);
        int status = lua_pcall(L, 0, LUA_MULTRET, 1);
        if (status != 0)
            rc = reportError(L);
    }
    lua_close(L);
    free(bytecode);
    return rc;
}
