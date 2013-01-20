vim,tmux的配置文件用到了powerline,所以需要安装它。

鉴于个人不喜欢powerline的bash风格，bash命令行改用powerline-bash_

.. _powerline-bash: https://github.com/milkbikis/powerline-bash

Powerline是一个python写的工具，为bash,tmux,zsh,vim等提供了一致的powerline解决方案。

安装::

    pip install https://github.com/Lokaltog/powerline/tarball/develop

然后需要渲染字体,我喜欢用Inconsolata-g:

把fonts目录下的Inconsolata-g for Powerline 复制到.fonts下，或者这么安装::

    python setup.py fonts

然后注意：终端用户需要在自己的终端中选择这个字体: Inconsolata-g for Powerline 

我用的sakura终端，在dotfiles/sakura/../sakura.conf中已经配置好了！不用手工选择了。


