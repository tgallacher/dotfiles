CASE_SENSITIVE="true"

# Change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# /end Oh-My-ZSH config

# == Personal aliases / vars
[ -f $ZDOTDIR/.aliases.zsh ] && source $ZDOTDIR/.aliases.zsh
[ -f $ZDOTDIR/.variables.zsh ] && source $ZDOTDIR/.variables.zsh

#
## General config
#

# == Zsh Plugin manager
source "$ZDOTDIR/.antigenrc"

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# == Hook direnv tool
# See https://direnv.net
which direnv &> /dev/null && eval "$(direnv hook zsh)";

# == Python
# Allow pyenv to autoconfig python for us
# see: https://opensource.com/article/19/5/python-3-default-mac
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# == NVM
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# == Local overrides
# Support adding custom local zsh config(s)
# Note: This is required due to limitations in the ansible dotfiles role
# Note: we use the null_glob opt to supress no match "errors"
#   @see: https://unix.stackexchange.com/a/26825
for f in ~/.*.zshlocal(.N); do source "$f"; done
