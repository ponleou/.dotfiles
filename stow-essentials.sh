#!/bin/bash

script_dir="$(dirname "$(realpath "$0")")" # directory of where the script is
stow --dir=$script_dir/essentials --target=$HOME easyeffects GIMP mpv omz cliphist dolphin sway vesktop