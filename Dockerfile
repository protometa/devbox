FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

RUN apt-get update && apt-get install -y\
  vim-nox\
  git

ADD .vimrc /root/.vimrc
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  /root/.vim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  /root/.vim/colors/

RUN vim -T dumb +PlugInstall +qall

WORKDIR /root/src/
