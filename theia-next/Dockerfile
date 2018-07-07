# Build Layer
FROM node:9-alpine
RUN apk add --no-cache make gcc g++ python
ARG version=next
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn && \
    yarn theia build && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

# Run layer
FROM node:9-alpine
RUN apk update && \
    apk upgrade  && \
    apk add --no-cache \
    python \
    python3 \
    py3-pip \
    clang \
    wget \
    curl \
    build-base \
    su-exec \
    openjdk8-jre-base  \
    sudo \
    unzip \
    openssh \
    gettext \
    git; 
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
          chmod 0440 /etc/sudoers.d/user;
## Explicit allow access
RUN addgroup theia && \ 
    adduser -G theia -s /bin/sh -D theia;
RUN mkdir -p /workspace
RUN mkdir -p /workspace/project
RUN mkdir -p /.theia
RUN mkdir -p /.npm
RUN chmod g+rw /.npm && chmod g+rw /.theia && \
    chown -R theia:theia /.npm && chown -R theia:theia /.theia;
COPY entrypoint /home/theia 
RUN chgrp -R 0 /home/theia && \
    chmod a+x /home/theia/entrypoint && \
    chmod -R g=u /home/theia && \
    chmod g=u /etc/passwd
EXPOSE 3000
RUN npm i -g typescript
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
VOLUME ["/home/theia/project"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
CMD [ "yarn", "theia", "start", "/home/theia/project", "--hostname=0.0.0.0" ]
