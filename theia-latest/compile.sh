#!/bin/sh
set -e

apt-get update && \
    apt-get -y upgrade  && \
    apt-get -y install sudo && \
    apt-get -y install \
    python3 \
    python3-pip \
    build-essential \
    dumb-init \
    wget \
    curl \
    gzip \
    unzip\
    openssh-client \
    git;
npm i -g typescript
# Step 2 : add user
adduser --disabled-password --gecos '' theia && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
chmod 0440 /etc/sudoers.d/user;
chown -R theia:theia /home/theia;
# Step 3: Add permissions
mkdir -p /home/project && \
mkdir -p /home/theia/plugins && \
         mkdir -p /.theia && \
         chmod g+rw /home &&  \
         mkdir -p /.theia && \
         mkdir -p /.npm && \
         chmod g+rw /.npm && chmod g+rw /.theia && chmod -R g+rw /home/project && chmod -R g+rw /home/theia/plugins && \
         chown -R theia:theia /.npm && chown -R theia:theia /.theia && chown -R theia:theia /home/project && chown -R theia:theia /home/theia/plugins;
         chgrp -R 0 /home/theia && \
         chmod a+x /home/theia/entrypoint && \
         chmod -R g=u /home/theia && \
         chmod g=u /etc/passwd;
         
# Step 4: Clean APT cache

apt-get clean
apt-get autoclean
rm -rf /var/cache/apt/archives