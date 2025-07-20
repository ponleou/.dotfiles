#!/bin/bash

set -e

notify-send "test"

cd "$TMP_DIR"

git fetch origin
notify-send "Git merge" "$(git merge --squash -X theirs origin/autocommit)"
git commit -m "autosync: sync from autocommit branch ($(date +'%d-%m-%Y %H:%M:%S'))"
notify-send "Git push for sync" "$(git push)"
