# TODO: This needs to come before `antidote load` to avoid "compdef not found" error
autoload -Uz compinit && compinit

# Docker*
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# see: https://github.com/ohmyzsh/ohmyzsh/issues/11817#issuecomment-1655430206
zstyle ':omz:plugins:docker' legacy-completion yes

typeset -U path cdpath fpath manpath
# Ensure path arrays do not contain duplicates.
typeset -gU path fpath
# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="20000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

unsetopt APPEND_HISTORY
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
setopt autocd

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
# load plugins statically defined in "$(ZDOTDOR:-~)/.zsh_plugins.txt"
antidote load

# Mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# FZF
if command -v fzf >/dev/null 2>&1; then
  # INFO: workaround for keybind conflict between fzf + jeffreytse/zsh-vi-mode
  fzf --zsh > $HOME/.fzf.zsh
  zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git';
    export FZF_CTRL_T_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git';
    export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git';
  fi
fi

# Granted/Assume
alias -- assume="source assume"

# Kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if command -v switcher >/dev/null 2>&1; then
  source <(switcher init zsh)

  # optionally use alias `s` instead of `switch`
  alias s=switch

  # optionally use command completion
  source <(switch completion zsh)
fi

# load custom config, avoiding the need to commit into git (e.g. secrets, etc)
if [ -f $HOME/.custom.zshrc ]; then
  source $HOME/.custom.zshrc
fi

## Starship
if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

## Zoxide
eval "$(zoxide init zsh --cmd cd)"


## Aliases
alias -- cl=clear
alias -- ecr-login='aws ecr get-login-password --region eu-east-1 | docker login --username AWS --password-stdin $(aws sts get-caller-identity | jq -r '\''.Account'\'').dkr.ecr.eu-east-1.amazonaws.com'
alias -- egrep='egrep --color=auto'
alias -- fgrep='fgrep --color=auto'
alias -- ghd='gh dash'
alias -- git_prune_branches='git fetch && git remote prune origin && git br -v | grep gone | awk '\''{print $1;}'\'' | xargs -n 1 git br -d'
alias -- grep='grep --color=auto'
alias -- l='ls -lF -G'
alias -- la='ls -laF -G'
alias -- p=pulumi
# alias -- sb='z $HOME/Code/tgallacher/obsidian'
alias -- sudo='sudo '
alias -- v=nvim


## Yazi
# TODO - used?
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
