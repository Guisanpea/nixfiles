#!/bin/sh

if pgrep -f "firefoxpwa.*01JP2D0C8C3TDNPRAVJY91HMEK"; then
    hyprctl dispatch togglespecialworkspace pomofocus
else
    firefoxpwa site launch 01JP2D0C8C3TDNPRAVJY91HMEK
fi