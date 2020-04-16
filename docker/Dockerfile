FROM ubuntu:18.04
MAINTAINER Ouyangjunfei

WORKDIR /root

# 更改Ubuntu的apt软件源
RUN sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/mirrors\.163\.com\/ubuntu\//g' \
/etc/apt/sources.list && \
    sed -i 's/http:\/\/security\.ubuntu\.com\/ubuntu\//http:\/\/mirrors\.163\.com\/ubuntu\//g' /etc/apt/sources.list

# 安装openjdk和openssh-server
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    openssh-server \
&&  rm -rf /var/lib/apt/lists \
&&  ln -s /usr/bin/python3 /usr/bin/python

# 从本机复制hadoop和spark
ADD --chown=root:root hadoop-2.7.3.tar.gz /usr/local
ADD --chown=root:root spark-2.4.5-bin-without-hadoop.tgz /usr/local

# 设置环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop-2.7.3
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV SPARK_HOME=/usr/local/spark-2.4.5-bin-without-hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME/sbin

# SSH免密登陆
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config

# 创建hadoop存储文件夹，与xml文件相符合
RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir -p ~/hdfs/tmp && \
    mkdir $HADOOP_HOME/logs && \
    sed -i 's/${JAVA_HOME}/\/usr\/lib\/jvm\/java-8-openjdk-amd64/g' $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# 复制hadoop和spark配置文件至相关目录
COPY --chown=root:root core-site.xml hdfs-site.xml mapred-site.xml slaves yarn-site.xml $HADOOP_HOME/etc/hadoop/
COPY --chown=root:root slaves spark-env.sh $SPARK_HOME/conf/

CMD [ "sh", "-c", "service ssh start;/bin/bash"]
