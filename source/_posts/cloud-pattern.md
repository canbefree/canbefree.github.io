---
title: cloud_pattern
date: 2021-03-19 07:26:28
tags:
    - docker
    - micro
---



[参考文档](https://docs.microsoft.com/en-us/azure/architecture/patterns/index-patterns)


### BFF模式(前端做后端)(backend for frontend)

后端提供api接口，前端负责在不同场景编排服务

> 比如活动编辑需要判断活动是否有人参与了： 1, 判断有人参与 2, 编辑活动，这样就可以实现了。api的粒度更小，后面可以用更小的成本构建改造。


### 反腐层模式(anti-corruption layer)




