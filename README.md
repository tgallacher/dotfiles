# 💻 dotfiles

System wide config files.

Powering consistency, self documentation and saving some keystrokes.

### Installation

## First time setup:
Install or setup a new SSH key.

```sh
# generate new ssh key -- optionally specify filename
ssh-keygen -t ed25519 -C "<email>"

# tell ssh agent to use the keychain for the passphrase
eval "$(ssh-agent -s)"
touch ~/.ssh/config

cat << EOF >> ~/.ssh/config
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF

# add file to osx's keychain so we don't need to keep typing the passphrase
ssh-add --apple-use-keychain ~/.ssh/<filename>
```
> Note: don't forget to add the public SSH key to the relevant DVCS (e.g. Github).

Then create the necessary folder structure: `mkdir -p ~/Code/tgallacher && cd $_` and clone the dotfiles repo in there:

```sh
# This will save having to install XCode dev tools to get started
nix shell -p git
```

```sh
git clone git@github.com:tgallacher/dotfiles.git
```

Create new workspaces -- min 5.

Open keyboard shortcuts and under "Misson Control" enable the shortcuts for switching to each workspace using `<C-<number>>`.

Under "Spotlight" disable (or remap) the keyboard shortcuts for Spotlight.

## Bootstrap using nix

> Note: The following steps require a suitable Nix config to exist (`inputs.nix-darwin.lib.darwinSystem`) for a given host (e.g. `m1pro=import ...`).


### Pre-requisites

Install Homebrew
> TODO: bring this into nix via a suitable module, etc

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install & Setup

Then, we can bootstrap the Nix setup:

```sh
# pwd should be the dotfiles repo root
nix run nix-darwin -- switch --flake ".#<hostname>"
```

The above command is only required for the 1st time run. This will install [nix-darwin](https://github.com/LnL7/nix-darwin), [home-manager](https://github.com/nix-community/home-manager), and the config specified in the flake files for the target host.

### Setup Raycast

GUI applications installed via HomeManager and/or Nix are not accessible via Spotlight, as it does not follow symlinks (to the Nix store in this case). However, [Raycast](https://www.raycast.com/) does, and is a better alternative all the same.

But, Raycast is a GUI app, so we need to find it manually in the nix store and run it once so we can configure it to auto load for us in the future.

We can find the location using something like:

```sh
find /nix/store -type d -name "*-raycast-*" -print
```

We can then manually invoke the raycast binary, e.g.
```sh
/nix/store/y5vlpzm7f1km0247bgl50lc89m3hp5nf-raycast-1.76.0/Applications/Raycast.app/Contents/MacOS/Raycast
```
This will run the app from the terminal, consuming the terminal. This is enough to complete the 1st time setup, set the hotkey, and crucially, enable "start at login".

With that set, we can then close the app by `<C-c>` in the terminal where we ran Raycast. At this point we can restart the computer, or logout and back in.

This will also mean that when we run Alacritty using Raycast, it spawns the correct shell type (login, interactive, etc) which will correctly have its `PATH` configured so that nix is accessible.

### Post install config

- Add [vimium](https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) extension to Brave Browser
- Set Brave Browser to the _default browser_
- Open Nvim and allow all plugins to install. Once complete, run `:UpdateRemotePlugins` to install "wilder" bindings, etc; and run `:checkhealth` if any other errors appear

### Apply Changes made to nix config
To apply changes made to any nix file for the target system, now that `nix-darwin` is available, can simply run:

```sh
darwin-rebuild switch --flake ".#<hostname>"
```

# TODO
- [ ] Can we change the default spotlight keyboard shortcuts through nix?
- [ ] Can we dynamically pull the location where the nix flake is at, to avoid having to hard code the `/Code/tgallacher/dotfiles` path?
- [ ] Fix Obsidian NVIM plugin loading projects that may not be on the host
- [ ] fix git email - use direnv for the right folders?
- [ ] Allow configuring username at host level

## Troubleshoot

### "mismatch in fixed-output derivation"
This is because a file is fetched and we define the expected SHA sum for it, and it has changed. The offending fetch will be in the error. Update the shasum.

### PATH is not set correctly
If `nix` or `darwin-rebuild` binaries are not found then this is usually a sign the shell isn't picking up the correct files. Most recently I came across this when running alacritty from raycast, when running raycast manually from the terminal. This prevents a login shell from running, which doesn't load all the necessary *rc or *env files. Following the recommendations above on Raycast setup resolves this issue.

## License

[MIT](./LICENSE)
