#!/usr/bin/env bash

wallpaper_path=$HOME/Pictures/backgrounds
backgrounds_folder=$HOME/Pictures/backgrounds/others
wallpaper_name="$(ls $backgrounds_folder | wofi --show dmenu --sort-order=alphabetical)"
if [[ -f $backgrounds_folder/$wallpaper_name ]]; then
    find ~/Pictures/backgrounds -maxdepth 1 -type f -delete
    cp $backgrounds_folder/$wallpaper_name $wallpaper_path/.current_wallpaper
    wall-change $wallpaper_path/.current_wallpaper
    wal -i $wallpaper_path/.current_wallpaper -s -t -n
else
    exit 1
fi