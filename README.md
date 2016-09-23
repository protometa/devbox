

# Usage

Create a volume for the SSH agent:

    docker volume create --name=ssh-agent 

Run:

    docker-compose run --rm devbox


# SSH Agent

This container uses an `ssh-agent` from another long-running container so that you don't have enter your key password every time you start this one. This enables the socket to be shared on Mac OS X.

Start SSH agent:

    docker run -u 1000 --rm -v ssh-agent:/ssh -v $HOME:$HOME -it whilp/ssh-agent ssh-add

Add keys:

    docker run -u 1000 --rm -v ssh-agent:/ssh -v $HOME:$HOME -it whilp/ssh-agent ssh-add $HOME/.ssh/id_rsa

