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
RUN mkdir /home/node
RUN chmod g+rw /home/* && \
    chown node:root /home/node;
    

VOLUME /home
WORKDIR /home/node
EXPOSE 3000
USER 1000
CMD [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
