---
title: SHELL脚本
date: 2016-10-25 03:55:59
categories: liunx
tags: 
    - shell
    - vagrant
---



## 基本语法


### 变量


#### 语句赋值
```bash
for file in `ls /etc`;do
    echo $file;
done
```
#### 单引号 双引号
类似php,单引号会屏蔽对转义字符的引号,双引号不会屏蔽转义
例子
```bash
ps aux|awk -F ' ' '{print $1}'
ps aux|awk -F ' ' "{print \$1}"
```

#### 使用变量
```
skill="12312" #赋值前后不要留空格 
echo "I am good at ${skill}Script"
echo $skill
```
#### 修改变量
变量被删除后不能再次使用。unset 命令不能删除只读变量。
``` bash
myUrl="http://www.w3cschool.cc"
readonly myUrl
my="http://www.w3cschool.cc"
unset my
```

#### 变量声明
在脚本或命令中定义，仅在当前shell实例中有效
```bash
PATH=/usr/bin
export PATH
```

#### 字符串

```bash
str='this is a string' #单引号字串中不能出现单引号（对单引号使用转义符后也不行）。

string="abcd"   #获取字符串长度 
echo ${#string} #输出 4

string="runoob is a great site"  #提取子字符串 
echo ${string:1:4} # 输出 unoo

string="runoob is a great company" #查找子字符串
echo `expr index "$string" is`  # 输出 8

```

##### DATE
DATE --help

date +"%Y%m%d"

#### 数组
```
array_name=(value0 value1 value2 value3)
valuen=${array_name[n]}
echo ${array_name[@]} #使用@符号可以获取数组中的所有元素
```


#### 赋值格式 
```bash
i=0 #前后不能有空格
```

### 参数传递
|参数处理 |说明|
|：---|：----|
|$1  | 第一个参数|
|$#   | 传递到脚本的参数个数|
|$* | 以一个单字符串显示所有向脚本传递的参数|
|$$|脚本运行的当前进程ID号|
|$!|后台运行的最后一个进程的ID号|
|$@|与$*相同 但返回数组|
|$-|显示Shell使用的当前选项，与set命令功能相同|
|$?|显示最后命令的退出状态 或者函数的返回值|


### 比较符号
| 符号    |      描述    | 
|: ------------- |:-------------:| 
| =  -eq   | 相等  |
| =  -ne   | 相等  |
| >  -gt | 大于      |
| <  -lt | 小于      |
| >  -ge | 不小于      |
| <  -le | 不大于      |
| !  -z | 是否为null      |

### 逻辑判断

#### for 

```angular2html
for i in 1 2 3 4;do
    echo $i;
done
```

#### if 
```
if [ 0 == 0 ];then #必须有空格 一般条件语句都要用空格分隔开。一般赋值都不允许有空格
    
fi
```
#### [ -x $nginx]
| 符号    |      描述    | 
|: ------------- |:-------------:| 
| x  | 如果文件存在且可执行则为真  |
| f   | 如果文件存在且为普通文件则为真  |
| c | 如果文件存在且为字符型特殊文件则为真    |
| -b | 如果文件存在且为块特殊文件则为真    |
| w | 如果文件存在且可写则为真    |
| e| 如果文件存在则为真        |
| = |   字符串等于则为真 |
| != |   字符串不相等则为真 |
| -z |   字符串的长度为零则为真 |
| -n |   字符串的长度不为零则为真 |
| -a |   and 与 |
| -o |   or 或 |
#### case in 
```
read aNum
case $aNum in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac
```

#### while 
```
while true;do
sleep 1
echo "hello,world!"
done
```


### 函数
#### 函数定义和使用
```
function def(){
echo "hello,world";
return 1;
}

def
```
1. 函数必须先定义才能使用
2. def #函数的调用不能加 小括号 如 def() 这样是错误的
3. echo $?  #输出 def 的返回值。

### 执行外部程序
```bash
dir_list = $(ls)
dir_list = `ls`
exec ls
```
exec : 执行exec 当前上下文就直接结束了。此时不会输出 "done"
```bash
exec ls
echo done
```

$(),`` 方法类似，都是直接执行,并将结果返回。

### EOM
```bash
cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
baseurl=http://download.fedoraproject.org/pub/epel/7/\$basearch
enabled=1
gpgcheck=0
EOM
```


### sed命令
```bash
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
```
*sed 是一种在线编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有 改变，除非你使用重定向存储输出。Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。[link](http://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856901.html)*    


### 小试牛刀
守护脚本
```bash
#/bin/bash
while true;
do
content=` lsof demo.sh|awk -F ' ' '{print($2)}'|grep -e "[^PID]"`
echo "ss",$content;
if [ ! -n "$content" ];then
        nohup ./demo.sh &
        echo "restart sh"
fi
sleep 1
done
```
时间日期遍历
```bash 
#!/usr/bin/env bash
date1="$2"
date2="$1"

echo "start:{$date2} end: {$date1}"

tempdate=`date -d "-0 day $date1" +%F`
enddate=`date -d "-0 day $date2" +%F`
tempdateSec=`date -d "-0 day $date1" +%s`
enddateSec=`date -d "-0 day $date2" +%s`

echo "##########################"

echo 'tempdate:'$tempdate
echo 'enddate:'$enddate


for i in `seq 1 300`;do
    if [[ $tempdateSec -lt $enddateSec ]]; then
        break
    fi
    echo $tempdate

    tempdate=`date -d "-$i day $date1" +%F`
    tempdateSec=`date -d "-$i day $date1" +%s`
done

```

```
    
```