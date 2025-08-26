#!/usr/bin/env bash
# tmux-sessionkiller

if [[ -z $TMUX ]]; then
  echo "Cannot kill a session when not inside a tmux session"
  exit 1
fi

curr_session=$(tmux list-sessions | grep '(attached)' | sed -n 's/^\([^:]*\):.*/\1/p')

(tmux switch-client -l || tmux switch-client -p) && tmux kill-session -t "$curr_session"
