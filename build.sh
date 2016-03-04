#!/bin/bash
docker build -t protometa/devbox . || exit
docker stop devbox
docker rm devbox-old
docker rename devbox devbox-old
docker create -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.ssh:/home/lukenimtz/.ssh -v ~/src/:/home/lukenimtz/src/ --name devbox protometa/devbox
