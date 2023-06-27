# https://github.com/pure-fish/pure
# Leader symbol for fish prompt
set pure_symbol_prompt "\$"
set pure_color_virtualenv "magenta"
set pure_show_jobs true
set pure_color_jobs "blue"
set pure_show_system_time false

# Basic
set -x SHELL fish
set -x TERM screen-256color
set -x EDITOR nvim
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# Go
set -x GOPATH $HOME/dev/gopark
set -x GO111MODULE on

# https://github.com/tj/n
# Where node versions stores.
set -x N_PREFIX $HOME/.n

# vcpkg (c++ package manager)
# VCPKG_ROOT is the path of vcpkg repo.
set -x VCPKG_ROOT $HOME/dev/vcpkg

# $PATH environment variable
set -e fish_user_paths
set -gx fish_user_paths \
    $HOME/.pyenv/shims \
    $GOPATH/bin \
    $HOME/.cargo/bin \
    $HOME/.dotnet/tools \
    $N_PREFIX/bin \
    $VCPKG_ROOT \
    $HOME/dev/src/flutter/bin \
    /usr/local/lib/ruby/gems/3.4.2/bin \
    /usr/local/opt/ruby/bin \
    /usr/local/opt/llvm/bin \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/sbin \
    /usr/bin \
    /sbin \
    /bin \
    $HOME/.fzf/bin \
    $fish_user_paths

# Config files directory.
set -x XDG_CONFIG_HOME $HOME/.config

# oo (Go version manager)
source $HOME/.oo/env.fish

# homebrew
# disable auto updates.
set -x HOMEBREW_NO_AUTO_UPDATE 1

# https://github.com/junegunn/fzf
set -x FZF_DEFAULT_COMMAND 'fd --type f --exclude .git'

# Rewrite Greeting message
# https://github.com/jaseg/lolcat
if not functions -q _old_fish_greeting
    functions -c fish_greeting _old_fish_greeting
end
function fish_greeting
    _old_fish_greeting
    if type -q fortune and type -q lolcat
        fortune -s | lolcat -l
    end
end

# Rewrite prompt for pyenv (overriding pure-fish/pure)
if not functions -q  _old_pure_prompt_virtualenv
    functions -c _pure_prompt_virtualenv _old_pure_prompt_virtualenv
end
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
if functions -q fish_user_key_bindings
    if not functions -q _old_fish_user_key_bindings
        functions -c fish_user_key_bindings _old_fish_user_key_bindings
    end
end

function fish_user_key_bindings
    if functions -q _old_fish_user_key_bindings
        _old_fish_user_key_bindings
    end
    # Ctrl-X to edit command buffer with $EDITOR
    bind \cx edit_command_buffer
end

# fish dotenv function
# Execute `dotenv` will load environment variables from file `.env`.
function dotenv --description 'Load environment variables from .env file'
    set -l envfile ".env"

    if [ (count $argv) -gt 0 ]
        set envfile $argv[1]
    end

    if test -e $envfile
        # If envfile exists, set env variables one by one.
        for line in (cat $envfile | grep -e '[^[:space:]]' | grep -v '^#')
            set -xg (echo $line | cut -d = -f 1) (echo $line | cut -d = -f 2-)
        end

        set -xg __PYENV_ACTIVATE 1

        # Rewrite _pure_prompt function
        if not functions -q _old_pure_prompt
            functions -c _pure_prompt _old_pure_prompt
        end

        # Insert dotenv prefix to prompt
        function _pure_prompt  --inherit-variable envfile --argument-names exit_code
            if set -q __PYENV_ACTIVATE
                echo -n -s (set_color green) "(" $envfile ")" (set_color normal) " "
            end
            _old_pure_prompt $exit_code
        end
    end
end

function dotenv-erase --description 'Erase environment variables from given file'
    set -l envfile ".env"

    if [ (count $argv) -gt 0 ]
        set envfile $argv[1]
    end

    if test -e $envfile
        # If envfile exists, set env variables one by one.
        for line in (cat $envfile | grep -e '[^[:space:]]' | grep -v '^#')
            set --erase (echo $line | cut -d = -f 1)
        end
    end

    set --erase __PYENV_ACTIVATE
end

# Alias
alias g "git"
alias gst "git status"
alias gc "git commit -ev"
alias python python3
alias pip pip3
alias nvim ~/.bin/nvim-osx64/bin/nvim
alias ls exa
alias ack ag
alias sed gsed
