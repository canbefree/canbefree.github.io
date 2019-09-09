---
title: Docker
date: 2018-06-19 16:28:53
tags:

---
# 优势
- 日志查看方便
- 方便配置
- 快速启动
- 快速复制容器,压测或者模拟分布式环境
- php ,go ,python后端甚至前端角色切换。

## 环境搭建

[docker安装](https://docs.docker.com/docker-for-windows/install/)
- 下载比较慢,使用迅雷或者 choco (choco search docker-desktop)
  
[docker-compose安装](https://docs.docker.com/compose/install/)

[docker-compose环境](git@github.com:canbefree/dev.git)

[docker-php55](git@github.com:canbefree/docker-php55.git)

- 配置 .env ( 工作路径,以及数据库密码等)
- 所有配置文件都在根目录etc下(如nginx配置文件 /etc/nginx/ext )
- 日志查看 （docker logs [container_name]）

- [阿里云自动构建](https://yq.aliyun.com/articles/58512)
  
```bash
    git tag -a release-v7.1.0 -m "Update ...."
    git push origin --tags
```

### DOCKERFILE[配置详解](https://docs.docker.com/engine/reference/builder/#maintainer)

- [volumns](https://docs.docker.com/engine/reference/builder/#volumns)
- [ENV](https://docs.docker.com/engine/reference/builder/#arg)
  - 配置环境变量
- [ARG](https://docs.docker.com/engine/reference/builder/#arg)
  - ARG USERNAME=1000 #定义变量USERNAME 默认1000
  - $USERNAME  #用$使用声明的USERNAME变量(类似PHP)
  
- [ADD](https://docs.docker.com/engine/reference/builder/#add) 和 [COPY](https://docs.docker.com/engine/reference/builder/#copy) 区别
  
        add 复制url,copy更简单
- [CMD](https://docs.docker.com/engine/reference/builder/#cmd)


### COMPOSE [配置详解](https://docs.docker.com/engine/reference/builder/#maintainer)
- volumns
        数据需要迁移，就需要volumns了，一般我都用来数据库的迁移
- networks
        容器如何访问宿主机IP: host.docker.internal

- images
- 指定对应的Dockerfile
  
```Dockerfile
    php-fpm7:
        build:
            context: ./php-fpm
            dockerfile: Dockerfile7
```

### 问题

- 添加volumn配置时 无法使用 `docker-compose restart [container_name]` 生效,请stop后在启动
  
## 容器化开发环境尝试


### 容器化尝试
- 卸载本地go
- 安装vscode插件 - Remote development 
  - docker镜像可以使用阿里云加速构建
  - 比如我使用的[go环境](https://github.com/canbefree/docker-go)
- 至于插件如何使用请参考插件文档。

- 通过Remote development如何访问 其他容器,比如数据库,其他环境
    -  数据库建立与宿主机的端口映射, 开发环境再通过 host.docker.internal 访问数据库
    -  直接使用同样的[docker-compose.yml](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/docker-in-docker-compose/.devcontainer) 配置相同的网络环境 [详情参考](https://code.visualstudio.com/docs/remote/containers-advanced)

框架或者语言时刻都在更新，个人开发视野也很容易产生局限，如果有更好的建议或者其他问题探讨都可以发送邮箱：452198757@qq.com

最新的资讯:[github博客]( https://canbefree.github.io/2018/06/19/docker/)
