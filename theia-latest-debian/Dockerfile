# Build Layer
FROM node:carbon
RUN apt -y install make gcc g++ python
ARG version=latest
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn && \
    yarn theia build && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

# Run layer
FROM node:carbon
RUN adduser --disabled-password --gecos '' theia && \
    adduser theia sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt update && \
    apt -y upgrade  && \
    apt -y install \
    python \
    python3 \
    python3-pip \
    build-essential \
    clang \
    openjdk-8-jdk  \
    su-exec \
    wget \
    curl \
    su-exec \
    zsh \
    sudo \
    openssh-server \
    openssh-client \
    bash \
    git; 
    
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
          chmod 0440 /etc/sudoers.d/user;
## Explicit allow access
RUN mkdir -p /workspace
RUN mkdir -p /workspace/project
RUN mkdir -p /.theia
RUN chmod g+rw /workspace && \
chown -R theia:theia /workspace;
RUN chmod g+rw /workspace && \
chown -R theia:theia /workspace;
WORKDIR /workspace
RUN su-exec theia sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN  su-exec theia sh -c "$(cd ~/.oh-my-zsh/themes && wget https://raw.githubusercontent.com/noud02/dotfiles/master/zsh/themes/nyan.zsh-theme && cd ~/ && \
     rm -rf .zshrc && \
     wget https://raw.githubusercontent.com/noud02/dotfiles/master/zsh/zshrc >> .zshrc && \
     rm -rf zshrc;)"
COPY --from=0 /home/theia /home/theia
COPY --from=0 /home/theia /workspace
EXPOSE 3000
RUN npm i -g typescript
ENV SHELL /usr/bin/zsh
ENV USE_LOCAL_GIT true
VOLUME ["/workspace/project"]
USER 1000
ENTRYPOINT [ "yarn", "theia", "start", "/workspace/project", "--hostname=0.0.0.0" ]
