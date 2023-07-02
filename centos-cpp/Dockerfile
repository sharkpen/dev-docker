## 指定基础镜像为CentOS FROM centos:8
FROM centos:8

ARG user_name=lijinqi

ENV USER_NAME=${user_name}

## 设置作者信息
LABEL mantainer="${user_name}@croot.com"
## 安装必要的软件包


RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y && yum install -y sudo 
RUN yum install -y git zsh 

RUN useradd -m ${USER_NAME} -s /bin/bash \
    && sed -i '108 a\'"$USER_NAME"' ALL=(ALL) NOPASSWD: ALL' /etc/sudoers 


## 在容器中创建一个新的目录
USER ${user_name}
WORKDIR /home/${user_name}

## 将本地文件复制到容器中的/app目录中
COPY --chown=lijinqi:lijinqi . /home/${user_name}


RUN git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc 
RUN sed -i "s/robbyrussell/bira/" ~/.zshrc
RUN sudo usermod -s /bin/zsh ${USER_NAME} 


RUN sudo yum install -y \
    python3.9 \
    python39-devel \
    clang \
    llvm \
    cmake \
    wget \
    curl \
    gcc  \
    ncurses-devel \
    make 

RUN mkdir source && git clone https://github.com/vim/vim.git source/vim 
RUN cd /home/${USER_NAME}/source/vim \
    && ./configure --enable-python3interp=yes --with-python3-command=python3 \
    && make -j8 && sudo make install

RUN mkdir .vim && mkdir .vim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN vim -c PluginInstall -c q -c q
RUN cd /home/${USER_NAME}/.vim/bundle/YouCompleteMe && python3 install.py 

RUN sudo yum install -y \
    epel-release \
    java-1.8.0-openjdk-devel \
    git-clang-format

RUN echo 3 | sudo alternatives --config python
RUN echo 1 | sudo alternatives --config python3


RUN sudo yum groupinstall "Development Tools" -y

RUN cd /home/${USER_NAME}/source && wget https://github.com/bazelbuild/bazel/releases/download/6.1.0/bazel-6.1.0-installer-linux-x86_64.sh && sudo sh bazel-6.1.0-installer-linux-x86_64.sh

RUN cd /home/${USER_NAME}/workspace/example && bazel build //:hello



## 运行一些命令以准备容器
#RUN chmod +x /app/start.sh

## 定义容器启动时运行的命令
ENTRYPOINT ["/bin/zsh"]

