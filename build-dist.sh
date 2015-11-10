./build-dev.sh

docker run -it --rm\
  -v /var/run/docker.sock:/var/run/docker.sock\
  -v $(which docker):$(which docker)\
  -v $(pwd):/root/src/\
  my-vim-docker-dev\
  docker build -f /root/src/Dockerfile-dist -t my-vim-docker /root/