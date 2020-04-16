#!/usr/bin/env bash
#
# Copyright (c) 2020 by  lu.
# All rights reserved.
#
#ident  "docker 1.0"

cp -r ./docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
cp -r ./docker-compose-Linux-x86_64 /usr/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
chmod +x /usr/bin/docker-compose

#验证
docker-compose -version

