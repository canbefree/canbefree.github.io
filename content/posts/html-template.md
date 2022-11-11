---
title: "HTML Template Syntax | HUGO"
date: 2022-11-09T11:44:58+08:00
draft: false
author: "canbefree"
categories: "note"
tags: ["杂记","go","hugo","html","template"]
description: "golang html/template"
---
## text/template[[^m1]]

Example：

```go
	temp := `
	hello,	{{.Name}}
	`
	t, err := template.New("test").Parse(temp)
	helper.PaincErr(err)

	type Args struct {
		Name string
	}
	arg := Args{ Name: "????",}

	// var out *bufio.Writer = bufio.NewWriter(os.Stdout)
	// err = t.ExecuteTemplate(out, "test", arg)
	err = t.ExecuteTemplate(os.Stdout, "test", arg)
	helper.PaincErr(err)
	// out.Flush()
```

#### Text and spaces

trim 为了让代码更符合阅读

```
"{{23 -}} < {{-   45}}". // output: 23<45 "
```

#### Actions

注释 `{{/* comment */}}`

> `{{` 和 / 必须紧贴着, 如果包含空格或者换行会展示出来

{{- /*   */ -}}

> trim

if 语句控制

```
{{if pipeline}} T1 {{else}}{{if pipeline}} T0 {{end}}{{end}}
```

foreach控制

```
{{range pipeline}} T1 {{else}} T0 {{end}}
```

template

```
{{template "name"}}
```

```go
	{{define "html5"}}
	<html>hello,world</html>
	{{end}}
	{{template "html5"}}
```

```
{{template "name" pipeline}}
```

```go
	{{define "html5"}}
	<html>{{.}}</html>
	{{end}}
	{{template "html5" "???"}}

```

#### Pipelines

a possibly chained sequence of "commands"

#### Variables

$variable := pipeline

```
range $index, $element := pipeline
```

#### functions

and , not , or

> "or x y" behaves as "if x then x else y".
> "and x y" behaves as "if x then y else x."

call

> 调用函数

index

slice

js,html,urlquery

len

print ,printf,println

## html/template [[^m2]]

    相比 text/template , 会autoescaping，减少安全问题。

添加了很多内置语法，可以直接通过管道的方式执行。

```
<a href="/search?q={{. | urlescaper | attrescaper}}">{{. | htmlescaper}}</a>
```

#### functions

Funcs

    FuncMap, 定义自定义函数方法

```go
	temp := `
	{{ "13588888888" | encode }}
	`
	t, err := template.New("test").Funcs(template.FuncMap{
		"encode": func(s string) string {
			if len(s) < 7 {
				return s
			}
			return s[0:3] + "****" + s[7:]
		},
	}).Parse(temp)
	helper.PaincErr(err)
	arg := ""
	err = t.ExecuteTemplate(os.Stdout, "test", arg)
	helper.PaincErr(err)
```

再看一个hugo的例子, partial 函数的实现， 本质上就是ctx.Include的别名

```go
// file: hugo/tpl/partials/init.go
	ns.AddMethodMapping(ctx.Include,
		[]string{"partial"},
		[][2]string{
			{`{{ partial "header.html" . }}`, `<title>Hugo Rocks!</title>`},
		},
	)
```

最后的核心代码,本质上还是使用的 Funcs 函数

```go
// file: hugo/tpl/tplimpl/template_funcs.go
func createFuncMap(d *deps.Deps) map[string]any {
	funcMap := template.FuncMap{}

	// Merge the namespace funcs
	for _, nsf := range internal.TemplateFuncsNamespaceRegistry {
		ns := nsf(d)
		if _, exists := funcMap[ns.Name]; exists {
			panic(ns.Name + " is a duplicate template func")
		}
		funcMap[ns.Name] = ns.Context
		for _, mm := range ns.MethodMappings {
			for _, alias := range mm.Aliases {
				if _, exists := funcMap[alias]; exists {
					panic(alias + " is a duplicate template func")
				}
				funcMap[alias] = mm.Method
			}
		}
	}

	if d.OverloadedTemplateFuncs != nil {
		for k, v := range d.OverloadedTemplateFuncs {
			funcMap[k] = v
		}
	}

	return funcMap
}
```

[^m1]: https://pkg.go.dev/text/template
    
[^m2]: https://pkg.go.dev/html/template
