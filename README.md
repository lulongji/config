# config

# 初始化

    yum clean all  && yum -y install
    
    yum -y install gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng


## docker

- docker-install
- docker-start
- docker-uninstall


# 安装
- mysql5.7
- oracle11g
- redis
- nginx


###### 在docker中使用 --network host 来为容器配置 host 网络：

    docker run -d --name nginx --network host nginx

## nginx 

    docker run --name nginx --network host -v /app/docker/nginx/config/nginx.conf:/etc/nginx/nginx.conf -v /app/docker/nginx/config/logs:/var/log/nginx  -v /app/docker/nginx/config/conf.d/default.conf:/etc/nginx/conf.d/default.conf -v  /var/www/html :/  /usr/share/nginx/html -d nginx

##



    