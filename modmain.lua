local require = GLOBAL.require
GLOBAL.TUNING.DO_NOT_EAT_TOO_MUCH = require("mod_config")

require("mod_tuning_override")

local LoadStrings = require("strings.strings")
LoadStrings("cn")

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
