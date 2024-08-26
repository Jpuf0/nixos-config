#!/usr/bin/env bash
export wallpapers_path="$HOME/Pictures/backgrounds"
export SWWW_TRANSITION_FPS=120
export SWWW_TRANSITION_STEP=20
export SWWW_TRANSITION=wipe
export SWWW_TRANSITION_ANGLE=30
export INTERVAL=300

while true; do
  paper = find $wallpapers_path -type f | shuf -n 1
  hyprctl hyprpaper preload $paper
  hyprctl hyprpaper wallpaper $paper
  sleep $INTERVAL
  hyprctl hyprpaper unload unused
done