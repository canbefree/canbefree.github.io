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

docker-compose run --rm  -v ./logstash/ --name=logstash logstash


> CRON_ACTION [A-Z]+
> CRONLOG %{SYSLOGBASE} \(%{USER:user}\) %{CRON_ACTION:action} \(%{DATA:message}\)

如何解释上面的两句话？
%{CRON_ACTION:action} 其实就是 %([A-Z]+:action),也就是 (?<action>[A-Z]+)的意思。

[测试正则](http://grokdebug.herokuapp.com/)

ruby grokdebug.rb -m '10.1.1.1' -p '%{IP:client}' 





### elasticsearch
#### 宿主机调整 不然docker会报错
sysctl -w vm.max_map_count=262144

#### 状态查询

>查询集群节点数以及健康状态
http://120.78.62.77:9200/_cat/health?v

>节点设置

curl http://120.78.62.77:9200/_cluster/health -H "Content-Type: application/json" -s | python -m json.tool

http://120.78.62.77:9200/_cluster/settings


```
    wget https://artifacts.elastic.co/downloads/logstash/logstash-5.6.3.zip
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.3.zip
    wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.3-linux-x86_64.tar.gz
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.3-linux-x86_64.tar.gz
```


#### 安装 x-pack

./bin/elasticsearch-plugin install -b x-pack



原有100人手上有100收藏品。 100人之间互相交易。 找出最受欢迎的收藏品（交易次数最多的收藏品）


收藏品 --