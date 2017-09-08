#!/usr/bin/env bash

##1.run mysql
##2.run redis
##3.run php-fpm --link myqsl:mysql --link redis:redis
##4.run nginx --link php-fpm:php-fpm


#run mysql
docker run --name sf-mysql -e MYSQL_ROOT_PASSWORD=hellodocker -d mysql:5.7

#run redis
docker run --name sf-redis -d redis

#run php-fpm -v
docker run --name sf-php-fpm -v $PWD/app:/app --link sf-mysql:mysql --link sf-redis:redis -d php:7.0-fpm

#run mongo
docker run --name sf-mongo -d mongo

#run php-fpm v 5.0 app2
docker run --name sf-php-fpm-56 -v $PWD/app2:/app --link sf-mongo:mongo -d php:5.6-fpm

#run nginx
docker run  --name sf-nginx -v $PWD/app:/app1 -v $PWD/app2:/app2 --link sf-php-fpm:php-fpm-7 --link sf-php-fpm-56:php-fpm-56 -v $PWD/nginx.conf:/etc/nginx/nginx.conf -p 80:80 -d nginx

#rm
docker ps -aq --filter name=sf-* | xargs docker stop | xargs  docker rm

##tools
docker run -it --rm -v $PWD:/app --workdir=/app composer