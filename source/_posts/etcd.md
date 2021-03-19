---
title: etcd
date: 2021-03-18 09:05:20
tags:
    - docker
---


[![](https://img.shields.io/badge/etcd-yellow)][1]

-----

当前版本: v3.4.0

etcd环境变量配置：https://etcd.io/docs/v3.4.0/op-guide/configuration/

> etcd is configurable through a configuration file, various command-line flags, and environment variables

一键搭建etcd环境：
```
$ curl -LO https://raw.githubusercontent.com/canbefree/docker-common/master/docker-compose-etcd.yml

$ docker-compose up -f docker-compose-etcd.yml --build

```

### raft算法



### etcd优化
服务器：
1. 硬件要求：SSD固态，基于cp,需要优质的集群网络

客户端：
1. 拒绝大量的key
2. 尽量少用Lease



### etcd监控：

[1]:https://etcd.io/docs/current/