---
title: webpack
date: 2017-07-20 05:35:58
categories: web
tags:
---

# 介绍

对于js,css等前端文件的打包,可以提高网页的打开速度,但是文件一次性加载也会导致初始化过程过慢。复杂的多页面结
构用不到的库也会包含进来。浪费网络带宽。所有如何利用webpack实现资源分块传输,按需实现懒加载。

# 基础使用

## 目录结构

```

dist |
demo |---resource |
                  |---css |
                  |---sass|
                  |---js|
webconfig.config.js
package.json
```

## 重要文件内容

package.json

```json
{
  "name": "demo",
  "version": "1.0.0",
  "description": "demo ",
  "main": "index.js",
  "directories": {
    "test": "tests"
  },
  "scripts": {
    "dev": "npm run development",
    "development": "cross-env NODE_ENV=development node_modules/webpack/bin/webpack.js --progress --hide-modules --config=webpack.config.js"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "bootstrap": "^4.3.1",
    "jquery": "^3.4.1",
    "vue": "^2.6.10"
  },
  "devDependencies": {
    "cross-env": "^5.2.0",
    "css-loader": "^2.1.1",
    "node-sass": "^4.12.0",
    "popper.js": "^1.15.0",
    "sass-loader": "^7.1.0",
    "style-loader": "^0.23.1",
    "webpack": "^4.30.0",
    "webpack-cli": "^3.3.2"
  }
}
```

webpack.config.js
```js
// var ExtractTextPlugin = require('extract-text-webpack-plugin');
const MinCssExtractPlugin = require('mini-css-extract-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin')
const path = require('path');

module.exports = {
    entry: {
        'main': path.resolve(__dirname, 'resources/assets/js/main.js'),
        'vendor': path.resolve(__dirname, 'resources/assets/js/vendor.js'),
        'ext': path.resolve(__dirname, 'resources/assets/js/ext.js'),
    },
    mode: "development",
    output: {
        path: path.resolve(__dirname, '../../dist/demo'),
        filename: '[name].[contenthash].js',
        chunkFilename: 'js/[name].[chunkhash].js'
    },
    resolve: {
        alias: {
            '@': path.resolve(__dirname, 'resources/assets/js'),
            '#': path.resolve(__dirname, 'resources/assets/sass'),
            'vue$': 'vue/dist/vue.common.js'
        }
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                options: {

                    plugins: ['@babel/plugin-syntax-dynamic-import']
                }
            },
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            },
            {
                test: /\.sass$/,
                // use: ['style-loader', 'css-loader', 'sass-loader']
                // use:ExtractTextPlugin.extract(['css-loader', 'sass-loader'])
                use: [MinCssExtractPlugin.loader, 'css-loader', 'sass-loader']
            }
        ]
    },
    plugins: [
        new MinCssExtractPlugin({
            filename: 'css/[name].[hash].css'
        }),

        new HtmlWebpackPlugin({
            filename: 'index.html',    //生成的html存放路径，相对于 path
            chunckTemplate: 'js',
            template: 'view/index.html',    //html模板路径
            inject: true,    //允许插件修改哪些内容，true/'head'/'body'/false,
            chunks: ['main'],//加载指定模块中的文件，否则页面会加载所有文件
            hash: false,    //为静态资源生成hash值
            minify: {    //压缩HTML文件
                removeComments: true,    //移除HTML中的注释
                collapseWhitespace: true//删除空白符与换行符
            }
        }),
    ]
}

```

## 初始化

> npm -i

---

# 疑问

## 问题一
在业务中，一般将js分成两个部分，一个部分如 public.js vendor.js 更新操作比较少,客户端可以保留缓存,还有一部分业务js每次修改必须得更新,所有得考虑如何把业务js,css样式剥离出来。但是按上面的配置,总会再 dist文件生成一个main文件， 那如何打包多个入口的webpack? 如何将css样式等其他资源从main.js文件中剥离出来？

>利用[entry入口](https://www.webpackjs.com/concepts/#%E5%85%A5%E5%8F%A3-entry-)来制定多个入口:

    ```js
    //part
    entry: {
        'main': path.resolve(__dirname, 'resources/assets/js/main.js'),
        'vendor': path.resolve(__dirname, 'resources/assets/js/vendor.js'),
    },
    mode: "development",
    output: {
        path: path.resolve(__dirname, '../../dist'),
        filename: '[name].js'
    },
    //endpart
    ```

>实现css样式的剥离

```
npm install extract-text-webpack-plugin@next  --save-dev (加入@next使用最新beta版来兼容 webpack4)
npm install  mini-css-extract-plugin --save-dev (官方推荐使用这个来提取css文件)
```


>插入一点小知识[loader特性](https://www.webpackjs.com/concepts/loaders/#loader-%E7%89%B9%E6%80%A7)： 
>>use: ['style-loader', 'css-loader', 'sass-loader']  
    这是一个链式传递(反向), sass-loader识别处理后 传递给 css-loader识别处理 然后在通过 style-loader 插入到html中。

    ```js
    //part
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            },
            {
                test: /\.sass$/,
                // use: ['style-loader', 'css-loader', 'sass-loader']
                // use:ExtractTextPlugin.extract(['css-loader', 'sass-loader'])
                use: [MinCssExtractPlugin.loader, 'css-loader', 'sass-loader']
            }
        ]
    },
    //endpart
    //part
    plugins: [
        new MinCssExtractPlugin({
            filename: 'css/[name].css'
        })
    ]
    //endpart
    ```


## 问题二

问题1中。设计到js缓存,所以在webpack打包过程中，如何没有改变(md5值未更新)就需要使用 

```
    new ExtractTextPlugin("css/[name].[contenthash:8].css")
```
> 为什么不使用 [hash] 或者 [chunkhash] 而要使用[contenthash]的[原因](http://www.cnblogs.com/ihardcoder/p/5623411.html),
> 可以这样简单理解：hash是针对所有文件的指纹，chunkhash是针对模块指纹,contenthash是针对输出后的文件内容的指纹。

### 问题三
 如何使用懒加载?

>什么是懒加载？
>>    比如说京东App上是没有分页的，通过下滑实现内容延时加载。
>>    又比如说 多个js文件,有些文件可以等视图出来再加载 (下列解决的是此种情况).

```
 npm i -D  @babel/plugin-syntax-dynamic-import
```

``` js
...
        path: path.resolve(__dirname, '../../dist/demo'),
        filename: '[name].[contenthash].js',
        chunkFilename: 'js/[name].[chunkhash].js'  //未被列入entry的js文件
...
```

这样就可以使用 import() 方法进行动态加载了。

```js
setTimeout(function () {
    import("./ext")
}, 5000)
```

### 问题4
如何根据直接生成html文件

```
 npm i -D html-webpack-plugin
```

``` json
        ...
        new HtmlWebpackPlugin({
            filename: 'view/index.html',    //生成的html存放路径，相对于 path
            template: 'view/index.html',    //html模板路径
            inject: true,    //允许插件修改哪些内容，true/'head'/'body'/false,
            chunks: ['vendors', 'app'],//加载指定模块中的文件，否则页面会加载所有文件
            hash: false,    //为静态资源生成hash值
            minify: {    //压缩HTML文件
                removeComments: true,    //移除HTML中的注释
                collapseWhitespace: true    //删除空白符与换行符
            }
        }),
        '''
```
