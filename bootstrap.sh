#!/usr/bin/env bash

brew_formulae=(
  # OS
  "FelixKratz/formulae/borders" # jankyBorders
  "tmux"

  # CORE
  "mise" # devtool manager
  "stow"
  "git"
  "dwdiff" # Another diff visualiser
  "curl" # Fetch stuff
  "tldr" # Man docs helper
  "rsync" # File transfer
  "unzip" # Zip files
  "unrar" # Rar files
  "zip" # Zip
  # MISC
  "mtr" # traceroute alternative
  "ykman" # yubikey manager
  "cargo" # (rnix)
  "gcc" # (C compiler)
  "gnumake"
  "rustc"
  "iperf" # Network performance

  # DEPS
  "libiconv" # rnix-lsp
  "pngpaste" # required for Obsidian.nvim
  "trash" # nvim-tree

  # >supapro
  "libpq" # pqsl cli
  "danielfoehrkn/switch/switch" # kubectx for large scale k8s installations
  "supabase/homebrew-packages/supa-admin-cli"
  "supabase/tap/supabase" # CLI Note: nixpkgs has not been updated to v2 yet

  "ifstat" # sketchybar
  "switchaudio-osx" # volume item; sketchybar
)

brew_casks=(
  # Base
  "brave-browser"
  "mullvad-vpn"
  "obsidian"
  "spotify"
  "whatsapp"
  "raycast"
  "font-monaspace-nerd-font"

  # supapro
  "aws-vault"     # aws credential management
  "bitwarden"
  "cloudflare-warp"
  "dbeaver-community"
  "discord"
  "front"         # support tickets
  "linear-linear" # project management
  "ngrok"
  "notion"
  "orbstack" # Docker desktop alternative
  "slack"
  "yubico-authenticator" # authenticator app

  "sf-symbols" # sketchybar
)

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

brew install --quiet "${brew_formulae[@]}"
brew install --cask --quiet "${brew_casks[@]}"

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
