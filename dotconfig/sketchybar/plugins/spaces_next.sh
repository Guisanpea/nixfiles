#!/usr/bin/env zsh
export PATH="/opt/homebrew/bin:$PATH"

SPACES_JSON=$(yabai -m query --spaces --display)
CURRENT=$(echo $SPACES_JSON | jq -r '.[] | select(.["has-focus"]==true) | .index')
NEXT=$(echo $SPACES_JSON | jq -r --argjson cur "$CURRENT" '.[] | select(.index > $cur).index' | xargs)
echo $NEXT > /tmp/sketchybar_spaces_next.txt

LABEL_PADDING_LEFT=10
LABEL_PADDING_RIGHT=10

sketchybar --set $NAME \
  label="$NEXT" \
  label.drawing=yes \
  icon.drawing=no \
  label.padding_left=$LABEL_PADDING_LEFT \
  label.padding_right=$LABEL_PADDING_RIGHT