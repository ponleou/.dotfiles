#!/bin/bash
set -e

cd "$TMP_DIR"

git merge --squash origin/autocommit
git commit -m "Sync from autocommit ($(date +'%d-%m-%Y %H:%M:%S'))"
git push
