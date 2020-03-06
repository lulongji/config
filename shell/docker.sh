#!/usr/bin/env bash

yum -y update && yum -y install docker-io

service docker start

mkdir -p /app/docker

