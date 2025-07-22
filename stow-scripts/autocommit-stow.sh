#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
SYNC_TIMER_PID=""

trigger_sync_after_idle() {
  SYNC_TIMER_FILE="$SCRIPT_DIR/../tmp/SYNC_TIMER_PID"

  # get PID from file
  if [ -f "$SYNC_TIMER_FILE" ]; then
    SYNC_TIMER_PID="$(cat "$SYNC_TIMER_FILE")"
  fi

  # kill process if PID exist
  if [ -n "$SYNC_TIMER_PID" ]; then
    kill "$SYNC_TIMER_PID"
    SYNC_TIMER_PID="" 
  fi

  sleep 5 &
  SYNC_TIMER_PID=$!
  ( wait $SYNC_TIMER_PID && bash "$SCRIPT_DIR/autosync-stow.sh" ) &

  # echo into file for next run to kill process
  if [ -f "$SYNC_TIMER_FILE" ]; then
    echo "$SYNC_TIMER_PID" > "$SYNC_TIMER_FILE"
  fi
}

trigger_sync_after_idle

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
