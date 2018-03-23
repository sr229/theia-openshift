FROM theiaide/theia:next

#Python 2
RUN apt-get update && apt-get install -y python python-pip && \
 pip install python-language-server;
 
#Python 3
RUN add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update && \
    apt-get install -y python3.6
    
#Developer tools

## Git and sudo (sudo needed for user override)
RUN apt-get -y install git sudo

#OpenShift compatibility
## User account
RUN adduser --disabled-password --gecos '' theia && \
    adduser theia sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;
    
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
