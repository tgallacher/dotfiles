##!/usr/bin/env zsh

# Helper to improve interop between desktop / laptop
export __IS_OSX=$(uname -s | grep -cF "Darwin")
export __IS_NIXOS=$(uname -v | grep -cF "NixOS")

# cleaning up home folder
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# Allow for alt. dir for zsh config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LC_ALL=en_GB.UTF-8

# use .zprofile to set environment vars for non-login, non-interactive shells.
# Note: atuoloads otherwise
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
