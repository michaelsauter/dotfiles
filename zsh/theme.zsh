if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
PS1="%n@%m:%~%# "

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
ZSH_THEME_GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# Theme
prompt_git() {
  local ref dirty
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
      ZSH_THEME_GIT_PROMPT_DIRTY='±'
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
        local output="${ref/refs\/heads\//⭠  }$dirty"
        if [[ -n $dirty ]]; then
          echo -n "$fg[red]$output"
        else
          echo -n "$fg[green]$output"
            fi
            fi
}

function precmd() {
  print -rP '
$fg[cyan]%D{%H:%M} $USERNAME $fg[yellow]%c $(prompt_git)'
}

PROMPT='%{$reset_color%}%{$reset_color%}→ '
RPROMPT=''
