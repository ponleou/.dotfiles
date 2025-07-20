#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
SYNC_TIMER_PID=""

trigger_sync_after_idle() {
    if [ -n "$SYNC_TIMER_PID" ]; then
      kill "$SYNC_TIMER_PID"
      SYNC_TIMER_PID="" 
    fi

    ( sleep 15 && bash $SCRIPT_DIR/autosync-stow.sh ) &
    SYNC_TIMER_PID=$!
    export SYNC_TIMER_PID
}

export SCRIPT_DIR
export -f trigger_sync_after_idle 

inotifywait -q -m -r --exclude '/\.git($|/)' \
  -e CLOSE_WRITE \
  -e CREATE \
  -e DELETE \
  -e MOVED_TO \
  -e MOVED_FROM \
  -e MODIFY \
  --format="git add -A && git commit -m 'autocommit: change in %w' && git push && trigger_sync_after_idle" ~/.dotfiles | sh
