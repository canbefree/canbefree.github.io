---
title: Mysql数据库
date: 2016-10-09 08:57:40
categories: sql
tags: [mysql,mariadb]
---

### 安装数据库
#### yum 安装
>服务器：centos 安装版本：mariadb 1:5.5.50
```
    sudo yum install mariadb-server
```
#### 开机自启关闭防火墙
```bash
sudo systemctl stop firewalld.service #关闭防火墙
sudo systemctl disable firewalld.service #关闭防火墙开机启动

sudo systemctl start mariadb  #开启服务
sudo systemctl enable mariadb #开机启动
```

#### 设置密码
>初始化安装是**没有密码**的
```
    mysqladmin -u root password {123456}
```

#### 开启权限
```mysql
grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option ;
flush privileges ;
```


### 错误排查
>IP address '192.168.33.13' could not be resolved: Name or service not known

默认ip会发解析成域名，修改/etc/my.cnf配置文件取消反解析。
```ini
[mysqld]
skip-name-resolve
```


### mysql update on duplicate

```
INSERT INTO `landlord_kreturn_task`(`mid`, `taskid`, `day`, `finished`, `finishtime`, `awarded`, `awardtime`, `date`, `updatetime`) VALUES (1,1,1,1,1,1,1,1,1)
on duplicate key 
update 
`finished` = 1 , `finishtime` = 1232131
```
####  如果改成and必须两个update值都修改了才会影响。
```
INSERT INTO `landlord_kreturn_task`(`mid`, `taskid`, `day`, `finished`, `finishtime`, `awarded`, `awardtime`, `date`, `updatetime`) VALUES (1,1,1,1,1,1,1,1,1)
on duplicate key 
update 
`finished` = 1 and  `finishtime` = 1232131
```