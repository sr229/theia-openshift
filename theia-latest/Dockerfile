FROM theiaide/theia:latest

RUN addgroup theia && \ 
    adduser -G theia -s /bin/sh -D theia;
    
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
RUN mkdir -p /home/theia && \
    mkdir -p /home/theia/project;
RUN chmod g+rw /home/* && \
    chown -R theia:theia /home/theia/*;

EXPOSE 3000
USER theia
ENTRYPOINT [ "yarn", "theia", "start", "/home/theia/project", "--hostname=0.0.0.0" ]
