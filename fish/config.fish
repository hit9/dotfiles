set pure_symbol_prompt "->>"

# Alias
alias g "git"
alias gst "git status"
alias gc "git commit -ev"

# Pyenv init
status --is-interactive; and . (pyenv init -|psub)
