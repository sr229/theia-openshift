#!/bin/sh

# Theia image - Compile script
# Copyright 2018 (c) Ayane "Capuccino" Satomi

# prefetch and upgrade deps first
echo '--- BEGIN Container update ---'

apk update && \
apk upgrade;

# perform initial workspace required runtimes installations

apk install \
    bash \
    gettext \
    wget \
    curl \
    go \
    python \
    python3 \
    build-base \
    ffmpeg \
    tar \
    sudo \
    openjdk8;

# perform NPM override and install Theia CLI

npm i -g npm@4 @theia/cli@latest

# perform initial package acquires for core Go packages

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

echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user


# Build Theia and chmod dirs
echo ' --- BEGIN IDE INSTALL ---'
cd /home/node && \
   theia build;

mkdir -p /workspace
chown -R node:root /workspace
chown -R node:root /home/node
chmod -R g+rw /home/node
chmod -R g+rw /workspace
find /home/node -type d -exec chmod g+x {} +

