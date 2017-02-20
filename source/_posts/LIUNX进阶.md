---
title: LIUNX进阶
date: 2017-02-17 03:47:18
tags:
---

### RSYNC 同步文件 

>不像SCP命令,它是增量同步。能够保持原来文件的权限、时间、软硬链接等附加信息


### EXCEPT
实用场景
1. 很多重复的请求动作时。
1. 当没有对方服务器权限，但是有查询权限时。
```js
#!/usr/bin/expect -f 
set timeout 40 #有些命令响应时间比较长。
set ipaddr "localhost"
set passwd "sercert"
set date  [exec date "+%Y%m%d"]
spawn scp -P 3600 user@$ipaddr:/data/wwwroot/xxlanldord_logdata/requestlog/detail$date /var/local/logalot/logs/innernet

"*?password:*" { send "$passwd\r" }
}
expect eof
exit
```