#!/bin/bash

# Define the app_id for Todoist
APP_ID="chat-gpt"

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
    chat-gpt
fi
