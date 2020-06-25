#! /bin/sh

# install docker dependencies
apt update && apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


# Install others
add-apt-repository -y ppa:ondrej/php
curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt update && apt install -y \
    nodejs \
    unzip \
    php7.3-cli \
    python3 \
    python3-pip \
    zsh \
    docker-ce \
    docker-compose

# Assign current user to "docker" group
usermod -aG docker $USER

# Install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

