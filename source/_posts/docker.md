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


### 如何配置环境
#### 配置 nginx

php-fpm 配置的路径需要修改
php-fpm 配置的默认监听端口要从 172.0.0.1:9000改成 9000

```
FROM nginx
```
docker build -t php-fpm-7 .

```
PWD="/data/nginx" &&
docker run -p 80:80 --name nginx  --privileged=true \
-v /www:/www \
-v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf \
-v $PWD/conf/conf.d:/etc/nginx/conf.d \
-v $PWD/logs:/wwwlogs \
-d nginx 

```


#### 配置 php-fpm
这个必须设置成：
php-fpm.conf中daemonize = no
否则容器无法启动 Exited

```
FROM php:7.1-fpm

MAINTAINER xieyutian "xieyutianhn@gmail.com"
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        libmcrypt-dev \
        libssl-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
    && apt-get autoremove \
    && apt-get clean \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
          
RUN pecl install redis-3.1.3 \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable redis xdebug

```

```
P=/data/php-fpm && \
docker run -p 9000:9000 --name  php-fpm  --privileged=true \
-v /www:/www \
-v $P/etc/php-fpm.conf:/usr/local/etc/php-fpm.conf \
-v $P/etc/php-fpm.d/:/usr/local/etc/php-fpm.d/ \
-v $P/logs:/phplogs \
-d 7.1-fpm
```

#### 获取容器ip
docker inspect b4 |grep IPAddress


#### 删除

##### 镜像删除
docker rmi $(docker images -q -f "dangling=true")   

##### 容器删除
docker rm -f $(docker ps -a -q)
docker ps -a |grep Exit |awk '{print $1}' |xargs docker rm



### 本地镜像

### 公共镜像
sudo docker pull ubuntu:12.04 //花了大概两分钟时间

sudo docker pull registry.cn-shanghai.aliyuncs.com/rulicn/php7

### 结语