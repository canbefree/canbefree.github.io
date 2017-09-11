---
title: 优雅的代码格式
date: 2016-10-14 04:40:37
categories: 设计模式
tags:
    - php
    - python
---

### 代码规范
1. 命名规范
> helloWorld(实例化对象,静态变量) hello_world(变量) HelloWorld(类) _helloworld(私有变量) HELLOWORLD(常量) 

2. 函数。

>返回的值避免类型时MIX类型
```
  //打印一段html
  function outPutHtml(){
    if(true) return "<div>HELLO WORLD</div>";
    if(false) return "";
  }
```
>不执行的代码段直接抛出异常 非必要少用日志

3. 日志信息独立成行,异常的等
 

### 数据库规范
三大范式
◆ 第一范式（1NF）：强调的是列的原子性，即列不能够再分成其他几列。 
◆ 第二范式（2NF）：首先是 1NF，另外包含两部分内容，一是表必须有一个主键；二是没有包含在主键中的列必须完全依赖于主键，而不能只依赖于主键的一部分。
◆ 第三范式（3NF）：首先是 2NF，另外非主键列必须直接依赖于主键，不能存在传递依赖。即不能存在：非主键列 A 依赖于非主键列 B，非主键列 B 依赖于主键的情况。


### 设计模式

### 单例模式的一些写法

```
    $object = Example::factory()->func();
```

```
    $object = Example::facory();
    if(!is_object($object)){
      throw new Exception("is not object");
    }
    $object->func();
```

### 工厂模式

代码中可以用switch的地方都可以改成工厂模式。

#### 为什么要使用工厂模式
1.集中化管理。比如你有个日志系统，底层可以用db,file,cache。使用工厂模式可以便于快速切换。
2.解耦。容器（工厂）不用重构。你只需拓展方法就可以了。可扩展性更强。

#### 自己导出数据使用过的例子
初始版本：
```php
class Poker{

    public function __construct($sdate,$edate)
    {
        $this->stime =  strtotime($sdate);
        $this->etime = strtotime($edate)+86399;
    }


    /**
     * 按日导出
     * @param $callback\
     */
    public function export($callback){
        $stime = $this->stime;
        $etime = $this->etime;
       while($stime<=$etime) {
           call_user_func($callback,$stime);
           $stime+=86400;
       }
    }
}

/**
 *  繁体版本场次局数分布状况：level，在该场次玩牌局数为1场的用户数，在该场次玩牌局数为2场的用户数，
 * 在该场次玩牌局数为3场的用户数……在该场次玩牌局数为50场及以上的用户数
 */
function func1(){
    return function($stime){
        echo date("Ymd",$stime) ;
    };
}

$poker = new Poker("2017-02-06","2017-02-19");

$poker->export(func1());
```
改进(添加导出每个操作的初始化，比如初始化csv表头，删除重复的csv等)
```php
interface IExport{
     public function setup();
     public function teardown();
     public function handle();
}

/**
 *  繁体版本场次局数分布状况：level，在该场次玩牌局数为1场的用户数，在该场次玩牌局数为2场的用户数，
 * 在该场次玩牌局数为3场的用户数……在该场次玩牌局数为50场及以上的用户数
 */
class Export1 implements IExport
{
   public function setup(){
       echo "初始化变量";
   }
   public function teardown(){
        echo "销毁变量";
   }
   public function handle(){
        return function($stime){
            echo $stime;
        };
   }
}
    
class Poker{

    public function __construct($sdate,$edate)
    {
        $this->stime =  strtotime($sdate);
        $this->etime = strtotime($edate)+86399;
    }

    /**
     * 按日导出
     * @param $callback\
     */
    public function export(IExport $class){
        $stime = $this->stime;
        $etime = $this->etime;
        $class->setup();
       while($stime<=$etime) {
           call_user_func($class->handle(),$stime);
           $stime+=86400;
       }
       $class->teardown();
    }
}

$poker = new Poker("2017-02-06","2017-02-19");

$poker->export(new Export1());
```

#### 依赖注入(网上找的例子)

超人类似要加工的对象。
模组类似超人组件

绑定好超人的函数。加入超人方法。


```php
class Container
{
    protected $binds;

    protected $instances;

    public function bind($abstract, $concrete)
    {
        if ($concrete instanceof Closure) {
            $this->binds[$abstract] = $concrete;
        } else {
            $this->instances[$abstract] = $concrete;
        }
    }
    
    public function make($abstract, $parameters = [])
    {
        if (isset($this->instances[$abstract])) {
            return $this->instances[$abstract];
        }

        array_unshift($parameters, $this);

        return call_user_func_array($this->binds[$abstract], $parameters);
    }
}
```

```php
// 创建一个容器（后面称作超级工厂）
$container = new Container;

// 向该 超级工厂 添加 超人 的生产脚本  
$container->bind('superman', function($container, $moduleName) {
    return new Superman($container->make($moduleName));
});

// 向该 超级工厂 添加 超能力模组 的生产脚本
$container->bind('xpower', function($container) {
    return new XPower;
});

// 同上
$container->bind('ultrabomb', function($container) {
    return new UltraBomb;
});

// ******************  华丽丽的分割线  **********************
// 开始启动生产
$superman_1 = $container->make('superman', 'xpower');
$superman_2 = $container->make('superman', 'ultrabomb');
$superman_3 = $container->make('superman', 'xpower');
```

### 中间件
关于中间件有两组概念：
1. 中间件是一种通用接口模型。中间件模式为了统一调用，将子类组合封装起来。
2. 中间件是一种重用过程。为原来的流程增加筛选或者标记工序。这个也是我下面要解释的。

#### 简单的例子
成功执行 next1,next2并原封不动返回 request
```python
def next1(request):
	print "next1"
	return request

def next2(request):
	print "next2"
	return request

request = "request"
pipe = [next2,next1,request]


#def xx():
#	def _xx(x,y):
#		return x(y)
#	return _xx

print reduce(lambda x,y:x(y), pipe)
#print reduce(xx(), pipe)

```


#### 稍复杂点的例子
当组装过后,小闭包组合成了一个大闭包。
```python
#!-*-coding=utf-8-*-
class Next1(object):
	def handle(self,next,request):
		print "Next1"
		return next(request)

class Next2(object):
	def handle(self,next,request):
		print "Next2"
		return next(request)

def firstClosure(callable):
	def _xx(request):
		callable(request)
	return _xx

# 初始化callback
N1 = Next1()
N2 = Next2();
next1 = N1.handle;
next2 = N2.handle;


pipes = [next1,next2]

pipes.append(firstClosure)

pipes.reverse();

def getClosure():

	'''
	获得一个大的闭包
	'''
	def bigClosure(firstClosure,one_pipe):
		def warp(request):
			return one_pipe(firstClosure,request)
		return warp
	return bigClosure

callable = reduce(getClosure(), pipes)


callable("request")

```


### 巧用回调
#### 利用回调来解耦
请求第三方服务。如果成功,第三方调用服务器给你的方法。


#### 异步回调
IO,网络,等待耗时等特殊场景常用异步来解决。
1.场景1
同时获取多个网站数据。对返回的数据进行处理。

#### 自定义方法
1.场景1 
>这个要注意安全问题。
array_reduce


### 观察者模式

A1：观察者 
A2: 观察者
B: 主题

在B中注册观察者A1,A2，当B有改变时通知A1,A2 执行update()

优势：解耦：观察者update自定义，不用写在主题逻辑里面。方便扩展：添加观察者简单。不用修改主题。