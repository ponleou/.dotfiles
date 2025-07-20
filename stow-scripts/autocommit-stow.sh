#!/bin/bash

inotifywait -q -m -r --exclude '/\.git($|/)' \
  -e CLOSE_WRITE \
  -e CREATE \
  -e DELETE \
  -e MOVED_TO \
  -e MOVED_FROM \
  -e MODIFY \
  --format="git add -A && git commit -m 'autocommit: change in %w' && git push" ~/.dotfiles | sh
