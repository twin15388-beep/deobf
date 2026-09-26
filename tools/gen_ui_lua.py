"""Emit ouroboros_ui.lua from data/ui_tree.json (see tools/gen_ui_widgets.py).

The artifact builds its window with the external ObsidianUltra library; this
generator writes a module that rebuilds the same window: identical window
options, tabs, groupboxes, widget keys, texts, defaults, ranges, suffixes,
tooltips and callbacks (callbacks go through a handler table supplied by the
caller, so the module stays free of hard dependencies).

Usage: python3 tools/gen_ui_lua.py
"""
import json

TREE = "data/ui_tree.json"
OUT = "ouroboros_ui.lua"


def lua_str(s):
    if s is None:
        return "nil"
    s = s.strip()
    if s.startswith('"') and s.endswith('"'):
        s = s[1:-1]
    s = s.replace('\\"', '"').replace("\\'", "'").replace("\\\\", "\\")
    return '"%s"' % s.replace("\\", "\\\\").replace('"', '\\"')


def lua_val(v):
    if v is None:
        return None
    v = v.strip()
    if v in ("true", "false") or v.replace(".", "", 1).lstrip("-").isdigit():
        return v
    if v.startswith("{"):
        # convert {..} literal with [ "k" ] = v pairs into lua table text
        return v
    return lua_str(v)


def main():
    tree = json.load(open(TREE, encoding="utf-8"))
    L = []
    A = L.append
    A("--[[ ============================================================================")
    A("  Ouroboros — ИНТЕРФЕЙС (окно, вкладки, группы, виджеты)")
    A("  ----------------------------------------------------------------------------")
    A("  СГЕНЕРИРОВАНО: tools/gen_ui_widgets.py (дерево из артефакта) +")
    A("  tools/gen_ui_lua.py (этот файл). Не править вручную — правьте артефакт/генератор.")
    A("")
    A("  Библиотека — внешняя (ObsidianUltra, WindUI-подобная):")
    A('    база  https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/')
    A("    файлы Library.lua, addons/ThemeManager.lua, addons/SaveManager.lua")
    A("  Загрузчик повторяет артефакт: HttpGet → loadstring → pcall, до 5 попыток,")
    A("  проверка «вернулась таблица», warn \"[Ouroboros] could not load %s:%s\".")
    A("============================================================================ ]]")
    A("")
    A("local M = {}")
    A("")
    A('M.BASE_URL = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/"')
    A('M.FILES = {') 
    A('    library = "Library.lua",')
    A('    theme   = "addons/ThemeManager.lua",')
    A('    save    = "addons/SaveManager.lua",')
    A('}')
    A('M.SAVE_ROOT = "MyScriptHub"              -- aVQ:SetFolder')
    A('M.SAVE_FOLDER = "OuroborosHub/Ouwland"   -- aVR:SetFolder')
    A('M.DEFAULT_CONFIG = "Rosewater"           -- aVQ:SaveDefault')
    A('M.IGNORE_INDEXES = { "MenuKeybind", "SaveManager_ImportSource" }')
    A("")
    A("M.WINDOW = {")
    A('    Title = "Ouroboros",')
    A("    Font = Enum.Font.BuilderSans,")
    A('    Footer = nil,                       -- см. Footer ниже (Discord/версия)')
    A("    Icon = 132608042600488,")
    A("    Size = UDim2.fromOffset(860, 660),")
    A('    NotifySide = "Right",')
    A("    ShowCustomCursor = false,")
    A("    CornerRadius = 0,")
    A("    SidebarCompacted = true,")
    A('    TabSwipeFrom = "bottom",')
    A("    Animations = { TabSwitch = true },")
    A("}")
    A("")
    A("M.DISCORD = {")
    A("    Banner = 95892854151512,")
    A("    Avatar = 132608042600488,")
    A('    Title = "Ouroboros Hub",')
    A('    Subtitle = "Dupes, keyless scripts and updates",')
    A("}")
    A("")
    A("-- Загрузчик внешних файлов: 5 попыток, как в артефакте (состояния 1059…1082).")
    A("function M.LoadFile(path, services)")
    A("    local HttpGet = services.HttpGet")
    A("    local wait = services.wait or task.wait")
    A("    local warnf = services.warn or warn")
    A("    local reason")
    A("    for attempt = 1, 5 do")
    A("        local ok, data = pcall(HttpGet, M.BASE_URL .. path)")
    A("        if ok and type(data) == \"string\" and data ~= \"\" then")
    A("            local chunk, err = loadstring(data)")
    A("            if chunk then")
    A("                local ok2, result = pcall(chunk)")
    A("                if ok2 then")
    A("                    if type(result) == \"table\" then return result end")
    A("                    reason = \"returned \" .. typeof(result) .. \" instead of a table\"")
    A("                else")
    A("                    reason = tostring(result)")
    A("                end")
    A("            else")
    A("                reason = \"does not compile (\" .. tostring(err) .. \")\"")
    A("            end")
    A("        elseif ok then")
    A("            reason = (data == \"\") and \"empty response\" or \"returned \" .. typeof(data)")
    A("        else")
    A("            reason = tostring(data)            -- нет ответа")
    A("        end")
    A("        wait(0.2)")
    A("    end")
    A('    warnf(string.format("[Ouroboros] could not load %s:%s", path, tostring(reason)))')
    A("    return nil")
    A("end")
    A("")
    A("-- Дерево окна, выгруженное из артефакта (data/ui_tree.json).")
    A("M.SPEC = {")
    for tb in tree["tabs"]:
        A("    { name = %s, icon = %s, groups = {" % (lua_str(tb["name"]), lua_str(tb.get("icon"))))
        for g in tb["groups"]:
            A("        { side = %s, name = %s, icon = %s, widgets = {"
              % (lua_str(g["side"]), lua_str(g["name"]), lua_str(g.get("icon"))))
            for w in g["widgets"]:
                parts = ["kind = %s" % lua_str(w["kind"])]
                if w.get("key"):
                    parts.append("key = %s" % lua_str(w["key"]))
                if w.get("setter"):
                    parts.append("setter = %s" % lua_str(w["setter"]))
                if w.get("action"):
                    parts.append("action = %s" % lua_str(w["action"]))
                for field in ("text", "default", "min", "max", "suffix", "tooltip", "values", "multi"):
                    v = lua_val(w.get(field))
                    if v is not None:
                        parts.append("%s = %s" % (field, v))
                if w.get("label"):
                    # label — обрывок исходного выражения, всегда строка
                    parts.append("label = %s" % lua_str(w["label"]))
                A("            { %s }," % ", ".join(parts))
            A("        }},")          # закрыть widgets = { и группу
        A("    }},")              # закрыть groups = { и вкладку
    A("}")
    A("")
    A("-- Опции виджета из спецификации (имена полей — как у библиотеки).")
    A("local function options_of(w, handler)")
    A("    local options = {}")
    A("    if w.text then options.Text = w.text end")
    A("    if w.label then options.Text = options.Text or w.label end")
    A("    if w.tooltip then options.Tooltip = w.tooltip end")
    A("    if w.default ~= nil then options.Default = w.default end")
    A("    if w.min ~= nil then options.Min = w.min end")
    A("    if w.max ~= nil then options.Max = w.max end")
    A("    if w.suffix then options.Suffix = w.suffix end")
    A("    if w.multi then options.Multi = w.multi end")
    A("    if w.values then options.Values = w.values end")
    A("    if handler then options.Callback = handler end")
    A("    return options")
    A("end")
    A("")
    A("-- Сборка окна. handlers — таблица «setter/action/ключ → функция(value)».")
    A("-- Возвращает { window, tabs, toggles, values } (toggles/values — таблицы библиотеки).")
    A("function M.Build(Library, handlers)")
    A("    handlers = handlers or {}")
    A("    local window = Library:CreateWindow(M.WINDOW)")
    A("    if window.SetGlow then window:SetGlow(false) end")
    A("    local tabs = {}")
    A("    for _, spec in ipairs(M.SPEC) do")
    A("        local tab = window:AddTab(spec.name, spec.icon)")
    A("        tabs[spec.name] = tab")
    A("        for _, group in ipairs(spec.groups) do")
    A("            local add = (group.side == \"right\") and tab.AddRightGroupbox or tab.AddLeftGroupbox")
    A("            local box = add(tab, group.name, group.icon)")
    A("            for _, w in ipairs(group.widgets) do")
    A("                local handler = handlers[w.action or w.setter or w.key]")
    A("                if w.kind == \"Toggle\" then")
    A("                    box:AddToggle(w.key, options_of(w, handler))")
    A("                elseif w.kind == \"Slider\" then")
    A("                    box:AddSlider(w.key, options_of(w, handler))")
    A("                elseif w.kind == \"Dropdown\" then")
    A("                    box:AddDropdown(w.key, options_of(w, handler))")
    A("                elseif w.kind == \"Input\" then")
    A("                    box:AddInput(w.key, options_of(w, handler))")
    A("                elseif w.kind == \"KeyPicker\" then")
    A("                    box:AddKeyPicker(w.key, options_of(w, handler))")
    A("                elseif w.kind == \"ColorPicker\" then")
    A("                    box:AddColorPicker(w.key, options_of(w, handler))")
    A("                elseif w.kind == \"Label\" then")
    A("                    box:AddLabel(w.text or w.label or \"\", true)")
    A("                elseif w.kind == \"Button\" then")
    A("                    box:AddButton({ Text = w.key or w.label or \"\", Func = handler })")
    A("                end")
    A("            end")
    A("        end")
    A("    end")
    A("    local ok, discord = pcall(function() window:AddDiscordBox(nil, M.DISCORD) end)")
    A("    return {")
    A("        window = window,")
    A("        tabs = tabs,")
    A("        toggles = Library.Toggles or {},")
    A("        values = Library.Values or {},")
    A("        discord = ok and discord or nil,")
    A("    }")
    A("end")
    A("")
    A("-- Хвост инициализации UI (состояния 5931/5932), порядок как в артефакте:")
    A("-- дефолтный конфиг → приоритеты → авто-конфиг → SettlePriority.")
    A("function M.Finish(ui, library, theme, save, settingsTab, handlers)")
    A("    if save then")
    A("        save:SetLibrary(library)")
    A("        save:SetFolder(M.SAVE_ROOT)")
    A('        save:SaveDefault(M.DEFAULT_CONFIG)')
    A("        save:ApplyToTab(settingsTab)")
    A("        save:IgnoreThemeSettings()")
    A('        save:SetIgnoreIndexes(M.IGNORE_INDEXES)')
    A("    end")
    A("    if theme then")
    A("        theme:SetLibrary(library)")
    A("        theme:SetFolder(M.SAVE_FOLDER)")
    A("        theme:IgnoreThemeSettings()")
    A("    end")
    A("    if save then save:LoadAutoloadConfig() end")
    A("    local handlersT = handlers or {}")
    A("    local toggle, settle = handlersT.Toggle, handlersT.SettlePriority")
    A("    if library.Toggles and library.Toggles.HideUiOnStart and library.Toggles.HideUiOnStart.Value then")
    A("        if toggle then toggle(false) end")
    A("    end")
    A("    if settle then settle() end")
    A("    return ui")
    A("end")
    A("")
    A("return M")
    open(OUT, "w", encoding="utf-8").write("\n".join(L) + "\n")
    print("wrote %s (%d lines)" % (OUT, len(L)))


if __name__ == "__main__":
    main()
