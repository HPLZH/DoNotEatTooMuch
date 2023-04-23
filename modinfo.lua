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

除普通难度以外的所有难度的参数都未经充分测试
通过修改 (此mod)/scripts/difficulties/user.lua 修改自定义难度的参数
]]

--Who wrote this awesome mod?
author = "Li Zihan"

--A version number so you can ask people if they are running an old version of your mod.
version = "v1.5"

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

local function OptionInfo(description, data, hover)
    return { description = description, data = data, hover = hover }
end

local function Option(name, label, hover, options, default)
    return {
        name = name,
        label = label,
        hover = hover,
        options = options,
        default = default,
    }
end

local difficulties = {
    OptionInfo("自定义", "user"),
    OptionInfo("简单", "easy", "Easy"),
    OptionInfo("普通 (默认)", "normal", "Normal (Default)"),
    OptionInfo("困难", "hard", "Hard"),
    OptionInfo("困难+", "hard1", "Hard+"),
    OptionInfo("困难++", "hard2", "Hard++"),
    OptionInfo("疯狂", "hard3", "Crazy"),
    OptionInfo("死亡", "hard4", "Deadly"),
}

local languages = {
    OptionInfo("简体中文", "cn")
}

configuration_options = {
    Option("difficulty", "难度", "Difficulty", difficulties, "normal"),
    Option("language", "语言", "Language", languages, "cn")
}
