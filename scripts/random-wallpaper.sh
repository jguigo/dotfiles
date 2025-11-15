#!/usr/bin/env bash
set -euo pipefail

WALL_DIR="$HOME/wallpapers"

mapfile -t files < <(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \))

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No wallpapers found in $WALL_DIR"
  exit 1
fi

random_wall="${files[RANDOM % ${#files[@]}]}"

swww img "$random_wall"

echo "Wallpaper applied: $random_wall"
