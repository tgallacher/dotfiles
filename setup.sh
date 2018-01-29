#!/bin/bash

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/shell/.zshrc" ~
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.wgetrc" ~
ln -sfv "$DOTFILES_DIR/.hushlogin" ~
ln -sfv "$DOTFILES_DIR/pip.conf" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore" ~

# Package managers & packages

# Make sure we have Homebrew installed
which brew > /dev/null
if [ $? -eq 0 ]; then
    source "$DOTFILES_DIR/brew.sh"
    source "$DOTFILES_DIR/brew-cask.sh"
else
    echo '>> NOTE: "brew" not found. Make sure to install Homebrew first';
fi;

source "$DOTFILES_DIR/install/npm.sh"
