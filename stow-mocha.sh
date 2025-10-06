#!/bin/bash

primary_themes=("peach")
valid_theme=0

for theme in "${primary_themes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    valid_theme=1
    break
  fi
done

stow --dir=./mocha/base --target=$HOME btop konsole ghostwriter

if [[ $valid_theme == 1 ]]; then
    stow --dir=./mocha/$1 --target=$HOME nwg-look qt6ct rofi sway swaylock swaync waybar wlogout
fi