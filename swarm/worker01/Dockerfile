FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive

###########################################################################
# Set Locale
###########################################################################
ENV LOCALE id_ID

RUN apt-get update && apt-get install -y locales
RUN locale-gen ${LOCALE}.UTF-8
ENV LANGUAGE=${LOCALE}.UTF-8
ENV LC_ALL=${LOCALE}.UTF-8
ENV LC_CTYPE=${LOCALE}.UTF-8
ENV LANG=${LOCALE}.UTF-8

###########################################################################
# Set Timezone
###########################################################################
ENV TZ Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


###########################################################################
# Installation Dependencies
###########################################################################
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    telnet \
    net-tools \
    htp

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && apt-key fingerprint 0EBFCD88 && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

CMD tail -f /var/log/dpkg.log
