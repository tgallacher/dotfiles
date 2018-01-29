#!/bin/bash

#
# Setup Homebrew Cask for simplier app installs
#

brew tap caskroom/cask

# Install packages

apps=(
  alfred
  dropbox
  docker
  google-chrome
  google-chrome-canary
  slack
  spotify
  sublime-text
  vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize qlvideo
