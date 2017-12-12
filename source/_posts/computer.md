---
title: 计算机常识
date: 2017-02-08 04:36:21
tags:
---

### 关于字节

1个汉字 == 2个英文 == 2个字节 == 16bit 
assci码 用7bit表示(2^7=128)

> 这里说的都是最佳压缩情况

*utf-8中文字符占三个字节，GB18030兼容GBK兼容GB2312中文字符占两个字节，ISO8859-1是拉丁字符（ASCII字符）占一个字节*


### https
 >HTTP>SSL>TCP>IP
 
 1.下载证书
 2.验证证书是否正确。如果正确,利用证书向服务器发送加密的私钥(随机字符串) (非对称加密算法)
 3.用私钥解密服务器发来的数据。建立通信。(对称加密)
 
 关于非对称加密算法的两种加密方式：
 1.将明文用公钥加密，只有持有私钥的人才能解开 （数字证书）
 2.将明文用私钥加密，发给所有人，告诉所有人这段消息是我发的。（签名）
 
### CLASS DIAGRAM
#### 类的基本表示方式
基本的表示方式
```uml
+ price : decimal
```

>类
>> 属性
>>> 私有属性  -
>>> 保护属性 #
>>> 公有属性 +
>>> 类常量 
>>> 类变量 下划线

>> 私有
>>> 私有方法 -
>>> 保护方法 #
>>> 公共方法 +
>>> 类方法 _

类的关系

继承类 

继承接口
组合
聚合
依赖 
单向关联(A使用了B类 商品<----订单,添加商品到订单)
双向关联(互相使用。)
自身关联
多维关联