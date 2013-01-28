.. image:: https://raw.github.com/hit9/dotfiles/master/vim/gvim.png

.. image:: https://raw.github.com/hit9/dotfiles/master/vim/vim.png

手工安装
--------

依赖：powerline, 见powerline/Readme.rst

安装依赖后::

    git submodule update --init 
    # 更新vundle
    cd vim/vundle ; git checkout master ; git pull;
    # 更新pyflakes
    cd vim/pyflakes ; git checkout master ; git pull;python setup.py install;
    # 创建.vim/bundle目录
    mkdir -p ~/.vim/bundle/  
    # 创建vundle的符号链接
    ln -s $(readlink -e vim/vundle) ~/.vim/bundle/vundle  
    # 按照绝对路径创建符号链接
    ln -s $(readlink -e vim/.vimrc) ~/.vimrc   
    # 进入vim 后 :BundleInstall
    vim  -c "BundleInstall"

使用
----

可以直接看vimrc来了解使用，都有详细的中文注释.

Vim新手请看VimCheatSheet_

.. _VimCheatSheet: https://github.com/hit9/dotfiles/blob/master/vim/VimCheatSheet.rst

1. 命令

   ``:R`` 快速运行程序

   ``:PEP8`` 对python程序执行PEP8自动修正(依赖autopep8: pip install autopep8)

   ``:NT`` 打开NERDTree窗口浏览器

   ``:TG`` 打开taglist窗口

   ``:YR`` 打开持久化剪切板

   ``:GD`` 打开Gundo窗口(持久化undo)

2. 快捷键

   ``Ctrl-C`` 复制到系统剪切板

   ``Ctrl-V`` 从系统粘贴板粘贴 (注意:vim访问系统剪切板需要安装gvim)

   ``0`` 普通模式下按下0跳到行首

   ``9`` 普通模式下按下9跳到行尾

   ``w+方向键`` 快速地在各个分割的窗口之间跳转

   ``<leader>+w`` ``\`` 键后按下w启动快速跳转.类似vimoperater中的f


插件依赖
--------

- taglist依赖ctags , ubuntu下: ``sudo apt-get install ctags``
    
- pyflakes-vim 依赖pyflakes: ``pip install git+git://github.com/kevinw/pyflakes.git``
