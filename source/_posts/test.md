---
title: 关于性能测试
date: 2017-01-04 07:48:59
tags:
---

### 接口响应

```bash
curl -d "m=bigpaygift&p=bigstoregift" "http://tclandlord.boyaagame.com/landlord_facebookth/application/api.php" -w %{time_total}"\n"
```

### ab测试
```$xslt
./ab -n 1 -v 4 -p 'userlogin.txt' -T 'application/x-www-form-urlencoded' 'http://api.xxxxx.com/1/login'

```