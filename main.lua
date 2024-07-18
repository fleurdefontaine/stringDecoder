local pattern = {
  rVar = "local%s+([%w_]+)%s*=",
  rFunc1 = "function%s+([%w_]+)%s*%(",
  rFunc2 = "local%s+function%s+([%w_]+)%s*%("
}

local Literals = {}

function checkLiterals(...)
    local args = {...}
    for _, v in pairs(args[2]) do
        for name in args[1]:gmatch(v) do
            Literals[name] = true
        end
    end
end

-- Example usage
local code = ([=[
local a = "tea"
local function declaredFunction()
end
print(string.char(table.unpack({97})))
print(string.char(table.unpack({104, 101, 108, 108, 111})))
print(string.char(table.unpack({100, 101, 99, 108, 97, 114, 101, 100, 86, 97, 114, 105, 97, 98, 108, 101})))
print(string.char(table.unpack({100, 101, 99, 108, 97, 114, 101, 100, 70, 117, 110, 99, 116, 105, 111, 110})))
]=])

checkLiterals(code, pattern)

local decode = function(...)
    return (...):gsub("string.char%s*%(%s*table.unpack%s*%(%s*{(.-)}%s*%)%s*%)",
        function(...)
            local args = {...}
            local asciiVal = {}
            local char = {}

            for n in args[1]:gmatch("%d+") do
                table.insert(asciiVal, n)
            end

            for k, v in next, asciiVal, nil do
                table.insert(char, string.char(v))
            end

            local res = table.concat(char)
            if Literals[res] then
                if (type(Literals[res]) == "function") then
                    return res .. "()"
                else
                    return res
                end
            else
                return '"' .. res .. '"'
            end
        end)
end

local out = decode(code)
print(out)