#!/usr/bin/env bash

# Wait until hyprpaper is running
sleep 2
WALLPAPER_DIR="$HOME/Pictures/wallpaper/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded | grep -oP '(?<=,).+')

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ,"$WALLPAPER"