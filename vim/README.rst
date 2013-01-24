手工安装
--------

依赖：powerline, 见powerline/Readme.rst

安装依赖后::

    # 更新vundle
    git submodule update --init vim/vundle
    # 创建.vim/bundle目录
    mkdir -p ~/.vim/bundle/  
    # 创建vundle的符号链接
    ln -s $(readlink -e vim/vundle) ~/.vim/bundle/vundle  
    # 按照绝对路径创建符号链接
    ln -s $(readlink -e vim/.vimrc) ~/.vimrc   
    # 进入vim 后 :BundleInstall
    vim  -c "BundleInstall"

截图
----

.. image:: https://raw.github.com/hit9/dotfiles/master/vim/gvim.png
