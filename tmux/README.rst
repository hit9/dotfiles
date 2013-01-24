.. image:: https://raw.github.com/hit9/dotfiles/master/tmux/tmux.png

手工安装
--------

依赖: powerline, 参照powerline/Readme.rst

安装::
    
    # powerline的tmux扩展的主题配置文件
    mkdir -p ~/.config/powerline/themes/tmux
    ln -s $(readlink powerline/themes/tmux/default.json)  ~/.config/powerline/themes/tmux/default.json
    # tmux.conf
    ln -s $(readlink tmux/.tmux.conf) ~/.tmux.conf
