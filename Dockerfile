FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

RUN apt-get install -y software-properties-common
RUN sudo add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update
RUN apt-get install -y\
  neovim\
  git

ADD .nvimrc /root/.config/nvim/init.vim
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  /root/.config/nvim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  /root/.config/nvim/colors/

# RUN nvim -c "PlugInstall | qall"

# ENTRYPOINT nvim
