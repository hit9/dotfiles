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

配置文件使用说明
----------------

- :R 命令会运行当前文件(对于C文件会gcc后再运行，对于python文件直接python执行 etc.)
- :PEP8 需要安装autopep8 ( ``pip install autopep8`` ), 会直接对正在编辑的py文件pep8转化
- :T 会打开NerdTree
  0 映射到^
  9 映射到$

VIM使用CheatSheet
-----------------

特别制作了一个VIM使用一览表:VimCheatSheet

插件说明
--------

- tagbar依赖ctags , ubuntu下: ``sudo apt-get install ctags``
    
  pyflakes-vim 依赖pyflakes: ``pip install git+git://github.com/kevinw/pyflakes.git``

截图
----

.. image:: https://raw.github.com/hit9/dotfiles/master/vim/gvim.png
