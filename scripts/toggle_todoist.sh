#!/bin/sh

if pgrep -f "firefoxpwa.*01HKN7B79GP8PQ9ERFFX4RZJ8P"; then
    hyprctl dispatch togglespecialworkspace todoist
else
    firefoxpwa site launch 01HKN7B79GP8PQ9ERFFX4RZJ8P
fi
