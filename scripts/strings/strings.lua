local function LoadValues(k, v, namespace)
    if type(v) == "table" then
        if namespace[k] == nil then
            namespace[k] = {}
        end
        for k1, v1 in pairs(v) do
            LoadValues(k1, v1, namespace[k])
        end
    else
        namespace[k] = v
    end
end

local function LoadModules(k, v, namespace, fpath)
    if type(v) == "table" then
        if namespace[k] == nil then
            namespace[k] = {}
        end
        for k1, v1 in pairs(v) do
            LoadModules(k1, v1, namespace[k], fpath)
        end
    else
        LoadValues(k, require(fpath(v)), namespace)
    end
end

function LoadStrings(lang)
    local basePath = "strings/" .. lang .. "/"
    local modules = require("strings.modules")
    local link = function(v)
        return basePath .. v
    end
    for k, v in pairs(modules) do
        LoadModules(k, v, STRINGS, link)
    end
end

return LoadStrings
