# 💻 dotfiles

System wide config files.

Powering consistency, self documentation and saving some keystrokes.

### Installation

## First time setup:

```sh
nix shell -p git vim
```

Install or setup new ssh key.

```sh
# generate new ssh key -- optionally specify filename
ssh-keygen -t ed25519 -C "<email>"

# add file to osx's keychain so we don't need to keep typing the passphrase
ssh-add --apple-use-keychain ~/.ssh/<filename>

# don't forget to add public key to github
```

Clone dotfiles repo

```sh
git clone git@github.com:tgallacher/dotfiles.git
```

## Bootstrap using nix

```sh
darwin-rebuild switch --flake ".#<hostname>"
```

## License

[MIT](./LICENSE)
