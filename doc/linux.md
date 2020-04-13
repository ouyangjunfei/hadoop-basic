# 操作系统

---

- [操作系统](#%e6%93%8d%e4%bd%9c%e7%b3%bb%e7%bb%9f)
  - [简要介绍](#%e7%ae%80%e8%a6%81%e4%bb%8b%e7%bb%8d)
  - [工具和命令](#%e5%b7%a5%e5%85%b7%e5%92%8c%e5%91%bd%e4%bb%a4)

---

## 简要介绍

大数据组件一般运行于Linux内核的操作系统，Linux的发行版有很多，做实验选择自己喜欢的就好；一般推荐CentOS或Ubuntu，安装环境无论是原生Linux还是虚拟机都可。

> CentOS（Community ENTerprise Operating System）是Linux发行版之一，它是来自于Red Hat Enterprise Linux依照开放源代码规定释出的源代码所编译而成。由于出自同样的源代码，因此有些要求高度稳定性的服务器以CentOS替代商业版的Red Hat Enterprise Linux使用。

> Ubuntu是一个以桌面应用为主的Linux操作系统。Ubuntu基于Debian发行版和GNOME桌面环境，与Debian的不同在于它每6个月会发布一个新版本。Ubuntu的目标在于为一般用户提供一个最新的、同时又相当稳定的主要由自由软件构建而成的操作系统。Ubuntu具有庞大的社区力量，用户可以方便地从社区获得帮助。

[Linux系统之CentOS和Ubuntu的区别](https://cloud.tencent.com/developer/article/1457753)

我个人使用的是Vmware Workstaion + Ubuntu 16.04，后面截图以此作为演示

---

## 工具和命令

在Linux环境下更多是用bash操作，所以熟知一些命令和工具是必需的。

---**以Ubuntu系统为示例**---

- **Linux系统区分大小写**，所以命令不正确时检查大小写

- 包管理系统
  - Ubuntu使用优秀的包管理系统，常用的有apt和dpkg，对应的CentOS系统上为yum和rpm
  - 在使用包管理系统前需要换源，默认源在国外速度慢；可以更改`/etc/apt/sources.list`，更简单的方法是系统设置->软件与更新->下载->找到中国的服务器
  ![apt换源](hadoop/apt.jpg)
  - 常用命令，都需要加上`sudo`
    - `apt-get update`：从源更新最新的软件目录名单
    - `apt-get upgrade`：更新系统内的软件
    - `apt-get install xxxxxx`：安装某个软件，会自动解决依赖问题

- sudo
  默认使用的用户是普通用户，没有root权限，在需要root权限执行的命令前加上`sudo`并输入用户密码即可在运行过程中获得root权限，注意在Linux系统下输入密码是默认不可见的，没有******号

- vi/vim
  无图形界面的编辑器，很多时候需要对配置文件进行修改，但是又只有bash，所以vi/vim的使用是必不可少，vi与vim略有不同，参考[vi与vim使用与区别](https://blog.csdn.net/J080624/article/details/69544064)，实际使用可以当作一回事；需要注意的是，vi/vim的操作逻辑与平常的编辑器不太相同，建议查看[十分钟学会 Vim 基本操作](https://www.jianshu.com/p/ec5910c93d69)和[vi/vim基本使用方法](https://www.cnblogs.com/itech/archive/2009/04/17/1438439.html)进行学习

- ping
  搭建集群有时需要测试机器是否处于同一个网络下，ping命令的安装`sudo apt-get install iputils-ping`

- ifconfig
  查看本机IP等网络信息使用的命令是`ifconfig`，安装命令为`sudo apt-get install net-tools`

- ssh
  - Hadoop集群的运行依赖于SSH，它是一个可用于远程登陆的协议，具体来说使用`ssh 被访问用户名@IP地址`命令再输入被访问用户的密码即可实现登陆
  - 安装SSH服务端`sudo apt install openssh-server`，会自动安装SSH客户端`openssh-client`
  - 开启停止重启查看服务状态`service ssh/sshd start|stop|restart|status`，`ssh`表示客户端服务，`sshd`表示服务端服务，一般来说全部打开即可，d表示daemon，即守护进程
  - 测试SSH服务往往使用`ssh 当前用户名@localhost`命令，可以成功进入表示SSH功能正常
  - SSH客户端的配置文件`/etc/ssh/ssh_config`，配置文件[详解](https://blog.csdn.net/JimyJimang/article/details/10406523)；SSH服务端的配置文件`/etc/ssh/sshd_config`，配置文件[详解](https://blog.51cto.com/xujpxm/1717862)
  - 正常的SSH登陆需要每次输入密码，更简便的方式有免密登陆，利用非对称加密的原理，创建公钥与私钥，将公钥复制到被访问机器上，即可完成免密登陆，参考[SSH 免密登录是怎么玩儿的?](https://zhuanlan.zhihu.com/p/28423720)和[ssh免密登录配置](https://blog.csdn.net/m0_37590135/article/details/74275859)

- Java
  Linux下建议使用OpenJDK，安装命令`sudo apt-get install openjdk-8-jdk`

- cd
  更换目录，一个`.`表示当前目录，两个`.`表示上一级目录，下面的命令表示返回上层目录
  > $ cd ..    

- ls
  列出当前目录内的文件信息，`ls -al`查看详细的信息

- 使用`Tab`键可以快速补全命令

- 路径(Path)
  - Linux的根目录表示为`/`，当前用户的目录表示为`~`.
  - 如可用`cd /`进入系统的根目录，使用`cd ~`进入当前用户的目录
  - 如果被操作目录路径第一个字符为`/`则表示绝对路径，否则表示相对路径。比如处于当前目录`/home/user`，想进入`mydir`目录，应该使用`cd mydir`命令，如果使用`cd /mydir`，则会从系统的根目录访问`mydir`，而这个文件夹是不存在的
