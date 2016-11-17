# Custom functions
function __git_prompt_info() {
	GIT_PROMPT_PREFIX="(%{$fg_bold[green]%}"
	GIT_PROMPT_SUFFIX=")"
	GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$reset_color%}"
	GIT_PROMPT_CLEAN="%{$reset_color%}"

	is_git_dir=$(command git rev-parse --is-inside-work-tree 2> /dev/null)

	if [ "$is_git_dir" = "true" ]; then
		dirty=$(command git status --porcelain 2> /dev/null | tail -n1)
		git_branch=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null)

		if [[ -n $dirty ]]; then;
			echo " ${GIT_PROMPT_PREFIX}${git_branch}${GIT_PROMPT_DIRTY}${GIT_PROMPT_SUFFIX}"
		else
			echo " ${GIT_PROMPT_PREFIX}${git_branch}${GIT_PROMPT_CLEAN}${GIT_PROMPT_SUFFIX}"
		fi
	else
		echo "${PROMPT_CLEAN}"
	fi
}

# Autoloads
autoload -Uz compinit && compinit
autoload -Uz colors &&colors
autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search

# Options
setopt APPEND_HISTORY			# Append to history file instead of replacing
setopt AUTO_CD					# cd into directory if not command is specified
setopt BANG_HIST                # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY         # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST	# Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE        # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file.
setopt HIST_VERIFY              # Don't execute immediately upon history expansion.
setopt NOTIFY					# Report status of background jobs immediately
setopt PROMPT_SUBST				# Allow command substitution in prompt

# Bindings
bindkey -v
bindkey '\e[A'	up-line-or-beginning-search
bindkey '\e[B'	down-line-or-beginning-search
bindkey '^r'	history-incremental-search-backward
bindkey ' '		magic-space

# Prompt theme
PROMPT='[%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%}$(__git_prompt_info)%{$reset_color%}]$ '

# Environment variables
export EDITOR=vim
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.history

# Go
export GOPATH=$HOME/devel/go
export PATH="$PATH:$GOPATH/bin"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Aliases
alias tmux="tmux -2"
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tml='tmux list-sessions'

# Scripts
source $HOME/.scripts/z.sh
