--!strict
return ((function(...)
    return ((function(environment, unpack_values, new_proxy, set_metatable, get_metatable, select_values, input_arguments, local_34, local_35, local_36, local_37, local_38, local_39, local_40, local_41, local_42, local_43, local_44, local_45, local_46, local_47, local_48, local_49)
        local recovered_1, recovered_2, recovered_3, recovered_4, recovered_5, recovered_6, recovered_7, recovered_8, recovered_9, recovered_10, recovered_11, recovered_12, recovered_13, recovered_14, recovered_15, recovered_16, recovered_17, recovered_18, recovered_19, recovered_20, recovered_21, recovered_22;
        recovered_1 = function(local_91)
            local local_92 = local_39(local_91);
            return function(local_93)
                local state, arguments, captures, capture_guard = 12320991, {local_93}, local_91, local_92;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_116 = arguments[1];
                local_126 = "Instance";
                local_119 = environment["Instance"];
                local_126 = "new";
                state = local_119["new"];
                local_126 = "Highlight";
                local_127 = local_40[captures[1]];
                local_119 = state("Highlight", local_127);
                local_126 = local_119;
                state = "OutlineColor";
                local_119 = local_40[captures[2]];
                local_126["OutlineColor"] = local_119;
                state = "Adornee";
                local_119 = local_116;
                local_126["Adornee"] = local_119;
                local_127 = true;
                local_119 = local_40[captures[3]];
                state = (local_119 == true);
                state = ((state and 12768643) or 12808223);
                if (state == 12768643) then
                    local_119 = local_40[captures[4]];
                    state = "FillColor";
                    local_126["FillColor"] = local_119;
                    state = "FillTransparency";
                    local_119 = local_40[captures[5]];
                    local_126["FillTransparency"] = local_119;
                    state = 2890875;
                else
                    state = "FillTransparency";
                    local_119 = 1;
                    local_126["FillTransparency"] = 1;
                    state = 2890875;
                end
                local_119 = {};
                local_126 = nil;
                state = environment["KPdAW1QRvZ9xRt"];
                local_116 = nil;
                if state then
                    error("Unsupported truthy VM exit global: KPdAW1QRvZ9xRt");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_2 = function(local_55)
            local local_56 = local_39(local_55);
            return function(local_57, local_58, local_59, local_60)
                local state, arguments, captures, capture_guard = 908929, {local_57, local_58, local_59, local_60}, local_55, local_56;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_116 = arguments[1];
                local_126 = "Instance";
                local_119 = environment["Instance"];
                local_126 = "new";
                state = local_119["new"];
                local_126 = "BillboardGui";
                local_127 = local_40[captures[1]];
                local_119 = state("BillboardGui", local_127);
                local_126 = local_119;
                local_127 = "Instance";
                local_136 = 0;
                local_133 = "Vector3";
                local_119 = environment["Instance"];
                local_125 = "Head";
                local_127 = "new";
                state = local_119["new"];
                local_127 = "Frame";
                local_119 = state("Frame", local_126);
                local_127 = local_119;
                local_123 = "Instance";
                local_119 = environment["Instance"];
                local_123 = "new";
                local_130 = 3;
                state = local_119["new"];
                local_123 = "TextLabel";
                local_119 = state("TextLabel", local_127);
                state = "Adornee";
                local_123 = local_119;
                local_132 = 0;
                local_119 = "WaitForChild";
                local_119 = local_116["WaitForChild"];
                local_119 = local_119(local_116, "Head");
                local_126["Adornee"] = local_119;
                state = "StudsOffset";
                local_125 = environment["Vector3"];
                local_133 = "new";
                local_119 = local_125["new"];
                local_133 = 0;
                local_125 = local_119(0, 3, 0);
                local_126["StudsOffset"] = local_125;
                state = "AlwaysOnTop";
                local_130 = 0;
                local_133 = "UDim2";
                local_119 = true;
                local_126["AlwaysOnTop"] = true;
                local_125 = environment["UDim2"];
                local_133 = "new";
                local_119 = local_125["new"];
                local_133 = 4;
                local_132 = 0.5;
                local_125 = local_119(4, 0, 0.5, 0);
                local_136 = 0;
                state = "Size";
                local_126["Size"] = local_125;
                local_133 = "UDim2";
                local_130 = 0;
                local_125 = environment["UDim2"];
                state = "Size";
                local_132 = 1;
                local_133 = "new";
                local_119 = local_125["new"];
                local_133 = 1;
                local_125 = local_119(1, 0, 1, 0);
                local_127["Size"] = local_125;
                state = "Size";
                local_133 = "UDim2";
                local_125 = environment["UDim2"];
                local_133 = "new";
                local_132 = 1;
                local_136 = 0;
                local_119 = local_125["new"];
                local_130 = 0;
                local_133 = 1;
                local_125 = local_119(1, 0, 1, 0);
                local_123["Size"] = local_125;
                state = "BackgroundTransparency";
                local_119 = 1;
                local_127["BackgroundTransparency"] = 1;
                local_119 = 1;
                local_127 = nil;
                local_125 = "Name";
                state = "BackgroundTransparency";
                local_123["BackgroundTransparency"] = 1;
                local_119 = local_116["Name"];
                local_116 = nil;
                state = "Text";
                local_123["Text"] = local_119;
                local_119 = local_40[captures[2]];
                state = "Font";
                local_126 = nil;
                local_123["Font"] = local_119;
                state = "TextColor3";
                local_119 = local_40[captures[3]];
                local_123["TextColor3"] = local_119;
                state = "TextScaled";
                local_119 = local_40[captures[4]];
                local_123["TextScaled"] = local_119;
                state = environment["Lw5l0Cj7SSHEEG"];
                local_123 = nil;
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: Lw5l0Cj7SSHEEG");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_3 = function(local_55)
            local local_56 = local_39(local_55);
            return function(local_57, local_58, local_59, local_60)
                local state, arguments, captures, capture_guard = 176902, {local_57, local_58, local_59, local_60}, local_55, local_56;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_127 = "Vector3";
                local_126 = "Character";
                local_116 = local_40[captures[1]];
                local_119 = local_116["Character"];
                local_130 = "_G";
                local_116 = "HumanoidRootPart";
                state = local_119["HumanoidRootPart"];
                local_126 = environment["Vector3"];
                local_119 = "Size";
                local_125 = "_G";
                local_127 = "new";
                local_116 = local_126["new"];
                local_123 = environment["_G"];
                local_125 = "HeadSize";
                local_133 = "_G";
                local_127 = local_123["HeadSize"];
                local_125 = environment["_G"];
                local_133 = "HeadSize";
                local_123 = local_125["HeadSize"];
                local_133 = environment["_G"];
                local_130 = "HeadSize";
                local_125 = local_133["HeadSize"];
                local_126 = local_116(local_127, local_123, local_125);
                state["Size"] = local_126;
                local_116 = local_40[captures[1]];
                local_126 = "Character";
                local_119 = local_116["Character"];
                local_116 = "HumanoidRootPart";
                state = local_119["HumanoidRootPart"];
                local_119 = "CanCollide";
                local_116 = false;
                state["CanCollide"] = false;
                state = environment["sBPT08LAv2XUrk"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: sBPT08LAv2XUrk");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_4 = function(local_91)
            local local_92 = local_39(local_91);
            return function(local_93)
                local state, arguments, captures, capture_guard = 10013251, {local_93}, local_91, local_92;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_119 = {};
                state = environment["jr9mhNYoCIPK2e"];
                if state then
                    error("Unsupported truthy VM exit global: jr9mhNYoCIPK2e");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_5 = function(local_63)
            local local_64 = local_39(local_63);
            return function(local_65, local_66, local_67, local_68, local_69, local_70)
                local state, arguments, captures, capture_guard = 3550145, {local_65, local_66, local_67, local_68, local_69, local_70}, local_63, local_64;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_127 = "game";
                local_119 = "shared";
                local_116 = arguments[1];
                state = environment["shared"];
                local_126 = local_116;
                local_119 = "walkfast";
                local_123 = "Players";
                state["walkfast"] = local_126;
                local_126 = environment["game"];
                local_127 = "GetService";
                local_127 = local_126["GetService"];
                local_127 = local_127(local_126, "Players");
                local_126 = "LocalPlayer";
                local_119 = local_127["LocalPlayer"];
                local_126 = "Character";
                state = local_119["Character"];
                local_126 = state;
                state = 8006720;
                while true do
                    local_125 = "shared";
                    local_123 = environment["shared"];
                    local_125 = "walkfast";
                    local_127 = local_123["walkfast"];
                    local_119 = local_127;
                    state = ((local_127 and 332506) or 15504524);
                    if (state == 332506) then
                        local_125 = "game";
                        local_123 = environment["game"];
                        local_125 = "GetService";
                        local_133 = "RunService";
                        local_125 = local_123["GetService"];
                        local_125 = local_125(local_123, "RunService");
                        local_123 = "RenderStepped";
                        local_127 = local_125["RenderStepped"];
                        state = 15504524;
                        local_123 = "wait";
                        local_123 = local_127["wait"];
                        local_123 = local_123(local_127);
                        local_119 = local_123;
                    else

                    end
                    state = ((local_119 and 15941518) or 1832493);
                    if (state == 1832493) then
                        break
                    else
                        local_133 = "Players";
                        local_129 = "Z";
                        local_125 = "game";
                        local_123 = environment["game"];
                        local_125 = "GetService";
                        local_125 = local_123["GetService"];
                        local_125 = local_125(local_123, "Players");
                        local_123 = "LocalPlayer";
                        local_127 = local_125["LocalPlayer"];
                        local_117 = "Y";
                        local_123 = "Character";
                        local_119 = local_127["Character"];
                        local_127 = "HumanoidRootPart";
                        local_132 = "Vector3";
                        state = local_119["HumanoidRootPart"];
                        local_127 = state;
                        local_119 = "Velocity";
                        local_133 = "Position";
                        state = local_127["Velocity"];
                        local_135 = "X";
                        local_123 = state;
                        local_125 = local_127["Position"];
                        local_130 = environment["Vector3"];
                        local_132 = "new";
                        local_133 = local_130["new"];
                        local_136 = local_123["X"];
                        local_135 = 20;
                        local_132 = (local_136 / 20);
                        local_135 = local_123["Y"];
                        local_127 = nil;
                        local_117 = 30;
                        local_136 = (local_135 / 30);
                        local_117 = local_123["Z"];
                        local_129 = 20;
                        local_135 = (local_117 / 20);
                        local_130 = local_133(local_132, local_136, local_135);
                        local_119 = (local_125 + local_130);
                        state = "MoveTo";
                        state = local_126["MoveTo"];
                        local_123 = nil;
                        state = state(local_126, local_119);
                        state = 8006720;
                    end
                end
                local_126 = nil;
                local_119 = {};
                state = environment["JQxnm854khM6B"];
                local_116 = nil;
                if state then
                    error("Unsupported truthy VM exit global: JQxnm854khM6B");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_6 = function(local_55)
            local local_56 = local_39(local_55);
            return function(local_57, local_58, local_59, local_60)
                local state, arguments, captures, capture_guard = 14630919, {local_57, local_58, local_59, local_60}, local_55, local_56;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_127 = "game";
                local_126 = local_38();
                local_116 = arguments[1];
                local_40[local_126] = local_116;
                local_119 = environment["game"];
                local_123 = "UserInputService";
                local_116 = nil;
                local_127 = "GetService";
                local_127 = local_119["GetService"];
                local_127 = local_127(local_119, "UserInputService");
                local_119 = "JumpRequest";
                state = local_127["JumpRequest"];
                local_127 = recovered_20({local_126});
                local_119 = "connect";
                local_119 = state["connect"];
                local_126 = local_46(local_126);
                local_119 = local_119(state, local_127);
                state = environment["HC0NGk4cqGSiQn"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: HC0NGk4cqGSiQn");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_7 = function(local_82)
            local local_83 = local_39(local_82);
            return function(local_84, local_85)
                local state, arguments, captures, capture_guard = 11581663, {local_84, local_85}, local_82, local_83;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_127 = "RunService";
                local_126 = 15;
                local_119 = "_G";
                state = environment["_G"];
                local_119 = "HeadSize";
                local_116 = arguments[1];
                state["HeadSize"] = 15;
                local_119 = "_G";
                state = environment["_G"];
                local_119 = "Disabled";
                local_126 = local_116;
                state["Disabled"] = local_126;
                local_126 = "game";
                local_119 = environment["game"];
                local_126 = "GetService";
                local_116 = nil;
                local_126 = local_119["GetService"];
                local_126 = local_126(local_119, "RunService");
                local_119 = "RenderStepped";
                state = local_126["RenderStepped"];
                local_126 = recovered_17({});
                local_119 = "connect";
                local_119 = state["connect"];
                local_119 = local_119(state, local_126);
                local_119 = {};
                state = environment["MUTlyUuJfqLC"];
                if state then
                    error("Unsupported truthy VM exit global: MUTlyUuJfqLC");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_8 = function(local_96)
            local local_97 = local_39(local_96);
            return function()
                local state, arguments, captures, capture_guard = 14949374, {}, local_96, local_97;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                state = "5517298834";
                local_127 = "rbxassetid://";
                local_125 = "AnimationId";
                local_133 = "game";
                local_119 = "AnimationId";
                local_126 = "Instance";
                environment["AnimationId"] = "5517298834";
                local_116 = environment["Instance"];
                local_126 = "new";
                local_119 = local_116["new"];
                local_126 = "Animation";
                local_116 = local_119("Animation");
                local_119 = "AnimationId";
                local_123 = environment["AnimationId"];
                local_126 = ("rbxassetid://" .. local_123);
                local_116["AnimationId"] = local_126;
                local_125 = environment["game"];
                local_133 = "Players";
                local_123 = local_125["Players"];
                local_125 = "LocalPlayer";
                local_127 = local_123["LocalPlayer"];
                local_123 = "Character";
                local_126 = local_127["Character"];
                local_127 = "Humanoid";
                local_119 = local_126["Humanoid"];
                local_126 = "LoadAnimation";
                state = environment["8i15kB9GM8BqY3"];
                local_126 = local_119["LoadAnimation"];
                local_126 = local_126(local_119, local_116);
                local_119 = "Play";
                local_119 = local_126["Play"];
                local_119 = local_119(local_126);
                local_127 = 1;
                local_116 = nil;
                local_119 = "AdjustSpeed";
                local_119 = local_126["AdjustSpeed"];
                local_119 = local_119(local_126, 1);
                local_126 = nil;
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: 8i15kB9GM8BqY3");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_9 = function(local_73)
            local local_74 = local_39(local_73);
            return function(local_75, local_76, local_77, local_78, local_79)
                local state, arguments, captures, capture_guard = 16645849, {local_75, local_76, local_77, local_78, local_79}, local_73, local_74;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_119 = "pairs";
                state = environment["pairs"];
                local_132 = "game";
                local_130 = environment["game"];
                local_132 = "GetService";
                local_132 = local_130["GetService"];
                local_136 = "Players";
                local_132 = local_132(local_130, "Players");
                local_130 = "LocalPlayer";
                local_133 = local_132["LocalPlayer"];
                local_130 = "PlayerScripts";
                local_125 = local_133["PlayerScripts"];
                local_133 = "Shop";
                local_123 = local_125["Shop"];
                local_125 = "Chests";
                local_127 = local_123["Chests"];
                local_125 = "GetDescendants";
                local_125 = local_127["GetDescendants"];
                local_123 = {local_125(local_127)};
                local_127 = {state(unpack_values(local_123))};
                local_119 = local_127[1];
                local_126 = local_127[3];
                local_116 = local_127[2];
                state = 9001218;
                local_127 = local_119;
                while true do
                    local_126, local_125 = local_127(local_116, local_126);
                    state = ((local_126 and 12385041) or 8661748);
                    if (state == 8661748) then
                        break
                    else
                        local_123 = local_126;
                        local_130 = "Name";
                        local_133 = local_125["Name"];
                        local_130 = "Mythical";
                        state = (local_133 == "Mythical");
                        state = ((state and 9232491) or 14389864);
                        if (state == 9232491) then
                            local_130 = "Instance";
                            local_133 = environment["Instance"];
                            local_124 = 0;
                            local_136 = "UDim2";
                            local_135 = 0;
                            local_130 = "new";
                            state = local_133["new"];
                            local_130 = "BillboardGui";
                            local_133 = state("BillboardGui", local_125);
                            local_131 = 0;
                            local_130 = "ElectricPPPGUI";
                            state = "Name";
                            local_133["Name"] = "ElectricPPPGUI";
                            local_132 = environment["UDim2"];
                            local_129 = 0;
                            local_136 = "new";
                            state = "Size";
                            local_117 = 10;
                            local_130 = local_132["new"];
                            local_136 = 10;
                            local_132 = local_130(10, 0, 10, 0);
                            local_133["Size"] = local_132;
                            local_130 = true;
                            state = "AlwaysOnTop";
                            local_132 = "Instance";
                            local_135 = "UDim2";
                            local_133["AlwaysOnTop"] = true;
                            local_130 = environment["Instance"];
                            local_132 = "new";
                            local_129 = 1;
                            state = local_130["new"];
                            local_132 = "Frame";
                            local_130 = state("Frame", local_133);
                            local_117 = 0;
                            local_136 = environment["UDim2"];
                            state = "Size";
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 1;
                            local_136 = local_132(1, 0, 1, 0);
                            local_132 = 0.8;
                            local_130["Size"] = local_136;
                            local_135 = "Color3";
                            state = "BackgroundTransparency";
                            local_133 = nil;
                            local_130["BackgroundTransparency"] = 0.8;
                            state = "BorderSizePixel";
                            local_132 = 0;
                            local_130["BorderSizePixel"] = 0;
                            local_117 = 255;
                            local_129 = 255;
                            local_136 = environment["Color3"];
                            state = "BackgroundColor3";
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 240;
                            local_131 = 2;
                            local_136 = local_132(240, 255, 255);
                            local_130["BackgroundColor3"] = local_136;
                            local_136 = "Instance";
                            local_117 = "UDim2";
                            local_132 = environment["Instance"];
                            local_136 = "new";
                            state = local_132["new"];
                            local_136 = "TextLabel";
                            local_129 = 0;
                            local_132 = state("TextLabel", local_130);
                            state = "Size";
                            local_135 = environment["UDim2"];
                            local_130 = nil;
                            local_117 = "new";
                            local_136 = local_135["new"];
                            local_117 = 2;
                            local_135 = local_136(2, 0, 2, 0);
                            local_136 = 0;
                            local_132["Size"] = local_135;
                            state = "BorderSizePixel";
                            local_132["BorderSizePixel"] = 0;
                            local_136 = 10;
                            state = "TextSize";
                            local_132["TextSize"] = 10;
                            local_136 = "Mythical Chest";
                            state = "Text";
                            local_132["Text"] = "Mythical Chest";
                            local_136 = 1;
                            state = "BackgroundTransparency";
                            local_132["BackgroundTransparency"] = 1;
                            state = 14389864;
                            local_132 = nil;
                        else

                        end
                        local_123 = nil;
                        local_125 = nil;
                        state = 9001218;
                    end
                end
                local_119 = {};
                state = environment["C7kVP5s9JtOK"];
                if state then
                    error("Unsupported truthy VM exit global: C7kVP5s9JtOK");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_10 = function(local_96)
            local local_97 = local_39(local_96);
            return function()
                local state, arguments, captures, capture_guard = 12760391, {}, local_96, local_97;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_127 = "game";
                local_126 = environment["game"];
                local_127 = "GetService";
                local_123 = "Workspace";
                local_127 = local_126["GetService"];
                local_127 = local_127(local_126, "Workspace");
                local_126 = "PlayerCharacters";
                local_116 = local_127["PlayerCharacters"];
                local_133 = "game";
                local_125 = environment["game"];
                local_133 = "Players";
                local_123 = local_125["Players"];
                local_125 = "LocalPlayer";
                local_127 = local_123["LocalPlayer"];
                local_123 = "Name";
                local_126 = local_127["Name"];
                local_119 = local_116[local_126];
                local_116 = "FallDamage";
                state = local_119["FallDamage"];
                local_119 = "Destroy";
                local_119 = state["Destroy"];
                local_119 = local_119(state);
                local_119 = {};
                state = environment["V1oZefp7NFut"];
                if state then
                    error("Unsupported truthy VM exit global: V1oZefp7NFut");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_11 = function(local_91)
            local local_92 = local_39(local_91);
            return function(local_93)
                local state, arguments, captures, capture_guard = 4915196, {local_93}, local_91, local_92;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_119 = "pairs";
                state = environment["pairs"];
                local_136 = "Players";
                local_132 = "game";
                local_130 = environment["game"];
                local_132 = "GetService";
                local_132 = local_130["GetService"];
                local_132 = local_132(local_130, "Players");
                local_130 = "LocalPlayer";
                local_133 = local_132["LocalPlayer"];
                local_130 = "PlayerScripts";
                local_125 = local_133["PlayerScripts"];
                local_133 = "Shop";
                local_123 = local_125["Shop"];
                local_125 = "Chests";
                local_127 = local_123["Chests"];
                local_125 = "GetDescendants";
                local_125 = local_127["GetDescendants"];
                local_123 = {local_125(local_127)};
                local_127 = {state(unpack_values(local_123))};
                local_116 = local_127[2];
                local_126 = local_127[3];
                state = 5644735;
                local_119 = local_127[1];
                local_127 = local_119;
                while true do
                    local_126, local_125 = local_127(local_116, local_126);
                    state = ((local_126 and 6298840) or 12358934);
                    if (state == 6298840) then
                        local_123 = local_126;
                        local_130 = "Name";
                        local_133 = local_125["Name"];
                        local_130 = "Legendary";
                        state = (local_133 == "Legendary");
                        state = ((state and 221501) or 3893982);
                        if (state == 221501) then
                            local_130 = "Instance";
                            local_133 = environment["Instance"];
                            local_130 = "new";
                            state = local_133["new"];
                            local_130 = "BillboardGui";
                            local_131 = 0;
                            local_135 = 0;
                            local_133 = state("BillboardGui", local_125);
                            local_130 = "ElectricPPPGUI";
                            state = "Name";
                            local_136 = "UDim2";
                            local_117 = 10;
                            local_133["Name"] = "ElectricPPPGUI";
                            local_132 = environment["UDim2"];
                            state = "Size";
                            local_136 = "new";
                            local_124 = 0;
                            local_130 = local_132["new"];
                            local_129 = 0;
                            local_136 = 10;
                            local_132 = local_130(10, 0, 10, 0);
                            local_133["Size"] = local_132;
                            state = "AlwaysOnTop";
                            local_132 = "Instance";
                            local_117 = 0;
                            local_129 = 1;
                            local_130 = true;
                            local_133["AlwaysOnTop"] = true;
                            local_130 = environment["Instance"];
                            local_135 = "UDim2";
                            local_132 = "new";
                            state = local_130["new"];
                            local_132 = "Frame";
                            local_130 = state("Frame", local_133);
                            local_136 = environment["UDim2"];
                            state = "Size";
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 1;
                            local_136 = local_132(1, 0, 1, 0);
                            local_130["Size"] = local_136;
                            local_135 = "Color3";
                            state = "BackgroundTransparency";
                            local_132 = 0.8;
                            local_130["BackgroundTransparency"] = 0.8;
                            local_129 = 255;
                            local_132 = 0;
                            state = "BorderSizePixel";
                            local_130["BorderSizePixel"] = 0;
                            state = "BackgroundColor3";
                            local_117 = 255;
                            local_136 = environment["Color3"];
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 240;
                            local_136 = local_132(240, 255, 255);
                            local_130["BackgroundColor3"] = local_136;
                            local_136 = "Instance";
                            local_132 = environment["Instance"];
                            local_117 = "UDim2";
                            local_129 = 0;
                            local_136 = "new";
                            state = local_132["new"];
                            local_136 = "TextLabel";
                            local_132 = state("TextLabel", local_130);
                            local_135 = environment["UDim2"];
                            state = "Size";
                            local_117 = "new";
                            local_131 = 2;
                            local_136 = local_135["new"];
                            local_117 = 2;
                            local_135 = local_136(2, 0, 2, 0);
                            local_130 = nil;
                            local_132["Size"] = local_135;
                            local_136 = 0;
                            state = "BorderSizePixel";
                            local_132["BorderSizePixel"] = 0;
                            local_133 = nil;
                            state = "TextSize";
                            local_136 = 10;
                            local_132["TextSize"] = 10;
                            state = "Text";
                            local_136 = "Legendary Chest";
                            local_132["Text"] = "Legendary Chest";
                            local_136 = 1;
                            state = "BackgroundTransparency";
                            local_132["BackgroundTransparency"] = 1;
                            local_132 = nil;
                            state = 3893982;
                        else

                        end
                        local_125 = nil;
                        local_123 = nil;
                        state = 5644735;
                    else
                        break
                    end
                end
                state = environment["121UM0D3ri6p"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: 121UM0D3ri6p");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_12 = function(local_91)
            local local_92 = local_39(local_91);
            return function(local_93)
                local state, arguments, captures, capture_guard = 12085171, {local_93}, local_91, local_92;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_125 = "game";
                local_123 = environment["game"];
                local_116 = arguments[1];
                local_125 = "Players";
                local_127 = local_123["Players"];
                local_123 = "LocalPlayer";
                local_126 = local_127["LocalPlayer"];
                local_127 = "Character";
                local_119 = local_126["Character"];
                local_126 = "Humanoid";
                state = local_119["Humanoid"];
                local_126 = local_116;
                local_119 = "HipHeight";
                state["HipHeight"] = local_126;
                local_116 = nil;
                state = environment["rj7cuGsGP37y"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: rj7cuGsGP37y");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_13 = function(local_73)
            local local_74 = local_39(local_73);
            return function(local_75, local_76, local_77, local_78, local_79)
                local state, arguments, captures, capture_guard = 16119328, {local_75, local_76, local_77, local_78, local_79}, local_73, local_74;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_132 = "game";
                local_119 = "pairs";
                local_136 = "Players";
                state = environment["pairs"];
                local_130 = environment["game"];
                local_132 = "GetService";
                local_132 = local_130["GetService"];
                local_132 = local_132(local_130, "Players");
                local_130 = "LocalPlayer";
                local_133 = local_132["LocalPlayer"];
                local_130 = "PlayerScripts";
                local_125 = local_133["PlayerScripts"];
                local_133 = "Shop";
                local_123 = local_125["Shop"];
                local_125 = "Chests";
                local_127 = local_123["Chests"];
                local_125 = "GetDescendants";
                local_125 = local_127["GetDescendants"];
                local_123 = {local_125(local_127)};
                local_127 = {state(unpack_values(local_123))};
                local_126 = local_127[3];
                state = 14133709;
                local_116 = local_127[2];
                local_119 = local_127[1];
                local_127 = local_119;
                while true do
                    local_126, local_125 = local_127(local_116, local_126);
                    state = ((local_126 and 2331350) or 12127417);
                    if (state == 2331350) then
                        local_123 = local_126;
                        local_130 = "Name";
                        local_133 = local_125["Name"];
                        local_130 = "Common";
                        state = (local_133 == "Common");
                        state = ((state and 9337013) or 2253478);
                        if (state == 2253478) then

                        else
                            local_117 = 10;
                            local_130 = "Instance";
                            local_133 = environment["Instance"];
                            local_131 = 0;
                            local_130 = "new";
                            state = local_133["new"];
                            local_129 = 0;
                            local_130 = "BillboardGui";
                            local_133 = state("BillboardGui", local_125);
                            local_130 = "ElectricPPPGUI";
                            local_136 = "UDim2";
                            state = "Name";
                            local_133["Name"] = "ElectricPPPGUI";
                            state = "Size";
                            local_132 = environment["UDim2"];
                            local_136 = "new";
                            local_130 = local_132["new"];
                            local_135 = 0;
                            local_136 = 10;
                            local_132 = local_130(10, 0, 10, 0);
                            local_133["Size"] = local_132;
                            state = "AlwaysOnTop";
                            local_132 = "Instance";
                            local_130 = true;
                            local_133["AlwaysOnTop"] = true;
                            local_117 = 0;
                            local_130 = environment["Instance"];
                            local_132 = "new";
                            state = local_130["new"];
                            local_129 = 1;
                            local_132 = "Frame";
                            local_130 = state("Frame", local_133);
                            state = "Size";
                            local_135 = "UDim2";
                            local_136 = environment["UDim2"];
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 1;
                            local_136 = local_132(1, 0, 1, 0);
                            local_130["Size"] = local_136;
                            state = "BackgroundTransparency";
                            local_132 = 0.8;
                            local_130["BackgroundTransparency"] = 0.8;
                            local_135 = "Color3";
                            local_124 = 0;
                            local_132 = 0;
                            local_131 = 2;
                            state = "BorderSizePixel";
                            local_130["BorderSizePixel"] = 0;
                            local_133 = nil;
                            local_129 = 255;
                            local_136 = environment["Color3"];
                            local_135 = "new";
                            local_132 = local_136["new"];
                            state = "BackgroundColor3";
                            local_135 = 240;
                            local_117 = 255;
                            local_136 = local_132(240, 255, 255);
                            local_117 = "UDim2";
                            local_130["BackgroundColor3"] = local_136;
                            local_136 = "Instance";
                            local_132 = environment["Instance"];
                            local_136 = "new";
                            state = local_132["new"];
                            local_129 = 0;
                            local_136 = "TextLabel";
                            local_132 = state("TextLabel", local_130);
                            state = "Size";
                            local_135 = environment["UDim2"];
                            local_130 = nil;
                            local_117 = "new";
                            local_136 = local_135["new"];
                            local_117 = 2;
                            local_135 = local_136(2, 0, 2, 0);
                            local_132["Size"] = local_135;
                            local_136 = 0;
                            state = "BorderSizePixel";
                            local_132["BorderSizePixel"] = 0;
                            state = "TextSize";
                            local_136 = 10;
                            local_132["TextSize"] = 10;
                            local_136 = "Common Chest";
                            state = "Text";
                            local_132["Text"] = "Common Chest";
                            state = "BackgroundTransparency";
                            local_136 = 1;
                            local_132["BackgroundTransparency"] = 1;
                            local_132 = nil;
                            state = 2253478;
                        end
                        local_125 = nil;
                        state = 14133709;
                        local_123 = nil;
                    else
                        break
                    end
                end
                local_119 = {};
                state = environment["tOGgHDFOslK6"];
                if state then
                    error("Unsupported truthy VM exit global: tOGgHDFOslK6");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_14 = function(local_73)
            local local_74 = local_39(local_73);
            return function(local_75, local_76, local_77, local_78, local_79)
                local state, arguments, captures, capture_guard = 4317733, {local_75, local_76, local_77, local_78, local_79}, local_73, local_74;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_126 = "Color3";
                local_116 = local_38();
                local_132 = "Enum";
                local_131 = "CoreGui";
                state = true;
                local_40[local_116] = true;
                local_119 = environment["Color3"];
                local_126 = "fromRGB";
                local_136 = 255;
                local_127 = 255;
                state = local_119["fromRGB"];
                local_123 = 255;
                local_126 = 255;
                local_119 = state(255, 255, 255);
                local_125 = "Color3";
                state = false;
                local_126 = local_38();
                local_40[local_126] = local_119;
                local_133 = 255;
                local_127 = local_38();
                local_40[local_127] = false;
                state = 1;
                local_123 = local_38();
                local_40[local_123] = 1;
                local_119 = environment["Color3"];
                local_130 = 255;
                local_125 = "fromRGB";
                state = local_119["fromRGB"];
                local_125 = 255;
                local_119 = state(255, 255, 255);
                local_125 = local_38();
                local_40[local_125] = local_119;
                state = true;
                local_133 = local_38();
                local_40[local_133] = true;
                local_130 = environment["Enum"];
                local_132 = "Font";
                local_119 = local_130["Font"];
                local_130 = "RobotoMono";
                state = local_119["RobotoMono"];
                local_130 = local_38();
                local_40[local_130] = state;
                local_132 = "Color3";
                local_135 = 255;
                local_134 = "Players";
                local_119 = environment["Color3"];
                local_132 = "fromRGB";
                state = local_119["fromRGB"];
                local_132 = 255;
                local_119 = state(255, 255, 255);
                local_132 = local_38();
                local_136 = local_38();
                local_40[local_132] = local_119;
                state = false;
                local_135 = "Instance";
                local_40[local_136] = false;
                local_119 = environment["Instance"];
                local_135 = "new";
                state = local_119["new"];
                local_124 = "GetService";
                local_129 = "game";
                local_117 = environment["game"];
                local_124 = local_117["GetService"];
                local_128 = "game";
                local_129 = {local_124(local_117, "CoreGui")};
                local_135 = "Folder";
                local_119 = state("Folder", unpack_values(local_129));
                local_135 = local_38();
                local_117 = "";
                local_40[local_135] = local_119;
                local_119 = "Name";
                state = local_40[local_135];
                state["Name"] = "";
                local_119 = "AddOutline";
                state = recovered_1({local_135, local_126, local_127, local_125, local_123});
                local_129 = "ipairs";
                environment["AddOutline"] = state;
                local_117 = "AddNameTag";
                local_119 = recovered_2({local_135, local_130, local_132, local_136});
                environment["AddNameTag"] = local_119;
                local_117 = environment["ipairs"];
                local_118 = environment["game"];
                local_128 = "GetService";
                local_128 = local_118["GetService"];
                state = 10716787;
                local_128 = local_128(local_118, "Players");
                local_134 = "GetPlayers";
                local_134 = local_128["GetPlayers"];
                local_118 = {local_134(local_128)};
                local_128 = {local_117(unpack_values(local_118))};
                local_131 = local_128[2];
                local_124 = local_128[3];
                local_129 = local_128[1];
                while true do
                    local_124, local_118 = local_129(local_131, local_124);
                    state = ((local_124 and 15306341) or 12449164);
                    if (state == 12449164) then
                        break
                    else
                        local_121 = "Players";
                        local_137 = "game";
                        local_122 = environment["game"];
                        local_137 = "GetService";
                        local_137 = local_122["GetService"];
                        local_117 = local_124;
                        local_137 = local_137(local_122, "Players");
                        local_122 = "LocalPlayer";
                        local_134 = local_137["LocalPlayer"];
                        local_128 = (local_118 ~= local_134);
                        state = ((local_128 and 15795367) or 2751153);
                        if (state == 2751153) then

                        else
                            local_122 = recovered_21({local_116, local_133});
                            local_134 = "CharacterAdded";
                            local_128 = local_118["CharacterAdded"];
                            local_134 = "Connect";
                            local_134 = local_128["Connect"];
                            local_134 = local_134(local_128, local_122);
                            local_134 = "Character";
                            local_128 = local_118["Character"];
                            state = ((local_128 and 7819629) or 9751184);
                            if (state == 7819629) then
                                local_134 = local_40[local_116];
                                local_122 = true;
                                local_128 = (local_134 == true);
                                state = ((local_128 and 14269228) or 7004611);
                                if (state == 7004611) then

                                else
                                    local_134 = "AddOutline";
                                    local_137 = "Character";
                                    local_128 = environment["AddOutline"];
                                    state = 7004611;
                                    local_122 = local_118["Character"];
                                    local_134 = local_128(local_122);
                                end
                                local_122 = true;
                                local_134 = local_40[local_133];
                                local_128 = (local_134 == true);
                                state = ((local_128 and 944181) or 579942);
                                if (state == 579942) then

                                else
                                    local_137 = "Character";
                                    local_134 = "AddNameTag";
                                    local_128 = environment["AddNameTag"];
                                    local_122 = local_118["Character"];
                                    state = 579942;
                                    local_134 = local_128(local_122);
                                end
                                state = 9751184;
                            else

                            end
                            state = 2751153;
                        end
                        local_117 = nil;
                        state = 10716787;
                        local_118 = nil;
                    end
                end
                local_124 = "Players";
                state = environment["wEDWc5mtCVPUm"];
                local_131 = "game";
                local_129 = environment["game"];
                local_131 = "GetService";
                local_131 = local_129["GetService"];
                local_131 = local_131(local_129, "Players");
                local_126 = local_46(local_126);
                local_119 = {};
                local_123 = local_46(local_123);
                local_129 = "PlayerAdded";
                local_136 = local_46(local_136);
                local_117 = local_131["PlayerAdded"];
                local_129 = "Connect";
                local_127 = local_46(local_127);
                local_132 = local_46(local_132);
                local_135 = local_46(local_135);
                local_125 = local_46(local_125);
                local_131 = recovered_18({local_116, local_133});
                local_133 = local_46(local_133);
                local_116 = local_46(local_116);
                local_129 = local_117["Connect"];
                local_130 = local_46(local_130);
                local_129 = local_129(local_117, local_131);
                if state then
                    error("Unsupported truthy VM exit global: wEDWc5mtCVPUm");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_15 = function(local_91)
            local local_92 = local_39(local_91);
            return function(local_93)
                local state, arguments, captures, capture_guard = 12913970, {local_93}, local_91, local_92;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_132 = "game";
                local_119 = "pairs";
                state = environment["pairs"];
                local_136 = "Players";
                local_130 = environment["game"];
                local_132 = "GetService";
                local_132 = local_130["GetService"];
                local_132 = local_132(local_130, "Players");
                local_130 = "LocalPlayer";
                local_133 = local_132["LocalPlayer"];
                local_130 = "PlayerScripts";
                local_125 = local_133["PlayerScripts"];
                local_133 = "Shop";
                local_123 = local_125["Shop"];
                local_125 = "Chests";
                local_127 = local_123["Chests"];
                local_125 = "GetDescendants";
                local_125 = local_127["GetDescendants"];
                local_123 = {local_125(local_127)};
                local_127 = {state(unpack_values(local_123))};
                local_119 = local_127[1];
                local_116 = local_127[2];
                local_126 = local_127[3];
                state = 7931558;
                local_127 = local_119;
                while true do
                    local_126, local_125 = local_127(local_116, local_126);
                    state = ((local_126 and 5240040) or 16547150);
                    if (state == 5240040) then
                        local_123 = local_126;
                        local_130 = "Name";
                        local_133 = local_125["Name"];
                        local_130 = "Rare";
                        state = (local_133 == "Rare");
                        state = ((state and 11859924) or 12192223);
                        if (state == 11859924) then
                            local_130 = "Instance";
                            local_133 = environment["Instance"];
                            local_129 = 0;
                            local_130 = "new";
                            state = local_133["new"];
                            local_117 = 10;
                            local_130 = "BillboardGui";
                            local_133 = state("BillboardGui", local_125);
                            local_135 = 0;
                            state = "Name";
                            local_136 = "UDim2";
                            local_130 = "ElectricPPPGUI";
                            local_133["Name"] = "ElectricPPPGUI";
                            state = "Size";
                            local_132 = environment["UDim2"];
                            local_136 = "new";
                            local_130 = local_132["new"];
                            local_136 = 10;
                            local_132 = local_130(10, 0, 10, 0);
                            local_133["Size"] = local_132;
                            local_132 = "Instance";
                            local_131 = 0;
                            state = "AlwaysOnTop";
                            local_117 = 0;
                            local_130 = true;
                            local_133["AlwaysOnTop"] = true;
                            local_130 = environment["Instance"];
                            local_135 = "UDim2";
                            local_132 = "new";
                            state = local_130["new"];
                            local_132 = "Frame";
                            local_130 = state("Frame", local_133);
                            local_136 = environment["UDim2"];
                            state = "Size";
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_129 = 1;
                            local_135 = 1;
                            local_136 = local_132(1, 0, 1, 0);
                            local_130["Size"] = local_136;
                            local_135 = "Color3";
                            state = "BackgroundTransparency";
                            local_132 = 0.8;
                            local_130["BackgroundTransparency"] = 0.8;
                            state = "BorderSizePixel";
                            local_132 = 0;
                            local_130["BorderSizePixel"] = 0;
                            local_136 = environment["Color3"];
                            local_135 = "new";
                            state = "BackgroundColor3";
                            local_129 = 255;
                            local_132 = local_136["new"];
                            local_117 = 255;
                            local_135 = 240;
                            local_136 = local_132(240, 255, 255);
                            local_130["BackgroundColor3"] = local_136;
                            local_136 = "Instance";
                            local_124 = 0;
                            local_132 = environment["Instance"];
                            local_136 = "new";
                            local_117 = "UDim2";
                            state = local_132["new"];
                            local_136 = "TextLabel";
                            local_129 = 0;
                            local_132 = state("TextLabel", local_130);
                            local_135 = environment["UDim2"];
                            state = "Size";
                            local_131 = 2;
                            local_117 = "new";
                            local_136 = local_135["new"];
                            local_117 = 2;
                            local_135 = local_136(2, 0, 2, 0);
                            local_136 = 0;
                            local_132["Size"] = local_135;
                            state = "BorderSizePixel";
                            local_132["BorderSizePixel"] = 0;
                            local_136 = 10;
                            local_133 = nil;
                            state = "TextSize";
                            local_132["TextSize"] = 10;
                            local_130 = nil;
                            local_136 = "Rare Chest";
                            state = "Text";
                            local_132["Text"] = "Rare Chest";
                            state = "BackgroundTransparency";
                            local_136 = 1;
                            local_132["BackgroundTransparency"] = 1;
                            state = 12192223;
                            local_132 = nil;
                        else

                        end
                        local_123 = nil;
                        state = 7931558;
                        local_125 = nil;
                    else
                        break
                    end
                end
                local_119 = {};
                state = environment["U2yTthXWJoeLZZ"];
                if state then
                    error("Unsupported truthy VM exit global: U2yTthXWJoeLZZ");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_16 = function(local_96)
            local local_97 = local_39(local_96);
            return function()
                local state, arguments, captures, capture_guard = 14351983, {}, local_96, local_97;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_119 = "pairs";
                local_132 = "game";
                state = environment["pairs"];
                local_136 = "Players";
                local_130 = environment["game"];
                local_132 = "GetService";
                local_132 = local_130["GetService"];
                local_132 = local_132(local_130, "Players");
                local_130 = "LocalPlayer";
                local_133 = local_132["LocalPlayer"];
                local_130 = "PlayerScripts";
                local_125 = local_133["PlayerScripts"];
                local_133 = "Shop";
                local_123 = local_125["Shop"];
                local_125 = "Chests";
                local_127 = local_123["Chests"];
                local_125 = "GetDescendants";
                local_125 = local_127["GetDescendants"];
                local_123 = {local_125(local_127)};
                local_127 = {state(unpack_values(local_123))};
                local_116 = local_127[2];
                state = 12189044;
                local_126 = local_127[3];
                local_119 = local_127[1];
                local_127 = local_119;
                while true do
                    local_126, local_125 = local_127(local_116, local_126);
                    state = ((local_126 and 1119951) or 10589906);
                    if (state == 1119951) then
                        local_130 = "Name";
                        local_123 = local_126;
                        local_133 = local_125["Name"];
                        local_130 = "Uncommon";
                        state = (local_133 == "Uncommon");
                        state = ((state and 4495594) or 10448948);
                        if (state == 4495594) then
                            local_130 = "Instance";
                            local_133 = environment["Instance"];
                            local_117 = 10;
                            local_130 = "new";
                            local_136 = "UDim2";
                            state = local_133["new"];
                            local_130 = "BillboardGui";
                            local_133 = state("BillboardGui", local_125);
                            state = "Name";
                            local_130 = "ElectricPPPGUI";
                            local_133["Name"] = "ElectricPPPGUI";
                            local_132 = environment["UDim2"];
                            state = "Size";
                            local_129 = 0;
                            local_136 = "new";
                            local_131 = 0;
                            local_135 = 0;
                            local_130 = local_132["new"];
                            local_136 = 10;
                            local_132 = local_130(10, 0, 10, 0);
                            local_133["Size"] = local_132;
                            state = "AlwaysOnTop";
                            local_132 = "Instance";
                            local_130 = true;
                            local_133["AlwaysOnTop"] = true;
                            local_130 = environment["Instance"];
                            local_124 = 0;
                            local_132 = "new";
                            state = local_130["new"];
                            local_132 = "Frame";
                            local_117 = 0;
                            local_130 = state("Frame", local_133);
                            state = "Size";
                            local_135 = "UDim2";
                            local_129 = 1;
                            local_136 = environment["UDim2"];
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 1;
                            local_136 = local_132(1, 0, 1, 0);
                            local_130["Size"] = local_136;
                            local_132 = 0.8;
                            state = "BackgroundTransparency";
                            local_130["BackgroundTransparency"] = 0.8;
                            state = "BorderSizePixel";
                            local_117 = 255;
                            local_135 = "Color3";
                            local_132 = 0;
                            local_130["BorderSizePixel"] = 0;
                            state = "BackgroundColor3";
                            local_136 = environment["Color3"];
                            local_129 = 255;
                            local_133 = nil;
                            local_135 = "new";
                            local_132 = local_136["new"];
                            local_135 = 240;
                            local_136 = local_132(240, 255, 255);
                            local_130["BackgroundColor3"] = local_136;
                            local_117 = "UDim2";
                            local_129 = 0;
                            local_136 = "Instance";
                            local_132 = environment["Instance"];
                            local_136 = "new";
                            state = local_132["new"];
                            local_136 = "TextLabel";
                            local_132 = state("TextLabel", local_130);
                            local_135 = environment["UDim2"];
                            state = "Size";
                            local_117 = "new";
                            local_131 = 2;
                            local_136 = local_135["new"];
                            local_117 = 2;
                            local_135 = local_136(2, 0, 2, 0);
                            local_132["Size"] = local_135;
                            local_136 = 0;
                            state = "BorderSizePixel";
                            local_132["BorderSizePixel"] = 0;
                            local_136 = 10;
                            state = "TextSize";
                            local_132["TextSize"] = 10;
                            local_130 = nil;
                            state = "Text";
                            local_136 = "Uncommon Chest";
                            local_132["Text"] = "Uncommon Chest";
                            state = "BackgroundTransparency";
                            local_136 = 1;
                            local_132["BackgroundTransparency"] = 1;
                            state = 10448948;
                            local_132 = nil;
                        else

                        end
                        local_125 = nil;
                        state = 12189044;
                        local_123 = nil;
                    else
                        break
                    end
                end
                state = environment["1luwil5RtdVm"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: 1luwil5RtdVm");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_17 = function(local_100)
            local local_101 = local_39(local_100);
            return function(local_102, local_103, local_104)
                local state, arguments, captures, capture_guard = 10816622, {local_102, local_103, local_104}, local_100, local_101;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_116 = "_G";
                local_119 = environment["_G"];
                local_116 = "Disabled";
                state = local_119["Disabled"];
                state = ((state and 14238182) or 3361975);
                if (state == 3361975) then

                else
                    local_119 = "next";
                    state = environment["next"];
                    local_116 = "game";
                    local_126 = "Players";
                    local_119 = environment["game"];
                    local_127 = "GetPlayers";
                    local_116 = "GetService";
                    local_116 = local_119["GetService"];
                    local_116 = local_116(local_119, "Players");
                    local_127 = local_116["GetPlayers"];
                    local_127 = {local_127(local_116)};
                    local_126 = local_127[2];
                    local_116 = state;
                    local_119 = local_127[1];
                    local_127 = local_119;
                    state = 10243237;
                    while true do
                        local_126, local_125 = local_116(local_127, local_126);
                        state = ((local_126 and 13414708) or 15568629);
                        if (state == 13414708) then
                            local_133 = local_38();
                            local_117 = "game";
                            local_40[local_133] = local_125;
                            local_123 = local_126;
                            local_136 = "Name";
                            local_125 = local_133;
                            local_132 = local_40[local_125];
                            local_130 = local_132["Name"];
                            local_135 = environment["game"];
                            local_129 = "Players";
                            local_117 = "GetService";
                            local_117 = local_135["GetService"];
                            local_117 = local_117(local_135, "Players");
                            local_135 = "LocalPlayer";
                            local_136 = local_117["LocalPlayer"];
                            local_135 = "Name";
                            local_132 = local_136["Name"];
                            local_133 = (local_130 ~= local_132);
                            state = ((local_133 and 5441190) or 7262544);
                            if (state == 5441190) then
                                local_130 = "pcall";
                                local_132 = recovered_3({local_125});
                                local_133 = environment["pcall"];
                                local_130 = local_133(local_132);
                                state = 7262544;
                            else

                            end
                            local_123 = nil;
                            local_125 = local_46(local_125);
                            state = 10243237;
                        else
                            break
                        end
                    end
                    state = 3361975;
                end
                state = environment["4ovHVYULAHHb"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: 4ovHVYULAHHb");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_18 = function(local_55)
            local local_56 = local_39(local_55);
            return function(local_57, local_58, local_59, local_60)
                local state, arguments, captures, capture_guard = 12798352, {local_57, local_58, local_59, local_60}, local_55, local_56;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_119 = "CharacterAdded";
                local_116 = arguments[1];
                local_126 = recovered_19({captures[1], captures[2]});
                state = local_116["CharacterAdded"];
                local_119 = "Connect";
                local_119 = state["Connect"];
                local_116 = nil;
                local_119 = local_119(state, local_126);
                local_119 = {};
                state = environment["lIPLkpCntxZ6"];
                if state then
                    error("Unsupported truthy VM exit global: lIPLkpCntxZ6");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_19 = function(local_91)
            local local_92 = local_39(local_91);
            return function(local_93)
                local state, arguments, captures, capture_guard = 13029106, {local_93}, local_91, local_92;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_116 = arguments[1];
                local_119 = local_40[captures[1]];
                local_126 = true;
                state = (local_119 == true);
                state = ((state and 11816503) or 3695335);
                if (state == 3695335) then

                else
                    local_119 = "AddOutline";
                    state = environment["AddOutline"];
                    local_119 = state(local_116);
                    state = 3695335;
                end
                local_119 = local_40[captures[2]];
                local_126 = true;
                state = (local_119 == true);
                state = ((state and 13830494) or 15894490);
                if (state == 13830494) then
                    local_119 = "AddNameTag";
                    state = environment["AddNameTag"];
                    local_119 = state(local_116);
                    state = 15894490;
                else

                end
                local_116 = nil;
                local_119 = {};
                state = environment["gaOsFH7iVIHVT"];
                if state then
                    error("Unsupported truthy VM exit global: gaOsFH7iVIHVT");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_20 = function(local_82)
            local local_83 = local_39(local_82);
            return function(local_84, local_85)
                local state, arguments, captures, capture_guard = 2693588, {local_84, local_85}, local_82, local_83;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                state = local_40[captures[1]];
                state = ((state and 13153728) or 5664381);
                if (state == 5664381) then

                else
                    local_127 = "game";
                    local_126 = environment["game"];
                    local_127 = "Players";
                    local_116 = local_126["Players"];
                    local_126 = "LocalPlayer";
                    local_119 = local_116["LocalPlayer"];
                    local_116 = "Character";
                    state = local_119["Character"];
                    local_116 = "Humanoid";
                    local_119 = "FindFirstChildOfClass";
                    local_119 = state["FindFirstChildOfClass"];
                    local_119 = local_119(state, "Humanoid");
                    state = "ChangeState";
                    local_116 = "Jumping";
                    state = local_119["ChangeState"];
                    state = state(local_119, "Jumping");
                    state = 5664381;
                end
                local_119 = {};
                state = environment["0cpDx2A3VBzuU"];
                if state then
                    error("Unsupported truthy VM exit global: 0cpDx2A3VBzuU");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_21 = function(local_82)
            local local_83 = local_39(local_82);
            return function(local_84, local_85)
                local state, arguments, captures, capture_guard = 2865384, {local_84, local_85}, local_82, local_83;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_116 = arguments[1];
                local_126 = true;
                local_119 = local_40[captures[1]];
                state = (local_119 == true);
                state = ((state and 14517169) or 10135159);
                if (state == 10135159) then

                else
                    local_119 = "AddOutline";
                    state = environment["AddOutline"];
                    local_119 = state(local_116);
                    state = 10135159;
                end
                local_126 = true;
                local_119 = local_40[captures[2]];
                state = (local_119 == true);
                state = ((state and 12827118) or 12512780);
                if (state == 12512780) then

                else
                    local_119 = "AddNameTag";
                    state = environment["AddNameTag"];
                    local_119 = state(local_116);
                    state = 12512780;
                end
                local_116 = nil;
                state = environment["BftETEAYzBliIE"];
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: BftETEAYzBliIE");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        recovered_22 = function(local_107)
            local local_108 = local_39(local_107);
            return function(...)
                local state, arguments, captures, capture_guard = 11092583, {...}, local_107, local_108;
                local local_114, local_115, local_116, local_117, local_118, local_119, local_120, local_121, local_122, local_123, local_124, local_125, local_126, local_127, local_128, local_129, local_130, local_131, local_132, local_133, local_134, local_135, local_136, local_137;
                local_124 = "keyabc123";
                local_130 = "ToggleKey";
                local_116 = arguments;
                local_134 = "DiscordLink";
                local_119 = "loadstring";
                local_123 = "https://raw.githubusercontent.com/Loco-CTO/UI-Library/main/VisionLibV2/source.lua";
                state = environment["loadstring"];
                local_131 = "Key";
                local_128 = 5;
                local_125 = "HttpGet";
                local_127 = "game";
                local_117 = "Enum";
                local_126 = environment["game"];
                local_125 = local_126["HttpGet"];
                local_127 = {local_125(local_126, "https://raw.githubusercontent.com/Loco-CTO/UI-Library/main/VisionLibV2/source.lua")};
                local_123 = "Xtrey10x Hub Free - [\240\159\146\150\240\159\164\150UPDATE 8] Grand Piece Online";
                local_119 = state(unpack_values(local_127));
                state = local_119();
                local_133 = "By Xtrey10x";
                local_127 = "Name";
                local_126 = state;
                local_135 = environment["Enum"];
                local_125 = "Footer";
                local_117 = "KeyCode";
                local_136 = local_135["KeyCode"];
                state = "Create";
                local_129 = false;
                local_135 = "RightShift";
                local_132 = local_136["RightShift"];
                local_135 = recovered_4({});
                local_137 = "ToggledRelativeYOffset";
                local_121 = 5;
                state = local_126["Create"];
                local_117 = "KeySystem";
                local_136 = "LoadedCallback";
                local_122 = "https://discord.gg/Bp7wFcZeUn";
                local_118 = "MaxAttempts";
                local_119 = {
                    ["Name"] = "Xtrey10x Hub Free - [\240\159\146\150\240\159\164\150UPDATE 8] Grand Piece Online",
                    ["Footer"] = "By Xtrey10x",
                    ["ToggleKey"] = local_132,
                    ["LoadedCallback"] = local_135,
                    ["KeySystem"] = false,
                    ["Key"] = "keyabc123",
                    ["MaxAttempts"] = 5,
                    ["DiscordLink"] = "https://discord.gg/Bp7wFcZeUn",
                    ["ToggledRelativeYOffset"] = 5,
                };
                local_132 = "Color";
                local_123 = "Name";
                local_117 = "Color3";
                local_137 = "Callback";
                state = state(local_126, local_119);
                local_133 = "Icon";
                local_127 = state;
                local_135 = environment["Color3"];
                local_117 = "new";
                local_130 = "rbxassetid://11396131982";
                local_120 = 0;
                local_131 = 0;
                local_124 = 15;
                state = "Tab";
                local_125 = "General";
                local_136 = local_135["new"];
                state = local_127["Tab"];
                local_117 = 1;
                local_129 = 0;
                local_135 = local_136(1, 0, 0);
                local_119 = {["Name"] = "General", ["Icon"] = "rbxassetid://11396131982", ["Color"] = local_135};
                local_133 = "Main";
                local_129 = recovered_5({});
                local_135 = "Callback";
                local_131 = recovered_6({});
                state = state(local_127, local_119);
                local_125 = "Name";
                local_119 = {["Name"] = "Main"};
                local_123 = state;
                state = "Section";
                local_136 = false;
                state = local_123["Section"];
                local_118 = "Min";
                local_117 = recovered_7({});
                state = state(local_123, local_119);
                local_130 = " Invisible Hitbox";
                local_125 = state;
                state = "Toggle";
                state = local_125["Toggle"];
                local_128 = 2.07;
                local_133 = "Name";
                local_132 = "Default";
                local_119 = {["Name"] = " Invisible Hitbox", ["Default"] = false, ["Callback"] = local_117};
                local_122 = 2.07;
                local_136 = "Default";
                local_117 = "Callback";
                local_135 = false;
                local_132 = "Walkspeed";
                state = state(local_125, local_119);
                local_130 = "Name";
                local_133 = state;
                state = "Toggle";
                state = local_125["Toggle"];
                local_119 = {["Name"] = "Walkspeed", ["Default"] = false, ["Callback"] = local_129};
                state = state(local_125, local_119);
                local_135 = "Default";
                local_117 = false;
                local_132 = "Name";
                local_136 = "Inf Geppo";
                local_129 = "Callback";
                local_130 = state;
                local_119 = {["Name"] = "Inf Geppo", ["Default"] = false, ["Callback"] = local_131};
                local_135 = "Running Animation";
                state = "Toggle";
                state = local_125["Toggle"];
                local_129 = recovered_8({});
                local_114 = recovered_9({});
                state = state(local_125, local_119);
                local_131 = recovered_10({});
                local_136 = "Name";
                local_117 = "Callback";
                local_115 = recovered_11({});
                local_132 = state;
                local_119 = {["Name"] = "Running Animation", ["Callback"] = local_129};
                local_135 = "Name";
                state = "Button";
                state = local_125["Button"];
                local_117 = "No Fall Damage";
                local_123 = nil;
                state = state(local_125, local_119);
                local_136 = state;
                state = "Button";
                local_121 = recovered_12({});
                state = local_125["Button"];
                local_129 = "Callback";
                local_134 = "Default";
                local_119 = {["Name"] = "No Fall Damage", ["Callback"] = local_131};
                local_129 = "HipHeight";
                state = state(local_125, local_119);
                local_117 = "Name";
                local_135 = state;
                local_131 = "Max";
                state = "Slider";
                local_119 = {["Name"] = "HipHeight", ["Max"] = 15, ["Min"] = 2.07, ["Default"] = 2.07, ["Callback"] = local_121};
                local_137 = "Color3";
                state = local_125["Slider"];
                local_118 = "rbxassetid://11396131982";
                local_129 = "Name";
                local_136 = nil;
                local_131 = "Esp";
                local_121 = 0;
                local_124 = "Icon";
                state = state(local_125, local_119);
                local_122 = environment["Color3"];
                local_130 = nil;
                local_137 = "new";
                local_117 = state;
                local_134 = local_122["new"];
                local_137 = 1;
                local_122 = local_134(1, 0, 0);
                state = "Tab";
                local_128 = "Color";
                local_119 = {["Name"] = "Esp", ["Icon"] = "rbxassetid://11396131982", ["Color"] = local_122};
                state = local_127["Tab"];
                local_132 = nil;
                local_137 = recovered_13({});
                local_124 = "Player Esp";
                state = state(local_127, local_119);
                local_131 = "Name";
                local_129 = state;
                state = "Section";
                state = local_129["Section"];
                local_134 = recovered_14({});
                local_119 = {["Name"] = "Player Esp"};
                local_118 = "Esp";
                local_128 = "Callback";
                local_124 = "Name";
                state = state(local_129, local_119);
                local_131 = state;
                state = "Button";
                state = local_131["Button"];
                local_120 = recovered_15({});
                local_119 = {["Name"] = "Esp", ["Callback"] = local_134};
                local_134 = "Common Chest";
                local_122 = "Callback";
                local_128 = "Chest Esp";
                local_118 = "Name";
                state = state(local_131, local_119);
                local_119 = {["Name"] = "Chest Esp"};
                local_121 = recovered_16({});
                local_124 = state;
                state = "Section";
                state = local_129["Section"];
                local_128 = "Name";
                local_135 = nil;
                state = state(local_129, local_119);
                local_118 = state;
                local_127 = nil;
                state = "Button";
                state = local_118["Button"];
                local_119 = {["Name"] = "Common Chest", ["Callback"] = local_137};
                local_137 = "Callback";
                local_122 = "Uncommon Chest";
                state = state(local_118, local_119);
                local_134 = "Name";
                local_128 = state;
                state = "Button";
                local_133 = nil;
                local_119 = {["Name"] = "Uncommon Chest", ["Callback"] = local_121};
                local_137 = "Rare Chest";
                state = local_118["Button"];
                local_121 = "Callback";
                local_122 = "Name";
                local_126 = nil;
                state = state(local_118, local_119);
                local_119 = {["Name"] = "Rare Chest", ["Callback"] = local_120};
                local_137 = "Name";
                local_124 = nil;
                local_134 = state;
                local_120 = "Callback";
                state = "Button";
                local_121 = "Legendary Chest";
                state = local_118["Button"];
                state = state(local_118, local_119);
                local_128 = nil;
                local_119 = {["Name"] = "Legendary Chest", ["Callback"] = local_115};
                local_122 = state;
                local_115 = "Callback";
                state = "Button";
                local_121 = "Name";
                local_125 = nil;
                local_117 = nil;
                local_120 = "Mythical Chest";
                state = local_118["Button"];
                local_129 = nil;
                local_122 = nil;
                state = state(local_118, local_119);
                local_119 = {["Name"] = "Mythical Chest", ["Callback"] = local_114};
                local_137 = state;
                local_131 = nil;
                state = "Button";
                state = local_118["Button"];
                local_134 = nil;
                local_137 = nil;
                state = state(local_118, local_119);
                local_121 = state;
                local_121 = nil;
                state = environment["pHP3LHlR7xReh"];
                local_118 = nil;
                local_119 = {};
                if state then
                    error("Unsupported truthy VM exit global: pHP3LHlR7xReh");
                end
                state = (#capture_guard);
                return unpack_values(local_119)
            end
        end;
        local_39, local_37, local_35, local_42, local_34, local_38, local_49, local_43, local_40, local_48, local_44, local_41, local_45, local_36, local_46, local_47 = function(local_50)
            for local_51 = 1, (#local_50), 1 do
                local_34[local_50[local_51]] = (1 + local_34[local_50[local_51]]);
            end
            if new_proxy then
                local local_52 = new_proxy(true);
                local local_53 = get_metatable(local_52);
                local_53["__index"], local_53["__gc"], local_53["__len"] = local_50, local_43, function()
                    return -2689963
                end;
                return local_52
            else
                return set_metatable({}, {
                    ["__gc"] = local_43,
                    ["__index"] = local_50,
                    ["__len"] = function()
                        return -2689963
                    end,
                })
            end
        end, nil, nil, nil, {}, function()
            local_47 = (local_47 + 1);
            local_34[local_47] = 1;
            return local_47
        end, nil, function(local_87)
            local local_88, local_89 = 1, local_87[1];
            while local_89 do
                local_34[local_89], local_88 = (local_34[local_89] - 1), (local_88 + 1);
                if (local_34[local_89] == 0) then
                    local_34[local_89], local_40[local_89] = nil, nil;
                end
                local_89 = local_87[local_88];
            end
        end, {}, nil, nil, nil, nil, nil, function(local_138)
            local_34[local_138] = (local_34[local_138] - 1);
            if (local_34[local_138] == 0) then
                local_34[local_138], local_40[local_138] = nil, nil;
            end
        end, 0;
        return (recovered_22({}))(unpack_values(input_arguments))
    end))(((getfenv and getfenv()) or _ENV), (unpack or table["unpack"]), newproxy, setmetatable, getmetatable, select, {...})
end))(...)
