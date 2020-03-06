#!/usr/bin/env bash
#
# Copyright (c) 2019 by lulongij of lu.
# All rights reserved.
#
#ident  "@(#)nginx 1.0"

# 安装nginx
docker pull nginx

# 创建挂载目录
#sudo mkdir -p /app/docker/nginx/{conf,html,logs}
sudo mkdir -p /app/docker/nginx/

SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
WORKING_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
#整理配置文件
cp -r  "$(dirname "$WORKING_DIR")"/nginx/config/* /app/docker/nginx/

#运行nginx
docker run --name nginx -p 80:80 -v /app/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /app/docker/nginx/logs:/var/log/nginx -v /app/docker/nginx/conf/www/*.conf:/etc/nginx/conf.d/default.conf -d nginx




