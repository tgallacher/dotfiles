# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
fi

export LC_ALL=en_GB.UTF-8
export CASE_SENSITIVE="true"
export HIST_STAMPS="yyyy-mm-dd"

# cleaning up home folder
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Allow for alt. dir for zsh config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# use .zprofile to set environment vars for non-login, non-interactive shells.
# Note: atuoloads otherwise
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export BROWSER="brave"
export EDITOR=nvim
export TERMINAL=ghostty
export VISUAL=ghostty
export PAGER="less"

export HOMEBREW_NO_INSTALL_UPGRADE=1 # don't upgrade already installed formulae when running install for that formulae
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1 # don't install outdated formulae

export LEFTHOOK=0 # Disable Git pre-commit hooks that might be configured in some projects

