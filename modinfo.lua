--The name of the mod displayed in the 'mods' screen.
name = "不要撑死"

if release then
else
    name = name .. "(dev)"
end

--A description of the mod.
description = [[
吃过多的食物会带来负面效果，还有可能会被撑死。

源代码: https://github.com/HPLZH/DoNotEatTooMuch/

若要提出建议或报告问题，请使用此页面:
https://github.com/HPLZH/DoNotEatTooMuch/issues
]]

--Who wrote this awesome mod?
author = "Li Zihan"

--A version number so you can ask people if they are running an old version of your mod.
version = "v1.1"

-- DS
api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true

-- DST
api_version_dst = 10
dst_compatible = true
server_only_mod = false        -- true also ok
client_only_mod = false
all_clients_require_mod = true -- false also ok

forumthread = ""
