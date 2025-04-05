#!/bin/bash

inotifywait -q -m -r --exclude '\.git' \
  -e CLOSE_WRITE \
  -e CREATE \
  -e DELETE \
  -e MOVED_TO \
  -e MOVED_FROM \
  -e MODIFY \
  -e ATTRIB \
  -e UNLINK \
  --format="git add . && git commit -m 'autocommit on change in %w' && git push" ~/.dotfiles | sh
