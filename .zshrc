# Bootstrap antigen
# @see https://github.com/zsh-users/antigen
source $(brew list antigen | grep zsh | head -n 1)

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

antigen init $HOME/.antigenrc

## /end Oh-My-ZSH config
#
## General config

# Hook direnv tool
# See https://direnv.net
which direnv &> /dev/null && eval "$(direnv hook zsh)";

[ -f $HOME/.aliases.zsh ] && source $HOME/.aliases.zsh
[ -f $HOME/.variables.zsh ] && source $HOME/.variables.zsh

# Allow pyenv to autoconfig python for us
# see: https://opensource.com/article/19/5/python-3-default-mac
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Support adding custom local zsh config(s)
# Note: we use the null_glob opt to supress no match "errors"
# @see: https://unix.stackexchange.com/a/26825
for f in ~/.*.zshlocal(.N); do source "$f"; done
