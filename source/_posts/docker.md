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

### 安装
#### 准备一个liunx环境

#### 安装docker
>centos

```
sudo yum install docker  //centos 7.0 可以直接安装
sudo service docker start //启动docker
sudo chkconfig docker on //开机自启
```


### 本地镜像


### 公共镜像
sudo docker pull ubuntu:12.04 //花了大概两分钟时间



### 结语