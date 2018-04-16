#!/bin/bash

#
# Setup Homebrew Cask for simplier app installs
#

brew tap caskroom/cask

# Install packages

apps=(
  google-chrome-canary
  visual-studio-code
  google-chrome
  sublime-text
  dropbox
  spotify
  alfred
  docker
  iterm2
  slack
  vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize qlvideo
