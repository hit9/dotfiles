.. image:: https://raw.github.com/hit9/dotfiles/master/conky/conky.png

手工安装
--------

::

    ln -s $(readlink conky/conkyrc) ~/.conkyrc
    ln -s $(readlink conky/conky) ~/.conky


开机启动: 把命令 `sh /path/to/dotfiles/conky/conky-startup.sh` 加入启动项
