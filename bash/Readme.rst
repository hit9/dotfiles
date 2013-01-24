Powerline:

.. image:: https://raw.github.com/hit9/dotfiles/master/bash/powerline_shell.png

Dircolors:

.. image:: https://raw.github.com/hit9/dotfiles/master/bash/dircolors-solarized.png

手工安装
--------

依赖：fonts, 安装fonts参见fonts/Readme.rst

安装bashrc::

    #更新dircolors-solarized
    git submodule update --init dircolors-solarized
    #安装powerline-shell
    pip install --user --upgrade git+git://github.com/hit9/powerline-shell
    ln -s $(readlink bash/.bashrc) ~/.bashrc
