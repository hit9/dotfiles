依赖:powerline-shell ,fonts

手工安装::

    ln -s $(readlink oh-my-zsh) ~/.oh-my-zsh
    ln -s $(readlink zsh/zshrc) ~/.zshrc


bash和zsh是两个常用的shell.

设置zsh为默认shell::

    chsh -s $(which zsh)  # 执行后重启下
