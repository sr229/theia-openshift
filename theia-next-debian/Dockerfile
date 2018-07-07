# Build Layer
FROM node:carbon
RUN apt-get -y install make gcc g++ python
ARG version=next
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn && \
    yarn theia build && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

# Run layer
FROM node:carbon
RUN apt-get update && \
    apt-get -y upgrade  && \
    apt-get -y install sudo && \
    apt-get -y install \
    python \
    python3 \
    python3-pip \
    build-essential \
    clang \
    openjdk-7-jdk  \
    wget \
    curl \
    zsh \
    unzip\
    openssh-server \
    openssh-client \
    bash \
    git; 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
          chmod 0440 /etc/sudoers.d/user;
## Explicit allow access
RUN adduser --disabled-password --gecos '' theia
RUN mkdir -p /home/theia/project
RUN mkdir -p /.theia
RUN chmod g+rw /home
WORKDIR /home/theia/project
RUN mkdir -p /.theia
RUN mkdir -p /.npm
RUN chmod g+rw /.npm && chmod g+rw /.theia && \
    chown -R theia:theia /.npm && chown -R theia:theia /.theia;
COPY --from=0 /home/theia /home/theia
COPY entrypoint /home/theia 
RUN chgrp -R 0 /home/theia && \
    chmod a+x /home/theia/entrypoint && \
    chmod -R g=u /home/theia && \
    chmod g=u /etc/passwd
EXPOSE 3000
RUN npm i -g typescript
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
VOLUME ["/home/theia"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
CMD [ "yarn", "theia", "start", "/home/theia/project", "--hostname=0.0.0.0" ]
