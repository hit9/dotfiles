local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[cyan]%}%n@%m%{$reset_color%} \
%{$fg[green]%}%c \
$(git_prompt_info)\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%} '
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} %{$fg[cyan]%}($gvm_go_name@$gvm_pkgset_name)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}:: %{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
