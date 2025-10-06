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
SAVE_DIR="/media/Shared/Drive/Replay captures/GSR"
REPLAY_BUFFER_SEC="60"
FRAMERATE="60"
# RECORDING_PREFIX="recording"
# REPLAY_PREFIX="replay"
AUDIO_OUTPUT="default_output"
AUDIO_INPUT="default_input"
WINDOW="portal"                                # 'screen', 'screen-direct', 'focused', 'portal' or 'region'
FRAMERATE_MODE="cfr"                            # 'cfr', or 'vfr'
VIDEO_CODEC="hevc"                              # 'auto', 'h264', 'hevc', 'av1', 'vp8', 'vp9', 'hevc_hdr', 'av1_hdr', 'hevc_10bit' or 'av1_10bit'
AUDIO_CODEC="opus"                              # 'aac', 'opus' or 'flac'
VIDEO_QUALITY="high"                            # 'medium', 'high', 'very_high' or 'ultra'
COLOR_RANGE="full"                              # 'limited', or 'full'
CONTAINER="mkv"                                 # 'mp4', 'mkv', 'flv', 'webm' and others that support h264, hevc, av1, vp8 or vp9
ENABLE_CURSOR="yes"                             # 'yes' or 'no'

START_REPLAY=" Start Replay"
SAVE_REPLAY=" Save Replay"
STOP_REPLAY=" Stop Replay"
START_RECORDING=" Start Recording"
STOP_RECORDING=" Stop Recording"
PAUSE_RECORDING=" Pause/Resume Recording"

process_list=$(pgrep -af gpu-screen-recorder)
pgrep_code=$?
running=0
replay_mode=0

if [[ pgrep_code == 0 ]]; then
    running=1
fi

if [[ running == 1 && "$process_list" == *"-r "* ]]; then


# Make sure the "Videos" folder exists
if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
fi

# Create Menu Items
options=(" Start Replay" " Save Replay" " Stop Replay" " Start Recording" " Stop Recording" " Pause/Resume Recording")

# Print Menu Items each with a newline
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p " 󰕧 Recorder ")

# Get date for file name
date=$(date +"%Y-%m-%d_%H-%M-%S")

# gpu-screen-recorder options
recording_options=(
    -w $WINDOW
    -f $FRAMERATE
    -fm $FRAMERATE_MODE
    -q $VIDEO_QUALITY
    -a "$AUDIO_OUTPUT|$AUDIO_INPUT"
    -k $VIDEO_CODEC
    -ac $AUDIO_CODEC
    -cursor $ENABLE_CURSOR
    -cr $COLOR_RANGE
    -c $CONTAINER
    -o "$SAVE_DIR/Recording_$date.$CONTAINER"
)

replay_options=(
    -w $WINDOW
    -f $FRAMERATE
    -fm $FRAMERATE_MODE
    -q $VIDEO_QUALITY
    -a "$AUDIO_OUTPUT|$AUDIO_INPUT"
    -k $VIDEO_CODEC
    -ac $AUDIO_CODEC
    -cursor $ENABLE_CURSOR
    -cr $COLOR_RANGE
    -c $CONTAINER
    -r $REPLAY_BUFFER_SEC
    -o "$SAVE_DIR"
)

# Handle selected input
case "$choice" in
"${options[0]}")
    # START REPLAY
    gpu-screen-recorder "${replay_options[@]}"
    exit 0
    ;;
"${options[1]}")
    # SAVE REPLAY
    pkill -SIGUSR1 -f gpu-screen-recorder
    exit 0
    ;;
"${options[2]}")
    # STOP REPPLAY
    pkill -SIGINT -f gpu-screen-recorder
    exit 0
    ;;
"${options[3]}")
    # START RECORDING
    gpu-screen-recorder "${recording_options[@]}"
    exit 0
    ;;
"${options[4]}")
    # STOP RECORDING
    pkill -SIGINT -f gpu-screen-recorder
    exit 0
    ;;
"${options[5]}")
    # PAUSE/RESUME RECORDING
    pkill -SIGUSR2 -f gpu-screen-recorder
    exit 0
    ;;
*)
    echo -e "Error: Option not recognized '${choice}'"
    exit 1
    ;;
esac
