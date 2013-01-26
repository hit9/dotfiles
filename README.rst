关于
----

托管vim, bash, zsh, git, tmux, sakura, conky,配置文件的repo.用于在系统crash之后快速地恢复工作环境。

安装
----

查看帮助::

    make

安装vim, conky::

    make vim conky

强制建立软链接进行安装::

    make vim force=1

安装所有::

    make all

手工安装:在各自目录下有安装说明


使用的第三方工具(submodule)
---------------------------

prompt: powerline-shell 

tmux: powerline

vim: vundle

ls: dircolors-solarized

zsh: oh-my-zsh

截图
----

有部分工具有截图，在各自的目录的README中。

.. image:: https://raw.github.com/hit9/dotfiles/master/Screenshot.png
