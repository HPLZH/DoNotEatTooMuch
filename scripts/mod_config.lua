return function (difficulty)
    local CONFIG = require("difficulties.generic")
    local OVERRIDES = require("difficulties.overrides")

    for key, value in pairs(OVERRIDES[difficulty]) do
        CONFIG[key] = value
    end

    return CONFIG
end