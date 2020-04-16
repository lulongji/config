#!/usr/bin/env bash
#
# Copyright (c) 2020 by  lu.
# All rights reserved.
#
#ident  "docker 1.0"

#更新yum
yum -y update
#更新缓存
yum makecache fast


#安装 pip
yum -y install epel-release
yum -y install python-pip
#
yum -y install gcc gcc-c++ kernel-devel
yum -y install python-devel

# 查看版本
pip --version

# 安装docker-compose
pip install --upgrade pip
pip install docker-compose


# 查看版本
docker-compose version




