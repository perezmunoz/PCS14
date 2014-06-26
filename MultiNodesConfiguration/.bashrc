export JAVA_HOME=/usr/lib/jvm/java

case "$TERM" in
"dumb")
    export PS1="> "
    ;;
xterm*|rxvt*|eterm*|screen*)
    export PS1='\[\033[00;32m\]Alex [\h] > \[\033[00m\]'
    ;;
*)
    export PS1="> "
    ;;
esac

hostname=$(hostname);

# Hadoop
HADOOP_PREFIX=/opt/hadoop-2.2.0
export HADOOP_HOME=$HADOOP_PREFIX
export HADOOP_COMMON_HOME=$HADOOP_PREFIX
export HADOOP_CONF_DIR=~/hadoop_conf
export HADOOP_HDFS_HOME=$HADOOP_PREFIX
export HADOOP_MAPRED_HOME=$HADOOP_PREFIX
export HADOOP_YARN_HOME=$HADOOP_PREFIX
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_PREFIX}"/lib/"
export HADOOP_OPTS="${HADOOP_OPTS} -Djava.library.path=$HADOOP_PREFIX/lib/"

export HADOOP_LOG_DIR=~/hadoop_logs
export HADOOP_NAMENODE_NAME=localhost

# mise à jour de slaves
if [ ! -d "/tmp/hadoop-tmp" ]; then
    mkdir /tmp/hadoop-tmp;
fi
if [ ! -d "/tmp/hadoop-tmp/hdfs" ]; then
    mkdir /tmp/hadoop-tmp/hdfs; 
fi
if [ ! -d "/tmp/hadoop-tmp/hdfs/datanode" ]; then
    mkdir /tmp/hadoop-tmp/hdfs/datanode;
fi
if [ -n "$OAR_FILE_NODES" ]; then

    cat $OAR_FILE_NODES | uniq > ~/hadoop_conf_original/slaves;

    if [ ! -d "/tmp/hadoop-tmp/hdfs/namenode" ]; then
        mkdir /tmp/hadoop-tmp/hdfs/namenode;
    fi
    if [ ! -d "/tmp/hadoop-tmp/hdfs/namesecondary" ]; then
        mkdir /tmp/hadoop-tmp/hdfs/namesecondary;
    fi
    export HADOOP_NAMENODE_NAME=$(head -1 $OAR_FILE_NODES);

    if [ ! -d "$HADOOP_CONF_DIR" ]; then
	mkdir $HADOOP_CONF_DIR;
    else
	rm -rf $HADOOP_CONF_DIR"/*";
    fi

    if [ ! -d $HADOOP_CONF_DIR"_slaves" ]; then
	mkdir $HADOOP_CONF_DIR"_slaves";
    else
	rm -rf $HADOOP_CONF_DIR"_slaves/*";
    fi

    for f in ~/hadoop_conf_original/*; do
	cat $f | sed -e 's/\$HADOOP_NAMENODE_NAME/'$HADOOP_NAMENODE_NAME'/g' > ~/hadoop_conf/$(basename $f);
    done;
    for f in ~/hadoop_conf_slaves_original/*; do
	cat $f | sed -e 's/\$HADOOP_NAMENODE_NAME/'$HADOOP_NAMENODE_NAME'/g' > ~/hadoop_conf_slaves/$(basename $f);
    done;

else
    export HADOOP_CONF_DIR=~/hadoop_conf_slaves;
fi

## Sécurité du logout

function confirm()
{
    echo -n "$@ "
    read -e answer
    for response in y Y yes YES Yes Sure sure SURE OK ok Ok
    do
        if [ "_$answer" == "_$response" ]
        then
            return 0
        fi
    done
 
    # Any answer other than the list above is considerred a "no" answer
    return 1
}
function testExit()
{
    if [[ "$(jps|wc -l)" -gt "1" ]]; then
	confirm Avez-vous bien arrêté tous les processus Java ? \(commande jps\) yes/no && logout;
    else
	logout;
    fi
}

alias exit="testExit";
