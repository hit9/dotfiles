Powerline:

.. image:: https://raw.github.com/hit9/dotfiles/master/bash/powerline_shell.png

Dircolors:

.. image:: https://raw.github.com/hit9/dotfiles/master/bash/dircolors-solarized.png

手工安装
--------

依赖：fonts, 安装fonts参见fonts/Readme.rst

安装bashrc::

    git submodule update --init
    #更新dircolors-solarized
    cd dircolors-solarized; git checkout master ; git pull ;
    ln -s $(readlink dircolors-solarized/dircolors.256dark) ~/dircolors.256dark
    #安装powerline-shell
    cd powerline-shell; git checkout master; git pull ; python setup.py install
    ln -s $(readlink bash/.bashrc) ~/.bashrc
