###############################################################################
#                                 ZSH Config                                  #
###############################################################################

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
bindkey -e
bindkey '^r'	history-incremental-search-backward
bindkey ' '		magic-space

# Special key bindings
typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"       beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"        end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"     overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]"  backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"     delete-char
[[ -n "$key[PageUp]"    ]] && bindkey -- "$key[PageUp]"     up-line-or-history
[[ -n "$key[PageDown]"  ]] && bindkey -- "$key[PageDown]"   down-line-or-history
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"         up-line-or-beginning-search
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"       down-line-or-beginning-search
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"       backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"      forward-char

# Prompt theme
PROMPT='[%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%}$(__git_prompt_info)%{$reset_color%}]$ '

# Environment variables
export EDITOR=nvim
export HISTSIZE=10000
export SAVEHIST=10000
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Aliases
alias tmux="tmux -2"
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tml='tmux list-sessions'

# Local executables
export PATH="$HOME/.local/bin:$PATH"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
