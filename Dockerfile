# Theia image - Dockerfile
# Copyright 2018 (c) Ayane "Capuccino" Satomi
FROM node:alpine
MAINTAINER Ayane Satomi <enra@headbow.stream>


# necessary overrides because dtrace-provider fails

ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# Copy Package.json then initialize build

COPY package.json /home/node/
COPY compile_container.sh /tmp/

RUN /tmp/compile_container.sh

# Copy Run script, expose 3000, and CMD

COPY run_container.sh /tmp/
COPY passwd_template /tmp/
EXPOSE 3000
VOLUME /workspace
ENV SHELL /bin/bash
CMD ["/bin/sh", "-c", "/tmp/run_container.sh"]