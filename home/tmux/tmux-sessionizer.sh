#!/usr/bin/env bash
# tmux-sessionizer - https://github.com/ThePrimeagen/.dotfiles

dirs=(
  ~/Code
)

selected_name=""
tmux_running=$(pgrep tmux)

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find "${dirs[@]}" -mindepth 1 -maxdepth 2 -type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$selected_name" -c "$selected"
  exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name"
