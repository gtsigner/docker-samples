#可以按照需求切换版本
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
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*

#Flag:最后记得清理apt产生的垃圾，减少空间占用  rm -rf /....
COPY ./dockerfiles/php/php-pro.ini /usr/local/etc/php/php.ini
COPY ./dockerfiles/php/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./app /app
WORKDIR /app
