#!/bin/bash

accents=("peach")
valid_accent=0
script_dir="$(dirname "$(realpath "$0")")" # directory of where the script is

for accent in "${accents[@]}"; do
  if [[ "$1" == "$accent" ]]; then
    valid_accent=1
    break
  fi
done

stow --dir=$script_dir/mocha/base --target=$HOME btop konsole ghostwriter nwg-look qt6ct swaylock rofi swaync waybar wlogout
stow --dir=$script_dir/mocha/base --target=$script_dir/essentials/utils sway-util

stow_theme() {
  local accent="$1"   # this is the variable after --dir=$script_dir/mocha/

  stow --dir="$script_dir/mocha/$accent" --target="$HOME" nwg-look qt6ct
  stow --dir="$script_dir/mocha/$accent" --target="$script_dir/mocha/utils" rofi-util swaync-util waybar-util wlogout-util sway-util
}

if [[ $valid_accent == 1 ]]; then
  stow_theme "$1"
else
  stow_theme "${accents[0]}"
fi