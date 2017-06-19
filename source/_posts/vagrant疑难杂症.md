---
title: vagrant疑难杂症
date: 2016-10-12 03:58:10
categories: liunx
tags: 
    - vagrant
      
---

### vagrant无法登陆

#### 检查公钥是否正确
```
$ vim /home/vagrant/.ssh/authorized_keys
```

>检查[公钥](https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub)是否为
```
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
    
```
#### 检查机器名和ip是否与配置文件一致,如果不一致

##### 修改主机名称
```
$ sudo vim /etc/hostname
```

##### 修改服务器网络配置
```
$ sudo vim /etc/sysconfig/network-scripts/ifcfg-enp0s8
```

### unknown filesystem type 'vboxsf'
```
Failed to mount folders in Linux guest. This is usually because
the "vboxsf" file system is not available. Please verify that
the guest additions are properly installed in the guest and
can work properly. The command attempted was:

mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` data /data
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` data /data

The error output from the last command was:

mount: unknown filesystem type 'vboxsf'

```
解决:
>vagrant plugin install vagrant-vbguest


[链接](http://www.cnblogs.com/canbefree/p/4985194.html)