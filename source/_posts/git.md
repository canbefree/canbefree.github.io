---
title: GIT
date: 2016-10-09 10:56:37
categories: php
tags: [git,github]
---


#### fork别人的项目后如何保持同步更新

![git-pull-request](git-pull-request.jpg)

如图，颠倒下head即可

### 项目整洁
> 比如说有些大文件不小心comit上去了。我删掉他。但是每次检出代码的历史记录都会保留这个大的文件。如何确保这种情况不再发生

1.将最近4次提交合成一个
```bash
git rebase -i HEAD~4
```

2.有选择性的合并历史提交
$ git rebase -i <first_commit>

会进入一个如下所示的文件
  1 pick ba07c7d add bootstrap theme and format import
  2 pick 7d905b8 add newline at file last line
  3 pick 037313c fn up_first_char rename to caps
  4 pick 34e647e add fn of && use for index.jsp
  5 pick 0175f03 rename common include
  6 pick 7f3f665 update group name && update config

将想合并的提交的pick改成s，如
  1 pick ba07c7d add bootstrap theme and format import
  2 pick 7d905b8 add newline at file last line
  3 pick 037313c fn up_first_char rename to caps
  4 s 34e647e add fn of && use for index.jsp
  5 pick 0175f03 rename common include
  6 pick 7f3f665 update group name && update config

这样第四个提交就会合并进入第三个提交。
等合并完提交之后再运行
$ git push -f
$ git gc --prune=now