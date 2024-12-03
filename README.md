# 💻 dotfiles

System wide config files.

Powering consistency, self documentation and saving some keystrokes.

## Installation

### First time setup:
Setup a new SSH key:

```sh
# generate new ssh key and set a passphrase -- [optionally specify filename]
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


#### Install Homebrew
> TODO: bring this into nix via a suitable module, etc

> INFO: Check [https://brew.sh](https://brew.sh) for the latest install command

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This will install Xcode tools and ensure we have `git` installed, etc.

#### Clone repo
> FIXME: The Nix setup is currently hard wired to this specific folder structure

Create the required local folder structure: `mkdir -p ~/Code/tgallacher && cd $_` and clone the dotfiles repo there: `git clone git@github.com:tgallacher/dotfiles.git`

> TODO: The following steps need to be completed manually, once.

Create new OSX workspaces -- min 5.

Open keyboard shortcuts and under "_Mission Control_" enable the shortcuts for switching to each workspace using `<C-<number>>`.

Under "Spotlight" disable (or remap) the keyboard shortcuts for Spotlight.

#### Bootstrap using nix
Ensure the target host has a suitable Nix config within [hosts/](./hosts) and this is added to the hosts entrypoint within [hosts/default.nix](./hosts/default.nix); This means ensuring there is a valid nix system config block defined (e.g. `inputs.nix-darwin.lib.darwinSystem` for a `nix-darwin` set up).

The following will bootstrap [nix-darwin](https://github.com/LnL7/nix-darwin), [home-manager](https://github.com/nix-community/home-manager), and the config specified in the flake files for the target host within the `hosts/`:
> Note: This is only run once

```sh
# "<hostname>" should match a system config within the above host entrypoint file
nix --experimental-features 'nix-command flakes' run nix-darwin -- switch --flake ".#<hostname>"
```

#### Setup Raycast (OSX hosts only)
Once complete, we will have installed [Raycast](https://www.raycast.com/) on OSX systems which is a Spotlight and Alfred alternative. However, GUI applications installed via HomeManager and/or Nix are not accessible via Spotlight, as Spotlight does not follow symlinks (_to the Nix store in this case_). Raycast does. But, Raycast is a GUI app, so we need to find it manually in the nix store so we can run and configure it for easier access later.

We can easily find the location of the Raycast binary using something like:

```sh
find /nix/store -type d -name "*-raycast-*" -print
```

We can then manually invoke the Raycast binary, e.g.
```sh
/nix/store/y5vlpzm7f1km0247bgl50lc89m3hp5nf-raycast-1.76.0/Applications/Raycast.app/Contents/MacOS/Raycast
```
This will run the app in the terminal (will consume the terminal window). This is enough to complete the 1st time setup; set the hotkey; and (crucially) enable "_start at login_".

With that configured, we can now close Raycast in the terminal (`<C-c>`). At this point we need to logout and back in for our new settings to take effect. This will also reset and correctly load our shell environment with all the necessary nix set up within out PATH variable.

#### Post Install: Manual steps

- Add [Vimium Chrome extension](https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) to Brave Browser
- Set Brave Browser to the _default browser_
- Open Nvim and allow all plugins to install (happens automatically on first load). Once complete, run `:UpdateRemotePlugins` to install "wilder" bindings, etc; and run `:checkhealth` if any other errors appear

### Apply Nix Changes
To apply changes made to any nix file for the target system, now that `nix-darwin` is available, can simply run:

```sh
darwin-rebuild switch --flake ".#<hostname>"
```

## TODO
- [ ] Can we change the default spotlight keyboard shortcuts through nix?
- [ ] Can we dynamically pull the location where the nix flake is at, to avoid having to hard code the `/Code/tgallacher/dotfiles` path?
- [ ] Fix Obsidian NVIM plugin loading projects that may not be on the host
- [ ] Fix git email - use direnv for the right folders?
- [ ] Allow configuring username at host level

## Troubleshoot
### "cannot write to nix.conf unrecognised values"
When installing Nix using the Determinate system install, it pre-configures a `nix.conf` file, and the `nix-darwin` bootstrapper doesn't seem to like it. To workaround this, manually move the file `mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin` and then run the bootstrap command above. Once done, you can manually copy over the contents of the original file to the config file created by the `nix-darwin` bootstrapper process.

### "mismatch in fixed-output derivation"
This is because a file is fetched and we define the expected SHA sum for it, and it has changed. The offending fetch will be in the error. Update the shasum.

### PATH is not set correctly
If `nix` or `darwin-rebuild` binaries are not found then this is usually a sign the shell isn't picking up the correct files. Most recently I came across this when running alacritty from raycast, when running raycast manually from the terminal. This prevents a login shell from running, which doesn't load all the necessary *rc or *env files. Following the recommendations above on Raycast setup resolves this issue.

## License

[MIT](./LICENSE)
