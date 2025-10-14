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
stow --dir=$script_dir/mocha/base --target=$script_dir/essentials/bases sway-base

stow --dir=$script_dir/mocha/configs/background --target=$script_dir/mocha/mods transparent
stow --dir=$script_dir/mocha/configs/fx --target=$script_dir/mocha/mods blur

stow_accent() {
  local accent="$1"   # this is the variable after --dir=$script_dir/mocha/

  if [[ -f "$script_dir/.current_accent" ]]; then
    local prev_accent=$(cat "$script_dir/.current_accent")
    stow -D --dir="$script_dir/mocha/$prev_accent" --target="$HOME" nwg-look qt6ct
    stow -D --dir="$script_dir/mocha/$prev_accent" --target="$script_dir/mocha/options" rofi-option swaync-option waybar-option wlogout-option sway-option
  fi

  stow --dir="$script_dir/mocha/$accent" --target="$HOME" nwg-look qt6ct
  stow --dir="$script_dir/mocha/$accent" --target="$script_dir/mocha/options" rofi-option swaync-option waybar-option wlogout-option sway-option

  echo $accent > "$script_dir/.current_accent"

  nwg-look -a > /dev/null 2>&1
  papirus-folders -C cat-mocha-$accent > /dev/null 2>&1
  swaync-client --reload-css >/dev/null 2>&1
}

if [[ $valid_accent == 1 ]]; then
  stow_accent "$1"
else
  echo "Accent not found, fallback to default accent ${accents[0]}"
  stow_accent "${accents[0]}"
fi

swaymsg reload
