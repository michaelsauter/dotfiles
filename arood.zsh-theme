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
$fg[cyan]%D{%H:%M:%S} $fg[yellow]%c $(prompt_git)'
}

PROMPT='%{$reset_color%}%{$reset_color%}→ '
RPROMPT=''
