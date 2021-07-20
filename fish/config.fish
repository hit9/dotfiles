# Using fish@2.7.1
# brew install fish@2.7.1
set pure_symbol_prompt "=>"
set pure_color_virtualenv "magenta"

# Alias git
alias g "git"
alias gst "git status"
alias gc "git commit -ev"
# Use advanced exa
alias ls exa
# Use bat instead of cat
alias cat bat
# Use ag instead of ack
alias ack ag
# Alias gsed to sed
alias sed gsed

alias python python3
alias pip pip3
alias nvim ~/.bin/nvim-osx64/bin/nvim

export GO111MODULE=on
export GOPRIVATE="github.com/yogorobot/*"


# Tell pipenv to manage venv inside project directory
export PIPENV_VENV_IN_PROJECT=1

# Rewrite Greeting message
functions -c fish_greeting _old_fish_greeting
function fish_greeting
    _old_fish_greeting
    if type -q fortune and type -q lolcat
        fortune -s | lolcat
    end
end

# Rewrite prompt for pyenv (overriding pure-fish/pure)
functions -c _pure_prompt_virtualenv _old_pure_prompt_virtualenv
function _pure_prompt_virtualenv
    if set -q PYENV_VERSION
        # https://github.com/pure-fish/pure/blob/master/functions/_pure_prompt_virtualenv.fish
        echo -n -s (set_color magenta) "(" (basename "$PYENV_VERSION") ")" (set_color normal) ""
    end
    if set -q VIRTUAL_ENV
        echo -n -s (set_color magenta) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) ""
    end
end
 
# Rewrite function fish_user_key_bindings
functions -c fish_user_key_bindings _old_fish_user_key_bindings
function fish_user_key_bindings
  _old_fish_user_key_bindings
  bind \cx edit_command_buffer
end
