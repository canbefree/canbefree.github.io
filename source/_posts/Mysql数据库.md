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


### mysql基本语法
#### 聚合
取出用户最近的添加时间以及总记录数
```sql
select max(time)from table group by user
```
#### if
取出大于当前日期的记录数
```sql
select count(if(time>123213213,1,null)) from table 
```

#### case when 
第一种 
```sql
case age when 18 then "1"  else "2" end
```
第二种
```sql
case when age>18 then 1 when age <2 then 2 end
```

统计符合条件数据的数量(利用null)
```sql
SELECT count(case when mid <1000 then 1 else null end)  FROM `landlord_fan` 
```


#### 聚合查询
```sql
select count(0),co from (SELECT count(mid) as co FROM `table`  group by mid) as A group by co
```

### 数据库优化

优化索引
>空字段 添加 not　null 属性。(null增加索引负担)
>尽量使用整形,比如时间.空间更小，运算方便
>分配更小的字段长度
>mysql仅能对靠左的的前缀进行查询

假设存在组合索引it1c1c2(c1,c2)，查询语句select * from t1 where c1=1 and c2=2能够使用该索引。
查询语句select * from t1 where c1=1也能够使用该索引。但是，查询语句select * from t1 where c2=2不能够使用该索引，
因为没有组合索引的引导列，即，要想使用c2列进行查找，必需出现c1等于某值。‘

```sql
explain(sql)
```

#### mysql gone away
1.用mysql_ping可以发起重连(单例模式特别注意)


#### 关于引擎
