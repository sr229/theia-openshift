#!/bin/sh
set -e

apt-get update && \
    apt-get -y upgrade  && \
    apt-get -y install sudo && \
    apt-get -y install \
    python \
    python3 \
    python3-pip \
    python-pip \
    build-essential \
    clang \
    openjdk-7-jdk \
    wget \
    php7-cli \
    curl \
    unzip\
    openssh-server \
    openssh-client \
    bash \
    git;
npm i -g typescript
php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
# Step 2 : add user
adduser --disabled-password --gecos '' theia && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
chmod 0440 /etc/sudoers.d/user;
chown -R theia:theia /home/theia;
# Step 3: Add permissions
mkdir -p /home/project && \
         mkdir -p /.theia && \
         chmod g+rw /home &&  \
         mkdir -p /.theia && \
         mkdir -p /.npm && \
         chmod g+rw /.npm && chmod g+rw /.theia && chmod g+rw /home/project && \
         chown -R theia:theia /.npm && chown -R theia:theia /.theia && chown -R theia:theia /home/project;
         chgrp -R 0 /home/theia && \
         chmod a+x /home/theia/entrypoint && \
         chmod -R g=u /home/theia && \
         chmod g=u /etc/passwd;