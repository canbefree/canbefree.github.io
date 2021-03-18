---
title: Docker容器开发
date: 2018-06-19 16:28:53
tags:
  - vscode
  - docker
---

![](https://img.shields.io/badge/docker-yellow)


##  docker介绍
1.  开发人员容器进化历程: vm虚拟机-> vargant -> 容器化，在之前的工作经历中，容器开发没出来之前，在搭建本地环境都比较复杂，nginx,功能依赖zookeeper等都需要自己build,配置，工作环境的变化，你不得不重新花大量时间。在博雅的工作期间，比较流行的就是用虚拟机导入别的同事提前打包好的镜像，但是镜像大小动辄两个G，而且虚拟机启动慢，占用cpu过多。也会因为个人机器环境出现各种问题。
2.  容器开发的好处：开发人员在本地编写代码，可以更方便和同事共享工作。直接打包一键构建。容易模拟，同步生产，测试。
3.  简易，docker+vscode即可。开放的镜像资源很多。

## 环境搭建
### vscode + docker开发环境搭建
- [docker安装](https://docs.docker.com/docker-for-windows/install/)
  - 下载比较慢,使用迅雷或者 choco (choco search docker-desktop)

- [阿里云自动构建](https://yq.aliyun.com/articles/58512)
    - dockerhub的访问速度一般，可以考虑容器托管
  我一直用的阿里云镜像服务，很好用，除了登陆需要手机授权比较麻烦，可以使用webhook实现 github/私有gitlab的自动镜像构建

  - 使用"docker tag"命令重命名镜像，并将它通过专有网络地址推送至Registry。

- vscode安装配置
  
  -  必须安装vscode插件: ms-vscode-remote.remote-containers
     -  容器开发核心插件, 直接通过*Remote-Container:Add Development...*命令选择对应语言可以初始化一个docker容器开发环境，会在当前目录下生成一个.devcontainer,包含所需的Dockerfile.可以进一步配置.
     - 执行 *Remote-Container:Open folder in container...* 即可。
     - 也可以使用docker-compose的配置化，具体可以参考我的[go环境](https://github.com/canbefree/docker-go)搭建
  
> 注意：使用remote开发,如果宿主机和容器的系统不一样，通过容器volumns挂载的文件的访问速度会比较慢，会影响git的使用,所以不建议使用volumns直接挂载开发目录，直接通过`docker create volumns` 会比较好。

  - 容器之间与宿主机文件的复制
    - 通过 docker cp 命令(比较麻烦,因为需要知道容器ID)
    - 通过volumn挂载用户目录(推荐)
    - 容器本地持久化：
      - 备份：
          ```bash
          docker run --rm  --volumes-from docker-go  -v  D:/backup:/backup ubuntu tar cvf backup/back.tar -C /workspace .
          ```
          将/workspace 备份到 D:/backup下 
      - 恢复
          ```bash
           docker run --rm --volumes-from docker-go -v  D:backup:/backup ubuntu tar xvf backup/back.tar -C /workspace
          ```
          将
    - 直接对镜像进行备份 *docker login ... docker push ...*
> 小提示： 宿主机copy内容到容器可以直接通过vscode操作，容器到宿主机只能复制图片等特殊格式


## 其他问题问题

1. 添加volumn配置时 无法使用 `docker-compose restart [container_name]` 生效,请stop后在启动
  

2. 通过Remote development如何访问 其他容器,比如数据库,其他环境
    -  数据库建立与宿主机的端口映射, 开发环境再通过 host.docker.internal 访问数据库
    -  直接使用同样的[docker-compose.yml](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/docker-in-docker-compose/.devcontainer) 配置相同的网络环境 [详情参考](https://code.visualstudio.com/docs/remote/containers-advanced)

> 框架或者语言时刻都在更新，个人开发视野也很容易产生局限，如果有更好的建议或者其他问题探讨都可以及时评论

### 参考

docker [官方文档][1]

[1]:https://docs.docker.com/
