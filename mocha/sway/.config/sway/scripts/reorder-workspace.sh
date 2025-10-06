#!/bin/bash

# Get outputs sorted by x position
outputs=($(swaymsg -t get_outputs | jq -r '[.[] | {name: .name, x: .rect.x}] | sort_by(.x) | .[].name'))

ws=()

for i in "${!outputs[@]}"; do
    # Get workspaces for current output
    current_output="${outputs[$i]}"
    workspaces=($(swaymsg -t get_workspaces | jq -r --arg output "$current_output" '.[] | select(.output == $output) | .name'))
    ws[$i]="${workspaces[*]}"  # Combine with spaces
done

flat_ws=()
for sublist in "${ws[@]}"; do
    # Split the combined string back into individual elements
    flat_ws+=($sublist)
done

max=$(printf "%s\n" "${flat_ws[@]}" | sort -nr | head -1)

max=$((max * 2))

len=${#flat_ws[@]}

for ((i = len - 1; i >= 0; i--)); do
    swaymsg "rename workspace ${flat_ws[i]} to $max"
    flat_ws[$i]=$max
    ((max--))
done

for ((i = 0; i < len; i++)); do
    swaymsg "rename workspace ${flat_ws[i]} to $((i+1))"
done
