手工安装
--------

创建目录~/.fonts 然后把.fonts下的字体全部拷贝过去

::

    mkdir -p ~/.fonts
    cp fonts/.fonts/* ~/.fonts/
    #更新字体缓存
    fc-cache -vf ~/.fonts 
