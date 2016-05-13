#!/bin/bash
docker start devbox && \
ssh -p 2222 \
  -o "SendEnv=DOCKER_HOST" \
  -A $(docker-machine ip)
