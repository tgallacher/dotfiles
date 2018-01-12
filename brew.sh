#!/bin/bash
#
# Install useful command-line tools using Homebrew.
#

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools + some useful utils.
brew install vim --with-override-system-vi
brew install grep openssh screen direnv dwdiff \
    trash ifstat nmap pwgen tree openssl sqlite xz

# Install other useful binaries.
brew install git
brew install ssh-copy-id

# Remove outdated versions from the cellar.
brew cleanup
