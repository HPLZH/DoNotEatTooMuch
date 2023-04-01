# 安装方法

## 通过Steam安装

1. 前往Steam创意工坊页面: <https://steamcommunity.com/sharedfiles/filedetails/?id=2955691787>
2. 点击页面上绿色的“订阅”按钮
3. 等待Steam自动下载这个mod

## 通过Git安装

注意: 通过这种方式安装的mod都带有开发版本标记

### 先决条件

1. 能够找到游戏的`mods`文件夹
2. 安装了Git
3. 会使用控制台/终端

### 初次安装

在对应版本的游戏的`mods`文件夹中执行以下命令:  
`git clone https://github.com/HPLZH/DoNotEatTooMuch.git`

或者:  
`git clone git@github.com:HPLZH/DoNotEatTooMuch.git`

### 更新

在`mods/DoNotEatTooMuch`文件夹中执行以下命令:  
`git pull`

### 移除开发版本标记

在`mods/DoNotEatTooMuch/modinfo.lua`顶部添加一行lua代码:  
`local release = true`
