---
title: K8s
date: 2019-09-04 14:47:53
tags: [docker,k8s]
categories:
    - docker
    - k8s
---

### k8s

#### 安装

- windows篇

    下载官网最新版本[docker](https://docs.docker.com/docker-for-windows/install/)

    >由于官网是境外服务器,下载可能比较慢,建议用迅雷等p2p工具下载[直接下载地址](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

    安装后,检查kubelet是否安装完毕
    ![kubelet版本](1.PNG)

### 搭建

-  使用kubeadm搭建 k8s [安装](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
  

```
# 创建一个 Master 节点
$ kubeadm init

# 将一个 Node 节点加入到当前集群中
$ kubeadm join <Master 节点的 IP 和端口 >
```
