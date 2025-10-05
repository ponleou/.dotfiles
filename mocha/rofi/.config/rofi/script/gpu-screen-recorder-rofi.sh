#!/usr/bin/env bash
#
# gpu-screen-recorder constrols for rofi
#
# Author: Justus0405
# Date: 30.04.2025
# License: MIT
# 
# Modified by: ponleou

###########
# CONFIG #
##########
FRAMERATE="60"
FRAMERATE_MODE="cfr"
SAVE_DIR="/media/Shared/Drive/Replay captures"
REPLAY_BUFFER_SEC="60"
VIDEO_CODEC="hevc"
AUDIO_CODEC="opus"

# Make sure the "Videos" folder exists
if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
fi

# Create Menu Items
options=(" Start Recording" " Stop Recording" " Pause/Resume Recording" " Start Replay" " Stop Replay" " Save Replay")

# Print Menu Items each with a newline
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p " 󰕧 Recorder ")

# Get date for file name
date=$(date +"%Y-%m-%d_%H-%M-%S")

# gpu-screen-recorder options
recording_options=(
    -w "screen"
    -f $FRAMERATE
    -fm $FRAMERATE_MODE
    -fm "cfr"
    -a "default_output|default_input"
    -k $VIDEO_CODEC
    -ac $AUDIO_CODEC
    -cursor $ENABLE_CURSOR
    -o "$SAVE_DIR/Video-${date}.mp4"
)

replay_options=(
    -w "screen"
    -f $FRAMERATE
    -fm $FRAMERATE_MODE
    -fm "cfr"
    -a "default_output|default_input"
    -c "mp4"
    -r $REPLAY_BUFFER_SEC
    -k $VIDEO_CODEC
    -ac $AUDIO_CODEC
    -cursor $ENABLE_CURSOR
    -o "$SAVE_DIR/Clip-${date}.mp4"
)

# Handle selected input
case "$choice" in
"${options[0]}")
    # START RECORDING
    gpu-screen-recorder "${recording_options[@]}"
    exit 0
    ;;
"${options[1]}")
    # STOP RECORDING
    pkill -SIGINT -f gpu-screen-recorder
    exit 0
    ;;
"${options[2]}")
    # PAUSE/RESUME RECORDING
    pkill -SIGUSR2 -f gpu-screen-recorder
    exit 0
    ;;
"${options[3]}")
    # START REPLAY
    gpu-screen-recorder "${replay_options[@]}"
    exit 0
    ;;
"${options[4]}")
    # STOP REPPLAY
    pkill -SIGINT -f gpu-screen-recorder
    exit 0
    ;;
"${options[5]}")
    # SAVE REPLAY
    pkill -SIGUSR1 -f gpu-screen-recorder
    exit 0
    ;;
*)
    echo -e "Error: Option not recognized '${choice}'"
    exit 1
    ;;
esac
