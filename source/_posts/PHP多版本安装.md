---
title: PHP多版本安装
date: 2016-10-19 04:41:24
categories: php
tags:
    - nginx
    - php
---

### 准备

1. [官网](http://cn2.php.net/releases/)下载 5.3.9的包
1. 解压到用户目录


### 编译
#### 如果有老版本请按照老版本的编译参数
##### 查看php版本的编译参数
```
$ /usr/local/php/bin/php -i |grep configure
```

#### 一些必须安装的库文件

```bash
sudo yum install libxml2-devel.x86_64
sudo yum install openssl openssl-devel
sudo yum install libcurl-devel
sudo yum install libpng-devel
sudo yum install libmcrypt-devel
sudo yum install bzip2-devel
sudo yum install libjpeg-devel
sudo yum install freetype-devel.x86_64
```

#### 执行编译(负责老版本的编译参数)
```bash
./configure  --prefix=/usr/local/php53 --with-config-file-path=/usr/local/php53/etc --with-mysql --with-mysqli --with-iconv-dir=/usr/local --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-discard-path --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl=/usr/local --without-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap  --enable-zip --with-bz2

./configure  --prefix=/usr/local/php54 --with-config-file-path=/usr/local/php54/etc --with-curl=/usr/local  --enable-fpm  --with-mysql --with-mysqli --enable-sockets --enable-fastcgi 

./configure  --prefix=/usr/local/php7 --with-pdo-mysql=mysqlnd --with-config-file-path=/usr/local/php7/etc  --with-mysqli --with-iconv-dir=/usr/local --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath   --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl=/usr/local  --enable-mbregex  --enable-fpm --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap  --enable-zip --with-bz2

```
* added to Makefile to EXTRA_LIBS at the end "-llber" (报错 ber_scanf *
> 生成的Makefile文件 找到首字为EXTRA_LIBS 加上 -llber选项 (php7.0不用处理)

#### make
> --with-png-dir 带-dir后缀的表明这个路径下有so文件
> --with-zlib 没有带表明 就是源码 .h .cpp

#### make install 
```
$ /usr/local/php53/bin/php -v
```
查看是否安装成功

### 配置
#### phpfpm配置
```
$ cd /usr/local/php53
$ sudo find . -name php-fpm.conf*
$ sudo cp /usr/local/php53/etc/php-fpm.conf.default /usr/local/php53/etc/php-fpm.conf
$ sudo vim /usr/local/php53/etc/php-fpm.conf
    listen = 127.0.0.1:9001 #修改 php-fpm监听的端口
$ sudo /usr/local/php53/sbin/php-fpm
```

#### 设置 php-fpm子进程用户：
编辑文件php-fpm.conf （一般位于 /usr/local/php/etc/php-fpm.conf 
找到 user 、 group 两个参数的定义，将其设置为www www，
再重启 php-fpm 进程即可。 

#### php.ini配置
```
$ /usr/local/php53/bin/php -i |grep php.ini
```
**Configuration File (php.ini) Path => /usr/local/php53/etc**

> 在源码目录执行 *find . -name "php.ini\*"*
>> **./php.ini-production**  
>> **./php.ini-development**


> 拷贝 配置文件 到 /usr/local/php53/etc 目录
```
$ sudo cp php.ini-development /usr/local/php53/etc/php.ini
```



#### nginx配置

> SAFE MODE Restriction in effect. The script whose uid is 40019 is not allowed to access  

#####查看 nginx.conf 文件的权限配置  
nginx.conf文件第一行设置为 www www;;
再执行 nginx -s reload 即可。


#### 其他
请按照正常编译


### 其他问题回顾
#### This Lib Requires The Memcached Extention!

> 安装pear
> sudo -i
> export PATH=$PATH:/usr/local/php53/bin
> pecl install memcached


### 其他配置

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
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_pass  127.0.0.1:9000;
        }

        access_log logs/yourdomain.log combined;
    }
```


### 常见编译错误解决方法
1.freetype-devel            sudo yum install -y freetype-devel
2.libtool                   export ECHO=echo  回车后 make  正常
3.libmcrypt 

----


###　过滤微信emji表情
    /**
     * 过滤掉微信用户的emoji表情
     * @param $nickname
     * @param string $replaceStr
     * @return mixed
     */
    static function replaceEmoji($nickname,$replaceStr="*")
    {

        $nicknameTmp = preg_replace_callback(
            '/./u',
            function (array $match) use ($replaceStr) {
                return strlen($match[0]) >= 4 ? $replaceStr : $match[0];
            },
            $nickname);
        return $nicknameTmp;

    }