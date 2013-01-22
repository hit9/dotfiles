vim, tmux, git ,conky 等工具的配置文件。为了快速的安装和备份，恢复工作环境。

安装
----

注意，不要删掉这个repo目录.

配置文件都在这么目录中,安装只是建立了软链接.安装脚本为 ``Install.py`` ,使用方法见 ``Install.py help``

安装配置文件后需要看下相应目录下的README.rst(比如vim/README.rst),看看还有需要进行的安装工作没有。

依赖
----

具体依赖不用细看。。直接看注意处:

**注意** ：终端用户一定要给自己的终端选择好字体:Inconsolata-g for Powerline

具体依赖:

vim, tmux, sakura的配置文件都依赖Inconsolata-g for Powerline字体,脚本会自动在安装以上任一个的时候安装字体

vim的rc依赖powerline, 脚本会检测powerline是否安装，没有安装的时候会自动安装

tmux的配置文件依赖tmux-powerline ,脚本会从github克隆并创建软链接到home目录

bashrc依赖powerline-shell, 脚本会自动安装这个powerline

截图
----

有部分工具有截图，在各自的目录的README中。

.. image:: https://raw.github.com/hit9/dotfiles/master/Screenshot.png
