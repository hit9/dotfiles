dotfiles
---------

dotfiles for my vim, zsh, git and tmux when I'am ele.me.

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
