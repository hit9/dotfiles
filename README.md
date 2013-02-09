关于
----

托管vim, bash, zsh, git, tmux, sakura, conky,配置文件的repo.用于在系统crash之后快速地恢复工作环境。

管理的方法
----------

这份dotfiles把所管理项目的配置文件集中放在dotfiles这个目录下(源的目录中). 通过建立指向dotfiles目录下配置文件的软链接来使配置文件生效。比如: vimrc 的文件实际存放在 `dotfiles/vim/.vimrc`, 我们建立如下的软链接来使告诉vim使用这份vimrc:

    ln -s /path/to/dotfiles/vim/.vimrc ~/.vimrc

而我们不必把使用到的工具(比如vim插件，终端增强工具,oh-my-zsh)等copy到这个源里，我们只要使用submodule即可(submodule就像一个指针，指向那个源的地址)

另外，vim的插件全部使用vundle管理的。

支持的工具配置文件
-----------------

(括号中是该配置文件使用了的Submodule)

- git: `.gitconfig`

- vim: `.vimrc (vundle，powerline)`

- bash: `.bashrc (dircolors-solarized)`

- zsh: `.zshrc (oh-my-zsh.dircolors-solarized)`

- conky: `.conky/`, `.conky`

- tmux: `.tmux.conf (powerline)`

- sakura: `.sakura.conf`

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
