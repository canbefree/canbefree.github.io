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
 

### volumes
#### 创建volume

> docker volume create data-volume

```
docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=192.168.1.1,rw \
    --opt device=:/path/to/dir \
    foo
```

#### 获取容器ip
docker inspect b4 |grep IPAddress


#### 删除

##### 镜像删除
docker rmi $(docker images -q -f "dangling=true")   

##### 容器删除
    
docker ps -a |grep Exit |awk '{print $1}' |xargs docker rm



### 结语
