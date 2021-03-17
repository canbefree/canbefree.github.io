---
title: jquery
date: 2016-10-09 04:26:35
tags: [jquery,js,web]
categories: js

---

### $.extent
为扩展jQuery类本身添加新的方法。
 
#### 原型
extend(dest,src1,src2,src3...);


省略dest 将mix方法合并到jquery全局对象里面去。
```js
	$.extend({
		mix:function(){console.log("mix")}
	})
	$.mix()
```

####重载模型
extend(boolean,dest,src1,src2,src3...) //false 浅拷贝 true深拷贝
var result=$.extend( true, {},
{ name: "John", location: {city: "Boston",county:"USA"} },
{ last: "Resig", location: {state: "MA",county:"China"} } ); 

### $.fn
fn代表对象实例化

jQuery.fn = jQuery.prototype 

```js
  	$.fn.alertClick = function(){
  		$(this).click(function(){
  			console.log($(this).val())	
  		})
  	};	
  
  	//新加一个方法。点击输出文本内容
  	$('#text').alertClick();  
```

用索引的方式
```js
	$.fn['alertLen'] = function(){
			$(this).click(function(){
				console.log($(this).val());
			})
		};
```

### $.fn.extent
给jQuery对象添加多个方法
```js
	$.fn.extend({
		'alertClick':function(){
			$(this).click(function(){
				console.log($(this).val());
			});
		},
		'alertLen':function(){
			$(this).click(function(){
				console.log($(this).val().length)
			});
		}
		});	

	//新加一个方法。点击输出文本内容
	$('#text').alertLen();
```
### $.data
```
    jQuery.data( document.body, "bar", "test" );
```


### 如何编写一个juery插件
1. 匿名函数 避免污染环境变量
2. 确定最终插件的使用方式 $.fn.extend  $.extend
3. $.data()方法实现 模块的单例绑定

#### 什么时候用$.fn 什么时候用 $.extend
$.fn = $.prototype

所以 $.fn.extend 是拓展一个方法到实例化的对象上 而 $.extend是添加 Jquery类的静态方法。


```js
    $.fn.yiiGridView = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist in jQuery.yiiGridView');
            return false;
        }
    };
```
等价于
```js
var yiiGridView = function (method) {
                          if (methods[method]) {
                              return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
                          } else if (typeof method === 'object' || !method) {
                              return methods.init.apply(this, arguments);
                          } else {
                              $.error('Method ' + method + ' does not exist in jQuery.yiiGridView');
                              return false;
                          }
                      };
$.fn.extend(yiiGridView);
```
