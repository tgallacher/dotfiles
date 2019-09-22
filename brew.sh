#!/usr/bin/env bash
#
# Install useful command-line tools using Homebrew.
#

## Prep

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install Utils:
#   `coreutils` - GNU core utilities (those that come with macOS are outdated).
#   `moreutils` - some other useful utilities like `sponge`
#   `findutils` - GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
#   `gnu-sed`   - GNU `sed`, overwriting the built-in `sed`
#   `gnupg`     - enable PGP-signing commits
utils=(
  ansible
  awscli
  coreutils
  curl
  direnv
  dwdiff
  findutils
  fontconfig
  freetype
  git
  git-secrets
  gnu-sed --with-default-names
  gnupg
  go
  grep
  ifstat
  iterm2
  jq
  moreutils
  nmap
  node@10
  openssh
  openssl
  openssl@1.1
  openvpn
  pwgen
  python
  python@2
  screen
  ssh-copy-id
  terraform
  trash
  tree
  vim --with-override-system-vi
  wget --with-iri
  xz
  yarn
)

brew install "${utils[@]}"

## Casks

apps=(
  1password
  alfred
  burp-suite
  docker
  firefox
  font-menlo-for-powerline
  font-source-code-pro-for-powerline
  google-chrome
  kap
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlstephen
  qlvideo
  quicklook-json
  spotify
  station
  visual-studio-code
  vlc
  xquartz
)

brew cask install "${apps[@]}"

## Cleanup
brew cleanup

## Post install setups
# $(brew --prefix coreutils)/libexec/gnubin >> $PATH
