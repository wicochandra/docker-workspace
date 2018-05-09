FROM ubuntu:16.04

RUN DEBIAN_FRONTEND=noninteractive

###########################################################################
# Set Locale
###########################################################################
ENV LOCALE en_US

RUN apt-get update && apt-get install -y locales
RUN locale-gen ${LOCALE}.UTF-8
ENV LANGUAGE=${LOCALE}.UTF-8
ENV LC_ALL=${LOCALE}.UTF-8
ENV LC_CTYPE=${LOCALE}.UTF-8
ENV LANG=${LOCALE}.UTF-8

###########################################################################
# Set Timezone
###########################################################################
ENV TZ UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


###########################################################################
# Add non-root user:
###########################################################################
# Add a non-root user to prevent files being created with root permissions on host machine.
ENV PUID 1000
ENV PGID 1000
ENV USER web_user

RUN groupadd -g ${PGID} ${USER} && \
    useradd -u ${PUID} -g ${USER} -m ${USER} && \
    usermod -p "*" ${USER}

###########################################################################
# PPA dependencies:
#   PHP 7
###########################################################################
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

###########################################################################
# Install:
#   PHP
#   Libaries
###########################################################################
RUN apt-get update && apt-get install -y \
    --allow-downgrades \
    --allow-remove-essential \
    --allow-change-held-packages \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-intl \
    php7.2-json \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-zip \
    php7.2-bcmath \
    php7.2-memcached \
    php7.2-fpm \
    php7.2-mysql \
    php7.2-gd \
    php7.2-imagick \
    git \
    curl

##########################################################################
# Composer:
##########################################################################
# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer
RUN . ~/.bashrc


###########################################################################
# PHP-FPM
###########################################################################
RUN rm /etc/php/7.2/fpm/pool.d/*
RUN adduser ${USER} www-data
COPY ./php-fpm/www.pool.conf /etc/php/7.2/fpm/pool.d/www.pool.conf
COPY ./php-fpm/php.ini /etc/php/7.2/fpm/php.ini


EXPOSE 9000
EXPOSE 3000

###########################################################################
# Final Task
###########################################################################
USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

CMD service php7.2-fpm start && tail -f /var/log/php7.2-fpm.log
WORKDIR var/www
