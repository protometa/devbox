#!/bin/bash
ssh -p 2222 -At \
  -o "SendEnv=DOCKER_HOST" \
  $(docker-machine ip) \
  "cd $PWD; zsh"
