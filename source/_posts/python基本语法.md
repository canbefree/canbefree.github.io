---
title: python基本语法
date: 2017-01-03 07:50:37
tags:
---

### python处理文件
 
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

