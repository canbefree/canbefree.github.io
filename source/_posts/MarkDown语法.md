---
title: MarkDown语法
date: 2016-10-09 04:26:35
tags: [blog,tool,markdown]
categories: blog

---
### 视频

<video id="video" controls="" preload="none">
      <source id="mp4" src="{% asset_path 视频示例.mp4  %}" type="video/mp4"/>
      <p>Your user agent does not support the HTML5 Video element.</p>
</video>

```html
<video id="video" controls="" preload="none">
      <source id="mp4" src="{% asset_path 视频示例.mp4  %}" type="video/mp4"/>
      <p>Your user agent does not support the HTML5 Video element.</p>
</video>
```

### 图片,链接


这是一个图片![百度](http://www.baidu.com/img/2016_10_09logo_61d59f1e74db0be41ffe1d31fb8edef3.png)

这是一个图片的行内链接[![hexo-image]](http://www.baidu.com)
这是一个引用的图片链接[![hexo-image]][hexo-url]

这是一个文字的行内链接[百度](http://www.baidu.com)  
这是一个文字的引用链接[百度][baidu]


```
这是一个图片![百度](http://www.baidu.com/img/2016_10_09logo_61d59f1e74db0be41ffe1d31fb8edef3.png)

这是一个图片的行内链接[![hexo-image]](http://www.baidu.com)
这是一个引用的图片链接[![hexo-image]][hexo-url]

这是一个文字的行内链接[百度](http://www.baidu.com)  
这是一个文字的引用链接[百度][baidu]
```

### HEXO图片设置（本blog）

>修改配置文件
```ini
_config.yml
post_asset_folder: true
```
>引入插件(一旦引入插件 公共图片文件引入方式将不可用)
```
npm install https://github.com/CodeFalling/hexo-asset-image --save
```
>图片插入

添加图片到一下路径  
\source\_posts\Swig模板\swig.PNG

引用方式
```
![swig](/swig.PNG)
{% asset_path swig.PNG  %}
{% asset_img swig.PNG %}
{% asset_link swig.PNG  %}
{% asset_img swig.PNG This is an example image %}
```
         
   

### 表格
---
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

```
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

```



### 粗体和斜体,强调
---
这是**粗体**  
这是*斜体*  
这是`强调`  

```
这是**粗体**  
这是*斜体*  
这是`强调`  
```

### 标注 


### 段落缩进
> 段落  
> 哈哈
>> 分类表达
  
>结束

```
> 段落  
> 哈哈
>> 分类表达
  
>结束
```
### 列表

#### 无序列表
- 列表1
- 列表2
```
- 列表1
- 列表2

```
#### 有序列表
1. 列表1
>dfasdfasdff[url](www.baidu.com)
1. 列表2

```
- 列表1
- 列表2

```

### 转义字符


|显示结果|实体名称|
|:-----|:----|
| &nbsp;|&amp;nbsp;|
|&lt; |&amp;lt;|
|&gt; |&amp;gt;|
| &amp;|&amp;amp;|
| &quot;|&amp;quot;|
| &#39;|&amp;apos;(IE不支持)|

[hexo-image]: http://img.shields.io/badge/Hexo-2.4+-2BAF2B.svg?style=flat-square
[hexo-url]: http://hexo.io  
[baidu]: http://www.baidu.com


