---
title: C plus
date: 2016-10-25 05:16:08
categories: cpp
tags:
    - cpp
---

使用广泛,难以被淘汰。 C给我的认知是这个。 
-----

### 数据结构

#### 字符串数组声明
```cpp
    char dog[2] = "ab";//error 想想为什么
```

#### 结构体
> 声明(结构声明必须在使用前)
```cpp
    struct student{
    	char name[10];
    	unsigned int age;
    }stu1,stu2;
```
> 赋值
```cpp
    stu1 = {"小明",10}; 
```
结构体在定义的同时内存已经划分好。所以不容许单独变量赋值。除非他是一个对象或者指针。
```cpp
    stu1.name = "小明"; //error 字符数组不能这样直接赋值。
    stu1.name[10] = "小明"; //yes 
```
#### 枚举
```cpp
enum Week {monday,tuesday,wednesday,thursday,friday,saturday,sunday}; //取值为 0-7
enum Bits {one =1, two=2, three=5}; //取值为 0-5
```
#### 容器


#### 指针
一定要在对指针应用接触引用运算符（*）之前，将指针初始化为一个确定的，适当的地址。
```cpp
    long * fellow;
    * fellow = 223323; //error
    
    long * fellow = new long;
    * fellow = 223323; //yes
```
new 分配指针地址  
delete **只能**用来释放new分配的内存。 delete ps; 指针本身未删除,可以重新用new分配内存。
    

### 重载


#### 函数模板
```cpp
template <typename AnyType>

AnyType Sum(AnyType a, AnyType b){
	return a + b;
}
```
#### 类模板
```cpp
template <class Type,int n>
class Simple{
private:
	Type _i;
public:
	Simple(Type i){
		_i = i;
	}
	void echo(){
		cout << n << endl;
		cout << _i << endl;
	}
};

void main(){
	Simple<int,5> simple(1);
	simple.echo();
	cin.get();
}
```


#### 运算符重载
```cpp

class Time{
private:
	int _second;
	int _minute;
	int _hour;
public:
	Time(){
	}
	Time(int second, int minute, int hour){
		_second = second;
		_minute = minute;
		_hour = hour;
	}

	Time operator+(const Time t)const{
		Time sum;
		sum._second = t._second + _second;
		sum._minute = t._minute + _minute;
		sum._hour = t._hour + _hour;
		return sum;
	}

	Time operator++(){
		_second++;
		_minute++;
		_hour++;
		return *this;
	}

	Time operator++(int){
		Time tmp = *this;
		_second++;
		_minute++;
		_hour++;
		return tmp;
	}

	void echoTime(){
		cout << "现在时间:" << _hour << ":" << _minute << ":" << _second << endl;
	}

	friend  ostream & operator<< (ostream & os, Time &t); //友元
};


ostream & operator << (ostream & os, Time & t){
	os << "now time:" << t._hour << ":" << t._minute << ":" << t._second;
	return os;
}

int _tmain(int argc, _TCHAR* argv[])
{	
	Time time1 = Time(1, 4, 5);
	Time time2 = Time(2, 3, 5);
	Time time3 = time1 + time2;
	cout << time3 << endl;

	Time time4 = ++time1;
	cout << time4 << endl;
	cout << time1 << endl;

	Time time5 = time2++;
	cout << time5 << endl;
	cout << time2 << endl;

	cin.get();
}

```

### 虚方法

```cpp
class A{
private:
	int a;
public:
	virtual void echo();
};

class B :public A{ //公有继承
private:
	int b;
public:
	virtual void echo();
};

void A::echo(){
	cout << "A" << endl;
}

void B::echo(){
	cout << "B" << endl;
}


int main(){
	A a;
	B b;

	A & c = a;
	c.echo();
	A & d = b;
	d.echo();

	cin.get();
	return 0;
}

```


### 继承
####  拷贝构造
> 发生对象初始化
> 按值传参
> 返回按值传递的对象。
> 一些临时变量等。

#### 赋值引用
> 重载运算符 =

### const

```cpp
class Room{
private:
	char *_name;
public:
	Room(){
		this->_name = "办公";
	}
	void printName(){
		cout << _name << endl;
	}

	int setName(const char * &name) const{ // 第一个const表示参数不允许许改变。改成引用传参速度更快。
	                                        //第二个表示函数体类不允许成员变量赋值。 
		strcpy_s(_name,20,name);
        return true;
	}

};
```