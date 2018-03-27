# Build Layer
FROM node:8-alpine
RUN apk add --no-cache make gcc g++ python
ARG version=latest
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn && \
    yarn theia build && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

# Run layer
FROM node:8-alpine
RUN addgroup theia && \ 
adduser -G theia -s /bin/sh -D theia;
RUN apk update && \
    apk upgrade  && \
    apk add --no-cache \
    python \
    python3 \
    py3-pip \
    clang \
    openjdk8-jre-base  \
    sudo \
    openssh \
    bash \
    git; 
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
          chmod 0440 /etc/sudoers.d/user;
## Explicit allow access
RUN mkdir -p /home/theia && \
    mkdir -p /home/theia/project;
RUN chmod g+rw /home/* && \
chown -R theia:theia /home/theia/*;
WORKDIR /home/theia
COPY --from=0 /home/theia /home/theia
EXPOSE 3000
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
USER 1000
ENTRYPOINT [ "yarn", "theia", "start", "/home/theia/project", "--hostname=0.0.0.0" ]
