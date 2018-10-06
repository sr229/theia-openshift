# Build Layer
FROM node:9 as build
RUN apt-get -y install make gcc g++ python
ARG version=next
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
FROM node:9
COPY entrypoint /home/theia/
ADD compile.sh /tmp/
RUN cd /tmp/ && bash compile.sh
COPY --from=build /home/theia /home/theia
WORKDIR /home/theia
EXPOSE 3000
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
VOLUME ["/home/project"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
# CMD [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
CMD ["node", "--expose-gc", "--max-old-space-size=64", "--max-new-space-size=256", "/home/theia/src-gen/backend/main.js", "/home/project", "--hostname=0.0.0.0"]
