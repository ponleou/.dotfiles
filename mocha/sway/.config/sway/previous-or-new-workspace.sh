#!/bin/bash

swaymsg -r -t get_workspaces | jq -r --arg OUTPUT $(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused == true) | .name') '(. | (max_by(.num) | .num)) as $max | [.[] | select(.output == $OUTPUT)] | (min_by(.num) | .num) as $minOutput | (.[] | select(.focused == true) | .num) as $current | if $minOutput < $current then "prev_on_output" else $max + 1 end'