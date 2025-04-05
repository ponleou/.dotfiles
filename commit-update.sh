#!/bin/bash

inotifywait -q -m -r --exclude '\.git' -e CLOSE_WRITE --format="git add . && git commit -m 'autocommit on change in %w' && git push" ~/.dotfiles | sh
