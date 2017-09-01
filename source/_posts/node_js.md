---
title: node.js
date: 2016-10-13 08:47:51
categories: js
tags:
     - node
---

### require对象
> 用于从外部获取一个模块接口,即所获取模块的exports对象.

require将文档作为一个对象引入



### exports对象
> 一个模块可以通过module.exports或exports将函数、变量等导出，以使其它JavaScript脚本通过require()函数引入并使用。

#### module.exports
所有的exports收集到的属性和方法，都赋值给了Module.exports。当然，这有个前提，就是Module.exports本身不具备任何属性和方法。如果，Module.exports已经具备一些属性和方法，那么exports收集来的信息将被忽略。

```
# 一开始会node.js会这么赋值 module.exports=exports＝{};

module.exports = 'ROCK IT!'; //最后返回的时 module.exports 所以下面的 exports.name改动无效。会报错
exports.name = function() {
    console.log('My name is Lemmy Kilmister');
};
```

```
var rocker = require('./rocker.js');
rocker.name(); // TypeError: Object ROCK IT! has no method 'name'
```

其实module.exports才是模块公开的接口，每个模块都会自动创建一个module对象，对象有一个modules的属性，初始值是个空对象{}，module的公开接口就是这个属性——module.exports。


#### 什么时候用module.exports 什么时候用 exports
> 如果你想你的模块是一个特定的类型就用Module.exports。如果你想的模块是一个典型的“实例化对象”就用exports。

##### 类定义
``` 
module.exports = function(name, age) {
    this.name = name;
    this.age = age;
    this.about = function() {
        console.log(this.name +' is '+ this.age +' years old');
    };
};
```

```
var Rocker = require('./rocker.js');
var r = new Rocker('Ozzy', 62);
r.about(); // Ozzy is 62 years old

```
##### 数组定义
```
module.exports = ['Lemmy Kilmister', 'Ozzy Osbourne', 'Ronnie James Dio', 'Steven Tyler', 'Mick Jagger'];
```
```
var rocker = require('./rocker.js');
console.log('Rockin in heaven: ' + rocker[2]); //Rockin in heaven: Ronnie James Dio

```
##### 实例化对象
```
exports.js = "hello,world!"
```
```
var is = require("./is")
console.log(is.js)
```

### [异步](http://www.ruanyifeng.com/blog/2012/12/asynchronous%EF%BC%BFjavascript.html)
#### 什么是异步
```
//异步操作
setTimeout(function(){
    console.log(1000)
},10000);

console.log("hello,world!")
```
>  如上,先输出hello,world,再输出1000
>   我叫你吃饭,不等你回答就去吃了是异步
>   我叫你吃饭,等你回答了再去吃就是同步。

#### 模拟异步回调

1. 执行某个函数 
2. 执行语句A,B,C,D
3. 在D语句发起异步请求，同时向引擎注册一个回调事件 
4. 执行E,F,G ->退出函数块 ，引擎Loop...Loop...Loop，此时异步的请求得到了Response，之前注册的回调被执行。

>通知ABCD吃饭 
```
//通知吃饭
var notice = function(name,callback){
    console.log(name+",你妈叫你回家吃饭了");
    setTimeout(function(){
        callback(name);
    },2000);
}

//通知完毕
var end = function(name){
    console.log(name+"通知完毕");
}

notice("A",end);
notice("B",end);
notice("C",end);
notice("D",end);

```
> 原理就是 f1(f2)

#### 发布订阅

```
pass
 
```
#### promise
回调函数真正的问题在于他剥夺了我们使用 return 和 throw 这些关键字的能力。而 Promise 很好地解决了这一切。

##### 插件安装 (ECMAScript 6 的正式版 )
```
npm install bulebird
```