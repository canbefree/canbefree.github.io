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


### 如何配置环境(LNMP)

#### 准备Dockerfile文件 并build

nginx 
```
FROM nginx
```

php-fpm
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
    && docker-php-ext-install -j$(nproc) pdo pdo-mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

COPY swoole/ swoole/

RUN cd swoole \
    && phpize \
    && ./configure \
    && make \
    && make install

RUN pecl install redis-3.1.3 \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable redis xdebug swoole

```

mariadb
```
FROM FROM mariadb:10.3
```


### 创建目录文件
mkdir /www
docker run -it nginx /bin/bash
mkdir -p /data/nginx
mkdir -p /data/nginx/logs
docker cp nginx:/etc/nginx conf/
mv (上步创建的nginx文件)  /date/nginx


mkdir -p /data/php-fpm 
docker run --name php-fpm -d 7.1-fpm /bin/bash
docker cp php-fpm:/usr/local/etc/ etc/
mv (上步创建的php-fpm文件) /date/php-fpm

mkdir -p /data/mariadb
docker run --name mariadb -d mariadb /bin/bash
docker cp mariadb:/etc/mysql conf

### 修改配置文件
php-fpm 配置的默认监听端口要从 172.0.0.1:9000改成 9000

php-fpm.conf中daemonize = no
否则容器无法启动 Exited

配置命令行
sudo tee /etc/docker/daemon.json <<-'EOF'
alias php='docker exec -it php-fpm php'
alias mysql='docker exec -it mariadb mysql'
alias nginx='docker exec -it nginx service nginx'
EOF


### 启动shell脚本
```
docker rm -f $(docker ps -a -q)

P=/data/php-fpm && \
docker run --name  php-fpm  --privileged=true \
-v /www:/www \
-v $P/etc/php-fpm.conf:/usr/local/etc/php-fpm.conf \
-v $P/etc/php-fpm.d/:/usr/local/etc/php-fpm.d/ \
-v $P/logs:/phplogs \
-d 7.1-fpm

P=/data/nginx && \
docker run -p 80:80 --name nginx  --privileged=true \
--link php-fpm \
-v /www:/www \
-v $P/conf/nginx.conf:/etc/nginx/nginx.conf \
-v $P/conf/conf.d:/etc/nginx/conf.d \
-v $P/logs:/wwwlogs \
-d nginx

#mysql存了数据 建议不要和php-fpm以及nginx放一起。
P=/data/mariadb && \
docker run -p 3306:3306 --name mariadb --privileged=true \
-e MYSQL_ROOT_PASSWORD=123456 \
-v $P/conf:/etc/mysql \
-d mariadb

```


##### 网速慢可以用[阿里云](https://cr.console.aliyun.com/?spm=5176.1971733.2.28.60785837Gd4YZQ#/accelerator)加速 

通过修改daemon配置文件/etc/docker/daemon.json来使用加速器
```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://15vkd47w.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

```

#### 获取容器ip
docker inspect b4 |grep IPAddress


#### 删除

##### 镜像删除
docker rmi $(docker images -q -f "dangling=true")   

##### 容器删除
    
docker ps -a |grep Exit |awk '{print $1}' |xargs docker rm


### 本地镜像

### 公共镜像
sudo docker pull ubuntu:12.04 //花了大概两分钟时间

sudo docker pull registry.cn-shanghai.aliyuncs.com/rulicn/php7

### 结语