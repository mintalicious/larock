FROM php:fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq install libcurl3-dev libpng12-dev libmcrypt-dev && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-install curl gd mbstring mcrypt pdo pdo_mysql zip

VOLUME /var/www/html
EXPOSE 9000
