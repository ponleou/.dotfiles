#!/bin/bash

script_dir="$(dirname "$(realpath "$0")")" # directory of where the script is
stow --dir=$script_dir/script --target=$HOME user
