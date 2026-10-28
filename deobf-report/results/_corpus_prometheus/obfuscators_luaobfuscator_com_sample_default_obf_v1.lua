local v0 = tonumber
local v1 = string.byte
local v2 = string.char
local v3 = string.sub
local v4 = string.gsub
local v5 = string.rep
local v6 = table.concat
local v7 = table.insert
local v8 = math.ldexp
local v9 = getfenv or function()
  return _ENV
end
local v10 = setmetatable
local v12 = select
local v13 = unpack or table.unpack
local function v15(v16, v17, ...)
  local v18 = 1
  local v19
  v16 = v4(v3(v16, 5), "..", function(v30)
    if (v1(v30, 2) == 81) then
      v19 = v0(v3(v30, 1, 1))
      return ""
    else
      local v85 = 0
      local v86
      while true do
        if (v85 == 0) then
          v86 = v2(v0(v30, 16))
          if v19 then
            local v127 = 0
            local v128
            while true do
              if (v127 == 1) then
                return v128
              end
              if (v127 == 0) then
                v128 = v5(v86, v19)
                v19 = nil
                v127 = 1
              end
            end
          else
            return v86
          end
          break
        end
      end
    end
  end)
  local function v20(v31, v32, v33)
    if v33 then
      local v87 = 0
      local v88
      while true do
        if (v87 == 0) then
          v88 = (v31 / (2 ^ (v32 - 1))) % (2 ^ (((v33 - 1) - (v32 - 1)) + 1))
          return v88 - (v88 % 1)
        end
      end
    else
      local v89 = 0
      local v90
      while true do
        if (v89 == 0) then
          v90 = 2 ^ (v32 - 1)
          return (((v31 % (v90 + v90)) >= v90) and 1) or 0
        end
      end
    end
  end
  local function v21()
    local v34 = v1(v16, v18, v18)
    v18 = v18 + 1
    return v34
  end
  local function v22()
    local v35, v36 = v1(v16, v18, v18 + 2)
    v18 = v18 + 2
    return (v36 * 256) + v35
  end
  local function v23()
    local v37, v38, v39, v40 = v1(v16, v18, v18 + 3 + 0)
    v18 = v18 + 4
    return (v40 * 16777216) + (v39 * 65536) + (v38 * 256) + v37
  end
  local function v24()
    local v41 = v23()
    local v42 = v23()
    local v43 = 1
    local v44 = (v20(v42, 1, 20) * 4294967296) + v41
    local v45 = v20(v42, 21, 31)
    local v46 = ((v20(v42, 32) == 1) and -1) or 1
    if (v45 == 0) then
      if (v44 == 0) then
        return v46 * 0
      else
        local v116 = 0
        while true do
          if (v116 == 0) then
            v45 = 1
            v43 = 0
            break
          end
        end
      end
    elseif (v45 == 2047) then
      return ((v44 == 0) and (v46 * (1/0))) or (v46 * NaN)
    end
    return v8(v46, v45 - 1023) * (v43 + (v44 / 4503599627370496.0))
  end
  local function v25(v47)
    local v48
    if not v47 then
      v47 = v23()
      if (v47 == 0) then
        return ""
      end
    end
    v48 = v3(v16, v18, (v18 + v47) - 1)
    v18 = v18 + v47
    local v49 = {}
    for v66 = 1, #v48 do
      v49[v66] = v2(v1(v3(v48, v66, v66)))
    end
    return v6(v49)
  end
  local function v27(...)
    return {...}, v12("#", ...)
  end
  local function v28()
    local v50 = (function()
      return function(v91, v92, v93, v94, v95, v96, v97, v98)
        local v91 = (function()
          return 0
        end)()
        local v92 = (function()
          return
        end)()
        local v93 = (function()
          return
        end)()
        while true do
          if (1 == v91) then
            if (v92 == 1) then
              v93 = (function()
                return v94() ~= 0
              end)()
            elseif (v92 == 2) then
              v93 = (function()
                return v95()
              end)()
            elseif (v92 ~= 3) then
            else
              v93 = (function()
                return v96()
              end)()
            end
            v97[v98] = (function()
              return v93
            end)()
            break
          end
          if (0 ~= v91) then
          else
            local v122 = (function()
              return 0
            end)()
            while true do
              if (v122 ~= 1) then
              else
                v91 = (function()
                  return 1
                end)()
                break
              end
              if (v122 == 0) then
                v92 = (function()
                  return v94()
                end)()
                v93 = (function()
                  return nil
                end)()
                v122 = (function()
                  return 1
                end)()
              end
            end
          end
        end
        return v91, v92, v93, v94, v95, v96, v97, v98
      end
    end)()
    local v51 = (function()
      return function(v99, v100, v101, v102, v103, v104, v105, v106, v107)
        local v108 = (function()
          return 0
        end)()
        local v99 = (function()
          return
        end)()
        local v100 = (function()
          return
        end)()
        while true do
          if (v108 ~= 0) then
          else
            local v123 = (function()
              return 0
            end)()
            local v124 = (function()
              return
            end)()
            while true do
              if (v123 == 0) then
                v124 = (function()
                  return 0
                end)()
                while true do
                  if (v124 ~= 0) then
                  else
                    v99 = (function()
                      return 0
                    end)()
                    v100 = (function()
                      return nil
                    end)()
                    v124 = (function()
                      return 1
                    end)()
                  end
                  if (v124 == 1) then
                    v108 = (function()
                      return 1
                    end)()
                    break
                  end
                end
                break
              end
            end
          end
          if (1 ~= v108) then
          else
            local v125 = (function()
              return 0
            end)()
            while true do
              if (v125 == 0) then
                while true do
                  if (v99 == 0) then
                    v100 = (function()
                      return v101()
                    end)()
                    if (v102(v100, 1, 1) == 0) then
                      local v145 = (function()
                        return 0
                      end)()
                      local v146 = (function()
                        return
                      end)()
                      local v147 = (function()
                        return
                      end)()
                      local v148 = (function()
                        return
                      end)()
                      local v149 = (function()
                        return
                      end)()
                      while true do
                        if (v145 == 1) then
                          local v395 = (function()
                            return 0
                          end)()
                          while true do
                            if (1 == v395) then
                              v145 = (function()
                                return 2
                              end)()
                              break
                            end
                            if (v395 ~= 0) then
                            else
                              v148 = (function()
                                return nil
                              end)()
                              v149 = (function()
                                return nil
                              end)()
                              v395 = (function()
                                return 1
                              end)()
                            end
                          end
                        end
                        if (v145 ~= 0) then
                        else
                          local v396 = (function()
                            return 0
                          end)()
                          local v397 = (function()
                            return
                          end)()
                          while true do
                            if (v396 == 0) then
                              v397 = (function()
                                return 0
                              end)()
                              while true do
                                if (v397 == 0) then
                                  v146 = (function()
                                    return 0
                                  end)()
                                  v147 = (function()
                                    return nil
                                  end)()
                                  v397 = (function()
                                    return 1
                                  end)()
                                end
                                if (1 == v397) then
                                  v145 = (function()
                                    return 1
                                  end)()
                                  break
                                end
                              end
                              break
                            end
                          end
                        end
                        if (v145 == 2) then
                          while true do
                            if (0 ~= v146) then
                            else
                              local v477 = (function()
                                return 0
                              end)()
                              local v478 = (function()
                                return
                              end)()
                              while true do
                                if (v477 == 0) then
                                  v478 = (function()
                                    return 0
                                  end)()
                                  while true do
                                    if (v478 == 0) then
                                      v147 = (function()
                                        return v102(v100, 2, 3)
                                      end)()
                                      v148 = (function()
                                        return v102(v100, 4, 6)
                                      end)()
                                      v478 = (function()
                                        return 1
                                      end)()
                                    end
                                    if (v478 ~= 1) then
                                    else
                                      v146 = (function()
                                        return 1
                                      end)()
                                      break
                                    end
                                  end
                                  break
                                end
                              end
                            end
                            if (v146 == 3) then
                              if (v102(v148, 3, 3) == 1) then
                                v149[4] = (function()
                                  return v103[v149[4]]
                                end)()
                              end
                              v104[v105] = (function()
                                return v149
                              end)()
                              break
                            end
                            if (v146 == 2) then
                              local v480 = (function()
                                return 0
                              end)()
                              local v481 = (function()
                                return
                              end)()
                              while true do
                                if (0 ~= v480) then
                                else
                                  v481 = (function()
                                    return 0
                                  end)()
                                  while true do
                                    if (v481 ~= 0) then
                                    else
                                      if (v102(v148, 1, 1) == 1) then
                                        v149[2] = (function()
                                          return v103[v149[2]]
                                        end)()
                                      end
                                      if (v102(v148, 2, 2) == 1) then
                                        v149[3] = (function()
                                          return v103[v149[3]]
                                        end)()
                                      end
                                      v481 = (function()
                                        return 1
                                      end)()
                                    end
                                    if (v481 == 1) then
                                      v146 = (function()
                                        return 3
                                      end)()
                                      break
                                    end
                                  end
                                  break
                                end
                              end
                            end
                            if (v146 == 1) then
                              local v482 = (function()
                                return 0
                              end)()
                              local v483 = (function()
                                return
                              end)()
                              while true do
                                if (v482 == 0) then
                                  v483 = (function()
                                    return 0
                                  end)()
                                  while true do
                                    if (v483 == 1) then
                                      v146 = (function()
                                        return 2
                                      end)()
                                      break
                                    end
                                    if (v483 == 0) then
                                      v149 = (function()
                                        return {v106(), v106(), nil, nil}
                                      end)()
                                      if (v147 == 0) then
                                        local v501 = (function()
                                          return 0
                                        end)()
                                        local v502 = (function()
                                          return
                                        end)()
                                        while true do
                                          if (v501 ~= 0) then
                                          else
                                            v502 = (function()
                                              return 0
                                            end)()
                                            while true do
                                              if (v502 ~= 0) then
                                              else
                                                v149[3] = (function()
                                                  return v106()
                                                end)()
                                                v149[4] = (function()
                                                  return v106()
                                                end)()
                                                break
                                              end
                                            end
                                            break
                                          end
                                        end
                                      elseif (v147 == 1) then
                                        v149[3] = (function()
                                          return v107()
                                        end)()
                                      elseif (v147 == 2) then
                                        v149[3] = (function()
                                          return v107() - 65536
                                        end)()
                                      elseif (v147 == 3) then
                                        local v507 = (function()
                                          return 0
                                        end)()
                                        while true do
                                          if (v507 == 0) then
                                            v149[3] = (function()
                                              return v107() - 65536
                                            end)()
                                            v149[4] = (function()
                                              return v106()
                                            end)()
                                            break
                                          end
                                        end
                                      end
                                      v483 = (function()
                                        return 1
                                      end)()
                                    end
                                  end
                                  break
                                end
                              end
                            end
                          end
                          break
                        end
                      end
                    end
                    break
                  end
                end
                return v99, v100, v101, v102, v103, v104, v105, v106, v107
              end
            end
          end
        end
      end
    end)()
    local v52 = (function()
      return function(v109, v110, v111)
        local v112 = (function()
          return 0
        end)()
        while true do
          if (v112 == 0) then
            local v126 = (function()
              return 0
            end)()
            while true do
              if (v126 == 0) then
                v109[v110 - 1] = (function()
                  return v111()
                end)()
                return v109, v110, v111
              end
            end
          end
        end
      end
    end)()
    local v53 = (function()
      return {}
    end)()
    local v54 = (function()
      return {}
    end)()
    local v55 = (function()
      return {}
    end)()
    local v56 = (function()
      return {v53, v54, nil, v55}
    end)()
    local v57 = (function()
      return v23()
    end)()
    local v58 = (function()
      return {}
    end)()
    for v68 = 1, v57 do
      FlatIdent_61585, Type, Cons, v21, v24, v25, v58, v68 = (function()
        return v50(FlatIdent_61585, Type, Cons, v21, v24, v25, v58, v68)
      end)()
    end
    v56[3] = (function()
      return v21()
    end)()
    for v69 = 1, v23() do
      FlatIdent_1BCFB, Descriptor, v21, v20, v58, v53, v69, v22, v23 = (function()
        return v51(FlatIdent_1BCFB, Descriptor, v21, v20, v58, v53, v69, v22, v23)
      end)()
    end
    for v70 = 1, v23() do
      v54, v70, v28 = (function()
        return v52(v54, v70, v28)
      end)()
    end
    return v56
  end
  local function v29(v60, v61, v62)
    local v63 = v60[1]
    local v64 = v60[2]
    local v65 = v60[3]
    return function(...)
      local v71 = v63
      local v72 = v64
      local v73 = v65
      local v74 = v27
      local v75 = 1
      local v76 = -1
      local v77 = {}
      local v78 = {...}
      local v79 = v12("#", ...) - 1
      local v80 = {}
      local v81 = {}
      for v113 = 0, v79 do
        if (v113 >= v73) then
          v77[v113 - v73] = v78[v113 + 1]
        else
          v81[v113] = v78[v113 + 1]
        end
      end
      local v83
      local v84
      while true do
        v83 = v71[v75]
        v84 = v83[1]
        if (true and (v84 <= 26)) then
          if (v84 <= 12) then
            if (v84 <= 5) then
              if (v84 <= 2) then
                if ((v84 <= 0) or false) then
                  if (true and v81[v83[2]]) then
                    v75 = v75 + 1 + 0 + 0
                  else
                    v75 = v83[3]
                  end
                elseif (v84 > 1) then
                  v81[v83[2]] = {}
                else
                  local v156 = 0
                  local v157
                  while true do
                    if (true and (v156 == 0)) then
                      v157 = v83[2]
                      return v81[v157](v13(v81, v157 + 1, v83[3]))
                      break
                    end
                  end
                end
              elseif (true and (v84 <= 3)) then
                local v130 = v83[3]
                local v131 = v81[v130]
                for v150 = v130 + 1, v83[4] do
                  v131 = v131 .. v81[v150]
                end
                v81[v83[2]] = v131
              elseif (v84 == 4) then
                v81[v83[2]] = #v81[v83[3]]
              else
                local v159 = 0
                local v160
                local v161
                local v162
                while true do
                  if (true and (v159 == 1)) then
                    v162 = v81[v160 + 2]
                    if (v162 > 0) then
                      if (v161 > v81[v160 + 1]) then
                        v75 = v83[3]
                      else
                        v81[v160 + 1 + 2] = v161
                      end
                    elseif (v161 < v81[v160 + 1 + 0]) then
                      v75 = v83[3]
                    else
                      v81[v160 + 3] = v161
                    end
                    break
                  end
                  if (v159 == 0) then
                    v160 = v83[2]
                    v161 = v81[v160]
                    v159 = 1
                  end
                end
              end
            elseif (v84 <= 8) then
              if (v84 <= 6) then
                v81[v83[2]] = v61[v83[3]]
              elseif (v84 == 7) then
                v81[v83[2]] = v81[v83[3]] * v81[v83[4]]
              else
                return v81[v83[2]]
              end
            elseif (v84 <= 10) then
              if (v84 == 9) then
                for v367 = v83[2], v83[3] do
                  v81[v367] = nil
                end
              else
                v81[v83[2]] = v81[v83[3]] + v83[4]
              end
            elseif (v84 > 11) then
              local v165 = v83[2]
              local v166 = v81[v165 + 2]
              local v167 = v81[v165] + v166
              v81[v165] = v167
              if (v166 > 0) then
                if (v167 <= v81[v165 + 1]) then
                  v75 = v83[3]
                  v81[v165 + 1 + 2] = v167
                end
              elseif (v167 >= v81[v165 + 1]) then
                v75 = v83[3]
                v81[v165 + 3] = v167
              end
            else
              v81[v83[2]] = v29(v72[v83[3]], nil, v62)
            end
          elseif ((v84 <= 19) or false) then
            if (v84 <= 15) then
              if (v84 <= 13) then
                v81[v83[2]] = v81[v83[3]][v83[4]]
              elseif (true and (v84 > 14)) then
                v75 = v83[3]
              else
                v81[v83[2]] = v81[v83[3]]
              end
            elseif (v84 <= 17) then
              if (v84 == 16) then
                if (v81[v83[2]] == v83[4]) then
                  v75 = v75 + 1 + 0
                else
                  v75 = v83[3]
                end
              else
                local v173 = 0
                local v174
                while true do
                  if (v173 == 0) then
                    v174 = v83[2]
                    return v13(v81, v174, v174 + v83[3])
                    break
                  end
                end
              end
            elseif (v84 > 18) then
              v81[v83[2]] = v83[3]
            else
              local v177 = 0
              local v178
              while true do
                if (true and (v177 == 0)) then
                  v178 = v83[2]
                  return v13(v81, v178, v76)
                  break
                end
              end
            end
          elseif (v84 <= 22) then
            if (v84 <= 20) then
              return
            elseif (v84 > 21) then
              v62[v83[3]] = v81[v83[2]]
            else
              local v181
              local v182, v183
              local v184
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v61[v83[3]]
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v81[v83[2]] = v61[v83[3]]
              v75 = v75 + 1 + 0 + 0
              v83 = v71[v75]
              v81[v83[2]] = v61[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v61[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]] + v83[4]
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v182, v183 = v74(v81[v184](v13(v81, v184 + 1 + 0, v83[3])))
              v76 = (v183 + v184) - 1
              v181 = 0
              for v369 = v184, v76 do
                v181 = v181 + 1
                v81[v369] = v182[v181]
              end
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v81[v184] = v81[v184](v13(v81, v184 + 1, v76))
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v81[v83[2]] = v61[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v61[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v81[v83[2]] = #v81[v83[3]]
              v75 = v75 + 1 + 0 + 0
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]] % v81[v83[4]]
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v81[v83[2]] = v83[3] + v81[v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = #v81[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]] % v81[v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v83[3] + v81[v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]] + v83[4]
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v182, v183 = v74(v81[v184](v13(v81, v184 + 1 + 0, v83[3])))
              v76 = (v183 + v184) - 1
              v181 = 0
              for v372 = v184, v76 do
                v181 = v181 + 1
                v81[v372] = v182[v181]
              end
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v182, v183 = v74(v81[v184](v13(v81, v184 + 1, v76)))
              v76 = (v183 + v184) - 1
              v181 = 0
              for v375 = v184, v76 do
                v181 = v181 + 1 + 0 + 0
                v81[v375] = v182[v181]
              end
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v81[v184] = v81[v184](v13(v81, v184 + 1, v76))
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]] % v83[4]
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v182, v183 = v74(v81[v184](v81[v184 + 1 + 0]))
              v76 = (v183 + v184) - 1
              v181 = 0
              for v378 = v184, v76 do
                local v379 = 0
                while true do
                  if (v379 == 0) then
                    v181 = v181 + 1
                    v81[v378] = v182[v181]
                    break
                  end
                end
              end
              v75 = v75 + 1
              v83 = v71[v75]
              v184 = v83[2]
              v81[v184](v13(v81, v184 + 1 + 0, v76))
            end
          elseif ((v84 <= 24) or false) then
            if ((v84 == 23) or false) then
              v81[v83[2]] = {}
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v62[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]][v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v62[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]][v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v62[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]][v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v62[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              if not v81[v83[2]] then
                v75 = v75 + 1
              else
                v75 = v83[3]
              end
            else
              v81[v83[2]] = v81[v83[3]] % v81[v83[4]]
            end
          elseif (v84 > 25) then
            local v227 = v83[2]
            v81[v227] = v81[v227](v81[v227 + 1])
          else
            local v229
            local v230
            local v231
            v81[v83[2]] = v81[v83[3]]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v83[3]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v81[v83[3]]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v83[3]
            v75 = v75 + 1
            v83 = v71[v75]
            v231 = v83[2]
            v230 = v81[v231]
            v229 = v81[v231 + 2 + 0]
            if (v229 > 0) then
              if (v230 > v81[v231 + 1 + 0 + 0]) then
                v75 = v83[3]
              else
                v81[v231 + 3] = v230
              end
            elseif (v230 < v81[v231 + 1 + 0]) then
              v75 = v83[3]
            else
              v81[v231 + 2 + 1] = v230
            end
          end
        elseif ((v84 <= 40) or false) then
          if (true and (v84 <= 33)) then
            if (v84 <= 29) then
              if (v84 <= 27) then
                local v137 = v83[2]
                v81[v137](v13(v81, v137 + 1, v76))
              elseif (v84 > 28) then
                local v242
                local v243
                local v244
                v62[v83[3]] = v81[v83[2]]
                v75 = v75 + 1
                v83 = v71[v75]
                v81[v83[2]] = v62[v83[3]]
                v75 = v75 + 1 + 0
                v83 = v71[v75]
                v81[v83[2]] = v81[v83[3]][v83[4]]
                v75 = v75 + 1
                v83 = v71[v75]
                v81[v83[2]] = v81[v83[3]][v81[v83[4]]]
                v75 = v75 + 1
                v83 = v71[v75]
                v81[v83[2]] = v83[3]
                v75 = v75 + 1
                v83 = v71[v75]
                v244 = v83[2]
                v81[v244] = v81[v244](v81[v244 + 1])
                v75 = v75 + 1
                v83 = v71[v75]
                v81[v83[2]] = v62[v83[3]]
                v75 = v75 + 1
                v83 = v71[v75]
                v81[v83[2]] = v81[v83[3]]
                v75 = v75 + 1
                v83 = v71[v75]
                v244 = v83[2]
                v243 = {v81[v244](v81[v244 + 1])}
                v242 = 0
                for v380 = v244, v83[4] do
                  local v381 = 0
                  while true do
                    if (v381 == 0) then
                      v242 = v242 + 1
                      v81[v380] = v243[v242]
                      break
                    end
                  end
                end
                v75 = v75 + 1
                v83 = v71[v75]
                v75 = v83[3]
              else
                local v263 = v83[2]
                local v264, v265 = v74(v81[v263](v13(v81, v263 + 1, v76)))
                v76 = (v265 + v263) - 1
                local v266 = 0
                for v382 = v263, v76 do
                  v266 = v266 + 1
                  v81[v382] = v264[v266]
                end
              end
            elseif (true and (v84 <= 31)) then
              if (v84 == 30) then
                v81[v83[2]][v81[v83[3]]] = v83[4]
              else
                local v269 = 0
                local v270
                local v271
                local v272
                local v273
                local v274
                local v275
                while true do
                  if ((v269 == 2) or false) then
                    v83 = v71[v75]
                    v81[v83[2]] = v62[v83[3]]
                    v75 = v75 + 1
                    v83 = v71[v75]
                    v81[v83[2]] = v81[v83[3]][v83[4]]
                    v269 = 3
                  end
                  if (v269 == 5) then
                    v75 = v75 + 1
                    v83 = v71[v75]
                    v275 = v83[2]
                    v81[v275] = v81[v275](v13(v81, v275 + 1 + 0, v76))
                    v75 = v75 + 1
                    v269 = 6
                  end
                  if (true and (v269 == 7)) then
                    v271 = v81[v275]
                    v270 = v81[v275 + 2]
                    if (true and (v270 > 0)) then
                      if (v271 > v81[v275 + 1]) then
                        v75 = v83[3]
                      else
                        v81[v275 + 3] = v271
                      end
                    elseif (v271 < v81[v275 + 1]) then
                      v75 = v83[3]
                    else
                      v81[v275 + 3] = v271
                    end
                    break
                  end
                  if (v269 == 6) then
                    v83 = v71[v75]
                    v81[v83[2]] = v83[3]
                    v75 = v75 + 1 + 0
                    v83 = v71[v75]
                    v275 = v83[2]
                    v269 = 7
                  end
                  if ((v269 == 0) or false) then
                    v270 = nil
                    v271 = nil
                    v272 = nil
                    v273, v274 = nil
                    v275 = nil
                    v269 = 1
                  end
                  if (v269 == 1) then
                    v81[v83[2]] = v62[v83[3]]
                    v75 = v75 + 1
                    v83 = v71[v75]
                    v81[v83[2]] = v81[v83[3]][v83[4]]
                    v75 = v75 + 1
                    v269 = 2
                  end
                  if (v269 == 4) then
                    v275 = v83[2]
                    v273, v274 = v74(v81[v275](v81[v275 + 1]))
                    v76 = (v274 + v275) - 1
                    v272 = 0
                    for v461 = v275, v76 do
                      v272 = v272 + 1
                      v81[v461] = v273[v272]
                    end
                    v269 = 5
                  end
                  if (v269 == 3) then
                    v75 = v75 + 1 + 0
                    v83 = v71[v75]
                    v81[v83[2]] = v81[v83[3]]
                    v75 = v75 + 1 + 0
                    v83 = v71[v75]
                    v269 = 4
                  end
                end
              end
            elseif (v84 > 32) then
              v81[v83[2]] = v81[v83[3]] % v83[4]
            else
              local v277 = v83[2]
              local v278, v279 = v74(v81[v277](v13(v81, v277 + 1, v83[3])))
              v76 = (v279 + v277) - 1
              local v280 = 0
              for v385 = v277, v76 do
                v280 = v280 + 1
                v81[v385] = v278[v280]
              end
            end
          elseif (v84 <= 36) then
            if (v84 <= 34) then
              v81[v83[2]] = v83[3] ~= 0
            elseif (true and (v84 > 35)) then
              if (v83[2] == v81[v83[4]]) then
                v75 = v75 + 1
              else
                v75 = v83[3]
              end
            else
              v81[v83[2]] = v83[3] + v81[v83[4]]
            end
          elseif (v84 <= 38) then
            if (v84 == 37) then
              local v282 = 0
              local v283
              local v284
              local v285
              while true do
                if (2 == v282) then
                  for v464 = 1, v83[4] do
                    v75 = v75 + 1
                    local v465 = v71[v75]
                    if (v465[1] == 14) then
                      v285[v464 - 1] = {v81, v465[3]}
                    else
                      v285[v464 - 1] = {v61, v465[3]}
                    end
                    v80[#v80 + 1 + 0] = v285
                  end
                  v81[v83[2]] = v29(v283, v284, v62)
                  break
                end
                if (v282 == 1) then
                  v285 = {}
                  v284 = v10({}, {
                    __index = function(v467, v468)
                    local v469 = v285[v468]
                    return v469[1][v469[2]]
                  end,
                    __newindex = function(v470, v471, v472)
                    local v473 = v285[v471]
                    v473[1][v473[2]] = v472
                  end
                  })
                  v282 = 2
                end
                if ((v282 == 0) or false) then
                  v283 = v72[v83[3]]
                  v284 = nil
                  v282 = 1
                end
              end
            else
              local v286
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1
              v83 = v71[v75]
              v286 = v83[2]
              v81[v286] = v81[v286](v13(v81, v286 + 1, v83[3]))
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]][v83[3]] = v81[v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1 + 0
              v83 = v71[v75]
              v286 = v83[2]
              v81[v286] = v81[v286](v13(v81, v286 + 1, v83[3]))
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]][v83[3]] = v81[v83[4]]
            end
          elseif ((v84 > 39) or false) then
            local v303
            v81[v83[2]] = v83[3]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v83[3]
            v75 = v75 + 1
            v83 = v71[v75]
            v303 = v83[2]
            v81[v303] = v81[v303](v13(v81, v303 + 1 + 0, v83[3]))
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]][v83[3]] = v81[v83[4]]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v81[v83[3]]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v83[3]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v83[3]
            v75 = v75 + 1
            v83 = v71[v75]
            v303 = v83[2]
            v81[v303] = v81[v303](v13(v81, v303 + 1, v83[3]))
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]][v83[3]] = v81[v83[4]]
            v75 = v75 + 1
            v83 = v71[v75]
            v81[v83[2]] = v81[v83[3]]
          else
            local v324 = v83[2]
            v81[v324] = v81[v324](v13(v81, v324 + 1, v83[3]))
          end
        elseif ((v84 <= 47) or false) then
          if (true and (v84 <= 43)) then
            if ((v84 <= 41) or false) then
              local v139 = v83[2]
              local v140, v141 = v74(v81[v139](v81[v139 + 1 + 0]))
              v76 = (v141 + v139) - 1
              local v142 = 0
              for v151 = v139, v76 do
                v142 = v142 + 1
                v81[v151] = v140[v142]
              end
            elseif (v84 == 42) then
              local v326
              v81[v83[2]] = v83[3]
              v75 = v75 + 1
              v83 = v71[v75]
              v326 = v83[2]
              v81[v326] = v81[v326](v13(v81, v326 + 1, v83[3]))
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]][v83[3]] = v81[v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v81[v83[3]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1
              v83 = v71[v75]
              v326 = v83[2]
              v81[v326] = v81[v326](v13(v81, v326 + 1 + 0, v83[3]))
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]][v83[3]] = v81[v83[4]]
              v75 = v75 + 1
              v83 = v71[v75]
              v81[v83[2]] = v83[3]
              v75 = v75 + 1
              v83 = v71[v75]
              for v388 = v83[2], v83[3] do
                v81[v388] = nil
              end
            else
              v81[v83[2]][v81[v83[3]]] = v81[v83[4]]
            end
          elseif (v84 <= 45) then
            if (v84 == 44) then
              if not v81[v83[2]] then
                v75 = v75 + 1
              else
                v75 = v83[3]
              end
            else
              local v346 = 0
              local v347
              local v348
              local v349
              while true do
                if (1 == v346) then
                  v75 = v75 + 1
                  v83 = v71[v75]
                  v81[v83[2]] = v83[3]
                  v75 = v75 + 1
                  v346 = 2
                end
                if (v346 == 2) then
                  v83 = v71[v75]
                  v81[v83[2]] = #v81[v83[3]]
                  v75 = v75 + 1
                  v83 = v71[v75]
                  v346 = 3
                end
                if (v346 == 4) then
                  v348 = v81[v349]
                  v347 = v81[v349 + 2]
                  if (v347 > 0) then
                    if (v348 > v81[v349 + 1]) then
                      v75 = v83[3]
                    else
                      v81[v349 + 2 + 1] = v348
                    end
                  elseif ((v348 < v81[v349 + 1]) or false) then
                    v75 = v83[3]
                  else
                    v81[v349 + 3] = v348
                  end
                  break
                end
                if (v346 == 0) then
                  v347 = nil
                  v348 = nil
                  v349 = nil
                  v81[v83[2]] = {}
                  v346 = 1
                end
                if (3 == v346) then
                  v81[v83[2]] = v83[3]
                  v75 = v75 + 1
                  v83 = v71[v75]
                  v349 = v83[2]
                  v346 = 4
                end
              end
            end
          elseif (true and (v84 > 46)) then
            local v350 = v83[2]
            local v351 = {v81[v350](v81[v350 + 1])}
            local v352 = 0
            for v390 = v350, v83[4] do
              local v391 = 0
              while true do
                if (true and (v391 == 0)) then
                  v352 = v352 + 1
                  v81[v390] = v351[v352]
                  break
                end
              end
            end
          else
            local v353 = v83[2]
            local v354 = v83[4]
            local v355 = v353 + 2
            local v356 = {v81[v353](v81[v353 + 1], v81[v355])}
            for v392 = 1, v354 do
              v81[v355 + v392] = v356[v392]
            end
            local v357 = v356[1]
            if v357 then
              v81[v355] = v357
              v75 = v83[3]
            else
              v75 = v75 + 1
            end
          end
        elseif ((v84 <= 50) or false) then
          if ((v84 <= 48) or false) then
            local v143 = v83[2]
            v81[v143] = v81[v143](v13(v81, v143 + 1, v76))
          elseif (v84 > 49) then
            v81[v83[2]] = v83[3] ~= 0
            v75 = v75 + 1
          else
            v81[v83[2]] = v62[v83[3]]
          end
        elseif (v84 <= 52) then
          if ((v84 > 51) or false) then
            v81[v83[2]] = v81[v83[3]][v81[v83[4]]]
          elseif (v81[v83[2]] < v81[v83[4]]) then
            v75 = v75 + 1
          else
            v75 = v83[3]
          end
        elseif ((v84 == 53) or false) then
          v81[v83[2]][v83[3]] = v81[v83[4]]
        else
          local v365 = 0
          local v366
          while true do
            if (0 == v365) then
              v366 = v83[2]
              v81[v366](v81[v366 + 1])
              break
            end
          end
        end
        v75 = v75 + 1
      end
    end
  end
  return v29(v28(), {}, v17)(...)
end
return v15("LOL!293Q0003063Q00737472696E6703043Q006368617203043Q00627974652Q033Q0073756203053Q0062697433322Q033Q0062697403043Q0062786F7203053Q007461626C6503063Q00636F6E63617403063Q00696E73657274026Q001C4003043Q003DD3398D03043Q00E849A14C026Q00184003163Q00E33330A6CAA58B3325E0CBB9C83D33E39EA8CE2F33B903063Q00CAAB5C4786BE026Q001440030D3Q0032A8823ADC42BC8422D706E0CB03053Q00B962DAEB57026Q00104003153Q00AFCAD21C0714B3C5E80F102AA8CCC41E0A2EB2C6C403063Q004BDCA3B76A62026Q00F03F03343Q0006454B035E2C4745406E165D50095B225A7F40422C454E40562A44520C50314C4E19152D4046051531414B1315365D50095B220803053Q003545292260028Q0003193Q00AF3856DCB33951DDA57A44C1A57A53C6AE3E59DDA9355EDAE103043Q00A9C05A30027Q0040026Q00084003053Q007072696E7403153Q0073696576655F6F665F657261746F737468656E657303023Q005F47025Q00407A4003053Q007061697273024Q00F0E4FD40026Q003440025Q00C05940023Q00406E9B5E41025Q005D3241024Q0087C6324100A14Q00177Q00122Q000100013Q00202Q00010001000200122Q000200013Q00202Q00020002000300122Q000300013Q00202Q00030003000400122Q000400053Q00062Q0004000B0001000100040F3Q000B0001001231000400063Q00200D000500040007001231000600083Q00200D000600060009001231000700083Q00200D00070007000A00062500083Q000100062Q000E3Q00074Q000E3Q00014Q000E3Q00054Q000E3Q00024Q000E3Q00034Q000E3Q00064Q0026000900083Q00122Q000A000C3Q00122Q000B000D6Q0009000B000200104Q000B00094Q000900083Q00122Q000A000F3Q00122Q000B00106Q0009000B000200104Q000E00092Q0026000900083Q00122Q000A00123Q00122Q000B00136Q0009000B000200104Q001100094Q000900083Q00122Q000A00153Q00122Q000B00166Q0009000B000200104Q001400092Q0026000900083Q00122Q000A00183Q00122Q000B00196Q0009000B000200104Q001700094Q000900083Q00122Q000A001B3Q00122Q000B001C6Q0009000B000200104Q001A00090012130009001A4Q0009000A000E3Q0026100009003C0001001A00040F3Q003C0001001213000A001A4Q0009000B000B3Q001213000900173Q0026100009009B0001001D00040F3Q009B00012Q0009000E000E3Q002610000A00530001001E00040F3Q00530001001213000F001A3Q002610000F00460001001700040F3Q00460001001213000A00143Q00040F3Q00530001002610000F00420001001A00040F3Q0042000100102300100017000E000633000D004E0001001000040F3Q004E00010012310010001F3Q00200D00113Q001A2Q00360010000200010012310010001F3Q00200D00113Q00172Q0036001000020001001213000F00173Q00040F3Q00420001002610000A006D0001001400040F3Q006D000100020B000F00013Q00121D000F00203Q00122Q000F00213Q00202Q00103Q00144Q000F000F001000122Q001000226Q000F0002000200122Q001000236Q0011000F6Q00100002001200044Q0067000100062Q0014006700013Q00040F3Q006700010012310015001F3Q00200D00163Q00112Q000E001700134Q00030016001600172Q003600150002000100062E001000600001000200040F3Q00600001001231000F001F3Q00200D00103Q000E2Q0036000F0002000100040F3Q00A00001002610000A007B0001001A00040F3Q007B0001001213000F001A3Q000E24001700740001000F00040F3Q00740001001213000A00173Q00040F3Q007B0001002610000F00700001001A00040F3Q00700001001213000B00243Q00200A0010000B002500200A000B00100026001213000F00173Q00040F3Q00700001002610000A008C0001001D00040F3Q008C0001001213000F001A3Q002610000F00820001001700040F3Q00820001001213000A001E3Q00040F3Q008C0001002610000F007E0001001A00040F3Q007E0001001213000E00273Q000633000C008A0001000D00040F3Q008A00010012310010001F3Q00200D00113Q000B2Q0036001000020001001213000F00173Q00040F3Q007E0001002610000A003F0001001700040F3Q003F0001001213000F001A3Q002610000F00940001001A00040F3Q00940001001213000C00283Q001213000D00293Q001213000F00173Q002610000F008F0001001700040F3Q008F0001001213000A001D3Q00040F3Q003F000100040F3Q008F000100040F3Q003F000100040F3Q00A00001002610000900370001001700040F3Q003700012Q0009000C000D3Q0012130009001D3Q00040F3Q003700012Q00143Q00013Q00023Q00023Q00026Q00F03F026Q00704002264Q002D00025Q00122Q000300016Q00045Q00122Q000500013Q00042Q0003002100012Q000600076Q0015000800026Q000900016Q000A00026Q000B00036Q000C00046Q000D8Q000E00063Q00202Q000F000600014Q000C000F6Q000B3Q00024Q000C00036Q000D00046Q000E00016Q000F00016Q000F0006000F00102Q000F0001000F4Q001000016Q00100006001000102Q00100001001000202Q0010001000014Q000D00106Q000C8Q000A3Q000200202Q000A000A00024Q0009000A6Q00073Q000100040C0003000500012Q0006000300054Q000E000400024Q0001000300044Q001200036Q00143Q00017Q00073Q00028Q00026Q00F03F027Q004003043Q006D61746803053Q00666C2Q6F7203043Q0073717274010001333Q001213000100014Q0009000200023Q001213000300013Q000E24000100030001000300040F3Q00030001000E24000100140001000100040F3Q001400012Q000200046Q0019000200043Q00122Q000400026Q00055Q00122Q000600023Q00042Q000400130001000E24000200100001000700040F3Q001000012Q003200086Q0022000800014Q002B00020007000800040C0004000D0001001213000100023Q002610000100020001000200040F3Q00020001001213000400013Q002610000400170001000100040F3Q00170001001213000500033Q00121F000600043Q00202Q00060006000500122Q000700043Q00202Q0007000700064Q00088Q000700086Q00063Q000200122Q000700023Q00042Q0005002D00012Q003400090002000800062Q0009002C00013Q00040F3Q002C00012Q00070009000800082Q000E000A6Q000E000B00083Q0004050009002C000100201E0002000C000700040C0009002A000100040C0005002300012Q0008000200023Q00040F3Q0017000100040F3Q0002000100040F3Q0003000100040F3Q000200012Q00143Q00017Q00", v9(), ...)
