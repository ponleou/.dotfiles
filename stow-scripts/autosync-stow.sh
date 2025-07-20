#!/bin/bash

set -e

cd "$TMP_DIR"

git merge --squash origin/autocommit
git commit -m "autosync: sync from autocommit branch ($(date +'%d-%m-%Y %H:%M:%S'))"
git push
