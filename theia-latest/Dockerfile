# IDE Layer
FROM theiaide/theia:latest as theia-base

# Run layer
FROM node:8-stretch
COPY --from=theia-base /home/theia /home/theia
COPY entrypoint /home/theia/
ADD compile.sh /tmp/
RUN cd /tmp/ && bash compile.sh
WORKDIR /home/theia
EXPOSE 3000
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
VOLUME ["/home/project"]
USER 10001
ENTRYPOINT ["/home/theia/entrypoint"]
# CMD [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
CMD [ "node", "--always-compact", "--max-old-space-size=64", "/home/theia/src-gen/backend/main.js", "/home/project", "--hostname=0.0.0.0" ] 
