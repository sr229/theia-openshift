FROM theiaide/theia:latest


RUN apk update && \
    apk upgrade  && \
    apk add \
    python \
    python3 \
    clang \
    openjdk8-jre-base  \
    sudo;


    
# Create user
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
          chmod 0440 /etc/sudoers.d/user;
    
## Explicit allow access
RUN mkdir -p /home/node && \
    mkdir -p /home/node/project;
RUN chmod g+rw /home/* && \
    chown -R node:root /home/node/*;

VOLUME /home
WORKDIR /home/node
EXPOSE 3000
USER 1000
CMD [ "yarn", "theia", "start", "/home/node/project", "--hostname=0.0.0.0" ]
