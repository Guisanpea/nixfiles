#!/usr/bin/env zsh
export PATH="/opt/homebrew/bin:$PATH"

update_space() {
    SPACES=$(yabai -m query --spaces --display | jq -c '.[]')
    ICONS=""
    for SPACE in ${(f)SPACES}; do
        IDX=$(echo $SPACE | jq -r '.index')
        FOCUSED=$(echo $SPACE | jq -r '.focused')
        if [[ $FOCUSED == "true" ]]; then
            ICONS+="%{F#24273a}$IDX%{F-} "
        else
            ICONS+="%{F#00000000}$IDX%{F-} "
        fi
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
