---
title: PHP
date: 2017-02-09 11:32:49
tags:
---
### 前言
待完善

### PHP实现原理

待完善

### 编写PHP插件
代码规范：
    Class :用大驼峰
    object ： 用小驼峰
    变量: 用 下滑线

待完善

### 常用

#### PHP操作数组
array_chuck

####　过滤微信emji表情
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

#### 绝对路径和相对路径
> 相对路径都是参考入口文件的。。。！！！！

> __FILE__ 代码所在当前文件的文件名称
> __DIR__ 代码所在当前文件的目录名称
> getcwd() 获取执行目录

#### 关于 = 和 || 优先级问题。
```php
<?php
        if (!$flag = false || true) {
            echo "hahah";
        }else{
            echo "hello,world!";
        }
?>
```
不会输出"hahah",因为 || 的优先级比 = 高 导致 

正确写法:
```
<?php
        if ((!$mid = "123456") || true) {
            echo "hahah";
        }
?>
```


### PHP安装

#### 准备

1. [官网](http://cn2.php.net/releases/)下载 5.3.9的包
1. 解压到用户目录

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

#### 其他配置

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


#### psr-0 与 psr-4 标准

##### psr-0
1 命名空间必须与绝对路径一致 
2 类名首字母必须大写 
3 除去入口文件外，其他“.php”必须只有一个类 
4 php类文件必须自动载入，不采用include等 
5 单一入口

#### psr-4
PSR-4和PSR-0最大的区别是对下划线（underscore)的定义不同。PSR-4中，在类名中使用下划线没有任何特殊含义。而PSR-0则规定类名中的下划线_会被转化成目录分隔符。 
PSR-4会预先加载目录映射,如上面的例子为例,\Core\ClassLoader 类在Core命名空间里，PSR-4规范会设定一个路径来指定Core命名空间属于某一个文件夹（example： \Core\ => vendor/myApp/Core/src/ ) 这样去找类的时候, 就会去对应的目录下去找。


### 总结
