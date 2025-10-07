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
if [ -f "$SCRIPT_DIR/../tmp/$LOCK_FILE" ]; then
  notify-send "Autosync aborted" "$SCRIPT_DIR/../tmp/$LOCK_FILE exists"
  exit 1
fi

git rm -rf .
notify-send "Autosync is checking out $AUTO_BRANCH to $MERGE_BRANCH" "$(git checkout origin/$AUTO_BRANCH -- .)"
git add -A
notify-send "Autosync is commiting"  "$(git commit -m \"autosync: sync from $AUTO_BRANCH branch ($(date +'%d-%m-%Y %H:%M:%S'))\")"
notify-send "Autosync is pushing" "$(git push origin $MERGE_BRANCH)"

notify-send "Autosync completed"