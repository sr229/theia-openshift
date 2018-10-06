# Build Layer
FROM node:8-stretch as build
RUN apt-get update && apt-get -y install make gcc g++ python php7.0-cli
RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
ARG version=latest
RUN adduser --disabled-password --gecos '' theia && \
    mkdir -p /etc/sudoers.d && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo "user ALL=(root) NOPASSWD:ALL" >> /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user;
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn && \
    yarn theia build && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

# Run layer
FROM node:8-stretch
COPY entrypoint /home/theia/
ADD compile.sh /tmp/
RUN cd /tmp/ && bash compile.sh
COPY --from=0 /home/theia /home/theia
WORKDIR /home/theia
EXPOSE 3000
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
ENV NODE_OPTIONS "--max-old-space-size=256"
VOLUME ["/home/project"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
CMD [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
