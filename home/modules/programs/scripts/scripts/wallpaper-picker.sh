#!/usr/bin/env bash

wallpaper_path=$HOME/Pictures/wallpapers
wallpapers_folder=$HOME/Pictures/wallpapers/others
wallpaper_name="$(ls $wallpapers_folder | wofi --show dmenu --sort-order=alphabetical)"
if [[ -f $wallpapers_folder/$wallpaper_name ]]; then
    find ~/Pictures/wallpapers -maxdepth 1 -type f -delete
    cp $wallpapers_folder/$wallpaper_name $wallpaper_path/.current_wallpaper
    wall-change $wallpaper_path/.current_wallpaper
    wal -i $wallpaper_path/.current_wallpaper -s -t -n
else
    exit 1
fi