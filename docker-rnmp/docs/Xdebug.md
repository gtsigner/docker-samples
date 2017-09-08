>docker-compose环境来自：https://github.com/zhaojunlike/docker-lnmp-redis
>原文：http://blog.oeynet.com/post/97.html

## 说明
在开发中，断点调试是我们最快能找出Bug代码问题的所在，那么在docker中如何使用xdebug进行php项目的跟踪调试呢？


## Step1 制作一个包含Xdebug扩展的容器

dockerfile如下
```
FROM php:5.6-fpm
MAINTAINER Godtoy <zhaojunlike@gmail.com>
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo_mysql mysql mbstring opcache bcmath \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --enable-bcmath \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install redis-3.1.0 \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable redis xdebug \
```

构建的话，我们这里直接使用docker-compose.yml中进行构建
```
version: '3.0'
services:
  php-fpm:
    build: ./dockerfiles/php/
    #image: zhaojunlike/php-fpm:5.6-latest
    restart: always
    environment:
      TP_APP_DEBUG: 1
      APP_DEBUG: 1
    volumes:
#网站目录
      - ./app:/app:rw
#配置文件
      - ./dockerfiles/php/php-dev.ini:/usr/local/etc/php/php.ini:ro
      - ./dockerfiles/php/php-fpm.conf:/usr/local/etc/php-fpm.conf:ro
      - /etc/localtime:/etc/localtime:ro
#挂载站点日志
      - ./logs/php-fpm:/var/log/php-fpm:rw
```

php.ini文件配置信息
```
[PHP]
short_open_tag = On
display_errors = On
error_reporting = E_ALL
post_max_size = 120M
upload_max_filesize = 100M

[Date]
date.timezone = Asia/Shanghai

[XDebug]
xdebug.idekey = "PHPSTORM"
xdebug.remote_enable = 1
xdebug.remote_handler = "dbgp"
xdebug.remote_mode = "req"
xdebug.remote_connect_back = on
xdebug.remote_autostart = off
xdebug.remote_host = "192.168.197.1"
xdebug.remote_port = 9000
xdebug.remote_log = /var/log/php-fpm/x-debug-remote.log

```
remote_host是开发IDE工具的ip地址

php.ini我推荐创建2个版本，一个版本用于本地开发调试的环境配置文件，还有一个线上生产的文件，可以开启opache等扩展对平台进行加速

## Step2 启动Lnmp环境
在docker-lnmp中，我们已经编排好了一个基本的nginx+php-fpm +mysql的环境实例，我们只需要克隆到根目录使用
```
docker-compose up -d
```
便会自动的去执行build然后生成镜像

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/f148665886207a0ed5e3edea9bf813c0.png)

最后会自动启动4个容器

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/478faade9a197749343ac2af849abe04.png)



## Step3 配置PHPStorm IDE
配置路径：File | Settings | Languages & Frameworks | PHP | Debug | DBGp Proxy

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/95245fa1021663c45af9247fc9861766.png)

在host文件中我将dev.me 已经host到了docker宿主机IP地址里面
所以www.dev.me也可以是docker宿主机的ip地址

```hosts
192.168.197.128	admin.dev.me api.dev.me dev.me www.dev.me m.dev.me old.dev.me new.dev.me
```

配置启动

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/a08aa363659ff5f832ebceeea07ae213.png)

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/6ef161b25071d13500e64c9c89e864c0.png)

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/7106b00f44c41aeaeca8117fa6f85636.png)


![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/886d20251050a3faa534ad55d6f4abe2.png)

最后apply就行了，
![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/66d186ade778318dd4ac1b728fc22882.png)


启动的时候，请开启那个小电话，还有打好断点就行了。
![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/e7fa67108c45942bea5666f5a4012c4e.png)

这样就配置好了
![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/89d60ca67f8c2265a00d8498e86d0127.png)



## Chrome 安装插件监听
地址
https://chrome.google.com/webstore/detail/jetbrains-ide-support/hmhgeddbohgjknpmjagkdomcpobmllji

![screenshots.png](https://blog.oeynet.com/upload/editor/20170824/29d96685d1f4e3f9103064ed9adb5662.png)

开启小电话以后，如果访问www.dev.me会自动进入断点中的debug模式，这样我们的docker开发环境的断点调试就已经配置好了。 enjoy