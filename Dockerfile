FROM php:fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq install libcurl3-dev libpng12-dev libjpeg-dev libmcrypt-dev libmcrypt4 zlib1g-dev && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/lib
RUN docker-php-ext-install curl gd mbstring mcrypt pdo pdo_mysql zip
RUN docker-php-ext-install bcmath

COPY php/my_php.ini /usr/local/etc/php/conf.d/

VOLUME /var/www/html
EXPOSE 9000
