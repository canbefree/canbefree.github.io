---
title: Hexo主题制作
date: 2016-10-10 05:05:26
categories: blog
tags:
    - hexo
    - less
    - swing
---
接触到Hexo,网上接触大量自定义的博客。他们主页的个性,内容简明。对比下自己的博客。感受到了深深的伤害。

-------

### Hexo博客搭建

#### 新建github仓库

> 命名要规范： `canbefree.github.io`

现在点击访问 [canbefree.github.io](http://canbefree.github.io) 看看有没有生效

#### 安装hexo

> 安装 `nodejs`  
> `$ npm install hexo -g`  
> `$ hexo init`  
> `$ npm install`
> `$ hexo s -g -p 4000`   查看效果 -p指定端口

#### 修改配置文件 **_config.yml**

```yml
deploy:
  type: git
  repo: https://github.com/canbefree/canbefree.github.io
  branch: master
```

#### 创建分支,方便转移博客

将 `hexo init` 生成的文件全部提交的github的分支hexo上（相当于文件备份）

#### 发布流程

> `$ hexo clean`
> `$ hexo generate` 生成静态文件
> `npm install hexo-deployer-git --save` 安装git插件
> `$ hexo d` 发布到github博客上
> `git add .   git commit -m " " git push origin hexo` 修改的文件备份到分支上面


### hexo迁移

####  部署blog工作环境

考虑的工作环境的变换。hexo如何在别的机器上部署同样的博客环境也很重要

1. cnpm install hexo -g && hexo init
2. 从git下载分支hexo,覆盖当前的hexo目录
3. cnpm install
4. npm install hexo-deployer-git --save 安装git插件  (不要使用cnpm安裝 不支持--save)
5. hexo clean
6. hexo g
7. hexo d

#### 博客部署 

鉴于国内访问github的速度，估计很多人都没有打开博客的欲望。

##### 借助云服务器部署

> hexo -d 生成的静态页面可以直接部署到服务器上面。 找一台国内服务器能很快部署上去。

##### 借助coding.net部署 (不提供服务了)

### HEXO使用

#### markdown相关语法

[链接](https://canbefree.github.io/2016/10/09/markdown/)

### 相关模块

#### swig一些自定义函数

模板内发现很多函数都没见过, is_year,is_tag,经过一系列的*研究*~~

> \node_modules\hexo\lib\plugins\helper\index.js

```js
  helper.register('is_year', is.year);
```

```
Helper.prototype.register = function(name, fn) {
  if (!name) throw new TypeError('name is required');
  if (typeof fn !== 'function') throw new TypeError('fn must be a function');

  this.store[name] = fn;
};
```
### 添加更新日期
  修改主题配置文件（博客主目录）/themes/next/_config.yml，中找到 updated_at: false 修改为 updated_at: true

### 关于hexo插件引入
> \node_modules\hexo-generator-tag\index.js
```js
hexo.extend.generator.register('tag', require('./lib/generator'));
```

> \node_modules\hexo-server\index.js

```js
hexo.extend.console.register('server', 'Start the server.', {
  desc: 'Start the server and watch for file changes.',
  options: [
    {name: '-i, --ip', desc: 'Override the default server IP. Bind to all IP address by default.'},
    {name: '-p, --port', desc: 'Override the default port.'},
    {name: '-s, --static', desc: 'Only serve static files.'},
    {name: '-l, --log [format]', desc: 'Enable logger. Override log format.'},
    {name: '-o, --open', desc: 'Immediately open the server url in your default web browser.'}
  ]
}, require('./lib/server'));

hexo.extend.filter.register('server_middleware', require('./lib/middlewares/header'));
```
> 执行hexo, 默认cmd是help 
```js
hexo.call(cmd, args) 
```
> 默认加载所有 hexo-开头的插件。
```js
    // Ignore plugins whose name is not started with "hexo-"
    if (name.substring(0, 5) !== 'hexo-') return false;
```

<br>
<br>

### 自定义主题(NEXT)

#### 安装主题

直接clone到 theme目录即可
```bash
git clone --branch v5.1.2 https://github.com/iissnan/hexo-theme-next themes/next
```
#### 修改主题配置
> 修改 themes/next/_config.yml 

mermaid: 直接打开注释即可

站内搜索 [参考](https://www.jianshu.com/p/5b62c01c4dfa)

1. 安装插件

```shell
  npm install hexo-generator-search
  npm install hexo-generator-searchdb
```

2. 配置next中的搜索入口 (themes/next/_config.yml)

``` yml
local_search:
  enable: true
  # If auto, trigger search by changing input.
  # If manual, trigger search by pressing enter key or search button.
  trigger: auto
  # Show top n results per article, show all results by setting to -1
  top_n_per_article: -1
  # Unescape html strings to the readable one.
  unescape: false
  # Preload the search data when the page loads.
  preload: true

```
#### 添加mermaid插件

1. 修改主题配置文件

```yml
# Mermaid tag
mermaid:
  enable: true
  # Available themes: default | dark | forest | neutral
  theme: forest
  cdn: //cdn.jsdelivr.net/npm/mermaid@8/dist/mermaid.min.js

```
2. 安装插件
```bash
$ npm install hexo-filter-mermaid-diagrams
```

3. 修改配置 themes/next/layout/_third-party/tags/mermaid.swig
```
{%- set mermaid_uri = theme.vendors.mermaid or theme.mermaid.cdn %}
```


#### 主题结构查看
>layout #`布局文件`
>>includes              
>>>layout.swig          
>>>pagination.swig      
>>>recent-posts.swig    

>>archive.swig
>>category.swig
>>index.swig
>>page.swig
>>post.swig
>>tag.swig

>source `#资源文件`
>_config_yml `主题配置文件`

