---
title: VIM常用操作
date: 2016-10-09 04:20:20
categories: liunx
tags: [liunx,vim]
---

### 前言
VIM编辑神器

### 配置VIM

[github搜索vim](https://github.com/search?utf8=%E2%9C%93&q=vim)

[vim插件安装](https://github.com/canbefree/spf13-vim)

### 常用

| 命令          | 解释         |
| ------------- |:-------------| 
| ^             | 跳到行首      |
| $             | 跳到行尾      |
| J             | 行合并       |
| &lt;Crtl+z &gt;     | 挂起vim,fg返回 | 
| daw   |删掉一个单词|
| <c-e>         | toggle NERDTREE|
| <c-w>         | switch NERDTREE |
| m [a-z] |标记文本(在当前文件搜索)|
| m [A-Z] |标记文本(在所有目录中查找)|
| ' [a-zA-Z] |跳转到标记|


:set mouse =c

### vim执行shell命令
|命令|解释|
|--|--|
|:! command|执行命令|
|：r !command |执行命令 结果粘贴到当前vim行|


#### tab操作
1. :tabc 关闭当前tab
2. :tabs 查看所有tab
3. :tabp | gT 切换到上一个tab
4. :tabn | gT 切换到下一个tab

#### split vsplit
split 接文件可以打开其他文件

crtl +w  h, j, k, l 可以左右切换
crtl +w r 可以调整布局


#### vim 查找目录下内容

vimgrep /匹配模式/[g][j] 要搜索的文件/范围 
g：表示是否把每一行的多个匹配结果都加入
j：表示是否搜索完后定位到第一个匹配位置
vimgrep /pattern/ %           在当前打开文件中查找
vimgrep /pattern/ *             在当前目录下查找所有
vimgrep /pattern/ **            在当前目录及子目录下查找所有
vimgrep /pattern/ *.c          查找当前目录下所有.c文件
vimgrep /pattern/ **/*         只查找子目录

cn                                          查找下一个
cp                                          查找上一个
copen                                    打开quickfix
cw                                          打开quickfix
cclose                                   关闭qucikfix
help vimgrep                       查看vimgrep帮助


#### surround
cs " ' 替换 "" 为 ''
ds "  删除 ""
ysiw] 加上[]

#### ctags 使用
sudo yum install ctags

<c-]> 跳转到定义
<c-o|t> 跳转回去
gd    查找当前关键字

#### nerdtree

shift-R 刷新列表

#### neocomplete
tab 选择
ctrl+n ctrl+p 前后选择

#### cscope使用
sudo yum install cscope

对于C代码：
cscope -Rqb

 :cs add cscope.out
 

#### CtrlP
 	按F5清除当前目录的缓冲以便获取新文件，移除被删掉的文件以及应用新的忽略选项。
    按<ctrl-f>和<ctrl-b>在两种模式间循环
    按<ctrl-d>切换到仅搜索文件名而不是完整路径
    按<ctrl-r>切换到正则表达式模式
    使用<ctrl-j>，<ctrl-k>或者方向键在结果列表移动
    使用<ctrl-t>或<ctrl-v>,<ctrl-x>以新表，新窗口分割方式打开选定项
    使用<ctrl-n>,<ctrl-p>在历史记录里选择上一项或下一项
    使用<ctrl-y>来创建新文件和它的父目录
    使用<ctrl-z>来标记（取消标记）多个文件，使用<ctrl-o>来打开它们

### 图例

{% asset_link vim.png  %}


### 复制粘贴

shift + insert 复制系统粘贴
set clipboard=unamedplusset clipboard=unamedplus

