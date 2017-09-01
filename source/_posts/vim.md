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
:set mouse =c

#### tab操作
1. :tabc 关闭当前tab
2. :tabs 查看所有tab
3. :tabp | gT 切换到上一个tab
4. :tabn | gT 切换到下一个tab

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


#### ctags 使用
sudo yum install ctags

<c-]> 跳转到定义
<c-o|t> 跳转回去
gd    查找当前关键字


#### cscope使用
sudo yum install cscope

对于C代码：
cscope -Rqb

 :cs add cscope.out
 

### 图例

{% asset_link vim.png  %}


### 复制粘贴

shift + insert 复制系统粘贴
set clipboard=unamedplusset clipboard=unamedplus

