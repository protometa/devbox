FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y\
  vim-nox\
  git

ADD .vimrc /root/.vimrc
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  /root/.vim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  /root/.vim/colors/

RUN vim -T dumb +PlugInstall +qall

RUN git config --global user.email "luke.nimtz@gmail.com"
RUN git config --global user.name "Luke Nimtz"

WORKDIR /root/src/
