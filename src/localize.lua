-- https://springrts.com/wiki/Lua_Performance#TEST_1:_Localize
--[[
➜  Downloads time lua localize.lua 100000 no
lua localize.lua 100000 no  0.77s user 0.00s system 99% cpu 0.775 total
➜  Downloads time lua localize.lua 100000 yes
lua localize.lua 100000 yes  0.58s user 0.00s system 99% cpu 0.581 total
]]

local loop_count = tonumber(arg[1])

local t = {}
local r = {}
local math_random = math.random
for i = 1, 200 do
    t[i] = math_random()
end
for i = 1, 100 do
    r[i] = 0
end

if "yes" == arg[2] then
    local math_min = math.min
    for j = 1, loop_count do
        for i = 1, 100 do
            r[i] = math_min(t[i], t[i * 2])
        end
    end
else
    for j = 1, loop_count do
        for i = 1, 100 do
            r[i] = math.min(t[i], t[i * 2])
        end
    end
end


