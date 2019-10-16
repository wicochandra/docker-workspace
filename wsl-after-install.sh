#! /bin/sh

add-apt-repository -y ppa:ondrej/php
curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt update && apt install -y \
    libkrb5-dev \
    nodejs \
    unzip \
    php7.3-cli \
    python \
    python-pip

