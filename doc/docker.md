# 使用Docker搭建Spark

---

## Hadoop版本
- *Dockerfile*文件中使用的Hadoop版本为2.7.3，可以更换为你拥有的版本，修改第19和24行
- 并且把你的**hadoop-2.x.x.tar.gz**文件放入`hadoop-basic/docker`目录下

## Spark版本
- *Dockerfile*文件中使用的Spark版本为2.4.5，并且是非自带Hadoop的，可以更换为你拥有的版本，修改第20和26行
- 并且把你的**spark-2.x.x-bin-without-hadoop.tgz**文件放入`hadoop-basic/docker`目录下

---

## Docker安装及换源

安装[教程](https://docs.docker.com/engine/install/ubuntu/)

换源使用阿里云

---

## 镜像构建及容器运行

进入到本项目的`docker`目录
> $ cd hadoop-basic/docker

执行构建命令
> $ docker build -t spark:1.0 .

等待片刻，镜像构建完成

进入`shell`目录
> $ ./run-cluster.sh

此时运行了两个容器，一个为master，一个为worker1

建议在本机中`/etc/hosts`加入对两个容器的域名解析

进入容器master

> $ docker exec -it master bash

进行Namenode初始化
> $ hdfs namenode -format

启动HDFS
> $ start-dfs.sh

启动Spark集群
> $ bash \$SPARK_HOME/sbin/start-all.sh

在master容器中安装pip

> $ apt-get install python3-pip

安装jupyter

> $ pip3 install jupyter -i http://pypi.douban.com/simple --trusted-host pypi.douban.com

配置pyspark启动参数

> $ vim $SPARK_HOME/bin/pyspark

    export PYSPARK_DRIVER_PYTHON = jupyter
    export PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=* --allow-root --no-browser'

启动pyspark

> $ pyspark --master spark://master:7077