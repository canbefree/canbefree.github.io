---
title: PHP疑难杂症
date: 2016-10-09 10:39:49
categories: php
tags:
    - php
---

记录一些简单 但是容易出错的。

### 绝对路径和相对路径
> 相对路径都是参考入口文件的。。。！！！！


### 关于 = 和 || 优先级问题。
```php
<?php
        if (!$flag = false || true) {
            echo "hahah";
        }else{
            echo "hello,world!";
        }
?>
```
不会输出"hahah",因为 || 的优先级比 = 高 导致 

正确写法:
```
<?php
        if ((!$mid = "123456") || true) {
            echo "hahah";
        }
?>
```