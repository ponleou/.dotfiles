#!/bin/bash

accents=("peach" "yellow")
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

stow_accent() {
  local accent="$1"   # this is the variable after --dir=$script_dir/mocha/

    if [[ -f "$script_dir/.current_accent" ]]; then
    local prev_accent=$(cat "$script_dir/.current_accent")
    stow -D --dir="$script_dir/mocha/$prev_accent" --target="$HOME" nwg-look qt6ct
    stow -D --dir="$script_dir/mocha/$prev_accent" --target="$script_dir/mocha/utils" rofi-util swaync-util waybar-util wlogout-util sway-util
  fi

  stow --dir="$script_dir/mocha/$accent" --target="$HOME" nwg-look qt6ct
  stow --dir="$script_dir/mocha/$accent" --target="$script_dir/mocha/utils" rofi-util swaync-util waybar-util wlogout-util sway-util

  echo $accent > "$script_dir/.current_accent"
}

if [[ $valid_accent == 1 ]]; then
  stow_accent "$1"
else
  echo "Accent not found, fallback to default accent ${accents[0]}"
  stow_accent "${accents[0]}"
fi