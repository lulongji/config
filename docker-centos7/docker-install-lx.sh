#!/usr/bin/env bash
#
# Copyright (c) 2020 by  lu.
# All rights reserved.
#
#ident  "docker 1.0"
set -h

tar zxvf ./docker-19.03.5.tgz

cp docker/* /usr/bin/

# 启动docker
dockerd &

#验证
docker version