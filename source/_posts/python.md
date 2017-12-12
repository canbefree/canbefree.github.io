---
title: python基本语法
date: 2017-01-03 07:50:37
tags:
---


python 简单易用 掌握少许的基本语法就能解决一大推问题。


----------------
### IPYTHON
#### 查看 %magic

```python
import random
random??
random?
```

### python处理文件
1.打开文件(最好用上下问管理的方式打开,这样能保证资源的释放 ** with **)
```python

```
2.删除文件
3.获取文件信息


 
#### 示例 (某次批量处理文件用到的)
```python
import os
import json

def process(line):
	api = line.split('|')[3]
	if api.split('#')[2] in ['task.apiv1','others.fuckcrash','usericon.iconupload','changeinfo.userinfo','payment.dealorder','payment.applevoucher','.android','core.facebook']:
		return False
	params = api.split('#')[3]
	ret = auth(params)
	if ret:
		print(api)

def auth(params):
	dirs = json.loads(params)
	if dirs['mid'] == 0:
		return False
		
	if dirs['version'] in ["3.2","3.0.0","1","21","3.7","3.4","19","28","17","27","25","3.8","32","33","31","16"]:
		return False

	return True

with open("no_auth_online20161231","r") as f:
	for line in f:
		process(line)
```

### python 存储

#### python socket

#### python redis



#### 关于threading里面的 join setDaemon
##### join
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

### 

```python

    from optparse import OptionParser  
    [...]  
    parser = OptionParser()  
    parser.add_option("-f", "--file", dest="filename",  
                      help="write report to FILE", metavar="FILE")  
    parser.add_option("-q", "--quiet",  
                      action="store_false", dest="verbose", default=True,  
                      help="don't print status messages to stdout")  
      
    (options, args) = parser.parse_args()  

```


### pip install 编译错误

#### 利用wheel跳过编译
##### 安装wheel
```
    pip install wheel
```
##### 下载编译好的whl包
[点击跳转](http://www.lfd.uci.edu/~gohlke/pythonlibs/#lxml) `http://www.lfd.uci.edu/~gohlke/pythonlibs/#lxml`

##### pip install 文件路径
```
   pip install C:\Users\NeoXie\Downloads\MySQL_python-1.2.5-cp27-none-win_amd64.whl  pip install 
```
