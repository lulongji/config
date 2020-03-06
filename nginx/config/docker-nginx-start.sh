#!/usr/bin/env bash
#
# Copyright (c) 2019 by lulongij of lu.
# All rights reserved.
#
#ident  "@(#)nginx 1.0"

#运行nginx
docker run --name nginx -p 80:80 -v /app/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /app/docker/nginx/logs:/var/log/nginx -v /app/docker/nginx/conf/www/*.conf:/etc/nginx/conf.d/default.conf -d nginx




