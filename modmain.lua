local require = GLOBAL.require
GLOBAL.TUNING.DO_NOT_EAT_TOO_MUCH_NAME = modname
local CONFIG = require("mod_config")
local difficulty = GetModConfigData("difficulty")
local language = GetModConfigData("language")
GLOBAL.TUNING.DO_NOT_EAT_TOO_MUCH = CONFIG(difficulty)

require("mod_tuning_override")

local LoadStrings = require("strings.strings")
LoadStrings(language)

AddComponentPostInit("hunger", require("modifiers.components.hunger"))
AddComponentPostInit("sanity", require("modifiers.components.sanity"))
AddComponentPostInit("health", require("modifiers.components.health"))
AddComponentPostInit("locomotor", require("modifiers.components.locomotor"))
AddPrefabPostInit("spoiled_food", require("modifiers.prefabs.spoiled"))
AddPrefabPostInit("rottenegg", require("modifiers.prefabs.spoiled"))
if (GLOBAL.TheSim.GetGameID ~= nil and GLOBAL.TheSim:GetGameID() == "DST") then
    AddPrefabPostInit("spoiled_fish", require("modifiers.prefabs.spoiled"))
    AddPrefabPostInit("spoiled_fish_small", require("modifiers.prefabs.spoiled"))
end
AddClassPostConstruct("widgets/healthbadge", require("modifiers.widgets.healthbadge"))
