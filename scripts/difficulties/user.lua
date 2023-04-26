local GENERIC = require("difficulties.generic")
local USER = {}
for key, value in pairs(GENERIC) do
    USER[key] = GetModConfigData(key, TUNING.DO_NOT_EAT_TOO_MUCH_NAME)
end

return USER
