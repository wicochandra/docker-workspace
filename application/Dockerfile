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
    php7.3-cli \
    php7.3-common \
    php7.3-curl \
    php7.3-intl \
    php7.3-json \
    php7.3-xml \
    php7.3-mbstring \
    php7.3-zip \
    php7.3-bcmath \
    php7.3-memcached \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-gd \
    php7.3-imagick \
    php7.3-imap \
    php7.3-xdebug \
    php7.3-mailparse \
    git \
    curl \
    wget \
    zsh \
    vim \
    nano

###########################################################################
# Install:
#  nodejs
#  npm
###########################################################################
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get update && apt-get install -y \
    --allow-downgrades \
    --allow-remove-essential \
    --allow-change-held-packages \
    nodejs

###########################################################################
# Install:
#  oh-my-zsh
###########################################################################

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY ./.zshrc /root/.zshrc

#########################################################################
# Install xvfb and Chrome headless dependencies
#########################################################################
RUN apt-get update && apt-get install -y \
    --allow-downgrades \
    --allow-remove-essential \
    --allow-change-held-packages \
    xvfb \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils

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
RUN rm /etc/php/7.3/fpm/pool.d/*
RUN adduser ${USER} www-data
COPY ./php-fpm/www.pool.conf /etc/php/7.3/fpm/pool.d/www.pool.conf
COPY ./php-fpm/php.ini /etc/php/7.3/fpm/php.ini


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

ENV DISPLAY :21.0
RUN Xvfb :21 -ac -screen 0 1200x800x16 &
CMD service php7.3-fpm start && \
    tail -f /var/log/php7.3-fpm.log

WORKDIR var/www
