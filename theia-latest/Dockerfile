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
    bash \
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
RUN chmod g+rw .npm && chmod g+rw /.theia && \
    chown theia:theia /.npm && chown theia:theia;
RUN chmod g+rw /workspace && \
    chown -R theia:theia /workspace;
WORKDIR /workspace
COPY --from=0 /home/theia /home/node
COPY --from=0 /home/theia /workspace
EXPOSE 3000
RUN npm i -g typescript
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
VOLUME ["/workspace/project"]
USER theia
ENTRYPOINT [ "yarn", "theia", "start", "/workspace/project", "--hostname=0.0.0.0" ]
