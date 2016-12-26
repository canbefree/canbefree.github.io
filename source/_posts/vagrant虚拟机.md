---
title: vagrant虚拟机
date: 2016-10-17 11:47:55
categories: liunx
tags:
    - vagrant
---

### centos7.0 关闭防火墙

```
$ systemctl stop firewalld.service #停止firewall  
$ systemctl disable firewalld.service #禁止firewall开机启动
```
### 自定义的box需要手动配置网络配置 

```
sudo rm -rf /etc/sysconfig/network-scripts/ifcfg-enp0s8
sudo rm -rf /etc/hostname

$ wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
$ cat vagrant.pub > ~/.ssh/authorized_keys
$ rm vagrant.pub
$
```


### 自定义脚本启动

```
   config.vm.provision "shell", inline: <<-SHELL
     sudo service network restart
   SHELL

```
启动时带上 --provision 参数
> $ vagrant reload --provision