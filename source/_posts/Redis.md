---
title: Redis
date: 2017-02-20 11:25:50
tags:
    - redis
---


### redis之多端口
>配置多端口，方便后面服务细分。

### redis之常用结构
#### 字符
set get getrange incr decr
#### 哈希
hget hset hgetall hlen hvals
#### 列表
lpush lpop blpop brpop rpop rpoplpush rpush
#### 集合
sadd smembers spop sdiff sinter srem sunion scard   
#### 有序集合
zadd zrange zcount
### redis之性能监测
> 每秒吞吐量
```bash
redis-benchmark -q -n 100000
```
```log
PING_INLINE: 49975.02 requests per second
PING_BULK: 50787.20 requests per second
SET: 49407.12 requests per second
GET: 50301.81 requests per second
INCR: 50251.26 requests per second
LPUSH: 50226.02 requests per second
LPOP: 49652.43 requests per second
SADD: 50000.00 requests per second
SPOP: 50787.20 requests per second
LPUSH (needed to benchmark LRANGE): 49850.45 requests per second
LRANGE_100 (first 100 elements): 27307.48 requests per second
LRANGE_300 (first 300 elements): 11471.84 requests per second
LRANGE_500 (first 450 elements): 8892.84 requests per second
LRANGE_600 (first 600 elements): 6874.74 requests per second
MSET (10 keys): 37821.48 requests per second
```
> 命中率()


### redis删除过期缓存机制
1. redis读取键值会判断该值是否过期。过期则删除.
2. redis后台每隔一段时间,选取一定数量的key查看是否过期。如果过期数量大于一定比例。则该指令再执行一次。

### redis之管道
如下命令：
echo "config get *" |redis-cli
