#!/bin/sh

if pgrep -f "spotify"; then
    hyprctl dispatch togglespecialworkspace spotify
else
    spotify
fi
