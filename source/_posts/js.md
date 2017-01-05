---
title: js
date: 2016-12-05 04:26:35
tags: [js]
categories: js

---

## 匿名函数

```js
	;(function(jQuery,document,window){ 
	//第一行的分号是为了避免压缩错误
	//第一行是; +号的 作用是将函数转成表达式 假如有個匿名函數
	//  例如：`function(){ console.log('yooo'); }`，要調用它一般用`(function(){ console.log('yooo'); })()`
	//        js 解釋器碰到一開始的左括號就會把後面解釋為一個表達式。而`function(){ console.log('yooo'); }()`
	//        卻會語法錯誤，因為 js 解釋器看到 function 自動默認為函數定義了。這時可以用`!function(){ console.log('yooo'); }()`，
	//        前面的「!」會指引解釋器告訴它後面是一個表達式，所以效果和用括號括住匿名函數定義一樣，但是省一個字符。
		
	})(jQuery,document,window)
```

func的作用域只有在闭包内才有效
```js
	'use strict'    
	;(function(){
		var privateInt = 1; //这个只有在这个闭包内才能使用
		var func = function(){
			console.log(privateInt)
		}
		func()
	})()
```
## 关于对象
```js
	'use strict'
	var plugin = function(){
		this.init = {
			'heigth':187,
			'weight':'56kg'
		};
		this.print = function(){
			console.log(this.init.heigth) //this只能用在当前变量内
		};
		return this //js函数根据返回值来确定对象。
	}

	plugin.prototype.hello = function(){
		console.log("hello,world!"+this.init.heigth)
	}

	var p = new plugin()
	p.print()

	p.hello()
```

### this
加了this就是公有方法  
没加就是私有方法

### 对象中的静态变量
直接类名+方法定义
```
	'use strict'
	var plugin = function(){
	}
	plugin.count = 123;
	console.log(plugin.count)

```

## 关于重构
给个例子 去发散下。
```
	'use strict'
	var plugin = function(){
		console.log(arguments)
	}

	var p = new plugin(123,323)
```



## apply
apply()是函数对象的一个方法，它的作用是改变函数的调用对象
```js
    　　var x = 0;
    　　function test(){
    　　　　alert(this.x);
    　　}
    　　var o={};
    　　o.x = 1;
    　　o.m = test;
    　　o.m.apply(); //0
        o.m.apply(o); //1
```
apply()的参数为空时，默认调用全局对象。因此，这时的运行结果为0，证明this指的是全局对象。


## 如何开发一个js插件
使用匿名函数
```js
	;(function(window){
	    'use strict'
		c = function(){
			
		}
		window.c = C;
	})(window)
```

使用列表的方式
```js
    var _plugin = {
        'proper':{
            'height':100
        },
        'init': function(){
               this.height = _plugin.height;
        }
    }
```