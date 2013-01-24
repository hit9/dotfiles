.. image:: https://raw.github.com/hit9/dotfiles/master/tmux/tmux.png

手工安装
--------

依赖: fonts ,请先按照fonts/Readme.rst 安装字体

安装::
    
    # 更新tmux-powerline
    git submodule update --init tmux-powerline
    ln -s $(readlink tmux/.tmux.conf) ~/.tmux.conf
