---
title: phpstorm-pystorm-的那点事
date: 2016-10-13 10:13:01
categories: php
tags:
    - web
    - php
    - python
    
---
### 前言
学好怎么去配置phpstorm对开发的帮助极大。

### 如何设置项目同步

#### 设置
> setting>>SSH Terminal>> configure servers

>> ![img](setting.PNG)
>>> *注意蓝色标记处 那个才是重点*

> 排查大文件目录的同步
>> ![img](exclude.PNG)

> 使用同步
>> 右键项目 deployment> sync

#### xdebug

#### 安装
1. 安装 go-pear.php
2. pecl install xdebug
```
You should add "zend_extension=/usr/local/php7/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" to php.ini

```

3. 修改 php.ini配置文件,重启php-fpm进程
```ini
zend_extension=/usr/local/php7/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so"
xdebug.remote_enable=On
xdebug.default_enable=1
xdebug.remote_hander=dpgp
xdebug.remote_mode=req
xdebug.remote_port=9000
xdebug.remote_idekey="PHPSTORM"
xdebug.remote_autostart=1
xdebug.remote_connect_back=1

```

4. 配置phpstorm 

File --> setting (搜索"debug")--> DEBUG --> DBGp proxy
设置：
IDE KEY :PHPSTORM
host:192.168.0.111 （虚拟机ip）
port:9001


### 总结

积少成多
