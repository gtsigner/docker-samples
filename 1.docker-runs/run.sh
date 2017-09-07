#!/usr/bin/env bash

##1.run mysql
##2.run redis
##3.run php-fpm --link myqsl:mysql --link redis:redis
##4.run nginx --link php-fpm:php-fpm
project_name=hello
echo "Project Run Start <${project_name}> "
exit 0
docker run -d --name $project_name-sf-mysql
docker run -d --name $project_name-sf-redis
docker run -d --name $project_name-php-fpm
docker run -d --name $project_name-nginx
