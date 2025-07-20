#!/bin/bash

set -e

notify-send $TMP_DIR

cd "$TMP_DIR"

notify-send "Git merge" "$(git merge --squash origin/autocommit)"
git commit -m "autosync: sync from autocommit branch ($(date +'%d-%m-%Y %H:%M:%S'))"
notify-send "Git push for sync" "$(git push)"
