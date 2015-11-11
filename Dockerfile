FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

RUN apt-get install -y software-properties-common
RUN sudo add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update
RUN apt-get install -y\
  python3-dev python3-pip\
  neovim\
  git

RUN pip3 install neovim

ADD .nvimrc /root/.config/nvim/init.vim
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  /root/.config/nvim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  /root/.config/nvim/colors/

RUN nvim +PlugInstall +qall --headless
ENV TERM=xterm-256colors

# ENTRYPOINT nvim
