FROM ubuntu:14.04
MAINTAINER Luke Nimtz <luke.nimtz@gmail.com>

WORKDIR /home/lukenimtz/

# set locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y software-properties-common
# neovim repo
RUN add-apt-repository ppa:neovim-ppa/unstable
# docker key and repo
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb http://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
  sudo openssh-server \
  wget curl lftp \
  git \
  zsh \
  python3-dev python3-pip \
  neovim \
  docker-engine \
&& rm -rf /var/lib/apt/lists/*

RUN yes | adduser lukenimtz --disabled-password --shell /bin/zsh \
  && echo '%lukenimtz   ALL= NOPASSWD: ALL' >> /etc/sudoers
RUN adduser lukenimtz docker
# alt home for mirroring host volumes on osx
RUN ln -s /home /Users

RUN mkdir -p /home/lukenimtz/.ssh/ \
  && wget https://github.com/protometa.keys -O /home/lukenimtz/.ssh/authorized_keys \
  && chmod 700 /home/lukenimtz/.ssh \
  && chmod 600 /home/lukenimtz/.ssh/authorized_keys \
  && mkdir /var/run/sshd

RUN pip3 install neovim

# nvim config
ADD nvimrc ./.config/nvim/init.vim
ADD http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  ./.config/nvim/autoload/
ADD http://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim \
  ./.config/nvim/colors/

# zsh config
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
ADD zshrc ./.zshrc
RUN chsh -s $(which zsh) lukenimtz

# git config
ADD gitconfig ./.gitconfig
ADD gitignore ./.gitignore

RUN nvim +PlugInstall +UpdateRemotePlugins +qall --headless

RUN mkdir code/
RUN chown -R lukenimtz:lukenimtz /home/lukenimtz

VOLUME /home/lukenimtz/code/

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
