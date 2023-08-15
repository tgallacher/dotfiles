# 💻 dotfiles

System wide config files.

Powering consistency, self documentation and saving some keystrokes.

### Installation

Designed to be used with `GNU Stow`. Or, copy/paste to your heart's content.

Note: Files inside `.config` will not work with GNU Stow. 

```sh
# install gnu stow
brew install stow

# stow a single tool's config
stow --target=$HOME <tool folder name> # e.g. stow zsh

# stow all
stow --target=$HOME */     # the `/` ensure we don't stow single files, which are to do with this repo
            # Note: this will stow the `.config` folder for linux stuff, until it is updated
```

## Todo
- Migrate Linux config, after review
- 

## License

[MIT](./LICENSE)
