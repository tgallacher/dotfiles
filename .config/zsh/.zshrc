CASE_SENSITIVE="true"

# Change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# /end Oh-My-ZSH config


#
## General config
#

# == Antibody
# @see https://getantibody.github.io/
source <(antibody init)
# Update Oh-My-Zsh install location so that normal .oh-my-zsh works
antibody bundle robbyrussell/oh-my-zsh kind:dummy
export ZSH=$(antibody path robbyrussell/oh-my-zsh)

antibody bundle < $ZDOTDIR/.antibodyrc

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# == Hook direnv tool
# See https://direnv.net
which direnv &> /dev/null && eval "$(direnv hook zsh)";

# == Python
# Allow pyenv to autoconfig python for us
# see: https://opensource.com/article/19/5/python-3-default-mac
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# == NVM
export NVM_DIR="$XDG_CONFIG_HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# == Personal aliases / vars etc
[ -f $ZDOTDIR/.aliases.zsh ] && source $ZDOTDIR/.aliases.zsh
[ -f $ZDOTDIR/.variables.zsh ] && source $ZDOTDIR/.variables.zsh

# == Local overrides
# Support adding custom local zsh config(s)
# Note: This is required due to limitations in the ansible dotfiles role
# Note: we use the null_glob opt to supress no match "errors"
#   @see: https://unix.stackexchange.com/a/26825
for f in ~/.*.zshlocal(.N); do source "$f"; done
