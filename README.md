

# Usage

Create container:

    docker create -it -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -v ~/src/:/home/lukenimtz/src -v ~/.ssh:/home/lukenimtz/.ssh --name devbox1 protometa/devbox

Attach to container:

    docker start devbox1 && docker attach devbox1


