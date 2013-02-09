关于
----

托管vim, bash, zsh, git, tmux, sakura, conky,配置文件的repo.用于在系统crash之后快速地恢复工作环境。

这个repo只托管了配置文件，而工具(如vim插件，oh-my-zsh, 用到的py脚本什么的)都是submodule的方式.

支持的工具配置文件
-----------------

- git: .gitconfig

- vim: .vimrc (vundle，powerline)

- bash: .bashrc (dircolors-solarized)

- zsh: .zshrc (oh-my-zsh.dircolors-solarized)

- conky: .conky/  .conky

- tmux: .tmux.conf (powerline)

- sakura: .sakura.conf

我如何使用
----------

### 1.使用make

安装vim的配置文件vimrc

    make vim

安装tmux的配置文件tmux.conf

    make tmux

安装所有

    make all

强制建立软链接:(覆盖掉已有)

    make vim force=1

### 2.手工安装

在各个子目录下有Readme,里面有手工安装的方法。

使用建议
--------

Fork一份到你的账户下，建立你自己的dotfiles.

这份dotfiles完全依赖于Github, 是一份便携的工具箱。

使用Submodule来更新各个第三方repo:

    git submodule foreach git pull origin master

注意Lokaltog-powerline是使用的develop分支，更新它需要:

    cd Lokaltog-powerline; git checkout develop; git pull

截图
----

有部分工具有截图，在各自的目录的README中。

![](https://raw.github.com/hit9/dotfiles/master/Screenshot.gif)

![](https://raw.github.com/hit9/dotfiles/master/Screenshot.png)

测试的平台
----------

只测试了Ubuntu.

应该支持所有的Linux平台。
