#!/bin/bash

primary_themes=("peach")
valid_theme=0

for theme in "${primary_themes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    valid_theme=1
    break
  fi
done

stow --dir=./mocha/base --target=$HOME btop konsole ghostwriter nwg-look qt6ct swaylock rofi swaync

if [[ $valid_theme == 1 ]]; then
  stow --dir=./mocha/$1 --target=$HOME nwg-look qt6ct sway waybar wlogout
  stow --dir=./mocha/$1 --target=./mocha/utils rofi-util swaync-util
else
  stow --dir=./mocha/"${primary_themes[0]}" nwg-look qt6ct sway waybar wlogout
fi