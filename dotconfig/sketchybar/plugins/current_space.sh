#!/usr/bin/env zsh
export PATH="/opt/homebrew/bin:$PATH"

update_space() {
    SPACES=$(yabai -m query --spaces --display | jq -r '.[].index')
    ICONS=""
    for IDX in $SPACES; do
        ICONS+="$IDX "
    done

    sketchybar --set $NAME icon="$ICONS"
}

case "$SENDER" in
"mouse.clicked")
    # Reload sketchybar
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
*)
    update_space
    ;;
esac
