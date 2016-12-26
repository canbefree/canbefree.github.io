---
title: python optparse模块
date: 2016-10-27 05:25:31
categories: python
tags:
    - python
---

### 功能
>易于使用，可以方便地生成标准的、符合Unix/Posix 规范的命令行说明[link](http://www.cnblogs.com/captain_jack/archive/2011/01/11/1933366.html)


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

