---
title: nginx源码学习
date: 2016-10-28 05:32:57
categories: liunx
tag:
    - liunx
    - nginx
---

### git上下载源码
[下载地址](https://github.com/nginx/nginx/tree/branches/stable-1.2)

### 源码编译
> 下载源码后你会发现没有 configure 文件 其实在auto文件夹内
```bash
    ./auto/configure --with-cc-opt='-g -O0'
```




### nginx功能介绍

#### 配置文件

##### 虚拟机停止使用缓存
如果是虚拟机必须关闭这个函数，修改nginx配置 改成 sendfile off;
```conf
sendfile off;
```

##### 路径过滤index.php
```conf
    server {
        listen          80;
        server_name     yourdomain.com;
        root            /home/yourdomain/www/;
        index           index.html index.htm index.php;

        if (!-e $request_filename) {
            rewrite ^(.*)$ /index.php$1 last;
        }

        location ~ .*\.php(\/.*)*$ {
            include fastcgi.conf;
            fastcgi_index  index.php;
            fastcgi_pass  127.0.0.1:9000;
        }

        access_log logs/yourdomain.log combined;
    }
```