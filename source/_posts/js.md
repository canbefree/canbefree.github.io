---
title: js
date: 2016-12-05 04:26:35
tags: [js]
categories: js

---
js.. 

----

### js 基本语法

#### js对象
js索引不用写成字符串形式
```js
	var a = "123";
	console.log({a:a}) //output: {a:123} 
```

#### use strict 
js文件开头记得加上这个。
```js
 "use strict";
```
#### 匿名函数
匿名函数能够有效的减少全局变量,配合var声明 也可以让js变得十分优雅。

匿名函数可以用来声明全局的函数,比如下面 nAdd方法,这样这个方法就变成全局的了。

```js
	var nAdd;
　　function f1(){
　　　　var n=999;
        nAdd = function(){
			n=n+1;
		}
　　　　function f2(){
　　　　　　alert(n);
　　　　}
　　　　return f2;
　　}
　　var result=f1();
　　result(); // 999
　　nAdd();
　　result(); // 1000
```

#### 闭包
理解闭包首先得理解函数的变量的作用域。


```js 
    //一个最简单的闭包
	var warp = function(){
		var i =3;
		var c = function(){
			i++;
			return i;
		}
		return c;
	}

	var func = warp();
	console.log(func());
	console.log(func());
```

一般来说,调用一个函数，解释器分配一块独立的内存来处理。当函数的工作完成，编译器便会回收这块内存。
这是意外发生了,函数返回了一个函数引用。 当 ** var func = warp();**  func是全局的。导致函数c一直存在一个对象引用。
编译器无法回收 ** c **,这时闭包产生了。


#### 关于对象
静态方法和变量（这个不深究,感觉没什么用）

prototype 原型方法
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

prototype 继承
```js
	var Animal = function(){
	}

	Animal.prototype.getName = function(){
		console.log(this._name);
	}

	Animal.prototype.setName = function(name){
		this._name = name;
	}

	var Person = function(){
		this.speak = function(){
			console.log("I'm a man");
		}
	}

	Person.prototype = new Animal()

	var p = new Person()
	p.setName("xiaoming")
	p.getName()
	p.speak();
```
** new做了哪些事情？ **
当代码var p = new Person()执行时，new 做了如下几件事情：
创建一个空白对象
创建一个指向Person.prototype的指针
将这个对象通过this关键字传递到构造函数中并执行构造函数。


#### this

加了this就是公有方法,没加就是私有方法

>如何理解 
>1. this指的是，调用函数的那个对象 
>2. this 不能被赋值，但可以被 call/apply  改变 

1. this 和构造器
```js
function Tab(nav, content) {
  this.nav = nav
  this.content = content
}
```
1. this 和对象
```js
	var a = {
		"hello":function(){
			console.log("hello,world!");
		},
		"test":function(){
			this.hello();
		}
	}   
	a.test()
```
1. this 和函数
坚决杜绝在 纯函数内使用 this，但有时候会这么写，调用方式使用 call/apply
```js
function showMsg() {
  alert(this.message)
}
  
var m1 = {
  message: '输入的电话号码不正确'
}
var m2 = {
  message: '输入的身份证号不正确'
}
  
showMsg.call(m1) // '输入的电话号码不正确'
showMsg.call(m2) // '输入的身份证号不正确'
```
1. 全局环境的 this
1. this 和 DOM/事件
1. this 可以被 call/apply 改变
1. ES5 中新增的 bind 和 this
1. ES6 箭头函数(arrow function) 和 this




#### 对象中的静态变量
直接类名+方法定义
```
	'use strict'
	var plugin = function(){
	}
	plugin.count = 123;
	console.log(plugin.count)

```

#### 关于重构
给个例子 去发散下。
```
	'use strict'
	var plugin = function(){
		console.log(arguments)
	}
	var p = new plugin(123,323)
```



#### apply 和 call方法
apply和call基本的区别是参数不同 apply后面接数组 call后面接参数

它们的作用是改变函数的调用对象
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

call实现继承
```js
	var Animal = function(){
		this.getName = function(){
		console.log(this._name);
		}

		this.setName = function(name){
		this._name = name;
		}
	}	

	var Person = function(){
		Animal.call(this)
		this.speak = function(){
			console.log("I'm a man");
		}
	}

	var p = new Person()
	p.setName("xiaoming")
	p.getName()
	p.speak();
```


#### 如何开发一个js插件
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


### js 跨域
