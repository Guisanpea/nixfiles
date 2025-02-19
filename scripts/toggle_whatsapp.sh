#!/bin/sh

if pgrep -f "firefoxpwa.*01JJXZ3MN0JWBAR270M42K1QYG"; then
    hyprctl dispatch togglespecialworkspace whatsapp
else
    firefoxpwa site launch 01JJXZ3MN0JWBAR270M42K1QYG
fi
