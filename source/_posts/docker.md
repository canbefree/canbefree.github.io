---
title: Docker
date: 2017-06-19 16:28:53
tags:
---

### 前言
镜像，容器，仓库

### 内容

#### 基本命令

|命令|解释|
|:--|:--|
|service server start|开启docker服务|
|chkconfig docker on  |加入开机启动|
|run|运行一个实例|
|docker ps -a |查看运行的所有实例|

绑定端口
``` 
docker run -p 4000:80 friendlyhello
```

### 结语