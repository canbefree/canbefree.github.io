---
title: phpstorm-pystorm-的那点事
date: 2016-10-13 10:13:01
categories: php
tags:
    - web
    - php
    - python
    
---

### 项目同步

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

3. 修改 php.ini配置文件
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