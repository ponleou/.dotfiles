#!/bin/bash

# Get the current GPU status
gpu_status=$(supergfxctl -g)
desktop_session=$(echo $DESKTOP_SESSION)

# Check if dGPU is active (adjust the status string if needed)
if [[ "$gpu_status" == "Hybrid" ]]; then
    # Enable HDMI-A-1 (dGPU) and disable DP-3
#    wlr-randr --output HDMI-A-1 --toggle --pos -1707,0 --scale 1.5
    wlr-randr --output DP-3 --toggle --pos -1707,0 --scale 1.5
else
    # Enable DP-3 (iGPU) and disable HDMI-A-1
    wlr-randr --output DP-3 --toggle --pos -1707,0 --scale 1.5
fi
