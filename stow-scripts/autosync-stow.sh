#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Set TMP_DIR is not set
if [ -z "$TMP_DIR" ]; then
  TMP_DIR_FILE="$SCRIPT_DIR/../tmp/TMP_DIR"
  
  if [ -f "$TMP_DIR_FILE" ]; then
    TMP_DIR="$(cat "$TMP_DIR_FILE")"
  fi
fi

# Exit if TMP_DIR is empty
if [ -z "$TMP_DIR" ]; then
  exit 1
fi

cd "$TMP_DIR"

LOCK_FILE="autosync.lock"
if [ -f "$LOCK_FILE" ]; then
  notify-send "Autosync aborted" "$TMP_DIR/$LOCK_FILE exists"
  exit 1
fi

# notify-send "Autosync is merging" "$(git merge --squash -X theirs origin/autocommit)"
# git add -A
# git commit -m "autosync: sync from autocommit branch ($(date +'%d-%m-%Y %H:%M:%S'))"

# notify-send "Autosync is pushing" "$(git push)"

# notify-send "Autosync completed"