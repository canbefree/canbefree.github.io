---
title: vagrant虚拟机
date: 2016-10-17 11:47:55
categories: liunx
tags:
    - vagrant
---

# 推荐使用docker 

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
> 
> 
> ### vagrant无法登陆

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

### vagrant virtualbox VM inaccessible

```
Bringing machine ‘default’ up with ‘virtualbox’ provider…
Your VM has become “inaccessible.” Unfortunately, this is a critical error
with VirtualBox that Vagrant can not cleanly recover from. Please open VirtualBox
and clear out your inaccessible virtual machines or find a way to fix
them.
```

C:\Users\denglj\VirtualBox VMs\vagrant_default_1411538218356_15372\vagrant_default_1411538218356_15372.vbox文件不存在。于是进入该文件的目录，发现并没有后缀为.vbox文件，而是多了一个.vbox-tmp的文件。简单地将该文件后缀中的-tmp去掉，在执行vagrant up命令，成功了。问题得到解决。