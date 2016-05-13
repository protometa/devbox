#!/bin/bash
docker build -t protometa/devbox . || exit
docker stop devbox
docker rm devbox-old
docker rename devbox devbox-old
docker create -it \
  -v $DOCKER_CERT_PATH:/certs \
  -v ~/code/:/home/lukenimtz/code/ \
  -p 2222:22 \
  --name devbox \
  protometa/devbox
