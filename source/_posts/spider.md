---
title: 爬虫
date: 2016-10-09 09:15:52
desc: 爬虫：高效率,断点续爬,内存消耗低
categories: python
tags: [spider,tool,scrapy,python]
---
### python爬虫

#### 安装依赖

1. python3.7 scrpay库 twisted
    1. https://twistedmatrix.com/trac/wiki/Downloads
    1. pip3 install scrapy
2. chromedriver
   1. google或者百度搜索下载,本人使用 choco 安装 (http://npm.taobao.org/mirrors/chromedriver/75.0.3770.8/)
3. selenium
   1. pip install selenium

4. 谷歌浏览器

#### 简单的爬虫

##### 简单示例

爬取狗东所有搜索关于小米的产品

> settings.py

1. 添加Selenium中间件
    1. 狗东的下一页都是通过Js加载的 使用scrapy shell ![1](/1.png)
    1. 观察上图可以发现，显示正在加载中,查看dom可以发现此时分页导航还没有生成。（因为是异步加载，spider默认的引擎不支持js，所以需要引入 Selenium 下载中间件）
    1. Selenium中间件格式参考![2](/2.png)
2. 修改默认请求头

> items.py

``` python 
class JdItem(scrapy.Item):
    title = scrapy.Field()
    price = scrapy.Field()
```

>爬虫代码

```python
# -*- coding: utf-8 -*-
import scrapy
from spider.items import JdItem
from selenium import webdriver
class JdSpider(scrapy.Spider):
    name = 'jd'
    allowed_domains = ['jd.com']

    def __init__(self):
        self.browser = webdriver.Chrome()
        self.browser.set_page_load_timeout(30)

    start_urls = [
        'https://search.jd.com/Search?keyword=%E5%B0%8F%E7%B1%B3&enc=utf-8'
    ]

    def parse(self, response):
        item_lists = response.css(".gl-item")
        for item in item_lists:
            jditem = JdItem()
            jditem['price'] = item.css('.p-price i ::text').get()
            jditem['title'] = item.css('.p-name ::attr(title) ').get()
            yield jditem

        next_page_script = response.css(".pn-next ::attr(onclick)").get()
        self.browser.execute_script(next_page_script)
        yield scrapy.Request(self.browser.current_url)
```

#### 暂停思考

如上我们便可以抓取狗东所有的小米产品了，但是 Selenium是依赖于浏览器的，如果想要在自己的云服务器跑如何实现？
推荐使用 PhantomJS

```python
    #self.browser = webdriver.Chrome()
    self.browser = webdriver.PhantomJS()
```

在实际过程中,使用 PhantomJs会被强制远程中断(识别header,强制让你跳 passport.jd.com)。
Selenium support for PhantomJS has been deprecated, please use headless versions of Chrome or Firefox instead

这就蛋疼了。

好吧，试试chrome来跑Selenium

1. 安装chromedriver
    1. http://npm.taobao.org/mirrors/chromedriver/75.0.3770.8/
2. 安装 Headless Chrome
    1. yum install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

3. 设置chrome
   ```python
        if(sys.platform == 'liunx'):
            options.add_argument('--headless')
            options.add_argument('--disable-gpu')
            options.add_argument('--no-sandbox')
        self.browser = webdriver.Chrome(chrome_options=options)
   ```



#### 关于需要登陆的网站如何爬取

直接出题,爬知乎!

知乎反反爬虫!
知乎会识别浏览器的自动测试模式，然后拒绝你的请求。

正常浏览器下：
![3](/3.png)

自动测试浏览器下：
![4](/4.png)

```python
        options.add_experimental_option(
            'excludeSwitches', ['enable-automation'])
```

#### 爬虫过程中突然奔溃了,如何不重复爬

选项: 

> scrapy crawl jd -s JOBDIR=./job

#### 配置日志

```python
import logging
from scrapy.utils.log import configure_logging

configure_logging(install_root_handler=False)
logging.basicConfig(
    filename='log.txt',
    format='%(levelname)s: %(message)s',
    level=logging.WARNING
)
```

#### 待解决问题

如果是多级页面爬取执行js会存在问题：

>比如列表页的下一页是通过js脚本执行的，查询物品详情后再调用这个js就会报错，因为浏览器的列表页js运行环境已经被详情页取代了。

可以分级爬取。将所有商品爬去下来，再根据数据库的详情页 url 重新爬取.

可以爬取详情页不使用 Selenium中间件 (修改中间件,加入使用条件)

```python
    if spider.name == 'jd':
            # 显式等待*秒,等待js求加载完毕
            if(request.url.find('item.jd.com') == -1):
                spider.log("wait for js load!")
                spider.browser.get(request.url)
                time.sleep(3)

                return HtmlResponse(url=spider.browser.current_url, body=spider.browser.page_source,
                                encoding="utf-8", request=request)
```

### 使用selenium爬虫的优缺点

    优点:
        1. 反反爬
        2. 开发难度减少
   
    缺点
        1. 比较慢
        2. 耗资源