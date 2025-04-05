#!/bin/bash

inotifywait -q -m -r -e CLOSE_WRITE --format="git -C %w add . && git -C %w commit -m 'autocommit on change in %w' && git -C  push" ../.dotfiles | sh 