# Build Layer
FROM node:carbon
RUN apt-get -y install make gcc g++ python
ARG version=latest
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
RUN mkdir -p /workspace
RUN mkdir -p /workspace/project
RUN mkdir -p /.theia
RUN chmod g+rw /workspace && \
    chown -R node:node /workspace;
WORKDIR /workspace
RUN su node -c "$(cd /home/node && git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh)"
RUN su node -c "$(cd /home/node/.oh-my-zsh/themes && wget https://raw.githubusercontent.com/noud02/dotfiles/master/zsh/themes/nyan.zsh-theme && cd ~/ && \
     rm -rf .zshrc && \
     wget https://raw.githubusercontent.com/noud02/dotfiles/master/zsh/zshrc >> .zshrc && \
     rm -rf zshrc;)"
RUN su node -c "$(cd /home/node && \
  mkdir .fonts && \
  cd .fonts && \
  wget "https://github.com/FortAwesome/Font-Awesome/raw/master/use-on-desktop/Font%20Awesome%205%20Free-Regular-400.otf" && \
  wget "https://github.com/FortAwesome/Font-Awesome/raw/master/use-on-desktop/Font%20Awesome%205%20Brands-Regular-400.otf" && \
  wget "https://github.com/FortAwesome/Font-Awesome/raw/master/use-on-desktop/Font%20Awesome%205%20Free-Solid-900.otf";)"
COPY --from=0 /home/theia /home/node
COPY --from=0 /home/theia /workspace
EXPOSE 3000
RUN npm i -g typescript
ENV SHELL /bin/zsh
ENV USE_LOCAL_GIT true
VOLUME ["/workspace/project"]
USER 1000
ENTRYPOINT [ "yarn", "theia", "start", "/workspace/project", "--hostname=0.0.0.0" ]
