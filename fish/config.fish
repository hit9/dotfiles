# Using fish@2.7.1
# brew install fish@2.7.1
set pure_symbol_prompt ":) ->"

# Alias
alias g "git"
alias gst "git status"
alias gc "git commit -ev"

# Use advanced exa
alias ls exa

# Use bat instead of cat
alias cat bat

# Use ag instead of ack
alias ack ag

export GO111MODULE=on

alias nvim ~/.bin/nvim-osx64/bin/nvim

export GOPRIVATE="github.com/yogorobot/*"

# Pyenv init slow alot
# pyenv init - --no-rehash | source
alias python python3
alias pip pip3
