#!/usr/bin/env zsh
export PATH="/opt/homebrew/bin:$PATH"

CURRENT=$(yabai -m query --spaces --display | jq -r '.[] | select(.["has-focus"]==true) | .index')
echo $CURRENT > /tmp/sketchybar_space_current.txt

ICON_PADDING_LEFT=10
ICON_PADDING_RIGHT=10

sketchybar --set $NAME \
  label="$CURRENT" \
  label.drawing=yes \
  icon.drawing=no \
  label.padding_left=$ICON_PADDING_LEFT \
  label.padding_right=$ICON_PADDING_RIGHT \
  label.color=0xff000000