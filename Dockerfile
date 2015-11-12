FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

# set locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# install neovim and git
RUN apt-get install -y software-properties-common
RUN sudo add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update
RUN apt-get install -y\
  python3-dev python3-pip\
  neovim\
  git

RUN pip3 install neovim

# nvim config
ADD .nvimrc /root/.config/nvim/init.vim
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  /root/.config/nvim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  /root/.config/nvim/colors/

RUN nvim +PlugInstall +UpdateRemotePlugins +qall --headless
ENV TERM=xterm-256color
ENV EDITOR=nvim

# git config
RUN git config --global user.email "luke.nimtz@gmail.com"
RUN git config --global user.name "Luke Nimtz"
RUN git config --global push.default simple

WORKDIR /root/src/
