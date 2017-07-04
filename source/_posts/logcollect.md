---
title: 日志收集
date: 2017-02-15 04:46:37
tags:
    - ELK
    - Kafka
    - Kibana
    - logstash
    - ElasticSearch
    - filebeat
---


### 配置基本环境

> 下载即可用。简单的修改下配置文件即可。网站上都有示例。
> 配置文件默认都是远程不可连接。要改下配置。

1. JDK
2. RUBY
3. [logstash](https://www.elastic.co/downloads/logstash)
4. [elasticsearch](https://www.elastic.co/downloads/elasticsearch)
5. [kibana](https://www.elastic.co/downloads/kibana)
6. [filebeat](https://www.elastic.co/downloads/beats/filebeat)

### logstash
#### 格式化日志
[grok基础](http://udn.yyuap.com/doc/logstash-best-practice-cn/filter/grok.html)
```yml
filter {
    #定义数据的格式
    grok {
        match => { "message" => "%{DATA:timestamp}\|%{IP:serverIp}\|%{IP:clientIp}\|%{DATA:logSource}\|%{DATA:userId}\|%{DATA:reqUrl}\|%{DATA:reqUri}\|%{DATA:refer}\|%{DATA:device}\|%{DATA:textDuring}\|%{DATA:duringTime:int}\|\|"}
        }
    #定义时间戳的格式
    date {
        match => [ "timestamp", "yyyy-MM-dd-HH:mm:ss" ]
        locale => "cn"
        }
    
    #定义客户端的IP是哪个字段（上面定义的数据格式）
      geoip {
        source => "clientIp"
      }
    #定义客户端设备是哪一个字段
    useragent {
      source => "device"
      target => "userDevice"
    }
    #需要进行转换的字段，这里是将访问的时间转成int，再传给Elasticsearch
    mutate {
      convert => ["duringTime", "integer"]
    }
}
```

> CRON_ACTION [A-Z ]+
> CRONLOG %{SYSLOGBASE} \(%{USER:user}\) %{CRON_ACTION:action} \(%{DATA:message}\)

如何解释上面的两句话？
%{CRON_ACTION:action} 其实就是 %([A-Z ]+:action),也就是 (?<action>[A-Z]+)的意思。

[测试正则](http://grokdebug.herokuapp.com/)
####  