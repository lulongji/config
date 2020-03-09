#!/bin/sh
#
# Copyright (c) 2019 by lulongij of lu.
# All rights reserved.
#
#ident  "@(#)nginx 1.0"

#项目名
APP_NAME="nginx "

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

pid=00000

#校验进程
APP_PID=$APP_HOME/nginx.pid

start(){
 checkpid
 if [ $? -eq 0 ]; then

    docker run --name nginx --net host -v /app/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /app/docker/nginx/logs:/var/log/nginx  -d nginx

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
