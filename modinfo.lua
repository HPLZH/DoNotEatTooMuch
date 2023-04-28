--The name of the mod displayed in the 'mods' screen.
name = "不要撑死"

if release then
else
    name = name .. "(dev)"
end

--A description of the mod.
description = [[
我们移除了饥饿值的上限
溢出的食物不再会被浪费
但是注意不要被撑死

源代码: https://github.com/HPLZH/DoNotEatTooMuch/
]]

--Who wrote this awesome mod?
author = "Li Zihan"

--A version number so you can ask people if they are running an old version of your mod.
version = "v1.8"

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

--Force enable English
--To use other languages, change "EN" to other strings.

--local locale = "EN"

local STRINGS = {
    CN = {
        DEFAULT_LANG = "cn",
        BASIC = "基本设置",
        VERSION = "版本",
        DIFFICULTY = "难度",
        DIFFICULTIES = {
            USER = "启用自定义参数",
            USER_D = "选择此难度后自定义参数才有效",
            EASY = "简单",
            NORMAL = "普通 (默认)",
            HARD = "困难",
            HARD1 = "困难+",
            HARD2 = "困难++",
            HARD3 = "疯狂",
            HARD4 = "死亡",
        },
        LANGUAGE = "语言",
        NOLANG = "无语言",
        USER_CONFIG = "自定义参数",
        CONFIG = {
            SANITY_RATE = "精神值下降速率",
            SANITY_MOVING_MULTIPLIER = "移动精神速率系数",
            HEALTH_RATE = "生命值下降速率",
            HEALTH_FREQ = "生命值下降频率",
            HEALTH_DROP_POINT = "危险临界点",
            HEALTH_RANDOM_DROP_POINT = "随机掉血点",
            HEALTH_DROP_STOP_POINT = "安全临界点",
            HEALTH_CURE_POINT = "状态恢复点",
            HEALTH_HURT_COUNT = "随机掉血最大计数",
            HUNGER_MOVING_MULTIPLIER = "移动食物速率系数",
            BASIC_MASS = "基础质量",
            SPEED_SANITY_MULTIPLIER_MIN = "最低换算精神值",
        },
        CONFIG_D = {
            SANITY_RATE = "精神值下降速率",
            SANITY_MOVING_MULTIPLIER = "移动中精神值下降速率系数",
            HEALTH_RATE = "生命值下降速率",
            HEALTH_FREQ = "生命值下降频率",
            HEALTH_DROP_POINT = "危险临界点",
            HEALTH_RANDOM_DROP_POINT = "随机掉血点",
            HEALTH_DROP_STOP_POINT = "安全临界点",
            HEALTH_CURE_POINT = "状态恢复点",
            HEALTH_HURT_COUNT = "随机掉血最大计数",
            HUNGER_MOVING_MULTIPLIER = "移动中食物消耗速率系数",
            BASIC_MASS = "基础质量",
            SPEED_SANITY_MULTIPLIER_MIN = "最低换算精神值",
        }
    },

    EN = {
        BASIC = "Basic",
        DIFFICULTY = "Difficulty",
        DIFFICULTIES = {
            USER = "Custom",
            USER_D = "Enable the custom parameters below",
            EASY = "Easy",
            NORMAL = "Normal (Default)",
            HARD = "Hard",
            HARD1 = "Hard+",
            HARD2 = "Hard++",
            HARD3 = "Crazy",
            HARD4 = "Deadly",
        },
        LANGUAGE = "Language",
        NOLANG = "No language",
        USER_CONFIG = "Custom Parameters",
        CONFIG = {
            SANITY_RATE = "精神值下降速率",
            SANITY_MOVING_MULTIPLIER = "移动精神速率系数",
            HEALTH_RATE = "生命值下降速率",
            HEALTH_FREQ = "生命值下降频率",
            HEALTH_DROP_POINT = "危险临界点",
            HEALTH_RANDOM_DROP_POINT = "随机掉血点",
            HEALTH_DROP_STOP_POINT = "安全临界点",
            HEALTH_CURE_POINT = "状态恢复点",
            HEALTH_HURT_COUNT = "随机掉血最大计数",
            HUNGER_MOVING_MULTIPLIER = "移动食物速率系数",
            BASIC_MASS = "基础质量",
            SPEED_SANITY_MULTIPLIER_MIN = "最低换算精神值",
        },
        CONFIG_D = {
            SANITY_RATE = "精神值下降速率",
            SANITY_MOVING_MULTIPLIER = "移动中精神值下降速率系数",
            HEALTH_RATE = "生命值下降速率",
            HEALTH_FREQ = "生命值下降频率",
            HEALTH_DROP_POINT = "危险临界点",
            HEALTH_RANDOM_DROP_POINT = "随机掉血点",
            HEALTH_DROP_STOP_POINT = "安全临界点",
            HEALTH_CURE_POINT = "状态恢复点",
            HEALTH_HURT_COUNT = "随机掉血最大计数",
            HUNGER_MOVING_MULTIPLIER = "移动中食物消耗速率系数",
            BASIC_MASS = "基础质量",
            SPEED_SANITY_MULTIPLIER_MIN = "最低换算精神值",
        }
    },

}

STRINGS.ZH = STRINGS.CN

local STR = locale ~= nil and STRINGS[locale:upper():sub(0, 2)] or STRINGS.CN

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

local function Header(label)
    return {
        name = "",
        label = label,
        options = { { description = "", data = "" } },
        default = "",
    }
end

local function numToOptionInfos(nums, count)
    r = {}
    for i = 1, count, 1 do
        r[i] = OptionInfo(nums[i], nums[i])
    end
    return r
end

local function percToOptionInfos(percs, count)
    r = {}
    for i = 1, count, 1 do
        r[i] = OptionInfo(percs[i] * 100 .. "%", percs[i])
    end
    return r
end

local difficulties = {
    OptionInfo(STR.DIFFICULTIES.USER, "user", STR.DIFFICULTIES.USER_D),
    OptionInfo(STR.DIFFICULTIES.EASY, "easy"),
    OptionInfo(STR.DIFFICULTIES.NORMAL, "normal"),
    OptionInfo(STR.DIFFICULTIES.HARD, "hard"),
    OptionInfo(STR.DIFFICULTIES.HARD1, "hard1"),
    OptionInfo(STR.DIFFICULTIES.HARD2, "hard2"),
    OptionInfo(STR.DIFFICULTIES.HARD3, "hard3"),
    OptionInfo(STR.DIFFICULTIES.HARD4, "hard4"),
}

local languages = {
    OptionInfo("? ? ?", "chars", STR.NOLANG),
    OptionInfo("简体中文", "cn"),
}

local numbers_0_10 = numToOptionInfos({
    0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,
    1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
    2, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9,
    3, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9,
    4, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9,
    5, 5.5,
    6, 6.5,
    7, 7.5,
    8, 8.5,
    9, 9.5,
    10,
}, 61)

local numbers_freq = numToOptionInfos({
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    15, 20, 25, 30, 35, 40, 45, 50, 55, 60
}, 20)

local numbers_mass = numToOptionInfos({
    0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,
    1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
    2, 2.5,
    3, 3.5,
    4, 4.5,
    5, 6, 7, 8, 9, 10,
}, 31)

local numbers_1_20_i = numToOptionInfos({
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
}, 20)

local percents_0_2 = percToOptionInfos({
    0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09,
    0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19,
    0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29,
    0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39,
    0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49,
    0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59,
    0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69,
    0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79,
    0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89,
    0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99,
    1, 1.01, 1.02, 1.03, 1.04, 1.05, 1.06, 1.07, 1.08, 1.09,
    1.1, 1.11, 1.12, 1.13, 1.14, 1.15, 1.16, 1.17, 1.18, 1.19,
    1.2, 1.21, 1.22, 1.23, 1.24, 1.25, 1.26, 1.27, 1.28, 1.29,
    1.3, 1.31, 1.32, 1.33, 1.34, 1.35, 1.36, 1.37, 1.38, 1.39,
    1.4, 1.41, 1.42, 1.43, 1.44, 1.45, 1.46, 1.47, 1.48, 1.49,
    1.5, 1.51, 1.52, 1.53, 1.54, 1.55, 1.56, 1.57, 1.58, 1.59,
    1.6, 1.61, 1.62, 1.63, 1.64, 1.65, 1.66, 1.67, 1.68, 1.69,
    1.7, 1.71, 1.72, 1.73, 1.74, 1.75, 1.76, 1.77, 1.78, 1.79,
    1.8, 1.81, 1.82, 1.83, 1.84, 1.85, 1.86, 1.87, 1.88, 1.89,
    1.9, 1.91, 1.92, 1.93, 1.94, 1.95, 1.96, 1.97, 1.98, 1.99,
    2,
}, 201)

local percents_1_2 = percToOptionInfos({
    1, 1.01, 1.02, 1.03, 1.04, 1.05, 1.06, 1.07, 1.08, 1.09,
    1.1, 1.11, 1.12, 1.13, 1.14, 1.15, 1.16, 1.17, 1.18, 1.19,
    1.2, 1.21, 1.22, 1.23, 1.24, 1.25, 1.26, 1.27, 1.28, 1.29,
    1.3, 1.31, 1.32, 1.33, 1.34, 1.35, 1.36, 1.37, 1.38, 1.39,
    1.4, 1.41, 1.42, 1.43, 1.44, 1.45, 1.46, 1.47, 1.48, 1.49,
    1.5, 1.51, 1.52, 1.53, 1.54, 1.55, 1.56, 1.57, 1.58, 1.59,
    1.6, 1.61, 1.62, 1.63, 1.64, 1.65, 1.66, 1.67, 1.68, 1.69,
    1.7, 1.71, 1.72, 1.73, 1.74, 1.75, 1.76, 1.77, 1.78, 1.79,
    1.8, 1.81, 1.82, 1.83, 1.84, 1.85, 1.86, 1.87, 1.88, 1.89,
    1.9, 1.91, 1.92, 1.93, 1.94, 1.95, 1.96, 1.97, 1.98, 1.99,
    2,
}, 101)

local percents_p1_1 = percToOptionInfos({
    0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09,
    0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19,
    0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29,
    0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39,
    0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49,
    0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59,
    0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69,
    0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79,
    0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89,
    0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99,
    1,
}, 100)

if folder_name then
    configuration_options = {
        Header(STR.BASIC),
        Option("", STR.VERSION, nil, { { description = version, data = "" } }, ""),
        Option("difficulty", STR.DIFFICULTY, nil, difficulties, "normal"),
        Option("language", STR.LANGUAGE, "Language", languages, STR.DEFAULT_LANG),
        Header(STR.USER_CONFIG),
        Option("SANITY_RATE", STR.CONFIG.SANITY_RATE, STR.CONFIG_D.SANITY_RATE, numbers_0_10, 1),
        Option("SANITY_MOVING_MULTIPLIER", STR.CONFIG.SANITY_MOVING_MULTIPLIER, STR.CONFIG_D.SANITY_MOVING_MULTIPLIER,
            percents_1_2, 1.2),
        Option("HEALTH_RATE", STR.CONFIG.HEALTH_RATE, STR.CONFIG_D.HEALTH_RATE, numbers_0_10, 1),
        Option("HEALTH_FREQ", STR.CONFIG.HEALTH_FREQ, STR.CONFIG_D.HEALTH_FREQ, numbers_freq, 10),
        Option("HEALTH_DROP_POINT", STR.CONFIG.HEALTH_DROP_POINT, STR.CONFIG_D.HEALTH_DROP_POINT, percents_1_2, 1.5),
        Option("HEALTH_RANDOM_DROP_POINT", STR.CONFIG.HEALTH_RANDOM_DROP_POINT, STR.CONFIG_D.HEALTH_RANDOM_DROP_POINT,
            percents_1_2, 1.2),
        Option("HEALTH_DROP_STOP_POINT", STR.CONFIG.HEALTH_DROP_STOP_POINT, STR.CONFIG_D.HEALTH_DROP_STOP_POINT,
            percents_0_2, 0.9),
        Option("HEALTH_CURE_POINT", STR.CONFIG.HEALTH_CURE_POINT, STR.CONFIG_D.HEALTH_CURE_POINT, percents_0_2, 0.8),
        Option("HEALTH_HURT_COUNT", STR.CONFIG.HEALTH_HURT_COUNT, STR.CONFIG_D.HEALTH_HURT_COUNT, numbers_1_20_i, 10),
        Option("HUNGER_MOVING_MULTIPLIER", STR.CONFIG.HUNGER_MOVING_MULTIPLIER, STR.CONFIG_D.HUNGER_MOVING_MULTIPLIER,
            percents_0_2, 1.2),
        Option("BASIC_MASS", STR.CONFIG.BASIC_MASS, STR.CONFIG_D.BASIC_MASS, numbers_mass, 1),
        Option("SPEED_SANITY_MULTIPLIER_MIN", STR.CONFIG.SPEED_SANITY_MULTIPLIER_MIN,
            STR.CONFIG_D.SPEED_SANITY_MULTIPLIER_MIN, percents_p1_1, 0.8),
    }
else
    configuration_options = {
        Option("", STR.VERSION, nil, { { description = version, data = "" } }, ""),
        Option("difficulty", STR.DIFFICULTY, nil, difficulties, "normal"),
        Option("language", STR.LANGUAGE, "Language", languages, STR.DEFAULT_LANG),
        Option("SANITY_RATE", STR.CONFIG.SANITY_RATE, STR.CONFIG_D.SANITY_RATE, numbers_0_10, 1),
        Option("SANITY_MOVING_MULTIPLIER", STR.CONFIG.SANITY_MOVING_MULTIPLIER, STR.CONFIG_D.SANITY_MOVING_MULTIPLIER,
            percents_1_2, 1.2),
        Option("HEALTH_RATE", STR.CONFIG.HEALTH_RATE, STR.CONFIG_D.HEALTH_RATE, numbers_0_10, 1),
        Option("HEALTH_FREQ", STR.CONFIG.HEALTH_FREQ, STR.CONFIG_D.HEALTH_FREQ, numbers_freq, 10),
        Option("HEALTH_DROP_POINT", STR.CONFIG.HEALTH_DROP_POINT, STR.CONFIG_D.HEALTH_DROP_POINT, percents_1_2, 1.5),
        Option("HEALTH_RANDOM_DROP_POINT", STR.CONFIG.HEALTH_RANDOM_DROP_POINT, STR.CONFIG_D.HEALTH_RANDOM_DROP_POINT,
            percents_1_2, 1.2),
        Option("HEALTH_DROP_STOP_POINT", STR.CONFIG.HEALTH_DROP_STOP_POINT, STR.CONFIG_D.HEALTH_DROP_STOP_POINT,
            percents_0_2, 0.9),
        Option("HEALTH_CURE_POINT", STR.CONFIG.HEALTH_CURE_POINT, STR.CONFIG_D.HEALTH_CURE_POINT, percents_0_2, 0.8),
        Option("HEALTH_HURT_COUNT", STR.CONFIG.HEALTH_HURT_COUNT, STR.CONFIG_D.HEALTH_HURT_COUNT, numbers_1_20_i, 10),
        Option("HUNGER_MOVING_MULTIPLIER", STR.CONFIG.HUNGER_MOVING_MULTIPLIER, STR.CONFIG_D.HUNGER_MOVING_MULTIPLIER,
            percents_0_2, 1.2),
        Option("BASIC_MASS", STR.CONFIG.BASIC_MASS, STR.CONFIG_D.BASIC_MASS, numbers_mass, 1),
        Option("SPEED_SANITY_MULTIPLIER_MIN", STR.CONFIG.SPEED_SANITY_MULTIPLIER_MIN,
            STR.CONFIG_D.SPEED_SANITY_MULTIPLIER_MIN, percents_p1_1, 0.8),
    }
end
