#!/usr/bin/env zsh
#
# .zshrc
#

# Autogen'd: 
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


CASE_SENSITIVE="true"

# Change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

#
## General config
#

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles


# Set omz variables prior to loading omz plugins
# see: https://github.com/ohmyzsh/ohmyzsh/issues/11762#issuecomment-1598235236
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
mkdir -p $ZSH_CACHE_DIR/completions


autoload -Uz compinit && compinit
# == Zsh Plugin manager
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load 


# == Local overrides
# Support adding custom local zsh config(s)
# Note: we use the null_glob opt to supress no match "errors"
#   @see: https://unix.stackexchange.com/a/26825
for f in $HOME/.*.zshlocal(.N); do source "$f"; done

# Autogen'd: To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
