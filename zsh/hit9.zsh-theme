local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[cyan]%}%n %c\
$(git_prompt_info)
%{$fg[yellow]%}%(!.#.$)%{$reset_color%} '

PROMPT2='%{$fg[red]%}\ %{$reset_color%} '
RPS1='${return_code} %{$fg[cyan]%}($(oo)%{$reset_color%} %{$fg[cyan]%}node@$(node -v))%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
