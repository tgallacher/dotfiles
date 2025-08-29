#!/usr/bin/env bash

###
## RUN
###

#-- Install
if command -v brew > /dev/null 2>&1; then
    echo "Brew already installed"
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "..Done"
fi

if command -v nix > /dev/null 2>&1; then
  echo "Nix CLI already installed"
else
  echo "Installing Nix CLI..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  echo "..Done"
fi

echo "To install brew packages, run 'darwin-rebuild switch --flake \".#<hostname>'\""

# #-- Configure
# stow_pkgs=(
#   btop
#   editorconfig
#   gh-dash
#   ghostty
#   git
#   home
#   hosts
#   hushlogin
#   k9s
#   libs
#   sketchybar
#   starship
#   tmux
#   wallpapers
#   wezterm
#   wget
#   yazi
#   zsh
# )
#
# stow -S "${stow_pkgs[@]}"
