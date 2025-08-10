#!/bin/bash
SCREEN_HEIGHT=$(xrandr | grep -oP '\d+x\d+\+\d+\+\d+' | head -1 | cut -d'x' -f2 | cut -d'+' -f1)
WAYBAR_HEIGHT=$((SCREEN_HEIGHT * 3 / 100))

sed -i "s/\"height\": [0-9]*/\"height\": $WAYBAR_HEIGHT/" ~/.config/waybar/config.jsonc
