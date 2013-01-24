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
    ln -s $(readlink dircolors-solarized/dircolors.256dark) ~/dircolors.256dark
    #安装powerline-shell
    pip install --upgrade git+git://github.com/hit9/powerline-shell
    ln -s $(readlink bash/.bashrc) ~/.bashrc
