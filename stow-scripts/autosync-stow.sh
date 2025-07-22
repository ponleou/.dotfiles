#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

if [ -z "$TMP_DIR" ]; then
    TMP_DIR="$(cat $SCRIPT_DIR/../tmp/TMP_DIR)"
fi

cd "$TMP_DIR"


notify-send "Autosync is merging" "$(git merge --squash -X theirs origin/autocommit)"
git add -A
git commit -m "autosync: sync from autocommit branch ($(date +'%d-%m-%Y %H:%M:%S'))"

notify-send "Autosync is pushing" "$(git push)"

notify-send "Autosync completed"