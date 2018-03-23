FROM theiaide/theia:next


RUN apk update && \
    apk upgrade  && \
    apk add \
    python \
    python3 \
    clang \
    openjdk8-jre-base  \
    sudo;


    
# Create user
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user
    
## Explicit allow access
RUN chmod g+rw /home/* && \
    chown theia:root /home/theia;
    
## Call package upgrade to make sure we don't supply with old packages
RUN apt-get update && apt-get -y upgrade 

VOLUME /home
WORKDIR /home/theia
EXPOSE 3000
USER 1000
CMD [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
