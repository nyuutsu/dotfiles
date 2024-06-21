# path
export PATH="${PATH}:$(find /home/nyuu/scripts -maxdepth 1 -type d -printf '%p:')"
export PATH="${PATH}:/home/nyuu/repos"

export PATH="${PATH}:/home/nyuu/.cargo/bin"
export PATH="${PATH}:/home/nyuu/.cabal/bin"
# python
export PATH="${PATH}:/home/nyuu/.local/bin"
export PATH="${PATH}:/home/nyuu/.virtualenvs"
export CONDA_ENVS_PATH="${PATH}:/home/nyuu/.conda/envs/babenv"
export PATH="${PATH}:/home/nyuu/.conda/envs/babenv"

# ssh agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# default programs
export EDITOR="vim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"

# cleanup
export XDG_CACHE_HOME="$HOME/.cache"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

export XDG_CONFIG_HOME="$HOME/.config"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
#export XCOMPOSEFILE="$XDG_CONFIG_HOME/x11/XCompose"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XRDB="$XDG_CONFIG_HOME/x11/xresources"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_DATA_HOME="$HOME/.local/share"
export CABAL_CONFIG="$XDG_DATA_HOME/cabal/config"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_DATA_HOME/history"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
#export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode

export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

# wm
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

#export PATH="${PATH}:/home/nyuu/bin" # who is this even for
