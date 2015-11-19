FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

RUN useradd -m lukenimtz && echo "lukenimtz:docker" | chpasswd && adduser lukenimtz sudo && adduser lukenimtz users
WORKDIR /home/lukenimtz/

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
  sudo wget curl\
  git\
  zsh\
  python3-dev python3-pip\
  neovim

RUN pip3 install neovim

# nvim config
ADD .nvimrc ./.config/nvim/init.vim
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  ./.config/nvim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  ./.config/nvim/colors/

ENV TERM=xterm-256color
ENV EDITOR=nvim

# zsh config
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
ADD .zshrc ./
RUN chsh -s $(which zsh) lukenimtz

RUN chown -R lukenimtz:lukenimtz ./
USER lukenimtz

# git config
RUN git config --global user.email "luke.nimtz@gmail.com"
RUN git config --global user.name "Luke Nimtz"
RUN git config --global push.default simple

RUN nvim +PlugInstall +UpdateRemotePlugins +qall --headless

WORKDIR /home/lukenimtz/src/
CMD zsh

