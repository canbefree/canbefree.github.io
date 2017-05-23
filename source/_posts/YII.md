---
title: YII
date: 2017-04-29 05:24:30
tags: [框架,yii]
---

### 前言
工作需要

### 安装YII
1. 新建yii目录
2. 执行命令
```bash
composer global require "fxp/composer-asset-plugin:^1.2.0"
composer create-project --prefer-dist yiisoft/yii2-app-basic basic
```
3. 按提示输入github token，如果没有token，请前往[https://github.com/settings/tokens](https://github.com/settings/tokens)生成


### YII目录结构
<pre>
basic/                  应用根目录
    composer.json       Composer 配置文件, 描述包信息
    config/             包含应用配置及其它配置
        console.php     控制台应用配置信息
        web.php         Web 应用配置信息
    commands/           包含控制台命令类
    controllers/        包含控制器类
    models/             包含模型类
    runtime/            包含 Yii 在运行时生成的文件，例如日志和缓存文件
    vendor/             包含已经安装的 Composer 包，包括 Yii 框架自身
    views/              包含视图文件
    web/                Web 应用根目录，包含 Web 入口文件
        assets/         包含 Yii 发布的资源文件（javascript 和 css）
        index.php       应用入口文件
    yii  
</pre>

### YII前端页面




