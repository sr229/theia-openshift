# Theia image - Dockerfile
# Copyright 2018 (c) Ayane "Capuccino" Satomi
FROM node:alpine
MAINTAINER Ayane Satomi <enra@headbow.stream>


# necessary overrides because dtrace-provider fails

ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# Copy Package.json then initialize build

ADD package.json /opt/app/
ADD compile_container.sh /tmp/

RUN /tmp/compile_container.sh

# Copy Run script, expose 3000, and CMD

ADD run_container.sh /tmp/
ADD passwd_template /tmp/
EXPOSE 3000
ENV SHELL /bin/bash
WORKDIR /workspace
VOLUME /workspace
CMD ["/bin/sh", "-c", "/tmp/run_container.sh"]