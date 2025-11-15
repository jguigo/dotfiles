#!/bin/bash

THEME=$1
WAYBAR_DIR="$HOME/dotfiles/waybar"
CONFIG_DIR="$HOME/.config/waybar"

if [ -z "$THEME" ]; then
  echo "Usage: $0 <theme_name>"
  exit 1
fi

if [ ! -d "$WAYBAR_DIR/$THEME" ]; then
  echo "Theme '$THEME' not found in $WAYBAR_DIR"
  exit 1
fi

ln -sfn "$WAYBAR_DIR/$THEME" "$CONFIG_DIR"

echo "Theme '$THEME' applied successfully."
echo "Restarting Waybar..."

pkill waybar && waybar & disown
