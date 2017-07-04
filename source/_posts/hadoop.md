---
title: hadoop学习笔记
date: 2016-10-17 03:59:41
categories: liunx
tags: 
    - hadoop
---

### hadoop使用
vagrant 生成ip：192.168.33.50
关闭防火墙

#### 安装 jdk
```
 yum install java-1.7.0
 yum install java-1.7.0-openjdk-devel.x86_64
```

解压源码到用户目录 /home/vagrant

#### hadoop结构
```
> bin
> etc
> include
> lib
> libexec
> sbin
> share
> dfs  #需要自己创建
>> data #需要自己创建
>> name #需要自己创建

> conf #配置文件 需要自己创建
> tmp  #tmp dir  需要自己创建
```

### 单机配置

#### 新建用户
```
$ sudo groupadd hadoop
$ sudo adduser -g hadoop hadoop # 忽略报错
$ passwd hadoop

$ sudo -i
$ chmod -R 777 /etc/sudoers  
$ vim /etc/sudoers 

    ## Allow root to run any commands anywhere 
    root    ALL=(ALL)       ALL
    hadoop  ALL=(ALL)       ALL

$ chmod -R 440 /etc/sudoers 
$ su hadoop
$ 
```
#### 实现 ssh localhost
```
$ ssh-keygen
$ ssh-copy-id hadoop@localhost # 后面的参数为你要操作的平台
```

#### 配置环境变量
```
$ sudo vim /etc/profile

export JAVA_HOME=/usr/lib/jvm/java-openjdk

export PATH=$PATH:/home/hadoop/hadoop-2.7.3/bin

$ source /etc/profile

#修改hadoop2.7.2/etc/hadoop/hadoop-env.sh指定JAVA_HOME
$ vim etc/hadoop/hadoop-env.sh

#export JAVA_HOME=${JAVA_HOME}
export JAVA_HOME=/usr/lib/jvm/java-openjdk
```


#### 本地模式验证
```
  $ mkdir input
  $ cp /etc/hadoop/*.xml input
  $ bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep input output 'dfs[a-z.]+'
  $ cat output/*
```

### 伪分布式配置
#### 创建目录
```
$ mddir dfs
$ mkdir dfs/name
$ mkdir dfs/data
```

#### 修改配置文件
修改 etc/hadoop/core-site.xml
>
```xml
<configuration>
  <!-- 接收Client连接的RPC端口，用于获取文件系统metadata信息。 -->
  <property>
        <name>fs.defaultFS</name> 
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```
修改 etc/hadoop/hdfs-site.xml
> 
```xml
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/home/hadoop/hadoop-2.7.3/dfs/name</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/home/hadoop/hadoop-2.7.3/dfs/data</value>
    </property>
    <!-- 设置namenode的http通讯地址 -->
    <property>
        <name>dfs.namenode.http-address</name>
        <value>localhost:50070</value>
    </property>
    <!-- 设置secondarynamenode的http通讯地址 -->
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>localhost:9001</value>
    </property>
    <!-- 备份只有一份 -->
    <property> 
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <!-- 网站可以搜索到文件内容 -->
    <property> 
        <name>dfs.webhdfs.enabled</name>
        <value>true</value>
    </property>
</configuration>
```



#### 启动
```
$ bin/hdfs namenode -format
$ ./sbin/start-dfs.sh
```
打开 [http://192.168.33.50:50070/](http://192.168.33.50:50070/)验证

#### 配置 YARN
修改
```bash
$ cp etc/hadoop/mapred-site.xml.template etc/hadoop/mapred-site.xml
$ vim etc/hadoop/mapred-site.xml
```
```xml
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>localhost:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>localhost:19888</value>
    </property>
</configuration>
```
```
$ vim etc/hadoop/yarn-site.xml
```
```xml
      <property>
            <name>yarn.nodemanager.aux-services</name>
            <value>mapreduce_shuffle</value>
      </property>
```
#### 启动 YARN服务
```
$ ./sbin/start-yarn.sh 

```

访问 [http://192.168.33.50:8088](http://192.168.33.50:8088)

### 分布式搭建

#### ssh免密码登录
pass

#### 修改hosts 
```
$ sudo vim /etc/hosts
    192.168.33.51 master
    192.168.33.52 slave1
    192.168.33.53 slave2
```
#### 修改 slaves文件
```
$ vim etc/hadoop/slaves
  slave1
  slave2
```

#### 发送到各个主机(所有从机必须保持一致)
```
scp /etc/hosts hadoop@192.168.33.52:~
scp /etc/hosts hadoop@192.168.33.53:~
```
> ssh到各个主机切换到root执行
```
cat /home/hadoop/hosts > /etc/hosts
```
#### 修改配置
##### core-site.xml
```xml
<configuration>
  <!-- 接收Client连接的RPC端口，用于获取文件系统metadata信息。 -->
  <property>
        <name>fs.defaultFS</name>
        <value>hdfs://master:9000</value>
    </property>
</configuration>

```
##### hdfs-site.xml
```xml
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/home/hadoop/hadoop-2.7.3/dfs/name</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/home/hadoop/hadoop-2.7.3/dfs/data</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>master:9001</value>
    </property>
    <property>
        <name>dfs.webhdfs.enabled</name>
        <value>true</value>
    </property>
</configuration>


```

#### yarn-site.xml
```xml
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>master:8032</value>
    </property>
    <property>
        <name>yarn.resourcemanager.scheduler.address</name>
        <value>master:8030</value>
    </property>
    <property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>master:8031</value>
    </property>
    <property>
        <name>yarn.resourcemanager.admin.address</name>
        <value>master:8033</value>
    </property>
    <property>
        <name>yarn.resourcemanager.webapp.address</name>
        <value>master:8088</value>
    </property>
</configuration>
```
#### mapred-site.xml
```xml
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>master:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>master:19888</value>
    </property>
</configuration>
```


#### 同步配置
```
scp -r ~/hadoop-2.7.3/etc hadoop@192.168.33.53:~/hadoop-2.7.3/
scp -r ~/hadoop-2.7.3/etc hadoop@192.168.33.52:~/hadoop-2.7.3/
```


#### 启动 hadoop
> 格式化 namenode (需要保证各个虚拟机上的dfs都为空文件夹。)
```
$ bin/hadoop namenode -format 
```
> 启动所有服务
```
$ sbin/start-all.sh
```
> 节点管理器启动 (当发现 8088缺少某个节点时)
```
$ ./sbin/yarn-daemons.sh  start nodemanager
```
> 启动历史服务器
> Hadoop自带了一个历史服务器，可以通过历史服务器查看已经运行完的Mapreduce作业记录
> 比如用了多少个Map、用了多少个Reduce、作业提交时间、作业启动时间、作业完成时间等信息。
> 默认情况下，Hadoop历史服务器是没有启动的，我们可以通过下面的命令来启动Hadoop历史服务器
```
sbin/mr-jobhistory-daemon.sh   start historyserver
```



### hdfs 命令
#### [查看帮助](dfs.help.txt)
```bash
$ /bin/hdfs dfs -help #查看帮助
$ /bin/hdfs dfs -mkidr -p input
```



### mapreduce
```bash
$ bin/hdfs dfs -mkdir /input
$ bin/hdfs dfs -put etc/* /input
$ hadoop jar hadoop-mapreduce-examples-2.7.1.jar wordcount /input /output
```

#### 运行本机的 worldcount
```
$ hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /input /output/4
```
#### WordCount原理图
![img](http://images.cnitblog.com/blog/306623/201306/23175200-0ccb72e4bd7b4e48a2eea8673f361741.x-png)
#### 



