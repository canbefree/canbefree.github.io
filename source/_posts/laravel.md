---
title: laravel
date: 2016-11-07 04:44:55
tags:
    - php
    - laravel
---

### laravel介绍 

快速开发,composer,less

### laravel注意事项
> 搭建的时候 一定要把域名的根目录指向 *public*.因为laravel中是相对*public*定位文件位置。
> php artisan clear-compiled //不生成编译文件

### 如何正确使用中间件
#### 创建中间件
```bash
php artisan make:middleware Bysso/AuthMiddleware
```
#### 激活中间件
>我们需要在使用前注册每一个中间件。在Laravel有两种类型的中间件。  

1.全局中间件 
  所有的路由都会生效。  
2.路由中间件  
  某个路由配置使用到这个中间件才会生效。


### 服务提供者(PROVIDER)

为什么要用服务提供者？
1.我建立了一个服务，当应用需要调用这个服务的时候，就引用它。后来业务增长，代码到处都用到了这个服务。
有一天这个服务废弃了,我需要遍历所有的代码去修改它。岂不是很不方便。（代码迁移,修改类名,基础架构修改比如DB存储和分布式存储）


>创建一个服务提供者的总结：
1.先创建一个服务类的接口，规范，
2.创建服务类，
3.然后创建服务提供者
4.注册服务提供者，最后调用服务

你可以完全不使用Service Provider
```
$app->make('APP\Model\Example');
```

#### 创建Service类
service类提供方法

#### 创建provider
provider 注册服务

```
class AuthServiceProvider extends ServiceProvider
{    
    public function register()
     {
         $this->app->singleton('AjaxResponseService', function () {
             return new \App\Services\AjaxResponse();
         });
     }
}
```

```php
<?php #file config/app.php
#.....
    'providers' => [
            /**
         * 自己创建的facade
         */
        \App\Providers\TestServiceProvider::class,

    ],
#.....
```

> 实现注入依赖。用对象名就可以调用service方法。方便后期维护，service的名称和内容都可以修改。只要provider 注册时修改到对应的类。

```
AjaxResponseService $service;
$service->callMe(""); 
```



#### FACADE
1. laravel5创建一个facade，可以将某个service注册个门面，这样，使用的时候就不需要麻烦地use 了
2. facade调用service方法都通过静态方法调用。
3. 使用facade前提必须注册provider,以及配置他的别名

```php
<?php #file config/app.php
#.....
    'aliases' => [
            /**
         * 自己创建的facade
         */
        'TestF' => App\Facades\TestFacade::class,

    ],
#.....
```

```php
<?php  #facade方法调用都是静态方法。 如TestF::callMe("TestController");
    ·····
    public static function __callStatic($method, $args)
    {
        $instance = static::getFacadeRoot();

        if (! $instance) {
            throw new RuntimeException('A facade root has not been set.');
        }

        return $instance->$method(...$args);
    }
?>
```

3. 单例调用,返回改别名绑定的类。
```php
<?php
    ·····
    protected static function resolveFacadeInstance($name)
    {
        if (is_object($name)) {
            return $name;
        }

        if (isset(static::$resolvedInstance[$name])) {
            return static::$resolvedInstance[$name];
        }

        return static::$resolvedInstance[$name] = static::$app[$name];
    }
?>
```

### 事件
>记录一个click路由每个id的提交次数。
#### 生成类
指定文件\app\Providers\EventServiceProvider.php
```php
    protected $listen = [
        'App\Events\SomeEvent' => [
            'App\Listeners\EventListener',
        ],
    ];
```
> 执行 php artisan event:generate 生成 app\Events\SomeEvent.php 以及 app\Listeners\EventListener.php 文件

#### 初始化事件
修改SomeEvent构造方法
```php
    public function __construct($post)
    {
        //
        $this->post = $post;
    }
```

#### 定义监听事件
修改 EventListener
```php
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct(Store $session)
    {
        //
        $this->session = $session;
    }

    /**
     * Handle the event.
     *
     * @param  SomeEvent  $event
     * @return void
     */
    public function handle(SomeEvent $event)
    {
        $post = $event->post;
        $key = "click:".$post;
        $value = $this->session->get("$key")+1;
        $this->session->set($key,$value);
    }
```

#### 触发事件
```php
use Illuminate\Session\Store;

class TestController extends Controller
{

    //依赖注入
    public function __construct(Store $session)
    {
        $this->session = $session;
    }


    public function click($id = 0)
    {
        $key = "click:".$id;
        Event::fire(new SomeEvent($id));
        echo "该界面已经被点击了";
        var_export($this->session->get($key));
    }
}
```

### 邮件设置
#### 完善配置
```ini
MAIL_DRIVER=smtp
MAIL_FROM_ADDRESS=  //用户邮件地址
MAIL_HOST=mailtrap.io //邮件服务器，可以去邮件设置查看。
MAIL_PORT=2525 //ssl 默认 465
MAIL_USERNAME=null  //用户名
MAIL_PASSWORD=null  //用户密码
MAIL_ENCRYPTION=null //根据端口选择对应的加密方式
MAIL_FROM_NAME=neoxie //发送人姓名
```
#### 发送纯文本邮件
```php
        Mail::raw('你好，我是PHP程序！', function ($message) {
            $to = '452198757@qq.com';
            $message ->to($to)->subject('纯文本信息邮件测试');
        });

```

#### 发送html邮件
> 这个需要创建 mails.test模板
```
        $name = '谢宇天';
        $flag = Mail::send('mails.test',['name'=>$name],function($message){
            $to = '452198757@qq.com';
            $message ->to($to)->subject('邮件测试');
        });
```




### Elixir 

> 注意,首先前端不是我的工作重点（这点一定要牢记）,你知道知道怎么利用 sass 定制自己的 bootstrap 就可以了。
#### gulp
1.npm install
2.npm install gulp
3.yum install libnotify #Error in plugin 'gulp-notify' not found: notify-send

#### module 不存在
直接npm安装 缺啥安装啥。

#### 基本语法
```js
elixir(function(mix) {
    mix.sass('app.scss'); //编译scss
    mix.browserify ('app.js')//编译 js
    mix.styles([     //合并css文件
        'test1.css',
        'test2.css'
    ]);
    mix.scripts([     //合并js文件
        'test1.js',
        'test2.js'
    ]);
    
    mix.stylesIn('public/css'); //合并目录下的css文件
    mix.scriptsIn('public/js'); //合并目录下的js文件
    
    mix.version("css/all.css"); //哈希化文件名 elixir()可以正确加载到该文件
});
```
### blade模板
#### extents
相当于 require

####  yield
插入一个片段,配合section实现
```
@yield('content')
```

#### section
定义一个判断
```
@section('content')
    @@parent <!-- 不是覆盖 而是引入-->
    页面的内容
@endsection
```
#### 关于打印
Hello, @{{ $name }}. // 输出 Hello, {{ $name }}.
Hello, {!! $name !!}. //输出name的内容 不转义


#### 语法糖
```
{{ $name or 'Default' }} //{{ isset($name) ? $name : 'Default' }}
```
```
@if (count($records) === 1)
    I have one record!
@elseif (count($records) > 1)
    I have multiple records!
@else
    I don't have any records!
@endif
```
```
@unless (Auth::check())
    You are not signed in.
@endunless
```
```
@for ($i = 0; $i < 10; $i++)
    The current value is {{ $i }}
@endfor

@foreach ($users as $user)
    <p>This is user {{ $user->id }}</p>
@endforeach

@forelse ($users as $user)
    <li>{{ $user->name }}</li>
@empty
    <p>No users</p>
@endforelse

@while (true)
    <p>I'm looping forever.</p>
@endwhile
```


### 单元测试
####安装phpunit
```bash
➜ wget https://phar.phpunit.de/phpunit.phar

➜ chmod +x phpunit.phar

➜ sudo mv phpunit.phar /usr/local/bin/phpunit

➜ phpunit --version
PHPUnit 5.4.0 by Sebastian Bergmann and contributors.
```

#### 执行测试
```console
$ phpunit
```
#### 编写测试用例
```console
php artisan make:test SigTest

php artisan make:model Models/SigModel
```
```php
class SigModel extends Model
{
    //生成sig签名
    public static function sign($post){
        unset($post['sig']);
        sort($post);
        return md5(serialize($post));
    }


    public static function checkSig($post){
        $sig = $post['sig'];
        unset($post['sig']);
        $sign = self::sign($post);
        return $sig == $sign?true:false;
    }
}
```

```php
use App\Models\SigModel;
class SigTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testExample()
    {
        $post = array('11',123,123,123);
        $post['sig'] = SigModel::sign($post);
        $this->assertTrue(SigModel::checkSig($post));
    }
}
```




