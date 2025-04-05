#!/bin/bash

grim -g "$(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" -l 0 -t ppm - | satty --filename - --fullscreen --copy-command wl-copy --early-exit --initial-tool crop --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png


