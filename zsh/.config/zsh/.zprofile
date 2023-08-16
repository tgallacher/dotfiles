#!/usr/bin/env zsh
#
# .zprofile
#

export BROWSER="brave"

# 
# Editors
#

export EDITOR="nvim"
export TERMINAL="alacritty"
export PAGER="less"
export VISUAL="nvim"

#
# Paths
#

# Set the list of directories that zsh searches for commands
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Adjust Path
# Path mods should live here:
# source: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2

# TODO: why curl not installed in std location?
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share:$PATH"

# Pyenv bootstrap
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


# Ensure path arrays do not contain duplicates.
typeset -gU path fpath
# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path

