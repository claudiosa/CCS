local n_trains   = 2
local n_stations = 3
local cost       = 10   -- the uniform cost simplifies the problem!

local ti = table.insert
local sf = string.format

local rules = {}

local function map(train, station)
    return string.char(64 + train) .. tostring(station)
end

local function gen_list(from, to)
    local l = {}
    if not from then from = 1 end
    if not to   then to   = n_stations end
    
    for t = 1, n_trains do
        for s = from, to do
            ti(l, map(t, s))
        end
    end
    
    return l
end

local function limits()
    local list = table.concat(gen_list(), ',')
    ti(rules, sf('[%s] :: 0..10000', list))
end

local function delay()
    math.randomseed(os.time())

    for t = 1, n_trains do
        ti(rules, sf('%s #= %d', map(t, 1), math.random(0, 100) ))
    end
end

local function sequential()
    for train = 1, n_trains do
        for to = 2, n_stations do
            local s1 = map(train, to - 1)
            local s2 = map(train, to)
            ti(rules, sf('%s #>= %s + %d', s2, s1, cost))
        end
    end
end

local function disjunctive()
    local tl = math.ceil(n_trains / 2)
    
    for s = 1, n_stations - 1 do
        for t1 = 1, tl do
            for t2 = tl + 1, n_trains do
                local st1, st2 = s, n_stations - s
                local n1       = map(t1, st1)
                local n2       = map(t2, st2)
                ti(rules, sf('disjunctive([%s,%s],[%d,%d])', n1, n2, cost, cost))
            end
        end
    end
end

local function different_group(from, to, station)
    local l = {}
    
    for t = from, to do
        ti(l, map(t, station))
    end
    
    return sf( 'alldifferent([%s])', table.concat(l, ',') )
end

local function different()
    local tl = math.ceil(n_trains / 2)
    
    for s = 1, n_stations do
        if tl > 1 then
            ti( rules, different_group(1, tl, s)            )
        
            if n_trains - tl > 1 then
                ti( rules, different_group(tl + 1, n_trains, s) )
            end
        end
    end
end

local function minimize()
    local all = table.concat(gen_list(), ',')
    local l   = table.concat(gen_list(n_stations, n_stations), '+')
    
    local lower = n_trains * n_stations * (cost - 1)
    local upper = lower * 10
    
    local opt = sf('bb_options{strategy:dichotomic, from: %d, to: %d, timeout: 10}',
        lower, upper)
    
    ti(rules, sf('Cost #= %s', l))
    ti(rules, sf('bb_min(labeling([%s]), Cost, %s)', all, opt))
end

function output()
    local list = table.concat(gen_list(), ',')
    local res  = table.concat(rules, ',\n\t') .. '.'
    local out  = sf([[
:- lib(ic).
:- lib(ic_edge_finder3).
:- lib(branch_and_bound).

train([%s]) :-
%s%s
    ]], list, '\t', res)
    print(out)
end

-- ** main **

limits()
delay()
sequential()
disjunctive()
different()
minimize()
output()
