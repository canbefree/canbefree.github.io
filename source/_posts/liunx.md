---
title: LIUNX进阶
date: 2017-02-17 03:47:18
tags:
---

### MAN手册

Usage:用法
Examples:示例
TEST [OPTION] ... [+FORMAT]

#### man配置色彩
```bash
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
```



### 系统配置修改
|作用|指令|
|：---|：----|
|修改时区| cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime|

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

### ECHO用法
命令通过管道来执行。
```bash
  echo "CONFIG GET *"|redis-cli
```
颜色改变
echo -e "\033[44;37;5m ME\033[0m COOL" 


### 查看系统配置
|指定|效果|
|-|-|
|df -h| 查看根目录下文件夹大小|
|du -ah -max-depth=1|查看目录下文件大小|


### 免密码登录
#### 本机生成密钥对
#### 将公钥发给服务器