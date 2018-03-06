---
title: Docker
date: 2017-06-19 16:28:53
tags:
---

### 前言
镜像，容器，仓库

### 内容|


#### 基本命令

|命令|解释|
|:--|:--|
|service server start|开启docker服务|
|chkconfig docker on  |加入开机启动|
|run|运行一个实例|
|docker ps -a |查看运行的所有实例
 


#### 获取容器ip
docker inspect b4 |grep IPAddress


#### 删除

##### 镜像删除
docker rmi $(docker images -q -f "dangling=true")   

##### 容器删除
    
docker ps -a |grep Exit |awk '{print $1}' |xargs docker rm

#### windows快捷安装软件
choco

#### 问题总结
1. ssh 登陆不上服务
> 修改host配置 添加 127.0.0.1 localhost
> 修改 /etc/ssh/sshd_config 中配置项 UseDNS no 取消反向代理

2. Error starting userland proxy
>ERROR: for php-fpm  Cannot start service php-fpm: driver failed programming external connectivity on endpoint php-fpm (060279c09292a3f7cd2c0464ad868e46ac3809fdbba826a8d4fdb9981dccd4d2): Error starting userland proxy: mkdir /port/tcp:0.0.0.0:9601:tcp:172.18.0.4:9601: input/output error
Encountered errors while bringing up the project.

重启下docker即可

### 结语
