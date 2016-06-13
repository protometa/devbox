FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

RUN useradd -m lukenimtz && \
  echo "lukenimtz:docker" | chpasswd && \
  adduser lukenimtz sudo && \
  adduser lukenimtz users
  
WORKDIR /home/lukenimtz/

# set locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# neovim repo
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable
# docker key and repo
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb http://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
  sudo wget curl lftp \
  git \
  zsh \
  python3-dev python3-pip \
  neovim \
  docker-engine \
&& rm -rf /var/lib/apt/lists/*

RUN adduser lukenimtz docker

RUN pip3 install neovim

RUN pip3 install docker-compose
RUN curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
  chmod +x /usr/local/bin/docker-machine

# nvim config
ADD .nvimrc ./.config/nvim/init.vim
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  ./.config/nvim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim \
  ./.config/nvim/colors/

ENV TERM=xterm-256color
ENV EDITOR=nvim

# zsh config
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
ADD .zshrc ./
RUN chsh -s $(which zsh) lukenimtz

RUN mkdir code/
RUN chown -R lukenimtz:lukenimtz ./
USER lukenimtz

# git config
RUN git config --global user.email "luke.nimtz@gmail.com"
RUN git config --global user.name "Luke Nimtz"
RUN git config --global push.default simple

RUN nvim +PlugInstall +UpdateRemotePlugins +qall --headless

VOLUME  /home/lukenimtz/code/

WORKDIR /home/lukenimtz/
CMD ["/bin/zsh"]

