# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="sporty_256"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/hit9/.rvm/bin

export TERM=screen-256color

# dircolors-solarized : https://github.com/seebi/dircolors-solarized
eval `dircolors ~/dircolors.256dark`

# powerline 

_powerline_precmd() {
	export PS1="$(powerline-prompt --renderer_module=zsh_prompt --last_exit_code=$? --last_pipe_status="$pipestatus" left)"
	export RPS1="$(powerline-prompt --renderer_module=zsh_prompt --last_exit_code=$? --last_pipe_status="$pipestatus" right)"
	_powerline_tmux_set_pwd
}

_powerline_tmux_setenv() {
	if [[ -n "$TMUX" ]]; then
		tmux setenv TMUX_"$1"_$(tmux display -p "#D" | tr -d %) "$2"
	fi
}

_powerline_tmux_set_pwd() {
	_powerline_tmux_setenv PWD "$PWD"
}

_powerline_tmux_set_columns() {
	_powerline_tmux_setenv COLUMNS "$COLUMNS"
}

_powerline_install_precmd() {
	for f in "${precmd_functions[@]}"; do
		if [[ "$f" = "_powerline_precmd" ]]; then
			return
		fi
	done
	precmd_functions+=(_powerline_precmd)
}

trap "_powerline_tmux_set_columns" SIGWINCH
kill -SIGWINCH $$

_powerline_install_precmd
