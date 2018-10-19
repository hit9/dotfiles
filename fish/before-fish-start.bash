#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export SHELL=/usr/local/bin/fishlogin
export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

# Be emacs
set -o emacs

# Node/Npm
export PATH=$PATH:$(brew --prefix)/share/npm/bin

# Golang
export GOPATH=/Users/hit9/gopark
export PATH=$PATH:$GOPATH/bin
source "/Users/hit9/github/oo/env"

# Rust/Cargo
export PATH=$PATH:/Users/hit9/.cargo/bin

# Pythonn
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Postgresql
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Ctrl-R
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
