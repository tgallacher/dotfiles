#!/bin/bash
# Note
#   The following is not 100% POSIX compliant due to the use of the `((` command.
#
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# This will make updating any changes difficult
# as we will no have un commited changes...
#
# @todo How to get these whilst being able to distribute
# changes using `git pull`?
read -p 'Git username: ' gitUsername
read -p 'Git email: ' gitEmail

# Symlink config from here to the relevant user locations.
ln -sfv "$DOTFILES_DIR/.vimrc" $HOME
ln -sfv "$DOTFILES_DIR/.wgetrc" $HOME
ln -sfv "$DOTFILES_DIR/.hushlogin" $HOME
ln -sfv "$DOTFILES_DIR/pip.conf" $HOME
ln -sfv "$DOTFILES_DIR/shell/.zshrc" $HOME
ln -sfv "$DOTFILES_DIR/git/.gitconfig" $HOME
ln -sfv "$DOTFILES_DIR/git/.gitignore" $HOME

# @todo Remember the syntax..
# set -e {
#     echo '[user]';
#     echo '\tname = gitUsername';
#     echo '\temail = gitEmail';
# } | tee "$DOTFILES_DIR/git/.gitconfig";

#
# Package managers & packages
#

# Make sure we have Homebrew installed
which brew > /dev/null
if (($? != 0)); then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if (($? == 0)); then
    source "$DOTFILES_DIR/brew.sh"
    source "$DOTFILES_DIR/brew-cask.sh"
else
    echo '>> NOTE: "brew" not found. Make sure to install Homebrew first';
fi;

ln -sfv "$DOTFILES_DIR/vscode/user-settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
# Symlink vscode binary
ln -sfv /usr/local/bin/code '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'

# Install global NPM packages
source "$DOTFILES_DIR/npm.sh"
