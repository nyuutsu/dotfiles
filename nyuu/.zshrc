zstyle :compinstall filename '/home/nyuu/.zshrc'

autoload -Uz compinit
compinit

## import

autoload colors; colors

if [ -f ~/.api_keys ]; then
. ~/.api_keys
fi

if [ -f ~/.env_vars ]; then
. ~/.env_vars
fi

if [ -f ~/.zsh_aliases ]; then
. ~/.zsh_aliases
fi

## tab complete

# force a reload of completion system if nothing matched
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

zstyle ':completion:*' menu select yes
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' completer _force_rehash _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:descriptions' format "$fg_bold[black]» %d$reset_color"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignored-patterns '*?.pyc' '__pycache__'
zstyle ':completion:*:*:rm:*:*' ignored-patterns

setopt complete_in_word

setopt extended_history hist_no_store hist_ignore_dups hist_expire_dups_first hist_find_no_dups inc_append_history share_history hist_reduce_blanks hist_ignore_space

export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
#export HISTSIZE=1000000
#export SAVEHIST=1000000

## misc

# .. options
setopt autocd beep extendedglob nomatch rc_quotes
unsetopt notify
# allow extendedglob + #-based command "comments"/"tags"
disable -p '#'

# don't count common path separators as word characters
WORDCHARS=${WORDCHARS//[&.;\/]}

REPORTTIME=5

# prompt
PROMPT="%{%(!.$fg_bold[red].$fg_bold[green])%}%n %~%{$reset_color%} %(!.ꙮ.⚕) "
RPROMPT_code="%(?..\$? %{$fg_no_bold[red]%}%?%{$reset_color%}  )"
RPROMPT_jobs="%1(j.%%# %{$fg_no_bold[cyan]%}%j%{$reset_color%}  .)"
RPROMPT_time="%{$fg_bold[black]%}%*%{$reset_color%}"
RPROMPT=$RPROMPT_code$RPROMPT_jobs$RPROMPT_time

# reconnect ssh socket in an existing tmux session
function fixssh {
  for line in "${(f)$(tmux show-environment)}"; do
    if [[ $line =~ '^SSH_\w+=' ]]; then
      echo export $line
      export $line
    fi
  done
}

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# keybindings
bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

# tab completion
bindkey '^i' complete-word  # tab to do menu
bindkey "\e[Z" reverse-menu-complete  # shift-tab to reverse menu

# shared history for ^R, other shell history ignored
down-line-or-local-history() {
  zle set-local-history 1
  zle down-line-or-history
  zle set-local-history 0
}
zle -N down-line-or-local-history

up-line-or-local-history() {
  zle set-local-history 1
  zle up-line-or-history
  zle set-local-history 0
}
zle -N up-line-or-local-history

bindkey "\e[A" up-line-or-local-history
bindkey "\eOA" up-line-or-local-history
bindkey "\e[B" down-line-or-local-history
bindkey "\eOB" down-line-or-local-history

page-up-within-tmux() {
  if [[ $TMUX == '' ]]; then
  else
    tmux copy-mode -u
  fi
}
zle -N page-up-within-tmux

# page up
bindkey "${terminfo[kpp]}" page-up-within-tmux

# arch i3 + i3-gaps merger breaks init urxvt cursor placement
clear
