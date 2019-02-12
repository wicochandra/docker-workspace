FROM php:7.2-apache

COPY ./web.conf /etc/apache/sites-enabled/000-default.conf
RUN apt-get update &&\
    apt-get install -y \
        libxml2-dev

RUN docker-php-source extract \
    && docker-php-ext-install pdo_mysql  \
    && docker-php-source delete

