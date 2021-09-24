---
title: "Markdown"
date: 2021-09-04T09:16:30+08:00
draft: false
author: canbefree
toc:
  auto: false
math:
  enable: true
---

- [Markdown语法](#markdown语法)
	- [数学公式](#数学公式)
	- [mermaid](#mermaid)
	- [标签](#标签)
	- [表格](#表格)
	- [待办事项](#待办事项)
	- [html标签](#html标签)
		- [html转义字符](#html转义字符)
	- [脚注](#脚注)
	- [扩展阅读](#扩展阅读)
		- [数学公式详情](#数学公式详情)
			- [平方](#平方)
			- [求和](#求和)
			- [极限](#极限)
		- [mermaid详情](#mermaid详情)
			- [graph](#graph)
			- [sequenceDiagram](#sequencediagram)
			- [classDiagram](#classdiagram)
				- [uml关系](#uml关系)

# Markdown语法

## 数学公式

mathjax:  https://oysz2016.github.io/post/8611e6fb.html

[goto](#数学公式详情)

`$$ c = \pm\sqrt{a^2 + b^2} $$`
$$ c = \pm\sqrt{a^2 + b^2} $$



## mermaid

[goto](#mermaid详情)



## 标签

标签和颜色
`![](https://img.shields.io/badge/label-msg-yellow)`
![](https://img.shields.io/badge/label-msg-yellow)

标签和默认图标
`![](https://img.shields.io/badge/label-msg-yellow?logo=docker)`
![](https://img.shields.io/badge/label-msg-yellow?logo=docker)

官网图标集合 [https://simpleicons.org/](https://simpleicons.org/)

> 包含空格请用 - 代替 比如 *~~Github Actions~~*  <u>Github-Actions 或 github-actions</u>
`![](https://img.shields.io/badge/label-msg-yellow?logo=Github-Actions)`
![](https://img.shields.io/badge/label-msg-yellow?logo=Github-Actions)





## 表格 

| 表格 | A   | B   |
| ---- | --- | --- |
| A    |     |     |
| B    |     |     |
| C    |     |     |



## 待办事项

- [x] 事项1

  

## html标签
`<kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>k</kbd>`

<kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>k</kbd>

### html转义字符

| 预览       | 编码         | 释义 |
| ---------- | ------------ | ---- |
| &lt;       | `&lt;`       |
| &gt;       | `&gt;`       |
| &amp;      | `&amp;`      |
| &quot;     | `&quot;`     |
| &apos;     | `&apos;`     |
| &copy;     | `&copy;`     |
| &ensp;正文 | `&ensp;`正文 | 缩进 |

## 脚注
`脚注[[^脚注1]]`

`[^脚注1]: 我的脚注释义`

脚注[[^脚注1]]

[^脚注1]: 我的脚注释义


## 扩展阅读

-----------------------------------------

### 数学公式详情

#### 平方

$$
a^22
$$

#### 求和

$$
\sum_{i=1}^na_i
$$

#### 极限

$$
\lim_{x->0}
$$



### mermaid详情

#### graph

```Markdown
graph LR
A --预处理--> B --编译--> C --汇编--> D --"链接(ld)"--> E
```

{{< mermaid >}}
graph LR
A --预处理--> B --编译--> C --汇编--> D --"链接(ld)"--> E
{{< /mermaid >}}

```Markdown
graph RL
A("()")
B(("(())"))
C{{"{{}}"}}
D{"{}"}
```

{{< mermaid >}}
graph RL
A("()")
B(("(())"))
C{{"{{}}"}}
D{"{}"}
{{< /mermaid >}}



```markdown
graph LR
	classDef Relation fill yellow
	classDef Entity fill #cf8d2e
	subgraph 回答
        C(回答)
        C1(题型对应答案)
        C2(开始结束时间)
	end
	C1-->C
	C2-->C
	subgraph 问卷
        A(问卷-Survey)
        A1((编号))
        A2((问券说明))
        A4((描述))
    end
	subgraph 表单
        F(表单-Form)
        F1((表单类型))
        F2((排序))
        F3((标题))
    end
	
	F1-->F
	F2-->F
	
	A1-->A
	A2-->A
	A4-->A
	subgraph 题型
        B(题型-Row)
        B1((编号))
        B4((类型))
        B5((自定义字段))
	end
	subgraph 选项
		Q(选项)
	end

	B1-->B
	F3-->F
	B4-->B
	Q--n---r5--1---B 
	B5-->B
	
	
	U(用户)
	r1{关系1}
	r2{关系2}
	r3{关系3}
	r4{关系4}
	r5{关系5}
	class r1,r2,r3,r4,r5 Relation
	class A,B,C,D,U,F,Q Entity
	
	A --1--- r1  --n--- F
	F --1--- r3--n---B
	
	C --1--- r2 --1--- Q
	U --1---r4--n--- C
	
	
```
{{< mermaid >}}
graph LR
	classDef Relation fill yellow
	classDef Entity fill #cf8d2e
	subgraph 回答
        C(回答)
        C1(题型对应答案)
        C2(开始结束时间)
	end
	C1-->C
	C2-->C
	subgraph 问卷
        A(问卷-Survey)
        A1((编号))
        A2((问券说明))
        A4((描述))
    end
	subgraph 表单
        F(表单-Form)
        F1((表单类型))
        F2((排序))
        F3((标题))
    end
	
	F1-->F
	F2-->F
	
	A1-->A
	A2-->A
	A4-->A
	subgraph 题型
        B(题型-Row)
        B1((编号))
        B4((类型))
        B5((自定义字段))
	end
	subgraph 选项
		Q(选项)
	end

	B1-->B
	F3-->F
	B4-->B
	Q--n---r5--1---B 
	B5-->B
	
	
	U(用户)
	r1{关系1}
	r2{关系2}
	r3{关系3}
	r4{关系4}
	r5{关系5}
	class r1,r2,r3,r4,r5 Relation
	class A,B,C,D,U,F,Q Entity
	
	A --1--- r1  --n--- F
	F --1--- r3--n---B
	
	C --1--- r2 --1--- Q
	U --1---r4--n--- C
	
{{< /mermaid >}}


#### sequenceDiagram

```markdown
sequenceDiagram
    Alice->>John: Hello John, how are you?
    John -->>Alice: Great!
    Alice ->>John: See you later!
```

{{< mermaid >}}
sequenceDiagram
    Alice->>John: Hello John, how are you?
    John -->>Alice: Great!
    Alice ->>John: See you later!
{{< /mermaid >}}

#### classDiagram

##### uml关系

```markdown
classDiagram
classA --|> classB : Inheritance 表示A继承B
```

{{< mermaid >}}
classDiagram
classA --|> classB : Inheritance 表示A继承B
{{< /mermaid >}}

```markdown
classDiagram
classC --* classD : Composition D由C组合而成，当D不存在，C也不复存在
```
{{< mermaid >}}
classDiagram
classC --* classD : Composition D由C组合而成，当D不存在，C也不复存在
{{< /mermaid >}}

```markdown
classDiagram
classE --o classF : Aggregation E 大雁 F 雁群
```

{{< mermaid >}}
classDiagram
classE --o classF : Aggregation E 大雁 F 雁群
{{< /mermaid >}}

```markdown
classDiagram
classG --> classH : Association G关联H  G作为H的成员变量 
```

{{< mermaid >}}
classDiagram
classE --o classF : Aggregation E 大雁 F 雁群
{{< /mermaid >}}

```markdown
classDiagram
classI -- classJ : Link(Solid) 
```

{{< mermaid >}}
classDiagram
classE --o classF : Aggregation E 大雁 F 雁群
{{< /mermaid >}}

```markdown
classDiagram
classK ..> classL : Dependency K依赖L 
```

{{< mermaid >}}
classDiagram
classE --o classF : Aggregation E 大雁 F 雁群
{{< /mermaid >}}

```markdown
classDiagram
class classN{
	<<interface>>
}
classM ..|> classN : Realization    M 实习了 N接口
```

{{< mermaid >}}
classDiagram
class classN{
	<<interface>>
}
classM ..|> classN : Realization    M 实习了 N接口
{{< /mermaid >}}



```markdown
classDiagram
classO .. classP : Link(Dashed)
```

{{< mermaid >}}
classDiagram
classO .. classP : Link(Dashed)
{{< /mermaid >}}







