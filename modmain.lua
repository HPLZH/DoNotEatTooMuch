do
    local GLOBAL = GLOBAL
    local modEnv = GLOBAL.getfenv(1)
    local rawget, setmetatable = GLOBAL.rawget, GLOBAL.setmetatable
    setmetatable(modEnv, {
        __index = function(self, index)
            return rawget(GLOBAL, index)
        end
    })

    _G = GLOBAL
end

local _string, xpcall, package, tostring, print, os, unpack, require, getfenv, setmetatable, next, assert, tonumber, io, rawequal, collectgarbage, getmetatable, module, rawset, math, debug, pcall, table, newproxy, type, coroutine, _G, select, gcinfo, pairs, rawget, loadstring, ipairs, _VERSION, dofile, setfenv, load, error, loadfile =
    string, xpcall, package, tostring, print, os, unpack, require, getfenv, setmetatable, next, assert, tonumber, io,
    rawequal, collectgarbage, getmetatable, module, rawset, math, debug, pcall, table, newproxy, type, coroutine, _G,
    select,
    gcinfo, pairs, rawget, loadstring, ipairs, _VERSION, dofile, setfenv, load, error, loadfile
local TheInput, TheInputProxy, TheGameService, TheShard, TheNet, FontManager, PostProcessor, TheItems, EnvelopeManager, TheRawImgui, ShadowManager, TheSystemService, TheInventory, MapLayerManager, RoadManager, TheLeaderboards, TheSim =
    TheInput, TheInputProxy, TheGameService, TheShard, TheNet, FontManager, PostProcessor, TheItems, EnvelopeManager,
    TheRawImgui, ShadowManager, TheSystemService, TheInventory, MapLayerManager, RoadManager, TheLeaderboards, TheSim

local DST = TheSim:GetGameID() == "DST"

GLOBAL.TUNING.DO_NOT_EAT_TOO_MUCH = require("mod_config")

require("strings.strings")
LoadStrings("cn")

AddComponentPostInit("hunger", require("modifiers.components.hunger"))
AddComponentPostInit("sanity", require("modifiers.components.sanity"))
AddComponentPostInit("health", require("modifiers.components.health"))
AddComponentPostInit("locomotor", require("modifiers.components.locomotor"))

if (not DST) or (TheNet ~= nil and TheNet:GetIsClient()) then
    AddClassPostConstruct("widgets/healthbadge", require("modifiers.widgets.healthbadge"))
end
