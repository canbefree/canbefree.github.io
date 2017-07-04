---
title: composer
date: 2016-11-01 10:37:26
tags:

    - php
    - composer
---


### 安装 composer 

```bash
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
```

### 配置国内镜像站

```
composer config -g repo.packagist composer https://packagist.phpcomposer.com #全局配置

composer config repo.packagist composer https://packagist.phpcomposer.com  #当前项目

```

### 动手开发第一个自己的composer包

#### PSR-0 PSR4
PSR-4和PSR-0最大的区别是对下划线（underscore)的定义不同。PSR-4中，在类名中使用下划线没有任何特殊含义。而PSR-0则规定类名中的下划线_会被转化成目录分隔符。 

