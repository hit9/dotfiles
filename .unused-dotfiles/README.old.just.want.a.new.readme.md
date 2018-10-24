dotfiles
---------

dotfiles for my vim, zsh, git and tmux when I'am at Eleme.Inc

管理方法
--------

Repo只包含各种工具所依赖的配置文件，所有第三方依赖(如vim插件, oh-my-zsh等)不在git控制下。

vim插件使用vundle来安装，oh-my-zsh等其他工具作为submodule.

对应每个工具在makefile中有其安装的脚本。

所有配置文件都被软连接到其应当处于的位置，如`path/to/repo/dotfiles/vim/vimrc` 被软连接到 `~/.vimrc` 等等，这样
配置文件才会对相应应用生效。

First Step
----------

Update all submodules:

```
git submodule update --init
```

Vim
----

Download ctags from http://ctags.sourceforge.net/, then extract it and then

```
./configure
sudo make install
```

and then:

```
make vim
```

to force install (when the .vimrc already exists):

```
make vim force=1
```

tmux
-----

```
make tmux
```

git
---


```
make git
```

zsh
---

```
make zsh
```
