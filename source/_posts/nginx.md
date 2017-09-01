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
### gdb调试
编译代码是加上 -g选项 将源码标识编译到执行文件中。用gdb就可以直接调出源码。
>gcc -g test.c -o test

bt  查看代码函数的调用栈

f   切换当前的函数栈

i locals 打印当前函数栈内的变量

p 查看指针的值

detach-on-fork off 设置子进程同时访问 inferior 2 切换进程 threads 1 切换线程



### 源码阅读
1. main函数位于 core/nginx.c目录下。



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

重启php-fpm脚本
```
#!/bin/bash
#
# Startup script for the PHP-FPM server.
#
# chkconfig: 345 85 15
# description: PHP is an HTML-embedded scripting language
# processname: php-fpm
# config: /usr/local/php/etc/php.ini
 
# Source function library.
. /etc/rc.d/init.d/functions
 
PHP_PATH=/usr/local/php7
DESC="php-fpm daemon"
NAME=php-fpm
# php-fpm路径
DAEMON=$PHP_PATH/php/sbin/$NAME
# 配置文件路径
CONFIGFILE=$PHP_PATH/php/etc/php-fpm.conf
# PID文件路径(在php-fpm.conf设置)
PIDFILE=$PHP_PATH/php/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME
 
# Gracefully exit if the package has been removed.
test -x $DAEMON || exit 0
 
rh_start() {
  $DAEMON -y $CONFIGFILE || echo -n " already running"
}
 
rh_stop() {
  kill -QUIT `cat $PIDFILE` || echo -n " not running"
}
 
rh_reload() {
  kill -HUP `cat $PIDFILE` || echo -n " can't reload"
}
 
case "$1" in
  start)
        echo -n "Starting $DESC: $NAME"
        rh_start
        echo "."
        ;;
  stop)
        echo -n "Stopping $DESC: $NAME"
        rh_stop
        echo "."
        ;;
  reload)
        echo -n "Reloading $DESC configuration..."
        rh_reload
        echo "reloaded."
  ;;
  restart)
        echo -n "Restarting $DESC: $NAME"
        rh_stop
        sleep 1
        rh_start
        echo "."
        ;;
  *)
         echo "Usage: $SCRIPTNAME {start|stop|restart|reload}" >&2
         exit 3
        ;;
esac
exit 0
```