

# Usage

    alias dev="docker run -it --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v $(which docker):$(which docker) \
      -v $(pwd):/root/src/ \
      protometa/devbox"

