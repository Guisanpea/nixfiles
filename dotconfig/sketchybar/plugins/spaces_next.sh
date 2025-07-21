#!/usr/bin/env zsh
export PATH="/opt/homebrew/bin:$PATH"

DISPLAY_IDX=$(echo $NAME | grep -o '[0-9]*$')
if [[ -z "$DISPLAY_IDX" ]]; then
  DISPLAY_IDX=1
fi

SPACES_JSON=$(yabai -m query --spaces)
CURRENT=$(echo $SPACES_JSON | jq -r --argjson disp "$DISPLAY_IDX" '.[] | select(.display==$disp and ."has-focus"==true).index')
NEXT_SPACES=$(echo $SPACES_JSON | jq -r --argjson disp "$DISPLAY_IDX" --argjson cur "$CURRENT" '.[] | select(.display==$disp and .index > $cur).index')

ICONS=""
for IDX in $NEXT_SPACES; do
  ICONS+="$IDX "
done

sketchybar --set $NAME icon="$ICONS"