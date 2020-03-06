#!/bin/sh
#
# Copyright (c) 2019 by lulongij of lu.
# All rights reserved.
#
#ident  "@(#)spring 1.0"


#项目jar名称
APP_NAME=

#JDK指定
#JAVA_HOME=/app/java/jdk8

#关闭debug模式则设置为空
APP_DEBUGE=
#APP_DEBUGE="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=18080"

#JVM参数
JAVA_OPTS='-Xms1024m -Xmx1024m -XX:MaxPermSize=256m -XX:NewRatio=4 -XX:+UseParallelGC -XX:ParallelGCThreads=8 -XX:+UseAdaptiveSizePolicy -verbose:gc -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:-HeapDumpOnOutOfMemoryError -Xloggc:verbose-gc-sp.txt'


# 如果不指定jdk则使用默认
if [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]]; then
    javaexe="$JAVA_HOME/bin/java"
elif type -p java > /dev/null 2>&1; then
    javaexe=$(type -p java)
elif [[ -x "/usr/bin/java" ]];  then
    javaexe="/usr/bin/java"
else
    echo "Unable to find Java"
    exit 1
fi

#获取当前工作空间
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
WORKING_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

#项目目录
APP_HOME="$(dirname "$WORKING_DIR")"

#项目配置文件路径
APP_CONF="$APP_HOME/conf/bootstrap.properties"

#日志文件
LOG_FILE="--logging.config=$APP_HOME/conf/logback.xml"

JAR_FILE=$APP_HOME/lib/$APP_NAME*.jar

pid=00000
#校验进程
APP_PID=$APP_HOME/$APP_NAME.pid

APP_CONF="--spring.config.location=file:$APP_CONF"

start(){
 checkpid
 if [ $? -eq 0 ]; then
    echo JDK路径: $JAVA_HOME
    echo 项目目录: $APP_HOME
    echo 项目名称: $APP_NAME
    echo 配置文件: $APP_CONF
    echo JVM参数: $JAVA_OPTS

    if  [ ! -n "$APP_DEBUGE" ] ;then
        echo "关闭debug模式!"
    else
        echo "开启debug模式!"
    fi

    /bin/sh -c  "$javaexe -jar $APP_DEBUGE $JVM_OPTS $JAR_FILE $APP_CONF  $LOG_FILE > /dev/null 2>&1 & echo \$!" > "$APP_PID"
    echo "---------------------------------"
    echo "启动完成"
    echo "---------------------------------"
    sleep 2s
  else
      echo "$APP_NAME is runing PID: $pid"
  fi

}

status(){
   checkpid
   if [ $? -eq 0 ]; then
     echo  "$APP_NAME not runing"
   else
     echo "$APP_NAME runing PID: $pid"
   fi
}


checkpid(){
   if [[ -f "$APP_PID" ]]; then
        pid=$(cat "$APP_PID")
        PIDNUM=`ps -ef |grep "$pid" -i |grep -v grep |wc -l`
        if [ $PIDNUM -eq 0 ];then
		return 0;
        else
                return 1;
        fi
   else
        return 0;
   fi
}


stop(){
    checkpid
    if [ $? -eq 0 ]; then
      echo "$APP_NAME not runing"
    else
      echo "$APP_NAME stop..."
      kill -9 $pid
    fi
}

restart(){
    stop
    sleep 1s
    start
}

case $1 in
          start) start;;
          stop)  stop;;
          restart)  restart;;
          status)  status;;
              *)  echo "require start|stop|restart|status"  ;;
esac
