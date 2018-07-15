# Build Layer
FROM node:9
RUN apt-get -y install make gcc g++ python
ARG version=next
WORKDIR /home/theia
ADD $version.package.json ./package.json
RUN yarn && \
    yarn theia build && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

# Run layer
FROM node:9
ADD compile.sh /tmp/
RUN wget https://gist.githubusercontent.com/sr229/581959d87f11f33131116b7b82ff1e3f/raw/143088989d3c0528b3024730dc5a9677f31da644/hoe.sh | bash
COPY --from=0 /home/theia /home/theia
COPY entrypoint /home/theia
WORKDIR /home/theia 
EXPOSE 3000
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
VOLUME ["/home/project"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
CMD [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
