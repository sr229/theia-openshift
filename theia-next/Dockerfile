# IDE Layer
FROM node:8-stretch as theia-base
RUN apt-get update && apt-get -y install make gcc g++ python
ARG version=next
RUN adduser --disabled-password --gecos '' theia && \
    mkdir -p /etc/sudoers.d && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo "user ALL=(root) NOPASSWD:ALL" >> /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user;
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn install --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn autoclean --force && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \    
    yarn cache clean

# Run layer
FROM node:8-stretch
COPY --from=theia-base /home/theia /home/theia
COPY entrypoint /home/theia/
ADD compile.sh /tmp/
RUN cd /tmp/ && bash compile.sh
WORKDIR /home/theia
EXPOSE 3000
ENV SHELL /bin/bash \
    USE_LOCAL_GIT true
VOLUME ["/home/project"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
CMD [ "node", "--always-compact", "--max-old-space-size=64", "/home/theia/src-gen/backend/main.js", "/home/project", "--hostname=0.0.0.0" ] 
