#!/usr/bin/env bash
#
# Copyright (c) 2020 by  lu.
# All rights reserved.
#
#ident  "docker 1.0"
set -h

#更新yum
yum -y update
#更新缓存
yum makecache fast

#设置仓库
yum install -y yum-utils  device-mapper-persistent-data lvm2
yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo

#安装 Docker Engine-Community
yum install -y docker-ce docker-ce-cli containerd.io

#查看docker版本
docker --version

echo "安装完成！"

# centos7
# 设置开机启动
systemctl enable docker

# 启动docker服务
systemctl start docker

echo "已配置开机启动！"
# 重启docker
systemctl daemon-reload
systemctl restart docker

# 生效配置
newgrp - docker

# 查看docker版本
docker --version