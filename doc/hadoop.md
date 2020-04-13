# 大数据组件Hadoop

*Apache基金会拥有庞大的大数据生态组件，其中Hadoop和Spark都是顶级项目，也是大数据生态的核心组件。*

---

- [大数据组件Hadoop](#%e5%a4%a7%e6%95%b0%e6%8d%ae%e7%bb%84%e4%bb%b6hadoop)
  - [简要介绍](#%e7%ae%80%e8%a6%81%e4%bb%8b%e7%bb%8d)
  - [Hadoop1与Hadoop2](#hadoop1%e4%b8%8ehadoop2)
  - [Hadoop下载](#hadoop%e4%b8%8b%e8%bd%bd)
  - [Hadoop单机安装与环境配置](#hadoop%e5%8d%95%e6%9c%ba%e5%ae%89%e8%a3%85%e4%b8%8e%e7%8e%af%e5%a2%83%e9%85%8d%e7%bd%ae)
  - [Hadoop完全分布式](#hadoop%e5%ae%8c%e5%85%a8%e5%88%86%e5%b8%83%e5%bc%8f)

---

## 简要介绍

Apache Hadoop是一个允许在集群上使用简单编程模型对大量数据进行分布式处理的软件库。它被设计为可以从单机拓展到上千台机器，并且每台机器提供本机的计算和存储能力。与其依赖于硬件的高稳定性，Hadoop系统自身被设计为在应用层可以探测和处理各种错误，所以在一个集群上可以提供高可用的服务。

[官网](https://hadoop.apache.org/)

Hadoop系统主要涉及的组件：
- Hadoop Common：支撑其他Hadoop组件运行的普通组件
- Hadoop Distributed File System(HDFS)：分布式文件系统，*可以单独作为很多应用支持的底层文件存储系统*，比如Spark
- Hadoop YARN：作业调度和集群资源管理的框架
- Hadoop MapReduce：基于YARN用作大量数据并行处理的系统

---

## Hadoop1与Hadoop2

如果上过大数据基础课程，应该大致了解Hadoop的工作流程。

需要指出的是，早期Hadoop1和如今主流使用的Hadoop2架构设计已经发生很大变化，参考下面两篇文章
- [Hadoop 1.x和2.x区别和联系](https://blog.csdn.net/pao___pao/article/details/79464184)
- [Hadoop 1与Hadoop 2的区别](https://blog.csdn.net/simonqian_vip/article/details/20358169)

> Hadoop 1.0即第一代Hadoop，由分布式存储系统HDFS和分布式计算框架MapReduce组成，其中，HDFS由一个NameNode和多个DataNode组成，MapReduce由一个JobTracker和多个TaskTracker组成，对应Hadoop版本为Apache Hadoop 0.20.x、1.x、0.21.X、0.22.x和CDH3

> Hadoop 2.0针对Hadoop 1.0中的MapReduce在扩展性和多框架支持等方面的不足，它将JobTracker中的资源管理和作业控制功能分开，分别由组件ResourceManager和ApplicationMaster实现，其中，ResourceManager负责所有应用程序的资源分配，而ApplicationMaster仅负责管理一个应用程序，进而诞生了全新的通用资源管理框架YARN,对应Hadoop版本为Apache Hadoop 0.23.x、2.x和CDH4

---

## Hadoop下载

2.x最新版本为2.9.2，[下载链接](https://hadoop.apache.org/releases.html)，[2.9.2文档](https://hadoop.apache.org/docs/r2.9.2/index.html)，下载`binary`即可，需要学习源码可以单独下载`src`

压缩文件解压后，在`$HADOOP_HOME/share/doc`内是当前版本对应的doc文档，可以用浏览器打开`index.html`直接本地查看

Hadoop[全版本下载](https://archive.apache.org/dist/hadoop/core/)

Hadoop[全版本文档](https://hadoop.apache.org/docs/)

---

## Hadoop单机安装与环境配置

**官网文档** [Hadoop: Setting up a Single Node Cluster](https://hadoop.apache.org/docs/r2.9.2/hadoop-project-dist/hadoop-common/SingleCluster.html)

此文档是单节点上三种搭建方式的介绍，非常简介，具体为：
1. Local(Standalone)模式，也即直接运行Hadoop
2. Pseudo-Distributed(伪分布式)模式，当前节点既作为Master又作为Worker
3. YARN在单节点部署，之前介绍了，YARN是资源管理和作业调度的程序，我们需要更改配置文件使其在单节点上运行

配置的过程因为比较简单，不再截图给出，第一个参考就是上面的官方文档，第二个是[史上最详细、最全面的Hadoop环境搭建](https://www.javazhiyin.com/25870.html)，有每一步的过程截图，很详细，其中还包含了完全分布式的指导，建议大家一步步来，循序渐进。

---

## Hadoop完全分布式

**官方文档** [Hadoop Cluster Setup](https://hadoop.apache.org/docs/r2.9.2/hadoop-project-dist/hadoop-common/ClusterSetup.html)

这个文档写的比较详细，主要是针对大规模集群，对于我们布置环境，1主节点1从节点只用参考部分内容即可；总结一下主要在于几个配置文件的设置。

进入$HADOOP_HOME/etc/hadoop
> $HADOOP_HOME表示你的Hadoop文件解压位置，应设置为系统级的环境参数

Hadoop的所有配置文件都位于`$HADOOP_HOME/etc/hadoop`

下面分享我的配置文件，仅供参考，所有参数的含义均在[官网](https://hadoop.apache.org/docs/r2.9.2/index.html)左侧列表最下方

![docs](hadoop/doc.jpg)

- hadoop-env.sh
  只修改
  ```
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
  ```

- core-site.xml
  ```xml
  <configuration>
      <!--NameNode URI-->
      <property>
          <name>fs.defaultFS</name>
          <!--master是主节点的主机名-->
          <value>hdfs://master:9000/</value>
      </property>
      <!--用来指定临时文件的存放目录-->
      <property>
          <name>hadoop.tmp.dir</name>
          <!--路径可以更改，别忘记创建文件夹-->
          <value>file:/root/hdfs/tmp</value>
      </property>
  </configuration>
  ```
  用于配置Hadoop核心的功能参数

- hdfs-site.xml
  ```xml
  <configuration>
      <!--Namenode存储相关文件的本地路径-->
      <property>
          <name>dfs.namenode.name.dir</name>
          <value>file:/root/hdfs/namenode</value>
      </property>
      <!--Datanode存储相关文件的本地路径-->
      <property>
          <name>dfs.datanode.data.dir</name>
          <value>file:/root/hdfs/datanode</value>
      </property>
      <!--每个文件块在HDFS备份的数量-->
      <property>
          <name>dfs.replication</name>
          <value>2</value>
      </property>
  </configuration>
  ```
  用于配置HDFS相关的参数

- yarn-site.xml
  ```xml
  <configuration>
      <property>
          <name>yarn.nodemanager.aux-services</name>
          <value>mapreduce_shuffle</value>
      </property>
      <property>
          <name>yarn.resourcemanager.hostname</name>
          <value>master</value>
      </property>
  </configuration>
  ```
  用于配置调度系统YARN相关的参数

- mapred-site.xml
  ```xml
  <configuration>
      <property>
          <name>mapreduce.framework.name</name>
          <value>yarn</value>
      </property>
  </configuration>
  ```
  用于配置Map-Reduce过程相关的参数

- slaves
  ```
  master
  worker1
  ```
  master是主节点的主机名，worker1是从节点的主机名。这里slaves文件包含的是工作节点的主机名，如果不要master就只有worker1一个作为工作节点，或者你可以添加worker2等等更多的工作节点。

配置完成后，初始化
> $ bin/hdfs namenode -format

再开启所有进程
> $ sbin/start-all.sh

可用
> $ jps

查看本机相关进程是否成功运行

当执行`start-all.sh`脚本的时候，程序会说明此脚本已经被遗弃，请使用`start-dfs.sh`和`start-yarn.sh`，使用前一个脚本和分别使用后两个脚本最终结果是没有区别的，因为我们是很小的集群。

`start-dfs.sh`脚本实质上是启动HDFS，有的情况下我们只需要HDFS即可，比如计算架构我们使用Spark，此脚本运行成功后，可以在50070端口查看HDFS的情况。

`start-yarn.sh`是启动YARN系统，即Hadoop 2.x中引入的资源管理和作业调度程序，这个看情况开启，Web端口为8088

如果Spark使用的调度系统为Standalone，那么可以不用开启YARN，反之如果Spark使用YARN作为调度系统，则必须都开启。


