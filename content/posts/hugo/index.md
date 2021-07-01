---
title: "HUGO"
date: 2021-07-01T08:20:30Z
draft: true
---

### hugo安装

> hugo的安装，下载源码 执行 **go install --tags extended**  

[源码地址](https://github.com/gohugoio/hugo) 


[官方文档](https://gohugo.io/getting-started/)


[中文文档](https://www.gohugo.org/)
### 特性:
- [x] 支持mermaid
- [x] 支持mathjax
- [x] 评论
- [x] 本地图片支持

#### mermaid支持
```html
<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
<script>mermaid.initialize({ startOnLoad: true });</script>
<script>
  Array.from(document.getElementsByClassName('language-mermaid')).forEach(el => {
    el.parentElement.outerHTML = `<div class="mermaid">${el.innerText}</div>`
  })
</script>
```

#### 评论支持
[文档](https://github.com/apps/utterances)

#### 本地资源

![hugo](./hugo.png "img-size-100-200")
