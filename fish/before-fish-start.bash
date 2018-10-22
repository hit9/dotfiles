#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export SHELL=/usr/local/bin/fishlogin
export TERM=screen-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

# Be emacs
set -o emacs

# Node/Npm
export PATH=$PATH:/usr/local/share/npm/bin

# Golang
export GOPATH=/Users/hit9/gopark
export PATH=$PATH:$GOPATH/bin
source "/Users/hit9/github/oo/env"

# Rust/Cargo
export PATH=$PATH:/Users/hit9/.cargo/bin

# Postgresql
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Ctrl-R
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Fzf color: Seoul256 Dusk
export FZF_DEFAULT_OPTS='
  --color=dark,hl:255,fg:30,hl+:255,fg+:30,bg+:235
'
