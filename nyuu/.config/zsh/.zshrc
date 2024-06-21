clear

zstyle :compinstall filename '/home/nyuu/.zshrc'
autoload -Uz compinit; compinit
autoload colors; colors

for file in ~/.config/zsh/.api_keys ~/.config/zsh/.zsh_aliases; do
  [[ -f $file ]] && source $file
done

# force a reload of completion system if nothing matched
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

zstyle ':completion:*' menu select yes
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' completer _force_rehash _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' max-errors 2
# Set up case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Exclude completions from the 'parameter' group (environment variables, etc.)
zstyle ':completion:*:parameters' ignored-patterns '*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*:descriptions' format "$fg_bold[black]» %d$reset_color"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignored-patterns '*?.pyc' '__pycache__'
zstyle ':completion:*:*:rm:*:*' ignored-patterns

setopt complete_in_word

setopt extended_history hist_no_store hist_ignore_dups hist_expire_dups_first hist_find_no_dups inc_append_history share_history hist_reduce_blanks hist_ignore_space
export HISTFILE=~/.config/zsh/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export ZSH_COMPDUMP="~/.config/zsh/zcompdump"
setopt autocd nomatch rc_quotes
unsetopt notify

# don't count common path separators as word characters
WORDCHARS=${WORDCHARS//[&.;\/]}
REPORTTIME=5

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

# General movement
# Taken from http://wiki.archlinux.org/index.php/Zsh and Ubuntu's inputrc
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

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

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source /home/nyuu/.config/broot/launcher/bash/br
