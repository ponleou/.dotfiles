#!/bin/bash

set -e

cd "$TMP_DIR"

# git add -A
# git commit -m "autosync: commiting previous merge ($(date +'%d-%m-%Y %H:%M:%S'))"
# notify-send "Autosync is pushing previous merge" "$(git push)"


notify-send "Autosync is merging" "$(git merge --squash -X theirs origin/autocommit)"
git commit -m "autosync: sync from autocommit branch ($(date +'%d-%m-%Y %H:%M:%S'))"

notify-send "Autosync is pushing" "$(git push)"
