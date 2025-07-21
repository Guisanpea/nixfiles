#!/usr/bin/env zsh
export PATH="/opt/homebrew/bin:$PATH"

sketchybar --set $NAME label="$(date '+%a %b %-d %-H:%M')"
