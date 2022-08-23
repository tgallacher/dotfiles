# default apps
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

# cleaning up home folder
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# Allow for alt. dir for zsh config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LC_ALL=en_GB.UTF-8
