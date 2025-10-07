#!/bin/bash

primary_themes=("peach")
valid_theme=0
script_dir="$(dirname "$(realpath "$0")")" # directory of where the script is

for theme in "${primary_themes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    valid_theme=1
    break
  fi
done

stow --dir=$script_dir/mocha/base --target=$HOME btop konsole ghostwriter nwg-look qt6ct swaylock rofi swaync waybar wlogout

if [[ $valid_theme == 1 ]]; then
  stow --dir=$script_dir/mocha/$1 --target=$HOME nwg-look qt6ct sway 
  stow --dir=$script_dir/mocha/$1 --target=$script_dir/mocha/utils rofi-util swaync-util waybar-util wlogout-util
else
  stow --dir=$script_dir/mocha/"${primary_themes[0]}" nwg-look qt6ct sway waybar wlogout
fi