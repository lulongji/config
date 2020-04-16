#!/usr/bin/env bash
#
# Copyright (c) 2020 by  lu.
# All rights reserved.
#
#ident  "docker 1.0"
set -h

yum -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine


echo "卸载完成!"