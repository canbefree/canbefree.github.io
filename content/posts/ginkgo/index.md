---
title: "Ginkgo"
date: 2021-09-01T22:12:51+08:00
author: canbefree
tags: 
- golang
- test
draft: false
categories: [ golang ]
---

- [TDD BDD](#tdd-bdd)
- [ginkgo](#ginkgo)
  - [基础用法](#基础用法)
  - [HOOKS](#hooks)
    - [BeforeSuite 和 AfterSuite](#beforesuite-和-aftersuite)
    - [beforeeach](#beforeeach)
    - [JustBeforeEach](#justbeforeeach)
  - [Describe, Context It and Specs by](#describe-context-it-and-specs-by)
  - [跳过代码](#跳过代码)
  - [Focused](#focused)
  - [Parallel Specs](#parallel-specs)
  - [避免污染测试](#避免污染测试)
  - [异步测试](#异步测试)
  - [Benchmark Tests](#benchmark-tests)
## TDD BDD

测试驱动开发 (TDD)： 敏捷开发，测试先行；

行为驱动开发: 帮助开发人员design软件，换言之，BDD 展开来讲可以当作一个设计文档来阅读 （适合DDD领域驱动）

## ginkgo 
一个BDD框架

### 基础用法
` ginkgo bootstrap // 初始化套件 `


` ginkgo generate demo //生成一个测试 `

### HOOKS

#### BeforeSuite 和 AfterSuite

```go
func TestV1(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "V1 Suite")
}

var _ = BeforeSuite(func() { // 可以用来初始化DB
	fmt.Println("hello,world!")
})

var _ = AfterSuite(func() {
	
})

```

> Both `BeforeSuite` and `AfterSuite` can be run **asynchronously** by passing a function that takes a **Done** parameter.

> 有test-pollution,所以Done被 deprecated 

**推荐方式**

```go
It("...", func() {
	done := make(chan interface{})
	go func() {
		// user test code to run asynchronously
		close(done) //signifies the code is done
	}()
	Eventually(done, timeout).Should(BeClosed())
})
```



https://github.com/onsi/ginkgo/blob/v2/docs/MIGRATING_TO_V2.md#removed-async-testing

#### beforeeach
执行时机：每个单元测试的开始​,负责初始化或重置

```go
    BeforeEach(func() {
        book, err = NewBookFromJSON(`{
            "title":"Les Miserables",
            "author":"Victor Hugo",
            "pages":2783
        }`)
    })
```



#### JustBeforeEach
> 会在所有的beforeEach 后运行

```go
// JustBeforeEach 
var _ = Describe("Main", func() {
	var c int
	BeforeEach(func() {
		c = 2
	})
	JustBeforeEach(func() { // 
		c = 3
	})
	Describe("c", func() {
		BeforeEach(func() { // 这里不会被覆盖
			c = 4
		})
		It("should be a 3", func() {
			Expect(c).To(Equal(3))
		})
	})

})
```



### Describe, Context It and Specs by

**describe** ：   describe the individual behaviors of your code   一个行为一个describe 比如说下单

*context*:  exercise those behaviors under different circumstances 每个行为中不同场景： 下单成功，下单失败

Specs就是 Context 的别名，让代码可读性更强。

It： single specs 最小场景 申明用例, 期望这个用例得到的结果

by: 添加注释用的 用ginkgo -v 才能看到



### 跳过代码

Using the `P` and `X` prefixes

Skip 

### Focused 

专注模式 using the F prefixes

### Parallel Specs

并发模式 

>  ginkgo -p 

> ginkgo -p -nodes=N (默认nodes = runtime.NumCPU())

并发模式下第三方进程管理：

```go
"github.com/onsi/ginkgo/config"

config.GinkgoConfig.ParallelNode  parameter is the index for the current node (starts with 1, goes up to N)
```

并发模式下的单例：先创建db实例，再初始化所有的 client 

```go
// SynchronizedBeforeSuite

var _ = SynchronizedBeforeSuite(func() []byte {
    port := 4000 + config.GinkgoConfig.ParallelNode

    dbRunner = db.NewRunner()
    err := dbRunner.Start(port)
    Expect(err).NotTo(HaveOccurred())

    return []byte(dbRunner.Address())
}, func(data []byte) {
    dbAddress := string(data)

    dbClient = db.NewClient()
    err = dbClient.Connect(dbAddress)
    Expect(err).NotTo(HaveOccurred())
})
```

### 避免污染测试

> 每个变量需要通过beforeeach 来声明.这边变量才会在Context下重新初始化

```go
var _ = Describe("When reading a book", func() {                                        //L1'
    var book *books.Book                                                                //L2'
    book = books.New("The Chronicles of Narnia", 300) // create book in parent closure  //L3'   错误！

    It("should increment the page number", func() {                                     //L4'
        err := book.Read(3)                                                             //L5'
        Expect(err).NotTo(HaveOccurred())                                               //L6'
        Expect(book.CurrentPage()).To(Equal(4))                                         //L7'
    })                                                                                  //L8'

    Context("when the reader finishes the book", func() {                               //L9'
        It("should not allow them to read more pages", func() {                         //L10'
            err := book.Read(300)                                                       //L11'
            Expect(err).NotTo(HaveOccurred())                                           //L12'
            Expect(book.IsFinished()).To(BeTrue())                                      //L13'
            err = book.Read(1)                                                          //L14'
            Expect(err).To(HaveOccurred())                                              //L15'
        })                                                                              //L16'
    })                                                                                  //L17'
})   
```

 >  Do not make assertions in container node functions

```go
var _ = Describe("When reading a book", func() {
    var book *books.Book
    book = books.New("The Chronicles of Narnia", 300)
    Expect(book.CurrentPage()).To(Equal(1))
    Expect(book.NumPages()).To(Equal(300))     

    It("...")
})
```

> data文件建议定义top-level (不会被修改)

```go
// books_suite_test.go

package books_test

import (
    . "github.com/onsi/ginkgo"
    . "github.com/onsi/gomega"

    "github.com/onsi/books"

    "testing"
)

var testConfigData TestConfigData

func TestBooks(t *testing.T) {
    RegisterFailHandler(Fail) 
    testConfigData = loadTestISBNs("isbn.json")
    RunSpecs(t, "Books Suite")
}   
```

> 不能在构建阶段load测试文件 (每个Context都会运行一次，严重浪费了资源)

```go
var _ = Describe("Looking up ISBN numbers", func() {
    var testConfigData TestConfigData

    BeforeEach(func() {
        testConfigData = loadTestISBNs("isbn.json") // WRONG!
    })

    Context("When the book can be found", func() {
        for _, d := range testConfigData {
            d := d //necessary to ensure the correct value is passed to the closure
            It("returns the correct ISBN number for " + d.Title, func() {                                                
                Expect(books.ISBNFor(d.Title, d.Author)).To(Equal(d.ISBN))
            })                                                                                            
        }
    })                                                                                                
}) 
```

### 异步测试

```go
It("...", func() {
	done := make(chan interface{})
	go func() {
		// user test code to run asynchronously
		close(done) //signifies the code is done
	}()
	Eventually(done, timeout).Should(BeClosed())
})
```

### Benchmark Tests

Measure  已废弃

```go
Measure("it should do something hard efficiently", func(b Benchmarker) {
    runtime := b.Time("runtime", func() {
        output := SomethingHard()
        Expect(output).To(Equal(17))
    })

    Ω(runtime.Seconds()).Should(BeNumerically("<", 0.2), "SomethingHard() shouldn't take too long.")

    b.RecordValue("disk usage (in MB)", HowMuchDiskSpaceDidYouUse())
}, 10)
```

```go
var _ = Describe("Common", func() {
	var e *gmeasure.Experiment
	BeforeEach(func() {
		e = gmeasure.NewExperiment("my exprement")
	})
	It("rand should not bigger then 14", func() {
		// 	actual := common.GetRand(14)
		// 	Expect(actual).Should(Not(Equal(14)))
		// })
		e.SampleDuration("call", func(idx int) {
			actual := common.GetRand(14)
			fmt.Println("-------------------------", actual)
			Expect(actual).Should(Not(Equal(10)))
		}, gmeasure.SamplingConfig{N: 1000})

	})
	AfterEach(func() {
		fmt.Println(e)
	})
})


// Name            | N    | Min    | Median | Mean   | StdDev | Max   
// ===================================================================
// call [duration] | 1000 | 20.1ms | 20.4ms | 20.7ms | 1.4ms  | 38.8ms

```


