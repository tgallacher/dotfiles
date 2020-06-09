# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

## /end Oh-My-ZSH config
#

## General config
#
#

# == Antigen
# @see https://github.com/zsh-users/antigen
source $(brew list antigen | grep zsh | head -n 1)

# source $HOME/.powerlevel9k.zsh
antigen init $HOME/.antigenrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# == Hook direnv tool
# See https://direnv.net
which direnv &> /dev/null && eval "$(direnv hook zsh)";

# == Python
# Allow pyenv to autoconfig python for us
# see: https://opensource.com/article/19/5/python-3-default-mac
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# == Personal aliases / vars etc
[ -f $HOME/.aliases.zsh ] && source $HOME/.aliases.zsh
[ -f $HOME/.variables.zsh ] && source $HOME/.variables.zsh

# == Local overrides
# Support adding custom local zsh config(s)
# Note: This is required due to limitations in the ansible dotfiles role
# Note: we use the null_glob opt to supress no match "errors"
# @see: https://unix.stackexchange.com/a/26825
for f in ~/.*.zshlocal(.N); do source "$f"; done
