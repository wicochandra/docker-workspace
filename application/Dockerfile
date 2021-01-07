FROM centos:8

###########################################################################
# Set Timezone
###########################################################################
ENV TZ Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

###########################################################################
# Set Locale
###########################################################################
ENV LOCALE en_US

RUN yum update && yum install -y \
        glibc-locale-source \
        glibc-langpack-en
RUN localedef -f UTF-8 -i en_US ${LOCALE}.UTF-8
ENV LANGUAGE=${LOCALE}.UTF-8
ENV LC_ALL=${LOCALE}.UTF-8
ENV LC_CTYPE=${LOCALE}.UTF-8
ENV LANG=${LOCALE}.UTF-8

###########################################################################
# Add non-root user:
###########################################################################
# Add a non-root user to prevent files being created with root permissions on host machine.
ENV PUID 1000
ENV PGID 1000
ENV USER www-data

RUN groupadd -g ${PGID} ${USER} && \
    useradd -u ${PUID} -g ${USER} -m ${USER} && \
    usermod -p "*" ${USER}


RUN dnf install -y \
    git \
    curl \
    wget \
    zsh \
    vim

    
###########################################################################
# Install:
#  nodejs
#  npm
###########################################################################
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN dnf install -y \
        nodejs \
        gcc-c++ \
        make \
        yarn
        
###########################################################################
# Install:
#  oh-my-zsh
###########################################################################

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY ./.zshrc /root/.zshrc

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
COPY ./php-fpm/www.pool.conf /etc/php-fpm.d/www.conf
COPY ./php-fpm/php.ini /etc/php.ini

RUN mkdir /run/php-fpm

###########################################################################
# Install:
#  php7.2
###########################################################################
RUN dnf install -y \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \ 
        https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf module enable php:remi-7.3 -y && dnf install -y \
        php-cli \
        php-common \
        php-curl \
        php-intl \
        php-json \
        php-xml \
        php-mbstring \
        php-zip \
        php-bcmath \
        php-memcached \
        php-fpm \
        php-mysql \
        php-gd \
        php-imagick \
        php-imap \
        php-xdebug \
        php-mailparse

WORKDIR var/www
EXPOSE 9000
EXPOSE 3000

# CMD tail -f /etc/php/7.2/fpm/php.ini
CMD [ "php-fpm", "-F", "-c /etc/php.ini"]
