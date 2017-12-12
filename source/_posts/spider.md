---
title: 爬虫
date: 2016-10-09 09:15:52
desc: 爬虫：高效率,断点续爬,内存消耗低
categories: python
tags: [spider,tool,scrapy,python]
---
### python爬虫


#### 准备工作
> python2.7 (3.5有点不兼容)
> scrapy
> bz4
> [BeautifulSoup](http://www.cnblogs.com/yupeng/p/3362031.html)

遇到困难 请参考:[PYTTHON疑难杂症](https://canbefree.github.io/2016/10/09/PYTHON%E7%96%91%E9%9A%BE%E6%9D%82%E7%97%87/)
#### 开始爬虫

##### 初始化

>新建项目
```
 scrapy startproject e_commerce
 cd e_commerce
 scrapy genspider yhd yhd.com
```
>items.py

目的主要是收集 商品图片,img_url,商品价格,商品评价
```
    name = scrapy.Field()  # 商品名称
    price = scrapy.Field()  # 商品价格
    img_url = scrapy.Field()  # 商品图片
    evaluation = scrapy.Field()  # 商品评分
```
>pipelines.py

存储
```
```
