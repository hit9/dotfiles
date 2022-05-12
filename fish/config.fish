# https://github.com/pure-fish/pure

set pure_symbol_prompt "=>"
set pure_color_virtualenv "magenta"

# Basic
set -x SHELL fish
set -x TERM screen-256color
set -x EDITOR vim
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# Go
set -x GOPATH $HOME/gopark
set -x GO111MODULE on
set -x GOPRIVATE "github.com/yogorobot/*"

# https://github.com/tj/n
set -x N_PREFIX $HOME/.n

# $PATH
set -e fish_user_paths
set -gx fish_user_paths \
        $HOME/.pyenv/shims \
        $GOPATH/bin \
        $HOME/.cargo/bin \
        $N_PREFIX/bin \
        /usr/local/lib/ruby/gems/3.1.0/bin \
        /usr/local/opt/ruby/bin \
        /Applications/Postgres.app/Contents/Versions/latest/bin/Applications/Postgres.app/Contents/Versions/latest/bin \
        /usr/local/opt/llvm/bin \
        /usr/local/sbin \
        /usr/local/bin \
        /usr/sbin \
        /usr/bin \
        /sbin \
        /bin \
        $HOME/.fzf/bin \
        $fish_user_paths

set -x XDG_CONFIG_HOME $HOME/.config

# oo
source $HOME/.oo/env.fish

# https://github.com/junegunn/fzf
set -x FZF_DEFAULT_COMMAND 'fd --type f --exclude .git'

# Rewrite Greeting message
functions -c fish_greeting _old_fish_greeting
function fish_greeting
    _old_fish_greeting
    if type -q fortune and type -q lolcat
        fortune -s | lolcat -l
    end
end

# pipenv
set -x PIPENV_VENV_IN_PROJECT 1

# Rewrite prompt for pyenv (overriding pure-fish/pure)
functions -c _pure_prompt_virtualenv _old_pure_prompt_virtualenv
function _pure_prompt_virtualenv
    if set -q PYENV_VERSION
        # https://github.com/pure-fish/pure/blob/master/functions/_pure_prompt_virtualenv.fish
        echo -n -s (set_color magenta) "" (basename "$PYENV_VERSION") "" (set_color normal) ""
    end
    if set -q VIRTUAL_ENV
        echo -n -s (set_color magenta) "" (basename "$VIRTUAL_ENV") "" (set_color normal) ""
    end
end


# Rewrite function fish_user_key_bindings
functions -c fish_user_key_bindings _old_fish_user_key_bindings
function fish_user_key_bindings
  _old_fish_user_key_bindings
  bind \cx edit_command_buffer  # Ctrl-X
end

# bat https://github.com/sharkdp/bat
set -x BAT_THEME zenburn

# Alias
alias g "git"
alias gst "git status"
alias gc "git commit -ev"
alias python python3
alias pip pip3
alias nvim ~/.bin/nvim-osx64/bin/nvim
alias vim ~/.bin/nvim-osx64/bin/nvim
alias ls exa
alias ack ag
alias sed gsed
# alias cat bat
# alias grep ggrep
