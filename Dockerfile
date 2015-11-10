FROM alpine
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

git config --global core.editor "vim"

ADD .vimrc /root/.vimrc
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\
  /root/.vim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim\
  /root/.vim/colors/

RUN vim +PlugInstall +qall

