#!/bin/sh

# Theia image - Compile script
# Copyright 2018 (c) Ayane "Capuccino" Satomi

# prefetch and upgrade deps first
echo '--- BEGIN Container update ---'

apk update && \
apk upgrade;

# perform initial workspace required runtimes installations

apk add \
    bash \
    gettext \
    wget \
    su-exec \
    git \
    curl \
    go \
    python \
    python3 \
    py-pip \
    build-base \
    ffmpeg \
    tar \
    sudo \
    openjdk8 \
    openssh-client \
    openssh-server \
    gnupg;

# perform NPM override and install Theia CLI

echo '--- BEGIN NPM Override + Theia CLI install ---'

su-exec node npm i -g npm@4 @theia/cli@next

# perform initial package acquires for core Go packages

echo '--- BEGIN GoLang Core Libraries Cache ---'

go get -u -v github.com/ramya-rao-a/go-outline
go get -u -v github.com/acroca/go-symbols
go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/godoc
go get -u -v github.com/zmb3/gogetdoc
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/fatih/gomodifytags
go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v github.com/cweill/gotests/...
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v github.com/josharian/impl
go get -u -v github.com/haya14busa/goplay/cmd/goplay

# Create User
echo '--- BEGIN NOPASSWD Override ---'

echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user

echo '--- DONE NOPASSWD Override ---'

# Build Theia and chmod dirs
echo ' --- BEGIN IDE INSTALL ---'
mkdir -p /opt/app && \
      cd /opt/app && \
          theia build;

mkdir -p /workspace
chown -R node:root /workspace
chown -R node:root /home/node
chmod -R g+rw /home/node
chmod -R g+rw /workspace
find /home/node -type d -exec chmod g+x {} +

echo '-- POSTINSTALL Remove un-needed packages ---'
apk del su-exec && \
echo '-- Script Done. ---';