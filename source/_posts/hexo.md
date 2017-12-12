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
> `$ hexo s -g`   查看效果

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

<br>
<br>

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

##### 借助coding.net部署
1.创建coding账号
2.[创建新的项目](#1)
3.[加入ssh个人秘钥并测试](#2)
4.[修改hexo _config.yml配置文件](#3)
5.push到博客
6.设置coding(点击项目的 **PAGES 服务** )

<span id="1" >项目名称需要和你的用户名一致,不然可能导致你的css文件 **404 error ** </span>
<span id="2" >forget about ** SSH ** it does't work</span>
<span id="3" >
修改git部分
```yaml
deploy:
  type: git
#  repo: https://github.com/canbefree/canbefree.github.io
  repo: https://git.coding.net/canbefree/canbefree.git
  branch: master
```
</span>

<br>
<br>
### HEXO使用

#### 本地图片链接

##### 公共图片文件

将图片资源放到\source\img\swig.PNG

```
![swig](/img/swig.PNG)
```
##### 文章内插图

>修改配置文件
```
_config.yml
post_asset_folder: true # 打开之后 公共图片文件引入方式将不可用
>图片插入

添加图片到一下路径  
\source\_posts\Swig模板\swig.PNG

引用方式
```

```swig
![swig](/swig.PNG)
{% asset_path swig.PNG  %}
{% asset_img swig.PNG %}
{% asset_link swig.PNG  %}
{% asset_img swig.PNG This is an example image %}

```

<br>
<br>
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
#### 关于hexo插件引入
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
### yo自定义主题

#### 生成初始文件
```bash
    npm install generator-hexo-theme
    yo hexo-theme
```
> 取名字 freestyle
> 选择 swig
> 选择 scss
> 选择 bower.json
> 将主题拷贝到项目文件夹下

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

#### 站内搜索

http://blog.niices.com/Hexo-Next-Algolia-Search/