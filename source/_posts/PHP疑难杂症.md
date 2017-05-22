---
title: PHP疑难杂症
date: 2016-10-09 10:39:49
categories: php
tags:
    - php
---

记录一些简单 但是容易出错的。
### 绝对路径和相对路径
> 相对路径都是参考入口文件的。。。！！！！


### 关于 = 和 || 优先级问题。
```php
<?php
        if (!$flag = false || true) {
            echo "hahah";
        }else{
            echo "hello,world!";
        }
?>
```
不会输出"hahah",因为 || 的优先级比 = 高 导致 

正确写法:
```
<?php
        if ((!$mid = "123456") || true) {
            echo "hahah";
        }
?>
```

### 关于threading里面的 join setDaemon
#### join
```python
def pr(i):
	time.sleep(1)
	print "log:"+str(i)


if __name__ =="__main__":
	for i in range(0,100):
		t = threading.Thread(target=pr,args=(i,))
		t.start()
		t.join()
	print "done"

```
>结果是一秒输出一行。

当子线程执行时，主线程必须等待他结束方可继续执行。所以阻塞了。
