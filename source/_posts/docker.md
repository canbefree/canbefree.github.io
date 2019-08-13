---
title: Docker
date: 2017-06-19 16:28:53
tags:
---

# 环境搭建
 
## 要求

- 日志查看方便
- 方便配置
- 快速启动
- 快速复制容器,压测或者模拟分布式环境


## 环境搭建
[docker-compose环境](git@github.com:canbefree/dev.git)
[docker-php55](git@github.com:canbefree/docker-php55.git)

- 配置 .env ( 工作路径,以及数据库密码等)
- 所有配置文件都在根目录etc下(如nginx配置文件 /etc/nginx/ext )
- 日志查看 （docker logs [container_name]）

- [阿里云自动构建](https://yq.aliyun.com/articles/58512)
  
``` 
    git tag -a release-v7.1.0 -m "Update ...."
    git push origin --tags
```

## DOCKERFILE[配置详解](https://docs.docker.com/engine/reference/builder/#maintainer)

- volumns
- [ADD](https://docs.docker.com/engine/reference/builder/#add) 和 [COPY](https://docs.docker.com/engine/reference/builder/#copy) 区别
  
        add 复制url,copy更简单
- [CMD](https://docs.docker.com/engine/reference/builder/#cmd)

## COMPOSE [配置详解](https://docs.docker.com/engine/reference/builder/#maintainer)
- volumns
  
        数据需要迁移，就需要volumns了，一般我都用来数据库的迁移
- networks
  
        容器如何访问宿主机IP: host.docker.internal

        

- imgages
- 指定对应的Dockerfile
```
    php-fpm7:
        build:
            context: ./php-fpm
            dockerfile: Dockerfile7
```

## 问题
- 添加volumn配置时 无法使用 `docker-compose restart [container_name]` 生效,请stop后在启动
- 




# 尾注
  ## 目前存在一些头痛的问题

- 如何在宿主机执行终端命令(主要是被执行文件路径宿主机和容器里面挂载的位置不一致,导致无法执行)，
- 生产环境如何实现不停机动态挂载目录(研究下k8s)
- 生产环境日志路径不在开发目录下，导致mkdir权限不足，现在php-fpm使用的是root权限，有安全隐患




框架或者语言时刻都在更新，个人开发视野也很容易产生局限，如果有更好的建议或者其他问题探讨都可以发送邮箱：452198757@qq.com





