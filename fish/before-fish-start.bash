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
# export FZF_DEFAULT_OPTS='
#   --color=dark,hl:255,fg:30,hl+:255,fg+:30,bg+:235
#   --color info:108,prompt:109,spinner:108,pointer:168,marker:168
#'

# https://github.com/junegunn/fzf/wiki/Color-schemes
# Molokai (modified)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark,fg:252,hl:67,fg+:252,bg+:235,hl+:81
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
'
export FZF_DEFAULT_COMMAND='fd --type f --exclude .git'
