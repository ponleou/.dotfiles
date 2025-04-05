#!/bin/bash

inotifywait -q -m -r --exclude '\.git' \
  -e CLOSE_WRITE \
  -e CREATE \
  -e DELETE \
  -e MOVED_TO \
  -e MOVED_FROM \
  -e MODIFY \
  --format="git add . && git commit -m 'autocommit: $(date +%d-%m-%YT%H:%M:%S) change in %w' && git push" ~/.dotfiles | sh
