手工安装
--------

依赖：fonts, 首先安装字体,见fonts/Readme.rst

::
    
    git submodule update --init # 更新vundle
    pip install --user --upgrade git+git://github.com/Lokaltog/powerline # 安装powerline
    ln -s $(readlink -e vim/.vimrc) ~/.vimrc   # 按照绝对路径创建符号链接
    mkdir -p ~/.vim/bundle/   # 创建.vim/bundle目录
    ln -s $(readlink -e vim/vundle) ~/.vim/bundle/vundle  # 创建vundle的符号链接
    vim # 进入vim 后 :BundleInstall

截图
----

.. image:: https://raw.github.com/hit9/dotfiles/master/vim/gvim.png
