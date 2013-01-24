sakura是一个小巧的虚拟终端。

这个配置文件只是配置了下字体，配置了下透明。

用到的字体: Inconsolata_ , Inconsolata-dz-Powerline_

.. _Inconsolata: http://levien.com/type/myfonts/inconsolata.html

.. _Inconsolata-dz-Powerline: https://gist.github.com/1595572

手工安装配置文件
----------------

依赖:fonts, 请先按照fonts/Readme.rst安装fonts

::

    ln -s $(readlink sakura/.config/sakura/sakura.conf)  ~/.config/sakura/sakura.conf
