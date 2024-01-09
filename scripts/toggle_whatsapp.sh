#!/bin/bash

# Define the app_id for Whatsapp
APP_ID="FFPWA-01HKQ02CZ0FJ90985QX9J9YGEK"

# Get the window information using swaymsg and jq
WINDOW_INFO=$(swaymsg -t get_tree | jq '.. | select(.app_id? == "'$APP_ID'")')

# Check if the window exists
if [[ ! -z "$WINDOW_INFO" ]]; then
    # Check if the window is visible
    if [[ $(echo "$WINDOW_INFO" | jq '.visible') == "true" ]]; then
        # If visible, hide the window
        swaymsg "[app_id=\"$APP_ID\"] move scratchpad"
    else
        # If not visible, show the window
        swaymsg "[app_id=\"$APP_ID\"] scratchpad show"
    fi
else
   firefoxpwa site launch 01HKQ02CZ0FJ90985QX9J9YGEK
fi
