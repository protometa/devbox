#!/bin/bash
docker start devbox && ssh -p 2222 -A $(docker-machine ip)
