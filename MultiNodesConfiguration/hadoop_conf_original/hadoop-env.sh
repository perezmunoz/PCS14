export HADOOP_HEAPSIZE="500"
export HADOOP_NAMENODE_INIT_HEAPSIZE="500"

export JAVA_HOME=/usr/lib/jvm/java

export HADOOP_HOME=/opt/hadoop-2.2.0
export HADOOP_CONF_DIR=~/hadoop_conf
export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true

export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/"
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME"/lib/native/"

export HADOOP_COMMON_HOME=/opt/hadoop-2.2.0
export HADOOP_HDFS_HOME=/opt/hadoop-2.2.0
export HADOOP_MAPRED_HOME=/opt/hadoop-2.2.0
export HADOOP_YARN_HOME=/opt/hadoop-2.2.0
export HADOOP_LOG_DIR=~/hadoop_logs
export YARN_LOG_DIR=~/yarn_logs

export YARN_CONF_DIR=~/hadoop_conf
